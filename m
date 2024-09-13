Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44492FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp816-0005iU-Ju; Fri, 13 Sep 2024 11:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp809-00029A-To
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp806-0007nG-Gz
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so20946155e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240461; x=1726845261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TKWeC4pYOAAnp+KIP7VnR06oZPWCIMY6KFnj6eH8Ao0=;
 b=sa9fcwu3HuaVJjh1bAo1qXkUrkds4EqoK83QjBa6NnW2+RzLC28L0icwrggyub/ctK
 poqnQgudFsmI+ERwmq23NGEIMc33Rg7gto21zYAAtWJg5KJoWt5E3YTU5FV98ZA36rxs
 RWeztRz62MDiZ+IXb0wOJo1IvvCtX2JxrgnEtPG6NPOxAFWm0+TEN9yBgL+UvybHrAsZ
 7kceXoC4RILkEedX4dMahlxb0E59Xv1EG0/9hJQmqjpI0ZCA2LqlVytmnha7kV+OCYsB
 FMKbmiIHtqg/1WzisTDJmJ6P68cZkYZP7LnzhsQ72SlkKeVuxmkOqsO/w80ibGrfq5BF
 wXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240461; x=1726845261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKWeC4pYOAAnp+KIP7VnR06oZPWCIMY6KFnj6eH8Ao0=;
 b=xOTo4RQE3vpRfSBnXxwAu6R3KUQyMAMOw7p6JYxZKAos+g2s4pXbCsd8EkpPIrgaLE
 lsG21tbLGkGhBc7oZgaoiD9KQ34qVjOBc3Dn00Zu1VuuaVNKG4+Grbdwq17yV/kXE5Bx
 TAVYrp6N1ijOP6RyO9tWJbNbN0ZQp/QWu4gjP9piJLMlx5Z0lQ74MWZK5VvnnQj2wRpB
 b3CZncwrh/+lDPNAUpwedoXzt+azt45zbbAfnZkXWQuZ6q+mndwK0ha2f+BKjohrYVn+
 hdy5TmeJooU3vUDVhp1/gMix5RbniW9jC+XDZFYIiiUfshbpXsCOMBP5aMWNbW2W3czG
 mAyA==
X-Gm-Message-State: AOJu0YywQGX9MNwYnOPpvOfTpU/wPJVehdldTa3HslaIHwIDL1RxGqWc
 Bessw3At4IVgx+sJr/YEGXMJmkc3qztv8RVUYtDGDo6uUijVVko3agEIU10JURp24+jK3TIhpHj
 O
X-Google-Smtp-Source: AGHT+IHlfDdF0fIb0e/fxAPYpKFphnrgAweDPyWE/by9PIQ6Si8MK8vKlJgLxeQpeFF1nSDpze9Cjw==
X-Received: by 2002:a05:600c:1e10:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-42cdb522cf7mr57774665e9.10.1726240460854; 
 Fri, 13 Sep 2024 08:14:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/27] hvf: arm: Implement and use
 hvf_get_physical_address_range
Date: Fri, 13 Sep 2024 16:13:59 +0100
Message-Id: <20240913151411.2167922-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Danny Canter <danny_canter@apple.com>

This patch's main focus is to use the previously added
hvf_get_physical_address_range to inform VM creation
about the IPA size we need for the VM, so we can extend
the default 36b IPA size and support VMs with 64+GB of
RAM. This is done by freezing the memory map, computing
the highest GPA and then (depending on if the platform
supports an IPA size that large) telling the kernel to
use a size >= for the VM. In pursuit of this a couple of
things related to how we handle the physical address range
we expose to guests were altered, but for an explanation of
what we were doing:

Today, to get the IPA size we were reading id_aa64mmfr0_el1's
PARange field from a newly made vcpu. Unfortunately, HVF just
returns the hosts PARange directly for the initial value and
not the IPA size that will actually back the VM, so we believe
we have much more address space than we actually do today it seems.

