Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CC4E74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZh6-0001c8-6c; Tue, 03 Dec 2024 15:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgi-0001SM-WE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:06 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgh-0003CB-D3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:04 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea49cc8b88so3034783b6e.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258400; x=1733863200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KydR7DthtTuF26Sa++zJDQx95A57XILxzyCBnopfb7Y=;
 b=vzGecq+LZKxbqMgehCDzmK0dbnPbzPu+FG/gjxG1geq1Lprl52OX+Bc7kv8tJ83Yu8
 OvKrT3PtjcDk3vO4U3Ds54WeS0zajM31SXWwZEOiwromhdjKz+HGLCD60YXqO7aFZDW4
 M8X7m0Zhl3fcY13yURWJhWzY2b2bg3nC1aUVJaF7ZxauOOWpLao2w4HnlpN/qFfxytW8
 SVgP9zDSiFu/vT3hgFelneBJkd8cDt/koieSfa37zT1IUqo19xNVIwYZrK/BqZDByK+k
 o5dd6yMTGtZ6/zhfRHETn9cF6krz998fxNvFPGHyAe/ffIKWwtC5sc4WYFHGocfdVII8
 mUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258400; x=1733863200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KydR7DthtTuF26Sa++zJDQx95A57XILxzyCBnopfb7Y=;
 b=rtn44EsQYqTq6bMv1jbsxXl2QhXdGDF8chVNAQs06l4z/QnIh++GdwLE7SHzG6xVmA
 u0CDTN8EpoKykXAvNNZvd0t7n41z1n/RuT3VzeWD8cwO4nWi0rkU86UiSyDvQpCLn+Xw
 ff2n3wjL3jI0dFCKBOigX2qTNwB0OGKqIZvDat9/i9BiQRXK/BBK0PKlHEwI3tMjNnF7
 EovgBwN/SBwBDpJmjWpHSCFo9XoL/G9NMdtJrEBB7pNXPjgyfEAy28jJBiu8/E9zC/Qa
 dnSNLuxRGdw994POX0NHNK4Ou/vAwyAFFe277eZpQzZXcDDE25WXz/hMLPVrfxwITqo9
 O2pg==
X-Gm-Message-State: AOJu0YxkrV4dJXRaGieHNWr0sgAh4p5+wsbBYz6v8NzyCGWvl265x29T
 BlDt41iv1p8Itj58+g3mEfQsTnS8T1xt/jhFs5jeuMKZpPhlXrc76b66yp9pNDpDm8pgqA4Un23
 ZK9g=
X-Gm-Gg: ASbGnct+6HyMNSdSlCXv6o5QOX5q3fNf4KeERqc5gbYSRl+I+aWH4ZtF3T6sETo+YB0
 58313Wg4EqIw2bGm0R3Aa0peXLIBCvYJEfOVRMCMBSHYuDhDNQHD9z4gCQbnA9MW0iEfz/ocIVA
 KJT4AgmPN7KYrqcKNpofyGBTqsN6uTZIg9bbrQ7JlPYmfUgtxPWypfigwzMdfIGMsS5uPcwXOlq
 Rj6iK+p/qS9mbIEeSYgjStbgHaQUTOpLIqsEm7VhRHU4JZqGFnVCaiUxdttN/7DKQMO1tLi6UTK
 +eaf75Cn9fKBpSB7GaK6vDg1pp5rJmfdnOLZ
X-Google-Smtp-Source: AGHT+IEmBZelmxcyorYQDlDbrjlVFtWUngVzI4bXUe5KgnJqx2l+83M8zRiQT1hqUMC0wfpUSXHb4g==
X-Received: by 2002:a05:6808:191e:b0:3e7:9f1f:b84a with SMTP id
 5614622812f47-3eae4f87a19mr3559095b6e.21.1733258400045; 
 Tue, 03 Dec 2024 12:40:00 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 09/11] softfloat: Share code between parts_pick_nan cases
Date: Tue,  3 Dec 2024 14:39:46 -0600
Message-ID: <20241203203949.483774-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

Remember if there was an SNaN, and use that to simplify
float_2nan_prop_s_{ab,ba} to only the snan component.
Then, fall through to the corresponding
float_2nan_prop_{ab,ba} case to handle any remaining
nans, which must be quiet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index de51097dcf..099f1c48ef 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -39,10 +39,12 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
 static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
                                      float_status *s)
 {
+    bool have_snan = false;
     int cmp, which;
 
     if (is_snan(a->cls) || is_snan(b->cls)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
+        have_snan = true;
     }
 
     if (s->default_nan_mode) {
@@ -57,30 +59,20 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
 
     switch (s->float_2nan_prop_rule) {
     case float_2nan_prop_s_ab:
-        if (is_snan(a->cls)) {
-            which = 0;
-        } else if (is_snan(b->cls)) {
-            which = 1;
-        } else if (is_qnan(a->cls)) {
-            which = 0;
-        } else {
-            which = 1;
+        if (have_snan) {
+            which = is_snan(a->cls) ? 0 : 1;
+            break;
         }
-        break;
-    case float_2nan_prop_s_ba:
-        if (is_snan(b->cls)) {
-            which = 1;
-        } else if (is_snan(a->cls)) {
-            which = 0;
-        } else if (is_qnan(b->cls)) {
-            which = 1;
-        } else {
-            which = 0;
-        }
-        break;
+        /* fall through */
     case float_2nan_prop_ab:
         which = is_nan(a->cls) ? 0 : 1;
         break;
+    case float_2nan_prop_s_ba:
+        if (have_snan) {
+            which = is_snan(b->cls) ? 1 : 0;
+            break;
+        }
+        /* fall through */
     case float_2nan_prop_ba:
         which = is_nan(b->cls) ? 1 : 0;
         break;
-- 
2.43.0


