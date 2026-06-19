Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC07FCDB469
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRBY-0000dN-4A; Fri, 19 Jun 2026 00:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRBI-0000Mo-LM
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:50:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRBE-0005bS-QQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:50:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8453b56ab74so911844b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781844600; x=1782449400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw4yGax63bC0ox/jGkXgO4IBMTah0WlBIPfyiNjDhBE=;
 b=iZ0RKETny4jHJSugx7d9HHJvTBJuToZpt+Sgtmti0ahpu7mBK9cvfxP3xygWhWd3KY
 UQXywVO9jh1z03jDava0vd7H5DMcrGYaTdvBa2wBtFstunD6kxwUDdHkj3plJ98gakH0
 9cO35X9j5x9gpnKXIlOjFYdnn/9EeVcXL3xUhh8arZXH1QZevJFhRUfBpjxzbXSKl8h+
 b+pqLLnDYBHV3knYSWoKQX4Ir/VQFnOWpNPBM+dVnDgjB0DXVbDTooLENgrH3ivyjpji
 8zlaGXkF/eS8YsiTIp6wasoZcEF4rX7g3YNlA4LWtlF+5uejv/BZlSaRV1i8B4D3PrTh
 +Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781844600; x=1782449400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zw4yGax63bC0ox/jGkXgO4IBMTah0WlBIPfyiNjDhBE=;
 b=JqMUKGdQLuCel/588Rs0GF8/ZglMazn2koRU9DzQwFI9AfvBICGI2dz+r/1SO2pSys
 Btbafo4z4KBrldLAP+/kwDJpLlvoPqA40E1AgxVKH3b+C5HfSwmLow5JOy9HtB2XL4cB
 MO22NL11n+GBFlFYTTChEYeskT4Kpv2Y8JJ9D800wsBaKuD2ahHiMSaE2SrggEwaop9D
 AmJ3tr7suIsGC87q2+iPMlQhB0DhEq3tfjx2TJritQAEUpZcabFNNW5inTLHSE3+G1Io
 fI7z213bwenLEc/EyXdZNWFXzYMrN7r/zv+jN63u6XWoBB9G2znOfsQhEua8zRgQq7uB
 BkPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+c7W3Hexca4HVLN9GZCk9X9gtPnx4tOgEQclWIYpbSZsOIX9eiQ9PJeM72d5Zp6NbjhpkCQRyXz/Wt@nongnu.org
X-Gm-Message-State: AOJu0Yx3DH4dGBLh+LSC64oaQu52UN05QbxuO0DrgUylKmN9uzJszXc9
 U6Rjlt2HoiYkUQT0ZpAGBvOn1IAb94UZO3C+d11f9alB0X1gTVCfW7sb
X-Gm-Gg: AfdE7clZ1sF98jldQU8CH3+UllsZEvGumW3HKb47rSHiuXizhLS8zegrh3dvuwJrc1N
 em+W4CwB2Aarhs0jc6WUZf3T/7AaNXm6XsxSWKwW0iv/ZH4iHY8ngqr+cG8OXRcbrDmzaJ/nW/t
 kAnscuS2h9dq8gzocO7RmHtgX5rivGIVbU3hwUm6h+FzXUeYxUaFCEJi/84X8MNf569S8DGBAYx
 NF61iz1opyey8eJpDO1WKPg4eFqhzgO38Jb5Pp11wtC2wn+fNejhk1evg4+NeSOEq+yW+9QJ/np
 lYXp2YG8Z/Cv6161LP+voPdbNlE5+8Ch2rYNWF2+i5DgTJtGzbij279PmzGSMMsUXq6GXqwJRjq
 doMQ6JQs2jsH9iSSQ6v9iZ5U9JkVYoxCSvl2SEBG8wB+VUrbMF2pjKtbb3RCR08SF7kqcDRE16B
 cu3r9fQsza42alL83LacJB8bAFVJyDyQPmKZ6aEmz7dT1e9c/mmk7cSO8F6CVbM3vDReolErII7
 AlKEfNHpk0HH9XdGNIWTIh7Ve/Xo8tuldPwbUrVfg==
X-Received: by 2002:a05:6a00:1401:b0:842:5b63:610f with SMTP id
 d2e1a72fcca58-8455603d0e5mr1101311b3a.4.1781844599880; 
 Thu, 18 Jun 2026 21:49:59 -0700 (PDT)
