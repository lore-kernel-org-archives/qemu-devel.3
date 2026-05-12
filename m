Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B15CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuLt-0004yt-E9; Tue, 12 May 2026 17:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKl-0000xe-2I; Tue, 12 May 2026 17:08:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKf-0002d4-0I; Tue, 12 May 2026 17:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=4udaYFb8wZEl1kO1PHPBwef/lFSby6/dh8NrWRE/A98=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=d4a7hMpW77HBR6nWuzDGKbInuHTKH0XFuwvt5tMDBPVl+hECY8eOLNAqK28gBFMYN
 +AgEFkcQ8Dza+7Ub6FJg6jJ5NcKJphTlIO2W10NCXhm2v+wjew+brIjZRQ/LwtNs+M
 /p4ml96feWXabB3WvlQP8OqsnbuGk34xkP9TseiLSLeHW3XfsxY79CHMRdQmjw7tUD
 LHbjDhb3jaZu8rZkwBEe5U0l8R9cuN4mHOpIlmme6dBKLzVknZ6l48hobceYay1iWY
 AGqZRZ9QKBTQKOy7cm6gAMWZm9YtLA65/FKimCI4UY2w93YKr4qa303K256V9rCdps
 wtcIacEsyOVsg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4583F1AA354;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 520133ABCC4;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 023/117] hw/ssi/aspeed_smc: Convert mem ops to
 read/write_with_attrs for error handling
Date: Tue, 12 May 2026 23:53:25 +0300
Message-ID: <20260512205503.361097-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

Error conditions (invalid flash mode, unwritable flash) now return
MEMTX_ERROR instead of silently succeeding or returning undefined
values.

This allows the memory subsystem to properly propagate transaction
errors to the guest, improving QEMU reliability.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260323125545.577653-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 80c5be945877ea3f258679c6042df8f0efd77202)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index e33496f502..4153aed3f2 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -493,17 +493,18 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
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
@@ -512,18 +513,19 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
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
@@ -624,8 +626,8 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
     return false;
 }
 
-static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
-                                   unsigned size)
+static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
+                                   uint64_t data, unsigned size, MemTxAttrs attrs)
 {
     AspeedSMCFlash *fl = opaque;
     AspeedSMCState *s = fl->controller;
@@ -636,7 +638,7 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
 
     if (!aspeed_smc_is_writable(fl)) {
         aspeed_smc_error("flash is not writable at 0x%" HWADDR_PRIx, addr);
-        return;
+        return MEMTX_ERROR;
     }
 
     switch (aspeed_smc_flash_mode(fl)) {
@@ -661,12 +663,15 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
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
@@ -754,7 +759,8 @@ static void aspeed_smc_reset(DeviceState *d)
     s->snoop_dummies = 0;
 }
 
-static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
+static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
+                                   unsigned int size, MemTxAttrs attrs)
 {
     AspeedSMCState *s = ASPEED_SMC(opaque);
     AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(opaque);
@@ -782,12 +788,13 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
 
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);
 
-        return s->regs[addr];
+        *data = s->regs[addr];
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
-        return -1;
+        *data = -1;
     }
+    return MEMTX_OK;
 }
 
 static uint8_t aspeed_smc_hclk_divisor(uint8_t hclk_mask)
@@ -1108,8 +1115,8 @@ static void aspeed_2600_smc_dma_ctrl(AspeedSMCState *s, uint32_t dma_ctrl)
     s->regs[R_DMA_CTRL] &= ~(DMA_CTRL_REQUEST | DMA_CTRL_GRANT);
 }
 
-static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
-                             unsigned int size)
+static MemTxResult aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
+                                    unsigned int size, MemTxAttrs attrs)
 {
     AspeedSMCState *s = ASPEED_SMC(opaque);
     AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
@@ -1159,13 +1166,13 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
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
 
@@ -2007,8 +2014,8 @@ static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] = {
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
2.47.3


