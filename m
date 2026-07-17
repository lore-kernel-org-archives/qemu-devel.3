Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D90C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfnX-0005wV-7Q; Fri, 17 Jul 2026 06:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfnU-0005vv-UW; Fri, 17 Jul 2026 06:28:01 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfnT-0000P7-8I; Fri, 17 Jul 2026 06:28:00 -0400
Received: from localhost (unknown [131.107.159.8])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3122720B7178;
 Fri, 17 Jul 2026 03:27:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3122720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784284048;
 bh=OGGpowXvVwpFoT6iKc2B4BLya9B2Y4TG8FXlisamEn0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VupK1EmAmw/GnlsuwxHsCLLaHjJZmEKhHf1NLtotrs/ZaXsikPdT5rupRWAUg5FUm
 lHF1kT2JDHBZcJD2vdUXMIcacPrf3SdpbX+kZy7UcSc5Mr6rGoMAxtsSt1D7MKHqNO
 C6Qm7hJhf4TjyCMPZ5mqI459H31TTnP4dQxI8or4=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Fri, 17 Jul 2026 10:27:25 +0000
Subject: [PATCH v5 10/13] target/arm/mshv: add vCPU run loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mshv_accel_arm64_supp-v5-10-ef07d4c6b337@linux.microsoft.com>
References: <20260717-mshv_accel_arm64_supp-v5-0-ef07d4c6b337@linux.microsoft.com>
In-Reply-To: <20260717-mshv_accel_arm64_supp-v5-0-ef07d4c6b337@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
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

Add the main vCPU run loop for MSHV using the MSHV_RUN_VP_IOCTL.

Handle MMIO exits by emulating the instruction using the syndrome
information from ESR_EL2.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 include/hw/hyperv/hvgdk_mini.h |  44 +++++++++++++++++
 target/arm/mshv/mshv-all.c     | 107 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index fc014aa5d7..63f05b01a6 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -892,6 +892,50 @@ struct hv_x64_memory_intercept_message {
     uint8_t instruction_bytes[16];
 } QEMU_PACKED;
 
+union hv_arm64_vp_execution_state {
+    uint16_t as_uint16;
+    struct {
+        uint16_t cpl:2;
+        uint16_t debug_active:1;
+        uint16_t interruption_pending:1;
+        uint16_t vtl:4;
+        uint16_t virtualization_fault_active:1;
+        uint16_t reserved:7;
+    };
+};
+
+struct hv_arm64_intercept_message_header {
+    uint32_t vp_index;
+    uint8_t instruction_length;
+    uint8_t intercept_access_type;
+    union hv_arm64_vp_execution_state execution_state;
+    uint64_t pc;
+    uint64_t cpsr;
+};
+
+union hv_arm64_memory_access_info {
+    uint8_t as_uint8;
+    struct {
+        uint8_t gva_valid:1;
+        uint8_t gva_gpa_valid:1;
+        uint8_t hypercall_output_pending:1;
+        uint8_t reserved:5;
+    };
+};
+
+struct hv_arm64_memory_intercept_message {
+    struct hv_arm64_intercept_message_header header;
+    uint32_t cache_type; /* enum hv_cache_type */
+    uint8_t instruction_byte_count;
+    union hv_arm64_memory_access_info memory_access_info;
+    uint16_t reserved1;
+    uint8_t instruction_bytes[4];
+    uint32_t reserved2;
+    uint64_t guest_virtual_address;
+    uint64_t guest_physical_address;
+    uint64_t syndrome;
+};
+
 union hv_message_flags {
     uint8_t asu8;
     struct {
diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
index da43333aa6..6ec9811258 100644
--- a/target/arm/mshv/mshv-all.c
+++ b/target/arm/mshv/mshv-all.c
@@ -20,6 +20,7 @@
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
 #include "target/arm/mshv_arm.h"
+#include "target/arm/helper.h"
 
 #include "system/mshv.h"
 #include "system/mshv_int.h"
@@ -158,8 +159,114 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
     return store_regs(cpu);
 }
 
+static int set_memory_info(const struct hyperv_message *msg,
+                           struct hv_arm64_memory_intercept_message *info)
+{
+    if (msg->header.message_type != HVMSG_GPA_INTERCEPT
+            && msg->header.message_type != HVMSG_UNMAPPED_GPA
+            && msg->header.message_type != HVMSG_UNACCEPTED_GPA) {
+        error_report("invalid message type");
+        return -1;
+    }
+    memcpy(info, msg->payload, sizeof(*info));
+
+    return 0;
+}
+
+static uint64_t mshv_mmio_get_reg(CPUState *cpu, int reg_index)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    return reg_index < 31 ? env->xregs[reg_index] : 0ULL;
+}
+
+static void mshv_mmio_set_reg(CPUState *cpu, int reg_index, uint64_t val)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    if (reg_index < 31) {
+        env->xregs[reg_index] = val;
+    }
+}
+
+static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
+                               const struct hyperv_message *msg,
+                               MshvVmExit *exit_reason)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    struct hv_arm64_memory_intercept_message info = { 0 };
+    int ret;
+    EsrEl2 syndrome;
+
+    ret = set_memory_info(msg, &info);
+    if (ret < 0) {
+        error_report("failed to convert message to memory info");
+        return -1;
+    }
+
+    syndrome.raw = info.syndrome;
+
+    ret = load_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load registers");
+        return -1;
+    }
+
+    static const struct arm_emul_ops mshv_arm_emul_ops = {
+        .get_reg = mshv_mmio_get_reg,
+        .set_reg = mshv_mmio_set_reg,
+    };
+
+    ret = arm_emulate_mmio(cpu, syndrome, info.guest_physical_address,
+                           &mshv_arm_emul_ops);
+    if (ret < 0) {
+        error_report("Failed to emulate with syndrome");
+        return -1;
+    }
+
+    /* Advance PC past the faulting instruction */
+    env->pc += (syndrome.il == 1) ? 4 : 2;
+
+    ret = store_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store registers");
+        return -1;
+    }
+
+    *exit_reason = MshvVmExitIgnore;
+
+    return 0;
+}
+
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
+    int ret;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
+    if (ret < 0) {
+        *exit = MshvVmExitShutdown;
+        return ret;
+    }
+
+    switch (msg->header.message_type) {
+    case HVMSG_UNRECOVERABLE_EXCEPTION:
+        *exit = MshvVmExitShutdown;
+        break;
+    case HVMSG_GPA_INTERCEPT:
+    case HVMSG_UNMAPPED_GPA:
+        ret = handle_unmapped_mem(vm_fd, cpu, msg, exit);
+        if (ret < 0) {
+            error_report("failed to handle mmio");
+            return -1;
+        }
+        break;
+    default:
+        error_report("Unhandled message type: 0x%x", msg->header.message_type);
+        return -1;
+    }
+
     return 0;
 }
 

-- 
2.45.4


