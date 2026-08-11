Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F09C5CFED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNf-00012H-Jp; Tue, 11 Aug 2026 12:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNG-0008FJ-LL
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNC-0000dY-F5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xozE/mmQUtpbtgTw0R5po73BJbDV50BhOnDxLSJRumc=;
 b=Nh+5mpaWGcV9dJ3CgF/TtAnCFsL9hoJZiW59uZOs8G9x4C7V6rVpMoIsyGClECbvfHjkYJ
 1CpmGRlNAs8PYNlQBa9YtXuWc4/l8gdYhHslv57q59C7a1RqfPNpVrTDqPIl6BLQ1xYEj/
 AVbYG6b5kFDzw39CFZlj+tDQJVhkwx0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-FAXzd3BzPX6di_-LhiGdXQ-1; Tue,
 11 Aug 2026 12:30:39 -0400
X-MC-Unique: FAXzd3BzPX6di_-LhiGdXQ-1
X-Mimecast-MFC-AGG-ID: FAXzd3BzPX6di_-LhiGdXQ_1786465838
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 060B21956041; Tue, 11 Aug 2026 16:30:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 522F1195DF91; Tue, 11 Aug 2026 16:30:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 25/83] hw/ssi/aspeed_smc: Add Data FIFO-based flash access
 support for AST2700
Date: Tue, 11 Aug 2026 18:28:40 +0200
Message-ID: <20260811162938.1403216-26-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

AST2700 supports a Data FIFO mode where flash accesses can be performed
directly through Data FIFO MMIO offsets. The Data FIFO start offset
increments by one for every 16MB of flash address space, allowing the
chip select (CS) to be decoded from the Data FIFO offset.

This change adds Data FIFO support to the Aspeed SMC model and introduces
a class callback to translate Data FIFO offsets into CS indices. For
AST2700, the Data FIFO offset is matched against the segment start address
of each CS to determine the target flash device.

The SMC register region size (nregs) is also extended dynamically
based on the number of supported chip selects to cover all possible
Data FIFO regions.

This breaks migration compatibility with older QEMU builds for the
affected models, even though Aspeed machines are not officially
covered by migration compatibility guarantees.

Bump version_id to 4 and minimum_version_id to 2 to reflect the
incompatible format.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ssi/aspeed_smc.h |   3 +-
 hw/ssi/aspeed_smc.c         | 117 +++++++++++++++++++++++++++++++++---
 2 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index a273365689ea..5f391fc24ef3 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -47,7 +47,7 @@ struct AspeedSMCFlash {
 #define TYPE_ASPEED_SMC "aspeed.smc"
 OBJECT_DECLARE_TYPE(AspeedSMCState, AspeedSMCClass, ASPEED_SMC)
 
-#define ASPEED_SMC_R_MAX        (0x100 / 4)
+#define ASPEED_SMC_R_MAX        (0x300 / 4)
 #define ASPEED_SMC_CS_MAX       5
 
 struct AspeedSMCState {
@@ -114,6 +114,7 @@ struct AspeedSMCClass {
                            AspeedSegments *seg);
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);
     int (*addr_width)(const AspeedSMCState *s);
+    int (*data_fifo_offset_to_cs)(const AspeedSMCState *s, uint32_t offset);
     const MemoryRegionOps *reg_ops;
 };
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index c8cc6cfa56e4..bf596f7b2d68 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -163,6 +163,9 @@
 /* Read Timing Compensation Register */
 #define R_TIMINGS         (0x94 / 4)
 
+/* Data fifo */
+#define R_DATA_FIFO       (0x200 / 4)
+
 /* SPI controller registers and bits (AST2400) */
 #define R_SPI_CONF        (0x00 / 4)
 #define   SPI_CONF_ENABLE_W0   0
@@ -209,6 +212,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[];
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4
 #define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08
+#define ASPEED_SMC_FEATURE_DATA_FIFO 0x10
 
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)
 {
@@ -225,6 +229,11 @@ static inline bool aspeed_smc_has_dma64(const AspeedSMCClass *asc)
     return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);
 }
 
+static inline bool aspeed_smc_has_data_fifo(const AspeedSMCClass *asc)
+{
+    return !!(asc->features & ASPEED_SMC_FEATURE_DATA_FIFO);
+}
+
 #define aspeed_smc_error(fmt, ...)                                      \
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS__)
 
@@ -664,6 +673,7 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
 {
     AspeedSMCState *s = ASPEED_SMC(opaque);
     AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(opaque);
+    int cs;
 
     addr >>= 2;
 
@@ -689,6 +699,18 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);
 
         *data = s->regs[addr];
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >= R_DATA_FIFO) {
+        cs = asc->data_fifo_offset_to_cs(s, addr << 2);
+        if (cs >= 0) {
+            /*
+             * Data fifo mode only supports SPI user mode.
+             * The flash address is provided by the SPI command/address cycles,
+             * the MMIO addr parameter is ignored.
+             */
+            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, attrs);
+        }
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
+        return MEMTX_ERROR;
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
@@ -1063,6 +1085,19 @@ static MemTxResult aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
     } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&
                addr == R_DMA_DRAM_ADDR_HIGH) {
         s->regs[addr] = DMA_DRAM_ADDR_HIGH(value);
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >= R_DATA_FIFO) {
+        int cs = asc->data_fifo_offset_to_cs(s, addr << 2);
+        if (cs >= 0) {
+            /*
+             * Data fifo mode only supports SPI user mode.
+             * The flash address is provided by the SPI command/address cycles,
+             * the MMIO addr parameter is ignored.
+             */
+            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,
+                                          attrs);
+        }
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
+        return MEMTX_ERROR;
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
@@ -1183,8 +1218,8 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
-    .version_id = 3,
-    .minimum_version_id = 1,
+    .version_id = 4,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
         VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
