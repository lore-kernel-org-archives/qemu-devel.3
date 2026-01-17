Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6066ED4A5F5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxup-000141-Fp; Fri, 16 Jan 2026 23:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxun-00012S-VJ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:57 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxul-0001by-VR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:57 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so1921736b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624075; x=1769228875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RH8MgotqlFns+p/ybTV+cssRJMwpCx8aTxqyahAdRls=;
 b=LGEE6a9sRf3Hr40lGQhK0/o3Xn65dEQwxBV/fjqVMiCqcMG0Im2+1vtGcskp1xKU7B
 xvNRv99xEN9hcYwBO7coEVkECr3gTFEcbXr4OGodbLLdX1Gz8MXFaH0OVzpCLLhO9MDl
 qdLkNMgPKv7Nsrf78mzQ+uWn2KjRy9LYOsM61HeaNHLMn1elzJG7pYAhV777AgLD8oIC
 UKGNzrxkRxMvPdl2+rghG5Jl74eiuwB3FuYwjwpQfG8oPMzPXRVuUwxnQKpBA9xLqBdU
 kgoSqEb4qJ2qH/BJOHlGm+haC65pEGmI7jDmgig2QijA+puAYnJG25BFXLb4XTKeHfVA
 uTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624075; x=1769228875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RH8MgotqlFns+p/ybTV+cssRJMwpCx8aTxqyahAdRls=;
 b=hQAHBo1So2uvg50Oi5LdnjF+qf0yT0AOCG2qriX7Una1/wYQaj75P1ZWV0XRggtdC2
 fRyUpo2HhaFFawiaDbLtyV+gcQxecDxTpsDU8Qvhu6fcC815M504ENaG0FF+yH04kTuJ
 cWUlKezYU8ByPgxHm+QLH+cMvu9M5kbc2zk7MqeNPbTAJFTNCYE7duplUB98cBdt9OlL
 M67HLvbBu1m3c06wligroh9nhb7rGRMlPVro0eJbelSxs7wXZeG4iwMJzwuiOZS/9iqK
 d+juHNTL1xTSGD7+WjlPp8lrjZEgj0LzSgf+6vIKuBOJel4UDkYmLJqTfKfxi8/sav7L
 6eBQ==
X-Gm-Message-State: AOJu0YwzNqoI/AumAWv3ft0zv5MSk4tQui0pb/gMxz19y5IdhdCVfUFN
 8f/dfFopBYyjm302/wE6lASmrvRZ2ltJtyc7NRicl74Va6pjvgANqttu
X-Gm-Gg: AY/fxX4d6X/NRgwRU3zZ1wW2aP9lAqblpX6Mqaf8JMK2+ey46h2RDXbfxQeF9aAWnGJ
 bZwU+2Iwuuj8Vql1iDZi9btjRTj0M38QzMTzhNW7r2ZHZtUuTT3/Y+MHsJSC+qlRxHuLE8l5uPs
 zxmerkhyrz5K2PxydloffEh8E/nMU/ESGqEoAVo1XvXdgowa0WHXiN6/hZ61x8imxnGCKnS5Bpl
 WA8Lg77HH+apG6IStjTrOWNYYdLo61zXF0qMLWF/RuRsUxhzsv3+82pMeY4iTOQTtaBAs7639NC
 2x2cQJ5b0RfroUCmxUGQ9R71R0Run6otj6gXPwOVfEagoxQKWL0zs6mwL+eT4zg+afQG4EF89qP
 cf79TU55SMt+ZiClCPqCNy8yXvKMdb96K5rx2/77f9m3SlpWH+juUgHoarareLgJ4HkrfGieOAd
 9HOvgzDrJ2EB3UfwqWpMHbAcM/GDKhbZ2EP2fvvorue73oPnPb+pYa6gw80+/NQQ==
X-Received: by 2002:a05:6a21:6d9f:b0:2b9:6b0b:66be with SMTP id
 adf61e73a8af0-38dff2996bcmr5218891637.14.1768624074635; 
 Fri, 16 Jan 2026 20:27:54 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:54 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 6/8] riscv: add sdext single-step support
Date: Sat, 17 Jan 2026 12:27:27 +0800
Message-ID: <ce55286638a7c4bcfc6a9627151fdc3bd808077b.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Use a TB flag when dcsr.step is set (and we are not in Debug Mode).
When the flag is on, build 1-insn TBs and do not chain to the next TB.
Add a TB-exit helper that enters Debug Mode with cause=step and sets
dpc to the next pc, then stops with EXCP_DEBUG.

If dcsr.stepie is 0, do not take interrupts while stepping. Treat WFI
as a nop so the hart does not sleep during a step.

