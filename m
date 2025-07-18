Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F557C83F3B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucp8T-0008Kl-9Q; Fri, 18 Jul 2025 13:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov5-00056U-Q4
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov2-0000t7-UR
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso12123115e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859846; x=1753464646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjBlcjoHjKFWMnPECWtFEiFouTdLLlV7xjpvri9h4/Q=;
 b=xEvMwmHGGc3NCIjoVLDoqx9Wz9BnwMRsTbxrz7HnHgFsju8b70eXj0DULN8H4x9PV+
 SjtYlffIac2JePO/0eD9DXz1+Ok6cWER2OTUAIP7J4e8BGdGuaIdilFH6GqL38zxdAHX
 WneM4cHi0kJecdhUnBwNWLQ3zF1FzzEA1+/8W2DX1xBL4H1d4OVyCq4d9O3WTRIvPrW7
 6KfH226flC4oiyq2vgux1uW+iIGTeGn1XkKzFTsKo2bbO7FsXviwye2yQCX4nu6uOEOD
 c3KQaCfbfG/CIsmg/WDb5I95D/9BgdkKrq2c4DgRRFAD2Ye1zqfrAKJJK5mFlAS5jXht
 xSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859846; x=1753464646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjBlcjoHjKFWMnPECWtFEiFouTdLLlV7xjpvri9h4/Q=;
 b=Z0icxzQEcK1EpXGx5Egq4wrbl8OOj9kDMHVcov2JIQ2fT00V20IjuYnq+YlVpR/RdJ
 7lugmWMoqizcv0n5atqqOykMAw+pf2Z9Qa+kRxEQ+QvxzR3d7gZFJ4p8054qlKa5YQDL
 14cq5KEyil8YbJvs+uG8mg7NbBPE0pOH1DdG+43pN6rFIdvdV/EKD6TFMLpu60pkSkfr
 dd4E3CFViA9UNspp3dzEstomoyjBqCJPDzFqoQrFDArfiyfuHfoTjwtE3W6cSR5Kk1ch
 4qTwt8RBAifK0CzrAXg2Bebyo8zJSmizliuNfx2IGxX010v1fPNyZrqMv1dVz3QArAwt
 iuJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdv8+NPDWGqwjWjX944jL0U4AAwVbOsPR6rkrIONhWt3q3RFTF8LODfWL1BVNB/y43JUPfsUoUWoUy@nongnu.org
X-Gm-Message-State: AOJu0YyQ05Ug/H7nJ2eoDn13tPReH0OY/Lfr19OHBsi8GT+C2sX+/R+f
 0Ejxczwnf4zOchUnFP2voSexnWGv65x+bDm4zEMblTskFWToytenPCPszXkLMdZLzgfImJ4AoYZ
 YBfUW
X-Gm-Gg: ASbGncvuNQjBq6vphAWsnKzNJWScrbUOnQc4AzYsCE2ikSVq2K/GUE6YGaC1X5Yjwjp
 WAu6wF9ruiUfhabT3O3cJFrM2VMNpdxm+df1Wni75hnmHTMJQi6G2X163JzBvhK5Zb2rUwnrV7t
 Sl4hTMW8ANvb4Re3FBxDqWqvd9v4U3SATr5IKvAmqZ0+mWiLrJtLqq9YUgQK+/9Yz+hSU/gDNKN
 xFfiFXLRt0rYbnBUtqdrfF09jgKiXc0eEDhGYhexxoCG9Eims5ywdP4k9WMfX6x3j6OoC85lA7B
 e1X8vnw3KhFb878G6Fe7zEFhJR0Zfloi1/BCrl7y0wARwQ7fr+bBI9h2xLuxKk3wk/GJ6cG6vN2
 NZmbeZQZdLfwYRQYWOM4YATVLO77n
X-Google-Smtp-Source: AGHT+IEM5IeVlpaYzMT8E/ZRNsxxJNfeKd9LAHdFMwPc4k1ufXXEoTxH9UlEfVfAQqxyhnASfTLs+g==
X-Received: by 2002:a05:600c:6207:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-456352e7865mr75082205e9.8.1752859846147; 
 Fri, 18 Jul 2025 10:30:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 09/10] target/arm: Honour FPCR.AH=1 default NaN value
 in FMAXNMQV, FMINNMQV
