Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF273C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmbc-00064G-Bm; Wed, 24 Apr 2024 20:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmb1-0005GV-Ta
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmau-0007uG-PW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso3632065ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003447; x=1714608247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fX2m1kkCbS1cMj7VDlXMqT9akuCODLBKcZuUdZRgdS0=;
 b=FdAOSXzRCGZtejBX1rult38Iqo/hxd/fzvEmjyQL6FvXlMTpX5/MxoOL3MpCdqig2f
 OiwFRws0VCLvYkJpJ+vxpsUb3WO+kAkgrEFm5Rafh/J+lfKFkfR0bcl9q+QaUz6iMWAr
 BySQjy6cCXm7PBudvdrnD1jbiOCfdEJ9jULqs3CCEEkpt9HnZ2c+XkLiluRLooa33gOn
 LPpATeIkpFAwMfzdVfHoMw0NIllOpuIeKZodGL9sVtDJfkZqIbxODnp5znPhMmz+DV0p
 tJaMAknA6Jq4Xnfcq2a6szzWRDaHo9o7eddDRlBp0masKELA3CoUzMijjp/gbRObmh7Q
 euog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003447; x=1714608247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fX2m1kkCbS1cMj7VDlXMqT9akuCODLBKcZuUdZRgdS0=;
 b=hXN+Rg4uzdc7BPRpbSfJSt6bJobNPmzdNNIxdEhrU/+9r5JphcRej2Hj+LR+Od6gAk
 5GfmFQB0cBH3rl6niJJSJcOf4Sz1a9HBoug63PME+/qpwgHXs2QkuT6Gfa9wrks0zgb7
 WvlivhHsmdgRJbZ7fawhMDrH8emIp5GuCDqRPpGHqZJPpTn5PnJwlo4Zxzh2duJw2KTk
 aWFkO3l2YVlmMSra59EbLTkBFTvzrZXRpEIEC13U6RhQlMnNLPRWottR1H1iB62dnlw1
 /5YHRmGSsQbSNkSipbCxHuTmGiO2U2KkbFSEeN7GN0jLXKxf7A0W64R9sZcoErklFJoM
 HOBg==
X-Gm-Message-State: AOJu0Yy6HuJzNEo44BxH+G4HO0n9rHVAh8hTUZ+I/J8tsVj3PxjHRGlc
 iz/rBh9EF6y5SkpX6XO8iBBmoJ5O6PnjFMIdz/5GatVzcbgpdYZ4Q6x1ddhHyj+5bPvJLw4uLyh
 Y
X-Google-Smtp-Source: AGHT+IFVTskk/VFAQdu8r0CfALb8aB8H+a4N+n5bFabBuhia+Mo3B1cndUg0eC6bbyXcVyFE81+DCg==
X-Received: by 2002:a17:902:db07:b0:1e8:32ed:6f6d with SMTP id
 m7-20020a170902db0700b001e832ed6f6dmr5126513plx.39.1714003446782; 
 Wed, 24 Apr 2024 17:04:06 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001e0648dfd68sm12483717plb.296.2024.04.24.17.04.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:04:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/45] target/hppa: Implement PSW_H, PSW_L
Date: Wed, 24 Apr 2024 17:00:21 -0700
Message-Id: <20240425000023.1002026-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index 42c413211a..5adbe0fe9c 100644
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
index 7ad7aa675d..4126995604 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -55,6 +55,7 @@ typedef struct DisasDelayException {
     TCGLabel *lab;
     uint32_t insn;
     bool set_iir;
+    bool set_b;
     int8_t set_n;
     uint8_t excp;
     /* Saved state at parent insn. */
@@ -744,6 +745,7 @@ static DisasDelayException *delay_excp(DisasContext *ctx, uint8_t excp)
     e->insn = ctx->insn;
     e->set_iir = true;
     e->set_n = ctx->psw_n_nonzero ? 0 : -1;
+    e->set_b = false;
     e->excp = excp;
     e->iaq_f = ctx->iaq_f;
     e->iaq_b = ctx->iaq_b;
@@ -1872,6 +1874,54 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
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
@@ -2009,10 +2059,12 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
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
@@ -2033,6 +2085,7 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
     nullify_over(ctx);
     install_link(ctx, link, with_sr0);
 
+    do_priv_branch_trap(ctx, maybe_priv, &ctx->iaq_j, is_n);
     if (!do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
         if (is_n && use_nullify_skip(ctx)) {
             install_iaq_entries(ctx, &ctx->iaq_j, NULL);
@@ -3993,7 +4046,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     tcg_gen_addi_i64(ctx->iaq_j.base, load_gpr(ctx, a->b), a->disp);
     ctx->iaq_j.base = do_ibranch_priv(ctx, ctx->iaq_j.base);
 
-    return do_ibranch(ctx, a->l, true, a->n);
+    return do_ibranch(ctx, a->l, true, a->n, ctx->privilege == 3 ? 0 : 1);
 }
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
@@ -4042,7 +4095,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
     }
 
     if (indirect) {
-        return do_ibranch(ctx, 0, false, a->n);
+        return do_ibranch(ctx, 0, false, a->n, -1);
     }
     return do_dbranch(ctx, disp, 0, a->n);
 }
@@ -4060,7 +4113,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         tcg_gen_add_i64(t0, t0, t1);
 
         ctx->iaq_j = iaqe_next_absv(ctx, t0);
-        return do_ibranch(ctx, a->l, false, a->n);
+        return do_ibranch(ctx, a->l, false, a->n, 0);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
         return do_dbranch(ctx, 0, a->l, a->n);
@@ -4081,7 +4134,7 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
     dest = do_ibranch_priv(ctx, dest);
     ctx->iaq_j = iaqe_next_absv(ctx, dest);
 
-    return do_ibranch(ctx, 0, false, a->n);
+    return do_ibranch(ctx, 0, false, a->n, ctx->privilege == 3 ? 0 : 1);
 }
 
 static bool trans_bve(DisasContext *ctx, arg_bve *a)
@@ -4094,7 +4147,7 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     ctx->iaq_j.base = do_ibranch_priv(ctx, b);
     ctx->iaq_j.disp = 0;
 
-    return do_ibranch(ctx, a->l, false, a->n);
+    return do_ibranch(ctx, a->l, false, a->n, ctx->privilege == 3 ? 0 : 1);
 }
 
 static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
@@ -4852,6 +4905,9 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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


