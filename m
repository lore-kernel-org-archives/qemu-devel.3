Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F089ECA0EDB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 20:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulvlM-0006Uw-Aj; Tue, 12 Aug 2025 16:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1ulvlG-0006UU-8A; Tue, 12 Aug 2025 16:38:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1ulvlD-0002bi-GA; Tue, 12 Aug 2025 16:38:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFeIhu029454;
 Tue, 12 Aug 2025 20:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=g6YCSX
 Z2YrFQbSvuyEZMu/cg2m01IFL1tANsmtlPwRY=; b=aPZACXKJmJC0hR1FbRH6Ky
 gycEeWG5zBa7DD6AZH/dc2+sbeEIcb9KDIcwjGM0G1siDZ/JmS+YDlai/H0Qlhji
 xHv4fOtFhFQcHhVlNRTv5+bi3CLce21rd9wWvPgvNR2pMCU9omtxUf9AShMnDy6i
 4fdS4ZVqbW4Is/nuPhGIubSR8LDSZRAYQEozEncX3LSBp3a3WpoQEB3tkKWufCwx
 gH+yzUfOuSPskSOZVvKCCFqPUVq4qCWPYcCSviejTp8lkO5mJcDuCq4ShF0ZWkMz
 hM3bHQUyHwgaWfL5hBg/nFSghMBNTUXC2Kg6pJIhBXbnLTySYC9r9ILVO1eVMNWw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14gseh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 20:38:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57CKWaeX010824;
 Tue, 12 Aug 2025 20:38:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14gse3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 20:38:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CI5L7r028582;
 Tue, 12 Aug 2025 20:38:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n45bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 20:38:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57CKc8Uu10946036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Aug 2025 20:38:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D05D58054;
 Tue, 12 Aug 2025 20:38:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60F6958050;
 Tue, 12 Aug 2025 20:38:07 +0000 (GMT)
Received: from [9.10.80.161] (unknown [9.10.80.161])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Aug 2025 20:38:07 +0000 (GMT)
Message-ID: <416ce7fd-1497-4b15-ae96-2e0df8f2cca4@linux.ibm.com>
Date: Tue, 12 Aug 2025 15:38:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/50] ppc queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, milesg@linux.ibm.com,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
 <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
 <6afc919bdb18166a71a2dba1a3862709629d5e08.camel@linux.ibm.com>
 <a9d36b56-2954-4a48-aec4-09657a2295b2@tls.msk.ru>
 <3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <3b1fcc0a-6ce7-4639-a17c-34d640745c20@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bVLVfJ7PC4WYbHqz6rD5whkCe9SYKy1M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE5NCBTYWx0ZWRfX/I7/twB6KXrG
 At+YfrbRa36pDzTs1Tdd1wYmL+wmmD96tjtbci9gSKefzG/RRPVlVjV9M/eYzsM4Sm+vntuhNyR
 mmr5A2Uq2lUY8oiKK7h4EccKXzjOLKfwkNs0hBaibiBy+JsMNOBN8lDPSXLQF9PSPA9cauPfYXl
 WkRJApFXLBPBE3BMw7JKIfEIfT2lMCarSpvnqx3ZP/boq9MaQ8Wv2B5nkNLZTCQxNlZGosk97Pl
 kG6D4a8AceOZMHvDl8SLAqcvnfaViVWw3l5IBGnWvlhg0E8uHph3SYc9UXoZWeOWyzrRrq3l1V3
 1DsmJ64kJ/F+PCYoxVC/1Nd7cBHRL8N6EREi6mzFVgT+V4bwcWb0Tn4bmJkrJI0jAjWN0coO9t1
 X5FEie+BoNTIivnjjyrno1ZQfP+GmmvhGPohN6A0uiDfMmrjAvpAF5jykgB1QOAMwOZKxjcQ
