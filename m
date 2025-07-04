Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668B0C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFH-0003Ss-Qa; Fri, 04 Jul 2025 12:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEm-0001OB-UR
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEj-0006VT-UV
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:08 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so679118f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646364; x=1752251164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wkw6psIRHCXdgECrfk4QsKxF+wC3SOGd8/GLWs79+O8=;
 b=NQ5IqwMPDPrwtoFCnrBYlrVAkchUqc03s/FfHqRZtFp7VVHJsmGm9wzm14G5R49T4/
 2xNZwOJlY3sNvRvxq1LAEMgWcoLmZd9sYn2wT+flLNEkSQKFr8qk5JEF0nW47SvwWHhw
 oAYbHSKYZVwBsixDTcYUCYMAeDHYzcIA/WZovl/37tsRHbsQRxtCmkH0L3KqQp17TpLh
 BvMnUVawMfhdtnPZ9keuAMF2/4+VBjQy6OIG8wG63bd7e03UhLKRLjs9Ob1fZn0lJUBR
 qyg5QfMZO+qSZp0SHGgteQtVgP0K+Od5Acd1usF1E16Fhvy2JViMchrz/tOQfL5ezWTK
 wnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646364; x=1752251164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkw6psIRHCXdgECrfk4QsKxF+wC3SOGd8/GLWs79+O8=;
 b=ZHpXwrjg5iz90EAExkUaztDxa4EBGq3vNasyuLnOmTAsayb8MMsBcUDQriIR4r2w4z
 722M/kRuw3hEoxwvmmkZIvx4LOwenWx5rTgCXercehC72UoNq8wBn+ZN9/M45nAODteY
 3Ye4vZu1qiaNyQMnIF/eEYFlEV1znPGsprESFkOE9kTO0urh6FjqBCDbpfeWmrPqH8ug
 mjei5np3ngiq7wj9Am6ebja8gE1Z4X0vQFR+u9WSHVlAV896V4CBGxO1fXWjvcCPLBAt
 qsy0vb7HgFwK3tNvG8aphJHudBs59Y3KYqoYL/NrvUX14NaWZlthJ9eBFcNQDTo9O869
 zSKw==
X-Gm-Message-State: AOJu0YzPmSHspoB67dwTDc3W68A1bQmXDMTUIIa1sg4PiD9cgKds8y4o
 64yULQPq0WwO9mrTNmFtWAwg5VMwIQyy9HvubaR6qA0+vZmxWHCYFX9hr7DcyB1Vi995ebq1Wi9
 TPpD6
X-Gm-Gg: ASbGncsqWNCwFtAQAabYacGUokkM5RcwxoRQqenRoEFNOPudFdNhfpf2I9zAlN0YKfH
 mHFEAQJFij5+CnKGIRdrIMberWvN3JxUTN4EOgiiRyFPBhjJrT+fpbYOkzEaqUP+QVWeOLOE2RO
 Ko7xz68mxzQCpodkGLCjsEz0JBbIRLf2qn99yD5h8CPmwJNb/xR5RmTKNToArQctef07Fj5cMu7
 TMsDiMdyJz4y6TnxNEwbj8H7wbW/ZgeZC2bwvpyWQEQy2ZMwihsF3o43Rp0Lld9O4h++T3HN1PM
 kx9e+lBZVdrnXIm0/1d9xrC/9WufAc1JkQFjGR/tFd2sANayAqVR/EDtfoKX3JQz9rBB
X-Google-Smtp-Source: AGHT+IFRpY/25re3K+fIqq0i8/k2o/eXea+074Y1iTbthinMGwMtFaVeiEbdjKj7sEk1drhFxNEq/A==
X-Received: by 2002:a05:6000:2008:b0:3a6:d95c:5e8 with SMTP id
 ffacd0b85a97d-3b4964dca43mr3266627f8f.35.1751646364427; 
 Fri, 04 Jul 2025 09:26:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 065/119] target/arm: Implement SME2 FCVT (widening), FCVTL
Date: Fri,  4 Jul 2025 17:24:05 +0100
Message-ID: <20250704162501.249138-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-54-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/vec_internal.h  |  1 +
 target/arm/tcg/sme.decode      |  5 ++++
 target/arm/tcg/sme_helper.c    | 45 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    |  2 +-
 target/arm/tcg/translate-sme.c |  5 ++++
 6 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 97e70959e8a..be4621f2d9d 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -217,3 +217,5 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index c8199a3ef8e..bbf76f63b18 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -306,6 +306,7 @@ static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
 bfloat16 helper_sme2_ah_fmax_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 
+float32 sve_f16_to_f32(float16 f, float_status *fpst);
 float16 sve_f32_to_f16(float32 f, float_status *fpst);
 
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 831179c0eed..5100ebaebad 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -726,9 +726,14 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 &zz_n           zd zn n
 @zz_1x2         ........ ... ..... ...... ..... zd:5        \
                 &zz_n n=1 zn=%zn_ax2
+@zz_2x1         ........ ... ..... ...... zn:5  .....       \
+                &zz_n n=1 zd=%zd_ax2
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
 FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
+
+FCVT_w          11000001 101 00000 111000 ..... ....0       @zz_2x1
+FCVTL           11000001 101 00000 111000 ..... ....1       @zz_2x1
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index d97afdb69cf..c696246d15d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -29,6 +29,13 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
+
+static bool vectors_overlap(ARMVectorReg *x, unsigned nx,
+                            ARMVectorReg *y, unsigned ny)
+{
+    return !(x + nx <= y || y + ny <= x);
+}
+
 void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
@@ -1591,3 +1598,41 @@ void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d[H2(i * 2 + 1)] = d1;
     }
 }
+
+/* Expand and convert */
+void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float16 *s = vs;
+    float32 *d0 = vd;
+    float32 *d1 = vd + sizeof(ARMVectorReg);
+
+    if (vectors_overlap(vd, 1, vs, 2)) {
+        s = memcpy(&scratch, s, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d0[H4(i)] = sve_f16_to_f32(s[H2(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d1[H4(i)] = sve_f16_to_f32(s[H2(n + i)], fpst);
+    }
+}
+
+/* Deinterleave and convert. */
+void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float16 *s = vs;
+    float32 *d0 = vd;
+    float32 *d1 = vd + sizeof(ARMVectorReg);
+
+    for (i = 0; i < n; ++i) {
+        float32 v0 = sve_f16_to_f32(s[H2(i * 2 + 0)], fpst);
+        float32 v1 = sve_f16_to_f32(s[H2(i * 2 + 1)], fpst);
+        d0[H4(i)] = v0;
+        d1[H4(i)] = v1;
+    }
+}
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index b522ddaf7cb..4f12723afea 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4554,7 +4554,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                       \
  * FZ16.  When converting from fp16, this affects flushing input denormals;
  * when converting to fp16, this affects flushing output denormals.
  */
-static inline float32 sve_f16_to_f32(float16 f, float_status *fpst)
+float32 sve_f16_to_f32(float16 f, float_status *fpst)
 {
     bool save = get_flush_inputs_to_zero(fpst);
     float32 ret;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 10e5b77040e..d6167eafe17 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1360,3 +1360,8 @@ TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvt_n)
 TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvtn)
+
+TRANS_FEAT(FCVT_w, aa64_sme_f16f16, do_zz_fpst, a, 0,
+           FPST_A64_F16, gen_helper_sme2_fcvt_w)
+TRANS_FEAT(FCVTL, aa64_sme_f16f16, do_zz_fpst, a, 0,
+           FPST_A64_F16, gen_helper_sme2_fcvtl)
-- 
2.43.0


