Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFA6C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QRA-0006FX-Gw; Mon, 13 May 2024 03:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPP-0002tv-89
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPM-0001Oq-1O
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34d7b0dac54so2201984f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586458; x=1716191258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3TB1VO2quFVd1n6RleTgxgMY51q9sS2yTp/72QKh2g=;
 b=Ky4ofM6Qs44YflT+XfMFQSvGNC7rhiUK1m0/G2xFJremK7XQup1oIp/1dcuTOdQwSH
 I9rG2tUdzoDHAOWRh9XRlNKArrbrW0P3wntTg+nzMwG+4895vIPXrOjoZmnoTwMgcXPH
 mgYw3ba/OJ/54APOcWMO50BUvgaX5N7XKUaYMBQWHllDAqXNduZj5nNXsSo+ajXbrhO9
 OxeW6KKwD5+u0HtSV8W3zMmgwJGOTU431v3c3nWNErMzROXi/ZJ7fNjjRon+ay7KJDGG
 EWEZEMhuwpuPcnySPU+uxj/F0NwC9OLus7/i4XlXSBevbaj7aLlrt+7WoLuRxybJH32u
 v+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586458; x=1716191258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3TB1VO2quFVd1n6RleTgxgMY51q9sS2yTp/72QKh2g=;
 b=gtL6IMWiQhKaMGC1oyMyLFCfRVlnsOIRVr3hIj9NA41EbnmjY6Pm7BKuJ+JUy3I2P5
 m8HVlbIMaKjJJJHtS9+1Jls/Oh5I/Be0MpKb/VJwsWAKeuxLVVp70GaqQwDogr9vJbUI
 Zu9g4CWZspJ1baQ2HRdRSITvpWcfCom/X2U6OkOXDcROzuUrMuDkSRbZDE56r7ScJzpq
 JRUp46SkRew2I8PteId7OGIRMQeeME3cRFe5ZnwhlfYGH3VdaByDoccMJRWqVlVI2bwK
 wE+rGWsRJDoPqYD7P9E9iw3AhX8RMrvKKNQUPya6VDi0tM/vXSSieSgqhk/3w3MdMJhb
 jBOg==
X-Gm-Message-State: AOJu0YzkCD+4j/RUr0yVP3+7t07fQ/DUguR/wxRr0Yk7hHB/uTXe3LA/
 1/6dz5eSG+inbFm9inkzjHSnYg5bdn13S2P/G7q+/+nH89Wobvd099U++bCBWmwNHYIYzTtnsGQ
 OeTE=
X-Google-Smtp-Source: AGHT+IGS5Y8UEf9DWdZLvC0b9e72ULC66NYoS/VzlLR53mmJVVqjGD2bhvNZAKRlJrkqikMAMAkN1Q==
X-Received: by 2002:adf:ffcf:0:b0:34a:4b4b:7f4b with SMTP id
 ffacd0b85a97d-350182861d4mr11341416f8f.19.1715586458494; 
 Mon, 13 May 2024 00:47:38 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 27/45] target/hppa: Remove cond_free
Date: Mon, 13 May 2024 09:46:59 +0200
Message-Id: <20240513074717.130949-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
index ef62cd7e94..e06c14dd15 100644
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
@@ -1165,7 +1150,6 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1262,7 +1246,6 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1317,7 +1300,6 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1332,10 +1314,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     save_gpr(ctx, rt, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (cf) {
-        ctx->null_cond = do_log_cond(ctx, cf, d, dest);
-    }
+    ctx->null_cond = do_log_cond(ctx, cf, d, dest);
 }
 
 static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
@@ -1430,7 +1409,6 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     }
     save_gpr(ctx, rt, dest);
 
-    cond_free(&ctx->null_cond);
     ctx->null_cond = cond;
 }
 
@@ -1853,7 +1831,6 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
     taken = gen_new_label();
     tcg_gen_brcond_i64(c, cond->a0, cond->a1, taken);
-    cond_free(cond);
 
     /* Not taken: Condition not satisfied; nullify on backward branches. */
     n = is_n && disp < 0;
@@ -2035,7 +2012,7 @@ static void do_page_zero(DisasContext *ctx)
 
 static bool trans_nop(DisasContext *ctx, arg_nop *a)
 {
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2049,7 +2026,7 @@ static bool trans_sync(DisasContext *ctx, arg_sync *a)
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2061,7 +2038,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
     tcg_gen_andi_i64(dest, dest, -4);
 
     save_gpr(ctx, a->t, dest);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2076,7 +2053,7 @@ static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
 
     save_gpr(ctx, rt, t0);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2121,7 +2098,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
     save_gpr(ctx, rt, tmp);
 
  done:
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2161,7 +2138,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
         tcg_gen_andi_i64(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
         return true;
     }
 
@@ -2235,7 +2212,7 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
     tcg_gen_andi_i64(tmp, tmp, ctx->is_pa20 ? 63 : 31);
     save_or_nullify(ctx, cpu_sar, tmp);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2252,7 +2229,7 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 #endif
     save_gpr(ctx, a->t, dest);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2414,7 +2391,7 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
         tcg_gen_add_i64(dest, src1, src2);
         save_gpr(ctx, a->b, dest);
     }
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2656,7 +2633,7 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
        since the entire address space is coherent.  */
     save_gpr(ctx, a->t, ctx->zero);
 
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -2733,7 +2710,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
         unsigned rt = a->t;
 
         if (rt == 0) { /* NOP */
-            cond_free(&ctx->null_cond);
+            ctx->null_cond = cond_make_f();
             return true;
         }
         if (r2 == 0) { /* COPY */
@@ -2744,7 +2721,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             } else {
                 save_gpr(ctx, rt, cpu_gr[r1]);
             }
-            cond_free(&ctx->null_cond);
+            ctx->null_cond = cond_make_f();
             return true;
         }
 #ifndef CONFIG_USER_ONLY
@@ -2809,11 +2786,7 @@ static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
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
 
@@ -2839,7 +2812,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
             tcg_gen_subi_i64(tmp, tmp, 1);
         }
         save_gpr(ctx, a->t, tmp);
-        cond_free(&ctx->null_cond);
+        ctx->null_cond = cond_make_f();
         return true;
     }
 
@@ -3365,7 +3338,7 @@ static bool trans_ldil(DisasContext *ctx, arg_ldil *a)
 
     tcg_gen_movi_i64(tcg_rt, a->i);
     save_gpr(ctx, a->t, tcg_rt);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3376,7 +3349,7 @@ static bool trans_addil(DisasContext *ctx, arg_addil *a)
 
     tcg_gen_addi_i64(tcg_r1, tcg_rt, a->i);
     save_gpr(ctx, 1, tcg_r1);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3392,7 +3365,7 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
         tcg_gen_addi_i64(tcg_rt, cpu_gr[a->b], a->i);
     }
     save_gpr(ctx, a->t, tcg_rt);
-    cond_free(&ctx->null_cond);
+    ctx->null_cond = cond_make_f();
     return true;
 }
 
@@ -3618,10 +3591,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3661,10 +3631,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3706,10 +3673,7 @@ static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3742,10 +3706,7 @@ static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3782,10 +3743,7 @@ static bool trans_depi_imm(DisasContext *ctx, arg_depi_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3818,10 +3776,7 @@ static bool trans_dep_imm(DisasContext *ctx, arg_dep_imm *a)
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
-    cond_free(&ctx->null_cond);
-    if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
-    }
+    ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -3855,10 +3810,7 @@ static bool do_dep_sar(DisasContext *ctx, unsigned rt, unsigned c,
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


