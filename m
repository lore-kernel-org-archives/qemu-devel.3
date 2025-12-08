Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC89D3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVvQ-0006lI-N6; Mon, 08 Dec 2025 02:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvO-0006kn-Fu; Mon, 08 Dec 2025 02:44:50 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvM-0008LH-52; Mon, 08 Dec 2025 02:44:50 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:37 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 00/18] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Date: Mon, 8 Dec 2025 15:44:12 +0800
Message-ID: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Hi all,

LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM
2.0 specification (see Figure 2):
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf

LTPI provides a protocol and physical interface for tunneling various
low-speed signals between the Host Processor Module (HPM) and the
Satellite Controller Module (SCM). In Figure 2 of the specification,
the AST27x0 SoC (left) integrates two LTPI controllers, allowing it to
connect to up to two AST1700 boards. On the other side, the AST1700
consolidates HPM FPGA functions and multiple peripheral interfaces
(GPIO, UART, I2C, I3C, etc.) onto a single board.

Because the AST1700 exposes additional I/O interfaces (GPIO, I2C, I3C,
and others), it acts as an I/O expander. Once connected over LTPI,
the AST27x0 can control additional downstream devices through this link.

This patch series is based on the SGPIO changes:
https://lore.kernel.org/qemu-devel/20251106-aspeed-sgpio-v1-0-b026093716fa@google.com/

It introduces a basic LTPI controller model and wires it into the
AST27x0 SoC. The series also adds the AST1700-specific LTPI expander
device and incrementally connects common peripherals on the AST1700
model. For the I3C block, which may cause kernel crashes, its MMIO
region is modeled as an unimplemented device to reserve address space
and make the missing functionality explicit, ensuring stable guest
probing.

In the official release images, the AST1700 functions are not included
by default. To test the AST1700-related functionality, please include
the following DTS files for probing:
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi0.dtsi
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi1.dtsi

After including these DTS files in the BMC image, you can verify LTPI
functionality using the following scenarios:

1. In U-Boot:
   Run the ltpi command to trigger the LTPI connection and display the
   current connection status.
2. In BMC Linux:
   Run i2cdetect -y <16-38> to scan and test the I2C buses exposed by
   the AST1700.

Any feedback or suggestions are appreciated!

Kane

---

ChangeLog
---------
v3:
- Add PWM model
- Integrate the SGPIO model
- Fix I2C test case failure
- Refine code structure

v2:
- Separate the AST1700 model into a standalone implementation
- Refine the mechanism for assigning the AST1700 board number

v1:
- Initial version
---

Kane-Chen-AS (18):
  hw/misc: Add LTPI controller
  hw/arm/aspeed: Attach LTPI controller to AST27X0 platform
  hw/misc: Add basic Aspeed PWM model
  hw/arm/aspeed: Add AST1700 LTPI expander device model
  hw/arm/aspeed: Integrate AST1700 device into AST27X0
  hw/arm/aspeed: Integrate interrupt controller for AST1700
  hw/arm/aspeed: Attach LTPI controller to AST1700 model
  hw/arm/aspeed: Attach UART device to AST1700 model
  hw/arm/aspeed: Attach SRAM device to AST1700 model
  hw/arm/aspeed: Attach SPI device to AST1700 model
  hw/arm/aspeed: Attach ADC device to AST1700 model
  hw/arm/aspeed: Attach SCU device to AST1700 model
  hw/arm/aspeed: Attach GPIO device to AST1700 model
  hw/arm/aspeed: attach I2C device to AST1700 model
  hw/arm/aspeed: Attach WDT device to AST1700 model
  hw/arm/aspeed: Attach PWM device to AST1700 model
  hw/arm/aspeed: Attach SGPIOM device to AST1700 model
  hw/arm/aspeed: Model AST1700 I3C block as unimplemented device

 include/hw/arm/aspeed_ast1700.h |  53 +++++++
 include/hw/arm/aspeed_soc.h     |  25 ++-
 include/hw/i2c/aspeed_i2c.h     |   1 +
 include/hw/intc/aspeed_intc.h   |   2 +
 include/hw/misc/aspeed_ltpi.h   |  32 ++++
 include/hw/misc/aspeed_pwm.h    |  31 ++++
 hw/arm/aspeed_ast1700.c         | 269 ++++++++++++++++++++++++++++++++
 hw/arm/aspeed_ast27x0.c         | 163 +++++++++++++++++--
 hw/i2c/aspeed_i2c.c             |  19 ++-
 hw/intc/aspeed_intc.c           |  60 +++++++
 hw/misc/aspeed_ltpi.c           | 194 +++++++++++++++++++++++
 hw/misc/aspeed_pwm.c            | 121 ++++++++++++++
 hw/arm/meson.build              |   1 +
 hw/misc/meson.build             |   2 +
 hw/misc/trace-events            |   4 +
 15 files changed, 957 insertions(+), 20 deletions(-)
 create mode 100644 include/hw/arm/aspeed_ast1700.h
 create mode 100644 include/hw/misc/aspeed_ltpi.h
 create mode 100644 include/hw/misc/aspeed_pwm.h
 create mode 100644 hw/arm/aspeed_ast1700.c
 create mode 100644 hw/misc/aspeed_ltpi.c
 create mode 100644 hw/misc/aspeed_pwm.c

-- 
2.43.0


