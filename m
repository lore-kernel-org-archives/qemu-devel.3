Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79926CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9P-0003vk-3q; Wed, 08 Oct 2025 17:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9M-0003vK-2o
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:44 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c91-0006cn-AX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:43 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b57bffc0248so313048a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960578; x=1760565378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOmykAHgNa3WEY/QflE4W9ZlUUYk2FsFplQhf4AR8Po=;
 b=YOl6EAI+U0Mw7IfQW2cFV6GzZecUs+ikyRswWKtQERxILkm3ZmdF0QoqsQeRHA0GBr
 L8/QLkxe1l+Z/QQtIsRLMiqQSHURCdspwBTkeC45kW0sVxzZCQMdYzSje6Dgt+Y4Sjj+
 1uMt64S66EMuwo70D2s2Og1ZYzcONEpr+pmEHHnNnW1Y16y+YkvcgedgEvZ1QHRqv5RA
 ANC7iQxtU+WcHvZB/ArYZo9iEqhAin2KmT7QyuGyHdBBSJ5hdb8KAIqP7kCPokl6jk0p
 8nTmhG+cshfDLOH6AoODmPWJkGSur2kBavyQRPBolHs4UtqwdXxOFfOmnxULWcpLke42
 aatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960578; x=1760565378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOmykAHgNa3WEY/QflE4W9ZlUUYk2FsFplQhf4AR8Po=;
 b=ccTmBdHU3Zco5D/5LL3TGi4lnGWgo6xikj9hy3L/QSGdTrv0RAcrD9Q/hHzuPKi/um
 eePTHhSFC6Sf0MliGsNKWpBTFM1XU8z48MQ/8dz7UJSsVIfa/CMqMwHJBDHNH4w4Teq/
 lz783D2IAs6dhA4rPWdJGLGuOu74XUWEGmnq1Do0oYHRss4TvwwKhsWeC0mR0jnUi7CX
 HC0FMr70SXvCt7ljnrrBwT8EX0TVwDYVeSsc+KVwukLP6qjhPrM7nfz62XLAB+MGsOMY
 IWouBhK7vA4i4hYASN2TsFQPquB8bPHF545fC1Gk3FkLKwvKczOuJln7RHC6hhgYGRt2
 0wmw==
X-Gm-Message-State: AOJu0YwTET3BFd1r2nm1hQKFeVsmvlGtcDrkw+Zm+5tNxDmtUSQP6fyg
 7kWtlME/OU60s4mTnM7BFfhcWh3hYqpGg9CFBB6mk4SRH4voJaQti8MrP5Q2pXhyOBdHYlQqNra
 QVGLMEB4=
X-Gm-Gg: ASbGncsZm6SwvCDGF8vq5z7ecb3pu0/6vJ39qP6+JpYPGX+4n++c6n07tasqxt8w+OM
 xtbagFSA+utsVwoBWThEmHC7b7HSOJDxrDW9yrTIf+2v2yeDREbvOiYq8FE+be4nlHlB5OyrBYl
 bOoc2BdujxvPOolU8YH/jpDHkJHulzs4aBZIZS3svp4Ev7ufD0JLutyhFy4b1x/Ez+KlstL7QMe
 u246X97GdKq/2oz4rAPXn44fm7YjfEu38ZMSs3KG6Zkr6VSLR8VIPB/NDPSGnEwekR4hFAgC+Va
 2QpGJwXtPS8iSjJn4apmQPUbWtAGWdFFIIMxQFIfMmLXmRS115BY5cgflzvWkzERLhFFA4BhsA9
 rYDnHW9o99rvlFEHcKf0RfxehWxoe3SW6j9t1ldSfCK02uFqaHlIeDz3x
X-Google-Smtp-Source: AGHT+IFIc1sMRWQ1DMGeLiD5H5uxjSFsVuPFglAK653ydnsFUyyjNZ+EJagFGxU1YzpTaBwMxV7asQ==
X-Received: by 2002:a17:903:1a06:b0:27d:6995:990d with SMTP id
 d9443c01a7336-29027f0cccamr57745065ad.19.1759960578033; 
 Wed, 08 Oct 2025 14:56:18 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 05/73] target/arm: Force HPD for stage2 translations
Date: Wed,  8 Oct 2025 14:55:05 -0700
Message-ID: <20251008215613.300150-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Stage2 translations do not have hierarchial permissions.
Setting HPD means we can eliminate an extra check against
regime_is_stage2.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c |  7 +++++--
 target/arm/ptw.c    | 24 +++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20a189ef4f..b7bc27436f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9397,8 +9397,11 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         gran = tg0_to_gran_size(extract32(tcr, 14, 2));
         if (stage2) {
-            /* VTCR_EL2 */
-            hpd = false;
+            /*
+             * Stage2 does not have hierarchical permissions.
+             * Thus disabling them makes things easier during ptw.
+             */
+            hpd = true;
         } else {
             hpd = extract32(tcr, 24, 1);
         }
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e03657f309..2657023120 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1507,8 +1507,12 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
         }
         tsz = sextract32(tcr, 0, 4) + 8;
         select = 0;
-        hpd = false;
         epd = false;
+        /*
+         * Stage2 does not have hierarchical permissions.
+         * Thus disabling them makes things easier during ptw.
+         */
+        hpd = true;
     } else if (el == 2) {
         /* HTCR */
         tsz = extract32(tcr, 0, 3);
@@ -2014,16 +2018,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * except NSTable (which we have already handled).
      */
     attrs = new_descriptor & (MAKE_64BIT_MASK(2, 10) | MAKE_64BIT_MASK(50, 14));
-    if (!regime_is_stage2(mmu_idx)) {
-        if (!param.hpd) {
-            attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
-            /*
-             * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
-             * means "force PL1 access only", which means forcing AP[1] to 0.
-             */
-            attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
-            attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
-        }
+    if (!param.hpd) {
+        attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
+        /*
+         * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
+         * means "force PL1 access only", which means forcing AP[1] to 0.
+         */
+        attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
+        attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
     }
 
     ap = extract32(attrs, 6, 2);
-- 
2.43.0


