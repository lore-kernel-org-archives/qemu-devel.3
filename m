Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1ABCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS6OQ-0001PN-To; Wed, 27 May 2026 01:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6OO-0001Oj-2l; Wed, 27 May 2026 01:01:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6OL-0004GK-Di; Wed, 27 May 2026 01:01:19 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id D58B920B7179;
 Tue, 26 May 2026 22:00:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D58B920B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779858044;
 bh=saHx0AZj1bC/KGc5H4epHC7MN2YchRpmY2xtHHd20kg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FkfF8QSuMl+NarIK2QkHcFsRyJqNRFgjdpToodeJcrMDfzKJgmv9ChK7G229RSF+M
 E2DdvK76K1O+tJQIx+CrqvLAAF9CoYHiHHL75fvvOv+12j37J7mCCkvMe7IwWJc/d9
 97vyfXPsPIw1nMhAIzDwkD0h6K5AShFvYNZThYZQ=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Wed, 27 May 2026 05:00:50 +0000
Subject: [PATCH v4 14/15] hw/intc,target/arm/mshv: add MSHV vGICv3
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-mshv_accel_arm64_supp-v4-14-66d871dcdc53@linux.microsoft.com>
References: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
In-Reply-To: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

Add in-kernel GICv3 support for the MSHV accelerator, following the
same approach as the KVM and WHPX vGIC backends. The implementation
handles IRQ injection via the HVCALL_ASSERT_VIRTUAL_INTERRUPT hypercall.

Introduce mshv_arch_pre_init_vm(), an arch-specific hook called after
VM creation but before VM initialization, used on arm64 to configure
GIC partition properties (GICD base, ITS translater base, timer and PMU
PPI numbers). The x86 side provides a no-op stub.

Update the virt machine to treat MSHV like WHPX for GIC version
selection (GICv3 only) and MSI controller finalization (no ITS support).

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 accel/mshv/mshv-all.c              |   5 +
 hw/arm/virt.c                      |  12 +--
 hw/intc/arm_gicv3_common.c         |   6 +-
 hw/intc/arm_gicv3_mshv.c           | 181 +++++++++++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/hyperv/hvgdk_mini.h     |   2 +
 include/hw/hyperv/hvhdk_mini.h     |   6 ++
 include/hw/intc/arm_gicv3_common.h |   2 +-
 include/system/mshv_int.h          |   1 +
 target/arm/mshv/mshv-all.c         |  61 +++++++++++++
 target/i386/mshv/mshv-all.c        |   5 +
 11 files changed, 270 insertions(+), 12 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 61a9d58546..2cad2f0619 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -200,6 +200,11 @@ static int create_vm(int mshv_fd, int *vm_fd)
         return -1;
     }
 
+    ret = mshv_arch_pre_init_vm(*vm_fd);
+    if (ret < 0) {
+        return -1;
+    }
+
     ret = initialize_vm(*vm_fd);
     if (ret < 0) {
         return -1;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7803c73b0d..026de919c7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2663,7 +2663,7 @@ static void finalize_gic_version(VirtMachineState *vms)
         /* KVM w/o kernel irqchip can only deal with GICv2 */
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         accel_name = "KVM with kernel-irqchip=off";
-    } else if (whpx_enabled()) {
+    } else if (whpx_enabled() || mshv_enabled()) {
         gics_supported |= VIRT_GIC_VERSION_3_MASK;
     } else if (hvf_enabled()) {
         if (!hvf_irqchip_in_kernel()) {
@@ -2717,7 +2717,7 @@ static void finalize_msi_controller(VirtMachineState *vms)
     if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
-        } else if (whpx_enabled()) {
+        } else if (whpx_enabled() || mshv_enabled()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         }  else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
@@ -2739,12 +2739,8 @@ static void finalize_msi_controller(VirtMachineState *vms)
             error_report("GICv2 + ITS is an invalid configuration.");
             exit(1);
         }
