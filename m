Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24211F589DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC3v-0004Wm-M4; Fri, 24 Apr 2026 04:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC3s-0004UA-VI; Fri, 24 Apr 2026 04:38:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC3q-00058B-AR; Fri, 24 Apr 2026 04:38:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIB4l03944217; Fri, 24 Apr 2026 08:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=sL9gp7I/jxSDHbP99e7HfABkGVMg3VPFh1Wfo+llI
 LA=; b=Mtm9B9dB47ruOvFU6OU/X9GASH4rb/k+Io/PfgY6oFXpOWAVcqCJWY3vU
 BeMtvktl//iMoFdMAznM57tJ8noI1K5S7xlsOHsKdnFWp92UEKGzRINMC5wtDpEB
 bYZ5Q8PJEX7VWv1BCu/oV0UasxaraFlnI/jT9WwfXFfqWylS0kRPj24KxWJkRgVm
 smSAxn+wlBW6riTnFdlNS3AhEGf6Qy5QGwl6ZRbLxQzBGdiHXF6+rFhOlLOb/273
 9rfmh+HWSahFq/r6aWZWdMoCN8u59vNE5Sj54Hi+GTnoB4llRHWfB1WGcXELHYAP
 JpAZ0g4nyyUzW9HjRMJJJfjRKZVOA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3v2j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:38:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8ZUJJ015566;
 Fri, 24 Apr 2026 08:38:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkya3f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:38:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8chI950266402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:38:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE99E2004E;
 Fri, 24 Apr 2026 08:38:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B1C42004F;
 Fri, 24 Apr 2026 08:38:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:38:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 00/10] Implement MPIPL for PowerNV
Date: Fri, 24 Apr 2026 14:08:27 +0530
Message-ID: <20260424083837.214947-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yUepKAV0ddDhYJSV6pSu7arK8pcMlFKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX3/RyJpWobPwP
 PzTl13klBRWYYktukrt+1OPRmGztrnm21rmGL0jjWX7rNeHeJh8oU2BSqqWA5OW8U/maEEGKhn4
 PnnZ4Rd9QhywBuvOhYKORg7iMGk4hZrK5Zu5lqChhwEypSM6YCktyIxtThd2W1En3dYf/SXBFZR
 D2waY0V6gGoindKZUEJwF1SPPF4xh3SV0qIwA2xsDZIMjDqwDfX8r7yrN3RgmgLoDvFeUTwgynf
 HsYn11zUsXr3YyzwS6Vu9IlBCpKHcTfcsR4v0oN3iRJ+8OxGTyFmZxvgKpVQYiCUYk3M8K8H7nx
 K0bKpghpsEIDhC4JANsRG++KBNrCQsxekHhxO7SutTuOAWKrgD3VE1rlcS6JQzF2w/HdznFvWN0
 RNfQp2dpMV6+bWeTxpoKjycI7nMt4t0PdRS2axgo5fPEZf8D5oLUAH+lCJQGlB8mZ5LrnQTvAxJ
 RFe1QHcICsv7AQZkKYQ==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69eb2c17 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8 a=OEKdL03DoN76juSg_5EA:9
X-Proofpoint-ORIG-GUID: 3RrMm4t9tr2EbiJ_qaKELuJMKelE2iDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, HEXHASH_WORD=2.984, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Overview
=========

Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
in QEMU.

Fadump is an alternative dump mechanism to kdump, in which we the firmware
does a memory preserving boot, and the second/crashkernel is booted fresh
like a normal system reset, instead of the crashed kernel loading the
second/crashkernel in case of kdump.

MPIPL in PowerNV, is similar to fadump in Pseries. The idea is same, memory
preserving, where in PowerNV we are assisted by SBE (Self Boot Engine) &
Hostboot, while in Pseries we are assisted by PHyp (Power Hypervisor)

For implementing in baremetal/powernv QEMU, we need to export a
"ibm,opal/dump" node in the device tree, to tell the kernel we support
MPIPL

Once kernel sees the support, and "fadump=on" is passed on commandline,
kernel will register memory regions to preserve with Skiboot.

Kernel sends these data using OPAL calls, after which skiboot/opal saves
the memory region details to MDST and MDDT tables (S-source, D-destination)

