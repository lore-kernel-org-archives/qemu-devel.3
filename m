Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B9BC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1Lw-0003gU-AX; Fri, 14 Jun 2024 03:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lu-0003dU-3H
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI1Lq-0000o2-QK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718350078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHYjj6xTVqULwYhf+vn1Jxw3e4hRDsjf++C3P7WZwn0=;
 b=eRDI5fRpV/9uqX9e9lIPET00mqt4CgaNKKgc6OYA3sKCsxupFsIBGBRcHA6Ta56pvOAp9u
 LE0SAgzKIRBtKCpbS+T6txrgL5XJ8/76vfknRsodHeos1Ddw9kj5deBsrEtRjcixTt6bUf
 bwRMBM2cZMglYziEin5HP4GZTXivLrA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-HLuNhVBhMkeXczyMOLB5bg-1; Fri,
 14 Jun 2024 03:27:50 -0400
X-MC-Unique: HLuNhVBhMkeXczyMOLB5bg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E43A11956095; Fri, 14 Jun 2024 07:27:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F627300021A; Fri, 14 Jun 2024 07:27:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/19] aspeed/smc: Add AST2700 support
Date: Fri, 14 Jun 2024 09:26:12 +0200
Message-ID: <20240614072620.1262053-12-clg@redhat.com>
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

AST2700 fmc/spi controller's address decoding unit is 64KB
and only bits [31:16] are used for decoding. Introduce seg_to_reg
and reg_to_seg handlers for ast2700 fmc/spi controller.
In addition, adds ast2700 fmc, spi0, spi1, and spi2 class init handler.

AST2700 is a 64 bits quad core CPUs(Cortex-a35). Introduce a new
"aspeed_2700_smc_flash_ops" and set its valid "max_access_size"
8 for 64 bits data format access.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ssi/aspeed_smc.c | 234 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 129d06690d36..49205ab76d38 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -185,7 +185,7 @@
  *   0: 4 bytes
  *   0x1FFFFFC: 32M bytes
  *
- * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
+ * DMA length is from 1 byte to 32MB (AST2600, AST10x0 and AST2700)
  *   0: 1 byte
  *   0x1FFFFFF: 32M bytes
  */
@@ -1938,6 +1938,234 @@ static const TypeInfo aspeed_1030_spi2_info = {
     .class_init = aspeed_1030_spi2_class_init,
 };
 
