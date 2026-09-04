Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471CFC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2VD2-00039I-BC; Fri, 04 Sep 2026 10:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1x2VCz-00034y-R2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:48:01 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1x2VCw-0004W4-VN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:48:01 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-86d43cdee51so14117557b3.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1788533278; x=1789138078; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XCclJD14e1dhn5+WjJeOdDkpX8FrnlxuNas3n5cM4X0=;
 b=DSm3gqPGN2r8+6XTWbRNboSa9tbLRP+37SpPe3v7j/3OP9bbC1xaT/+QlTY0lMLJdo
 xzievP4wgLQd+AtVqQTU1LEMRwra+pdy+BTyJz50fjM21vu/GqdTIrqD5bUCdB0AY8vI
 vaV4qV+1TGoa4rTtf+0+kOhKvIPCIrrsI2VY1elT1f03iiDCx78Ds1IcWkMjwO++sRwE
 I8RMkvc0CkMpg/Tm3/Y/bKwm6qiRPIFkp4r5Lvi/vTqUy17+P07vhZZ19BH08A50pOFQ
 BkkPvo9+jz2FHZbF0VJcL+MRXbRPXrWfIO82uNtu2H/kTWjYz5mNq669tqfAdnNq95jX
 Skcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533278; x=1789138078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XCclJD14e1dhn5+WjJeOdDkpX8FrnlxuNas3n5cM4X0=;
 b=Qr6bsecWN9eUyA9C1bPZIiffPO/tVr3thjKHn+IHvdtT0oAFyR29CFZx2TFoJRVOry
 AJ33hItmgJi3NsqKNqaGb9MQU67eshloCO84u0q35JX0czOaMd6r5YEghDslNdBncULH
 t/YXqzEnUpfPp2YXtPZ8PAxpmLkqFncN2NMhHHzOzLh19yOgUWxjeEhpfIZzt+rf0rqg
 HPwLqne/u290I3uj0p0quxDkmF5qzFjSxHCVufxvaoO3TR3stSWGDrTAcouF9bavNc/g
 9m1TXtUaeJqEER7Gjwio4tiZlq4hLdtu1eHwvkpmucJsVADXcB4ICMqvluM/pL64qnJ8
 LuVw==
X-Gm-Message-State: AFuF++lesRTCSwcdCe1QLspwMd5x0SDn3ho0hTuYHA9YQYxPyxGdC4/P
 AtNE8M1ojJO13ezBCi2yCWhgYGFXMvYO8aCT9AqsYjGvaOpZNZDFGUYodPqe8PjduDw=
X-Gm-Gg: AYBFou3TT1F6J4gA5lA+jyl/5EwDngw6Zr3A9AlGk0cWHnMR4XxtXY9guTeUj1EPRc8
 17pzN5EFdRFfvx7qOykl5yXXzLMzX88JX0JzjU0W4Pbwn9UkJu9qvo2tjfZlpevwtNwMbIaZBxn
 I7i4Q5KcfkVgDhL24CmLpxX2q/3iRyJHG8XqkK9sNxGyRa65uSn/2OTkayhXJL473NmuH+6Q2/X
 E73IV4m3gwd//YWi62bYTH5x27W3kGIT1evdIBoiKBMze5J4BcrGZxH8WIPkTJWBhyh0DIEfkN9
 M6wg/aabyeiaD436kQjO1MyAiaR99d7HXsj7GM3ctXtfTqSsgxLT9yk7ImL7aO0QUsWjXxIGAfb
 0FC/ZTvZcLmQcrEr+pPXs05/lhgJcdmzr7jfJyXFA4R6iZDR937n31h5ocvmiOFHHgJEGB9yLf0
 NHSRvIZXhD/Be2OybSkevNO82MuKu4Eb3kpRZ8/BcQtRdGezPz/qJA+cVH1nqzQaMI2N24b1IP1
 eA33FbBPp0TQcs1U/cIDgzq6s81ysIYnoAydKZzqcgk
X-Received: by 2002:a05:690c:c507:b0:873:17c9:afca with SMTP id
 00721157ae682-87317c9eb9cmr10124357b3.29.1788533277709; 
 Fri, 04 Sep 2026 07:47:57 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:6f99:bae4:e245:b362])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714ab73f23sm19274597b3.33.2026.09.04.07.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:57 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Fri, 04 Sep 2026 09:47:29 -0500
Subject: [PATCH v3 2/3] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis
 model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-atlantis_prcm-v3-2-8bf20795a381@oss.tenstorrent.com>
References: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
In-Reply-To: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
(RCPU, HSIO, PCIe and MM). The remaining 2 are only accessed by the
boot cpu which isn't modelled yet.

This commit adds these 4 PRCM blocks to the tt-atlantis model, along
with necessary device tree nodes for them.

