Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA4AC5DF69
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wub9A-0000eG-ON; Thu, 13 Aug 2026 15:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wub8z-0000cH-T1; Thu, 13 Aug 2026 15:31:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wub8v-0005Xx-M2; Thu, 13 Aug 2026 15:31:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DJ1r8h3196821; Thu, 13 Aug 2026 19:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=9fODObWcFE14fibxmNzKyyhroPXV
 r1R2ScZ45cHVC+Q=; b=HjHfyOYN9d5QiNICJQ63j+waV+Ystg3UgVZJgrZRwqgT
 DSOngDTYrooY+RziKsqDfpOd23vS1s0Q2PleS7y6CTOs70J6sRq/EyhFnFWYML9L
 DDQVWvgXJbcbYVqmV6rqrl1V4S+CTuxjDyQQWFOeOvP7m1XPZmiAlB1aWSZQWUuu
 nKoTuWUfCCFYY5srz3j/HtGEq5PcUI0fvmdlWSpq0x4urBKcO7ZPTEFw1/xZLl9G
 60vMa8a9qbIj6DoIWl3fWhNsRjb59APcRvPncgh6pm3JlvhQGqdhn+0MlbKkpW+6
 va+ZE9uVus3IEf6+M4JGBBZa+NyPxE+yJPQEzy+F2Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma1q13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 19:30:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DJQPnV012627;
 Thu, 13 Aug 2026 19:30:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqcjk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 19:30:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DJUg0n54395150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 19:30:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 591235805B;
 Thu, 13 Aug 2026 19:30:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CE1258060;
 Thu, 13 Aug 2026 19:30:41 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2026 19:30:41 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] Add IBM Huygens BMC machine for AST2700
Date: Thu, 13 Aug 2026 14:30:32 -0500
Message-ID: <20260813193040.669533-1-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzOCBTYWx0ZWRfX3b19h5QPkCBR
 DfU04YF1MpKNc5jmo4dt0N6k9ZWncwhNGXdPw2UdwCEKyaVPTPsFaQ7R/8ZVO3fdevq6ojthX6b
 x8tbtJG+6qQJRfCMEghCQsBhK55VJyaxeocEwTF+5Mue1jQfey0pDlWmZtkqJWkZ0pDM4RK1T29
 yR6ZhdFzHz+98MMPbwY/rTJaz0Kyb1wISlfLiDKe6xAAHH39tldz+KNgRtVhq02gvVQUW3uC0JF
 n4/8VM+fjii9tCuPxoXyw553YqqXL5Nmm4ySVoCdwH3ZtJFnGMxSVQ1+/ctXl2MqYhUtlw7iWtx
 5vMn7A3RLmHUnODAXDsGLJfIrNS7O3jyq66lyt9w080Sih0S/NSljENLL4COsFTWrAZ/ISheYr4
 MQZOqgN5pQEB+CmIp0sfOaukuSIBTU+EsUeKRsNqnFHsUIatM3soHlVyG6jRONrvUA6mNh+1ODy
 fifKJs4Fqg5uqyOphkw==
X-Proofpoint-ORIG-GUID: 1ymoptXiJWSPK9kOf5RpRQ32XBPca0oV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzOCBTYWx0ZWRfX4S+H/OuMNcAY
 PVaYStswX102JPxId/Uuj9skFraYRMSP6E/jESivtF8HzpgnpeyI3WoumEK/q1JxUaCZC2HdjUV
 FX1y4tIfs3rSs4bkYbGC7bx9yUWQm5E=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7e1b65 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=hD80L64hAAAA:8 a=V2NxCb60AAAA:8 a=NEAV23lmAAAA:8 a=GFUYeY8HRM1waPgzSTQA:9
 a=QEXdDO2ut3YA:10 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: OCixTD_iwNBgaXunzNJ3YnZpYGC0si5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
controllers to their APB-to-OPB bridges, adds a TI UCD90320 PMBus
power-sequencer model, adds an AST2700 UFS host controller on top of the
generic sysbus UFS device, and finally adds the huygens-bmc machine that
ties these together to boot OpenBMC from FMC flash and a UFS root
filesystem.

Dependencies, both on-list, neither merged yet:

1. Jeuk Kim's UFS restructure, which patches 5 and 6 build on:

     https://lore.kernel.org/qemu-devel/cover.1786096976.git.jeuk20.kim@samsung.com/

   The base-commit trailer below therefore names a local commit: current
   master plus those two patches. Patches 1-4 and 7 do not need it.

