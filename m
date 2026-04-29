Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8307FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMR-0003tM-Te; Wed, 29 Apr 2026 18:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMQ-0003jc-GL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:26 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMO-0005KF-7y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:26 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36146ae9dd4so179267a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501583; x=1778106383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOo9Ej8oauL+yt74QGsLK9i6wkNOq1Wi6G6vU7WjjcY=;
 b=fS38waavuCzF0kaJ6YJyia83JbU8OpJ7cFTaQnNQ3dSzsaqmaVetL3q9CCHhA3t8/F
 649z5emO8Ejaewn6/l3m62pZ+6yJfTSDlLyhPLflk+N4PXgOqC/J42AMt8/uWb+6BdN2
 +Br7WRxbq7caPSk09V8oYkXTgJ7PdEg2P71gI9JPT+GzC4zdDz8z9VPerttdTg3TxWRz
 +csaeQbmKj0sJwEHaqPl42ugTgMZnMtnHroxLLigHwAIeLP2v3jhIMeZrO30zA/HXS2x
 +dqkTD6KJul7j/ZyvRLhbu81C+YhXnqnlnLFVWwTnDOyscMT/h3i4+pBGSLoZp9L/Kj4
 SWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501583; x=1778106383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wOo9Ej8oauL+yt74QGsLK9i6wkNOq1Wi6G6vU7WjjcY=;
 b=nx4oH8koUNaARcK4RbHCokPM4TxAeOHsP+JNnpO5lKKTT+AmwGdALNF1v9xUMdLFOt
 cC20Dlr+RTxw03mTm0Wjnn59f8B5goIPTSXPARVBz2uhrYf/6rR/Alr2wsIkGuZOT9Re
 3g3a/nefy2JncDZvuwRN9AR4i0SAqSMhC98g7U9n36BsA67kxalNvH9jr38M/0USzwUT
 S+APdZ15yR3t37PtemGZXWMH528io6y0+Jftvtp5RS5grtqKUDxP7p3e5E+0FIxxWXki
 d3vDpUBN2MOovfhN584qDfpSLzQhPnRhSBxasvV1luglh8kyfBv/22BtKiKM/C3uLqwT
 C+Dg==
X-Gm-Message-State: AOJu0Yyanktg4Xy4A+XzdXgxIyodSmuhtC7rhm3jVRXnImthbhA6OEcZ
 GPFubEfp7+q+5MDJncnFd0lu2lzb/aPAC6ickXEiiYjpE4zrjUPi4rGIVzqWbvLGz+UpmHX+K9S
 yNp3Tk8o=
X-Gm-Gg: AeBDietvGSJfYcBuEuwjh2FgXsiZchqQj28XHTwYKdLxi3TFFssk/Y1TdVtcqXUKxJg
 CeBaN3v/Nezocj3lrqnbXohpiiEBKUEO9+TmoT1Gq4B++qU8B5qDJt8DGGa+eqGYtGXiNYUuBmX
 nZT6xg0bmaCXhwXqQ4Qnfr6QRfPJth5kWPTBsdrceY0qqI2ftLk+hySPgZRla59/GE9ehHFV5+x
 gv/ESKCv0l/+NmD0Y9nJ35isRVdbYoVq6l4YWSjMU1MZpqAl/Bz/sgle5mIx9g9zdmn6HGKILX3
 VdcaXXu+DWL+JkOJqUIuMvuFJ0uPU59LQgYktrmaOHE2mMEBDeGLoQOtl9JF8ZPyu5xtdWf+xcs
 cKXKjB1XvuI5/0MgOWnwCYJEUmemymdxnO+dbkc7pbRMM/WV9hY4YqB3JuBI9JoHyNBV9kCMrd5
 h7z0N630d0vJ9qpupV/LTGyghe3DMhdYjMcVYY1se8
X-Received: by 2002:a17:90b:4fcc:b0:35f:b75e:fff5 with SMTP id
 98e67ed59e1d1-364c30ae79dmr222844a91.22.1777501582886; 
 Wed, 29 Apr 2026 15:26:22 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/48] fpu: Inline float16_unpack_raw into callers
Date: Thu, 30 Apr 2026 08:24:33 +1000
Message-ID: <20260429222445.26301-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 fpu/softfloat.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bc6450954e..cdf95a8517 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
-{
-    *p = unpack_raw64(&float16_params, f);
-}
-
 static void QEMU_FLATTEN bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
 {
     *p = unpack_raw64(&bfloat16_params, f);
@@ -1482,7 +1477,7 @@ static FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
 static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
                                       float_status *s, const FloatFmt *params)
 {
-    float16_unpack_raw(p, f);
+    *p = unpack_raw64(&float16_params, f);
     parts64_canonicalize(p, s, params);
 }
 
@@ -4978,9 +4973,8 @@ bfloat16 bfloat16_default_nan(float_status *status)
 
 float16 float16_silence_nan(float16 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = unpack_raw64(&float16_params, a);
 
-    float16_unpack_raw(&p, a);
     p.frac <<= float16_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
@@ -5049,9 +5043,8 @@ static bool parts_squash_denormal(FloatParts64 p, float_status *status)
 float16 float16_squash_input_denormal(float16 a, float_status *status)
 {
     if (status->flush_inputs_to_zero) {
-        FloatParts64 p;
+        FloatParts64 p = unpack_raw64(&float16_params, a);
 
-        float16_unpack_raw(&p, a);
         if (parts_squash_denormal(p, status)) {
             return float16_set_sign(float16_zero, p.sign);
         }
-- 
2.43.0


