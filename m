Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF90C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 02:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbtDi-0007OY-0O; Wed, 07 Aug 2024 22:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sbtDf-0007G1-Vl; Wed, 07 Aug 2024 22:49:39 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sbtDe-0008AE-6y; Wed, 07 Aug 2024 22:49:39 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 8 Aug
 2024 10:49:17 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 8 Aug 2024 10:49:17 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v2 04/11] hw/i2c/aspeed: introduce a new dma_dram_offset
 attribute in AspeedI2Cbus
Date: Thu, 8 Aug 2024 10:49:09 +0800
Message-ID: <20240808024916.1262715-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The "Current DMA Operating Address Status(0x50)" register of
I2C new mode has been removed in AST2700.
This register is used for debugging and it is a read only register.

To support AST2700 DMA mode, introduce a new
dma_dram_offset class attribute in AspeedI2Cbus to save the
current DMA operating address.

ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
And the base address of dram is "0x4 00000000" which
is 64bits address.

Set the dma_dram_offset data type to uint64_t for
64 bits dram address DMA support.

Both "DMA Mode Buffer Address Register(I2CD24 old mode)" and
"DMA Operating Address Status (I2CC50 new mode)" are used for showing the
low part dram offset bits [31:0], so change to read/write both register bits [31:0] in
bus register read/write functions.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/i2c/aspeed_i2c.c         | 51 +++++++++++++++++++++++--------------
 include/hw/i2c/aspeed_i2c.h |  9 +------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index abcb1d5330..2dea3a42a0 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -114,7 +114,10 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
             value = -1;
+            break;
         }
+
+        value = extract64(bus->dma_dram_offset, 0, 32);
         break;
     case A_I2CD_DMA_LEN:
         if (!aic->has_dma) {
@@ -150,9 +153,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CM_DMA_TX_ADDR:
     case A_I2CM_DMA_RX_ADDR:
     case A_I2CM_DMA_LEN_STS:
-    case A_I2CC_DMA_ADDR:
     case A_I2CC_DMA_LEN:
-
     case A_I2CS_DEV_ADDR:
     case A_I2CS_DMA_RX_ADDR:
     case A_I2CS_DMA_LEN:
@@ -161,6 +162,9 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CS_DMA_LEN_STS:
         /* Value is already set, don't do anything. */
         break;
+    case A_I2CC_DMA_ADDR:
+        value = extract64(bus->dma_dram_offset, 0, 32);
+        break;
     case A_I2CS_INTR_STS:
         break;
     case A_I2CM_CMD:
@@ -210,18 +214,18 @@ static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
 {
     MemTxResult result;
     AspeedI2CState *s = bus->controller;
-    uint32_t reg_dma_addr = aspeed_i2c_bus_dma_addr_offset(bus);
     uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
 
-    result = address_space_read(&s->dram_as, bus->regs[reg_dma_addr],
+    result = address_space_read(&s->dram_as, bus->dma_dram_offset,
                                 MEMTXATTRS_UNSPECIFIED, data, 1);
     if (result != MEMTX_OK) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM read failed @%08x\n",
-                      __func__, bus->regs[reg_dma_addr]);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: DRAM read failed @%" PRIx64 "\n",
+                      __func__, bus->dma_dram_offset);
         return -1;
     }
 
-    bus->regs[reg_dma_addr]++;
+    bus->dma_dram_offset++;
     bus->regs[reg_dma_len]--;
     return 0;
 }
@@ -291,7 +295,6 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
     uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
     uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
     uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
-    uint32_t reg_dma_addr = aspeed_i2c_bus_dma_addr_offset(bus);
     int pool_rx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
                                                 RX_SIZE) + 1;
 
@@ -323,14 +326,17 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
             data = i2c_recv(bus->bus);
             trace_aspeed_i2c_bus_recv("DMA", bus->regs[reg_dma_len],
                                       bus->regs[reg_dma_len], data);
-            result = address_space_write(&s->dram_as, bus->regs[reg_dma_addr],
+
+            result = address_space_write(&s->dram_as, bus->dma_dram_offset,
                                          MEMTXATTRS_UNSPECIFIED, &data, 1);
             if (result != MEMTX_OK) {
-                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM write failed @%08x\n",
-                              __func__, bus->regs[reg_dma_addr]);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: DRAM write failed @%" PRIx64 "\n",
+                              __func__, bus->dma_dram_offset);
                 return;
             }
