Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32052C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOB-0003N5-IH; Sun, 06 Sep 2026 13:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOA-0003MW-03
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GO7-0008VN-Re
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gRd3mQ/+wVlcnyYIsnKwvslWuhv7RnI3C3PxuGb35Y4=;
 b=L6WvB0Yl44rfxcEv1xzbQb4cpWDXuhLoRkKHq1kTIOVX78EEzuf/mSYXZvjktQAFR0aHg0
 T97nTOYOxS+LGk9i9hvkriunnFpyfBa2sM+1knfXFd+IFncDaYZpnPkJP5qT5GcqjJkR6y
 923SNOrkFIDIJ6myDbvUysl5gE8PFJQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-dEf8pn9xMWiWu_X3hgfIYA-1; Sun,
 06 Sep 2026 13:10:34 -0400
X-MC-Unique: dEf8pn9xMWiWu_X3hgfIYA-1
X-Mimecast-MFC-AGG-ID: dEf8pn9xMWiWu_X3hgfIYA_1788714633
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B99351954AEB; Sun,  6 Sep 2026 17:10:32 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C45EC1955F0C; Sun,  6 Sep 2026 17:10:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Mikail Sadic <mikail.sadic@ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/40] hw/i2c/aspeed_i2c: Latch received bytes for SMBus block
 reads
Date: Sun,  6 Sep 2026 19:09:43 +0200
Message-ID: <20260906171021.26568-3-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

An SMBus block read takes the block length from the first byte of the
transfer, and firmware reads that byte back from a register rather than
from the transfer buffer. The receive paths never updated those
registers, so block reads reported a bogus length.

On AST2600 the driver reads the length from the receive byte buffer,
I2CC_MS_TXRX_BYTE_BUF[15:8]. The datasheet documents that field as valid
while the DMA buffer is not enabled. The byte mode receive path already
updated it, but the pool buffer path did not, and the driver selects
buffer mode by default.

On AST2700 the driver reads the length from offset 0x84 instead.

Add I2CC_BYTE_DATA_LOG at 0x84 and latch received bytes into it. The pool
buffer, DMA-to-pool and DMA-to-DRAM paths latch their first byte, the byte
mode path latches every byte. Each latch also updates the receive byte
buffer unless RX_DMA_EN is set, which is the datasheet condition and does
not depend on FUNC_CFG_DMA_EN. The byte data log only exists on AST2700
and AST1040, so it is gated on a class flag.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Mikail Sadic <mikail.sadic@ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260814020836.3119613-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  3 +++
 hw/i2c/aspeed_i2c.c         | 38 +++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 05937a7a0b49..480c6418feee 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)
     FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)
 REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)
     FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
+REG32(I2CC_BYTE_DATA_LOG, 0x84)
+    FIELD(I2CC_BYTE_DATA_LOG, RX_BUF, 0, 8)
 REG32(I2CC_VERSION_CTRL, 0x94)
     FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)
 
@@ -302,6 +304,7 @@ struct AspeedI2CClass {
     bool has_share_pool;
     uint64_t mem_size;
     bool has_dma64;
+    bool has_byte_data_log;
     uint32_t dma_addr_lo_mask;
 };
 
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 68bdcd0e25a6..0bc4bb6fbe92 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -159,6 +159,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CS_INTR_CTRL:
     case A_I2CS_DMA_LEN_STS:
     case A_I2CS_INTR_STS:
+    case A_I2CC_BYTE_DATA_LOG:
     case A_I2CC_VERSION_CTRL:
         value = bus->regs[offset / sizeof(*bus->regs)];
         break;
@@ -334,6 +335,27 @@ static int aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *bus)
     return ret;
 }
 
+/*
+ * Latch a received byte where firmware reads it back from: the receive byte
+ * buffer, only valid while the DMA buffer is disabled, and the byte data log,
+ * which AST2700 uses instead. Buffer and DMA transfers latch only the first
+ * byte, read back as the SMBus block length.
+ */
+static void aspeed_i2c_bus_latch_rx_byte(AspeedI2CBus *bus, uint8_t data)
+{
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+    uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
+    uint32_t reg_cmd = aspeed_i2c_bus_cmd_offset(bus);
+
+    if (aic->has_byte_data_log) {
+        ARRAY_FIELD_DP32(bus->regs, I2CC_BYTE_DATA_LOG, RX_BUF, data);
+    }
+
+    if (!SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {
+        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);
+    }
+}
+
 static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
@@ -349,6 +371,9 @@ static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
         pool_base[offset + i] = i2c_recv(bus->bus);
         trace_aspeed_i2c_bus_recv("BUFF", i + 1, bus->regs[reg_dma_len],
                                   pool_base[offset + i]);
+        if (i == 0) {
+            aspeed_i2c_bus_latch_rx_byte(bus, pool_base[offset]);
+        }
         bus->regs[reg_dma_len]--;
         ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i + 1);
     }
@@ -443,6 +468,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
             pool_base[i] = i2c_recv(bus->bus);
             trace_aspeed_i2c_bus_recv("BUF", i + 1, pool_rx_count,
                                       pool_base[i]);
+            if (i == 0) {
+                aspeed_i2c_bus_latch_rx_byte(bus, pool_base[0]);
+            }
         }
 
         /* Update RX count */
@@ -460,7 +488,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         }
 
         aspeed_i2c_set_rx_dma_dram_offset(bus);
-        while (bus->regs[reg_dma_len]) {
+        for (i = 0; bus->regs[reg_dma_len]; i++) {
             MemTxResult result;
 
             data = i2c_recv(bus->bus);
@@ -476,6 +504,10 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
                 return;
             }
 
+            if (i == 0) {
+                aspeed_i2c_bus_latch_rx_byte(bus, data);
+            }
+
             bus->dma_dram_offset++;
             bus->regs[reg_dma_len]--;
             /* In new mode, keep track of how many bytes we RXed */
@@ -489,7 +521,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
     } else {
         data = i2c_recv(bus->bus);
         trace_aspeed_i2c_bus_recv("BYTE", 1, 1, bus->regs[reg_byte_buf]);
-        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);
+        aspeed_i2c_bus_latch_rx_byte(bus, data);
     }
 }
 
@@ -1758,6 +1790,7 @@ static void aspeed_1040_i2c_class_init(ObjectClass *klass, const void *data)
     aic->has_dma = true;
     aic->mem_size = 0x2000;
     aic->has_dma64 = true;
+    aic->has_byte_data_log = true;
     aic->dma_addr_lo_mask = 0x00ffffff;
 }
 
@@ -1780,6 +1813,7 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
     aic->has_dma = true;
     aic->mem_size = 0x2000;
     aic->has_dma64 = true;
+    aic->has_byte_data_log = true;
     aic->dma_addr_lo_mask = 0xffffffff;
 }
 
-- 
2.55.0


