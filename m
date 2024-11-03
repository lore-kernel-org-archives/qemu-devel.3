Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780ADD11101
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7cVe-00031F-Mq; Sun, 03 Nov 2024 10:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7cVc-0002zz-1o; Sun, 03 Nov 2024 10:27:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7cVZ-0002SI-Lf; Sun, 03 Nov 2024 10:27:19 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XhJLF21hVz6K5lR;
 Sun,  3 Nov 2024 23:24:37 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 42385140B67;
 Sun,  3 Nov 2024 23:27:15 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.9) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 16:26:57 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <richard.henderson@linaro.org>, <peter.maydell@linaro.org>
CC: <salil.mehta@huawei.com>, <jonathan.cameron@huawei.com>,
 <alex.bennee@linaro.org>, <imammedo@redhat.com>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <maz@kernel.org>, <will@kernel.org>,
 <oliver.upton@linux.dev>, <jean-philippe@linaro.org>,
 <lpieralisi@kernel.org>, <david@redhat.com>, <philmd@linaro.org>,
 <andrew.jones@linux.dev>, <eric.auger@redhat.com>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH] hw/intc/arm-gicv3*: Refactor GICv3 CPU reginfo to have common
 invocation
Date: Sun, 3 Nov 2024 15:26:39 +0000
Message-ID: <20241103152639.202480-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.9]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refactor GICv3 code for TCG and KVM to initialize the GIC CPU interface
register information by introducing a new common hook
`ARMGICv3CommonClass::init_cpu_reginfo`. This hook can be assigned to
the respective TCG or KVM variants during the GICv3 initialization
phase and invoked during the GICv3 realization phase. The primary goals
of this refactor include:

1. Enhancing code modularity and reusability in future patch-sets.
2. Providing a common invocation function for TCG and KVM during GICv3
   realization.
3. Improving code readability.

Note: This is a non-intrusive patch with *no* functional changes
      intended. Code has been tested to confirm correct initialization
      sequences across relevant scenarios.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/intc/arm_gicv3.c                |   1 +
 hw/intc/arm_gicv3_cpuif.c          | 245 ++++++++++++++---------------
 hw/intc/arm_gicv3_cpuif_common.c   |  10 ++
 hw/intc/arm_gicv3_kvm.c            |  12 +-
 hw/intc/gicv3_internal.h           |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 6 files changed, 140 insertions(+), 130 deletions(-)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 58e18fff54..2a30625916 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -459,6 +459,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, void *data)
     ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
 
     agcc->post_load = arm_gicv3_post_load;
+    agcc->init_cpu_reginfo = gicv3_init_cpu_reginfo;
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
 }
 
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index ea1d1b3455..75a06d6f28 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -3025,143 +3025,138 @@ static void gicv3_cpuif_el_change_hook(ARMCPU *cpu, void *opaque)
     gicv3_cpuif_virt_irq_fiq_update(cs);
 }
 
