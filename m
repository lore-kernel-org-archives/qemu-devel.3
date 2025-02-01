Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ADBC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYU-0006sS-OK; Sat, 01 Feb 2025 11:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYS-0006og-LB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYQ-0001G8-LS
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:12 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso20786285e9.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428069; x=1739032869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t5Lc0sWgo+3G84LPfignpf76iyeDNPt3aNSusiwbo3I=;
 b=Zs/DIQVpxZgsCw0Y0U+pJHSuO2z1SCYlam/DMQrJY1Hx91mbEjX8RSkYs+OoGQHcmy
 zyoMc5tYSZfcJszFyjFXf/vP8k6Fw+u0JZETNvco8LvvK+qALMcwQ7/xefLDp2eKRDw9
 CcuJuhHeO9c+gDH6yrHGBVzG6UAN3fqOQsu6C4hs34QkpK0KT647iQGU9jZEP5YhqA7c
 Wi00itzYKww7XVvMT1knM3YzaDvOLKT+hN34hVReYcOT+GIVMfBRmkBKKZuNFBetYGOv
 6dE9NvNuKm3x0/zPHBSSuJ0pcyUtq7jQWvgWKWka+dxKkwiUQgxHBLpTykQoMzRvXQTE
 K1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428069; x=1739032869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5Lc0sWgo+3G84LPfignpf76iyeDNPt3aNSusiwbo3I=;
 b=a9XCfyQ3rhHzMVl3cGDht0fVWG136tHyoIDR62VloF91DV0LbnYgJMxEOhY6rrsU9/
 MUJeytazc3/LZuYBDxz1Hn10AsHonh6uBvMPnx+bUi0yn5MphjyMcVTZMkwjCzaumVQd
 QzWb9VrbatdclORk24QlgM/Zp0vK+f2swFOEeyEkynUrR7ZESpTEkXGMdjVU3jfV1kRZ
 bTU5MGWNGsTtzNCX5NJ+WIoiJpLeQpUJoIMI1saAfIv3EzKOSE2I0NX2QIRss3MHSx0c
 /qOHlgl8Mqd2sB8Ob0N7P8ANeAa3fgfhjvzrHIvZxQ0H/mBpPQAHhsPxK+D0ZyjYtD3z
 KHpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHjuIgpbrOHLDg0zK3y9dXOJcgHwunzjYCizjSklvtgmYo4ooGpOA1bD+0fLiD7xKHMC+a/wykhB8E@nongnu.org
X-Gm-Message-State: AOJu0YziF8BtHjBHjArmpjMTrNvyEFdo1ezo5Y7jExVjHa8f5vuLuYh5
 k/fy+K5nD1O1Cmmm7a38LdK3S7rIO7rswolU4jtqTE7GlhETs2maCnPDRr1h5nbNOkBk9pgXbBN
 x
X-Gm-Gg: ASbGncvGXRSJW4+P9Wtqn5WN83mza7nkbmCQx0kmx5Xe8Vka+HZFWgGhvxpnkP1NyPQ
 1qVuShGD4/f0W4QKy4JKx2IsuDSUSSJaQiLHP6pS/vkiYA4tbsUGl5CHRjzsDohVNx/kgVPRrBY
 LNkd3x26gPeSYWUwJ3y5hVhd7MKtu+kylH9ovm2nSIBvgM9CUpxqpy4l1yyh6kClGUinrFKEl9P
 yy2PhPx6Uks/Vgot6WKIx8s43ua2tvWMtU9qo3X3HtF5UG6lV0wgKIIElWVT96WWnR3ag5wvqG1
 DK5pU/kH7Rzy6HvjM11M
X-Google-Smtp-Source: AGHT+IEm0y4aGUXpbV2j0PquwXnRlh4MRyWp0TYRYtdU3FlsHA8IR5KGoM7a/o4xLMnZ46VM2YFY6w==
X-Received: by 2002:a05:600c:5488:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-438dc4223aemr116341325e9.27.1738428069137; 
 Sat, 01 Feb 2025 08:41:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 42/69] target/arm: Handle FPCR.AH in negation in FMLS
 (vector)
Date: Sat,  1 Feb 2025 16:39:45 +0000
Message-Id: <20250201164012.1660228-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics
in FMLS (vector), by implementing a new set of helpers for
the AH=1 case.

The float_muladd_negate_product flag produces the same result
as negating either of the multiplication operands, assuming
neither of the operands are NaNs.  But since FEAT_AFP does not
negate NaNs, this behaviour is exactly what we need.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: squashed in RTH's patch to use the muladd flag
---
 target/arm/helper.h            |  4 ++++
 target/arm/tcg/translate-a64.c |  7 ++++++-
 target/arm/tcg/vec_helper.c    | 22 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index be47edff896..f0a783b7088 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -782,6 +782,10 @@ DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2509a29528e..c209ac84228 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5871,7 +5871,12 @@ static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
     gen_helper_gvec_vfms_s,
     gen_helper_gvec_vfms_d,
 };
-TRANS(FMLS_v, do_fp3_vector, a, 0, f_vector_fmls)
+static gen_helper_gvec_3_ptr * const f_vector_fmls_ah[3] = {
+    gen_helper_gvec_ah_vfms_h,
+    gen_helper_gvec_ah_vfms_s,
+    gen_helper_gvec_ah_vfms_d,
+};
+TRANS(FMLS_v, do_fp3_vector_2fn, a, 0, f_vector_fmls, f_vector_fmls_ah)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmeq[3] = {
     gen_helper_gvec_fceq_h,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ae3cb50fa24..fc3e6587b81 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1558,6 +1558,24 @@ static float64 float64_mulsub_f(float64 dest, float64 op1, float64 op2,
     return float64_muladd(float64_chs(op1), op2, dest, 0, stat);
 }
 
+static float16 float16_ah_mulsub_f(float16 dest, float16 op1, float16 op2,
+                                 float_status *stat)
+{
+    return float16_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
+static float32 float32_ah_mulsub_f(float32 dest, float32 op1, float32 op2,
+                                 float_status *stat)
+{
+    return float32_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
+static float64 float64_ah_mulsub_f(float64 dest, float64 op1, float64 op2,
+                                 float_status *stat)
+{
+    return float64_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
 #define DO_MULADD(NAME, FUNC, TYPE)                                        \
 void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
                   float_status *stat, uint32_t desc)                       \
@@ -1584,6 +1602,10 @@ DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
 DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
 DO_MULADD(gvec_vfms_d, float64_mulsub_f, float64)
 
+DO_MULADD(gvec_ah_vfms_h, float16_ah_mulsub_f, float16)
+DO_MULADD(gvec_ah_vfms_s, float32_ah_mulsub_f, float32)
+DO_MULADD(gvec_ah_vfms_d, float64_ah_mulsub_f, float64)
+
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
  */
-- 
2.34.1


