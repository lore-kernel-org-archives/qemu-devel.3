Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E28FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAP-0007Xi-6A; Wed, 29 Apr 2026 20:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAD-00070d-A1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAB-0006Ry-52
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:56 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b9705613ddso2086175ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508513; x=1778113313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhCKVShMlJBi8gRbysM65ZJCFTfwAaPCS1vV8AfHK4I=;
 b=rBoi4C98AK06kx0Y7lWT5XK7RLL3fD9kksI4tR0d1KvegP0tdPbFbREA2H6wbyCzFk
 M35xmCTEuQWvE36iNwzZTM6R2I4cA7DrnmLdNvu1/keoWC7UyMwuX9m+iNPpP64Bm8Rr
 5Manh97oy1yTVpGkvmJawNHi23Du5UfzjkpV/70M6kN4reHGtO/FeVRvBshYKW10KTfz
 xyaVLAUPrh7+GQiUUc95ouwWqbCbXhVCB2dLqlbwYHL6AT4qyvAMHHKmJCZD73GRcPVc
 w0bobRHMIhATe5ZAd6PvXnhG864VcepEFQPhBNadvgVN9Vt6LFKkrtZNuOw9l9+7xoyY
 IZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508513; x=1778113313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UhCKVShMlJBi8gRbysM65ZJCFTfwAaPCS1vV8AfHK4I=;
 b=g7hhw4WAEy+NSMagV7xVxaaCm/8CZn21YPsCBpjD2b1YniFDNqJpG1VdqSTU6eKXOM
 294DVwETMsivRQfPq2EwV7Up7amYZkTq8z7gd/4Zp9BHManaLtS4vbxEPEmgDNajQaUf
 lA355nzIIm7WG9pUkoa3NjmkkTJCYKAn8yaeq6jM0glrqEQyvq+f8lhQbQDpEoyvXQcQ
 2VNuIfhUK/h+9br4GuLmk6C70bK1bfaehhhJB+qX4e9hx1aNFO5791o/FD4L81PuKWsZ
 jgCeUTfWPeSWD1RQJV2QmCuixODQePk/PIR7y6wsKWPWqJb/6JoC1BwJP8rSbMFXKmEx
 Kf1A==
X-Gm-Message-State: AOJu0Yz+ugoRdmPBmOAuePrrntLbQwQ+XegpIv3/f4NgLhXTdhdETkBC
 pXCkgAVNR5+2ei7h/n62tqL23FuojMqFks/r7380TueBGiGmFui+Chdp43scnkBWlNGvyFcb+lK
 LAgF9PkY=
X-Gm-Gg: AeBDiesdNzujuK8PEhNb68yVEGAWbSBCZd1qAjx6Ay6JCoy+Eo7E6XX8w77T4LS+U16
 9t94AQil7ZhIRqmj7UyPsm3UUgNxNZ/1ytsqIPq9OhstrN6GfyKPEtpJZgUhOjgqqc+5mLNLPr4
 EoiK4czgWOysdyjS8uNEw7x19Vfgktw5VMfJH4FGJ+rTB3jYtXIW7l9KoaFNSuS/x/n/kv1U4l4
 5R1jHvcnkZWpw1KrUJcTCfLDX27LL1Bvh5KdnqKtSfNulxa13dB5t9O4qiA6TlshaxWm32GBvgZ
 OTFPN/ygNrBZoJcMka/JNsUNQ6ulW3BrmWzo1tOL+x0VD+msvPdiNL7SYlgpqrxOah/HFWZEAKp
 ahdvRRKin+KLhXJr8YtSIIv1gQkm3D+SU9EnAf7JQlaUY9VYePterhHh2rXkgL6KUf48Ms1L9At
 rqXn9D66rCOU+Q61xoKZop9T/in5caVlSuluWl77cK
X-Received: by 2002:a05:6a20:430f:b0:398:71e4:6282 with SMTP id
 adf61e73a8af0-3a3cf521bd0mr684281637.4.1777508513362; 
 Wed, 29 Apr 2026 17:21:53 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 28/47] target/arm: Implement BFCVTN for SVE
Date: Thu, 30 Apr 2026 10:20:27 +1000
Message-ID: <20260430002046.59739-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 +
 target/arm/tcg/fp8_helper.c      | 96 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  3 +
 target/arm/tcg/sve.decode        |  2 +
 4 files changed, 103 insertions(+)

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
index 3e1ce24bd0..4270e13a8e 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -78,6 +78,15 @@ static FP8Context fp8_src_start(CPUARMState *env, uint32_t desc, int scale_mask)
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
@@ -102,6 +111,13 @@ static void float16_invalid_input(float16 *d, size_t nelem, float_status *s)
     float_raise(float_flag_invalid | float_flag_invalid_snan, s);
 }
 
+/* Invalid output format writes -1 and raises invalid.  */
+static void float8_invalid_output(uint8_t *d, size_t nelem, float_status *s)
+{
+    memset(d, -1, nelem);
+    float_raise(float_flag_invalid, s);
+}
+
 static bfloat16 fcvt_fp8e4m3_to_b16(float8_e4m3 x, int scale, float_status *s)
 {
     FloatParts64 p = float8_e4m3_unpack_canonical(x, s);
@@ -130,6 +146,47 @@ static float16 fcvt_fp8e5m2_to_f16(float8_e5m2 x, int scale, float_status *s)
     return float16_round_pack_canonical(&p, s);
 }
 
+static float8_e4m3 fcvt_b16_to_fp8e4m3(bfloat16 x, int scale,
+                                       bool saturate, float_status *s)
+{
+    FloatParts64 p = bfloat16_unpack_canonical(x, s);
+
+    p = parts64_scalbn(&p, scale, s);
+    /*
+     * Saturating Inf -> Max handled in uncanon_e4m3_overflow
+     * because there is no infinity encoding.
+     */
+    return float8_e4m3_round_pack_canonical(&p, s, saturate);
+}
+
+/*
+ * Because e5m2 has an infinity encoding, we need to handle
+ * conversion of Inf -> Max manually.  This will be converted
+ * to the actual maximum value during rounding.
+ */
+static void scalbn_to_fp8e5m2(FloatParts64 *p, int scale,
+                              bool saturate, float_status *s)
+{
+    if (unlikely(p->cls == float_class_inf)) {
+        if (saturate) {
+            p->cls = float_class_normal;
+            p->exp = INT_MAX;
+            p->frac = -1;
+        }
+    } else {
+        *p = parts64_scalbn(p, scale, s);
+    }
+}
+
+static float8_e5m2 fcvt_b16_to_fp8e5m2(bfloat16 x, int scale,
+                                       bool saturate, float_status *s)
+{
+    FloatParts64 p = bfloat16_unpack_canonical(x, s);
+
+    scalbn_to_fp8e5m2(&p, scale, saturate, s);
+    return float8_e5m2_round_pack_canonical(&p, s, saturate);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -406,3 +463,42 @@ void HELPER(sme2_fcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
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
+                fcvt_b16_to_fp8e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(2 * i + 1)] =
+                fcvt_b16_to_fp8e5m2(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            bfloat16 e0 = n0[H2(i)];
+            bfloat16 e1 = n1[H2(i)];
+            d[H1(2 * i + 0)] =
+                fcvt_b16_to_fp8e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(2 * i + 1)] =
+                fcvt_b16_to_fp8e4m3(e1, ctx.scale, osc, &ctx.stat);
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
index 5200f3d034..7276d9c44a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4099,6 +4099,9 @@ TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
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


