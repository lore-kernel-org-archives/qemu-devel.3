Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbD-0008CR-PI; Fri, 21 Feb 2025 09:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWi-0006RI-Gn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:55 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWf-00015v-RG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:52 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id A2E50204E5BB; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2E50204E5BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=0JG/k2FedV3leSTYvugMKLbdpsUtL8gN3PYO9+FffHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JWyJh10qkgA5ntWxsAZ1i9rMlmtoReT+RNQAoPkuVZvTxA6NoQA4xQBzgVHeBHzTr
 4YWRjlYv5/5YlJ4xPGHHuNK+/VjXNPC8QDLHcWD2DaeqHWCilqXisp8Ei3yFUyqFiJ
 Y+oIecH0QvRP1V92g+eTVedrlvOFIhDwIE60cKZM=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 08/19] target/i386: rename hvf_mmio_buf to mmio_buf
Date: Fri, 21 Feb 2025 00:36:16 -0800
Message-Id: <1740126987-8483-9-git-send-email-liuwe@linux.microsoft.com>
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
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:10 -0500
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

We want to refactor HVF's instruction emulator to a common component. Renaming
hvf_mmio_buf removes the association between HVF and the instruction emulator.

The definition of the field is still guarded by CONFIG_HVF for now, since it is
the only user.

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/cpu.h         |  2 +-
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86_emu.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34f..bfdb1f87a3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2070,7 +2070,7 @@ typedef struct CPUArchState {
 #endif
 #if defined(CONFIG_HVF)
     HVFX86LazyFlags hvf_lflags;
-    void *hvf_mmio_buf;
+    void *mmio_buf;
 #endif
 
     uint64_t mcg_cap;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 64e4154cdf..533b05577d 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -168,7 +168,7 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    g_free(env->hvf_mmio_buf);
+    g_free(env->mmio_buf);
 }
 
 static void init_tsc_freq(CPUX86State *env)
@@ -262,7 +262,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     if (hvf_state->hvf_caps == NULL) {
         hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
     }
-    env->hvf_mmio_buf = g_new(char, 4096);
+    env->mmio_buf = g_new(char, 4096);
 
     if (x86cpu->vmware_cpuid_freq) {
         init_tsc_freq(env);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 25912e82ca..d0a8e221ea 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -183,8 +183,8 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
-    return env->hvf_mmio_buf;
+    vmx_read_mem(env_cpu(env), env->mmio_buf, ptr, bytes);
+    return env->mmio_buf;
 }
 
 
@@ -486,9 +486,9 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
-    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
+    emul_ops->handle_io(env_cpu(env), DX(env), env->mmio_buf, 0,
                         decode->operand_size, 1);
-    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
+    vmx_write_mem(env_cpu(env), addr, env->mmio_buf,
                   decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
@@ -509,9 +509,9 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
+    vmx_read_mem(env_cpu(env), env->mmio_buf, addr,
                  decode->operand_size);
-    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
+    emul_ops->handle_io(env_cpu(env), DX(env), env->mmio_buf, 1,
                         decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.39.5 (Apple Git-154)


