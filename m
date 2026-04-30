Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FC9FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEvt-00009P-PC; Wed, 29 Apr 2026 20:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv8-0007jZ-9Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:24 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv6-0001q5-L9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82cf636dac8so171848b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507579; x=1778112379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyGaCW7gD91Dm1boSLyd8Ffs2ydc5g5SItzum+VAxMU=;
 b=O7BHsI/2VsG94d+eA6rMgvYxb0gYMQsUzALdIEbJkt3LKDeWhAVITYermOJtlZaWLM
 yxMIHXWABOR3W9+60yyzOIh7ZB2LCH+Sg1j/JaXB1CKLG/wJOMS/LuVv6gK/ElmpImdv
 tUvRLwTmvtBCZY8g5ilxWn/RcI5ZQ8tWejPMvuLhxNy94Rwz/GCTXVSfncyO7yJg9cZw
 9QYV880p3CY/0JnC9mtsQ3e5cbrZFgFHXvjQsMPGHiJXtDkaTBOKz2+0p589g1r8T0Pi
 4MUOCM1nxg9I8cviVY9zoSpIygmOHcVKAuohFakiEw7ZUg5cyvzQjj+gkUdCR1HTUzxn
 tmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507579; x=1778112379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyGaCW7gD91Dm1boSLyd8Ffs2ydc5g5SItzum+VAxMU=;
 b=MfeNTfVsIOVH/7PXKbTiGlFL8+miO2tPzbWnShdqakBDQU9L5VrjrA33gP1wBbFMLG
 htXLSD18v9y6hzvVzfJ05CrRDJ1O2F6fYSPbkFQMaJTKcUz6hbrFD+lHjF0gPx1zqBBD
 hOJaHctWRRaZrw+5qPwVYJ9gZq82BwLy4+Is80gRDlCI0sLYZAhbAh+E9n81X06V5SOi
 5x4FXmQGoeocIZYpAxWCkKTe5N8zj4gHKqsr7jaHXvltLJ4zH9l+ZEVm9X9oPTl3UDgs
 KP4Q4lDxQ5bg0RvHnoF966N9sh2+cWqQQn/+eiNHLYuN5JJtlI6y2r3gG7Z0SDJyXBng
 nRlg==
X-Gm-Message-State: AOJu0YxEGh4hSL8TRKA+jusXjBVzAtejaK9ZeVIrUOvA1Zr8CXiS+FbU
 dN70c4tJET2p8FIpVUNHVVNlJa4j/o9O194Gdd4CtMqzVfb6tJ1gT9yLBhhHeesHiCM3sA0JHOW
 stwIgckE=
X-Gm-Gg: AeBDievg2vPrwod5uFKkqNNxEA+KxMIXW6vt071XkMzO8kbycgrmq0nJMsHaFehjt4q
 A5kdBZXC45trLR/VG3udxICMv2zQxMOOmmYNniWwgcHjqBZ/P6iGCFX2Ga/wEjP6d8ll8JHKEwm
 Om9mdtXBR4Wj9dAO7cWqLJKsm/LpAtO6EAFdYUmfTUmhc9X11HNu7HFJKDSMKMYBwWxrq4kmjOu
 G7mvMpPp+bpAFDDJXfJFsC1t1IeH3APFhUzDr0w1cn+k4RaO+KqpMYakvJFlT6qkRT2tP6qe1G2
 1f73I2sKd/av8RJKZiTRnpH+KF154yqsQtQDt5vV7zCT4v49WFa1+d6kV1sC42yA7R29k2/FFDW
 c2w9t3imCGrZMHtNcX6drE0+ODhbBRSH0+vEbRtINFUpryzoqy6oRuTJ9Iw8qrAUh968kVX7+rT
 AHfjnIve+TyEIdyJLTkd2sO9Ov8v5Wzgd0U/BOhY7x
X-Received: by 2002:a05:6a00:a10:b0:82c:e9cc:f62f with SMTP id
 d2e1a72fcca58-834fdb07d83mr765930b3a.7.1777507578755; 
 Wed, 29 Apr 2026 17:06:18 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 22/40] fpu: Return struct from parts{64,
 128}_pick_nan_muladd
Date: Thu, 30 Apr 2026 10:05:05 +1000
Message-ID: <20260430000524.56046-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 7d4b40022b..211ecdf114 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -114,13 +114,15 @@ FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
     return *ret;
 }
 
-static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
-                                            FloatPartsN *c, float_status *s,
-                                            int ab_mask, int abc_mask)
+static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
+                                           const FloatPartsN *b,
+                                           const FloatPartsN *c,
+                                           float_status *s,
+                                           int ab_mask, int abc_mask)
 {
     bool infzero = (ab_mask == float_cmask_infzero);
     bool have_snan = (abc_mask & float_cmask_snan);
-    FloatPartsN *ret;
+    const FloatPartsN *ret;
 
     if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
@@ -160,7 +162,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         }
         ret = c;
     } else {
-        FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
+        const FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
 
         assert(rule != float_3nan_prop_none);
@@ -179,13 +181,12 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        *ret = partsN(silence_nan)(ret, s);
+        return partsN(silence_nan)(ret, s);
     }
-    return ret;
+    return *ret;
 
  default_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    return partsN(default_nan)(s);
 }
 
 /*
@@ -698,7 +699,8 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        return partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
+        *a = partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
+        return a;
     }
 
     if (flags & float_muladd_negate_c) {
-- 
2.43.0


