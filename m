Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1C0C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMcv-00079T-CF; Fri, 24 Jan 2025 11:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZD-0005rN-5h
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ9-0005mT-5Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so15094285e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736193; x=1738340993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QLc5R4kgwLEQYIqVscOHBm/T/V1hZNad06mmFiQYTk0=;
 b=LonrvDe8ofyt9K4xiT0MSIuIylOd+bgOp4YTOOm0VEc9kok20yD5G/jNUMbRXa7aIf
 JlRb6UaFC2vcGU+B77wHRPjU6R2fhw58sb0dQ42D+9f/bvf/mtq+AWlejMg5SygtpFHJ
 q//D0u6t1X7PQIneit9CR+qlQLgfDbneffFRIp0O+hvX4knqwqjZEATrlgzJL8K0ejev
 JQ0yWOAwp2IqPSfbkpmk1gz2U8/EJIyDXnvWJXvzIqRyaKK16+MlwZ6XGzqIVr7I0fQO
 LtxvCKZvu8f7ggk10+3SgTmjt0WFyIzA7q0yFXP9mMeLOUVkKeldhjU+Oz7VG0TvSX1M
 Msww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736193; x=1738340993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLc5R4kgwLEQYIqVscOHBm/T/V1hZNad06mmFiQYTk0=;
 b=Lkr/wpj2V/ryAPKHlIHigg+Ryv47fqdK1ZcxoTl7V9SrgCZrvC+CW7P5zDsn6g3ZXw
 jOiQ7VdduPrK88ECBteDTHtR4XDvj3j0+LZ/lEtIKAWehIJamk6KBn2lHbE+pTphTmM9
 GM/dGe+FKcwAiJMMx3j1RZiVp5ph7irgLG4PUTngRcBHS7Nir6WQnPLSWoS8ANwGZCRu
 0/pf2v0tRejVeMqpA0OS/piTptwWU6CoILLIMROFoVDQJYHNZO2vyDAfuo/eZfYgwsSw
 TMmkjqh3YKWGbv79O6XoJLGi5Dkx32T2KEHUTR3BnbGe6CTzzXmeAY7KzJyM/RDzuLAU
 Shmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfhPi4WfCNHtwuZboQw58FQc6n7BXO5TZpmwolhMXH0lbb9sbORLSK6V97qAHhvBy3tkti2B3uzNo+@nongnu.org
X-Gm-Message-State: AOJu0YyN4RymVN7SbJ/Ym+4Uu2UimWO7jetf7m3v9yDqyMPNP6RM7es6
 fS2DudFkwias0CMtylhrUN8J4asNRWp7F6K/pXui8oQV8y6uJk5N5pysIiGQUMc=
X-Gm-Gg: ASbGncvOZRmBgDFD5UwNG9/Ztlqe3jWmRC678g7fzeDewHAy68I+f26gNGDCm3JtBhN
 UYJTaJI78oNUBTG182UF0va4KjZh44VAoQ/Rc+9cSyUUvXp0UdkCn8/qD4co+HWMN9oyq+NKJr2
 rXVE5VSZ3yfmOWSAAmjtzQveTX9qWUjcalzmKxo5WGJls9onSPK/+Jui1KpIWTkV+hCQy/hvlkQ
 DbJnTlo2G3+CKHaOWUXuUJXSOs7/cfmXe0UXCVJyRaTkEXcJc3IQCvCWzbpVMY4RxEA6DxB7rqK
 Mo4KitPj6/k=
X-Google-Smtp-Source: AGHT+IFp4HqoGPDpZdupadiiTkZyXkCSsAhuRDaiUIQhirJc+tmSDeBb/L0M6Ts8pXdrXltwdm/e+w==
X-Received: by 2002:a05:600c:511b:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-4389142e0e8mr268300935e9.22.1737736193127; 
 Fri, 24 Jan 2025 08:29:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 60/76] target/arm: Handle FPCR.AH in FMLSL
Date: Fri, 24 Jan 2025 16:28:20 +0000
Message-Id: <20250124162836.2332150-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Honour the FPCR.AH "don't negate the sign of a NaN" semantics in
FMLSL. We pass in the value of FPCR.AH in the SIMD data field, and
use this to determine whether we should suppress the negation for
NaN inputs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c |  4 ++--
 target/arm/tcg/vec_helper.c    | 28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0827dff16b2..e22c2a148ab 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5968,7 +5968,7 @@ TRANS(FMINNMP_v, do_fp3_vector, a, 0, f_vector_fminnmp)
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
-        int data = (is_2 << 1) | is_s;
+        int data = (s->fpcr_ah << 2) | (is_2 << 1) | is_s;
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm), tcg_env,
@@ -6738,7 +6738,7 @@ TRANS(FMLS_vi, do_fmla_vector_idx, a, true)
 static bool do_fmlal_idx(DisasContext *s, arg_qrrx_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
-        int data = (a->idx << 2) | (is_2 << 1) | is_s;
+        int data = (s->fpcr_ah << 5) | (a->idx << 2) | (is_2 << 1) | is_s;
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm), tcg_env,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 382b5da4a9c..aa42c50f9fe 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2083,6 +2083,26 @@ static uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
     return ptr[is_q & is_2] >> ((is_2 & ~is_q) << 5);
 }
 
+static uint64_t neg4_f16(uint64_t v, bool fpcr_ah)
+{
+    /*
+     * Negate all inputs for FMLSL at once. This is slightly complicated
+     * by the need to avoid flipping the sign of a NaN when FPCR.AH == 1
+     */
+    uint64_t mask = 0x8000800080008000ull;
+    if (fpcr_ah) {
+        uint64_t tmp = v, signbit = 0x8000;
+        for (int i = 0; i < 4; i++) {
+            if (float16_is_any_nan(extract64(tmp, 0, 16))) {
+                mask ^= signbit;
+            }
+            tmp >>= 16;
+            signbit <<= 16;
+        }
+    }
+    return v ^ mask;
+}
+
 /*
  * Note that FMLAL requires oprsz == 8 or oprsz == 16,
  * as there is not yet SVE versions that might use blocking.
@@ -2094,6 +2114,7 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
     intptr_t i, oprsz = simd_oprsz(desc);
     int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
     int is_q = oprsz == 16;
     uint64_t n_4, m_4;
 
@@ -2101,9 +2122,8 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
     n_4 = load4_f16(vn, is_q, is_2);
     m_4 = load4_f16(vm, is_q, is_2);
 
-    /* Negate all inputs for FMLSL at once.  */
     if (is_s) {
-        n_4 ^= 0x8000800080008000ull;
+        n_4 = neg4_f16(n_4, fpcr_ah);
     }
 
     for (i = 0; i < oprsz / 4; i++) {
@@ -2155,6 +2175,7 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
     int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     int index = extract32(desc, SIMD_DATA_SHIFT + 2, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 5, 1);
     int is_q = oprsz == 16;
     uint64_t n_4;
     float32 m_1;
@@ -2162,9 +2183,8 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
     /* Pre-load all of the f16 data, avoiding overlap issues.  */
     n_4 = load4_f16(vn, is_q, is_2);
 
-    /* Negate all inputs for FMLSL at once.  */
     if (is_s) {
-        n_4 ^= 0x8000800080008000ull;
+        n_4 = neg4_f16(n_4, fpcr_ah);
     }
 
     m_1 = float16_to_float32_by_bits(((float16 *)vm)[H2(index)], fz16);
-- 
2.34.1


