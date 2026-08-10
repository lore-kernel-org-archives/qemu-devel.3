Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D7CC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVCc-0001VT-1G; Mon, 10 Aug 2026 14:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCa-0001UK-6y; Mon, 10 Aug 2026 14:58:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCX-0003Rg-Mr; Mon, 10 Aug 2026 14:58:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGVtnu292855; Mon, 10 Aug 2026 18:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=PFUdvod4578KlAlJNW9b3M3Pi3m3
 giB2+fWB54jkGMo=; b=Uf/HNSYrsH2xODMiU2mu6KXy4+c+DFHR693j09mjDsQG
 2CZWaLDbOGbjjWQmZi70MmRKuAUhFoX2NMMCqzjVt1heeuoRQ5BEpA1A4qALGKZt
 M27epZHON0fyTgkDZm6ExDtYUVZMzVay6r14HLqGd0FPX5trUwcBH8QQC90SrPhP
 EFZnsW62lTFjUan6UWKRRZ+FuJDzTs3jK9qqd10GlbzhCzrBMqVVB2h6h871j7Yn
 IhWx+/QO6WLpYz/hXfnwM+o25bmSaeQaePvGYJH1zER4hzd2eCaP2sYl9NAqWsPH
 qJui+bg3L+KcKbMjq6XG14C5yRl3E3f8X+voHq3rCw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysmk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIuMTx019224;
 Mon, 10 Aug 2026 18:57:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gx00h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvDON24773210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 206605805A;
 Mon, 10 Aug 2026 18:57:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D631C58051;
 Mon, 10 Aug 2026 18:57:49 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:49 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] Add IBM Huygens BMC machine for AST2700
Date: Mon, 10 Aug 2026 13:57:38 -0500
Message-ID: <20260810185748.1253-1-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfXxeLHWpiRBbEq
 oiFhbf/DkFSYckkMb3JNG0ujq09gUd2h+LDmhAl+zKdl2IgBg5Qhrr72ie6J3WMZTJfKrjIPvs1
 dhc1tFbL7INH7qTZL/uHMoORK4SWEfaSkFSt5qew1pBrWTYEFHNCTtRsHVcpytRFaskbTj/4poj
 vCPbYzXEU+WDV49fD0FUgZJxqeehe05FYaLNh7CCY0uIPME+ONzSPkTZw6tj3e/xi2/L2SLhUB7
 J8Yz4TaEvPsJ5SyzuT/naAmrWzT+YnbU67BqREkFB996oJsCJKHHtU1LN7GdjVB42onvhhBhC2J
 +f1HllCWKwRMVgEYIhHGe7MkSqAIfn4kfMMxKh/ISgL2Mnn/gaccaf91I4AWgBiSiSDJNfqFWkT
 cOTSGdZ1HcevSJs46Kd6lRtvClt5wk9WLf9GExe+8LVqftMhTVuzVsZ1/WH/frrvwlEPNxone7x
 4+rS9WAc5mAXqqkjTVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX3alKqsNWQRNW
 FzvO4JkkfpZtpsIF2ZIVGOedYmHpkXuUUj5LOugQDgXsCfajS6rIngcseMhZNOjxrXD6wD1vLvp
 Vde0DLF7w2G38KRNHg+Et3Ch3ka8OBg=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a1f32 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=hD80L64hAAAA:8 a=16UY8-0HC6ZX7w77xpQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wB_UmNl3naz7uaAHLYclm0b5_DhQ29rc
X-Proofpoint-ORIG-GUID: w91KTs4U0Au0hTGEzTPKDW439jAJc_rh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100158
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
controllers to their APB-to-OPB bridges, fixes an aspeed I2C DMA
block-read corner case, adds a TI UCD90320 PMBus power-sequencer model,
adds an AST2700 UFS host controller on top of the generic sysbus UFS
device, and finally adds the huygens-bmc machine that ties these together
to boot OpenBMC from FMC flash and a UFS root filesystem.

Dependency: this series applies on top of Jeuk Kim's UFS restructure,
which is on-list but not yet merged:

  https://lore.kernel.org/qemu-devel/cover.1786096976.git.jeuk20.kim@samsung.com/

