Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E289C5516E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpX5D-0004Gy-CF; Thu, 30 Jul 2026 16:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5B-0004DV-GC; Thu, 30 Jul 2026 16:10:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX59-0001gi-6j; Thu, 30 Jul 2026 16:10:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJmv3S4002895; Thu, 30 Jul 2026 20:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=42d3W3kF0uWwMZfKDf+l0ZD8hi/x
 PFntIGPadmAHWWc=; b=pRtm4/14onYT2R06tj2JrM5qzBRMCb/oSTqoUPzHfcL2
 4NIO+XHatPQoHnHFNZ/q02zMaQ6tfrxtD+ZwWkx4id7vKTgKSfkRWnOz8VMrlG23
 hMtvPCPyz3uw1mK/THzijzvqZygWbhA56KYaLZ2Fr3HHDV7namT++Czvcafbgr65
 RcNJDJGPeEPDbT/3x+V9SJbElT2COeE6ZG9f93JsIr8awtqNc0NHIABdFDxZ+fvk
 Bcukt7UPPzdyg4TD0S7gW3CMXM8SROQtcuCqdbkE2uvnI15N4XlBQNCGMFldcoeR
 VTAFUzg8kf4TNmlUkkcQZZApDJYRT6Wg9JpPYEozgg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd8snw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJuMG9008974;
 Thu, 30 Jul 2026 20:09:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwd382-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UK9lVo58786194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 20:09:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4971D58043;
 Thu, 30 Jul 2026 20:09:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D890558055;
 Thu, 30 Jul 2026 20:09:46 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 20:09:46 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] Add IBM Huygens BMC machine for AST2700
Date: Thu, 30 Jul 2026 15:09:35 -0500
Message-ID: <20260730200945.1113936-1-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: BK4SpnDLrSpCpnrsnaxgcLhfmfHAEhYC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfXyVvVlk+xVu3L
 rgbqIbUXXFwn3BNGy/LJoWDZg5DHowapwE/bCakrC7B76tg/YF5fKFWoOqfiiW1X7ujeULnNCRn
 snpu7zxP2WLBgtFhqzlQaWCE26/HguM=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6baf8d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=X-OJmhkvuyxfmyMaHAUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfXwIICU2hxqat1
 8LqPMnTR4uPbGCmHY14fP/wJsGPbDQZnzPKIF5Oo0ozkotbKpvmZsnkeMVqrJCW2Ont/YBVgr/n
 z4TljfJeUI4/BYkovZokNtPDT604Lw45+mGKQLFdo5n1p2Q5B3hDsBMJAnvrCHIOFGGL/hVfA8h
 Ik2rZCox3ydE0SFCMYOYB+Pu6urbekDWeEtAGoHlJXgTcdxi+b+JHBqf88rj/vuGR6W//Aatglv
 l26IlUdct2mGrRgmdoF2+LosVKSJwXEOqRmUJ7MPo8BDqDziLQM3g+NgDvvTUUMyIugzeo7ooPZ
 ZI9QJ6YpzY1dJ882BnRXLNvfJrfoZ51LBkE1nJSfw19xyKF7LUI3Xq/JbOSLRyOBJwSRdR98d1j
 MsYW0RbqAJ+U/viPaElz2IVQRll/aw3j3XmUEO2NFJ4ULaQhnQ9px6h8MS6ggfSVBuXrDW1qDX+
 Kenj2+5swsN8mwmPE8A==
X-Proofpoint-GUID: sThEzNdcgbSYRcxQ4-9QZeGX_kifF1If
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=mikail.sadic@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds initial support for the IBM Huygens BMC, the baseboard
management controller of an IBM POWER12 server platform, based on the
ASPEED AST2700 A2 SoC.

It introduces a CFAM-S FSI responder model, wires the AST2700 FSI
controllers to their APB-to-OPB bridges, fixes an aspeed I2C DMA
block-read corner case, adds a TI UCD90320 PMBus power-sequencer model,
refactors the UFS device into a shared core with a new AST2700 sysbus
frontend, and finally adds the huygens-bmc machine that ties these
together to boot OpenBMC from FMC flash and a UFS root filesystem.

Patch summary:

  1. fsi/cfam: a common CFAM model holding the slot, config table,
     responder and local bus, with the existing cfam as its first
     derivative. No functional change to the existing cfam.
  2. fsi/cfam: the CFAM-S as a second derivative - its own config table,
     the slave-ID alias window, and a v1 mailbox engine added to lbus.c
     alongside the scratchpad.
  3. arm/aspeed: wire the two AST2700 FSI controllers to their APB-to-OPB
     bridges.
  4. i2c/aspeed: fix DMA-receive first-byte handling so SMBus block reads
     (I2C_M_RECV_LEN) report the correct length.
  5. hw/sensor: TI UCD90320 24-rail PMBus power sequencer.
  6. ufs: refactor the transport-independent UFS core out of the PCI
     device (SDHCI/XHCI-style) so PCI and sysbus frontends share it.
     TYPE_UFS stays a PCI device and -device ufs is unchanged.
  7. ufs/aspeed: AST2700 sysbus UFS frontend on the shared core.
  8. arm/aspeed: the huygens-bmc machine.

Changes since v1:

* Split the original 5 commits into 8. The aspeed I2C DMA fix, the FSI
  controller wiring, the CFAM common base class, and the UFS
  core-vs-frontend split are now separate patches (each buildable on its
  own).

