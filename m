Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13976C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUpA-0008KV-NS; Mon, 29 Jan 2024 11:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnk-0003Af-JG
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:04 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnf-0004Vf-CS
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:04 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ae7ae9ec5so979776f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546877; x=1707151677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDyOJncTz/gz39l44d2jGwByTaW/KG4k2gJ/GNswNnI=;
 b=zF2HpAqjvSq0m0KzUV8Hs2RJ3Ceq+etm4TrzfpUOzNV6gXqzGGcRn7XENC65KK1SPh
 UFkk60YM4MSGBkMUL82Ngbl6YooTb0gmrceFs8XvnHFanImtpxwlpxXvirEzlrxnGPrT
 GkBxCWexNJF9hMmkjgCHMbEtigVn5mM1Ql/s4SQY4ID4X1u06euUWobCcKXQlapz9K6B
 7uKY70DO5osnApoFIERH67Ck8IHC4LCPdtQdJU6Hr+Bj2NK51equJgvm3zNUau4DCpL6
 d9RDR4CV57ZNRT+WjuK3itOf3O+GTTg89nX/IJmktZjswAIC3NeHkLucdGHmMl9ezxZT
 mOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546877; x=1707151677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDyOJncTz/gz39l44d2jGwByTaW/KG4k2gJ/GNswNnI=;
 b=btQ1IQ5axkPN76+IgJJh462izp0MJQrGtM7uU81fyh6b9bwEVLQBCHiz4x2gH2sLXe
 zl2yA3DuD9kdT5uoAtrqQdhQs84EqRWzHaTlAx+CXd8POvZwVygixH93X/NM4VBw7nQu
 e5z52y5ERl7aVsblvAqkEo4RWC7Wh0URsZWaI5vT72pJMktM67iit49nM+2ULRwSRfmh
 ieG5M7KcTxFTywtV4wP/OnMBpIpZ5z1FrMKYitRgjI3YiFr7SyuDvTaRMm6qX/g7Lte1
 sZvMkKHXonendVjH352fJiCeD81xJmKCr6CTqr5RLJBHD66ny+dPVMqdBmzP40wuZbf1
 2RcA==
X-Gm-Message-State: AOJu0YxAIeWoMt1aUrCRb1toy8RLRVJVA3yJSB4rRmgKwzvtPK8ve1fs
 SQr7RzlXhGZVts2B1Uc590cc7l1ICeAkd979KGy68vRuLhFHbJdUI5R3sfCYj6lGC8/k6Trq41e
 n
X-Google-Smtp-Source: AGHT+IGpSP62XxzQ6ZDTlpeFHsIrctZ9h8BZDrmsx+XYzXCe3dEYoh7yTLPt/V9X39N+RCxRJF1Yww==
X-Received: by 2002:a5d:6812:0:b0:33a:e75e:281c with SMTP id
 w18-20020a5d6812000000b0033ae75e281cmr3295951wru.5.1706546877555; 
 Mon, 29 Jan 2024 08:47:57 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0033aee3bfac5sm2738967wrx.16.2024.01.29.08.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 26/29] target/sparc: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:45:08 +0100
