Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B26CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Px-0005eI-Bg; Tue, 07 Oct 2025 10:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Ps-0005bw-Ee
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pi-00027P-1R
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so26502805e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846293; x=1760451093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ENve6wMxdaDDH0x9jtLf9GkL8jPXA7Ca2HYte//Nd6I=;
 b=ILNZj92cslw2XB5l4LE2dBs6G4HAlemIItY9sXvSY9UHcuWuh6lPKtZKcv1XUQIA4J
 NfGbMFSrxnEDhsNjs+5eoOmlor3leabB2Dhh1D5E+OfqQk6iC72IxP1HNlvX0jZETrf5
 itpjae6ov6fuwquQV29VNRvpO0P40GL9o5QiK+2f3y8fWeyKozOcTPcMECvVgeKbBXcg
 Ei+uqDJw/b7zyPpZ3uner5Qqv0ARD0xgGHj/pmSIecxIFG7Y7oicVP1FrH1Mo3+K5rfl
 /D1wcNMCb717yfSoyNZB9nBp2kOL14LXeUJmeYhiUCSFpc/q8H1tjiOztrNiQn5I90HX
 s8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846293; x=1760451093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENve6wMxdaDDH0x9jtLf9GkL8jPXA7Ca2HYte//Nd6I=;
 b=w58mdDCcnGvq3uTO1hwrmsrbTLkXBdZCi8z8G+cdCuRBbu8G/BqcIPemQQi4RS9onO
 TWUW+POAlef2xYYY/MI2EVtVb47xS9T6QV2sbWaPQnRuQ/tWOSTMZrv6OpqR7xaOxC0A
 heKsv/6dfMuJofeklxC537w9UnMY78dCytlzuECQEQL8U5fsbSpz/MnC4HfNi/Bf8bkg
 rfncgAR2gttGaGRe8iqCXY4smFDyMfojVgB2cLggrbpC4GCGdy6lD/zp5pNrIjxKFVED
 xyFDtXp+2o+1o2ButkcfqWDrETspzgZX3QitnzbY9y0+xKhxs+yT2ScG+IRkBnuUXcza
 slgQ==
X-Gm-Message-State: AOJu0YyZWmQ7J/TSuxAYqskaUCMfPNsLZ1iokumyZG/QhsTnWJzGaueN
 o8v7Z3wjmrIVs9k9R1t+vME68AlCAtUaBiFPqL1K8/S3+2+M+FKmRhd5GWcvwFsw+/iUTBEsiGR
 M8XNj
X-Gm-Gg: ASbGncvj2UKEtVuu2UzTWFQ3SewtGykmR6qyr+goC1FHInHkWaMGXJL77WCE2DbiyUQ
 Tqlaenrx1xxIe5RNgyYLchz9EqqoGRF1RbrsT/20+vBVP7wQtu3wl970Ke1pvkiBPmrfgHW4MAH
 0l8WPUEvZCVX8dN1/2IP1W4bPXLGekFMx9jf7RrHPzs7eqYj47S2KUAgYC5gRvRAv+tiEDEByE7
 weP2CNozt5hcJJiDRYccd3F4bwVYOKXb8qdWNth/io7u1qp/wOf6tzd0sF+DieHwAM7vq5QxSy1
 NpGw5Rt4g9wgBeywQO5r2FDnqotBnWLuDEPt1Q3C7y5VjNx+hJmh65jCzdCk9yUwB6FaH/jP2sG
 w4IH87QPuORwshJP3KtvPla3d40UkZ4lK2j0w7i/vbqHZ2uqIWnOBh5Cv
X-Google-Smtp-Source: AGHT+IHo/GvtjyTtMIGxMxcFCQeITA0F3ubQ8/fH6qwu7MNTvEI09LOgn8YTes7/v/s6kAmqaebb9Q==
X-Received: by 2002:a05:600c:4fd3:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-46e710f6d02mr117240795e9.7.1759846293319; 
 Tue, 07 Oct 2025 07:11:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/62] hw/arm/xlnx-versal: gem: refactor creation
Date: Tue,  7 Oct 2025 15:10:27 +0100
Message-ID: <20251007141123.3239867-8-peter.maydell@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Refactor the GEM ethernet controllers creation using the VersalMap
structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