Then in the event of a kernel crash, the kernel initiates MPIPL with another
OPAL code (opal_cec_reboot2), this request goes to Skiboot.
Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
along with OPAL's relocated base address.

SBE then stops all core clocks, and only does particular ISteps for a
memory preserving boot.

Then, hostboot comes up, and with help of the relocated base address, it
accesses MDST & MDDT tables (S-source and D-destination), and preserves the
memory regions according to the data in these tables.
And after preserving, it writes the preserved memory region details to MDRT
tables (R-Result), for the kernel to know where/whether a memory region is
preserved.

Both SBE's and hostboot responsiblities are implemented in the SBE code
in QEMU.

Then in the second kernel/crashkernel boot, OPAL passes the "mpipl-boot"
property for the kernel to know that a dump is active, which kernel then
exports in /proc/vmcore

Testing
====================

1. Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/fadump-powernv-v6

2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2476290852

3. QEMU ppc64 functional tests:
    Ok:                13  
    Fail:              0   
    Skipped:           3   

4. Analysing generated vmcore:

    # file /proc/vmcore
    /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style

    # crash vmlinux-38fec10eb60d-network vmcore-powernv-24apr26
    ...
          KERNEL: vmlinux-38fec10eb60d-network
        DUMPFILE: vmcore-powernv-24apr26
            CPUS: 2
            DATE: Thu Jan  1 05:30:00 IST 1970
          UPTIME: 00:01:38
    LOAD AVERAGE: 0.13, 0.08, 0.03
           TASKS: 84
        NODENAME: buildroot
         RELEASE: 6.14.0
         VERSION: #1 SMP Thu Apr  3 08:06:13 CDT 2025
         MACHINE: ppc64le  (1000 Mhz)
          MEMORY: 6 GB
           PANIC: "Kernel panic - not syncing: sysrq triggered crash"
             PID: 239
         COMMAND: "sh"
            TASK: c00000000933cb00  [THREAD_INFO: c00000000933cb00]
             CPU: 0
           STATE: TASK_RUNNING (PANIC)
    
    crash> bt
    PID: 239      TASK: c00000000933cb00  CPU: 0    COMMAND: "sh"
     R0:  c000000000059604    R1:  c0000000093df9c0    R2:  c0000000020eaa00
     R3:  c0000000bffffff8    R4:  c0000000071e0dc2    R5:  0000000000000002
     R6:  5245424d554e0a32    R7:  4d5f584944415228    R8:  454b0a313d29554d
     R9:  0000000000000000    R10: 4152430a303d5445    R11: 313d454d49544853
     R12: 3837383030373737    R13: c00000017ffff480    R14: 00000001172c0460
     R15: 0000000000000000    R16: 0000000000000000    R17: 00007fffe17bac78
     R18: 000000012cd00700    R19: 0000000000000000    R20: 000000012cd006f8
     R21: fcffffffffffffff    R22: c00000000933cb00    R23: 0000000000000000
     R24: a8aaaaaaaaaaaaaa    R25: c000000003bb7eb8    R26: c000000003e5eab8
     R27: c0000000c0000000    R28: 0000000000000000    R29: 0000000000000002
     R30: c000000003e5eab8    R31: c000000003e16b30
     NIP: c000000000059720    MSR: 9000000000001033    OR3: 0000000000000000
     CTR: 0000000000000000    LR:  c00000000002f69c    XER: 0000000020040006
     CCR: 0000000028002202    MQ:  0000000000000003    DAR: 0000000000000000
     DSISR: 0000000000000000     Syscall Result: 0000000000000000
     [NIP  : crash_fadump+560]
     [LR   : ppc_panic_fadump_handler+84]
     #0 [c0000000093df9c0] crash_fadump at c00000000005966c
     #1 [c0000000093dfa20] ppc_panic_fadump_handler at c00000000002f69c
     #2 [c0000000093dfa40] notifier_call_chain at c0000000001ab390
     #3 [c0000000093dfaa0] atomic_notifier_call_chain at c0000000001ab4a4
     #4 [c0000000093dfac0] panic at c000000000163598
     #5 [c0000000093dfb60] sysrq_handle_crash at c000000000beafd4
     #6 [c0000000093dfbc0] __handle_sysrq at c000000000beb9b4
     #7 [c0000000093dfc60] write_sysrq_trigger at c000000000bec34c
     #8 [c0000000093dfce0] proc_reg_write at c00000000071027c
     #9 [c0000000093dfd10] vfs_write at c000000000620a28
    #10 [c0000000093dfdc0] ksys_write at c000000000621010
    #11 [c0000000093dfe10] system_call_exception at c0000000000324b8
    #12 [c0000000093dfe50] system_call_vectored_common at c00000000000bff0
    crash> kmem -i
                     PAGES        TOTAL      PERCENTAGE
        TOTAL MEM    92396       5.6 GB         ----
             FREE    89710       5.5 GB   97% of TOTAL MEM
             USED     2686     167.9 MB    2% of TOTAL MEM
          BUFFERS        0            0    0% of TOTAL MEM
           CACHED     1500      93.8 MB    1% of TOTAL MEM
             SLAB      674      42.1 MB    0% of TOTAL MEM
    
       TOTAL HUGE        0            0         ----
        HUGE FREE        0            0    0% of TOTAL HUGE
    
       TOTAL SWAP        0            0         ----
        SWAP USED        0            0    0% of TOTAL SWAP
        SWAP FREE        0            0    0% of TOTAL SWAP
    
     COMMIT LIMIT    46198       2.8 GB         ----
        COMMITTED        0            0    0% of TOTAL LIMIT
	crash> # ps and kmem -i works

