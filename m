Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6263CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Po-0005ae-Ks; Tue, 07 Oct 2025 10:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pm-0005ZO-7O
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pf-000274-82
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so70682985e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846291; x=1760451091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jArA7Esvg64NrfHlt/LBEhrn290ZO8SS+I/X/+Cb/CI=;
 b=wfb4kbFQOoD+uP3LEpQcatLHI+msG1gB8PT38pXLAluDm9gyMzcuih91Ei0I7BmF5+
 M+7p5fZGGbZiRHZppn+e+qJUPek2RvGB18may4r+3vLbu2tQKS7/tDpXSU5aE1cMOXaP
 d3jfbDj4fvq3DwDgqht1/h4v8/D8lsU9rr7qMqg+7n45I0w5ithoiZt9Y2pOQGrUpSTc
 bykyAOdSv26lwnMKZ2i5DZ5yR7wbr/o2tBIWWCjy9brCQL538zCUkCYxcsv7gktq+/gI
 8t/dQBRnWJBiqNgEHc0ORFNofQpsV59y7wFTnM0LFkIxEjvbb5PuM9NFfhbZToQGiwa3
 uK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846291; x=1760451091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jArA7Esvg64NrfHlt/LBEhrn290ZO8SS+I/X/+Cb/CI=;
 b=JFQ6CpU143lLWBNj6cwJZqlTEJ/irQxR2oUPFC95RLnHBtx3fEIks6cKp6B0igTV6i
 ELjxQIH03f/lEc0u2LmOY8RcBU59Qtj/OPbWDQjFaDVzoxwRcbF/opVNeLT/BsH3RKb5
 OQQvF8jW2fxJsspPoHTVV8FmrbjltkCQ/5JdbnMfybfCO5XMt4CduH75qefjGzw3aE4M
 tg7zNiM8XpR88We26nCo9QzZaaLWa4G8fxIw+0FICfcWiLB/KYm1frdRjdVSygTDyunB
 sb3Q0SImUN+dTVcf8tjc4PtMiSYzYN+pVizOC8SPkVyhkBisN9BYHmLtcv5kFSY/pJzv
 +k0w==
X-Gm-Message-State: AOJu0YzpyTHr6eOYWOnY4O5T+qpg47Ve81wvtf6QmSSZNCZkJonCP5an
 UxfWiAnGIT45l9+aCjCOXiSpsHim8xjx1wnXxDYsM1Ce14pevaG6JF0WmOZT2VKe0g8iMxXp124
 A6Sxb
X-Gm-Gg: ASbGncsvelLvM5EuKcB3qTvwSue3oX+czt4R4S7NQC3NWjbgj0vBQX4IMtw0ihRoaeL
 cMLkvfwgpEVg1yiyG66qaOy1onQtXmJ/bQLEbaKmaHfpJMdawyJurMBbvPSULQeyav8ft77jV+m
 pbQKi24sLzSYLJsv6KVfb+I4U5YHEelO0AVmu6jl1ItVA5uVUvtk4IYfbb2iFfN+Pe1RjzyFm9W
 8tlMN6hKoW/GaH//TPp4ohddpbg6E1BqzKzgv10syzlU9bgPGxACMCPR4adaoQYbaALuHeyNxXw
 ax6Zj9ZLzgMQU7h3Sps8NRkvuecRHmO7ZDv/UyaaInStPag3iaNZGLXU1b2qtNFgqJIPczXU/lH
 KC8/VAoC/1NSawzdtXirESdwUpOagKfmjUnYdQEpAc2SkQvKbxuj9bWuO
X-Google-Smtp-Source: AGHT+IEPcAJ29SK6Yai68K+KE6boAnBeYfIEC96nVANzWPNCsckjBUBCE6Pkl9IORpLure14G/yn/Q==
X-Received: by 2002:a05:600c:3b0f:b0:46e:59dd:1b4d with SMTP id
 5b1f17b1804b1-46e7110a268mr150212375e9.16.1759846291063; 
 Tue, 07 Oct 2025 07:11:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/62] hw/arm/xlnx-versal: canfd: refactor creation
Date: Tue,  7 Oct 2025 15:10:25 +0100
Message-ID: <20251007141123.3239867-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Refactor the CAN controllers creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