-            bus->regs[reg_dma_addr]++;
+
+            bus->dma_dram_offset++;
             bus->regs[reg_dma_len]--;
             /* In new mode, keep track of how many bytes we RXed */
             if (aspeed_i2c_is_new_mode(bus->controller)) {
@@ -636,14 +642,18 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CM_DMA_TX_ADDR:
         bus->regs[R_I2CM_DMA_TX_ADDR] = FIELD_EX32(value, I2CM_DMA_TX_ADDR,
                                                    ADDR);
-        bus->regs[R_I2CC_DMA_ADDR] = FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR);
+        bus->dma_dram_offset =
+            deposit64(bus->dma_dram_offset, 0, 32,
+                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
         bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
                                                      TX_BUF_LEN) + 1;
         break;
     case A_I2CM_DMA_RX_ADDR:
         bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
                                                    ADDR);
-        bus->regs[R_I2CC_DMA_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR);
+        bus->dma_dram_offset =
+            deposit64(bus->dma_dram_offset, 0, 32,
+                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
         bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
                                                      RX_BUF_LEN) + 1;
         break;
@@ -811,7 +821,8 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
             break;
         }
 
-        bus->regs[R_I2CD_DMA_ADDR] = value & 0x3ffffffc;
+        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
+                                         value & 0x3ffffffc);
         break;
 
     case A_I2CD_DMA_LEN:
@@ -983,6 +994,7 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
         VMSTATE_UINT8_ARRAY(pool, AspeedI2CBus, ASPEED_I2C_BUS_POOL_SIZE),
+        VMSTATE_UINT64(dma_dram_offset, AspeedI2CBus),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -1188,8 +1200,9 @@ static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
             return -1;
         }
         ARRAY_FIELD_DP32(bus->regs, I2CS_DMA_LEN_STS, RX_LEN, 0);
-        bus->regs[R_I2CC_DMA_ADDR] =
-            ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_RX_ADDR, ADDR);
+        bus->dma_dram_offset =
+            deposit64(bus->dma_dram_offset, 0, 32,
+                      ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_RX_ADDR, ADDR));
         bus->regs[R_I2CC_DMA_LEN] =
             ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_LEN, RX_BUF_LEN) + 1;
         i2c_ack(bus->bus);
@@ -1255,10 +1268,10 @@ static int aspeed_i2c_bus_slave_event(I2CSlave *slave, enum i2c_event event)
 static void aspeed_i2c_bus_new_slave_send_async(AspeedI2CBus *bus, uint8_t data)
 {
     assert(address_space_write(&bus->controller->dram_as,
-                               bus->regs[R_I2CC_DMA_ADDR],
+                               bus->dma_dram_offset,
                                MEMTXATTRS_UNSPECIFIED, &data, 1) == MEMTX_OK);
 
-    bus->regs[R_I2CC_DMA_ADDR]++;
+    bus->dma_dram_offset++;
     bus->regs[R_I2CC_DMA_LEN]--;
     ARRAY_FIELD_DP32(bus->regs, I2CS_DMA_LEN_STS, RX_LEN,
                      ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_LEN_STS, RX_LEN) + 1);
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index b42c4dc584..bdaea3207d 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -248,6 +248,7 @@ struct AspeedI2CBus {
 
     uint32_t regs[ASPEED_I2C_NEW_NUM_REG];
     uint8_t pool[ASPEED_I2C_BUS_POOL_SIZE];
+    uint64_t dma_dram_offset;
 };
 
 struct AspeedI2CState {
@@ -369,14 +370,6 @@ static inline uint32_t aspeed_i2c_bus_dma_len_offset(AspeedI2CBus *bus)
     return R_I2CD_DMA_LEN;
 }
 
-static inline uint32_t aspeed_i2c_bus_dma_addr_offset(AspeedI2CBus *bus)
-{
-    if (aspeed_i2c_is_new_mode(bus->controller)) {
-        return R_I2CC_DMA_ADDR;
-    }
-    return R_I2CD_DMA_ADDR;
-}
-
 static inline bool aspeed_i2c_bus_is_master(AspeedI2CBus *bus)
 {
     return SHARED_ARRAY_FIELD_EX32(bus->regs, aspeed_i2c_bus_ctrl_offset(bus),
-- 
2.34.1


