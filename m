Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B6AE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5A-00078k-U1; Sun, 08 Dec 2024 17:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ58-00077t-IC
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:54 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ57-0006Cz-0I
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:54 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f2abc195f3so313842eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698132; x=1734302932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngH9p42c0w/Bs34iA9YcexqT8mFBvJQCf0c5QlB9/w4=;
 b=G1y7BZHMrJaIZ2tIxgufoy5EwG/Yiv3KcNAAj7ZZ0Y1fh9XS91liliVDoj6AHkVC5y
 dVeViPNejValpl76AyqG60JPrRPG48E72qaYEF9vMt4Oen8nb4vKo0kCfylgzMPgfvrv
 d4eqjbizFhCbxtkIW4ULzk0GPpwSCBwfV77LXlRdSaAsjZflFvRGAPJxHq0B9eLUrSYu
 BcGL7tbWIbQ18LRk6UlINT2wC2B96+pAfKa/p93TxFD2mOnPbQKmzFLQ5dbVdyOtHltN
 rtpvTW17k+jHJ4K8Sv/Z1g5FR3rXAyjvB6qFwV41ZsS8z7VOMJN/2LtHIkF7hcxjI8Ni
 ryIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698132; x=1734302932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngH9p42c0w/Bs34iA9YcexqT8mFBvJQCf0c5QlB9/w4=;
 b=fe+RbFsPFvIYipf1IjhvFClVDvdLoj6ofKngHgDHsVeylwCuNapLj1NyLlaOletQR9
 WXu2ee8iSnDcjXe9twS7DMdqvtvaxrATT4aW68lR7Xfclqklg3ANNAH0iHWYaZ919tXp
 LmSqnn2N3NKO0vzxORn8FakczJy82XeAo7Cw8UC+W7VYBTPD0NBFwf1Vdt4AO4pdXDj9
 XN95coeJfZAzPIuLVMBQZ3339wTpMZ3Q/+Wbhod++6gyMXoD7z5xLxQn7X81J20qOqw9
 WnL/kEk25GxuGelbrF2QWpadSh+Sx6kek+dWnrnMraCNGMhK0X55W1qiHjpxhKzZXJWn
 fcsA==
X-Gm-Message-State: AOJu0YyRSsGnnuUobEm0dx8WjLM9CUas+fmMmM/r/RvOrVKvpbvOzbDe
 idFwxaE9r/G0Vxp6C/fs9Qm1aEyURBKEI4Dq3DQR0s7Kh9HCOyfKPvKwuR7NlQMQJ3LFSWHpQxh
 KniH/pw==
X-Gm-Gg: ASbGncsXZpmZGaKOSQ2rjBJAmwOW4DpwglEb8w4UTQ5h0+kLoyfTxl4Wb4NYMX1IGMz
 gT9g4Czo4ci3KaWb/E0EG7JBS6MOit041DANvbb402Ds+NhGXihZuZeT0qh+SueRDdzdlPjLlB5
 ewUzikAcOOGvc+W3nx+aFW7cIzaqH2J8UaIKCvLHyCIXGhfBCmjLpEoLEQcrAqFDvBCrY3OxNCZ
 tol5sK/Alez1tSiX0jVDxRJJG1qFWlwHr6S1fXsHqz9gTl9/ihg+iLAOgFoTjlKnOpBNCedXCx9
 U3N0WmwrXYuPhf2sShpvwmExgEz17b0EkD30
X-Google-Smtp-Source: AGHT+IGFA+vc+Z/biMOGy2363BXcy9M4AAz+Lj6mTuiEyPlF8CiTzZt5aSoASu1Zt04YV1uzci2pSg==
X-Received: by 2002:a05:6820:8109:b0:5ee:bb2:bdc3 with SMTP id
 006d021491bc7-5f286e7caf6mr8275875eaf.2.1733698131796; 
 Sun, 08 Dec 2024 14:48:51 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 04/17] softfloat: Remove float_muladd_halve_result
Date: Sun,  8 Dec 2024 16:48:31 -0600
Message-ID: <20241208224844.570491-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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
index a4174de692..81e7a7524b 100644
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
index 5133358878..5b5969725b 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -567,10 +567,6 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
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