The base-commit trailer below therefore names a local commit that is
v11.1.0-rc3 (3e3ccab106) plus those two patches. Patches 6 and 7 need
it, patches 1-5 and 8 do not.

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
  6. ufs: a configurable logical-block-size on ufs-lu, and an unmapped LUN
     answering INQUIRY as "not connected". The ufs PCI device keeps its
     current property set and geometry.
  7. ufs/aspeed: the AST2700 UFS host controller as a subclass of
     TYPE_SYSBUS_UFS, adding only the UFSHCI version.
  8. arm/aspeed: the huygens-bmc machine.

Changes since v2:

* UFS: rebased onto Jeuk Kim's restructure, as requested. The v2 core
  refactor (v2 patch 6) is dropped entirely, Jeuk's patch 1 supersedes it.
  hw/ufs/aspeed_ufs.c is now a subclass of TYPE_SYSBUS_UFS whose only
  AST2700-specific behavior is pinning the controller version register
  to 2.0, chained after the parent realize. MMIO, IRQ, DMA address space,
  properties, migration state and unrealize all come from the generic
  sysbus device, and the Aspeed type adds no instance fields.

  The two behaviors Huygens needs that the restructure does not provide
  are now their own patch (6), placed ahead of the Aspeed patch: the
  ufs-lu logical-block-size property (default unchanged, so the PCI
  device is unaffected) and the unmapped-LUN INQUIRY reporting "not
  connected" rather than failing the request. logical-block-size now also
  rejects non-powers-of-two, values outside 512..UFS_BLOCK_SIZE, and a
  drive shorter than one block, which would previously have realized a
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

* Rebased onto v11.1.0-rc3.

Not addressed in this series:

* CFAM extended addressing (Miles): the mode where a single CFAM has 8MB
  rather than four cascaded CFAMs sharing that space. This changes the
  addressing model of the existing FSI/CFAM code rather than anything this
  series introduces, so it's left it as follow-up work. It does bear on
  patch 2 though: the CFAM-S there aliases one 2MiB slot across the 8MiB
  window to fold the slave-ID views together, and if extended addressing
  is modelled properly that window is probably the wrong shape or should
  not exist at all. I am happy to take direction on whether to do that
  first.

Testing done:

* Whole series builds, and each of the 8 patches builds standalone.
* make check passes.
* huygens-bmc boots OpenBMC to the login prompt and multi-user target
  from FMC flash + UFS storage (internal images).
* PCI UFS qtests pass (13/13), unchanged by patch 6.
* aspeed_fsi-test passes (4/4), unchanged by the CFAM patches.
* huygens-bmc, ast2700-evb and ast2600-evb all construct successfully.
* On huygens-bmc, the UFS version register reads 0x00000200, and the
  ufs-lu created by the board reports a 512-byte block size and passes it
  to its backing scsi-hd. The PCI ufs device with no property set still
  reports 4096.

Changes since v1 (unchanged from the v2 posting, for reference):

* Split the original 5 commits into 8. The aspeed I2C DMA fix, the FSI
  controller wiring, the CFAM common base class, and the UFS
  core-vs-frontend split are now separate patches (each buildable on its
  own).

* UFS: reworked per review (Jeuk Kim). Instead of a second, standalone
  UFS implementation, the common core was separated from the PCI glue so
  the AST2700 controller could be a thin sysbus frontend on top of it.
  (Superseded in v3 - see above.)

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

Note: checkpatch reports a couple of MAINTAINERS/SPDX warnings for the
new files; they are covered by existing wildcard entries in the ASPEED
and FSI sections.

Thank you again for all of the feedback.

Mikail Sadic (8):
  fsi/cfam: Add common CFAM base class
  fsi/cfam: Add CFAM-S model
  arm/aspeed: Wire AST2700 FSI controllers to APB-to-OPB bridges
  i2c/aspeed: Fix DMA receive first-byte handling for block reads
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
 hw/i2c/aspeed_i2c.c             |   7 +
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
 33 files changed, 1149 insertions(+), 64 deletions(-)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 docs/specs/ucd90320.rst
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/arm/aspeed_ast27x0_huygens.c
 create mode 100644 hw/fsi/cfam-s.c
 create mode 100644 hw/sensor/ucd90320.c
 create mode 100644 hw/ufs/aspeed_ufs.c

base-commit: 8c9baa57b781ae86330ba036415a768da12d9b28

-- 
2.53.0


