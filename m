Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD166C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbY-0000KF-4m; Fri, 21 Feb 2025 09:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWl-0006ST-Gm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:56 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWg-00016C-9i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:54 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id CA20D204E5BE; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA20D204E5BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=TE9ju8Gk3DR1YdZvKVR7DhBrIHHXhv15wRt1POD51PI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=maJ6C1WDo65MrXqUB1mhpmYHraRrvD5k9JAcRsm1/YOKNng7gybp7cBUsbzCCrb8s
 PJ86ELr9GGqAPd07MBBdwpqusiry+xo8xkyc45Q5p/BZsmYsJ8Ch1tXXqQQ7DYHaUX
 fJIgKpAK/OVsI7nfuA2RdEBc0d2SFVEgmWfmWYEE=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 11/19] target/i386/hvf: move and rename simulate_{rdmsr, wrmsr}
Date: Fri, 21 Feb 2025 00:36:19 -0800
Message-Id: <1740126987-8483-12-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:12 -0500
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

This requires making raise_exception non-static. That function needs to be
renamed to avoid clashing with a function in TCG.

Mostly code movement. No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf-i386.h |   2 +
 target/i386/hvf/hvf.c      | 216 +++++++++++++++++++++++++++++++++++-
 target/i386/hvf/x86_emu.c  | 220 +------------------------------------
 target/i386/hvf/x86_emu.h  |   4 +-
 4 files changed, 221 insertions(+), 221 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 046b681d13..044ad236ae 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,6 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
+void hvf_simulate_rdmsr(CPUX86State *env);
+void hvf_simulate_wrmsr(CPUX86State *env);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e108e2bbe6..88f5487b45 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -506,6 +506,218 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
+void hvf_simulate_rdmsr(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t msr = ECX(env);
+    uint64_t val = 0;
+
+    switch (msr) {
+    case MSR_IA32_TSC:
+        val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
+        break;
+    case MSR_IA32_APICBASE:
+        val = cpu_get_apic_base(cpu->apic_state);
+        break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_read(index, &val);
+        if (ret < 0) {
+            x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
+    case MSR_IA32_UCODE_REV:
+        val = cpu->ucode_rev;
+        break;
+    case MSR_EFER:
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
+        break;
+    case MSR_FSBASE:
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE);
+        break;
+    case MSR_GSBASE:
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE);
+        break;
+    case MSR_KERNELGSBASE:
+        val = rvmcs(cs->accel->fd, VMCS_HOST_FS_BASE);
+        break;
+    case MSR_STAR:
+        abort();
+        break;
+    case MSR_LSTAR:
+        abort();
+        break;
+    case MSR_CSTAR:
+        abort();
+        break;
+    case MSR_IA32_MISC_ENABLE:
+        val = env->msr_ia32_misc_enable;
+        break;
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask;
+        break;
+    case MSR_MTRRfix64K_00000:
+        val = env->mtrr_fixed[0];
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1];
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3];
+        break;
+    case MSR_MTRRdefType:
+        val = env->mtrr_deftype;
+        break;
+    case MSR_CORE_THREAD_COUNT:
+        val = cpu_x86_get_msr_core_thread_count(cpu);
+        break;
+    default:
+        /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
+        val = 0;
+        break;
+    }
+
+    RAX(env) = (uint32_t)val;
+    RDX(env) = (uint32_t)(val >> 32);
+}
+
+void hvf_simulate_wrmsr(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t msr = ECX(env);
+    uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
+
+    switch (msr) {
+    case MSR_IA32_TSC:
+        break;
+    case MSR_IA32_APICBASE: {
+        int r;
+
+        r = cpu_set_apic_base(cpu->apic_state, data);
+        if (r < 0) {
+            x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        ret = apic_msr_write(index, data);
+        if (ret < 0) {
+            x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+        }
+
+        break;
+    }
+    case MSR_FSBASE:
+        wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
+        break;
+    case MSR_GSBASE:
+        wvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE, data);
+        break;
+    case MSR_KERNELGSBASE:
+        wvmcs(cs->accel->fd, VMCS_HOST_FS_BASE, data);
+        break;
+    case MSR_STAR:
+        abort();
+        break;
+    case MSR_LSTAR:
+        abort();
+        break;
+    case MSR_CSTAR:
+        abort();
+        break;
+    case MSR_EFER:
+        /*printf("new efer %llx\n", EFER(cs));*/
+        wvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER, data);
+        if (data & MSR_EFER_NXE) {
+            hv_vcpu_invalidate_tlb(cs->accel->fd);
+        }
+        break;
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base = data;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask = data;
+        break;
+    case MSR_MTRRfix64K_00000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix64K_00000] = data;
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1] = data;
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3] = data;
+        break;
+    case MSR_MTRRdefType:
+        env->mtrr_deftype = data;
+        break;
+    default:
+        break;
+    }
+
+    /* Related to support known hypervisor interface */
+    /* if (g_hypervisor_iface)
+         g_hypervisor_iface->wrmsr_handler(cs, msr, data);
+
+    printf("write msr %llx\n", RCX(cs));*/
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -688,9 +900,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         {
             hvf_load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
-                simulate_rdmsr(env);
+                hvf_simulate_rdmsr(env);
             } else {
-                simulate_wrmsr(env);
+                hvf_simulate_wrmsr(env);
             }
             env->eip += ins_len;
             hvf_store_regs(cpu);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index ef4b77b10e..b6e63daea4 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -44,6 +44,7 @@
 #include "x86_flags.h"
 #include "vmcs.h"
 #include "vmx.h"
