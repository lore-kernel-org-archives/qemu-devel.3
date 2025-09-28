Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD983CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x2u-0002Td-2G; Sun, 28 Sep 2025 15:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x2q-0002TJ-CF
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:26:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x2i-0003wm-BD
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:26:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SBS8kl003678
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=erj9Xh1FXKYRDXVbU2hogqjXsWeq
 u78AMp3ToIM0mLc=; b=Ni7t01wiV7NFgOzY/a4OM5zcUDWz94sybeEi6Q36uDTe
 mGJ0Vn9zLOgHRn4JseH6WWDUyPP5MxkNMNX9DMKP7ga1W4qx9uHVh0yri8Fxnc89
 iYuV5cQK0vNTkOvDoWxhe5f/51jvS4EUWQxYDNAtiD8WAPjsqJj9EMxzZxy+3YyB
 yVJE/l1MQOOTjScMFy3lS3n5WSEUhsR8wI5QszqwG5A2bwbGpM2cYJJM+P6JMc+v
 TkkjLJeguqapawYWKTi8qhg1O62d+0stFNturrRTfuorpG4NylSr1yNcaUuCuP/x
 I68anPM2aAtn/tnKadvnnrOHsHkD7VUa9wxCXl3SIA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7emsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH45sp020095
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8ru14j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQYeN9699616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 005E720049
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59C6E20040
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:33 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:33 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] ppc-for-20250928 queue
Date: Mon, 29 Sep 2025 00:56:02 +0530
Message-ID: <20250928192629.139822-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DXxvoyPhoZ4NvSXzgQphYVWHLDOiE4mN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX598yV3DP/O7Q
 ijGSVr62yDGMWOZGDVcjIylz1v0vQO8ouXv6x37rw3thdc9EVoWrEZQTgKfwNxvOXNT/zO/FMqH
 0S38M9UfIB2zeB8LkDhYuLxbjgXx8dZ1guqTODaLeqI6JSa4Lj6NYkcSJ7eUECqZnnc0YTFbYKa
 efMRJlT6+dgqwB7DCWgBSHhC+Yrp0CZuV8zWuF2MgAI3D7SvFtTExXRBZXka62NsjiQ8h398MyK
 JN2IdmZqbOiSI+llaOyVqexNn7evEDH7Rd4Fqi6rs56/hb7fCXlsX3VXMH2AQopWma35NfaXVFw
 Dpmexx2AvjPhBrNkEZPoVGEzZObgFbKBek1vnP0MSjQP8nT8EBTYEwxAiAp8nqFR7VrSnhXy2pQ
 a30L+04yXQbjpLWiYTHPVBMr60liAQ==
X-Proofpoint-GUID: DXxvoyPhoZ4NvSXzgQphYVWHLDOiE4mN
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68d98bec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=p0WdMEafAAAA:8
 a=sVbD6n94faxykOv1CUIA:9 a=QEXdDO2ut3YA:10 a=poXaRoVlC6wW9_mwW8W4:22
 a=oH34dK2VZjykjzsv8OSz:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The following changes since commit d6dfd8d40cebebc3378d379cd28879e0345fbf91:

  Merge tag 'pull-target-arm-20250926' of https://gitlab.com/pm215/qemu into staging (2025-09-26 13:27:01 -0700)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-20250928-20250929

for you to fetch changes up to 6c51df580d2a64b4e1ef7bdbffeb3615ffe25d43:

  target/ppc: use MAKE_64BIT_MASK for mcrfs exception clear mask (2025-09-28 23:50:36 +0530)

----------------------------------------------------------------
ppc queue for 20250928

* Support for PowerNV11 and PPE42 CPU/Machines.
* Deprecation of Power8E and Power8NVL
* Decodetree patches for some floating-point instructions
* Minor bug fixes, improvements in ppc/spapr/xive/xics.

Qemu CI: https://gitlab.com/harshpb/qemu/-/pipelines/2068351418

