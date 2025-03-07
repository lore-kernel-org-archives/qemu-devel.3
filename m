Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C345BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdnV-00080t-ML; Fri, 07 Mar 2025 14:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tqdnM-0007zT-D1
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:44 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tqdnK-0005io-Ls
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:44 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 654A12038F41; Fri,  7 Mar 2025 11:55:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 654A12038F41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741377336;
 bh=Y0YgMAVKYo8cSOptnzThemrN+dmKmi2kQS3lqt0kQFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pDKrnpdC2n9y7GcmVpNCMW7y08bfRymXzBg6H2mHwPYqX99z971s7YOQGKFZvqjLx
 sY3P6IF5nOL7XGbtxUbSupjNqz32XPuODrDi+gLCeucLSykx+vw7LR3ErO5/tqE5hp
 onM/9f/qKUEjWkvBSjnPP6pbSG5VhyfzP/3L8jjw=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH v2 07/14] target/i386/hvf: provide and use simulate_{wrmsr,
 rdmsr} in emul_ops
Date: Fri,  7 Mar 2025 11:55:18 -0800
Message-Id: <1741377325-28175-8-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
References: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Change the first argument's type to be CPUState to match other hooks.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf-i386.h |  4 ++--
 target/i386/hvf/hvf.c      | 18 ++++++++++--------
 target/i386/hvf/x86_emu.c  |  4 ++--
 target/i386/hvf/x86_emu.h  |  2 ++
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 044ad236ae80..8c42ae6b0130 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,8 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
-void hvf_simulate_rdmsr(CPUX86State *env);
-void hvf_simulate_wrmsr(CPUX86State *env);
+void hvf_simulate_rdmsr(CPUState *cpu);
+void hvf_simulate_wrmsr(CPUState *cpu);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e4f48a79fb7c..8c31d2e0cf72 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -252,6 +252,8 @@ static const struct x86_emul_ops hvf_x86_emul_ops = {
     .write_mem = hvf_write_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
     .handle_io = hvf_handle_io,
+    .simulate_rdmsr = hvf_simulate_rdmsr,
+    .simulate_wrmsr = hvf_simulate_wrmsr,
 };
 
 int hvf_arch_init_vcpu(CPUState *cpu)
@@ -506,10 +508,10 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
-void hvf_simulate_rdmsr(CPUX86State *env)
+void hvf_simulate_rdmsr(CPUState *cs)
 {
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
     uint32_t msr = ECX(env);
     uint64_t val = 0;
 
@@ -611,10 +613,10 @@ void hvf_simulate_rdmsr(CPUX86State *env)
     RDX(env) = (uint32_t)(val >> 32);
 }
 
-void hvf_simulate_wrmsr(CPUX86State *env)
+void hvf_simulate_wrmsr(CPUState *cs)
 {
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
     uint32_t msr = ECX(env);
     uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
 
@@ -900,9 +902,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         {
             hvf_load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
-                hvf_simulate_rdmsr(env);
+                hvf_simulate_rdmsr(cpu);
             } else {
-                hvf_simulate_wrmsr(env);
+                hvf_simulate_wrmsr(cpu);
             }
             env->eip += ins_len;
             hvf_store_regs(cpu);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 3ff41c35d89a..aec7a8a3fa85 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -672,13 +672,13 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    hvf_simulate_rdmsr(env);
+    emul_ops->simulate_rdmsr(env_cpu(env));
     env->eip += decode->len;
 }
 
 static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    hvf_simulate_wrmsr(env);
+    emul_ops->simulate_wrmsr(env_cpu(env));
     env->eip += decode->len;
 }
 
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 107c1f1ac866..555b567e2c7d 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -30,6 +30,8 @@ struct x86_emul_ops {
                                     enum X86Seg seg);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
+    void (*simulate_rdmsr)(CPUState *cs);
+    void (*simulate_wrmsr)(CPUState *cs);
 };
 
 extern const struct x86_emul_ops *emul_ops;
-- 
2.47.2


