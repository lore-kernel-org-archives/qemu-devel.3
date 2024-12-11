Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BB6E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSx-0002BT-Oi; Wed, 11 Dec 2024 11:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSl-0001M0-OE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSj-0007u6-Sv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a2033562so59608825e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934080; x=1734538880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ivfNURTgFhMHqj38K3J6R37tOZQ5Ck2WKrXXhbFBm8w=;
 b=QSoBMIvZY6uqK4ks02y7HutchLdBV+4sA5uIpZPNu6nBRauXmPOCwr2rFh3eNW2nYc
 85o19SGzbrDEFDd1EatRC1MnMJkozGQ25SL3vZi6efgejU5V+tXSOas3qVyEDPUGJhvC
 12OM08+hkSpAquy51n87iH/0ElzPwHHdhfSK5LoO+FO6yqpLWStFz65KyUhhYttEaA/8
 bCFPZGijem2eQ5reY0afuy9bsfYKfz+BMwmXbW8epZNJa+/LgMF8FJDB8stz30X0RIaz
 DEqv+GM7XKidT4qxIEYit7NEQL/M0U/ngfbmVdkKzEoChpAFUsUTL3QssQhvucP7w/v4
 mSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934080; x=1734538880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivfNURTgFhMHqj38K3J6R37tOZQ5Ck2WKrXXhbFBm8w=;
 b=EUgWvSW6qQVyCsAbgNo2v9Qp7r/e0P0Q7LkXV/eLWVrkYjbw01VKlluaAAZ8eIYZsD
 OYPyAr10Y+eXpbqF35Uh+pHOMa+XaKYm/xPLP06NW9R98PnLcaiVjY4rlwvQfnUHCqmV
 rjCJQX5oaqy+08LjyZnaml7k5SyFb318bjeCfQjtNSCRgf3TQAm8b+lCpPgPlhYc2ok+
 tHvwaDTm+8rQt3fCjngWZmlKm9X1RZ/wSuKcQY0jl2BiSDVtOA3nJBXJXAB+m/jDFxOe
 vRGEu8Gu4bKUXBV7XzCgCHHW3P4BGHOzKlXK+QBc00/i9i6eGyuizKhnmeqKZBQg9PsL
 Py8w==
X-Gm-Message-State: AOJu0YyswZDx2vn1Pdm88+PhoTCwDY/ui0fv39qkaQi6QRoB0XlFwZou
 Hr7cxZ7PA/jjsIf5qum6xR+99N42E9Y67NN1iPXjDp+4nsTqcPCOULB71lWQemTdLzyCwU4Tcum
 7
X-Gm-Gg: ASbGncu1HQ3WAqk4EXvGdZbWuZHG0A0T3b5U5l+Ojr1uxnX8D2vnLrTWgB9Pz2acBNd
 xQSZBCPT66AcP9H6tATw6+tzCgq1hgwHzfWzkbaNlE9O75sPmOkMR60YMD4b0UxBIJ6kFh2wNmM
 auwwTaPM197MJYARao7r+jN/LqPqRjcOfBhUKATL72RSwdt3F6/FfZQCGPIrgeqrEdaycFK9CVV
 LNv7DlB+SBera7KChORkhkPMhZxHV+ZM0E1f+4CpIbGIAuw6lhUQe2d7H9W
X-Google-Smtp-Source: AGHT+IH/j41N+1em0an4n1ByvJ4sCgqnN4zBxlc0ReR/6oseWKCCDSjjNzzKeGg4qd/9jfwETmMXuQ==
X-Received: by 2002:a05:600c:1e89:b0:434:9fac:b158 with SMTP id
 5b1f17b1804b1-43622823874mr3173695e9.1.1733934080402; 
 Wed, 11 Dec 2024 08:21:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/72] softfloat: Use parts_pick_nan in propagateFloatx80NaN
Date: Wed, 11 Dec 2024 16:19:58 +0000
Message-Id: <20241211162004.2795499-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Unpacking and repacking the parts may be slightly more work
than we did before, but we get to reuse more code.  For a
code path handling exceptional values, this is an improvement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241203203949.483774-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6ba1cfd32a0..8de8d5f3425 100644
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
2.34.1


