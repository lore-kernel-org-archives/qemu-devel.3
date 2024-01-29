Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3E6C48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUnT-0001Qw-0U; Mon, 29 Jan 2024 11:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUls-00069O-8G
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlp-0003kX-CT
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so34905495e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546764; x=1707151564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGNKA1+F8sOT+wzzeFuDW0MVJl/ad3LJJb3kfzi1Tuw=;
 b=C9yIKRPdxAyM+3tu3pip8Fx4SlVfzY34ZnLVNLZcpxVM+pXKDQGAi1wpBjSJ0oRhFE
 a6VKTGEYUHdbHccgfjKgqxuY4k7BVy1cwDpwnp9NHkOYQP81vdx9ueAtpq3iZxbSlQYr
 cgnR8q5C1xNzmkHqKxdJ8euVYymr2YW9/4pvqM+CJV89MRxIKpQOaSs79Osf/xbWnIZM
 bTkH/UlmHqCdLn2Tuq6wSbrEJf9put2IhGfP9ttkHBy41DNMaCk0g9HirlfvIH5WBG4+
 tZGmiGLtBfqAkaB3a7Lm1u/xVKnOG6QK4To9720PY4sAAKA4fp7OFQDZXCXOeNJUO6kt
 x9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546764; x=1707151564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGNKA1+F8sOT+wzzeFuDW0MVJl/ad3LJJb3kfzi1Tuw=;
 b=IwaIbg0MfPaHXoqQCe5JoTUvjUujfWUqlsEIAMlhQA4yEB+b8tFdam7FyD8lvf0oEY
 KKjzdksgDGMQRNJhCo1BzxjeEfTm8r4Eokitzkvf8ge7Nouicq0LJxIe6jjeqYcfyqek
 HlSIkcJg/IYKmxFC2aEn7dLZv9STDEmusCIcc0T0QmbS38JjhiSMohPCMKdADk7IVtgi
 vfIid5uyUv2C4ECax/IUddQc95aeDxZMz+Tg5M/hpHABBZcvc/jWBCLVke09ILJbzsU/
 KeR0wQwvyUqFFQAE32aBiFkkimX8vrOQQ0eOL/do05CExbQUd7c6wAy1028q21LrhaQv
 gYtg==
X-Gm-Message-State: AOJu0Yzm6jcNloOy25i9a5BRcqOUOPIXnUB01yk7z7DmpY4hJpfq9+Su
 yGbscZJvJvpImvDHjyFlgJKRw0nGurNZSIjq6pJWI6memASqMgSPmhlMIiD6tXPA3XeiLTAzNWe
 g
X-Google-Smtp-Source: AGHT+IEXV3Ki5IWCz4nhNivs20Xtm4D5RCIZtFll/A9SeJ2KRGM2dIq81Jsin9IhV9P3C8GFjfF1yg==
X-Received: by 2002:a5d:5f96:0:b0:33a:e724:63fb with SMTP id
 dr22-20020a5d5f96000000b0033ae72463fbmr3905171wrb.20.1706546763809; 
 Mon, 29 Jan 2024 08:46:03 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a5d4a47000000b0033aef37ec94sm2523940wrs.113.2024.01.29.08.46.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:46:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/29] target/alpha: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:44:49 +0100
Message-ID: <20240129164514.73104-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.c        | 31 +++++++------------------------
 target/alpha/gdbstub.c    |  6 ++----
 target/alpha/helper.c     | 15 +++++----------
 target/alpha/mem_helper.c | 11 +++--------
 target/alpha/translate.c  |  4 ++--
 5 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b8ed29e343..e21a8936c7 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -130,40 +130,27 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
 
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
@@ -171,16 +158,12 @@ static void ev6_cpu_initfn(Object *obj)
 
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
index 32333081d8..d1188194ba 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2917,8 +2917,8 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
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
2.41.0


