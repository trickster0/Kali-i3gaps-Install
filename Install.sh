#!/bin/bash
# Author: Michael Rocha (@Essex09_)

#Prevent shutter from being removed
#echo "shutter hold" | sudo dpkg --set-selections

# Update
echo -e "###################"
echo -e "#  Updating Kali  #" 
echo -e "###################"

apt-get update -y

# Install i3 and it's dependencies
sleep .5;
echo -e "\n"
echo -e "###################"
echo -e "#  Installing i3  #"
echo -e "###################"

apt-get install -y git build-essential autoconf pkg-config i3blocks
apt-get install i3 -y

# i3-gaps Installation
sleep .5;
echo -e "\n"
echo -e "########################"
echo -e "#  Installing i3-gaps  #"
echo -e "########################"

mkdir -p /opt/i3install/gui && cd /opt/i3install/gui
git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps

## Source: https://github.com/Airblader/i3/wiki/Compiling-&-Installing
# Compile & Install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# i3-gaps Dependencies
sleep .5;
echo -e "\n"
echo -e "#####################################"
echo -e "#  Installing i3-gaps dependencies  #"
echo -e "#####################################"

apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j8
make install

##### Kali Ricing
# lxappearance changes themes and icons
# nitrogen used to change wallpaper
sleep .5;
echo -e "\n"
echo -e "#################"
echo -e "#  Ricing Kali  #"
echo -e "#################"

apt-get install -y lxappearance nitrogen arc-theme moka-icon-theme rofi compton xfce4-terminal neofetch zathura i3status

echo -e "\n"
echo -e "##########################"
echo -e "#  Adding Overpass font  #"
echo -e "##########################"

git clone https://github.com/RedHatBrand/Overpass.git
cp Overpass/desktop-fonts/overpass-mono/overpass-mono-regular.otf /usr/share/fonts/
fc-cache -fv

#echo -e "\n"
#echo -e "##########################"
#echo -e "#  Installing OpenJDK    #"
#echo -e "##########################"
# Fixes CS issue
#apt-get -y install openjdk-11-jdk
#update-java-alternatives -s java-1.11.0-openjdk-amd64

#sleep .5;
#echo -e "."
#echo -e "."
#echo -e "."
#echo -e "Installing ddtools"
#echo -e "."
#echo -e "."
#echo -e "."
# ddnotes - Dependencies
#apt-get install -y xdotool dmenu

#cd /usr/
#git clone https://github.com/wmutils/core.git && cd core/
#make && make install

## ddnotes Installation
#cd /root/Kali-i3gaps-Install/gui
#git clone https://github.com/umurgdk/ddnotes.git && cp ddnotes/ddnotes /usr/bin/

echo -e "\n"
echo -e "#####################################"
echo -e "#  Installing Essex09's Configs     #"
echo -e "#####################################"
cd /opt/
git clone https://github.com/Essex09/dotfiles.git
cd dotfiles/
cp .bashrc .profile /root/
cd .config/ && cp -r compton/ i3/ neofetch/ rofi/ xfce4/ /root/.config/
cd ../.local/share && cp -r xfce4 /root/.local/share/
wget https://raw.githubusercontent.com/trickster0/Kali-i3gaps-Install/master/config -O ~/.config/i3/config
wget https://raw.githubusercontent.com/trickster0/Kali-i3gaps-Install/master/i3blocks.conf -O ~/.config/i3/i3blocks.conf
echo i3 > ~/.xsession
echo user-session=i3 >> /etc/lightdm/lightdm.conf
## Finish
sleep .5;
echo -e "\n"
echo -e "############################################################"
echo -e "#  Finished. Please restart to login to i3.               #"
echo -e "#  Download your own i3 config file to /root/.config/i3/  #"
echo -e "############################################################"
