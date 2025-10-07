Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69404CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Pu-0005bQ-79; Tue, 07 Oct 2025 10:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pp-0005ax-Bz
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Ph-00026p-82
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so38027165e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846290; x=1760451090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C9h8WM4gxi2sTa+iZ6czhn/Kjg3vyz44CeCkzLnEM/U=;
 b=qyOq77TJU95ax4nkzkrtQg5IkyP4wNp9A5aMueqpTUUjCGiT5NmWxZespDMqahucWz
 eAlMvUqMWmukcbwnoFLoGyPgSSUsmj0ot2RPTFxPOFGO+6p3o6Xp3NEHSw3OZ6Gb2AVx
 26j8OrqNfKqWasDdZlUib625Yh8+yuIxCk+hppOERRMeV5WstUsomTlM4hQw3hJ35Mmk
 rEUhq6MC33Iz1/E/zJTrcVYcM2sDamhcXEtK71210YhTXgQ4Pvo9o+a9a99fi7x2qPol
 kbLnsC2qt4cOdlup54X3HqPsv3BH82iApMYVm9qk6qWGadBB0UDxW3YmK2NX0T983SNV
 dxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846290; x=1760451090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9h8WM4gxi2sTa+iZ6czhn/Kjg3vyz44CeCkzLnEM/U=;
 b=DFfk4e6RitWeuI3gXt8SIvK4Hx+rR51MV0hBEU9/x+9xFO3Csq4zDhV+DAoMons5Fg
 VyBZFLHgsEYQtaFWwsp77rclLD1k2n8DPELq5o1aUMdAEh1N3KfYioQurEeb0YcdraBy
 +fZX48QTCWBkXlfjDR1eWgsyxH6PPUtNXnOjOFk+HSJkXwwSZPejXYo9ijwPo1y1N/SA
 KWM3WOYfVJHdHrGaXlGwvlrvhf/h2DnTsMqvhReALazjUM1JSbZNDgUyDq9hdG6DZ00S
 5QqneV01FxFwusdZrwTHElZSbSUSFap0vQcRYAe3fmOdcXvpia4C4lQqiT50yfUcEuOt
 4bsw==
X-Gm-Message-State: AOJu0Yw+pxifJIcwN/rRrtuv1daNXWOl4hPLkG5mBiFXc0sOEqLJKFm/
 4U1+ITRrdAQzcGEv7PfYITOpLmyIQ76pyYAzpnVRibTGyg20w6tQmA3ZbCoPZkImIyG2r1rjpBC
 RJvsL
X-Gm-Gg: ASbGnctq+Asg1AbJ5kSthEYgJpg0JGIi34/3lUYbQ3j+kcaSzWWr8c0Ln49fJq/yats
 PZ9CviwBlNqfTF0Qtvemx6s7edhhirB8aRIYuOwwtX0N8YCJ93B1U8gSaOwxhE+iV20B79q6nAJ
 ValTuCj/boJrIk1ja3aoQvBluzEV0fH3vRJzmw/OsP2dwhBIz+CSnmEEkUnPAHVUTk33B4vvVij
 aOpULLzGAFJDiLJvehKyU2E3z3OZcRREgXT1HFrgmhT9BW7PWMLJUG2VIJVfTnUQAz0O2ZjX4/J
 8IF56UhSaEdhauwUg7Nb9vciCHCZhhRXsHM5toTkzCnG0PP27RHQjWosx3gk8eexhRg2IXuU7uX
 inTrXIQ59kbT2G2+J0Uk0rtidrcY2E/Y2xYoep/ke6G/Bdfq1/DaMtsrF
X-Google-Smtp-Source: AGHT+IE/rpGjAUHFt8v/f1f1RboB9iN7wHuCf1RSgO8xZnfit1h2qBSnablpEncWfQBrNeLt8w30lw==
X-Received: by 2002:a05:600c:529a:b0:46d:9d28:fb5e with SMTP id
 5b1f17b1804b1-46e710ffb36mr115555445e9.5.1759846289997; 
 Tue, 07 Oct 2025 07:11:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/62] hw/arm/xlnx-versal: uart: refactor creation