+/*
+ * The FMC Segment Registers of the AST2700 have a 64KB unit.
+ * Only bits [31:16] are used for decoding.
+ */
+#define AST2700_SEG_ADDR_MASK 0xffff0000
+
+static uint32_t aspeed_2700_smc_segment_to_reg(const AspeedSMCState *s,
+                                               const AspeedSegments *seg)
+{
+    uint32_t reg = 0;
+
+    /* Disabled segments have a nil register */
+    if (!seg->size) {
+        return 0;
+    }
+
+    reg |= (seg->addr & AST2700_SEG_ADDR_MASK) >> 16; /* start offset */
+    reg |= (seg->addr + seg->size - 1) & AST2700_SEG_ADDR_MASK; /* end offset */
+    return reg;
+}
+
+static void aspeed_2700_smc_reg_to_segment(const AspeedSMCState *s,
+                                           uint32_t reg, AspeedSegments *seg)
+{
+    uint32_t start_offset = (reg << 16) & AST2700_SEG_ADDR_MASK;
+    uint32_t end_offset = reg & AST2700_SEG_ADDR_MASK;
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+
+    if (reg) {
+        seg->addr = asc->flash_window_base + start_offset;
+        seg->size = end_offset + (64 * KiB) - start_offset;
+    } else {
+        seg->addr = asc->flash_window_base;
+        seg->size = 0;
+    }
+}
+
+static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] = {
+    [R_CONF] = (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |
+            CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),
+    [R_CE_CTRL] = 0x0000aa00,
+    [R_CTRL0] = 0x406b0641,
+    [R_CTRL1] = 0x00000400,
+    [R_CTRL2] = 0x00000400,
+    [R_CTRL3] = 0x00000400,
+    [R_SEG_ADDR0] = 0x08000000,
+    [R_SEG_ADDR1] = 0x10000800,
+    [R_SEG_ADDR2] = 0x00000000,
+    [R_SEG_ADDR3] = 0x00000000,
+    [R_DUMMY_DATA] = 0x00010000,
+    [R_DMA_DRAM_ADDR_HIGH] = 0x00000000,
+    [R_TIMINGS] = 0x007b0000,
+};
+
+static const MemoryRegionOps aspeed_2700_smc_flash_ops = {
+    .read = aspeed_smc_flash_read,
+    .write = aspeed_smc_flash_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static const AspeedSegments aspeed_2700_fmc_segments[] = {
+    { 0x0, 128 * MiB }, /* start address is readonly */
+    { 128 * MiB, 128 * MiB }, /* default is disabled but needed for -kernel */
+    { 256 * MiB, 128 * MiB }, /* default is disabled but needed for -kernel */
+    { 0x0, 0 }, /* disabled */
+};
+
+static void aspeed_2700_fmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
+
+    dc->desc               = "Aspeed 2700 FMC Controller";
+    asc->r_conf            = R_CONF;
+    asc->r_ce_ctrl         = R_CE_CTRL;
+    asc->r_ctrl0           = R_CTRL0;
+    asc->r_timings         = R_TIMINGS;
+    asc->nregs_timings     = 3;
+    asc->conf_enable_w0    = CONF_ENABLE_W0;
+    asc->cs_num_max        = 3;
+    asc->segments          = aspeed_2700_fmc_segments;
+    asc->segment_addr_mask = 0xffffffff;
+    asc->resets            = aspeed_2700_fmc_resets;
+    asc->flash_window_base = 0x100000000;
+    asc->flash_window_size = 1 * GiB;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+    asc->dma_flash_mask    = 0x2FFFFFFC;
+    asc->dma_dram_mask     = 0xFFFFFFFC;
+    asc->dma_start_length  = 1;
+    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
+    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
+    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
+}
+
+static const TypeInfo aspeed_2700_fmc_info = {
+    .name =  "aspeed.fmc-ast2700",
+    .parent = TYPE_ASPEED_SMC,
+    .class_init = aspeed_2700_fmc_class_init,
+};
+
+static const AspeedSegments aspeed_2700_spi0_segments[] = {
+    { 0x0, 128 * MiB }, /* start address is readonly */
+    { 128 * MiB, 128 * MiB }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+};
+
+static void aspeed_2700_spi0_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
+
+    dc->desc               = "Aspeed 2700 SPI0 Controller";
+    asc->r_conf            = R_CONF;
+    asc->r_ce_ctrl         = R_CE_CTRL;
+    asc->r_ctrl0           = R_CTRL0;
+    asc->r_timings         = R_TIMINGS;
+    asc->nregs_timings     = 2;
+    asc->conf_enable_w0    = CONF_ENABLE_W0;
+    asc->cs_num_max        = 2;
+    asc->segments          = aspeed_2700_spi0_segments;
+    asc->segment_addr_mask = 0xffffffff;
+    asc->flash_window_base = 0x180000000;
+    asc->flash_window_size = 1 * GiB;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+    asc->dma_flash_mask    = 0x2FFFFFFC;
+    asc->dma_dram_mask     = 0xFFFFFFFC;
+    asc->dma_start_length  = 1;
+    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
+    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
+    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
+}
+
+static const TypeInfo aspeed_2700_spi0_info = {
+    .name =  "aspeed.spi0-ast2700",
+    .parent = TYPE_ASPEED_SMC,
+    .class_init = aspeed_2700_spi0_class_init,
+};
+
+static const AspeedSegments aspeed_2700_spi1_segments[] = {
+    { 0x0, 128 * MiB }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+};
+
+static void aspeed_2700_spi1_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
+
+    dc->desc               = "Aspeed 2700 SPI1 Controller";
+    asc->r_conf            = R_CONF;
+    asc->r_ce_ctrl         = R_CE_CTRL;
+    asc->r_ctrl0           = R_CTRL0;
+    asc->r_timings         = R_TIMINGS;
+    asc->nregs_timings     = 2;
+    asc->conf_enable_w0    = CONF_ENABLE_W0;
+    asc->cs_num_max        = 2;
+    asc->segments          = aspeed_2700_spi1_segments;
+    asc->segment_addr_mask = 0xffffffff;
+    asc->flash_window_base = 0x200000000;
+    asc->flash_window_size = 1 * GiB;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+    asc->dma_flash_mask    = 0x2FFFFFFC;
+    asc->dma_dram_mask     = 0xFFFFFFFC;
+    asc->dma_start_length  = 1;
+    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
+    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
+    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
+}
+
+static const TypeInfo aspeed_2700_spi1_info = {
+        .name =  "aspeed.spi1-ast2700",
+        .parent = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2700_spi1_class_init,
+};
+
+static const AspeedSegments aspeed_2700_spi2_segments[] = {
+    { 0x0, 128 * MiB }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+};
+
+static void aspeed_2700_spi2_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
+
+    dc->desc               = "Aspeed 2700 SPI2 Controller";
+    asc->r_conf            = R_CONF;
+    asc->r_ce_ctrl         = R_CE_CTRL;
+    asc->r_ctrl0           = R_CTRL0;
+    asc->r_timings         = R_TIMINGS;
+    asc->nregs_timings     = 2;
+    asc->conf_enable_w0    = CONF_ENABLE_W0;
+    asc->cs_num_max        = 2;
+    asc->segments          = aspeed_2700_spi2_segments;
+    asc->segment_addr_mask = 0xffffffff;
+    asc->flash_window_base = 0x280000000;
+    asc->flash_window_size = 1 * GiB;
+    asc->features          = ASPEED_SMC_FEATURE_DMA |
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
+    asc->dma_flash_mask    = 0x0FFFFFFC;
+    asc->dma_dram_mask     = 0xFFFFFFFC;
+    asc->dma_start_length  = 1;
+    asc->nregs             = ASPEED_SMC_R_MAX;
+    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
+    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
+    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
+    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
+}
+
+static const TypeInfo aspeed_2700_spi2_info = {
+        .name =  "aspeed.spi2-ast2700",
+        .parent = TYPE_ASPEED_SMC,
+        .class_init = aspeed_2700_spi2_class_init,
+};
+
 static void aspeed_smc_register_types(void)
 {
     type_register_static(&aspeed_smc_flash_info);
@@ -1954,6 +2182,10 @@ static void aspeed_smc_register_types(void)
     type_register_static(&aspeed_1030_fmc_info);
     type_register_static(&aspeed_1030_spi1_info);
     type_register_static(&aspeed_1030_spi2_info);
+    type_register_static(&aspeed_2700_fmc_info);
+    type_register_static(&aspeed_2700_spi0_info);
+    type_register_static(&aspeed_2700_spi1_info);
+    type_register_static(&aspeed_2700_spi2_info);
 }
 
 type_init(aspeed_smc_register_types)
-- 
2.45.2


