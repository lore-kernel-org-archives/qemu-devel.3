Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E388DCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Q4-0005fP-Lx; Tue, 07 Oct 2025 10:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q0-0005f3-Td
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pm-000288-Fl
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso51248955e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846297; x=1760451097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J41c/R0G8V7brEPhzE5k1w0NOA32agVYBgiUvBtPkYA=;
 b=fBHEw8FFfJPoga/FUBcj6aTR6HtwX5GkPI8D35kQYZywPmsUzsQWpL5ZqXgTV/4skB
 bmRdbcg6Hv1Bd4ZxrGM1xHlDjcSjRt3xhVkbWVcPeKh1Zvhpn47KGevPHIJDK8Y+DmNx
 wFzCtGqlMy4kz8OjnlkbO5bu24k2h6UVh42I0/xCFQc1Fzr8Fd1JFUro01g46oP8P95S
 /eRn8HjTS66gFADFosNNIdtk+fwedIyePoQMf45sO+lIPcx+NP7tHD3HLbmU2ezuJp1Z
 bTifb2qr0zVlu/HQSKnFhqI0Udd+lfMxzA+scXqQu01e0BzwRuU8lLtl+kvAYnU2Y6/O
 u1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846297; x=1760451097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J41c/R0G8V7brEPhzE5k1w0NOA32agVYBgiUvBtPkYA=;
 b=WWkVCwMditwaGXq5EsCbDLfNmaeNIiflrkWUQ3KYmYVTF7qydiGNUcUNBUSlyd4aGP
 W+u5b/0iM0q1StiKe7U4mAyCKOR23e8wi/gIA2/vyc5lOHZH6b6Z6LcMBKVAz0KlSc/x
 bTGCP3T471W/FM5CHY25MQiFVFuN0+X/3LJSgXg5wWLg4dGRcHwctbXMf5RKqq6M7XGr
 wB1S/b1GVa2Oz4Im0YTILA0ZSASkrs3r72+5Tu/xRqc8189Mcwbs6xfxsWPXxFQlH+xZ
 /JNEIPTyGmmdjK72HBtFOS7WA6Yn82BZ5YEEQKNsUxqD+x3r/cz9t2BhfCE9s3yAC04u
 uuLQ==
X-Gm-Message-State: AOJu0Yw9JCC+LmHUk4MLeFhcmckOs1gXAiDk5HDfh5GfAdgK/nimTWG6
 1wqWte0pRikwU+4XKGsw4rXBhfEudeckVG/eZwa4qBPUPyypxthYkvJ5Dii2wL/RFUjzDWl8Ilw
 F1Nu6
X-Gm-Gg: ASbGncs7vwtraRbqdIIYLxm5pZoU05fovcdQAcqmOVa/PMEiDlsjlr4OD4FZk9uPR4G
 HRuD7P+8iFrtceEeQJx5+MNqy1fWX/5tHSMr1EEEPFIasqjClZg7w2twx6AiP4es18w+sTtZ66E
 cLsya4vHCx+aH19SgovxHhwKiwC0wJ/rS5JyyZ3F4IgfdpgodR/l6Dgm4x6ffi/VHPcJ83j1q7q
 gU1IpntnYR7BNb/7WdVh0vTcLnyIEl+6+aUfJjSJU8N9K/Az+6fp8UtfuGcv8nlm/OpuHAc21SX
 7+SWyYRI36ZDaPZPqrA4k7h9yy9CwUyOWc2tilh7msDuyFZO8w/opRSwZLbwEUr1dhsF4fhgl1r
 RIqC9wcstjGwM+rPK8iQuspiQr5FpbVwxg3vB/NGiiTYwQkomatt6WOWl
X-Google-Smtp-Source: AGHT+IGBA/p1hLgIpxQPnW1L9MuXzYxxuqSfCu17WNLGwJ0afbIKzWn3tViCCRtdrpSrc02YE4cYpw==
X-Received: by 2002:a05:600c:4081:b0:46e:72df:a812 with SMTP id
 5b1f17b1804b1-46e72dfa86fmr69571865e9.4.1759846296613; 
 Tue, 07 Oct 2025 07:11:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/62] hw/arm/xlnx-versal: usb: refactor creation
Date: Tue,  7 Oct 2025 15:10:30 +0100
Message-ID: <20251007141123.3239867-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Refactor the USB controller creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-10-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  5 ---
 hw/arm/xlnx-versal-virt.c    | 56 +--------------------------
 hw/arm/xlnx-versal.c         | 74 +++++++++++++++++++++++++++++-------
 3 files changed, 62 insertions(+), 73 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 71c3314b8b4..5d4b30f0ff9 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -19,7 +19,6 @@
 #include "hw/intc/arm_gicv3.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
