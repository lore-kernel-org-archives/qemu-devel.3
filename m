Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE93C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raffD-0001i5-Fj; Thu, 15 Feb 2024 12:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeU-00085f-4H
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:02 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeM-00041p-HO
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:01 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412255afa19so4287725e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018553; x=1708623353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IWaKHIaLp+s7Xdot9kUgCnTLEvnOBydKdl3qOUH4l2g=;
 b=SlvW+mNOmkY5E/h5B5i+nHV8lDKOTUMonsF3IQXlodA+tmdIh6O0tggOH0RAy9VvGb
 597d1XiQpKTMzQxc1wt7tIE6uB6paCDy5O+rhO8fJCVvS5/9RZeSZ+Syl0Z1SGM5OO7I
 9eGBRZ4zmcB7uD/hgo13PSZXxERbeBfQa2hW+zyaHllGUm8y4BZVsnI2OJA56rWhAr83
 ScwhW/lZhTPcLNjQ8nAQUJjRUrFVLJk/mc6qJ5iXmbbVcr8wA5C8eK/JGuVQHVUMw7JN
 8p5m/KwFE0G5hmROQoGj5/WllgvBe5SrvSqOsNcIlBKgRaJ8P+6COBSnlZ7OlGmsBLvo
 f3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018553; x=1708623353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWaKHIaLp+s7Xdot9kUgCnTLEvnOBydKdl3qOUH4l2g=;
 b=LTFltnY3Is9T/Gz7/tW3TQXjH+5bakAo88tFvq2eiR7V5nSnnL/pXfgRYGOCD3Dz4l
 8BFD/4JLlxMbWUjKu94IpYrcSO/WfCqs5p+OA+OpolxBiNObvAvJzIWwtNd+Q8GUc3Bv
 88nw1GTaY4o3boBKTtHczU0g+TGjE2wzjVvxmb5Zb1QXsCQsoBq/iPB38pVw0dcMv9wj
 Cb3kbfd9174lplkkmJClTNXGgpmf5w568sStOFlNFvntItvgZmmSW5d6FqYTZpNR73B/
 EjSvA2N/FdXaZXYcdyYxpxOppsQnTJRT0RWqxTVMhth4A9U2JLk8bUwMS/M9rcAZqBak
 p5Uw==
X-Gm-Message-State: AOJu0Yxq89HGFbAdQjS6JfYjj0hh2iCH45D9JSVYLj0nHiUFQVLgzv77
 R/P+XTL8uasFT92wmS8aQU2OB86oIWxdogumEQTzSa/LboV3I1vy9Bc92xpsPTFvkzxrqrzYXVH
 A
X-Google-Smtp-Source: AGHT+IHYSr2RJExDOwcVzr28/93OAUtEpjgpeJ+uzU8dJIULnjDZUWsbwQkFeubdZwq9f6y6xmam6g==
X-Received: by 2002:a05:6000:1ce:b0:33c:e1d4:8aec with SMTP id
 t14-20020a05600001ce00b0033ce1d48aecmr1987772wrx.50.1708018553042; 
 Thu, 15 Feb 2024 09:35:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/35] hw/arm/mps3r: Add CPUs, GIC, and per-CPU RAM
Date: Thu, 15 Feb 2024 17:35:34 +0000
Message-Id: <20240215173538.2430599-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Create the CPUs, the GIC, and the per-CPU RAM block for
the mps3-an536 board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240206132931.38376-10-peter.maydell@linaro.org
---
 hw/arm/mps3r.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 888a846d23c..6473f62d677 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -27,10 +27,14 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
