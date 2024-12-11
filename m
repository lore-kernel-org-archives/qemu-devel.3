Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD565E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPgu-0006At-3k; Wed, 11 Dec 2024 11:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdZ-0006Vq-KS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:33 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdX-0001TN-NS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:33 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46753242ef1so55628471cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934751; x=1734539551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzXVAFhwLhHjMlw7+JtsqHzAv3kMgsjwAUaa310i+wU=;
 b=UmH/0vsbhbnxRJQ97pHpHUYzGmSFkYL3JLkRvTXMfdTMft7K9Xtp02If19oNujqBik
 d0/YrQFgns+OOpnOutUKZo2LejA4fx/wULddfS+u8x0gRiYbwD6O9Ek/I1QKE0hcmKOn
 w/aBydYN7isvDm7r6raRq3mE3W3Afj8LVoIoV0f3F3Q3EoLAXCE6wNe9gtZ8RracgkNZ
 X5Pb8LrPrSzlQ4FNF/8IlTACMjd0nDTo02YOVi10J16g7n5+uJciaE65gRN0ygMlHFBV
 5JnFBGInbHqKEgDNx0SkbS6TtSDYiPesjQMbC8ux3mEuEcOAUb3JOlhJEToW4Qi0BAcE
 Jttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934751; x=1734539551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzXVAFhwLhHjMlw7+JtsqHzAv3kMgsjwAUaa310i+wU=;
 b=cxlUn2iyy2p4DTaRzJeDfWsHqPH8R481cAoujQ2DxAT/ivjXuhaaBrzdMD3chS8fhQ
 dpTrewv8GLroHw7gAWr8G7mK7GlF93jSIgyatBgel67iXZGH0FKF1DnsG8JS+mNK8irE
 miZBJie/OoDEogxX6d4w3l/gehEdnfcUFLUSBwcpE7w4QynimvQqdcLWVMXGg1wEP+e8
 ZB3amwDYQKl4XLJk3gQNNWt7v8o4pHZr4mPbw6w9UqE/xJ4hFLc5gNaGNhsmqE2/09hg
 OxIEGfi0kjMTHZ80f4fom+TYCVCdEBXXSDf4eNsE0y37Tkwd7JzZH6kRFrMcKqA26aPq
 uEXA==
X-Gm-Message-State: AOJu0YxpJhE1wtdYUkNj4A81Vi7QmuEaDJ+/Fwxi5z9B9MA4ej9aIxN/
 E/IB5OjKQ8ZieAyLY2fpzYUda3IEeDgBkkSld6fT9XA4G4J0Ij4McI2BnWE1C1QVYYcX3SrvMg7
 j/0jZfvDI
X-Gm-Gg: ASbGncvESYSfCvVH617EAIHMqeYCHd5xU3aLhti9r0d7qphEAC10tH8OPgUIxcXR0rl
 /nCgxhs46G/EUV3tRO2dEcSkz7HUaWSNhLMxwYoiZDd3gcZcz/aJ1JgM/ND+iKNpIuGQvNZAWhg
 urBM5aj4/T4wgZT/3dw15oO/KAGfQFWdc1cWHPBzFFJ6EHJ7k0CPWAy+hgeMTAe/XQRW3O5UNYH
 X5t8/A5DVf+kvtmaakTAgN8k7GhDY0rIS0cyhrakrh13KB2cbLVaBu3c6Xk8w==
X-Google-Smtp-Source: AGHT+IG7xNI86DphCbJRgbBvDdKWQ6vsYOVX7u61Zf/jJz4ZwSE3wZPbH2yF6d93bMsybWpVdinS1w==
X-Received: by 2002:a05:622a:114e:b0:466:b29a:9b10 with SMTP id
 d75a77b69052e-4678936287amr61023061cf.42.1733934750824; 
 Wed, 11 Dec 2024 08:32:30 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 36/69] target/arm: Convert ABS, NEG to decodetree
Date: Wed, 11 Dec 2024 10:30:03 -0600
Message-ID: <20241211163036.2297116-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 46 +++++++++++++++++++++++-----------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9bb9668d11..c697f0e944 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8889,6 +8889,33 @@ static const ENVScalar1 f_scalar_sqneg = {
 TRANS(SQNEG_s, do_env_scalar1, a, &f_scalar_sqneg)
 TRANS(SQNEG_v, do_env_vector1, a, &f_scalar_sqneg)
 
+static bool do_scalar1_d(DisasContext *s, arg_rr *a, ArithOneOp *f)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        f(t, t);
+        write_fp_dreg(s, a->rd, t);
+    }
+    return true;
+}
+
+TRANS(ABS_s, do_scalar1_d, a, tcg_gen_abs_i64)
+TRANS(NEG_s, do_scalar1_d, a, tcg_gen_neg_i64)
+
+static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_fn2(s, a->q, a->rd, a->rn, fn, a->esz);
+    }
+    return true;
+}
+
+TRANS(ABS_v, do_gvec_fn2, a, tcg_gen_gvec_abs)
+TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9213,13 +9240,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* CMEQ, CMLE */
         cond = u ? TCG_COND_LE : TCG_COND_EQ;
         goto do_cmop;
-    case 0xb: /* ABS, NEG */
-        if (u) {
-            tcg_gen_neg_i64(tcg_rd, tcg_rn);
-        } else {
-            tcg_gen_abs_i64(tcg_rd, tcg_rn);
-        }
-        break;
     case 0x2f: /* FABS */
         gen_vfp_absd(tcg_rd, tcg_rn);
         break;
@@ -9264,6 +9284,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         break;
     default:
     case 0x7: /* SQABS, SQNEG */
+    case 0xb: /* ABS, NEG */
         g_assert_not_reached();
     }
 }
@@ -9614,7 +9635,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         /* fall through */
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
-    case 0xb: /* ABS, NEG */
         if (size != 3) {
             unallocated_encoding(s);
             return;
@@ -9705,6 +9725,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* USQADD / SUQADD */
     case 0x7: /* SQABS / SQNEG */
+    case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
     }
@@ -10103,7 +10124,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         /* fall through */
     case 0x8: /* CMGT, CMGE */
     case 0x9: /* CMEQ, CMLE */
-    case 0xb: /* ABS, NEG */
         if (size == 3 && !is_q) {
             unallocated_encoding(s);
             return;
@@ -10280,6 +10300,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* SUQADD, USQADD */
     case 0x7: /* SQABS, SQNEG */
+    case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
     }
@@ -10324,12 +10345,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
     case 0xb:
-        if (u) { /* ABS, NEG */
-            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_neg, size);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_abs, size);
-        }
-        return;
+        g_assert_not_reached();
     }
 
     if (size == 3) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 17ecdac9db..f112951df7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1632,8 +1632,12 @@ SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_s
 
 SQABS_s         0101 1110 ..1 00000 01111 0 ..... .....     @rr_e
 SQNEG_s         0111 1110 ..1 00000 01111 0 ..... .....     @rr_e
+ABS_s           0101 1110 111 00000 10111 0 ..... .....     @rr
+NEG_s           0111 1110 111 00000 10111 0 ..... .....     @rr
 
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
 SQNEG_v         0.10 1110 ..1 00000 01111 0 ..... .....     @qrr_e
+ABS_v           0.00 1110 ..1 00000 10111 0 ..... .....     @qrr_e
+NEG_v           0.10 1110 ..1 00000 10111 0 ..... .....     @qrr_e
-- 
2.43.0


