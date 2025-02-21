Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E68C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbZ-0000Le-3Q; Fri, 21 Feb 2025 09:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWh-0006Qs-Mg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:52 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWc-00015K-VM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:50 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 88C5B204E5B9; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88C5B204E5B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=jjeIaG9DwJUKGnit+zJ24Cl1eykEKi5ZQF8GegV2KyI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bQwyujBGnas0Wqqqf6dkojES4XJovegEaVz9bXFfdPzYA5fkxgdHIS5XHa4cLQx9p
 1RgZWgEFZOJNDGcYgF21EMpe31HAC8fF99NSD+m+Oy7kJOYf6OZPqyWt05J22JcQfq
 xRQ6Yw8JVPRNy7M8ssPeCmv73VAxFJoUETQ/ks3o=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 06/19] target/i386/hvf: move and rename {load,
 store}_regs
Date: Fri, 21 Feb 2025 00:36:14 -0800
Message-Id: <1740126987-8483-7-git-send-email-liuwe@linux.microsoft.com>
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
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:11 -0500
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

They contain HVF specific code. Move them to a better location and
add "hvf_" prefix. Fix up all the call sites.

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf.c      | 71 +++++++++++++++++++++++++++++++-------
 target/i386/hvf/x86_emu.c  | 46 ------------------------
 target/i386/hvf/x86_emu.h  |  3 --
 target/i386/hvf/x86_task.c |  4 +--
 target/i386/hvf/x86hvf.h   |  3 ++
 5 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e1e7cc3b7d..3c306101f9 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -61,6 +61,7 @@
 #include "vmx.h"
 #include "x86.h"
 #include "x86_descr.h"
+#include "x86_flags.h"
 #include "x86_mmu.h"
 #include "x86_decode.h"
 #include "x86_emu.h"
@@ -452,6 +453,52 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
+void hvf_load_regs(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    int i = 0;
+    RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
+    RRX(env, R_EBX) = rreg(cs->accel->fd, HV_X86_RBX);
+    RRX(env, R_ECX) = rreg(cs->accel->fd, HV_X86_RCX);
+    RRX(env, R_EDX) = rreg(cs->accel->fd, HV_X86_RDX);
+    RRX(env, R_ESI) = rreg(cs->accel->fd, HV_X86_RSI);
+    RRX(env, R_EDI) = rreg(cs->accel->fd, HV_X86_RDI);
+    RRX(env, R_ESP) = rreg(cs->accel->fd, HV_X86_RSP);
+    RRX(env, R_EBP) = rreg(cs->accel->fd, HV_X86_RBP);
+    for (i = 8; i < 16; i++) {
+        RRX(env, i) = rreg(cs->accel->fd, HV_X86_RAX + i);
+    }
+
+    env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
+    rflags_to_lflags(env);
+    env->eip = rreg(cs->accel->fd, HV_X86_RIP);
+}
+
+void hvf_store_regs(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    int i = 0;
+    wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
+    wreg(cs->accel->fd, HV_X86_RBX, RBX(env));
+    wreg(cs->accel->fd, HV_X86_RCX, RCX(env));
+    wreg(cs->accel->fd, HV_X86_RDX, RDX(env));
+    wreg(cs->accel->fd, HV_X86_RSI, RSI(env));
+    wreg(cs->accel->fd, HV_X86_RDI, RDI(env));
+    wreg(cs->accel->fd, HV_X86_RBP, RBP(env));
+    wreg(cs->accel->fd, HV_X86_RSP, RSP(env));
+    for (i = 8; i < 16; i++) {
+        wreg(cs->accel->fd, HV_X86_RAX + i, RRX(env, i));
+    }
+
+    lflags_to_rflags(env);
+    wreg(cs->accel->fd, HV_X86_RFLAGS, env->eflags);
+    macvm_set_rip(cs, env->eip);
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -535,10 +582,10 @@ int hvf_vcpu_exec(CPUState *cpu)
             if (ept_emulation_fault(slot, gpa, exit_qual)) {
                 struct x86_decode decode;
 
-                load_regs(cpu);
+                hvf_load_regs(cpu);
                 decode_instruction(env, &decode);
                 exec_instruction(env, &decode);
-                store_regs(cpu);
+                hvf_store_regs(cpu);
                 break;
             }
             break;
@@ -553,7 +600,7 @@ int hvf_vcpu_exec(CPUState *cpu)
 
             if (!string && in) {
                 uint64_t val = 0;
-                load_regs(cpu);
+                hvf_load_regs(cpu);
                 hvf_handle_io(env_cpu(env), port, &val, 0, size, 1);
                 if (size == 1) {
                     AL(env) = val;
@@ -565,7 +612,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                     RAX(env) = (uint64_t)val;
                 }
                 env->eip += ins_len;
-                store_regs(cpu);
+                hvf_store_regs(cpu);
                 break;
             } else if (!string && !in) {
                 RAX(env) = rreg(cpu->accel->fd, HV_X86_RAX);
@@ -575,11 +622,11 @@ int hvf_vcpu_exec(CPUState *cpu)
             }
             struct x86_decode decode;
 
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             decode_instruction(env, &decode);
             assert(ins_len == decode.len);
             exec_instruction(env, &decode);
-            store_regs(cpu);
+            hvf_store_regs(cpu);
 
             break;
         }