Starting in macOS 13.0 some APIs were introduced to be able to
query the maximum IPA size the kernel supports, and to set the IPA
size for a given VM. However, this still has a couple of issues
on < macOS 15. Up until macOS 15 (and if the hardware supported
it) the max IPA size was 39 bits which is not a valid PARange
value, so we can't clamp down what we advertise in the vcpu's
id_aa64mmfr0_el1 to our IPA size. Starting in macOS 15 however,
the maximum IPA size is 40 bits (if it's supported in the hardware
as well) which is also a valid PARange value so we can set our IPA
size to the maximum as well as clamp down the PARange we advertise
to the guest. This allows VMs with 64+ GB of RAM and should fix the
oddness of the PARange situation as well.

Signed-off-by: Danny Canter <danny_canter@apple.com>
Message-id: 20240828111552.93482-4-danny_canter@apple.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf_arm.h      | 19 +++++++++++++
 target/arm/internals.h    | 19 +++++++++++++
 accel/hvf/hvf-accel-ops.c | 12 ++++++++-
 hw/arm/virt.c             | 31 +++++++++++++++++++++-
 target/arm/hvf/hvf.c      | 56 ++++++++++++++++++++++++++++++++++++++-
 target/arm/ptw.c          | 15 +++++++++++
 6 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index e848c1d27d4..26c717b3826 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -22,4 +22,23 @@ void hvf_arm_init_debug(void);
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+#ifdef CONFIG_HVF
+
+uint32_t hvf_arm_get_default_ipa_bit_size(void);
+uint32_t hvf_arm_get_max_ipa_bit_size(void);
+
+#else
+
+static inline uint32_t hvf_arm_get_default_ipa_bit_size(void)
+{
+    return 0;
+}
+
+static inline uint32_t hvf_arm_get_max_ipa_bit_size(void)
+{
+    return 0;
+}
+
+#endif
+
 #endif
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 203a2dae148..c5d7b0b4929 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -450,6 +450,25 @@ static inline void update_spsel(CPUARMState *env, uint32_t imm)
  */
 unsigned int arm_pamax(ARMCPU *cpu);
 
+/*
+ * round_down_to_parange_index
+ * @bit_size: uint8_t
+ *
+ * Rounds down the bit_size supplied to the first supported ARM physical
+ * address range and returns the index for this. The index is intended to
+ * be used to set ID_AA64MMFR0_EL1's PARANGE bits.
+ */
+uint8_t round_down_to_parange_index(uint8_t bit_size);
+
+/*
+ * round_down_to_parange_bit_size
+ * @bit_size: uint8_t
+ *
+ * Rounds down the bit_size supplied to the first supported ARM physical
+ * address range bit size and returns this.
+ */
+uint8_t round_down_to_parange_bit_size(uint8_t bit_size);
+
 /* Return true if extended addresses are enabled.
  * This is always the case if our translation regime is 64 bit,
  * but depends on TTBCR.EAE for 32 bit.
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index dbebf209f48..d60874d3e6b 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -53,6 +53,7 @@
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "gdbstub/enums.h"
+#include "hw/boards.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hvf.h"
 #include "sysemu/hvf_int.h"
@@ -319,8 +320,17 @@ static int hvf_accel_init(MachineState *ms)
     int x;
     hv_return_t ret;
     HVFState *s;
+    int pa_range = 36;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    ret = hvf_arch_vm_create(ms, 0);
+    if (mc->hvf_get_physical_address_range) {
+        pa_range = mc->hvf_get_physical_address_range(ms);
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
+    ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     assert_hvf_ok(ret);
 
     s = g_new0(HVFState, 1);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d284a602e82..8b2b991d978 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -66,6 +66,7 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/irq.h"
 #include "kvm_arm.h"
+#include "hvf_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
@@ -3034,7 +3035,35 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
 
 static int virt_hvf_get_physical_address_range(MachineState *ms)
 {
-    return 0;
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+
+    int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
+    int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
+
+    /* We freeze the memory map to compute the highest gpa */
+    virt_set_memmap(vms, max_ipa_size);
+
+    int requested_ipa_size = 64 - clz64(vms->highest_gpa);
+
+    /*
+     * If we're <= the default IPA size just use the default.
+     * If we're above the default but below the maximum, round up to
+     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only
+     * returns values that are valid ARM PARange values.
+     */
+    if (requested_ipa_size <= default_ipa_size) {
+        requested_ipa_size = default_ipa_size;
+    } else if (requested_ipa_size <= max_ipa_size) {
+        requested_ipa_size = max_ipa_size;
+    } else {
+        error_report("-m and ,maxmem option values "
+                     "require an IPA range (%d bits) larger than "
+                     "the one supported by the host (%d bits)",
+                     requested_ipa_size, max_ipa_size);
+        return -1;
+    }
+
+    return requested_ipa_size;
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 19964d241ed..6cea483d422 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -22,6 +22,7 @@
 #include <mach/mach_time.h>
 
 #include "exec/address-spaces.h"
