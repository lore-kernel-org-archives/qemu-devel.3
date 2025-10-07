Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCD9CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Q7-0005h6-G5; Tue, 07 Oct 2025 10:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q4-0005gJ-Jr
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pp-00028d-N1
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so32547195e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846299; x=1760451099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kGK38QachpaMpQCKi7uwYmY0JzTOQzsEO4np/oZh0BY=;
 b=HKu581YOza02ZOhH9Cun77Q+I0LiID25tTcR0DepQ66YojPpbm8242dVTooj2tuD/0
 oyM5mt76uJxsmvGWavgYH8jKR/qHprSpfE2AE2NMFfbD0r1/1aG+ZHz/raVIyVIS40hn
 yiLgnURReku15IGpS0G6GqS5MfOC4f3CluKBYSiHO3++rxS1HL7IPhA7u7A242/sl0PL
 M4R+MvDIeXJjChBSgHmLi+uwcgWWzXLA/G+DaXONxGBwEqsGnVlAZYkpyEqpfVuFccf3
 nOxBaD5iKg+JhNiX5ryKYXB2YqMx9QBAo0dec+wY8DGNwmY7z5kXhrdjIQKOfivmokjP
 JLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846299; x=1760451099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGK38QachpaMpQCKi7uwYmY0JzTOQzsEO4np/oZh0BY=;
 b=OBtYm7kpuHfJEFrX49qe34xH5B5QwIQu7cIANe92jPuqPC848xMZPnUyVYP/H5K9hP
 mcGMd6tkny1e5TmGi6i+yqF5Ft/72ZLgJvBD1bkyHUxXFexrulc5R6j6hb6xAfwa0+dy
 IxVxsJB2JQoIl6hRcqFn6SqymcNfAhTwavtJJCjbCrW+RQw9PvMa627Fjq1lTlB/S5AU
 7Ib33o5WYSccnMNWQcjZg0DY0hVtIBI4cwoUWuuEfYHbonfCfk6kaS8AblOq35XhsEJf
 l604fTbEN0aXmG17IZojv1xw1/dEEA/CnQlY4iiKJGidxQ9Nqsf7iVjssgk9k83YBpNE
 WEiw==
X-Gm-Message-State: AOJu0Yx/url8D434QATYpTjh4qqUuEmRjLkvV+xNZHwgXNuqEE/FkzAq
 6ffnodxbOn5slZh7KLYAxPAHyyhm0Lkctm0bYVBPnLh1RrVQvP/m6Y20Fgh9YGirus3TLLlTQsX
 +BsOK
X-Gm-Gg: ASbGncvcwyuJGx35JcX3yhpKZxtXH/7uLvQJrMHocqSuSEtlev/RpAPI6t3gL33/4sb
 x/TjTgW2km94L9mQ9o/sNgPzc2SkoThjSk7aAdQ5lnVL3hCzlV96JfN53KC3hHAAZhCtcjoxv7D
 1LORFfxJf2Ytk6fyuXwdpyR0IvsdN/oFK+8Bw5wYjYToYT/BaZI1rlM20W7NPF9B/EHpEuswAH4
 d5+0OdjuSNxlm34b7ZGm8+iIVjZyjX2lki0ub5pt1ZsijJZgwHk2YLCZzVVCp7ScuKDyLACypg8
 FCQ3uFlO8ERmrYaxYTjlP5sTzcbE3PZAHlaFfTfNdfWAY2ggnfTzez7PiMHT7xWU5pKVJVzUYX3
 6IHe/nbkL+GT/5K4/8a+aeWxFrJ2+jpPdwdYaxRfxqfXgCqQvqkJikjuh
