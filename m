Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E300C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8K-0006US-BN; Wed, 15 May 2024 05:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8G-0006K6-NN
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8E-0001h7-8k
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34e667905d2so4541638f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766065; x=1716370865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kT+7yAhk2utfYV3lzQ8cWYMJVbRzNn7/wnnKVG1z4lw=;
 b=KCwCNTVI6ka/XlFAS1BtF5Y4Y1kIHtkVljjtxAc+sPQeteNA+L96CDj3+YOVs4+kAN
 3PwuupvvouCZAcDltm0sD0hjqlPE2xWdQnpknJrryx9LdEkkx9y5+4Ybo+SS0cIl5acZ
 y7e/i9K05VUw7XT9xDLnO+dp1OAISY7ydZYFnNwa0SB2ywqRN0HUBh9ijL8Ni5zDcjI7
 wyuj9NzT15mGJuFPOAWsnsWpU4olLsrYjwHW0hVElZs+L9T82juZKlxyw74915lOsh8D
 gwGqcR8/WTDDwZ85YT6x2afuyGHP1w9O/3GJKESt1CAf4IW5GAnPH/19278te1u1KJzW
 oPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766065; x=1716370865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kT+7yAhk2utfYV3lzQ8cWYMJVbRzNn7/wnnKVG1z4lw=;
 b=q2fp1FlzRGmfk9qIN3AIjtm5EikvP3mU0cuken5mhBXblbz42LVjciNz9HSS3cBn5j
 hK5DoZFdZ0jkZEAWuVHrn9rRgwBFSF4HRIsJtadoO0Po05AD0J4LsKIH5yRAhRkiOvh2
 AGkhJD68HHMyHL9AGGtfSblyjgi3qKvgv27ZHkP9/HVRn/QXKEhxqbeIX1pCjGwt4q3D
 RuautmwU9x2Vk/EL6LFAZVCwqyXd7Be8I5RoZdiNFWJL2Bz+f5n5/KY7Luei6hKdwpPA
 2wx2wKX1E0vgNzaFAashMH7iDXKV+KHeZzx7/Wo2xANxUBeiiH/NePrIZ2NLM52fdf3n
 rBng==
X-Gm-Message-State: AOJu0YwguDEYeB9cnT9vCyhOWk/ixEAA8GI5JOOlYz0oF6aLdWAXl3I2
 ObCC7WfcgRlX59hhyAyOTOPpjafrk1XwBmWJEOV9OoF77DrNhrfORlxBvV5OZB7AP880w5dEBj4
 1494=
X-Google-Smtp-Source: AGHT+IEu4WhnOBWjxK62QcFmmNKyx0Ve7RTLbUNghCpK/GLe+H/HagbzGxyHpQw+s/WQa5jDsbNRCw==
X-Received: by 2002:a05:6000:e43:b0:34e:21cd:dbf3 with SMTP id
 ffacd0b85a97d-3504a73ec96mr12011599f8f.36.1715766064778; 
 Wed, 15 May 2024 02:41:04 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/43] target/hppa: Remove cond_free
Date: Wed, 15 May 2024 11:40:27 +0200
Message-Id: <20240515094043.82850-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Now that we do not need to free tcg temporaries, the only
thing cond_free does is reset the condition to never.
Instead, simply write a new condition over the old, which
may be simply cond_make_f() for the never condition.

The do_*_cond functions do the right thing with c or cf == 0,
so there's no need for a special case anymore.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 102 +++++++++++-----------------------------
 1 file changed, 27 insertions(+), 75 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 11d74bb2aa..81a75ddf95 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -373,21 +373,6 @@ static DisasCond cond_make_vv(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
     return cond_make_tt(c, t0, t1);
 }
 
-static void cond_free(DisasCond *cond)
-{
-    switch (cond->c) {
-    default:
-        cond->a0 = NULL;
-        cond->a1 = NULL;
-        /* fallthru */
-    case TCG_COND_ALWAYS:
-        cond->c = TCG_COND_NEVER;
-        break;
-    case TCG_COND_NEVER:
-        break;
-    }
-}
-
 static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
@@ -537,7 +522,7 @@ static void nullify_over(DisasContext *ctx)
 
         tcg_gen_brcond_i64(ctx->null_cond.c, ctx->null_cond.a0,
                            ctx->null_cond.a1, ctx->null_lab);
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
     }
 }
 