PS: This patch references Max Chou's handling of ext_tb_flags.
https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 include/exec/translation-block.h |  3 ++-
 target/riscv/cpu.h               |  3 +++
 target/riscv/cpu_helper.c        |  6 ++++++
 target/riscv/csr.c               | 21 +++++++--------------
 target/riscv/helper.h            |  1 +
 target/riscv/op_helper.c         | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c       |  9 ++++++++-
 target/riscv/translate.c         | 16 ++++++++++++++--
 8 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index cdce399eba..75188f56c8 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -62,7 +62,8 @@ struct TranslationBlock {
      * x86: the original user, the Code Segment virtual base,
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
-     * sparc: the next pc of the instruction queue (for delay slots).
+     * sparc: the next pc of the instruction queue (for delay slots),
+     * riscv: an extension of tb->flags.
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ca861aa5f8..fe37ae8458 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -712,6 +712,9 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
+/* sdext single-step needs a TB flag to build 1-insn TBs */
+FIELD(EXT_TB_FLAGS, SDEXT_STEP, 33, 1)
+
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 83d2aa1b75..d8905a5a1e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -638,6 +638,12 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
+
+        if (cpu->cfg.ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
+            return false;
+        }
+
         int interruptno = riscv_cpu_local_irq_pending(env);
         if (interruptno >= 0) {
             cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4a732b9364..8dff9615c4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3171,15 +3171,10 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-#ifndef CONFIG_USER_ONLY
-static bool riscv_sdext_available(CPURISCVState *env)
-{
-    return riscv_cpu_cfg(env)->ext_sdext;
-}
-
-static RISCVException dcsr_predicate(CPURISCVState *env, int csrno)
+#if !defined(CONFIG_USER_ONLY)
+static RISCVException sdext(CPURISCVState *env, int csrno)
 {
-    if (!riscv_sdext_available(env)) {
+    if (!riscv_cpu_cfg(env)->ext_sdext) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -6440,12 +6435,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TINFO]     =  { "tinfo",    sdtrig, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", sdtrig, read_mcontext, write_mcontext },
 #if !defined(CONFIG_USER_ONLY)
-    [CSR_DCSR]      =  { "dcsr", dcsr_predicate, read_dcsr, write_dcsr },
-    [CSR_DPC]       =  { "dpc", dcsr_predicate, read_dpc, write_dpc },
-    [CSR_DSCRATCH]  =  { "dscratch0", dcsr_predicate,
-                         read_dscratch, write_dscratch },
-    [CSR_DSCRATCH1] =  { "dscratch1", dcsr_predicate,
-                         read_dscratch, write_dscratch },
+    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
+    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
+    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
+    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
 #endif
 
     [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index acff73051b..0b709c2b99 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -141,6 +141,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_1(sdext_step, void, env)
 DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index dfe5388ab7..6fe29ce905 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -470,6 +470,22 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_step(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    CPUState *cs = env_cpu(env);
+
+    if (!riscv_cpu_cfg(env)->ext_sdext || env->debug_mode ||
+        !(env->dcsr & DCSR_STEP)) {
+        return;
+    }
+
+    riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_STEP);
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit_restore(cs, GETPC());
+#endif
+}
+
 void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
 {
 #ifndef CONFIG_USER_ONLY
@@ -604,6 +620,10 @@ void helper_wfi(CPURISCVState *env)
                (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
+        if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP)) {
+            return;
+        }
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2b543ced07..0426855145 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    uint64_t ext_flags = 0;
     bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     if (cpu->cfg.ext_zve32x) {
@@ -189,10 +190,16 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
+    }
+#endif
+
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
         .flags = flags,
-        .cs_base = env->misa_ext,
+        .cs_base = ext_flags,
     };
 }
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd..4660387164 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -110,6 +110,8 @@ typedef struct DisasContext {
     bool ztso;
     /* Use icount trigger for native debug */
     bool itrigger;
+    /* Enter Debug Mode after next instruction (sdext single-step). */
+    bool sdext_step;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
     bool insn_start_updated;
@@ -284,6 +286,9 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_lookup_and_goto_ptr();
 }
@@ -294,6 +299,9 @@ static void exit_tb(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_exit_tb(NULL, 0);
 }
@@ -307,7 +315,8 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
       * Under itrigger, instruction executes one by one like singlestep,
       * direct block chain benefits will be small.
       */
-    if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
+    if (translator_use_goto_tb(&ctx->base, dest) &&
+        !ctx->itrigger && !ctx->sdext_step) {
         /*
          * For pcrel, the pc must always be up-to-date on entry to
          * the linked TB, so that it can use simple additions for all
@@ -1297,6 +1306,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
 
     ctx->pc_save = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
@@ -1333,6 +1343,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
+    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1383,7 +1394,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
+        if (ctx->itrigger || ctx->sdext_step ||
+            !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         } else {
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
-- 
2.52.0