X-Google-Smtp-Source: AGHT+IFdp9FimP8y1nqf4uTPgqngBS5xcPQyQe4H0ou4Css/GOkb+hd0/b9b5pXwLO+2LeTGaFBKPg==
X-Received: by 2002:a05:600c:1c02:b0:46e:37d5:dbed with SMTP id
 5b1f17b1804b1-46fa2d2164dmr26148135e9.12.1759846298776; 
 Tue, 07 Oct 2025 07:11:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/62] hw/arm/xlnx-versal: ospi: refactor creation
Date: Tue,  7 Oct 2025 15:10:32 +0100
Message-ID: <20251007141123.3239867-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Refactor the OSPI controller creation using the VersalMap structure.

Note that the connection to the PMC IOU SLCR is removed for now and will
be re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-12-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  12 +--
 hw/arm/xlnx-versal-virt.c    |  41 ++++------
 hw/arm/xlnx-versal.c         | 142 ++++++++++++++++++++---------------
 3 files changed, 98 insertions(+), 97 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 79ca9b13321..b7ef255d6fd 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -20,8 +20,6 @@
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/nvram/xlnx-bbram.h"
-#include "hw/ssi/xlnx-versal-ospi.h"
-#include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
@@ -88,14 +86,6 @@ struct Versal {
     struct {
         struct {
             XlnxVersalPmcIouSlcr slcr;
-
-            struct {
-                XlnxVersalOspi ospi;
-                XlnxCSUDMA dma_src;
-                XlnxCSUDMA dma_dst;
-                MemoryRegion linear_mr;
-                OrIRQState irq_orgate;
-            } ospi;
         } iou;
 
         XlnxZynqMPRTC rtc;
@@ -136,6 +126,8 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
+void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
+                              BlockBackend *blk);
 
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b6c49dafe09..a948e24aea0 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -48,8 +48,8 @@ struct VersalVirt {
 
     struct {
         bool secure;
+        char *ospi_model;
     } cfg;
-    char *ospi_model;
 };
 
 static void fdt_create(VersalVirt *s)
@@ -381,15 +381,15 @@ static char *versal_get_ospi_model(Object *obj, Error **errp)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
-    return g_strdup(s->ospi_model);
+    return g_strdup(s->cfg.ospi_model);
 }
 
 static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
-    g_free(s->ospi_model);
-    s->ospi_model = g_strdup(value);
+    g_free(s->cfg.ospi_model);
+    s->cfg.ospi_model = g_strdup(value);
 }
 
 
@@ -482,38 +482,27 @@ static void versal_virt_init(MachineState *machine)
     arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
 
     for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
-        BusState *spi_bus;
-        DeviceState *flash_dev;
         ObjectClass *flash_klass;
-        qemu_irq cs_line;
         DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
+        BlockBackend *blk;
+        const char *mdl;
 
-        spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
-
-        if (s->ospi_model) {
-            flash_klass = object_class_by_name(s->ospi_model);
+        if (s->cfg.ospi_model) {
+            flash_klass = object_class_by_name(s->cfg.ospi_model);
             if (!flash_klass ||
                 object_class_is_abstract(flash_klass) ||
                 !object_class_dynamic_cast(flash_klass, TYPE_M25P80)) {
                 error_report("'%s' is either abstract or"
-                       " not a subtype of m25p80", s->ospi_model);
+                       " not a subtype of m25p80", s->cfg.ospi_model);
                 exit(1);
             }
+            mdl = s->cfg.ospi_model;
+        } else {
+            mdl = "mt35xu01g";
         }
 
-        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
-
-        if (dinfo) {
-            qdev_prop_set_drive_err(flash_dev, "drive",
-                                    blk_by_legacy_dinfo(dinfo), &error_fatal);
-        }
-        qdev_prop_set_uint8(flash_dev, "cs", i);
-        qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
-
-        cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
-
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.pmc.iou.ospi),
-                           i + 1, cs_line);
+        blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+        versal_ospi_create_flash(&s->soc, i, mdl, blk);
     }
 }
 
