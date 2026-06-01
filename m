Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC056CD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsRh-0007J3-Ae; Sun, 31 May 2026 22:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRg-0007Ia-98; Sun, 31 May 2026 22:32:04 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRe-0004V7-6Y; Sun, 31 May 2026 22:32:04 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 10:31:49 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 10:31:49 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 1/6] hw/misc/aspeed_scu: Add AST1040 SCU model
Date: Mon, 1 Jun 2026 10:31:42 +0800
Message-ID: <20260601023149.2309299-2-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
References: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=twmbx01.aspeedtech.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add an AST1040 variant of the ASPEED SCU with reset values, APB clock calculation, clock-stop handling, and CPTRA page-select registers.

Expose the Caliptra page aperture as a QOM link so the SoC model can wire the remap window without callbacks.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 include/hw/misc/aspeed_scu.h |  10 ++
 hw/misc/aspeed_scu.c         | 251 +++++++++++++++++++++++++++++++++++
 hw/misc/trace-events         |   2 +
 3 files changed, 263 insertions(+)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index c30940ab76..6445ae5cf4 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -22,6 +22,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEED_SCU)
 #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"
 #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"
 #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"
+#define TYPE_ASPEED_1040_SCU TYPE_ASPEED_SCU "-ast1040"
 
 #define ASPEED_SCU_NR_REGS (0x1A8 >> 2)
 #define ASPEED_AST2600_SCU_NR_REGS (0xE20 >> 2)
@@ -39,6 +40,15 @@ struct AspeedSCUState {
     uint32_t hw_strap1;
     uint32_t hw_strap2;
     uint32_t hw_prot_key;
+
+    /*
+     * AST1040 only: alias region (the Caliptra MCI page aperture) whose
+     * target offset is selected by SCU_CPTRA_PAGE_REG0, linked in by the SoC.
+     * cptra_page_window_base is its base in the address map, used to reject a
+     * self-referential remap.
+     */
+    MemoryRegion *cptra_page_window;
+    uint64_t cptra_page_window_base;
 };
 
 #define AST2400_A1_SILICON_REV   0x02010303U
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 19da6c075f..028677880f 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -17,6 +17,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/range.h"
 #include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "trace.h"
@@ -179,6 +180,41 @@
 #define AST2700_SCUIO_CLK_DUTY_MEAS_RST TO_REG(0x388)
 #define AST2700_SCUIO_FREQ_CNT_CTL      TO_REG(0x3A0)
 