+#include "hw/intc/arm_gicv3.h"
 
 /* Define the layout of RAM and ROM in a board */
 typedef struct RAMInfo {
@@ -60,6 +64,10 @@ typedef struct RAMInfo {
 #define IS_ROM 2
 
 #define MPS3R_RAM_MAX 9
+#define MPS3R_CPU_MAX 2
+
+#define PERIPHBASE 0xf0000000
+#define NUM_SPIS 96
 
 typedef enum MPS3RFPGAType {
     FPGA_AN536,
@@ -69,11 +77,18 @@ struct MPS3RMachineClass {
     MachineClass parent;
     MPS3RFPGAType fpga_type;
     const RAMInfo *raminfo;
+    hwaddr loader_start;
 };
 
 struct MPS3RMachineState {
     MachineState parent;
+    struct arm_boot_info bootinfo;
     MemoryRegion ram[MPS3R_RAM_MAX];
+    Object *cpu[MPS3R_CPU_MAX];
+    MemoryRegion cpu_sysmem[MPS3R_CPU_MAX];
+    MemoryRegion sysmem_alias[MPS3R_CPU_MAX];
+    MemoryRegion cpu_ram[MPS3R_CPU_MAX];
+    GICv3State gic;
 };
 
 #define TYPE_MPS3R_MACHINE "mps3r"
@@ -163,6 +178,107 @@ static MemoryRegion *mr_for_raminfo(MPS3RMachineState *mms,
     return ram;
 }
 
+/*
+ * There is no defined secondary boot protocol for Linux for the AN536,
+ * because real hardware has a restriction that atomic operations between
+ * the two CPUs do not function correctly, and so true SMP is not
+ * possible. Therefore for cases where the user is directly booting
+ * a kernel, we treat the system as essentially uniprocessor, and
+ * put the secondary CPU into power-off state (as if the user on the
+ * real hardware had configured the secondary to be halted via the
+ * SCC config registers).
+ *
+ * Note that the default secondary boot code would not work here anyway
+ * as it assumes a GICv2, and we have a GICv3.
+ */
+static void mps3r_write_secondary_boot(ARMCPU *cpu,
+                                       const struct arm_boot_info *info)
+{
+    /*
+     * Power the secondary CPU off. This means we don't need to write any
+     * boot code into guest memory. Note that the 'cpu' argument to this
+     * function is the primary CPU we passed to arm_load_kernel(), not
+     * the secondary. Loop around all the other CPUs, as the boot.c
+     * code does for the "disable secondaries if PSCI is enabled" case.
+     */
+    for (CPUState *cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
+        if (cs != first_cpu) {
+            object_property_set_bool(OBJECT(cs), "start-powered-off", true,
+                                     &error_abort);
+        }
+    }
+}
+
+static void mps3r_secondary_cpu_reset(ARMCPU *cpu,
+                                      const struct arm_boot_info *info)
+{
+    /* We don't need to do anything here because the CPU will be off */
+}
+
+static void create_gic(MPS3RMachineState *mms, MemoryRegion *sysmem)
+{
+    MachineState *machine = MACHINE(mms);
+    DeviceState *gicdev;
+    QList *redist_region_count;
+
+    object_initialize_child(OBJECT(mms), "gic", &mms->gic, TYPE_ARM_GICV3);
+    gicdev = DEVICE(&mms->gic);
+    qdev_prop_set_uint32(gicdev, "num-cpu", machine->smp.cpus);
+    qdev_prop_set_uint32(gicdev, "num-irq", NUM_SPIS + GIC_INTERNAL);
+    redist_region_count = qlist_new();
+    qlist_append_int(redist_region_count, machine->smp.cpus);
+    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+    object_property_set_link(OBJECT(&mms->gic), "sysmem",
+                             OBJECT(sysmem), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->gic), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->gic), 0, PERIPHBASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->gic), 1, PERIPHBASE + 0x100000);
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     */
+    for (int i = 0; i < machine->smp.cpus; i++) {
+        DeviceState *cpudev = DEVICE(mms->cpu[i]);
+        SysBusDevice *gicsbd = SYS_BUS_DEVICE(&mms->gic);
+        int intidbase = NUM_SPIS + i * GIC_INTERNAL;
+        int irq;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs used for this board. This isn't a BSA board,
+         * but it uses the standard convention for the PPI numbers.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+        };
+
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(gicdev,
+                                                   intidbase + timer_irq[irq]));
+        }
+
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev,
+                                                     intidbase + ARCH_GIC_MAINT_IRQ));
+
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev,
+                                                     intidbase + VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicsbd, i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicsbd, i + machine->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicsbd, i + 2 * machine->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicsbd, i + 3 * machine->smp.cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+}
+
 static void mps3r_common_init(MachineState *machine)
 {
     MPS3RMachineState *mms = MPS3R_MACHINE(machine);
@@ -173,6 +289,50 @@ static void mps3r_common_init(MachineState *machine)
         MemoryRegion *mr = mr_for_raminfo(mms, ri);
         memory_region_add_subregion(sysmem, ri->base, mr);
     }
