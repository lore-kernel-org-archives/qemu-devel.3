Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77691CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsH-0002YV-JX; Mon, 08 Jun 2026 01:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSra-0001ed-FZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrX-0000ZP-VQ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNFTDEPSBh1l3YPKlbVUkDCbt8f5ZgobdVJy0qtAba0=;
 b=hJ7evqgw3wGVSHgTWIbNtkh5suqPKVMAqVDnJ2FL8NUUh/QUIJ+HcDpBgb477zDYbUweCq
 js5qT7Uktg8gj8bn2rOO94PPkWUMjbtRh1BvyooBk2Jy7R1A0qwUCzOtjWrzL7/fWQ6vG8
 YEaBjKopk1K0FBuasnPMeiNyVpN/Y1Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-UtrajwuoO0qrx_toBFBasQ-1; Mon,
 08 Jun 2026 01:49:21 -0400
X-MC-Unique: UtrajwuoO0qrx_toBFBasQ-1
X-Mimecast-MFC-AGG-ID: UtrajwuoO0qrx_toBFBasQ_1780897761
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E26591944D3B; Mon,  8 Jun 2026 05:49:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AD4C27A; Mon,  8 Jun 2026 05:49:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/37] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to unify
 DMA address handling
Date: Mon,  8 Jun 2026 07:48:14 +0200
Message-ID: <20260608054826.346488-26-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The Aspeed I2C controller has two register layouts.

The AST2500 uses the old mode with a single DMA address register (I2CD_DMA_ADDR)
where the address is 4-byte aligned and masked to 0x3ffffffc.

>From AST2600 onwards, the new mode provides separate master TX/RX and slave RX DMA
address registers (I2CM_DMA_TX_ADDR, I2CM_DMA_RX_ADDR, I2CS_DMA_RX_ADDR)
with different address widths per SoC:
  AST2600 (new mode): 0x7fffffff  - bits[30:0]
  AST1030 (new mode): 0x7fffffff  - bits[30:0]
  AST1060 (new mode): 0x7fffffff  - bits[30:0]
  AST2700 (new mode): 0xffffffff  - bits[31:0]

Introduce dma_addr_lo_mask as a per-class attribute and apply it
uniformly when storing DMA address register writes and when loading
the address into dma_dram_offset for both master and slave paths.
This replaces the previous FIELD_EX32 extractions (which incorrectly
stripped bit 31 on AST2700) and the hardcoded 0x3ffffffc literal in
the old-mode path.

Fixes: 1809ab6a67359e0876981cd05d2a50b2843eabad ("hw/i2c/aspeed: Add AST2700 support")
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260603040027.938816-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  5 +----
 hw/i2c/aspeed_i2c.c         | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index d42cb4865aa5..1fc229f69919 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -209,13 +209,9 @@ REG32(I2CS_DMA_LEN, 0x2c)
     FIELD(I2CS_DMA_LEN, TX_BUF_LEN_W1T, 15, 1)
     FIELD(I2CS_DMA_LEN, TX_BUF_LEN, 0, 11)
 REG32(I2CM_DMA_TX_ADDR, 0x30)
-    FIELD(I2CM_DMA_TX_ADDR, ADDR, 0, 31)
 REG32(I2CM_DMA_RX_ADDR, 0x34)
-    FIELD(I2CM_DMA_RX_ADDR, ADDR, 0, 31)
 REG32(I2CS_DMA_TX_ADDR, 0x38)
-    FIELD(I2CS_DMA_TX_ADDR, ADDR, 0, 31)
 REG32(I2CS_DMA_RX_ADDR, 0x3c)
-    FIELD(I2CS_DMA_RX_ADDR, ADDR, 0, 31)
 REG32(I2CS_DEV_ADDR, 0x40)
 REG32(I2CM_DMA_LEN_STS, 0x48)
     FIELD(I2CM_DMA_LEN_STS, RX_LEN, 16, 13)
