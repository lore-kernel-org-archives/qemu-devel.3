Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F362CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLtK-0006Ov-LV; Tue, 19 Aug 2025 08:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uoLtI-0006OY-8S; Tue, 19 Aug 2025 08:56:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uoLtG-0004S0-3T; Tue, 19 Aug 2025 08:56:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J31Zix031324;
 Tue, 19 Aug 2025 12:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uhsUIJ
 jFTMS0cRrLdd47HK7mhwjY5hziyHTUmqohQ7I=; b=DnlTvC58jMcltsDYMHNB68
 UD7TOWgQK47sikwKJpfaYFdBOWn4jMIOSNPCsMIgV7uoJGtLg7R0ljvB6LlPhwdH
 zorMxeqw0kxa4GxwGm86pm/4LKFjc+EF/ejYy9s7W2h3RcUP6ScSNw4wBKZSUOtU
 5XwD0dv/B8Gvfm9GD8ctE2OAE6kKUpNUiWYQgC8hDNfCLZzY0jw9MeeHmIwfRFz0
 JYPNLUesJ3HkZX/VT7kC00KVBWLpUbjCKmgkOogKTB3pLpafts6x1+u6/rHlOQL8
 cObAbpm46eO6jKp+DopiM3xHLpt4lDVFtLwgNVL1iX34QfmOxo5NLfx29LkmSScA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g3svs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 12:56:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57JCuCdd023820;
 Tue, 19 Aug 2025 12:56:34 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g3svn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 12:56:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JAUEtA003190;
 Tue, 19 Aug 2025 12:56:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hma396-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 12:56:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57JCuT6t52953538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 12:56:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69C0320043;
 Tue, 19 Aug 2025 12:56:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B17720040;
 Tue, 19 Aug 2025 12:56:27 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.204.207.58])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 19 Aug 2025 12:56:27 +0000 (GMT)
Date: Tue, 19 Aug 2025 18:26:22 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, milesg@linux.ibm.com,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 00/50] ppc queue
Message-ID: <aKR0dr5MZ4Ms94Xn@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
 <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
 <6afc919bdb18166a71a2dba1a3862709629d5e08.camel@linux.ibm.com>
 <a9d36b56-2954-4a48-aec4-09657a2295b2@tls.msk.ru>
 <3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5t8nXIIwNIoj7mSNSZIUFQ8XEGYoa3vs
X-Authority-Analysis: v=2.4 cv=coObk04i c=1 sm=1 tr=0 ts=68a47482 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=ymyJ6kAnLaKtO-8wbJQA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: GORCGvrnKKZxPYbcMqKDE4_APJ-Gs5_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDAxNiBTYWx0ZWRfX2ayoXfecfUhv
 uY5ddxhYcAgk3Ky2bn4IgTxqny7gd7OFw1RUbnybTRKg8DHF+B7rBUYLd6/OhS/8V84+d+Pcvw/
 TEfLYfhzIl25kQCxTb0a4qhWh3BMpdELCkIA461njE6KADICI1v6ujGrKK+C9KA+Epnx2t5tpBx
 wAa65pE9veU8PyC2i/mr456+aLhqSqsswQamYiBCLMlFtqf9GTrunuCrk6/iqszInLuS+BzLHg4
 Ez3izjM2SJnBNR+tZ9ke+mVl2u1UfJ0ea+tsxxcGbOE+m65++oANOhUNxbN7ER088NJ8wc/UxQs
 yQUvYI6387qbEzmpwVqf3uKBwLwuXCxXaDvhhleIWERuHIuG67bBTlPwhIPEJ9RZFzrg5OH2q72
 60vgz6ET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 10:17:24AM +0200, Cédric Le Goater wrote:
