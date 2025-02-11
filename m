Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D305EC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7C-0001WT-Tp; Tue, 11 Feb 2025 11:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5u-0006i6-E1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5s-0003F6-0H
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43944c51e41so24655205e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291195; x=1739895995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ULgbBVOGXN6AY5BC4aU6aGZbJwza+dJWr4d7SeUgmQY=;
 b=DPAyo/v8vIjWUjK4fPtQJFMe5wxFMtxMQqZjIXYoXoSLeW9SAAKdIZAh42nyBIJK8v
 zAx8ifiNWD7KPVtmqIWdl2+V//PsCfHTUoWDAp4HBbYphPQPaZ1PEsyd2apPawqa08ua
 VWVdv8I04FUUE0KkyAIvbjhzftSLmswtIzuUSNwMi41SYA/qtm1GsYmzuHgbXaNr1P3i
 /I8ljf2n9tsZZ+QvLt3l1QNwbm0RrF5aYItYK6gz7Tj19sgr0wOuUDdfj0rxzDhW2cqr
 MQQezYEIdTkbR9zx64UMMSWj+jdc5AzSM/Y8XO47T4f74bFNmySGrbUa43GXSWOHIqQw
 QvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291195; x=1739895995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULgbBVOGXN6AY5BC4aU6aGZbJwza+dJWr4d7SeUgmQY=;
 b=Sqi2F+dRQ6PPxB60I3NwknNkombGYM8cSAT+4AJRSFsOU7hnMGk2cJKSDA9oF7Tn+3
 V/b8JaoCuwees0i/VzvDGeXCqZNNjdcs4tYQyGAHoUpXPGhyC9YdClkajkiAPpvk4aUm
 qS1nWutcceOkPUD1/YbkVEYoWJst1qAlCeqPxZzJlHX4ZtajMEV5QHt37+jaIIjPMx6W
 2FG3AFx1KX6pKoz+F8Z4VDWv7MLnKvj/WSqnzoo45OEryiqGEVItiE7j6YJYFyLWIVh2
 0kN4XzbVW0HsUH3TykGnHXgRIWO9ypyKHZQChF5t5R8/nwhIOO3DxKRQAf7UPpg63/F9
 qakQ==
X-Gm-Message-State: AOJu0Yy7bIe8nw1DBLkaqiDIZZcjZbljS8gHwSQjY1jVK8oeqkii3vNL
 zAcKVlKtaeZuDSNc4iErjvH75+43ydk5XMklQgFB5YDqmXYnJ638KrhpWe/y0Gnwc8J55m1f2Ap
 n
X-Gm-Gg: ASbGncvIMZ5mbibH5D50Y8BFpG+3prRxlr1zejsiCAJEE2VqaPnQVB1uhV3pQgLKyTT
 iqOFbmRoXvJY9foa7UUMuRl+kRxS1tJ4qA0bece2/04Hhlu6oD8v+TCkO1msYjvTRFUBhpXXRrm
 0eNRI/Qun6+z5K5GsoNMxKBphw39MTjb791oYlP+clvR42nUPRaTRgP4FL3v12lYJiNHMh24yLc
 DtE0ePSjbl6GthgapmUAAr5FkCYohH7IhiLWbvtdy68N3LHS6pTOp7Y6ME0XgfywvDukeAAQYbw
 SzexHos7Q3vl0LJ4Nl9h
X-Google-Smtp-Source: AGHT+IFqO6FBn67Q3fG6v4PcobgENXePshQa4Oi4C5jTLJJgTxAkgKAvO4bF9SotJvtdC91FtPn+Ug==
X-Received: by 2002:a05:600c:4e89:b0:439:45ce:15c0 with SMTP id
 5b1f17b1804b1-43945ce18d2mr59530265e9.25.1739291195282; 
 Tue, 11 Feb 2025 08:26:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/68] target/arm: Handle FPCR.AH in negation steps in FCADD
Date: Tue, 11 Feb 2025 16:25:23 +0000
Message-Id: <20250211162554.4135349-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The negation steps in FCADD must honour FPCR.AH's "don't change the
sign of a NaN" semantics.  Implement this by encoding FPCR.AH into
the SIMD data field passed to the helper and using that to decide
whether to negate the values.

The construction of neg_imag and neg_real were done to make it easy
to apply both in parallel with two simple logical operations.  This
changed with FPCR.AH, which is more complex than that. Switch to
an approach closer to the pseudocode, where we extract the rot
parameter from the SIMD data word and negate the appropriate
input value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 10 +++++--
 target/arm/tcg/vec_helper.c    | 54 +++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 76c41b9bdba..e8db9f39b16 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6106,8 +6106,14 @@ static gen_helper_gvec_3_ptr * const f_vector_fcadd[3] = {
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
index 0b84a562c03..b181b9734d4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -879,19 +879,21 @@ void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
     float16 *d = vd;
     float16 *n = vn;
     float16 *m = vm;
-    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 15;
-    neg_imag <<= 15;
-
     for (i = 0; i < opr_sz / 2; i += 2) {
         float16 e0 = n[H2(i)];
-        float16 e1 = m[H2(i + 1)] ^ neg_imag;
+        float16 e1 = m[H2(i + 1)];
         float16 e2 = n[H2(i + 1)];
-        float16 e3 = m[H2(i)] ^ neg_real;
+        float16 e3 = m[H2(i)];
+
+        if (rot) {
+            e3 = float16_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float16_maybe_ah_chs(e1, fpcr_ah);
+        }
 
         d[H2(i)] = float16_add(e0, e1, fpst);
         d[H2(i + 1)] = float16_add(e2, e3, fpst);
@@ -906,19 +908,21 @@ void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
     float32 *d = vd;
     float32 *n = vn;
     float32 *m = vm;
-    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 31;
-    neg_imag <<= 31;
-
     for (i = 0; i < opr_sz / 4; i += 2) {
         float32 e0 = n[H4(i)];
-        float32 e1 = m[H4(i + 1)] ^ neg_imag;
+        float32 e1 = m[H4(i + 1)];
         float32 e2 = n[H4(i + 1)];
-        float32 e3 = m[H4(i)] ^ neg_real;
+        float32 e3 = m[H4(i)];
+
+        if (rot) {
+            e3 = float32_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float32_maybe_ah_chs(e1, fpcr_ah);
+        }
 
         d[H4(i)] = float32_add(e0, e1, fpst);
         d[H4(i + 1)] = float32_add(e2, e3, fpst);
@@ -933,19 +937,21 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
     float64 *d = vd;
     float64 *n = vn;
     float64 *m = vm;
-    uint64_t neg_real = extract64(desc, SIMD_DATA_SHIFT, 1);
-    uint64_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 63;
-    neg_imag <<= 63;
-
     for (i = 0; i < opr_sz / 8; i += 2) {
         float64 e0 = n[i];
-        float64 e1 = m[i + 1] ^ neg_imag;
+        float64 e1 = m[i + 1];
         float64 e2 = n[i + 1];
-        float64 e3 = m[i] ^ neg_real;
+        float64 e3 = m[i];
+
+        if (rot) {
+            e3 = float64_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float64_maybe_ah_chs(e1, fpcr_ah);
+        }
 
         d[i] = float64_add(e0, e1, fpst);
         d[i + 1] = float64_add(e2, e3, fpst);
-- 
2.34.1


