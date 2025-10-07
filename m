Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456B0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68QM-0005mv-3n; Tue, 07 Oct 2025 10:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QF-0005kP-BW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Py-0002BJ-0s
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so40947185e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846308; x=1760451108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B/Sr2KZknYT38HhacTrPmpAzdTzo5E39tfibSg4rn3I=;
 b=Ol2wog+jpfQhLVWqdYFzOO2Ny6tWfI+QGTn5vEdAnhii4GOuRInO2mTgtAxESsGMH3
 f9aEPSK3dPRHzzyFVIF8Qq+4DEu0mD19jsmh/+wKMUjxnsExVgaYJ93YVquvV/+nNE8n
 tFfQUEb5vRLnZf/Dp6QBX1B4q8/8txuVB/XY39xyahnDrLIygGdTMeG9ATccVlD70PfE
 FEpZgZHKL9O58To+kPAlI6AUm7z2Hk9JSqj+D3xLwQEwjJyg1FpPk5wbmtu0ZE2DYL2B
 36pL56xOOjPXzlSxs9AhFSs7hePLgA5003vmIaCoyAz9sukxMEUcGh9N4zycXrf1Z4Pn
 uG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846308; x=1760451108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/Sr2KZknYT38HhacTrPmpAzdTzo5E39tfibSg4rn3I=;
 b=CU38mS/vQpap8rhr+H52W51BOGEmGbrHNaQ3c0HUj40NxNXba4ZCEgmF7RFvVwtEyt
 lg5A2zWkm5KSLbclBLHlpqUQ7I1wpX2DdLhNzvtFjuE7B+cteGxmyZHFCunnI34lIwUc
 Nb68oOnloBsjDtlDkutlnUO5oaI6Xo+snmFmJlim6tYwtB2H1lSpqanbM/H8qlYUQBhy
 yMcxz2CsucZSD1+Ql9dhuGozMQIcIC2wxb8+9MF0NFH9Rx2yKOTCrm4XRqtpH03aTGOy
 PRppQN7pC3wmXjFeJURuxPMs/CNq+XL6BB19csbiz5chSunUyHzC0N8ZDC3TnkITYm/J
 w+1w==
X-Gm-Message-State: AOJu0YwsqUTm8y3ZcIRzaftYXyco7YnQ2Wm7mLH63+bs6veXPkyNoJBo
 cMHzp1juF1T4+2XRo35eCR0x7XMrbsJZwigbSxv9q3pHnJn6XppzSJCc+HLZXNHOH5c6edDY/8O
 6LtqA
X-Gm-Gg: ASbGncsCx5Dz+veD4FGmLF93xoUuQn/zc/HbsLxogoLCDbK9WBsTI7vWkErrX4egC/u
 ylv9OYNo5DoEpat4ridqmvxUkr4Dx3nnP0NFKjUcm9jx+0ipsIJh2lkUKzf0t+9WwsdyVIfcKyd
 l/ySQRqwhhl+WJbJ27pPpzfoZWCUZFbMu9FIxWzNB3fIdKohr2XtvML3VGcvLXQHXR0bb2jTXQ5
 iH74mUaYskXQd4xwpwiPkNl1mJFycrD5e124IQg3IwGbYnyX3t6Ph8jUkP4X79ZMrguZWT2v7VS
 KJwRhd8VfFHFtM3p82Ngm7e1o3OnlfRz6pT30c+0tNIA4pury+G5hAXDeanQ97lsnzLIjgLcR5h
 BuninHDt1pVay7zaYOyQYfVTwvvt6N85A2M+TeVMiLGcc/6HauECrFyFu
X-Google-Smtp-Source: AGHT+IF0Ks2hfEhjb4o0SbSRkQoJhaL+MqUFqGFpa1fciOMGX7rKGdKJPFcw4aMtgiaNFEUkyiH9Xg==
X-Received: by 2002:a05:600c:1e20:b0:46e:34f9:993 with SMTP id
 5b1f17b1804b1-46e71109f6dmr97343235e9.13.1759846307891; 
 Tue, 07 Oct 2025 07:11:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/62] hw/arm/xlnx-versal: refactor CPU cluster creation
