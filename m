Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251B8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8J-0006Rp-NJ; Wed, 15 May 2024 05:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B83-0005oM-Ez
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7x-0001cU-TN
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34f7d8bfaa0so4554190f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766048; x=1716370848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWp6bdA1sBa5OoQyzeOLvPwfbI/UOT6XgwKsQG7+re4=;
 b=nApT73MfDJTq4YbFbKFn+tS2lsJwow6GQM0Uy5Q04alUytBvC1Z4W4Z83surBHm4ET
 RL9CfRGXQp9m59LuDAyeJqeeSFhKqYEvvMWALpnhJrepj675LZW2xAMT1fkte4HONqmn
 6J1zw7CKvF7NHWGnk59cDxHlmRNoyjM0CFvIeqXJV1VgAaAwtrZqhJMy6JZKEBxEOV6d
 WBnJW+RGGIZplMIwMGxP7jpPQURfEgzfWO+TBpc/ywjLFDOlACtq18rTvuFh2U7DTKQj
 Cjk10T3IEl+5gLKcUX+5rP3xpTNu9hmGG/CWb/84jD+nEnh5NWFCdhAgwK9fdRORUGOw
 lUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766048; x=1716370848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWp6bdA1sBa5OoQyzeOLvPwfbI/UOT6XgwKsQG7+re4=;
 b=fwfxZO3RWY790z/IFbd5OSu0wdyZO0CQ+31YvtBG8Iq822vyui6hStyTc733WlrBeT
 e7SQIVutXgc5uha1MKUYQ80HdkFm/w1AmRsUx8aa/8E7gALNNErPy6Q1TE1NrtDZJ5zu
 3a64WIoreKnOwSDh3rqSB6h3vEZle6wK9gEd8Hqok736M/IKAPaGtEYOVhTEMzdrHtIk
 yQwQD/UV1flsSDsUsvlTzEnEEp81T9J/lXx1AoVie8pn71FV5d5PYjYBa80Ew3HfLiA7
 o4x3gpwGFRdkRsPGZICGfCclfbuA7Cy48LFW7grMU54LAAwB2YzGkMu2wCjajbXnNxMA
 qGZQ==
X-Gm-Message-State: AOJu0YxcTD2XtmEtHifR/hLpVN4fjGbKorR8sMmE88rjoY0jQ2FeHTV8
 Jvj0g35Ki7Ui4B/kGucMg5hHIEpll2DASp832YBChDNB/4eKyuk/jAisJngaHqq+hL4X/W/Ouo8
 85T4=
X-Google-Smtp-Source: AGHT+IFXjbyRa0fYQMPhqaVUHw3xdsBbpsLaRLUDtscTHEDpkXOdv9D3wAVEYqLwAkOfkFArrfyqPg==
X-Received: by 2002:adf:fc89:0:b0:34f:feb2:c9aa with SMTP id
 ffacd0b85a97d-3504a9694e7mr10302526f8f.47.1715766048356; 
 Wed, 15 May 2024 02:40:48 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 05/43] target/hppa: Allow prior nullification in do_ibranch
Date: Wed, 15 May 2024 11:40:05 +0200
Message-Id: <20240515094043.82850-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
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

Simplify the function by not attempting a conditional move
on the branch destination -- just use nullify_over normally.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 73 +++++++++++------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4c42b518c5..140dfb747a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1871,17 +1871,15 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
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
@@ -1895,60 +1893,29 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
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