@@ -632,21 +679,21 @@ int hvf_vcpu_exec(CPUState *cpu)
         case EXIT_REASON_RDMSR:
         case EXIT_REASON_WRMSR:
         {
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
                 simulate_rdmsr(env);
             } else {
                 simulate_wrmsr(env);
             }
             env->eip += ins_len;
-            store_regs(cpu);
+            hvf_store_regs(cpu);
             break;
         }
         case EXIT_REASON_CR_ACCESS: {
             int cr;
             int reg;
 
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             cr = exit_qual & 15;
             reg = (exit_qual >> 8) & 15;
 
@@ -674,16 +721,16 @@ int hvf_vcpu_exec(CPUState *cpu)
                 abort();
             }
             env->eip += ins_len;
-            store_regs(cpu);
+            hvf_store_regs(cpu);
             break;
         }
         case EXIT_REASON_APIC_ACCESS: { /* TODO */
             struct x86_decode decode;
 
-            load_regs(cpu);
+            hvf_load_regs(cpu);
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
-            store_regs(cpu);
+            hvf_store_regs(cpu);
             break;
         }
         case EXIT_REASON_TPR: {
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 96447ea2c0..2fb54e1f1e 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -1454,52 +1454,6 @@ static void init_cmd_handler(void)
     }
 }
 
-void load_regs(CPUState *cs)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    int i = 0;
-    RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
-    RRX(env, R_EBX) = rreg(cs->accel->fd, HV_X86_RBX);
-    RRX(env, R_ECX) = rreg(cs->accel->fd, HV_X86_RCX);
-    RRX(env, R_EDX) = rreg(cs->accel->fd, HV_X86_RDX);
-    RRX(env, R_ESI) = rreg(cs->accel->fd, HV_X86_RSI);
-    RRX(env, R_EDI) = rreg(cs->accel->fd, HV_X86_RDI);
-    RRX(env, R_ESP) = rreg(cs->accel->fd, HV_X86_RSP);
-    RRX(env, R_EBP) = rreg(cs->accel->fd, HV_X86_RBP);
-    for (i = 8; i < 16; i++) {
-        RRX(env, i) = rreg(cs->accel->fd, HV_X86_RAX + i);
-    }
-
-    env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
-    rflags_to_lflags(env);
-    env->eip = rreg(cs->accel->fd, HV_X86_RIP);
-}
-
-void store_regs(CPUState *cs)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-
-    int i = 0;
-    wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
-    wreg(cs->accel->fd, HV_X86_RBX, RBX(env));
-    wreg(cs->accel->fd, HV_X86_RCX, RCX(env));
-    wreg(cs->accel->fd, HV_X86_RDX, RDX(env));
-    wreg(cs->accel->fd, HV_X86_RSI, RSI(env));
-    wreg(cs->accel->fd, HV_X86_RDI, RDI(env));
-    wreg(cs->accel->fd, HV_X86_RBP, RBP(env));
-    wreg(cs->accel->fd, HV_X86_RSP, RSP(env));
-    for (i = 8; i < 16; i++) {
-        wreg(cs->accel->fd, HV_X86_RAX + i, RRX(env, i));
-    }
-
-    lflags_to_rflags(env);
-    wreg(cs->accel->fd, HV_X86_RFLAGS, env->eflags);
-    macvm_set_rip(cs, env->eip);
-}
-
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     /*if (hvf_vcpu_id(cs))
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 8f4f8f1eca..ebad7df1cc 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -34,9 +34,6 @@ extern const struct x86_emul_ops *emul_ops;
 void init_emu(const struct x86_emul_ops *ops);
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
 
-void load_regs(CPUState *cpu);
-void store_regs(CPUState *cpu);
-
 void simulate_rdmsr(CPUX86State *env);
 void simulate_wrmsr(CPUX86State *env);
 
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 287fe11cf7..161217991f 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -119,7 +119,7 @@ void vmx_handle_task_switch(CPUState *cpu, x86_segment_selector tss_sel, int rea
         return;
     }
 
-    load_regs(cpu);
+    hvf_load_regs(cpu);
 
     struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
     x86_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
@@ -178,7 +178,7 @@ void vmx_handle_task_switch(CPUState *cpu, x86_segment_selector tss_sel, int rea
     x86_segment_descriptor_to_vmx(cpu, tss_sel, &next_tss_desc, &vmx_seg);
     vmx_write_segment_descriptor(cpu, &vmx_seg, R_TR);
 
-    store_regs(cpu);
+    hvf_store_regs(cpu);
 
     hv_vcpu_invalidate_tlb(cpu->accel->fd);
 }
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 423a89b6ad..8c46ce8ad0 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -31,4 +31,7 @@ void hvf_get_xsave(CPUState *cs);
 void hvf_get_msrs(CPUState *cs);
 void vmx_clear_int_window_exiting(CPUState *cs);
 void vmx_update_tpr(CPUState *cs);
+
+void hvf_load_regs(CPUState *cpu);
+void hvf_store_regs(CPUState *cpu);
 #endif
-- 
2.39.5 (Apple Git-154)


