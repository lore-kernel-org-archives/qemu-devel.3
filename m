Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E4C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaRQ-0002KS-5i; Thu, 29 Feb 2024 02:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfaRO-0002Hv-6B; Thu, 29 Feb 2024 02:02:50 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX02.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfaRL-0003DK-Ad; Thu, 29 Feb 2024 02:02:49 -0500
Received: from TWMBX03.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Feb
 2024 15:02:36 +0800
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX03.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Feb
 2024 15:03:33 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Feb 2024 15:02:36 +0800
To: <qemu-devel@nongnu.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Alistair
 Francis" <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <jamin_lin@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 4/8] aspeed/smc: Add AST2700 support
Date: Thu, 29 Feb 2024 15:02:29 +0800
Message-ID: <20240229070233.463502-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229070233.463502-1-jamin_lin@aspeedtech.com>
References: <20240229070233.463502-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX02.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

AST2700 support the maximum dram size is 8GiB.
Update dma_rw function and trace-event to support 64 bits dram
address. DMA length is from 1 byte to 32MB for AST2700, AST2600 and AST10x0
and DMA length is from 4 bytes to 32MB for AST2500.

In other words, if "R_DMA_LEN" is 0, it should move at least 1 byte
data for AST2700, AST2600 and AST10x0 and 4 bytes data for AST2500.
To support all ASPEED SOCs, adds dma_start_length parameter to store
the start length and update DMA_LENGTH mask to "1FFFFFF" to fix dma moving
incorrect data length issue.

Currently, dma_rw function only supports length 4 bytes aligned.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/ssi/aspeed_smc.c         | 326 +++++++++++++++++++++++++++++++++---
 hw/ssi/trace-events         |   2 +-
 include/hw/ssi/aspeed_smc.h |   1 +
 3 files changed, 309 insertions(+), 20 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 3c93936fd1..73121edf2b 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -131,6 +131,9 @@
 #define   FMC_WDT2_CTRL_BOOT_SOURCE      BIT(4) /* O: primary 1: alternate */
 #define   FMC_WDT2_CTRL_EN               BIT(0)
 
+/* DMA DRAM Side Address High Part (AST2700) */
+#define R_DMA_DRAM_ADDR_HIGH   (0x7c / 4)
+
 /* DMA Control/Status Register */
 #define R_DMA_CTRL        (0x80 / 4)
 #define   DMA_CTRL_REQUEST      (1 << 31)
@@ -177,13 +180,18 @@
  * DMA flash addresses should be 4 bytes aligned and the valid address
  * range is 0x20000000 - 0x2FFFFFFF.
  *
- * DMA length is from 4 bytes to 32MB
+ * DMA length is from 4 bytes to 32MB (AST2500)
  *   0: 4 bytes
  *   0x7FFFFF: 32M bytes
+ *
+ * DMA length is from 1 byte to 32MB (AST2600, AST10x0 and AST2700)
+ *   0: 1 byte
+ *   0x1FFFFFF: 32M bytes
  */
 #define DMA_DRAM_ADDR(asc, val)   ((val) & (asc)->dma_dram_mask)
+#define DMA_DRAM_ADDR_HIGH(val)   ((val) & 0xf)
 #define DMA_FLASH_ADDR(asc, val)  ((val) & (asc)->dma_flash_mask)
-#define DMA_LENGTH(val)         ((val) & 0x01FFFFFC)
+#define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
 
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
@@ -202,6 +210,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[];
 #define ASPEED_SMC_FEATURE_DMA       0x1
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4
+#define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08
 
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)
 {
@@ -213,6 +222,11 @@ static inline bool aspeed_smc_has_wdt_control(const AspeedSMCClass *asc)
     return !!(asc->features & ASPEED_SMC_FEATURE_WDT_CONTROL);
 }
 
+static inline bool aspeed_smc_has_dma_dram_addr_high(const AspeedSMCClass *asc)
+{
+    return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);
+}
+
 #define aspeed_smc_error(fmt, ...)                                      \
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS__)
 
@@ -655,7 +669,7 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-        .max_access_size = 4,
+        .max_access_size = 8,
     },
 };
 