2. Jamin Lin's I2C block-read fix:

     https://patchwork.kernel.org/project/qemu-devel/patch/20260813090205.853307-1-jamin_lin@aspeedtech.com/

   This one is a runtime rather than a build dependency, which is why the
   series is not based on it. Everything compiles and every machine
   constructs without it, but the UCD90320 in patch 4 will not probe,
   because the ucd9000 driver identifies the device with an SMBus block
   read and the AST2700 reports the block length from a register that
   patch models. I have tested his patch against that driver and it works;
   the Huygens-BMC boot was run with it applied.

   The guest also needs a kernel that reads the block length from the
   right register on AST2700, i.e. one carrying

     https://github.com/AspeedTech-BMC/linux/commit/f9938ec5799e

Patch summary:

  1. fsi/cfam: a common CFAM model holding the slot, config table,
     responder and local bus, with the existing cfam as its first
     derivative. No functional change to the existing cfam.
  2. fsi/cfam: the CFAM-S as a second derivative - its own config table,
     the slave-ID alias window, and a v1 mailbox engine added to lbus.c
     alongside the scratchpad.
  3. arm/aspeed: wire the two AST2700 FSI controllers to their APB-to-OPB
     bridges.
  4. hw/sensor: TI UCD90320 24-rail PMBus power sequencer.
  5. ufs: a configurable logical-block-size on ufs-lu, and an unmapped LUN
     answering INQUIRY as "not connected". The ufs PCI device keeps its
     current property set and geometry.
  6. ufs/aspeed: the AST2700 UFS host controller as a subclass of
     TYPE_SYSBUS_UFS, adding only the UFSHCI version.
  7. arm/aspeed: the huygens-bmc machine.

Changes since v3:

* Dropped the i2c/aspeed patch (v3 4/8). Jamin Lin has posted the correct
  implementation, which the UCD90320 now depends on instead; reviewed and
  tested, see the dependency note above. The guest also needs the AST2700
  kernel fix linked there.

* Rebased onto current master, which is past the 11.1.0 release. v3 was on
  v11.1.0-rc3. The only conflict was hw/arm/Kconfig, where the UCD90320
  select landed next to the newly added ADC128D818 one.

* No other patch changed. Patches 1-3 and 5-7 are the v3 patches with
  only their numbering shifted.

Not addressed in this series:

* CFAM extended addressing (Miles): the mode where a single CFAM has 8MB
  rather than four cascaded CFAMs sharing that space. This changes the
  addressing model of the existing FSI/CFAM code rather than anything this
  series introduces, so it's left as follow-up work. It does bear on
  patch 2 though: the CFAM-S there aliases one 2MiB slot across the 8MiB
  window to fold the slave-ID views together, and if extended addressing
  is modelled properly that window is probably the wrong shape or should
  not exist at all.

* A functional test for the machine. The v1 test depended on non-public
  Huygens images and was dropped; it will be resent once images can be
  published.

Testing done:

* Whole series builds, and each of the 7 patches builds standalone.
* make check passes.
* huygens-bmc boots OpenBMC to the login prompt and multi-user target
  from FMC flash + UFS storage (internal images), with Jamin's I2C patch
  applied. The UCD90320 probes, reports its device identification over an
  SMBus block read, and the power sequencer publishes system power state.
* PCI UFS qtests pass (13/13), unchanged by patch 5.
* aspeed_fsi-test passes (4/4), unchanged by the CFAM patches.
* huygens-bmc, ast2700-evb and ast2600-evb all construct successfully.
* On huygens-bmc, the UFS version register reads 0x00000200, and the
  ufs-lu created by the board reports a 512-byte block size and passes it
  to its backing scsi-hd. The PCI ufs device with no property set still
  reports 4096.

Changes since v2 (unchanged from the v3 posting, for reference):

