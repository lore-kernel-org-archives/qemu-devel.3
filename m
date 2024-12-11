Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77088E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSy-0002EY-EM; Wed, 11 Dec 2024 11:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSp-0001XS-A2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSn-0007ux-GR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so6285435e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934084; x=1734538884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E85lj8XRhj/Fk3RQPB/aLYeRqkABA8VMdndxVbT9joA=;
 b=mqD6/oj+XSZNoVUCkC0+isFlnMbSzIcX+c+HNJlL8hBXVYC0OWGB3mD0RtDlXvrnUL
 PsjFX6O9A37As22gLkvN/tAfYY0nZFczVnRD72ZBA0f6iQDY5qXJ1GhXgLaJd6SN3yYx
 G29NxsLkit/3Rro/JjbydmEfY2hX9xvZ0avEZeeBVyeLe647FaKrFOBaQAU3fo8PZ9j0
 vWNFo7ept3+UxuDMzae9QDGWrYk96kgwm7ikaY0vpBPkRaO2l1b2q5B7jDuxgFHRCkO1
 Yfn4QUV5X2rhZYpBAJ2a6RB9lo+rzMe2RihwFczWSUSdvdEFvXCisG0T/xNzLXnujRei
 /myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934084; x=1734538884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E85lj8XRhj/Fk3RQPB/aLYeRqkABA8VMdndxVbT9joA=;
 b=H8eF4aueI66PEiBXrpPls2I7V7I8LOXF22y3snvKBQKq7kLX9UxCikGWtfFJv4rwBU
 y3vBVzXuBovzcesRTc+2tbUxQCmyWzQo1pxXMGiYEgk5kCMgmvHZlG3kNHcfcByz0dD1
 yRXKmrsnNHdneoTcfPAgQ9YDmOUvVApA/a8TCiH1E79lt9+u4e2jLchTC4Xii4tcD9M6
 pD+JfCfJ3tTUAb/l4T0NtI6QGsVW1vNI0FRAxd8HhAIbHtU+50/JqW9EPLE3O+rAJowq
 ziMPwAz7HkzJ4J5n7twdsNUU7JwuLogLuWkIAxb675bPquFloaNq2ltBtxJvkuCdK2Il
 7e+A==
X-Gm-Message-State: AOJu0YyNTEm7agtE70uY967UkJ4p/gT+NJ+7Aumv0zfi5nCryEy9TR97
 nfZPfUvHGccAge3sUP+9lVmM1v78pH/znYPbjbyGH0Yi7l1wHfZJVjhYeQEVPWkusj8xCrWplVL
 a
X-Gm-Gg: ASbGncseOvAVUw//tbOpsqJ1lOkfuWYheTALBOC8E656AfVvM1FEaYoLAhWfWSBoB1J
 hePme0SGqpI9Zi3GoByF6a+HoKaZCwQSyvRY6sSJhvv1oJeezToVtHAG8EGkdJ3vAm6Xc/r26nD
 NJ9ac7PTrgcnDWDJsDEongzIpluGj9iztYPRLOujYeuBj2t38hHRx9q4aKt88Pf1jU3bpDeCFo/
 ygv+NW5nRvo9d6ij/8UWmU/B0u/kLsQheT7nG7lmHUKeZtKHL06n2SoDPng
X-Google-Smtp-Source: AGHT+IHi5cWI9HumJccejp+wfPPknBU5WEKTBa1FEGvsjA+YUOV6I/k2m11jg3kEUIWFYlpsCdabRw==
X-Received: by 2002:a05:600c:4e50:b0:431:5df7:b310 with SMTP id
 5b1f17b1804b1-43622832e88mr2983255e9.8.1733934084148; 
 Wed, 11 Dec 2024 08:21:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 70/72] softfloat: Replace WHICH with RET in parts_pick_nan
Date: Wed, 11 Dec 2024 16:20:02 +0000
Message-Id: <20241211162004.2795499-71-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Replace the "index" selecting between A and B with a result variable
of the proper type.  This improves clarity within the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241203203949.483774-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index abe24aeaa00..ba8de7be76e 100644
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
2.34.1