Date: Fri, 18 Jul 2025 18:30:31 +0100
Message-ID: <20250718173032.2498900-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718173032.2498900-1-peter.maydell@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The FMAXNMQV and FMINNMQV insns use the default NaN as their identity
value for inactive source vector elements. We open-coded this in
sve_helper.c, hoping to avoid a function call. However, this fails
to account for FPCR.AH=1 changing the default NaN value to set the
sign bit. Use a call to floatN_default_nan() to obtain this value.

Fixes: 1de7ecfc12d05 ("target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bf894f0bf13..803f0a094dc 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4484,33 +4484,35 @@ static TYPE FUNC##_reduce(TYPE *data, float_status *status, uintptr_t n) \
     }                                                                 \
 }                                                                     \
 uint64_t helper_sve_##NAME##v_##SUF(void *vn, void *vg,               \
-                                    float_status *s, uint32_t desc)   \
+                                    float_status *status, uint32_t desc) \
 {                                                                     \
     uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_data(desc);   \
     TYPE data[sizeof(ARMVectorReg) / sizeof(TYPE)];                   \
+    TYPE ident = IDENT;                                               \
     for (i = 0; i < oprsz; ) {                                        \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
         do {                                                          \
             TYPE nn = *(TYPE *)(vn + H(i));                           \
-            *(TYPE *)((void *)data + i) = (pg & 1 ? nn : IDENT);      \
+            *(TYPE *)((void *)data + i) = (pg & 1 ? nn : ident);      \
             i += sizeof(TYPE), pg >>= sizeof(TYPE);                   \
         } while (i & 15);                                             \
     }                                                                 \
     for (; i < maxsz; i += sizeof(TYPE)) {                            \
-        *(TYPE *)((void *)data + i) = IDENT;                          \
+        *(TYPE *)((void *)data + i) = ident;                          \
     }                                                                 \
-    return FUNC##_reduce(data, s, maxsz / sizeof(TYPE));              \
+    return FUNC##_reduce(data, status, maxsz / sizeof(TYPE));         \
 }                                                                     \
 void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
                                     float_status *status, uint32_t desc) \
 {                                                                     \
     unsigned oprsz = simd_oprsz(desc), segments = oprsz / 16;         \
+    TYPE ident = IDENT;                                               \
     for (unsigned e = 0; e < 16; e += sizeof(TYPE)) {                 \
         TYPE data[ARM_MAX_VQ];                                        \
         for (unsigned s = 0; s < segments; s++) {                     \
             uint16_t pg = *(uint16_t *)(vg + H1_2(s * 2));            \
             TYPE nn = *(TYPE *)(vn + (s * 16 + H(e)));                \
-            data[s] = (pg >> e) & 1 ? nn : IDENT;                     \
+            data[s] = (pg >> e) & 1 ? nn : ident;                     \
         }                                                             \
         *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
     }                                                                 \
@@ -4521,14 +4523,17 @@ DO_REDUCE(fadd,h, float16, H1_2, float16_add, float16_zero)
 DO_REDUCE(fadd,s, float32, H1_4, float32_add, float32_zero)
 DO_REDUCE(fadd,d, float64, H1_8, float64_add, float64_zero)
 
-/* Identity is floatN_default_nan, without the function call.  */
-DO_REDUCE(fminnm,h, float16, H1_2, float16_minnum, 0x7E00)
-DO_REDUCE(fminnm,s, float32, H1_4, float32_minnum, 0x7FC00000)
-DO_REDUCE(fminnm,d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
+/*
+ * We can't avoid the function call for the default NaN value, because
+ * it changes when FPCR.AH is set.
+ */
+DO_REDUCE(fminnm,h, float16, H1_2, float16_minnum, float16_default_nan(status))
+DO_REDUCE(fminnm,s, float32, H1_4, float32_minnum, float32_default_nan(status))
+DO_REDUCE(fminnm,d, float64, H1_8, float64_minnum, float64_default_nan(status))
 
-DO_REDUCE(fmaxnm,h, float16, H1_2, float16_maxnum, 0x7E00)
-DO_REDUCE(fmaxnm,s, float32, H1_4, float32_maxnum, 0x7FC00000)
-DO_REDUCE(fmaxnm,d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fmaxnm,h, float16, H1_2, float16_maxnum, float16_default_nan(status))
+DO_REDUCE(fmaxnm,s, float32, H1_4, float32_maxnum, float32_default_nan(status))
+DO_REDUCE(fmaxnm,d, float64, H1_8, float64_maxnum, float64_default_nan(status))
 
 DO_REDUCE(fmin,h, float16, H1_2, float16_min, float16_infinity)
 DO_REDUCE(fmin,s, float32, H1_4, float32_min, float32_infinity)
-- 
2.43.0


