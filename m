Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A29FCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Pr-0005b1-0C; Tue, 07 Oct 2025 10:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pm-0005Zy-ON
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pg-00027F-Sw
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so57800195e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846292; x=1760451092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0cMdDKIQDg7CKjwcQRQZC4ht62S9Iu7Xq9R+UBWw6U8=;
 b=OWrXdlzrbp6egNXPQfXH/Xnelw/ZIlvlvDEyAu3fmOLeGJIkhkCXnKogfBo3oOfHPi
 ugGcUPMo0Fff5VxnpM2FiaLmsJXPB1GzprISTHGedzAJXvzzPadIJPZgoieWcmkhgANa
 8cPm6jx39vyciaMc7k9O2+pj6QPsjDpzlWCAal8QXB5IMpjLddP8volI6dLDhaUEM42t
 T/ody0UPjr4YTwY4E3tkr2dmhkTapr4QgNxmoja7EBpJ1qz9xd47JWmESHI1Ru+WVdKu
 7YZblf34dSv9lCicCzTL9n6EGJBy+vy3hvYMtoTBhdujoaSjyL3M/RoQdTpL7mzy6idq
 xBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846292; x=1760451092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cMdDKIQDg7CKjwcQRQZC4ht62S9Iu7Xq9R+UBWw6U8=;
 b=p1GYz5tzw29tLwqwB0sf3BSLPJu0mNAApfXLvO3yDuJU978uTKG52FNRUu6SuEzO9y
 9Yb/FHjZhUEfMK1/6sdw3Z9lIb29zy3hvyZDCW90Vs1MWnrCcOYbXF7LzfE8BfR+9s6Y
 N1bMig73p3LrVHzDEWBOGfqzD3pfNFxVDsFWuhaJSRQD9fZ7lAgdLNh532HEkBnYcp7G
 wK71V7ZHTjP4XeDboWtCAWmhd0EQXW3pKfs7GSXwk/ypPdw+ECL6QaC5o+Ir9FCObssA
 3y741d4uCKSUkS+NYgKsrhtEUZdEXWV1rkZJskmiuVoRLyqXbCt6A3vDbZV9SbmRVnxW
 5H+g==
X-Gm-Message-State: AOJu0YxQwNVek4EqLlrf14xWB+Kj/S8hR/ILYstv4sEcvUbOdEj8d6rz
 ExR5CIjLQYtpS6WUDtR+l4wdq3mLjpzAtHPC7JGsYNUrhoN7wYulXMhionokXFcCmsF8cV/RSEK
 VtEn8
X-Gm-Gg: ASbGncvHL1UHoMsE0RRwk1XYFQ2+35QTZivlxwJwS+Oir79LvfuELcb3nJndI/+gWO8
 PhM6RCzKH10PZGcoUvQg5+P4osq/1dXKFpsHSU/GAaF0SwVUsH/7sh4H5dm4zRnZvp3jnQvddAE
 trC3TvkfqJA1W4IpXgcHKNH6nXWdMsfALrUbVIBGhxcF+6R4Epa6z/JkSEnuoiNBykZa7mYgrs0
 xUzQA0C89bzsxwr/SX9yNqhWcKQlaoInhouELSVbj7BG+VcpiWaiBbp8SG3l8LMAXaSLh+ploxb
 QeIB3HtOkGMVXNqtFUE5On3aHtalag9c4o52jYWWP0+hyUpncY8A9ccYkUbneFjpPWcNCvewbHU
 XVhnB8wp8eAGMu66otMF2XFinHDTRIVXMbCXfaud4zRKHvXAWudZYSOey
X-Google-Smtp-Source: AGHT+IFRKUy6uKjh7VNdWcA+mWw8qpQJqoMnxHgQ6RnnFAge+szw492vho3fw5aY0jRD+X75/tcgHA==
X-Received: by 2002:a05:600c:3541:b0:46e:3d41:5fe7 with SMTP id
 5b1f17b1804b1-46e71168cd8mr102460955e9.29.1759846292322; 
 Tue, 07 Oct 2025 07:11:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/62] hw/arm/xlnx-versal: sdhci: refactor creation
Date: Tue,  7 Oct 2025 15:10:26 +0100
Message-ID: <20251007141123.3239867-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Refactor the SDHCI controllers creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-6-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  5 +-
 hw/arm/xlnx-versal-virt.c    | 43 ++--------------
 hw/arm/xlnx-versal.c         | 96 ++++++++++++++++++++++++++++--------
 3 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 007c91b596e..4a7a2d85aac 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -16,7 +16,6 @@
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
-#include "hw/sd/sdhci.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
@@ -105,7 +104,6 @@ struct Versal {
     /* The Platform Management Controller subsystem.  */
     struct {
         struct {
-            SDHCIState sd[XLNX_VERSAL_NR_SDS];
             XlnxVersalPmcIouSlcr slcr;
 
             struct {
@@ -156,7 +154,10 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
     s->cfg.fdt = fdt;
 }
 
+void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
+
 int versal_get_num_can(VersalVersion version);
+int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 334252564be..52852082d4b 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -284,32 +284,6 @@ static void fdt_add_zdma_nodes(VersalVirt *s)
     }
 }
 
-static void fdt_add_sd_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "clk_xin\0clk_ahb";
-    const char compat[] = "arasan,sdhci-8.9a";
-    int i;
-
-    for (i = ARRAY_SIZE(s->soc.pmc.iou.sd) - 1; i >= 0; i--) {
-        uint64_t addr = MM_PMC_SD0 + MM_PMC_SD0_SIZE * i;
-        char *name = g_strdup_printf("/sdhci@%" PRIx64, addr);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_SD0_IRQ_0 + i * 2,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addr, 2, MM_PMC_SD0_SIZE);
-        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-        g_free(name);
-    }
-}
-
 static void fdt_add_rtc_node(VersalVirt *s)
 {
     const char compat[] = "xlnx,zynqmp-rtc";
@@ -564,16 +538,11 @@ static void efuse_attach_drive(XlnxEFuse *dev)
     }
 }
 