+#include "hvf-i386.h"
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
@@ -661,8 +662,7 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void raise_exception(CPUX86State *env, int exception_index,
-                            int error_code)
+void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code)
 {
     env->exception_nr = exception_index;
     env->error_code = error_code;
@@ -670,227 +670,15 @@ static void raise_exception(CPUX86State *env, int exception_index,
     env->exception_injected = 1;
 }
 
-void simulate_rdmsr(CPUX86State *env)
-{
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-    uint32_t msr = ECX(env);
-    uint64_t val = 0;
-
-    switch (msr) {
-    case MSR_IA32_TSC:
-        val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
-        break;
-    case MSR_IA32_APICBASE:
-        val = cpu_get_apic_base(cpu->apic_state);
-        break;
-    case MSR_APIC_START ... MSR_APIC_END: {
-        int ret;
-        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-
-        ret = apic_msr_read(index, &val);
-        if (ret < 0) {
-            raise_exception(env, EXCP0D_GPF, 0);
-        }
-
-        break;
-    }
-    case MSR_IA32_UCODE_REV:
-        val = cpu->ucode_rev;
-        break;
-    case MSR_EFER:
-        val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
-        break;
-    case MSR_FSBASE:
-        val = rvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE);
-        break;
-    case MSR_GSBASE:
-        val = rvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE);
-        break;
-    case MSR_KERNELGSBASE:
-        val = rvmcs(cs->accel->fd, VMCS_HOST_FS_BASE);
-        break;
-    case MSR_STAR:
-        abort();
-        break;
-    case MSR_LSTAR:
-        abort();
-        break;
-    case MSR_CSTAR:
-        abort();
-        break;
-    case MSR_IA32_MISC_ENABLE:
-        val = env->msr_ia32_misc_enable;
-        break;
-    case MSR_MTRRphysBase(0):
-    case MSR_MTRRphysBase(1):
-    case MSR_MTRRphysBase(2):
-    case MSR_MTRRphysBase(3):
-    case MSR_MTRRphysBase(4):
-    case MSR_MTRRphysBase(5):
-    case MSR_MTRRphysBase(6):
-    case MSR_MTRRphysBase(7):
-        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base;
-        break;
-    case MSR_MTRRphysMask(0):
-    case MSR_MTRRphysMask(1):
-    case MSR_MTRRphysMask(2):
-    case MSR_MTRRphysMask(3):
-    case MSR_MTRRphysMask(4):
-    case MSR_MTRRphysMask(5):
-    case MSR_MTRRphysMask(6):
-    case MSR_MTRRphysMask(7):
-        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask;
-        break;
-    case MSR_MTRRfix64K_00000:
-        val = env->mtrr_fixed[0];
-        break;
-    case MSR_MTRRfix16K_80000:
-    case MSR_MTRRfix16K_A0000:
-        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1];
-        break;
-    case MSR_MTRRfix4K_C0000:
-    case MSR_MTRRfix4K_C8000:
-    case MSR_MTRRfix4K_D0000:
-    case MSR_MTRRfix4K_D8000:
-    case MSR_MTRRfix4K_E0000:
-    case MSR_MTRRfix4K_E8000:
-    case MSR_MTRRfix4K_F0000:
-    case MSR_MTRRfix4K_F8000:
-        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3];
-        break;
-    case MSR_MTRRdefType:
-        val = env->mtrr_deftype;
-        break;
-    case MSR_CORE_THREAD_COUNT:
-        val = cpu_x86_get_msr_core_thread_count(cpu);
-        break;
-    default:
-        /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
-        val = 0;
-        break;
-    }
-
-    RAX(env) = (uint32_t)val;
-    RDX(env) = (uint32_t)(val >> 32);
-}
-
 static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_rdmsr(env);
