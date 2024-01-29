Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEC5C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUp0-0007jn-TH; Mon, 29 Jan 2024 11:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnd-0002dO-3C
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnZ-0004Rp-If
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40eb033c1b0so36344765e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546872; x=1707151672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EK1f6yC+2+7tJRqq8zpOFY9o0Gec7K9NU3Dea7XiVcs=;
 b=eSCr7yyM3cbUuOeBNgO6lZykNe2w4vM6i6cNBlUpI+SrlWrypuMV/tK1+f4uQC73ll
 nBUCCH+owChmacrP/0a5C75DjeD+Veya2DBa8toEXcrGt2wVa3EmFVsJLpwyLwy7roBH
 QPw3gNA3bHbomUshAYyzjPCHf5nRn0AsoeFJ1rTH3zfkOlpdJAGFc1NYn4YEVCBZIZpr
 IPoE9zTg4M6F4ykpSJSLOTVF7FOGDKwRMm0HHgwgSkOkbi8BBMwgrlR35W82VcsCms0x
 B+Qlsr7dWKree92lGFGAAUtQgcw7n+boUsMd23XnHtL8rsx1doix6881eEL5utbC/0ml
 A5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546872; x=1707151672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EK1f6yC+2+7tJRqq8zpOFY9o0Gec7K9NU3Dea7XiVcs=;
 b=BerSiXLtK2F0N8sD/GIokaVa0D+vM1mQ7XcwcKC1bA78oGTW8Bu6Y0S2uarcbOx2t6
 A70nltzmReHKp05P5mK+Vn0SaXDsn+VxIQ/AyQO2FSlwN5MpS55Os6bU4kUHbvviCupI
 Vo9I1uPNGpc+RtrjX5xiTCJARlUgVA3FELOXC2lv8oLMgAfPO7Vrsp5fjPOILBc3k2+1
 PVesX/Ad6mGJekRlecPfMbHkdN7pPNLM49N3neI1Sj6alRJLDIEfXYfVYz+rK55tx8e+
 YQxyCDmVkDzBuqzWrLxUrUX5kpeyuFcrfv+ATyvix6MD9H1N+bo2fL5XrGUVbT347o9M
 qU2w==
X-Gm-Message-State: AOJu0Yy5c6t6ZwE9H6OktABxUerYU8ytXJmqLPC1KPBlIAtROKH5xNmD
 +T7WCNZ6/Er4LivwFhy4bbLNZnTjcNvLXxpJq1tb0eceHR3fdybYJz3g+6/hxGH57BUPXKy6y0j
 q
X-Google-Smtp-Source: AGHT+IGp/BpyozcDAwqfGmyRJlRPq1/IHU+J5kLY+oFMWzv+eh6PdIu4rsOF1seUTLeuqx4RAfarbA==
X-Received: by 2002:a05:600c:468f:b0:40e:cd0e:f749 with SMTP id
 p15-20020a05600c468f00b0040ecd0ef749mr5338733wmo.28.1706546871830; 
 Mon, 29 Jan 2024 08:47:51 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a05600c1c8700b0040ef3ae26cdsm5224770wms.37.2024.01.29.08.47.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 25/29] target/sh4: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:45:07 +0100
