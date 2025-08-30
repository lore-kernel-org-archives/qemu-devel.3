Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815DFCA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvy-00085D-Et; Sat, 30 Aug 2025 11:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEM3-0005wt-QS
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:24 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEM2-0004A5-4G
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:23 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b49cf1d4f6fso2011810a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532541; x=1757137341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjcBOO95mytUtWdUeUAW/OzBEgf7hTTRCWzAcQNMZLI=;
 b=QooSYAGnsdPYLXabdhoRqueRjE1GXurl3HomlF96lUxymHGW3NbzJAfaoPMQXNKyWC
 pZ73bVDO94EmWRruzwotlFieeNsJjzipur2yiBGdZvD5c0Ou7irmPnvIw2aHXmhXsgpG
 aeLhTE5hpNaKMRDel5WAVqWdrVduJXCNqa0vmTylzr96cSPy9XZJjTVVv1wl7mrmS+hB
 UoltEiYeW6ZsdwlJ5w4vUboOrBqe8U0civDs64o+xZ92NJZXYvTvVxMtfQcZu1TdOnWM
 vzU7EqM/wAKD5RSLpumJcrEOpI5Kqcp3bj6dtMwcuj6/AdClSpBt+yxPt6Ay33ZHYXOR
 jkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532541; x=1757137341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjcBOO95mytUtWdUeUAW/OzBEgf7hTTRCWzAcQNMZLI=;
 b=fJbIWiWZNKrr63+FonUgwHR5tL6LH2T1sRY2jhj15W+PIxMCBZE6HOuxiLCQnQ0zi/
 UQIgpFGo+2gcxpTPuVsvHgUJVTnJKF/sG1/yDTizmrZ7a+m/XtFKOEvFJ46DhHIpfqqW
 56y43NS/JBZhh2Snja9xPoa8z2jA67dUUER9/RIXLO1xAKLWGqPOau7RgtcVUoAyIBes
 OcK177hdiHJG+wk9HT9KODZBwWkaZYIn5nosV2UnHEsJB0+GuIpguc7Va8LURDfgNJ3H
 LZZ/KG4mBBTfZ9peoHdoqGe5yq8w0yyUIMrEKf+AaLMDzgvqVPRWfdB8ALyeIB9jikyK
 ghxQ==
X-Gm-Message-State: AOJu0Yzes220rrsflZrx4HKih6s4sFvhrXNkFBGMKfwfJZycxY++tueS
 B/t9L5AgN6X3uIAmyoK60CV1h2DVo7ysyx12f6E5zEP/NFQ07LlAyAhSGBQzEAAzVMxLL3ZKvgg
 4eXQxFpg=
X-Gm-Gg: ASbGnctxJxRzgncc6oZvZYHLGKuts/GevRaddVM+EI1Uq4gnZGAN80MbZ2EH+G3KvVJ
 X49GzCkgrjOXWFNCmMcT6xofWxFzUPWP1U1j99/QvC31h6nySKkz8A7fh3aCf3nigDB6J/soPpS
 IdzpDLHsa86v2r+coGurUKQ793Hsx9SsDh7bL3U+w/e75mGmeN6ssBq/3lOi8MOYs6Wr8AttV7E
 k38nsXJeVGCMHRyoCXhmC6WPGvNaPJ6yHHLNWhMlRUihNoGTRkjkaDGi5muZPrl/anlI/o/5z8m
 THBL9uOGKnijultCwCILNjHtA6fUOHXlR2MV8LVz8OMvB6AcO38RcowtQABhbkgoeer+yJTq73W
 kO/3f34legMwyWYx8uSCaAUyASAu2tcgf3Fa9P7znwo1Vg4ExTa7HwputHuZ/UkN3OFSymLU=
X-Google-Smtp-Source: AGHT+IHb7e1gPOtyanmDcRTBgQsHlJNOg1omy5Mn2kZPoWtdN3jmqpydOcFbw+8d+D6/mChceFR98g==
X-Received: by 2002:a05:6a20:4324:b0:243:c91d:9472 with SMTP id
 adf61e73a8af0-243d6dd02d9mr1587353637.7.1756532540690; 
 Fri, 29 Aug 2025 22:42:20 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 16/84] target/arm: Force HPD for stage2 translations
Date: Sat, 30 Aug 2025 15:40:20 +1000
Message-ID: <20250830054128.448363-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
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
index 638d32fd80..91d6a7a5ae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9533,8 +9533,11 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
index 089eeff845..aecac27c54 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1472,8 +1472,12 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
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
@@ -1979,16 +1983,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