----------------------------------------------------------------
Aditya Gupta (10):
      ppc/pnv: Introduce Pnv11Chip
      ppc/pnv: Introduce Power11 PowerNV machine
      ppc/pnv: Add PnvChipClass handler to get reference to interrupt controller
      ppc/pnv: Add XIVE2 controller to Power11
      ppc/pnv: Add PHB5 PCIe Host bridge to Power11
      ppc/pnv: Add ChipTOD model for Power11
      tests/powernv: Switch to buildroot images instead of op-build
      tests/powernv: Add PowerNV test for Power11
      target/ppc: Introduce macro for deprecating PowerPC CPUs
      target/ppc: Deprecate Power8E and Power8NVL

Chinmay Rath (4):
      target/ppc: Move floating-point rounding and conversion instructions to decodetree.
      target/ppc: Move floating-point compare instructions to decodetree.
      target/ppc: Move floating-point move instructions to decodetree.
      target/ppc: Move remaining floating-point move instructions to decodetree.

Denis Sergeev (1):
      target/ppc: use MAKE_64BIT_MASK for mcrfs exception clear mask

Fabian Vogt (1):
      hw/intc/xics: Add missing call to register vmstate_icp_server

Gautam Menghani (1):
      ppc/xive2: Fix integer overflow warning in xive2_redistribute()

Glenn Miles (9):
      target/ppc: IBM PPE42 general regs and flags
      target/ppc: Add IBM PPE42 family of processors
      target/ppc: IBM PPE42 exception flags and regs
      target/ppc: Add IBM PPE42 exception model
      target/ppc: Support for IBM PPE42 MMU
      target/ppc: Add IBM PPE42 special instructions
      hw/ppc: Support for an IBM PPE42 CPU decrementer
      hw/ppc: Add a test machine for the IBM PPE42 CPU
      tests/functional: Add test for IBM PPE42 instructions

Harsh Prateek Bora (1):
      ppc/spapr: init lrdr-capapcity phys with ram size if maxmem not provided

 MAINTAINERS                            |   7 +
 docs/about/deprecated.rst              |   9 +
 docs/system/ppc/powernv.rst            |   9 +-
 include/hw/ppc/pnv.h                   |  38 ++
 include/hw/ppc/pnv_chip.h              |   8 +
 include/hw/ppc/pnv_chiptod.h           |   2 +
 include/hw/ppc/pnv_xscom.h             |  49 +++
 include/hw/ppc/ppc.h                   |   1 +
 target/ppc/cpu-models.h                |   4 +
 target/ppc/cpu.h                       |  76 +++-
 target/ppc/helper.h                    |  38 +-
 target/ppc/insn32.decode               | 106 +++++-
 hw/intc/pnv_xive2.c                    |   4 +-
 hw/intc/xics.c                         |   2 +
 hw/intc/xive2.c                        |  45 ++-
 hw/ppc/pnv.c                           | 560 ++++++++++++++++++++++++++++++
 hw/ppc/pnv_chiptod.c                   |  59 ++++
 hw/ppc/pnv_core.c                      |  17 +
 hw/ppc/ppc_booke.c                     |   7 +-
 hw/ppc/ppe42_machine.c                 | 101 ++++++
 hw/ppc/spapr.c                         |  11 +-
 target/ppc/cpu-models.c                |  27 +-
 target/ppc/cpu_init.c                  | 251 +++++++++++---
 target/ppc/excp_helper.c               | 163 +++++++++
 target/ppc/fpu_helper.c                |  38 +-
 target/ppc/helper_regs.c               |  45 ++-
 target/ppc/tcg-excp_helper.c           |  12 +
 target/ppc/translate.c                 |  35 +-
 target/ppc/translate/fp-impl.c.inc     | 291 ++++++----------
 target/ppc/translate/fp-ops.c.inc      |  30 --
 target/ppc/translate/ppe-impl.c.inc    | 609 +++++++++++++++++++++++++++++++++
 hw/ppc/Kconfig                         |   5 +
 hw/ppc/meson.build                     |   2 +
 tests/functional/ppc/meson.build       |   1 +
 tests/functional/ppc/test_ppe42.py     |  79 +++++
 tests/functional/ppc64/test_powernv.py |  34 +-
 36 files changed, 2407 insertions(+), 368 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc
 create mode 100644 tests/functional/ppc/test_ppe42.py

