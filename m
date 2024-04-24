Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6BAC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY8-0008Nv-CU; Wed, 24 Apr 2024 20:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXW-0008AQ-V2
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:45 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXR-0006AH-A1
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so337905a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003231; x=1714608031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JvZtT+b94F+EHwcSvNa04xBqeHxjFbplsfzPgMsFT1g=;
 b=xpTZwfCCTdS8ObodZi+dXxxItX+zhQ5ffArw2SYD1qlJo4htKjK+vbXO8DbD36vZAx
 nvi8zsmvjydV2zlP5aODSTebaYf7lpxSl5H3wqevJnvk2qLEy54e7cyXl16e9dTlQlOl
 58FO8z0Vnzf2oAk/2aYq7CPfWECyO5Rt+IUXZOR9n2yL08LuuW5vmlnp/GXCfsEkGz3+
 nZPx1kr+GluzplYQ+I4r4y2icp7VF4OqFA7/qqsSaOKFj1RXVwbqxRvMmoAzgp4L/uy/
 RthK06wxam7Sfc6ndJKxkNP2eQw4gYNE7lHmtPrMG0NDe7Y1Bi2lYdDuMQ75ySK2UTok
 x3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003231; x=1714608031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvZtT+b94F+EHwcSvNa04xBqeHxjFbplsfzPgMsFT1g=;
 b=fhHCu2DI/BwO0qp28q1FN9jKtCH9VaIolJUbJUR8F8irvznFtxf8CVa1lJxQBHJvGf
 zxaTLj7+cFVNZEBX38v0mh6rRMKjQlQ1ERokMBsOGui1TgKkeJyWAltDX2Y1oXQnpSDx
 OVRwV92Nzl3PFhOfZ9V4NoTqQEiY3/u1aylrcvIwuvUce3hq/I5SlcYV825IuoABH6b+
 +cwkgSlKck+D1R+lDmtcTJDo0GbdUH+rNt0TvZ5Kr+wxJ7DDAX95UPCezKybY5C8OZD1
 5WY0qBiqbNefPVHp84Or7gq6W88OkOCwfxKWWb+0cdUBmqEJMulBwoC7oma1eVLbmsEA
 fukg==
X-Gm-Message-State: AOJu0Yz4PluSojQ46FJRqHavp+j4iSbqWnAHGd8VWa5yf4d41v2IF2hD
 XhXEOY+VFIQ5HRjbJp6PJuYIPwUJ/vAdoSt8r9ZtTM7aWGMtEog887R9fAjM0mH+HHlbZOpPez3
 L
X-Google-Smtp-Source: AGHT+IFiqQ9amjc/etNg8hDltn41ge/g6LUypGv8EA5dPMEh7+SNB2eGla3sOFCYAf3Dxi4/8eCgjw==
X-Received: by 2002:a05:6a20:9150:b0:1a3:64a9:11e5 with SMTP id
 x16-20020a056a20915000b001a364a911e5mr4456766pzc.50.1714003230991; 
 Wed, 24 Apr 2024 17:00:30 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/45] target/hppa: Allow prior nullification in do_ibranch
Date: Wed, 24 Apr 2024 16:59:43 -0700
Message-Id: <20240425000023.1002026-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Simplify the function by not attempting a conditional move
on the branch destination -- just use nullify_over normally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 73 +++++++++++------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cbf78a4007..ceba7a98e5 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1870,17 +1870,15 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
                        unsigned link, bool is_n)
 {
-    TCGv_i64 a0, a1, next, tmp;
-    TCGCond c;
+    TCGv_i64 next;
 
-    assert(ctx->null_lab == NULL);
+    if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
+        next = tcg_temp_new_i64();
+        tcg_gen_mov_i64(next, dest);
 
-    if (ctx->null_cond.c == TCG_COND_NEVER) {
         if (link != 0) {
             copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
-        next = tcg_temp_new_i64();
-        tcg_gen_mov_i64(next, dest);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
@@ -1894,60 +1892,29 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         }
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
-    } else if (is_n && use_nullify_skip(ctx)) {
-        /* The (conditional) branch, B, nullifies the next insn, N,
-           and we're allowed to skip execution N (no single-step or
-           tracepoint in effect).  Since the goto_ptr that we must use
-           for the indirect branch consumes no special resources, we
-           can (conditionally) skip B and continue execution.  */
-        /* The use_nullify_skip test implies we have a known control path.  */
-        tcg_debug_assert(ctx->iaoq_b != -1);
-        tcg_debug_assert(ctx->iaoq_n != -1);
+        return true;
+    }
 
-        /* We do have to handle the non-local temporary, DEST, before
-           branching.  Since IOAQ_F is not really live at this point, we
-           can simply store DEST optimistically.  Similarly with IAOQ_B.  */
+    nullify_over(ctx);
+
+    if (is_n && use_nullify_skip(ctx)) {
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
         next = tcg_temp_new_i64();
         tcg_gen_addi_i64(next, dest, 4);
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
-
-        nullify_over(ctx);
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
-        tcg_gen_lookup_and_goto_ptr();
-        return nullify_end(ctx);
+        nullify_set(ctx, 0);
     } else {
-        c = ctx->null_cond.c;
-        a0 = ctx->null_cond.a0;
-        a1 = ctx->null_cond.a1;
-
-        tmp = tcg_temp_new_i64();
-        next = tcg_temp_new_i64();
-
-        copy_iaoq_entry(ctx, tmp, ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_movcond_i64(c, next, a0, a1, tmp, dest);
-        ctx->iaoq_n = -1;
-        ctx->iaoq_n_var = next;
-
-        if (link != 0) {
-            tcg_gen_movcond_i64(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
-        }
-
-        if (is_n) {
-            /* The branch nullifies the next insn, which means the state of N
-               after the branch is the inverse of the state of N that applied
-               to the branch.  */
-            tcg_gen_setcond_i64(tcg_invert_cond(c), cpu_psw_n, a0, a1);
-            cond_free(&ctx->null_cond);
-            ctx->null_cond = cond_make_n();
-            ctx->psw_n_nonzero = true;
-        } else {
-            cond_free(&ctx->null_cond);
-        }
+        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
+        nullify_set(ctx, is_n);
     }
-    return true;
+    if (link != 0) {
+        copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+    }
+
+    tcg_gen_lookup_and_goto_ptr();
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return nullify_end(ctx);
 }
 
 /* Implement
-- 
2.34.1


