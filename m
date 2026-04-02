Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF55D3942B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILH-0008NK-Sr; Thu, 02 Apr 2026 09:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8IKu-0005fW-2X; Thu, 02 Apr 2026 09:43:53 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1w8HXu-0008SD-LC; Thu, 02 Apr 2026 08:53:17 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 64D8820B713B;
 Thu,  2 Apr 2026 05:53:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64D8820B713B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775134381;
 bh=TY7n33ExJIL0Bw0UIsz8p5ZQFgxMQ47a5Q5d1DVObQA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BD1sLZkHdf8eweQ1tpQmiksrEnFpDs2ChJjXdttdc0gcH/wqtRfWHi6FZeCOORWon
 ZQEjcce70peIeuWr7rbD/xBbP9UROl3iSS7djjZOkdjLBNc0cG24vJB7ncX5T5giww
 SxrhkBjPqcNcSlbSSkMjerjcArTbfZXXBl9+hd7g=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 02 Apr 2026 12:52:32 +0000
Subject: [PATCH v2 05/14] target/arm/mshv: implement -cpu host for MSHV
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-mshv_accel_arm64_supp-v2-5-754895c15e9e@linux.microsoft.com>
References: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
In-Reply-To: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit enables support for the `-cpu host` option with MSHV
accelerator on ARM64. The implementation queries the partition's CPU's
ID registers and features via hypervisor interface, allowing to pass all
CPU capabilities for the host CPU to the guest.

Replace preprocessor config checks with runtime calls to mshv_enabled(),
kvm_enabled(), etc. This ensures that the correct accelerator is
selected at runtime when both MSHV and KVM are enabled.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 accel/mshv/mshv-all.c          |   3 +-
 hw/arm/virt.c                  |   3 +-
 include/hw/hyperv/hvgdk_mini.h |  17 ++++
 include/hw/hyperv/hvhdk.h      |  10 ++
 include/system/hw_accel.h      |   3 +-
 target/arm/cpu.c               |   6 +-
 target/arm/cpu64.c             |  24 +++--
 target/arm/mshv/mshv-all.c     | 204 +++++++++++++++++++++++++++++++++++++++++
 target/arm/mshv_arm.h          |  18 ++++
 9 files changed, 273 insertions(+), 15 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d4cc7f5371..44f35a1463 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -400,13 +400,14 @@ static int mshv_init_vcpu(CPUState *cpu)
     int ret;
 
     cpu->accel = g_new0(AccelCPUState, 1);
-    mshv_arch_init_vcpu(cpu);
 
     ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
     if (ret < 0) {
         return -1;
     }
 
+    mshv_arch_init_vcpu(cpu);
+
     cpu->accel->dirty = true;
 
     return 0;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7456614d05..34eb5248a9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -50,6 +50,7 @@
 #include "system/kvm.h"
 #include "system/hvf.h"
 #include "system/whpx.h"
+#include "system/mshv.h"
 #include "system/qtest.h"
 #include "system/system.h"
 #include "hw/core/loader.h"