Changelog
====================

v5 -> v6:
* rebased to upstream commit bb230769b4d01de714bed686161ad39a8f4f3fd1
* #2,3,4: remove osdep.h include from .h file
* #3: use RAM_ADDR_FMT format for ram size
* #4,5: replace '__packed' with 'QEMU_PACKED'
* #8: add pnv_dt_create in pnv_reset, to create dt after mpipl
* #10: add sourabh as reviewer

v4 -> v5:
* #4/10: set chunk_id=0 before copying
* #7/10: remove unnecessary bool check, ie. 'if (b1) b2=b1 else b2=!b1' => 'b2=b1'

v3 -> v4:
* #2/10: s/recieves/receives
* #7/10: remove empty line at EOF

v2 -> v3:
* rebase to upstream, changes in patches below
* #2/10: no code change. add comment that skiboot triggers S0
* #3/10: stash command: handle invalid skiboot_base sent by guest
* #4/10: s/src_len/data_len/
* #4/10: use TARGET_FMT_lx/PRIx64 instead of %lx to prevent build errors
* #4/10: stop copying chunks once copying a chunk fails
* #5/10: use address_space_{read,write} instead of cpu_physical_memory_{read,write}
* #5/10: add more SPRs to be saved, same set of SPRs as spapr FADump, except CR and FPSCR
* #7/10: only export "mpipl-boot" property if preserving cpu states and writing MDRT was successful, otherwise continue with normal reboot
* #7/10: use address_space_{read,write} instead of cpu_physical_memory_{read,write}
* #8/10: reword commit description to mention fw-load-area, no code change
* #10/10: add entry in MAINTAINERS file

Aditya Gupta (10):
  ppc/pnv: Move SBE host doorbell function to top of file
  ppc/mpipl: Implement S0 SBE interrupt
  ppc/pnv: Handle stash command in PowerNV SBE
  pnv/mpipl: Preserve memory regions as per MDST/MDDT tables
  pnv/mpipl: Preserve CPU registers after crash
  pnv/mpipl: Set thread entry size to be allocated by firmware
  pnv/mpipl: Write the preserved CPU and MDRT state
  pnv/mpipl: Enable MPIPL support
  tests/functional: Add test for MPIPL in PowerNV
  MAINTAINERS: Add entry for MPIPL (PowerNV)

 MAINTAINERS                           |   9 +
 hw/ppc/meson.build                    |   1 +
 hw/ppc/pnv.c                          | 108 +++++-
 hw/ppc/pnv_mpipl.c                    | 482 ++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c                      |  85 ++++-
 include/hw/ppc/pnv.h                  |   6 +
 include/hw/ppc/pnv_mpipl.h            | 168 +++++++++
 tests/functional/ppc64/test_fadump.py |  35 +-
 8 files changed, 862 insertions(+), 32 deletions(-)
 create mode 100644 hw/ppc/pnv_mpipl.c
 create mode 100644 include/hw/ppc/pnv_mpipl.h

-- 
2.53.0