@@ -1808,6 +1843,39 @@ static void aspeed_2700_smc_reg_to_segment(const AspeedSMCState *s,
     }
 }
 
+/*
+ * Convert a data fifo offset to a chip select (CS).
+ *
+ * Data fifo access starts at 0x200. The data fifo offset index is
+ * calculated by subtracting the data fifo base offset from the MMIO address.
+ *
+ * The data fifo offset index increments by 1 for every 16MB of flash address
+ * space. Each offset step therefore represents a 16MB address decode range.
+ *
+ * The CS is determined by matching the data fifo offset index against the
+ * segment start address of each CS.
+ *
+ * Returns the CS index on success, or -1 if the offset is invalid.
+ */
+static int aspeed_2700_smc_data_fifo_offset_to_cs(const AspeedSMCState *s,
+                                                  uint32_t offset)
+{
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+    uint32_t start_offset;
+    uint32_t fifo_offset;
+    int i;
+
+    for (i = 0; i < asc->cs_num_max; i++) {
+        start_offset = (s->regs[R_SEG_ADDR0 + i] & 0x0000ffff) << 16;
+        fifo_offset = start_offset / 0x1000000;
+        if (fifo_offset == offset - (R_DATA_FIFO << 2)) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
 static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] = {
     [R_CONF] = (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |
             CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),
@@ -1842,6 +1910,27 @@ static const AspeedSegments aspeed_2700_fmc_segments[] = {
     { 0x0, 0 }, /* disabled */
 };
 
+/*
+ * AST2700 supports data fifo mode with a base data fifo start offset of 0x200.
+ *
+ * The data fifo start offset increments by 1 for every 16MB of flash address
+ * space. Each offset step therefore represents a 16MB address decode range.
+ *
+ * Assuming each chip select (CS) can use the maximum flash size of 256MB:
+ *   256MB / 16MB = 0x10 offset steps per CS.
+ *
+ * Data fifo start offset for CSn:
+ *   0x200 + (n * 0x10)
+ *
+ * Examples:
+ *   CS0: 0x200
+ *   CS1: 0x210
+ *   CS2: 0x220
+ *   CS3: 0x230
+ *
+ * asc->nregs should be set to: 0x200 + (asc->cs_num_max * 0x10)
+ * to cover all possible data fifo regions.
+ */
 static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1861,14 +1950,16 @@ static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *data)
     asc->flash_window_base = 0x100000000;
     asc->flash_window_size = 1 * GiB;
     asc->features          = ASPEED_SMC_FEATURE_DMA |
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
+                             ASPEED_SMC_FEATURE_DATA_FIFO;
     asc->dma_flash_mask    = 0x2FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
-    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
     asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
@@ -1896,14 +1987,16 @@ static void aspeed_2700_spi0_class_init(ObjectClass *klass, const void *data)
     asc->flash_window_base = 0x180000000;
     asc->flash_window_size = 1 * GiB;
     asc->features          = ASPEED_SMC_FEATURE_DMA |
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
+                             ASPEED_SMC_FEATURE_DATA_FIFO;
     asc->dma_flash_mask    = 0x2FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
-    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
     asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
@@ -1930,14 +2023,16 @@ static void aspeed_2700_spi1_class_init(ObjectClass *klass, const void *data)
     asc->flash_window_base = 0x200000000;
     asc->flash_window_size = 1 * GiB;
     asc->features          = ASPEED_SMC_FEATURE_DMA |
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
+                             ASPEED_SMC_FEATURE_DATA_FIFO;
     asc->dma_flash_mask    = 0x2FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
-    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
     asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
@@ -1964,14 +2059,16 @@ static void aspeed_2700_spi2_class_init(ObjectClass *klass, const void *data)
     asc->flash_window_base = 0x280000000;
     asc->flash_window_size = 1 * GiB;
     asc->features          = ASPEED_SMC_FEATURE_DMA |
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |
+                             ASPEED_SMC_FEATURE_DATA_FIFO;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0xFFFFFFFC;
     asc->dma_start_length  = 1;
-    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->nregs             = (0x200 + (asc->cs_num_max * 0x10)) >> 2;
     asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
     asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->data_fifo_offset_to_cs = aspeed_2700_smc_data_fifo_offset_to_cs;
     asc->reg_ops           = &aspeed_2700_smc_flash_ops;
 }
 
-- 
2.55.0


