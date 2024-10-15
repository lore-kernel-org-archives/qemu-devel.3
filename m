Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E3BCFC27F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eOp-0003Dn-7b; Tue, 15 Oct 2024 06:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eOn-00033I-DD; Tue, 15 Oct 2024 06:03:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eOk-00013D-FX; Tue, 15 Oct 2024 06:03:29 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSV1C6n42z6DB43;
 Tue, 15 Oct 2024 17:58:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F0F3140B63;
 Tue, 15 Oct 2024 18:03:24 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:03:04 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <eric.auger@redhat.com>,
 <will@kernel.org>, <ardb@kernel.org>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V5 07/30] arm/virt,
 gicv3: Introduce GICv3 CPU Interface *accessibility* flag and checks
Date: Tue, 15 Oct 2024 10:59:49 +0100
Message-ID: <20241015100012.254223-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015100012.254223-1-salil.mehta@huawei.com>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.149]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Introduce a `gicc_accessible` flag to indicate whether it is safe to access the
GICv3 CPU interface. This flag will determine the availability of the GICv3 CPU
interface based on whether the associated QOM vCPUs are enabled or disabled.

Additionally, implement checks throughout the GICv3 codebase to ensure that any
updates or accesses to GICC registers (e.g., `ICC_*_EL1`) occur only when the
`gicc_accessible` flag is set. This ensures that operations such as KVM VGIC
GICC register fetches or modifications are performed only for GICv3 CPU
interfaces that are valid and associated with active QOM vCPUs.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpu-common.c                       | 11 +++++++++
 hw/arm/virt.c                      |  1 +
 hw/intc/arm_gicv3_common.c         | 14 ++++++++---
 hw/intc/arm_gicv3_cpuif.c          |  8 +++++++
 hw/intc/arm_gicv3_kvm.c            | 23 ++++++++++++++++++-
 include/hw/core/cpu.h              | 12 ++++++++++
 include/hw/intc/arm_gicv3_common.h | 37 ++++++++++++++++++++++++++++++
 7 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/cpu-common.c b/cpu-common.c
index 6b262233a3..b96eb4ca55 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -24,6 +24,7 @@
 #include "sysemu/cpus.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
+#include "hw/boards.h"
 
 QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -108,6 +109,16 @@ void cpu_list_remove(CPUState *cpu)
     cpu_list_generation_id++;
 }
 
