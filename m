Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4737C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx34-0000wx-L5; Tue, 28 Jan 2025 20:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx31-0000v6-Cy
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:19 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2z-0003Zh-Lo
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216634dd574so76330945ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114756; x=1738719556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFnszkZ9p4ia79OPiqkJPkH/8uYSac2Q2Jigs8rdmpc=;
 b=ujgm1yraqSlTaLQly6iWJN/aceCg64ACHBHjwdS8WZB9E7l1APWLwkZKqf0NHItWYQ
 WyOdgLSsRbombH2DXbNwo5FOKTAxotcSziVOJxaV4mjwVqfGArcuSciJoT45fXkm3zev
 M7ReIpkorQJ7euuqom+xgeQphWYJpqMi138RKV4wdq9eZfq5zq3GbBTLI5EAdVpyYWov
 rdtS/aKX6IAOIO4Ou6zsh0jIMUSWxQtG5my/bsC0OGwy+l+CsnSd9MvKZjA1ANBaI70c
 l6sQTJptbrt5Rekl8mGnUJgtCj8dWMMAZlBMYGDD9xWRQr5Lu72XDnMylmCd51ixbACm
 yT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114756; x=1738719556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFnszkZ9p4ia79OPiqkJPkH/8uYSac2Q2Jigs8rdmpc=;
 b=P7nBYwr24ahP7oyoNH26lQ5m4995RAqUDrdE/S7x0p72hbtkG1QWe9GewQldUfdfh3
 UqU9r5tpWHpYhD8lcyzvJ7/W7XqymlbQQXo1i17g8SbF7oJQsJKRS6G3mbOcogEVwoih
 HXJsOlSeir2ZbylaypMd1Cw1Ayx3iqxbB/QiyQ/dy6YpKo7Le127+npQkWwBYQQ0gZJg
 HBuzec1J2WPWnzK078JUdCIVu2HrsHr5S+T5KSd45Or9+6rHuR9R+OVYWomll2vSyvXQ
 jkdnkIoq0Z8a+dAaeM2DSCKoaQNjbXTqK2r2bnD7zNoTsoSNPa38ukQhwC5Xqc5CF/Vb
 aaZQ==
X-Gm-Message-State: AOJu0YxmfgbirluEeVD5Gp0ds01Rwht1FQnInaCfvCx46oPW9THWjK39
 g+aA8nBmizshRql4UlnBHTpRJq57z91AhzA/P0kew3rytOWKK4PbIy5eFLAW9QYPfRXp7m69N7/
 g
X-Gm-Gg: ASbGncslThD58sIR16y7BTwGpW6PzLBizam9Uc1pgko0xg66fLvv1w7yhQ1ZDUAje2c
 MgPUr1hgWAh8CR0pyyGF2TxT6JF2GFZLxkY99mXt2uwj22ebn1udayzClR9UG9jVqor3VC+aiGX
 1oY/nYnG4hBhF7xZXi3Sf1dfCFUTVNUZV8J3ccbeLjWc+ItsbM5kB/g0wC3wAbu4F/wXtSZeh98
 qArs/nGdbTqBK7awqEfJCXhPrVSb59loXYlLe9unWA/XBjAeq1hLUkHOhDO5aXjYWzhF6e/EjVe
 pktbP1B8HDwRaQ+3Q6gEPbS/Q2Pqar3LoOKqcpOiQn449Fmtcg==
X-Google-Smtp-Source: AGHT+IFrq30tedMev+HHnbqm9y/JvgOzNlDMXRTMKvyxXVvLgKLBLXVxUCRZL54qVealnUpcBD/e9Q==
X-Received: by 2002:a17:902:ef45:b0:215:ba2b:cd51 with SMTP id
 d9443c01a7336-21dd7d64d98mr20362425ad.15.1738114756384; 
 Tue, 28 Jan 2025 17:39:16 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 26/34] target/arm: Handle FPCR.AH in gvec_fcmla[hs]_idx
Date: Tue, 28 Jan 2025 17:38:49 -0800
Message-ID: <20250129013857.135256-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/arm/tcg/vec_helper.c    | 44 ++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3748f7d145..9e751e737a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6922,7 +6922,7 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
-                          (a->idx << 2) | a->rot, fn);
+                          (s->fpcr_ah << 4) | (a->idx << 2) | a->rot, fn);
     }
     return true;
 }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 76637d072d..964000773a 100644
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
2.43.0


