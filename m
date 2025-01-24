Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4003C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMco-0006Gm-CI; Fri, 24 Jan 2025 11:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ8-0005os-E0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ6-0005lI-Fn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:54 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436341f575fso24727475e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736191; x=1738340991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LSzywg4TTdbVfL3fvcONmuOXn5s4KCgB/V3iwxmTcrs=;
 b=kiv3o2B2PmNEpnqFUIoao6i3ODySIYdCuGAnhiT3TtkBb1SKm8EWR83/71xFFhQB3/
 H05mtG3qsIHg7rdxxCKrw2EoYK65EoxyDuBtQVhWi2uAOH+udKXkIrVY9AfB2BC6xvc1
 vijb+0DfBfQfmUbYpsDu4+FXnL9Q23ZAPWObFUwUja1anqj0Kj1o2hpmHN0ZwJb/5339
 k9ofUkH5I9ZjhRaP1JURiXCLE8gHLQXvXrDrrV9ROg75h5LjdBOCzSJlRKqBFcKWe6CE
 fZy7+dPyTKyTcDNgViXCsJ7Z3a3Gdw93m63JH/W0tVVANvjJ7pJDEY7IKEQoRg8O9NH2
 bwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736191; x=1738340991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSzywg4TTdbVfL3fvcONmuOXn5s4KCgB/V3iwxmTcrs=;
 b=PodZaDDSODWmJrxdxONMSLJsLB3ULTPMFasiMJy1la7+fpagJq6IlpOklcb0JDRaxS
 9ccoRRO1MrszyuzN0XY46YJnRUakELcnNdiayNyygGdxeB9fVTPzLLEbZdZIWYoWJo9T
 MiV6DpyhvUh9f172G1bHYgao/Fex1ugtIEjLe90gZStespViuc/HRclc9/r3jerGZZbx
 l9//RKpUI1FjwJG00PrmG8Myxd1n7m7u0z16/WskHtAiBLL3l9v4Q+yiP0s0Eo2uhlVE
 AbKGFSe/koQUojLj9XFDfNcsuymBchlN5gkxVADWdUHZO2PaY9rzNEbedgplKHyOCvo5
 HDsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ELj1VAscy4m2zGAe+rx2XsZCzbJ31jdRq5+UTy2o0H97E7TE9UR0XYwM9zrpU4G10rN4R2nq5S91@nongnu.org
X-Gm-Message-State: AOJu0Yze9lOR0lfBLU9rvDuVHq+FztMpOqjuv+nM8smmyWSP4xOduKVf
 LUi5UQaGT92FCJVTxucM3A2PMH07lziSYbhQfs874Ug9L3JMFQcDF7TQsp20Vc4=
X-Gm-Gg: ASbGncsFEww6rdrlYPxfTKJeABktU7B6GZszC1PjaTKJiOAXeDeMNbZ9LWYEkZqnulC
 YP0J78vAhI9bIMWXHNL0z1FddocmYrg2NpXgmN8MDokyc5at6gntvDtpyUH1Pjp49LE63gfa7sN
 yjc+rMHdtqvkI8QJ410P87J6K+Doo+B/xSpb53p6PzDSaXameE49cGDPT3kepz49BzIz5QyjGao
 uIcDOESpqMx7j6ilkfr9qiBifIFkesoim/zLLdQeCEISzuM7nYKmlMncuteFpO7+F94fpkOETxT
 ZN4dAzTArn8=
X-Google-Smtp-Source: AGHT+IEurW6y/umpMtMdpIsOEE1ECQZztj+VvI/6Rv4Okqv1jc5MoRXyRawpU3DaPjzW8qd2ZgMc5A==
X-Received: by 2002:a05:600c:8712:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-438913ce0b7mr315490555e9.7.1737736191105; 
 Fri, 24 Jan 2025 08:29:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 58/76] target/arm: Handle FPCR.AH in negation steps in FCADD