The xlnx-versal-virt machine now dynamically creates the correct amount
of CAN bus link properties based on the number of CAN controller
advertised by the SoC.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-5-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  7 +--
 hw/arm/xlnx-versal-virt.c    | 73 +++++++++-------------------
 hw/arm/xlnx-versal.c         | 94 +++++++++++++++++++++++++-----------
 3 files changed, 95 insertions(+), 79 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b01ddeb1423..007c91b596e 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -31,7 +31,7 @@
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
-#include "hw/net/xlnx-versal-canfd.h"
+#include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
@@ -83,8 +83,6 @@ struct Versal {
             OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
-            CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
-            XlnxVersalCANFDState canfd[XLNX_VERSAL_NR_CANFD];
         } iou;
 
         /* Real-time Processing Unit.  */
@@ -141,6 +139,7 @@ struct Versal {
 
     struct {
         MemoryRegion *mr_ddr;
+        CanBusState **canbus;
         void *fdt;
     } cfg;
 };
@@ -157,6 +156,8 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
     s->cfg.fdt = fdt;
 }
 
+int versal_get_num_can(VersalVersion version);
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e1deae11317..334252564be 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -43,11 +43,11 @@ struct VersalVirt {
         uint32_t clk_25Mhz;
         uint32_t usb;
         uint32_t dwc;
-        uint32_t canfd[2];
     } phandle;
     struct arm_boot_info binfo;
 
-    CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
+    CanBusState **canbus;
+
     struct {
         bool secure;
     } cfg;
@@ -209,38 +209,6 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     g_free(name);
 }
 
-static void fdt_add_canfd_nodes(VersalVirt *s)
-{
-    uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
-    uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
-    unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
-    const char clocknames[] = "can_clk\0s_axi_aclk";
-    int i;
-
-    /* Create and connect CANFD0 and CANFD1 nodes to canbus0. */
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        char *name = g_strdup_printf("/canfd@%" PRIx64, addrs[i]);
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cell(s->fdt, name, "rx-fifo-depth", 0x40);
-        qemu_fdt_setprop_cell(s->fdt, name, "tx-mailbox-count", 0x20);
-
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addrs[i], 2, size[i]);
-        qemu_fdt_setprop_string(s->fdt, name, "compatible",
-                                "xlnx,canfd-2.0");
-
-        g_free(name);
-    }
-}
-
 static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
                                      uint32_t phandle)
 {
@@ -661,10 +629,14 @@ static void versal_virt_init(MachineState *machine)
                             TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
                              &error_abort);
-    object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
-                             &error_abort);
-    object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
-                             &error_abort);
+
+    for (i = 0; i < versal_get_num_can(VERSAL_VER_VERSAL); i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), prop_name,
+                                 OBJECT(s->canbus[i]),
+                                 &error_abort);
+    }
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
@@ -672,7 +644,6 @@ static void versal_virt_init(MachineState *machine)
     create_virtio_regions(s);
 
     fdt_add_gem_nodes(s);
-    fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
@@ -755,19 +726,22 @@ static void versal_virt_init(MachineState *machine)
 static void versal_virt_machine_instance_init(Object *obj)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+    size_t i, num_can;
+
+    num_can = versal_get_num_can(VERSAL_VER_VERSAL);
+    s->canbus = g_new0(CanBusState *, num_can);
 
     /*
-     * User can set canbus0 and canbus1 properties to can-bus object and connect
-     * to socketcan(optional) interface via command line.
+     * User can set canbusx properties to can-bus object and optionally connect
+     * to socketcan interface via command line.
      */
-    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
-                             (Object **)&s->canbus[0],
-                             object_property_allow_set_link,
-                             0);
-    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
-                             (Object **)&s->canbus[1],
-                             object_property_allow_set_link,
-                             0);
+    for (i = 0; i < num_can; i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
+
+        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
+                                 (Object **) &s->canbus[i],
+                                 object_property_allow_set_link, 0);
+    }
 }
 
 static void versal_virt_machine_finalize(Object *obj)
@@ -775,6 +749,7 @@ static void versal_virt_machine_finalize(Object *obj)
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
 
     g_free(s->ospi_model);