Message-ID: <20240129164514.73104-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
 target/sparc/cpu.c          | 17 +++++------------
 target/sparc/gdbstub.c      |  3 +--
 target/sparc/int32_helper.c |  3 +--
 target/sparc/int64_helper.c |  3 +--
 target/sparc/ldst_helper.c  |  6 ++----
 target/sparc/mmu_helper.c   | 15 +++++----------
 target/sparc/translate.c    |  9 +++------
 7 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 152bee4f81..72a9b9a285 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -32,9 +32,8 @@
 static void sparc_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    SPARCCPU *cpu = SPARC_CPU(cs);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
     if (scc->parent_phases.hold) {
         scc->parent_phases.hold(obj);
@@ -83,8 +82,7 @@ static void sparc_cpu_reset_hold(Object *obj)
 static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        SPARCCPU *cpu = SPARC_CPU(cs);
-        CPUSPARCState *env = &cpu->env;
+        CPUSPARCState *env = cpu_env(cs);
 
         if (cpu_interrupts_enabled(env) && env->interrupt_index > 0) {
             int pil = env->interrupt_index & 0xf;
@@ -613,8 +611,7 @@ static void cpu_print_cc(FILE *f, uint32_t cc)
 
 static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int i, x;
 
     qemu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
@@ -711,11 +708,8 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
 
 static bool sparc_cpu_has_work(CPUState *cs)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-           cpu_interrupts_enabled(env);
+           cpu_interrupts_enabled(cpu_env(cs));
 }
 
 static char *sparc_cpu_type_name(const char *cpu_model)
@@ -749,8 +743,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
-    SPARCCPU *cpu = SPARC_CPU(dev);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #if defined(CONFIG_USER_ONLY)
     /* We are emulating the kernel, which will trap and emulate float128. */
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index a1c8fdc4d5..5257c49a0d 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -29,8 +29,7 @@
 
 int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
     if (n < 8) {
         /* g0..g7 */
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 058dd712b5..6b7d65b031 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -99,8 +99,7 @@ void cpu_check_irqs(CPUSPARCState *env)
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int cwp, intno = cs->exception_index;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 27df9dba89..bd14c7a0db 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -130,8 +130,7 @@ void cpu_check_irqs(CPUSPARCState *env)
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int intno = cs->exception_index;
     trap_state *tsptr;
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 09066d5487..203441bfb2 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -421,8 +421,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
                                   bool is_write, bool is_exec, int is_asi,
                                   unsigned size, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int fault_type;
 
 #ifdef DEBUG_UNASSIGNED
@@ -483,8 +482,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
                                   bool is_write, bool is_exec, int is_asi,
                                   unsigned size, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem access to " HWADDR_FMT_plx " from " TARGET_FMT_lx
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 453498c670..a05ee22315 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -206,8 +206,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     CPUTLBEntryFull full = {};
     target_ulong vaddr;
     int error_code = 0, access_index;
@@ -391,8 +390,7 @@ void dump_mmu(CPUSPARCState *env)
 int sparc_cpu_memory_rw_debug(CPUState *cs, vaddr address,
                               uint8_t *buf, int len, bool is_write)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     target_ulong addr = address;
     int i;
     int len1;
@@ -759,8 +757,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     CPUTLBEntryFull full = {};
     int error_code = 0, access_index;
 
@@ -898,8 +895,7 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     hwaddr phys_addr;
     int mmu_idx = cpu_mmu_index(env, false);
 
@@ -916,8 +912,7 @@ G_NORETURN void sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                               int mmu_idx,
                                               uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #ifdef TARGET_SPARC64
     env->dmmu.sfsr = build_sfsr(env, mmu_idx, access_type);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..769418d6b0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5154,13 +5154,12 @@ TRANS(FCMPEq, ALL, do_fcmpq, a, true)
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUSPARCState *env = cpu_env(cs);
     int bound;
 
     dc->pc = dc->base.pc_first;
     dc->npc = (target_ulong)dc->base.tb->cs_base;
     dc->mem_idx = dc->base.tb->flags & TB_FLAG_MMU_MASK;
-    dc->def = &env->def;
+    dc->def = &cpu_env(cs)->def;
     dc->fpu_enabled = tb_fpu_enabled(dc->base.tb->flags);
     dc->address_mask_32bit = tb_am_enabled(dc->base.tb->flags);
 #ifndef CONFIG_USER_ONLY
@@ -5210,10 +5209,9 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUSPARCState *env = cpu_env(cs);
     unsigned int insn;
 
-    insn = translator_ldl(env, &dc->base, dc->pc);
+    insn = translator_ldl(cpu_env(cs), &dc->base, dc->pc);
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
@@ -5406,8 +5404,7 @@ void sparc_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     target_ulong pc = data[0];
     target_ulong npc = data[1];
 
-- 
2.41.0


