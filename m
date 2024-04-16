Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072A2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwezK-00039i-H9; Tue, 16 Apr 2024 05:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rweyx-0002vc-8o; Tue, 16 Apr 2024 05:20:07 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rweyh-0007Zt-Qs; Tue, 16 Apr 2024 05:20:00 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 17:19:07 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 17:19:07 +0800
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
Subject: [PATCH v3 07/16] aspeed/smc: fix dma moving incorrect data length
 issue
Date: Tue, 16 Apr 2024 17:18:54 +0800
Message-ID: <20240416091904.935283-8-jamin_lin@aspeedtech.com>
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

DMA length is from 1 byte to 32MB for AST2600 and AST10x0
and DMA length is from 4 bytes to 32MB for AST2500.

In other words, if "R_DMA_LEN" is 0, it should move at least 1 byte
data for AST2600 and AST10x0 and 4 bytes data for AST2500.
To support all ASPEED SOCs, adds dma_start_length parameter to store
the start length, add helper routines function to compute the dma length
and update DMA_LENGTH mask to "1FFFFFF" to fix dma moving
incorrect data length issue.

Currently, only supports dma length 4 bytes aligned.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/ssi/aspeed_smc.c         | 52 ++++++++++++++++++++++++++++++++-----
 include/hw/ssi/aspeed_smc.h |  1 +
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 8a8d77b480..71abc7a2d8 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -178,13 +178,17 @@
  * DMA flash addresses should be 4 bytes aligned and the valid address
  * range is 0x20000000 - 0x2FFFFFFF.
  *
- * DMA length is from 4 bytes to 32MB
+ * DMA length is from 4 bytes to 32MB (AST2500)
  *   0: 4 bytes
  *   0x7FFFFF: 32M bytes
+ *
+ * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
+ *   0: 1 byte
+ *   0x1FFFFFF: 32M bytes
  */
 #define DMA_DRAM_ADDR(asc, val)   ((val) & (asc)->dma_dram_mask)
 #define DMA_FLASH_ADDR(asc, val)  ((val) & (asc)->dma_flash_mask)
-#define DMA_LENGTH(val)         ((val) & 0x01FFFFFC)
+#define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
 
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
@@ -843,6 +847,24 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
     }
 }
 
+static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
+{
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+    uint32_t dma_len;
+    uint32_t extra;
+
+    dma_len = s->regs[R_DMA_LEN] + asc->dma_start_length;
+
+    /* dma length 4 bytes aligned */
+    extra = dma_len % 4;
+
+    if (extra != 0) {
+        dma_len += 4 - extra;
+    }
+
+    return dma_len;
+}
+
 /*
  * Accumulate the result of the reads to provide a checksum that will
  * be used to validate the read timing settings.
@@ -850,6 +872,7 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
 static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 {
     MemTxResult result;
+    uint32_t dma_len;
     uint32_t data;
 
     if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
@@ -861,7 +884,9 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
         aspeed_smc_dma_calibration(s);
     }
 
-    while (s->regs[R_DMA_LEN]) {
+    dma_len = aspeed_smc_dma_len(s);
+
+    while (dma_len) {
         data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
                                     MEMTXATTRS_UNSPECIFIED, &result);
         if (result != MEMTX_OK) {
@@ -877,7 +902,8 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
          */
         s->regs[R_DMA_CHECKSUM] += data;
         s->regs[R_DMA_FLASH_ADDR] += 4;
-        s->regs[R_DMA_LEN] -= 4;
+        dma_len -= 4;
+        s->regs[R_DMA_LEN] = dma_len;
     }
 
     if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
@@ -889,14 +915,17 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 static void aspeed_smc_dma_rw(AspeedSMCState *s)
 {
     MemTxResult result;
+    uint32_t dma_len;
     uint32_t data;
 
+    dma_len = aspeed_smc_dma_len(s);
+
     trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
                             "write" : "read",
                             s->regs[R_DMA_FLASH_ADDR],
                             s->regs[R_DMA_DRAM_ADDR],
-                            s->regs[R_DMA_LEN]);
-    while (s->regs[R_DMA_LEN]) {
+                            dma_len);
+    while (dma_len) {
         if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
             data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
                                         MEMTXATTRS_UNSPECIFIED, &result);
@@ -937,7 +966,8 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
          */
         s->regs[R_DMA_FLASH_ADDR] += 4;
         s->regs[R_DMA_DRAM_ADDR] += 4;
-        s->regs[R_DMA_LEN] -= 4;
+        dma_len -= 4;
+        s->regs[R_DMA_LEN] = dma_len;
         s->regs[R_DMA_CHECKSUM] += data;
     }
 }
@@ -1381,6 +1411,7 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x1FFFFFFC;
+    asc->dma_start_length  = 4;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
@@ -1464,6 +1495,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 4;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_smc_reg_to_segment;
@@ -1620,6 +1652,7 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_WDT_CONTROL;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1658,6 +1691,7 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_DMA_GRANT;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1697,6 +1731,7 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
                              ASPEED_SMC_FEATURE_DMA_GRANT;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x3FFFFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1778,6 +1813,7 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_1030_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_1030_smc_reg_to_segment;
@@ -1815,6 +1851,7 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
@@ -1851,6 +1888,7 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
     asc->features          = ASPEED_SMC_FEATURE_DMA;
     asc->dma_flash_mask    = 0x0FFFFFFC;
     asc->dma_dram_mask     = 0x000BFFFC;
+    asc->dma_start_length  = 1;
     asc->nregs             = ASPEED_SMC_R_MAX;
     asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
     asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
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