@@ -3450,7 +3451,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-        if (kvm_enabled() || hvf_enabled()) {
+        if (kvm_enabled() || hvf_enabled() || mshv_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
     }
diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index dfe94050f4..d56be0d70f 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -48,6 +48,20 @@ typedef enum hv_register_name {
     HV_ARM64_REGISTER_LR    = 0x0002001E,
     HV_ARM64_REGISTER_PC    = 0x00020022,
 
+    /* AArch64 System Register Descriptions: ID Registers */
+    HV_ARM64_REGISTER_ID_MIDR_EL1         = 0x00022000,
+    HV_ARM64_REGISTER_ID_MPIDR_EL1        = 0x00022005,
+    HV_ARM64_REGISTER_ID_AA64_PFR0_EL1    = 0x00022020,
+    HV_ARM64_REGISTER_ID_AA64_PFR1_EL1    = 0x00022021,
+    HV_ARM64_REGISTER_ID_AA64_ISAR0_EL1   = 0x00022030,
+    HV_ARM64_REGISTER_ID_AA64_ISAR1_EL1   = 0x00022031,
+    HV_ARM64_REGISTER_ID_AA64_ISAR2_EL1   = 0x00022032,
+    HV_ARM64_REGISTER_ID_AA64_MMFR0_EL1   = 0x00022038,
+    HV_ARM64_REGISTER_ID_AA64_MMFR1_EL1   = 0x00022039,
+    HV_ARM64_REGISTER_ID_AA64_MMFR2_EL1   = 0x0002203a,
+    HV_ARM64_REGISTER_ID_AA64_DFR0_EL1    = 0x00022028,
+    HV_ARM64_REGISTER_ID_AA64_DFR1_EL1    = 0x00022029,
+
     /* AArch64 System Register Descriptions: General system control registers */
     HV_ARM64_REGISTER_MIDR_EL1   = 0x00040051,
     HV_ARM64_REGISTER_MPIDR_EL1  = 0x00040001,
@@ -841,6 +855,9 @@ struct hv_cpuid {
 #define HV_HYP_PAGE_SIZE        BIT(HV_HYP_PAGE_SHIFT)
 #define HV_HYP_PAGE_MASK        (~(HV_HYP_PAGE_SIZE - 1))
 
+#define HV_ANY_VP               ((uint32_t)-1)
+#define HV_VTL_ALL              0xF
+
 #define HVCALL_GET_PARTITION_PROPERTY    0x0044
 #define HVCALL_SET_PARTITION_PROPERTY    0x0045
 #define HVCALL_GET_VP_REGISTERS          0x0050
diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
index 866c8211bf..2e1ef80972 100644
--- a/include/hw/hyperv/hvhdk.h
+++ b/include/hw/hyperv/hvhdk.h
@@ -18,6 +18,16 @@ struct hv_input_set_partition_property {
     uint64_t property_value;
 };
 
+struct hv_input_get_partition_property {
+    uint64_t partition_id;
+    uint32_t property_code; /* enum hv_partition_property_code */
+    uint32_t padding;
+};
+
+struct hv_output_get_partition_property {
+    uint64_t property_value;
+};
+
 union hv_partition_synthetic_processor_features {
     uint64_t as_uint64[HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS];
 
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index f0c10b6d80..614ea60be3 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -51,7 +51,8 @@ static inline bool hwaccel_enabled(void)
     return hvf_enabled()
         || kvm_enabled()
         || nvmm_enabled()
-        || whpx_enabled();
+        || whpx_enabled()
+        || mshv_enabled();
 }
 
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e3e84b4bb..8aa22747ff 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -46,6 +46,7 @@
 #include "system/tcg.h"
 #include "system/qtest.h"
 #include "system/hw_accel.h"
+#include "system/mshv.h"
 #include "kvm_arm.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
@@ -1629,8 +1630,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM or HVF");
+        if (!kvm_enabled() && !hvf_enabled() && !mshv_enabled()) {
+            error_setg(errp,
+                       "The 'host' CPU type can only be used with KVM, HVF, or MSHV");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d6feba220e..59cb23dd99 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -26,12 +26,14 @@
 #include "qemu/units.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/mshv.h"
 #include "system/whpx.h"
 #include "system/hw_accel.h"
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "mshv_arm.h"
 #include "whpx_arm.h"
 #include "qapi/visitor.h"
 #include "hw/core/qdev-properties.h"
@@ -821,16 +823,18 @@ static void aarch64_host_initfn(Object *obj)
     }
 #endif
 
-#if defined(CONFIG_KVM)
-    kvm_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_sve_properties(obj);
-#elif defined(CONFIG_HVF)
-    hvf_arm_set_cpu_features_from_host(cpu);
-#elif defined(CONFIG_WHPX)
-    whpx_arm_set_cpu_features_from_host(cpu);
-#else
-    g_assert_not_reached();
-#endif
+    if (mshv_enabled()) {
+        mshv_arm_set_cpu_features_from_host(cpu);
+    } else if (kvm_enabled()) {
+        kvm_arm_set_cpu_features_from_host(cpu);
+        aarch64_add_sve_properties(obj);
+    } else if (hvf_enabled()) {
+        hvf_arm_set_cpu_features_from_host(cpu);
+    } else if (whpx_enabled()) {
+        whpx_arm_set_cpu_features_from_host(cpu);
+    } else {
+        g_assert_not_reached();
+    }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_pauth_properties(obj);
     }
diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
index ad9cb267a8..db1174b444 100644
--- a/target/arm/mshv/mshv-all.c
+++ b/target/arm/mshv/mshv-all.c
@@ -18,10 +18,23 @@
 
 #include "system/cpus.h"
 #include "target/arm/cpu.h"
+#include "target/arm/internals.h"
+#include "target/arm/mshv_arm.h"
 
 #include "system/mshv.h"
 #include "system/mshv_int.h"
 #include "hw/hyperv/hvgdk_mini.h"
+#include "hw/hyperv/hvhdk_mini.h"
+
+typedef struct ARMHostCPUFeatures {
+    ARMISARegisters isar;
+    uint64_t features;
+    uint64_t midr;
+    uint32_t reset_sctlr;
+    const char *dtb_compatible;
+} ARMHostCPUFeatures;
+
+static ARMHostCPUFeatures arm_host_cpu_features;
 
 static enum hv_register_name STANDARD_REGISTER_NAMES[32] = {
     HV_ARM64_REGISTER_X0,
@@ -190,3 +203,194 @@ int mshv_arch_post_init_vm(int vm_fd)
 {
     return 0;
 }
+
+static uint32_t mshv_arm_get_ipa_bit_size(int mshv_fd)
+{
+    int ret;
+    struct hv_input_get_partition_property in = {0};
+    struct hv_output_get_partition_property out = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_PHYSICAL_ADDRESS_WIDTH;
+
+    args.code = HVCALL_GET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+    args.out_sz = sizeof(out);
+    args.out_ptr = (uint64_t)&out;
+
+    ret = mshv_hvcall(mshv_fd, &args);
+
+    if (ret < 0) {
+        error_report("Failed to get IPA size");
+        exit(1);
+    }
+
+    return out.property_value;
+}
+
+static void clamp_id_aa64mmfr0_parange_to_ipa_size(int mshv_fd,
+                                                   ARMISARegisters *isar)
+{
+    uint32_t ipa_size = mshv_arm_get_ipa_bit_size(mshv_fd);
+    uint64_t id_aa64mmfr0;
+
+    /* Clamp down the PARange to the IPA size the kernel supports. */
+    uint8_t index = round_down_to_parange_index(ipa_size);
+    id_aa64mmfr0 = GET_IDREG(isar, ID_AA64MMFR0);
+    id_aa64mmfr0 = (id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
+    SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
+}
+
+static int mshv_get_partition_regs(int vm_fd, hv_register_name *names,
+                             hv_register_value *values, size_t n_regs)
+{
+    int ret = 0;
+    size_t in_sz, names_sz, values_sz;
+    void *in_buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    void *out_buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    hv_input_get_vp_registers *in = in_buffer;
+
+    struct mshv_root_hvcall args = {0};
+
+    names_sz = n_regs * sizeof(hv_register_name);
+    in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
+
+    memset(in, 0, HV_HYP_PAGE_SIZE);
+
+    in->vp_index = HV_ANY_VP;
+    in->input_vtl.target_vtl = HV_VTL_ALL;
+    in->input_vtl.use_target_vtl = 1;
+
+    for (int i = 0; i < n_regs; i++) {
+        in->names[i] = names[i];
+    }
+
+    values_sz = n_regs * sizeof(hv_register_value);
+
+    args.code = HVCALL_GET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uintptr_t)(in_buffer);
+    args.out_sz = values_sz;
+    args.out_ptr = (uintptr_t)(out_buffer);
+    args.reps =  (uint16_t) n_regs;
+
+    ret = mshv_hvcall(vm_fd, &args);
+
+    if (ret == 0) {
+        memcpy(values, out_buffer, values_sz);
+    }
+
+    qemu_vfree(in_buffer);
+    qemu_vfree(out_buffer);
+
+    return ret;
+}
+
+static bool mshv_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+{
+    int mshv_fd = mshv_state->fd;
+    int vm_fd = mshv_state->vm;
+    int i, ret;
+    bool success = true;
+    uint64_t pfr0, pfr1;
+    gchar *contents = NULL;
+
+    const struct {
+        hv_register_name name;
+        int isar_idx;
+    } regs[] = {
+        { HV_ARM64_REGISTER_ID_AA64_PFR0_EL1,  ID_AA64PFR0_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_PFR1_EL1,  ID_AA64PFR1_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_ISAR2_EL1, ID_AA64ISAR2_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_DFR0_EL1,  ID_AA64DFR0_EL1_IDX },
+        { HV_ARM64_REGISTER_ID_AA64_DFR1_EL1,  ID_AA64DFR1_EL1_IDX },
+    };
+
+    size_t n_regs = ARRAY_SIZE(regs);
+    hv_register_name *reg_names = g_new(hv_register_name, n_regs);
+    hv_register_value *reg_values = g_new(hv_register_value, n_regs);
+
+    for (i = 0; i < n_regs; i++) {
+        reg_names[i] = regs[i].name;
+    }
+
+    ret = mshv_get_partition_regs(vm_fd, reg_names, reg_values, n_regs);
+
+    if (ret < 0) {
+        error_report("Failed to get host ID registers");
+        success = false;
+        goto out;
+    }
+
+    for (i = 0; i < n_regs; i++) {
+        ahcf->isar.idregs[regs[i].isar_idx] = reg_values[i].reg64;
+    }
+
+    /* Read MIDR_EL1 from sysfs */
+    if (g_file_get_contents(
+            "/sys/devices/system/cpu/cpu0/regs/identification/midr_el1",
+            &contents, NULL, NULL)) {
+        ahcf->midr = g_ascii_strtoull(contents, NULL, 0);
+    } else {
+        error_report("Failed to read MIDR_EL1 from sysfs");
+        success = false;
+        goto out;
+    }
+
+    ahcf->dtb_compatible = "arm,armv8";
+    ahcf->features = (1ULL << ARM_FEATURE_V8) |
+                     (1ULL << ARM_FEATURE_AARCH64) |
+                     (1ULL << ARM_FEATURE_PMU) |
+                     (1ULL << ARM_FEATURE_GENERIC_TIMER) |
+                     (1ULL << ARM_FEATURE_NEON);
+
+    clamp_id_aa64mmfr0_parange_to_ipa_size(mshv_fd, &ahcf->isar);
+
+    /*
+     * SVE (Scalable Vector Extension) and SME (Scalable Matrix Extension)
+     * require specific context switch logic in the accelerator.
+     * Mask them out for now to ensure stability.
+     */
+    /* Mask SVE in PFR0 */
+    pfr0 = GET_IDREG(&ahcf->isar, ID_AA64PFR0);
+    pfr0 &= ~R_ID_AA64PFR0_SVE_MASK;
+    SET_IDREG(&ahcf->isar, ID_AA64PFR0, pfr0);
+
+    /* Mask SME in PFR1 */
+    pfr1 = GET_IDREG(&ahcf->isar, ID_AA64PFR1);
+    pfr1 &= ~R_ID_AA64PFR1_SME_MASK;
+    SET_IDREG(&ahcf->isar, ID_AA64PFR1, pfr1);
+
+out:
+    g_free(contents);
+    g_free(reg_names);
+    g_free(reg_values);
+    return success;
+}
+
+void mshv_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    if (!arm_host_cpu_features.dtb_compatible) {
+        if (!mshv_enabled() ||
+            !mshv_arm_get_host_cpu_features(&arm_host_cpu_features)) {
+            /*
+             * We can't report this error yet, so flag that we need to
+             * in arm_cpu_realizefn().
+             */
+            cpu->host_cpu_probe_failed = true;
+            return;
+        }
+    }
+
+    cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
+    cpu->isar = arm_host_cpu_features.isar;
+    cpu->env.features = arm_host_cpu_features.features;
+    cpu->midr = arm_host_cpu_features.midr;
+    cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
+}
diff --git a/target/arm/mshv_arm.h b/target/arm/mshv_arm.h
new file mode 100644
index 0000000000..a03f9a4405
--- /dev/null
+++ b/target/arm/mshv_arm.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Aastha Rawat   <aastharawat@linux.microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_MSHV_ARM_H
+#define QEMU_MSHV_ARM_H
+
+#include "target/arm/cpu.h"
+
+void mshv_arm_set_cpu_features_from_host(ARMCPU *cpu);
+
+#endif

-- 
2.45.4


