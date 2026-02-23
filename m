Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D00E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRCq-0001xd-3e; Mon, 23 Feb 2026 03:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCo-0001uh-2l
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:14 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRCm-0007og-DJ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:13 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so17821055ad.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834931; x=1772439731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WILaMGNYgo59ciXOv8fCSdPpQjQ/av9tdzjHB1/JF6I=;
 b=lf384EcY1AT7BV1P5rip8nSAi4yqamo+4akZyRWPL+NzhefukGG3RAN0hsptElpVfN
 nqe562SY60rvHCuoBoq1VBNuH+YVExfcoC+svVw+m3sge5GTwyu0ZvgRlDGkjsxxN3gf
 JZhCour4EBezGj4SEDrx/p6vOrJ/XciPqsXfxbmDycKvILkKLK2yW5AISRMxLi+EDinb
 a7gU1ceJBqnN/ksNerux7b02R3pQ0dXD5uYU/UhrGvIgl7qioSwu/DHNPHk2Q4yABmbZ
 cA09ZBTWMBOow/AZBhNKwofWbvHC4PIyy7Kgc5PL6TP0j9IhX33X49T8zts+RpGs3H7c
 tsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834931; x=1772439731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WILaMGNYgo59ciXOv8fCSdPpQjQ/av9tdzjHB1/JF6I=;
 b=uwULEIEXX4QU9X+aBZAX9sq4Xr9YXXgQepEsVs15TOFvrVWMib8uB3DDG94YjbAgUU
 hX1vOABvxQUpTZKtVCuY6dkMZXCzbLNHldeB5YFySYBbQU4mQRurnKDnvkFw/L+eKHp5
 02XclMCkKdsWsAMdhZOP+Qu9NNWV7DSm5MBk0VR2a3S+IfyvUIys9pKt0CsjKzURAYyg
 nTe4gtaLxr9S6tDUL4jAYj8gxOohlghD9Lq7GzmBXepAx3WoWHK/GPQz8QutTBGLhqtm
 kAVIBeSv+++cRU8K7iG75Zciv3jY/EE+x1a15zqp11Cwftp7wJjEmX20MkwvKaNzpl2S
 XhTQ==
X-Gm-Message-State: AOJu0Yz9VxDdUztEy/5Rx6O1ckY1pCgZhnj7TgHuSLTyB5iRFCQ3pz0y
 +Ct3UQ5REUqBXVJ7sv0+OnqIEFc2xc6q+IOu9lnSUM7d7JKyF9TQR1P4Uf5WjR2HQtDKWODmNGp
 PvQ1vHONTyQ==
X-Gm-Gg: ATEYQzxa1teJAm5F+UFknTXPszdajMbabEccJ6XwU/3Cz/y8/WlQJUUPdVWnfabkuCk
 yHFC0oi7nm1qJjVSUpNZE0TqbjdGQtJ9ttXA54eRzhnZyqqCHG4UQ8m4xrFQIRJ6fahA+g3k8NN
 c1UHzzcWwcMEiCu3xzEHoXAvuUK5ed0gfvpfdLXcDfV77mrqf3ghLD0otL4WqLqJcY7TV4B7OyK
 7AAj9yldWzrn5WC84H/p5v6iI/FqJ3FSymAckVxicqY9zb2InZw23EpKH9D6BvC+IRNHE/ECscl
 bBuWmCu0KCAXs68422YJojaLiOjrzo5LUIOoyQNsKsPm05/erNqDQZLpih44X4NUqNyyf9/GL0/
 iULAspmnBkAhGS7rca38mzOyitIbSm0pQXjzNsZ4bdPfAU+wUGq+BAZeXyat6afnkhXTFi3sISa
 abTITHk9nt+PHbxhcIY5Hj/DMyOA3x/XYokVxzGVPafPbVWMcWzK+bLLTlBmsQZ5QWHg==
X-Received: by 2002:a17:903:13d0:b0:2aa:d5e8:f4dd with SMTP id
 d9443c01a7336-2ad74463ebamr79008715ad.15.1771834930930; 
 Mon, 23 Feb 2026 00:22:10 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 2/9] fpu/softfloat: Refactor floatx80 format NaN
 classification to share code
Date: Mon, 23 Feb 2026 19:21:47 +1100
Message-ID: <20260223082154.5623-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223082154.5623-1-richard.henderson@linaro.org>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

From: Max Chou <max.chou@sifive.com>

The floatx80_is_[quiet|signaling]_nan functions contain duplicated
logic that should be shared.
This commit introduces floatx80_nan_is_snan helper function that
determine if a NaN is signaling and change the return type of
floatx80_is_[signaling|quiet]_nan to bool.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260204051756.667397-4-max.chou@sifive.com>
---
 include/fpu/softfloat.h        |  4 +--
 fpu/softfloat-specialize.c.inc | 53 ++++++++++++----------------------
 2 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 66b0c47b5e..69b9041ef0 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -978,8 +978,8 @@ floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
 FloatRelation floatx80_compare(floatx80, floatx80, float_status *status);
 FloatRelation floatx80_compare_quiet(floatx80, floatx80, float_status *status);
-int floatx80_is_quiet_nan(floatx80, float_status *status);
-int floatx80_is_signaling_nan(floatx80, float_status *status);
+bool floatx80_is_quiet_nan(floatx80, float_status *status);
+bool floatx80_is_signaling_nan(floatx80, float_status *status);
 floatx80 floatx80_silence_nan(floatx80, float_status *status);
 floatx80 floatx80_scalbn(floatx80, int, float_status *status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 7d2515c1fa..9ed968c79b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -357,53 +357,38 @@ bool float64_is_signaling_nan(float64 a_, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is a
-| quiet NaN; otherwise returns 0. This slightly differs from the same
-| function for other types as floatx80 has an explicit bit.
+| Determine if a floatx80 NaN is signaling NaN.
+| The MSB of frac differs from the same function for other types as floatx80
+| has an explicit bit.
 *----------------------------------------------------------------------------*/
 
-int floatx80_is_quiet_nan(floatx80 a, float_status *status)
+static bool floatx80_nan_is_snan(floatx80 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return floatx80_is_any_nan(a);
-    } else {
-        if (snan_bit_is_one(status)) {
-            uint64_t aLow;
-
-            aLow = a.low & ~0x4000000000000000ULL;
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (aLow << 1)
-                && (a.low == aLow);
-        } else {
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (UINT64_C(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a.low >> 62) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
 | Returns 1 if the extended double-precision floating-point value `a' is a
-| signaling NaN; otherwise returns 0. This slightly differs from the same
-| function for other types as floatx80 has an explicit bit.
+| quiet NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int floatx80_is_signaling_nan(floatx80 a, float_status *status)
+bool floatx80_is_quiet_nan(floatx80 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        if (snan_bit_is_one(status)) {
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && ((a.low << 1) >= 0x8000000000000000ULL);
-        } else {
-            uint64_t aLow;
+    return floatx80_is_any_nan(a) && !floatx80_nan_is_snan(a, status);
+}
 
-            aLow = a.low & ~UINT64_C(0x4000000000000000);
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (uint64_t)(aLow << 1)
-                && (a.low == aLow);
-        }
-    }
+/*----------------------------------------------------------------------------
+| Returns 1 if the extended double-precision floating-point value `a' is a
+| signaling NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool floatx80_is_signaling_nan(floatx80 a, float_status *status)
+{
+    return floatx80_is_any_nan(a) && floatx80_nan_is_snan(a, status);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


