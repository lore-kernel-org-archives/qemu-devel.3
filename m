Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDC5CEB2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 06:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKA8v-0006SO-DL; Sat, 15 Nov 2025 01:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA8t-0006Rr-BK
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:15 -0500
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA8p-0008Ki-Mn
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:13 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82AB6202BCD;
 Sat, 15 Nov 2025 07:52:08 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E8CA2013C7;
 Sat, 15 Nov 2025 07:52:08 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 73AD11800087;
 Sat, 15 Nov 2025 14:52:07 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv2 00/13] Adding comprehensive support for i.MX8MM EVK board
Date: Sat, 15 Nov 2025 12:20:46 +0530
Message-Id: <20251115065059.1884980-1-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Changes in v2:
- Fixed the DTB offset in functional testing script test_imx8mm_evk.py
  and preserved alphabetical order of machine names in tests/functional/aarch64/meson.build
- Fixed a typo and updated the documentation
- Modified structures type to static const in fsl-imx8mm.c wherever
  applicable.
- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk.c. This
  is needed because the default DTB in the iMX LF BSP images have CSI
  and DSI enabled. Developers/Hobbyists using these BSP images will
  observe CSI and DSI crash logs on the console since these are unimplemented.
  With this change, both debian and iMX LF images will boot up without any issues.

Changes in v1:

This patch series adds support for the NXP i.MX8MM EVK (Evaluation Kit)
board to QEMU, enabling emulation of this ARM Cortex-A53 based development
platform.

The series includes:

1. Core peripheral support (CCM clock controller, Analog module)
2. GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
3. GPIO,I2C,SPI,USDHC and USB Emulation support
4. PCIe and ENET Controller Emulation support
5. Documentation and functional test included

Key features ported:
- Basic boot support with Linux
- UART console for serial communication
- Interrupt handling
- Clock and power management infrastructure

Testing:
- Linux kernel boots to console

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Gaurav Sharma (13):
  hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
  hw/arm/fsl-imx8mm: Implemented CCM(Clock Control Module) and Analog IP
  hw/arm/fsl-imx8mm: Implemented support for SNVS
  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
  hw/arm/fsl-imx8mm: Add PCIe support
  hw/arm/fsl-imx8mm: Add GPIO controllers
  hw/arm/fsl-imx8mm: Adding support for I2C emulation
  hw/arm/fsl-imx8mm: Adding support for SPI controller
  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
  hw/arm/fsl-imx8mm: Adding support for USB controller
  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation

 docs/system/arm/imx8mm-evk.rst              |  62 ++
 docs/system/target-arm.rst                  |   1 +
 hw/arm/Kconfig                              |  24 +
 hw/arm/fsl-imx8mm.c                         | 687 ++++++++++++++++++++
 hw/arm/imx8mm-evk.c                         | 127 ++++
 hw/arm/meson.build                          |   2 +
 hw/misc/Kconfig                             |   6 +
 hw/misc/imx8mm_analog.c                     | 160 +++++
 hw/misc/imx8mm_ccm.c                        | 175 +++++
 hw/misc/meson.build                         |   2 +
 hw/timer/imx_gpt.c                          |  26 +
 include/hw/arm/fsl-imx8mm.h                 | 240 +++++++
 include/hw/misc/imx8mm_analog.h             |  81 +++
 include/hw/misc/imx8mm_ccm.h                |  30 +
 include/hw/timer/imx_gpt.h                  |   2 +
 tests/functional/aarch64/meson.build        |   2 +
 tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
 17 files changed, 1694 insertions(+)
 create mode 100644 docs/system/arm/imx8mm-evk.rst
 create mode 100644 hw/arm/fsl-imx8mm.c
 create mode 100644 hw/arm/imx8mm-evk.c
 create mode 100644 hw/misc/imx8mm_analog.c
 create mode 100644 hw/misc/imx8mm_ccm.c
 create mode 100644 include/hw/arm/fsl-imx8mm.h
 create mode 100644 include/hw/misc/imx8mm_analog.h
 create mode 100644 include/hw/misc/imx8mm_ccm.h
 create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py

-- 
2.34.1


