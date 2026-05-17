Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F490CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKs-0001jW-Mu; Sat, 16 May 2026 20:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKU-0001dx-VE
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:03 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKT-0002Vv-6y
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:02 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso420267a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977558; x=1779582358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXEFjIA2Rc2Ly2XJsgxo/zPmqwc6w9LU/oPQ8iHupDk=;
 b=KaICmOxAdkdSRhASr3rbO3HIe7RHhFMtd8rHJ0Pp8/R0R5KTolGvNP8LelMIlIVIab
 asTImzJYvrmB9oDvz0JoSJmcJUmEpXMq/wjoxBmfSaKbxx7IwQ9JpRjQm6nbQWWmQuWu
 ysNlL5btbI0og3U7MU7OzjXJ8UpbcSEZFJ1Cf3mMicwOyYi9s9h0ZEREbJFO6GEoEsz3
 fhb5tH8D+pxYgpyIsmeeQs1d9qXPpmSkNhludsNmbcaSkxV2HvZNVrTfEY79otSsxYnW
 h8opR4gaLOF1aD+9+F2rIZOEUJ/MmPfyd+NlYUDdT0it+3vfmS7YCbVXF099VtVNleaU
 /0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977558; x=1779582358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXEFjIA2Rc2Ly2XJsgxo/zPmqwc6w9LU/oPQ8iHupDk=;
 b=nQeQtGpEHhyiyX5MYLcUewDgclo0boMa+ccruIK03pKl4mBhX5So4FCxf5VYfGy45D
 +j35zy960BMq/1mn7U2f6dAvLxoyvm6eCaM34T76BPDc/roiEB3QLLCvtYIYJBKbw67s
 Kyybc0+teWExIicaBySxwhvUt0p/XY5dbeGVhjygmV5Kycm1iiNfuxnZDeK1xW/jISZF
 u0ytPLByWV5i9KPnCyRQfQ8h/XuvngWf9BOwcNNJGXZAKW7RheVgYK76r3c16ry4DJuG
 BGgPqDaU4A0PWdIMRKVOLFSFCm3HD+Yex8egAfVl6UhN957nKC1l/z5/O0Z1ZS0+DKXl
 LioA==
X-Gm-Message-State: AOJu0YxlHXuDNs8upzE4lfII3fS9tRTGBWTpMSvtgpx4Erq4635RQCfT
 63ydcSabUDT3Cs3v50dRJn3OZTjw49mUL7qCVd7RhbgblvGpvuuESwgCekPXGXZYEJhgVtMEhrA
 7KfU3
X-Gm-Gg: Acq92OGUhQGhnxfMuiOmQ2H0H4rXMnLsQ33HASJ9+heefUbDfFzGFyLnf3bxkLxBnjr
 nBRmeEBh0Z6n4bUvDEMNq8w6VNBwHbnu7HbD6wrA17tylAA9bO8EIB75gnBCer94OKIjL3jET+N
 OTvXEMLYO4YfoM4Dqwd9GrJ99Zj9UynQ5L2O2IbheORli4BAL9urMKWBfT1BoHI71mED1kIWoX0
 jz0gaNyixbzTdsNOL3zfGwNwpAhaTB8oM//isNJhtGHPWPcNwVJK4os6rNFayvdc7aFaPLxeOVT
 AbFuFgUXHsgKPrO2MGUASWy3mLTMOGHykBI7O21gLZnCEougp0X+44X8UKHpkkQWfKtiFWyNw9C
 T0dUDhvwPFMSZaXtFkHOX9vHYD0tBccy9EYg4Q0tJtRYbNz+N6IFIC/5U7SNtpD2LIzC+b2L2NB
 FmQnAERY24WU/jGRRp3nBhKF5eqUjc
X-Received: by 2002:a05:6a00:198f:b0:82a:5d55:5807 with SMTP id
 d2e1a72fcca58-83f33c52428mr9516451b3a.6.1778977558290; 
 Sat, 16 May 2026 17:25:58 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 04/12] fpu: Hoist nan check in partsN_addsub
Date: Sat, 16 May 2026 17:25:41 -0700
Message-ID: <20260517002550.321291-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

The nan test had been down below because it was unlikely.
But if we have to have one anyway because of denormals,
we might as well take care of them right away.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 437b333341..3246702289 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -530,13 +530,15 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
 {
     int ab_mask = float_cmask(a_orig->cls) | float_cmask(b_orig->cls);
 
+    if (unlikely(ab_mask & float_cmask_anynan)) {
+        return partsN(pick_nan)(a_orig, b_orig, s);
+    }
+
     /*
      * For addition and subtraction, we will consume an
      * input denormal unless the other input is a NaN.
      */
-    if (!(ab_mask & float_cmask_anynan)) {
-        record_denormals_used(ab_mask, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     FloatPartsN a = *a_orig;
     FloatPartsN b = *b_orig;
@@ -558,10 +560,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             if (a.cls != float_class_inf) {
                 /* N - Inf */
@@ -586,10 +584,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             a.cls = float_class_inf;
             return a;
@@ -604,9 +598,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
     g_assert(a.cls == float_class_zero);
     g_assert(is_anynorm(b.cls));
     return b;
-
- p_nan:
-    return partsN(pick_nan)(a_orig, b_orig, s);
 }
 
 /*
-- 
2.43.0


