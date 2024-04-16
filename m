Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC52C04FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf0R-0004Mb-25; Tue, 16 Apr 2024 05:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwez5-0002zg-1k; Tue, 16 Apr 2024 05:20:13 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwez2-0007iy-Ci; Tue, 16 Apr 2024 05:20:10 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 17:19:09 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 17:19:08 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 09/16] aspeed/smc: Add AST2700 support
Date: Tue, 16 Apr 2024 17:18:56 +0800
Message-ID: <20240416091904.935283-10-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST2700 fmc/spi controller's address decoding unit is 64KB
and only bits [31:16] are used for decoding. Introduce seg_to_reg
and reg_to_seg handlers for ast2700 fmc/spi controller.
In addition, adds ast2700 fmc, spi0, spi1, and spi2 class init handler.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/ssi/aspeed_smc.c | 222 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index a67cac3d0f..e768e5463c 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -185,7 +185,7 @@
  *   0: 4 bytes
  *   0x7FFFFF: 32M bytes
  *
- * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
+ * DMA length is from 1 byte to 32MB (AST2600, AST10x0 and AST2700)
  *   0: 1 byte
  *   0x1FFFFFF: 32M bytes
  */
@@ -670,7 +670,7 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-        .max_access_size = 4,
+        .max_access_size = 8,
     },
 };
 
@@ -1951,6 +1951,220 @@ static const TypeInfo aspeed_1030_spi2_info = {
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
@@ -1967,6 +2181,10 @@ static void aspeed_smc_register_types(void)
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
2.25.1


