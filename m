Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D79BCD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYD-0001xr-Go; Wed, 10 Jun 2026 12:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY6-0001N5-R7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLY4-0005gB-Ja
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490c1915793so49983425e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107979; x=1781712779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldD7uq8CtKbO8z66zG95Ud/dRrfQ003dYkJ1EjnaVvY=;
 b=BjJwpqNcioS216DWhCDPPfUcJX0ywDgpapZ4cl+FdCEpuYUuRWZNTiSdqjWKP7wjda
 54Hr+Gpg37nU5vLdfyvIBmVbILZYyaYGrqA9XcbuyTTolrd2bzDOPomKalmyV1jTMk17
 rD6ihAQirOj5tvmPYk/zJ2Oiju4QGyQUa8IKg0Ly/gFStgGa7O5KsGpKPKkng3W++Ntp
 s/owqBppnhugEDIztb3o8Xb9vPZVjcSqTsriKV0yYXVPz7ZBqhepmoKneN6GALmfhe7V
 JglEE2OJEVxsQFhg06QSfPcybKttPP+KWW+3rfE5jh0BKRJD37FWgpfl5hv8mFRkQLHy
 K+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107979; x=1781712779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ldD7uq8CtKbO8z66zG95Ud/dRrfQ003dYkJ1EjnaVvY=;
 b=Lkm0C0G6tmCkAtPPHPDC70LHj8hA0tHtCjpUNLQyx9kMbGMs1xh7hivVByhzXwhne9
 xIE4kYO92sJK9jgbgvTowfpkH04PDuD83EqcJ1mlIxtCLtxaYL8sNYNW3AgOHgMZOcn8
 T7B0Dbhe+sOfloZyjNG3N/cfw3UILmByMcUTKOMF75DHhzOPmi810VANuIeIk3IV4Jn4
 tAwzu/snGEQIhWpsoH3EgJZsIFf35NOnElD9hGv9YzpcXrmShZGvfNsjZ75eSdvNEofp
 X17LKdqXgAQmd1Tc+in6pfGaSSnSEttIFdWS1R4ya+8IZqVjBEn27ouNjgENK0IJUmCk
 F28g==
X-Gm-Message-State: AOJu0YyZrknWniBrsnN/XE7fd6IyQdnEB2izbwLuhRbqBibaSpfn0R71
 Vwocmvnbe1tvhnseTSU64oDrtS1RTcAPvvMzyH6IQ3C+YSRamNgCsmlhVBwhsoWkPCTqpNSAcEJ
 nhOEs
X-Gm-Gg: Acq92OFezkfV0JpYf4A+iv+dSa6I53DD0lFiTZTqwd8WMYqnlU6f5ZhK8FiiXnDXOZx
 VRs/RJF/JrVHZj5MIOiUED3FiftrWXAMwO/yNwcEhBFx1YhZ/j4B/Gq52hZF5lCUS06K6HJX3eC
 L595C/rdT5C08u/e3JAAw2xvNszLaoNJO5Seeyu8HxWeQMkyOFW9cfU5qx5pn/EkLLvs+xBWRsy
 aHdeZQ21fDMgyaEJqBEClA1ejOykndYdsoUEwqUMm7xei6V1pXVTZCw22Dqkd2FHCRgQvteBiC2
 YUnk7m5BcwmGUe20+xZrjbdMQdVAnd8bBQAB1A01qdp0Q98XFrRISJ6mX7bkVBu9Ifdu5sKWS4t
 BH1Pn0BcFC/H/bxKp4CBZCev+G7UoPpEPfk5JaSCGTYrNxeKeXI71KlcrlyoA6OJaC/l9XXAGa7
 1NADlZ2HRRAnu33owxrOYLi96BzYJm5e4pMo8hNirWmS6/UbXwNUGlliV5XPues7tNxFMMuIKGc
 Jje2ckBTxmtmuwuwLo41pdt/AKFmxWzSr4AuVegg4Q=
X-Received: by 2002:a05:600c:620f:b0:490:5074:651e with SMTP id
 5b1f17b1804b1-490c2612cb7mr361383875e9.25.1781107978826; 
 Wed, 10 Jun 2026 09:12:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/71] target/arm: Implement BFCVTN for SVE
