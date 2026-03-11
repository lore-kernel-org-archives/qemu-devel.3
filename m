Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9FD112583F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L6f-0006zE-PC; Wed, 11 Mar 2026 11:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L5B-0004S4-Oq; Wed, 11 Mar 2026 11:02:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L58-0003pe-9I; Wed, 11 Mar 2026 11:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241303; bh=48i6eBKXftJqY451kPbhow7I+neYu344SPbOUt52g6o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FQ8d3xM7AiVhCGyXFnzGtjpHvTxxIdUWxszuLi5MdpLdHo63C09h4E0/rzljHLwm4
 jcec02UHr/E2VPzOA5WgOdIcv8/UNsNF3FJ4qBv2thQE9wZnqA4PkZ7mRGdOuzqodr
 09FWRcy2CR1FvabUXbgex+NeQISkkA3qTs1QaEXOhaaK86o8dCHE6QxdQyXlebNXvR
 peLfFI37oPaosiB80enqUTJjF/vQqDe7vFFu7OTyk1I3wBH2HAge+XNxqpmQEfMfOc
 UoNHOyUZFUpOF+RwIh+5NmAcm4zEc/a3ZApW/IqW1/g5CMHWJLZzKbjIp/VTpAYKw2
 YuG0dmWvKYNhQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E0713191E47;
 Wed, 11 Mar 2026 18:01:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CCAAF37C299;
 Wed, 11 Mar 2026 18:02:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 09/44] hw/i2c/aspeed_i2c: Fix out-of-bounds read in
 I2C MMIO handlers
Date: Wed, 11 Mar 2026 18:01:41 +0300
Message-ID: <20260311150221.1084186-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The ASPEED I2C controller exposes a per-bus MMIO window of 0x80 bytes on
AST2600/AST1030/AST2700, but the backing regs[] array was sized for only
28 dwords (0x70 bytes). This allows guest reads in the range [0x70..0x7f]
to index past the end of regs[].

Fix this by:
- Sizing ASPEED_I2C_NEW_NUM_REG to match the 0x80-byte window
  (0x80 >> 2 = 32 dwords).
- Avoiding an unconditional pre-read from regs[] in the legacy/new read
  handlers. Initialize the return value to -1 and only read regs[] for
  offsets that are explicitly handled/valid, leaving invalid offsets to
  return -1 with a guest error log.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3290
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260210024331.3984696-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit c2c5beec42bf9872b37e78b9e259132df7435cb5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index f4f6e8aff9..35026fba00 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -94,7 +94,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
                                         unsigned size)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
-    uint64_t value = bus->regs[offset / sizeof(*bus->regs)];
+    uint64_t value = -1;
 
     switch (offset) {
     case A_I2CD_FUN_CTRL:
@@ -105,7 +105,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CD_DEV_ADDR:
     case A_I2CD_POOL_CTRL:
     case A_I2CD_BYTE_BUF:
-        /* Value is already set, don't do anything. */
+        value = bus->regs[offset / sizeof(*bus->regs)];
         break;
     case A_I2CD_CMD:
         value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
@@ -113,21 +113,20 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CD_DMA_ADDR:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
-            value = -1;
             break;
         }
+        value = bus->regs[offset / sizeof(*bus->regs)];
         break;
     case A_I2CD_DMA_LEN:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
-            value = -1;
+            break;
         }
+        value = bus->regs[offset / sizeof(*bus->regs)];
         break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
-        value = -1;
         break;
     }
 
@@ -139,7 +138,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
                                         unsigned size)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
-    uint64_t value = bus->regs[offset / sizeof(*bus->regs)];
+    uint64_t value = -1;
 
     switch (offset) {
     case A_I2CC_FUN_CTRL:
@@ -159,13 +158,12 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CS_CMD:
     case A_I2CS_INTR_CTRL:
     case A_I2CS_DMA_LEN_STS:
-        /* Value is already set, don't do anything. */
+    case A_I2CS_INTR_STS:
+        value = bus->regs[offset / sizeof(*bus->regs)];
         break;
     case A_I2CC_DMA_ADDR:
         value = extract64(bus->dma_dram_offset, 0, 32);
         break;
-    case A_I2CS_INTR_STS:
-        break;
     case A_I2CM_CMD:
         value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
         break;
@@ -176,13 +174,13 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
         if (!aic->has_dma64) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
             __func__);
-            value = -1;
+            break;
         }
+        value = bus->regs[offset / sizeof(*bus->regs)];
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
-        value = -1;
         break;
     }
 
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 2c4c81bd20..29b2b5cb80 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -37,8 +37,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 #define ASPEED_I2C_NR_BUSSES 16
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20
-#define ASPEED_I2C_OLD_NUM_REG 11
-#define ASPEED_I2C_NEW_NUM_REG 28
+#define ASPEED_I2C_NEW_NUM_REG (0x80 >> 2)
 
 #define A_I2CD_M_STOP_CMD       BIT(5)
 #define A_I2CD_M_RX_CMD         BIT(3)
-- 
2.47.3


