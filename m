Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1095CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuV8-0006aM-CN; Thu, 23 Oct 2025 08:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vBpdx-0000IK-Up; Thu, 23 Oct 2025 03:21:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vBpdq-0007Q0-Mn; Thu, 23 Oct 2025 03:21:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6am3F013852;
 Thu, 23 Oct 2025 07:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PDpfbB
 e+7yDen1s0A8/RYdtUgxWTx+RUvRJOJhV4p/U=; b=G9AXWoAIzv+V6InNomkobO
 aSsi4PM4ayTf0ggVltMGYQT2PRtrbQnhTrupEHRL6gFqLJCmCJlqWyhpZG8uIAu9
 dySXBHmrzwsHkZUbMgtRhjah5ZS/4f2l1e3fL5Ow7Q7Gu7uUtFrVWodbkW4Hl1H+
 7PzKmCAHcoTGiYMO4Bbbb2DLQRM0/r8gpC2wc5mtvN7RuFXxNYjsPkAEoijT3m7T
 BsZMw7oWOSK/fNBBOjAsK5yDisfoFAr6yhnYLjv57YScCvLna4cVlZo7XM9CnBBU
 dw0TOBXV1QQRjAJoq5+7MCu+SXHAF2o+1SwPYTlSa30xwP223jGrIhCWAvGjDhWw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vydw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:21:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N7LeJS023837;
 Thu, 23 Oct 2025 07:21:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vydvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:21:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6jDKF024686;
 Thu, 23 Oct 2025 07:21:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk4f6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:21:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N7LaK013697508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 07:21:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A58A2004B;
 Thu, 23 Oct 2025 07:21:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8D1320043;
 Thu, 23 Oct 2025 07:21:33 +0000 (GMT)
Received: from [9.39.26.208] (unknown [9.39.26.208])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 07:21:33 +0000 (GMT)
Message-ID: <3e3378f1-7fc0-47da-800a-9f8987bf072b@linux.ibm.com>
Date: Thu, 23 Oct 2025 12:51:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Implement Firmware Assisted Dump for PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
Content-Language: en-US
From: shivang upadhyay <shivangu@linux.ibm.com>
In-Reply-To: <20251021134823.1861675-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AMVOwYKyyOgKYPIOkBHsroU7RKMj-5CQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx0PNNDBNDUKj
 pBjuLlLQUw/6EeSiGVVeO8tjw/Ull2ZtcXnWxhmtpCyUITHYJKHfWLtxIHRJhL8beLcME3RuZmz
 fHPh7zN+llcQavxNzmCOaw/kSyQ0w/tUksiYtFD3bf9XKiOPFJtR5Gv8KPuvAf1iNw8Ksv5xELO
 t3NeVQfn3L3/bt2vEkdXCTVQO2Y+LYrmSER86qukcpmqLgzgq/ZIKQvgiZ83B7KlNnZ+q4VVm5j
 PaRwk30NxloFT9/fnEYE0gk2DfvssB4Mp6jFJfDZrdtow9YOoiCyvqTUVsehQziKo+sqARi69G4
 VSMn3go+/i5UyP9IdzPtH2jbfQneh0tKYs5Q56+tErsStY+pAAjK7D8NXhP9tC91X9VYOG0TRmK
 3KGyUbcPDVqJWd7H9EfEw+e29v5YIw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f9d785 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=wEDoamZ1AAAA:20 a=NEAV23lmAAAA:8 a=93Ubh6UdAAAA:8
 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8 a=mw8Mp3qblR76PRYpqnsA:9 a=QEXdDO2ut3YA:10
 a=q-6THwuxr82FYj4XiUVi:22 a=yULaImgL6KKpOYXvFmjq:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: a7ogN3HTP7LsGitHAHNAjzXL1D4TJRYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 08:24:38 -0400
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


