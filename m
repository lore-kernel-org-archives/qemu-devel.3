Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272A0CF043B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNWT-0001Kz-SX; Tue, 08 Oct 2024 23:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNWQ-0001KN-Td; Tue, 08 Oct 2024 23:37:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNWN-0006L2-Lt; Tue, 08 Oct 2024 23:37:58 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdpp0wP3z6K6RV;
 Wed,  9 Oct 2024 11:36:34 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 8F806140A34;
 Wed,  9 Oct 2024 11:37:50 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:37:31 +0200
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
Subject: [PATCH RFC V4 30/33] target/arm/kvm,
 tcg: Handle SMCCC hypercall exits in VMM during PSCI_CPU_{ON, OFF}
Date: Wed, 9 Oct 2024 04:37:01 +0100
Message-ID: <20241009033704.250287-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

From: Author Salil Mehta <salil.mehta@huawei.com>

To support vCPU hotplug, we must trap any `HVC`/`SMC` `PSCI_CPU_{ON,OFF}`
hypercalls from the host KVM to QEMU for policy checks. This ensures the
following when a vCPU is brought online:

1. The vCPU is actually plugged in (i.e., present).
2. The vCPU is not disabled.

Implement the registration and handling of `HVC`/`SMC` hypercall exits within
the VMM, ensuring that proper policy checks and control flow are enforced during
the vCPU onlining and offlining processes.

Co-developed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/arm-powerctl.c   | 22 ++++++---
 target/arm/helper.c         |  2 +-
 target/arm/internals.h      | 11 -----
 target/arm/kvm.c            | 93 +++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h        | 14 ++++++
 target/arm/meson.build      |  1 +
 target/arm/{tcg => }/psci.c |  8 ++++
 target/arm/tcg/meson.build  |  4 --
 8 files changed, 132 insertions(+), 23 deletions(-)
 rename target/arm/{tcg => }/psci.c (97%)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 2b2055c6ac..03bb8e7b8a 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -17,6 +17,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/tcg.h"
 #include "target/arm/multiprocessing.h"
+#include "hw/boards.h"
 
 #ifndef DEBUG_ARM_POWERCTL
 #define DEBUG_ARM_POWERCTL 0
@@ -31,14 +32,14 @@
 
 CPUState *arm_get_cpu_by_id(uint64_t id)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cpu;
 
     DPRINTF("cpu %" PRId64 "\n", id);
 
-    CPU_FOREACH(cpu) {
-        ARMCPU *armcpu = ARM_CPU(cpu);
-
-        if (arm_cpu_mp_affinity(armcpu) == id) {
+    /* with vCPU hotplug support, we must now check for all possible vCPUs */
+    CPU_FOREACH_POSSIBLE(cpu, ms->possible_cpus) {
+        if (cpu && (arm_cpu_mp_affinity(ARM_CPU(cpu)) == id)) {
             return cpu;
         }
     }
@@ -119,9 +120,16 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
 
     /* Retrieve the cpu we are powering up */
     target_cpu_state = arm_get_cpu_by_id(cpuid);
-    if (!target_cpu_state) {
-        /* The cpu was not found */
-        return QEMU_ARM_POWERCTL_INVALID_PARAM;
+
+    if (!qemu_enabled_cpu(target_cpu_state)) {
+        /*
+         * The cpu is not plugged in or disabled. We should return appropriate
+         * value as introduced in DEN0022E PSCI 1.2 issue E
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[ARM]%s: Denying attempt to online removed/disabled "
+                      "CPU%" PRId64"\n", __func__, cpuid);
+        return QEMU_ARM_POWERCTL_IS_OFF;
     }
 
     target_cpu = ARM_CPU(target_cpu_state);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a890f98445..c121e3bc1a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11840,7 +11840,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                       env->exception.syndrome);
     }
 
-    if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
+    if (arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
         return;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 722c4dd00b..e9c3ae4494 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -501,21 +501,10 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs);
 
-#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
-static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
-{
-    return false;
-}
-static inline void arm_handle_psci_call(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-#else
 /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
-#endif
 
 /**
  * arm_clear_exclusive: clear the exclusive monitor
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 369d7ad135..9a51249a42 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -544,9 +544,51 @@ int kvm_arch_get_default_type(MachineState *ms)
     return fixed_ipa ? 0 : size;
 }
 
+static bool kvm_arm_set_vm_attr(struct kvm_device_attr *attr, const char *name)
+{
+    int err;
+
+    err = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    err = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    return true;
+}
+
+int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
+{
+    struct kvm_smccc_filter filter = {
+        .base = func,
+        .nr_functions = 1,
+        .action = faction,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VM_SMCCC_CTRL,
+        .attr = KVM_ARM_VM_SMCCC_FILTER,
+        .flags = 0,
+        .addr = (uintptr_t)&filter,
+    };
+
+    if (!kvm_arm_set_vm_attr(&attr, "SMCCC Filter")) {
+        error_report("failed to set SMCCC filter in KVM Host");
+        return -1;
+    }
+
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret = 0;
+
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -609,6 +651,22 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
+    /*
+     * To be able to handle PSCI CPU ON calls in QEMU, we need to install SMCCC
+     * filter in the Host KVM. This is required to support features like
+     * virtual CPU Hotplug on ARM platforms.
+     */
+    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN64_CPU_ON,
+                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("CPU On PSCI-to-user-space fwd filter install failed");
+        abort();
+    }
+    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN_CPU_OFF,
+                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("CPU Off PSCI-to-user-space fwd filter install failed");
+        abort();
+    }
+
     return ret;
 }
 
@@ -1452,6 +1510,38 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
     return false;
 }
 
