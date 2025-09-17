Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A88CAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh1h-00069N-2a; Tue, 16 Sep 2025 21:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1b-00067z-VT; Tue, 16 Sep 2025 21:32:01 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1U-0006vf-2B; Tue, 16 Sep 2025 21:31:59 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 09:31:43 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 09:31:43 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v1 0/6] hw/arm/aspeed: AST1700 IO expander support for AST27x0
 (LTPI, UART, IRQ, I2C)
Date: Wed, 17 Sep 2025 09:31:35 +0800
Message-ID: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series adds support for AST1700-based IO expander boards on the
ASPEED AST27x0 family and wires them into the machine models. It
introduces an LTPI controller, adds a machine property to select how
many expanders are present, and connects the expander-provided UART,
interrupt controller, and I2C blocks.

What this series does

- Add a new `ioexps-num` machine property (range 0-2; default 0) so
  boards can declare how many expanders are attached without changing
  defaults.
- Add an LTPI controller device used by the expander/board glue.
- Add the AST1700 IO expander device model.
- Wire up the expander UART, interrupt controllers, and I2C on AST27x0
  machines.

Example usage:
  ./qemu-system-aarch64 -M ast2700a1-evb,ioexps-num=2 \
    -drive file=image-bmc,format=raw,if=mtd \
    ...


Verification:

U-Boot:
=> ltpi
LTPI0:
    link partner    : ast1700
    link mode       : DDR
    link bandwidth  : 25Mbps
LTPI1:
    link partner    : ast1700
    link mode       : DDR
    link bandwidth  : 25Mbps
=>

Linux (BMC):
root@ast2700-default:~# i2cdetect -y 16
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

With `ioexps-num` left at 0, existing behavior is unchanged.

Any feedback or suggestions are appreciated.

Best Regards,
Kane
---
Kane-Chen-AS (6):
  hw/arm/aspeed: Add 'ioexps-num' property for AST27x0
  hw/arm/aspeed: Add LTPI controller
  hw/arm/aspeed: Add AST1700 IO expander
  hw/arm/aspeed: Model AST1700 IO expander UART on AST27x0
  hw/arm/aspeed: Model AST1700 IO expander interrupt controllers on
    AST27x0
  hw/arm/aspeed: Model AST1700 IO expander I2C on AST27x0

 include/hw/arm/aspeed_soc.h   |  32 +++++-
 include/hw/intc/aspeed_intc.h |   2 +
 include/hw/misc/aspeed_ltpi.h |  25 +++++
 hw/arm/aspeed.c               |  49 +++++++++
 hw/arm/aspeed_ast27x0.c       | 184 ++++++++++++++++++++++++++++++++--
 hw/intc/aspeed_intc.c         |  60 +++++++++++
 hw/misc/aspeed_ltpi.c         | 111 ++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 8 files changed, 452 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/misc/aspeed_ltpi.h
 create mode 100644 hw/misc/aspeed_ltpi.c

-- 
2.43.0