@@ -734,6 +748,9 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         (aspeed_smc_has_dma(asc) && addr == R_DMA_CTRL) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_FLASH_ADDR) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_DRAM_ADDR) ||
+        (aspeed_smc_has_dma(asc) &&
+         aspeed_smc_has_dma_dram_addr_high(asc) &&
+         addr == R_DMA_DRAM_ADDR_HIGH) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_CHECKSUM) ||
         (addr >= R_SEG_ADDR0 &&
@@ -840,8 +857,11 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
  */
 static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 {
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
     MemTxResult result;
+    uint32_t dma_len;
     uint32_t data;
+    uint32_t extra;
 
     if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
         aspeed_smc_error("invalid direction for DMA checksum");
@@ -852,7 +872,14 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
         aspeed_smc_dma_calibration(s);
     }
 
-    while (s->regs[R_DMA_LEN]) {
+    dma_len = s->regs[R_DMA_LEN] + asc->dma_start_length;
+    /* dma length 4 bytes aligned */
+    extra = dma_len % 4;
+    if (extra != 0) {
+        dma_len += 4 - extra;
+    }
+
+    while (dma_len) {
         data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
                                     MEMTXATTRS_UNSPECIFIED, &result);
         if (result != MEMTX_OK) {
@@ -868,7 +895,8 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
          */
         s->regs[R_DMA_CHECKSUM] += data;
         s->regs[R_DMA_FLASH_ADDR] += 4;
-        s->regs[R_DMA_LEN] -= 4;
+        dma_len -= 4;
+        s->regs[R_DMA_LEN] = dma_len;
     }
 
     if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
@@ -879,21 +907,44 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 
 static void aspeed_smc_dma_rw(AspeedSMCState *s)
 {
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+    uint64_t dram_addr_high;
+    uint64_t dma_dram_addr;
+    uint64_t dram_addr;
     MemTxResult result;
+    uint32_t dma_len;
     uint32_t data;
+    uint32_t extra;
+
+    if (aspeed_smc_has_dma_dram_addr_high(asc)) {
+        dram_addr_high = s->regs[R_DMA_DRAM_ADDR_HIGH];
+        dram_addr_high <<= 32;
+        dma_dram_addr = dram_addr_high | s->regs[R_DMA_DRAM_ADDR];
+        dram_addr = dma_dram_addr - s->dram_mr->container->addr;
+    } else {
+        dma_dram_addr = s->regs[R_DMA_DRAM_ADDR];
+        dram_addr = dma_dram_addr;
+    }
+
+    dma_len = s->regs[R_DMA_LEN] + asc->dma_start_length;
+    /* dma length 4 bytes aligned */
+    extra = dma_len % 4;
+    if (extra != 0) {
+        dma_len += 4 - extra;
+    }
 
     trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
                             "write" : "read",
                             s->regs[R_DMA_FLASH_ADDR],
-                            s->regs[R_DMA_DRAM_ADDR],
-                            s->regs[R_DMA_LEN]);
-    while (s->regs[R_DMA_LEN]) {
+                            dram_addr,
+                            dma_len);
+
+    while (dma_len) {
         if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
-            data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
+            data = address_space_ldl_le(&s->dram_as, dram_addr,
                                         MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
-                aspeed_smc_error("DRAM read failed @%08x",
-                                 s->regs[R_DMA_DRAM_ADDR]);
+                aspeed_smc_error("DRAM read failed @%" PRIx64, dram_addr);
                 return;
             }
 
@@ -913,11 +964,10 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
                 return;
             }
 
-            address_space_stl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
+            address_space_stl_le(&s->dram_as, dram_addr,
                                  data, MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
-                aspeed_smc_error("DRAM write failed @%08x",
-                                 s->regs[R_DMA_DRAM_ADDR]);
+                aspeed_smc_error("DRAM write failed @%" PRIx64, dram_addr);
                 return;
             }
         }
@@ -926,10 +976,18 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
          * When the DMA is on-going, the DMA registers are updated
          * with the current working addresses and length.
          */
+        dram_addr += 4;
+        dma_dram_addr += 4;
+        if (aspeed_smc_has_dma_dram_addr_high(asc)) {
+            dram_addr_high = dma_dram_addr >> 32;
+            s->regs[R_DMA_DRAM_ADDR_HIGH] = dram_addr_high;
+        }
+
+        s->regs[R_DMA_DRAM_ADDR] = dma_dram_addr & 0xffffffff;
         s->regs[R_DMA_FLASH_ADDR] += 4;
-        s->regs[R_DMA_DRAM_ADDR] += 4;
-        s->regs[R_DMA_LEN] -= 4;
         s->regs[R_DMA_CHECKSUM] += data;
+        dma_len -= 4;
+        s->regs[R_DMA_LEN] = dma_len;
     }
 }
 
