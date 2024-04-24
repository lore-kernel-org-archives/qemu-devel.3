Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FD5C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmJF-0001Cx-GU; Wed, 24 Apr 2024 19:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIi-00013b-Or
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:45:30 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIc-0002Lm-Tx
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:45:19 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-60275a82611so333889a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714002309; x=1714607109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+fYxFDEu9QUatBFkfchgNydxoYm4Cqsftsf9cDR/W3Q=;
 b=FjsID58iMBMDQywYxdXLmc/KZGgJRNP8mgU08ELBM7d0nTxoraNnV8d4MApqvqCiJ4
 wO+wMacBUxnK4j3i+0qeqSScT0KxjZMFhl6zT2mgKR6uY+5vUF5mjr0klRIt0E+3BSbu
 sy55kp6+SuAg3N5/vkOxl4BqAkPUoS6WLLd+fzpuapcU3ZkxIGLn6ORpfITazHNrTAB+
 in81g5IiUOh4h7aLl+B1u1pWjAN1EOmD7MSSw8H9moLR1gV3PPtY2SK7EZQhVtBx/bqQ
 k1SKjd4uic+0b9S0Fxug+V29C71GixcQdju20CHiE8kKuWUSxvLvtQYITYF6yVUVuJXk
 H4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714002309; x=1714607109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fYxFDEu9QUatBFkfchgNydxoYm4Cqsftsf9cDR/W3Q=;
 b=agb+7a/uzTG8SRYIk8c3ziHJuvipixcwAWjat2YwA31kYyCNmPF7UX7/mWJ85l6scJ
 j6gwv0SbqsdrEQu2bET2muEH7clWQPKJJ3M/q4fgva4QsZbTwAtKMcbWXitFBdhu06VL
 advHdZrzCaT8hqaz8WPlTNpKpM8jZu1PYT8IcXweDHQSUpbp98z25NsP+fQdiPk9fKvO
 oKTaJ+RsUUKk8EyNoejGuEHxYWHi/rug+m6KFFf6XSW8ze+bFWQfKaWVrS0q2L0+j+AS
 gH9A4vPz3BZMmq3bLBSXVkLWjuotLF3gU0rAKdaRLQHK+jbJYlmbenhZDSlWoGZVwTcV
 iogA==
X-Gm-Message-State: AOJu0YxImD1puW55LQ+wXQUXLnB99+iXwAUk3cMXXNmPuoBE0McEZ0cq
 AJ/lSevC/fUeMTSm6xsyik3b2+2+V5MFGEwdQGQx3vcUavLgQHF1vBEaXZPTZGpnQP9mYXeOGp2
 4
X-Google-Smtp-Source: AGHT+IGlLpX4y0na5L9tS6NUAMaruOj166H7Vdy5qsdhsz4SyZ7GBm8vIsNjQbeULUrqsGqyqRmtrA==
X-Received: by 2002:a05:6a20:9193:b0:1a7:7cae:24dc with SMTP id
 v19-20020a056a20919300b001a77cae24dcmr4858663pzd.5.1714002309294; 
 Wed, 24 Apr 2024 16:45:09 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f55100b001e49428f327sm12531642plf.176.2024.04.24.16.45.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:45:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/alpha: Implement CF_PCREL
Date: Wed, 24 Apr 2024 16:44:36 -0700
Message-Id: <20240424234436.995410-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424234436.995410-1-richard.henderson@linaro.org>
References: <20240424234436.995410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c       | 23 ++++++++++++++++++++++-
 target/alpha/translate.c | 29 +++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index f98d022671..0e2fbcb397 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -38,12 +38,27 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+static void alpha_cpu_synchronize_from_tb(CPUState *cs,
+                                          const TranslationBlock *tb)
+{
+    /* The program counter is always up to date with CF_PCREL. */
+    if (!(tb_cflags(tb) & CF_PCREL)) {
+        CPUAlphaState *env = cpu_env(cs);
+        env->pc = tb->pc;
+    }
+}
+
 static void alpha_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
     CPUAlphaState *env = cpu_env(cs);
-    env->pc = data[0];
+
+    if (tb_cflags(tb) & CF_PCREL) {
+        env->pc = (env->pc & TARGET_PAGE_MASK) | data[0];
+    } else {
+        env->pc = data[0];
+    }
 }
 
 static bool alpha_cpu_has_work(CPUState *cs)
@@ -78,6 +93,11 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+#ifndef CONFIG_USER_ONLY
+    /* Use pc-relative instructions in system-mode */
+    cs->tcg_cflags |= CF_PCREL;
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -190,6 +210,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 
 static const TCGCPUOps alpha_tcg_ops = {
     .initialize = alpha_translate_init,
+    .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 86402d96d5..db847e7a23 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -54,6 +54,9 @@ struct DisasContext {
     uint32_t tbflags;
     int mem_idx;
 
+    /* True if generating pc-relative code.  */
+    bool pcrel;
+
     /* implver and amask values for this CPU.  */
     int implver;
     int amask;
@@ -254,7 +257,12 @@ static void st_flag_byte(TCGv val, unsigned shift)
 
 static void gen_pc_disp(DisasContext *ctx, TCGv dest, int32_t disp)
 {
-    tcg_gen_movi_i64(dest, ctx->base.pc_next + disp);
+    uint64_t addr = ctx->base.pc_next + disp;
+    if (ctx->pcrel) {
+        tcg_gen_addi_i64(dest, cpu_pc, addr - ctx->base.pc_first);
+    } else {
+        tcg_gen_movi_i64(dest, addr);
+    }
 }
 
 static void gen_excp_1(int exception, int error_code)
@@ -433,8 +441,14 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
 static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
     if (translator_use_goto_tb(&ctx->base, ctx->base.pc_next + disp)) {
-        tcg_gen_goto_tb(idx);
-        gen_pc_disp(ctx, cpu_pc, disp);
+        /* With PCREL, PC must always be up-to-date. */
+        if (ctx->pcrel) {
+            gen_pc_disp(ctx, cpu_pc, disp);
+            tcg_gen_goto_tb(idx);
+        } else {
+            tcg_gen_goto_tb(idx);
+            gen_pc_disp(ctx, cpu_pc, disp);
+        }
         tcg_gen_exit_tb(ctx->base.tb, idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
@@ -2852,6 +2866,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     ctx->tbflags = ctx->base.tb->flags;
     ctx->mem_idx = alpha_env_mmu_index(env);
+    ctx->pcrel = ctx->base.tb->cflags & CF_PCREL;
     ctx->implver = env->implver;
     ctx->amask = env->amask;
 
@@ -2887,7 +2902,13 @@ static void alpha_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 
 static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    if (ctx->pcrel) {
+        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK);
+    } else {
+        tcg_gen_insn_start(dcbase->pc_next);
+    }
 }
 
 static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.34.1


