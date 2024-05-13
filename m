Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D30C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPK-0002r5-6y; Mon, 13 May 2024 03:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPE-0002nF-Ah
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPC-0001Le-B6
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso24944285e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586448; x=1716191248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98Yc6UutVteeKcS1a+PabWfW1CAzoS9/dEERHMGPons=;
 b=W1PBNajLVwNPn71qeLt7CEtp795sEK27gYcLra4tr8g2+9NyNWxulh1XdOy3074aji
 V9k4b8tdG5bUW2Rkohu9NfyJknJ/ECm2jJcm3vZY4h/UuRwBLlAIspdnHgBZsE4tLawG
 WoSbwevitQh5HmY5PY75AqaskZ8fBJkj+IcM36Y/stMEDOpEniA9ndLBFAkPGW9fL1Kp
 SkOD0ldDWRRkDBwMxY914ejo3iJOAxcD7azsCIi6r/08U93qV6tNW6JAWXvaPuPBZcGh
 pzra5I6sixiJu/+3Nijw0X+/ePV636KCzRR0FLPDK6wHwLyKZG9jjKdtoJZ0gYsIzvgv
 LA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586448; x=1716191248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98Yc6UutVteeKcS1a+PabWfW1CAzoS9/dEERHMGPons=;
 b=KE9OJSxhPwope7Dzb4+4UTKsZxfJ4Xp/dP8X2kIFgKb0AjM6vWfGbe8vzVUB64jzWb
 VfvugqN7aiqxiLeDmWHZlhHeHsjjtTzOYJcVGsQJWcuZbe0brkG7tQD5yWf3/j6p1+da
 8pO9GydSkG77xwqenI2xt3d4pbye/6I9Y8uMvtYYHkx4yNxB8cQPB6KHRBH8MD9suOs8
 RFhL8BIhb1XTQCURBis3Sa9SGWbzglm/JWtJb4LY4Q86Jve5AVWKgNlWEol+ao4f1ZUE
 3rirF6ZcSM0zzsgFIZCCjD02Y2kxs6aKHTKV86FfqxugDPha6PGROjoaASkOExK4ocj9
 cWnA==
X-Gm-Message-State: AOJu0YwXiDMdjMW9RiDQgNmvyXCwf5kLeFTs9ZSQN6uFvlqx5JX6lqcX
 qFpBIUe+X6a2crf9Uq+58gMVDa8uiGxhrCyRDmzfXV3Q2ZU0rOjYLOgyB3uE6esu5rac9rTckwd
 5I2Q=
X-Google-Smtp-Source: AGHT+IG79evf9QkuKhB4yw4XVQ1r7EE8KjYsIDMSe0FcS155y4CFsAtSPlF41LOXSW8IL/T3vIo4cw==
X-Received: by 2002:a05:600c:2042:b0:41c:8754:8793 with SMTP id
 5b1f17b1804b1-41fead790ecmr72257155e9.41.1715586448030; 
 Mon, 13 May 2024 00:47:28 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 12/45] target/hppa: Add IASQ entries to DisasContext
Date: Mon, 13 May 2024 09:46:44 +0200
Message-Id: <20240513074717.130949-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
index 13a48d1b6c..d24220c60f 100644
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
@@ -3916,12 +3923,12 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
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
@@ -4035,8 +4042,8 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 
     install_link(ctx, a->l, false);
     install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
-    if (ctx->iaoq_b == -1) {
-        tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
+    if (ctx->iasq_b) {
+        tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
     }
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
     nullify_set(ctx, a->n);
@@ -4617,6 +4624,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mmu_idx = MMU_USER_IDX;
     ctx->iaoq_f = ctx->base.pc_first | ctx->privilege;
     ctx->iaoq_b = ctx->base.tb->cs_base | ctx->privilege;
+    ctx->iasq_b = NULL;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
@@ -4631,6 +4639,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
     ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
+    ctx->iasq_b = (diff ? NULL : cpu_iasq_b);
 #endif
 
     ctx->zero = tcg_constant_i64(0);
@@ -4683,6 +4692,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
+        ctx->iasq_n = NULL;
         ctx->iaoq_n_var = NULL;
         ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
 
@@ -4705,7 +4715,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         return;
     }
     /* Note this also detects a priority change. */
-    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+    if (ctx->iaoq_b != ctx->iaoq_f + 4 || ctx->iasq_b) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         return;
     }
@@ -4725,6 +4735,10 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                              gva_offset_mask(ctx->tb_flags));
         }
     }
+    if (ctx->iasq_n) {
+        tcg_gen_mov_i64(cpu_iasq_b, ctx->iasq_n);
+        ctx->iasq_b = cpu_iasq_b;
+    }
 }
 
 static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
@@ -4733,14 +4747,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
@@ -4749,12 +4764,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
@@ -4767,6 +4785,9 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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


