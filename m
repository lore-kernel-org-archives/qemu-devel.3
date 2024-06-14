Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F7EC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1Lr-0003Sj-2i; Fri, 14 Jun 2024 03:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lp-0003Rs-PQ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lo-0000nW-58
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50UHzxju/vgPYUlhxAkVmjUy9/fEsWgJ8psibIW6p6M=;
 b=UcjQE/d2Q4g8IuCXxxQGmzYwgDHCeZEsrCINNfwTWUjmrda5vla8Ie6aa7aYfU/Abn/tbY
 Kdu4dM6q/TZhWNWeU+MGg0mjxTH3MH3CBZUmjR0Zn4e3ANson/5I44dISIvsIdjYc7Ed8r
 Lv8TMWiPVcuo9oKNwG5fQ2gtg9jtiDM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-QBcrtVykMnKADnF845hlkQ-1; Fri,
 14 Jun 2024 03:27:46 -0400
X-MC-Unique: QBcrtVykMnKADnF845hlkQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF64319560B9; Fri, 14 Jun 2024 07:27:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 210D3300021A; Fri, 14 Jun 2024 07:27:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/19] aspeed/smc: support 64 bits dma dram address
Date: Fri, 14 Jun 2024 09:26:10 +0200
Message-ID: <20240614072620.1262053-10-clg@redhat.com>
In-Reply-To: <20240614072620.1262053-1-clg@redhat.com>
References: <20240614072620.1262053-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

AST2700 support the maximum dram size is 8GiB
and has a "DMA DRAM Side Address High Part(0x7C)"
register to support 64 bits dma dram address.
Add helper routines functions to compute the dma dram
address, new features and update trace-event
to support 64 bits dram address.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ssi/aspeed_smc.c | 51 ++++++++++++++++++++++++++++++++++++++-------
 hw/ssi/trace-events |  2 +-
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 0b8488a113db..df0c63469cd7 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -132,6 +132,9 @@
 #define   FMC_WDT2_CTRL_BOOT_SOURCE      BIT(4) /* O: primary 1: alternate */
 #define   FMC_WDT2_CTRL_EN               BIT(0)
 
+/* DMA DRAM Side Address High Part (AST2700) */
+#define R_DMA_DRAM_ADDR_HIGH   (0x7c / 4)
+
 /* DMA Control/Status Register */
 #define R_DMA_CTRL        (0x80 / 4)
 #define   DMA_CTRL_REQUEST      (1 << 31)
@@ -187,6 +190,7 @@
  *   0x1FFFFFF: 32M bytes
  */
 #define DMA_DRAM_ADDR(asc, val)   ((val) & (asc)->dma_dram_mask)
+#define DMA_DRAM_ADDR_HIGH(val)   ((val) & 0xf)
 #define DMA_FLASH_ADDR(asc, val)  ((val) & (asc)->dma_flash_mask)
 #define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
 
@@ -207,6 +211,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[];
 #define ASPEED_SMC_FEATURE_DMA       0x1
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4
+#define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08
 
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)
 {
@@ -218,6 +223,11 @@ static inline bool aspeed_smc_has_wdt_control(const AspeedSMCClass *asc)
     return !!(asc->features & ASPEED_SMC_FEATURE_WDT_CONTROL);
 }
 
+static inline bool aspeed_smc_has_dma64(const AspeedSMCClass *asc)
+{
+    return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);
+}
+
 #define aspeed_smc_error(fmt, ...)                                      \
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS__)
 
@@ -747,6 +757,8 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         (aspeed_smc_has_dma(asc) && addr == R_DMA_CTRL) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_FLASH_ADDR) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_DRAM_ADDR) ||
+        (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&
+         addr == R_DMA_DRAM_ADDR_HIGH) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_CHECKSUM) ||
         (addr >= R_SEG_ADDR0 &&
@@ -847,6 +859,12 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
     }
 }
 
+static uint64_t aspeed_smc_dma_dram_addr(AspeedSMCState *s)
+{
+    return s->regs[R_DMA_DRAM_ADDR] |
+        ((uint64_t) s->regs[R_DMA_DRAM_ADDR_HIGH] << 32);
+}
+
 static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
 {
     AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
@@ -903,24 +921,34 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 
 static void aspeed_smc_dma_rw(AspeedSMCState *s)
 {
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+    uint64_t dma_dram_offset;
+    uint64_t dma_dram_addr;
     MemTxResult result;
     uint32_t dma_len;
     uint32_t data;
 
     dma_len = aspeed_smc_dma_len(s);
+    dma_dram_addr = aspeed_smc_dma_dram_addr(s);
+
+    if (aspeed_smc_has_dma64(asc)) {
+        dma_dram_offset = dma_dram_addr - s->dram_base;
+    } else {
+        dma_dram_offset = dma_dram_addr;
+    }
 
     trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
                             "write" : "read",
                             s->regs[R_DMA_FLASH_ADDR],
-                            s->regs[R_DMA_DRAM_ADDR],
+                            dma_dram_offset,
                             dma_len);
     while (dma_len) {
         if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
-            data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
+            data = address_space_ldl_le(&s->dram_as, dma_dram_offset,
                                         MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
-                aspeed_smc_error("DRAM read failed @%08x",
-                                 s->regs[R_DMA_DRAM_ADDR]);
+                aspeed_smc_error("DRAM read failed @%" PRIx64,
+                                 dma_dram_offset);
                 return;
             }
 
@@ -940,11 +968,11 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
                 return;
             }
 
-            address_space_stl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
+            address_space_stl_le(&s->dram_as, dma_dram_offset,
                                  data, MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
-                aspeed_smc_error("DRAM write failed @%08x",
-                                 s->regs[R_DMA_DRAM_ADDR]);
+                aspeed_smc_error("DRAM write failed @%" PRIx64,
+                                 dma_dram_offset);
                 return;
             }
         }
@@ -953,8 +981,12 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
          * When the DMA is on-going, the DMA registers are updated
          * with the current working addresses and length.
          */
+        dma_dram_offset += 4;
+        dma_dram_addr += 4;
+
+        s->regs[R_DMA_DRAM_ADDR_HIGH] = dma_dram_addr >> 32;
+        s->regs[R_DMA_DRAM_ADDR] = dma_dram_addr & 0xffffffff;
         s->regs[R_DMA_FLASH_ADDR] += 4;
-        s->regs[R_DMA_DRAM_ADDR] += 4;
         dma_len -= 4;
         s->regs[R_DMA_LEN] = dma_len;
         s->regs[R_DMA_CHECKSUM] += data;
@@ -1107,6 +1139,9 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
     } else if (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN &&
                aspeed_smc_dma_granted(s)) {
         s->regs[addr] = DMA_LENGTH(value);
+    } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&
+               addr == R_DMA_DRAM_ADDR_HIGH) {
+        s->regs[addr] = DMA_DRAM_ADDR_HIGH(value);
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2d5bd2b83d0c..7b5ad6a939e3 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -6,7 +6,7 @@ aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d index:0x%x d
 aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
 aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
-aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint32_t dram_addr, uint32_t size) "%s flash:@0x%08x dram:@0x%08x size:0x%08x"
+aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint64_t dram_addr, uint32_t size) "%s flash:@0x%08x dram:@0x%" PRIx64 " size:0x%08x"
 aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
 
-- 
2.45.2


