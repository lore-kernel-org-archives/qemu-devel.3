Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C3CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY3-0008Lk-Lk; Wed, 24 Apr 2024 20:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXe-0008B1-5F
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXZ-0006E4-A4
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e5715a9ebdso3123085ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003239; x=1714608039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Sn1JTeEfTZOk+RwEEIDqXZrh/6FLZ4ooVDbCTyJn+s=;
 b=NsH6dk8xb/vUOpD5tKVQMNCCXdy+gsbkJ0boeA1UUT9bOkxkrLf2Zf3caAWx9uQBVY
 WYPr1QWEpvpaFFdn37J96kgczuSrSIoyEqmy6ZuhR+mQRfpelL5BcdJIBmCp82R9d539
 +L8GfiQ7Ykhl5cI3T7vIaVhCz0KtCt8JvsDR/1NId/5k8VUmpYo2Myqfhu2l0mHOdaPL
 MU8ZRg7yZXs5P3Yjg8ecTH8PqOvxnSKsPV7yVSuMEnFh5qgFo9uG1L9P36pBP1LpHqsx
 TZWGiRYAZVb6WLfkgwi9jK7ZCKHKk9zpL90n/ssP8cTmDD+HCJY0v7z8Qq+0HRMU3fdX
 zUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003239; x=1714608039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Sn1JTeEfTZOk+RwEEIDqXZrh/6FLZ4ooVDbCTyJn+s=;
 b=iTAWbRWVRyixpeB1To2+CSTOn3NsJPzZlE+t1L/2hbpf8FEB7SKaVrIvN5KZZVgbTm
 5i7bYdiIQG8vRatIeWwvhlv0+cxKPPbGJpZaMHd72gDVbatuSTAFvD098XywTdDAT7nO
 ZdFnSd7syFj9gnqgqM3ucz/RgaVHfrxiIKoImhpdr9HAeACSDjuxG86GH4zUcRpcj0Nl
 dg5mWfXpGaG4x45e1yvjGuzDP9+iai64DLuvyksMXJTtbhhxIDuxy9cLcTIFWyzhEBV4
 QfQuJQ7k0fLzxjcOWBhuD/lcFRZfGNiDUuMOcDOFJlydpXnpjQQBAne+E2pvkKVTO6gs
 kzHA==
X-Gm-Message-State: AOJu0Yy1dkJ8XDQhvYO2QDe51s/QQv6alp2tVRWs4+2EV8u3OQoLup9l
 EVpTyBj1IMTT38WbaKzsql/z9QmW73I7qICq3UmW04sCOX6sAivn3jhywy5WmJTaQYjKvhwFXwp
 6
X-Google-Smtp-Source: AGHT+IG6ktmDk155vTLUasYZy3dLCY8OGCR7p2vaxU9i1+1FY5VQF66n04gYfzXwKtjm16jNaz/90Q==
X-Received: by 2002:a17:902:74c2:b0:1e4:ad9b:f770 with SMTP id
 f2-20020a17090274c200b001e4ad9bf770mr4024799plt.23.1714003239236; 
 Wed, 24 Apr 2024 17:00:39 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/45] target/hppa: Add space argument to do_ibranch
Date: Wed, 24 Apr 2024 16:59:52 -0700
Message-Id: <20240425000023.1002026-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 76 ++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 50 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6b3b298678..2ddaefde21 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1912,8 +1912,8 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
-                       unsigned link, bool is_n)
+static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 dspc,
+                       unsigned link, bool with_sr0, bool is_n)
 {
     TCGv_i64 next;
 
@@ -1921,10 +1921,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
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
@@ -1933,6 +1933,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
         }
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
+        ctx->iasq_n = dspc;
         return true;
     }
 
@@ -1941,13 +1942,13 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
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
 
@@ -3914,33 +3915,18 @@ static bool trans_depi_sar(DisasContext *ctx, arg_depi_sar *a)
 
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
@@ -4009,7 +3995,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         tcg_gen_shli_i64(tmp, load_gpr(ctx, a->x), 3);
         tcg_gen_addi_i64(tmp, tmp, ctx->iaoq_f + 8);
         /* The computation here never changes privilege level.  */
-        return do_ibranch(ctx, tmp, a->l, a->n);
+        return do_ibranch(ctx, tmp, NULL, a->l, false, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
         return do_dbranch(ctx, 0, a->l, a->n);
@@ -4028,30 +4014,20 @@ static bool trans_bv(DisasContext *ctx, arg_bv *a)
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


