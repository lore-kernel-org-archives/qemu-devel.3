Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7744FFB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DC-0001Ay-3S; Fri, 24 Apr 2026 00:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Cg-0007ng-9E
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:48 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Ce-0002w1-DO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:46 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4042905015cso4427075fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005103; x=1777609903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Su7VYGRrcdszkKPYCMhXf5vTOdniXRif5U1SUu2ox64=;
 b=DQ7liQu7rJrgvNUGs1SqyX62g0yK/vVsKv2IXmFqXz1HfyWj4cRWxkQTF6BAeGkMJB
 Ek6uqgtSIPakZYUSmSTOFJkLIDOg0RuU3ApJRszifmm1DVqDyo86/ArZ83w70l/XoV4d
 TpWdg/ekY5+uENulxjQ/P6hoC9ynjzXy1T1KDdc42zookIdBMNT/2x6TV++xerFC02+T
 487VfR8FpTsUXNgXBsqMc6gxWjLhVH4MLn8plziTqmzd9/Rz1zxE2s+DZlkRUH+s3Y8a
 8Jakc5bvlc0LCdwp96oXdu3IDB5IB1V3NS7Nvn4R3+xads7l4z0gtrHaC2esLgOjOc65
 M6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005103; x=1777609903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Su7VYGRrcdszkKPYCMhXf5vTOdniXRif5U1SUu2ox64=;
 b=RIvo7GSjjgelyAZEWXj8Gnas+F6F0WKtO+nB99SbyLp5v7+OpFuKqkGnc0Wc8DTHbe
 XGrOUiFMP598JS/G2afXk5b1cKRpbUKLgEzy8+gKcRRlk1AvfkJ1sOrWVoxEVbNISTBZ
 0vbAvchqgrEFXntd5S+GqtmmdX/dpZLbqEbriQFRH2dB6CerUmkpBLy6ikE4aMaGcfxW
 OekFUGUwvRuZCYDOhzzCLu81wYknmrjpHDOqdJrruRV1n/aqzLmIVj6aafPoNRM/vzPY
 PpQMy3ZPLMBxqcs3fHWK5KOr4kfv0MSURwM/IE6zZnvly1wLXKVsUH/bB1w1ULJKCrMe
 GGIA==
X-Gm-Message-State: AOJu0YxUU6bBD1C72eHYnes4X050TqMtdBkwwKfmOTzc1UkWRBiRYK5o
 l8pCWD51oJke3At8nx2rYE9r0OkiePPaLMUr/ccEjn7IgOt16JeTyR2XJaSvSlNpdpPwFIFbTTM
 S19nwX5c=
X-Gm-Gg: AeBDietiQ8dEImcq5v43fLPzhAhTMpJQdWSQt44s1mRBNGsiVMpKxy7wld7fWju8SK5
 2zD/qiYx+cN9wfxHVaKPHuTCwDMMVBRED9nX3Ae7VIQLk4PxPlZEteS56O73Thp9Ze2lQ0xmuRw
 BQUSVUyh+cQHcG+NX/fOeANsuYKufF+3TGcixxECaGKTZhH0lQL3xoCnHoLoe2zbDCN5qYNqQX2
 vPlQN6xJl8xqHxTKxtseWZbRNoHCN8XTxVF9GfoSrkeK/SBKtKekGrCgFZbRLEg35ltmJCln7qR
 YBGj4OIRJYG+lOD6O7Sqm6Mqp9ut6d3keNtzoMkIbAGmH8T/Y1bbm83A/oTXvFKasbZc5p+8tMr
 3G7e0+SgPJKeWnExv6sPoETzyQUZ8yVOuhv8YTk/zBXyku2cQfPRjC4Ehvkk/aKrGTAB4ciZvSO
 jCcvD0CPYchVCYNG7JvLakHAu5OTgBwuX2PiMAy1IV83Z6FcDlXUTlet1v57XKYuaNEu04nGt4
