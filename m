Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F87CC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMT-0008Kn-Gt; Sun, 27 Jul 2025 04:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLk-0005Cr-Ly
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLi-00044q-OM
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2401248e4aaso1288305ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603393; x=1754208193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7LCKs76Nw+Cer/cpAQHFjJNOdRtPOAbp6iYLe+f3EQ=;
 b=O0AutxExnGgBeFsJ8I22bRDZyqo/ZnEaJuqLQVXM1rvfHesTzY0piMzWkGhEQO0CRr
 PzWV/N2jP43KmApTWtAcWoI7H9LxinsiRfj3eImOiC7LOwXg+LVaWIXBGmjnw/7v8cfI
 kRi7+zDZtP5u3jWyTvxFpaNIkj20WZZ0c8WohYzUC3JaX5zNulQxaXrjLcleUVxdG/kF
 CD+p2DbvnB/pa4tc7kzgjetEs3Ewb1TnKgmW73gOdq3yfHTcvPW4j8OE6RJ1Siw9Bc1p
 G7jz54frOXkYCmI8lhuKcIONsBy3AOs4qbOnQFw1v0WzyuflwzUS4GLNg9Kdnxqh3qO9
 1DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603393; x=1754208193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7LCKs76Nw+Cer/cpAQHFjJNOdRtPOAbp6iYLe+f3EQ=;
 b=r678ddcu4guv8334j6K1mqrjO9ZWI/HSod4aOTEqha1Clfs8sEjl25Z95SdmyxmheD
 RZLt+m0efrZpsNVGcTjdFSjtoLXmRtmKgxO8QhmrWOgkZsr/Bj/UsPeOIYV3jN1g0NlI
 q9qk4v+AgrLYG8J2kQGB1nlb+1zhmt60ypwYi6NXv5HnGdzOMpONGCnDBP83CTBlydqK
 ylqffeGZzW+b6mOg163lWrOOnwoULkRjL7x6WVpjwAf/zmDBVG30+uLjupI7zpdh9+LW
 yIi4ZYn6oKA2c+RGGv5T2hVUKnnRel4CNSLVWD1Jh4Bs81bHsr4aOL0dDJ1FufGLD+7p
 QP4w==
X-Gm-Message-State: AOJu0YxODjHrhpRZw94wRzf9WYDbnsbDjbnQj4FvmC3gbQ630njV6Ugz
 re1NyzzXVmFU0lg3I7JYuHELw9Uc67Ht00P55IiQxwDKkoljUhQk31vbk1FKpXIm3kuz4GxNLlt
 /eKtn
X-Gm-Gg: ASbGnctZzvTfPcxuAt1NDcUoVFJiDONM25WJ8pHyyYgcFPu8Bd+SahfY3I9j0/vRWEl
 01b4hQKMgxxfzIYTWwvXV7/WNaYPwR+WwHPwnr6YOndxKdTPbH3G0+evYdo40mqPEUfcQXwtyUv
 Lov970J8BAwQ3ssUzKDPktEbenhIVjRKipjReJffVDqWg9GcuMj2Q3wlsTFsNR3/rrGhdu7xS75
 BLpTr7V9WBo5Ar8CrtJr08wxM+U/wKzHMGcVx+khXfm4s3fTe0huP2hBfn09D8+Hms6IzHZIZ3u
 PHKCyopRxtEiPXACj+/G6V8mRV5nALjiy59hyU+0tGg+MTD3JxzBVkpAV7BanWo/K5epSggLCIC
 NiOBd6ZUcc8gyniZ+WGuTu1u1Zzo+ak9OJDTrv8z5WidblcmVhY23KY51pwpU/vFSK3WuSlW6ir
 WPVY+2ONY4Ag==
X-Google-Smtp-Source: AGHT+IGYLJ2isOG6ZUT0awpKMmjRMNeUMEglbx/RJ2Y/VkBoBpUaZfJnVma0NJIUrgXyC7EvAfxesA==
X-Received: by 2002:a17:902:ebcd:b0:240:1f25:d443 with SMTP id
 d9443c01a7336-2401f25d6e2mr1082595ad.30.1753603393160; 
 Sun, 27 Jul 2025 01:03:13 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/82] target/arm: Force HPD for stage2 translations
Date: Sat, 26 Jul 2025 22:01:45 -1000
Message-ID: <20250727080254.83840-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c |  7 +++++--
 target/arm/ptw.c    | 24 +++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6353b2dea1..a6130f7dcd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9639,8 +9639,11 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
index efbad7af1f..2eb2041edb 100644
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


