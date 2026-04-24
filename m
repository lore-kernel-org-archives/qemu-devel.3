Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64122FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DR-0002ZW-FX; Fri, 24 Apr 2026 00:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DM-0002P7-S6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:28 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DL-0003Ya-7e
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:28 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-42fdab683b7so942238fac.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005145; x=1777609945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEaE+Gz4pYUADHfndZN2FYmsXkuJHrO7JwM42EplOck=;
 b=P7zpHjGP/UBRGPsjVFLhEE9y8jXpddbvQ7ul/FIFLx2tSPdBSjnI7gjnXaQ4s78EOE
 zQRLYJW7XCFgEffJeeTjDoNd8cKXbhq5xgdYf5HGeEc8rYtmY2Q2UGP7vDHhTE81GuSt
 ITBD1WTuW9ZDlQPq62HPee5RVKJ2WPQcvcLSV8j64/NHJolC+K8SGKcq+JdUXxExc2QD
 4RP8rpje69uiAa3G4Fj9PvXOeOB1eNz5YWyyh6YOlL7qSu5iwCLqL2XVQWD/HY6gTjOU
 AXvDLu4ADDrHglN5u8xFJxkWnDVX2/57Dsm15NAWv9dCZsO7gAtEk2HlUAdAv2H6Tne7
 4UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005145; x=1777609945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEaE+Gz4pYUADHfndZN2FYmsXkuJHrO7JwM42EplOck=;
 b=WD3AQJxvKjXD/4+q8quU8a/f+WNKoWf6YLmTSmdT5UUyVG//u/SnQ/4Z76RqNsJCOe
 0mdhXhsDDplkCzOlSBMkXZkZdQfy9BfzQzdlegqGWHWM/SbmNtZ+k6NYSgzMvotwyK54
 gHaWMvEFc9VcQMn7yf2UwVnwE3pZeLm7X7cj0lwtGJy0v7cF4IRGk3IUSF8tzotDlRGZ
 Epan6Y/eYSqet8zSIiEUJYemNNf1JTXmblP4/viJE1xkY5R3AkvT8KkjIbYTa39QH/7c
 oa4cTudj06bI5Bz5TcV9WalEquRPYk9NKwM0iKpSHnxwyjynzHdF5WUjiRR+Vf0atWBm
 nAmw==
X-Gm-Message-State: AOJu0YxJRgsia1TAiH1varOR+OE6evk3C1Ge/vIIw7zxGL39pRq0/wW6
 8Ill43G3WEAlw6T1pmbcLg4fXfgkkJzmYJuNUZfKwc9+tRt7xDUlGBCH+FFNhrL2hYAOaM/gB1N
 SnWC3umc=
X-Gm-Gg: AeBDieuXmYzi6mQtVdqbufSkH+ntj0AwcI/MiA3XzqFYLVf2CkP3RIok7CtjOcwr/5M
 Dxk7J1aiNiAdNfvzUcNQeIrseE1H3v7aW5HxYJqxl2Y1EggtuIR9QaCNb9OfyJfY4KuUBnuKDsK
 ycCa9k5oXYyy0fBzL8rPvRNiIGU9Fv1QaXz7sAr0G7aP3qlfqxHylgQUhd8WJQ+dOlQMpjsv79y
 uI4wh1cI5MAgktgH20VYtDC3O8sRSGYQbJfbK4B2mzqPdPlcJlJBwibC1C7vOWYrcYIgiOCtlxB
 sYlDvke/9VGUhoG1Wzx6T2FOFf1WqfrWVRHriconc9oy3VHBvIysav8hh8XvVVRTiQBN0+gDxgc
 SnAEayB7G/L98xkjMemjctvlMkfNe++fNbL6SYrM7id2U7hK7tVy8jYwbzXCgqAPBX2jvO3foUG
 pofjrNtM9d83dz6bGGtU0Pl9wJx3BHYtoDV+UF/On0uXNlbPrV4i2vUs8a2t7/KSH4Wd2V21TZ
X-Received: by 2002:a05:6870:702a:b0:417:70d2:f991 with SMTP id
 586e51a60fabf-42abf236519mr18907955fac.8.1777005144581; 
 Thu, 23 Apr 2026 21:32:24 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 30/40] target/arm: Implement BFCVTN for SVE
Date: Fri, 24 Apr 2026 14:30:04 +1000
Message-ID: <20260424043014.46305-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 55 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  3 ++
 target/arm/tcg/sve.decode        |  2 ++
 4 files changed, 62 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index b5dc2b7064..bbc8d69e28 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -12,3 +12,5 @@ DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 2b1955508d..ad5a2dc64d 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -77,6 +77,15 @@ static FP8Context fp8_src_start(CPUARMState *env, uint32_t desc, int scale_mask)
     return fp8_start(env, desc, f8fmt, scale);
 }
 
+static FP8Context fp8_dst_start(CPUARMState *env, uint32_t desc)
+{
+    uint64_t fpmr = env->vfp.fpmr;
+    FPMRType f8fmt = FIELD_EX64(fpmr, FPMR, F8D);
+    int scale = FIELD_SEX64(fpmr, FPMR, NSCALE);
+
+    return fp8_start(env, desc, f8fmt, scale);
+}
+
 /*
  * Invalid input format is treated as snan, then the conversion operation
  * converts to default nan and raises invalid.
@@ -101,6 +110,13 @@ static void float16_invalid_input(float16 *d, size_t nelem, float_status *s)
     float_raise(float_flag_invalid | float_flag_invalid_snan, s);
 }
 
+/* Invalid output format writes -1 and raises invalid.  */
+static void float8_invalid_output(uint8_t *d, size_t nelem, float_status *s)
+{
+    memset(d, -1, nelem);
+    float_raise(float_flag_invalid, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -377,3 +393,42 @@ void HELPER(sme2_fcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sve2_bfcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            bfloat16 e0 = n0[H2(i)];
+            bfloat16 e1 = n1[H2(i)];
+            d[H1(2 * i + 0)] =
+                bfloat16_to_float8_e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(2 * i + 1)] =
+                bfloat16_to_float8_e5m2(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            bfloat16 e0 = n0[H2(i)];
+            bfloat16 e1 = n1[H2(i)];
+            d[H1(2 * i + 0)] =
+                bfloat16_to_float8_e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(2 * i + 1)] =
+                bfloat16_to_float8_e4m3(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        float8_invalid_output(d, oprsz, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e31ab609f9..54f1b253c6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4098,6 +4098,9 @@ TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
 TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
            gen_helper_sve2_bfcvt, true, true)
 
+TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_bfcvtn_bh, false, false)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index ca110f4bc1..b6ef8ed8de 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1101,6 +1101,8 @@ BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
 BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
+BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
+
 ### SVE FP Compare with Zero Group
 
 FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
-- 
2.43.0


