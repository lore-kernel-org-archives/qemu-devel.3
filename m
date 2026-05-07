Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F12CD37A9
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EN-0004XI-OG; Thu, 07 May 2026 12:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EK-0004Vm-NL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:41 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006lg-Qw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:40 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de44ed7a11so874609a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169927; x=1778774727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vif2gY1S8nmJRhYybl+BgqipJgue0+RfwqpaRHJOLL4=;
 b=u5IZVgDVfAgtQseXpMjJenBzR7ZDzQtx0E92HgNxfvWOudz+w5oT9AoBpyreLLPr1F
 K7idtz99MxZSOrqIuLSMPCiJCsx2GFYyeIWh9BBrD4qbwVoBBIKxd1DWg9hnssle+1k/
 bYWnK6+sg/feAs6h/3wuASPGqN/5+wBUsTz3v1ELLspDt4KDqZDm8S6xDmFtDdoWSxM9
 gzw2kfDiVRQjc6b9UweGJqOGvd9Dlqj+farOlNH89iSMutlHEfnmFNcevm+ET7IbTxl0
 fC1uDRmtgwVW1shsSxJO0zg23NR2zS+l11edFOeeBDRTSELFuKmU7jckrGm2rUEsnBdw
 Ob9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169927; x=1778774727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vif2gY1S8nmJRhYybl+BgqipJgue0+RfwqpaRHJOLL4=;
 b=Hr2Wn3wD9v2vCG4eaKyfEScY3d8EDJNamMHjyUZrNSial6//l7gmbFzdovRYbQh2jU
 V4Jv9Jj5JSUUNaW26p2e1Loyw6hbMZwW6OpDkJjPvweULhU2QpoVLZU7ZFwVfz8S0VZG
 SPvbWrDaDSfRL9rM6pf2M0mIE9MtnUVADrKAOOs2kHBbojlwvIF3Y4eUgbJ6Db7YsiEj
 CaNOYsYa9lhFjkTrw0uppdYTs1t2j91jAwyTEbK6SuQYnZ+4EEPkVT73i8cb9hBSGIbX
 2i2l54RuSCg8PHiNdmyzUpcECoimkExs6n4LI3ZNI6gKBrlspfRTc/Ak+cgTQHo7rCH+
 Hv8w==
X-Gm-Message-State: AOJu0YydLwrzVYlQYkMcxQk7jxWyYCZGWgXMXZWerSc15vbJ4O3WTDtT
 c1J7nCtfd/jO94/2lKarzhpxGozk/ZXpdZvyHW88rHBVb8BVH82ImxR5jb9A2Zn6pl6WKsbERON
 9RBSv
X-Gm-Gg: AeBDiesZnrZAycF+hU5/nz9y3JlQAI0IAFi3zlVwiMZ7sVwiKU01ggNOlBitxQcyAhB
 WaU1fgIrrv/lyfPiiG2qUk55xuHmsjjpX+hSGf3yAvUQnsZNDnk307fzoodHA0KXLaa+p4tmInz
 qrh68oSPrpnFJmNEYV5oZRoj1Mul0W8gmDVmCyoUHvm31tVwzcLyxKKQvUW0DdPHvLhjLlorhk6
 OAc+BRsoriflpFMnGmnLD3DTJcDz+L3oAeHflmxkNvvq7rSK+jEmX/OQ719YY5X49Jdnk7o3LfX
 Vvx4Lhb9el8nMz4iyN0BSLzeWgbsnFfXWptQpoOkOI9p+Au3V3cz4vmNAda2xlTvtLUkEY8IuKj
 dQry/1frO8x0lUTpw2JzOWNJGMNudiVvy6eTsAQbPlGPna/+NnmbX+Y7dERu/fBzTcS9DqNEt1y
 iqRLPzRc+U2nAqPWBBHIHH8T/Y0aXmCh2AX/bRrWBhRkW/og==
X-Received: by 2002:a05:6830:83a3:b0:7d7:d504:cc6d with SMTP id
 46e09a7af769-7e1df0caa12mr5775975a34.21.1778169926583; 
 Thu, 07 May 2026 09:05:26 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/29] fpu: Inline float32_pack_raw into callers
Date: Thu,  7 May 2026 11:04:53 -0500
Message-ID: <20260507160518.444797-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


