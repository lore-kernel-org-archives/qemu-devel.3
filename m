Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8773D58CAC
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 21:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Qo0-0003hs-NV; Sun, 22 Mar 2026 17:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4Qnt-0003g3-08
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 17:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4Qnp-00073b-Jy
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 17:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774216665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/fT/Z4UXECEVdqdNfQV6ZbgaAiHfkFkpWrQvNThp/o=;
 b=U497dGxCPgoxy0WA1sLkmAvZLLmGixWFPzhfmLB+v21xkJRyMHaLFTAFUVtcQMGC0zxqv+
 LdJQgBkhHfZbZgxpwelKRXouI3EGq+/+hPf+nSOsOpajjyMJ8mBnHtQDvrNM/SqLqXC4Fo
 6jLGbXv87uN1+U2Zo3iYOv/k9fgHgd4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-LY5Rvsq6OpKBSE893V0vXw-1; Sun,
 22 Mar 2026 17:57:41 -0400
X-MC-Unique: LY5Rvsq6OpKBSE893V0vXw-1
X-Mimecast-MFC-AGG-ID: LY5Rvsq6OpKBSE893V0vXw_1774216660
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C62B195608C; Sun, 22 Mar 2026 21:57:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF8941955F21; Sun, 22 Mar 2026 21:57:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/3] hw/ssi/aspeed_smc: Convert mem ops to
 read/write_with_attrs for error handling
Date: Sun, 22 Mar 2026 22:57:30 +0100
Message-ID: <20260322215732.387383-2-clg@redhat.com>
In-Reply-To: <20260322215732.387383-1-clg@redhat.com>
References: <20260322215732.387383-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Error conditions (invalid flash mode, unwritable flash, invalid data
FIFO offset) now return MEMTX_ERROR instead of silently succeeding or
returning undefined values.

This allows the memory subsystem to properly propagate transaction
errors to the guest, improving QEMU reliability.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ssi/aspeed_smc.c | 58 ++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index ed6cedabcb3b..b14b1cbddfc3 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -502,17 +502,18 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
     }
 }
 
-static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
+                                 uint64_t *data, unsigned size, MemTxAttrs attrs)
 {
     AspeedSMCFlash *fl = opaque;
     AspeedSMCState *s = fl->controller;
-    uint64_t ret = 0;
     int i;
 
+    *data = 0;
     switch (aspeed_smc_flash_mode(fl)) {
     case CTRL_USERMODE:
         for (i = 0; i < size; i++) {
-            ret |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
+            *data |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
         }
         break;
     case CTRL_READMODE:
@@ -521,18 +522,19 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
         aspeed_smc_flash_setup(fl, addr);
 
         for (i = 0; i < size; i++) {
-            ret |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
+            *data |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
         }
 
         aspeed_smc_flash_unselect(fl);
         break;
     default:
         aspeed_smc_error("invalid flash mode %d", aspeed_smc_flash_mode(fl));
+        return MEMTX_ERROR;
     }
 
-    trace_aspeed_smc_flash_read(fl->cs, addr, size, ret,
+    trace_aspeed_smc_flash_read(fl->cs, addr, size, *data,
                                 aspeed_smc_flash_mode(fl));
-    return ret;
+    return MEMTX_OK;
 }
 
 /*
@@ -633,8 +635,8 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
     return false;
 }
 
-static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
-                                   unsigned size)
+static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
+                                   uint64_t data, unsigned size, MemTxAttrs attrs)
 {
     AspeedSMCFlash *fl = opaque;
     AspeedSMCState *s = fl->controller;
@@ -645,7 +647,7 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
 
     if (!aspeed_smc_is_writable(fl)) {
         aspeed_smc_error("flash is not writable at 0x%" HWADDR_PRIx, addr);
-        return;
+        return MEMTX_ERROR;
     }
 
     switch (aspeed_smc_flash_mode(fl)) {
@@ -670,12 +672,15 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     default:
         aspeed_smc_error("invalid flash mode %d", aspeed_smc_flash_mode(fl));
+        return MEMTX_ERROR;
     }
+
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps aspeed_smc_flash_ops = {
-    .read = aspeed_smc_flash_read,
-    .write = aspeed_smc_flash_write,
+    .read_with_attrs = aspeed_smc_flash_read,
+    .write_with_attrs = aspeed_smc_flash_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
@@ -763,7 +768,8 @@ static void aspeed_smc_reset(DeviceState *d)
     s->snoop_dummies = 0;
 }
 
-static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
+static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
+                                   unsigned int size, MemTxAttrs attrs)
 {
     AspeedSMCState *s = ASPEED_SMC(opaque);
     AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(opaque);
@@ -792,7 +798,7 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
 
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);
 
-        return s->regs[addr];
+        *data = s->regs[addr];
     } else if (aspeed_smc_has_data_fifo(asc) && addr >= R_DATA_FIFO) {
         cs = asc->data_fifo_offset_to_cs(s, addr << 2);
         if (cs >= 0) {
@@ -801,15 +807,17 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
              * The flash address is provided by the SPI command/address cycles,
              * the MMIO addr parameter is ignored.
              */
-            return aspeed_smc_flash_read(&s->flashes[cs], 0, size);
+            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, attrs);
         }
         aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
-        return -1;
+        *data = -1;
+        return MEMTX_ERROR;
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
-        return -1;
+        *data = -1;
     }
+    return MEMTX_OK;
 }
 
 static uint8_t aspeed_smc_hclk_divisor(uint8_t hclk_mask)
@@ -1130,8 +1138,8 @@ static void aspeed_2600_smc_dma_ctrl(AspeedSMCState *s, uint32_t dma_ctrl)
     s->regs[R_DMA_CTRL] &= ~(DMA_CTRL_REQUEST | DMA_CTRL_GRANT);
 }
 
-static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
-                             unsigned int size)
+static MemTxResult aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
+                                    unsigned int size, MemTxAttrs attrs)
 {
     AspeedSMCState *s = ASPEED_SMC(opaque);
     AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
@@ -1186,19 +1194,21 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
              * The flash address is provided by the SPI command/address cycles,
              * the MMIO addr parameter is ignored.
              */
-            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size);
+            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,
+                                          attrs);
         }
         aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
+        return MEMTX_ERROR;
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
-        return;
     }
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps aspeed_smc_ops = {
-    .read = aspeed_smc_read,
-    .write = aspeed_smc_write,
+    .read_with_attrs = aspeed_smc_read,
+    .write_with_attrs = aspeed_smc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -2073,8 +2083,8 @@ static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] = {
 };
 
 static const MemoryRegionOps aspeed_2700_smc_flash_ops = {
-    .read = aspeed_smc_flash_read,
-    .write = aspeed_smc_flash_write,
+    .read_with_attrs = aspeed_smc_flash_read,
+    .write_with_attrs = aspeed_smc_flash_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-- 
2.53.0


