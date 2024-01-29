Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C66C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUp5-0007vR-41; Mon, 29 Jan 2024 11:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnv-00047j-UZ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:18 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUns-0004aw-Cq
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:15 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5100ed2b33dso4624187e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546890; x=1707151690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfR8cC6O+BWQhQkWXGdZ7PfclWjDr/hbLCsaxnqdy8k=;
 b=DIy2XmezmVWtAyc6E0HEtvM82wc7b721PmBqh1IBwU8IPrVX7fpTILo90rjNGg/r43
 2rqD8e19qtA9DIHeCLfJN+JV8897o0iyy53tMcImva577Fz3eimvHetpWbhTQdJx4vSS
 5xJeMPPqGAB9QlrAlfnfJG8konzHaA99KcA6DyxyoqqujYoK46QkLmfJ+zLJ1PIyTYLh
 PQ65ZYbL649vT8p84waBfenoetVqnaEYE0fYgvyLPM30YZi8wwwoC3eyffkdmHwE2xCG
 j0Lcevkwkc4+jcxM1Sr0bkyNpKTyYuYEHp9QKl848v/LMYHPcvg+eEInNnGQIR/0Zmm7
 4yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546890; x=1707151690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfR8cC6O+BWQhQkWXGdZ7PfclWjDr/hbLCsaxnqdy8k=;
 b=dovS8Snbvm2gNC1CDmQLCw7xDzt3++ZpLWyrzX8uESc57ZwfNoYx4+4lWzQwDaXaiC
 V2UBchmMdkHaVYtU4ZFsRcB73y2VMqJUDdxINO9/xyrboROEN3k+pcXpCtx6sMeVXhqf
 dcODwcUIuS3yeB4cE24fLGXFe7hOZkF7X3PFqx3bAaEulp+uUEpjZ2Cx5PdXtlhBcIZ0
 reapY8MIwdnHYCHzWUSsnoe7WE8nmUAbnKT4mYCVaEEzl+IWpbCudwV1P0+Y9XDuRepU
 fIcJX1fcjzoh9c+YctOpblVhTcwRGBiIF0NT+CfVcet3m0GVIGgHlHIp5AYFPSdxRKyM
 wyHg==
X-Gm-Message-State: AOJu0YwhNmaD77tCPFjlA+MDFhyTE1bTqxcHqY1vwJX8UzB5vhF14TCR
 piJpUaqBeKjrMPqS5hBBPu6uPGpMgWyFs/Jv5Ige27GNKLXkHy4KybWDeT4gbpDyCx0OhJtn3mk
 r
X-Google-Smtp-Source: AGHT+IFdYBYX+YhuXRJ5ebXXB5wSuyFUDmegmoCsIRNXBDPunLZRwNY2MqJbCauv7QOv9aYvnOjo7g==
X-Received: by 2002:ac2:4e08:0:b0:510:1b81:ac2f with SMTP id
 e8-20020ac24e08000000b005101b81ac2fmr4708425lfr.62.1706546890079; 
 Mon, 29 Jan 2024 08:48:10 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a056000038b00b0033aed5feea4sm3296936wrf.54.2024.01.29.08.48.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:48:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 28/29] target/xtensa: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:45:10 +0100
Message-ID: <20240129164514.73104-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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
 target/xtensa/cpu.c        | 3 +--
 target/xtensa/dbg_helper.c | 3 +--
 target/xtensa/exc_helper.c | 3 +--
 target/xtensa/gdbstub.c    | 6 ++----
 target/xtensa/helper.c     | 9 +++------
 target/xtensa/translate.c  | 6 ++----
 6 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ce044466ad..47fd7c7ca9 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -91,9 +91,8 @@ bool xtensa_abi_call0(void)
 static void xtensa_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    XtensaCPU *cpu = XTENSA_CPU(cs);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     bool dfpu = xtensa_option_enabled(env->config,
                                       XTENSA_OPTION_DFP_COPROCESSOR);
 
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 497dafca71..5546c82ecd 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -66,8 +66,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 
 bool xtensa_debug_check_breakpoint(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     unsigned int i;
 
     if (xtensa_get_cintlevel(env) >= env->config->debug_level) {
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 168419a505..0514c2c1f3 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -205,8 +205,7 @@ static void handle_interrupt(CPUXtensaState *env)
 /* Called from cpu_handle_interrupt with BQL held */
 void xtensa_cpu_do_interrupt(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     if (cs->exception_index == EXC_IRQ) {
         qemu_log_mask(CPU_LOG_INT,
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 4b3bfb7e59..4748fb6532 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -65,8 +65,7 @@ void xtensa_count_regs(const XtensaConfig *config,
 
 int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
 #ifdef CONFIG_USER_ONLY
     int num_regs = env->config->gdb_regmap.num_core_regs;
@@ -120,8 +119,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     uint32_t tmp;
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index a9f8907083..ca214b948a 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -217,8 +217,7 @@ static uint32_t check_hw_breakpoints(CPUXtensaState *env)
 
 void xtensa_breakpoint_handler(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
@@ -266,8 +265,7 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
@@ -297,8 +295,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     cpu_restore_state(cs, retaddr);
     HELPER(exception_cause_vaddr)(env, env->pc,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 87947236ca..e646e016df 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1127,10 +1127,9 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
                                          CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUXtensaState *env = cpu_env(cpu);
     uint32_t tb_flags = dc->base.tb->flags;
 
-    dc->config = env->config;
+    dc->config = cpu_env(cpu)->config;
     dc->pc = dc->base.pc_first;
     dc->ring = tb_flags & XTENSA_TBFLAG_RING_MASK;
     dc->cring = (tb_flags & XTENSA_TBFLAG_EXCM) ? 0 : dc->ring;
@@ -1248,8 +1247,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
 void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     xtensa_isa isa = env->config->isa;
     int i, j;
 
-- 
2.41.0


