Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F53CCD185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Q0-0005f1-97; Tue, 07 Oct 2025 10:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pt-0005cE-O8
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pl-00027a-Da
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so70054935e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846294; x=1760451094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G3gy6d2csiGARxgk9ASTnLWPxen54VGTjRgfkcYu+iI=;
 b=waEvo04XiRG1xESFYAbhKH4uX35dY7UdmcV+72TFN4oxxHT5AwyW5P+EbrorbNOMPU
 iDHFmIhXnvXGMhCvlH3npAcblxBxfA3boXwUSxfwK2HUiXdMGEQgdUbrgyvJqNWqGqnP
 Qh1nEPeH+7V/NXaN8zMFEliqy7BfHtgia/F/TwSg8BhmN7LF/DfiQav3y49FcISsLcfT
 IG4OiYUiTemCfOK7hece8rAMA9XOq+aOhdoJqB2/ZvDoURZT/GI2LfIIPEukNgTYIw2Z
 CTQweTorMyCX52SD69nWeKXMHEL3/lviHLmmUvsS3bNnE3OqEu3+FcVwphp4nJrtHISz
 RQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846294; x=1760451094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3gy6d2csiGARxgk9ASTnLWPxen54VGTjRgfkcYu+iI=;
 b=mHq+y1MtaqO6196ZHIrrzwbNULKvVDQ/3bobBX9Mv/MzaCza2js1/ltqZVpsz4yqMw
 qX8/G1luxl2IXXfJpqNhl+qsq5sU8xatiHWZtk8D4nmSX6jWT9uxoD6fgfEw14cSsB0J
 FsxBnNXSEMRLRn39cN+k7ngOHwtH1Sd5xrsNW3vZsn2zhGFZ257uWYuxq6v5mLrcmax0
 IfQnrz+69NtF6B/lClpsGUO5oSGq00ikTXC5EVlEzBIW12nNMKx6WtAeqjjKvr5D7xoH
 GHV3S1elsSEMSKXTrmVb9qW8A12ff82wbqid2HChH4dCye16B2HWXAp82Yd47dcs8FNJ
 Ia8A==
X-Gm-Message-State: AOJu0YzjhiqJMfsulD6lRdYhxr20zP2LdSCVCj+QsdwyP1tpHkiBGP/C
 slwqhbI0nH2q8qhs8NJIRVmYxUkwlH43dnPD6nrepvTN6bhjtMBXG+ujge46czusHrFbLdlhXG0
 aFvC8
X-Gm-Gg: ASbGncvPk7t2gcwsGFDEv83jGffrO6eo8zblOBLyNzyawS2Enc5yQ7GSGCA5oT3rGip
 sTm2q1fDfYvg6WOZdtNzFL3c8Ja9V3m6s5jcxFwc9P5tHYiiirXt9rlFN7l9AaRXZNNIQK4GLsN
 O35ShHnQ/w1UtfakJronVL3xWjcUOjidOh9IJIFQ38zVzX1zceHwEILBftRSzPnLL92ZGU7QTqS
 mfry1U7y+6T1e1CkkdWpelQB4kzK2YrlCVn4DMQKzSO39tow4r2BnETwdfHMYTH6fKiMyyj6E23
 Hf3amL36OVYdnZ+W9GnMfoy5l5LK2nwmLxTZ4BnNe+zmuwCCJVWKNqskqF3dTg5Q4EKyH99oKDs
 pgv6Xo48ojSATC8KTcLa43bGRrrUVzzlsIbjaBnxsUSWSNU6WG0/lJTlyLdiNfN0DQWY=
X-Google-Smtp-Source: AGHT+IGUIbpIRMnzeoiND5P//WcNHTItGPGcE2BrzsxG9m6UxZi5yf7y6KVGudkHxIj5kxTNYafTHA==
X-Received: by 2002:a05:600c:3b08:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-46e71101a79mr124886135e9.6.1759846294208; 
 Tue, 07 Oct 2025 07:11:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/62] hw/arm/xlnx-versal: adma: refactor creation
Date: Tue,  7 Oct 2025 15:10:28 +0100
Message-ID: <20251007141123.3239867-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Refactor the ADMA creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-8-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  2 -
 hw/arm/xlnx-versal-virt.c    | 28 --------------
 hw/arm/xlnx-versal.c         | 72 ++++++++++++++++++++++++------------
 3 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 1fcc2b623da..4eeea98ff34 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -17,7 +17,6 @@
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
-#include "hw/dma/xlnx-zdma.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
@@ -77,7 +76,6 @@ struct Versal {
         MemoryRegion mr_ocm;
 
         struct {
-            XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
         } iou;
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0634cc90eac..418e4c6e983 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -204,33 +204,6 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     g_free(name);
 }
 
