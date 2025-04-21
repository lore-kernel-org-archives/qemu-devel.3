Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8CBC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 06:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6kcr-0004EV-EU; Mon, 21 Apr 2025 02:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u6kcp-0004Cm-7P; Mon, 21 Apr 2025 02:27:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u6kcm-0006Hi-Um; Mon, 21 Apr 2025 02:27:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KLga0a020353;
 Mon, 21 Apr 2025 06:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Fi6TWz
 mGGgF4rdHQu+w28UYtK4nREO/Uc6sL2NPFWLY=; b=bdSoJqML24voJPKmmUYyNC
 fDrbw7MYmMy0pJ7k4rDX5/1u8slnoeF81mqYnmbiQLAta3/M1AR86ONs2KXllMGi
 c7TsBh/8vd3c+aqIL4RbG53Il3GizzAm+0F9oBVDuc3yxvVeZcGMO+Lqb5IyQmmq
 EvmPVFN+6vrqsE4cB3hQ63juWUE0V3uG3rU77RdsGeJAMb8ZAkGjK/aUOb8FrTRl
 lLZfSPpXuPzHiRG5RGplzOj7KmFmLkQ7nxBE9l/wTk7m8Xwo1H1XoKi8QV+I2+yb
 /bYNNvCB3+YVAr2B5X8zMVV4/AnAgZJ0HKlaYUUPUOKPQX3v4IZ/4TaKj/0VxLPA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46592v9e2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Apr 2025 06:27:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53L6QMhv012945;
 Mon, 21 Apr 2025 06:27:20 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46592v9e2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Apr 2025 06:27:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53L41q2E001563;
 Mon, 21 Apr 2025 06:27:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rcjvvug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Apr 2025 06:27:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53L6RF2q26018434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Apr 2025 06:27:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7B3F20043;
 Mon, 21 Apr 2025 06:27:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9408120040;
 Mon, 21 Apr 2025 06:27:12 +0000 (GMT)
Received: from [9.39.25.182] (unknown [9.39.25.182])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Apr 2025 06:27:12 +0000 (GMT)
Message-ID: <f414f0ad-0b33-4545-9dc2-9f9e89af59c1@linux.ibm.com>
Date: Mon, 21 Apr 2025 11:57:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Implement Firmware Assisted Dump for PSeries
From: Aditya Gupta <adityag@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250323174007.221116-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NDdaXR4QPuCbdFJEnA_ai6pw0Yf2wc-o
X-Authority-Analysis: v=2.4 cv=RorFLDmK c=1 sm=1 tr=0 ts=6805e548 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=dYOz5sho_cLMNvMCarkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jTpmJ5G770DGCg3zoNM1AlZBpXt0sv5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Hi,

Any comments on the series ?


Thanks,

- Aditya Gupta


On 23/03/25 23:09, Aditya Gupta wrote:
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

