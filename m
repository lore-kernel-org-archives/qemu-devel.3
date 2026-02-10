Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8691BEA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpme6-0000sA-5e; Tue, 10 Feb 2026 07:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmdu-0000iQ-ST; Tue, 10 Feb 2026 07:14:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmds-0008Qs-Bw; Tue, 10 Feb 2026 07:14:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D315E187DA0;
 Tue, 10 Feb 2026 15:13:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 70604360CC2;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 62/78] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Date: Tue, 10 Feb 2026 15:14:15 +0300
Message-ID: <20260210121438.67781-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

In the previous design, the I2C model would update I2CC_DMA_LEN (0x54) based on
the value of I2CM_DMA_LEN (0x1C) when the firmware set either I2CM_DMA_TX_ADDR
(0x30) or I2CM_DMA_RX_ADDR (0x34). However, this only worked correctly if the
firmware set I2CM_DMA_LEN before setting I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR.

If the firmware instead set I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR before setting
I2CM_DMA_LEN, the value written to I2CC_DMA_LEN would be incorrect.

To fix this issue, the model should be updated to set I2CC_DMA_LEN when the
firmware writes to the I2CM_DMA_LEN register, rather than when it writes to the
I2CM_DMA_RX_ADDR and I2CM_DMA_TX_ADDR registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: ba2cccd64e90 ("aspeed: i2c: Add new mode support")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260102090746.1130033-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 9cbd8ee7f67fceee51d3c993a282e5adc397b6b9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 765a98b698..93b8fd1661 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -660,8 +660,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
-        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
-                                                     TX_BUF_LEN) + 1;
         break;
     case A_I2CM_DMA_RX_ADDR:
         bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
@@ -669,8 +667,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
                       FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
-        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
-                                                     RX_BUF_LEN) + 1;
         break;
     case A_I2CM_DMA_LEN:
         w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
@@ -683,10 +679,16 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         if (FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN, RX_BUF_LEN,
                              FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN));
+            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
+                                                         I2CM_DMA_LEN,
+                                                         RX_BUF_LEN) + 1;
         }
         if (FIELD_EX32(value, I2CM_DMA_LEN, TX_BUF_LEN_W1T)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN, TX_BUF_LEN,
                              FIELD_EX32(value, I2CM_DMA_LEN, TX_BUF_LEN));
+            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
+                                                         I2CM_DMA_LEN,
+                                                         TX_BUF_LEN) + 1;
         }
         break;
     case A_I2CM_DMA_LEN_STS:
-- 
2.47.3