Date: Tue,  7 Oct 2025 15:10:41 +0100
Message-ID: <20251007141123.3239867-22-peter.maydell@linaro.org>
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

Refactor the CPU cluster creation using the VersalMap structure. There
is no functional change. The clusters properties are now described in
the VersalMap structure. For now only the APU is converted. The RPU will
be taken care of by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-21-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  12 +-
 hw/arm/xlnx-versal-virt.c    |  80 +-------
 hw/arm/xlnx-versal.c         | 354 ++++++++++++++++++++++++++---------
 3 files changed, 276 insertions(+), 170 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index af47acb288f..9d9ccfb0014 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,7 +15,6 @@
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
-#include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
 #include "target/arm/cpu.h"
@@ -43,15 +42,6 @@ struct Versal {
     SysBusDevice parent_obj;
 
     /*< public >*/
-    struct {
-        struct {
-            MemoryRegion mr;
-            CPUClusterState cluster;
-            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
-            GICv3State gic;
-        } apu;
-    } fpd;
-
     MemoryRegion mr_ps;
 
     struct {
@@ -75,6 +65,7 @@ struct Versal {
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
+        uint32_t gic;
     } phandle;
 
     struct {
@@ -96,6 +87,7 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
     s->cfg.fdt = fdt;
 }
 
+DeviceState *versal_get_boot_cpu(Versal *s);
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b981d012558..27594f78c8f 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -38,7 +38,6 @@ struct VersalVirt {
     void *fdt;
     int fdt_size;
     struct {
-        uint32_t gic;
         uint32_t clk_125Mhz;
         uint32_t clk_25Mhz;
     } phandle;
@@ -63,7 +62,6 @@ static void fdt_create(VersalVirt *s)
     }
 
     /* Allocate all phandles.  */
-    s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
     s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
 
@@ -72,9 +70,6 @@ static void fdt_create(VersalVirt *s)
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
-    qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
-    qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
-    qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
     qemu_fdt_setprop_string(s->fdt, "/", "compatible", "xlnx-versal-virt");
 }
@@ -90,67 +85,6 @@ static void fdt_add_clk_node(VersalVirt *s, const char *name,
     qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
 }
 
-static void fdt_add_cpu_nodes(VersalVirt *s, uint32_t psci_conduit)
-{
-    int i;
-
-    qemu_fdt_add_subnode(s->fdt, "/cpus");
-    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#size-cells", 0x0);
-    qemu_fdt_setprop_cell(s->fdt, "/cpus", "#address-cells", 1);
-
-    for (i = XLNX_VERSAL_NR_ACPUS - 1; i >= 0; i--) {
-        char *name = g_strdup_printf("/cpus/cpu@%d", i);
-        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
-
-        qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop_cell(s->fdt, name, "reg",
-                              arm_cpu_mp_affinity(armcpu));
-        if (psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
-            qemu_fdt_setprop_string(s->fdt, name, "enable-method", "psci");
-        }
-        qemu_fdt_setprop_string(s->fdt, name, "device_type", "cpu");
-        qemu_fdt_setprop_string(s->fdt, name, "compatible",
-                                armcpu->dtb_compatible);
-        g_free(name);
-    }
-}
-
-static void fdt_add_gic_nodes(VersalVirt *s)
-{
-    char *nodename;
-
-    nodename = g_strdup_printf("/gic@%x", MM_GIC_APU_DIST_MAIN);
-    qemu_fdt_add_subnode(s->fdt, nodename);
-    qemu_fdt_setprop_cell(s->fdt, nodename, "phandle", s->phandle.gic);
-    qemu_fdt_setprop_cells(s->fdt, nodename, "interrupts",
-                           GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
-                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop(s->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
-                                 2, MM_GIC_APU_DIST_MAIN,
-                                 2, MM_GIC_APU_DIST_MAIN_SIZE,
-                                 2, MM_GIC_APU_REDIST_0,
-                                 2, MM_GIC_APU_REDIST_0_SIZE);
-    qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");
-    g_free(nodename);
-}
-
-static void fdt_add_timer_nodes(VersalVirt *s)
-{
-    const char compat[] = "arm,armv8-timer";
-    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
-
-    qemu_fdt_add_subnode(s->fdt, "/timer");
-    qemu_fdt_setprop_cells(s->fdt, "/timer", "interrupts",
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ, irqflags,
-            GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
-    qemu_fdt_setprop(s->fdt, "/timer", "compatible",
-                     compat, sizeof(compat));
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -396,16 +330,14 @@ static void versal_virt_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
-    fdt_add_gic_nodes(s);
-    fdt_add_timer_nodes(s);
-    fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
-    /* Make the APU cpu address space visible to virtio and other
-     * modules unaware of multiple address-spaces.  */
-    memory_region_add_subregion_overlap(get_system_memory(),
-                                        0, &s->soc.fpd.apu.mr, 0);
+    /*
+     * Map the SoC address space onto system memory. This will allow virtio and
+     * other modules unaware of multiple address-spaces to work.
+     */
+    memory_region_add_subregion(get_system_memory(), 0, &s->soc.mr_ps);
 
     /* Attach bbram backend, if given */
     bbram_attach_drive(s);
@@ -429,7 +361,7 @@ static void versal_virt_init(MachineState *machine)
         s->binfo.loader_start = 0x1000;
         s->binfo.dtb_limit = 0x1000000;
     }
-    arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
+    arm_load_kernel(ARM_CPU(versal_get_boot_cpu(&s->soc)), machine, &s->binfo);
 
     for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
         ObjectClass *flash_klass;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 23aac709dc4..b4cad856dc2 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -43,6 +43,7 @@
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
+#include "hw/intc/arm_gicv3_common.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -67,7 +68,34 @@ typedef struct VersalSimplePeriphMap {
     int irq;
 } VersalSimplePeriphMap;
 
+typedef struct VersalGicMap {
+    int version;
+    uint64_t dist;
+    uint64_t redist;
+    size_t num_irq;
+} VersalGicMap;
+
+enum StartPoweredOffMode {
+    SPO_SECONDARIES,
+    SPO_ALL,
+};
+
+typedef struct VersalCpuClusterMap {
+    VersalGicMap gic;
+
+    const char *name;
+    const char *cpu_model;
+    size_t num_core;
+    size_t num_cluster;
+    uint32_t qemu_cluster_id;
+    bool dtb_expose;
+
+    enum StartPoweredOffMode start_powered_off;
+} VersalCpuClusterMap;
+
 typedef struct VersalMap {
+    VersalCpuClusterMap apu;
+
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
@@ -164,6 +192,22 @@ typedef struct VersalMap {
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
+    .apu = {
+        .name = "apu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
+        .num_cluster = 1,
+        .num_core = 2,
+        .qemu_cluster_id = 0,
+        .start_powered_off = SPO_SECONDARIES,
+        .dtb_expose = true,
+        .gic = {
+            .version = 3,
+            .dist = 0xf9000000,
+            .redist = 0xf9080000,
+            .num_irq = 192,
+        },
+    },
+
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
@@ -294,11 +338,12 @@ static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     qemu_irq irq;
     bool ored;
+    DeviceState *gic;
 
     ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
 
-    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic),
-                           FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
+    irq = qdev_get_gpio_in(gic, FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
 
     if (ored) {
         irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
@@ -375,107 +420,239 @@ static inline DeviceState *create_or_gate(Versal *s, Object *parent,
     return or;
 }
 
-static void versal_create_apu_cpus(Versal *s)
+static MemoryRegion *create_cpu_mr(Versal *s, DeviceState *cluster,
+                                   const VersalCpuClusterMap *map)
 {
-    int i;
+    MemoryRegion *mr, *root_alias;
+    char *name;
 
-    object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
-                            TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->fpd.apu.cluster), "cluster-id", 0);
+    mr = g_new(MemoryRegion, 1);
+    name = g_strdup_printf("%s-mr", map->name);
+    memory_region_init(mr, OBJECT(cluster), name, UINT64_MAX);
+    g_free(name);
 
-    for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
-        Object *obj;
+    root_alias = g_new(MemoryRegion, 1);
+    name = g_strdup_printf("ps-alias-for-%s", map->name);
+    memory_region_init_alias(root_alias, OBJECT(cluster), name,
+                             &s->mr_ps, 0, UINT64_MAX);
+    g_free(name);
+    memory_region_add_subregion(mr, 0, root_alias);
 
-        object_initialize_child(OBJECT(&s->fpd.apu.cluster),
-                                "apu-cpu[*]", &s->fpd.apu.cpu[i],
-                                XLNX_VERSAL_ACPU_TYPE);
-        obj = OBJECT(&s->fpd.apu.cpu[i]);
-        if (i) {
-            /* Secondary CPUs start in powered-down state */
-            object_property_set_bool(obj, "start-powered-off", true,
-                                     &error_abort);
-        }
-
-        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->fpd.apu.cpu),
-                                &error_abort);
-        object_property_set_link(obj, "memory", OBJECT(&s->fpd.apu.mr),
-                                 &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    }
-
-    qdev_realize(DEVICE(&s->fpd.apu.cluster), NULL, &error_fatal);
+    return mr;
 }
 
-static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_gic(Versal *s,
+                                      const VersalCpuClusterMap *map,
+                                      MemoryRegion *mr,
+                                      size_t num_cpu)
 {
-    static const uint64_t addrs[] = {
-        MM_GIC_APU_DIST_MAIN,
-        MM_GIC_APU_REDIST_0
-    };
-    SysBusDevice *gicbusdev;
-    DeviceState *gicdev;
+    DeviceState *dev;
+    SysBusDevice *sbd;
     QList *redist_region_count;
-    int nr_apu_cpus = ARRAY_SIZE(s->fpd.apu.cpu);
-    int i;
+    g_autofree char *node = NULL;
+    g_autofree char *name = NULL;
+    const char compatible[] = "arm,gic-v3";
 
-    object_initialize_child(OBJECT(s), "apu-gic", &s->fpd.apu.gic,
-                            gicv3_class_name());
-    gicbusdev = SYS_BUS_DEVICE(&s->fpd.apu.gic);
-    gicdev = DEVICE(&s->fpd.apu.gic);
-    qdev_prop_set_uint32(gicdev, "revision", 3);
-    qdev_prop_set_uint32(gicdev, "num-cpu", nr_apu_cpus);
-    qdev_prop_set_uint32(gicdev, "num-irq", XLNX_VERSAL_NR_IRQS + 32);
+    dev = qdev_new(gicv3_class_name());
+    name = g_strdup_printf("%s-gic[*]", map->name);
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+    sbd = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_uint32(dev, "revision", 3);
+    qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
+    qdev_prop_set_uint32(dev, "num-irq", map->gic.num_irq + 32);
 
     redist_region_count = qlist_new();
-    qlist_append_int(redist_region_count, nr_apu_cpus);
-    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+    qlist_append_int(redist_region_count, num_cpu);
+    qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
 
-    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+    qdev_prop_set_bit(dev, "has-security-extensions", true);
+    object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->fpd.apu.gic), &error_fatal);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
-        MemoryRegion *mr;
+    memory_region_add_subregion(mr, map->gic.dist,
+                                sysbus_mmio_get_region(sbd, 0));
+    memory_region_add_subregion(mr, map->gic.redist,
+                                sysbus_mmio_get_region(sbd, 1));
 