+    hvf_simulate_rdmsr(env);
     env->eip += decode->len;
 }
 
-void simulate_wrmsr(CPUX86State *env)
-{
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-    uint32_t msr = ECX(env);
-    uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
-
-    switch (msr) {
-    case MSR_IA32_TSC:
-        break;
-    case MSR_IA32_APICBASE: {
-        int r;
-
-        r = cpu_set_apic_base(cpu->apic_state, data);
-        if (r < 0) {
-            raise_exception(env, EXCP0D_GPF, 0);
-        }
-
-        break;
-    }
-    case MSR_APIC_START ... MSR_APIC_END: {
-        int ret;
-        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-
-        ret = apic_msr_write(index, data);
-        if (ret < 0) {
-            raise_exception(env, EXCP0D_GPF, 0);
-        }
-
-        break;
-    }
-    case MSR_FSBASE:
-        wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
-        break;
-    case MSR_GSBASE:
-        wvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE, data);
-        break;
-    case MSR_KERNELGSBASE:
-        wvmcs(cs->accel->fd, VMCS_HOST_FS_BASE, data);
-        break;
-    case MSR_STAR:
-        abort();
-        break;
-    case MSR_LSTAR:
-        abort();
-        break;
-    case MSR_CSTAR:
-        abort();
-        break;
-    case MSR_EFER:
-        /*printf("new efer %llx\n", EFER(cs));*/
-        wvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER, data);
-        if (data & MSR_EFER_NXE) {
-            hv_vcpu_invalidate_tlb(cs->accel->fd);
-        }
-        break;
-    case MSR_MTRRphysBase(0):
-    case MSR_MTRRphysBase(1):
-    case MSR_MTRRphysBase(2):
-    case MSR_MTRRphysBase(3):
-    case MSR_MTRRphysBase(4):
-    case MSR_MTRRphysBase(5):
-    case MSR_MTRRphysBase(6):
-    case MSR_MTRRphysBase(7):
-        env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base = data;
-        break;
-    case MSR_MTRRphysMask(0):
-    case MSR_MTRRphysMask(1):
-    case MSR_MTRRphysMask(2):
-    case MSR_MTRRphysMask(3):
-    case MSR_MTRRphysMask(4):
-    case MSR_MTRRphysMask(5):
-    case MSR_MTRRphysMask(6):
-    case MSR_MTRRphysMask(7):
-        env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask = data;
-        break;
-    case MSR_MTRRfix64K_00000:
-        env->mtrr_fixed[ECX(env) - MSR_MTRRfix64K_00000] = data;
-        break;
-    case MSR_MTRRfix16K_80000:
-    case MSR_MTRRfix16K_A0000:
-        env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1] = data;
-        break;
-    case MSR_MTRRfix4K_C0000:
-    case MSR_MTRRfix4K_C8000:
-    case MSR_MTRRfix4K_D0000:
-    case MSR_MTRRfix4K_D8000:
-    case MSR_MTRRfix4K_E0000:
-    case MSR_MTRRfix4K_E8000:
-    case MSR_MTRRfix4K_F0000:
-    case MSR_MTRRfix4K_F8000:
-        env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3] = data;
-        break;
-    case MSR_MTRRdefType:
-        env->mtrr_deftype = data;
-        break;
-    default:
-        break;
-    }
-
-    /* Related to support known hypervisor interface */
-    /* if (g_hypervisor_iface)
-         g_hypervisor_iface->wrmsr_handler(cs, msr, data);
-
-    printf("write msr %llx\n", RCX(cs));*/
-}
-
 static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_wrmsr(env);
+    hvf_simulate_wrmsr(env);
     env->eip += decode->len;
 }
 
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index a1d1dc7d74..107c1f1ac8 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -36,9 +36,7 @@ extern const struct x86_emul_ops *emul_ops;
 
 void init_emu(const struct x86_emul_ops *ops);
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
-
-void simulate_rdmsr(CPUX86State *env);
-void simulate_wrmsr(CPUX86State *env);
+void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code);
 
 target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
-- 
2.39.5 (Apple Git-154)


