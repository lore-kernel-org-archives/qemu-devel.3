Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FCCEA810B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpme6-0000ss-Tj; Tue, 10 Feb 2026 07:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmdy-0000k4-Ts; Tue, 10 Feb 2026 07:15:02 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmdw-0008Re-Nm; Tue, 10 Feb 2026 07:15:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E52BB187DA1;
 Tue, 10 Feb 2026 15:13:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 829E5360CC3;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 63/78] hw/i2c/aspeed_i2c: Fix DMA moving data into
 incorrect address
Date: Tue, 10 Feb 2026 15:14:16 +0300
Message-ID: <20260210121438.67781-7-mjt@tls.msk.ru>
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

In the previous design, the I2C model updated dma_dram_offset only when
firmware programmed the RX/TX DMA buffer address registers. The firmware
used to rewrite these registers before issuing each DMA command.

The firmware driver behavior has changed to program the DMA address
registers only once during I2C initialization. As a result, the I2C model
no longer refreshes dma_dram_offset, causing DMA to move data into an
incorrect DRAM address.

Fix this by introducing helper functions to update dma_dram_offset from
the DMA address registers, and invoke them right before handling TX/RX
DMA operations. This guarantees DMA always uses the correct buffer
address even if the registers are programmed only once.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: c400c38854017eeccda63115814eba4c3ef2b51f ("hw/i2c/aspeed: Introduce a new dma_dram_offset attribute in AspeedI2Cbus")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260203020855.1642884-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit efea7ddb4689a1ac4bce63a9ddb32887c7f3ac50)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 93b8fd1661..c48fa2050b 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -116,8 +116,6 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
             value = -1;
             break;
         }
-
-        value = extract64(bus->dma_dram_offset, 0, 32);
         break;
     case A_I2CD_DMA_LEN:
         if (!aic->has_dma) {
@@ -221,6 +219,64 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
     return SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CD_CMD, TX_STATE);
 }
 
+/*
+ * The AST2700 support the maximum DRAM size is 8 GB.
+ * The DRAM offset range is from 0x0_0000_0000 to
+ * 0x1_FFFF_FFFF and it is enough to use bits [33:0]
+ * saving the dram offset.
+ * Therefore, save the high part physical address bit[1:0]
+ * of Tx/Rx buffer address as dma_dram_offset bit[33:32].
+ */
+static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)
+{
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+    uint32_t value;
+
+    assert(aic->has_dma);
+
+    if (aspeed_i2c_is_new_mode(bus->controller)) {
+        value = bus->regs[R_I2CM_DMA_TX_ADDR];
+        bus->dma_dram_offset =
+            deposit64(bus->dma_dram_offset, 0, 32,
+                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
+        if (!aic->has_dma64) {
+            value = bus->regs[R_I2CM_DMA_TX_ADDR_HI];
+            bus->dma_dram_offset =
+                deposit64(bus->dma_dram_offset, 32, 32,
+                          extract32(value, 0, 2));
+        }
+    } else {
+        value = bus->regs[R_I2CD_DMA_ADDR];
+        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
+                                         value & 0x3ffffffc);
+    }
+}
+
+static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)
+{
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+    uint32_t value;
+
+    assert(aic->has_dma);
+
+    if (aspeed_i2c_is_new_mode(bus->controller)) {
+        value = bus->regs[R_I2CM_DMA_RX_ADDR];
+        bus->dma_dram_offset =
+            deposit64(bus->dma_dram_offset, 0, 32,
+                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
+        if (!aic->has_dma64) {
+            value = bus->regs[R_I2CM_DMA_RX_ADDR_HI];
+            bus->dma_dram_offset =
+                deposit64(bus->dma_dram_offset, 32, 32,
+                          extract32(value, 0, 2));
+        }
+    } else {
+        value = bus->regs[R_I2CD_DMA_ADDR];
+        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
+                                         value & 0x3ffffffc);
+    }
+}
+
 static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
 {
     MemTxResult result;
@@ -270,6 +326,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
         if (aspeed_i2c_is_new_mode(bus->controller)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);
         }
+        aspeed_i2c_set_tx_dma_dram_offset(bus);
         while (bus->regs[reg_dma_len]) {
             uint8_t data;
             ret = aspeed_i2c_dma_read(bus, &data);
@@ -335,6 +392,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);
         }
 
+        aspeed_i2c_set_rx_dma_dram_offset(bus);
         while (bus->regs[reg_dma_len]) {
             MemTxResult result;
 
@@ -401,6 +459,7 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
         uint8_t data;
 
+        aspeed_i2c_set_tx_dma_dram_offset(bus);
         aspeed_i2c_dma_read(bus, &data);
         return data;
     } else {
@@ -657,16 +716,10 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CM_DMA_TX_ADDR:
         bus->regs[R_I2CM_DMA_TX_ADDR] = FIELD_EX32(value, I2CM_DMA_TX_ADDR,
                                                    ADDR);
-        bus->dma_dram_offset =
-            deposit64(bus->dma_dram_offset, 0, 32,
-                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
         break;
     case A_I2CM_DMA_RX_ADDR:
         bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
                                                    ADDR);
-        bus->dma_dram_offset =
-            deposit64(bus->dma_dram_offset, 0, 32,
-                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
         break;
     case A_I2CM_DMA_LEN:
         w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
@@ -748,15 +801,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         qemu_log_mask(LOG_UNIMP, "%s: Slave mode DMA TX is not implemented\n",
                       __func__);
         break;
-
-    /*
-     * The AST2700 support the maximum DRAM size is 8 GB.
-     * The DRAM offset range is from 0x0_0000_0000 to
-     * 0x1_FFFF_FFFF and it is enough to use bits [33:0]
-     * saving the dram offset.
-     * Therefore, save the high part physical address bit[1:0]
-     * of Tx/Rx buffer address as dma_dram_offset bit[33:32].
-     */
     case A_I2CM_DMA_TX_ADDR_HI:
         if (!aic->has_dma64) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
@@ -766,8 +810,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->regs[R_I2CM_DMA_TX_ADDR_HI] = FIELD_EX32(value,
                                                       I2CM_DMA_TX_ADDR_HI,
                                                       ADDR_HI);
-        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
-                                         extract32(value, 0, 2));
         break;
     case A_I2CM_DMA_RX_ADDR_HI:
         if (!aic->has_dma64) {
@@ -778,8 +820,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->regs[R_I2CM_DMA_RX_ADDR_HI] = FIELD_EX32(value,
                                                       I2CM_DMA_RX_ADDR_HI,
                                                       ADDR_HI);
-        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
-                                         extract32(value, 0, 2));
         break;
     case A_I2CS_DMA_TX_ADDR_HI:
         qemu_log_mask(LOG_UNIMP,
@@ -795,8 +835,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->regs[R_I2CS_DMA_RX_ADDR_HI] = FIELD_EX32(value,
                                                       I2CS_DMA_RX_ADDR_HI,
                                                       ADDR_HI);
-        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
-                                         extract32(value, 0, 2));
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
@@ -887,9 +925,6 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
             break;
         }
-
-        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
-                                         value & 0x3ffffffc);
         break;
 
     case A_I2CD_DMA_LEN:
-- 
2.47.3