+CPUState *qemu_get_possible_cpu(int index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    assert((index >= 0) && (index < possible_cpus->len));
+
+    return CPU(possible_cpus->cpus[index].cpu);
+}
+
 CPUState *qemu_get_cpu(int index)
 {
     CPUState *cpu;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b286afc62c..00fd65b4e1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -795,6 +795,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     vms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(vms->gic, "revision", revision);
     qdev_prop_set_uint32(vms->gic, "num-cpu", max_cpus);
+    qdev_prop_set_uint32(vms->gic, "num-smp-cpu", smp_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index bd50a1b079..218ced1d9f 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -436,13 +436,20 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_possible_cpu(i);
+        bool gicc_accessible = (i < s->num_smp_cpu);
         uint64_t cpu_affid;
 
-        s->cpu[i].cpu = cpu;
+        /*
+         * Accordingly, set the QOM `GICv3CPUState` as either accessible or
+         * inaccessible based on the `CPUState` of the associated QOM vCPU.
+         */
+        gicv3_set_cpustate(&s->cpu[i], cpu, gicc_accessible);
+
         s->cpu[i].gic = s;
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
-        gicv3_set_gicv3state(cpu, &s->cpu[i]);
+        if (gicc_accessible)
+            gicv3_set_gicv3state(cpu, &s->cpu[i]);
 
         /* Pre-construct the GICR_TYPER:
          * For our implementation:
@@ -607,6 +614,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
 
 static Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICv3State, num_cpu, 1),
+    DEFINE_PROP_UINT32("num-smp-cpu", GICv3State, num_smp_cpu, 1),
     DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
     DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
     DEFINE_PROP_BOOL("has-lpi", GICv3State, lpi_enable, 0),
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index bdb13b00e9..151f957d42 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1052,6 +1052,10 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
+    if (!gicv3_cpu_accessible(cs)) {
+        return;
+    }
+
     g_assert(bql_locked());
 
     trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
@@ -2036,6 +2040,10 @@ static void icc_generate_sgi(CPUARMState *env, GICv3CPUState *cs,
     for (i = 0; i < s->num_cpu; i++) {
         GICv3CPUState *ocs = &s->cpu[i];
 
+        if (!gicv3_cpu_accessible(ocs)) {
+            continue;
+        }
+
         if (irm) {
             /* IRM == 1 : route to all CPUs except self */
             if (cs == ocs) {
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9ea6b8e218..7e741ace50 100644
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
@@ -458,6 +459,16 @@ static void kvm_arm_gicv3_put(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /*
+         * We must ensure that we do not attempt to access or update KVM GICC
+         * registers if their corresponding QOM `GICv3CPUState` is marked as
+         * 'inaccessible', either because their corresponding QOM vCPU objects
+         * do not exist or are disabled due to hot-unplug action.
+         */
+        if (!gicv3_cpu_accessible(c)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], true);
@@ -616,6 +627,14 @@ static void kvm_arm_gicv3_get(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /*
+         * don't attempt to access KVM VGIC for the disabled vCPUs where
+         * GICv3CPUState is inaccessible.
+         */
+        if (!gicv3_cpu_accessible(c)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], false);
@@ -815,7 +834,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->num_cpu; i++) {
         ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
 
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+        if (gicv3_cpu_accessible(&s->cpu[i])) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+        }
     }
 
     /* Try to create the device via the device control API */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4e0cb325a0..0be1984698 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -950,6 +950,18 @@ static inline bool cpu_in_exclusive_context(const CPUState *cpu)
  */
 CPUState *qemu_get_cpu(int index);
 
+/**
+ * qemu_get_possible_cpu:
+ * @index: The CPUState@cpu_index value of the CPU to obtain.
+ *         Input index MUST be in range [0, Max Possible CPUs)
+ *
+ * If CPUState object exists,then it gets a CPU matching
+ * @index in the possible CPU array.
+ *
+ * Returns: The possible CPU or %NULL if CPU does not exist.
+ */
+CPUState *qemu_get_possible_cpu(int index);
+
 /**
  * cpu_exists:
  * @id: Guest-exposed CPU ID to lookup.
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index cd09bee3bc..4383a4ce08 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -190,6 +190,7 @@ struct GICv3CPUState {
     uint64_t icc_apr[3][4];
     uint64_t icc_igrpen[3];
     uint64_t icc_ctlr_el3;
+    bool gicc_accessible;
 
     /* Virtualization control interface */
     uint64_t ich_apr[3][4]; /* ich_apr[GICV3_G1][x] never used */
@@ -255,6 +256,7 @@ struct GICv3State {
     uint32_t nb_redist_regions; /* number of redist regions */
 
     uint32_t num_cpu;
+    uint32_t num_smp_cpu;
     uint32_t num_irq;
     uint32_t revision;
     bool lpi_enable;
@@ -353,4 +355,39 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
  */
 const char *gicv3_class_name(void);
 
+/**
+ * gicv3_cpu_accessible
+ *
+ * The `GICv3CPUState` can become inaccessible if the associated `CPUState` is
+ * either unavailable or in a disabled state. This state is independent of the
+ * KVM VGIC and is not compliant with ARM CPU architecture (i.e. there is no
+ * way we can explicitly enable/disable ARM GIC CPU interface). This change
+ * is specific to QOM only.
+ *
+ * Returns: True if accessible otherwise False
+ */
+static inline bool gicv3_cpu_accessible(GICv3CPUState *gicc)
+{
+    assert(gicc);
+    return gicc->gicc_accessible;
+}
+
+/**
+ * gicv3_set_cpustate
+ *
+ * Sets `GICv3CPUState` and the associated `CPUState` as accessible and
+ * available for use
+ */
+static inline void gicv3_set_cpustate(GICv3CPUState *s,
+                                      CPUState *cpu,
+                                      bool gicc_accessible)
+{
+    if (gicc_accessible) {
+        s->cpu = cpu;
+        s->gicc_accessible = true;
+    } else {
+        s->cpu = NULL;
+        s->gicc_accessible = false;
+    }
+}
 #endif
-- 
2.34.1