Message-ID: <20240129164514.73104-26-philmd@linaro.org>
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
 target/sh4/cpu.c       | 18 ++++++------------
 target/sh4/gdbstub.c   |  6 ++----
 target/sh4/helper.c    | 14 ++++----------
 target/sh4/translate.c |  6 ++----
 4 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 1b03c7bcb1..3308a2be07 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -71,8 +71,7 @@ static void superh_restore_state_to_opc(CPUState *cs,
 static bool superh_io_recompile_replay_branch(CPUState *cs,
                                               const TranslationBlock *tb)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(cs);
 
     if ((env->flags & (TB_FLAG_DELAY_SLOT | TB_FLAG_DELAY_SLOT_COND))
         && !(cs->tcg_cflags & CF_PCREL) && env->pc != tb->pc) {
@@ -92,9 +91,8 @@ static bool superh_cpu_has_work(CPUState *cs)
 static void superh_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    SuperHCPU *cpu = SUPERH_CPU(cs);
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(obj);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(cs);
 
     if (scc->parent_phases.hold) {
         scc->parent_phases.hold(obj);
@@ -144,8 +142,7 @@ out:
 
 static void sh7750r_cpu_initfn(Object *obj)
 {
-    SuperHCPU *cpu = SUPERH_CPU(obj);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(CPU(obj));
 
     env->id = SH_CPU_SH7750R;
     env->features = SH_FEATURE_BCR3_AND_BCR4;
@@ -162,8 +159,7 @@ static void sh7750r_class_init(ObjectClass *oc, void *data)
 
 static void sh7751r_cpu_initfn(Object *obj)
 {
-    SuperHCPU *cpu = SUPERH_CPU(obj);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(CPU(obj));
 
     env->id = SH_CPU_SH7751R;
     env->features = SH_FEATURE_BCR3_AND_BCR4;
@@ -180,8 +176,7 @@ static void sh7751r_class_init(ObjectClass *oc, void *data)
 
 static void sh7785_cpu_initfn(Object *obj)
 {
-    SuperHCPU *cpu = SUPERH_CPU(obj);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(CPU(obj));
 
     env->id = SH_CPU_SH7785;
     env->features = SH_FEATURE_SH4A;
@@ -216,8 +211,7 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void superh_cpu_initfn(Object *obj)
 {
-    SuperHCPU *cpu = SUPERH_CPU(obj);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(CPU(obj));
 
     env->movcal_backup_tail = &(env->movcal_backup);
 }
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index d8e199fc06..75926d4e04 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -26,8 +26,7 @@
 
 int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(cs);
 
     switch (n) {
     case 0 ... 7:
@@ -76,8 +75,7 @@ int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int superh_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(cs);
 
     switch (n) {
     case 0 ... 7:
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5a6f653c12..7c6f9d374a 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -55,8 +55,7 @@ int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
 
 void superh_cpu_do_interrupt(CPUState *cs)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(cs);
     int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
     int do_exp, irq_vector = cs->exception_index;
 
@@ -432,11 +431,10 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
 
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
     target_ulong physical;
     int prot;
 
-    if (get_physical_address(&cpu->env, &physical, &prot, addr, MMU_DATA_LOAD)
+    if (get_physical_address(cpu_env(cs), &physical, &prot, addr, MMU_DATA_LOAD)
             == MMU_OK) {
         return physical;
     }
@@ -782,11 +780,8 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
 bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        SuperHCPU *cpu = SUPERH_CPU(cs);
-        CPUSH4State *env = &cpu->env;
-
         /* Delay slots are indivisible, ignore interrupts */
-        if (env->flags & TB_FLAG_DELAY_SLOT_MASK) {
+        if (cpu_env(cs)->flags & TB_FLAG_DELAY_SLOT_MASK) {
             return false;
         } else {
             superh_cpu_do_interrupt(cs);
@@ -800,8 +795,7 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(cs);
     int ret;
 
     target_ulong physical;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 81f825f125..d9f222bd15 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -159,8 +159,7 @@ void sh4_translate_init(void)
 
 void superh_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-    CPUSH4State *env = &cpu->env;
+    CPUSH4State *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "pc=0x%08x sr=0x%08x pr=0x%08x fpscr=0x%08x\n",
@@ -2186,7 +2185,6 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUSH4State *env = cpu_env(cs);
     uint32_t tbflags;
     int bound;
 
@@ -2196,7 +2194,7 @@ static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     /* We don't know if the delayed pc came from a dynamic or static branch,
        so assume it is a dynamic branch.  */
     ctx->delayed_pc = -1; /* use delayed pc from env pointer */
-    ctx->features = env->features;
+    ctx->features = cpu_env(cs)->features;
     ctx->has_movcal = (tbflags & TB_FLAG_PENDING_MOVCA);
     ctx->gbank = ((tbflags & (1 << SR_MD)) &&
                   (tbflags & (1 << SR_RB))) * 0x10;
-- 
2.41.0


