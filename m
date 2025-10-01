Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A220CAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFO-0005K0-Gx; Tue, 30 Sep 2025 21:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lF5-0005GY-WA
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEk-000816-F5
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so41961845e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280546; x=1759885346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZitGaR6XZBmHkaFZhRFFCJMj6aa5mwQJceoZZyLOic=;
 b=PC8NP68KG9vJty2MItZPbsS2yTf3JUZafxUOOTa35w9965HnUyrMjlcvha9jp9TEfZ
 pweJCkR0m7RfgV4z+8O4XE3I79tGzYr/Mam+P39caT7El3cIhD08X+penlWhXsDlInQe
 Lgnoyyv7SlcFV9p7KCJaZW45+RJZ9kDAwtCRDhQZrxhjDqU+PPe/zNGQCUjnPaPape40
 fE8WUycpFUFHftB2ZiYooK+S0x84gLAOA/MLCj8CQc7j3TaBfhNmmScD090paSWQ8dYi
 G9TRjqMhgl8Jla4hMn1aZFFyXsFCXe7PCFS9yEiTThiPq8owlIbFf4YKtVXwocM3i3cM
 lIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280546; x=1759885346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZitGaR6XZBmHkaFZhRFFCJMj6aa5mwQJceoZZyLOic=;
 b=Lx3zPZ68uf6+yfiy2O062LHjy/tZf69LhOBinq8ewjH6IQwD9gefOOu8UiqR1cw2um
 J455BbWzAMWT1fdxVs1ukdOy5pB/RefVfLMEa+INJ0mnhZQDUc7EldIjT8Yj7CX6RFDT
 +KIlowt3JEac++Ga446oeQC4s/vzdPG8yiiL3xJ4MVRm6OdRCbo+2OjG2HZrvNZ8hM/t
 yoXw/k3MFjdazBVNOZS1AxrHq0ZCg9xFMtSP5RL+Oy1ib7BJbK36A0NzbFFGDCEQI5QL
 9pOVWxOnRsX+xN4SUwYe4ZytJPZaY0uxNWoQhzqLyBLYDPYfFdstmBJj4bukUdW9KGRM
 0d0Q==
X-Gm-Message-State: AOJu0YwpsnMT5gJgfgwiaDZqE6oI6BjEuiv6RCMgA1xezEDk4cJy1U5a
 zkFqsWdUZ60UpXlYriG00MUS7KT+VL6pXArniGdhJwtlKfUPwO2+vk3jneteYokG4JhmJEG2Bk2
 VuipMHmIjaw==
X-Gm-Gg: ASbGnctb7q5GlpIdMyMSu94GEiVxDjazh9Ca1uEob3JRIcjfDVD5O/Tmo8cRa0Onbsn
 kZfBtBvpXbEX4lWZhguZA1qSdUlzOGVYVINwgP8Nb3gKF1q5vTBJM8CXga0HAbK5x1AfG3nqfBu
 T/+g5n/TW5DGRMc9vKTa+w0FEl9rlEI9r0cKD5L4a37OpuxUEzEkA2QIvZiXiCviHiFpv9OIS43
 n+Nn9kCoBGP/p3euspzgaW/dIUawCyqcsZ4lABKAiup7/8y2knpaIWpWjbgOBxI6yUlxbHyLqtu
 szNgCN1gEmpkl5lAIwlKN0rcuzpMzbc5P5CwunfYSw76oHgHHTzArHXLM6p+L/3BvekVIRZSdM4
 IGcDPoCS3KPMzf2p0HWJXiLSa+N6MWZvboTr9+7wPIZUWzQ0MFfb4CFVMmD6uMMtdMc1Oz9XjHo
 Lcsz56pYjXzOzk4c9jw0rKD8kPi+NDUEBzQtA6HHojZFk=
X-Google-Smtp-Source: AGHT+IGpdCaaDWJ2sGIDNgXnBYcsveSYLrNYveQujxSN3gIHiFHHDYnoSvo7DUOClcK2bBipzwxpew==
X-Received: by 2002:a05:6000:2388:b0:3ea:bccc:2a2c with SMTP id
 ffacd0b85a97d-425577ed5d2mr1212744f8f.11.1759280546301; 
 Tue, 30 Sep 2025 18:02:26 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:25 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 06/24] arm/virt,
 gicv3: Pre-size GIC with possible vCPUs at machine init
Date: Wed,  1 Oct 2025 01:01:09 +0000
Message-Id: <20251001010127.3092631-7-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x32d.google.com
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

From: Salil Mehta <salil.mehta@huawei.com>

Pre-size the GIC with the maximum possible vCPUs during machine initialization
instead of the currently enabled CPU count. This ensures that the GIC is fully
provisioned for any vCPUs that may be enabled later by administrative or
hot-add–like operations.

Pre-sizing must also include redistributors for administratively disabled vCPUs,
ensuring the GIC is fully provisioned at initialization for all possible CPUs.
This is required because:

1. Memory regions and resources associated with GICC/GICR cannot be modified
   (added, deleted, or resized) after VM initialization.
2. The GICD_TYPER and related redistributor structures must be initialized with
   correct mp_affinity and CPU interface numbering at creation time, and cannot
   be altered later.
