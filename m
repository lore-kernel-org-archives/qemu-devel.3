Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25535C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 23:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHu3i-0000pt-7v; Thu, 13 Jun 2024 19:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu3f-0000Z2-6x; Thu, 13 Jun 2024 19:40:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sHu3c-0003SG-8u; Thu, 13 Jun 2024 19:40:42 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0f1524dLz6HJTP;
 Fri, 14 Jun 2024 07:35:53 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id 95E051400D9;
 Fri, 14 Jun 2024 07:40:35 +0800 (CST)
Received: from 00293818-MRGF.china.huawei.com (10.195.245.24) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:40:10 +0100
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
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH RFC V3 07/29] arm/virt,
 gicv3: Changes to pre-size GIC with possible vcpus @machine init
Date: Fri, 14 Jun 2024 00:36:17 +0100
Message-ID: <20240613233639.202896-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613233639.202896-1-salil.mehta@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.195.245.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The GIC needs to be pre-sized with possible vCPUs at initialization time. This
is necessary because memory regions and resources associated with GICC/GICR,
etc., cannot be changed (added, deleted, or modified) after the VM has been
initialized. Additionally, `GIC_TYPER` needs to be initialized with
`mp_affinity` and CPU interface number association, which cannot be changed
after the GIC has been initialized.

Once all the CPU interfaces of the GIC have been initialized, it must be ensured
that any updates to the GICC during reset only take place for the *enabled*
vCPUs and not the disabled ones. Therefore, proper checks are required at
various places.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[changed the comment in arm_gicv3_icc_reset]
---
 hw/arm/virt.c              | 15 ++++++++-------
 hw/intc/arm_gicv3_common.c |  7 +++++--
 hw/intc/arm_gicv3_cpuif.c  |  8 ++++++++
 hw/intc/arm_gicv3_kvm.c    | 34 +++++++++++++++++++++++++++++++---
 include/hw/arm/virt.h      |  2 +-
 5 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 81e7a27786..ac53bfadca 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -751,6 +751,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     const char *gictype;
     int i;
     unsigned int smp_cpus = ms->smp.cpus;
+    unsigned int max_cpus = ms->smp.max_cpus;
     uint32_t nb_redist_regions = 0;
     int revision;
 
@@ -775,7 +776,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     }
     vms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(vms->gic, "revision", revision);
-    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(vms->gic, "num-cpu", max_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
@@ -787,7 +788,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     if (vms->gic_version != VIRT_GIC_VERSION_2) {
         QList *redist_region_count;
         uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
-        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+        uint32_t redist0_count = MIN(max_cpus, redist0_capacity);
 
         nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
@@ -798,7 +799,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                 virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
 
             qlist_append_int(redist_region_count,
-                MIN(smp_cpus - redist0_count, redist1_capacity));
+                MIN(max_cpus - redist0_count, redist1_capacity));
         }
         qdev_prop_set_array(vms->gic, "redist-region-count",
                             redist_region_count);
@@ -871,7 +872,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         } else if (vms->virt) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
                                             intidbase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+            sysbus_connect_irq(gicbusdev, i + 4 * max_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
@@ -879,11 +880,11 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index bd50a1b079..183d2de7eb 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -436,10 +436,13 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_possible_cpu(i);
         uint64_t cpu_affid;
 
-        s->cpu[i].cpu = cpu;
+        if (qemu_enabled_cpu(cpu)) {
+            s->cpu[i].cpu = cpu;
+        }
+
         s->cpu[i].gic = s;
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
         gicv3_set_gicv3state(cpu, &s->cpu[i]);
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index bdb13b00e9..2a8aff0b99 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1052,6 +1052,10 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
+    if (!qemu_enabled_cpu(cs->cpu)) {
+        return;
+    }
+
     g_assert(bql_locked());
 
     trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
@@ -2036,6 +2040,10 @@ static void icc_generate_sgi(CPUARMState *env, GICv3CPUState *cs,
     for (i = 0; i < s->num_cpu; i++) {
         GICv3CPUState *ocs = &s->cpu[i];
 
+        if (!qemu_enabled_cpu(ocs->cpu)) {
+            continue;
+        }
+
         if (irm) {
             /* IRM == 1 : route to all CPUs except self */
             if (cs == ocs) {
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9ea6b8e218..8dbbd79e1b 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -24,6 +24,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "kvm_arm.h"
@@ -458,6 +459,18 @@ static void kvm_arm_gicv3_put(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /*
+         * To support hotplug of vcpus we need to make sure all gic cpuif/GICC
+         * are initialized at machvirt init time. Once the init is done we
+         * release the ARMCPU object for disabled vcpus but this leg could hit
+         * during reset of GICC later as well i.e. after init has happened and
+         * all of the cases we want to make sure we dont acess the GICC for
+         * the disabled VCPUs.
+         */
+        if (!qemu_enabled_cpu(c->cpu)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], true);
@@ -616,6 +629,11 @@ static void kvm_arm_gicv3_get(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /* don't access GICC for the disabled vCPUs. */
+        if (!qemu_enabled_cpu(c->cpu)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], false);
@@ -695,10 +713,19 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
         return;
     }
 
+    /*
+     * This shall be called even when vcpu is being hotplugged or onlined and
+     * other vcpus might be running. Host kernel KVM code to handle device
+     * access of IOCTLs KVM_{GET|SET}_DEVICE_ATTR might fail due to inability to
+     * grab vcpu locks for all the vcpus. Hence, we need to pause all vcpus to
+     * facilitate locking within host.
+     */
+    pause_all_vcpus();
     /* Initialize to actual HW supported configuration */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
                       KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
                       &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
+    resume_all_vcpus();
 
     c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
 }
@@ -813,9 +840,10 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
     for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+        CPUState *cs = qemu_get_cpu(i);
+        if (qemu_enabled_cpu(cs)) {
+            define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
+        }
     }
 
     /* Try to create the device via the device control API */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 780bd53ceb..36ac5ff4a2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -209,7 +209,7 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 
     assert(vms->gic_version != VIRT_GIC_VERSION_2);
 
-    return (MACHINE(vms)->smp.cpus > redist0_capacity &&
+    return (MACHINE(vms)->smp.max_cpus > redist0_capacity &&
             vms->highmem_redists) ? 2 : 1;
 }
 
-- 
2.34.1


