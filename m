Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D63CF043B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNLi-0000Kd-2L; Tue, 08 Oct 2024 23:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNLg-0000Ii-9E; Tue, 08 Oct 2024 23:26:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNLe-000503-2m; Tue, 08 Oct 2024 23:26:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdbC4TZFz6K97l;
 Wed,  9 Oct 2024 11:26:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 451F4140114;
 Wed,  9 Oct 2024 11:26:48 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:26:29 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V4 22/33] hw/arm,
 gicv3: Changes to notify GICv3 CPU state with vCPU hot-(un)plug event
Date: Wed, 9 Oct 2024 04:18:04 +0100
Message-ID: <20241009031815.250096-23-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Virtual CPU hot-(un)plug events must be communicated to the GIC. Introduce a
notification mechanism to ensure these events are properly relayed to the GIC,
allowing it to update the accessibility of the GIC CPU interface and adjust the
vCPU-to-GIC CPU interface association accordingly.

This approach deviates from the standard ARM CPU architecture specification,
where the CPU-to-GIC interface is typically fixed and the accessibility of the
GIC CPU interface cannot be disabled. However, this workaround is necessary
to address limitations imposed by the ARM CPU architecture [1][2].

For more details regarding these constraints and the workarounds, please refer
to the slides below:

References:
[1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
    architectures that don’t Support CPU Hotplug (like ARM64)
    Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
    (Slides 13,17,18)
[2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
    SoC Based Systems (like ARM64)
    Link: https://kvmforum2020.sched.com/event/eE4m

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c                      | 31 ++++++++++++++-
 hw/intc/arm_gicv3_common.c         | 60 +++++++++++++++++++++++++++++-
 include/hw/arm/virt.h              |  1 +
 include/hw/intc/arm_gicv3_common.h | 23 ++++++++++++
 4 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dad5f7d40f..9634011ae7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -702,6 +702,16 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     return dev;
 }
 
+static void virt_add_gic_cpuhp_notifier(VirtMachineState *vms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(vms);
+
+    if (mc->has_hotpluggable_cpus) {
+        Notifier *cpuhp_notifier = gicv3_cpuhp_notifier(vms->gic);
+        notifier_list_add(&vms->cpuhp_notifiers, cpuhp_notifier);
+    }
+}
+
 static void create_its(VirtMachineState *vms)
 {
     const char *itsclass = its_class_name();
@@ -977,6 +987,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
         create_v2m(vms);
     }
+
+    /* add GIC CPU hot(un)plug update notifier */
+    virt_add_gic_cpuhp_notifier(vms);
 }
 
 static void create_uart(const VirtMachineState *vms, int uart,
@@ -2452,6 +2465,8 @@ static void machvirt_init(MachineState *machine)
 
     create_fdt(vms);
 
+    notifier_list_init(&vms->cpuhp_notifiers);
+
     assert(possible_cpus->len == max_cpus);
     for (n = 0; n < possible_cpus->len; n++) {
         CPUArchId *cpu_slot;
@@ -3068,6 +3083,18 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
                          dev, &error_abort);
 }
 
+static void virt_update_gic(VirtMachineState *vms, CPUState *cs, bool plugging)
+{
+    GICv3CPUHotplugInfo gic_info = {
+        .gic = vms->gic,
+        .cpu = cs,
+        .cpu_plugging = plugging
+    };
+
+    /* notify gic to stitch GICC to this new cpu */
+    notifier_list_notify(&vms->cpuhp_notifiers, &gic_info);
+}
+
 static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
@@ -3144,7 +3171,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * `machvirt_init()`.
      */
     if (vms->acpi_dev) {
-        /* TODO: update GIC about this hotplug change here */
+        virt_update_gic(vms, cs, true);
         wire_gic_cpu_irqs(vms, cs);
     }
 }
@@ -3234,7 +3261,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     /* TODO: update the acpi cpu hotplug state for cpu hot-unplug */
 
     unwire_gic_cpu_irqs(vms, cs);
-    /* TODO: update the GIC about this hot unplug change */
+    virt_update_gic(vms, cs, false);
 
     /* TODO: unregister cpu for reset & update F/W info for the next boot */
 
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 4f230257ef..e7b2d04358 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -33,7 +33,6 @@
 #include "hw/arm/linux-boot-if.h"
 #include "sysemu/kvm.h"
 
-
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
 {
     if (cs->gicd_no_migration_shift_bug) {
@@ -366,6 +365,62 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
     }
 }
 
