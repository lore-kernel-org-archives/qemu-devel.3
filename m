Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFB0C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYV7-0006f3-6Z; Mon, 27 Jan 2025 18:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUr-0006S9-TF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:25 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUp-0005eh-EA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:25 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso6914026a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020382; x=1738625182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdGVKX0T2Z/m16C6XyQIYLgpEZaPtHKKAWekkwATeW8=;
 b=vprVtK6eTGgUDuzNwbyzQ9FkfVZ7UkjxjBougCGaXhsA3W7S0ZBadbwhrlbqYcC4HQ
 G2wnX8psAqgBgxDW/9C5nMG/hRroAKJ5AnWUCgC5pL+aYgMUFbi+NZLn/enIlfeVTWo7
 eRiXN/CR/FfBSefSP4lJRN5AzBGOOTeVKpctPBg5VZY0w42btDrWICBZt/vhVgBUJBDk
 KWwOqyG1O0y0CmjsxfQ2jx0sfCjYv7VgcMXkdWrJiRXDPutdeGz0KaxOMoZgr1cObdQS
 oxUQ+bws3mTlCBl48uGUH61Fdtf+yNQtNWhZvUKktfrYVKko0rZ0R12CQGGegWDfvAnM
 LAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020382; x=1738625182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdGVKX0T2Z/m16C6XyQIYLgpEZaPtHKKAWekkwATeW8=;
 b=jdvCal4kDvDtRoQCyfyj0ZboyWh3WsRHwbK9+jrBj5be3QOzMdL7symwXSwHw8YkMe
 YqOBCH0MDcu5L85DsTOahprYLlsE+jhyy0Tlg7r1iC1bzRxJ3NNCdwNIdTPOEfvRE7f8
 ihzGmF+FYS7S+c76Z2S232JYiC+ugwQIqxCviJmtdNc5lbkRsfcQZNKgu+Qa+eazz+sc
 4UcwsJicJG74rVbOXuvyJdkz+iE/Z4AtJtnMHBXOJJFGkjak33k04rz8UyZBzfTTKFAs
 KLlWvpfVL9W0JXtUupFtUriumLHbJeke6APFrYBfonO4KUJF9qfaerK+PWTugpbSVDAu
 341A==
X-Gm-Message-State: AOJu0Ywk400B5y5mzz+9rX5FgqBgpatIRN3ifYPGcBRiggMQ8a/SJqhd
 VdN4ieEUBd4yQo1bL9W9/n1EU8YQ77PvUtyNpcLtwy2tFBiBq+OS3UvdWuBwaUXyKZtrXlYwEyD
 Q
X-Gm-Gg: ASbGncsUVa1FMFVEHGczyUpybjjGBxpV/wnLwepxQS6vmH/ypmBPJZRYpiGg1lFgFn/
 m6WS/Vz3lFdmkNmcyENam6HVo/BT1QEq/IV7nVDLMTatGE68oHfoFKcVTJIq2pB7GH4MeF+SPoI
 HLsn/R8QOz9VKwEgS0uBtsumQhFMY8xGD9GQ/ORZWmb0mfok7wHVYXkjpKP9Jhy6NcX295gq3CK
 J+RL3Zt9iwi3mvhp55O4BKZ6SeSEfwGj5j7zPWzSPnsvT8y1EHfPqHtClrXXnkL2Bu7MuvwEoxd
 VUzlFi/AHHXPBqJ8ebfYM2+5lTz7/HYxjCUf4Y4=
X-Google-Smtp-Source: AGHT+IGk2if0cTzmhZskRUhi/N19rW7crpi0L+qmyN+Uq2fNCoW61klCjtK1IVnLSPNY/brFj63Dww==
X-Received: by 2002:a17:90b:4b8c:b0:2f4:9e8b:6aad with SMTP id
 98e67ed59e1d1-2f782b11be1mr74792758a91.0.1738020382112; 
 Mon, 27 Jan 2025 15:26:22 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 21/22] target/arm: Use float*_maybe_ah_chs in sve_ftmad_*
Date: Mon, 27 Jan 2025 15:26:03 -0800
Message-ID: <20250127232604.20386-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

The construction of neg_imag and neg_real were done to make it easy
to apply both in parallel with two simple logical operations.  This
changed with FPCR.AH, which is more complex than that.

Note that there was a naming issue with neg_imag and neg_real.
They were named backward, with neg_imag being non-zero for rot=1,
and vice versa.  This was combined with reversed usage within the
loop, so that the negation in the end turned out correct.

Using the rot variable introduced with fpcr_ah, it's easier to
match the pseudocode for the instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 970947e1ca..6a5bfa0e59 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5220,8 +5220,6 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
     uint64_t *g = vg;
     bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    float16 neg_imag = float16_set_sign(0, rot);
-    float16 neg_real = float16_chs(neg_imag);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5237,11 +5235,10 @@ void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
             e2 = *(float16 *)(vn + H1_2(j));
             e3 = *(float16 *)(vm + H1_2(i));
 
-            if (neg_real && !(fpcr_ah && float16_is_any_nan(e1))) {
-                e1 ^= neg_real;
-            }
-            if (neg_imag && !(fpcr_ah && float16_is_any_nan(e3))) {
-                e3 ^= neg_imag;
+            if (rot) {
+                e3 = float16_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float16_maybe_ah_chs(e1, fpcr_ah);
             }
 
             if (likely((pg >> (i & 63)) & 1)) {
@@ -5261,8 +5258,6 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
     uint64_t *g = vg;
     bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    float32 neg_imag = float32_set_sign(0, rot);
-    float32 neg_real = float32_chs(neg_imag);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5278,11 +5273,10 @@ void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
             e2 = *(float32 *)(vn + H1_2(j));
             e3 = *(float32 *)(vm + H1_2(i));
 
-            if (neg_real && !(fpcr_ah && float32_is_any_nan(e1))) {
-                e1 ^= neg_real;
-            }
-            if (neg_imag && !(fpcr_ah && float32_is_any_nan(e3))) {
-                e3 ^= neg_imag;
+            if (rot) {
+                e3 = float32_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float32_maybe_ah_chs(e1, fpcr_ah);
             }
 
             if (likely((pg >> (i & 63)) & 1)) {
@@ -5302,8 +5296,6 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
     uint64_t *g = vg;
     bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
-    float64 neg_imag = float64_set_sign(0, rot);
-    float64 neg_real = float64_chs(neg_imag);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5319,11 +5311,10 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
             e2 = *(float64 *)(vn + H1_2(j));
             e3 = *(float64 *)(vm + H1_2(i));
 
-            if (neg_real && !(fpcr_ah && float64_is_any_nan(e1))) {
-                e1 ^= neg_real;
-            }
-            if (neg_imag && !(fpcr_ah && float64_is_any_nan(e3))) {
-                e3 ^= neg_imag;
+            if (rot) {
+                e3 = float64_maybe_ah_chs(e3, fpcr_ah);
+            } else {
+                e1 = float64_maybe_ah_chs(e1, fpcr_ah);
             }
 
             if (likely((pg >> (i & 63)) & 1)) {
-- 
2.43.0


