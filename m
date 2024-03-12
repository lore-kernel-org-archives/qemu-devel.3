Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA58C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1WC-0006NS-H1; Tue, 12 Mar 2024 08:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1V8-0004P4-Dz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1V4-0000XB-Uf
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb58VdMkT72bE3NN+1BpFDoUUUPI1yhPfAiesZfAe2I=;
 b=dDLBax1XolEF01tWdd7zLhc6s27lQ7AFNGMndBi8z3oJt9q5r3oCH32hK6xPchGQGZ74VG
 x3uvB2jSdFhruUu7jPRAr0xN0skCeUwpxan+Co1w4frlILsEmxcTmn6jNT/SZJD1GC6eEc
 pOy3tAwXXeNNBWig/dObhGYCJmx3EM0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-i7uxCo4bPeWDHnC-d863sA-1; Tue,
 12 Mar 2024 08:44:55 -0400
X-MC-Unique: i7uxCo4bPeWDHnC-d863sA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4EED285F987;
 Tue, 12 Mar 2024 12:44:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9E28492BC4;
 Tue, 12 Mar 2024 12:44:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 38/55] target/alpha: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Tue, 12 Mar 2024 13:43:22 +0100
Message-ID: <20240312124339.761630-39-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-8-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/alpha/cpu.c        | 31 +++++++------------------------
 target/alpha/gdbstub.c    |  6 ++----
 target/alpha/helper.c     | 15 +++++----------
 target/alpha/mem_helper.c | 11 +++--------
 target/alpha/translate.c  |  4 ++--
 5 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index bf70173a25..05f9ee41e9 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -135,40 +135,27 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
 
 static void ev4_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->implver = IMPLVER_2106x;
+    cpu_env(CPU(obj))->implver = IMPLVER_2106x;
 }
 
 static void ev5_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->implver = IMPLVER_21164;
+    cpu_env(CPU(obj))->implver = IMPLVER_21164;
 }
 
 static void ev56_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->amask |= AMASK_BWX;
+    cpu_env(CPU(obj))->amask |= AMASK_BWX;
 }
 
 static void pca56_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->amask |= AMASK_MVI;
+    cpu_env(CPU(obj))->amask |= AMASK_MVI;
 }
 
 static void ev6_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(CPU(obj));
 
     env->implver = IMPLVER_21264;
     env->amask = AMASK_BWX | AMASK_FIX | AMASK_MVI | AMASK_TRAP;
@@ -176,16 +163,12 @@ static void ev6_cpu_initfn(Object *obj)
 
 static void ev67_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->amask |= AMASK_CIX | AMASK_PREFETCH;
+    cpu_env(CPU(obj))->amask |= AMASK_CIX | AMASK_PREFETCH;
 }
 
 static void alpha_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(CPU(obj));
 
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 0f8fa150f8..13694fd321 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -23,8 +23,7 @@
 
 int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     uint64_t val;
     CPU_DoubleU d;
 
@@ -59,8 +58,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     target_ulong tmp = ldtul_p(mem_buf);
     CPU_DoubleU d;
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 970c869771..d6d4353edd 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -286,11 +286,10 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
     target_ulong phys;
     int prot, fail;
 
-    fail = get_physical_address(&cpu->env, addr, 0, 0, &phys, &prot);
+    fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
     return (fail >= 0 ? -1 : phys);
 }
 
@@ -298,8 +297,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     target_ulong phys;
     int prot, fail;
 
@@ -325,8 +323,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 
 void alpha_cpu_do_interrupt(CPUState *cs)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     int i = cs->exception_index;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
@@ -435,8 +432,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     int idx = -1;
 
     /* We never take interrupts while in PALmode.  */
@@ -487,8 +483,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         "a0",  "a1",  "a2", "a3",  "a4", "a5", "t8", "t9",
         "t10", "t11", "ra", "t12", "at", "gp", "sp"
     };
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "PC      " TARGET_FMT_lx " PS      %02x\n",
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index a39b52c5dd..872955f5e7 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -42,18 +42,14 @@ static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retadd
 void alpha_cpu_record_sigbus(CPUState *cs, vaddr addr,
                              MMUAccessType access_type, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
-
-    do_unaligned_access(env, addr, retaddr);
+    do_unaligned_access(cpu_env(cs), addr, retaddr);
 }
 #else
 void alpha_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
 
     do_unaligned_access(env, addr, retaddr);
     cs->exception_index = EXCP_UNALIGN;
@@ -67,8 +63,7 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      int mmu_idx, MemTxAttrs attrs,
                                      MemTxResult response, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = access_type == MMU_DATA_STORE ? 1 : 0;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 882cf6cea0..a97cd54f0c 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2903,8 +2903,8 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUAlphaState *env = cpu_env(cpu);
-    uint32_t insn = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+    uint32_t insn = translator_ldl(cpu_env(cpu), &ctx->base,
+                                   ctx->base.pc_next);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.44.0


