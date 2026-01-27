Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F01D2F028
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiwG-0007GQ-BW; Tue, 27 Jan 2026 08:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiwB-0007Cw-Lq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:57 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkiw8-0004c0-Bi
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:16:55 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso40334525ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769519811; x=1770124611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLrX4WceHRAasUz6JVBvvYnwaCVndNcPYB7jYphsrzg=;
 b=k+iU+CyWnAZasRTk9bewJX1ngJHKG1Iew8xACU7WJtKpXS6jZZWCiNntN+1je1Qf6w
 FrIcb5p4InRu9il/TgrxFnIgd0eDnedncb+rEujlcNKL7EwDXrb5ZkDcs7zBXOnGZ5oc
 uNIHWGOKzISUy2jptBzRnpkcYlOBFrqJOzy+AaIYwJITGkd6IypDIccZZwRhxpfY47rj
 BjmSNKXE9fiYv5lI6VJT/xsPCMPR07PsSwmV3IX+gFR2D5Vvr1zjdGMSTG+coTaiL9dn
 VVE0NOfpCCojKhCiJlLhWC3kp2m6Gnzhl/pSFZYF8QIe5kOaZI5A4TT9c4k44KOxhqak
 M+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769519811; x=1770124611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VLrX4WceHRAasUz6JVBvvYnwaCVndNcPYB7jYphsrzg=;
 b=eGeKdM44aZKB7Ynn0JBo3J3WPj1y3a5d+eW1x7Fuz3d8hGmxEaYcasOpz0k6PbdDTw
 gTd6cB9HAWA0Yyng/UwAWWwoMG6S3ngbn7iP6iq0yuSEAyrhinBb0S7d/en+xHpLssu/
 Dzr38diCxfphTyih/+rN7E9EaBd8H4iykPvgZL0FsjmlQDtiHIwlWjbinwRt4c8R7pZS
 QemcaNavlUlXZKeT1dreZhT6riQczw8/sXSe6fneV+Z2DH35pk6nw5EkFgmEU/Lf1CnY
 +4BdRXFAwcufbwRkhfc6c+Rk/VKO62cd0VCCY+JoaQBm/oGmMElipu1bKKMhdq1bLUm+
 sReA==
X-Gm-Message-State: AOJu0YyUPGv07GrHKSwhPMoJVUZA19mduuTsfgfXy7IESl71CUQzS/ak
 k+PuMMspx7qFD5HCHCu6LZYi+NnY/bW6dBdjMTeozI5uFbNTXotlzcd3
X-Gm-Gg: AZuq6aJgRstMSI2jlprLArEHYMAS9KjLSoeu5L+A0TVIsnDDPL4/nwuso5fp9ROkxeo
 raMYwis6imh5DM04N4qUKJnri+vFUOT8V1hvecIlk8rU1jvcCV8DAPgcm2WTstcfOhN9KYtfqqi
 1EsDDo/WCpONQwgDuGkskVj9kLuQk7vWftvhtayZaMtCRnyfTFUhQdIf1r6YD9Lkozcmk74Hmd3
 Ogvug/i+mOgKjRg/yBWBPLD3FG4BV0Pr9KBeLCLzMNJWQEAqUFFh2gTXJ5mrtV8VQ8BH9xdH8m/
 RmWjn8eoNGljAz29p3bc3g4J0xkCAfk9+wlFRlto/0SEE3AmSmKE4Skbc1ii0ZakWA7eMnbcRDv
 xcoRq9RgxLc9UehnVmIDoh3wxPI/mxH/mFqYSf7XpQ9MR9mfv+QtSGsOCJ++GSfyAk1vViDSmeI
 Fqq/LwTOlbWg0AZJK1qWtMjAiQ+ischYVsQpgehOzIimXeJcYoX67DGbo+UxQ=
X-Received: by 2002:a17:903:3d05:b0:2a7:5e7a:5e80 with SMTP id
 d9443c01a7336-2a871366f2cmr14075935ad.26.1769519810726; 
 Tue, 27 Jan 2026 05:16:50 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.23.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb03b4sm117164345ad.82.2026.01.27.05.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 05:16:50 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v3 6/7] target/riscv: add sdext single-step support
Date: Tue, 27 Jan 2026 21:15:50 +0800
Message-ID: <07fc1ddebad14dad52bdaf4937ca93c6399e5840.1769517768.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
References: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 include/exec/translation-block.h |  4 ++--
 target/riscv/cpu.h               |  2 ++
 target/riscv/cpu_helper.c        |  6 ++++++
 target/riscv/helper.h            |  1 +
 target/riscv/op_helper.c         | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c       |  5 +++++
 target/riscv/translate.c         | 15 +++++++++++++--
 7 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 40cc699031..ee15608c89 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -64,8 +64,8 @@ struct TranslationBlock {
      * x86: the original user, the Code Segment virtual base,
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
-     * sparc: the next pc of the instruction queue (for delay slots).
-     * riscv: an extension of tb->flags,
+     * sparc: the next pc of the instruction queue (for delay slots),
+     * riscv: an extension of tb->flags.
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a2509e002..805fe23411 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -712,6 +712,8 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+/* sdext single-step needs a TB flag to build 1-insn TBs */
+FIELD(EXT_TB_FLAGS, SDEXT_STEP, 33, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 05a991fccc..2ca6040d20 100644
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
index 1bdef55d9a..935ebfdeb2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -193,6 +193,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
+    }
+#endif
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f687c75fe4..894fb27727 100644
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
@@ -1338,6 +1347,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
+    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1388,7 +1398,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
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