-#include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
@@ -74,10 +73,6 @@ struct Versal {
     struct {
         MemoryRegion mr_ocm;
 
-        struct {
-            VersalUsb2 usb;
-        } iou;
-
         /* Real-time Processing Unit.  */
         struct {
             MemoryRegion mr;
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 418e4c6e983..5801598da7c 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/device_tree.h"
+#include "system/address-spaces.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
@@ -40,8 +41,6 @@ struct VersalVirt {
         uint32_t gic;
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
-        uint32_t usb;
-        uint32_t dwc;
     } phandle;
     struct arm_boot_info binfo;
 
@@ -68,8 +67,6 @@ static void fdt_create(VersalVirt *s)
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
-    s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
-    s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
@@ -154,56 +151,6 @@ static void fdt_add_timer_nodes(VersalVirt *s)
                      compat, sizeof(compat));
 }
 
-static void fdt_add_usb_xhci_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "bus_clk\0ref_clk";
-    const char irq_name[] = "dwc_usb3";
-    const char compatVersalDWC3[] = "xlnx,versal-dwc3";
-    const char compatDWC3[] = "snps,dwc3";
-    char *name = g_strdup_printf("/usb@%" PRIx32, MM_USB2_CTRL_REGS);
-
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop(s->fdt, name, "compatible",
-                         compatVersalDWC3, sizeof(compatVersalDWC3));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_USB2_CTRL_REGS,
-                                 2, MM_USB2_CTRL_REGS_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-    qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_125Mhz);
-    qemu_fdt_setprop(s->fdt, name, "ranges", NULL, 0);
-    qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 2);
-    qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 2);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.usb);
-    g_free(name);
-
-    name = g_strdup_printf("/usb@%" PRIx32 "/dwc3@%" PRIx32,
-                           MM_USB2_CTRL_REGS, MM_USB_0);
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop(s->fdt, name, "compatible",
-                     compatDWC3, sizeof(compatDWC3));
-    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                 2, MM_USB_0, 2, MM_USB_0_SIZE);
-    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
-                     irq_name, sizeof(irq_name));
-    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_USB0_IRQ_0,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(s->fdt, name,
-                          "snps,quirk-frame-length-adjustment", 0x20);
-    qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
-    qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
-    qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy");
-    qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NULL, 0);
-    qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NULL, 0);
-    qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
-    qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
-    qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
-    g_free(name);
-}
-
 static void fdt_add_rtc_node(VersalVirt *s)
 {
     const char compat[] = "xlnx,zynqmp-rtc";
@@ -534,7 +481,6 @@ static void versal_virt_init(MachineState *machine)
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 295fca3d60d..946c0170674 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -32,6 +32,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/misc/xlnx-versal-xramc.h"
+#include "hw/usb/xlnx-usb-subsystem.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -80,6 +81,13 @@ typedef struct VersalMap {
         int irq;
         size_t num;
     } xram;
+
+    struct VersalUsbMap {
+        uint64_t xhci;
+        uint64_t ctrl;
+        int irq;
+    } usb[2];
+    size_t num_usb;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -108,6 +116,9 @@ static const VersalMap VERSAL_MAP = {
         .ctrl = 0xff8e0000, .ctrl_stride = 0x10000,
         .irq = 79,
     },
+
+    .usb[0] = { .xhci = 0xfe200000, .ctrl = 0xff9d0000, .irq = 22 },
+    .num_usb = 1,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -422,29 +433,67 @@ static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
-static void versal_create_usbs(Versal *s, qemu_irq *pic)
+static void versal_create_usb(Versal *s,
+                              const struct VersalUsbMap *map)
 {
     DeviceState *dev;
     MemoryRegion *mr;
+    g_autofree char *node, *subnode;
+    const char clocknames[] = "bus_clk\0ref_clk";
+    const char irq_name[] = "dwc_usb3";
+    const char compat_versal_dwc3[] = "xlnx,versal-dwc3";
+    const char compat_dwc3[] = "snps,dwc3";
 
-    object_initialize_child(OBJECT(s), "usb2", &s->lpd.iou.usb,
-                            TYPE_XILINX_VERSAL_USB2);
-    dev = DEVICE(&s->lpd.iou.usb);
+    dev = qdev_new(TYPE_XILINX_VERSAL_USB2);
+    object_property_add_child(OBJECT(s), "usb[*]", OBJECT(dev));
 
     object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
                              &error_abort);
     qdev_prop_set_uint32(dev, "intrs", 1);
     qdev_prop_set_uint32(dev, "slots", 2);
 
-    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-    memory_region_add_subregion(&s->mr_ps, MM_USB_0, mr);
+    memory_region_add_subregion(&s->mr_ps, map->xhci, mr);
 
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_USB0_IRQ_0]);
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
 
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
-    memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
+    memory_region_add_subregion(&s->mr_ps, map->ctrl, mr);
+
+    node = versal_fdt_add_simple_subnode(s, "/usb", map->ctrl, 0x10000,
+                                         compat_versal_dwc3,
+                                         sizeof(compat_versal_dwc3));
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                         clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                               s->phandle.clk_25mhz, s->phandle.clk_125mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "ranges", NULL, 0);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#address-cells", 2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#size-cells", 2);
+
+    subnode = g_strdup_printf("/%s/dwc3", node);
+    g_free(node);
+
+    node = versal_fdt_add_simple_subnode(s, subnode, map->xhci, 0x10000,
+                                         compat_dwc3,
+                                         sizeof(compat_dwc3));
+    qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-names",
+                     irq_name, sizeof(irq_name));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node,
+                          "snps,quirk-frame-length-adjustment", 0x20);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "#stream-id-cells", 1);
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "dr_mode", "host");
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "phy-names", "usb3-phy");
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,dis_u2_susphy_quirk", NULL, 0);
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,dis_u3_susphy_quirk", NULL, 0);
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,refclk_fladj", NULL, 0);
+    qemu_fdt_setprop(s->cfg.fdt, node, "snps,mask_phy_reset", NULL, 0);
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "maximum-speed", "high-speed");
 }
 
 static void versal_create_gem(Versal *s,
@@ -1017,10 +1066,6 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
                                  &error_abort);
     }
 
-    object_property_set_link(OBJECT(&s->lpd.crl),
-                             "usb", OBJECT(&s->lpd.iou.usb),
-                             &error_abort);
-
     sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, MM_CRL,
                                 sysbus_mmio_get_region(sbd, 0));
@@ -1208,7 +1253,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     versal_create_xrams(s, &map->xram);
 
-    versal_create_usbs(s, pic);
+    for (i = 0; i < map->num_usb; i++) {
+        versal_create_usb(s, &map->usb[i]);
+    }
+
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
-- 
2.43.0


