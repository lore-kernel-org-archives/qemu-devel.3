Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE62CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEQC-00060J-6p; Thu, 01 Oct 2026 06:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xCEPK-0005dk-2F; Thu, 01 Oct 2026 06:52:58 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xCEPI-0002PZ-6G; Thu, 01 Oct 2026 06:52:57 -0400
Received: from localhost (unknown [131.107.1.165])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4501520B716B;
 Thu,  1 Oct 2026 03:52:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4501520B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790851920;
 bh=VUi4mhmOj2SX7mZK32XO+03lc0VjNpBSAoUREVNFH+4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lOQxxG/tn7pPdL9PXCTwjWNmdkE9wVtN8+lLSRK+p5pCiltnmKHaFQjbCDDbej4St
 jk2rXhFV8+a2h62SKIAp4JoczWoViZMFpNo07nl9kOXRqRAZtohOZcJaVUEOSwz+f9
 eGQG9rB/XWaPSWUoUWoe7aTKU8/I9TsQ7pfG77og=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 01 Oct 2026 10:52:50 +0000
Subject: [PATCH v6 05/14] target/arm/mshv: implement vcpu state operations
 for ARM64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-mshv_accel_arm64_supp-v6-5-aefe5e76a0e3@linux.microsoft.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
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

Add support for reading and writing ARM64 CPU registers in the MSHV
accelerator. This includes functions to set and get registers,
initialize and destroy VCPU state, and manage register state
synchronization between QEMU and hypervisor.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h |  42 +++++++++++++++
 target/arm/mshv/mshv-all.c     | 119 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index a5527d49cf..b5bcea353a 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -32,6 +32,46 @@ typedef enum hv_register_name {
     HV_REGISTER_PENDING_EVENT0       = 0x00010004,
     HV_REGISTER_PENDING_EVENT1       = 0x00010005,
 
+#if defined(__aarch64__)
+    HV_ARM64_REGISTER_XZR   = 0x0002FFFE,
+    HV_ARM64_REGISTER_X0    = 0x00020000,
+    HV_ARM64_REGISTER_X1    = 0x00020001,
+    HV_ARM64_REGISTER_X2    = 0x00020002,
+    HV_ARM64_REGISTER_X3    = 0x00020003,
+    HV_ARM64_REGISTER_X4    = 0x00020004,
+    HV_ARM64_REGISTER_X5    = 0x00020005,
+    HV_ARM64_REGISTER_X6    = 0x00020006,
+    HV_ARM64_REGISTER_X7    = 0x00020007,
+    HV_ARM64_REGISTER_X8    = 0x00020008,
+    HV_ARM64_REGISTER_X9    = 0x00020009,
+    HV_ARM64_REGISTER_X10   = 0x0002000A,
+    HV_ARM64_REGISTER_X11   = 0x0002000B,
+    HV_ARM64_REGISTER_X12   = 0x0002000C,
+    HV_ARM64_REGISTER_X13   = 0x0002000D,
+    HV_ARM64_REGISTER_X14   = 0x0002000E,
+    HV_ARM64_REGISTER_X15   = 0x0002000F,
+    HV_ARM64_REGISTER_X16   = 0x00020010,
+    HV_ARM64_REGISTER_X17   = 0x00020011,
+    HV_ARM64_REGISTER_X18   = 0x00020012,
+    HV_ARM64_REGISTER_X19   = 0x00020013,
+    HV_ARM64_REGISTER_X20   = 0x00020014,
+    HV_ARM64_REGISTER_X21   = 0x00020015,
+    HV_ARM64_REGISTER_X22   = 0x00020016,
+    HV_ARM64_REGISTER_X23   = 0x00020017,
+    HV_ARM64_REGISTER_X24   = 0x00020018,
+    HV_ARM64_REGISTER_X25   = 0x00020019,
+    HV_ARM64_REGISTER_X26   = 0x0002001A,
+    HV_ARM64_REGISTER_X27   = 0x0002001B,
+    HV_ARM64_REGISTER_X28   = 0x0002001C,
+    HV_ARM64_REGISTER_FP    = 0x0002001D,
+    HV_ARM64_REGISTER_LR    = 0x0002001E,
+    HV_ARM64_REGISTER_PC    = 0x00020022,
+
+    /* AArch64 System Register Descriptions: General system control registers */
+    HV_ARM64_REGISTER_MIDR_EL1   = 0x00040051,
+    HV_ARM64_REGISTER_MPIDR_EL1  = 0x00040001,
+
+#elif defined(__x86_64__)
     /* X64 User-Mode Registers */
     HV_X64_REGISTER_RAX     = 0x00020000,
     HV_X64_REGISTER_RCX     = 0x00020001,
@@ -188,6 +228,8 @@ typedef enum hv_register_name {
     /* Other MSRs */
     HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
 
+#endif
+
     /* Misc */
     HV_X64_REGISTER_HYPERCALL       = 0x00090001,
     HV_REGISTER_GUEST_OS_ID         = 0x00090002,
diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
index 00c54f5d66..29dd45a123 100644
--- a/target/arm/mshv/mshv-all.c
+++ b/target/arm/mshv/mshv-all.c
@@ -10,17 +10,128 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "qemu/error-report.h"
+#include "qemu/memalign.h"
 #include "hw/arm/virt.h"
+
+#include "system/cpus.h"
+#include "target/arm/cpu.h"
+
 #include "system/mshv.h"
 #include "system/mshv_int.h"
+#include "hw/hyperv/hvgdk_mini.h"
+
+static const enum hv_register_name STANDARD_REGISTER_NAMES[32] = {
+    HV_ARM64_REGISTER_X0,
+    HV_ARM64_REGISTER_X1,
+    HV_ARM64_REGISTER_X2,
+    HV_ARM64_REGISTER_X3,
+    HV_ARM64_REGISTER_X4,
+    HV_ARM64_REGISTER_X5,
+    HV_ARM64_REGISTER_X6,
+    HV_ARM64_REGISTER_X7,
+    HV_ARM64_REGISTER_X8,
+    HV_ARM64_REGISTER_X9,
+    HV_ARM64_REGISTER_X10,
+    HV_ARM64_REGISTER_X11,
+    HV_ARM64_REGISTER_X12,
+    HV_ARM64_REGISTER_X13,
+    HV_ARM64_REGISTER_X14,
+    HV_ARM64_REGISTER_X15,
+    HV_ARM64_REGISTER_X16,
+    HV_ARM64_REGISTER_X17,
+    HV_ARM64_REGISTER_X18,
+    HV_ARM64_REGISTER_X19,
+    HV_ARM64_REGISTER_X20,
+    HV_ARM64_REGISTER_X21,
+    HV_ARM64_REGISTER_X22,
+    HV_ARM64_REGISTER_X23,
+    HV_ARM64_REGISTER_X24,
+    HV_ARM64_REGISTER_X25,
+    HV_ARM64_REGISTER_X26,
+    HV_ARM64_REGISTER_X27,
+    HV_ARM64_REGISTER_X28,
+    HV_ARM64_REGISTER_FP,
+    HV_ARM64_REGISTER_LR,
+    HV_ARM64_REGISTER_PC,
+};
+
+static int set_standard_regs(const CPUState *cpu)
+{
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+    struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)] = {};
+    int ret;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+
+    for (size_t i = 0; i < n_regs - 1; i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+        assocs[i].value.reg64 = env->xregs[i];
+    }
+
+    /* Last register is the program counter */
+    assocs[n_regs - 1].name = STANDARD_REGISTER_NAMES[n_regs - 1];
+    assocs[n_regs - 1].value.reg64 = env->pc;
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set standard registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int get_standard_regs(CPUState *cpu)
+{
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+    struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)] = {};
+    int ret;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get standard registers");
+        return -1;
+    }
+
+    for (size_t i = 0; i < n_regs - 1; i++) {
+        env->xregs[i] = assocs[i].value.reg64;
+    }
+    env->pc = assocs[n_regs - 1].value.reg64;
+
+    return 0;
+}
 
 static int load_regs(CPUState *cpu)
 {
+    int ret;
+
+    ret = get_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load standard registers");
+        return -1;
+    }
+
     return 0;
 }
 
 static int store_regs(const CPUState *cpu)
 {
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store standard registers");
+        return -1;
+    }
+
     return 0;
 }
 
@@ -41,12 +152,20 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
 void mshv_arch_init_vcpu(CPUState *cpu)
 {
+    AccelCPUState *state = cpu->accel;
 
+    mshv_setup_hvcall_args(state);
 }
 
 void mshv_arch_destroy_vcpu(CPUState *cpu)
 {
+    AccelCPUState *state = cpu->accel;
+
+    if (state->hvcall_args.base) {
+        qemu_vfree(state->hvcall_args.base);
+    }
 
+    state->hvcall_args = (MshvHvCallArgs){0};
 }
 
 int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd)

-- 
2.45.4


