Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F09C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyYT-0001LD-0v; Mon, 17 Aug 2026 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wvyYI-0001Bb-Pe
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:43:03 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wvyYE-0001MS-SY
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:43:01 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66c70e2904dso3735938d50.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1786977776; x=1787582576; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUZygXbR06TzNWyfkLlWTpBjMNElR72c8NKVbTiS+EA=;
 b=O4kPRzchHts2/QzDuIPEunZquPna4tNL66TyjF1R1okqx+ld3iwU7MsxSAFsyoTrKy
 8Jn1PVIkX2hcz8mq/4nOAnHM+0qta9yXoxeQ9A48jXttJhsF6RKYlYRchLj27/PkmLFU
 s15mFvCMSsl0M6mIhKrBJt0JopyYu0EJqU02DJEL12t0dHAjN+Qv9meUAhDUA7t5zcUk
 WDeiwioWQHNNnJcteYHiVr8NV4Eog6QdWagy5a7zutCffh6+3HomVF91r0S1ktYNByCD
 9jF1x++BfUYrj3QaX85tuUjwbf/KlrSFAbeP3xjAfYOQZYzmIyqSvYZtu6dRsHcItIKT
 HfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786977777; x=1787582577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lUZygXbR06TzNWyfkLlWTpBjMNElR72c8NKVbTiS+EA=;
 b=mc/wTrD6hNsU8apoF9Bvwo811FpwOzwylo8X6nIv1XBMBkFXdQv3W6Z8dDaqUXZrmX
 XgjxYYhNlopwZ9COToO6fnBMnbZIBFY1iMZzQ2Sw9QgkG5DAty9JZxLavTindJ8xzoeO
 Es3DLXNazFhwuWWr8NkeMzEfM5DqXPeD0m9bBnamjcq6iRpXjU8LHhL8C2rqRqTuEPAz
 /mCahka97e9vtBirCVp4dg/95Qi3Su8MdCdasdGWUihp9QvKxT0IGfgoS8nfU+odEQ3e
 i3L7VUkY1QgUn0GDGO9p0P3HCb0je9BBGr2aibHJ9EL08LEg0DIJL/y7KSlLmZWtCJnf
 QZBQ==
X-Gm-Message-State: AOJu0Yz/HoQ2RoOoGPXWO/VfqEMc6g0/6bGU0+2eOSs+gf3dZ+m+0e8a
 8VH6L0beCIZLld8Gy8SsluIx4omyhqdIapYqNoYQDu7utaY2X/wBmqeD1YCw779NZzU=
X-Gm-Gg: AR+sD13Wh+cQfXcXrktYHxSKbrey7wruCdUO9CBI3FZf85FzAH47bAtIenCgp3bWDvV
 6eWws1Dftsfq2wFUBNF2VmzcrOZCqU1wIEeB8nard6v3FHTcEpMo0cHbAfeb/51r6S8IgO2oIm9
 OE+FjhAUHcmCjsvovQJHjKTp5peCfqh9XwTSt1awnO4NGZvLuJInCs3n+rTVGjOJw9/X0pHprGJ
 dd7P+wFXrfHG5RDu2xn0wbfHoR1lCjctww3I1MsnNKk1GlNeZjRXZChIYDkHU4C3EeXbhxWzoh7
 QQmqyqIk5k21/szYE/Yce04/TbWjdMvR9w56DimDpXfXlpkPHPobUvqrxcoPOLqXrlXqXekyI1J
 ce8wQzJJIc6noB0VdcNwDJSEWNir28vSw+H00sjMVLsOQH6a9k53hr5KOJQkuU8GBgqq1fwQvkS
 cuaZnmWYqXsyZj1EBR9jXq2R7fy8I042g33gcOJj23WUOgajdrPaaHs9NHg/ojSd9Rxk5d3slYh
 8oX9uvpbNcHxqI+dptWpRtxnfVrE6bp9RTe0Ic=
X-Received: by 2002:a53:a68f:0:b0:668:42d:95e5 with SMTP id
 956f58d0204a3-66c72b1889emr6244101d50.4.1786977776556; 
 Mon, 17 Aug 2026 07:42:56 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cb47809d1sm904104d50.13.2026.08.17.07.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:42:56 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 17 Aug 2026 09:42:45 -0500
Subject: [PATCH v2 2/2] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis
 model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-atlantis_prcm-v2-2-ffba0b944419@oss.tenstorrent.com>
References: <20260817-atlantis_prcm-v2-0-ffba0b944419@oss.tenstorrent.com>
In-Reply-To: <20260817-atlantis_prcm-v2-0-ffba0b944419@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
(RCPU, HSIO, PCIe and MM). This commit adds these 4 PRCM blocks to the
tt-atlantis model, along with necessary device tree nodes for them.

Reviewed-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 docs/system/riscv/tt_atlantis.rst |  1 +
 hw/riscv/tt_atlantis.c            | 94 +++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/tt_atlantis.h    | 19 ++++++++
 3 files changed, 114 insertions(+)

diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index 1f2880d617..539c22354f 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -14,6 +14,7 @@ tt-atlantis QEMU model features
 * 8-core Ascalon-X CPU Cluster
 * RISC-V compliant Advanced Interrupt Architecture
 * 16550A compatible UART
