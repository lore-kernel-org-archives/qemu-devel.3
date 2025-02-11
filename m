Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCAAC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht89-0004Nw-8K; Tue, 11 Feb 2025 11:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5z-0006lJ-Fe
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:48 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5x-0003SR-JN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so18799625e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291204; x=1739896004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HlEjkAh+sKvMypzkzV7JSuHHCrT/IcHfqPnj/b+181Y=;
 b=nHbNdEFF3Shqj5OUDoVeAaB/cBgdG0StlZbqoIWIAQKRc3JK30q2Wq2aYZ6UJiS5zF
 IvGFDRJM83NYCXyzsJ9iMF677GdTHm79hCjHBn7AK33nZ4DAc4VpW4dqz9KIQ4gNQJhz
 wRj3lBF9exjQBmx2UIQTsxb+3PC76MuHkCRqc6aLP3AeIq1GEbvQI0qb5GVRrTDbxitY
 hqTvkx0n7ubUyyI++BIy13+QYwcJLOp5dVjXl3kMLk2tAeOMAiWTeekyG1aPLI1DDnOK
 qe1arfTI72ks4O6BmKNS5hKC7/+wpHZPqGh9mY4rSxYAKDH/W/dW9gNVsqV3c7CaGJuT
 q+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291204; x=1739896004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlEjkAh+sKvMypzkzV7JSuHHCrT/IcHfqPnj/b+181Y=;
 b=K7iuZmOA7D7ng5Kx9v7vDs/qM5/ZoURKN+QLvr/EoHuG9TlHap39KNClFWNlWmmE/b
 WMWpuW3LkktMkJQGhU7SAbtEeM8/R1ri2Al881OXWLB8HSyhWJ2651XY3c/VtFaxQqwE
 6Qtoii0kn9kGgiVBSTk1B/0rJuyugQyFwFmwCy6uhFJXeU7VPJh6ha+EYlQAjlZUy90h
 S+ccDhDvz/fAJR54Ft/6oYjBsJjAC8ASFHXC3PCiSqvpLnsi7UGP5n5Exj+5oBemSgU0
 rImes0+3iC2CKfinL5Wh1zLyjTrG7qTOCk2GNIGI3lI5g/ndjk/0WNqBi+qVz4Zbrfx6
 1Bmw==
X-Gm-Message-State: AOJu0YzXfQqoOoNJGz7ilOa3T4KErnHdklXe42/8ATlFoMoAZN+IyRI9
 NZm/aI6Fh1OrXo/nbMfuIzY47mNTuYoVBazRNAG6Y44l9Ai8XV4XhHsmZ4+Teh2FzFcl4Ij+ISA
 3
X-Gm-Gg: ASbGncvapjAlX0GwMwnKZzwvtUMvj6kEviegq1/6Q5JeyK0B9xz0F9vhveMfENK+Fc5
 QR2ZtxuxFgS/O4A/vxqaYEVZi88XFV8rrjStE6fhO81C1imb5hRY0cJEYxmdac+QP58AY0ggsm7
 RJ/2Ms9ETpYf8a0q5lITeFx8ttpDZ8V4Nek9tvANi2RRjHfb5pyW/pJddobwoBcHqaW0YwJ9JeX
 OSCYPNxOs1TSNDIreYNN3UpTtP/ufuMiw+rx24n3C5+5Po8Q9790zwaLFpyOnku7BMv4TfVYUFs
 XikL0XcmX65UxF7CkXwf
X-Google-Smtp-Source: AGHT+IGc5O4RNCAinZsjLFoiCPZ2NKeYFNuTxUwGk2aiv/Toy6J3ERz7UYFbHL3iPAPInTCYqqQgyQ==
X-Received: by 2002:a05:600c:198c:b0:434:fdbc:5cf7 with SMTP id
 5b1f17b1804b1-4394c853626mr41235735e9.27.1739291204008; 
 Tue, 11 Feb 2025 08:26:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/68] target/arm: Handle FPCR.AH in vector FCMLA