3. Avoids the need to dynamically resize GIC CPU interfaces, which is unsupported
   and would break architectural guarantees.

This patch:
 - Replaces use of `ms->smp.cpus` with `ms->smp.max_cpus` for GIC sizing,
   redistributor allocation, and interrupt wiring.
 - Updates GICv3 realization to fetch CPU references via
   `machine_get_possible_cpu()` instead of `qemu_get_cpu()`, ensuring that CPUs
   not yet realized but part of the possible set are accounted for.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c              | 24 ++++++++++++------------
 hw/core/machine.c          | 14 ++++++++++++++
 hw/intc/arm_gicv3_common.c |  4 ++--
 include/hw/arm/virt.h      |  2 +-
 include/hw/boards.h        | 12 ++++++++++++
 5 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f4eeeacf6c..ee09aa19bd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -793,7 +793,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     SysBusDevice *gicbusdev;
     const char *gictype;
     int i;
-    unsigned int smp_cpus = ms->smp.cpus;
+    unsigned int max_cpus = ms->smp.max_cpus;
     uint32_t nb_redist_regions = 0;
     int revision;
 
@@ -825,7 +825,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     vms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(vms->gic, "revision", revision);
-    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(vms->gic, "num-cpu", max_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
@@ -837,7 +837,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     if (vms->gic_version != VIRT_GIC_VERSION_2) {
         QList *redist_region_count;
         uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
-        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+        uint32_t redist0_count = MIN(max_cpus, redist0_capacity);
 
         nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
@@ -848,7 +848,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                 virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
 
             qlist_append_int(redist_region_count,
-                MIN(smp_cpus - redist0_count, redist1_capacity));
+                MIN(max_cpus - redist0_count, redist1_capacity));
         }
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
@@ -896,8 +896,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
      * CPU's inputs.
      */
-    for (i = 0; i < smp_cpus; i++) {
-        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+    for (i = 0; i < max_cpus; i++) {
+        DeviceState *cpudev = DEVICE(machine_get_possible_cpu(i));
         int intidbase = NUM_IRQS + i * GIC_INTERNAL;
         /* Mapping from the output timer irq lines from the CPU to the
          * GIC PPI inputs we use for the virt board.
@@ -926,7 +926,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         } else if (vms->virt) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
                                             intidbase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+            sysbus_connect_irq(gicbusdev, i + 4 * max_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
@@ -934,17 +934,17 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + 2 * max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + 3 * max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
 
         if (vms->gic_version != VIRT_GIC_VERSION_2) {
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
+            sysbus_connect_irq(gicbusdev, i + 4 * max_cpus,
                                qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
-            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
+            sysbus_connect_irq(gicbusdev, i + 5 * max_cpus,
                                qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
         }
     }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bd47527479..69d5632464 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1369,6 +1369,20 @@ bool machine_require_guest_memfd(MachineState *machine)
     return machine->cgs && machine->cgs->require_guest_memfd;
 }
 
+CPUState *machine_get_possible_cpu(int64_t cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    for (int i = 0; i < possible_cpus->len; i++) {
+        if (possible_cpus->cpus[i].cpu &&
+            possible_cpus->cpus[i].cpu->cpu_index == cpu_index) {
+            return possible_cpus->cpus[i].cpu;
+        }
+    }
+    return NULL;
+}
+
 static char *cpu_slot_to_string(const CPUArchId *cpu)
 {
     GString *s = g_string_new(NULL);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e438d8c042..f6a9f1c68b 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -32,7 +32,7 @@
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
-
+#include "hw/boards.h"
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
 {
@@ -436,7 +436,7 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = machine_get_possible_cpu(i);
         uint64_t cpu_affid;
 
         s->cpu[i].cpu = cpu;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 683e4b965a..ace4154cc6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -209,7 +209,7 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 
     assert(vms->gic_version != VIRT_GIC_VERSION_2);
 
-    return (MACHINE(vms)->smp.cpus > redist0_capacity &&
+    return (MACHINE(vms)->smp.max_cpus > redist0_capacity &&
             vms->highmem_redists) ? 2 : 1;
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index b27c2326a2..3ff77a8b3a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -118,6 +118,18 @@ bool device_is_dynamic_sysbus(MachineClass *mc, DeviceState *dev);
 MemoryRegion *machine_consume_memdev(MachineState *machine,
                                      HostMemoryBackend *backend);
 
+/**
+ * machine_get_possible_cpu: Gets 'CPUState' for the CPU with the given logical
+ * cpu_index. The slot index in possible_cpus[] list is always sequential, but
+ * 'cpu_index' values may not be sequential depending on machine implementation
+ * (e.g. with hotplug/unplug). Therefore, this function must scan the list to
+ * find a match.
+ * @cpu_index: logical cpu index to search for 'CPUState'
+ *
+ * Returns: pointer to CPUState, or NULL if not found.
+ */
+CPUState *machine_get_possible_cpu(int64_t cpu_index);
+
 /**
  * CPUArchId:
  * @arch_id - architecture-dependent CPU ID of present or possible CPU
-- 
2.34.1