@@ -1079,6 +1137,10 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
     } else if (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN &&
                aspeed_smc_dma_granted(s)) {
         s->regs[addr] = DMA_LENGTH(value);
+    } else if (aspeed_smc_has_dma(asc) &&
+               aspeed_smc_has_dma_dram_addr_high(asc) &&
+               addr == R_DMA_DRAM_ADDR_HIGH) {
+        s->regs[addr] = DMA_DRAM_ADDR_HIGH(value);
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
@@ -1372,6 +1434,7 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x1FFFFFFC;
+    asc->dma_start_length  = 4;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
@@ -1439,7 +1502,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
 
-    dc->desc               = "Aspeed 2600 FMC Controller";
+    dc->desc               = "Aspeed 2500 FMC Controller";
     asc->r_conf            = R_CONF;
     asc->r_ce_ctrl         = R_CE_CTRL;
     asc->r_ctrl0           = R_CTRL0;
@@ -1455,6 +1518,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 4;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
@@ -1477,7 +1541,7 @@ static void aspeed_2500_spi1_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
 
-    dc->desc               = "Aspeed 2600 SPI1 Controller";
+    dc->desc               = "Aspeed 2500 SPI1 Controller";
     asc->r_conf            = R_CONF;
     asc->r_ce_ctrl         = R_CE_CTRL;
     asc->r_ctrl0           = R_CTRL0;
@@ -1512,7 +1576,7 @@ static void aspeed_2500_spi2_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
 
-    dc->desc               = "Aspeed 2600 SPI2 Controller";
+    dc->desc               = "Aspeed 2500 SPI2 Controller";
     asc->r_conf            = R_CONF;
     asc->r_ce_ctrl         = R_CE_CTRL;
     asc->r_ctrl0           = R_CTRL0;
@@ -1611,6 +1675,7 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_WDT_CONTROL;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1649,6 +1714,7 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_DMA_GRANT;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1688,6 +1754,7 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_DMA_GRANT;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1769,6 +1836,7 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_1030_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_1030_smc_reg_to_segment;
@@ -1806,6 +1874,7 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1842,6 +1911,7 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1854,6 +1924,220 @@ static const TypeInfo aspeed_1030_spi2_info = {
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
@@ -1870,6 +2154,10 @@ static void aspeed_smc_register_types(void)
     type_register_static(&aspeed_1030_fmc_info);
     type_register_static(&aspeed_1030_spi1_info);
     type_register_static(&aspeed_1030_spi2_info);
+    type_register_static(&aspeed_2700_fmc_info);
+    type_register_static(&aspeed_2700_spi0_info);
+    type_register_static(&aspeed_2700_spi1_info);
+    type_register_static(&aspeed_2700_spi2_info);
 }
 
 type_init(aspeed_smc_register_types)
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2d5bd2b83d..7b5ad6a939 100644
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
 
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 8e1dda556b..f359ed22cc 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -106,6 +106,7 @@ struct AspeedSMCClass {
     uint32_t features;
     hwaddr dma_flash_mask;
     hwaddr dma_dram_mask;
+    uint32_t dma_start_length;
     uint32_t nregs;
     uint32_t (*segment_to_reg)(const AspeedSMCState *s,
                                const AspeedSegments *seg);
-- 
2.25.1


