Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72463FF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzj9-00074v-SU; Sun, 26 Apr 2026 09:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzio-0006u7-Hf
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzim-0008Kx-B8
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso58382585ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210827; x=1777815627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pFIOX/z0+aGze4rLka9drPNkmHdGrfhz/CpEbxvoxw=;
 b=NCV3ODXJo0xM5MnNXxBhLXkMWAjjiXZOaPCd7RvQ6RJc4pDyLj5IkDSs9meCriZ+e8
 qJhPoQW9VD47kgn2AtULqAHn/sqUQ19vznUKSY8E/5ZPYbzmkEvXWmKRTzbl2Jkkz0f7
 aqwjFDrXypy9mCcEUTE7VLcnrpujkZC0/UT+JuW1OreG2Z374wu3ZCMojAMtuJkexpa4
 6GxaKTls2/aapjK8DL6QBULbKpGlxA+Jcff7rLN7Ukg5aKVbCKtTDIr8YzhvtEuvqf/T
 rk1F7rTSDqci57/Ysga48E2iP/n4b97UwCCsDrXeEp+wuefer5FOSA0PcmJV9+r689C5
 TwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210827; x=1777815627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5pFIOX/z0+aGze4rLka9drPNkmHdGrfhz/CpEbxvoxw=;
 b=Jefh5H4O+T0teQjd+h8TFRIpD3A1R794PLVHXD6GCc5zKrpYTP+3n7Ak12XE7mgxEj
 iCqv/fiIsePCtwMhMhSq4XQZIujkMHHX5xcQyyEyAn5flQC7B/RkWGsHX4xnLaz1rgci
 32VB2qVIG/ipbhAVV39XgM6C2+6qRsJ0nBmKzBq727PMpIKRq1AEk5As82n9mWaqV3p2
 bxxvF0iMsV6lRqQn8TErZNynAlWhl9sP085Mq2bj3Wp7pEWnximqzpS3dqelQXo3wJd8
 dKo8zL4VIlSVQUVPLs62bUUmjl5Dpy4Yeg8n/0JpLcYl+BmVJbjCaNNkHu4rik/Zw2e3
 yW3g==
X-Gm-Message-State: AOJu0Yx1x1cyPBeRH/0up4318cO6Y2Xt7HRr54eySqH3q311Vqqzuyju
 WScZKfDSGCLcCpmo14XwpQm4U7+W0tRMQbfnj7zXBU/L1ZPgFs3D3SDmCXLJ31ABKITusJqKqLN
 yCHQqokY=
X-Gm-Gg: AeBDietcMPILek1VTWYkyUHfAeWWuD+LyHp7d+/qraoLwX+oYlr/KVJ0EG+gUXJj1LN
 Fysn9XYvGuCRjKJ7ZgbLDE0XbNBQUrrolFcwdwHwxcbuK3E+KYt5/6N0fbLjwX6s83ln3o4BwRE
 CfSq4U6E/EC7Tq/ND/3PpEOtI297WyQoNGjmXi+3sERisup8bOoBCmmjV1mJoZ5IzYU+kTjeHfA
 yUKVWRAkLacmbsscesMt1623tO6I01sXJJr6E+YK+1J0buWuj5dlFsEswieqb83KM8plvBWhair
 1E1dM4KDQ1TqexzCNIvPilT+ep45kOlV26XH2szQICRpxza6EE5SEEA2uw7ouFjF0ObsukxKixb
 mP+T09dmRXaRNK5vh2Ujgg7YUtXI8gmamr0XoUZli3iI+zsAbbrC+wdVaUSa9hBcD++iMzClMbN
 +DSEYILiSR+84hky5PJpWIbnFMpwM7mZ5YE2o4K4Gx
X-Received: by 2002:a17:903:b8f:b0:2b2:5857:583e with SMTP id
 d9443c01a7336-2b5f9fc0641mr398974785ad.31.1777210826884; 
 Sun, 26 Apr 2026 06:40:26 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 07/84] fpu: Drop parts_pick_nan
Date: Sun, 26 Apr 2026 23:38:44 +1000
Message-ID: <20260426134002.865628-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Use parts{64,128}_pick_nan at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 11 ++---------
 fpu/softfloat-parts.c.inc | 10 +++++-----
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 50a625fd0a..98ddc00936 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,13 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_pick_nan(FloatParts64 *a, FloatParts64 *b,
-                                      float_status *s);
-static FloatParts128 *parts128_pick_nan(FloatParts128 *a, FloatParts128 *b,
-                                        float_status *s);
-
-#define parts_pick_nan(A, B, S)    PARTS_GENERIC_64_128(pick_nan, A)(A, B, S)
-
 static FloatParts64 *parts64_pick_nan_muladd(FloatParts64 *a, FloatParts64 *b,
                                              FloatParts64 *c, float_status *s,
                                              int ab_mask, int abc_mask);
@@ -5175,7 +5168,7 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    pr = parts_pick_nan(&pa, &pb, status);
+    pr = parts128_pick_nan(&pa, &pb, status);
     return floatx80_round_pack_canonical(pr, status);
 }
 
@@ -5525,7 +5518,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 {
     /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
     if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
-        *r = *parts_pick_nan(a, b, status);
+        *r = *parts64_pick_nan(a, b, status);
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3bde254bfe..1a2eb7852d 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -604,7 +604,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     return b;
 
  p_nan:
-    return parts_pick_nan(a, b, s);
+    return partsN(pick_nan)(a, b, s);
 }
 
 /*
@@ -646,7 +646,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     /* Multiply by 0 or Inf */
@@ -832,7 +832,7 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
@@ -890,7 +890,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     /* Inf % N; N % 0 */
@@ -1592,7 +1592,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
             return is_nan(a->cls) ? b : a;
         }
 
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     if (ab_mask & float_cmask_denormal) {
-- 
2.43.0


