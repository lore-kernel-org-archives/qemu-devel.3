Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD2FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8h-0000f1-OB; Wed, 15 May 2024 05:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8O-0006wP-4a
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:16 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8K-0001if-3l
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:15 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34f7d8bfaa0so4554421f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766071; x=1716370871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTXjrqHLm9JH8e5dSGpKeq4vzWp/XOEH4I3ff7qowb0=;
 b=a0YENjc8sL1VAgPYK0Kc6J+t2iUczNpAxhgwr0p/AlmMY7ofqMaCnrLFDdrsHbBw+D
 ON3yy4N6T8M1o91ji3pv1PS04K1g6VnMwEmf4o7DsCpEwOI+9QDFHBOsb7ha+hVpEF5U
 9ztBiaKanoHDQjVyR0XDgnpf4aTGkVBmB2kdZcJtUs7HAd14x+9dzeMvuB1gkjqLnyyK
 POGiH9be1SUzDSaH0+wiVfiQmECsU85bEOWak1y5YwB2K8LNdU2FTJd3H5gvvec17S1+
 4EBuJ2gl2mdBK5sd1sAVjn937eIoweO8/JqYt4dVSWekGdUJMCS2jzcgYcoCHnzMZ3Dt
 D07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766071; x=1716370871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTXjrqHLm9JH8e5dSGpKeq4vzWp/XOEH4I3ff7qowb0=;
 b=v7uXcaC/eofHJ9gUuR/EeGDpXk544+rYWTLS/xSXSGRJSxEl15Naht8+jR3MEqa+58
 C6+1eA3SSopXUFNOM/g1MCOY5yOUheDVSjbaV4g/xWKnlgzZPIT62w4uHxAAbpfUkqSx
 Q476JH0ksgpWfADxqL7xwU2Z5jC3dQFsaj27bRTS8eepN7ew/ljEEUnxT+oqbSxpr0kM
 M8oFwROf6K8OgMFGUf6gqy78YkXpLnBWd5flH8btFq0TCbZEMt2MODGnJDBZduETEWOj
 n3WTOTwR8VFtfrdJkKYCbumYP2MWP2OTfHLCmf1JXD+E+I4UgSU55VSzHH1yo+v9QdOV
 zsow==
X-Gm-Message-State: AOJu0YwZS5mKXXRfTc7wV3mCtZS4AR6P5OpPGPjQHzZCsSF/1HHpu7Hr
 5RqbFK4r0LkdswJ1hKucSAOmwx5xsnYWGMLicj6D+n7Zw5Q6/kXviTddJhBFjcvKXc0tCuiSMBR
 zZFE=
X-Google-Smtp-Source: AGHT+IEYU5hjdWkHGznY1NJ8OJNZuMlA1K8to7EnH99xEQ3JL6vHWEWyC7VfAk6IB/9/iKW1Ph7TIA==
X-Received: by 2002:a5d:4d43:0:b0:341:d8a9:5b7d with SMTP id
 ffacd0b85a97d-3504a736e33mr11999874f8f.28.1715766070730; 
 Wed, 15 May 2024 02:41:10 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 36/43] target/hppa: Manage PSW_X and PSW_B in translator
Date: Wed, 15 May 2024 11:40:36 +0200
Message-Id: <20240515094043.82850-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