-        if (vms->gic_version == VIRT_GIC_VERSION_5) {
-            error_report("GICv5 + ITS is not yet implemented.");
-            exit(1);
-        }
-        if (whpx_enabled()) {
-            error_report("ITS not supported on WHPX.");
+        if (mshv_enabled()) {
+            error_report("ITS not supported on MSHV.");
             exit(1);
         }
         if (hvf_enabled() && hvf_irqchip_in_kernel()) {
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f7ba74e6d5..bfed6735b0 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -33,7 +33,7 @@
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
 #include "system/whpx.h"
-#include "system/hvf.h"
+#include "system/mshv.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -660,8 +660,8 @@ const char *gicv3_class_name(void)
         return "kvm-arm-gicv3";
     } else if (whpx_enabled()) {
         return TYPE_WHPX_GICV3;
-    } else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
-        return TYPE_HVF_GICV3;
+    } else if (mshv_enabled()) {
+        return TYPE_MSHV_GICV3;
     } else {
         if (kvm_enabled()) {
             error_report("Userspace GICv3 is not supported with KVM");
diff --git a/hw/intc/arm_gicv3_mshv.c b/hw/intc/arm_gicv3_mshv.c
new file mode 100644
index 0000000000..a87819a5ba
--- /dev/null
+++ b/hw/intc/arm_gicv3_mshv.c
@@ -0,0 +1,181 @@
+/*
+ * ARM Generic Interrupt Controller using MSHV in-kernel support
+ *
+ * Copyright Microsoft, Corp. 2026
+ * Based on vGICv3 KVM code by Pavel Fedin
+ *
+ * Authors:
+ *      Aastha Rawat <aastharawat@microsoft.com>
+ *      Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "migration/blocker.h"
+#include "target/arm/cpregs.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+struct MSHVARMGICv3Class {
+    ARMGICv3CommonClass parent_class;
+    DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
+};
+
+OBJECT_DECLARE_TYPE(GICv3State, MSHVARMGICv3Class, MSHV_GICV3)
+
+static void mshv_gicv3_get(GICv3State *s)
+{
+}
+
+static void mshv_gicv3_put(GICv3State *s)
+{
+}
+
+static void mshv_gicv3_reset_hold(Object *obj, ResetType type)
+{
+    GICv3State *s = ARM_GICV3_COMMON(obj);
+    MSHVARMGICv3Class *mgc = MSHV_GICV3_GET_CLASS(s);
+
+    if (mgc->parent_phases.hold) {
+        mgc->parent_phases.hold(obj, type);
+    }
+
+    mshv_gicv3_put(s);
+}
+
+static void mshv_gicv3_set_irq(void *opaque, int irq, int level)
+{
+    int ret;
+    GICv3State *s = (GICv3State *)opaque;
+    int vm_fd = mshv_state->vm;
+    struct hv_input_assert_virtual_interrupt arg = {0};
+    struct mshv_root_hvcall args = {0};
+    union hv_interrupt_control control = {
+        .interrupt_type = HV_ARM64_INTERRUPT_TYPE_FIXED,
+        .rsvd1 = 0,
+        .asserted = level,
+        .rsvd2 = 0
+    };
+
+    if (irq >= s->num_irq) {
+        return;
+    }
+
+    arg.control = control;
+    arg.vector = GIC_INTERNAL + irq;
+
+    args.code   = HVCALL_ASSERT_VIRTUAL_INTERRUPT;
+    args.in_sz  = sizeof(arg);
+    args.in_ptr = (uint64_t)&arg;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set GICv3 IRQ %d to level %d", irq, level);
+    }
+}
+
+static void mshv_gicv3_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    GICv3State *s = MSHV_GICV3(dev);
+    MSHVARMGICv3Class *mgc = MSHV_GICV3_GET_CLASS(s);
+    int i, ret;
+
+    mgc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    if (s->revision != 3) {
+        error_setg(errp, "unsupported GIC revision %d for platform GIC",
+                   s->revision);
+        return;
+    }
+
+    if (s->security_extn) {
+        error_setg(errp, "the platform vGICv3 does not implement the "
+                   "security extensions");
+        return;
+    }
+
+    if (s->nmi_support) {
+        error_setg(errp, "NMI is not supported with the platform GIC");
+        return;
+    }
+
+    if (s->nb_redist_regions > 1) {
+        error_setg(errp, "Multiple VGICv3 redistributor regions are not "
+                   "supported by MSHV");
+        error_append_hint(errp, "A maximum of %d VCPUs can be used",
+                          s->redist_region_count[0]);
+        return;
+    }
+
+    gicv3_init_irqs_and_mmio(s, mshv_gicv3_set_irq, NULL);
+
+    for (i = 0; i < s->num_cpu; i++) {
+        CPUState *cpu_state = qemu_get_cpu(i);
+
+        hv_register_assoc gicr_base = {
+            .name = HV_ARM64_REGISTER_GICR_BASE_GPA,
+            .value = {
+                .reg64 = 0x080A0000 + (GICV3_REDIST_SIZE * i)
+            }
+        };
+
+        ret = mshv_set_generic_regs(cpu_state, &gicr_base, 1);
+        if (ret < 0) {
+            error_setg(errp, "Failed to set GICR base for CPU %d", i);
+            return;
+        }
+    }
+
+    if (s->maint_irq) {
+        error_setg(errp,
+               "Nested virtualisation not currently supported by MSHV");
+        return;
+    }
+
+    error_setg(&s->migration_blocker,
+        "Live migration disabled because GIC state save/restore not supported on MSHV");
+    if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+        error_report_err(*errp);
+    }
+}
+
+static void mshv_gicv3_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
+    MSHVARMGICv3Class *mgc = MSHV_GICV3_CLASS(klass);
+
+    agcc->pre_save = mshv_gicv3_get;
+    agcc->post_load = mshv_gicv3_put;
+
+    device_class_set_parent_realize(dc, mshv_gicv3_realize,
+                                    &mgc->parent_realize);
+    resettable_class_set_parent_phases(rc, NULL, mshv_gicv3_reset_hold, NULL,
+                                       &mgc->parent_phases);
+}
+
+static const TypeInfo mshv_arm_gicv3_info = {
+    .name = TYPE_MSHV_GICV3,
+    .parent = TYPE_ARM_GICV3_COMMON,
+    .instance_size = sizeof(GICv3State),
+    .class_init = mshv_gicv3_class_init,
+    .class_size = sizeof(MSHVARMGICv3Class),
+};
+
+static void mshv_gicv3_register_types(void)
+{
+    type_register_static(&mshv_arm_gicv3_info);
+}
+
+type_init(mshv_gicv3_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index fac2d228f9..57505303e2 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -49,6 +49,7 @@ specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gic
 specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
 stub_ss.add(files('arm_gicv3_hvf_stub.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: ['CONFIG_MSHV', 'TARGET_AARCH64'], if_true: files('arm_gicv3_mshv.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index c3424b760a..e8c448b32e 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -66,6 +66,8 @@ typedef enum hv_register_name {
     HV_ARM64_REGISTER_MIDR_EL1   = 0x00040051,
     HV_ARM64_REGISTER_MPIDR_EL1  = 0x00040001,
 
+    HV_ARM64_REGISTER_GICR_BASE_GPA       = 0x00063000,
+
 #elif defined(__x86_64__)
     /* X64 User-Mode Registers */
     HV_X64_REGISTER_RAX     = 0x00020000,
diff --git a/include/hw/hyperv/hvhdk_mini.h b/include/hw/hyperv/hvhdk_mini.h
index 9c2f3cf5ae..4d78fa0677 100644
--- a/include/hw/hyperv/hvhdk_mini.h
+++ b/include/hw/hyperv/hvhdk_mini.h
@@ -62,6 +62,12 @@ enum hv_partition_property_code {
     HV_PARTITION_PROPERTY_ISOLATION_POLICY                       = 0x00050014,
     HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION               = 0x00050017,
     HV_PARTITION_PROPERTY_SEV_VMGEXIT_OFFLOADS                   = 0x00050022,
+    HV_PARTITION_PROPERTY_GICD_BASE_ADDRESS                      = 0x00050028,
+    HV_PARTITION_PROPERTY_GITS_TRANSLATER_BASE_ADDRESS           = 0x00050029,
+    HV_PARTITION_PROPERTY_GIC_LPI_INT_ID_BITS                    = 0x0005002A,
+    HV_PARTITION_PROPERTY_GIC_PPI_OVERFLOW_INTERRUPT_FROM_CNTV   = 0x0005002B,
+    HV_PARTITION_PROPERTY_GIC_PPI_OVERFLOW_INTERRUPT_FROM_CNTP   = 0x0005002C,
+    HV_PARTITION_PROPERTY_GIC_PPI_PERFORMANCE_MONITORS_INTERRUPT = 0x0005002D,
 
     /* Compatibility properties */
     HV_PARTITION_PROPERTY_PROCESSOR_VENDOR              = 0x00060000,
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 03ab3e8f2f..2eb5219a54 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -315,7 +315,7 @@ DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3CommonClass,
 
 /* Types for GICv3 kernel-irqchip */
 #define TYPE_WHPX_GICV3 "whpx-arm-gicv3"
-#define TYPE_HVF_GICV3 "hvf-arm-gicv3"
+#define TYPE_MSHV_GICV3 "mshv-arm-gicv3"
 
 struct ARMGICv3CommonClass {
     /*< private >*/
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 62fad48895..3e88f6b178 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -96,6 +96,7 @@ void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd);
+int mshv_arch_pre_init_vm(int vm_fd);
 int mshv_arch_post_init_vm(int vm_fd);
 void mshv_setup_hvcall_args(AccelCPUState *state);
 
diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
index 22653eb366..88531f6e73 100644
--- a/target/arm/mshv/mshv-all.c
+++ b/target/arm/mshv/mshv-all.c
@@ -290,6 +290,67 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     state->hvcall_args = (MshvHvCallArgs){0};
 }
 
+static int set_partition_prop(int vm_fd, uint32_t prop_code,
+                                uint64_t prop_value)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    in.property_code = prop_code;
+    in.property_value = prop_value;
+
+    struct mshv_root_hvcall args = {0};
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set partition property code %u", prop_code);
+        return -1;
+    }
+
+    return 0;
+}
+
+int mshv_arch_pre_init_vm(int vm_fd)
+{
+    int ret;
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+
+    ret = set_partition_prop(vm_fd,
+                            HV_PARTITION_PROPERTY_GICD_BASE_ADDRESS,
+                            vms->memmap[VIRT_GIC_DIST].base);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = set_partition_prop(vm_fd,
+                        HV_PARTITION_PROPERTY_GITS_TRANSLATER_BASE_ADDRESS,
+                        vms->memmap[VIRT_GIC_ITS].base);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = set_partition_prop(vm_fd,
+                        HV_PARTITION_PROPERTY_GIC_LPI_INT_ID_BITS,
+                        0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = set_partition_prop(vm_fd,
+                        HV_PARTITION_PROPERTY_GIC_PPI_OVERFLOW_INTERRUPT_FROM_CNTV,
+                        ARCH_TIMER_VIRT_IRQ);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = set_partition_prop(vm_fd,
+                        HV_PARTITION_PROPERTY_GIC_PPI_PERFORMANCE_MONITORS_INTERRUPT,
+                        VIRTUAL_PMU_IRQ);
+
+    return ret;
+}
 
 static uint32_t mshv_arm_get_ipa_bit_size(int mshv_fd)
 {
diff --git a/target/i386/mshv/mshv-all.c b/target/i386/mshv/mshv-all.c
index f0b43aa86f..ce8b426ea4 100644
--- a/target/i386/mshv/mshv-all.c
+++ b/target/i386/mshv/mshv-all.c
@@ -39,6 +39,11 @@ int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd)
     return 0;
 }
 
+int mshv_arch_pre_init_vm(int vm_fd)
+{
+    return 0;
+}
+
 /*
  * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
  * fault to the guest if it tries to access it. It is possible to override

-- 
2.45.4


