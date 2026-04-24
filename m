Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E831FB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Ch-0007in-JA; Fri, 24 Apr 2026 00:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CZ-0007DK-Ko
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:40 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CY-0002sx-1f
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:39 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4094b31a037so4589318fac.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005094; x=1777609894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdqYSYvyNpmf3YSAjo2AYikrIIkpiycHh+h6wUIhrr0=;
 b=eL4jT3KEGajODIKSJcQjVIVKg7Wa5HOBL4tHyAu9+wO3djK2V69hedkP9Ij2fiES+w
 p1c58FdCawU2RO3daNvEo751kaMVNzvDM0K354j2+eoR1+yMZTH7WFk3w+quPDZ/rMpM
 mJNqE1xtlKYBGPDKX1oureyNZEYXblfzZCfLyzf9Vi9MXn9U7ZnoVA7UrilK6K6ziZPo
 PH8TtDBUVzYbxwx0GuVLWbLgLC5E0th9qbw0pUlCzb5bwkX8OPgwYfLyqJHmHYTz3wuN
 z5DunfrO2A6mNso2lW1s0WWNfcopvqV9xipJIhuXFQyRJE/EPC/CXWS0XEZ6p/3S0Q8h
 C3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005094; x=1777609894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mdqYSYvyNpmf3YSAjo2AYikrIIkpiycHh+h6wUIhrr0=;
 b=Jd2J72Uve2bJcBTe4RWfbjyqcdR4BgP75NtAMyoj5gp08lVFZTkjcoHVsKbOlUvuJE
 tHsYXe1lN+PUiox/oQ7XllMzgdxgIvwzek+3iayJj+HDb7Y18ogQQUSXl7nchcbn3Pz9
 Iq/CCu5qd/9posuzdiWhl30HLosQ7cqJm4EwWWQlNrgEhzByG65v0oipHl4YcbTrBeQk
 48dyWYkCA4MgP50VcLT5Fm/X8XRIeGgqe6yW78xDx2N6o6S19Oe5a+ZuTWM2YgUzTbQh
 VRsoXz3MIbtQJ2feO1Oi4E5W0XSPpSFThTh6wOwebvDfnlG+XF+9/2NklvnW5v4iI6lP
 xGLQ==
X-Gm-Message-State: AOJu0YylT+ZQmAdUlC8P/5lehyHNPi0ppb3QuxKAXYk/7+UQl3yhyBKi
 Hu8WV734SSUrXL/Zof8dRXxymz5skU0K+Zbezoz9PBK367f3xigE9Zlqs7XYrMb+JRXuFXaWvI4
 Fc4joD8M=
X-Gm-Gg: AeBDievQa/dBZEo9vtGPyzStPKmfJRs7mn73OsCLlgmH9d06ntmKA9tvbhnPF53P/U/
 7hmZ3D57iUJrfE2uLzchFRGH7uzay9bbv6AQ79lhrSThtnXifMybEN6BLEpXXaSOKRKIIQGwFMo
 2sY5Ep/DZYzHwijXSiaU5asBsuWjdMWqQ0k3n92QVrWfSsbkPxd7cAKfGct2wnCXmyGVky47Cml
 NkQPY7VtwS1hx7FxtaWJjoK4UGJr4V9dmaLYF0gkF4FP+ZiMA/50brxP9sgdF8F9Y64+JYXnUN/
 rmy+eI2Mem/U2uQGAh5ufG4HRWqk8cz9xas1a5aGo21W5BLqHSfitUU5KRba7LqXZ62RcsQmvbY
 ZKEQ0f5jCigJ/Y98/77C+j02O7pqJ6E7IW7TSQb5NU4f4OLsecoV/VVPyPE77PAcihuyNFpEhDi
 uHccjsKea2BfJlO8GsUS2/KMrnph4lhbRvoVwwgUPucxX4oykEChuPxDRwqNyEAA==
X-Received: by 2002:a05:6870:c98c:b0:41c:573:aa5f with SMTP id
 586e51a60fabf-42aded68861mr18565256fac.31.1777005094408; 
 Thu, 23 Apr 2026 21:31:34 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 17/40] target/arm: Implement FSCALE for AdvSIMD
Date: Fri, 24 Apr 2026 14:29:51 +1000
Message-ID: <20260424043014.46305-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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
 target/arm/tcg/helper-a64-defs.h |  4 ++++
 target/arm/tcg/vec_internal.h    |  4 ++++
 target/arm/tcg/translate-a64.c   |  7 +++++++
 target/arm/tcg/vec_helper64.c    | 16 ++++++++++++++++
 target/arm/tcg/a64.decode        |  3 +++
 5 files changed, 34 insertions(+)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index eb270cf58b..08ba8a98a1 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -152,6 +152,10 @@ DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fscale_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fscale_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fscale_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(exception_return, void, env, i64)
 #endif
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 5c3f51eed3..b647399b18 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -349,6 +349,10 @@ float32 float32_famin(float32, float32, float_status *);
 float64 float64_famax(float64, float64, float_status *);
 float64 float64_famin(float64, float64, float_status *);
 
+#define float16_fscale  float16_scalbn
+#define float32_fscale  float32_scalbn
+float64 float64_fscale(float64, int64_t, float_status *);
+
 /*
  * Decode helper functions for predicate as counter.
  */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d132e051ca..515c0fb2e0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6495,6 +6495,13 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[3] = {
 };
 TRANS_FEAT(FAMIN, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index b5ad67b5e0..5479d98daf 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -175,3 +175,19 @@ DO_3OP(gvec_famax_s, float32_famax, float32)
 DO_3OP(gvec_famin_s, float32_famin, float32)
 DO_3OP(gvec_famax_d, float64_famax, float64)
 DO_3OP(gvec_famin_d, float64_famin, float64)
+
+float64 float64_fscale(float64 n, int64_t m, float_status *s)
+{
+    /*
+     * Given the 'int' parameter of float64_scalbn, we have to saturate
+     * the 'int64_t' parameter of the operation to some value.  Since
+     * float64 has an 11-bit exponent, saturating to 12 bits is sufficient
+     * to ensure that DBL_TRUE_MIN can be made to overflow.
+     */
+    int sat_m = MIN(MAX(m, -0xfff), 0xfff);
+    return float64_scalbn(n, sat_m, s);
+}
+
+DO_3OP(gvec_fscale_h, float16_fscale, int16_t)
+DO_3OP(gvec_fscale_s, float32_fscale, int32_t)
+DO_3OP(gvec_fscale_d, float64_fscale, int64_t)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 666a293540..02c7264cb9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1198,6 +1198,9 @@ FAMAX           0.00 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 FAMIN           0.10 1110 110 ..... 00011 1 ..... ..... @qrrr_h
 FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 
+FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
+FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


