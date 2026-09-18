Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C716C982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mfd-0006Km-Bz; Thu, 17 Sep 2026 20:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Mfb-0006Kd-Oz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:41:39 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7MfZ-0001L6-Ja
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:41:39 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so188486b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789692095; x=1790296895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c0KJgv8KJg16z+He/lIJzqS4Rbyje7/sUnz+qG6RhnU=;
 b=gGJ7efrSqL/fk5+i2VTsmOEH+iWuK3L5gH1vAkjifFZ4PNEAUBMK/GKzV8OE1xza6g
 ZE3nGiGQ4AaSWQ7rfy09C+CDY5AOGGrME051fuk8CHF7MAo5di9HyWVWSDSmRiIBv13L
 vydEGo+bFSnrwCW4uZyMfGIy3zQ2CRpkWQdJ3zvGh3fAvc5v4cZe7nXrbxuWy4WoeoYx
 EzUiIDq8zbkVtHnAfycvNj9UqnNJRXt10lN59dGWCbcnJW6wNv6C/A05zmN9rqZ+TI5n
 YyjxdjAHuMMvFGpYYF4+5aGos3lIVyikBO0hFFx1DODP6tHqSj+vmF5VejgvthT2/e93
 98JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692095; x=1790296895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0KJgv8KJg16z+He/lIJzqS4Rbyje7/sUnz+qG6RhnU=;
 b=ogmBgyYbBHv9pNx8F0BNLZy8MFYRKT1EzbI4Eb1MsF91HiFK5FVcelLJ0IjkZtQ5a1
 0LtLQaHywFfdUqQCXSdGbj2ZeEeT7xmQyczWbmkgkPD+PJgwbAe23RAKgHEDxPOVGXEt
 tiQOjEkmvXdh/E+Ds9fJ8IrIm9LenCjxLzfuHaAEnwwhb8ksX5gQ6P6q57mR4wKDG+nf
 GyGcQIXfwMlsoSUsrLrZ9AYdFS8rT1iVIgzS8q3TubMoTQ4HHbZJgmJE10XtftUX8Fmx
 JYrW8vJHX8aoZ6UG4JXFYz9yMk9A0nbKGaBls5DcIXXUNAOn3VG1ci5NFGfDWSnyN0HR
 n2FA==
X-Gm-Message-State: AFuF++kPbEueu7GwpzVxZfUNdYgw67n5qqeK+RmmpImdrTAjyzRVnbu/
 u222MThxENg+xZR0JZmfgMSMuM5b1DYEwHPkncCcrdxCNlgh445CcDZ0mrRvTcgrc+y8ymA/jn8
 1pUFTFxM=
X-Gm-Gg: AYBFou3qZDN/yoIhBT6lNmp7GzApsYYtQgVh+8AfOeVKBXDjizmdQ1ZV3dpNFRpLuc2
 cQ0UFmxYehiA/2qZMQjdjKx6mda/E+ZiczV7/qzn3Hd8pVYIuQHBLAvB0i1LFtgn6V00JnxzrlX
 hof9jHG9aUMXrJmwRpx8WMqR9+p0Xwtf3pqd3ep5Toiu2tY/lO81cZiXa5/LUESzy4I6qgLtIbv
 //csY69k6WNFsOfjHWXH1G5tyS25ga+6KO4uhbqG5bnWfTt1+Btd7Ys+Dmm35WmlCxTxMlKqKt8
 UcG9jOIDFRMlMTyhHKMvzBscBTmNPBG7U5Jgn2rQkC1voFjuPBjejuwgfZV8zKjTaOspRlf81uD
 2nLBtvmh6PbHAnFT+XInrdxqUeV34KkryIFMwCrk7uy+tSJtvPEqpC3I+mT/AScLI7LzUmtjjIT
 6XI4tgo48uXOnv8TUegzaHgaTwnT+WY2+VcX/TIgycoAy7DJB5P7hkhyMc17E+aI94rdMMHLOpP
 cP5AkI=
X-Received: by 2002:a05:6a20:438c:b0:3dd:85a8:cb80 with SMTP id
 adf61e73a8af0-3dd8c4decdfmr1558944637.35.1789692095326; 
 Thu, 17 Sep 2026 17:41:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:83aa:9d68:3956:350a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb19f8cesm25150780eec.2.2026.09.17.17.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:41:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] target/hppa/tcg: Always initialize DisasCond.{a0,a1}
Date: Thu, 17 Sep 2026 14:41:32 -1000
Message-ID: <20260918004132.365434-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Forthcoming tcg improvements will diagnose the passed
null pointer with --enable-ubsan:

