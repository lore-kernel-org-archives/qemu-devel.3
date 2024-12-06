Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C500DE7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOnb-0002ZT-Ql; Thu, 05 Dec 2024 22:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOnZ-0002Qr-Oc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:14:33 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOnX-0004b8-VR
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:14:33 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f1f1da0c8eso484478eaf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454870; x=1734059670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jWsAgdjbqze/KpwUsly9HuM39GzG0bcUuYjHr9574Rw=;
 b=OYNiq7SvbKZWxL05Lw2aSvNRcoLZOYYyprq3a+1u9GDeGVGyr4OeKAbEbgo36eqY53
 szmO4Yc/X0i5e8kelSEQDaaU1o5xIR4lD8BmEMJIhPTrk/K6WdKLuXs+RinK+YIRXPsu
 86Q+FQcTDB4llrtFQs1F5EuWYfkbmi6YIrPL7Zo2EThsL610b4z1qhru8zbZMTnCNmJD
 Oe3LaiHDKgJ6t1nTiVPG9NtsgexMRdwC7tobEYwIyp3J2wuuVJHFn6yqxvBwep6rRlpD
 zVV9yvZkc8ZTsG9ejp1iqvljtY1h7GG59sObDIu0XAdKYP8Qr1iHthGJ29LUtsmptngu
 0a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454870; x=1734059670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jWsAgdjbqze/KpwUsly9HuM39GzG0bcUuYjHr9574Rw=;
 b=URVMipgrofAM84jYaJUwzDHe8+x1KebfjNbMHxoutKcny2qSmuUnTI12DhROetjG4j
 WFTp4T/nkFDjBDQIwgmmIavTXC4aAbphqcMi3dlkOzAjwmoy5VKHu+XCPxwLExq5vKAR
 +cGB7L/vMtAbsZc28CugnViAcKCaBDXbTq1+KYrDqbrD8/qfMm7++ha1P34Wq+b3znA2
 SVOdYnBGBC7alRFE9n3IjdoGvHsaIuG+rDl1IH6hNz2I9sipfopqzNoreguRFbzZ98ka
 fgEpfTTp1hp9OhFo+k9+afCO+ifNyax+W10G9Zm0ShACL9eJgoMBqs18tMysEcrwCkCn
 SXWQ==
X-Gm-Message-State: AOJu0YzFVCyFCyQggL6tX7cS86Zkk8tdZUlnQR5OZCiM5srYifsBjfrV
 DeHBMblXC8i87echO95lNB0BqPjGMH9o3u5JQe9AiKdEALSJ9TvcquR0IobLfBjlTJlSjl+sSxz
 yzJmwih3y
X-Gm-Gg: ASbGncuT1TsdIjsnso5UW+1mzn94X0rAlKt8wUClY18aD1+kwZZuKjhs0Om9EkqrVXz
 Vig7IfBAF8EosQC9aQf5GC6bfCb0VwbV9C4GmE3OXiZ6hNisEqgaPy7tpbHwun8pYEfJ5kJOW7n
 P7MLR8gPKcGl+7DNFsHK6RBUybHlvrh6AhTgx0gJcnIR8SLGaA431uwJ9PsphZKnV3VnufDte0I
 7KouQLzHzPPx8pFrjUScgBZ40zNQjLQVuPrn4IFnvq9AWEPTMDN4q43vTbJ6j3G1xL/387X9W9c
 uZcM3XrMZKSiCZU2FM7BknNqQhyhfjtUkK/p
X-Google-Smtp-Source: AGHT+IHarJXdcrsJKaw/JLAoVlmBlTR6TWMJLrb6L4fqBPiE+eq5npoutdY9ZNTJyu4dx2mP7DaLzQ==
X-Received: by 2002:a05:6820:607:b0:5f1:e3d1:b994 with SMTP id
 006d021491bc7-5f286b74c1fmr1030055eaf.0.1733454870582; 
 Thu, 05 Dec 2024 19:14:30 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793249e8sm548936eaf.39.2024.12.05.19.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:14:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH] target/arm: Use float_round_to_odd in helper_fcvtx_f64_to_f32
Date: Thu,  5 Dec 2024 21:14:28 -0600
Message-ID: <20241206031428.78634-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

Softfloat has native support for round-to-odd.  Use it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 1daf3f27c0..ff48bac1a8 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -386,23 +386,13 @@ float64 HELPER(frecpx_f64)(float64 a, float_status *fpst)
 
 float32 HELPER(fcvtx_f64_to_f32)(float64 a, CPUARMState *env)
 {
-    /* Von Neumann rounding is implemented by using round-to-zero
-     * and then setting the LSB of the result if Inexact was raised.
-     */
     float32 r;
     float_status *fpst = &env->vfp.fp_status;
-    float_status tstat = *fpst;
-    int exflags;
+    int old = get_float_rounding_mode(fpst);
 
-    set_float_rounding_mode(float_round_to_zero, &tstat);
-    set_float_exception_flags(0, &tstat);
-    r = float64_to_float32(a, &tstat);
-    exflags = get_float_exception_flags(&tstat);
-    if (exflags & float_flag_inexact) {
-        r = make_float32(float32_val(r) | 1);
-    }
-    exflags |= get_float_exception_flags(fpst);
-    set_float_exception_flags(exflags, fpst);
+    set_float_rounding_mode(float_round_to_odd, fpst);
+    r = float64_to_float32(a, fpst);
+    set_float_rounding_mode(old, fpst);
     return r;
 }
 
-- 
2.43.0


