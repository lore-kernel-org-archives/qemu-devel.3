Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AD0C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 19:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqGwe-00027h-2E; Mon, 16 Sep 2024 14:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGwD-0001JY-Mi
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqGwB-0003MC-9T
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 14:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726513141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/pTFAJK4RR+trxI+ivctFavMCiEe0mc7YieujKSWGU=;
 b=efr+lmHevaDx0p2LUJ6tWZDvPotSZdW3Ly577CrojniWTHnIcuCtMn/A4KCMAedKpjngVz
 9UwV0sxjoszBFRv7n8N5+L0Ejmakgc8SJ8E6T13hVoUNJXJolXpBakS5Tr0an6Gj0oEu64
 5AMD3bGTpcEB8k52XWvlJtY8Yb2VN8I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-tU-IPdu1P7mgvM1r-C2vIQ-1; Mon,
 16 Sep 2024 14:57:29 -0400
X-MC-Unique: tU-IPdu1P7mgvM1r-C2vIQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9238F1956069; Mon, 16 Sep 2024 18:57:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.44])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CFDE19560AA; Mon, 16 Sep 2024 18:57:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PULL 07/12] hw/i2c/aspeed: Add support for Tx/Rx buffer 64 bit
 addresses
Date: Mon, 16 Sep 2024 20:57:03 +0200
Message-ID: <20240916185708.574546-8-clg@redhat.com>
In-Reply-To: <20240916185708.574546-1-clg@redhat.com>
References: <20240916185708.574546-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
and the base address of dram is "0x4 00000000" which
is 64bits address.

It has "Master DMA Mode Tx Buffer Base Address[39:32](0x60)"
and "Master DMA Mode Rx Buffer Base Address[39:32](0x64)"
registers to save the high part physical address of Tx/Rx
buffer address for master mode.

It has "Slave DMA Mode Tx Buffer Base Address[39:32](0x68)" and
"Slave DMA Mode Rx Buffer Base Address[39:32](0x6C)" registers
to save the high part physical address of Tx/Rx buffer address
for slave mode.

Ex: Tx buffer address for master mode [39:0]
The "Master DMA Mode Tx Buffer Base Address[39:32](0x60)"
bits [7:0] which corresponds the bits [39:32] of the 64 bits address of
the Tx buffer address.
The "Master DMA Mode Tx Buffer Base Address(0x30)" bits [31:0]
which corresponds the bits [31:0] of the 64 bits address
of the Tx buffer address.

Introduce a new has_dma64 class attribute and new registers for the
new mode to support DMA 64 bits dram address.
Update new mode register number to 28.

The aspeed_i2c_bus_vmstate is changed again and
version is not increased because it was done earlier in the same series.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/i2c/aspeed_i2c.h | 12 +++++++++-
 hw/i2c/aspeed_i2c.c         | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 4f23dc10c3e1..2c4c81bd209d 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -38,7 +38,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20
 #define ASPEED_I2C_OLD_NUM_REG 11
-#define ASPEED_I2C_NEW_NUM_REG 22
+#define ASPEED_I2C_NEW_NUM_REG 28
 
 #define A_I2CD_M_STOP_CMD       BIT(5)
 #define A_I2CD_M_RX_CMD         BIT(3)
@@ -227,6 +227,15 @@ REG32(I2CS_DMA_LEN_STS, 0x4c)
     FIELD(I2CS_DMA_LEN_STS, TX_LEN, 0, 13)
 REG32(I2CC_DMA_ADDR, 0x50)
 REG32(I2CC_DMA_LEN, 0x54)
+/* DMA 64bits */
+REG32(I2CM_DMA_TX_ADDR_HI, 0x60)
+    FIELD(I2CM_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)
+REG32(I2CM_DMA_RX_ADDR_HI, 0x64)
+    FIELD(I2CM_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
+REG32(I2CS_DMA_TX_ADDR_HI, 0x68)
+    FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)
+REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)
+    FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
 
 struct AspeedI2CState;
 
@@ -292,6 +301,7 @@ struct AspeedI2CClass {
     bool has_dma;
     bool has_share_pool;
     uint64_t mem_size;
+    bool has_dma64;
 };
 
 static inline bool aspeed_i2c_is_new_mode(AspeedI2CState *s)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index c61bafcb9ad4..74aa5e0a160b 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -140,6 +140,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
 static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
                                         unsigned size)
 {
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     uint64_t value = bus->regs[offset / sizeof(*bus->regs)];
 
     switch (offset) {
@@ -170,6 +171,16 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CM_CMD:
         value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
         break;
+    case A_I2CM_DMA_TX_ADDR_HI:
+    case A_I2CM_DMA_RX_ADDR_HI:
+    case A_I2CS_DMA_TX_ADDR_HI:
+    case A_I2CS_DMA_RX_ADDR_HI:
+        if (!aic->has_dma64) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
+            __func__);
+            value = -1;
+        }
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
@@ -731,6 +742,42 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         qemu_log_mask(LOG_UNIMP, "%s: Slave mode DMA TX is not implemented\n",
                       __func__);
         break;
+
+    case A_I2CM_DMA_TX_ADDR_HI:
+        if (!aic->has_dma64) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
+                          __func__);
+            break;
+        }
+        bus->regs[R_I2CM_DMA_TX_ADDR_HI] = FIELD_EX32(value,
+                                                      I2CM_DMA_TX_ADDR_HI,
+                                                      ADDR_HI);
+        break;
+    case A_I2CM_DMA_RX_ADDR_HI:
+        if (!aic->has_dma64) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
+                          __func__);
+            break;
+        }
+        bus->regs[R_I2CM_DMA_RX_ADDR_HI] = FIELD_EX32(value,
+                                                      I2CM_DMA_RX_ADDR_HI,
+                                                      ADDR_HI);
+        break;
+    case A_I2CS_DMA_TX_ADDR_HI:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Slave mode DMA TX Addr high is not implemented\n",
+                      __func__);
+        break;
+    case A_I2CS_DMA_RX_ADDR_HI:
+        if (!aic->has_dma64) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
+                          __func__);
+            break;
+        }
+        bus->regs[R_I2CS_DMA_RX_ADDR_HI] = FIELD_EX32(value,
+                                                      I2CS_DMA_RX_ADDR_HI,
+                                                      ADDR_HI);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -1554,6 +1601,7 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, void *data)
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->has_dma = true;
     aic->mem_size = 0x2000;
+    aic->has_dma64 = true;
 }
 
 static const TypeInfo aspeed_2700_i2c_info = {
-- 
2.46.0


