Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2343DCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 15:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNXvn-00033u-Mn; Thu, 14 May 2026 11:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNXvl-00033Q-SV; Thu, 14 May 2026 11:24:57 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wNXvj-0001a4-Bo; Thu, 14 May 2026 11:24:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E76160172;
 Thu, 14 May 2026 15:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EB1C2BCC7;
 Thu, 14 May 2026 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778772291;
 bh=qPuh0AbgV7loQBaI01PCmwnEF0MV5AfC3XG2DLYCZhs=;
 h=From:To:Cc:Subject:Date:From;
 b=OgPJZ3omfJH8V5YpMkWP33AaQFBg0ra/5VypUj708Gijf/He0kS542cen+SQ7qdGR
 3cEOzkZCDCs94udnbrV3NZu1SEYM2H+oB4KA0Vpgk2ZYDednKZnQymsqZutZ+81uE1
 XQyVIVmcv2IMSoCpPxi42XYutu2EE6GL+hhLO9S+nH3oGGH0jObiIeJ9/bXUXbHvj6
 zF6/DCMVODn5XHz36JxBb4CDYsxoiAjSin3Uyll+eMI2CIo+miiK6dPJVtVrhg03NM
 T+Y8AVvlLLs3t+bdPsHdEOT+KurhS+TjIU4QhajZshXnC+DadXQiSdNwprovCyFgtt
 p7J6w6z3xZsLA==
From: Conor Dooley <conor@kernel.org>
To: qemu-riscv@nongnu.org
Cc: conor@kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org
Subject: [PATCH] hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg
 clock dividers
Date: Thu, 14 May 2026 16:23:26 +0100
Message-ID: <20260514-reference-overhand-749149e36a88@spud>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5904;
 i=conor.dooley@microchip.com; h=from:subject:message-id;
 bh=OuyCOXrXofVwTCfXG2M3CTUPRGU17dFqlL39D9xLdo0=;
 b=owGbwMvMwCVWscWwfUFT0iXG02pJDFmsL966JqmtnqL0du3boOMsgS/mzj/T6R0oUKZnZ3u8X
 +bhW8G3HaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI73KG/5G/OCKZPP+d1JPm
 FLEwPrzty36/ZWF/bou4vnV8M/Xy/IsM/0zOWbReE3FsF+E5svfy7tyklnlGs3cn5ixbe7S4puX
 XMkYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp;
 fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

Minimal clock register configuration required to boot Linux
without backtraces in the clock code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I added two more cases to the switch in mchp_pfsoc_sysreg compared to
Guenter's patch, cos I still saw 2 backtraces with his patch applied.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Guenter Roeck <linux@roeck-us.net>
CC: Alistair Francis <alistair.francis@wdc.com>
CC: Sebastian Huber <sebastian.huber@embedded-brains.de>
CC: qemu-riscv@nongnu.org
CC: qemu-devel@nongnu.org
---
 hw/misc/mchp_pfsoc_ioscb.c         | 47 +++++++++++++++++++++++++++++-
 hw/misc/mchp_pfsoc_sysreg.c        | 12 ++++++++
 include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 05538d012a..1267d6ba4a 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -53,6 +53,8 @@
 #define IOSCB_MAILBOX_BASE          0x07020800
 #define IOSCB_CFG_BASE              0x07080000
 #define IOSCB_CCC_BASE              0x08000000
+#define IOSCB_PLL_NW0_BASE          0x08100000
+#define IOSCB_PLL_NW1_BASE          0x08200000
 #define IOSCB_PLL_MSS_BASE          0x0E001000
 #define IOSCB_CFM_MSS_BASE          0x0E002000
 #define IOSCB_PLL_DDR_BASE          0x0E010000