PSW_X is cleared after every instruction, and only set by RFI.
PSW_B is cleared after every non-branch, or branch not taken,
and only set by taken branches.  We can clear both bits with a
single store, at most once per TB.  Taken branches set PSW_B,
at most once per TB.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c       | 10 ++++++---
 target/hppa/translate.c | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 003af63e20..5f0df0697a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -50,7 +50,7 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
                           uint64_t *pcsbase, uint32_t *pflags)
 {
-    uint32_t flags = env->psw_n * PSW_N;
+    uint32_t flags = 0;
     uint64_t cs_base = 0;
 
     /*
@@ -80,11 +80,14 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
         cs_base |= env->iaoq_b & ~TARGET_PAGE_MASK;
     }
 
+    /* ??? E, T, H, L bits need to be here, when implemented.  */
+    flags |= env->psw_n * PSW_N;
+    flags |= env->psw_xb;
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
+
 #ifdef CONFIG_USER_ONLY
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
 #else
-    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
     if ((env->sr[4] == env->sr[5])
         & (env->sr[4] == env->sr[6])
         & (env->sr[4] == env->sr[7])) {
@@ -103,6 +106,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs,
 
     /* IAQ is always up-to-date before goto_tb. */
     cpu->env.psw_n = (tb->flags & PSW_N) != 0;
+    cpu->env.psw_xb = tb->flags & (PSW_X | PSW_B);
 }
 
 static void hppa_restore_state_to_opc(CPUState *cs,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ab8dd161ad..f7d54f4009 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -84,7 +84,9 @@ typedef struct DisasContext {
     uint32_t tb_flags;
     int mmu_idx;
     int privilege;
+    uint32_t psw_xb;
     bool psw_n_nonzero;
+    bool psw_b_next;
     bool is_pa20;
     bool insn_start_updated;
 
@@ -263,6 +265,7 @@ static TCGv_i64 cpu_psw_n;
 static TCGv_i64 cpu_psw_v;
 static TCGv_i64 cpu_psw_cb;
 static TCGv_i64 cpu_psw_cb_msb;
+static TCGv_i32 cpu_psw_xb;
 
 void hppa_translate_init(void)
 {
@@ -315,6 +318,9 @@ void hppa_translate_init(void)
         *v->var = tcg_global_mem_new(tcg_env, v->ofs, v->name);
     }
 
+    cpu_psw_xb = tcg_global_mem_new_i32(tcg_env,
+                                        offsetof(CPUHPPAState, psw_xb),
+                                        "psw_xb");
     cpu_iasq_f = tcg_global_mem_new_i64(tcg_env,
                                         offsetof(CPUHPPAState, iasq_f),
                                         "iasq_f");
@@ -509,6 +515,25 @@ static void load_spr(DisasContext *ctx, TCGv_i64 dest, unsigned reg)
 #endif
 }
 
+/*
+ * Write a value to psw_xb, bearing in mind the known value.
+ * To be used just before exiting the TB, so do not update the known value.
+ */
+static void store_psw_xb(DisasContext *ctx, uint32_t xb)
+{
+    tcg_debug_assert(xb == 0 || xb == PSW_B);
+    if (ctx->psw_xb != xb) {
+        tcg_gen_movi_i32(cpu_psw_xb, xb);
+    }
+}
+
+/* Write a value to psw_xb, and update the known value. */
+static void set_psw_xb(DisasContext *ctx, uint32_t xb)
+{
+    store_psw_xb(ctx, xb);
+    ctx->psw_xb = xb;
+}
+
 /* Skip over the implementation of an insn that has been nullified.
    Use this when the insn is too complex for a conditional move.  */
 static void nullify_over(DisasContext *ctx)
@@ -576,6 +601,8 @@ static bool nullify_end(DisasContext *ctx)
     /* For NEXT, NORETURN, STALE, we can easily continue (or exit).
        For UPDATED, we cannot update on the nullified path.  */
     assert(status != DISAS_IAQ_N_UPDATED);
+    /* Taken branches are handled manually. */
+    assert(!ctx->psw_b_next);
 
     if (likely(null_lab == NULL)) {
         /* The current insn wasn't conditional or handled the condition
@@ -1843,6 +1870,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 nullify_set(ctx, 0);
+                store_psw_xb(ctx, 0);
                 gen_goto_tb(ctx, 0, &ctx->iaq_j, NULL);
                 ctx->base.is_jmp = DISAS_NORETURN;
                 return true;
@@ -1850,20 +1878,24 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
         ctx->iaq_n = &ctx->iaq_j;
+        ctx->psw_b_next = true;
     } else {
         nullify_over(ctx);
 
         install_link(ctx, link, false);
         if (is_n && use_nullify_skip(ctx)) {
             nullify_set(ctx, 0);
+            store_psw_xb(ctx, 0);
             gen_goto_tb(ctx, 0, &ctx->iaq_j, NULL);
         } else {
             nullify_set(ctx, is_n);
+            store_psw_xb(ctx, PSW_B);
             gen_goto_tb(ctx, 0, &ctx->iaq_b, &ctx->iaq_j);
         }
         nullify_end(ctx);
 
         nullify_set(ctx, 0);
+        store_psw_xb(ctx, 0);
         gen_goto_tb(ctx, 1, &ctx->iaq_b, NULL);
         ctx->base.is_jmp = DISAS_NORETURN;
     }
@@ -1894,6 +1926,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     n = is_n && disp < 0;
     if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
+        store_psw_xb(ctx, 0);
         next = iaqe_incr(&ctx->iaq_b, 4);
         gen_goto_tb(ctx, 0, &next, NULL);
     } else {
@@ -1902,6 +1935,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
             ctx->null_lab = NULL;
         }
         nullify_set(ctx, n);
+        store_psw_xb(ctx, 0);
         gen_goto_tb(ctx, 0, &ctx->iaq_b, NULL);
     }
 
@@ -1913,9 +1947,11 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     next = iaqe_branchi(ctx, disp);
     if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
+        store_psw_xb(ctx, 0);
         gen_goto_tb(ctx, 1, &next, NULL);
     } else {
         nullify_set(ctx, n);
+        store_psw_xb(ctx, PSW_B);
         gen_goto_tb(ctx, 1, &ctx->iaq_b, &next);
     }
 
@@ -1949,6 +1985,7 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
         ctx->iaq_n = &ctx->iaq_j;
+        ctx->psw_b_next = true;
         return true;
     }
 
@@ -1958,9 +1995,11 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
     if (is_n && use_nullify_skip(ctx)) {
         install_iaq_entries(ctx, &ctx->iaq_j, NULL);
         nullify_set(ctx, 0);
+        store_psw_xb(ctx, 0);
     } else {
         install_iaq_entries(ctx, &ctx->iaq_b, &ctx->iaq_j);
         nullify_set(ctx, is_n);
+        store_psw_xb(ctx, PSW_B);
     }
 
     tcg_gen_lookup_and_goto_ptr();
@@ -2387,6 +2426,7 @@ static bool trans_halt(DisasContext *ctx, arg_halt *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
+    set_psw_xb(ctx, 0);
     nullify_over(ctx);
     gen_helper_halt(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -2398,6 +2438,7 @@ static bool trans_reset(DisasContext *ctx, arg_reset *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
+    set_psw_xb(ctx, 0);
     nullify_over(ctx);
     gen_helper_reset(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -2792,6 +2833,9 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
         if ((rt == 10 || rt == 31) && r1 == rt && r2 == rt) { /* PAUSE */
             /* No need to check for supervisor, as userland can only pause
                until the next timer interrupt.  */
+
+            set_psw_xb(ctx, 0);
+
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
@@ -4576,6 +4620,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cs = cs;
     ctx->tb_flags = ctx->base.tb->flags;
     ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
+    ctx->psw_xb = ctx->tb_flags & (PSW_X | PSW_B);
 
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = PRIV_USER;
@@ -4662,6 +4707,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
          */
         ctx->iaq_n = NULL;
         memset(&ctx->iaq_j, 0, sizeof(ctx->iaq_j));
+        ctx->psw_b_next = false;
 
         if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
             ctx->null_cond.c = TCG_COND_NEVER;
@@ -4674,6 +4720,10 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
             ret = ctx->base.is_jmp;
             assert(ctx->null_lab == NULL);
         }
+
+        if (ret != DISAS_NORETURN) {
+            set_psw_xb(ctx, ctx->psw_b_next ? PSW_B : 0);
+        }
     }
 
     /* If the TranslationBlock must end, do so. */
-- 
2.34.1