-        mr = sysbus_mmio_get_region(gicbusdev, i);
-        memory_region_add_subregion(&s->fpd.apu.mr, addrs[i], mr);
+    if (map->dtb_expose) {
+        node = versal_fdt_add_subnode(s, "/gic", map->gic.dist, compatible,
+                                      sizeof(compatible));
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
+        qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
+                                     2, map->gic.dist,
+                                     2, 0x10000,
+                                     2, map->gic.redist,
+                                     2, GICV3_REDIST_SIZE * num_cpu);
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
-    for (i = 0; i < nr_apu_cpus; i++) {
-        DeviceState *cpudev = DEVICE(&s->fpd.apu.cpu[i]);
-        int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
-        qemu_irq maint_irq;
-        int ti;
-        /* Mapping from the output timer irq lines from the CPU to the
-         * GIC PPI inputs.
-         */
-        const int timer_irq[] = {
-            [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
-            [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
-            [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
-            [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
-        };
+    return dev;
+}
 
+static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
+                               DeviceState *gic, DeviceState *cpu, size_t idx,
+                               size_t num_cpu)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(gic);
+    int ppibase = map->gic.num_irq + idx * GIC_INTERNAL + GIC_NR_SGIS;
+    int ti;
+    bool has_gtimer;
+    /*
+     * Mapping from the output timer irq lines from the CPU to the
+     * GIC PPI inputs.
+     */
+    const int timer_irq[] = {
+        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
+        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
+        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
+        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
+    };
+
+    has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
+
+    if (has_gtimer) {
         for (ti = 0; ti < ARRAY_SIZE(timer_irq); ti++) {
-            qdev_connect_gpio_out(cpudev, ti,
-                                  qdev_get_gpio_in(gicdev,
+            qdev_connect_gpio_out(cpu, ti,
+                                  qdev_get_gpio_in(gic,
                                                    ppibase + timer_irq[ti]));
         }
-        maint_irq = qdev_get_gpio_in(gicdev,
-                                        ppibase + VERSAL_GIC_MAINT_IRQ);
-        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
-                                    0, maint_irq);
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * nr_apu_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
-    for (i = 0; i < XLNX_VERSAL_NR_IRQS; i++) {
-        pic[i] = qdev_get_gpio_in(gicdev, i);
+    if (map->gic.version == 3) {
+        qemu_irq maint_irq;
+
+        maint_irq = qdev_get_gpio_in(gic,
+                                     ppibase + VERSAL_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
+                                    0, maint_irq);
+    }
+
+    sysbus_connect_irq(sbd, idx, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
+    sysbus_connect_irq(sbd, idx + num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_FIQ));
+    sysbus_connect_irq(sbd, idx + 2 * num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_VIRQ));
+    sysbus_connect_irq(sbd, idx + 3 * num_cpu,
+                       qdev_get_gpio_in(cpu, ARM_CPU_VFIQ));
+}
+
+static inline void versal_create_and_connect_gic(Versal *s,
+                                                 const VersalCpuClusterMap *map,
+                                                 MemoryRegion *mr,
+                                                 DeviceState **cpus,
+                                                 size_t num_cpu)
+{
+    DeviceState *gic;
+    size_t i;
+
+    gic = versal_create_gic(s, map, mr, num_cpu);
+
+    for (i = 0; i < num_cpu; i++) {
+        connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
+    }
+}
+
+static DeviceState *versal_create_cpu(Versal *s,
+                                      const VersalCpuClusterMap *map,
+                                      DeviceState *qemu_cluster,
+                                      MemoryRegion *cpu_mr,
+                                      size_t cluster_idx,
+                                      size_t core_idx)
+{
+    DeviceState *cpu = qdev_new(map->cpu_model);
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    Object *obj = OBJECT(cpu);
+    bool start_off;
+    size_t idx = cluster_idx * map->num_core + core_idx;
+    g_autofree char *name;
+    g_autofree char *node = NULL;
+
+    start_off = map->start_powered_off == SPO_ALL
+        || ((map->start_powered_off == SPO_SECONDARIES)
+            && (cluster_idx || core_idx));
+
+    name = g_strdup_printf("%s[*]", map->name);
+    object_property_add_child(OBJECT(qemu_cluster), name, obj);
+    object_property_set_bool(obj, "start-powered-off", start_off,
+                             &error_abort);
+    qdev_prop_set_int32(cpu, "core-count",  map->num_core);
+    object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
+    qdev_realize_and_unref(cpu, NULL, &error_fatal);
+
+    if (!map->dtb_expose) {
+        return cpu;
+    }
+
+    node = versal_fdt_add_subnode(s, "/cpus/cpu", idx,
+                                  arm_cpu->dtb_compatible,
+                                  strlen(arm_cpu->dtb_compatible) + 1);
+    qemu_fdt_setprop_cell(s->cfg.fdt, node, "reg",
+                          arm_cpu_mp_affinity(arm_cpu) & ARM64_AFFINITY_MASK);
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "device_type", "cpu");
+    qemu_fdt_setprop_string(s->cfg.fdt, node, "enable-method", "psci");
+
+    return cpu;
+}
+
+static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
+{
+    size_t i, j;
+    DeviceState *cluster;
+    MemoryRegion *mr;
+    char *name;
+    g_autofree DeviceState **cpus;
+    const char compatible[] = "arm,armv8-timer";
+    bool has_gtimer;
+
+    cluster = qdev_new(TYPE_CPU_CLUSTER);
+    name = g_strdup_printf("%s-cluster", map->name);
+    object_property_add_child(OBJECT(s), name, OBJECT(cluster));
+    g_free(name);
+    qdev_prop_set_uint32(cluster, "cluster-id", map->qemu_cluster_id);
+
+    mr = create_cpu_mr(s, cluster, map);
+
+    cpus = g_new(DeviceState *, map->num_cluster * map->num_core);
+
+    if (map->dtb_expose) {
+        qemu_fdt_add_subnode(s->cfg.fdt, "/cpus");
+        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#size-cells", 0);
+        qemu_fdt_setprop_cell(s->cfg.fdt, "/cpus", "#address-cells", 1);
+    }
+
+    for (i = 0; i < map->num_cluster; i++) {
+        for (j = 0; j < map->num_core; j++) {
+            DeviceState *cpu = versal_create_cpu(s, map, cluster, mr, i, j);
+
+            cpus[i * map->num_core + j] = cpu;
+        }
+
+    }
+
+    qdev_realize_and_unref(cluster, NULL, &error_fatal);
+
+    versal_create_and_connect_gic(s, map, mr, cpus,
+                                  map->num_cluster * map->num_core);
+
+    has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
+    if (map->dtb_expose && has_gtimer) {
+        qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
+        qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
+                         compatible, sizeof(compatible));
     }
 }
 
@@ -1286,7 +1463,6 @@ static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
-    qemu_irq pic[XLNX_VERSAL_NR_IRQS];
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
@@ -1295,14 +1471,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
-
-    versal_create_apu_cpus(s);
-    versal_create_apu_gic(s, pic);
+    s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
 
     container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(s), "irq-or-gates", container);
     object_unref(container);
 
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
+
+    versal_create_cpu_cluster(s, &map->apu);
     versal_create_rpu_cpus(s);
 
     for (i = 0; i < map->num_uart; i++) {
@@ -1359,11 +1538,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
                            MM_OCM_SIZE, &error_fatal);
 
     memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
-    memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+DeviceState *versal_get_boot_cpu(Versal *s)
+{
+    return DEVICE(versal_get_child_idx(s, "apu-cluster/apu", 0));
+}
+
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
 {
     DeviceState *sdhci, *card;
@@ -1467,7 +1650,6 @@ static void versal_base_init(Object *obj)
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-    memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
     memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
-- 
2.43.0