Reviewed-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 docs/system/riscv/tt_atlantis.rst |  1 +
 hw/riscv/tt_atlantis.c            | 86 +++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/tt_atlantis.h    | 22 ++++++++++
 3 files changed, 109 insertions(+)

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
index 8a219afef7..15b4192f4d 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -27,6 +27,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/tt_atlantis_prcm.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -58,12 +59,16 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_ACLINT] =           { 0xa2180000,       0x10000 },
     [TT_ATL_SIMSIC] =           { 0xa4000000,      0x200000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
+    [TT_ATL_PRCM_RCPU] =        { 0xd0000000,       0x10000 },
     [TT_ATL_I2C0] =             { 0xd4040000,       0x10000 },
     [TT_ATL_I2C1] =             { 0xd4050000,       0x10000 },
     [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
     [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
     [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
+    [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
+    [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
+    [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
@@ -327,11 +332,36 @@ static void create_fdt_i2c_device(void *fdt, TTAtlantisSoCState *s, int bus,
     qemu_fdt_setprop_cell(fdt, name, "reg", addr);
 }
 
+static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
+                             const char *prcm_name)
+{
+    hwaddr base = mem->base;
+    hwaddr size = mem->size;
+    char *name = g_strdup_printf("/soc/prcm_%s@%" PRIx64,
+                                 prcm_name, base);
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
 static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
     uint32_t periph_clk_phandle = next_phandle();
+    uint32_t osc_24m_phandle = next_phandle();
+    uint32_t prcm_rcpu_phandle;
+    g_autofree char *rcpu_name, *hsio_name, *pcie_name, *mm_name;
 
     create_fdt_cpu(fdt, s, aplic_s_phandle, imsic_s_phandle);
 
@@ -348,6 +378,30 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
                     aplic_s_phandle);
 
     create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
+    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
+
+    rcpu_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
+    prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
+                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
+                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
+    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
+                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
+                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
+
+    hsio_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_HSIO], "hsio");
+    qemu_fdt_setprop_cells(fdt, hsio_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_HSIO_PLL);
+
+    pcie_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_PCIE], "pcie");
+    qemu_fdt_setprop_cells(fdt, pcie_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_PCIE_PLL);
+
+    mm_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_MM], "mm");
+    qemu_fdt_setprop_cells(fdt, mm_name, "clocks", osc_24m_phandle,
+                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
+                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         create_fdt_i2c(fdt,
@@ -491,6 +545,15 @@ static void tt_atlantis_soc_init(Object *obj)
     object_initialize_child(obj, "uart1", &s->uart1,
                             TYPE_UNIMPLEMENTED_DEVICE);
 
+    object_initialize_child(obj, "prcm-rcpu", &s->prcm[PRCM_DOMAIN_RCPU],
+                            TYPE_TT_ATLANTIS_PRCM_RCPU);
+    object_initialize_child(obj, "prcm-hsio", &s->prcm[PRCM_DOMAIN_HSIO],
+                            TYPE_TT_ATLANTIS_PRCM_HSIO);
+    object_initialize_child(obj, "prcm-pcie", &s->prcm[PRCM_DOMAIN_PCIE],
+                            TYPE_TT_ATLANTIS_PRCM_PCIE);
+    object_initialize_child(obj, "prcm-mm", &s->prcm[PRCM_DOMAIN_MM],
+                            TYPE_TT_ATLANTIS_PRCM_MM);
+
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         object_initialize_child(obj, "i2c[*]", &s->i2c[i],
                                 TYPE_DESIGNWARE_I2C);
@@ -587,6 +650,28 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
                    qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    /* 4 PRCM blocks */
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_RCPU]), errp);
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_RCPU].base,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_RCPU]), 0));
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_HSIO]), errp);
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_HSIO].base,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_HSIO]), 0));
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_PCIE]), errp);
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_PCIE].base,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_PCIE]), 0));
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_MM]), errp);
+    memory_region_add_subregion(
+        s->memory, s->memmap[TT_ATL_PRCM_MM].base,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[PRCM_DOMAIN_MM]), 0));
+
     /*
      * Atlantis contains a DesignWare uart while the QEMU machine
      * uses the serial_mm model with the base ns16550 register set.
@@ -654,6 +739,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                              OBJECT(&ams->soc_memory), &error_abort);
     object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
                              &error_abort);
+
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 3923308b7c..db1dfed157 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -14,6 +14,7 @@
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/tt_atlantis_prcm.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -23,6 +24,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
 
 #define TT_ATL_NUM_I2C 5
+#define TT_ATL_NUM_PRCM 4
 
 struct TTAtlantisSoCState {
     /*< private >*/
@@ -41,6 +43,7 @@ struct TTAtlantisSoCState {
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
     MemoryRegion bootrom;
+    TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
     uint32_t num_harts;
     char *cpu_type;
@@ -81,6 +84,25 @@ enum {
     TT_ATL_SAPLIC,
     TT_ATL_SIMSIC,
     TT_ATL_UART1,
+    TT_ATL_PRCM_RCPU,
+    TT_ATL_PRCM_HSIO,
+    TT_ATL_PRCM_PCIE,
+    TT_ATL_PRCM_MM,
+};
+
+/*
+ * RCPU PRCM Clock IDs, sourced from linux dt-bindings
+ * include/dt-bindings/clock/tenstorrent,atlantis-prcm-rcpu.h
+ */
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


