Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FE7C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYd-0007EB-RQ; Sat, 01 Feb 2025 11:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYa-00076c-GN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:20 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYY-0001IU-KG
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:20 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so29999245e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428077; x=1739032877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hcrruo5RnW9YV1dz+RMkLiucYHbo488Dc1v5YzDdwzw=;
 b=l6gCYIt1wTvXmQSNzBp5iGBpXg4pufU6Ys8vVv0xayMZf6ReV/FSsH8yho0ebabZHT
 DOpqUumwYihpsoRMMTIu9iD8LpQ+TDwayzGfEt8TAyKSbet0pTOHIuIHar7Sboe1h4fT
 kKc4RIJrd6MUe/lMuY1RR1kF5+qpW/6tx5k3InseJ9tRrpaNXbl71h1vgWrinYrSeUiw
 TrNxIiB7d/UvsaViLgrU/8txtemmZ8Df5vNOg3624MPPu4fC0e6LaR1kivzNLmJfQBmz
 Qa1JAyw29E9qMxPXa1gjWyxUQ4BcUtGEMl78fakrn+XYSZNdZGnNmdpl4vewYduyJVzj
 TDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428077; x=1739032877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcrruo5RnW9YV1dz+RMkLiucYHbo488Dc1v5YzDdwzw=;
 b=EstfmvD2BWIchHlwZ9W6IdaNXEDJdoMa5rR16AzukkK2g2imosGLmXvoNdCe9D7ahf
 E7r/l9SpCVGFlf+iKnUVqu5UmcbHT7/ig0WwlgozHS+8i3ORkTZCJG1kHK3uiabVIqUF
 yuodx5SRvnsj1kzJ5s5wmGV/GUI+N44NIdSPEnj/Z1gk6aZV6VifuO8x+xq1Q6vqlO+j
 LwSsu517vhK+kwum60f12BhsCpptQ3g9gfqboQnxoH0NHvE1h/eki1Twbh9YuxqA6A5A
 wTKt8O2l0nBk8s4+xkRuKx+9TQbEdxrAZDRgNXuUYmaM9+iXe+oDLfB9TUQsOAPREMrO
 +PzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpHvNHIanP72+ttFz1Svk1iWldki76S4kj30PidhqEW+1lADIOVwZqPYnqCXDhk5bp7Bokkw2szuKk@nongnu.org
X-Gm-Message-State: AOJu0YzsmW7LAKpF6+3/1P1XwkasZlQQ7s8ICMQ1jjV6s9Lu/pKs0oDh
 p2L4Fe8BBrTUz+YkEh+25PcdE0UHrv/vh1cx7pRUq1ChU9sz+hqg3yE+/KHI8h4=
X-Gm-Gg: ASbGnculfd9PWlv5yzRsnSfAuNdHpy1/aux2WRkjdjGoPyg023ED0N9fi5MzOENHZG5
 SJiD4S/k+KbJuaaL0fPD1UQCPTJsET9HThey9KSBYd6Pi4d/dHzuTKefizwQ1lMgF3YVd2tf9Oh
 xQgaMA6wVbdF56GbAvXyXFWWyGKBeoFAya6f1F8Uu6ZR7QnmykCjFjFe2U/W2QwO69AC7xnmmJ2
 2VnhU0S7Hq0lkl3zXXLld+NNwIlAw/sQA2HFKo8QYsAJ2gWA/1P2fiJN10YacJZXj5TiB0yVoeC
 We6jnXeX7PDq8JX5nO2v
X-Google-Smtp-Source: AGHT+IF0oHU3270NjiK1//6Zt7tH+gJ2OlGulRguD4OUQnilIv8BSL15SuSzlpP075LKeDfie0lLag==
X-Received: by 2002:a05:600c:83ce:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-438dc41d5c4mr119153835e9.25.1738428076438; 
 Sat, 01 Feb 2025 08:41:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 47/69] target/arm: Handle FPCR.AH in FCMLA by index