+static int kvm_arm_handle_hypercall(CPUState *cs, struct kvm_run *run)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    kvm_cpu_synchronize_state(cs);
+
+    /*
+     * hard coding immediate to 0 as we dont expect non-zero value as of now
+     * This might change in future versions. Hence, KVM_GET_ONE_REG  could be
+     * used in such cases but it must be enhanced then only synchronize will
+     * also fetch ESR_EL2 value.
+     */
+    if (run->hypercall.flags == KVM_HYPERCALL_EXIT_SMC) {
+        cs->exception_index = EXCP_SMC;
+        env->exception.syndrome = syn_aa64_smc(0);
+    } else {
+        cs->exception_index = EXCP_HVC;
+        env->exception.syndrome = syn_aa64_hvc(0);
+    }
+    env->exception.target_el = 1;
+    bql_lock();
+    arm_cpu_do_interrupt(cs);
+    bql_unlock();
+
+    /*
+     * For PSCI, exit the kvm_run loop and process the work. Especially
+     * important if this was a CPU_OFF command and we can't return to the guest.
+     */
+    return EXCP_INTERRUPT;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1468,6 +1558,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_arm_handle_dabt_nisv(cpu, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
+    case KVM_EXIT_HYPERCALL:
+          ret = kvm_arm_handle_hypercall(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 0be7e896d2..b9c2b0f501 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -225,6 +225,15 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
+/**
+ * kvm_arm_set_smccc_filter
+ * @func: funcion
+ * @faction: SMCCC filter action(handle, deny, fwd-to-user) to be deployed
+ *
+ * Sets the ARMs SMC-CC filter in KVM Host for selective hypercall exits
+ */
+int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction);
+
 #else
 
 /*
@@ -294,6 +303,11 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+static inline int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 #endif
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb..3e9f704f35 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -23,6 +23,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
+  'psci.c',
   'ptw.c',
 ))
 
diff --git a/target/arm/tcg/psci.c b/target/arm/psci.c
similarity index 97%
rename from target/arm/tcg/psci.c
rename to target/arm/psci.c
index 51d2ca3d30..b3fcb85079 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/psci.c
@@ -21,7 +21,9 @@
 #include "exec/helper-proto.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "sysemu/runstate.h"
+#include "sysemu/tcg.h"
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
@@ -158,6 +160,11 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_0_1_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN64_CPU_SUSPEND:
+       if (!tcg_enabled()) {
+            warn_report("CPU suspend not supported in non-tcg mode");
+            break;
+       }
+#ifdef CONFIG_TCG
         /* Affinity levels are not supported in QEMU */
         if (param[1] & 0xfffe0000) {
             ret = QEMU_PSCI_RET_INVALID_PARAMS;
@@ -170,6 +177,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
             env->regs[0] = 0;
         }
         helper_wfi(env, 4);
+#endif
         break;
     case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
         switch (param[1]) {
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 508932a249..5b43c84c40 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -54,9 +54,5 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(files(
-  'psci.c',
-))
-
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
-- 
2.34.1


