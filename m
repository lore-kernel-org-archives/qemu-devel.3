Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880F4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY6-0008Ng-Us; Wed, 24 Apr 2024 20:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXr-0008Gc-6N
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXm-0006HX-0H
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e2c725e234so12376375ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003252; x=1714608052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NElphlnk4Z3YIuGs04YkM9tIzOkRH6mwVuLwvHi0tB8=;
 b=RO2zMKvm7Z/8DvuXID/F6UoPRvsfz36xcvFhgr5pfxahJ2v25WZxscO3M8GuOylzks
 qKZzbKUCtlJOw+v8ekpATMTUXtCPtQkirLM86aOrBPoyPcH8Q+4IV6Iq2ffvNiehuS59
 qruWmzfysEwsWRkhYqV60wk0OjfCy69EcIFm1vITI0/rTkZ+GfFxMllLufs/bZ3NXbXl
 FArjM/zF3+E2/RgBc+ijso1a2ALzKEYyPW2tblwy3+5QNkVyQ0rWkrPcoaF/k3sWrVnf
 +PmDTjIG9mXIV2a7xz90M8ivh0rI3989OKsFemOdRBQ6ovMQ50UeF00GqxMLIocuZrqJ
 fsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003252; x=1714608052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NElphlnk4Z3YIuGs04YkM9tIzOkRH6mwVuLwvHi0tB8=;
 b=FlCQPEfXSXdyXuiKBhrNFIITcp9rLivjtNJOqQkiIfkyhz8RrF5VdO0c1lpSjWPFpd
 WxiRaf4iGNca0C3XprZ2zbo59N6jNoF9K0Pykcsid7H+UFcUJC8u0Xi8NA2GzOgLYqJb
 WoDaa03k+nulnsyqzH6KeToVEkepl0URvVZ28bGM9srrPmM0ZUuqc1CLdE+2ppymBFD8
 9y/g2p1Bdts/DywRouZMkLGvyzYwE8NFTCGxO3WriqplpICipsdirAwJ5su8DtBaDNzn
 jkQu/deV5VQmKZAmDxQoLXjTpr4Ztl77CL3lB/XDM+pTX7GakzGXtwZ9s6ZqBLd+LCUC
 cKRg==
X-Gm-Message-State: AOJu0YzJlE28ahSB/IkDkrHcJeX5MdOw3zn4bd6A3dmnCvAT3DiNnbY/
 HTuFa/nqV9uNuLasuuZsBhACRXCfJjEIguRtV3VhDfV9B3wBwkC3q4Yp56xgiTyWYySRROWCAXM
 5
X-Google-Smtp-Source: AGHT+IEko7EhfkncaLdHcbvGRl8mWrNm1Z9OwTEv/v9Mi+Ib4FnQnDlJF4z2ePTtGTHaNEjVF3mKww==
X-Received: by 2002:a17:903:41c6:b0:1e8:8aa2:2ded with SMTP id
 u6-20020a17090341c600b001e88aa22dedmr1900279ple.13.1714003251810; 
 Wed, 24 Apr 2024 17:00:51 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/45] target/hppa: Remove cond_free
Date: Wed, 24 Apr 2024 17:00:05 -0700
Message-Id: <20240425000023.1002026-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 102 +++++++++++-----------------------------
 1 file changed, 27 insertions(+), 75 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b1311e7688..5714e2ad25 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -372,21 +372,6 @@ static DisasCond cond_make_vv(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
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
@@ -536,7 +521,7 @@ static void nullify_over(DisasContext *ctx)
 
         tcg_gen_brcond_i64(ctx->null_cond.c, ctx->null_cond.a0,
                            ctx->null_cond.a1, ctx->null_lab);
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
     }
 }
 