+#include "hw/boards.h"
 #include "hw/irq.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
@@ -297,6 +298,8 @@ void hvf_arm_init_debug(void)
 
 static void hvf_wfi(CPUState *cpu);
 
+static uint32_t chosen_ipa_bit_size;
+
 typedef struct HVFVTimer {
     /* Vtimer value during migration and paused state */
     uint64_t vtimer_val;
@@ -839,6 +842,16 @@ static uint64_t hvf_get_reg(CPUState *cpu, int rt)
     return val;
 }
 
+static void clamp_id_aa64mmfr0_parange_to_ipa_size(uint64_t *id_aa64mmfr0)
+{
+    uint32_t ipa_size = chosen_ipa_bit_size ?
+            chosen_ipa_bit_size : hvf_arm_get_max_ipa_bit_size();
+
+    /* Clamp down the PARange to the IPA size the kernel supports. */
+    uint8_t index = round_down_to_parange_index(ipa_size);
+    *id_aa64mmfr0 = (*id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
+}
+
 static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     ARMISARegisters host_isar = {};
@@ -882,6 +895,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
     r |= hv_vcpu_destroy(fd);
 
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
+
     ahcf->isar = host_isar;
 
     /*
@@ -904,6 +919,30 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return r == HV_SUCCESS;
 }
 
+uint32_t hvf_arm_get_default_ipa_bit_size(void)
+{
+    uint32_t default_ipa_size;
+    hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
+    assert_hvf_ok(ret);
+
+    return default_ipa_size;
+}
+
+uint32_t hvf_arm_get_max_ipa_bit_size(void)
+{
+    uint32_t max_ipa_size;
+    hv_return_t ret = hv_vm_config_get_max_ipa_size(&max_ipa_size);
+    assert_hvf_ok(ret);
+
+    /*
+     * We clamp any IPA size we want to back the VM with to a valid PARange
+     * value so the guest doesn't try and map memory outside of the valid range.
+     * This logic just clamps the passed in IPA bit size to the first valid
+     * PARange value <= to it.
+     */
+    return round_down_to_parange_bit_size(max_ipa_size);
+}
+
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
     if (!arm_host_cpu_features.dtb_compatible) {
@@ -931,8 +970,18 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
+    hv_return_t ret;
     hv_vm_config_t config = hv_vm_config_create();
-    hv_return_t ret = hv_vm_create(config);
+
+    ret = hv_vm_config_set_ipa_size(config, pa_range);
+    if (ret != HV_SUCCESS) {
+        goto cleanup;
+    }
+    chosen_ipa_bit_size = pa_range;
+
+    ret = hv_vm_create(config);
+
+cleanup:
     os_release(config);
 
     return ret;
@@ -1004,6 +1053,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               &arm_cpu->isar.id_aa64mmfr0);
     assert_hvf_ok(ret);
 
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar.id_aa64mmfr0);
+    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
+                              arm_cpu->isar.id_aa64mmfr0);
+    assert_hvf_ok(ret);
+
     return 0;
 }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 278004661bf..defd6b84de6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -96,6 +96,21 @@ static const uint8_t pamax_map[] = {
     [6] = 52,
 };
 
+uint8_t round_down_to_parange_index(uint8_t bit_size)
+{
+    for (int i = ARRAY_SIZE(pamax_map) - 1; i >= 0; i--) {
+        if (pamax_map[i] <= bit_size) {
+            return i;
+        }
+    }
+    g_assert_not_reached();
+}
+
+uint8_t round_down_to_parange_bit_size(uint8_t bit_size)
+{
+    return pamax_map[round_down_to_parange_index(bit_size)];
+}
+
 /*
  * The cpu-specific constant value of PAMax; also used by hw/arm/virt.
  * Note that machvirt_init calls this on a CPU that is inited but not realized!
-- 
2.34.1