* UFS: reworked per review (Jeuk Kim). Instead of a second, standalone
  UFS implementation, the common core (register block, UTRL/UTMRL, UPIU,
  query and ufs-lu handling) is separated from the PCI glue (DMA address
  space, IRQ, realize) so the AST2700 controller is a thin sysbus
  frontend on top of it, following the SDHCI/XHCI pattern. Two small,
  backwards-compatible additions ride on the core: a configurable ufs-lu
  logical-block-size (default unchanged, so the PCI device is unaffected)
  and an unmapped-LUN INQUIRY that reports "not connected" instead of
  failing the request. The PCI ufs-tests qtests still pass.

* CFAM-S: reworked per review (Ninad). It now shares a common base class
  with the cfam rather than being a parallel implementation: patch 1 adds
  an abstract cfam-common whose realize is driven by an FSICFAMCommonClass
  (config table, responder and local-bus offsets, and an engines hook),
  and both cfam and cfam-s derive from it. They are siblings rather than
  parent and child, since a CFAM-S is another kind of CFAM and not a
  specialisation of the P9 one. Patch 2 adds cfam-s supplying only its own
  config table, its mailbox engine and the slave-ID alias window; the v1
  mailbox is a local bus engine so it sits in lbus.c next to the
  scratchpad. Duplicated code has been cleaned. Two behavior changes
  follow from sharing the common config ops, both noted in patch 2: cfam-s
  now honors the SID_BREAK sequence, and config-table access is word-only
  for both types. Also made generic, all specific references dropped.

  Patch 1 is intended to be a no-op for the existing cfam, and was
  checked that way: aspeed_fsi-test passes, the four P9 config words read
  back identically over the OPB, and "info mtree" for ast2600-evb is
  unchanged. The Rainier boot test was also run and verified.

* i2c/aspeed: the DMA block-read fix is now its own patch, with a commit
  message explaining the I2C_M_RECV_LEN + DMA interaction (Cédric).

* UCD90320: the device-id/monitor-config/mfr-status responses are now
  device reset state rather than file-scope constants, with matching
  VMState (Cédric).

* Docs: the huygens-bmc and aspeed-ufs boot examples now use -blockdev
  instead of -drive (Cédric).

* Machine: commit message expanded (POWER12 BMC on AST2700 A2), the VPD
  buffer uses g_autofree, the docs describe the flash-vs-UFS split, and
  the networking example was simplified.

* New device files use DEFINE_TYPES() with inlined TypeInfo (Jamin Lin).

* Dropped the v1 functional test for now: depends on non-public Huygens
  images. It will be resent once images go public.

Testing done:

* Whole series builds.
* aspeed_fsi-test passes (4/4), unchanged by the CFAM refactor.
* huygens-bmc boots OpenBMC to the login prompt and multi-user target
  from FMC flash + UFS storage (internal images).
* PCI UFS ufs-tests qtests pass, unchanged by the refactor.
* make check passes all tests.

Note: checkpatch reports a couple of MAINTAINERS/SPDX warnings for the
new files; they are covered by existing wildcard entries in the ASPEED
and FSI sections.

Thank you for all of the helpful feedback.

Mikail Sadic (8):
  fsi/cfam: Add common CFAM base class
  fsi/cfam: Add CFAM-S model
  arm/aspeed: Wire AST2700 FSI controllers to APB-to-OPB bridges
  i2c/aspeed: Fix DMA receive first-byte handling for block reads
  hw/sensor: Add UCD90320 model
  ufs: Refactor common core out of the PCI implementation
  ufs/aspeed: Add AST2700 sysbus UFS frontend
  arm/aspeed: Add AST2700 Huygens machine

 MAINTAINERS                     |   2 +
 docs/specs/aspeed-ufs.rst       |  40 ++++++
 docs/specs/fsi.rst              |  15 ++
 docs/specs/index.rst            |   2 +
 docs/specs/ucd90320.rst         |  36 +++++
 docs/system/arm/aspeed.rst      |  50 ++++++-
 hw/ufs/ufs.h                    |  18 ++-
 include/hw/arm/aspeed.h         |   1 +
 include/hw/arm/aspeed_soc.h     |   3 +
 include/hw/fsi/cfam-s.h         |  40 ++++++
 include/hw/fsi/cfam.h           |  68 ++++++++-
 include/hw/fsi/fsi-master.h     |   2 +
 include/hw/fsi/lbus.h           |  11 ++
 include/hw/ufs/aspeed_ufs.h     |  16 +++
 hw/arm/aspeed.c                 |  25 ++++
 hw/arm/aspeed_ast27x0.c         |  31 ++++
 hw/arm/aspeed_ast27x0_huygens.c | 241 ++++++++++++++++++++++++++++++++
 hw/fsi/cfam-s.c                 |  91 ++++++++++++
 hw/fsi/cfam.c                   | 123 +++++++++-------
 hw/fsi/fsi-master.c             |   9 +-
 hw/fsi/lbus.c                   |  69 +++++++++
 hw/i2c/aspeed_i2c.c             |   7 +
 hw/sensor/ucd90320.c            | 169 ++++++++++++++++++++++
 hw/ufs/aspeed_ufs.c             |  75 ++++++++++
 hw/ufs/lu.c                     |  50 ++++++-
 hw/ufs/ufs.c                    |  57 +++++---
 hw/arm/Kconfig                  |   1 +
 hw/arm/meson.build              |   1 +
 hw/fsi/meson.build              |   2 +-
 hw/fsi/trace-events             |   2 +
 hw/sensor/Kconfig               |   4 +
 hw/sensor/meson.build           |   1 +
 hw/ufs/meson.build              |   1 +
 33 files changed, 1182 insertions(+), 81 deletions(-)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 docs/specs/ucd90320.rst
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/arm/aspeed_ast27x0_huygens.c
 create mode 100644 hw/fsi/cfam-s.c
 create mode 100644 hw/sensor/ucd90320.c
 create mode 100644 hw/ufs/aspeed_ufs.c


base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
-- 
2.53.0


