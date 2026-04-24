Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9576FFB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Dn-0003Su-4r; Fri, 24 Apr 2026 00:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Df-0003CB-Tf
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:47 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Dc-0003nQ-T7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:47 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-415e568a7ecso3155658fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005164; x=1777609964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHw9W0r73gnNntSyeFRZzouxm1QL1rIad4n1+k+yIsY=;
 b=mnbcmVQkFkRz7hucOsdg4Y6lvI64FWWtkVWOdIbn45hv6cb7EQla2uJRAmSF4uV1z5
 zHqxFVBXg1A6y5B2LzOraCLxjWejcA8HCrzM1Iae6/iMIMgKr+tvrl3hW3qB2Kc7ynSB
 iEXif/FqSyoePc+NBwLgKW9RR3ZrAheeHAaSzhzFUl4WCgrbwrX0dJ/gTrWFUbTxuA16
 jCoS/hwZWMBETznygsUlwr4Xl+PAHCyPy7yoQeykmojLqs+VV1rQL4cpb/0HRmqRaI94
 VKBL/RMn78H5ywYWKM0dSGa1V3V1/OKmyn/pZS8dP1trnXHUJFPOtVmXrm136DoPB0OC
 fqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005164; x=1777609964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JHw9W0r73gnNntSyeFRZzouxm1QL1rIad4n1+k+yIsY=;
 b=SmXUTjZb/3d4RDl/65qdP03Wc5Q2l8DqOCzp9jYf4eEDjinQsZdH2L5is9SL/2rgNf
 A2yfpcNYTKxpT3pMI8YOa/BFqrsTlXUyh7C00aPECrE2SzKQu+T0+4J6o/pc3CFsCHSM
 YiEDOOJLWNsU6joOcqIebdLD/OFOkZVzL27d5Xx9NLGYHzGUeDDKGD+L1HFImiQf8Zs2
 QzfDVm/JeiwfxYYQ1pKBJXP+RI5uL2kib+Q0swWtT/20XUpi7K5vqLHC3pBK/lMy3ITi
 CPu+qCAejB76ri7a5XyTMtVYrU2IUuIBMRnSi6sTTTFHMAF30viTmsBlaztya3z4RLg3
 tKVA==
X-Gm-Message-State: AOJu0YzKX1TZIUwv4geEERfIi1HPRarYB81RuVYw4VL85lcUWf/dE55a
 qwR1FpkHWd96u21Ipo7QWJPHal0KZ0S00sp6Fi5HFD/4x6XT/yy3oRj0dooQ424jP3M2jX89rMK
 uCtz1z9s=
X-Gm-Gg: AeBDietEVFcWCxSzvxE2gClQFAv0VCjCjwG7RQNdW1YgII4OWLG9+Ls5uB1Y4DRWia8
 b31UA4LZcTQPs9WVBjv2xMaawoJF+jXl6Ue74qPSsruhD3XspaI5O0jMK3z/7KCZ5ppkH64Jd3E
 zHGZSP9RcsEdEaJUhIp2T/k1KOy1Wib3WKSnAD07SjQO/M7+0TySlje4U3/cGdhTG2fds3ohQ6m
 zpFkTsTX1EJEqJB9kU18Sb5Mez5lrWkDvDx9RYZqayU9Y7sYzLr3iOb5Bvx5x2onA5bAXf3oUUK
 SaGYR5W3jenhWUjFMMV1mi92fajpXiJogSHxVmxwPgV9Xhi0d8SjksWXd9Nx1iO9GkQlnBf/K7F
 5F9RgAGP+mr/TYef62NutDWkkZ+NT9bgTt+k0WhGGyx56w+navE42U3KuYY+HsnixAEI3ftAYnl
 ++IxbXcjBBzCAwF8ARS0H1i9lIu0au/3F2+v0zEdn0L0fhdqb/EycR+zpy1UhrmQ==
X-Received: by 2002:a05:6870:5cce:b0:42c:dea:d370 with SMTP id
 586e51a60fabf-42c0dead818mr12277360fac.12.1777005163729; 
 Thu, 23 Apr 2026 21:32:43 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 36/40] target/arm: Implement FCVT,
 FCVTN (FP32 to FP8) for SME
Date: Fri, 24 Apr 2026 14:30:10 +1000
Message-ID: <20260424043014.46305-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
 target/arm/tcg/fp8_helper.c      | 95 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  3 +
 target/arm/tcg/sme.decode        |  3 +
 4 files changed, 103 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5863a6dbb8..36ae977431 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -21,3 +21,5 @@ DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index ebd448b466..099ca44c4a 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -645,3 +645,98 @@ void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    ARMVectorReg scratch[4];
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n = vn;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    size_t stride = sizeof(ARMVectorReg) / 4;
+
+    if (vectors_overlap(vd, 1, vn, 4)) {
+        n = memcpy(scratch, vn, sizeof(scratch));
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; i++) {
+            for (size_t j = 0; j < 4; j++) {
+                float32 e = n[H4(i) + stride * j];
+                d[H1(i + nelem * j)] =
+                    float32_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+            }
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; i++) {
+            for (size_t j = 0; j < 4; j++) {
+                float32 e = n[H4(i) + stride * j];
+                d[H1(i + nelem * j)] =
+                    float32_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+            }
+        }
+        break;
+    default:
+        float8_invalid_output(d, oprsz, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *n2 = vn + sizeof(ARMVectorReg) * 2;
+    uint32_t *n3 = vn + sizeof(ARMVectorReg) * 3;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            float32 e2 = n2[H2(i)];
+            float32 e3 = n3[H2(i)];
+            d[H1(4 * i + 0)] =
+                float32_to_float8_e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] =
+                float32_to_float8_e5m2(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 2)] =
+                float32_to_float8_e5m2(e2, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                float32_to_float8_e5m2(e3, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            float32 e2 = n2[H2(i)];
+            float32 e3 = n3[H2(i)];
+            d[H1(4 * i + 0)] =
+                float32_to_float8_e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] =
+                float32_to_float8_e4m3(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 2)] =
+                float32_to_float8_e4m3(e2, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                float32_to_float8_e4m3(e3, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        float8_invalid_output(d, oprsz, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b112f16cd7..c57c7c122e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1571,6 +1571,9 @@ static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
     return true;
 }
 
+TRANS_FEAT(FCVT_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_bs, 0)
+TRANS_FEAT(FCVTN_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtn_bs, 0)
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a02bcc0e22..2b9e41a75a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -865,6 +865,9 @@ BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
 FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
 
+FCVT_bs         11000001 001 10100 111000 ...00 .....       @zz_1x4
+FCVTN_bs        11000001 001 10100 111000 ...01 .....       @zz_1x4
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


