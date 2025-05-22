Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15848C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 22:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIEOY-0002UH-J8; Thu, 22 May 2025 18:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <henson@acm.org>) id 1uIEOV-0002Td-Qp
 for qemu-devel@nongnu.org; Thu, 22 May 2025 18:28:08 -0400
Received: from 004.mia.mailroute.net ([199.89.3.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <henson@acm.org>) id 1uIEOQ-0005B5-Gg
 for qemu-devel@nongnu.org; Thu, 22 May 2025 18:28:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by 004.mia.mailroute.net (Postfix) with ESMTP id 4b3NGF0qBbzm1Hbc
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 22:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:subject
 :subject:from:from:content-language:user-agent:mime-version:date
 :date:message-id:received:received; s=mr01; t=1747952868; x=
 1750544869; bh=z+6lNas0E2ByKjVQ2TrXgQJpE/UPa2yF6X88D5hZo4Y=; b=L
 qXsHCWSjQG1j/QbLkqV4hupCABVgIBwjTkFkHG9Oq7Mhd4jrDULBqVIMGKmyWh2Q
 Lc2Fs0CAlVR2uipazc2aSKWMLBvysTJF3FbcZanKCNw9xoJl1Z/8NOkhgg18/kkq
 yF3WjM702NJRT2t5Qbjs9jl20Iby65EyQk65E9czuGHtg5hBdvEDU5X5sDv+HPsB
 VPdk7TKAbIZbs/5+Lm2M0gxNyj6XS21g9M78j/Y+lDYfZJKWRgt+DwFZkPDGuo2W
 QPKjlIYgHfMx488y5wuJcCMX1FzRU/yuPZUK78yUvkUPc7M2Uv0f0GqVF2M8Vp8G
 8pFoPx7lf/pL1xDzsPk2w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zd2a8Vsr4sTK for <qemu-devel@nongnu.org>;
 Thu, 22 May 2025 22:27:48 +0000 (UTC)
Received: from [10.128.60.154] (vip.pbhware.com [47.181.41.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: henson@acm.org)
 by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b3NGD1cNszm1Hbd
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 22:27:47 +0000 (UTC)
Message-ID: <b27e86f8-a93f-4b77-a2d6-3a47e23dfb12@acm.org>
Date: Thu, 22 May 2025 15:27:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: "Paul B. Henson" <henson@acm.org>
Subject: sr-iov live migration with NET_FAILOVER
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=199.89.3.7; envelope-from=henson@acm.org;
 helo=004.mia.mailroute.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I'm running libvirtd under Debian 12 and trying to set up live migration 
of a linux vm that's using an sr-iov VF as its primary ethernet device. 
I have that device and the corresponding virtio backup device properly 
configured in libvirt, and when the vm starts up everything looks good:

2: nic0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state 
UP mode DEFAULT group default qlen 1000
     link/ether 52:54:00:a1:e0:38 brd ff:ff:ff:ff:ff:ff
3: enp8s0nsby: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc 
fq_codel master nic0 state DOWN mode DEFAULT group default qlen 1000
     link/ether 52:54:00:a1:e0:38 brd ff:ff:ff:ff:ff:ff
5: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master 
nic0 state UP mode DEFAULT group default qlen 1000
     link/ether 52:54:00:a1:e0:38 brd ff:ff:ff:ff:ff:ff

The problem I am having is that when I do a live migration of the box, 
link on the standby virtio interface does not come up when the VF is 
unplugged, so all network traffic to the system is dropped during the 
interval between the source pulling the VF and the destination plugging 
it back in.

It's not clear to me who is responsible for doing that? But from what I 
can tell, it seems like it should be qmeu?

Per the documentation:

https://www.kernel.org/doc/html/latest/networking/net_failover.html

The sequence of events should be:

* bring up link on standby device
* detach sr-iov device
* migrate vm
* attach sr-iov device
* bring down link on standby device

If I do that manually, using virsh to light up the standby device and 
detach the VF before migration and then manually reattach the device and 
bring down standby link, no traffic is lost at all during the migration 
process.

I initially thought perhaps libvirt was supposed to be doing it, but 
reviewing the debug logs and the QMP commands, it is neither detaching 
nor reattaching the VF. It's just telling qmeu there's a failover pair, 
and qemu is doing the detach/attach while migrating:

-device 
{"driver":"virtio-net-pci","failover":true,"netdev":"hostua-sr-iov-backup","id":"ua-sr-iov-backup","mac":"52:54:00:a1:e0:38","bus":"pci.7","addr":"0x0"}

-device 
{"driver":"vfio-pci","host":"0000:37:10.0","id":"hostdev0","failover_pair_id":"ua-sr-iov-backup","bus":"pci.1","addr":"0x0"}


I tried manually bringing up link on the standby device before migrating 
the system and letting qemu deal with the vf detach/attach, but that 
resulted in even more lost traffic than simply letting the standby 
device be down during the migration (the network started sending packets 
to the standby device but the failover device didn't forward them on to 
the virtual nic as long as the VF existed).

Am I missing something? Is there some other configuration I'm supposed 
to do? Any insight on this issue would be most appreciated.

Debian 12 has qemu 7.2 as stable, but I also tried the backport of 9.2 
with the same apparent behavior.

Thanks much...