-static void fdt_add_zdma_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "clk_main\0clk_apb";
-    const char compat[] = "xlnx,zynqmp-dma-1.0";
-    int i;
-
-    for (i = XLNX_VERSAL_NR_ADMAS - 1; i >= 0; i--) {
-        uint64_t addr = MM_ADMA_CH0 + MM_ADMA_CH0_SIZE * i;
-        char *name = g_strdup_printf("/dma@%" PRIx64, addr);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cell(s->fdt, name, "xlnx,bus-width", 64);
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_ADMA_IRQ_0 + i,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addr, 2, 0x1000);
-        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-        g_free(name);
-    }
-}
-
 static void fdt_add_rtc_node(VersalVirt *s)
 {
     const char compat[] = "xlnx,zynqmp-rtc";
@@ -561,7 +534,6 @@ static void versal_virt_init(MachineState *machine)
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 7c53bc82a20..5c2bd4be1f7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -30,6 +30,7 @@
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/sd/sdhci.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/dma/xlnx-zdma.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -60,6 +61,16 @@ typedef struct VersalMap {
         const uint32_t speed;
     } gem[3];
     size_t num_gem;
+
+    struct VersalZDMAMap {
+        const char *name;
+        VersalSimplePeriphMap map;
+        size_t num_chan;
+        uint64_t chan_stride;
+        int irq_stride;
+    } zdma[2];
+    size_t num_zdma;
+
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -78,6 +89,9 @@ static const VersalMap VERSAL_MAP = {
     .gem[0] = { { 0xff0c0000, 56 }, 2, "rgmii-id", 1000 },
     .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
     .num_gem = 2,
+
+    .zdma[0] = { "adma", { 0xffa80000, 60 }, 8, 0x10000, 1 },
+    .num_zdma = 1,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -492,30 +506,45 @@ static void versal_create_gem_fdt(Versal *s,
                      sizeof(uint32_t) * map->num_prio_queue * 3);
 }
 
-
-static void versal_create_admas(Versal *s, qemu_irq *pic)
+static void versal_create_zdma(Versal *s,
+                               const struct VersalZDMAMap *map)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *name;
+    const char compatible[] = "xlnx,zynqmp-dma-1.0";
+    const char clocknames[] = "clk_main\0clk_apb";
+    size_t i;
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
-        char *name = g_strdup_printf("adma%d", i);
-        DeviceState *dev;
-        MemoryRegion *mr;
+    name = g_strdup_printf("%s[*]", map->name);
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.adma[i],
-                                TYPE_XLNX_ZDMA);
-        dev = DEVICE(&s->lpd.iou.adma[i]);
+    for (i = 0; i < map->num_chan; i++) {
+        uint64_t addr = map->map.addr + map->chan_stride * i;
+        int irq = map->map.irq + map->irq_stride * i;
+        g_autofree char *node;
+
+        dev = qdev_new(TYPE_XLNX_ZDMA);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev));
         object_property_set_int(OBJECT(dev), "bus-width", 128, &error_abort);
         object_property_set_link(OBJECT(dev), "dma",
                                  OBJECT(get_system_memory()), &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps,
-                                    MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
+        memory_region_add_subregion(&s->mr_ps, addr, mr);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_ADMA_IRQ_0 + i]);
-        g_free(name);
+        versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, irq);
+
+        node = versal_fdt_add_simple_subnode(s, "/dma", addr, 0x1000,
+                                             compatible, sizeof(compatible));
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "xlnx,bus-width", 64);
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                               s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+        qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                         clocknames, sizeof(clocknames));
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     }
 }
 
@@ -978,14 +1007,6 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
                                  &error_abort);
     }
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
-        g_autofree gchar *name = g_strdup_printf("adma[%d]", i);
-
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.iou.adma[i]),
-                                 &error_abort);
-    }
-
     object_property_set_link(OBJECT(&s->lpd.crl),
                              "usb", OBJECT(&s->lpd.iou.usb),
                              &error_abort);
@@ -1171,8 +1192,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
         versal_create_gem_fdt(s, &map->gem[map->num_gem - 1 - i]);
     }
 
+    for (i = 0; i < map->num_zdma; i++) {
+        versal_create_zdma(s, &map->zdma[i]);
+    }
+
     versal_create_usbs(s, pic);
-    versal_create_admas(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
-- 
2.43.0