Date: Sat,  1 Feb 2025 16:39:50 +0000
Message-Id: <20250201164012.1660228-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The negation step in FCMLA by index mustn't negate a NaN when
FPCR.AH is set. Use the same approach as vector FCMLA of
passing in FPCR.AH and using it to select whether to negate
by XOR or by the muladd negate_product flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-27-richard.henderson@linaro.org
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/vec_helper.c    | 44 ++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c45a9822281..e8eab1eabdc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6927,7 +6927,7 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
-                          (a->idx << 2) | a->rot, fn);
+                          (s->fpcr_ah << 4) | (a->idx << 2) | a->rot, fn);
     }
     return true;
 }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 630513f00b2..c2f98a5c67e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -995,29 +995,33 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
     uintptr_t opr_sz = simd_oprsz(desc);
     float16 *d = vd, *n = vn, *m = vm, *a = va;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
-    uint32_t neg_real = flip ^ neg_imag;
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 4, 1);
+    uint32_t negf_real = flip ^ negf_imag;
     intptr_t elements = opr_sz / sizeof(float16);
     intptr_t eltspersegment = MIN(16 / sizeof(float16), elements);
+    float16 negx_imag, negx_real;
     intptr_t i, j;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 15;
-    neg_imag <<= 15;
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 15;
+    negx_imag = (negf_imag & ~fpcr_ah) << 15;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     for (i = 0; i < elements; i += eltspersegment) {
         float16 mr = m[H2(i + 2 * index + 0)];
         float16 mi = m[H2(i + 2 * index + 1)];
-        float16 e1 = neg_real ^ (flip ? mi : mr);
-        float16 e3 = neg_imag ^ (flip ? mr : mi);
+        float16 e1 = negx_real ^ (flip ? mi : mr);
+        float16 e3 = negx_imag ^ (flip ? mr : mi);
 
         for (j = i; j < i + eltspersegment; j += 2) {
             float16 e2 = n[H2(j + flip)];
             float16 e4 = e2;
 
-            d[H2(j)] = float16_muladd(e2, e1, a[H2(j)], 0, fpst);
-            d[H2(j + 1)] = float16_muladd(e4, e3, a[H2(j + 1)], 0, fpst);
+            d[H2(j)] = float16_muladd(e2, e1, a[H2(j)], negf_real, fpst);
+            d[H2(j + 1)] = float16_muladd(e4, e3, a[H2(j + 1)], negf_imag, fpst);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
@@ -1059,29 +1063,33 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
     uintptr_t opr_sz = simd_oprsz(desc);
     float32 *d = vd, *n = vn, *m = vm, *a = va;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
-    uint32_t neg_real = flip ^ neg_imag;
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 4, 1);
+    uint32_t negf_real = flip ^ negf_imag;
     intptr_t elements = opr_sz / sizeof(float32);
     intptr_t eltspersegment = MIN(16 / sizeof(float32), elements);
+    float32 negx_imag, negx_real;
     intptr_t i, j;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 31;
-    neg_imag <<= 31;
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 31;
+    negx_imag = (negf_imag & ~fpcr_ah) << 31;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     for (i = 0; i < elements; i += eltspersegment) {
         float32 mr = m[H4(i + 2 * index + 0)];
         float32 mi = m[H4(i + 2 * index + 1)];
-        float32 e1 = neg_real ^ (flip ? mi : mr);
-        float32 e3 = neg_imag ^ (flip ? mr : mi);
+        float32 e1 = negx_real ^ (flip ? mi : mr);
+        float32 e3 = negx_imag ^ (flip ? mr : mi);
 
         for (j = i; j < i + eltspersegment; j += 2) {
             float32 e2 = n[H4(j + flip)];
             float32 e4 = e2;
 
-            d[H4(j)] = float32_muladd(e2, e1, a[H4(j)], 0, fpst);
-            d[H4(j + 1)] = float32_muladd(e4, e3, a[H4(j + 1)], 0, fpst);
+            d[H4(j)] = float32_muladd(e2, e1, a[H4(j)], negf_real, fpst);
+            d[H4(j + 1)] = float32_muladd(e4, e3, a[H4(j + 1)], negf_imag, fpst);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
-- 
2.34.1


