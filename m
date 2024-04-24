Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6386C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXz-0008Jg-Ix; Wed, 24 Apr 2024 20:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXc-0008Ap-46
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXY-0006E1-Q7
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so3448875ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003239; x=1714608039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1R4n87rS3DeEnBoWSAaX+71ppkJFcbZ3XLEos1pPsJ0=;
 b=j9WFH483MA91hjwQ5zLR5SEUdSeoI+r/ny27tyCOxZIeEyT3wiK+YqQnVtYrGjdVa/
 /u0rdvJF0mnmemw6GOmQvwJhr8Xpl8lnFvIt6HF8SNoI1gtVu/AgP1UJYZZJAtL3Pgqc
 i+C/qD8SBOIpimB2SwKlRoTk9wtDeb3Ys3PXH9zgySv//jDnGAlf1rQdPRDTQuVsuuAv
 q+U9k3+j/j/JvWojEc9/zwxU7qoSwKwhPbAE7ZZM0SFPhmJaAan4rj9Y3bMezeTqptmA
 OREqDHe/aUi0e8btAeSqYdDg1kDP6FXHtl5SdngGFVVLYG5iqKxyCA4yKAcZlKvKpPB2
 MbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003239; x=1714608039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1R4n87rS3DeEnBoWSAaX+71ppkJFcbZ3XLEos1pPsJ0=;
 b=UoYmsocikqlUuXjKQ0+ELBC7bphp1yhX5oh10/1K/T9YUMXvo0dz1Qif7FkQNTGiLI
 h81JSArz/dzTqf9K233xHG7yfWTdusBNmevbmiya5A3bCqQilBP9+vhslRIa6pcFZGic
 UKcQBQoX3vDLy9CBDEFPqqEOjzv0+/D43YXbXJyo0bjAXeB9nweOtci8o4HsfJSnFMCR
 GCkjgiHMTvvJcxJcPwQKHmeaTUxn2le7WY9qy40iMZjsLhbb8NugpRzH7iC8DmRTnxmO
 CxOsNg8G3rRa2yakJKAaUx2HLmrpDzoEaVArLiXWilwFhb++rnhzBiUVDVp+JLMWPS6k
 k3eg==
X-Gm-Message-State: AOJu0YwGsScCzYfr6SvydJpKlc+ksM4LL0eBK9C7bzioR/Qs01zxKMsh
 rR+Bsjd9wL0MxJgcDQ3igCrnXHoxTFX9SsMbr5WKmlhNPR9znr7iPpI/mtphFDxagJKVMQ7eie+
 u
X-Google-Smtp-Source: AGHT+IEGn1WDQ23tfMOE7sngz+Bi507RC3jSN8fkXjvBa4GvPS6sCuxopGB93KMTU3hoxa3tb3/DfA==
X-Received: by 2002:a17:902:daca:b0:1e4:9ad5:7522 with SMTP id
 q10-20020a170902daca00b001e49ad57522mr4898056plx.21.1714003237578; 
 Wed, 24 Apr 2024 17:00:37 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/45] target/hppa: Add IASQ entries to DisasContext
Date: Wed, 24 Apr 2024 16:59:50 -0700
Message-Id: <20240425000023.1002026-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 138250b550..43a74dafcf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -49,6 +49,13 @@ typedef struct DisasContext {
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
@@ -3915,12 +3922,12 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
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
@@ -4034,8 +4041,8 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 
     install_link(ctx, a->l, false);
     install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
-    if (ctx->iaoq_b == -1) {
-        tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
+    if (ctx->iasq_b) {
+        tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
     }
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
     nullify_set(ctx, a->n);
@@ -4616,6 +4623,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mmu_idx = MMU_USER_IDX;
     ctx->iaoq_f = ctx->base.pc_first | ctx->privilege;
     ctx->iaoq_b = ctx->base.tb->cs_base | ctx->privilege;
+    ctx->iasq_b = NULL;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
@@ -4630,6 +4638,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
     ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
+    ctx->iasq_b = (diff ? NULL : cpu_iasq_b);
 #endif
 
     ctx->zero = tcg_constant_i64(0);
@@ -4682,6 +4691,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
+        ctx->iasq_n = NULL;
         ctx->iaoq_n_var = NULL;
         ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
 
@@ -4704,7 +4714,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         return;
     }
     /* Note this also detects a priority change. */
-    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+    if (ctx->iaoq_b != ctx->iaoq_f + 4 || ctx->iasq_b) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         return;
     }
@@ -4724,6 +4734,10 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                              gva_offset_mask(ctx->tb_flags));
         }
     }
+    if (ctx->iasq_n) {
+        tcg_gen_mov_i64(cpu_iasq_b, ctx->iasq_n);
+        ctx->iasq_b = cpu_iasq_b;
+    }
 }
 
 static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
@@ -4732,14 +4746,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
@@ -4748,12 +4763,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
@@ -4766,6 +4784,9 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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


