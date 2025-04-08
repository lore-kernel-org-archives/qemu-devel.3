Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEFBC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u24Gm-00041v-25; Tue, 08 Apr 2025 04:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u24Gj-00041X-1B; Tue, 08 Apr 2025 04:25:17 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u24Gg-0000Y5-3s; Tue, 08 Apr 2025 04:25:16 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 8 Apr
 2025 16:25:05 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 8 Apr 2025 16:25:05 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Date: Tue, 8 Apr 2025 16:25:04 +0800
Message-ID: <20250408082504.3060742-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

In the previous design, the I2C model would update I2CC_DMA_LEN (0x54) based on
the value of I2CM_DMA_LEN (0x1C) when the firmware set either I2CM_DMA_TX_ADDR
(0x30) or I2CM_DMA_RX_ADDR (0x34). However, this only worked correctly if the
firmware set I2CM_DMA_LEN before setting I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR.

If the firmware instead set I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR before setting
I2CM_DMA_LEN, the value written to I2CC_DMA_LEN would be incorrect.

Ideally, this issue should be resolved by updating the model to set
I2CC_DMA_LEN (0x54) when the firmware writes to the I2CM_DMA_LEN (0x1C)
register, instead of when it writes to I2CM_DMA_TX_ADDR (0x30) or
I2CM_DMA_RX_ADDR (0x34).

Originally, the design of I2CM_DMA_LEN (0x1C) included buffer length
write-enable bits for the current command:
Bit 31 enabled the RX buffer length update
Bit 15 enabled the TX buffer length update

In other words, when the firmware set either bit 31 or bit 15, the I2C model
could safely update I2CC_DMA_LEN (0x54) with the value in I2CM_DMA_LEN (0x1C).

However, starting with the AST2700, the design of the I2CM_DMA_LEN (0x1C)
register was changed. The write-enable bits (bit 31 and bit 15) were removed,
meaning there is no longer an explicit indication of whether the firmware
intends to update the TX or RX length.

As a result, on AST2700 and newer SoCs, the model cannot reliably determine
whether a write to I2CM_DMA_LEN was meant for TX or RX. This ambiguity is
especially problematic when the value written is 0, which actually corresponds
to a DMA length of 1.

To ensure consistent behavior across all SoCs, the model now updates
I2CC_DMA_LEN when I2CM_CMD (0x18) is written, as this is the final command that
initiates a TX or RX transfer and reflects the firmware’s intent more clearly.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: ba2cccd (aspeed: i2c: Add new mode support)
---
 hw/i2c/aspeed_i2c.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a8fbb9f44a..c659099e9a 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -634,6 +634,20 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
             break;
         }
 
+        /* Handle DMA length */
+        if (SHARED_FIELD_EX32(value, TX_DMA_EN) &&
+            SHARED_FIELD_EX32(value, M_TX_CMD)) {
+            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
+                                                         I2CM_DMA_LEN,
+                                                         TX_BUF_LEN) + 1;
+        }
+        if (SHARED_FIELD_EX32(value, RX_DMA_EN) &&
+            SHARED_FIELD_EX32(value, M_RX_CMD)) {
+            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
+                                                         I2CM_DMA_LEN,
+                                                         RX_BUF_LEN) + 1;
+        }
+
         if (bus->regs[R_I2CM_INTR_STS] & 0xffff0000) {
             qemu_log_mask(LOG_UNIMP, "%s: Packet mode is not implemented\n",
                           __func__);
@@ -656,8 +670,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
-        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
-                                                     TX_BUF_LEN) + 1;
         break;
     case A_I2CM_DMA_RX_ADDR:
         bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
@@ -665,8 +677,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
-        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
-                                                     RX_BUF_LEN) + 1;
         break;
     case A_I2CM_DMA_LEN:
         w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
-- 
2.43.0