@@ -542,7 +531,7 @@ static void versal_virt_machine_finalize(Object *obj)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
-    g_free(s->ospi_model);
+    g_free(s->cfg.ospi_model);
     g_free(s->canbus);
 }
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index f8291ac614b..964250bf151 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -34,6 +34,7 @@
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
+#include "hw/ssi/xlnx-versal-ospi.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -95,6 +96,15 @@ typedef struct VersalMap {
         uint64_t cache;
         int irq;
     } efuse;
+
+    struct VersalOspiMap {
+        uint64_t ctrl;
+        uint64_t dac;
+        uint64_t dac_sz;
+        uint64_t dma_src;
+        uint64_t dma_dst;
+        int irq;
+    } ospi;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -128,6 +138,13 @@ static const VersalMap VERSAL_MAP = {
     .num_usb = 1,
 
     .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 139 },
+
+    .ospi = {
+        .ctrl = 0xf1010000,
+        .dac = 0xc0000000, .dac_sz = 0x20000000,
+        .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
+        .irq = 124,
+    },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -815,95 +832,74 @@ static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
                        qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 2));
 }
 
-static void versal_create_ospi(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_ospi(Versal *s,
+                                       const struct VersalOspiMap *map)
 {
     SysBusDevice *sbd;
     MemoryRegion *mr_dac;
-    qemu_irq ospi_mux_sel;
-    DeviceState *orgate;
+    DeviceState *dev, *dma_dst, *dma_src, *orgate;
+    MemoryRegion *linear_mr = g_new(MemoryRegion, 1);
 
-    memory_region_init(&s->pmc.iou.ospi.linear_mr, OBJECT(s),
-                       "versal-ospi-linear-mr" , MM_PMC_OSPI_DAC_SIZE);
+    dev = qdev_new(TYPE_XILINX_VERSAL_OSPI);
+    object_property_add_child(OBJECT(s), "ospi", OBJECT(dev));
 
-    object_initialize_child(OBJECT(s), "versal-ospi", &s->pmc.iou.ospi.ospi,
-                            TYPE_XILINX_VERSAL_OSPI);
+    memory_region_init(linear_mr, OBJECT(dev), "linear-mr", map->dac_sz);
 
-    mr_dac = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi), 1);
-    memory_region_add_subregion(&s->pmc.iou.ospi.linear_mr, 0x0, mr_dac);
+    mr_dac = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion(linear_mr, 0x0, mr_dac);
 
     /* Create the OSPI destination DMA */
-    object_initialize_child(OBJECT(s), "versal-ospi-dma-dst",
-                            &s->pmc.iou.ospi.dma_dst,
-                            TYPE_XLNX_CSU_DMA);
+    dma_dst = qdev_new(TYPE_XLNX_CSU_DMA);
+    object_property_add_child(OBJECT(dev), "dma-dst-dev", OBJECT(dma_dst));
+    object_property_set_link(OBJECT(dma_dst), "dma",
+                             OBJECT(get_system_memory()), &error_abort);
 
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_dst),
-                            "dma", OBJECT(get_system_memory()),
-                             &error_abort);
+    sbd = SYS_BUS_DEVICE(dma_dst);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_dst);
-    sysbus_realize(sbd, &error_fatal);
-
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DMA_DST,
+    memory_region_add_subregion(&s->mr_ps, map->dma_dst,
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* Create the OSPI source DMA */
-    object_initialize_child(OBJECT(s), "versal-ospi-dma-src",
-                            &s->pmc.iou.ospi.dma_src,
-                            TYPE_XLNX_CSU_DMA);
+    dma_src = qdev_new(TYPE_XLNX_CSU_DMA);
+    object_property_add_child(OBJECT(dev), "dma-src-dev", OBJECT(dma_src));
 
-    object_property_set_bool(OBJECT(&s->pmc.iou.ospi.dma_src), "is-dst",
-                             false, &error_abort);
+    object_property_set_bool(OBJECT(dma_src), "is-dst", false, &error_abort);
 
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
-                            "dma", OBJECT(mr_dac), &error_abort);
-
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
-                            "stream-connected-dma",
-                             OBJECT(&s->pmc.iou.ospi.dma_dst),
+    object_property_set_link(OBJECT(dma_src), "dma", OBJECT(mr_dac),
                              &error_abort);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_src);
