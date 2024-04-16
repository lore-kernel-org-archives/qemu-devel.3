Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DC2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwezd-0003Rs-9Z; Tue, 16 Apr 2024 05:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rwez1-0002w6-HU; Tue, 16 Apr 2024 05:20:09 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rweyz-0007iy-Ld; Tue, 16 Apr 2024 05:20:07 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 17:19:08 +0800
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
Subject: [PATCH v3 08/16] aspeed/smc: support 64 bits dma dram address
Date: Tue, 16 Apr 2024 17:18:55 +0800
Message-ID: <20240416091904.935283-9-jamin_lin@aspeedtech.com>
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

AST2700 support the maximum dram size is 8GiB
and has a "DMA DRAM Side Address High Part(0x7C)"
register to support 64 bits dma dram address.
Add helper routines functions to compute the dma dram
address, new features and update trace-event
to support 64 bits dram address.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/ssi/aspeed_smc.c | 66 +++++++++++++++++++++++++++++++++++++++------
 hw/ssi/trace-events |  2 +-
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 71abc7a2d8..a67cac3d0f 100644
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
 
+static inline bool aspeed_smc_has_dma_dram_addr_high(const AspeedSMCClass *asc)
+{
+    return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);
+}
+
 #define aspeed_smc_error(fmt, ...)                                      \
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS__)
 
@@ -747,6 +757,9 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         (aspeed_smc_has_dma(asc) && addr == R_DMA_CTRL) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_FLASH_ADDR) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_DRAM_ADDR) ||
+        (aspeed_smc_has_dma(asc) &&
+         aspeed_smc_has_dma_dram_addr_high(asc) &&
+         addr == R_DMA_DRAM_ADDR_HIGH) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN) ||
         (aspeed_smc_has_dma(asc) && addr == R_DMA_CHECKSUM) ||
         (addr >= R_SEG_ADDR0 &&
@@ -847,6 +860,23 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
     }
 }
 
+static uint64_t aspeed_smc_dma_dram_addr(AspeedSMCState *s)
+{
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+    uint64_t dram_addr_high;
+    uint64_t dma_dram_addr;
+
+    if (aspeed_smc_has_dma_dram_addr_high(asc)) {
+        dram_addr_high = s->regs[R_DMA_DRAM_ADDR_HIGH];
+        dram_addr_high <<= 32;
+        dma_dram_addr = dram_addr_high | s->regs[R_DMA_DRAM_ADDR];
+    } else {
+        dma_dram_addr = s->regs[R_DMA_DRAM_ADDR];
+    }
+
+    return dma_dram_addr;
+}
+
 static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
 {
     AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
@@ -914,24 +944,34 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
 
 static void aspeed_smc_dma_rw(AspeedSMCState *s)
 {
+    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
+    uint64_t dram_addr_high;
+    uint64_t dma_dram_addr;
+    uint64_t dram_addr;
     MemTxResult result;
     uint32_t dma_len;
     uint32_t data;
 
     dma_len = aspeed_smc_dma_len(s);
+    dma_dram_addr = aspeed_smc_dma_dram_addr(s);
+
+    if (aspeed_smc_has_dma_dram_addr_high(asc)) {
+        dram_addr = dma_dram_addr - s->dram_mr->container->addr;
+    } else {
+        dram_addr = dma_dram_addr;
+    }
 
     trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
                             "write" : "read",
                             s->regs[R_DMA_FLASH_ADDR],
-                            s->regs[R_DMA_DRAM_ADDR],
+                            dram_addr,
                             dma_len);
     while (dma_len) {
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
 
@@ -951,11 +991,10 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
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
@@ -964,8 +1003,15 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
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
         dma_len -= 4;
         s->regs[R_DMA_LEN] = dma_len;
         s->regs[R_DMA_CHECKSUM] += data;
@@ -1118,6 +1164,10 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
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
 
-- 
2.25.1