X-Proofpoint-GUID: P265jJ8IO-sgldvAmAi_TlDXi_hkgs5Q
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689ba633 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=rxsfQsfiIYbU5HwttAgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120194
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 8/8/2025 3:17 AM, Cédric Le Goater wrote:
> On 8/8/25 08:07, Michael Tokarev wrote:
>> On 06.08.2025 23:46, Miles Glenn wrote:
>>> On Tue, 2025-08-05 at 22:07 +0200, Cédric Le Goater wrote:
>> ...
>>>> These seem to be interesting to have :
>>>>
>>>> ppc/xive2: Fix treatment of PIPR in CPPR update
>>>> ppc/xive2: Fix irq preempted by lower priority group irq
>
> I added :
>
>   ppc/xive2: Reset Generation Flipped bit on END Cache Watch
>
>>>> ppc/xive: Fix PHYS NSR ring matching
>>>> ppc/xive2: fix context push calculation of IPB priority
>>>> ppc/xive2: Remote VSDs need to match on forwarding address
>>>> ppc/xive2: Fix calculation of END queue sizes
>>>> ppc/xive: Report access size in XIVE TM operation error logs
>>>> ppc/xive: Fix xive trace event output
>>>
>>> I'm still not sure that the benefit is worth the effort, but I
>>> certainly don't have a problem with them being backported if someone
>>> has the desire and the time to do it.
>>
>> I mentioned already that 10.0 series will (hopefully) be LTS series.
>> At the very least, it is what we'll have in the upcoming debian
>> stable release (trixie), which will be stable for the next 2 years.
>> Whenever this is important to have working Power* support in debian -
>> I don't know.
>>
>> All the mentioned patches applied to 10.0 branch cleanly (in the
>> reverse order, from bottom to top), so there's no effort needed
>> to back-port them.  And the result passes at least the standard
>> qemu testsuite.  So it looks like everything works as intended.
>
>
> 24.04 operates correctly with a "6.14.0-27-generic #27~24.04.1-Ubuntu"
> kernel on a PowerNV10 system defined as :
>
>   Architecture:             ppc64le
>     Byte Order:             Little Endian
>   CPU(s):                   16
>     On-line CPU(s) list:    0-15
>   Model name:               POWER10, altivec supported
>     Model:                  2.0 (pvr 0080 1200)
>     Thread(s) per core:     4
>     Core(s) per socket:     2
>     Socket(s):              2
>     Frequency boost:        enabled
>     CPU(s) scaling MHz:     76%
>     CPU max MHz:            3800.0000
>     CPU min MHz:            2000.0000
>   Caches (sum of all):
>     L1d:                    128 KiB (4 instances)
>     L1i:                    128 KiB (4 instances)
>   NUMA:
>     NUMA node(s):           2
>     NUMA node0 CPU(s):      0-7
>     NUMA node1 CPU(s):      8-15
>
> with devices :
>
>   0000:00:00.0 PCI bridge: IBM Device 0652
>   0000:01:00.0 Non-Volatile memory controller: Red Hat, Inc. QEMU NVM 
> Express Controller (rev 02)
>   0001:00:00.0 PCI bridge: IBM Device 0652
>   0001:01:00.0 PCI bridge: Red Hat, Inc. Device 000e
>   0001:02:02.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host 
> Controller (rev 03)
>   0001:02:03.0 Ethernet controller: Intel Corporation 82574L Gigabit 
> Network Connection
>   0002:00:00.0 PCI bridge: IBM Device 0652
>   ...
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
>     [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
>   [    2.270794918,5] XIVE: [ IC 00  ] Resetting one xive...
>   [    2.271575295,3] XIVE: [CPU 0000] Error enabling PHYS CAM already 
> enabled
>   CPU 0100 Backtrace:
>    S: 0000000032413a20 R: 0000000030021408   .backtrace+0x40
>    S: 0000000032413ad0 R: 000000003008427c .xive2_tima_enable_phys+0x40
>    S: 0000000032413b50 R: 0000000030087430 
> .__xive_reset.constprop.0.isra.0+0x520
>    S: 0000000032413c90 R: 0000000030087638   .opal_xive_reset+0x78
>    S: 0000000032413d10 R: 00000000300038bc   opal_entry+0x14c
>    --- OPAL call token: 0x80 caller R1: 0xc0000000014bbc90 ---
>   [    2.273581201,3] XIVE: [CPU 0001] Error enabling PHYS CAM already 
> enabled
>
>
> Is it a modeling issue ?

I do not think it a modeling issue  We do get any warning or error 
messages when booting Linux on Power VM. Note that " [PATCH 43/50] 
ppc/xive: Check TIMA operations validity" added some warning logs.  The 
problem is that the Context is 'hardware owned' since it is already 
pushed/enabled.

MAK

>
>
> Thanks,
>
> C.
>
>
>
>