Received: from donnager-debian.. ([144.6.172.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455363da44sm870141b3a.8.2026.06.18.21.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:49:58 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 11/12] hw/riscv/atlantis: Integrate i2c controllers
Date: Fri, 19 Jun 2026 14:18:35 +0930
Message-ID: <20260619044838.1054677-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619044838.1054677-1-joel@jms.id.au>
References: <20260619044838.1054677-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add DesignWare I2C controllers to the tt-atlantis machine.

Provide a fixed clock in the device tree so that the Linux driver probes
without WARNing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h | 14 ++++++++
 hw/riscv/tt_atlantis.c         | 59 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |  1 +
 3 files changed, 74 insertions(+)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index a17732ce8114..7f7d4a5a5905 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -11,12 +11,15 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/sysbus.h"
+#include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
+#define TT_ATL_NUM_I2C 5
+
 struct TTAtlantisState {
     /*< private >*/
     MachineState parent;
@@ -27,11 +30,17 @@ struct TTAtlantisState {
 
     RISCVHartArrayState soc;
     DeviceState *irqchip;
+    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
 
     int fdt_size;
 };
 
 enum {
+    TT_ATL_I2C0_IRQ = 33,
+    TT_ATL_I2C1_IRQ = 34,
+    TT_ATL_I2C2_IRQ = 35,
+    TT_ATL_I2C3_IRQ = 36,
+    TT_ATL_I2C4_IRQ = 37,
     TT_ATL_UART1_IRQ = 39,
 };
 
@@ -40,6 +49,11 @@ enum {
     TT_ATL_BOOTROM,
     TT_ATL_DDR_LO,
     TT_ATL_DDR_HI,
+    TT_ATL_I2C0,
+    TT_ATL_I2C1,
+    TT_ATL_I2C2,
+    TT_ATL_I2C3,
+    TT_ATL_I2C4,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
     TT_ATL_SAPLIC,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index c3016d6d4c9e..e6afd7627da8 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -54,6 +54,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_ACLINT] =           { 0xa2180000,       0x10000 },
     [TT_ATL_SIMSIC] =           { 0xa4000000,      0x200000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
+    [TT_ATL_I2C0] =             { 0xd4040000,       0x10000 },
+    [TT_ATL_I2C1] =             { 0xd4050000,       0x10000 },
+    [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
+    [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
+    [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
@@ -275,10 +280,40 @@ static void create_fdt_rng(void *fdt)
     qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
 }
 
+static void create_fdt_clk(void *fdt, const char *clock_name,
+                           uint32_t freq, uint32_t phandle)
+{
+    g_autofree char *name = g_strdup_printf("/clocks/%s", clock_name);
+
+    qemu_fdt_add_path(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop_string(fdt, name, "clock-output-names", clock_name);
+    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 0);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", freq);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", phandle);
+}
+
+static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
+                           uint32_t irqchip_phandle, uint32_t clk_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX, mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "snps,designware-i2c");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
+    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
+    qemu_fdt_setprop_cell(fdt, name, "clocks", clk_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
+    uint32_t periph_clk_phandle = next_phandle();
     void *fdt = MACHINE(s)->fdt;
 
     create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
@@ -292,6 +327,15 @@ static void finalize_fdt(TTAtlantisState *s)
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
                     aplic_s_phandle);
+
+    create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
+
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        create_fdt_i2c(fdt,
+                       &s->memmap[TT_ATL_I2C0 + i],
+                       TT_ATL_I2C0_IRQ + i,
+                       aplic_s_phandle, periph_clk_phandle);
+    }
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -511,6 +555,21 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                 s->memmap[TT_ATL_UART1].base,
                                 s->memmap[TT_ATL_UART1].size);
 
+    /* I2C */
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        SysBusDevice *sbd;
+
+        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
+                                TYPE_DESIGNWARE_I2C);
+        sbd = SYS_BUS_DEVICE(&s->i2c[i]);
+        sysbus_realize(sbd, &error_fatal);
+        memory_region_add_subregion(system_memory,
+                                    s->memmap[TT_ATL_I2C0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
+    }
+
     /* Load or create device tree */
     if (machine->dtb) {
         load_fdt(s);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 5033415440d4..dcce819bf6e9 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -129,6 +129,7 @@ config TENSTORRENT
     select RISCV_IMSIC
     select SERIAL_MM
     select DEVICE_TREE
+    select DESIGNWARE_I2C
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