@@ -303,6 +299,7 @@ struct AspeedI2CClass {
     bool has_share_pool;
     uint64_t mem_size;
     bool has_dma64;
+    uint32_t dma_addr_lo_mask;
 };
 
 static inline bool aspeed_i2c_is_new_mode(AspeedI2CState *s)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 4a6732a18554..9d4e72c8585e 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -236,7 +236,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)
         value = bus->regs[R_I2CM_DMA_TX_ADDR];
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
-                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
+                      value & aic->dma_addr_lo_mask);
         if (aic->has_dma64) {
             value = bus->regs[R_I2CM_DMA_TX_ADDR_HI];
             bus->dma_dram_offset =
@@ -246,7 +246,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)
     } else {
         value = bus->regs[R_I2CD_DMA_ADDR];
         bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
-                                         value & 0x3ffffffc);
+                                         value & aic->dma_addr_lo_mask);
     }
 }
 
@@ -261,7 +261,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)
         value = bus->regs[R_I2CM_DMA_RX_ADDR];
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
-                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
+                      value & aic->dma_addr_lo_mask);
         if (aic->has_dma64) {
             value = bus->regs[R_I2CM_DMA_RX_ADDR_HI];
             bus->dma_dram_offset =
@@ -271,7 +271,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)
     } else {
         value = bus->regs[R_I2CD_DMA_ADDR];
         bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
-                                         value & 0x3ffffffc);
+                                         value & aic->dma_addr_lo_mask);
     }
 }
 
@@ -735,12 +735,10 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
     case A_I2CM_DMA_TX_ADDR:
-        bus->regs[R_I2CM_DMA_TX_ADDR] = FIELD_EX32(value, I2CM_DMA_TX_ADDR,
-                                                   ADDR);
+        bus->regs[R_I2CM_DMA_TX_ADDR] = value & aic->dma_addr_lo_mask;
         break;
     case A_I2CM_DMA_RX_ADDR:
-        bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
-                                                   ADDR);
+        bus->regs[R_I2CM_DMA_RX_ADDR] = value & aic->dma_addr_lo_mask;
         break;
     case A_I2CM_DMA_LEN:
         w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
@@ -777,7 +775,7 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->regs[R_I2CS_DEV_ADDR] = value;
         break;
     case A_I2CS_DMA_RX_ADDR:
-        bus->regs[R_I2CS_DMA_RX_ADDR] = value;
+        bus->regs[R_I2CS_DMA_RX_ADDR] = value & aic->dma_addr_lo_mask;
         break;
     case A_I2CS_DMA_LEN:
         if (FIELD_EX32(value, I2CS_DMA_LEN, RX_BUF_LEN_W1T)) {
@@ -1375,6 +1373,8 @@ static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
 static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
                                           enum i2c_event event)
 {
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+
     switch (event) {
     case I2C_START_SEND_ASYNC:
         if (!SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CS_CMD, RX_DMA_EN)) {
@@ -1385,7 +1385,7 @@ static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
         ARRAY_FIELD_DP32(bus->regs, I2CS_DMA_LEN_STS, RX_LEN, 0);
         bus->dma_dram_offset =
             deposit64(bus->dma_dram_offset, 0, 32,
-                      ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_RX_ADDR, ADDR));
+                      bus->regs[R_I2CS_DMA_RX_ADDR] & aic->dma_addr_lo_mask);
         bus->regs[R_I2CC_DMA_LEN] =
             ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_LEN, RX_BUF_LEN) + 1;
         i2c_ack(bus->bus);
@@ -1608,6 +1608,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, const void *data)
     aic->check_sram = true;
     aic->has_dma = true;
     aic->mem_size = 0x1000;
+    aic->dma_addr_lo_mask = 0x3ffffffc;
 }
 
 static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
@@ -1631,6 +1632,7 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, const void *data)
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->has_dma = true;
     aic->mem_size = 0x1000;
+    aic->dma_addr_lo_mask = 0x7fffffff;
 }
 
 static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *data)
@@ -1649,6 +1651,7 @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *data)
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
     aic->has_dma = true;
     aic->mem_size = 0x10000;
+    aic->dma_addr_lo_mask = 0x7fffffff;
 }
 
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
@@ -1670,6 +1673,7 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
     aic->has_dma = true;
     aic->mem_size = 0x2000;
     aic->has_dma64 = true;
+    aic->dma_addr_lo_mask = 0xffffffff;
 }
 
 static const TypeInfo aspeed_i2c_types[] = {
-- 
2.54.0


