Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B162C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0Xj-0004Vu-9g; Tue, 26 Mar 2024 02:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp0Xh-0004VY-1v
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:44:17 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp0Xf-0004YH-A4
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:44:16 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c3acf4b0e1so3076828b6e.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 23:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711435452; x=1712040252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9CLORt38yZiQ1fCLl5knbBMBJnlvZ9He6LtCWjt6QA=;
 b=NzZiqrW9kDYmldoioHvJB/RAr5GwRlKw5lfY75aDcrTSHKnrIO8ebFKiPGIVlRs69f
 /Cz4BQOAAI8m/8uNY8rVn7mtroY//0dZNpFHxT9QmLhZp1lVIyB3CCPs8JSrHUsFAkRp
 wagNSSsvSXAgGiadRyshqJnsyD2hXSppmu75JmIBZEVF7utnVorjKh31LMWMSL5cDLlG
 thEWlpe26DRwfVHWDD+JETv49vUTXBrESLPICPy4r8fWtStVWdNXQa8opdCiryEn2Wai
 mBykVJdbqJNI0wbe5gc46c27BmqBksQtAeRxLBMWQQXK3xbL0jotBQA//GZpmpSu+5OW
 0PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711435452; x=1712040252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9CLORt38yZiQ1fCLl5knbBMBJnlvZ9He6LtCWjt6QA=;
 b=kXQH3DsR9x3M2U9kVTxZtEtrXNVJ4H/mM/x4dcZhMXHGNAGxI6woZfnqIwBlB0gc0W
 p6KqaotA9p+D4730PNo0EARWXZpt+fzyGlcY+jb+R1WLYnmJF2SFRkjZkw/iZrmiN9IR
 y9ea7E03c3JBvWgTWyGN9tXwkW456151h50RAJchN9eMPfLAM9+DIGZ+Fi5IchYZoK3f
 4lnWCVEQ/uvGwt1UeP6KYUAQlT+3y/OWeo7a040guNoP2rBdk5KZ4GwF+4tK4NeElbCR
 0gD4VRIZ7OHCynN/l8xj/zMA2HyVJ6S6si9uqyL4FdGTkl3LO3Lte41eTsAbRplaPGFe
 MOHg==
X-Gm-Message-State: AOJu0Yxy720FucOr106PSXYxfiID/i40ZQEcXeNoUWxjjKiN8NYsa4+J
 9cHu7GPfVVtL6nZeIkjQmwFjelPy5PZXjLqCzh+PAoosmwQNiWIkjIE24RHGf3oIWP/PGepn8v2
 S
X-Google-Smtp-Source: AGHT+IH2AfhF/A2bXoQ18EVrEes5JiPZsFohpAvLSFVuNMaJjenWZojRob9k5o6u9CkGEKDmn3bAdA==
X-Received: by 2002:a05:6808:1315:b0:3c1:c124:6d4d with SMTP id
 y21-20020a056808131500b003c1c1246d4dmr10844194oiv.56.1711435452525; 
 Mon, 25 Mar 2024 23:44:12 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a633503000000b005dc36761ad1sm6958819pga.33.2024.03.25.23.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 23:44:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 3/3] target/hppa: Fix overflow computation for shladd
Date: Mon, 25 Mar 2024 20:44:05 -1000
Message-Id: <20240326064405.320551-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326064405.320551-1-richard.henderson@linaro.org>
References: <20240326064405.320551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Overflow indicator should include the effect of the shift step.
We had previously left ??? comments about the issue.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 85 ++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9d31ef5764..0976372d16 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -994,7 +994,8 @@ static TCGv_i64 get_psw_carry(DisasContext *ctx, bool d)
 
 /* Compute signed overflow for addition.  */
 static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
-                          TCGv_i64 in1, TCGv_i64 in2)
+                          TCGv_i64 in1, TCGv_i64 in2,
+                          TCGv_i64 orig_in1, int shift, bool d)
 {
     TCGv_i64 sv = tcg_temp_new_i64();
     TCGv_i64 tmp = tcg_temp_new_i64();
@@ -1003,9 +1004,50 @@ static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
     tcg_gen_xor_i64(tmp, in1, in2);
     tcg_gen_andc_i64(sv, sv, tmp);
 
+    switch (shift) {
+    case 0:
+        break;
+    case 1:
+        /* Shift left by one and compare the sign. */
+        tcg_gen_add_i64(tmp, orig_in1, orig_in1);
+        tcg_gen_xor_i64(tmp, tmp, orig_in1);
+        /* Incorporate into the overflow. */
+        tcg_gen_or_i64(sv, sv, tmp);
+        break;
+    default:
+        {
+            int sign_bit = d ? 63 : 31;
+            uint64_t mask = MAKE_64BIT_MASK(sign_bit - shift, shift);
+
+            /* Compare the sign against all lower bits. */
+            tcg_gen_sextract_i64(tmp, orig_in1, sign_bit, 1);
+            tcg_gen_xor_i64(tmp, tmp, orig_in1);
+            /*
+             * If one of the bits shifting into or through the sign
+             * differs, then we have overflow.
+             */
+            tcg_gen_movcond_i64(TCG_COND_TSTNE, sv,
+                                tmp, tcg_constant_i64(mask),
+                                tcg_constant_i64(-1), sv);
+        }
+    }
     return sv;
 }
 