> On 8/8/25 08:07, Michael Tokarev wrote:
> > On 06.08.2025 23:46, Miles Glenn wrote:
> > > On Tue, 2025-08-05 at 22:07 +0200, Cédric Le Goater wrote:
> > ...
> > > > These seem to be interesting to have :
> > > > 
> > > > ppc/xive2: Fix treatment of PIPR in CPPR update
> > > > ppc/xive2: Fix irq preempted by lower priority group irq
> 
> I added :
> 
>   ppc/xive2: Reset Generation Flipped bit on END Cache Watch
> 
> > > > ppc/xive: Fix PHYS NSR ring matching
> > > > ppc/xive2: fix context push calculation of IPB priority
> > > > ppc/xive2: Remote VSDs need to match on forwarding address
> > > > ppc/xive2: Fix calculation of END queue sizes
> > > > ppc/xive: Report access size in XIVE TM operation error logs
> > > > ppc/xive: Fix xive trace event output
> > > 
> > > I'm still not sure that the benefit is worth the effort, but I
> > > certainly don't have a problem with them being backported if someone
> > > has the desire and the time to do it.
> > 
> > I mentioned already that 10.0 series will (hopefully) be LTS series.
> > At the very least, it is what we'll have in the upcoming debian
> > stable release (trixie), which will be stable for the next 2 years.
> > Whenever this is important to have working Power* support in debian -
> > I don't know.
> > 
> > All the mentioned patches applied to 10.0 branch cleanly (in the
> > reverse order, from bottom to top), so there's no effort needed
> > to back-port them.  And the result passes at least the standard
> > qemu testsuite.  So it looks like everything works as intended.
> 
> 
> 24.04 operates correctly with a "6.14.0-27-generic #27~24.04.1-Ubuntu"
> kernel on a PowerNV10 system defined as :
> 
>   Architecture:             ppc64le
>     Byte Order:             Little Endian
>   CPU(s):                   16
>     On-line CPU(s) list:    0-15
>   Model name:               POWER10, altivec supported
>     Model:                  2.0 (pvr 0080 1200)
>     Thread(s) per core:     4
>     Core(s) per socket:     2
>     Socket(s):              2
>     Frequency boost:        enabled
>     CPU(s) scaling MHz:     76%
>     CPU max MHz:            3800.0000
>     CPU min MHz:            2000.0000
>   Caches (sum of all):
>     L1d:                    128 KiB (4 instances)
>     L1i:                    128 KiB (4 instances)
>   NUMA:
>     NUMA node(s):           2
>     NUMA node0 CPU(s):      0-7
>     NUMA node1 CPU(s):      8-15
> 
> with devices :
> 
>   0000:00:00.0 PCI bridge: IBM Device 0652
>   0000:01:00.0 Non-Volatile memory controller: Red Hat, Inc. QEMU NVM Express Controller (rev 02)
>   0001:00:00.0 PCI bridge: IBM Device 0652
>   0001:01:00.0 PCI bridge: Red Hat, Inc. Device 000e
>   0001:02:02.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)
>   0001:02:03.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
>   0002:00:00.0 PCI bridge: IBM Device 0652
>   ...
> 
> A rhel9 nested guest boots too.
> 
> Poweroff and reboot are fine.
> 
> 
> 
> Michael,
> 
> I would say ship it.
> 
> 
> Glenn, Gautam,
> 
> It would nice to get rid of these messages.
>   [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
>   [    2.270794918,5] XIVE: [ IC 00  ] Resetting one xive...
>   [    2.271575295,3] XIVE: [CPU 0000] Error enabling PHYS CAM already enabled
>   CPU 0100 Backtrace:
>    S: 0000000032413a20 R: 0000000030021408   .backtrace+0x40
>    S: 0000000032413ad0 R: 000000003008427c   .xive2_tima_enable_phys+0x40
>    S: 0000000032413b50 R: 0000000030087430   .__xive_reset.constprop.0.isra.0+0x520
>    S: 0000000032413c90 R: 0000000030087638   .opal_xive_reset+0x78
>    S: 0000000032413d10 R: 00000000300038bc   opal_entry+0x14c
>    --- OPAL call token: 0x80 caller R1: 0xc0000000014bbc90 ---
>   [    2.273581201,3] XIVE: [CPU 0001] Error enabling PHYS CAM already enabled
> 

Hi Cedric,

I'm not able to repro this with the latest QEMU master (commit
5836af078321).

My command line is:

$ cat run.sh
#!/bin/bash

./build/qemu-system-ppc64 \
	-smp 16,sockets=2,cores=2,threads=4 \
	-kernel vmlinux \
	-initrd initrd.img \
	-append 'root=LABEL=cloudimg-rootfs ro console=hvc0 earlyprintk' \
	-drive file=/home/gautam/images/noble-server-cloudimg-ppc64el.img,format=qcow2,if=none,id=drive0,format=qcow2,cache=none -device nvme,bus=pcie.0,addr=0x0,drive=drive0,serial=1234 \
	-M powernv10  -netdev user,id=net0,hostfwd=tcp::2223-:22 -device e1000e,netdev=net0,bus=pcie.1 -nographic


Can you please share your command line with which you got the above
warnings?

Thanks,
Gautam

> 
> Is it a modeling issue ?
> 
> 
> Thanks,
> 
> C.
> 
> 
> 
> 

