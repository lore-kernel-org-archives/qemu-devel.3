Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F36CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4UC-0000JA-IP; Tue, 21 Oct 2025 01:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB4U9-0000Ig-U4; Tue, 21 Oct 2025 01:00:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB4U7-0003Jd-Lk; Tue, 21 Oct 2025 01:00:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJbFu3027999;
 Tue, 21 Oct 2025 05:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hkLjLX
 uhWlcLuAWFnSTolEP7tzkfOaRh7Ur6irOuPdA=; b=LBl/UWpZs259kprXf4xYcl
 9LRrALAZeKg7iXJZGAEhAXGQBV/7LJoik0wYJtc+dAjvnCbHcJMYty8SW5gZwNlA
 fcI2GKmTJA3Z6tbLe41fy2DvX52TGpk7gjtbuQWKlZVolou8r/4Yvkb0KMIAdfSK
 Fhak3vbECa4coSA3wEgBYORPdIlz8v6BuOoeXZiCj2c7fE3crtWDHjX8w5K/IvF7
 XecS9v0WKYx6zlj92DdB251UlFy7Rs04Xl367BbVw7Mqq/u1bAYv0JN+aej+vQYG
 SnqJuDQukA6AQGvFP//dHkP6Rf2HeF9VZ5ekdIPhmk2K1N0JQfdxZeWPdpMtpb2Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326n3uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 05:00:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L4xNDa001294;
 Tue, 21 Oct 2025 05:00:31 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326n3un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 05:00:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L4HfpH002381;
 Tue, 21 Oct 2025 05:00:30 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej8w61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 05:00:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59L50Sqc6423746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 05:00:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA83358067;
 Tue, 21 Oct 2025 05:00:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 067AF58068;
 Tue, 21 Oct 2025 05:00:26 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 05:00:25 +0000 (GMT)
Message-ID: <22f3b73d-c068-4df6-9eaa-4012068ab289@linux.ibm.com>
Date: Tue, 21 Oct 2025 10:30:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Implement Firmware Assisted Dump for PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 shivangu@linux.ibm.com
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250323174007.221116-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f7136f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=dYOz5sho_cLMNvMCarkA:9
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/EFN7nsniS0T
 nBg2VnbJdP+G2yVsAkj7mh20Vh2Y09nEy4E0daEIZok3Rig4P3nGkRsJOIqMsm7dZWEJuumfeoA
 AO/GTwEDufDKJ329St78Egf5hX2PbWynxtZFxQ6QoY/9DA4HtTb8BzJKzkOyoBDdiuoxvCl+wDX
 esjZNC3ZBy2K8aNcl9nc4tk9fLSzUiUd+wBBNQmGgI1FPqyOkLvxkqGHqjIcJJEBiIraOteRqE9
 QclxYvmoQwHzUoHx5DZGKVn9RE6eB7qW5+QYwcl1uNiUDLih5eTqtDk4vZcUeCNt5qYa3KMQo3S
 Rz/95o9QPd5f5OBkRVjXGbxdeBLLzibIdrKrQ90OTzz0GCgJRgNjGer5oVd9ISkg2R8FzrAw5R0
 R0G+Ki1CYG8R1GlpunQ62qzpngyFsQ==
X-Proofpoint-GUID: uE-zast49RiMlLYOQNN5nL1alpQoL2j3
X-Proofpoint-ORIG-GUID: ojXCs3OK3EzNzFnKz9OkYN7fPmTwiKe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

+ Shivang - FYI

Hi Aditya,
Could you please keep Shivang in Cc when you post v5 ? TIA.

regards,
Harsh