+static int arm_gicv3_get_proc_num(GICv3State *s, CPUState *cpu)
+{
+    uint64_t mp_affinity;
+    uint64_t gicr_typer;
+    uint64_t cpu_affid;
+    int i;
+
+    mp_affinity = object_property_get_uint(OBJECT(cpu), "mp-affinity", NULL);
+    /* match the cpu mp-affinity to get the gic cpuif number */
+    for (i = 0; i < s->num_cpu; i++) {
+        gicr_typer = s->cpu[i].gicr_typer;
+        cpu_affid = (gicr_typer >> 32) & 0xFFFFFF;
+        if (cpu_affid == mp_affinity) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+static void arm_gicv3_cpu_update_notifier(Notifier *notifier, void * data)
+{
+    GICv3CPUHotplugInfo *gic_info = (GICv3CPUHotplugInfo *)data;
+    CPUState *cpu = gic_info->cpu;
+    ARMGICv3CommonClass *agcc;
+    int gic_cpuif_num;
+    GICv3State *s;
+
+    s = ARM_GICV3_COMMON(gic_info->gic);
+    agcc = ARM_GICV3_COMMON_GET_CLASS(s);
+
+    /* this shall get us mapped GICv3 CPU interface corresponding to MPIDR */
+    gic_cpuif_num = arm_gicv3_get_proc_num(s, cpu);
+    if (gic_cpuif_num < 0) {
+        error_report("Failed to associate cpu %d with any GIC cpuif",
+                     cpu->cpu_index);
+        abort();
+    }
+
+    /* Update the GICv3 CPU interface accessibiltiy accordingly */
+    gicv3_set_cpustate(&s->cpu[gic_cpuif_num], cpu, gic_info->cpu_plugging);
+
+    if (!gic_info->cpu_plugging) {
+        return;
+    }
+
+    /* re-stitch the GICv3 CPU interface to this new vCPU */
+    gicv3_set_gicv3state(cpu, &s->cpu[gic_cpuif_num]);
+
+    /*
+     * define and register the GICv3 CPU interface `system registers` for
+     * this new vCPU being hotplugged
+     */
+    agcc->init_cpu_reginfo(cpu);
+}
+
 static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = ARM_GICV3_COMMON(dev);
@@ -490,6 +545,8 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
         s->cpu[cpuidx - 1].gicr_typer |= GICR_TYPER_LAST;
     }
 
+    s->cpu_update_notifier.notify = arm_gicv3_cpu_update_notifier;
+
     s->itslist = g_ptr_array_new();
 }
 
@@ -497,6 +554,7 @@ static void arm_gicv3_finalize(Object *obj)
 {
     GICv3State *s = ARM_GICV3_COMMON(obj);
 
+    notifier_remove(&s->cpu_update_notifier);
     g_free(s->redist_region_count);
 }
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 98ce68eae1..0202f0252c 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -186,6 +186,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    NotifierList cpuhp_notifiers;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index c19eb8d3d0..170118f645 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -294,6 +294,7 @@ struct GICv3State {
     GICv3CPUState *gicd_irouter_target[GICV3_MAXIRQ];
     uint32_t gicd_nsacr[DIV_ROUND_UP(GICV3_MAXIRQ, 16)];
 
+    Notifier cpu_update_notifier;
     GICv3CPUState *cpu;
     /* List of all ITSes connected to this GIC */
     GPtrArray *itslist;
@@ -344,6 +345,28 @@ struct ARMGICv3CommonClass {
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
                               const MemoryRegionOps *ops);
+/**
+ * Structure used by GICv3 CPU hotplug notifier
+ */
+typedef struct GICv3CPUHotplugInfo {
+    DeviceState *gic; /* GICv3State */
+    CPUState *cpu;
+    bool cpu_plugging; /* CPU being plugged or unplugged */
+} GICv3CPUHotplugInfo;
+
+/**
+ * gicv3_cpuhp_notifier
+ *
+ * Returns CPU hotplug notifier which could be used to update GIC about any
+ * CPU hot(un)plug events.
+ *
+ * Returns: Notifier initialized with CPU Hot(un)plug update function
+ */
+static inline Notifier *gicv3_cpuhp_notifier(DeviceState *dev)
+{
+    GICv3State *s = ARM_GICV3_COMMON(dev);
+    return &s->cpu_update_notifier;
+}
 
 /**
  * gicv3_class_name
-- 
2.34.1


