Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379E4C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QSb-0005Lf-BD; Mon, 13 May 2024 03:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSY-0005Fa-CM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSU-0001ys-PV
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34e28e32ea4so2520443f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586652; x=1716191452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCHFJTxzbMF9g7JeklKIvaDk4C3waKBc8x9CK61ly5Y=;
 b=hZ8SHGQ0FaQqz58qvOGKFAfxQVQd0RkMHoa9ybqyjfH07sEOtgdxSO8zG7rYU7S6/g
 x2r8dNftgYTZIh2KOhjJRx/4RNJVpZzLLHgERLvOhWeDFrF6J5ZHF//TAA5ot8c/NWAU
 Y39f0/fkUC211pF3LffdRX3Q72sxpwHCyLcSDzVTb8suXh1eT4i+ivOss+Cw0iOpN66r
 Nxa8XcYm7rk+82VpjdZgeUwjTowMxeVFOqEYuGQQ33EsXfsGOg605RIvK5gJeof9sbeo
 VjB/CmRbm/Jn8EZmGm0QVLNccxMxundbjXpk78Mw04zLBykQJ4qVqgfocvPO996BKVW7
 JfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586652; x=1716191452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCHFJTxzbMF9g7JeklKIvaDk4C3waKBc8x9CK61ly5Y=;
 b=vKOOZFysk5k1cyPZNd/AIUT8bchThyVimND7kUA0Og3Br3w/WGkKv00qOTOd7b2Hgv
 lC9V/ZV9rc7SBBt4Me4UHbQxQqPEhQvHyVAAxXfag+krQ5dAUye0gFZov33OSJX2VZW6
 tZfqLveqa0QiRV/w9k/HN4aAGjT4va5UfFkNTpJLB6vCYFtgWSbNLt9mhIOPfJMwSWbb
 4YD2HAJCdjEktVXqjWRmZdx5U3r1pCKLlaKtAj0VUWt4vOIRlUc77aqQodi8qlb0CV5z
 d2zze0G3j4k/10GW+FymnhQukEEgTzKNrphtxpPY0MpE/Vg329a+jlQTop2RBhHsusnL
 y9nw==
X-Gm-Message-State: AOJu0Yx0G2I25PzjbW1TJDTGtKFIaYpGBjtZiPnTitIM2azN5wX6yN8H
 WcuHK2CKscSzFCvj0oLTe3XbYMVMuQKwmwn7x3yOCemMlgleaahoz0+TPiC4OeyKhP6pdHuHY0j
 GO9k=
X-Google-Smtp-Source: AGHT+IES+hZdn2C6NOO4IdyPobSe6yHwppL+vXcdU8FtqDw0HQQwiHbF9ntrx/Yh5HN/P3B9lvFc5A==
X-Received: by 2002:adf:e586:0:b0:34c:b2df:6f01 with SMTP id
 ffacd0b85a97d-3504a737f13mr6043289f8f.21.1715586652215; 
 Mon, 13 May 2024 00:50:52 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a50sm10374262f8f.30.2024.05.13.00.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:50:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 43/45] target/hppa: Implement PSW_H, PSW_L
Date: Mon, 13 May 2024 09:47:15 +0200
Message-Id: <20240513074717.130949-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
 target/hppa/cpu.c       |  4 +--
 target/hppa/translate.c | 68 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 2a3b5fc498..f53e5a2788 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -76,10 +76,10 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
         cs_base |= env->iaoq_b & ~TARGET_PAGE_MASK;
     }
 
-    /* ??? E, H, L bits need to be here, when implemented.  */
+    /* ??? E bits need to be here, when implemented.  */
     flags |= env->psw_n * PSW_N;
     flags |= env->psw_xb;
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P | PSW_T);
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_H | PSW_L | PSW_P | PSW_T);
 
 #ifdef CONFIG_USER_ONLY
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2290dc8533..3ccec023af 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -56,6 +56,7 @@ typedef struct DisasDelayException {
     TCGLabel *lab;
     uint32_t insn;
     bool set_iir;
+    bool set_b;
     int8_t set_n;
     uint8_t excp;
     /* Saved state at parent insn. */
@@ -745,6 +746,7 @@ static DisasDelayException *delay_excp(DisasContext *ctx, uint8_t excp)
     e->insn = ctx->insn;
     e->set_iir = true;
     e->set_n = ctx->psw_n_nonzero ? 0 : -1;
+    e->set_b = false;
     e->excp = excp;
     e->iaq_f = ctx->iaq_f;
     e->iaq_b = ctx->iaq_b;
@@ -1873,6 +1875,54 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
     return nullify_end(ctx);
 }
 
