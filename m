Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8259C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8Y-00081R-Qw; Wed, 15 May 2024 05:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8C-0005wP-Pr
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B89-0001fT-EF
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-420180b5838so20498605e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766059; x=1716370859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l70NVTnTNxZE1g+5+378o7Svk1vAno2NTsB+Y4jn2m0=;
 b=rSMw25bDeGuFoGRCquHMpMdk8uy/LJbK78NNRRuYGWCSzvamxHtLD3Q6bHwy70ASsA
 QMCfsCTj9xw1TNL6gw7N5KE8cQLxgfS4ral122vtJfFl9+vTZXeyQH2jef6YC7WLX6xo
 o7N51Ydqo6WqZTMtZ4qEs44Nx99lnYHNh12dsgTlz2AhnTJr0jHCMf6B3CS6z+T1GHLm
 L0o1LwSxVkI7PzmOfTxzGFuG2e0TIxcaJcK6IpgbvcB5Gyskw/Ae3O5AxBMWAyrf1HH0
 nu5mOREvO4dF0TtGf560/lmTML7x4QvVbTRHGcSS8RqqbwebCGwz0TXXpb2SdaPEnUZc
 43KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766059; x=1716370859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l70NVTnTNxZE1g+5+378o7Svk1vAno2NTsB+Y4jn2m0=;
 b=i3vigatOys2Lu4L+f+w7C/AHMDQqNfWhJ7sl4jgM4CqNNAtjaaTDqQ18j4gjmriizm
 Y+0+uX9Jw/hmjSjuhk/sU6JYXc796C92t/cP+WgmrhxuFs6/71z9Ng6wlZW11gBuh9jM
 GSx5KqTjJl0BWk0kZD62HsDdvAKl/K/FJkT87pB8mIv0U9Fu74Xp6Qc//6FuRK6hJ/ej
 5G0hOwg9KYpWCxRsFn4ZoNlYevRNyqCsOIRLdZVzQmJLE87ELWN+iZtZ4R3dcUe2N2gL
 Pxav8zqMboAv6OEMNWfCvLqxKt9nV/5LAhqfy3zPE+fX80J8RNArJH4LYyuPzuNS+cRj
 A/Qg==
X-Gm-Message-State: AOJu0YxYPlYTchWp2kXHhKhuDqtoBZJ2l75eGniUlW0k8R+//H+RRyl3
 1Fge63qXH6BPzzrSdBrNvK08nMmaILxsZ2ey6JFAy9jMaXr8y+UTWsyJYiRVgvG4nV6ysTX1Tbg
 7r2U=
X-Google-Smtp-Source: AGHT+IH3rws0etYB40miAasglYFV/2thiFdCz02yKZ9pZMiR+vBM2zKq06XWhz3NFI2284bfMvSx1A==
X-Received: by 2002:a05:6000:1d9b:b0:351:b7c8:3efe with SMTP id
 ffacd0b85a97d-351b7c83f88mr13829365f8f.3.1715766059438; 
 Wed, 15 May 2024 02:40:59 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/43] target/hppa: Rename cond_make_* helpers
Date: Wed, 15 May 2024 11:40:19 +0200
Message-Id: <20240515094043.82850-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Use 'v' for a variable that needs copying, 't' for a temp that
doesn't need copying, and 'i' for an immediate, and use this
naming for both arguments of the comparison.  So:

   cond_make_tmp -> cond_make_tt
   cond_make_0_tmp -> cond_make_ti
   cond_make_0 -> cond_make_vi
   cond_make -> cond_make_vv

Pass 0 explictly, rather than implicitly in the function name.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index de077e7a57..07ba35001b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -345,32 +345,32 @@ static DisasCond cond_make_n(void)
     };
 }
 
-static DisasCond cond_make_tmp(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
+static DisasCond cond_make_tt(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
     return (DisasCond){ .c = c, .a0 = a0, .a1 = a1 };
 }
 
-static DisasCond cond_make_0_tmp(TCGCond c, TCGv_i64 a0)
+static DisasCond cond_make_ti(TCGCond c, TCGv_i64 a0, uint64_t imm)
 {
-    return cond_make_tmp(c, a0, tcg_constant_i64(0));
+    return cond_make_tt(c, a0, tcg_constant_i64(imm));
 }
 
-static DisasCond cond_make_0(TCGCond c, TCGv_i64 a0)
+static DisasCond cond_make_vi(TCGCond c, TCGv_i64 a0, uint64_t imm)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
     tcg_gen_mov_i64(tmp, a0);
-    return cond_make_0_tmp(c, tmp);
+    return cond_make_ti(c, tmp, imm);
 }
 