@@ -92,6 +94,16 @@ static const MemoryRegionOps mchp_pfsoc_dummy_ops = {
 /* All PLL modules in IOSCB have the same register layout */
 
 #define PLL_CTRL    0x04
+#define PLL_REF_FB  0x08
+#define PLL_DIV_0_1 0x10
+#define PLL_DIV_2_3 0x14
+#define PLL_CTRL2   0x18
+#define PLL_CAL     0x1c
+#define PLL_PHADJ   0x20
+#define SSCG_REG_0  0x24
+#define SSCG_REG_1  0x28
+#define SSCG_REG_2  0x2c
+#define SSCG_REG_3  0x30
 
 static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
                                     unsigned size)
@@ -103,6 +115,22 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
         /* PLL is locked */
         val = BIT(25);
         break;
+    case PLL_DIV_0_1:
+    case PLL_DIV_2_3:
+        val = 0x01000100; /* return valid post divider values */
+        break;
+    case PLL_CTRL2:
+        val = 0x00001110;
+	break;
+    case PLL_REF_FB:
+        val = 0x00000100; /* RFDIV := 1 */
+        break;
+    case SSCG_REG_2:
+        val = 0x00000001; /* INTIN := 1 */
+	break;
+    case PLL_PHADJ:
+        val = 0x00000401;
+	break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
@@ -113,9 +141,18 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
     return val;
 }
 
+static void mchp_pfsoc_pll_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                       "(size %d, value 0x%" PRIx64
+                       ", offset 0x%" HWADDR_PRIx ")\n",
+                       __func__, size, value, offset);
+}
+
 static const MemoryRegionOps mchp_pfsoc_pll_ops = {
     .read = mchp_pfsoc_pll_read,
-    .write = mchp_pfsoc_dummy_write,
+    .write = mchp_pfsoc_pll_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -240,6 +277,14 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
                           "mchp.pfsoc.ioscb.ccc", IOSCB_CCC_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_CCC_BASE, &s->ccc);
 
+    memory_region_init_io(&s->pll_nw_0, OBJECT(s), &mchp_pfsoc_pll_ops, s,
+                          "mchp.pfsoc.ioscb.pll_nw_0", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_PLL_NW0_BASE, &s->pll_nw_0);
+
+    memory_region_init_io(&s->pll_nw_1, OBJECT(s), &mchp_pfsoc_pll_ops, s,
+                          "mchp.pfsoc.ioscb.pll_nw_1", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_PLL_NW1_BASE, &s->pll_nw_1);
+
     memory_region_init_io(&s->pll_mss, OBJECT(s), &mchp_pfsoc_pll_ops, s,
                           "mchp.pfsoc.ioscb.pll_mss", IOSCB_SUBMOD_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_PLL_MSS_BASE, &s->pll_mss);
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index f190ecc78e..09389d3b1f 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -29,6 +29,8 @@
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "system/runstate.h"
 
+#define CLOCK_CONFIG_CR 0x8
+#define RTC_CLOCK_CR    0xc
 #define MSS_RESET_CR    0x18
 #define ENVM_CR         0xb8
 #define MESSAGE_INT     0x118c
@@ -39,6 +41,16 @@ static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
     uint32_t val = 0;
 
     switch (offset) {
+    case CLOCK_CONFIG_CR:
+        /* Icicle kit reference design cpu/axi/ahb divider setting */
+        val = 0x24;
+        break;
+    case RTC_CLOCK_CR:
+        /* Bit 16 enables the RTC clock, 0x7d is the required divider
+         * setting for a 125 MHz reference.
+         */
+        val = BIT(16) | 0x7d;
+        break;
     case ENVM_CR:
         /* Indicate the eNVM is running at the configured divider rate */
         val = BIT(6);
diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index eaaa2ac5d9..9687ea25b1 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -35,6 +35,8 @@ typedef struct MchpPfSoCIoscbState {
     MemoryRegion mailbox;
     MemoryRegion cfg;
     MemoryRegion ccc;
+    MemoryRegion pll_nw_0;
+    MemoryRegion pll_nw_1;
     MemoryRegion pll_mss;
     MemoryRegion cfm_mss;
     MemoryRegion pll_ddr;
-- 
2.53.0


