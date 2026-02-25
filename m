Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCD0FD3758
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEI2-0007F2-Tr; Wed, 25 Feb 2026 07:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEHv-0007EI-DD; Wed, 25 Feb 2026 07:46:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEHt-0002Dz-21; Wed, 25 Feb 2026 07:46:46 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61P57FHk1136392; Wed, 25 Feb 2026 12:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=mrW2Hqgvv9VfQ9zva594pSA1+lGv/6ZDyAiizk4AE
 vc=; b=elq2yLEBBxYZlKgsT0UKALVZTLQdHV2eQfwrIgYkOpPcZAoHXJOAg1oxt
 VKBiyXFkDW5Gy8SrQErcqQs7PzdZH/1HH7s+EF8GPKuXqTdAZE5sgktRdinS8CbA
 0m9iqunf4zR4RCZSA3dqaaWSkTUFOhmLXW0hGlT4X/9nxhlPqr88263Q3VscgvE8
 9s97zcr2CaIZR828kZtP/J1ORabEhAS6eEcZVJEW11FYTn7owV68rJkCml0wPZnx
 dAUf/Ix09E5Y4lRws4iORKaTKhSjpsDEoshIHmEaJ8p8P7uf3kQ3SL6XBH1W+arj
 8xlNt8qWW83hNFnILELHTyGRibRvA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bryerf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:46:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P9FCVe027887;
 Wed, 25 Feb 2026 12:46:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1w291-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:46:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PCkc9d31326622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 12:46:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 686C920040;
 Wed, 25 Feb 2026 12:46:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 795BE20043;
 Wed, 25 Feb 2026 12:46:35 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.235])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 12:46:35 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v3 00/10] Implement MPIPL for PowerNV
Date: Wed, 25 Feb 2026 18:16:22 +0530
Message-ID: <20260225124633.1841222-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lh-sZJPxyS47a7zn0LhlhscRWI3CQLKq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX7PWruK2drOrQ
 PGJhD2VyAeEkXZYCXA5GF54WzeFlFhLzlZj62BtAn0h/LwMflpwJmHzQR83BVpoEL3k96ZDbYFw
 owAhAwb9IXQXar8ucTCO5N/3N8DDRgY7CdVw7dGMGDbaxlWtyCKuEI2/vLV3BAE+aINa3jzvhiW
 mibKXWMlnFRRSywPA1ORDoRRmiZAa3Dn3lh7TAR2tF5yybM1l3nyy7Ng/7mQDj3JQ19un9TJ0gw
 lX7S/0lG+6uQj3FzCzHfXQjDt2K1OhACTWMrVR6z5J6h6gmc/dm4EZqshaI3rZjIJkB1lwL3xQy
 k/NM+1aAQ7XmiJlyB46KXQGEwS6VhM1Vm+Wru3nv6czXgLNgruzJ8voIBGzGs70oTwMl0i0zviG
 dT8BPl8Rl28eyOtFD6i96LTeXbKrs5B0yDo9qLk8c+lUhdVvqJzhQYC03ZxyOAUH5+fOQ6VfI2K
 1IiytCt+qN1AC3iI+lg==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699eef33 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=p0WdMEafAAAA:8 a=z9LRaMQ_lXuMY2NzGswA:9
X-Proofpoint-GUID: rWJ-Vbu47UUx_tE8HmDvHnvw8OnKxowV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

1. Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/fadump-powernv-v3

2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2348793709

3. Analysing generated vmcore:

	# ls -lh /proc/vmcore 
	-r--------    1 root     root        4.5G Feb 25 07:33 /proc/vmcore
	# file /proc/vmcore 
	/proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style

	# crash vmlinux vmcore
	...
	      KERNEL: vmlinux-38fec10eb60d-network      
	    DUMPFILE: vmcore-powernv-25feb26
	        CPUS: 4
	        DATE: Thu Jan  1 05:30:00 IST 1970
	      UPTIME: 00:05:23
	LOAD AVERAGE: 0.12, 0.08, 0.03
	       TASKS: 101
	    NODENAME: buildroot
	     RELEASE: 6.14.0
	     VERSION: #1 SMP Thu Apr  3 08:06:13 CDT 2025
	     MACHINE: ppc64le  (1000 Mhz)
	      MEMORY: 6 GB
	       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
	         PID: 257
	     COMMAND: "sh"
	        TASK: c000000008066600  [THREAD_INFO: c000000008066600]
	         CPU: 2
	       STATE: TASK_RUNNING (PANIC)

	crash> # ps and kmem -i works

Changelog
====================

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

 MAINTAINERS                           |   8 +
 hw/ppc/meson.build                    |   1 +
 hw/ppc/pnv.c                          | 104 ++++++
 hw/ppc/pnv_mpipl.c                    | 482 ++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c                      |  84 ++++-
 include/hw/ppc/pnv.h                  |   7 +
 include/hw/ppc/pnv_mpipl.h            | 168 +++++++++
 tests/functional/ppc64/test_fadump.py |  35 +-
 8 files changed, 858 insertions(+), 31 deletions(-)
 create mode 100644 hw/ppc/pnv_mpipl.c
 create mode 100644 include/hw/ppc/pnv_mpipl.h

-- 
2.53.0