@@ -554,7 +539,7 @@ static void nullify_save(DisasContext *ctx)
                             ctx->null_cond.a0, ctx->null_cond.a1);
         ctx->psw_n_nonzero = true;
     }
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
 }
 
 /* Set a PSW[N] to X.  The intention is that this is used immediately
@@ -1164,7 +1149,6 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1261,7 +1245,6 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1316,7 +1299,6 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1331,10 +1313,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (cf) {
-        ctx->null_cond = do_log_cond(ctx, cf, d, dest);
-    }
+    ctx->null_cond = do_log_cond(ctx, cf, d, dest);
 }
 
 static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
@@ -1429,7 +1408,6 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     }
     save_gpr(ctx, rt, dest);
 
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1852,7 +1830,6 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
     taken = gen_new_label();
     tcg_gen_brcond_i64(c, cond->a0, cond->a1, taken);
-    cond_free(cond);
 
     /* Not taken: Condition not satisfied; nullify on backward branches. */
     n = is_n && disp < 0;
@@ -2034,7 +2011,7 @@ static void do_page_zero(DisasContext *ctx)
 
 static bool trans_nop(DisasContext *ctx, arg_nop *a)
 {
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2048,7 +2025,7 @@ static bool trans_sync(DisasContext *ctx, arg_sync *a)
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2060,7 +2037,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
     tcg_gen_andi_i64(dest, dest, -4);
 
     save_gpr(ctx, a->t, dest);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2075,7 +2052,7 @@ static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
 
     save_gpr(ctx, rt, t0);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2120,7 +2097,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
     save_gpr(ctx, rt, tmp);
 
  done:
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2160,7 +2137,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
         tcg_gen_andi_i64(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
         return true;
     }
 
@@ -2234,7 +2211,7 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
     tcg_gen_andi_i64(tmp, tmp, ctx->is_pa20 ? 63 : 31);
     save_or_nullify(ctx, cpu_sar, tmp);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2251,7 +2228,7 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 #endif
     save_gpr(ctx, a->t, dest);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2413,7 +2390,7 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
         tcg_gen_add_i64(dest, src1, src2);
         save_gpr(ctx, a->b, dest);
     }
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2655,7 +2632,7 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
        since the entire address space is coherent.  */
     save_gpr(ctx, a->t, ctx->zero);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2732,7 +2709,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
         unsigned rt = a->t;
 
         if (rt == 0) { /* NOP */
-            cond_free(&ctx->null_cond);
+            ctx->null_cond = cond_make_f();
             return true;
         }
         if (r2 == 0) { /* COPY */
@@ -2743,7 +2720,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             } else {
                 save_gpr(ctx, rt, cpu_gr[r1]);
             }
-            cond_free(&ctx->null_cond);
+            ctx->null_cond = cond_make_f();
             return true;
         }
 #ifndef CONFIG_USER_ONLY
@@ -2808,11 +2785,7 @@ static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
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
 
@@ -2838,7 +2811,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
             tcg_gen_subi_i64(tmp, tmp, 1);
         }
         save_gpr(ctx, a->t, tmp);
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
         return true;
     }
 
@@ -3364,7 +3337,7 @@ static bool trans_ldil(DisasContext *ctx, arg_ldil *a)
 
     tcg_gen_movi_i64(tcg_rt, a->i);
     save_gpr(ctx, a->t, tcg_rt);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3375,7 +3348,7 @@ static bool trans_addil(DisasContext *ctx, arg_addil *a)
 
     tcg_gen_addi_i64(tcg_r1, tcg_rt, a->i);
     save_gpr(ctx, 1, tcg_r1);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3391,7 +3364,7 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
         tcg_gen_addi_i64(tcg_rt, cpu_gr[a->b], a->i);
     }
     save_gpr(ctx, a->t, tcg_rt);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3617,10 +3590,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3660,10 +3630,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3705,10 +3672,7 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3741,10 +3705,7 @@ static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3781,10 +3742,7 @@ static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3817,10 +3775,7 @@ static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3854,10 +3809,7 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
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