../src/target/hppa/translate.c:579:9: runtime error: null pointer passed as argument 3, which is declared to never be null
../src/target/hppa/translate.c:579:9: runtime error: null pointer passed as argument 4, which is declared to never be null

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 72 ++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 002189ddfbd..41300c0dd73 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -339,30 +339,30 @@ static void set_insn_breg(DisasContext *ctx, int breg)
     tcg_set_insn_start_param(ctx->base.insn_start, 2, breg);
 }
 
-static DisasCond cond_make_f(void)
+static DisasCond cond_make_f(DisasContext *ctx)
 {
     return (DisasCond){
         .c = TCG_COND_NEVER,
-        .a0 = NULL,
-        .a1 = NULL,
+        .a0 = ctx->zero,
+        .a1 = ctx->zero,
     };
 }
 
-static DisasCond cond_make_t(void)
+static DisasCond cond_make_t(DisasContext *ctx)
 {
     return (DisasCond){
         .c = TCG_COND_ALWAYS,
-        .a0 = NULL,
-        .a1 = NULL,
+        .a0 = ctx->zero,
+        .a1 = ctx->zero,
     };
 }
 
-static DisasCond cond_make_n(void)
+static DisasCond cond_make_n(DisasContext *ctx)
 {
     return (DisasCond){
         .c = TCG_COND_NE,
         .a0 = cpu_psw_n,
-        .a1 = tcg_constant_i64(0)
+        .a1 = ctx->zero,
     };
 }
 
@@ -562,7 +562,7 @@ static void nullify_over(DisasContext *ctx)
 
         tcg_gen_brcond_i64(ctx->null_cond.c, ctx->null_cond.a0,
                            ctx->null_cond.a1, ctx->null_lab);
-        ctx->null_cond = cond_make_f();
+        ctx->null_cond = cond_make_f(ctx);
     }
 }
 
@@ -580,7 +580,7 @@ static void nullify_save(DisasContext *ctx)
                             ctx->null_cond.a0, ctx->null_cond.a1);
         ctx->psw_n_nonzero = true;
     }
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
 }
 
 /* Set a PSW[N] to X.  The intention is that this is used immediately
@@ -626,7 +626,7 @@ static bool nullify_end(DisasContext *ctx)
            label we have the proper value in place.  */
         nullify_save(ctx);
         gen_set_label(null_lab);
-        ctx->null_cond = cond_make_n();
+        ctx->null_cond = cond_make_n(ctx);
     }
     if (status == DISAS_NORETURN) {
         ctx->base.is_jmp = DISAS_NEXT;
@@ -766,7 +766,7 @@ static bool gen_excp_iir(DisasContext *ctx, int exc)
         DisasDelayException *e = delay_excp(ctx, exc);
         tcg_gen_brcond_i64(tcg_invert_cond(ctx->null_cond.c),
                            ctx->null_cond.a0, ctx->null_cond.a1, e->lab);
-        ctx->null_cond = cond_make_f();
+        ctx->null_cond = cond_make_f(ctx);
     }
     return true;
 }
@@ -859,7 +859,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
 
     switch (cf >> 1) {
     case 0: /* Never / TR    (0 / 1) */
-        cond = cond_make_f();
+        cond = cond_make_f(ctx);
         break;
     case 1: /* = / <>        (Z / !Z) */
         cond = cond_make_vi(zero_cond, res, zero_imm);
@@ -984,7 +984,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
     case 4:  /* undef, C */
     case 5:  /* undef, C & !Z */
     case 6:  /* undef, V */
-        return cf & 1 ? cond_make_t() : cond_make_f();
+        return cf & 1 ? cond_make_t(ctx) : cond_make_f(ctx);
     case 1:  /* == / <> */
         tc = d ? TCG_COND_EQ : TCG_COND_TSTEQ;
         imm = d ? 0 : UINT32_MAX;
@@ -1034,7 +1034,7 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
 }
 
 /* Similar, but for unit zero conditions.  */
-static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
+static DisasCond do_unit_zero_cond(DisasContext *ctx, unsigned cf, bool d, TCGv_i64 res)
 {
     TCGv_i64 tmp;
     uint64_t d_repl = d ? 0x0000000100000001ull : 1;
@@ -1058,7 +1058,7 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
     }
     if (ones == 0) {
         /* Undefined, or 0/1 (never/always). */
-        return cf & 1 ? cond_make_t() : cond_make_f();
+        return cf & 1 ? cond_make_t(ctx) : cond_make_f(ctx);
     }
 
     /*
@@ -1171,7 +1171,7 @@ static void gen_tc(DisasContext *ctx, DisasCond *cond)
         e = delay_excp(ctx, EXCP_COND);
         tcg_gen_brcond_i64(cond->c, cond->a0, cond->a1, e->lab);
         /* In the non-trap path, the condition is known false. */