@@ -555,7 +540,7 @@ static void nullify_save(DisasContext *ctx)
                             ctx->null_cond.a0, ctx->null_cond.a1);
         ctx->psw_n_nonzero = true;
     }
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
 }
 
 /* Set a PSW[N] to X.  The intention is that this is used immediately
@@ -1166,7 +1151,6 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1263,7 +1247,6 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1318,7 +1301,6 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1333,10 +1315,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (cf) {
-        ctx->null_cond = do_log_cond(ctx, cf, d, dest);
-    }
+    ctx->null_cond = do_log_cond(ctx, cf, d, dest);
 }
 
 static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
@@ -1431,7 +1410,6 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     }
     save_gpr(ctx, rt, dest);
 
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1854,7 +1832,6 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
     taken = gen_new_label();
     tcg_gen_brcond_i64(c, cond->a0, cond->a1, taken);
-    cond_free(cond);
 
     /* Not taken: Condition not satisfied; nullify on backward branches. */
     n = is_n && disp < 0;
@@ -2036,7 +2013,7 @@ static void do_page_zero(DisasContext *ctx)
 
 static bool trans_nop(DisasContext *ctx, arg_nop *a)
 {
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2050,7 +2027,7 @@ static bool trans_sync(DisasContext *ctx, arg_sync *a)
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2062,7 +2039,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
     tcg_gen_andi_i64(dest, dest, -4);
 
     save_gpr(ctx, a->t, dest);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2077,7 +2054,7 @@ static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
 
     save_gpr(ctx, rt, t0);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2122,7 +2099,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
     save_gpr(ctx, rt, tmp);
 
  done:
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2162,7 +2139,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
         tcg_gen_andi_i64(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
         return true;
     }
 
@@ -2236,7 +2213,7 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
     tcg_gen_andi_i64(tmp, tmp, ctx->is_pa20 ? 63 : 31);
     save_or_nullify(ctx, cpu_sar, tmp);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2253,7 +2230,7 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 #endif
     save_gpr(ctx, a->t, dest);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2415,7 +2392,7 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
         tcg_gen_add_i64(dest, src1, src2);
         save_gpr(ctx, a->b, dest);
     }
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2657,7 +2634,7 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
        since the entire address space is coherent.  */
     save_gpr(ctx, a->t, ctx->zero);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2734,7 +2711,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
         unsigned rt = a->t;
 
         if (rt == 0) { /* NOP */
-            cond_free(&ctx->null_cond);
+            ctx->null_cond = cond_make_f();
             return true;
         }
         if (r2 == 0) { /* COPY */
@@ -2745,7 +2722,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             } else {
                 save_gpr(ctx, rt, cpu_gr[r1]);
             }
-            cond_free(&ctx->null_cond);
+            ctx->null_cond = cond_make_f();
             return true;
         }
 #ifndef CONFIG_USER_ONLY
@@ -2810,11 +2787,7 @@ static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
     tcg_gen_xor_i64(dest, tcg_r1, tcg_r2);
     save_gpr(ctx, a->t, dest);
 
-    cond_free(&ctx->null_cond);
-    if (a->cf) {
-        ctx->null_cond = do_unit_zero_cond(a->cf, a->d, dest);
-    }
-
+    ctx->null_cond = do_unit_zero_cond(a->cf, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -2840,7 +2813,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
             tcg_gen_subi_i64(tmp, tmp, 1);
         }
         save_gpr(ctx, a->t, tmp);
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
         return true;
     }
 
@@ -3366,7 +3339,7 @@ static bool trans_ldil(DisasContext *ctx, arg_ldil *a)
 
     tcg_gen_movi_i64(tcg_rt, a->i);
     save_gpr(ctx, a->t, tcg_rt);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3377,7 +3350,7 @@ static bool trans_addil(DisasContext *ctx, arg_addil *a)
 
     tcg_gen_addi_i64(tcg_r1, tcg_rt, a->i);
     save_gpr(ctx, 1, tcg_r1);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3393,7 +3366,7 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
         tcg_gen_addi_i64(tcg_rt, cpu_gr[a->b], a->i);
     }
     save_gpr(ctx, a->t, tcg_rt);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3619,10 +3592,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3662,10 +3632,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3707,10 +3674,7 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3743,10 +3707,7 @@ static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3783,10 +3744,7 @@ static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3819,10 +3777,7 @@ static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3856,10 +3811,7 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (c) {
-        ctx->null_cond = do_sed_cond(ctx, c, d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, c, d, dest);
     return nullify_end(ctx);
 }
 
-- 
2.34.1