Date: Wed, 10 Jun 2026 17:11:31 +0100
Message-ID: <20260610161202.2235298-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 92 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 +
 target/arm/tcg/sve.decode        |  2 +
 target/arm/tcg/translate-sve.c   |  3 ++
 4 files changed, 99 insertions(+)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index e2330177ec..ffeaf02f97 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -72,6 +72,17 @@ static FP8Context fp8_src_start(CPUARMState *env, uint32_t desc, int scale_mask)
     return fp8_start(env, desc, f8fmt, scale);
 }
 
+static FP8Context fp8_dst_start(CPUARMState *env, uint32_t desc, bool is_f16)
+{
+    uint64_t fpmr = env->vfp.fpmr;
+    FPMRType f8fmt = FIELD_EX64(fpmr, FPMR, F8D);
+    int scale = (is_f16
+                 ? FIELD_SEX64(fpmr, FPMR, NSCALE_F16)
+                 : FIELD_SEX64(fpmr, FPMR, NSCALE));
+
+    return fp8_start(env, desc, f8fmt, scale);
+}
+
 /*
  * Invalid input format: we could take one of the usual set of
  * CONSTRAINED UNPREDICTABLE options for use of a reserved value,
@@ -111,6 +122,64 @@ static float16 fcvt_fp8_to_f16(uint8_t x, fp8_input_fn *f8fmt,
     return float16_round_pack_canonical(&p, s);
 }
 
+/*
+ * Invalid output format: we could take one of the usual set of
+ * CONSTRAINED UNPREDICTABLE options for use of a reserved value,
+ * but choose to take the additional option provided by the FPMR
+ * register specification, of setting the result to 0xff and
+ * signaling Invalid Operation.
+ */
+static uint8_t fcvt_fp8_invalid_output(FloatParts64 *p, int scale,
+                                       bool saturate, float_status *s)
+{
+    float_raise(float_flag_invalid, s);
+    return 0xff;
+}
+
+static uint8_t fcvt_fp8_e4m3_output(FloatParts64 *p, int scale,
+                                    bool saturate, float_status *s)
+{
+    *p = parts64_scalbn(p, scale, s);
+    /*
+     * Saturating Inf -> Max handled in uncanon_e4m3_overflow
+     * because there is no infinity encoding.
+     */
+    return float8_e4m3_round_pack_canonical(p, s, saturate);
+}
+
+static uint8_t fcvt_fp8_e5m2_output(FloatParts64 *p, int scale,
+                                    bool saturate, float_status *s)
+{
+    /*
+     * Because e5m2 has an infinity encoding, we need to handle
+     * saturation conversion of Inf -> Max manually.
+     */
+    if (unlikely(p->cls == float_class_inf)) {
+        if (saturate) {
+            /* maximum or minimum normal value for E5M2 */
+            return 0x7b | (p->sign << 7);
+        }
+    } else {
+        *p = parts64_scalbn(p, scale, s);
+    }
+    return float8_e5m2_round_pack_canonical(p, s, saturate);
+}
+
+typedef uint8_t fcvt_fp8_output_fn(FloatParts64 *, int, bool, float_status *);
+
+static fcvt_fp8_output_fn * const fcvt_fp8_output_fmt[8] = {
+    [0 ... 7] = fcvt_fp8_invalid_output,
+    [OFP8_E5M2] = fcvt_fp8_e5m2_output,
+    [OFP8_E4M3] = fcvt_fp8_e4m3_output,
+};
+
+static uint8_t fcvt_b16_to_fp8(bfloat16 x, fcvt_fp8_output_fn *f8fmt,
+                               int scale, bool saturate, float_status *s)
+{
+    FloatParts64 p = bfloat16_unpack_canonical(x, s);
+    return f8fmt(&p, scale, saturate, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -277,3 +346,26 @@ void HELPER(sme2_fcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(sve2_bfcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    for (size_t i = 0; i < nelem; ++i) {
+        bfloat16 e0 = n0[H2(i)];
+        bfloat16 e1 = n1[H2(i)];
+        d[H1(2 * i + 0)] = fcvt_b16_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(2 * i + 1)] = fcvt_b16_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c47e79637e..6b2875a451 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4100,6 +4100,9 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
 TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
 
+TRANS_FEAT_STREAMING_IF(BFCVTN, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_bfcvtn_bh, false, false)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
-- 
2.43.0