X-Received: by 2002:a05:6870:5491:b0:42c:1b45:e8c3 with SMTP id
 586e51a60fabf-42c1b468ab9mr12160708fac.33.1777005103077; 
 Thu, 23 Apr 2026 21:31:43 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 19/40] fpu: Add scalbn argument to fp8 conversion routines
Date: Fri, 24 Apr 2026 14:29:53 +1000
Message-ID: <20260424043014.46305-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

All Arm fp8 conversions have a power-of-2 scaling factor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h | 16 ++++++++++------
 fpu/softfloat.c         | 35 +++++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 8389a07b04..6f86848b7e 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -195,13 +195,17 @@ float128 uint128_to_float128(Int128, float_status *status);
 
 float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
 
-bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
-float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, bool sat, float_status *status);
-float8_e4m3 float32_to_float8_e4m3(float32, bool sat, float_status *status);
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, int scale, float_status *status);
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, int scale,
+                                    bool sat, float_status *status);
+float8_e4m3 float32_to_float8_e4m3(float32, int scale,
+                                   bool sat, float_status *status);
 
-bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
-float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool sat, float_status *status);
-float8_e5m2 float32_to_float8_e5m2(float32, bool sat, float_status *status);
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, int scale, float_status *status);
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, int scale,
+                                    bool sat, float_status *status);
+float8_e5m2 float32_to_float8_e5m2(float32, int scale,
+                                    bool sat, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 91c34307c8..bcec7d38c8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2853,7 +2853,8 @@ static void parts_float_to_ahp(FloatParts64 *a, float_status *s)
     }
 }
 
-static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
+static void parts_float_to_e5m2(FloatParts64 *a, float_status *s,
+                                int scale, bool saturate)
 {
     switch (a->cls) {
     case float_class_snan:
@@ -2873,8 +2874,10 @@ static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
 
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
-        break;
+        /* fall through */
     case float_class_normal:
+        a->exp += MIN(MAX(scale, -0x7f), 0x7f);
+        break;
     case float_class_zero:
         break;
     default:
@@ -2955,21 +2958,21 @@ float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
     return float8_e4m3_round_pack_canonical(&p, s, false);
 }
 
-bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, int scale, float_status *s)
 {
     FloatParts64 p;
 
     float8_e4m3_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts_scalbn(&p, scale, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
-bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, int scale, float_status *s)
 {
     FloatParts64 p;
 
     float8_e5m2_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts_scalbn(&p, scale, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2993,21 +2996,23 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *s)
     return float64_round_pack_canonical(&p, s);
 }
 
-float8_e4m3 float32_to_float8_e4m3(float32 a, bool saturate, float_status *s)
+float8_e4m3 float32_to_float8_e4m3(float32 a, int scale,
+                                   bool saturate, float_status *s)
 {
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts_scalbn(&p, scale, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
-float8_e5m2 float32_to_float8_e5m2(float32 a, bool saturate, float_status *s)
+float8_e5m2 float32_to_float8_e5m2(float32 a, int scale,
+                                   bool saturate, float_status *s)
 {
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_e5m2(&p, s, saturate);
+    parts_float_to_e5m2(&p, s, scale, saturate);
     return float8_e5m2_round_pack_canonical(&p, s, saturate);
 }
 
@@ -3078,21 +3083,23 @@ float32 float64_to_float32(float64 a, float_status *s)
     return float32_round_pack_canonical(&p, s);
 }
 
-float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, bool saturate, float_status *s)
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, int scale,
+                                    bool saturate, float_status *s)
 {
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts_scalbn(&p, scale, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
-float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, bool saturate, float_status *s)
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, int scale,
+                                    bool saturate, float_status *s)
 {
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_e5m2(&p, s, saturate);
+    parts_float_to_e5m2(&p, s, scale, saturate);
     return float8_e5m2_round_pack_canonical(&p, s, saturate);
 }
 
-- 
2.43.0


