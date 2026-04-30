Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB958CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAS-0007hF-EA; Wed, 29 Apr 2026 20:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAL-0007NB-GY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:05 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAJ-0006YN-Gd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f431c0ab6so189668b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508522; x=1778113322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qYbU7+TPTFqGiBQwxxMXvd6dGbNUHDSbf7XY1Mn5Rg=;
 b=Z/YhzmDPMlJpWRvx2e9RPmDIY0ss9CjSC/PFSI/RPlvw78BUm2mE+q6A9727aCXFRU
 NXWojAvbp2OFWJtjAp5/7Emj4Klf4bP6MjW+8tctXKkNPAWtFftVc3lkcHK7TXUcCpU/
 MExAtGT3GrwU9uYI5mzLZQ4VpnR63yIvHVObNU3lnPZgzJtZxLTfRLKsrZOTSkAd3n0i
 wJ91fMd96bOstUh3iSbEON9Arl3C+6W7dHo7TJUPM+cPEIq3AX6ycW2GYhXnX37WMHDj
 TF0GgxRgvd1+nIPdlrHj+JLGMMxwE740JUNdMXwslSjHARd5AAEq4xli9Gmh+pb60bw3
 xUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508522; x=1778113322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4qYbU7+TPTFqGiBQwxxMXvd6dGbNUHDSbf7XY1Mn5Rg=;
 b=Eb4/jiqGPB3ENKQcW5nUJm7I6FgXIcsFeA6jujKnjdhKBAmv1HZEyCdCi96h6HoAcT
 qHojEut0VDMwZqxfPzxfJpIe9YXSODLXEscaGVIUmKD/oXG2n+o4RZKnm/SkV409B6Wc
 cPkLB3MiELrK9TyUoH6X3pV1aiy5hLoWHp+9FkJRHG1acs0W85LKM52LnOzF338kJKmo
 LbGZz0vZJvSLNSntf/Od06scw0d/g8VBjXvbzFWPpake6zyIy6X4eawtXSvOQFGKTIoV
 tkf0egr72RQzSWLO9OrAchMxUgndEH7aO1CWtfVCPY2ANRLvVIgQgfYBWNBcPj9aKs/6
 6xZw==
X-Gm-Message-State: AOJu0YwjmGeccVU8kmeAc3Yz7+PmiLAABL/7FOsMpKj3PU1uGAzh4Qax
 fn3lad77GRDdIEUoyCDPaSSjcx1prpzxNPPxuQS0Ej1YDir/vr0CmgCwRoDsXjl6uU0EedTCS+g
 WbslnfMs=
X-Gm-Gg: AeBDievRQ06YkLwfJ0oTGf1DTXs5sRu3+DUUon5PIiTk0rjyQpSBUvPEd0nrqwnYCO8
 Y/IgxPv0Zza2+YXrSvY8EfmqRyfA8sKHu2EQtYZR0Jy7Ap/VU7RJUh8QSI/P04Moc77AgccjCPp
 JFuH2HhNEyUDA14jEqbC9h6d2dIVQ2XtCke4VGfV+Hq8tjElWIFNEqFk1Cqlw8i/j10KI9EU1m5
 Gjc+AKFUOxijC2SaOqeSafk+5i8jTe54XL/RbnmMAFTqlzc13QuUO8x9oGx+MAimkOj6jB/Rupd
 BCFooYan8PCIxFozTmFf/ds4pp3DFRPB3pJNpLdnJP3KBmmiVgHOazHOqU8AfbqchF5ruUqjq6e
 VYkYu6pfJn2/92rlhisl9wvj7HVBYuQ+DHATc9ZGgNKKw6VHO2UXoiDDyQi/e0xlnV5g4yheN2Q
 /ChGuN+YtVZ/xfvL421q1TCp7yhra36spgJZr1Jqv9
X-Received: by 2002:a05:6a00:2e0d:b0:82f:5c3f:94c6 with SMTP id
 d2e1a72fcca58-834fdcdeaafmr835948b3a.28.1777508521985; 
 Wed, 29 Apr 2026 17:22:01 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:22:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 32/47] target/arm: Implement FCVTNB, FCVTNT for SVE
Date: Thu, 30 Apr 2026 10:20:31 +1000
Message-ID: <20260430002046.59739-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/arm/tcg/fp8_helper.c      | 87 +++++++++++++++++++++++++++++++-
 target/arm/tcg/translate-sve.c   |  4 ++
 target/arm/tcg/sve.decode        |  2 +
 4 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index e67fb191c2..5863a6dbb8 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -19,3 +19,5 @@ DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 9c89964721..f92ffe68e3 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -626,7 +626,6 @@ void HELPER(sve2_fcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
 }
 
-
 void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
                              CPUARMState *env, uint32_t desc)
 {
@@ -668,3 +667,89 @@ void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
     fp8_finish(env, &ctx);
     clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
 }
+
+void HELPER(sve2_fcvtnb_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint16_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            d[H2(2 * i + 0)] =
+                fcvt_f32_to_fp8e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H2(2 * i + 1)] =
+                fcvt_f32_to_fp8e5m2(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            d[H2(2 * i + 0)] =
+                fcvt_f32_to_fp8e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H2(2 * i + 1)] =
+                fcvt_f32_to_fp8e4m3(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        /* -1 in each even field, 0 in each odd field. */
+        for (size_t i = 0; i < oprsz; i += 8) {
+            *(uint64_t *)(vd + i) = 0x00ff00ff00ff00ffull;
+        }
+        float_raise(float_flag_invalid, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
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
+            d[H1(4 * i + 1)] =
+                fcvt_f32_to_fp8e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                fcvt_f32_to_fp8e5m2(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            d[H1(4 * i + 1)] =
+                fcvt_f32_to_fp8e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                fcvt_f32_to_fp8e4m3(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        /* -1 in each odd field, even fields unchanged. */
+        for (size_t i = 0; i < oprsz; i += 8) {
+            *(uint64_t *)(vd + i) |= 0xff00ff00ff00ff00ull;
+        }
+        float_raise(float_flag_invalid, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c7fcf27183..13f7ab01af 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4103,6 +4103,10 @@ TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_bfcvtn_bh, false, false)
+TRANS_FEAT(FCVTNB, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnb_bs, false, false)
+TRANS_FEAT(FCVTNT, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnt_bs, false, false)
 
 /*
  *** SVE Floating Point Compare with Zero Group
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 806953bc35..7fce189b36 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1103,6 +1103,8 @@ BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
 FCVTN           01100101 00 001 010 001100 ....0 .....          @rd_rnx2 esz=1
 BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
+FCVTNB          01100101 00 001 010 001101 ....0 .....          @rd_rnx2 esz=1
+FCVTNT          01100101 00 001 010 001111 ....0 .....          @rd_rnx2 esz=1
 
 ### SVE FP Compare with Zero Group
 
-- 
2.43.0


