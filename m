Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A718E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRz-0000Fz-30; Wed, 11 Dec 2024 11:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRx-0000Eu-FV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:33 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRv-0007hi-UM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:33 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862df95f92so3517423f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934030; x=1734538830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nW62S+pVfkUdfFUsUNvfDmxePuMcoH99NH/YmsJ1zQE=;
 b=IQmp//B1M5m/LLL3lLE+aYajRK5RbEOXcX3InXu+1zOO8gWGH+Dt/DwNSmaCR9XuJz
 HRMTp0FoshksG0Ctipo2U1c9L94SG6uTM8lQs5suDvE5T0gVdmQwluc+BFn9bbqiYJH9
 izGkxFkyi0CtZ5PdhQitVY75pFmPOFYQiUbTle83p1CWmizBx0iRrLHhVSHHirJdKVB4
 qmbNEiQaLyWR/WzGWLgdJx6xhqvDioTdHDGQWmifwmjf6vYj6c7LYygFmA05NRGr7h41
 aOv+/PAln+vsnmqMr1kZiZdxC/Sc9O5QFLLTVF6KO0FPq04Sv6Fn6Wi9DpgCnPwK+dCu
 92ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934030; x=1734538830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nW62S+pVfkUdfFUsUNvfDmxePuMcoH99NH/YmsJ1zQE=;
 b=lGMo/eTxNUhNX+5n3IgDYLdi85OSa1P/s0gyeKuiETGHgU90ichOO24jM8v+SV5tZ+
 hMYKLPZEa5axZA6UsJfNcOHC7Zxx8Tlgah6nONP+1ziybJPV3/Gmgs3m5LkuJK+wq0GB
 SyjOMYvlWa7Wp9d7qoOMec3YflgbR0nTY1tcmdoEtgZtL9IgdI6lJj+Brq7KcXM5y+rf
 es71QGGX9+Snuu37N+P+jGlhynKHvc02JUKGsX3+OHJHpwM8YHD2t5AKxCKRnXZOtIP7
 LNzsH4xSYWUj1UMUK/+IS3XFbuUdRiAoj0oDZM0WGTTrv05nbOVNWH0vvcw5Wro/8iXD
 n6Sg==
X-Gm-Message-State: AOJu0YwoXO/n+8fjKrSvIPxHTVq/U3Ih+PP5fdMNGUt0VMQk5cqY2zWi
 A1F7aNHzKiy4yHcNResYtaPFj+s+RiJRTcQSz3E88FZRQXdp4WUL7v+ySk5iCvLMWOw2DSaBrsh
 T
X-Gm-Gg: ASbGncu5+t24Ik6aH+Ceamu6igr2pWKJvApfgviYYadrNKB7pKol7pGSeou+Uz6W7mN
 Gjezr2ZusngZ48U6//KzGDBzLATF0TXLkQqbXJCNM9WkxnY+4NNbbIH9k8U4DKMrXwyq35HMZAj
 XSY7NWWIiYDwPQiuFehbtvTGI+qO0QnkRRxCwfHR2ibLWZ6GNG8RTDSUK9xyeFvb8ul3rlbFFlM
 GNzbXixqbcCq8Ax0N9ncFn7dd0wTt8r533znXQxxc5fowcdKhjXjD7dbUI1
X-Google-Smtp-Source: AGHT+IGfYXP+8f2adh3PSnkie7B0YykCMdgzY/UnBerIBMyU6ix/iMdTEldDWAdLNJfyEW9+0wgpJQ==
X-Received: by 2002:a05:6000:4911:b0:386:459e:e138 with SMTP id
 ffacd0b85a97d-387876af35emr182149f8f.36.1733934030235; 
 Wed, 11 Dec 2024 08:20:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/72] softfloat: Pass have_snan to pickNaNMulAdd
Date: Wed, 11 Dec 2024 16:19:11 +0000
Message-Id: <20241211162004.2795499-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The new implementation of pickNaNMulAdd() will find it convenient
to know whether at least one of the three arguments to the muladd
was a signaling NaN. We already calculate that in the caller,
so pass it in as a new bool have_snan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-15-peter.maydell@linaro.org
---
 fpu/softfloat-parts.c.inc      | 5 +++--
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index aac1f9cd28c..655b7d9da51 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -67,8 +67,9 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
 {
     int which;
     bool infzero = (ab_mask == float_cmask_infzero);
+    bool have_snan = (abc_mask & float_cmask_snan);
 
-    if (unlikely(abc_mask & float_cmask_snan)) {
+    if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
@@ -80,7 +81,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     if (s->default_nan_mode) {
         which = 3;
     } else {
-        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, have_snan, s);
     }
 
     if (which == 3) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3e4ec938b25..a769c71f545 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -473,7 +473,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 | Return values : 0 : a; 1 : b; 2 : c; 3 : default-NaN
 *----------------------------------------------------------------------------*/
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
-                         bool infzero, float_status *status)
+                         bool infzero, bool have_snan, float_status *status)
 {
     /*
      * We guarantee not to require the target to tell us how to
-- 
2.34.1