-void gicv3_init_cpuif(GICv3State *s)
+void gicv3_init_cpu_reginfo(CPUState *cs)
 {
-    /* Called from the GICv3 realize function; register our system
-     * registers with the CPU
-     */
-    int i;
+    ARMCPU *cpu = ARM_CPU(cs);
+    GICv3CPUState *gcs = icc_cs_from_env(&cpu->env);
 
-    for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-        GICv3CPUState *cs = &s->cpu[i];
+    /*
+     * If the CPU doesn't define a GICv3 configuration, probably because
+     * in real hardware it doesn't have one, then we use default values
+     * matching the one used by most Arm CPUs. This applies to:
+     *  cpu->gic_num_lrs
+     *  cpu->gic_vpribits
+     *  cpu->gic_vprebits
+     *  cpu->gic_pribits
+     */
 
-        /*
-         * If the CPU doesn't define a GICv3 configuration, probably because
-         * in real hardware it doesn't have one, then we use default values
-         * matching the one used by most Arm CPUs. This applies to:
-         *  cpu->gic_num_lrs
-         *  cpu->gic_vpribits
-         *  cpu->gic_vprebits
-         *  cpu->gic_pribits
-         */
+    /*
+     * Note that we can't just use the GICv3CPUState as an opaque pointer
+     * in define_arm_cp_regs_with_opaque(), because when we're called back
+     * it might be with code translated by CPU 0 but run by CPU 1, in
+     * which case we'd get the wrong value.
+     * So instead we define the regs with no ri->opaque info, and
+     * get back to the GICv3CPUState from the CPUARMState.
+     *
+     * These CP regs callbacks can be called from either TCG or HVF code.
+     */
+    define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
 
-        /* Note that we can't just use the GICv3CPUState as an opaque pointer
-         * in define_arm_cp_regs_with_opaque(), because when we're called back
-         * it might be with code translated by CPU 0 but run by CPU 1, in
-         * which case we'd get the wrong value.
-         * So instead we define the regs with no ri->opaque info, and
-         * get back to the GICv3CPUState from the CPUARMState.
-         *
-         * These CP regs callbacks can be called from either TCG or HVF code.
-         */
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+    /*
+     * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
+     * implement FEAT_GICv3_NMI, which is the CPU interface part
+     * of NMI support. This is distinct from whether the GIC proper
+     * (redistributors and distributor) have NMI support. In QEMU
+     * that is a property of the GIC device in s->nmi_support;
+     * cs->nmi_support indicates the CPU interface's support.
+     */
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        gcs->nmi_support = true;
+        define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
+    }
 
-        /*
-         * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
-         * implement FEAT_GICv3_NMI, which is the CPU interface part
-         * of NMI support. This is distinct from whether the GIC proper
-         * (redistributors and distributor) have NMI support. In QEMU
-         * that is a property of the GIC device in s->nmi_support;
-         * cs->nmi_support indicates the CPU interface's support.
-         */
-        if (cpu_isar_feature(aa64_nmi, cpu)) {
-            cs->nmi_support = true;
-            define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
-        }
+    /*
+     * The CPU implementation specifies the number of supported
+     * bits of physical priority. For backwards compatibility
+     * of migration, we have a compat property that forces use
+     * of 8 priority bits regardless of what the CPU really has.
+     */
+    if (gcs->gic->force_8bit_prio) {
+        gcs->pribits = 8;
+    } else {
+        gcs->pribits = cpu->gic_pribits ?: 5;
+    }
 
-        /*
-         * The CPU implementation specifies the number of supported
-         * bits of physical priority. For backwards compatibility
-         * of migration, we have a compat property that forces use
-         * of 8 priority bits regardless of what the CPU really has.
-         */
-        if (s->force_8bit_prio) {
-            cs->pribits = 8;
-        } else {
-            cs->pribits = cpu->gic_pribits ?: 5;
-        }
+    /*
+     * The GICv3 has separate ID register fields for virtual priority
+     * and preemption bit values, but only a single ID register field
+     * for the physical priority bits. The preemption bit count is
+     * always the same as the priority bit count, except that 8 bits
+     * of priority means 7 preemption bits. We precalculate the
+     * preemption bits because it simplifies the code and makes the
+     * parallels between the virtual and physical bits of the GIC
+     * a bit clearer.
+     */
+    gcs->prebits = gcs->pribits;
+    if (gcs->prebits == 8) {
+        gcs->prebits--;
+    }
+    /*
+     * Check that CPU code defining pribits didn't violate
+     * architectural constraints our implementation relies on.
+     */
+    g_assert(gcs->pribits >= 4 && gcs->pribits <= 8);
 
