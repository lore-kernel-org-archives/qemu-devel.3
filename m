Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D818C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8F-0006FT-VH; Wed, 15 May 2024 05:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B86-0005pM-Er
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B84-0001dy-BN
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34d9c9f2cf0so5584320f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766055; x=1716370855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4fRcFT/XvpBWLW/GgTNiT9RwosFSNLjQuqj9lTpBzY=;
 b=Dbsw4T8TRklgX7VCL164PA1cUkv13gPBf1xaVbLyZm8Hxtt28mdYRapIt2KFTMYKVs
 hQOt30ghbs99l3b4rc2YmDboc4A9ajFh7jlJqhhwMh2Dye2cJIiDjvuEce/qH+WP4k6e
 dia/UWgBkUn3Ke/BXWVq7gpE1O9f80mplN9O/Zj2qfQh8FuH6YkuRPKg2URkRnXBL7mD
 ZlEcrpOhe9qPsJXlL+gu/lubjnQuTA1D1GYNTeGfDJIaUWcsGXaWU2sno1oyOv62V6Gk
 XURxf4TiYeDW1L6nxQfwTS5te13dDt0dV/bjnfd2sbsseOltZUeKeozJzJMiUfjOwG0o
 wHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766055; x=1716370855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4fRcFT/XvpBWLW/GgTNiT9RwosFSNLjQuqj9lTpBzY=;
 b=rLbuG1UxfQUJFyTdqJPzrc+2OfchfIn0Y7spBQRZLE3klTmEoEKG+QspeDqmg9RD1k
 qLcUC/pTaC1Zi5dlM/FpjZLKgjbMt/O0v1t0PTmCTpI4+TbDwUqf7ckgiFZ9uV2TZ+VH
 b2urtp3P1HyraORzAwZDiC1+4Fbrq72py9rGo1Adq+5NSDUtjyw3UWcvuBCzkujB5pJ3
 so1ery2s36uKml913VthqYRjZ1rbZmeDazyMXJBL8e04XiXQLKR6WLxSSixI9nLZangM
 9BIz1GB0LLT5Fr14NDMv0jBL6DODrflHCJAKCo9pnqYmG/yBVYlKDLdQWd798mhy27s0
 sSvA==
X-Gm-Message-State: AOJu0YyO6Yj/nH55wfw7pQX5Gc9VIQp4Yy2UoXFYyzmBg5utcNSiykzn
 TSR4VO5BnOOJA5PF+vO/UgWQVi1bLfXNBW54mOWIKwdNUBDOl7nlUK87lqkCViY2CQYhI0ofkoM
 I9hI=
X-Google-Smtp-Source: AGHT+IHoUl1jKzy5GQ9Vslm6lsan1eHeb9TKpFX1psLT4vL/fL0qKNzIbhdCZjS67YEgOA6FpnACEg==
X-Received: by 2002:adf:ef4c:0:b0:347:2b42:a397 with SMTP id
 ffacd0b85a97d-3504a630f5dmr13973721f8f.4.1715766054940; 
 Wed, 15 May 2024 02:40:54 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 14/43] target/hppa: Add space argument to do_ibranch
Date: Wed, 15 May 2024 11:40:14 +0200
Message-Id: <20240515094043.82850-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

This allows unification of BE, BLR, BV, BVE with a common helper.
Since we can now track space with IAQ_Next, we can now let the
TranslationBlock continue across the delay slot with BE, BVE.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 76 ++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 50 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index eed0f92db4..1758c6e1d4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1914,8 +1914,8 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
-                       unsigned link, bool is_n)
+static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 dspc,
+                       unsigned link, bool with_sr0, bool is_n)
 {
     TCGv_i64 next;
 
@@ -1923,10 +1923,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         next = tcg_temp_new_i64();
         tcg_gen_mov_i64(next, dest);
 
-        install_link(ctx, link, false);
+        install_link(ctx, link, with_sr0);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
+                install_iaq_entries(ctx, -1, next, dspc, -1, NULL, NULL);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
@@ -1935,6 +1935,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         }
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
+        ctx->iasq_n = dspc;
         return true;
     }
 
