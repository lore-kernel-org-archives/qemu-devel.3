Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FD9C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kly-00005g-KZ; Thu, 24 Sep 2026 10:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9kld-0008Ml-MW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:46 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klY-0005F3-Uz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:44 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-868b2e5be4eso826238b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261380; x=1790866180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uv+G7cyiouAqurlZMl2qt+7AlS770yvplz85F2mPwwg=;
 b=X4Mb1MetAImNHWa7kUSvcpVR/BeFuJwiYO6+cW2aHk16xaqeYtnTn4eGPKNBEa2MXS
 ZUEZg5z1x1+P5uldgE2R7q7gVd0n79RxVAWXt72UP6ukmestCAdSTS6t6nZgebj27mSS
 hk8QrRugV4xG5QUg3dVymUgmT4VEw3FARSEB6EBHV/nIWBVNhZvKpwtDCGFGOrKOTqk/
 RUqE3aJuanNke1i9FbQnAnLfTybVDcSxNO+IrX+t7o//w+z2hfmlt0wYkV5IE93lGgZU
 8EDOpu7O/mWRulADDNxjNC+oEGY5h/TKT08CeUtVUV6UOitKW17YIZGSg9JNtUV3T2Qs
 kvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261380; x=1790866180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uv+G7cyiouAqurlZMl2qt+7AlS770yvplz85F2mPwwg=;
 b=q88Tnhel2ut5sCp3Xyrbi06KlX/TDB7H1RvEXxNgDUrq5KIJMLRy+rPuRQItfBPADe
 acKIZeV3mf1CTsnlkiNgw0ir2eTxwc70TZg1vtwPRZLnTH7qZGv0bficw3V6lJfWAOJm
 L4VOgQMT+bBU4fnB+ZuXVkUURPpavytHamR3L1ZBva8TFwQynVxjMhseaM6f8V4in4Vc
 loVIIptn3LY5LLKPxYZkx1wtZ0F2a/3rCnCrd/8rOz6u/1/l1Z/IMtMsy3toTtYGoRxz
 0HcaINgCjhMPG51lYn98AqkMNhqrJ8TfMeulB3QHh5Pm8uAOFicnM1sdFs7t6ytTCnYU
 bfqg==
X-Gm-Message-State: AFuF++lLB36eWXN636KCnrBlLJRW0eMvVbYsjeg+oT0DNx/PDG1Akfjs
 aVa2myiqcV9bySSM0FNGmabILBBqbI/SXSh75DHuvGe1whVRSjGw/m+4oxae8YK168GptMS7ms5
 sp9BU
X-Gm-Gg: AYBFou0DPy/5M57VT40IN/9mMSr9Y/h8DD3nL/DqMEFRH2NjZPAgWlpycKYPqlwhmyj
 IL/LHNs1gThTXNJQiXNUncQnD0JAH4UFMsaAxCVS/CmPPBzO9FFVhcZ5MIdDADlVK/4zryNnVpa
 sehQ1hWcWsofZqsi9fic0YmmIebELgo/AYZhSeW31hY8/ZTMSNQ9KUGvzxe3y3OJezIsYnEENyX
 UsFq8P4wPdydi3JwDgZ5zk8sVqSmnsqVDjM4R6RJ28eitSsct6i+JnkRHEEu8RJABkzlY2RQrMD
 MFD9i8rB4qM/31WxOPNPqdke1P36xVRi8tKNdkQIyp3M/d46KFN9XKtnYIS9/UHn0QPm/k2lvYr
 GXk+yNhFI78dJ0wNZKIyTenKXRSGNp3yiqj+uiPXIW12HZpmS08iRYEYyy2Rrhsj4S0CMwdNTNq
 G3IecKtmBa7IdQKG/5r4RQjwlI//ENAklAA8RahfXcrE+uKJVzAz6Djs0p92fEfCDW6hCK3C9Up
 L9uQ5DO+/9uUX4u+y9SehMsOF41pK00lR8CHLnVKoiMrY9hqvQ=
X-Received: by 2002:a05:6a00:6ca5:b0:878:3507:8d62 with SMTP id
 d2e1a72fcca58-87e9dfafae9mr2483265b3a.41.1790261379306; 
 Thu, 24 Sep 2026 07:49:39 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 8/8] target/hppa/tcg: Always initialize DisasCond.{a0,a1}
Date: Thu, 24 Sep 2026 07:49:31 -0700
Message-ID: <20260924144931.161335-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
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