On 10/21/25 7:18 PM, Aditya Gupta wrote:
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
> Refer the Patch #7: "hw/ppc: Enable fadump for PSeries" for logs of a
> succesfful fadump crash
>
> Note: HPTE region has not been implemented. It's not planned as of now.
>
> Testing
> =======
>
> Has been tested with following QEMU options:
>
> * make check-functional-ppc64
> * smt1/smt4
> * with/without e1000e device
> * gitlab ci: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2111480523
>
> Following vmcore has been generated with v5 of this series, booted with
> -smp 4: https://ibm.box.com/s/dv92hdi67hh0588xn8cbvkjmlcy04d7h
>
> Git Tree for Testing
> ====================
>
> https://github.com/adi-g15-ibm/qemu/tree/fadump-pseries-v5
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
> Changelog
> =========
> v5:
>    + rebased to upstream, implemented reviews by sourabh and harsh
>    + [patch #1]: patch #1 and #2 of v4 merged into one
>    + [patch #3]: copy memory region in chunks of 32MB instead of all at once
>    + [patch #4]: fix endianness of vcpu id in CPUSTRT/CPUEND entries
>    + [patch #5]: replaced type __be32 with uint32_t
>    + [patch #7]: increased timeout for few messages to 20 seconds
>    + [patch #8]: update maintainers file for fadump
>
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
>    hw/ppc: Implement fadump register command
>    hw/ppc: Trigger Fadump boot if fadump is registered
>    hw/ppc: Preserve memory regions registered for fadump
>    hw/ppc: Implement saving CPU state in Fadump
>    hw/ppc: Pass dump-sizes property for fadump in device tree
>    hw/ppc: Enable fadump for PSeries
>    tests/functional: Add test for fadump in PSeries
>    MAINTAINERS: Add entry for FADump (pSeries)
>
>   MAINTAINERS                               |   8 +
>   hw/ppc/meson.build                        |   1 +
>   hw/ppc/spapr.c                            |  69 ++
>   hw/ppc/spapr_fadump.c                     | 730 ++++++++++++++++++++++
>   hw/ppc/spapr_rtas.c                       |  76 +++
>   include/hw/ppc/spapr.h                    |  11 +-
>   include/hw/ppc/spapr_fadump.h             | 124 ++++
>   tests/functional/ppc64/meson.build        |   2 +
>   tests/functional/ppc64/test_fadump.py     | 182 ++++++
>   tests/functional/qemu_test/linuxkernel.py |  59 ++
>   10 files changed, 1261 insertions(+), 1 deletion(-)
>   create mode 100644 hw/ppc/spapr_fadump.c
>   create mode 100644 include/hw/ppc/spapr_fadump.h
>   create mode 100755 tests/functional/ppc64/test_fadump.py

I've tested this patch series on the fedora-42 cloud images [1], and 
buildroot `qemu_ppc64_pseries_defconfig` image.
Tested-by:Shivang Upadhyay <shivangu@linux.ibm.com>
following are the logs for fedora test.
kernel command line
# grubby --info=ALL
....
args="no_timer_checkconsole=tty1console=ttyS0,115200n8systemd.firstboot=offrootflags=subvol=rootfadump=on"
....
triggeringthepanic
# echo c > /proc/sysrq-trigger
[390.457957]sysrq:Triggeracrash
[390.462183]Kernelpanic-notsyncing:sysrqtriggeredcrash
[390.463285]CPU:0UID:0PID:1081Comm:bashNottainted6.14.0-63.fc42.ppc64le#1
[390.464074]Hardwarename:IBMpSeries(emulatedbyqemu)POWER10(architected)0x8012000xf000006of:SLOF,git-ee03aepSeries
[390.465359]CallTrace:
[390.465675][c000000007023890][c000000001787a64]dump_stack_lvl+0x88/0xc4(unreliable)
[390.467916][c0000000070238c0][c000000000250a44]panic+0x19c/0x4a8
[390.468555][c000000007023960][c000000000f70684]sysrq_handle_crash+0x24/0x30
[390.469218][c0000000070239c0][c000000000f71388]__handle_sysrq+0xe8/0x3c0
[390.469898][c000000007023a90][c000000000f722d0]write_sysrq_trigger+0x1d0/0x268
[390.470563][c000000007023af0][c0000000008bf620]proc_reg_write+0xf0/0x160
[390.471184][c000000007023b20][c0000000007b63b8]vfs_write+0x128/0x590
[390.471791][c000000007023be0][c0000000007b6a10]ksys_write+0x80/0x150
[390.472388][c000000007023c30][c000000000032980]system_call_exception+0x160/0x310
[390.473075][c000000007023e50][c00000000000d05c]system_call_vectored_common+0x15c/0x2ec
[390.473826]---interrupt:3000at0x7fffa36a8494
[390.474653]NIP:00007fffa36a8494LR:00007fffa36a8494CTR:0000000000000000
[390.475341]REGS:c000000007023e80TRAP:3000Nottainted(6.14.0-63.fc42.ppc64le)
[390.476056]MSR:800000000280f033<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>CR:48222408XER:00000000
[390.477150]IRQMASK:0
[390.477150]GPR00:000000000000000400007fffefd0a24000000000001000000000000000000001
[390.477150]GPR04:000000013fd206c0000000000000000200000000000000000000000000000000
[390.477150]GPR08:0000000000000000000000000000000000000000000000000000000000000000
[390.477150]GPR12:000000000000000000007fffa3a0ac20000000012300005c000000013fd59b40
[390.477150]GPR16:0000000123009528000000013fd3e3f000000000000000010000000122f06460
[390.477150]GPR20:00000000000000000000000122faea1000000001230096d80000000123008bb8
[390.477150]GPR24:00000000000000000000000123008ba80000000122fb156000007fffa3841878
[390.477150]GPR28:000000000000000200007fffa3841790000000013fd206c00000000000000002
[390.483172]NIP[00007fffa36a8494]0x7fffa36a8494
[390.483616]LR[00007fffa36a8494]0x7fffa36a8494
[390.484072]---interrupt:3000
qemu-system-ppc64:warning:TCGdoesn'tsupportrequestedfeature,cap-cfpc=workaround
qemu-system-ppc64:warning:TCGdoesn'tsupportrequestedfeature,cap-ibs=workaround
qemu-system-ppc64:warning:TCGdoesn'tsupportrequestedfeature,cap-ccf-assist=on
SLOF**********************************************************************
QEMUStarting
BuildDate=Nov6202415:31:54
FWVersion=git-ee03aec2c106a699
Press"s"toenterOpenFirmware.
Populating/vdevicemethods
Populating/vdevice/vty@71000000
Populating/vdevice/nvram@71000001
Populating/vdevice/l-lan@71000002
Populating/vdevice/v-scsi@71000003
SCSI:Lookingfordevices
8000000000000000DISK:"QEMUQEMUHARDDISK2.5+"
8200000000000000CD-ROM:"QEMUQEMUCD-ROM2.5+"
Populating/pci@800000020000000
000000(D):12341111qemuvga
000800(D):10330194serialbus[usb-xhci]
InstallingQEMUfb
ScanningUSB
XHCI:Initializing
USBKeyboard
USBmouse
Usingdefaultconsole:/vdevice/vty@71000000
WelcometoOpenFirmware
Copyright(c)2004,2017IBMCorporationAllrightsreserved.
Thisprogramandtheaccompanyingmaterialsaremadeavailable
underthetermsoftheBSDLicenseavailableat
http://www.opensource.org/licenses/bsd-license.php
Tryingtoload:from:/vdevice/v-scsi@71000003/disk@8000000000000000...Successfullyloaded
WelcometoGRUB!
error:../../grub-core/term/serial.c:278:serialport`auto'isn'tfound.
error:../../grub-core/commands/terminal.c:138:terminal`serial'isn'tfound.
error:../../grub-core/commands/terminal.c:138:terminal`serial'isn'tfound.
Booting`FedoraLinux(6.14.0-63.fc42.ppc64le)42(CloudEdition)'
OFstdoutdeviceis:/vdevice/vty@71000000
PreparingtobootLinuxversion6.14.0-63.fc42.ppc64le(mockbuild@6dfdb20f66f3497abc344a07ba6fd9d1)(gcc(GCC)15.0.120250228(RedHat15.0.1-0),GNUldversion2.44-3.fc42)#1 
SMP Mon Mar 24 19:38:12 UTC 2025
Detectedmachinetype:0000000000000101
commandline:BOOT_IMAGE=(ieee1275/disk,gpt2)/vmlinuz-6.14.0-63.fc42.ppc64leno_timer_checkconsole=tty1console=ttyS0,115200n8systemd.firstboot=offroot=UUID=1226ffcb-9b43-42cd-9265-c87dfc50b214rootflags=subvol=rootfadump=on
Maxnumberofcorespassedtofirmware:2048(NR_CPUS=2048)
Callingibm,client-architecture-support...done
memorylayoutatinit:
memory_limit:0000000000000000(16MBaligned)
alloc_bottom:000000000ac50000
alloc_top:0000000030000000
alloc_top_hi:0000000280000000
rmo_top:0000000030000000
ram_top:0000000280000000
founddisplay:/pci@800000020000000/vga@0,opening...done
instantiatingrtasat0x000000002fff0000...done
prom_hold_cpus:skipped
copyingOFdevicetree...
Buildingdtstrings...
Buildingdtstructure...
Devicetreestrings0x000000000ac60000->0x000000000ac60c96
Devicetreestruct0x000000000ac70000->0x000000000ac80000
QuiescingOpenFirmware...
BootingLinuxvia__start()@0x0000000002300000...
[0.000000]rtasfadump:Firmware-assisteddumpisactive.
[0.000000]random:crnginitdone
[0.000000]fadump:Updatedcmdline:BOOT_IMAGE=(ieee1275/disk,gpt2)/vmlinuz-6.14.0-63.fc42.ppc64leno_timer_checkconsole=tty1console=ttyS0,115200n8systemd.firstboot=offroot=UUID=1226ffcb-9b43-42cd-9265-c87dfc50b214rootflags=subvol=rootfadump=on
[0.000000]fadump:Firmware-assisteddumpisactive.
[0.000000]fadump:Reserving9728MBofmemoryat0x00000020000000forpreservingcrashdata
[0.000000]radix-mmu:Pagesizesfromdevice-tree:
[0.000000]radix-mmu:Pagesizeshift=12AP=0x0
[0.000000]radix-mmu:Pagesizeshift=16AP=0x5
[0.000000]radix-mmu:Pagesizeshift=21AP=0x1
[0.000000]radix-mmu:Pagesizeshift=30AP=0x2
....
openingthegeneratedinvmcoreincrash(vmlinuxdebugsourcetakenfrom[2]).
# crash ./vmcore ./vmlinux
crash9.0.0++
....
Forhelp,type"help".
Type"aproposword"tosearchforcommandsrelatedto"word"...
KERNEL:/home/crash-images/vmlinux
DUMPFILE:./vmcore[PARTIALDUMP]
CPUS:1
DATE:WedDec3119:00:00EST1969
UPTIME:00:04:33
LOADAVERAGE:1.14,1.50,0.73
TASKS:111
NODENAME:localhost
RELEASE:6.14.0-63.fc42.ppc64le
VERSION:#1 SMP Mon Mar 24 19:38:12 UTC 2025
MACHINE:ppc64le(1000Mhz)
MEMORY:10GB
PANIC:"Kernelpanic-notsyncing:sysrqtriggeredcrash"
PID:1084
COMMAND:"bash"
TASK:c000000007057580[THREAD_INFO:c000000007057580]
CPU:0
STATE:TASK_RUNNING(PANIC)
crash>
....
[1]https://fedoraproject.org/cloud/download/
[2]https://archive.fedoraproject.org/pub/fedora-secondary/releases/42/Server/ppc64le/debug/tree/Packages/k/kernel-debuginfo-6.14.0-63.fc42.ppc64le.rpm

