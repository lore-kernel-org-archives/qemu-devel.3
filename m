Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24986E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDm-0008QL-Dh; Tue, 24 Dec 2024 15:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDV-0006uA-Gb
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:21 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDT-0002yF-I8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:21 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2161eb94cceso39855885ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070958; x=1735675758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNZINX2but2Pfb8ZOCVoSmAmmZqPR58yrma436JYpx8=;
 b=KwSRT+KcH7MgyHOtDyq5XmPTzoqcNKuvSAi7VuB/OwOW+Fmk94CwgyOddiCGKFDXbh
 JUsQaPT3aL64sKAvplEBtMeCc94UriLAxNDD74dYmLy7hRtxNFh/triM12/7l42Gg9Y9
 2dU9jb8s8Ce84DmmwvbxD/GFDRJpletHZWukKPIWvGtyJBTY/OfK+pwiqyeu4Qibzpsj
 p+m/yOPppOrQVWLigq/V70qTZOJy/FCs9dRGe19JvDM2w0owkfgCBYLTMJYC01pAT/yg
 gC9qpVIm8d4cMYlLTu3pl2y0J53I+2ySj1kAH8apr3fOL61cFlxVCNgoT0nqF6M8UteQ
 AgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070958; x=1735675758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNZINX2but2Pfb8ZOCVoSmAmmZqPR58yrma436JYpx8=;
 b=LFODBmFeAqj178tIPQ6C3VxJbL+gJgetL111SzoB2PEXlAlpy00TGV9lDpe3rkQjlG
 A1tGpPnYR4zRtkIQNO/ocZZ4lmwVeRe3jebk5GmXBWjRzbjhDb/K22SIn1Xx8+ekVezf
 9OaZ2rGsOpeeE37/JF+AHYff2gJPBFU5q3D4U9g4CTsHZBjNLe7/C3M33MrlZ2tgOkgO
 SwUjU8OxZjgLaaclp+t6riXYzTy1Bz2OB8x3X8sexatqE7X1Xnd4xYoZzYT5k+9DcN21
 co6dvXL87fDS+0ZPm5hDtAvzoJGT4kSChrBhlDJXd164OyF0dvPtXgWMI+5HKnc/uvDf
 eIEQ==
X-Gm-Message-State: AOJu0YwerBEHdhFyuTeDk5hMvaiTWiw4Mbe6hmRjgJvRNrfGlbGhWQCY
 217DNy4gZvZA7FEKbW5tA0/WhRZfuBhNnisiPILoNw6wHFENmAKuyD8NRmDA39fd3c3+NDGWbG8
 9nU8=
X-Gm-Gg: ASbGncsdSPNX4GPPJLyBBPWhQZZ4tf/gxMbzKwfzF0Uzkft15vBw1NKM8CQRERruQi8
 C6qAvy6b/xK/PRq9O2X3rx8XoXSa/bYfYG+CtbeMiWfRPITVbjGGyBtJX8EZqCZFvskAgIVDAvv
 KpAaTh606MxFmleMrjsGxNKmV2gZfSGevJ3SdzBcz6c4Gnv5QMvZb5P+tu1Zx6PQ8W5aqwCKVq/
 Qfrtp4ChnSt7WAQzWZSPM3DBhXqQh1OU4KjcL0/1n6x3+oSHQ/t7MZ20/FqNBGEjjexlAzjmR/+
 Tp5QWbGQHbXz2qusTN+YW8q3Sw==
X-Google-Smtp-Source: AGHT+IErbrhKU+oKKAvSzwkU3ymecNmd8zL3Z0AHMYDqwlEbcFobWis3YorU2v7AoW1i6Od1alwFzw==
X-Received: by 2002:a05:6a00:2449:b0:728:e906:e45a with SMTP id
 d2e1a72fcca58-72abdecdbfdmr28215787b3a.24.1735070957893; 
 Tue, 24 Dec 2024 12:09:17 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 58/72] softfloat: Remove float_muladd_halve_result
Date: Tue, 24 Dec 2024 12:05:07 -0800
Message-ID: <20241224200521.310066-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

All uses have been convered to float*_muladd_scalbn.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h   | 3 ---
 fpu/softfloat.c           | 6 ------
 fpu/softfloat-parts.c.inc | 4 ----
 3 files changed, 13 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index c34ce0477d..aa69aecfb0 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -120,14 +120,11 @@ bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status);
 | Using these differs from negating an input or output before calling
 | the muladd function in that this means that a NaN doesn't have its
 | sign bit inverted before it is propagated.
-| We also support halving the result before rounding, as a special
-| case to support the ARM fused-sqrt-step instruction FRSQRTS.
 *----------------------------------------------------------------------------*/
 enum {
     float_muladd_negate_c = 1,
     float_muladd_negate_product = 2,
     float_muladd_negate_result = 4,
-    float_muladd_halve_result = 8,
 };
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b5936cc0f8..6967fb5c9f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2274,9 +2274,6 @@ float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
     if (unlikely(!can_use_fpu(s))) {
         goto soft;
     }
-    if (unlikely(flags & float_muladd_halve_result)) {
-        goto soft;
-    }
 
     float32_input_flush3(&ua.s, &ub.s, &uc.s, s);
     if (unlikely(!f32_is_zon3(ua, ub, uc))) {
@@ -2345,9 +2342,6 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
     if (unlikely(!can_use_fpu(s))) {
         goto soft;
     }
-    if (unlikely(flags & float_muladd_halve_result)) {
-        goto soft;
-    }
 
     float64_input_flush3(&ua.s, &ub.s, &uc.s, s);
     if (unlikely(!f64_is_zon3(ua, ub, uc))) {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 4a62d6ca24..a724f317c5 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -653,10 +653,6 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     a->exp = p_widen.exp;
 
  return_normal:
-    /* TODO: Replace all use of float_muladd_halve_result with scale. */
-    if (flags & float_muladd_halve_result) {
-        a->exp -= 1;
-    }
     a->exp += scale;
  finish_sign:
     if (flags & float_muladd_negate_result) {
-- 
2.43.0


