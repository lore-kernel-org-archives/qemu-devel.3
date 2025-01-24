Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A7EC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMfp-00050j-JW; Fri, 24 Jan 2025 11:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZA-0005pV-Op
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:02 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ8-0005m4-4s
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:56 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436202dd730so16572715e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736192; x=1738340992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6dgTVvVr0GNtxqpPbcNERedzCSbz846MhmUGqEskeJE=;
 b=qGQCzzN6S8q9GVDFW/IUoO5RBfyz3yGFfmag+CFksup4UHYlCJV7hjdLZv0rFGbxzG
 C7m6Ggdp4uVwuiXE1HwKmnlSLlZRL5PuvLeUwKFA0C1pHumCheKj8yvoV4rqOspqsLUI
 h/ON2pwADJGzfGVUtW51PXqhNFiYGbLrdrzZ/D2a0J4Mgk5J4g/reteWWl5hN8Ue8c8q
 krXK06jl37ObdiPgClDRXJjoi1XPiAdBDxIB1+DYumNtNeVk+qnzyup6Fi08g/5Qnx23
 lWgyEiYmGDn+vXT8VtnAlD2mzadKLI3fOfrmzkYlbxIi8ad1b6+9pf4vfU2dSYt9SNh4
 2xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736192; x=1738340992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dgTVvVr0GNtxqpPbcNERedzCSbz846MhmUGqEskeJE=;
 b=kH8EsN6j2cOWS3KnbOLUakbhoRhCEetYWqm3TaDapnJRJC5mojtiU6qot+0919Ab0L
 mXhTnosVurm82CCiIixp2BVGwLmlS++rymj1pIaBEnK48xAlSJGhxGTXf0dyTbrgNR8o
 GpsnXYcbl8vwr6bFyRlFZtpBND5mmp5r8Brav5O0WwPnzE+EZpkWS4NpPffcDCloBLOS
 uxGaL56nVBYp0YKPoMATgb77hLuuWOvy5jCE3aB2CWsaMJ9dKEiQ+nxFr3weFFa4mBwv
 cKAhwR5/oaQ1pj5/PObOslrxnqZ01m5CquamXwSVvKzweBDL+3D9ikTIKRREMjm4fYV/
 iUFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVvpcdjsRpxZmCn/7yKNEPHUek1GDTEwRjmaDd616lmzNwGwkkSa+nMDOqnc8uAJ1PUNqZQyee0f4i@nongnu.org
X-Gm-Message-State: AOJu0Ywow7lvywFxGdQgYhlgkhaFcZE0MDIkkw7Gg5ZTl/tmXpeOv1c5
 H8a4mRxV5d7AY3aaOVIuyF/oYhjdg3EbsMRGC3PnQI4o8y/PWEEK4gY2JFvLLr4=
X-Gm-Gg: ASbGncv98b3Y1cW9D1KVgFZ2gsu3D61oqfOfbAPj8azoQ1BlSzp+wQbkRiYo5cvFGE0
 SvXAdrIzjaL/JMYE4LtKRWbEN/z3qA4XpLF9KR+gpQf5i+IDX8K+pTtYS0EhwkcOmqZEl4jlB6o
 X76A/7Q6dNolL4veAAUQs+RnJvy9cpvdXkNs+Qt2nThuZx0WB9uqfiNnHP8S47ilz5fykcrpkDz
 RafqqE21FbBX91Xlgb/PF5SJwJzKuIBvpW3xPsPoDQd1C61XhH2QC2OgHMqr/swQ8NHJip55hvt
 i+3M3q6tEvo=
X-Google-Smtp-Source: AGHT+IEq5z9GGePQaxWLm9+T8IVFFtzlpvFhkEcw2jGdFUDflEMsuuWr1WqcgpQaBO12xnbiCh/Hrw==
X-Received: by 2002:a05:600c:3c94:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-43891439f04mr240114165e9.21.1737736192085; 
 Fri, 24 Jan 2025 08:29:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 59/76] target/arm: Handle FPCR.AH in negation steps in SVE
 FCADD