@@ -1943,13 +1944,13 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
     next = tcg_temp_new_i64();
     tcg_gen_mov_i64(next, dest);
 
-    install_link(ctx, link, false);
+    install_link(ctx, link, with_sr0);
     if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
+        install_iaq_entries(ctx, -1, next, dspc, -1, NULL, NULL);
         nullify_set(ctx, 0);
     } else {
         install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                            -1, next, NULL);
+                            -1, next, dspc);
         nullify_set(ctx, is_n);
     }
 
@@ -3916,33 +3917,18 @@ static bool trans_depi_sar(DisasContext *ctx, arg_depi_sar *a)
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
 {
-    TCGv_i64 tmp;
+    TCGv_i64 dest = tcg_temp_new_i64();
+    TCGv_i64 space = NULL;
 
-    tmp = tcg_temp_new_i64();
-    tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
-    tmp = do_ibranch_priv(ctx, tmp);
+    tcg_gen_addi_i64(dest, load_gpr(ctx, a->b), a->disp);
+    dest = do_ibranch_priv(ctx, dest);
 
-#ifdef CONFIG_USER_ONLY
-    return do_ibranch(ctx, tmp, a->l, a->n);
-#else
-    TCGv_i64 new_spc = tcg_temp_new_i64();
-
-    nullify_over(ctx);
-
-    load_spr(ctx, new_spc, a->sp);
-    install_link(ctx, a->l, true);
-    if (a->n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, -1, tmp, new_spc, -1, NULL, new_spc);
-        nullify_set(ctx, 0);
-    } else {
-        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                            -1, tmp, new_spc);
-        nullify_set(ctx, a->n);
-    }
-    tcg_gen_lookup_and_goto_ptr();
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return nullify_end(ctx);
+#ifndef CONFIG_USER_ONLY
+    space = tcg_temp_new_i64();
+    load_spr(ctx, space, a->sp);
 #endif
+
+    return do_ibranch(ctx, dest, space, a->l, true, a->n);
 }
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
@@ -4011,7 +3997,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
         tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
-        return do_ibranch(ctx, tmp, a->l, a->n);
+        return do_ibranch(ctx, tmp, NULL, a->l, false, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
         return do_dbranch(ctx, 0, a->l, a->n);
@@ -4030,30 +4016,20 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
         tcg_gen_add_i64(dest, dest, load_gpr(ctx, a->b));
     }
     dest = do_ibranch_priv(ctx, dest);
-    return do_ibranch(ctx, dest, 0, a->n);
+    return do_ibranch(ctx, dest, NULL, 0, false, a->n);
 }
 
 static bool trans_bve(DisasContext *ctx, arg_bve *a)
 {
-    TCGv_i64 dest;
+    TCGv_i64 b = load_gpr(ctx, a->b);
+    TCGv_i64 dest = do_ibranch_priv(ctx, b);
+    TCGv_i64 space = NULL;
 
-#ifdef CONFIG_USER_ONLY
-    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
-    return do_ibranch(ctx, dest, a->l, a->n);
-#else
-    nullify_over(ctx);
-    dest = tcg_temp_new_i64();
-    tcg_gen_mov_i64(dest, load_gpr(ctx, a->b));
-    dest = do_ibranch_priv(ctx, dest);
-
-    install_link(ctx, a->l, false);
-    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
-                        -1, dest, space_select(ctx, 0, dest));
-    nullify_set(ctx, a->n);
-    tcg_gen_lookup_and_goto_ptr();
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return nullify_end(ctx);
+#ifndef CONFIG_USER_ONLY
+    space = space_select(ctx, 0, b);
 #endif
+
+    return do_ibranch(ctx, dest, space, a->l, false, a->n);
 }
 
 static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
-- 
2.34.1