+/* AST1040 SCU */
+#define AST1040_SILICON_REV              TO_REG(0x00)
+#define AST1040_HW_STRAP1                TO_REG(0x10)
+#define AST1040_HW_STRAP1_CLR            TO_REG(0x14)
+#define AST1040_HW_STRAP1_LOCK           TO_REG(0x20)
+#define AST1040_HW_STRAP1_SEC1           TO_REG(0x24)
+#define AST1040_SCU_CPTRA_PAGE_REG0      TO_REG(0x120)
+#define AST1040_SCU_CPTRA_PAGE_REG1      TO_REG(0x124)
+#define AST1040_SCU_CPTRA_PAGE_REG2      TO_REG(0x128)
+#define AST1040_SCU_CPTRA_PAGE_REG3      TO_REG(0x12C)
+#define AST1040_SCU_CPTRA_PAGE_REG4      TO_REG(0x130)
+#define AST1040_SCU_CPTRA_PAGE_REG5      TO_REG(0x134)
+#define AST1040_SCU_CLK_STOP_CTL_1       TO_REG(0x240)
+#define AST1040_SCU_CLK_STOP_CLR_1       TO_REG(0x244)
+#define AST1040_SCU_CLK_STOP_CTL_2       TO_REG(0x260)
+#define AST1040_SCU_CLK_STOP_CLR_2       TO_REG(0x264)
+#define AST1040_SCU_CLK_SEL_1            TO_REG(0x280)
+#define AST1040_SCU_CLK_SEL_2            TO_REG(0x284)
+#define AST1040_SCU_HPLL_PARAM           TO_REG(0x300)
+#define AST1040_SCU_HPLL_EXT_PARAM       TO_REG(0x304)
+#define AST1040_SCU_APLL_PARAM           TO_REG(0x310)
+#define AST1040_SCU_APLL_EXT_PARAM       TO_REG(0x314)
+#define AST1040_SCU_DPLL_PARAM           TO_REG(0x320)
+#define AST1040_SCU_DPLL_EXT_PARAM       TO_REG(0x324)
+#define AST1040_SCU_DPLL_PARAM_READ      TO_REG(0x328)
+#define AST1040_SCU_DPLL_EXT_PARAM_READ  TO_REG(0x32c)
+#define AST1040_SCU_UARTCLK_GEN          TO_REG(0x330)
+#define AST1040_SCU_HUARTCLK_GEN         TO_REG(0x334)
+#define AST1040_SCU_CLK_DUTY_MEAS_RST    TO_REG(0x388)
+#define AST1040_SCU_FREQ_CNT_CTL         TO_REG(0x3A0)
+#define AST1040_SCU_CLK_GET_PCLK_DIV(x) (((x) >> 18) & 0x7)
+
+#define ASPEED_AST1040_SCU_NR_REGS       (0xE20 >> 2)
+#define AST1040_SCU_CPTRA_PAGE_SIZE      0x1000
+
 #define SCU_IO_REGION_SIZE 0x1000
 
 static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] = {
@@ -1165,6 +1201,220 @@ static const TypeInfo aspeed_1030_scu_info = {
     .class_init = aspeed_1030_scu_class_init,
 };
 
+/* AST1040 SCU */
+
+static void aspeed_ast1040_scu_update_cptra_page(AspeedSCUState *s)
+{
+    hwaddr page_base = s->regs[AST1040_SCU_CPTRA_PAGE_REG0] &
+                       ~(hwaddr)(AST1040_SCU_CPTRA_PAGE_SIZE - 1);
+
+    if (!s->cptra_page_window) {
+        return;
+    }
+
+    if (ranges_overlap(page_base, AST1040_SCU_CPTRA_PAGE_SIZE,
+                       s->cptra_page_window_base,
+                       AST1040_SCU_CPTRA_PAGE_SIZE)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: refusing self-referential remap to 0x%" HWADDR_PRIx
+                      "\n", __func__, page_base);
+        memory_region_set_enabled(s->cptra_page_window, false);
+        return;
+    }
+
+    memory_region_set_alias_offset(s->cptra_page_window, page_base);
+    memory_region_set_enabled(s->cptra_page_window, true);
+}
+
+static uint64_t aspeed_ast1040_scu_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    AspeedSCUState *s = ASPEED_SCU(opaque);
+    int reg = TO_REG(offset);
+
+    if (reg >= ASPEED_AST1040_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    trace_aspeed_ast1040_scu_read(offset, size, s->regs[reg]);
+    return s->regs[reg];
+}
+
+static void aspeed_ast1040_scu_write(void *opaque, hwaddr offset,
+                                     uint64_t data64, unsigned size)
+{
+    AspeedSCUState *s = ASPEED_SCU(opaque);
+    int reg = TO_REG(offset);
+    uint32_t data = data64;
+    bool updated = false;
+
+    if (reg >= ASPEED_AST1040_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    trace_aspeed_ast1040_scu_write(offset, size, data);
+
+    switch (reg) {
+    case AST1040_SCU_CLK_STOP_CTL_1:
+    case AST1040_SCU_CLK_STOP_CTL_2:
+        s->regs[reg] |= data;
+        updated = true;
+        break;
+    case AST1040_SCU_CLK_STOP_CLR_1:
+    case AST1040_SCU_CLK_STOP_CLR_2:
+        s->regs[reg - 1] &= ~data;
+        updated = true;
+        break;
+    case AST1040_SCU_FREQ_CNT_CTL:
+        s->regs[reg] = deposit32(s->regs[reg], 6, 1, !!(data & BIT(1)));
+        updated = true;
+        break;
+    case AST1040_SCU_CPTRA_PAGE_REG0:
+        s->regs[reg] = data;
+        aspeed_ast1040_scu_update_cptra_page(s);
+        updated = true;
+        break;
+    case AST1040_SCU_CPTRA_PAGE_REG1:
+    case AST1040_SCU_CPTRA_PAGE_REG2:
+    case AST1040_SCU_CPTRA_PAGE_REG3:
+    case AST1040_SCU_CPTRA_PAGE_REG4:
+    case AST1040_SCU_CPTRA_PAGE_REG5:
+        s->regs[reg] = data;
+        updated = true;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+
+    if (!updated) {
+        s->regs[reg] = data;
+    }
+}
+
+static const MemoryRegionOps aspeed_ast1040_scu_ops = {
+    .read       = aspeed_ast1040_scu_read,
+    .write      = aspeed_ast1040_scu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .valid.unaligned = false,
+};
+
+static uint32_t aspeed_1040_scu_calc_hpll(AspeedSCUState *s, uint32_t hpll_reg)
+{
+    uint32_t multiplier = 1;
+    uint32_t clkin = aspeed_scu_get_clkin(s);
+
+    if (hpll_reg & SCU_AST2600_H_PLL_OFF) {
+        return 0;
+    }
+
+    if (!(hpll_reg & SCU_AST2600_H_PLL_BYPASS_EN)) {
+        uint32_t p = (hpll_reg >> 19) & 0xf;
+        uint32_t n = (hpll_reg >> 13) & 0x3f;
+        uint32_t m = hpll_reg & 0x1fff;
+
+        multiplier = ((m + 1) / (n + 1)) / (p + 1);
+    }
+
+    return clkin * multiplier;
+}
+
+static uint32_t aspeed_1040_scu_get_apb_freq(AspeedSCUState *s)
+{
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(s);
+    uint32_t hpll = asc->calc_hpll(s, s->regs[AST1040_SCU_HPLL_PARAM]);
+
+    return hpll /
+        (AST1040_SCU_CLK_GET_PCLK_DIV(s->regs[AST1040_SCU_CLK_SEL_1]) + 1)
+        / asc->apb_divider;
+}
+
+static void aspeed_ast1040_scu_reset_hold(Object *obj, ResetType type)
+{
+    AspeedSCUState *s = ASPEED_SCU(obj);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(obj);
+
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
+    s->regs[AST1040_SILICON_REV] = s->silicon_rev;
+    s->regs[AST1040_HW_STRAP1]   = s->hw_strap1;
+    aspeed_ast1040_scu_update_cptra_page(s);
+}
+
+static const uint32_t ast1040_a0_scu_resets[ASPEED_AST1040_SCU_NR_REGS] = {
+    [AST1040_HW_STRAP1_CLR]             = 0xFFF0FFF0,
+    [AST1040_HW_STRAP1_LOCK]            = 0x00000FFF,
+    [AST1040_HW_STRAP1_SEC1]            = 0x000000FF,
+    [AST1040_SCU_CLK_STOP_CTL_1]        = 0xffff8400,
+    [AST1040_SCU_CLK_STOP_CTL_2]        = 0x00005f30,
+    [AST1040_SCU_CLK_SEL_1]             = 0x86900000,
+    [AST1040_SCU_CLK_SEL_2]             = 0x00400000,
+    [AST1040_SCU_HPLL_PARAM]            = 0x10000027,
+    [AST1040_SCU_HPLL_EXT_PARAM]        = 0x80000014,
+    [AST1040_SCU_APLL_PARAM]            = 0x1000001f,
+    [AST1040_SCU_APLL_EXT_PARAM]        = 0x8000000f,
+    [AST1040_SCU_DPLL_PARAM]            = 0x106e42ce,
+    [AST1040_SCU_DPLL_EXT_PARAM]        = 0x80000167,
+    [AST1040_SCU_DPLL_PARAM_READ]       = 0x106e42ce,
+    [AST1040_SCU_DPLL_EXT_PARAM_READ]   = 0x80000167,
+    [AST1040_SCU_UARTCLK_GEN]           = 0x00014506,
+    [AST1040_SCU_HUARTCLK_GEN]          = 0x000145c0,
+    [AST1040_SCU_CLK_DUTY_MEAS_RST]     = 0x0c9100d2,
+    [AST1040_SCU_FREQ_CNT_CTL]          = 0x00000080,
+};
+
+static const Property aspeed_1040_scu_props[] = {
+    DEFINE_PROP_UINT64("cptra-page-window-base", AspeedSCUState,
+                       cptra_page_window_base, 0),
+};
+
+static void aspeed_1040_scu_init(Object *obj)
+{
+    AspeedSCUState *s = ASPEED_SCU(obj);
+
+    object_property_add_link(obj, "cptra-page-window", TYPE_MEMORY_REGION,
+                             (Object **)&s->cptra_page_window,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static void aspeed_1040_scu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
+
+    dc->desc = "ASPEED 1040 System Control Unit";
+    rc->phases.hold = aspeed_ast1040_scu_reset_hold;
+    device_class_set_props(dc, aspeed_1040_scu_props);
+    asc->resets = ast1040_a0_scu_resets;
+    asc->calc_hpll = aspeed_1040_scu_calc_hpll;
+    asc->get_apb = aspeed_1040_scu_get_apb_freq;
+    asc->apb_divider = 2;
+    asc->nr_regs = ASPEED_AST1040_SCU_NR_REGS;
+    asc->clkin_25Mhz = true;
+    asc->ops = &aspeed_ast1040_scu_ops;
+}
+
+static const TypeInfo aspeed_1040_scu_info = {
+    .name = TYPE_ASPEED_1040_SCU,
+    .parent = TYPE_ASPEED_SCU,
+    .instance_size = sizeof(AspeedSCUState),
+    .instance_init = aspeed_1040_scu_init,
+    .class_init = aspeed_1040_scu_class_init,
+};
+
 static void aspeed_scu_register_types(void)
 {
     type_register_static(&aspeed_scu_info);
@@ -1174,6 +1424,7 @@ static void aspeed_scu_register_types(void)
     type_register_static(&aspeed_1030_scu_info);
     type_register_static(&aspeed_2700_scu_info);
     type_register_static(&aspeed_2700_scuio_info);
+    type_register_static(&aspeed_1040_scu_info);
 }
 
 type_init(aspeed_scu_register_types);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b88accc437..82ddbf4d15 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -103,6 +103,8 @@ aspeed_ast2700_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%"
 aspeed_ast2700_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_ast2700_scuio_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_ast2700_scuio_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_ast1040_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_ast1040_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 
 # mps2-scc.c
 mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.43.0


