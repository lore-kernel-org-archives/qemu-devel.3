Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81106C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRnio-0001Lw-EQ; Wed, 18 Jun 2025 04:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uRnil-0001Ke-I8; Wed, 18 Jun 2025 04:00:35 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uRnii-0006A3-Vz; Wed, 18 Jun 2025 04:00:35 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 18 Jun
 2025 16:00:06 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 18 Jun 2025 16:00:06 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/2] hw/misc/aspeed_scu: Support the Frequency Counter
 Control register for AST2700
Date: Wed, 18 Jun 2025 16:00:05 +0800
Message-ID: <20250618080006.846355-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618080006.846355-1-jamin_lin@aspeedtech.com>
References: <20250618080006.846355-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the datasheet:
BIT[1] (SCU_FREQ_OSC_EN) enables the oscillator frequency measurement counter.
BIT[6] (SCU_FREQ_DONE) indicates the measurement is finished.
Firmware polls BIT[6] to determine when measurement is complete.
The flag can be cleared by writing BIT[1] to 0.

To simulate this hardware behavior in QEMU:
If BIT[1] is set to 1, BIT[6] is immediately set to 1 to avoid
firmware hanging during polling.
If BIT[1] is cleared to 0, BIT[6] is also cleared to 0 to match
hardware semantics.

The initial value of this register is initialized to 0x80, reflecting the
default value confirmed from an EVB register dump.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_scu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 4930e00fed..11d0739108 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -176,6 +176,7 @@
 #define AST2700_SCUIO_UARTCLK_GEN       TO_REG(0x330)
 #define AST2700_SCUIO_HUARTCLK_GEN      TO_REG(0x334)
 #define AST2700_SCUIO_CLK_DUTY_MEAS_RST TO_REG(0x388)
+#define AST2700_SCUIO_FREQ_CNT_CTL      TO_REG(0x3A0)
 
 #define SCU_IO_REGION_SIZE 0x1000
 
@@ -1022,6 +1023,10 @@ static void aspeed_ast2700_scuio_write(void *opaque, hwaddr offset,
         s->regs[reg - 1] ^= data;
         updated = true;
         break;
+    case AST2700_SCUIO_FREQ_CNT_CTL:
+        s->regs[reg] = deposit32(s->regs[reg], 6, 1, !!(data & BIT(1)));
+        updated = true;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
@@ -1066,6 +1071,7 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCUIO_UARTCLK_GEN]         = 0x00014506,
     [AST2700_SCUIO_HUARTCLK_GEN]        = 0x000145c0,
     [AST2700_SCUIO_CLK_DUTY_MEAS_RST]   = 0x0c9100d2,
+    [AST2700_SCUIO_FREQ_CNT_CTL]        = 0x00000080,
 };
 
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