* UFS: rebased onto Jeuk Kim's restructure, as requested. The v2 core
  refactor (v2 patch 6) is dropped entirely, Jeuk's patch 1 supersedes it.
  hw/ufs/aspeed_ufs.c is now a subclass of TYPE_SYSBUS_UFS whose only
  AST2700-specific behavior is pinning the controller version register
  to 2.0, chained after the parent realize. MMIO, IRQ, DMA address space,
  properties, migration state and unrealize all come from the generic
  sysbus device, and the Aspeed type adds no instance fields.

  The two behaviors Huygens needs that the restructure does not provide
  are now their own patch, placed ahead of the Aspeed patch: the ufs-lu
  logical-block-size property (default unchanged, so the PCI device is
  unaffected) and the unmapped-LUN INQUIRY reporting "not connected"
  rather than failing the request. logical-block-size now also rejects
  non-powers-of-two, values outside 512..UFS_BLOCK_SIZE, and a drive
  shorter than one block, which would previously have realized a
  zero-block unit.

  The Aspeed SoC Kconfig now selects UFS_SYSBUS. It previously relied on
  UFS_PCI being enabled via "imply PCI_DEVICES".

* CFAM: dropped the State suffix from the instance struct names (Miles).
  FSICFAMCommonState becomes FSICFAMCommon; FSICFAMState, which predates
  this series, becomes FSICFAM to match rather than leaving the two
  spellings side by side in one header; FSICFAMSState becomes FSICFAMS.
  The FSI prefix is kept. The class structs keep their suffix, as is
  usual for QOM. Also fixed patch 1 to check the realize_engines() return
  value.

* Machine: reworded the commit message (Miles). No code change.

Note: checkpatch reports a couple of MAINTAINERS/SPDX warnings for the
new files; they are covered by existing wildcard entries in the ASPEED
and FSI sections.

Thank you again for all of the feedback.

Mikail Sadic (7):
  fsi/cfam: Add common CFAM base class
  fsi/cfam: Add CFAM-S model
  arm/aspeed: Wire AST2700 FSI controllers to APB-to-OPB bridges
  hw/sensor: Add UCD90320 model
  ufs: Make the logical block size configurable and answer absent LUNs
  ufs/aspeed: Add AST2700 UFS host controller
  arm/aspeed: Add AST2700 Huygens machine

 MAINTAINERS                     |   3 +
 docs/specs/aspeed-ufs.rst       |  46 ++++++
 docs/specs/fsi.rst              |  15 ++
 docs/specs/index.rst            |   2 +
 docs/specs/ucd90320.rst         |  36 +++++
 docs/system/arm/aspeed.rst      |  50 ++++++-
 hw/ufs/ufs.h                    |   3 +
 include/hw/arm/aspeed.h         |   1 +
 include/hw/arm/aspeed_soc.h     |   3 +
 include/hw/fsi/cfam-s.h         |  40 ++++++
 include/hw/fsi/cfam.h           |  68 ++++++++-
 include/hw/fsi/fsi-master.h     |   4 +-
 include/hw/fsi/lbus.h           |  11 ++
 include/hw/ufs/aspeed_ufs.h     |  15 ++
 hw/arm/aspeed.c                 |  25 ++++
 hw/arm/aspeed_ast27x0.c         |  31 ++++
 hw/arm/aspeed_ast27x0_huygens.c | 241 ++++++++++++++++++++++++++++++++
 hw/fsi/cfam-s.c                 |  91 ++++++++++++
 hw/fsi/cfam.c                   | 125 ++++++++++-------
 hw/fsi/fsi-master.c             |   9 +-
 hw/fsi/lbus.c                   |  69 +++++++++
 hw/sensor/ucd90320.c            | 169 ++++++++++++++++++++++
 hw/ufs/aspeed_ufs.c             |  67 +++++++++
 hw/ufs/lu.c                     |  67 ++++++++-
 hw/ufs/ufs.c                    |   2 +-
 hw/arm/Kconfig                  |   2 +
 hw/arm/meson.build              |   1 +
 hw/fsi/meson.build              |   2 +-
 hw/fsi/trace-events             |   2 +
 hw/sensor/Kconfig               |   4 +
 hw/sensor/meson.build           |   1 +
 hw/ufs/meson.build              |   1 +
 32 files changed, 1142 insertions(+), 64 deletions(-)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 docs/specs/ucd90320.rst
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/arm/aspeed_ast27x0_huygens.c
 create mode 100644 hw/fsi/cfam-s.c
 create mode 100644 hw/sensor/ucd90320.c
 create mode 100644 hw/ufs/aspeed_ufs.c


base-commit: 7a66901b243ca3b401db8a8e45245e0518339974
-- 
2.53.0


