Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7252CE74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZgu-0001Yb-1e; Tue, 03 Dec 2024 15:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgb-0001Ko-Q0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:57 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgZ-0003AX-M0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:57 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-27b7a1480bdso2774599fac.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258393; x=1733863193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65/XNqGZ6VyYj6rTQSJdOtQFVcZddgAeG+CbEFdXJAI=;
 b=Kix3gkYbq+x93L9YAiQeXSK5emG2+IlSaUQ43X+E/y9+JO83VAZ2cdik22C7pJEC6G
 Mo+35IPs5mIFSmvY4GZ+IgW1OHio5r0rp0pJHeskot0PAxkSN+MpOQ5ufhy3fgvnQY1G
 2hH9LdooY1LgCMTmrHUEA8qoz3dC2hRRM+E+wonhm8AvDvNe9AxAao/f7UpYI32fcUUr
 2IfTW56LM36bZoqbEl8cw1M50WL5iO8D4jRrUXfwpubWsErincB8D1tH0fY3YkiirvEg
 7CVWJC3N4FrCst2PbMsrpp/955419Vt8TBA+N5HcAWMuVjnEVIe3xNWH8Z4Jp2BkOYFA
 IYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258393; x=1733863193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65/XNqGZ6VyYj6rTQSJdOtQFVcZddgAeG+CbEFdXJAI=;
 b=PeWD84dtaCFRrDocsiwjqBPoQ4Q8jMXYIFijuouNDnIMHCVXHkCbFKQW/cPOfJjKEJ
 ObZqfDYw5YcYjSEAWM+LUgbogTrKhCnISuHrig5E2H0UUNEGuNqfOoirUWzAF5RXS0dJ
 nDyp9f//V0vWfL/T2ahcMxZSFvTcPkWsgzpPKDOMZGgHrIB+c2rr8ukqZmNlBxCDaaV7
 ZZegwctE1Ue576orYddX0SlSuzdN6LbQuDCo4ftELDOp6fjAOOekDWZFIXsb3Ixdbccc
 wzwdto0XMT6Q6Dt1aUuYHbtV6DN9dj1ho14TaLICFKwguTyV6Ztb7iD8MwiQw8ErpfFg
 iH+g==
X-Gm-Message-State: AOJu0YxCYR148TGxL7if7J66P7xiz34e6GYY0Jq5PF2gQD3YUNiCAJUV
 WEQddbv1Qa6GYxveWRvRU2EHaRFBjRoDgVxkPsIrmBEQnbvlEZqmfiqMQlH7kV3u+FASvXsn7zQ
 04gQ=
X-Gm-Gg: ASbGnctM5RbySmeDe702j7MgpsgVbXg0nV/594wCE+kMssFBKWE8UCycRVBOy+rnMyT
 sQ0crIt5QBdEYrfA1U88AGL1FkLcU2Ywly6o8MqMWrJXc6v/9TYMWVZpHzkXE+od2EAtpT6b5NA
 cc5ymog5cTustnTYoOnqACD5tqJ3r7j7BAk+J2jgKYCHGmTjvUKnJy2C+Rhbofb5EMjmr0Sh5F8
 /3vuTBz/P/jGlVcTh7pJmBUkTmqy4O7iHz+ZyHX5SRsdEfs75m/wq4qY3EXP9gdu63MbDMnxRTg
 fsU1VXbL6jS5TSTU+i25WKlZWjSCmflpjB3e
X-Google-Smtp-Source: AGHT+IHmOVU3M0g9apA0UOsHEpsItgqERa8IA+AD+plf1CfdoB3FiNicEw76xwwc5l3ZbG5y4GkgvQ==
X-Received: by 2002:a05:6870:3913:b0:29e:5e83:150e with SMTP id
 586e51a60fabf-29e88885e8fmr3919454fac.27.1733258393185; 
 Tue, 03 Dec 2024 12:39:53 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 02/11] softfloat: Inline pickNaNMulAdd
Date: Tue,  3 Dec 2024 14:39:39 -0600
Message-ID: <20241203203949.483774-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Inline pickNaNMulAdd into its only caller.  This makes
one assert redundant with the immediately preceding IF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 35 +++++++++++++++++++++-
 fpu/softfloat-specialize.c.inc | 54 ----------------------------------
 2 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 655b7d9da5..f5c6b21fee 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -80,8 +80,41 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
 
     if (s->default_nan_mode) {
         which = 3;
+    } else if (infzero) {
+        /*
+         * Inf * 0 + NaN -- some implementations return the
+         * default NaN here, and some return the input NaN.
+         */
+        switch (s->float_infzeronan_rule) {
+        case float_infzeronan_dnan_never:
+            which = 2;
+            break;
+        case float_infzeronan_dnan_always:
+            which = 3;
+            break;
+        case float_infzeronan_dnan_if_qnan:
+            which = is_qnan(c->cls) ? 3 : 2;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, have_snan, s);
+        FloatClass cls[3] = { a->cls, b->cls, c->cls };
+        Float3NaNPropRule rule = s->float_3nan_prop_rule;
+
+        assert(rule != float_3nan_prop_none);
+        if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
+            /* We have at least one SNaN input and should prefer it */
+            do {
+                which = rule & R_3NAN_1ST_MASK;
+                rule >>= R_3NAN_1ST_LENGTH;
+            } while (!is_snan(cls[which]));
+        } else {
+            do {
+                which = rule & R_3NAN_1ST_MASK;
+                rule >>= R_3NAN_1ST_LENGTH;
+            } while (!is_nan(cls[which]));
+        }
     }
 
     if (which == 3) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index e075c47889..f26458eaa3 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -448,60 +448,6 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     }
 }
 
-/*----------------------------------------------------------------------------
-| Select which NaN to propagate for a three-input operation.
-| For the moment we assume that no CPU needs the 'larger significand'
-| information.
-| Return values : 0 : a; 1 : b; 2 : c; 3 : default-NaN
-*----------------------------------------------------------------------------*/
-static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
-                         bool infzero, bool have_snan, float_status *status)
-{
-    FloatClass cls[3] = { a_cls, b_cls, c_cls };
-    Float3NaNPropRule rule = status->float_3nan_prop_rule;
-    int which;
-
-    /*
-     * We guarantee not to require the target to tell us how to
-     * pick a NaN if we're always returning the default NaN.
-     * But if we're not in default-NaN mode then the target must
-     * specify.
-     */
-    assert(!status->default_nan_mode);
-
-    if (infzero) {
-        /*
-         * Inf * 0 + NaN -- some implementations return the default NaN here,
-         * and some return the input NaN.
-         */
-        switch (status->float_infzeronan_rule) {
-        case float_infzeronan_dnan_never:
-            return 2;
-        case float_infzeronan_dnan_always:
-            return 3;
-        case float_infzeronan_dnan_if_qnan:
-            return is_qnan(c_cls) ? 3 : 2;
-        default:
-            g_assert_not_reached();
-        }
-    }
-
-    assert(rule != float_3nan_prop_none);
-    if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
-        /* We have at least one SNaN input and should prefer it */
-        do {
-            which = rule & R_3NAN_1ST_MASK;
-            rule >>= R_3NAN_1ST_LENGTH;
-        } while (!is_snan(cls[which]));
-    } else {
-        do {
-            which = rule & R_3NAN_1ST_MASK;
-            rule >>= R_3NAN_1ST_LENGTH;
-        } while (!is_nan(cls[which]));
-    }
-    return which;
-}
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the double-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
-- 
2.43.0


