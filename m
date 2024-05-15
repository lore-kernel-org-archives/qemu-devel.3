Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCBC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8X-0007rW-33; Wed, 15 May 2024 05:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B85-0005pH-O3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B80-0001d1-FA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:57 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52327368e59so3979425e87.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766050; x=1716370850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3iq08ivkyb9G2rCb5jKvLjHEPK2YINfYwE+N67CAtrk=;
 b=wrRSSGMMoLXYqJz7VlGKAvlYSbr2R2QPJPEtfKfoICl+0K5wk6bLch2P7N1KE4w7tP
 OpLCDWxkTz3lCocCr8Dt8semsLEHO8MHZK+Ain0T/xm8/qwyYhygKZsrAhgpu+z91Pn7
 weo2iIlO5CG/JMhio4Zur1GPz5XQN5iMksytYpegDIjPtj1gFAMlWSsAdaKFVFLWjRAm
 nC/w6Kdlpeg9AWKZBKZIxg+CLEDrfimW4HkgP/IWSfcShume+kI6Et+2TyVeuL08Keti
 p1RO16fmDvlcFitcYO56bRWhDhMhPbPV2HK2hsUIWCAkdj9jZrBSdBgOvso5MZVu4lxj
 5Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766050; x=1716370850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iq08ivkyb9G2rCb5jKvLjHEPK2YINfYwE+N67CAtrk=;
 b=wuwe0F6AIugeg0z4PqIx1F2nFNDBsdBk6jwmWT4sTtoz7Fs/9uB+PtPW11YVL8u9XO
 4+hqK37qLGxfblgbOxcMBl5r7IqO9GeKOc2fFBq/jTfAHBe5p25iuQAJfNDtI1LSCHed
 +lFWxk7nt26yrx9+CWt8FFuzgkFHdBkuDAd/ftvyDo1Eqw0Wiv+3Am08WqzQTxbkkH/G
 1JDBCFctFfIhoSo8R2eitzwLLLB51lc/9ePKvhAoh9keQzGbqVetkNkifKlGW7YUnLQ2
 CKZeekykqARdeylVLfjiN7sc1Becb6hsfjVmgPDMJDtOhwVXo0pSuaZ7xzr9gjCXSvjF
 7/ww==
X-Gm-Message-State: AOJu0YwbDTnx7Lbj9+6fvshJqpKqOQRzaCe+wiIEKNXkOnxtm5N++uww
 4mPYOlUPPMwrND32Qa/X0eAWmp1uZhadKapGFW+w7sSFJvd8P5/1rKIqFTViZGPuwnE3ALv7Ogh
 Oqhw=
X-Google-Smtp-Source: AGHT+IFvOxo0WXN+MlY5XoCtHGwZ1ZlTwTtfMEMdDeNyt9EiSjz9r8FzSPQwAOFJo7ikWqjUZ8kWEA==
X-Received: by 2002:a05:6512:1046:b0:51d:2459:bdbb with SMTP id
 2adb3069b0e04-5220fb7760emr12319272e87.12.1715766050300; 
 Wed, 15 May 2024 02:40:50 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 08/43] target/hppa: Add install_link
Date: Wed, 15 May 2024 11:40:08 +0200
Message-Id: <20240515094043.82850-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add a common routine for writing the return address.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 55 ++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 08d5e2a4bc..220665d98e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -634,6 +634,24 @@ static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
     }
 }
 
+static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
+{
+    tcg_debug_assert(ctx->null_cond.c == TCG_COND_NEVER);
+    if (!link) {
+        return;
+    }
+    if (ctx->iaoq_b == -1) {
+        tcg_gen_addi_i64(cpu_gr[link], cpu_iaoq_b, 4);
+    } else {
+        tcg_gen_movi_i64(cpu_gr[link], ctx->iaoq_b + 4);
+    }
+#ifndef CONFIG_USER_ONLY
+    if (with_sr0) {
+        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
+    }
+#endif
+}
+
 static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
 {
     return ctx->iaoq_f + disp + 8;
@@ -1787,9 +1805,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     uint64_t dest = iaoq_dest(ctx, disp);
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
+        install_link(ctx, link, false);
         ctx->iaoq_n = dest;
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
@@ -1797,10 +1813,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     } else {
         nullify_over(ctx);
 
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
-
+        install_link(ctx, link, false);
         if (is_n && use_nullify_skip(ctx)) {
             nullify_set(ctx, 0);
             gen_goto_tb(ctx, 0, dest, dest + 4);
@@ -1892,9 +1905,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         next = tcg_temp_new_i64();
         tcg_gen_mov_i64(next, dest);
 
-        if (link != 0) {
-            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-        }
+        install_link(ctx, link, false);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 install_iaq_entries(ctx, -1, next, -1, NULL);
@@ -1911,16 +1922,17 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
 
     nullify_over(ctx);
 
+    next = tcg_temp_new_i64();
+    tcg_gen_mov_i64(next, dest);
+
+    install_link(ctx, link, false);
     if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, dest, -1, NULL);
+        install_iaq_entries(ctx, -1, next, -1, NULL);
         nullify_set(ctx, 0);
     } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
+        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, next);
         nullify_set(ctx, is_n);
     }
-    if (link != 0) {
-        copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
-    }
 
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -3899,10 +3911,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     nullify_over(ctx);
 
     load_spr(ctx, new_spc, a->sp);
-    if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
-    }
+    install_link(ctx, a->l, true);
     if (a->n && use_nullify_skip(ctx)) {
         install_iaq_entries(ctx, -1, tmp, -1, NULL);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
@@ -4019,16 +4028,16 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     return do_ibranch(ctx, dest, a->l, a->n);
 #else
     nullify_over(ctx);
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
+    dest = tcg_temp_new_i64();
+    tcg_gen_mov_i64(dest, load_gpr(ctx, a->b));
+    dest = do_ibranch_priv(ctx, dest);
 
+    install_link(ctx, a->l, false);
     install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
     if (ctx->iaoq_b == -1) {
         tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
     }
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
-    if (a->l) {
-        copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
-    }
     nullify_set(ctx, a->n);
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.34.1