+/*
+ * Since B,GATE can only increase priv, and other indirect branches can
+ * only decrease priv, we only need to test in one direction.
+ * If maybe_priv == 0, no priv is possible with the current insn;
+ * if maybe_priv < 0, priv might increase, otherwise priv might decrease.
+ */
+static void do_priv_branch_trap(DisasContext *ctx, int maybe_priv,
+                                DisasIAQE *next, bool n)
+{
+    DisasDelayException *e;
+    uint32_t psw_bit, excp;
+    TCGv_i64 new_priv;
+    TCGCond cond;
+
+    if (likely(maybe_priv == 0)) {
+        return;
+    }
+    if (maybe_priv < 0) {
+        psw_bit = PSW_H;
+        excp = EXCP_HPT;
+        cond = TCG_COND_LTU;
+    } else {
+        psw_bit = PSW_L;
+        excp = EXCP_LPT;
+        cond = TCG_COND_GTU;
+    }
+    if (likely(!(ctx->tb_flags & psw_bit))) {
+        return;
+    }
+
+    e = tcg_malloc(sizeof(DisasDelayException));
+    memset(e, 0, sizeof(*e));
+    e->next = ctx->delay_excp_list;
+    ctx->delay_excp_list = e;
+
+    e->lab = gen_new_label();
+    e->set_n = n ? 1 : ctx->psw_n_nonzero ? 0 : -1;
+    e->set_b = ctx->psw_xb != PSW_B;
+    e->excp = excp;
+    e->iaq_f = ctx->iaq_b;
+    e->iaq_b = *next;
+
+    new_priv = tcg_temp_new_i64();
+    copy_iaoq_entry(ctx, new_priv, next);
+    tcg_gen_andi_i64(new_priv, new_priv, 3);
+    tcg_gen_brcondi_i64(cond, new_priv, ctx->privilege, e->lab);
+}
+
 static bool do_taken_branch_trap(DisasContext *ctx, DisasIAQE *next, bool n)
 {
     if (unlikely(ctx->tb_flags & PSW_T)) {
@@ -2010,10 +2060,12 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
  * This handles nullification of the branch itself.
  */
 static bool do_ibranch(DisasContext *ctx, unsigned link,
-                       bool with_sr0, bool is_n)
+                       bool with_sr0, bool is_n, int maybe_priv)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, with_sr0);
+
+        do_priv_branch_trap(ctx, maybe_priv, &ctx->iaq_j, is_n);
         if (do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
             return true;
         }
@@ -2034,6 +2086,7 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
     nullify_over(ctx);
     install_link(ctx, link, with_sr0);
 
+    do_priv_branch_trap(ctx, maybe_priv, &ctx->iaq_j, is_n);
     if (!do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
         if (is_n && use_nullify_skip(ctx)) {
             install_iaq_entries(ctx, &ctx->iaq_j, NULL);
@@ -3994,7 +4047,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     tcg_gen_addi_i64(ctx->iaq_j.base, load_gpr(ctx, a->b), a->disp);
     ctx->iaq_j.base = do_ibranch_priv(ctx, ctx->iaq_j.base);
 
-    return do_ibranch(ctx, a->l, true, a->n);
+    return do_ibranch(ctx, a->l, true, a->n, ctx->privilege == 3 ? 0 : 1);
 }
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
@@ -4043,7 +4096,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
     }
 
     if (indirect) {
-        return do_ibranch(ctx, 0, false, a->n);
+        return do_ibranch(ctx, 0, false, a->n, -1);
     }
     return do_dbranch(ctx, disp, 0, a->n);
 }
@@ -4061,7 +4114,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         tcg_gen_add_i64(t0, t0, t1);
 
         ctx->iaq_j = iaqe_next_absv(ctx, t0);
-        return do_ibranch(ctx, a->l, false, a->n);
+        return do_ibranch(ctx, a->l, false, a->n, 0);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
         return do_dbranch(ctx, 0, a->l, a->n);
@@ -4082,7 +4135,7 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
     dest = do_ibranch_priv(ctx, dest);
     ctx->iaq_j = iaqe_next_absv(ctx, dest);
 
-    return do_ibranch(ctx, 0, false, a->n);
+    return do_ibranch(ctx, 0, false, a->n, ctx->privilege == 3 ? 0 : 1);
 }
 
 static bool trans_bve(DisasContext *ctx, arg_bve *a)
@@ -4095,7 +4148,7 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     ctx->iaq_j.base = do_ibranch_priv(ctx, b);
     ctx->iaq_j.disp = 0;
 
-    return do_ibranch(ctx, a->l, false, a->n);
+    return do_ibranch(ctx, a->l, false, a->n, ctx->privilege == 3 ? 0 : 1);
 }
 
 static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
@@ -4853,6 +4906,9 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (e->set_n >= 0) {
             tcg_gen_movi_i64(cpu_psw_n, e->set_n);
         }
+        if (e->set_b) {
+            tcg_gen_movi_i32(cpu_psw_xb, PSW_B);
+        }
         if (e->set_iir) {
             tcg_gen_st_i64(tcg_constant_i64(e->insn), tcg_env,
                            offsetof(CPUHPPAState, cr[CR_IIR]));
-- 
2.34.1