+    g_free(s->canbus);
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index b16af79e8a9..3d2e33d3dac 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -27,6 +27,7 @@
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
+#include "hw/net/xlnx-versal-canfd.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -43,12 +44,19 @@ typedef struct VersalSimplePeriphMap {
 typedef struct VersalMap {
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
+
+    VersalSimplePeriphMap canfd[4];
+    size_t num_canfd;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
+
+    .canfd[0] = { 0xff060000, 20 },
+    .canfd[1] = { 0xff070000, 21 },
+    .num_canfd = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -286,36 +294,42 @@ static void versal_create_uart(Versal *s,
     }
 }
 
-static void versal_create_canfds(Versal *s, qemu_irq *pic)
+static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
+                                CanBusState *bus)
 {
-    int i;
-    uint32_t irqs[] = { VERSAL_CANFD0_IRQ_0, VERSAL_CANFD1_IRQ_0};
-    uint64_t addrs[] = { MM_CANFD0, MM_CANFD1 };
+    SysBusDevice *sbd;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    const char compatible[] = "xlnx,canfd-2.0";
+    const char clocknames[] = "can_clk\0s_axi_aclk";
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.canfd); i++) {
-        char *name = g_strdup_printf("canfd%d", i);
-        SysBusDevice *sbd;
-        MemoryRegion *mr;
+    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XILINX_CANFD));
+    object_property_add_child(OBJECT(s), "canfd[*]", OBJECT(sbd));
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.canfd[i],
-                                TYPE_XILINX_CANFD);
-        sbd = SYS_BUS_DEVICE(&s->lpd.iou.canfd[i]);
+    object_property_set_int(OBJECT(sbd), "ext_clk_freq",
+                            25 * 1000 * 1000 , &error_abort);
 
-        object_property_set_int(OBJECT(&s->lpd.iou.canfd[i]), "ext_clk_freq",
-                                XLNX_VERSAL_CANFD_REF_CLK , &error_abort);
+    object_property_set_link(OBJECT(sbd), "canfdbus", OBJECT(bus),
+                             &error_abort);
 
-        object_property_set_link(OBJECT(&s->lpd.iou.canfd[i]), "canfdbus",
-                                 OBJECT(s->lpd.iou.canbus[i]),
-                                 &error_abort);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-        sysbus_realize(sbd, &error_fatal);
+    mr = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(sbd, 0);
-        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
 
-        sysbus_connect_irq(sbd, 0, pic[irqs[i]]);
-        g_free(name);
-    }
+    node = versal_fdt_add_simple_subnode(s, "/canfd", map->addr, 0x10000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "rx-fifo-depth", 0x40);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "tx-mailbox-count", 0x20);
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
 static void versal_create_usbs(Versal *s, qemu_irq *pic)
@@ -1044,7 +1058,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
         versal_create_uart(s, &map->uart[i], i);
     }
 
-    versal_create_canfds(s, pic);
+    for (i = 0; i < map->num_canfd; i++) {
+        versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
+    }
+
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
@@ -1072,24 +1089,46 @@ static void versal_realize(DeviceState *dev, Error **errp)
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+int versal_get_num_can(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->num_canfd;
+}
+
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
+    size_t i, num_can;
 
     memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
+
+    num_can = versal_get_map(s)->num_canfd;
+    s->cfg.canbus = g_new0(CanBusState *, num_can);
+
+    for (i = 0; i < num_can; i++) {
+        g_autofree char *prop_name = g_strdup_printf("canbus%zu", i);
+
+        object_property_add_link(obj, prop_name, TYPE_CAN_BUS,
+                                 (Object **) &s->cfg.canbus[i],
+                                 object_property_allow_set_link, 0);
+    }
+}
+
+static void versal_base_finalize(Object *obj)
+{
+    Versal *s = XLNX_VERSAL_BASE(obj);
+
+    g_free(s->cfg.canbus);
 }
 
 static const Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
-                      TYPE_CAN_BUS, CanBusState *),
-    DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
-                      TYPE_CAN_BUS, CanBusState *),
 };
 
 static void versal_base_class_init(ObjectClass *klass, const void *data)
@@ -1113,6 +1152,7 @@ static const TypeInfo versal_base_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Versal),
     .instance_init = versal_base_init,
+    .instance_finalize = versal_base_finalize,
     .class_init = versal_base_class_init,
     .class_size = sizeof(VersalClass),
     .abstract = true,
-- 
2.43.0