Date: Tue,  7 Oct 2025 15:10:24 +0100
Message-ID: <20251007141123.3239867-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Luc Michel <luc.michel@amd.com>

Refactor the UARTs creations. The VersalMap struct is now used to
describe the SoC and its peripherals. For now it contains the two UARTs
mapping information. The creation function now embeds the FDT creation
logic as well. The devices are now created dynamically using qdev_new
and (qdev|sysbus)_realize_and_unref.

This will allow to rely entirely on the VersalMap structure to create
the SoC and allow easy addition of new SoCs of the same family (like
versal2 coming with next commits).

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-4-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |   2 -
 hw/arm/xlnx-versal-virt.c    |  36 +--------
 hw/arm/xlnx-versal.c         | 144 ++++++++++++++++++++++++++++-------
 3 files changed, 119 insertions(+), 63 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index f2a62b43552..b01ddeb1423 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -18,7 +18,6 @@
 #include "hw/or-irq.h"
 #include "hw/sd/sdhci.h"
 #include "hw/intc/arm_gicv3.h"
-#include "hw/char/pl011.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
@@ -80,7 +79,6 @@ struct Versal {
         MemoryRegion mr_ocm;
 
         struct {
-            PL011State uart[XLNX_VERSAL_NR_UARTS];
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index d1c65afa2ac..e1deae11317 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -77,6 +77,7 @@ static void fdt_create(VersalVirt *s)
     s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
+    qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
     qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
@@ -208,40 +209,6 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     g_free(name);
 }
 
-static void fdt_add_uart_nodes(VersalVirt *s)
-{
-    uint64_t addrs[] = { MM_UART1, MM_UART0 };
-    unsigned int irqs[] = { VERSAL_UART1_IRQ_0, VERSAL_UART0_IRQ_0 };
-    const char compat[] = "arm,pl011\0arm,sbsa-uart";
-    const char clocknames[] = "uartclk\0apb_pclk";
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        char *name = g_strdup_printf("/uart@%" PRIx64, addrs[i]);
-        qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop_cell(s->fdt, name, "current-speed", 115200);
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addrs[i], 2, 0x1000);
-        qemu_fdt_setprop(s->fdt, name, "compatible",
-                         compat, sizeof(compat));
-        qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
-
-        if (addrs[i] == MM_UART0) {
-            /* Select UART0.  */
-            qemu_fdt_setprop_string(s->fdt, "/chosen", "stdout-path", name);
-        }
-        g_free(name);
-    }
-}
-
 static void fdt_add_canfd_nodes(VersalVirt *s)
 {
     uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
@@ -705,7 +672,6 @@ static void versal_virt_init(MachineState *machine)
     create_virtio_regions(s);
 
     fdt_add_gem_nodes(s);
-    fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3b596219561..b16af79e8a9 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -26,6 +26,7 @@
 #include "target/arm/gtimer.h"
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
+#include "hw/char/pl011.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -34,6 +35,83 @@
 #define VERSAL_NUM_PMC_APB_IRQS 18
 #define NUM_OSPI_IRQ_LINES 3
 
+typedef struct VersalSimplePeriphMap {
+    uint64_t addr;
+    int irq;
+} VersalSimplePeriphMap;
+
+typedef struct VersalMap {
+    VersalSimplePeriphMap uart[2];
+    size_t num_uart;
+} VersalMap;
+
+static const VersalMap VERSAL_MAP = {
+    .uart[0] = { 0xff000000, 18 },
+    .uart[1] = { 0xff010000, 19 },
+    .num_uart = 2,
+};
+
+static const VersalMap *VERSION_TO_MAP[] = {
+    [VERSAL_VER_VERSAL] = &VERSAL_MAP,
+};
+
+static inline VersalVersion versal_get_version(Versal *s)
+{
+    return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
+}
+
+static inline const VersalMap *versal_get_map(Versal *s)
+{
+    return VERSION_TO_MAP[versal_get_version(s)];
+}
+
+
+static qemu_irq versal_get_irq(Versal *s, int irq_idx)
+{
+    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
+}
+
+static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
+                                      int sbd_idx, int irq_idx)
+{
+    qemu_irq irq = versal_get_irq(s, irq_idx);
+
+    if (irq == NULL) {
+        return;
+    }
+
+    sysbus_connect_irq(sbd, sbd_idx, irq);
+}
+
+static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
+                                           uint64_t at, const char *compat,
+                                           size_t compat_sz)
+{
+    char *p;
+
+    p = g_strdup_printf("%s@%" PRIx64, path, at);
+    qemu_fdt_add_subnode(s->cfg.fdt, p);
+
+    if (!strncmp(compat, "memory", compat_sz)) {
+        qemu_fdt_setprop(s->cfg.fdt, p, "device_type", compat, compat_sz);
+    } else {
+        qemu_fdt_setprop(s->cfg.fdt, p, "compatible", compat, compat_sz);
+    }
+
+    return p;
+}
+
+static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
+                                                  uint64_t addr, uint64_t len,
+                                                  const char *compat,
+                                                  size_t compat_sz)
+{
+    char *p = versal_fdt_add_subnode(s, path, addr, compat, compat_sz);
+
+    qemu_fdt_setprop_sized_cells(s->cfg.fdt, p, "reg", 2, addr, 2, len);
+    return p;
+}
+
 static void versal_create_apu_cpus(Versal *s)
 {
     int i;
@@ -167,28 +245,44 @@ static void versal_create_rpu_cpus(Versal *s)
     qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
 }
 
