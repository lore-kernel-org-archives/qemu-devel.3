Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB4EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdnP-0007zx-JP; Fri, 07 Mar 2025 14:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tqdnK-0007ya-C4
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:42 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tqdnG-0005i0-Oh
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:41 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 3BB962038F3E; Fri,  7 Mar 2025 11:55:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BB962038F3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741377336;
 bh=bUsl5q0UnWMbUMpn3XPVKpAEkekYbfGqTlTmezhm7Pg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HAX01x7pSoQCAu4G4qNcN/0WxUBnat6LDSb9qMTEKGsY6xgisQuicjV/UHAeYQKXS
 W0VjVAy45ZOmRey8J44nUetyRthllyR0LrK3y8NDNtj8B9jItga5BOFqyhmbySs3z2
 b3It/IiWwgitIsHXEST3/q6UfAR8HjeXRnwySsaI=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH v2 04/14] target/i386: rename hvf_mmio_buf to emu_mmio_buf
Date: Fri,  7 Mar 2025 11:55:15 -0800
Message-Id: <1741377325-28175-5-git-send-email-liuwe@linux.microsoft.com>
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

We want to refactor HVF's instruction emulator to a common component. Renaming
hvf_mmio_buf removes the association between HVF and the instruction emulator.

The definition of the field is still guarded by CONFIG_HVF for now, since it is
the only user.

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
v2: mmio_buf -> emu_mmio_buf per suggestion from Paolo
---
 target/i386/cpu.h         |  2 +-
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86_emu.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7882b63b9b61..cf2bd0e9ada9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2109,7 +2109,7 @@ typedef struct CPUArchState {
 #endif
 #if defined(CONFIG_HVF)
     HVFX86LazyFlags hvf_lflags;
-    void *hvf_mmio_buf;
+    void *emu_mmio_buf;
 #endif
 
     uint64_t mcg_cap;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 7da03f9c0811..1cecb765952b 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -168,7 +168,7 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    g_free(env->hvf_mmio_buf);
+    g_free(env->emu_mmio_buf);
 }
 
 static void init_tsc_freq(CPUX86State *env)
@@ -262,7 +262,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     if (hvf_state->hvf_caps == NULL) {
         hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
     }
-    env->hvf_mmio_buf = g_new(char, 4096);
+    env->emu_mmio_buf = g_new(char, 4096);
 
     if (x86cpu->vmware_cpuid_freq) {
         init_tsc_freq(env);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 7b01ccde5d3e..e59a73e00d5c 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -184,8 +184,8 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, ptr, bytes);
-    return env->hvf_mmio_buf;
+    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    return env->emu_mmio_buf;
 }
 
 
@@ -487,9 +487,9 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
-    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 0,
+    emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 0,
                         decode->operand_size, 1);
-    vmx_write_mem(env_cpu(env), addr, env->hvf_mmio_buf,
+    vmx_write_mem(env_cpu(env), addr, env->emu_mmio_buf,
                   decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
@@ -510,9 +510,9 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->hvf_mmio_buf, addr,
+    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, addr,
                  decode->operand_size);
-    emul_ops->handle_io(env_cpu(env), DX(env), env->hvf_mmio_buf, 1,
+    emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 1,
                         decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.47.2


