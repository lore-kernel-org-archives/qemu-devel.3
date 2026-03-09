Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA19EEF36F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUuc-0006GD-Mx; Mon, 09 Mar 2026 03:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuV-0006Eq-6n; Mon, 09 Mar 2026 03:20:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuS-00063W-UE; Mon, 09 Mar 2026 03:20:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628Ns16O1681720; Mon, 9 Mar 2026 07:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=4Nwj2VFdTGyIvExDcPv4yqTvp9N85QS/QgPR3zlAw
 U4=; b=G0LwW40W+NxZvicQWIXHnXv915sfVFT7QfdKZ4z4hHV9IaTiwKS0QTz67
 v7sal13cE271CcV6zViaABQlH4+jziCJH8oYjkrzSxY9HrxaHncbsDgakIkCITrn
 SeYKujEdKCZ6bWOybemsZCA5r24ucMexhfAUNAEIqZUynlLGg7r8St6FFEMwH3mk
 0EIuFKVHrG2PEJjGK/GFZggydeBgBiEZEADRAxD3sXqV9I0fqfhfRvwsEM5HaiQV
 Qm7/dKqKulX+L/JNpcOmBV0uyHU+u/MtUehE7HJ4stjBlozDpqbEIAmrUkCGm/SD
 KPy3LsO1ifEKLwVzSKCbghSabWG2Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuy5g00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6295fVKa025085;
 Mon, 9 Mar 2026 07:20:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjutf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297K4eU31326494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FDA42004E;
 Mon,  9 Mar 2026 07:20:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ADDA20043;
 Mon,  9 Mar 2026 07:20:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:02 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 00/10] Implement MPIPL for PowerNV
Date: Mon,  9 Mar 2026 12:49:49 +0530
Message-ID: <20260309072001.3136261-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69ae74a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8 a=z9LRaMQ_lXuMY2NzGswA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfXy7pt3kirf0qT
 0LHnIw6/mbGFMvK1Onlt+D7zg8krhjf5Vl343gYYAHhTMjVYq286l0RGV4VpZB21nUFY/qZfZpt
 v9Me5QFjNe4wg1i9Zhld1wyMa7Pz+9fiHU2AfvkI4wr6zlHLZc64DSN0HtNur9A1wQxY9yKTrlW
 cIkxryz7lkNZcEg/IzSVPqQcMXhSAK4Ob7QWDYKCDZaWXWsJYrlNr/PIVgzw+WfTUJYrXW51sce
 viBaUZZ49WecybDnQ+GpCtghNwWxskldS1Rgl5Kxg+cy9MR/dkqMqj7Cj266ydLFcTTT/G7WSS4
 iTMMDTuWMDBsavey+kPD85aSVXN9Gaf2c/hABYz8FwIsGTJZiaHlaXk/7hv7JE1oMuh7lhR/WIf
 QZbNWF07f3FcgUZ2eRijwSVpNGZTw8nXxpWdB8q6eZfehRH8h2KQ0NVaiz1v6tviS4joQnF2XUt
 exHXfCP3N62Mnb2tXjg==
X-Proofpoint-GUID: 4jF5DDjgqi0ibe5ukf0A0FfT0WcbYr7S
X-Proofpoint-ORIG-GUID: cWGa0-tMyJqkWgHrOjq2Li8Vt_0A3-I6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

1. Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/fadump-powernv-v4

2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2372098708

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

 MAINTAINERS                           |   8 +
 hw/ppc/meson.build                    |   1 +
 hw/ppc/pnv.c                          | 104 ++++++
 hw/ppc/pnv_mpipl.c                    | 481 ++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c                      |  84 ++++-
 include/hw/ppc/pnv.h                  |   7 +
 include/hw/ppc/pnv_mpipl.h            | 168 +++++++++
 tests/functional/ppc64/test_fadump.py |  35 +-
 8 files changed, 857 insertions(+), 31 deletions(-)
 create mode 100644 hw/ppc/pnv_mpipl.c
 create mode 100644 include/hw/ppc/pnv_mpipl.h

-- 
2.53.0