-        /*
-         * The GICv3 has separate ID register fields for virtual priority
-         * and preemption bit values, but only a single ID register field
-         * for the physical priority bits. The preemption bit count is
-         * always the same as the priority bit count, except that 8 bits
-         * of priority means 7 preemption bits. We precalculate the
-         * preemption bits because it simplifies the code and makes the
-         * parallels between the virtual and physical bits of the GIC
-         * a bit clearer.
-         */
-        cs->prebits = cs->pribits;
-        if (cs->prebits == 8) {
-            cs->prebits--;
-        }
-        /*
-         * Check that CPU code defining pribits didn't violate
-         * architectural constraints our implementation relies on.
-         */
-        g_assert(cs->pribits >= 4 && cs->pribits <= 8);
+    /*
+     * gicv3_cpuif_reginfo[] defines ICC_AP*R0_EL1; add definitions
+     * for ICC_AP*R{1,2,3}_EL1 if the prebits value requires them.
+     */
+    if (gcs->prebits >= 6) {
+        define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr1_reginfo);
+    }
+    if (gcs->prebits == 7) {
+        define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr23_reginfo);
+    }
 
-        /*
-         * gicv3_cpuif_reginfo[] defines ICC_AP*R0_EL1; add definitions
-         * for ICC_AP*R{1,2,3}_EL1 if the prebits value requires them.
-         */
-        if (cs->prebits >= 6) {
-            define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr1_reginfo);
-        }
-        if (cs->prebits == 7) {
-            define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr23_reginfo);
-        }
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
+        int j;
 
-        if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
-            int j;
+        gcs->num_list_regs = cpu->gic_num_lrs ?: 4;
+        gcs->vpribits = cpu->gic_vpribits ?: 5;
+        gcs->vprebits = cpu->gic_vprebits ?: 5;
 
-            cs->num_list_regs = cpu->gic_num_lrs ?: 4;
-            cs->vpribits = cpu->gic_vpribits ?: 5;
-            cs->vprebits = cpu->gic_vprebits ?: 5;
 
-            /* Check against architectural constraints: getting these
-             * wrong would be a bug in the CPU code defining these,
-             * and the implementation relies on them holding.
-             */
-            g_assert(cs->vprebits <= cs->vpribits);
-            g_assert(cs->vprebits >= 5 && cs->vprebits <= 7);
-            g_assert(cs->vpribits >= 5 && cs->vpribits <= 8);
+        /* Check against architectural constraints: getting these
+         * wrong would be a bug in the CPU code defining these,
+         * and the implementation relies on them holding.
+         */
+        g_assert(gcs->vprebits <= gcs->vpribits);
+        g_assert(gcs->vprebits >= 5 && gcs->vprebits <= 7);
+        g_assert(gcs->vpribits >= 5 && gcs->vpribits <= 8);
 
-            define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
+        define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
 
