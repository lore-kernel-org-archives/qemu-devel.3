Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67552C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx34-0000x4-OO; Tue, 28 Jan 2025 20:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx31-0000ur-13
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:19 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2z-0003ZY-50
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:18 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21636268e43so138111625ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114756; x=1738719556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhZNlZKdSUaiwHdIbzmkL/DkDUQqqUml+/fzqgBD+4U=;
 b=uo/xxesmmkv+f2b3xtnf/Sg5k6tSeVlYbs0cp94DzX8Vpq5EbfVRafilsTMooXDupL
 Rwcz5ocHOtBK7aW6jIPtF6lpHO2w+0oMnMMA97/orhC8kVF0SV9p4r/zhp51RKe4TQ93
 mreyPX5iBfxKPmeYpSqbPKEh9LzIBSlUXuEAhJAm7nEKaPe/vq6hiF3zyvPH3k8Urm0s
 1cxPLrRd08NvRToh9xANB/C8KefHaJK51FdUGPRt2qOlMEZAYmSqK+L+rtwcmuCZAuCJ
 1PO4IRi9sELXanVprfV1ZbVGrxi4PtPXWifMDJwTBJhMTGo1iuzWkmzpnr/BrlY98KVy
 ryEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114756; x=1738719556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhZNlZKdSUaiwHdIbzmkL/DkDUQqqUml+/fzqgBD+4U=;
 b=lDP/D3ZFQAkHi08akqNzQ4fUgRbdcDtCPtO7tO+6dZCefBSqE31ZCaQPKhOWI1TJPJ
 Ao5XyqRv7SKrZp5HVbqiT5H3jhKrLwa2tEihq8ituI9nJP82FeOtj5ehyUVJHMXpii98
 SjRYRrmuZQZhCQ4/4LSWalqH9auWpwmlJQEQRmD9rVrbhWwzkfJLBwI9nt7jnDiITnqG
 eco6vwUvc8ix1swDrP/yhtnJgfKqY94obuwz6MzQUSqdGbwThB3UWt6NZMCGiGUDdLKE
 BwhowY2ceRtPfBJHWBwvLvb5vqZwSKCI4gcrHy8e/cYtW1WKhmmYTzkQNLpHX3yIdK7T
 26/g==
X-Gm-Message-State: AOJu0YzaEnMjpJFHYyK0iskmwrUZnUNMnmHbkb/+gY2rbsWu99Pfc1vm
 XQYoyBh7KxtAas3JwI2bGJEy+Ak251cVsR8ZY5Z7jwR/AREa3VBOzNWgHxEWi++mYXjuPuG5YrX
 5
X-Gm-Gg: ASbGnctYpa/uyyh5uwiiRnlDmhZ/AWlhUElX3sOmUjIguMYw/LvugZbPxVMe5xQBRL4
 gUFQMjfY/Ntj6Svkk8xmfvjX2Lo8BeILV+Y9k4++BDkvgc88weFbHvavJGgM9maS2yGBAw0E66z
 bN64Dr9Rb92eU94kWgbUYVFUeKVfIHueNh3Ri+bsc/pDCqM1dwMODQcf6rsbXZ+IxgAY1HQlab9
 eI/HSr6yuLDtFe8kPgYs0LT3Qm+Wzc9mL31zHxUJvxmm3Sd2jlFfSb7ZcdRRftLKh/GtbAVQ5FY
 ZisYvWGwTNwE4XD+qP2a52A1AcwSOoZr4KCm+dtc4zdqWYNl2+98+HKxD/PL
X-Google-Smtp-Source: AGHT+IFQN/1xtw4fR3MFz1HIUg8B6DY66SimpSduU2uWwUuE/Nk1/0l+hgDPU/FwpO5t4h4fpYrBag==
X-Received: by 2002:a17:902:f60f:b0:215:a3fd:61f5 with SMTP id
 d9443c01a7336-21dd7c44516mr19876635ad.5.1738114755744; 
 Tue, 28 Jan 2025 17:39:15 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 25/34] target/arm: Handle FPCR.AH in gvec_fcmla[hsd]
Date: Tue, 28 Jan 2025 17:38:48 -0800
Message-ID: <20250129013857.135256-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/vec_helper.c    | 66 ++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 715760a17b..3748f7d145 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6175,7 +6175,7 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                       a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
-                      a->rot, fn[a->esz]);
+                      a->rot | (s->fpcr_ah << 2), fn[a->esz]);
     return true;
 }
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5c1e84bf27..76637d072d 100644
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
2.43.0


