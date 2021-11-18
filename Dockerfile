FROM node:16.13-alpine

# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# install project dependencies
RUN yarn config set registry https://registry.npm.taobao.org/ && yarn install

# copy project files and folders to the current working directory (i.e. 'app' folder)
# It may seem reduntant to first copy package.json and package-lock.json and then all project files
# and folders in two separate steps but there is actually a very good reason for that
# (spoiler: it allows us to take advantage of cached Docker layers).
COPY . .

EXPOSE 3000
CMD [ "yarn", "dev" ]