-            for (j = 0; j < cs->num_list_regs; j++) {
-                /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
-                 * are split into two cp15 regs, LR (the low part, with the
-                 * same encoding as the AArch64 LR) and LRC (the high part).
-                 */
-                ARMCPRegInfo lr_regset[] = {
-                    { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
-                      .opc0 = 3, .opc1 = 4, .crn = 12,
-                      .crm = 12 + (j >> 3), .opc2 = j & 7,
-                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
-                      .nv2_redirect_offset = 0x400 + 8 * j,
-                      .access = PL2_RW,
-                      .readfn = ich_lr_read,
-                      .writefn = ich_lr_write,
-                    },
-                    { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
-                      .cp = 15, .opc1 = 4, .crn = 12,
-                      .crm = 14 + (j >> 3), .opc2 = j & 7,
-                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
-                      .access = PL2_RW,
-                      .readfn = ich_lr_read,
-                      .writefn = ich_lr_write,
-                    },
-                };
-                define_arm_cp_regs(cpu, lr_regset);
-            }
-            if (cs->vprebits >= 6) {
-                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
-            }
-            if (cs->vprebits == 7) {
-                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
-            }
+        for (j = 0; j < gcs->num_list_regs; j++) {
+            /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
+             * are split into two cp15 regs, LR (the low part, with the
+             * same encoding as the AArch64 LR) and LRC (the high part).
+             */
+            ARMCPRegInfo lr_regset[] = {
+                { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
+                  .opc0 = 3, .opc1 = 4, .crn = 12,
+                  .crm = 12 + (j >> 3), .opc2 = j & 7,
+                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                  .nv2_redirect_offset = 0x400 + 8 * j,
+                  .access = PL2_RW,
+                  .readfn = ich_lr_read,
+                  .writefn = ich_lr_write,
+                },
+                { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
+                  .cp = 15, .opc1 = 4, .crn = 12,
+                  .crm = 14 + (j >> 3), .opc2 = j & 7,
+                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                  .access = PL2_RW,
+                  .readfn = ich_lr_read,
+                  .writefn = ich_lr_write,
+                },
+            };
+            define_arm_cp_regs(cpu, lr_regset);
+        }
+        if (gcs->vprebits >= 6) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
+        }
+        if (gcs->vprebits == 7) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
         }
         if (tcg_enabled() || qtest_enabled()) {
             /*
@@ -3169,7 +3164,7 @@ void gicv3_init_cpuif(GICv3State *s)
              * state only changes on EL changes involving EL2 or EL3, so for
              * the non-TCG case this is OK, as EL2 and EL3 can't exist.
              */
-            arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, cs);
+            arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, gcs);
         } else {
             assert(!arm_feature(&cpu->env, ARM_FEATURE_EL2));
             assert(!arm_feature(&cpu->env, ARM_FEATURE_EL3));
diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
index ff1239f65d..f4d5ca447b 100644
--- a/hw/intc/arm_gicv3_cpuif_common.c
+++ b/hw/intc/arm_gicv3_cpuif_common.c
@@ -20,3 +20,13 @@ void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
 
     env->gicv3state = (void *)s;
 };
+
+void gicv3_init_cpuif(GICv3State *s)
+{
+    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_GET_CLASS(s);
+
+    /* define and register `system registers` with the vCPU  */
+    for (int i = 0; i < s->num_cpu; i++) {
+        agcc->init_cpu_reginfo(s->cpu[i].cpu);
+    }
+}
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9ea6b8e218..b4128786ca 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -777,6 +777,10 @@ static void vm_change_state_handler(void *opaque, bool running,
     }
 }
 
+static void kvm_gicv3_init_cpu_reginfo(CPUState *cs)
+{
+    define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
+}
 
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
@@ -812,11 +816,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
-    for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
-    }
+    /* Initialize vCPU interface */
+    gicv3_init_cpuif(s);
 
     /* Try to create the device via the device control API */
     s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_V3, false);
@@ -902,6 +903,7 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass, void *data)
 
     agcc->pre_save = kvm_arm_gicv3_get;
     agcc->post_load = kvm_arm_gicv3_put;
+    agcc->init_cpu_reginfo = kvm_gicv3_init_cpu_reginfo;
     device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
                                     &kgc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, kvm_arm_gicv3_reset_hold, NULL,
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index bc9f518fe8..cc8edc499b 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -722,6 +722,7 @@ void gicv3_redist_vinvall(GICv3CPUState *cs, uint64_t vptaddr);
 
 void gicv3_redist_send_sgi(GICv3CPUState *cs, int grp, int irq, bool ns);
 void gicv3_init_cpuif(GICv3State *s);
+void gicv3_init_cpu_reginfo(CPUState *cs);
 
 /**
  * gicv3_cpuif_update:
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index cd09bee3bc..7171f770e4 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -338,6 +338,7 @@ struct ARMGICv3CommonClass {
 
     void (*pre_save)(GICv3State *s);
     void (*post_load)(GICv3State *s);
+    void (*init_cpu_reginfo)(CPUState *cs);
 };
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-- 
2.34.1