-static DisasCond cond_make(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
+static DisasCond cond_make_vv(TCGCond c, TCGv_i64 a0, TCGv_i64 a1)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
 
     tcg_gen_mov_i64(t0, a0);
     tcg_gen_mov_i64(t1, a1);
-    return cond_make_tmp(c, t0, t1);
+    return cond_make_tt(c, t0, t1);
 }
 
 static void cond_free(DisasCond *cond)
@@ -789,7 +789,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32u_i64(tmp, res);
             res = tmp;
         }
-        cond = cond_make_0(TCG_COND_EQ, res);
+        cond = cond_make_vi(TCG_COND_EQ, res, 0);
         break;
     case 2: /* < / >=        (N ^ V / !(N ^ V) */
         tmp = tcg_temp_new_i64();
@@ -797,7 +797,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         if (!d) {
             tcg_gen_ext32s_i64(tmp, tmp);
         }
-        cond = cond_make_0_tmp(TCG_COND_LT, tmp);
+        cond = cond_make_ti(TCG_COND_LT, tmp, 0);
         break;
     case 3: /* <= / >        (N ^ V) | Z / !((N ^ V) | Z) */
         /*
@@ -819,10 +819,10 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_sari_i64(tmp, tmp, 63);
             tcg_gen_and_i64(tmp, tmp, res);
         }
-        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
+        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
         break;
     case 4: /* NUV / UV      (!UV / UV) */
-        cond = cond_make_0(TCG_COND_EQ, uv);
+        cond = cond_make_vi(TCG_COND_EQ, uv, 0);
         break;
     case 5: /* ZNV / VNZ     (!UV | Z / UV & !Z) */
         tmp = tcg_temp_new_i64();
@@ -830,7 +830,7 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         if (!d) {
             tcg_gen_ext32u_i64(tmp, tmp);
         }
-        cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
+        cond = cond_make_ti(TCG_COND_EQ, tmp, 0);
         break;
     case 6: /* SV / NSV      (V / !V) */
         if (!d) {
@@ -838,12 +838,12 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32s_i64(tmp, sv);
             sv = tmp;
         }
-        cond = cond_make_0(TCG_COND_LT, sv);
+        cond = cond_make_ti(TCG_COND_LT, sv, 0);
         break;
     case 7: /* OD / EV */
         tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, res, 1);
-        cond = cond_make_0_tmp(TCG_COND_NE, tmp);
+        cond = cond_make_ti(TCG_COND_NE, tmp, 0);
         break;
     default:
         g_assert_not_reached();
@@ -905,9 +905,9 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
             tcg_gen_ext32s_i64(t1, in1);
             tcg_gen_ext32s_i64(t2, in2);
         }
-        return cond_make_tmp(tc, t1, t2);
+        return cond_make_tt(tc, t1, t2);
     }
-    return cond_make(tc, in1, in2);
+    return cond_make_vv(tc, in1, in2);
 }
 
 /*
@@ -979,9 +979,9 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
         } else {
             tcg_gen_ext32s_i64(tmp, res);
         }
-        return cond_make_0_tmp(tc, tmp);
+        return cond_make_ti(tc, tmp, 0);
     }
-    return cond_make_0(tc, res);
+    return cond_make_vi(tc, res, 0);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
@@ -1040,7 +1040,7 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
     tcg_gen_andc_i64(tmp, tmp, res);
     tcg_gen_andi_i64(tmp, tmp, sgns);
 
-    return cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp);
+    return cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp, 0);
 }
 
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
@@ -1454,7 +1454,7 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
         }
 
         tcg_gen_andi_i64(cb, cb, test_cb);
-        cond = cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb);
+        cond = cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb, 0);
     }
 
     if (is_tc) {
@@ -3543,7 +3543,7 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
         tcg_gen_shl_i64(tmp, tcg_r, tmp);
     }
 
-    cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3560,7 +3560,7 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
     p = a->p | (a->d ? 0 : 32);
     tcg_gen_shli_i64(tmp, tcg_r, p);
 
-    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -4364,7 +4364,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
         switch (a->c) {
         case 0: /* simple */
             tcg_gen_andi_i64(t, t, 0x4000000);
-            ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+            ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
             goto done;
         case 2: /* rej */
             inv = true;
@@ -4394,16 +4394,16 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
         if (inv) {
             TCGv_i64 c = tcg_constant_i64(mask);
             tcg_gen_or_i64(t, t, c);
-            ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
+            ctx->null_cond = cond_make_tt(TCG_COND_EQ, t, c);
         } else {
             tcg_gen_andi_i64(t, t, mask);
-            ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
+            ctx->null_cond = cond_make_ti(TCG_COND_EQ, t, 0);
         }
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
 
         tcg_gen_extract_i64(t, t, 21 - cbit, 1);
-        ctx->null_cond = cond_make_0(TCG_COND_NE, t);
+        ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
     }
 
  done:
-- 
2.34.1


