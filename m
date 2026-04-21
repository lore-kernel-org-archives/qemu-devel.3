Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB959EA7184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3S9-0008U9-7t; Tue, 21 Apr 2026 01:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RU-00081J-1Q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RS-0006Ts-7T
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:35 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so33452285ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748472; x=1777353272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdqYSYvyNpmf3YSAjo2AYikrIIkpiycHh+h6wUIhrr0=;
 b=xG10FSVJR394xNSPsUYPpjrK3dgDe5M8aWv/PCBZVfWY2/sjqgqS19IlelHUfNRqjx
 JnjGqReHCEZNt79+27WKTLi5aTbp715TWl+Y1dz70QS7JtbiwBe6XqtHHaPreKkVHse5
 bzj730NO7J1uZJeh1ELkGFOfLW4MHRpz9CbxFswAO3r2BoUGvZgEGjzwCLB3s/hnTTqe
 Z6U6z+mfmBCiUiVcaaPCgbSaVY6Mn7ovuK3lLRRMmGgSZdI/RrjTrgoXNNCAJgORagW9
 cOd+OliK0hN2NB3uFqGDWSvzemv+26x5WNMpV/DVfyJYGAyqryOMUMldBpbfB9cHCgTL
 CEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748472; x=1777353272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mdqYSYvyNpmf3YSAjo2AYikrIIkpiycHh+h6wUIhrr0=;
 b=BATVuIbxDS0EQP739e1C/Oc3Iw9uf1B2zAPeCm3jSda8QgvTj2wU1PPv+qQHbPMc+k
 iBVgpieizHgatfDe9xVrTAnB84ettJqwz/BGXVtebGrOAVC2tkayDKFZQ3EhMujENbBV
 uS1sE4zLPMyf5euuNbctRUo+s0/DnkySbmYMhm0+jeCncmxg5p/9XC4ZKJtRUHWAY1Ce
 XVfaS1Mx4mrW1+uyNtnnMv8Wp3faoRIZ+7kKloMkROLfV4flVxNG8wjP1nQCnChnAV1D
 /Lt8IZtpoqbaCMBjHFzOX0mDP11NX+yk/2YKZT6hHe6M1QyfRtJmf4BDPUg534SqHNIk
 M8aA==
X-Gm-Message-State: AOJu0YzId0a46OZRiuaQTPJ5c410tEJCiOlxhlSqPmm6xLXBgDmlR9TF
 WnIlgySrawS98wFWwImFjOV/7cdHbI/CR4tZZvHmJPKUpMrnR5JPAQqPuDtcAl6BScjpFTV1HAM
 hJv2HXmc=
X-Gm-Gg: AeBDieuEcwK6fGItDQnSc6PCZp1S7+iurygSG7npsWinnLy1proIfhpqyoE1boZKHC3
 Uh3Z2s+etd5yUZakUh5R9j1GU5ACcdRQIeiz/qONi8yClztffpWUoUi1QIkvuLHEAih/ftdIhBc
 1924Q3Zfc/Uhe+d6L0vWGPzqquRR/yQj2FRqmzU1Dxx9q66iM5N7+xXrK+H3fNH3t2KvlKgAkGC
 XsuLS/ipc2xWoEhvAKUaqePToa9+4ej2bfmzjeuzlmnHLsF6mzP5+r+17qKV6SK3QfuDIZrLj0Y
 i4gUrC34/uwKxVrQAg8iJlFlMWezv29lucVCtZTXFUndyi3N2bdhomsulTwHmYcm/78plxqyan/
 HGR19byT9mNW44bzKvbz78TI7NVK8tAnK2PdeEyi5Xuf8gVy29hIyvxJ/4iUTo1NoWSZdTPtxls
 9qckBa6AaeZigOrAU+9NsQwiUwvTDxB3w95RbpxCPL
X-Received: by 2002:a17:903:987:b0:2b2:3dd9:c5f5 with SMTP id
 d9443c01a7336-2b5fa0044d9mr197243625ad.36.1776748472332; 
 Mon, 20 Apr 2026 22:14:32 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/37] target/arm: Implement FSCALE for AdvSIMD
Date: Tue, 21 Apr 2026 15:13:26 +1000
Message-ID: <20260421051346.41106-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
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


