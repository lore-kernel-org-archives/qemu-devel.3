Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD541EEA855
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQ4-00088Y-9M; Thu, 12 Feb 2026 16:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ1-00086o-IM
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqePz-00064o-Mj
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GcbYNXwH/aSDIPjFZUN1LesZNNucAAzu2noFJMuvG4=;
 b=ZOeNRHnMRKCRFVEUGfhpVSFvn9f+CWxYtyEVn6L26op1PvXLYm+fzyiRmP1mglz5aAaB/W
 SdGvVaypaSrxjsY6Z6dy2aGsdhVPuMQ1CZPG2boClfbDcnF5FigBb6fBI/PsxuRxEuHk7X
 XDq28xNZEG1eXuIG1NtEzV9IsAAbyAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-68JmIHm2O7mbCyF_KKpyNA-1; Thu,
 12 Feb 2026 16:40:07 -0500
X-MC-Unique: 68JmIHm2O7mbCyF_KKpyNA-1
X-Mimecast-MFC-AGG-ID: 68JmIHm2O7mbCyF_KKpyNA_1770932406
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4205B195605B; Thu, 12 Feb 2026 21:40:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8636B180066E; Thu, 12 Feb 2026 21:40:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/16] hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO
 handlers
Date: Thu, 12 Feb 2026 22:39:42 +0100
Message-ID: <20260212213955.2225662-4-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/hw/i2c/aspeed_i2c.h |  3 +--
 hw/i2c/aspeed_i2c.c         | 22 ++++++++++------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 68bd13802601..1ba0112cef6b 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -36,8 +36,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 #define ASPEED_I2C_NR_BUSSES 16
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20
-#define ASPEED_I2C_OLD_NUM_REG 11
-#define ASPEED_I2C_NEW_NUM_REG 28
+#define ASPEED_I2C_NEW_NUM_REG (0x80 >> 2)
 
 #define A_I2CD_M_STOP_CMD       BIT(5)
 #define A_I2CD_M_RX_CMD         BIT(3)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index fb3d6a560018..741c7a7297f5 100644
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
 
-- 
2.53.0


