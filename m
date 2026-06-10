Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B74CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY2-0000mA-Sh; Wed, 10 Jun 2026 12:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXy-0000FB-Em
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXw-0005cI-38
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso32600565e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107970; x=1781712770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5MAq/+zOPquUvnjQyptIkEBsY5qNKxyao34ulQ4Vi+M=;
 b=Fdzh/Vv1yy1Q6lp0q9ass+TsaTsrrPwg9Fo5tUaTVn4/J8hE4m4B6I27idL0jqXDwz
 MBm0VQ3s5wAG5PPV+PgjT5/4KYyWImlMdc1CMew+5i6v3q6Yl4ybC/hshQ7wd7KnFeuH
 8IxOBGDjRgljltkwZ9Jr9MH/48X4jNpEjqJP0oMcyPyLhZK1cKo4tF4vqbKBG7ObSF6e
 GYxCz7AKY8x1CenHowlhvMpJO45ygI9Rmb1F6MVD8mROvk1s/6DF3K5J8F6gMghAU8jm
 hM5T2vaEMUuptdEFmFCHcnOJ1cRPrV8jVT7fz+ddc0t9Iy9zcQZxU/dQRq8q38afZeRM
 1qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107970; x=1781712770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5MAq/+zOPquUvnjQyptIkEBsY5qNKxyao34ulQ4Vi+M=;
 b=hfqXbvOGBcoW2W1aDEpmGuVoclFb3qW8VoqA6q1DJ6Vlm6E+9IgvMpd6Ahy9xkj7dK
 i8K/7b4k9zFQ0hLMRne3QsleIFHciFgQ0Ud8iQQSfhkjSI0tGJQqrTxa5gckLtAw1w2P
 6B3nmYhTGJYPxkCyt93yEiwaB7avsSmdVup0Dqoq585rCxAfYkY6pS0Z48gFBZEySu4f
 RgU9SiOjZDgXK4Da+LZUXuyCltG6jsv0yBqKFz9C+3Qwskgi2LjhI0gft4UEZEPFFKjI
 o9ZKchW1lShiZqWVQ9ajQ0I2LxhNh+BL++I11qB9GJAFQNX8bmKQ0wUyqRntR9BAXR4x
 zQ7g==
X-Gm-Message-State: AOJu0Yxoo8EUv0PxT13taitAECvTvGygjIHkMdKguBZ4F/cMBA9L+w3d
 JVcsUQPcLsytNY2vMS2UlTHpj4CURUa/N49XqHsGL/e0nHHfZFYFH003j4KR9v/99soluvoX2Yo
 swmAB
X-Gm-Gg: Acq92OHUAveqjFQNl3T/e+/W7HFWNzOOEjKPeJusuvGw/mWsX6Sj5YC4EMsR2RiblBp
 27YXgZIzdUVa7otxqyTx30FVvgQFoZn0cBQ8l+vJIjsWw1HDtqzoGwEEz+kzKqkmJmkCzw/pO1D
 /+yjKMKtkQKk7A3/rvaDyPkSCneoGLiGnRoqlQqnNjcWNKYY2AFsC+5M/wmtt51FJqAtAlOVAuC
 YtSzJz3Qa7culCsJOn2PTyMDHEOTzeFDw61clp2C2yNsX9kt3WkVwnZ1WznM/oGoRFWc+j4a5ap
 XARXJ1fFeYgSaqbIw6mhtbvC0Yzz1RKAhUTSDvOlDEuY1w9nq4oqo2LiwqMqCWFuJbb8GWkIIR3
 Gy15dx4jdrmwlcJdnt9CzgRQW28oc5UQHdxBnLUFVlHQG9oUsKH003lDmu2DLH98IK9AhlhLGVu
 +yfNr2dsitqnn/WjCbqiIg2dNlAEA+dPyQoNnV/U96/S8O1zR0Z73RKBy8TqONk1zsAJf420ClS
 W0Elr2ZBYIlTDM0AkzkzXWEbHBAA2crGyTMeyjlkak=
X-Received: by 2002:a05:600c:468c:b0:490:469c:556b with SMTP id
 5b1f17b1804b1-490c257c3c8mr429905225e9.12.1781107970327; 
 Wed, 10 Jun 2026 09:12:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/71] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT,
 BF2CVTLT for SVE
Date: Wed, 10 Jun 2026 17:11:25 +0100
Message-ID: <20260610161202.2235298-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20260609192110.752384-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  6 ++++++
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/sve.decode        |  6 ++++++
 target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
 5 files changed, 52 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 13453bd8f4..e285f57d25 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1668,6 +1668,12 @@ isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool
+isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index bb3e8dae5f..c62fb2ffd6 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -122,3 +122,19 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_cvt_finish(env, &ctx);
     clear_tail(vd, 16, simd_maxsz(desc));
 }
+
+void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_b16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 0caaf63749..18ff483bb0 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -4,3 +4,4 @@
  */
 
 DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 078a085a79..e7984fa8e0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -108,6 +108,7 @@
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
+@rd_rn_e0       ........ .. ...... ...... rn:5 rd:5             &rr_esz esz=0
 @rd_rnx2        ........ ... ..... ...... ..... rd:5            &rr_esz rn=%rn_ax2
 
 # Two operand with governing predicate, flags setting
@@ -1090,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
+BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
+BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
+BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
+
 ### SVE FP Compare with Zero Group
 
 FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 997d6b0451..718a21de70 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
@@ -4068,6 +4069,28 @@ TRANS_FEAT(FRSQRTE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
            s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
            frsqrte_rpres_fns[a->esz] : frsqrte_fns[a->esz], a, 0)
 
+static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2, bool isodd)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           tcg_env, vsz, vsz,
+                           issrc2 | (isodd << 1) | (FPST_A64 << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT_STREAMING_IF(BF1CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_bfcvt, false, false)
+TRANS_FEAT_STREAMING_IF(BF2CVT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_bfcvt, true, false)
+TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_bfcvt, false, true)
+TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
-- 
2.43.0


