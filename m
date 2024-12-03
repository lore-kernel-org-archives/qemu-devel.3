Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED3E74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZh3-0001bs-F4; Tue, 03 Dec 2024 15:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgf-0001Po-32
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:02 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgc-0003BT-VO
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:00 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-29e49376462so2206942fac.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258398; x=1733863198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNUIjgqbw5Yl+6hPFOkjdIaMwRXN7nsIkH0qHur7LqI=;
 b=osQNGHP1tQbA03jHTs7rku97oeX9dhZ9myMEh2ClP2UM7pWugVaY0svFWKs6Vcf+vO
 rpQKZyVRFgYj6Grs978oEJyYzNB9js74t6g/NnH1KtE5d7ktpXfqF4GGH7V6/42gIvL6
 ZocgMg/ZwUrIBpTL8TCViEIAcgxDHzdCpQM+D8puUqM5ScgS3bxG0cm4yd32Et9Wt5AP
 OKceN0UL5FYDzH6iNo4HxF/Aj+EuI/B1ed87XGNZ9sOamvPTPellJZaV8xwcdFe2eHfp
 O/rBtfrIqKiRj1Iyk1LVOQpNZZJMT56V8pX41LuPzryxdNyfGuyL/lLud+BE3Jy/qOKI
 0S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258398; x=1733863198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNUIjgqbw5Yl+6hPFOkjdIaMwRXN7nsIkH0qHur7LqI=;
 b=ahz7rJjFZ40UFoKyjmZbA1qNPdXJ2A/mB5Rk+deK7FsYdgkeEt5N+OvoykHjFu1e5o
 ue0c6p8vNJKp66DODIA7v7p3TlbRyNHm1X6opLhpL/+AwT7JsOKISWL30Y/65P8+fr63
 K9h6Et9m6Fwwo8rtzqdUQrS5Xl3u2WXZ9rYWiMUNq23XCTDD2PL9/TUMaGawpZio+7zZ
 KmvIrjmt1aIiooJSeqsunhAcdRW4yyq6DqBVR5amsuoh74nJ7YoEQj9LcbmUkmiMM6ix
 4LnMj+4WwLKFqV1OTbI4s49jkwltpHOeZxLZ6SLYCXO6NqeKfvMF91CRcPZoJOJ29EQg
 guEw==
X-Gm-Message-State: AOJu0YwVI9OuXqnqdjoEey2hCuenoVwQ/wODVhXJSyswZluaKnJ6645K
 oAuxyFqvzfyCQGjnBRy1j2VOfnoLk0bHb37WL++9WW0Ykt7ss+vwVYyKMivIOJ3zfJIQTpehcpS
 z4bc=
X-Gm-Gg: ASbGncucbk87/NOMrLFmgSgMTBxtAKLqQUBgB8gDWe4ZgDSAiT0ZdpVnA3ngXbsLNct
 uGpK37QCDnKDX2gQy5vdet9z2j5AxpfVbrPy+//zIlbriw1e5KaLogZBWTr8qXvBN1DhJYyHDVe
 LnOe/Qxb7g00+3WBKpMIu3egr8Wt6LEEnLVojtp9Tw7f+z1OwzHld7xokzECh+sIChcrgQ0ufVo
 OJv2RCyKZcYymN/O4bSugpcDpii1XSrX+vCh90QtxN0MWBDIlNWNYoQc1n1mLbjbdO27mRX9slm
 hdAgLPuDTjSgcnQLwUJ82n4L9DC88kL3xXqs
X-Google-Smtp-Source: AGHT+IG8WoKKqB2jhFfdX9H1GIv3u11X+XjkZmJn+hgNa2uLvg3QJPwHv+9yIMM6VOkwEjb+4oOxMQ==
X-Received: by 2002:a05:6870:1644:b0:29d:c624:7cc4 with SMTP id
 586e51a60fabf-29e8853ef9emr4671927fac.6.1733258397757; 
 Tue, 03 Dec 2024 12:39:57 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 07/11] softfloat: Use parts_pick_nan in propagateFloatx80NaN
Date: Tue,  3 Dec 2024 14:39:44 -0600
Message-ID: <20241203203949.483774-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Unpacking and repacking the parts may be slightly more work
than we did before, but we get to reuse more code.  For a
code path handling exceptional values, this is an improvement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6ba1cfd32a..8de8d5f342 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4928,48 +4928,15 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
 
 floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 {
-    bool aIsLargerSignificand;
-    FloatClass a_cls, b_cls;
+    FloatParts128 pa, pb, *pr;
 
-    /* This is not complete, but is good enough for pickNaN.  */
-    a_cls = (!floatx80_is_any_nan(a)
-             ? float_class_normal
-             : floatx80_is_signaling_nan(a, status)
-             ? float_class_snan
-             : float_class_qnan);
-    b_cls = (!floatx80_is_any_nan(b)
-             ? float_class_normal
-             : floatx80_is_signaling_nan(b, status)
-             ? float_class_snan
-             : float_class_qnan);
-
-    if (is_snan(a_cls) || is_snan(b_cls)) {
-        float_raise(float_flag_invalid, status);
-    }
-
-    if (status->default_nan_mode) {
+    if (!floatx80_unpack_canonical(&pa, a, status) ||
+        !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    if (a.low < b.low) {
-        aIsLargerSignificand = 0;
-    } else if (b.low < a.low) {
-        aIsLargerSignificand = 1;
-    } else {
-        aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
-    }
-
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
-        if (is_snan(b_cls)) {
-            return floatx80_silence_nan(b, status);
-        }
-        return b;
-    } else {
-        if (is_snan(a_cls)) {
-            return floatx80_silence_nan(a, status);
-        }
-        return a;
-    }
+    pr = parts_pick_nan(&pa, &pb, status);
+    return floatx80_round_pack_canonical(pr, status);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