Date: Fri, 24 Jan 2025 16:28:18 +0000
Message-Id: <20250124162836.2332150-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The negation steps in FCADD must honour FPCR.AH's "don't change the
sign of a NaN" semantics.  Implement this by encoding FPCR.AH into
the SIMD data field passed to the helper and using that to decide
whether to negate the values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 10 +++++++--
 target/arm/tcg/vec_helper.c    | 39 ++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ce9ab75bc2f..0827dff16b2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6117,8 +6117,14 @@ static gen_helper_gvec_3_ptr * const f_vector_fcadd[3] = {
     gen_helper_gvec_fcadds,
     gen_helper_gvec_fcaddd,
 };
-TRANS_FEAT(FCADD_90, aa64_fcma, do_fp3_vector, a, 0, f_vector_fcadd)
-TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1, f_vector_fcadd)
+/*
+ * Encode FPCR.AH into the data so the helper knows whether the
+ * negations it does should avoid flipping the sign bit on a NaN
+ */
+TRANS_FEAT(FCADD_90, aa64_fcma, do_fp3_vector, a, 0 | (s->fpcr_ah << 1),
+           f_vector_fcadd)
+TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1 | (s->fpcr_ah << 1),
+           f_vector_fcadd)
 
 static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
 {
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 3b87e5b8d6d..382b5da4a9c 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -881,6 +881,7 @@ void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
     float16 *m = vm;
     uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = neg_real ^ 1;
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
@@ -889,9 +890,17 @@ void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
 
     for (i = 0; i < opr_sz / 2; i += 2) {
         float16 e0 = n[H2(i)];
-        float16 e1 = m[H2(i + 1)] ^ neg_imag;
+        float16 e1 = m[H2(i + 1)];
         float16 e2 = n[H2(i + 1)];
-        float16 e3 = m[H2(i)] ^ neg_real;
+        float16 e3 = m[H2(i)];
+
+        /* FPNeg() mustn't flip sign of a NaN if FPCR.AH == 1 */
+        if (!(fpcr_ah && float16_is_any_nan(e1))) {
+            e1 ^= neg_imag;
+        }
+        if (!(fpcr_ah && float16_is_any_nan(e3))) {
+            e3 ^= neg_real;
+        }
 
         d[H2(i)] = float16_add(e0, e1, fpst);
         d[H2(i + 1)] = float16_add(e2, e3, fpst);
@@ -908,6 +917,7 @@ void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
     float32 *m = vm;
     uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = neg_real ^ 1;
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
@@ -916,9 +926,17 @@ void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
 
     for (i = 0; i < opr_sz / 4; i += 2) {
         float32 e0 = n[H4(i)];
-        float32 e1 = m[H4(i + 1)] ^ neg_imag;
+        float32 e1 = m[H4(i + 1)];
         float32 e2 = n[H4(i + 1)];
-        float32 e3 = m[H4(i)] ^ neg_real;
+        float32 e3 = m[H4(i)];
+
+        /* FPNeg() mustn't flip sign of a NaN if FPCR.AH == 1 */
+        if (!(fpcr_ah && float32_is_any_nan(e1))) {
+            e1 ^= neg_imag;
+        }
+        if (!(fpcr_ah && float32_is_any_nan(e3))) {
+            e3 ^= neg_real;
+        }
 
         d[H4(i)] = float32_add(e0, e1, fpst);
         d[H4(i + 1)] = float32_add(e2, e3, fpst);
@@ -935,6 +953,7 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
     float64 *m = vm;
     uint64_t neg_real = extract64(desc, SIMD_DATA_SHIFT, 1);
     uint64_t neg_imag = neg_real ^ 1;
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
@@ -943,9 +962,17 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
 
     for (i = 0; i < opr_sz / 8; i += 2) {
         float64 e0 = n[i];
-        float64 e1 = m[i + 1] ^ neg_imag;
+        float64 e1 = m[i + 1];
         float64 e2 = n[i + 1];
-        float64 e3 = m[i] ^ neg_real;
+        float64 e3 = m[i];
+
+        /* FPNeg() mustn't flip sign of a NaN if FPCR.AH == 1 */
+        if (!(fpcr_ah && float64_is_any_nan(e1))) {
+            e1 ^= neg_imag;
+        }
+        if (!(fpcr_ah && float64_is_any_nan(e3))) {
+            e3 ^= neg_real;
+        }
 
         d[i] = float64_add(e0, e1, fpst);
         d[i + 1] = float64_add(e2, e3, fpst);
-- 
2.34.1


