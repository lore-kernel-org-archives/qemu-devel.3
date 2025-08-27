Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C75CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4d8-0005sc-Qm; Tue, 26 Aug 2025 21:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cb-0004iZ-LO
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cS-0007Nw-QA
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso1013727b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256786; x=1756861586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4Lf8/2iTXAex6ZXuf2I67UjdBKmSW8ls21CHC4ixcw=;
 b=Pl2q4ucr8qcm4GpR4RlPVjHpEnZdVj2acudVk4RaClEO0sAXCMAqBlLIMcd1nTPzTN
 ne652TeGORotKqHsI6GEcW36cvn/pK4edlyiqkZLc0YbmG5610Tgp5AFkkPOzQSe3kRS
 jnoPUk9jFPMJx/0UIppTWGL5aiq3spsKWpBpKWJjcBCI6+23sKrfFbBol1LUR9wIzzqz
 n+XPZjVjIfHYnkpGoCSccJJ1wgB4gaM9EOcXu9VfWlofBtorcCdCRIfkGgU2RuPVFNE5
 gsuAF+ySGDQplQgBdNyxRYI20tFrqmFllLewON7C65YO97zEmZoHm5t2s8wm1BXqANku
 4vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256786; x=1756861586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4Lf8/2iTXAex6ZXuf2I67UjdBKmSW8ls21CHC4ixcw=;
 b=KyKj0r5M57bC0gJ8nvW6Xh571+aFRm6pAz/oowJSsxeHcz/7rzDoXOIFNTwalqhn1H
 xFnOSNGfVtsqImTZoEjNEdKHPMa7Qjr3CZDDtMfEVUGMTFefxcaA34uP/YvM1xxK3ZQ4
 3n7odJyxIpajKdvk0/6BJGHMTSWpxP7K990vbmpXEO1JH/903Fbyu7nMeQHn6N8AJWjf
 SAXutYFF6J7Bsh99nOqDtIJvNy6nMAHRqnInvK7vvLCszpX1tr0It3DUFK2s6x2f/TjV
 VYjOLUNHol6TOLIHMqln9wSHmAAqdJurN36tUBGcoO/F4Y9pYcdQa9j05+guWV/iyZbX
 bNTw==
X-Gm-Message-State: AOJu0YzMU8qtYmWr5oBEqOV+IF5N4pvRwhk7b7nohgUSk0gezTVaMTN7
 XBahGwy6wXtUkVoCI1+hqYPfo6ShhcH6dBmkthgA96l/PddyiIkb9voS1J4ClB+614W5Kc2B2Zc
 KSPW8qRM=
X-Gm-Gg: ASbGnct1p9H/DhNPTbugWaPiwi8hf6ha0V1LM0VtTrA5XWDnCClLKFlSarKSwDi1Ah9
 IuWB/6OBNOVYkWK9IJm5RPu0Z7F546AZde6it5Ohs2Ml9KlCYGXCtMdbdoq/JO0yiIZ9m/jrT71
 CKuCHBAL44cgFkDgsSGPUUH3WJlTvclKM/RZOVsKJaNEQDef2cG6bEGzGQgdyB14thtC+V3uxSd
 6+fla5w9p/lOZ36eqpNGamOoYIALjxw3xgoW8TjkC66yqo/AmqXYRnfuiPXlp6VC5tVosgUG4FT
 B2UlthcwCfK03Ae1VEGR3G8EBJMlKo3EUFCsTNJcSjo8vfuuVTohgUlEGAaG17B+qmvkmUlN3cx
 nGSmQwU9s6okZCp9w3t0M+KAVF+VG2hIXbOF0
X-Google-Smtp-Source: AGHT+IHEVY7/8besdjS17Ryjh0NUy8unWQGZsVI/tHL1uTAaQ3cbGP5sEPNOdQ+Ozh8hS9LrCpboXQ==
X-Received: by 2002:a05:6a00:4649:b0:771:fab2:83ca with SMTP id
 d2e1a72fcca58-771fab28737mr4983047b3a.4.1756256785634; 
 Tue, 26 Aug 2025 18:06:25 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/61] target/arm: Add CP_REG_AA32_64BIT_{SHIFT,MASK}
Date: Wed, 27 Aug 2025 11:04:06 +1000
Message-ID: <20250827010453.4059782-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Give a name to the bit we're already using.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index b6c8eff0dd..3dc4c9927b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -178,9 +178,14 @@ enum {
 #define CP_REG_NS_SHIFT 29
 #define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
 
+/* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
+#define CP_REG_AA32_64BIT_SHIFT  15
+#define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
+
 #define ENCODE_CP_REG(cp, is64, ns, crn, crm, opc1, opc2)   \
-    ((ns) << CP_REG_NS_SHIFT | ((cp) << 16) | ((is64) << 15) |   \
-     ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
+    (((ns) << CP_REG_NS_SHIFT) |                            \
+     ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
+     ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
 #define ENCODE_AA64_CP_REG(cp, crn, crm, op0, op1, op2) \
     (CP_REG_AA64_MASK |                                 \
@@ -202,7 +207,7 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
         cpregid |= CP_REG_AA64_MASK;
     } else {
         if ((kvmid & CP_REG_SIZE_MASK) == CP_REG_SIZE_U64) {
-            cpregid |= (1 << 15);
+            cpregid |= CP_REG_AA32_64BIT_MASK;
         }
 
         /*
@@ -226,8 +231,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
         kvmid = cpregid & ~CP_REG_AA64_MASK;
         kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM64;
     } else {
-        kvmid = cpregid & ~(1 << 15);
-        if (cpregid & (1 << 15)) {
+        kvmid = cpregid & ~CP_REG_AA32_64BIT_MASK;
+        if (cpregid & CP_REG_AA32_64BIT_MASK) {
             kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM;
         } else {
             kvmid |= CP_REG_SIZE_U32 | CP_REG_ARM;
-- 
2.43.0


