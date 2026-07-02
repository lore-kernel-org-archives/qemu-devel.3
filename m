Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15426C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLI-0007D1-7U; Thu, 02 Jul 2026 14:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLA-00078o-6H
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMKp-0005Lm-1T
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso7081475e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017625; x=1783622425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BEiz57/0Jb31Qqloy6OCt2ozPhVLxchX7ERpV61dg1s=;
 b=uhxmu3sfWuA3H9ZtSfQKWWEItY7cWLkydccpJNjx+jOcu0n4CFaVdvUqlvwkA660zC
 eZQLRRyZKcJPiGiZsotwQZd5MdJ1doosiUxf8R60p6/PKWg1OXBWiQpFZcN85ZDJVEA1
 oArGP6HQAy1JE7ZvCw5EWoGNep/MI2CyT7bN8oUIBGGdmxZbJohHBev7nLqZT85I/F1i
 dqZiEiNVZxzFXkV1KEwBUcNXuapWHe33DwXot2UCqFgUzJ/RvGkHWwqHdUnZ6noCMwqQ
 NIngk38t0QcqcWKe9J4Saej54+yYoJeuifH419ZLqNeOhtrXlKtkY/bRsiCs9LF8YMt6
 9RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017625; x=1783622425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BEiz57/0Jb31Qqloy6OCt2ozPhVLxchX7ERpV61dg1s=;
 b=QZGfV/5a3MRkZFo/eISFeHqornq9XBNg9L2TUPzzCJwuB6QEhHo7QwW8RynbyQlVhK
 chGPbzLxKgDLkIGH2glnZWSih7BwcYT9CVKALSH+hzBVLm7a/NeiwUH9ifbnHuYbTIMi
 n2VzEJ8MmVh+xeMxz6eOxWn6YmIFceqeqcH+P7XdnrqLyx2olTdUpWoUjipCmqIYg7vP
 BGrgZqSHGd1C1jsxMrNhz/ay7A56FZl9oHS0tQsOxhxqNNFXw6VRSC9EmdXOB798C/M0
 U11cOvRb7/MwudXxMCF+YEFQoITkbp9z1502a5y2zJSCYCWkMh8WNCwwk9xxpCYxoEOE
 n/Tw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqk54Y0FQrAt6v07wl+MBsGRoU+pRXz2D/DlpIUpA+F/KEaKx9p5DrIIqYcQfY1uN2vQm3h3TruFTqS@nongnu.org
X-Gm-Message-State: AOJu0YzloWlNeg0SpwfZK5/eD+aDV0DVIvGkaMfqFzj5RYdY7yPq0+ED
 D2FO54qumNs1IJhTwcmSUr8hJeGnHIGrXqrxdZ81h9IDpOd2xOACfb6H+dN7AjK3Xek=
X-Gm-Gg: AfdE7ck0I63hleYnfia/x8ffusnRG7uLpNjc7GZyQWRcXsvuXC99FVUsLCedHWcxpC2
 AZ0jlhfqZb6bSDy/q2WmiDf+OFE0ARiCrLxHkP9xjiFAaOIqVSYpwm0RtNup2IXEbsUtBYKZnu7
 ukTjeh52EwynvcJhBM1X+yQ16NlRbTXwOYM94ziezp8DXxZIjmuuyrX9Ukk5qh0wcCYHyG3kXqY
 ndppQ4cDjfGFFL4WhM1nBQUmYUsngnjYHE8M8beei6IaXTetyFjZKXuHnjn6ixsRrN1naCL5jeZ
 m3gZsNP3O0RG1HEcs01Y4RXGY3OpgPKOLX2zn1+yTLQ+lUnERVzTu26uULdyuMlSDP4pX9taKx+
 MLhTONjjrQk9sZ8QQuy1YeHmjZyJ6tlWIcHBF/MRaq+8MfHG6bVOYqGGJaqiHOW2gsCq9eVlsFN
 zUdoZK8sbJeEFkW6VceR+JmpgR08rgZTbXW/I3q7NMCgg+xeWP78MjE4B/gXAqZmi0TQ+ot1sZs
 a57iEiaLX27/zTV1G9wKw==
X-Received: by 2002:a05:6000:27c8:b0:472:ec66:274a with SMTP id
 ffacd0b85a97d-47759d1ade0mr8173188f8f.7.1783017625493; 
 Thu, 02 Jul 2026 11:40:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/11] target/arm: Handle NSACR.NSASEDIS in CPACR accesses
Date: Thu,  2 Jul 2026 19:40:13 +0100
Message-ID: <20260702184019.3431139-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In cpacr_read() and cpacr_write() we have code that implements the
"CPACR.{cp10,cp11} behave as RAZ/WI from NonSecure when NSACR.cp10 is
0" behaviour.  There is a similar requirement for CPACR.ASEDIS: if
NSACR.NSASEDIS is 1 then CPACR.ASEDIS behaves as RAO/WI in NS.

This doesn't matter to us yet because we don't currently implement
ASEDIS or NSASEDIS. But we're about to do that, so add the handling
to cpacr_read() and cpacr_write().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index af98bda3f5..926c9ed516 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -585,11 +585,19 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /*
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     * Similarly, if NSACR.NSASEDIS is 1 then CPACR.ASEDIS ignores writes
+     * and reads as 1.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
-        value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            mask = R_CPACR_ASEDIS_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
     }
 
     env->cp15.cpacr_el1 = value;
@@ -600,12 +608,18 @@ static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     /*
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     * Similarly NSACR.NSASEDIS makes CPACR.ASEDIS read as 1.
      */
     uint64_t value = env->cp15.cpacr_el1;
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            value |= R_CPACR_ASEDIS_MASK;
+        }
     }
     return value;
 }
-- 
2.43.0


