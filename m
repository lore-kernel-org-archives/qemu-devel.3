Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D090CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcI4-0006gu-3I; Tue, 02 Jun 2026 23:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI1-0006eM-N6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHz-0003cc-KA
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:09 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8422871b42dso2080807b3a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457346; x=1781062146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYt4Xvo7JmWJ5kLRhU7z6WrSENBPotJcbXqumf2zKiI=;
 b=NKpfufsJCXfpx5lTlHx1eyOXUw1yYF5xw4T2W5moKq2C6ow8tZhY4j5NogJPZBoNL2
 lGQF5ryvjRb8eZYSNrUms2m36Nhw74WYXB28lBZdgmnmw6ywMh+kemJn83G1kISnUxkK
 2zgQh8OK/8z3VHI0sfC5Pjz8D3SLiEqpOJ8bkSFyVWv20U308XdopMlz+NzmZ2opXNkH
 aMiUvsYzyN0g2NvTdzyLPtuFd549cPgwDy4z+tyFiCjlO2svY/8K7tgSVK/BXw5lhvrs
 qg1kYsfMunuLtDVEW6bH2mMk9Vq84w0EXYvXf3GkHhNYUFiwk+7pm1Ev4ENREAoLGXOr
 iTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457346; x=1781062146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yYt4Xvo7JmWJ5kLRhU7z6WrSENBPotJcbXqumf2zKiI=;
 b=HTOcT9hIBDgCrz7SPmCyJt0UcA1Kdx2a6lEsNebCd1XOM3wMcv9pp/PWRWpz9Lix9I
 XCIW08FiFr8LHiagcBbBn/dmXfxKgZMd7iXv6EQNI1YF7JVDavsveNJldmW5rpUgd5b7
 717Gp1Y4pdm+CwWCtuqhtiiFXDn1Ahk1UhOmTJERATfl4TwHuedxXH52c49HuSh0erCU
 SWQDWGn8zTziTob8PoPVpDCcdVeG20YRL/HDfixlE2lWD0ndgpbq3yg02v1c2pi+nDyq
 YnarRVTfZNZEN9y//xC4JgjiiFB3KKzq8qnZ2cSrK1FJ0NG7p1wYa//R5RVWL888eIEA
 xBNQ==
X-Gm-Message-State: AOJu0Yz78radKPGb60dAn9fDtPmvyxC5w+pkX6zFBj1Xqi46rZC0OQuy
 w8E3clsY97d9R9tJMO/2oiJqhZgSKT0z2rWs3mxlrchytTf9ly1HuI5CD0Y4er/aAIbRVbSFMIm
 LpmmF3cw=
X-Gm-Gg: Acq92OG5iA22+AkKLyeyXtPI5Q0e+RtnBZzvKlCgynEKQZXkvOPWdK5sbmKMlTIZTzP
 LDKNQz98BFs8r2vbqCzDJ9sv0EnJKrdHoUZGU2JhqbGZb9o2aMZB63CJ6hsgvwrM1TB0VmU8UuV
 7+VuHQM+NsO832wA+L3fc19CoL5ufB7IlUca1tw1wfPhAZrrVkUUKIhDvM6pJZlxK+JZ0b9vtFU
 KXvPuRFI1KaSFpe+o64pnmLpIhkMRQJETtHoQrXOaQAwAXI2fPnm2cRssSq+lmA3VwYQcwNjbLO
 FTEumJArcWbEAxmPw2t9zkybmjCyKVqxBFiL29clRjufMOlpZ/JraJhmEuMA92pZ9/mm9r2Yb/F
 4Jy8OdZUhBuy41r0pCXjB39XJraFnygl3bhPGnA0mk6iQ2q4oDJNPUKXBsOOorzACt6f/EUX/1J
 MUSnmLM1dQ/p5U6KxrH4E7H2AP8zYLRlg+lAMmCD8=
X-Received: by 2002:a05:6a00:218e:b0:842:6cf3:5550 with SMTP id
 d2e1a72fcca58-84284f2ab99mr1485687b3a.47.1780457346043; 
 Tue, 02 Jun 2026 20:29:06 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 14/45] target/arm: Implement BFCVTN for SVE
Date: Tue,  2 Jun 2026 20:28:23 -0700
Message-ID: <20260603032855.106930-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 target/arm/tcg/fp8_helper.c      | 92 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  3 ++
 target/arm/tcg/sve.decode        |  2 +
 4 files changed, 99 insertions(+)

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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c47e79637e..eccb5b191c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4100,6 +4100,9 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
 TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
 
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


