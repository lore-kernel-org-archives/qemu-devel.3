Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EFFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLN-00007f-HM; Wed, 29 Apr 2026 18:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLH-00006U-9C
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLF-0004mo-9E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:14 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d99031e4eso159367a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501512; x=1778106312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZD0khzkwD8RJeG8Qc7wc3fw+bqT32NvxbKgOISP26Y=;
 b=D3/3LOCth4SuM+L+fihAU1ryjAusBzgi6c1vhTS2EOmfDnnDOzDHPGp78+Zg8LaoFP
 jH8OhJ8eC9lEl2av/PqvFuSFblU/6jQNrD61ZaswvYPsO5gHBpgEPJJ+U8Llbe1q7Pfn
 qpyQ0f9MeljIzm/SPYGdXqvxxynZrw6e2zlpu9GTBVn55tobZZMX9sZhOrCz2z87rNgj
 IL3ZIS6qae4YGErVejPGoZPLZ3YzeiDiIDzt+ysOpK3OuC30wglyJm+yeN7kVHmOcvll
 uQrJILNYGEbEkMV6ErUnadIec9UQNo1dm7kYv8tbZm7D0tJUSXWd6vR2zmIdFVw4g/co
 EbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501512; x=1778106312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZD0khzkwD8RJeG8Qc7wc3fw+bqT32NvxbKgOISP26Y=;
 b=UNe86r40E+per+2+rBYEwpkAn5DSPd763X17BQDRczb/zlnhLSaMQnnKB9fmBVwzfv
 tA+isctqf7IY4biij/DHHl1alvZMLQlhQd5feQZdUlRYbzhUvpTIL4dfv/1U66E+T5yQ
 +Y6RfoMm74Iq8WZaBOP0weIpzwIDzNn8WOID5mk/dEHIx+TdFmwDNPGrk1jBOjzjQRsV
 02uR7ZcgAk+NVn9ouMjkcDl+uVUfevPnssegRNbipMLTC6J6t4P20KCHwOWOQsjEMr1b
 dNbeWhQ3mPUE8NzCOpIHtvq7q/FhS4E4WNOmSL9Ak23/oUnvvPfzsijjpIKgMG2fuxH6
 LyKw==
X-Gm-Message-State: AOJu0Yykug8mr1Q8lRU/7lEpsjZepS05r9uyghOR0+19kR1CCylpXfVr
 gZbT6mdSOOwO+R11tBnXmNUA8sGddNum9WD+ytu/1KRYTwbD+lbW17rGl9ObOd2RqikivUMvyRM
 BHHR/i8I=
X-Gm-Gg: AeBDiescAtVFEGfViGK7loTzjpWNJC79Jp4aPCNarxM8XZ0fmgaB51RzbLba31F842N
 VS6HVYD4O6nzNGw5G3BnQGXHxMLnmbeLzFEESV7hyVw0bFJBGGoMB5oBD2CmbYkCAzYYuk+Lrrm
 r4goFR42BKsB3zegq6FeEbr7ybA2GHiONhqbShNyXXjC9wGjHX3FYa4b4LCw/9TprjzMT++MpGG
 Yor0DgyaW4tNz9Y43Nxm5/1W22WWDDwV47KfEBNu5C5ZyhiLiOxpjEC+MB28z/Ja0hy47Dz6N3o
 RMdFzUrvEZPtdWmSj66farhTBH/tPGW+jRK8Q5lCUSYEtHC1zL22pdtVSiv8OFI9ScC4cpxB/Kw
 QUASNUqR9+XvPdlUkSk6o4uNhzAJqFog4I9k/7y5y1cZ+RjID1n/pUdDsWVLHZrzIBbT1UQA6Ea
 Dy1tgiE4WpNxLYB+eetSoSpg/bW/eQnQ0qULlHmD9F
X-Received: by 2002:a17:90a:c10f:b0:35f:b7c1:faad with SMTP id
 98e67ed59e1d1-364c317d9c6mr149994a91.25.1777501511732; 
 Wed, 29 Apr 2026 15:25:11 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/48] fpu: Drop parts_pick_nan_muladd
Date: Thu, 30 Apr 2026 08:24:05 +1000
Message-ID: <20260429222445.26301-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use partsN() at the only call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 12 ------------
 fpu/softfloat-parts.c.inc |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 98ddc00936..e5d8b9573a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,18 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_pick_nan_muladd(FloatParts64 *a, FloatParts64 *b,
-                                             FloatParts64 *c, float_status *s,
-                                             int ab_mask, int abc_mask);
-static FloatParts128 *parts128_pick_nan_muladd(FloatParts128 *a,
-                                               FloatParts128 *b,
-                                               FloatParts128 *c,
-                                               float_status *s,
-                                               int ab_mask, int abc_mask);
-
-#define parts_pick_nan_muladd(A, B, C, S, ABM, ABCM) \
-    PARTS_GENERIC_64_128(pick_nan_muladd, A)(A, B, C, S, ABM, ABCM)
-
 static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
 static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
 static void parts256_add_normal(FloatParts256 *a, FloatParts256 *b);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1a2eb7852d..e1ce2be924 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -696,7 +696,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        return parts_pick_nan_muladd(a, b, c, s, ab_mask, abc_mask);
+        return partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
     }
 
     if (flags & float_muladd_negate_c) {
-- 
2.43.0


