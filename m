Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353D1C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8M-0006kW-Jx; Wed, 15 May 2024 05:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B84-0005pA-Vn
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B83-0001dc-4Q
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-351ae94323aso3221994f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766053; x=1716370853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixJmGoyxJB9sbwoHJd6SpaODQZW3sNI1pPxi/MSBfJ0=;
 b=IIEHO7W2T5cnqyA2S7c3lylenjFSzbHqfbZErS1KxRcRg2B1IYwaBEfIgn9DcaFtH5
 oF558IFFGOG1VCd7jJyz6BcIkWPgtMWDlkpwn9cmjaatFhYjb93aRrUaal3VbhJumE/J
 1ZuRVzSjHxuvNHp0P4gpakW2UY3/kG6f8X766wSrmVjgN8Ewtg5Gz6ZBGppKWYEsaDF8
 3T9P8Z8XjPcffTlwBdogBgkYv9OO1zHFRoKAO7SuwocL11XJG7S1Snkqm/0pWrRqK9iG
 yHuEgpyMZy3iXTIl0JMV23IO8r2/4yiNgsBqPELlcCE1R9vD5cz70ciUuknFtViiIZw5
 zlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766053; x=1716370853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixJmGoyxJB9sbwoHJd6SpaODQZW3sNI1pPxi/MSBfJ0=;
 b=io1QG+IkqzOQe8Q/ZO4bRa9tzLWDsW+orpZyII0cK8107ro1hKYy3TbzByXFbRtraa
 IwDpVEXNxdGstCuuSK3uKzSLwcHZ/iEYrtXwBnU93SDpD/iG+3Yjbt+NdAm7hHbDwhNM
 RvR7uwzcR744LNHN69VfFeQi9r3h775C10zhkx7nZfrC54XaUjkxI2xzV29ztQbq0Ia4
 Xxjc7HGjlz5G8RiX69gnmQRoA3sb9+v9Ji3oDagaV+KJb8oD07LE5dWr5ud7PUQe4Dh+
 gYhpLzTM/c8OB958PZi1op2bISn74hHDZZZ7BS67bIldJ2CcbYapSPrTzeux259zGVJK
 VqLg==
X-Gm-Message-State: AOJu0YxXdfr6nkaAD0yuu5cqgub7SgqTOtx9EPOfQLX45tjJgqHJH2jK
 aKzLsyVX0kJYm9DB0lxJ+yva0uLClRhIWO8x4fEmzEHEmXhZ+NxFvG/666YsnUbQsEOY78vyv0y
 sOJM=
X-Google-Smtp-Source: AGHT+IFOPPCMNsGK/G+lrD7ksFCGeRN3DdA/aTZPOAKgBRinqIjCrb+Yng9itF5gSxTUCb2IqNAZiQ==
X-Received: by 2002:adf:e851:0:b0:34d:9fc2:4a81 with SMTP id
 ffacd0b85a97d-3504a61c5c6mr10817628f8f.5.1715766053634; 
 Wed, 15 May 2024 02:40:53 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 12/43] target/hppa: Add IASQ entries to DisasContext
Date: Wed, 15 May 2024 11:40:12 +0200
Message-Id: <20240515094043.82850-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

Add variable to track space changes to IAQ.  So far, no such changes
are introduced, but the new checks vs ctx->iasq_b may eliminate an
unnecessary copy to cpu_iasq_f with e.g. BLR.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b79c44bd49..b4e384baa3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -50,6 +50,13 @@ typedef struct DisasContext {
     uint64_t iaoq_b;
     uint64_t iaoq_n;
     TCGv_i64 iaoq_n_var;
+    /*
+     * Null when IASQ_Back unchanged from IASQ_Front,
+     * or cpu_iasq_b, when IASQ_Back has been changed.
+     */
+    TCGv_i64 iasq_b;
+    /* Null when IASQ_Next unchanged from IASQ_Back, or set by branch. */
+    TCGv_i64 iasq_n;
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -3917,12 +3924,12 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     if (a->n && use_nullify_skip(ctx)) {
         install_iaq_entries(ctx, -1, tmp, -1, NULL);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
-        tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
+        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
         nullify_set(ctx, 0);
     } else {
         install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, tmp);
-        if (ctx->iaoq_b == -1) {
-            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
+        if (ctx->iasq_b) {
+            tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
         }
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
         nullify_set(ctx, a->n);
@@ -4036,8 +4043,8 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 
     install_link(ctx, a->l, false);
     install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
-    if (ctx->iaoq_b == -1) {
-        tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
+    if (ctx->iasq_b) {
+        tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
     }
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
     nullify_set(ctx, a->n);
@@ -4618,6 +4625,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mmu_idx = MMU_USER_IDX;
     ctx->iaoq_f = ctx->base.pc_first | ctx->privilege;
     ctx->iaoq_b = ctx->base.tb->cs_base | ctx->privilege;
+    ctx->iasq_b = NULL;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
@@ -4632,6 +4640,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
     ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
+    ctx->iasq_b = (diff ? NULL : cpu_iasq_b);
 #endif
 
     ctx->zero = tcg_constant_i64(0);
@@ -4684,6 +4693,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
+        ctx->iasq_n = NULL;
         ctx->iaoq_n_var = NULL;
         ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
 
@@ -4706,7 +4716,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         return;
     }
     /* Note this also detects a priority change. */
-    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+    if (ctx->iaoq_b != ctx->iaoq_f + 4 || ctx->iasq_b) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         return;
     }
@@ -4726,6 +4736,10 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                              gva_offset_mask(ctx->tb_flags));
         }
     }
+    if (ctx->iasq_n) {
+        tcg_gen_mov_i64(cpu_iasq_b, ctx->iasq_n);
+        ctx->iasq_b = cpu_iasq_b;
+    }
 }
 
 static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
@@ -4734,14 +4748,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     DisasJumpType is_jmp = ctx->base.is_jmp;
     uint64_t fi, bi;
     TCGv_i64 fv, bv;
-    TCGv_i64 fs;
+    TCGv_i64 fs, bs;
 
     /* Assume the insn queue has not been advanced. */
     fi = ctx->iaoq_b;
     fv = cpu_iaoq_b;
-    fs = fi == -1 ? cpu_iasq_b : NULL;
+    fs = ctx->iasq_b;
     bi = ctx->iaoq_n;
     bv = ctx->iaoq_n_var;
+    bs = ctx->iasq_n;
 
     switch (is_jmp) {
     case DISAS_NORETURN:
@@ -4750,12 +4765,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         /* The insn queue has not been advanced. */
         bi = fi;
         bv = fv;
+        bs = fs;
         fi = ctx->iaoq_f;
         fv = NULL;
         fs = NULL;
         /* FALLTHRU */
     case DISAS_IAQ_N_STALE:
-        if (use_goto_tb(ctx, fi, bi)
+        if (fs == NULL
+            && bs == NULL
+            && use_goto_tb(ctx, fi, bi)
             && (ctx->null_cond.c == TCG_COND_NEVER
                 || ctx->null_cond.c == TCG_COND_ALWAYS)) {
             nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
@@ -4768,6 +4786,9 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (fs) {
             tcg_gen_mov_i64(cpu_iasq_f, fs);
         }
+        if (bs) {
+            tcg_gen_mov_i64(cpu_iasq_b, bs);
+        }
         nullify_save(ctx);
         if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
             tcg_gen_exit_tb(NULL, 0);
-- 
2.34.1


