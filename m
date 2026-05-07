Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B0ECD37AB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JN-0002hf-6z; Thu, 07 May 2026 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Io-0001uD-3z
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:18 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ik-0008Aq-3f
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:15 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso884357a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170212; x=1778775012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T2ZghK4sNfiM5z8zyNlYLTncliVfy0NuA2KHs5cYwz0=;
 b=Pvu/T7UZQTg9b5ty43vbRmTka6svTZYe4P0WAa9xu6KW1yAr731xgRychxm2p9Ppp/
 ZDE0lxF7iByzI2y7q9/wjm9VNdZ+zLswpHmr3LcN/5M/RFGmzkRr2/DDRGnCqn2xRa19
 1yj+F+TmK1IDfEcoWZD4Vk6JylcHILIfEq9FHtIgRC85+t3aQoqqsyo3g6xjsla/xsxr
 VfWKfxziyJuBspXLcy8KR9bD0GHHVkTBVKm389S1Aoj7Zg3IpfDQH9arqvq9OuCp2Xma
 47jwm+UoRc2pMqIF2wJb1A2QtzQNQq6RMMjc21692yhkf8mqrqKg1VAGR/6LszwEJDsH
 fJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170212; x=1778775012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T2ZghK4sNfiM5z8zyNlYLTncliVfy0NuA2KHs5cYwz0=;
 b=gu5YiM1MCfzq6AFCOYr0hyD4rGB0kWV7PZOVdMLSf8Y9aCwSC6vL/Dl6SGyktVNZS5
 szG+3xCX7MFqVj7xMhwTMeH6eIAse8DAyN3UBlhyviHgYSnJxEI5sbqlqFdu/sp8SjCC
 KvJTfMoIrdIervHKve4FVTGDqajC2bWKdtRteWkHIMloyX0ruRPwH6cnbls23yCd3Dhu
 HE8U91N+pJ6kW0cSrT2fEqWihfCuVFFWW/De5nvYo7SLktIk1UEM8Z3vd+Ug63Wr8sLm
 uy+CgXW0vFCSq1E0P+UuS1Y7pl8Q5XpzOZi197gduxr+QNmnS4dIMditv7DkomHapHcb
 ahpg==
X-Gm-Message-State: AOJu0YzbfqVhYJJpnsgVHewI+tpwK/HTXI7Sr82QcKZzaOLBfHZvpSPP
 bo6bDs50v/qbXMRMB4pxdeQn/ZzHWEdmvnMSFEcpL8UUh2AQID9/Ec3sRFPrUlJ7bqgxJJJlE47
 uaeXr
X-Gm-Gg: AeBDiev23NC4EupFWto8xOI8jLfJM32IIuPM6l3g2274lZeRNlmbtAp6IZ5ghbrAoFA
 d8nColXwpclVQeIB7OEOKQzaJJ9nMXYmPdIrWVjaqNxdUYf3Br+Hk+HjeA7THmHJ6Ps0Nv0F9oe
 dLcApcOfeYKvj0CJGYA/AvHVPDm1ZNgtnyct9Zi5Y9oqpjqudhohb7W/tEtPruW1e9bmkaikVYS
 pNM4tOFU65tk/anS2/rJg30Lrf+xgmnzSVePjFxP17X9n9CXQE630Q5tu7+TryQT+RwOj8QAFMR
 NF0Yc/NjJl1IdjPWTAdilzfP9SPXVLw3rIhv0fuX0uxcMSRPuni9jnwhqJOQIeAJyjHo/Fd6NC7
 b49CgxKGXHkGKl11S0tGLBzwxgObBS4ct9tdUBbvkgJ/LOgqe7+hFBssgjnePJUKH2coc9drd9d
 HTXJaGXo3p+cE3W4gjHsvPCXXVvV61L69QzPhWvxCuZEW2bQ==
X-Received: by 2002:a05:6830:3890:b0:7dc:c926:4f6c with SMTP id
 46e09a7af769-7e1df060272mr5397628a34.18.1778170212296; 
 Thu, 07 May 2026 09:10:12 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/11] fpu: Saturate the exponent in uncanon_normal
Date: Thu,  7 May 2026 11:09:58 -0500
Message-ID: <20260507160959.449170-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Notice the conflict between saturation and rebias_overflow,
which should never happen.  Otherwise, saturate to INT32_MAX
and allow the usual overflow to max, infinity, or dnan.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 6df98eb5fb..c5a828eb90 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -341,7 +341,17 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         g_assert_not_reached();
     }
 
-    exp = p->exp + fmt->exp_bias;
+    /* Because exp_bias is positive, we can only overflow past INT_MAX. */
+    if (sadd32_overflow(p->exp, fmt->exp_bias, &exp)) {
+        /*
+         * rebias_overflow wants to compute a modulo exponent, which
+         * conflicts with saturation.  That said, saturation can only
+         * happen with scalbn, which is not a PowerPC operation.
+         */
+        assert(!s->rebias_overflow);
+        exp = INT32_MAX;
+    }
+
     if (likely(exp > 0)) {
         if (p->frac_lo & round_mask) {
             flags |= float_flag_inexact;
-- 
2.43.0