+/* Compute unsigned overflow for addition.  */
+static TCGv_i64 do_add_uv(DisasContext *ctx, TCGv_i64 cb, TCGv_i64 cb_msb,
+                          TCGv_i64 in1, int shift, bool d)
+{
+    if (shift == 0) {
+        return get_carry(ctx, d, cb, cb_msb);
+    } else {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        tcg_gen_extract_i64(tmp, in1, (d ? 63 : 31) - shift, shift);
+        tcg_gen_or_i64(tmp, tmp, get_carry(ctx, d, cb, cb_msb));
+        return tmp;
+    }
+}
+
 /* Compute signed overflow for subtraction.  */
 static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
                           TCGv_i64 in1, TCGv_i64 in2)
@@ -1020,19 +1062,19 @@ static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
     return sv;
 }
 
-static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
+static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
                    TCGv_i64 in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
 {
-    TCGv_i64 dest, cb, cb_msb, cb_cond, sv, tmp;
+    TCGv_i64 dest, cb, cb_msb, in1, uv, sv, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
 
     dest = tcg_temp_new_i64();
     cb = NULL;
     cb_msb = NULL;
-    cb_cond = NULL;
 
+    in1 = orig_in1;
     if (shift) {
         tmp = tcg_temp_new_i64();
         tcg_gen_shli_i64(tmp, in1, shift);
@@ -1050,9 +1092,6 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         }
         tcg_gen_xor_i64(cb, in1, in2);
         tcg_gen_xor_i64(cb, cb, dest);
-        if (cond_need_cb(c)) {
-            cb_cond = get_carry(ctx, d, cb, cb_msb);
-        }
     } else {
         tcg_gen_add_i64(dest, in1, in2);
         if (is_c) {
@@ -1063,18 +1102,23 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     /* Compute signed overflow if required.  */
     sv = NULL;
     if (is_tsv || cond_need_sv(c)) {
-        sv = do_add_sv(ctx, dest, in1, in2);
+        sv = do_add_sv(ctx, dest, in1, in2, orig_in1, shift, d);
         if (is_tsv) {
             if (!d) {
                 tcg_gen_ext32s_i64(sv, sv);
             }
-            /* ??? Need to include overflow from shift.  */
             gen_helper_tsv(tcg_env, sv);
         }
     }
 
+    /* Compute unsigned overflow if required.  */
+    uv = NULL;
+    if (cond_need_cb(c)) {
+        uv = do_add_uv(ctx, cb, cb_msb, orig_in1, shift, d);
+    }
+
     /* Emit any conditional trap before any writeback.  */
-    cond = do_cond(ctx, cf, d, dest, cb_cond, sv);
+    cond = do_cond(ctx, cf, d, dest, uv, sv);
     if (is_tc) {
         tmp = tcg_temp_new_i64();
         tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
@@ -2843,7 +2887,6 @@ static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf_d *a)
 static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 {
     TCGv_i64 dest, add1, add2, addc, in1, in2;
-    TCGv_i64 cout;
 
     nullify_over(ctx);
 
@@ -2880,19 +2923,23 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
     tcg_gen_xor_i64(cpu_psw_cb, add1, add2);
     tcg_gen_xor_i64(cpu_psw_cb, cpu_psw_cb, dest);
 
-    /* Write back PSW[V] for the division step.  */
-    cout = get_psw_carry(ctx, false);
-    tcg_gen_neg_i64(cpu_psw_v, cout);
+    /*
+     * Write back PSW[V] for the division step.
+     * Shift cb{8} from where it lives in bit 32 to bit 31,
+     * so that it overlaps r2{32} in bit 31.
+     */
+    tcg_gen_shri_i64(cpu_psw_v, cpu_psw_cb, 1);
     tcg_gen_xor_i64(cpu_psw_v, cpu_psw_v, in2);
 
     /* Install the new nullification.  */
     if (a->cf) {
-        TCGv_i64 sv = NULL;
+        TCGv_i64 sv = NULL, uv = NULL;
         if (cond_need_sv(a->cf >> 1)) {
-            /* ??? The lshift is supposed to contribute to overflow.  */
-            sv = do_add_sv(ctx, dest, add1, add2);
+            sv = do_add_sv(ctx, dest, add1, add2, in1, 1, false);
+        } else if (cond_need_cb(a->cf >> 1)) {
+            uv = do_add_uv(ctx, cpu_psw_cb, NULL, in1, 1, false);
         }
-        ctx->null_cond = do_cond(ctx, a->cf, false, dest, cout, sv);
+        ctx->null_cond = do_cond(ctx, a->cf, false, dest, uv, sv);
     }
 
     return nullify_end(ctx);
@@ -3419,7 +3466,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
         tcg_gen_add_i64(dest, in1, in2);
     }
     if (cond_need_sv(c)) {
-        sv = do_add_sv(ctx, dest, in1, in2);
+        sv = do_add_sv(ctx, dest, in1, in2, in1, 0, d);
     }
 
     cond = do_cond(ctx, c * 2 + f, d, dest, cb_cond, sv);
-- 
2.34.1


