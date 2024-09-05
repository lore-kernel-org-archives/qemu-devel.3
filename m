Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774DACD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC75-0001X6-9n; Thu, 05 Sep 2024 09:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6v-00010m-R8
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001jc-7M
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42c828c8863so6187945e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541269; x=1726146069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kA1Nhy36wEyQLROB85TcAoe1vw16tXcqprGuuXecm48=;
 b=pa84iWPGmV5efqSHBf+ePBpk31g4dKhiY36IUaIDKPzRU8wVhj4d6IzEi7FXwAsDRJ
 QBGf6kbvUJjpY5nC+ldSDy4djlllF0ZdubVzFtntRKKs0D2FVBd/fwZdgK3RuQTVXvyb
 4o8NjOnWnf66Z1iMqxadlcX7SLiUmh1ZdNE7xvRp8YTpUk6vkgkjyp5vqXCOn2A8zRu5
 iYcsY7yu1gjbrSZ69zqOYNwmdsWLE27brDp6hoVf8H3EwXWp21lhdwSEKydx4WSWcjDq
 5j1rfHoklXyYw6BChQz7seRXqhXT8gevM9JLLGTadSCjCri/eh/0YyrNko/lgnkaDjIG
 M2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541269; x=1726146069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kA1Nhy36wEyQLROB85TcAoe1vw16tXcqprGuuXecm48=;
 b=Bt6RUDFI86hiPeJnLYMbR1M4cKZxPgwJG6jwzyVt6Z+7qlLV8Vva07sAB8aj6tRYN4
 pPwIDofu1Xpefn9x0xPmoG/GICH1bWk4OaEcYhMUYTSzwEgrJP9/Fm0pdyrO4yFMDZGG
 BTZcnWp7hnCtAb0emayqPTNUPMurekPg5JCeD10uvMdeBhmOelHfCJlKdPNdejh6WAOl
 bYoq0Mh1M0OrehxN0UOMHoo6TZ/Un7GYdxUBzuDnUUN8ldWsaBGpiEnm14UEKX+xdh+0
 ky92q66OjulZwX/3/aHElJi7+z0A+F4fU0NEqXICl7H3+KMNXbECRoix03JH+b8JrlJN
 F1tg==
X-Gm-Message-State: AOJu0YyBPS3tJX9SskGBMECm+KcNMTX5lOqB65T1+6XSe2co08R8+3hp
 GIUULAmHCj9+klTDtDUIuqioZQJ+J/xqUmooRnUS0BorZ5YnSjQWR8qGWNZVdtIr/laEd5afKqc
 g
X-Google-Smtp-Source: AGHT+IEFmt8lKgpxD1PoHBoKkIYwnbp00O791/rdgwkXKeqFkGNdDBLIVQY+lOagNsyWS7kAi4kuUA==
X-Received: by 2002:a05:600c:4652:b0:42c:9e39:d066 with SMTP id
 5b1f17b1804b1-42c9e39d0f8mr1212575e9.3.1725541268541; 
 Thu, 05 Sep 2024 06:01:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/25] target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()
Date: Thu,  5 Sep 2024 14:00:42 +0100
Message-Id: <20240905130100.298768-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implement the FPCR.EBF=1 semantics for bfdotadd() operations:
 * is_ebf() sets up fpst and fpst_odd
 * bfdotadd_ebf() implements the fused paired-multiply-and-add
   operation that we need

The paired-multiply-and-add is similar to f16_dotadd() and
we use the same trick here as in that function, but the inputs
here are bfloat16 rather than float16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 57 +++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b0de74b55f1..22ddb968817 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2792,7 +2792,20 @@ DO_MMLA_B(gvec_usmmla_b, do_usmmla_b)
 
 bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
 {
-    /* FPCR is ignored for BFDOT and BFMMLA. */
+    /*
+     * For BFDOT, BFMMLA, etc, the behaviour depends on FPCR.EBF.
+     * For EBF = 0, we ignore the FPCR bits which determine rounding
+     * mode and denormal-flushing, and we do unfused multiplies and
+     * additions with intermediate rounding of all products and sums.
+     * For EBF = 1, we honour FPCR rounding mode and denormal-flushing bits,
+     * and we perform a fused two-way sum-of-products without intermediate
+     * rounding of the products.
+     * In either case, we don't set fp exception flags.
+     *
+     * EBF is AArch64 only, so even if it's set in the FPCR it has
+     * no effect on AArch32 instructions.
+     */
+    bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
     *statusp = (float_status){
         .tininess_before_rounding = float_tininess_before_rounding,
         .float_rounding_mode = float_round_to_odd_inf,
@@ -2801,7 +2814,18 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
         .default_nan_mode = true,
     };
 
-    return false;
+    if (ebf) {
+        float_status *fpst = &env->vfp.fp_status;
+        set_flush_to_zero(get_flush_to_zero(fpst), statusp);
+        set_flush_inputs_to_zero(get_flush_inputs_to_zero(fpst), statusp);
+        set_float_rounding_mode(get_float_rounding_mode(fpst), statusp);
+
+        /* EBF=1 needs to do a step with round-to-odd semantics */
+        *oddstatusp = *statusp;
+        set_float_rounding_mode(float_round_to_odd, oddstatusp);
+    }
+
+    return ebf;
 }
 
 float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
@@ -2823,7 +2847,34 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
-    g_assert_not_reached();
+    /*
+     * Compare f16_dotadd() in sme_helper.c, but here we have
+     * bfloat16 inputs. In particular that means that we do not
+     * want the FPCR.FZ16 flush semantics, so we use the normal
+     * float_status for the input handling here.
+     */
+    float64 e1r = float32_to_float64(e1 << 16, fpst);
+    float64 e1c = float32_to_float64(e1 & 0xffff0000u, fpst);
+    float64 e2r = float32_to_float64(e2 << 16, fpst);
+    float64 e2c = float32_to_float64(e2 & 0xffff0000u, fpst);
+    float64 t64;
+    float32 t32;
+
+    /*
+     * The ARM pseudocode function FPDot performs both multiplies
+     * and the add with a single rounding operation.  Emulate this
+     * by performing the first multiply in round-to-odd, then doing
+     * the second multiply as fused multiply-add, and rounding to
+     * float32 all in one step.
+     */
+    t64 = float64_mul(e1r, e2r, fpst_odd);
+    t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
+
+    /* This conversion is exact, because we've already rounded. */
+    t32 = float64_to_float32(t64, fpst);
+
+    /* The final accumulation step is not fused. */
+    return float32_add(sum, t32, fpst);
 }
 
 void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
-- 
2.34.1


