Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B3BC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOX-0004kA-JP; Tue, 11 Aug 2026 12:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOU-0004Xv-P3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOS-0000wl-Q9
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cri1gH69YRMzgDwfEq5/1Klz7WkmiMIo6NB0+8CpMHo=;
 b=gd3C4t1qF1pKM0RP1GqmoWF7+sjoqIOoiWTOG3BdPd2PtBrVYxYntcllNnL3QdTcdmjDwK
 +73FBzXfLJWK49YexJVOmQ6AU9p6p+VPYIn5WjaT1LNEct/ffiAce87+w5H7LPZrpyyj34
 4HvqoJZzSBSmhFf3clBrWbqq/ee1XbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-basjofgMOmqBXwVb1f8vBw-1; Tue,
 11 Aug 2026 12:31:51 -0400
X-MC-Unique: basjofgMOmqBXwVb1f8vBw-1
X-Mimecast-MFC-AGG-ID: basjofgMOmqBXwVb1f8vBw_1786465910
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74C8919560A2; Tue, 11 Aug 2026 16:31:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 067C4195DF91; Tue, 11 Aug 2026 16:31:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 59/83] hw/i2c/aspeed_i2c: Support the AST2700 master buffer mode
Date: Tue, 11 Aug 2026 18:29:14 +0200
Message-ID: <20260811162938.1403216-60-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

The AST2700 I2C controller can move master DMA payloads through its
internal SRAM pool rather than DRAM. The Linux driver calls this "buffer
mode" and selects it by default. Buffer mode reuses the master DMA
command bits (TX/RX_DMA_EN) and the DMA length registers, so the only
difference from a DRAM transfer is where the data comes from and goes
to: an offset into the pool programmed in I2CM_DMA_TX/RX_ADDR. The
I2CC_VERSION_CTRL FUNC_CFG_DMA_EN bit selects between the two.

Implement I2CC_VERSION_CTRL and, when FUNC_CFG_DMA_EN is clear, move the
payload through the pool buffer instead of DRAM.

I2CC_VERSION_CTRL resets to all ones, so guests that never program it
keep targeting DRAM and behave as before. The register sits above the
register window of the earlier SoCs, which are therefore unaffected.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260804081955.1563537-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i2c/aspeed_i2c.h |  2 +
 hw/i2c/aspeed_i2c.c         | 79 +++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 156998e7c14e..05937a7a0b49 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)
     FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)
 REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)
     FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
+REG32(I2CC_VERSION_CTRL, 0x94)
+    FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)
 
 struct AspeedI2CState;
 
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 27afcaeceedc..68bdcd0e25a6 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -159,6 +159,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CS_INTR_CTRL:
     case A_I2CS_DMA_LEN_STS:
     case A_I2CS_INTR_STS:
+    case A_I2CC_VERSION_CTRL:
         value = bus->regs[offset / sizeof(*bus->regs)];
         break;
     case A_I2CC_DMA_ADDR:
@@ -295,6 +296,65 @@ static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
     return 0;
 }
 
+/*
+ * In AST2700 buffer mode the master DMA command bits (TX/RX_DMA_EN) and the
+ * DMA length registers are reused, but data is moved through the controller
+ * internal SRAM pool at the offset programmed in I2CM_DMA_TX/RX_ADDR instead
+ * of DRAM. FUNC_CFG_DMA_EN selects between the two (set = DRAM).
+ */
+static bool aspeed_i2c_bus_dma_to_pool(AspeedI2CBus *bus)
+{
+    return aspeed_i2c_is_new_mode(bus->controller) &&
+           !ARRAY_FIELD_EX32(bus->regs, I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN);
+}
+
+static int aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *bus)
+{
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+    uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
+    uint32_t reg_cmd = aspeed_i2c_bus_cmd_offset(bus);
+    uint32_t offset = bus->regs[R_I2CM_DMA_TX_ADDR];
+    uint8_t *pool_base = aic->bus_pool_base(bus);
+    int ret = -1;
+    int i;
+
+    ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);
+    for (i = 0; bus->regs[reg_dma_len] &&
+                offset + i < ASPEED_I2C_BUS_POOL_SIZE; i++) {
+        trace_aspeed_i2c_bus_send("BUFF", i + 1, bus->regs[reg_dma_len],
+                                  pool_base[offset + i]);
+        ret = i2c_send(bus->bus, pool_base[offset + i]);
+        bus->regs[reg_dma_len]--;
+        ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, i + 1);
+        if (ret) {
+            break;
+        }
+    }
+    SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, TX_DMA_EN, 0);
+    return ret;
+}
+
+static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
+{
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+    uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
+    uint32_t reg_cmd = aspeed_i2c_bus_cmd_offset(bus);
+    uint32_t offset = bus->regs[R_I2CM_DMA_RX_ADDR];
+    uint8_t *pool_base = aic->bus_pool_base(bus);
+    int i;
+
+    ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);
+    for (i = 0; bus->regs[reg_dma_len] &&
+                offset + i < ASPEED_I2C_BUS_POOL_SIZE; i++) {
+        pool_base[offset + i] = i2c_recv(bus->bus);
+        trace_aspeed_i2c_bus_recv("BUFF", i + 1, bus->regs[reg_dma_len],
+                                  pool_base[offset + i]);
+        bus->regs[reg_dma_len]--;
+        ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i + 1);
+    }
+    SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX_DMA_EN, 0);
+}
+
 static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
@@ -320,6 +380,10 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
         }
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, TX_BUFF_EN, 0);
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
+        /* In buffer mode the DMA moves data through the pool, not DRAM */
+        if (aspeed_i2c_bus_dma_to_pool(bus)) {
+            return aspeed_i2c_bus_send_dma_pool(bus);
+        }
         /* In new mode, clear how many bytes we TXed */
         if (aspeed_i2c_is_new_mode(bus->controller)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);
@@ -385,6 +449,11 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_pool_ctrl, RX_COUNT, i & 0xff);
         SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX_BUFF_EN, 0);
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {
+        /* In buffer mode the DMA moves data through the pool, not DRAM */
+        if (aspeed_i2c_bus_dma_to_pool(bus)) {
+            aspeed_i2c_bus_recv_dma_pool(bus);
+            return;
+        }
         /* In new mode, clear how many bytes we RXed */
         if (aspeed_i2c_is_new_mode(bus->controller)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);
@@ -854,6 +923,9 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
                                                       I2CS_DMA_RX_ADDR_HI,
                                                       ADDR_HI);
         break;
+    case A_I2CC_VERSION_CTRL:
+        bus->regs[R_I2CC_VERSION_CTRL] = value;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -1497,6 +1569,13 @@ static void aspeed_i2c_bus_reset_hold(Object *obj, ResetType type)
     memset(s->regs, 0, sizeof(s->regs));
     s->pending_intr_sts = 0;
     i2c_end_transfer(s->bus);
+    /*
+     * I2CC_VERSION_CTRL resets to all-ones. FUNC_CFG_DMA_EN is therefore set,
+     * so master DMA targets DRAM unless the guest clears it to select buffer
+     * mode. Guests unaware of buffer mode never touch this register and keep
+     * doing DRAM DMA.
+     */
+    s->regs[R_I2CC_VERSION_CTRL] = 0xffffffff;
 }
 
 static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
-- 
2.55.0


