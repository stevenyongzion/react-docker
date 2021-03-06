FROM node:14 as builder

# Specify the directory inside the image in which all commands will run 
WORKDIR /usr/src/app 

# Copy package files and install dependencies 
COPY package*.json ./ 
RUN npm install 

# Copy all of the app files into the image 
# Note that for development environment, and mapped with volumes
# the below is not really needed
COPY ./ ./ 

# The default command to run when starting the container 
RUN npm run build

# docker build -t simple-node .
# docker run --rm -p 3000:3000 simple-node

# start of different phase
FROM nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx/html