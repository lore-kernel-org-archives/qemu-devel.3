Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A768FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGznr-0005lb-GH; Sun, 26 Apr 2026 09:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznV-0005cY-SN
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:22 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznU-0001KB-5k
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b788a98557so42446015ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211119; x=1777815919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wY0NB6qgE+bAQHWWi7d8cQ7VHs8v7Rlo1nrFDJMYy0I=;
 b=S4rvuDy03d1PXJqBXNM/CrZZ9nIH16Gbgd3vG58r++Fy6+PcCUvrcthzazlOL44xrF
 /39Qz+DvO8w920+sqlZyXV6cErn0CCzFpKwIrsufdlu4UKF2yaRzXIor4t+A3gz24GCK
 SFsLa4R/hh2T4fUrBF9jaepHLIEeUwvtma45iQFCGjwZbOmNdTAfB2bXgcR+PvBJbhhA
 HG1Gd/9M9f1slm6JGmu+I8P28+mgTHIZ3TIQKVDqKeFgBsNgGGBlu4VoFai8wwIC9c9A
 Pui0FSGTIPhCzy4mo1BFFBij1T9ymZVTHo7/X9AjRyHBmJcZSQ8TcoyJOVw3sz5tt4Vk
 9XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211119; x=1777815919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wY0NB6qgE+bAQHWWi7d8cQ7VHs8v7Rlo1nrFDJMYy0I=;
 b=EC9IcVFB49i5/RLLmzFnPWI1dJJorecsp5CmSBuxYA2WVhrCCPHwr+bDBAImHtm6Rz
 ZanyZ3yJc2a2ANlJL+dmnTvPwQ9wzhmn02eLDQgcsRXKNElmMZFFMhFHs1KvCnFhspFm
 FQPQfGpqToyQhSCfLNSVVp272BcIroC8D7QVtWakhDhEssPXylfTQYRQ8udlRER0Opu7
 RUm/WzZcifq0b3PW6dw/8OSFclY/kusqtsTJJDc6xIVGFfxsJzkQrUabE3oL88bUtrxS
 EPMhZbP8I1tPhqBG7nQOGCdGMIeIN37oQiJ1lBosr59Z+m/1leJhdVVPicRHbFcnLN1f
 TfnA==
X-Gm-Message-State: AOJu0YzaIIxBrF13+PFeiA2GWLzzOt3Kk+lsS4HLkGdlgLVlrb2vmuPM
 w5vcLCl2ba6Tks+Xfb0QaULpAeNcfVErumtJDJCIs7ThMY2wJ/y4Wc6w96HKj/vjrWsXGUX6BG7
 eMoeebX4=
X-Gm-Gg: AeBDiesUvxI5mSGZTWVYvn1FD6LzhoM6WOeEs2K/fu6onlVK++E97NywVTvYOT+PxtK
 RNQbhtsCX0T5cPF1nxmZA2b+9R+t2sfoY5QlYhERD+sjvHKMkXdaCORGgjkofPybPj3kBUFSQg5
 rt9Pm0oHLFAAnyEsqaM1rNgBKpXg3gk2tPgSNA3e2QtX2KxEGZpm32QARAseeYOINKfPPz2KDQY
 qsgtZBNOHMQZ6Bz7WZdFGZBUJbeJfDwH84bwJNtcXADXyE5suSLQ/W//BoILNqL5goOOUzlSoBR
 bwiACgYFxKsjO5RXfdTZGHzDhcPXNp41qJ0OviT2Jx2BbUnCms+7Mt9GPPYdPSfFnpsa7i8HeMt
 oLJe1bSoczAQk6WPjlewpYbDjRUtJR2XaG4vtGYGQCAvsB9IqkXRhF6PUT2NDk35z4W+Chj3+BB
 1EaE4rew1pAqWXjsFRFSB6/c0dkALpH/0e79TX4S2E
X-Received: by 2002:a17:902:f98e:b0:2b2:481b:de5f with SMTP id
 d9443c01a7336-2b5f9e86057mr286214455ad.5.1777211117120; 
 Sun, 26 Apr 2026 06:45:17 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 47/84] fpu: Change parts_float_to_float_narrow to
 parts128_to_parts64
Date: Sun, 26 Apr 2026 23:39:24 +1000
Message-ID: <20260426134002.865628-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Rename and return FloatParts64 structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 77585fa11f..99f0036d0d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2563,29 +2563,31 @@ static void parts128_float_to_float(FloatParts128 *a, float_status *s)
     }
 }
 
-static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
-                                        float_status *s)
+static FloatParts64 parts128_to_parts64(FloatParts128 *b, float_status *s)
 {
-    a->cls = b->cls;
-    a->sign = b->sign;
-    a->exp = b->exp;
+    FloatParts64 r = {
+        .cls = b->cls,
+        .sign = b->sign,
+        .exp = b->exp,
+    };
 
-    switch (a->cls) {
+    switch (r.cls) {
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
         /* fall through */
     case float_class_normal:
-        frac64_truncjam(a, b);
+        frac64_truncjam(&r, b);
         break;
     case float_class_snan:
     case float_class_qnan:
         /* Discard the low bits of the NaN. */
-        a->frac = b->frac_hi;
-        parts64_return_nan(a, s);
+        r.frac = b->frac_hi;
+        parts64_return_nan(&r, s);
         break;
     default:
         break;
     }
+    return r;
 }
 
 static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
@@ -2773,18 +2775,16 @@ bfloat16 float64_to_bfloat16(float64 a, float_status *s)
 float32 float128_to_float32(float128 a, float_status *s)
 {
     FloatParts128 p128 = float128_unpack_canonical(a, s);
-    FloatParts64 p64;
+    FloatParts64 p64 = parts128_to_parts64(&p128, s);
 
-    parts_float_to_float_narrow(&p64, &p128, s);
     return float32_round_pack_canonical(&p64, s);
 }
 
 float64 float128_to_float64(float128 a, float_status *s)
 {
     FloatParts128 p128 = float128_unpack_canonical(a, s);
-    FloatParts64 p64;
+    FloatParts64 p64 = parts128_to_parts64(&p128, s);
 
-    parts_float_to_float_narrow(&p64, &p128, s);
     return float64_round_pack_canonical(&p64, s);
 }
 
@@ -2812,7 +2812,7 @@ float32 floatx80_to_float32(floatx80 a, float_status *s)
     FloatParts128 p128;
 
     if (floatx80_unpack_canonical(&p128, a, s)) {
-        parts_float_to_float_narrow(&p64, &p128, s);
+        p64 = parts128_to_parts64(&p128, s);
     } else {
         parts64_default_nan(&p64, s);
     }
@@ -2825,7 +2825,7 @@ float64 floatx80_to_float64(floatx80 a, float_status *s)
     FloatParts128 p128;
 
     if (floatx80_unpack_canonical(&p128, a, s)) {
-        parts_float_to_float_narrow(&p64, &p128, s);
+        p64 = parts128_to_parts64(&p128, s);
     } else {
         parts64_default_nan(&p64, s);
     }
-- 
2.43.0