Date: Tue, 11 Feb 2025 16:25:31 +0000
Message-Id: <20250211162554.4135349-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The negation step in FCMLA mustn't negate a NaN when FPCR.AH
is set. Handle this by passing FPCR.AH to the helper via the
SIMD data field, and use this to select whether to do the
negation via XOR or via the muladd negate_product flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-26-richard.henderson@linaro.org
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/vec_helper.c    | 66 ++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3ab84611a65..ca06982d313 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6164,7 +6164,7 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                       a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
-                      a->rot, fn[a->esz]);
+                      a->rot | (s->fpcr_ah << 2), fn[a->esz]);
     return true;
 }
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index fc3e6587b81..630513f00b2 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -965,22 +965,26 @@ void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm, void *va,
     uintptr_t opr_sz = simd_oprsz(desc);
     float16 *d = vd, *n = vn, *m = vm, *a = va;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    uint32_t neg_real = flip ^ neg_imag;
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float16 negx_imag, negx_real;
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 15;
-    neg_imag <<= 15;
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 15;
+    negx_imag = (negf_imag & ~fpcr_ah) << 15;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     for (i = 0; i < opr_sz / 2; i += 2) {
         float16 e2 = n[H2(i + flip)];
-        float16 e1 = m[H2(i + flip)] ^ neg_real;
+        float16 e1 = m[H2(i + flip)] ^ negx_real;
         float16 e4 = e2;
-        float16 e3 = m[H2(i + 1 - flip)] ^ neg_imag;
+        float16 e3 = m[H2(i + 1 - flip)] ^ negx_imag;
 
-        d[H2(i)] = float16_muladd(e2, e1, a[H2(i)], 0, fpst);
-        d[H2(i + 1)] = float16_muladd(e4, e3, a[H2(i + 1)], 0, fpst);
+        d[H2(i)] = float16_muladd(e2, e1, a[H2(i)], negf_real, fpst);
+        d[H2(i + 1)] = float16_muladd(e4, e3, a[H2(i + 1)], negf_imag, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -1025,22 +1029,26 @@ void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm, void *va,
     uintptr_t opr_sz = simd_oprsz(desc);
     float32 *d = vd, *n = vn, *m = vm, *a = va;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    uint32_t neg_real = flip ^ neg_imag;
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float32 negx_imag, negx_real;
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 31;
-    neg_imag <<= 31;
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 31;
+    negx_imag = (negf_imag & ~fpcr_ah) << 31;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     for (i = 0; i < opr_sz / 4; i += 2) {
         float32 e2 = n[H4(i + flip)];
-        float32 e1 = m[H4(i + flip)] ^ neg_real;
+        float32 e1 = m[H4(i + flip)] ^ negx_real;
         float32 e4 = e2;
-        float32 e3 = m[H4(i + 1 - flip)] ^ neg_imag;
+        float32 e3 = m[H4(i + 1 - flip)] ^ negx_imag;
 
-        d[H4(i)] = float32_muladd(e2, e1, a[H4(i)], 0, fpst);
-        d[H4(i + 1)] = float32_muladd(e4, e3, a[H4(i + 1)], 0, fpst);
+        d[H4(i)] = float32_muladd(e2, e1, a[H4(i)], negf_real, fpst);
+        d[H4(i + 1)] = float32_muladd(e4, e3, a[H4(i + 1)], negf_imag, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -1085,22 +1093,26 @@ void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm, void *va,
     uintptr_t opr_sz = simd_oprsz(desc);
     float64 *d = vd, *n = vn, *m = vm, *a = va;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint64_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    uint64_t neg_real = flip ^ neg_imag;
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float64 negx_real, negx_imag;
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 63;
-    neg_imag <<= 63;
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (uint64_t)(negf_real & ~fpcr_ah) << 63;
+    negx_imag = (uint64_t)(negf_imag & ~fpcr_ah) << 63;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     for (i = 0; i < opr_sz / 8; i += 2) {
         float64 e2 = n[i + flip];
-        float64 e1 = m[i + flip] ^ neg_real;
+        float64 e1 = m[i + flip] ^ negx_real;
         float64 e4 = e2;
-        float64 e3 = m[i + 1 - flip] ^ neg_imag;
+        float64 e3 = m[i + 1 - flip] ^ negx_imag;
 
-        d[i] = float64_muladd(e2, e1, a[i], 0, fpst);
-        d[i + 1] = float64_muladd(e4, e3, a[i + 1], 0, fpst);
+        d[i] = float64_muladd(e2, e1, a[i], negf_real, fpst);
+        d[i + 1] = float64_muladd(e4, e3, a[i + 1], negf_imag, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


