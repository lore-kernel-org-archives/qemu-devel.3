Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D749CD1290
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlQ-0002fi-W7; Fri, 29 Mar 2024 18:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl8-0002a5-4D
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl6-0003Xf-7Z
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e2178b2cf2so17512295ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751494; x=1712356294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8E6cou+7Nj72A3SF6Jpjpj6zfeFiz5qaUOwtzCNxnY=;
 b=sbLoLvQ4meffAwa/3OP4Q4/XIthPczmUpUQ+c8zbRYrsu8MZZIM+x1ZsHXo807b4ft
 OvflfvLgglaXH0EX7iQllzaRir88FtD6/2jtzg4oqbmTGpKxguTAhiHgChybNP7C11Oe
 vg5DcTQrINgOVWG/jhK9iCbSwiK2/h2K1Ib+dJk8j9tmhgTK8hHnV3/ugpGf3ZXW+Px0
 jiEiky0G5+Xm3bFeC68St//E4f7KYz6Zb8xKBWWTEp4X2OkV9ArEHkr6jm+XWC9UZCYh
 r1gC1l5ws1pUUpcz+0rpZ/CH/bd00cjpZwI5osGRc30BRg9/An8ZWh5G2YbfgqtQ9qd7
 ux6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751494; x=1712356294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8E6cou+7Nj72A3SF6Jpjpj6zfeFiz5qaUOwtzCNxnY=;
 b=wdVGMGT2vKw4SUSY5bsnFuV4hO3UzuaVdjq45ZKhk1p0aMLpfsFMbCrgWPxbEmGDMc
 odBsz8kQwWsfrBfQihhfxeIpKkQQgdHj73HzRmc3hELfjLqZ+WotEvJvSEZ6oJSRy+an
 OP5zmjJVf8JzqJnWmHZ0pEHGRMKrpdrg169RJAcQ/TGgkioE0aVxVjwAG+gyqvfwv64l
 klMOFh7UaraHPAm8NbomRVEStbbFLfd7+M2crgb69WDBQ6cSV4b/TaA7H/v6dkquwKcN
 Pxf2h+Zod+x0OLzy+jsiUqS/dpTDRJwRN2G0j3e3kKmYOo6eApil9hFhJiYKAcZNFM1h
 hHJA==
X-Gm-Message-State: AOJu0YxjUO+Casyif6S5EtN7hWH/I30hbE21lUR02l9ttNPMOcTD+yET
 JI0281xFR0SaAUU+nAZDBFwneDQjtg7CVz+PHgM4rvzMvFMhEvGNvEscCKTFBwzOesYUqHfBpXF
 t
X-Google-Smtp-Source: AGHT+IG+dd2TqL55Gck2AGNqkWGm7KFsNo7soPqjI1lyUNZGNCyj1+Dgf6f79l8+2BRt++Fr+tr+3g==
X-Received: by 2002:a17:902:7848:b0:1e2:a70:247e with SMTP id
 e8-20020a170902784800b001e20a70247emr3635508pln.18.1711751494632; 
 Fri, 29 Mar 2024 15:31:34 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 14/18] target/hppa: Fix overflow computation for shladd
Date: Fri, 29 Mar 2024 12:31:07 -1000
Message-Id: <20240329223111.1735826-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 84 +++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 19 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9d31ef5764..6da9503f33 100644
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
@@ -1003,9 +1004,49 @@ static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
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
+
+            /* Compare the sign against all lower bits. */
+            tcg_gen_sextract_i64(tmp, orig_in1, sign_bit, 1);
+            tcg_gen_xor_i64(tmp, tmp, orig_in1);
+            /*
+             * If one of the bits shifting into or through the sign
+             * differs, then we have overflow.
+             */
+            tcg_gen_extract_i64(tmp, tmp, sign_bit - shift, shift);
+            tcg_gen_movcond_i64(TCG_COND_NE, sv, tmp, ctx->zero,
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
@@ -1020,19 +1061,19 @@ static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
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
@@ -1050,9 +1091,6 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         }
         tcg_gen_xor_i64(cb, in1, in2);
         tcg_gen_xor_i64(cb, cb, dest);
-        if (cond_need_cb(c)) {
-            cb_cond = get_carry(ctx, d, cb, cb_msb);
-        }
     } else {
         tcg_gen_add_i64(dest, in1, in2);
         if (is_c) {
@@ -1063,18 +1101,23 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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
@@ -2843,7 +2886,6 @@ static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf_d *a)
 static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
 {
     TCGv_i64 dest, add1, add2, addc, in1, in2;
-    TCGv_i64 cout;
 
     nullify_over(ctx);
 
@@ -2880,19 +2922,23 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
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
@@ -3419,7 +3465,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
         tcg_gen_add_i64(dest, in1, in2);
     }
     if (cond_need_sv(c)) {
-        sv = do_add_sv(ctx, dest, in1, in2);
+        sv = do_add_sv(ctx, dest, in1, in2, in1, 0, d);
     }
 
     cond = do_cond(ctx, c * 2 + f, d, dest, cb_cond, sv);
-- 
2.34.1