-        *cond = cond_make_f();
+        *cond = cond_make_f(ctx);
         break;
     }
 }
@@ -1473,7 +1473,7 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         } else {
             tcg_gen_sub_i64(dest, in1, in2);
         }
-        cond = do_unit_zero_cond(cf, d, dest);
+        cond = do_unit_zero_cond(ctx, cf, d, dest);
     } else {
         TCGv_i64 cb = tcg_temp_new_i64();
 
@@ -2131,7 +2131,7 @@ static void do_page_zero(DisasContext *ctx)
 
 static bool trans_nop(DisasContext *ctx, arg_nop *a)
 {
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2145,7 +2145,7 @@ static bool trans_sync(DisasContext *ctx, arg_sync *a)
     /* No point in nullifying the memory barrier.  */
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2157,7 +2157,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
     tcg_gen_andi_i64(dest, dest, -4);
 
     save_gpr(ctx, a->t, dest);
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2172,7 +2172,7 @@ static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
 
     save_gpr(ctx, rt, t0);
 
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2217,7 +2217,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
     save_gpr(ctx, rt, tmp);
 
  done:
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2257,7 +2257,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
         tcg_gen_andi_i64(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
-        ctx->null_cond = cond_make_f();
+        ctx->null_cond = cond_make_f(ctx);
         return true;
     }
 
@@ -2331,7 +2331,7 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
     tcg_gen_andi_i64(tmp, tmp, ctx->is_pa20 ? 63 : 31);
     save_or_nullify(ctx, cpu_sar, tmp);
 
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2348,7 +2348,7 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 #endif
     save_gpr(ctx, a->t, dest);
 
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2512,7 +2512,7 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
         tcg_gen_add_i64(dest, src1, src2);
         save_gpr(ctx, a->b, dest);
     }
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2754,7 +2754,7 @@ static bool trans_lci(DisasContext *ctx, arg_lci *a)
        since the entire address space is coherent.  */
     save_gpr(ctx, a->t, ctx->zero);
 
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -2831,7 +2831,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
         unsigned rt = a->t;
 
         if (rt == 0) { /* NOP */
-            ctx->null_cond = cond_make_f();
+            ctx->null_cond = cond_make_f(ctx);
             return true;
         }
         if (r2 == 0) { /* COPY */
@@ -2842,7 +2842,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
             } else {
                 save_gpr(ctx, rt, cpu_gr[r1]);
             }
-            ctx->null_cond = cond_make_f();
+            ctx->null_cond = cond_make_f(ctx);
             return true;
         }
 #ifndef CONFIG_USER_ONLY
@@ -2910,7 +2910,7 @@ static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
     tcg_gen_xor_i64(dest, tcg_r1, tcg_r2);
     save_gpr(ctx, a->t, dest);
 
-    ctx->null_cond = do_unit_zero_cond(a->cf, a->d, dest);
+    ctx->null_cond = do_unit_zero_cond(ctx, a->cf, a->d, dest);
     return nullify_end(ctx);
 }
 
@@ -2936,7 +2936,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
             tcg_gen_subi_i64(tmp, tmp, 1);
         }
         save_gpr(ctx, a->t, tmp);
-        ctx->null_cond = cond_make_f();
+        ctx->null_cond = cond_make_f(ctx);
         return true;
     }
 
@@ -3460,7 +3460,7 @@ static bool trans_ldil(DisasContext *ctx, arg_ldil *a)
 
     tcg_gen_movi_i64(tcg_rt, a->i);
     save_gpr(ctx, a->t, tcg_rt);
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -3471,7 +3471,7 @@ static bool trans_addil(DisasContext *ctx, arg_addil *a)
 
     tcg_gen_addi_i64(tcg_r1, tcg_rt, a->i);
     save_gpr(ctx, 1, tcg_r1);
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -3487,7 +3487,7 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
         tcg_gen_addi_i64(tcg_rt, cpu_gr[a->b], a->i);
     }
     save_gpr(ctx, a->t, tcg_rt);
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     return true;
 }
 
@@ -4689,7 +4689,7 @@ static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     /* Seed the nullification status from PSW[N], as saved in TB->FLAGS.  */
-    ctx->null_cond = cond_make_f();
+    ctx->null_cond = cond_make_f(ctx);
     ctx->psw_n_nonzero = false;
     if (ctx->tb_flags & PSW_N) {
         ctx->null_cond.c = TCG_COND_ALWAYS;
-- 
2.53.0