On 3/23/25 23:09, Aditya Gupta wrote:
> Overview
> =========
> 
> Implemented Firmware Assisted Dump (fadump) on PSeries machine in QEMU.
> 
> Fadump is an alternative dump mechanism to kdump, in which we the firmware
> does a memory preserving boot, and the second/crashkernel is booted fresh
> like a normal system reset, instead of the crashed kernel loading the
> second/crashkernel in case of kdump.
> 
> This requires implementing the "ibm,configure-kernel-dump" RTAS call in
> QEMU.
> 
> While booting with fadump=on, Linux will register fadump memory regions.
> 
> Some memory regions like Real Mode Memory regions, and custom memory
> regions declared by OS basically require copying the requested memory
> range to a destination
> 
> While other memory regions are populated by the firmware/platform (QEMU in
> this case), such as CPU State Data and HPTE.
> We pass the sizes for these data segment to the kernel as it needs to know
> how much memory to reserve (ibm,configure-kernel-dump-sizes).
> 
> Then after a crash, once Linux does a OS terminate call, we trigger fadump
> if fadump was registered.
> 
> Implementing the fadump boot as:
>      * pause all vcpus (will save registers later)
>      * preserve memory regions specified by fadump
>      * do a memory preserving reboot (using GUEST_RESET as it doesn't clear
>        the memory)
> 
> And then we pass a metadata (firmware memory structure) as
> "ibm,kernel-dump" in the device tree, containing all details of the
> preserved memory regions to the kernel.
> 
> Refer the Patch #7/8: "hw/ppc: Enable fadump for PSeries" for logs of a
> succesfful fadump crash
> 
> Note: HPTE region has not been implemented. It's not planned as of now.
> 
> Testing
> =======
> 
> Has been tested with following QEMU options:
> 
> * firmware: x-vof and SLOF
> * tcg & kvm
> * l1 guest and l2 guest
> * with/without smp
> * cma/nocma
> * default crashkernel values (can fail with big initrd) and crashkernel=1G
> 
> Git Tree for Testing
> ====================
> 
> https://github.com/adi-g15-ibm/qemu/tree/fadump-pseries-v4
> 
> Note: You will need a way to get the /proc/vmcore out of the VM for testing
> with crash-utility
> 
> I use the following command line which sets up networking:
>      "-net user,hostfwd=tcp::10022-:22 -net nic"
> 
> And a rootfs with ssh support, then copy the /proc/vmcore with networking
> (can do compression using gzip before ssh, but compression might take lot
> of time if done inside the VM)
> 
> Test vmcore for Testing with crash-utility
> ==========================================
> 
> Can use vmlinux and vmcore available at https://github.com/adi-g15-ibm/qemu/releases/tag/test-images-fadump-pseries-v2
> Above vmcore was generated with upstream qemu with these fadump patches
> applied, and in a KVM VM
> A limitation with above vmcore is it was a single CPU VM
> 
> Changelog
> =========
> v4
>    + [patch #8/8]: fixed kvm testcase, add license
> 
> v3:
>    + [patch #3,7]: fix compile errors (#define declared in a later patch
>                    but used in this patch, unused var)
>    + [patch #4/8]: use 'g_autofree' for cpu buffer, and replace g_malloc with
>                    g_try_malloc
>    + [patch #5/8]: use 'g_new' instead of 'malloc', add null check for cpu
>                    region
>    - nothing in other patches has been changed compared to v2
> 
> v2:
>    + rearrange code so that no unused functions get introduced in any patch
>    + add functional test for pseries as suggested by nick
>    + fix multiple issues pointed by harsh and nick
>    + fix bug in cpu register saving where it was being stored in
>      little-endian
>    - removed 'is_next_boot_fadump' and used fadump header's status flag to
>      store it
>    + fixed multiple style issues (naming, unneeded diffs etc)
> 
> Aditya Gupta (8):
>    hw/ppc: Implement skeleton code for fadump in PSeries
>    hw/ppc: Implement fadump register command
>    hw/ppc: Trigger Fadump boot if fadump is registered
>    hw/ppc: Preserve memory regions registered for fadump
>    hw/ppc: Implement saving CPU state in Fadump
>    hw/ppc: Pass dump-sizes property for fadump in device tree
>    hw/ppc: Enable fadump for PSeries
>    tests/functional: Add test for fadump in PSeries
> 
>   hw/ppc/meson.build                        |   1 +
>   hw/ppc/spapr.c                            |  72 +++
>   hw/ppc/spapr_fadump.c                     | 685 ++++++++++++++++++++++
>   hw/ppc/spapr_rtas.c                       |  71 +++
>   include/hw/ppc/spapr.h                    |  11 +-
>   include/hw/ppc/spapr_fadump.h             | 121 ++++
>   tests/functional/meson.build              |   2 +
>   tests/functional/qemu_test/linuxkernel.py |  59 ++
>   tests/functional/test_ppc64_fadump.py     | 182 ++++++
>   9 files changed, 1203 insertions(+), 1 deletion(-)
>   create mode 100644 hw/ppc/spapr_fadump.c
>   create mode 100644 include/hw/ppc/spapr_fadump.h
>   create mode 100755 tests/functional/test_ppc64_fadump.py
> 