Date: Fri, 24 Jan 2025 16:28:19 +0000
Message-Id: <20250124162836.2332150-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
sign of a NaN" semantics.  Implement this in the same way we did for
the base ASIMD FCADD, by encoding FPCR.AH into the SIMD data field
passed to the helper and using that to decide whether to negate the
values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c    | 45 +++++++++++++++++++++++++++-------
 target/arm/tcg/translate-sve.c |  2 +-
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 8527a7495a6..dc5a35b46ef 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5131,7 +5131,9 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
-    float16 neg_imag = float16_set_sign(0, simd_data(desc));
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    float16 neg_imag = float16_set_sign(0, rot);
     float16 neg_real = float16_chs(neg_imag);
 
     do {
@@ -5144,9 +5146,16 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
             i -= 2 * sizeof(float16);
 
             e0 = *(float16 *)(vn + H1_2(i));
-            e1 = *(float16 *)(vm + H1_2(j)) ^ neg_real;
+            e1 = *(float16 *)(vm + H1_2(j));
             e2 = *(float16 *)(vn + H1_2(j));
-            e3 = *(float16 *)(vm + H1_2(i)) ^ neg_imag;
+            e3 = *(float16 *)(vm + H1_2(i));
+
+            if (neg_real && !(fpcr_ah && float16_is_any_nan(e1))) {
+                e1 ^= neg_real;
+            }
+            if (neg_imag && !(fpcr_ah && float16_is_any_nan(e3))) {
+                e3 ^= neg_imag;
+            }
 
             if (likely((pg >> (i & 63)) & 1)) {
                 *(float16 *)(vd + H1_2(i)) = float16_add(e0, e1, s);
@@ -5163,7 +5172,9 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
-    float32 neg_imag = float32_set_sign(0, simd_data(desc));
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    float32 neg_imag = float32_set_sign(0, rot);
     float32 neg_real = float32_chs(neg_imag);
 
     do {
@@ -5176,9 +5187,16 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
             i -= 2 * sizeof(float32);
 
             e0 = *(float32 *)(vn + H1_2(i));
-            e1 = *(float32 *)(vm + H1_2(j)) ^ neg_real;
+            e1 = *(float32 *)(vm + H1_2(j));
             e2 = *(float32 *)(vn + H1_2(j));
-            e3 = *(float32 *)(vm + H1_2(i)) ^ neg_imag;
+            e3 = *(float32 *)(vm + H1_2(i));
+
+            if (neg_real && !(fpcr_ah && float32_is_any_nan(e1))) {
+                e1 ^= neg_real;
+            }
+            if (neg_imag && !(fpcr_ah && float32_is_any_nan(e3))) {
+                e3 ^= neg_imag;
+            }
 
             if (likely((pg >> (i & 63)) & 1)) {
                 *(float32 *)(vd + H1_2(i)) = float32_add(e0, e1, s);
@@ -5195,7 +5213,9 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
 {
     intptr_t j, i = simd_oprsz(desc);
     uint64_t *g = vg;
-    float64 neg_imag = float64_set_sign(0, simd_data(desc));
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    float64 neg_imag = float64_set_sign(0, rot);
     float64 neg_real = float64_chs(neg_imag);
 
     do {
@@ -5208,9 +5228,16 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
             i -= 2 * sizeof(float64);
 
             e0 = *(float64 *)(vn + H1_2(i));
-            e1 = *(float64 *)(vm + H1_2(j)) ^ neg_real;
+            e1 = *(float64 *)(vm + H1_2(j));
             e2 = *(float64 *)(vn + H1_2(j));
-            e3 = *(float64 *)(vm + H1_2(i)) ^ neg_imag;
+            e3 = *(float64 *)(vm + H1_2(i));
+
+            if (neg_real && !(fpcr_ah && float64_is_any_nan(e1))) {
+                e1 ^= neg_real;
+            }
+            if (neg_imag && !(fpcr_ah && float64_is_any_nan(e3))) {
+                e3 ^= neg_imag;
+            }
 
             if (likely((pg >> (i & 63)) & 1)) {
                 *(float64 *)(vd + H1_2(i)) = float64_add(e0, e1, s);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9200f7f8a49..0696192148c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3916,7 +3916,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
     gen_helper_sve_fcadd_s, gen_helper_sve_fcadd_d,
 };
 TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
-           a->rd, a->rn, a->rm, a->pg, a->rot,
+           a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
            a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 #define DO_FMLA(NAME, name) \
-- 
2.34.1


