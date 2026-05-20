Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F145ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZE-0001Zn-4i; Wed, 20 May 2026 13:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYy-0001Ld-Fn
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:33 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYv-0001u4-IB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:31 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3664df30f53so3060373a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297508; x=1779902308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28S4s82CMOTDg2xJmEmm0cDg+zVY5zOgP1NUkaKd36M=;
 b=SvcgxZpw9A9X4wzEYg1KSPjMDz2Hw5SCTvSAKBaPq1sF1RG4sBZ9mb2Y6XRT6lI1UR
 w5DGICL7H5BuDBbgyHGtEIddlJEb8zTGnrpi40+ttDXlEraYGAWU/bzNgt2lZJyA+tjy
 KzfhBqYZ2KVoxApi8O7AGyhx7FmnOBW+WLcZIKmkjMmT+9nYNwkLv263r4OEFPYGxb0t
 pDhti3yTcu1MKlwMyhjR/Sgz7YW1nlMJJQgz3I6gmly1ZUeiGf9MDZVVNMMPEVgXXRFW
 q4ppJLLMkq44f8pGtdF/5Dszu9234RHqhrrvsYXY7YEAVK82sMu2n0QEQ19TflTjHH1B
 kw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297508; x=1779902308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=28S4s82CMOTDg2xJmEmm0cDg+zVY5zOgP1NUkaKd36M=;
 b=UVg8qdhVZMFHBjGu2+Ea0Iva3PUf18zt/F8qCp+d8C9nA5el7QlWmgWg2TLOKdqDlu
 pG7RzLX/S/WKOCmd+lBSQpdr9W+j52MZu1/WkhyZf5s2lTBvMxm8bm7TuRrOQSk7IV7X
 qiiLhHji9vfBxMXcLOwf94rFdw2ul83423XniNITl9ylaKu1iu4q3LuUX77wLMRk8aqV
 6Pa7EOPFvBtvQGZaht/IRNP5OR6gNDo4tUfk5kUxMpCwRSeqMj1hfWpXDif6Gd/kZ0oS
 X/t/kNq28Z1mGFsrd2t/4YoaK9WW7/sb/iy1WfTIO17YJ9ftXMiw2Oom5aGVEjmUT2zs
 s/oA==
X-Gm-Message-State: AOJu0YxO2mMEa85p7li9RGMWKCTfJX0UDysO2yGs3fv/TTd21K/J5reD
 b6KJ6xt0M6fZm3D/iA55Tk2kQcNbi92DbE4zqP8KIcFUPQGbUgsUiX8+pqb/JvjlW/+15/9XFo1
 ONdeQ9Q8=
X-Gm-Gg: Acq92OGXPwqU2g2p3SrcsQPTYvbNqSaxnd+JqTPBk6xW3ewhE1LKAmakgx5jxlRnVE2
 wEcfwI8WLfBqWEK6l9gqJZKOAlw7iHJmfluO82I/XCTvG9uUx5a+APKG8PzXFevnIPseIcTYfG6
 FzZEUrpYTCZrdFdgqN5houe/9Ex5xC4iFYYtjQ6/cizro7SHMKWpj5JFgaWeMYoX9qOcD4bVNSq
 cOCAt6qmi6Ina8zyrg7XG4nKMbzkZic9IK+dEzXR8M2EpENNwRt8wMGyvEaxINpOxJiIV/mBZWx
 nKyKu89ivMs10n/gBQLxplUKCsTJENmZ87Jtbjd+vne7zVtsUeDjoKkq0gkJrk7v2hvRdS3NYU5
 BJdB7SkQJzKFwrxIg6jZM4qbaEKM2YVXvtMn6oGQZl2zedY3oOBX7GM6ScMVqANX1zpb6/CcLVO
 Dyq51bD7I+TNxr4Bi9uSzzRFyt11HX
X-Received: by 2002:a17:90b:1c82:b0:366:4782:1379 with SMTP id
 98e67ed59e1d1-36951c9a00fmr25837305a91.24.1779297507565; 
 Wed, 20 May 2026 10:18:27 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 08/30] fpu: Introduce exp_scalbn
Date: Wed, 20 May 2026 10:17:58 -0700
Message-ID: <20260520171820.848839-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Avoid exponent overflow as well as checking that we don't lose information with
opposing scaling.  Use it in partsN(scalbn) and partsN(round_to_int_normal).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 29 +++++++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc |  5 ++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a762f4b43a..df94f299e1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -461,6 +461,15 @@ typedef struct {
     uint64_t frac_lo;
 } FloatParts256;
 
+/*
+ * Minimum and maximum exponent for scalbn.
+ * These are chosen to be much larger than the true exponent for any input format,
+ * but also not at the bounds of INT32_{MIN,MAX} so that we can perform other
+ * arithmetic on the exponent without overflowing, particularly during uncanon.
+ */
+#define SCALBN_EXP_MAX  0x0fffffff
+#define SCALBN_EXP_MIN  (-SCALBN_EXP_MAX)
+
 /* These apply to the most significant word of each FloatPartsN. */
 #define DECOMPOSED_BINARY_POINT    63
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
@@ -601,6 +610,26 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.c.inc"
 
+static int32_t exp_scalbn(int32_t exp, int32_t scale)
+{
+    /*
+     * Catch chains of scaling which lose information.
+     * In particular, if the exponent has been saturated,
+     * do not allow it to become unsaturated.
+     */
+    if (exp >= SCALBN_EXP_MAX) {
+        assert(scale >= 0);
+    } else if (exp <= SCALBN_EXP_MIN) {
+        assert(scale <= 0);
+    }
+    if (sadd32_overflow(exp, scale, &exp)) {
+        exp = scale < 0 ? SCALBN_EXP_MIN : SCALBN_EXP_MAX;
+    } else {
+        exp = MIN(MAX(exp, SCALBN_EXP_MIN), SCALBN_EXP_MAX);
+    }
+    return exp;
+}
+
 /*
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 45606f8402..4715187017 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1098,8 +1098,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     uint64_t frac_lsb, frac_lsbm1, rnd_even_mask, rnd_mask, inc;
     int shift_adj;
 
-    scale = MIN(MAX(scale, -0x10000), 0x10000);
-    a->exp += scale;
+    a->exp = exp_scalbn(a->exp, scale);
 
     if (a->exp < 0) {
         bool one;
@@ -1623,7 +1622,7 @@ FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
     case float_class_normal:
         {
             FloatPartsN r = *a;
-            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            r.exp = exp_scalbn(r.exp, n);
             return r;
         }
     default:
-- 
2.43.0