-    sysbus_realize(sbd, &error_fatal);
+    object_property_set_link(OBJECT(dma_src), "stream-connected-dma",
+                             OBJECT(dma_dst), &error_abort);
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DMA_SRC,
+    sbd = SYS_BUS_DEVICE(dma_src);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+
+    memory_region_add_subregion(&s->mr_ps, map->dma_src,
                                 sysbus_mmio_get_region(sbd, 0));
 
     /* Realize the OSPI */
-    object_property_set_link(OBJECT(&s->pmc.iou.ospi.ospi), "dma-src",
-                             OBJECT(&s->pmc.iou.ospi.dma_src), &error_abort);
+    object_property_set_link(OBJECT(dev), "dma-src",
+                             OBJECT(dma_src), &error_abort);
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI,
+    memory_region_add_subregion(&s->mr_ps, map->ctrl,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DAC,
-                                &s->pmc.iou.ospi.linear_mr);
-
-    /* ospi_mux_sel */
-    ospi_mux_sel = qdev_get_gpio_in_named(DEVICE(&s->pmc.iou.ospi.ospi),
-                                          "ospi-mux-sel", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "ospi-mux-sel", 0,
-                                ospi_mux_sel);
+    memory_region_add_subregion(&s->mr_ps, map->dac,
+                                linear_mr);
 
     /* OSPI irq */
-    object_initialize_child(OBJECT(s), "ospi-irq-orgate",
-                            &s->pmc.iou.ospi.irq_orgate, TYPE_OR_IRQ);
-    object_property_set_int(OBJECT(&s->pmc.iou.ospi.irq_orgate),
-                            "num-lines", NUM_OSPI_IRQ_LINES, &error_fatal);
+    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", NUM_OSPI_IRQ_LINES,
+                            map->irq);
 
-    orgate = DEVICE(&s->pmc.iou.ospi.irq_orgate);
-    qdev_realize(orgate, NULL, &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(orgate, 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma_src), 0, qdev_get_gpio_in(orgate, 1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
 
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi), 0,
-                       qdev_get_gpio_in(orgate, 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_src), 0,
-                       qdev_get_gpio_in(orgate, 1));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_dst), 0,
-                       qdev_get_gpio_in(orgate, 2));
-
-    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_OSPI_IRQ]);
+    return dev;
 }
 
 static void versal_create_cfu(Versal *s, qemu_irq *pic)
@@ -1266,13 +1262,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
     }
 
     versal_create_efuse(s, &map->efuse);
+    versal_create_ospi(s, &map->ospi);
 
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_bbram(s, pic);
     versal_create_pmc_iou_slcr(s, pic);
-    versal_create_ospi(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
@@ -1318,6 +1314,30 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
     qdev_prop_set_drive(efuse, "drive", blk);
 }
 
+void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
+                              BlockBackend *blk)
+{
+    BusState *spi_bus;
+    DeviceState *flash, *ospi;
+    qemu_irq cs_line;
+
+    ospi = DEVICE(versal_get_child(s, "ospi"));
+    spi_bus = qdev_get_child_bus(ospi, "spi0");
+
+    flash = qdev_new(flash_mdl);
+
+    if (blk) {
+        qdev_prop_set_drive_err(flash, "drive", blk, &error_fatal);
+    }
+    qdev_prop_set_uint8(flash, "cs", flash_idx);
+    qdev_realize_and_unref(flash, spi_bus, &error_fatal);
+
+    cs_line = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(ospi),
+                       flash_idx + 1, cs_line);
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
-- 
2.43.0


