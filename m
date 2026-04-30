Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80071FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuW-00068p-S9; Wed, 29 Apr 2026 20:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuV-00068f-H6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuT-0001jH-VB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso184615b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507540; x=1778112340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Mxa4m32oeXlXCbYEih/Wgv7PsGE1aRsWYB+Y9zn5Ik=;
 b=L1gWHhcSKu/JLtrNSgUjB6ejBSloxXX63tpxR9mCkYbkpTPwlAin59pla+jOKvTj0G
 GTGThGDlxZOmdojhME/n9oYgluKbm845gyDnUCZLPI5xo58n8s9OE77JPSfxwxjfAjqy
 E+KqYjgdGhPVFuuMKMn4Fd/hiBeNf7kTwKASoxdVEo8vNMqLed0ZIPS2GRwDrnFORkYM
 1Otkb6UN6WDGndc+1NMy1e+tA9pxy5V3wGJBwNVBfqXfnEJuaJe4ZXMMDsaGxf22wb6k
 ocY/EIn8aVrDRJRklPOARga3Amip7s+9Oqf368AnEHz0mXlIEo6M529rt0t/FTN8vncx
 ayrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507540; x=1778112340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Mxa4m32oeXlXCbYEih/Wgv7PsGE1aRsWYB+Y9zn5Ik=;
 b=fEj3PTI4K85c/AbOJ35NM3yTiDcr4zlPYPGP5gHGMduHb6nGHPH2qwyPkJRClMp5tY
 0nqeYuRmXHRBHJNcP6abTZFpJmTJAhS3wCFmsvKFG/Z7JHtX/LR4U05S/olUJoSfYy5t
 /yBQZORhcDOpWixBh5HfidVmZ0+t4YPrjZThOsia0aUymo4KM2qCcgTnHLIBpSrZ2Pcy
 xPvfkOX1g6MbVSTqWbdkXP1RDgOCgQhpUZNc/MhVJSYL4+1CppQDi3t2vm/mF6Vvmnmr
 LEmsnz4xdsSRPSG7rGaPsJiEB6HuZg0xdQvC+pw0zhLtCYofG9pVP3OAeoPWKWdSlVLe
 bkKA==
X-Gm-Message-State: AOJu0YyC4nn5h3I+2ya/16EzMaoru/jfKhIA4y+SVeikKFgOcW9EF9wL
 lGQRQEHTqS91rTy5kUJeAAbaVIISFZvK5pHUPkNTcF2EfNLf5FAj0yJC6xxSyhhcP04L+FkPe/v
 0/+BKtac=
X-Gm-Gg: AeBDieu52DU+jzwGXgWo1vJil8mZwPklRPOPReziYlto7zm+mHi3ULGIvNE9DJKwQbp
 xFuQ60wjkPvQAP2r/6Ur/KYgIeDjYVaquETvZKbgrqRJ9G2n1e+UK7fCpUKcYyomvun9sziwRY6
 +vlO9vWxN6VlznXOPkcv1y1thpYwV1ELmJSYkT0dSu0cr7XXyThsmuZhSzT+zRF+dc0vmj1T5mS
 VABhZWLJgGw53ZJi8TbN6zLFTUMxjsDKn/tDJJsKjR0FmoaBTbyZ3AlccH5asXSGcesqOkR+xl1
 bmwlxt/kGodnlVbLS9yV2QUFPSc+Zi7XJxSE17r+6lvkFejk9gKx9iotuTPmSpctbQH9mN1UWmW
 wPjhyfPYc8eGIh3/hm/r3ql8ul44peBaVl90h58OujrC5TSVgCkOShoRTEJmqtVvCGZanhm3xDP
 XZ6YUEZSBQbcBsh5iAzcIjZ/VNCu+eO87iLAAHvCgtM2yeOawOEho=
X-Received: by 2002:a05:6a00:bc93:b0:82f:abc8:ae0 with SMTP id
 d2e1a72fcca58-834fdb32471mr801882b3a.17.1777507540350; 
 Wed, 29 Apr 2026 17:05:40 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 05/40] fpu: Inline float32_pack_raw into callers
Date: Thu, 30 Apr 2026 10:04:48 +1000
Message-ID: <20260430000524.56046-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6d5125eb1b..d1acf383e9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float32 QEMU_FLATTEN float32_pack_raw(const FloatParts64 *p)
-{
-    return make_float32(pack_raw64(p, &float32_params));
-}
-
 static float64 QEMU_FLATTEN float64_pack_raw(const FloatParts64 *p)
 {
     return make_float64(pack_raw64(p, &float64_params));
@@ -1497,7 +1492,7 @@ static float32 float32_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
     parts64_uncanon(p, s, &float32_params, false);
-    return float32_pack_raw(p);
+    return pack_raw64(p, &float32_params);
 }
 
 static FloatParts64 float64_unpack_canonical(float64 f, float_status *s)
@@ -2035,7 +2030,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return float32_pack_raw(pr);
+    return pack_raw64(pr, &float32_params);
 }
 
 float64 QEMU_SOFTFLOAT_ATTR
@@ -4721,7 +4716,7 @@ float32 float32_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
-    return float32_pack_raw(&p);
+    return pack_raw64(&p, &float32_params);
 }
 
 float64 float64_default_nan(float_status *status)
@@ -4772,7 +4767,7 @@ float32 float32_silence_nan(float32 a, float_status *status)
     p.frac <<= float32_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
-    return float32_pack_raw(&p);
+    return pack_raw64(&p, &float32_params);
 }
 
 float64 float64_silence_nan(float64 a, float_status *status)
-- 
2.43.0


