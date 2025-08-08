Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF02BC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQ5k-0002zp-JQ; Fri, 08 Aug 2025 12:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ukQ5h-0002qo-Ne; Fri, 08 Aug 2025 12:37:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ukQ5e-00051b-3o; Fri, 08 Aug 2025 12:37:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578AXl25020980;
 Fri, 8 Aug 2025 16:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=/8t/wG+mprjz3n7p3qHcLjKea/O5z8/S9wMWq4RcYIw=; b=rQDo1PsVlJm7
 I+HGBFLJXlDvme+KWXY0dN+vB48owWlIiEjfQwOuqqzHzDhtzevQknTYKaWEfmQi
 oh6qJuui7rI6bfTolycG05QPpPOix6N4QMZWQ/Ir3Mqu5mK5UJZmQW7KO3FVpKhv
 JZU7m1CWFya17uw3OdYr2ZvY59YVhNyk3CWBb4myo0jEiDntDvlvYrTwyIelJwos
 iZ+qXh7nPYfkPpfXkllcr+1RD+7PavES5AXWLvMSk7FjJJaZ8Q+v2UBLDn2VuGGC
 lWleS7vqsj44DvyfmSqMwsE6FDMsSur/rX7sIoia8sogIhrbNTcK2uiHJgmD73GU
 XMdSyF4YHw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63h4ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:37:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578Gakdt012659;
 Fri, 8 Aug 2025 16:37:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63h4rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:37:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578F57ve031307;
 Fri, 8 Aug 2025 16:37:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnpd9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:37:06 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578Gb5Z814418676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 16:37:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68E0058043;
 Fri,  8 Aug 2025 16:37:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED76258055;
 Fri,  8 Aug 2025 16:37:04 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 16:37:04 +0000 (GMT)
Message-ID: <a423cbb98f851fe29901485f4bf6485857f24386.camel@linux.ibm.com>
Subject: Re: [PULL 00/50] ppc queue
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Michael Tokarev
 <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
Date: Fri, 08 Aug 2025 11:37:04 -0500
In-Reply-To: <3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
 <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
 <6afc919bdb18166a71a2dba1a3862709629d5e08.camel@linux.ibm.com>
 <a9d36b56-2954-4a48-aec4-09657a2295b2@tls.msk.ru>
 <3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=689627b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ymyJ6kAnLaKtO-8wbJQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gVb8hNRnbG0gaTvTgjwoWYoJqIaQQsSo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEzMyBTYWx0ZWRfX2T9k4bT5iySL
 FsW/jXzustPotWSv1fDhRrjTf0+Gg1S5meLiHCQ8Tzq+ceFh3TrgTMDPQdyWScYTcBAKJdpbBYD
 SMmnC+GM5R2AiS4CV/vJBQc/LAFUsZWHXeNSArlmxl+p2jadjx0N/NVytLYk6h41hifYwYl8cYQ
 EC2R/kCpDlXs8DKmCekKDugzJkE/Q1mpOg8jWDZF4c6L1eNB5EjBi03MBEz+igLk2FiNW9oAGGi
 5zDCS2iqNOWjiZ2u+q4HaFSnCUj89rxKLrVmHWLOBKg/AvymBjCf5t2MAphwAaFEWvsgT+RXNza
 s6g/YNkdbZwyYyTZzUSmVNpoL6DqFq2LEUFKfgGNnqSniiSQyBYm8lALK9mZunh8VTSmz7TfI99
 Oz8MJ1zaqwdpGia+EmPkosfY3fsUdM6ki+h0/P5vQUjjNUNGjZUlEv2tb1lBAH+n7IGcOrZa
X-Proofpoint-ORIG-GUID: bwTavnlfvlR6PtHi8HBxW9yE3OZpxgdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080133
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2025-08-08 at 10:17 +0200, Cédric Le Goater wrote:
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
>    ppc/xive2: Reset Generation Flipped bit on END Cache Watch
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
> > to back-port them.  And the result passes at least the standard
> > qemu testsuite.  So it looks like everything works as intended.
> 
> 24.04 operates correctly with a "6.14.0-27-generic #27~24.04.1-Ubuntu"
> kernel on a PowerNV10 system defined as :
> 
>    Architecture:             ppc64le
>      Byte Order:             Little Endian
>    CPU(s):                   16
>      On-line CPU(s) list:    0-15
>    Model name:               POWER10, altivec supported
>      Model:                  2.0 (pvr 0080 1200)
>      Thread(s) per core:     4
>      Core(s) per socket:     2
>      Socket(s):              2
>      Frequency boost:        enabled
>      CPU(s) scaling MHz:     76%
>      CPU max MHz:            3800.0000
>      CPU min MHz:            2000.0000
>    Caches (sum of all):
>      L1d:                    128 KiB (4 instances)
>      L1i:                    128 KiB (4 instances)
>    NUMA:
>      NUMA node(s):           2
>      NUMA node0 CPU(s):      0-7
>      NUMA node1 CPU(s):      8-15
> 
> with devices :
> 
>    0000:00:00.0 PCI bridge: IBM Device 0652
>    0000:01:00.0 Non-Volatile memory controller: Red Hat, Inc. QEMU NVM Express Controller (rev 02)
>    0001:00:00.0 PCI bridge: IBM Device 0652
>    0001:01:00.0 PCI bridge: Red Hat, Inc. Device 000e
>    0001:02:02.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)
>    0001:02:03.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
>    0002:00:00.0 PCI bridge: IBM Device 0652
>    ...
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
>    
>    [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
>    [    2.270794918,5] XIVE: [ IC 00  ] Resetting one xive...
>    [    2.271575295,3] XIVE: [CPU 0000] Error enabling PHYS CAM already enabled
>    CPU 0100 Backtrace:
>     S: 0000000032413a20 R: 0000000030021408   .backtrace+0x40
>     S: 0000000032413ad0 R: 000000003008427c   .xive2_tima_enable_phys+0x40
>     S: 0000000032413b50 R: 0000000030087430   .__xive_reset.constprop.0.isra.0+0x520
>     S: 0000000032413c90 R: 0000000030087638   .opal_xive_reset+0x78
>     S: 0000000032413d10 R: 00000000300038bc   opal_entry+0x14c
>     --- OPAL call token: 0x80 caller R1: 0xc0000000014bbc90 ---
>    [    2.273581201,3] XIVE: [CPU 0001] Error enabling PHYS CAM already enabled
> 
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

Thank you, Cédric!

I'm not sure what's causing that error message.  I'm assuming it wasn't
there before now, which would probably mean that something (the model?)
is enabling the PHYS cams at initialization or realization where we
didn't used to.

Mike Kowal, is that the expecected behavior?  Can you take a look when
you have a chance?

Thanks,

Glenn