+
+    assert(machine->smp.cpus <= MPS3R_CPU_MAX);
+    for (int i = 0; i < machine->smp.cpus; i++) {
+        g_autofree char *sysmem_name = g_strdup_printf("cpu-%d-memory", i);
+        g_autofree char *ramname = g_strdup_printf("cpu-%d-memory", i);
+        g_autofree char *alias_name = g_strdup_printf("sysmem-alias-%d", i);
+
+        /*
+         * Each CPU has some private RAM/peripherals, so create the container
+         * which will house those, with the whole-machine system memory being
+         * used where there's no CPU-specific device. Note that we need the
+         * sysmem_alias aliases because we can't put one MR (the original
+         * 'sysmem') into more than one other MR.
+         */
+        memory_region_init(&mms->cpu_sysmem[i], OBJECT(machine),
+                           sysmem_name, UINT64_MAX);
+        memory_region_init_alias(&mms->sysmem_alias[i], OBJECT(machine),
+                                 alias_name, sysmem, 0, UINT64_MAX);
+        memory_region_add_subregion_overlap(&mms->cpu_sysmem[i], 0,
+                                            &mms->sysmem_alias[i], -1);
+
+        mms->cpu[i] = object_new(machine->cpu_type);
+        object_property_set_link(mms->cpu[i], "memory",
+                                 OBJECT(&mms->cpu_sysmem[i]), &error_abort);
+        object_property_set_int(mms->cpu[i], "reset-cbar",
+                                PERIPHBASE, &error_abort);
+        qdev_realize(DEVICE(mms->cpu[i]), NULL, &error_fatal);
+        object_unref(mms->cpu[i]);
+
+        /* Per-CPU RAM */
+        memory_region_init_ram(&mms->cpu_ram[i], NULL, ramname,
+                               0x1000, &error_fatal);
+        memory_region_add_subregion(&mms->cpu_sysmem[i], 0xe7c01000,
+                                    &mms->cpu_ram[i]);
+    }
+
+    create_gic(mms, sysmem);
+
+    mms->bootinfo.ram_size = machine->ram_size;
+    mms->bootinfo.board_id = -1;
+    mms->bootinfo.loader_start = mmc->loader_start;
+    mms->bootinfo.write_secondary_boot = mps3r_write_secondary_boot;
+    mms->bootinfo.secondary_cpu_reset_hook = mps3r_secondary_cpu_reset;
+    arm_load_kernel(ARM_CPU(mms->cpu[0]), machine, &mms->bootinfo);
 }
 
 static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
@@ -189,6 +349,7 @@ static void mps3r_set_default_ram_info(MPS3RMachineClass *mmc)
             /* Found the entry for "system memory" */
             mc->default_ram_size = p->size;
             mc->default_ram_id = p->name;
+            mmc->loader_start = p->base;
             return;
         }
     }
@@ -212,9 +373,22 @@ static void mps3r_an536_class_init(ObjectClass *oc, void *data)
     };
 
     mc->desc = "ARM MPS3 with AN536 FPGA image for Cortex-R52";
-    mc->default_cpus = 2;
-    mc->min_cpus = mc->default_cpus;
-    mc->max_cpus = mc->default_cpus;
+    /*
+     * In the real FPGA image there are always two cores, but the standard
+     * initial setting for the SCC SYSCON 0x000 register is 0x21, meaning
+     * that the second core is held in reset and halted. Many images built for
+     * the board do not expect the second core to run at startup (especially
+     * since on the real FPGA image it is not possible to use LDREX/STREX
+     * in RAM between the two cores, so a true SMP setup isn't supported).
+     *
+     * As QEMU's equivalent of this, we support both -smp 1 and -smp 2,
+     * with the default being -smp 1. This seems a more intuitive UI for
+     * QEMU users than, for instance, having a machine property to allow
+     * the user to set the initial value of the SYSCON 0x000 register.
+     */
+    mc->default_cpus = 1;
+    mc->min_cpus = 1;
+    mc->max_cpus = 2;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-r52");
     mc->valid_cpu_types = valid_cpu_types;
     mmc->raminfo = an536_raminfo;
-- 
2.34.1


