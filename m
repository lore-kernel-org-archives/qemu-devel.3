Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C00AFF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzor-0006Vt-Sg; Sun, 26 Apr 2026 09:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznn-0005gI-03
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznj-0001OQ-Lg
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso60074925ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211133; x=1777815933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGDYPjHTYCXHRscWp+hH1FEaFJxCcy/ciGEVQSmwAsc=;
 b=LNzLu8m23kkss7PP8sVAcuxJjI+PD2BrtsWa1dlEsX8P4pVmy6T/+1rQ7OdPHh+zMH
 D4hYKn7CmowCSOmexrJM0sYBOSiL8aCXmyfCUjBy6cH+CRC1rgK7ViyfCCe9XLaSO06R
 BriJ1R9gncxQapnBTOEP/D2fuzG8Xl9QHqkbhiO3icgKwxv26VfQC8tXWgtNxb+5y+dQ
 m7GeblqDdwmleOolUIAJoApqu2r1xdyp46CfWuGnJGTP2xJ+sN2VbEy26ojE6hYuMaSP
 IeCoHP4gF5dD2kzZXkaS6cNmAPfzjTuyrMOtmGIV4QBHb9bD+aUHiRg5J8WMK/gnbIde
 11kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211133; x=1777815933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IGDYPjHTYCXHRscWp+hH1FEaFJxCcy/ciGEVQSmwAsc=;
 b=UWu+g2SWEZ1hVjBu5ha6g0Pzv0k8vzd9B6ZXWeJJMHzMcjWBQupoklJnKH/cSCiAHB
 TZIJHdWiS/jOQSkniBKwCWHeWwJ1zpHGTECfrfVESR1McyOch79Hk3pKO2pxJKCx6KEM
 h6JV9mf0uTF3MUsNLmJsDjSlnwkjotkFt/MJibphn2TVYDRViG3ASlQyN5IeJixEdMvi
 2vfy8/ZZ9XLAPC7qYNZorufmkbTMTLHMQ9gRUOXTimoagAuVtF06vAP/tQWBvuyii9Yi
 V0QZPHbgcwkRz3feyEKI5f/YjX3H1+7ElYNql4rwKjMQ+W1ElR4pKBTTV+bnp6JSQso1
 /b2w==
X-Gm-Message-State: AOJu0YwAThepAagQbaoyHvvGiUKKDbs8eo4krYUdcFaJPqe5L2gM/bqC
 fMzPkp08Pt3Kf9Z0X2oON4m6cT5JBWTgdMD45Oz8BusDIsR7Mj4UmAAaog+DdVeZ+ZUJ0MEi0yy
 fUKJXK3I=
X-Gm-Gg: AeBDiesHLQDwVO6fWq2yTykpCBfUDmnHH5KX5+bj4vsteddlo6eZpAyS45gmB5yD1GN
 SJmLrR2e/KaYi4J8FRIDE3YenMhy2gKhteD0iDa1N2ejqL55UOtvFMm+b4/6NrhUa90jTiddabu
 JO2hqPHfbygFJKmQfv9uZ2Cqbm1fSSRg6aH5l/LS869/fZqFrNgWsNyI/de0z8S5AYqrnjYqF/v
 KjWfcDu1GgCv90rOWg1NP+4ue8A4eEb1n/25zZmKpDwAlDQLJZxGnvngy4xIMEtdqgE4h8a4x9z
 s32HUipbwRyxrODeRATcaWbtQXpS4AF7VTDmw6h+ywzeeec8X490lNpXbXHy9ZwDlnAkiwBawwT
 foyV23uZPWAvJRD/Jy4Po32RYjd5wjPz0IUJpFnLX8+KsGf83Y1gfZv/fybgN52JITNlB3HtkuO
 kydV42mWT6mg9kjllZIFsi3Z3bDmzTvSHaJO4OM6h6
X-Received: by 2002:a17:903:1110:b0:2b4:636b:dc4f with SMTP id
 d9443c01a7336-2b5f9e950a0mr337443645ad.15.1777211131932; 
 Sun, 26 Apr 2026 06:45:31 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 52/84] fpu: Inline bfloat16_pack_raw into callers
Date: Sun, 26 Apr 2026 23:39:29 +1000
Message-ID: <20260426134002.865628-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8cfe7f8f4b..6d5125eb1b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static bfloat16 QEMU_FLATTEN bfloat16_pack_raw(const FloatParts64 *p)
-{
-    return pack_raw64(p, &bfloat16_params);
-}
-
 static float32 QEMU_FLATTEN float32_pack_raw(const FloatParts64 *p)
 {
     return make_float32(pack_raw64(p, &float32_params));
@@ -1488,7 +1483,7 @@ static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
                                               float_status *s)
 {
     parts64_uncanon(p, s, &bfloat16_params, false);
-    return bfloat16_pack_raw(p);
+    return pack_raw64(p, &bfloat16_params);
 }
 
 static FloatParts64 float32_unpack_canonical(float32 f, float_status *s)
@@ -2230,7 +2225,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return bfloat16_pack_raw(pr);
+    return pack_raw64(pr, &bfloat16_params);
 }
 
 float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
@@ -4753,7 +4748,7 @@ bfloat16 bfloat16_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
-    return bfloat16_pack_raw(&p);
+    return pack_raw64(&p, &bfloat16_params);
 }
 
 /*----------------------------------------------------------------------------
@@ -4797,7 +4792,7 @@ bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
     p.frac <<= bfloat16_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
-    return bfloat16_pack_raw(&p);
+    return pack_raw64(&p, &bfloat16_params);
 }
 
 float128 float128_silence_nan(float128 a, float_status *status)
-- 
2.43.0


