Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5BFE74AD1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZhG-0001me-ME; Tue, 03 Dec 2024 15:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgm-0001Vk-Vf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:09 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgh-0003Cv-Dg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:08 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-29654932226so118749fac.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258402; x=1733863202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxwQYUCgdJ75izA3vVBTRu+vsh+0fdcxFYY32CHBmJU=;
 b=M13DV7xsaUuByWP1UsVF5CXtH1nUYLSP7gUMyX1yHbuHa84FFts7CpdnMb9uitZdTG
 TlaO4dhbL1te4yxkSD+oba/8KggLvLTQvDK2uaKNQNiYlBfi633H78o4k9hj/uD0HU9r
 bPSfBS3d6YYSYwFUwHHDFZ5QE8oXmmWIzDdGtfddNUxZPbSW0aaTWYTArimhvwyOLnCW
 KGYIjo1oq0nk1eSVcxf0HKcH2OozQUI0aBuSWh9L37IaXeaPWFLWO7rh2Qlkmdi9zEmD
 t4Eh+a7GWTfDjqPrELyKbgVpJ+QcvrAQ0t1S7LyNEl6po++tveUAqU+PxRwfrVX0H/6J
 m1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258402; x=1733863202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxwQYUCgdJ75izA3vVBTRu+vsh+0fdcxFYY32CHBmJU=;
 b=hg5L0VkYMBL8gM8aHpOjWnHRaT1UMPtFD1WbZrXDxDhpVy2Qm9vWvImQL6IYJp1xVF
 dmDQYHpSwhBrNZee2o0vTas/97EuBpF4iy5sQIwuzfJVu86XLT7gjicqUom0DXb50m74
 i9OQbcUDmBknxGqe2+5WBcHeogE0WnwQOyYC5jORNpF2PUM+e8aiibJxX+CirSq11yQO
 4DJ8hNRWeCU7eXrKdZsQAl6b/BpaYRJcWsONfQLoMpJJn6ANq/b8JAfmA7O5t9dPHguo
 hBirA4bXvqDV52q801qpizq0U5TkjHYa+l8COUHCyvaA4mJdzKefqtbChrCRo4wy5eZ4
 d9Gg==
X-Gm-Message-State: AOJu0YykpXT1hn0KlsMdx3q9er/sP5oETQf4GRlENfOXQ0MoMRZMS0CF
 3Vkt2NEpDpML+v+/QcCa0FsE2I9S3GPhFD70OLFD4GbTqVGHMOMfWrZ2TYDxn5EfA0TAkkKSUOj
 Jaj8=
X-Gm-Gg: ASbGncuxr2EzqemT703u6twBnMrdTajRpIo02/SYS/R26x1QuZ3qAgr4f/OUhhYVAun
 IZQJq6QkRBdVw+93+RETkHEipmHpj8mAtzB2VdkRwaacMglkuLSX9PKxsSOOBZgJjzXQaE/0zpj
 TUdx1pT/GurbBF1nlXbwe/AGv5u7sgKMt/JqiHeiw0OLW3lf3lriVxSygIo+1xWfrGXzHpVUD20
 qENT2peDS54FuAWJ9ngmH9iGX46I/J49+rUXlszJSuIyIRHemYHYN/BhyZ3p5S0Y/0SDDi1GHHC
 tDQI/2tW7k5W2M/3vX8sOxVu+cV2IdyRuS3W
X-Google-Smtp-Source: AGHT+IE/ZDBdAavAcG/lUIhkIGCyMcS/8nmmcngxyXbY1XgLm4ZvLEjWHHlJBN3tLrMs88cKkei/pg==
X-Received: by 2002:a05:6870:c14c:b0:29e:37af:a943 with SMTP id
 586e51a60fabf-29e88b5a9aamr2422020fac.18.1733258401824; 
 Tue, 03 Dec 2024 12:40:01 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:40:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 11/11] softfloat: Replace WHICH with RET in parts_pick_nan
Date: Tue,  3 Dec 2024 14:39:48 -0600
Message-ID: <20241203203949.483774-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Replace the "index" selecting between A and B with a result variable
of the proper type.  This improves clarity within the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 9a2287095c..e51c9827d9 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -40,7 +40,8 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
                                      float_status *s)
 {
     bool have_snan = false;
-    int cmp, which;
+    FloatPartsN *ret;
+    int cmp;
 
     if (is_snan(a->cls) || is_snan(b->cls)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
@@ -55,21 +56,21 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     switch (s->float_2nan_prop_rule) {
     case float_2nan_prop_s_ab:
         if (have_snan) {
-            which = is_snan(a->cls) ? 0 : 1;
+            ret = is_snan(a->cls) ? a : b;
             break;
         }
         /* fall through */
     case float_2nan_prop_ab:
-        which = is_nan(a->cls) ? 0 : 1;
+        ret = is_nan(a->cls) ? a : b;
         break;
     case float_2nan_prop_s_ba:
         if (have_snan) {
-            which = is_snan(b->cls) ? 1 : 0;
+            ret = is_snan(b->cls) ? b : a;
             break;
         }
         /* fall through */
     case float_2nan_prop_ba:
-        which = is_nan(b->cls) ? 1 : 0;
+        ret = is_nan(b->cls) ? b : a;
         break;
     case float_2nan_prop_x87:
         /*
@@ -85,35 +86,32 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
          */
         if (is_snan(a->cls)) {
             if (!is_snan(b->cls)) {
-                which = is_qnan(b->cls) ? 1 : 0;
+                ret = is_qnan(b->cls) ? b : a;
                 break;
             }
         } else if (is_qnan(a->cls)) {
             if (is_snan(b->cls) || !is_qnan(b->cls)) {
-                which = 0;
+                ret = a;
                 break;
             }
         } else {
-            which = 1;
+            ret = b;
             break;
         }
         cmp = frac_cmp(a, b);
         if (cmp == 0) {
             cmp = a->sign < b->sign;
         }
-        which = cmp > 0 ? 0 : 1;
+        ret = cmp > 0 ? a : b;
         break;
     default:
         g_assert_not_reached();
     }
 
-    if (which) {
-        a = b;
+    if (is_snan(ret->cls)) {
+        parts_silence_nan(ret, s);
     }
-    if (is_snan(a->cls)) {
-        parts_silence_nan(a, s);
-    }
-    return a;
+    return ret;
 }
 
 static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
-- 
2.43.0