The FDT nodes are created in reverse order compared to the devices
creation to keep backward compatibility with the previous generated
FDTs.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-7-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |   3 -
 hw/arm/xlnx-versal-virt.c    |  54 ------------
 hw/arm/xlnx-versal.c         | 155 ++++++++++++++++++++++++++---------
 3 files changed, 116 insertions(+), 96 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 4a7a2d85aac..1fcc2b623da 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -18,7 +18,6 @@
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/dma/xlnx-zdma.h"
-#include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
@@ -78,8 +77,6 @@ struct Versal {
         MemoryRegion mr_ocm;
 
         struct {
-            CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
-            OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
         } iou;
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 52852082d4b..0634cc90eac 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -38,7 +38,6 @@ struct VersalVirt {
     int fdt_size;
     struct {
         uint32_t gic;
-        uint32_t ethernet_phy[2];
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
         uint32_t usb;
@@ -57,7 +56,6 @@ struct VersalVirt {
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
-    int i;
 
     s->fdt = create_device_tree(&s->fdt_size);
     if (!s->fdt) {
@@ -67,9 +65,6 @@ static void fdt_create(VersalVirt *s)
 
     /* Allocate all phandles.  */
     s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
-    for (i = 0; i < ARRAY_SIZE(s->phandle.ethernet_phy); i++) {
-        s->phandle.ethernet_phy[i] = qemu_fdt_alloc_phandle(s->fdt);
-    }
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
@@ -209,54 +204,6 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     g_free(name);
 }
 
-static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
-                                     uint32_t phandle)
-{
-    char *name = g_strdup_printf("%s/fixed-link", gemname);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", phandle);
-    qemu_fdt_setprop(s->fdt, name, "full-duplex", NULL, 0);
-    qemu_fdt_setprop_cell(s->fdt, name, "speed", 1000);
-    g_free(name);
-}
-
-static void fdt_add_gem_nodes(VersalVirt *s)
-{
-    uint64_t addrs[] = { MM_GEM1, MM_GEM0 };
-    unsigned int irqs[] = { VERSAL_GEM1_IRQ_0, VERSAL_GEM0_IRQ_0 };
-    const char clocknames[] = "pclk\0hclk\0tx_clk\0rx_clk";
-    const char compat_gem[] = "cdns,zynqmp-gem\0cdns,gem";
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        char *name = g_strdup_printf("/ethernet@%" PRIx64, addrs[i]);
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        fdt_add_fixed_link_nodes(s, name, s->phandle.ethernet_phy[i]);
-        qemu_fdt_setprop_string(s->fdt, name, "phy-mode", "rgmii-id");
-        qemu_fdt_setprop_cell(s->fdt, name, "phy-handle",
-                              s->phandle.ethernet_phy[i]);
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz,
-                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addrs[i], 2, 0x1000);
-        qemu_fdt_setprop(s->fdt, name, "compatible",
-                         compat_gem, sizeof(compat_gem));
-        qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 1);
-        qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 0);
-        g_free(name);
-    }
-}
-
 static void fdt_add_zdma_nodes(VersalVirt *s)
 {
     const char clocknames[] = "clk_main\0clk_apb";
@@ -612,7 +559,6 @@ static void versal_virt_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
-    fdt_add_gem_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index ff2f47daad9..7c53bc82a20 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -29,6 +29,7 @@
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/sd/sdhci.h"
+#include "hw/net/cadence_gem.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -51,6 +52,14 @@ typedef struct VersalMap {
 
     VersalSimplePeriphMap sdhci[2];
     size_t num_sdhci;
+
+    struct VersalGemMap {
+        VersalSimplePeriphMap map;
+        size_t num_prio_queue;
+        const char *phy_mode;
+        const uint32_t speed;
+    } gem[3];
+    size_t num_gem;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -65,6 +74,10 @@ static const VersalMap VERSAL_MAP = {
     .sdhci[0] = { 0xf1040000, 126 },
     .sdhci[1] = { 0xf1050000, 128 },
     .num_sdhci = 2,
+
+    .gem[0] = { { 0xff0c0000, 56 }, 2, "rgmii-id", 1000 },
+    .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
+    .num_gem = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -111,6 +124,18 @@ static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
     sysbus_connect_irq(sbd, sbd_idx, irq);
 }
 
+static void versal_qdev_connect_gpio_out(Versal *s, DeviceState *dev,
+                                         int dev_idx, int irq_idx)
+{
+    qemu_irq irq = versal_get_irq(s, irq_idx);
+
+    if (irq == NULL) {
+        return;
+    }
+
+    qdev_connect_gpio_out(dev, dev_idx, irq);
+}
+
 static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
                                            uint64_t at, const char *compat,
                                            size_t compat_sz)
@@ -140,6 +165,21 @@ static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
     return p;
 }
 
+static inline DeviceState *create_or_gate(Versal *s, Object *parent,
+                                          const char *name, uint16_t num_lines,
+                                          int irq_idx)
+{
+    DeviceState *or;
+
+    or = qdev_new(TYPE_OR_IRQ);
+    qdev_prop_set_uint16(or, "num-lines", num_lines);
+    object_property_add_child(parent, name, OBJECT(or));
+    qdev_realize_and_unref(or, NULL, &error_abort);
+    versal_qdev_connect_gpio_out(s, or, 0, irq_idx);
+
+    return or;
+}
+
 static void versal_create_apu_cpus(Versal *s)
 {
     int i;
@@ -377,46 +417,82 @@ static void versal_create_usbs(Versal *s, qemu_irq *pic)
     memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
 }
 