-static void versal_create_uarts(Versal *s, qemu_irq *pic)
+static void versal_create_uart(Versal *s,
+                               const VersalSimplePeriphMap *map,
+                               int chardev_idx)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    g_autofree char *alias;
+    const char compatible[] = "arm,pl011\0arm,sbsa-uart";
+    const char clocknames[] = "uartclk\0apb_pclk";
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
-        static const int irqs[] = { VERSAL_UART0_IRQ_0, VERSAL_UART1_IRQ_0};
-        static const uint64_t addrs[] = { MM_UART0, MM_UART1 };
-        char *name = g_strdup_printf("uart%d", i);
-        DeviceState *dev;
-        MemoryRegion *mr;
+    dev = qdev_new(TYPE_PL011);
+    object_property_add_child(OBJECT(s), "uart[*]", OBJECT(dev));
+    qdev_prop_set_chr(dev, "chardev", serial_hd(chardev_idx));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.uart[i],
-                                TYPE_PL011);
-        dev = DEVICE(&s->lpd.iou.uart[i]);
-        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
-        g_free(name);
+    node = versal_fdt_add_simple_subnode(s, "/uart", map->addr, 0x1000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "current-speed", 115200);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names", clocknames,
+                     sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop(s->cfg.fdt, node, "u-boot,dm-pre-reloc", NULL, 0);
+
+    alias = g_strdup_printf("serial%d", chardev_idx);
+    qemu_fdt_setprop_string(s->cfg.fdt, "/aliases", alias, node);
+
+    if (chardev_idx == 0) {
+        qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
     }
 }
 
@@ -783,14 +877,6 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
                                  &error_abort);
     }
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
-        g_autofree gchar *name = g_strdup_printf("uart[%d]", i);
-
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.iou.uart[i]),
-                                 &error_abort);
-    }
-
     object_property_set_link(OBJECT(&s->lpd.crl),
                              "usb", OBJECT(&s->lpd.iou.usb),
                              &error_abort);
@@ -942,6 +1028,8 @@ static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    const VersalMap *map = versal_get_map(s);
+    size_t i;
 
     g_assert(s->cfg.fdt != NULL);
 
@@ -951,7 +1039,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
-    versal_create_uarts(s, pic);
+
+    for (i = 0; i < map->num_uart; i++) {
+        versal_create_uart(s, &map->uart[i], i);
+    }
+
     versal_create_canfds(s, pic);
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
-- 
2.43.0