+* 4 PRCMs (Clock and Reset Controllers)
 
 Known limitations
 -----------------
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d808bcc11c..9ebba07703 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -26,6 +26,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/tt_atlantis_prcm.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -59,6 +60,10 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
     [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
+    [TT_ATL_PRCM_RCPU] =        { 0xd0000000,       0x10000 },
+    [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
+    [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
+    [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
@@ -328,11 +333,35 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
     qemu_fdt_setprop_cell(fdt, name, "reg", addr);
 }
 
+static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
+                             const char *prcm_name)
+{
+    hwaddr base = mem->base;
+    hwaddr size = mem->size;
+    char *name = g_strdup_printf("/soc/prcm_%s@%" PRIx64,
+                                 prcm_name, mem->base);
+    g_autofree char *compatible =
+        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
+    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());
+
+    return name;
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
     uint32_t periph_clk_phandle = next_phandle();
+    uint32_t osc_24m_phandle = next_phandle();
+    uint32_t prcm_rcpu_phandle;
     void *fdt = MACHINE(s)->fdt;
 
     create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
@@ -348,6 +377,34 @@ static void finalize_fdt(TTAtlantisState *s)
                     aplic_s_phandle);
 
     create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
+    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
+
+    g_autofree char *rcpu_name = create_fdt_prcm(fdt,
+        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
+    prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
+                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
+                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
+                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
+                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
+
+    g_autofree char *hsio_name = create_fdt_prcm(fdt,
+        &s->memmap[TT_ATL_PRCM_HSIO], "hsio");
+    qemu_fdt_setprop_cells(fdt, hsio_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_HSIO_PLL);
+
+    g_autofree char *pcie_name = create_fdt_prcm(fdt,
+        &s->memmap[TT_ATL_PRCM_PCIE], "pcie");
+    qemu_fdt_setprop_cells(fdt, pcie_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_PCIE_PLL);
+
+    g_autofree char *mm_name = create_fdt_prcm(fdt,
+        &s->memmap[TT_ATL_PRCM_MM], "mm");
+    qemu_fdt_setprop_cells(fdt, mm_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
+                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         create_fdt_i2c(fdt,
@@ -545,6 +602,43 @@ static void tt_atlantis_machine_init(MachineState *machine)
     serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
                    qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    /* Add rcpu prcm block */
+    object_initialize_child(OBJECT(s), "prcm-rcpu", &s->prcm[0],
+                            TYPE_TT_ATLANTIS_PRCM_RCPU);
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[0]), &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_PRCM_RCPU].base,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(&s->prcm[0]), 0));
+
+    /* Add hsio prcm block */
+    object_initialize_child(OBJECT(s), "prcm-hsio", &s->prcm[1],
+                            TYPE_TT_ATLANTIS_PRCM_HSIO);
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[1]), &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_PRCM_HSIO].base,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(&s->prcm[1]), 0));
+
+    /* Add pcie prcm block */
+    object_initialize_child(OBJECT(s), "prcm-pcie", &s->prcm[2],
+                            TYPE_TT_ATLANTIS_PRCM_PCIE);
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[2]), &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_PRCM_PCIE].base,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(&s->prcm[2]), 0));
+
+    /* Add mm prcm block */
+    object_initialize_child(OBJECT(s), "prcm-mm", &s->prcm[3],
+                            TYPE_TT_ATLANTIS_PRCM_MM);
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[3]), &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_PRCM_MM].base,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(&s->prcm[3]), 0));
+
     /*
      * Atlantis contains a DesignWare uart while the QEMU machine
      * uses the serial_mm model with the base ns16550 register set.
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 7f7d4a5a59..20bcdfeb52 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,12 +13,14 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/misc/tt_atlantis_prcm.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
 #define TT_ATL_NUM_I2C 5
+#define TT_ATL_NUM_PRCM 4
 
 struct TTAtlantisState {
     /*< private >*/
@@ -31,6 +33,7 @@ struct TTAtlantisState {
     RISCVHartArrayState soc;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
+    TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
     int fdt_size;
 };
@@ -59,6 +62,22 @@ enum {
     TT_ATL_SAPLIC,
     TT_ATL_SIMSIC,
     TT_ATL_UART1,
+    TT_ATL_PRCM_RCPU,
+    TT_ATL_PRCM_HSIO,
+    TT_ATL_PRCM_PCIE,
+    TT_ATL_PRCM_MM,
+};
+
+/* RCPU PRCM Clock IDs */
+enum {
+    TT_ATL_CLK_RCPU_PLL = 0,
+    TT_ATL_CLK_RCPU_ROOT = 1,
+    TT_ATL_CLK_NOC_PLL = 25,
+    TT_ATL_CLK_NOCC_CLK = 26,
+    TT_ATL_CLK_HSIO_PLL = 54,
+    TT_ATL_CLK_PCIE_PLL = 55,
+    TT_ATL_CLK_MM_PLL0 = 56,
+    TT_ATL_CLK_MM_PLL1 = 57,
 };
 
 #endif

-- 
2.43.0