-static void versal_create_gems(Versal *s, qemu_irq *pic)
+static void versal_create_gem(Versal *s,
+                              const struct VersalGemMap *map)
 {
+    DeviceState *dev;
+    MemoryRegion *mr;
+    DeviceState *or;
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.gem); i++) {
-        static const int irqs[] = { VERSAL_GEM0_IRQ_0, VERSAL_GEM1_IRQ_0};
-        static const uint64_t addrs[] = { MM_GEM0, MM_GEM1 };
-        char *name = g_strdup_printf("gem%d", i);
-        DeviceState *dev;
-        MemoryRegion *mr;
-        OrIRQState *or_irq;
+    dev = qdev_new(TYPE_CADENCE_GEM);
+    object_property_add_child(OBJECT(s), "gem[*]", OBJECT(dev));
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
-                                TYPE_CADENCE_GEM);
-        or_irq = &s->lpd.iou.gem_irq_orgate[i];
-        object_initialize_child(OBJECT(s), "gem-irq-orgate[*]",
-                                or_irq, TYPE_OR_IRQ);
-        dev = DEVICE(&s->lpd.iou.gem[i]);
-        qemu_configure_nic_device(dev, true, NULL);
-        object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
-        object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
-                                &error_abort);
-        object_property_set_int(OBJECT(or_irq),
-                                "num-lines", 2, &error_fatal);
-        qdev_realize(DEVICE(or_irq), NULL, &error_fatal);
-        qdev_connect_gpio_out(DEVICE(or_irq), 0, pic[irqs[i]]);
+    qemu_configure_nic_device(dev, true, NULL);
+    object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
+    object_property_set_int(OBJECT(dev), "num-priority-queues",
+                            map->num_prio_queue, &error_abort);
 
-        object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
-                                 &error_abort);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, map->map.addr, mr);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(or_irq), 0));
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(or_irq), 1));
-        g_free(name);
+    /*
+     * The GEM controller exposes one IRQ line per priority queue. In Versal
+     * family devices, those are OR'ed together.
+     */
+    or = create_or_gate(s, OBJECT(dev), "irq-orgate",
+                        map->num_prio_queue, map->map.irq);
+
+    for (i = 0; i < map->num_prio_queue; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, qdev_get_gpio_in(or, i));
     }
 }
 
+static void versal_create_gem_fdt(Versal *s,
+                                  const struct VersalGemMap *map)
+{
+    int i;
+    g_autofree char *node;
+    g_autofree char *phy_node;
+    int phy_phandle;
+    const char compatible[] = "cdns,zynqmp-gem\0cdns,gem";
+    const char clocknames[] = "pclk\0hclk\0tx_clk\0rx_clk";
+    g_autofree uint32_t *irq_prop;
+
+    node = versal_fdt_add_simple_subnode(s, "/ethernet", map->map.addr, 0x1000,
+                                         compatible, sizeof(compatible));
+    phy_node = g_strdup_printf("%s/fixed-link", node);
+    phy_phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
+
+    /* Fixed link PHY node */
+    qemu_fdt_add_subnode(s->cfg.fdt, phy_node);
+    qemu_fdt_setprop_cell(s->cfg.fdt, phy_node, "phandle", phy_phandle);
+    qemu_fdt_setprop(s->cfg.fdt, phy_node, "full-duplex", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, phy_node, "speed", map->speed);
+
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "phy-mode", map->phy_mode);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "phy-handle", phy_phandle);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz,
+                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+
+    irq_prop = g_new(uint32_t, map->num_prio_queue * 3);
+    for (i = 0; i < map->num_prio_queue; i++) {
+        irq_prop[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
+        irq_prop[3 * i + 1] = cpu_to_be32(map->map.irq);
+        irq_prop[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    }
+    qemu_fdt_setprop(s->cfg.fdt, node, "interrupts", irq_prop,
+                     sizeof(uint32_t) * map->num_prio_queue * 3);
+}
+
+
 static void versal_create_admas(Versal *s, qemu_irq *pic)
 {
     int i;
@@ -902,14 +978,6 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
                                  &error_abort);
     }
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.gem); i++) {
-        g_autofree gchar *name = g_strdup_printf("gem[%d]", i);
-
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.iou.gem[i]),
-                                 &error_abort);
-    }
-
     for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
         g_autofree gchar *name = g_strdup_printf("adma[%d]", i);
 
@@ -1093,8 +1161,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
         versal_create_sdhci(s, &map->sdhci[i]);
     }
 
+    for (i = 0; i < map->num_gem; i++) {
+        versal_create_gem(s, &map->gem[i]);
+        /*
+         * Create fdt node in reverse order to keep backward compatibility with
+         * previous versions of the generated FDT. This affects Linux kernel
+         * interface naming order when persistent naming scheme is not in use.
+         */
+        versal_create_gem_fdt(s, &map->gem[map->num_gem - 1 - i]);
+    }
+
     versal_create_usbs(s, pic);
-    versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
-- 
2.43.0


