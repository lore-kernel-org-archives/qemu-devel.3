Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43A0112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LKL-00017J-6e; Wed, 11 Mar 2026 11:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LK5-0000fr-NW; Wed, 11 Mar 2026 11:18:10 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LK3-0000qj-P3; Wed, 11 Mar 2026 11:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773242195; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JR9U6XAFyHqi1///6+JcGCF6OFfcV9FEQekiaWkWluMv26HDEh8834tL1YrKEy+sCwDwuTcgbRrF9fMcBzK6WiioViJBJzeUt4WnM2wE1EByDqPYj12I4WCcZvoHtAuSMGgX7mGuX8a/RBwEeJuULKGOajquXMzJqi325On+EXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773242195;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DQPrzDw9ATjXXkE9Mjp3ep5LZQ8/VriMYtEggoGcNoo=; 
 b=jOTdBXO4E0pQGoQqFqekARD4Jmc1rl8O8F0Rxsa2zHBSw8bY6omhoNLY/XpC2fV7xECHix1VbuLAeg3suybxlFabv+65copX/3B3XlhxiZqdMTpheolzpK600HZ1nGHlDO45xne4bKAzBgZJFsr7u9DWIZTu7w1qhV6vPrRxfhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773242195; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=DQPrzDw9ATjXXkE9Mjp3ep5LZQ8/VriMYtEggoGcNoo=;
 b=rFtBYT6nN5d1rEva07DzBSJjKNYmWhoQdcFR8Jqi7AYWlkN1fb85YvdtWXxuCDTN
 Kv+sKQ1TUOZZkupdJ1qoKLlnsZui1pn88xCyMykLw51rD1A3SeL89MNRrvbl1weq7kE
 ZV2nkIy0xKOrbvMLQDWDVAMXsWh1g+wp0wIieU08=
Received: by mx.zohomail.com with SMTPS id 1773242193301229.18556215065826;
 Wed, 11 Mar 2026 08:16:33 -0700 (PDT)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
Date: Wed, 11 Mar 2026 15:15:32 +0000
Subject: [PATCH 05/14] target/arm/mshv: implement vcpu state operations for
 ARM64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-mshv_accel_arm64_supp-v1-5-c31699b7bc1f@anirudhrb.com>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Aastha Rawat <aastharawat@linux.microsoft.com>

Add support for reading and writing ARM64 CPU registers in the MSHV
accelerator. This includes functions to set and get registers,
initialize and destroy VCPU state, and manage register state
synchronization between QEMU and hypervisor.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h |  42 +++++++++++++
 target/arm/mshv/mshv-all.c     | 138 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index cb52cc9de2..dfe94050f4 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -13,6 +13,46 @@ typedef enum hv_register_name {
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
 
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
@@ -157,6 +197,8 @@ typedef enum hv_register_name {
     /* Other MSRs */
     HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
 
+#endif
+
     /* Misc */
     HV_REGISTER_GUEST_OS_ID         = 0x00090002,
     HV_REGISTER_REFERENCE_TSC       = 0x00090017,
diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
index 1c82e2c593..ad9cb267a8 100644
--- a/target/arm/mshv/mshv-all.c
+++ b/target/arm/mshv/mshv-all.c
@@ -9,16 +9,146 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "qemu/error-report.h"
+#include "qemu/memalign.h"
+
+#include "system/cpus.h"
+#include "target/arm/cpu.h"
+
 #include "system/mshv.h"
 #include "system/mshv_int.h"
+#include "hw/hyperv/hvgdk_mini.h"
+
+static enum hv_register_name STANDARD_REGISTER_NAMES[32] = {
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
+    struct hv_register_assoc *assocs;
+    int ret;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+
+    assocs = g_new0(hv_register_assoc, n_regs);
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
+        g_free(assocs);
+        return -1;
+    }
+
+    g_free(assocs);
+
+    return 0;
+}
+
+static void populate_standard_regs(const hv_register_assoc *assocs,
+                                   CPUARMState *env)
+{
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs - 1; i++) {
+        env->xregs[i] = assocs[i].value.reg64;
+    }
+
+    /* Last register is the program counter */
+    env->pc = assocs[n_regs - 1].value.reg64;
+}
 
 int mshv_load_regs(CPUState *cpu)
 {
+    int ret;
+
+    ret = mshv_get_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load standard registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+int mshv_get_standard_regs(CPUState *cpu)
+{
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+    struct hv_register_assoc *assocs;
+    int ret;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+
+    assocs = g_new0(hv_register_assoc, n_regs);
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get standard registers");
+        g_free(assocs);
+        return -1;
+    }
+
+    populate_standard_regs(assocs, env);
+
+    g_free(assocs);
     return 0;
 }
 
 int mshv_arch_put_registers(const CPUState *cpu)
 {
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -29,12 +159,20 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
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
 
 void mshv_init_mmio_emu(void)

-- 
2.43.0