-static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
+static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
 {
     BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    DeviceState *card;
 
-    card = qdev_new(TYPE_SD_CARD);
-    object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card));
-    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sd), "sd-bus"),
-                           &error_fatal);
+    versal_sdhci_plug_card(&s->soc, idx, blk);
 }
 
 static char *versal_get_ospi_model(Object *obj, Error **errp)
@@ -648,7 +617,6 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
-    fdt_add_sd_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
@@ -668,10 +636,9 @@ static void versal_virt_init(MachineState *machine)
     /* Attach efuse backend, if given */
     efuse_attach_drive(&s->soc.pmc.efuse);
 
-    /* Plugin SD cards.  */
-    for (i = 0; i < ARRAY_SIZE(s->soc.pmc.iou.sd); i++) {
-        sd_plugin_card(&s->soc.pmc.iou.sd[i],
-                       drive_get(IF_SD, 0, i));
+    /* Plug SD cards */
+    for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
+        sd_plug_card(s, i, drive_get(IF_SD, 0, i));
     }
 
     s->binfo.ram_size = machine->ram_size;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3d2e33d3dac..ff2f47daad9 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -28,6 +28,7 @@
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
+#include "hw/sd/sdhci.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -47,6 +48,9 @@ typedef struct VersalMap {
 
     VersalSimplePeriphMap canfd[4];
     size_t num_canfd;
+
+    VersalSimplePeriphMap sdhci[2];
+    size_t num_sdhci;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -57,6 +61,10 @@ static const VersalMap VERSAL_MAP = {
     .canfd[0] = { 0xff060000, 20 },
     .canfd[1] = { 0xff070000, 21 },
     .num_canfd = 2,
+
+    .sdhci[0] = { 0xf1040000, 126 },
+    .sdhci[1] = { 0xf1050000, 128 },
+    .num_sdhci = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -73,6 +81,18 @@ static inline const VersalMap *versal_get_map(Versal *s)
     return VERSION_TO_MAP[versal_get_version(s)];
 }
 
+static inline Object *versal_get_child(Versal *s, const char *child)
+{
+    return object_resolve_path_at(OBJECT(s), child);
+}
+
+static inline Object *versal_get_child_idx(Versal *s, const char *child,
+                                           size_t idx)
+{
+    g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
+
+    return versal_get_child(s, n);
+}
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
@@ -424,32 +444,39 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
 }
 
 #define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
-static void versal_create_sds(Versal *s, qemu_irq *pic)
+static void versal_create_sdhci(Versal *s,
+                                const VersalSimplePeriphMap *map)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    const char compatible[] = "arasan,sdhci-8.9a";
+    const char clocknames[] = "clk_xin\0clk_ahb";
 
-    for (i = 0; i < ARRAY_SIZE(s->pmc.iou.sd); i++) {
-        DeviceState *dev;
-        MemoryRegion *mr;
+    dev = qdev_new(TYPE_SYSBUS_SDHCI);
+    object_property_add_child(OBJECT(s), "sdhci[*]", OBJECT(dev));
 
-        object_initialize_child(OBJECT(s), "sd[*]", &s->pmc.iou.sd[i],
-                                TYPE_SYSBUS_SDHCI);
-        dev = DEVICE(&s->pmc.iou.sd[i]);
+    object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-        object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
-                                 &error_fatal);
-        object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
-                                 &error_fatal);
-        object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps,
-                                    MM_PMC_SD0 + i * MM_PMC_SD0_SIZE, mr);
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
-                           pic[VERSAL_SD0_IRQ_0 + i * 2]);
-    }
+    node = versal_fdt_add_simple_subnode(s, "/sdhci", map->addr, 0x10000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
 static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
@@ -1062,10 +1089,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
         versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
     }
 
+    for (i = 0; i < map->num_sdhci; i++) {
+        versal_create_sdhci(s, &map->sdhci[i]);
+    }
+
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
-    versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
@@ -1089,6 +1119,23 @@ static void versal_realize(DeviceState *dev, Error **errp)
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
+{
+    DeviceState *sdhci, *card;
+
+    sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
+
+    if (sdhci == NULL) {
+        return;
+    }
+
+    card = qdev_new(TYPE_SD_CARD);
+    object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                           &error_fatal);
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
@@ -1096,6 +1143,13 @@ int versal_get_num_can(VersalVersion version)
     return map->num_canfd;
 }
 
+int versal_get_num_sdhci(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->num_sdhci;
+}
+
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
-- 
2.43.0


