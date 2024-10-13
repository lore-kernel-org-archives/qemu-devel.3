Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA6CF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 18:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t03d0-0001J7-CX; Sun, 13 Oct 2024 14:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cz-0001II-3A
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t03cx-0002T3-I9
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 14:47:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c8b557f91so26393585ad.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728845258; x=1729450058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A367cDE3XXnX+J9PB6YWwLbOv7CCrH8XOGA6B2dAonQ=;
 b=CPdsdk/vadBarphoKLgzZcGC0QcDHf6YHRWApiwV7OORvsuQAMieRWu1Q2NgWGoyZ6
 pIKZKKyo5ZGC6nfnbsPAUN+bgESCFZTylQ7XOTR9HA8HgnkYm/F7kMy4+jELz6TOKNAe
 sEKsNMN/gM3S43NOpBKZxqC3c34s6Q9ONlZf+jQhoxr8HOte9MlphJAqq4OtHk13WVr/
 dUvbzh13fiIjv76yGJBlYPUeMUrSkGba4TuhnvP7Vywocl7tOyLrECuZNaQFHHlKnSZ8
 yPZjSBIXxwlYle2zVZTEdBuubIV7mn7az3LGce5K3dTPGiYrHRA3kMtQFcrg3SVpVLwl
 /n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728845258; x=1729450058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A367cDE3XXnX+J9PB6YWwLbOv7CCrH8XOGA6B2dAonQ=;
 b=TDXk39DHLbK7LkH/ImwrdojC1QV/ZvU1r2GtT3Z27/LNlxY+koeQGO+h65T99qPzNv
 /HKY6ukWVIXPJ+tGKMhzYJeiBZ2InBYqUShQ6G6OelYN90B6gdBptSXjwECWOb0wea51
 51Qr8MKI84JiC8pgEW9WEekVATOxevsdC4IZu4LV8/mG8Y+fFD7R3JgFXgCK2PgNX88u
 YinLeqMESJGNgaX4L9J6FWDy2TBwhiQ1ZO08/LwOe/+p/jGhHZCW/BM8JXqzMd14uJCK
 X4fvC51L6fppTWKiTvXXL/CvbHibAGaKxIlj7SbfAO2m687Amk79UGRydy6j78+V6vFD
 A23Q==
X-Gm-Message-State: AOJu0Yz55BYnXHOkg0Kv69D+E9UnZB/kTvXkZw4ks93XS+Y0LAOKqtfd
 1p7Fh75bMywRWAzoVDHKRf+cc/+zpKRP+bzC2sKKqNGu+HC2h0PmcQMfNoVAEq6Mouw1NUWwzW0
 J
X-Google-Smtp-Source: AGHT+IGvRfsXpMvrKqM+XTdNzkMe9S1y4G3+HE4CMWfWELYQl37UJe7I3yNOkN7wblaHIpYPU4gJ/Q==
X-Received: by 2002:a17:903:11c6:b0:20c:7661:dce8 with SMTP id
 d9443c01a7336-20ca167d499mr158830245ad.36.1728845258183; 
 Sun, 13 Oct 2024 11:47:38 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c35522fsm52811805ad.296.2024.10.13.11.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 11:47:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] target/i386: Remove ra parameter from ptw_translate
Date: Sun, 13 Oct 2024 11:47:33 -0700
Message-ID: <20241013184733.1423747-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013184733.1423747-1-richard.henderson@linaro.org>
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This argument is no longer used.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8f4dc08535..f97594f4ab 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -60,7 +60,7 @@ typedef struct PTETranslate {
     hwaddr gaddr;
 } PTETranslate;
 
-static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
+static bool ptw_translate(PTETranslate *inout, hwaddr addr)
 {
     int flags;
 
@@ -165,7 +165,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                  * Page table level 5
                  */
                 pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
-                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+                if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
             restart_5:
@@ -189,7 +189,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 4
              */
             pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
         restart_4:
@@ -209,7 +209,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
         restart_3_lma:
@@ -236,7 +236,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
             rsvd_mask |= PG_HI_USER_MASK;
@@ -258,7 +258,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
     restart_2_pae:
@@ -284,7 +284,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
         pte = ptw_ldq(&pte_trans, ra);
@@ -302,7 +302,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
     restart_2_nopae:
@@ -331,7 +331,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
         pte = ptw_ldl(&pte_trans, ra);
-- 
2.43.0


