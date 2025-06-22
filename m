Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA791C7115D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 17:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTOqL-0003Br-Pa; Sun, 22 Jun 2025 13:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTOqI-0003Ai-4v
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 13:50:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTOqF-00028W-G4
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 13:50:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2363616a1a6so26185215ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750614653; x=1751219453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zz85mS8Aj0NqtVluLQ1vpPK1jkJFPwOsi7JR49MknDU=;
 b=s8LsdRN5HItqgYQCMtY/a46HVikJIO7+GNBtlqhWl9LfhjgoX1IXSCn0//HDv9fkPP
 6viIhiIL5JUQPunQpswygE+suYhNZqOQs6gZHK/nQwXJrQJvxkdZDdIKitT1SHhorreE
 WjcrRcvUhCdWa/wvBVfMxS6uKKqGErNmaBbpEBiE0etw8/ilrYFMqkxmefbVrPLs7kui
 vKew+4sTe9W3m1uamTSEIQgdqLg45lD/DNbtZSrK7ATIJ/GCz3a4gXHryfqOO+j0F+ef
 hwu+cL0QDiW4/qsqWE2NORytyoHoEPICkOLXz2F6OgdPCqOPVY+OfXSoCY67Pw6F+YSr
 ITEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750614653; x=1751219453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zz85mS8Aj0NqtVluLQ1vpPK1jkJFPwOsi7JR49MknDU=;
 b=fDXU3HpXGUsLXSh2tJNobzRFquDdq5fh13UeWdkgQYId1GXTW9NwmPbqzWTHTYwqDw
 UE3H8CPONZD6PKpPCXJ3rrxUiVvy1nAG95jqaled8RaNuLuOy3Lcu77taZC05vGg8vOw
 FnSU1GfS+exTt4VwimiYqEL6L+1btDIVG8FV/L0poZ73TXSgRQuyUK8LPYG8V4rFNnj3
 3UA86Zfg0cd4D1S2jX/TR936Si2yMkPYkniZNkcRxPMe6hWM9nE/vjmjebuw8gRonJM/
 yIlOzoP3SWHXqzLlo7+tSzgys6U7MIX20n5i6AHmdQVOZeOy6jomLFta9MB3Z1jfDQJX
 99ow==
X-Gm-Message-State: AOJu0YzlsZIbj2h1iu8KSxIu4OiKvfI0OY3xsStsQyCc34Zug/JCWZsZ
 aLI/AjGhQHaIiVwlAK87YUn1ZwWTT5G0i+WnUSNIDUl2i4ttiuTb6LcudPIPHGndMHjGhrcYbzS
 jVIbDBcs=
X-Gm-Gg: ASbGncuKoKwNYbpjWuR2Se0fVUQYL4ML2JWLi7170k8Ya4+1z7NwrBJkkRAU5nHB4lq
 s25y/xiuMwCPlgnmjwezh7nCdnABvKfMcCjxJMjWsDYAh9jIB4pxmMiK6EhXG41Xa4sswBVFX8V
 GYlTcE1yJan8pHZysOPDKOfBSRlsmhoo70Nv12/0hiP3GXqJmUXTUGOYPUjH8+0C48tyt0+uX9+
 lVJGGYgKIvoRaSUgH+oihX6pmFLsXpDNAETWSRtu0LOKRHMoRsv5GBoB8Xv+DNtmR4V6MCqENZs
 xfAgupj6lfUUHGmcEvHY5vVhCGFf32BuWEnqE5uAyDPevqGw93AJLZmKauWvzVZQ0hYq6voN2au
 W47SNY60jH/LH+IsXVcFP
X-Google-Smtp-Source: AGHT+IHarkfQHe4KUfuCU1owAvQTmeYBjnzEeMaLq6MPhBg8SjiR/tMLuu0WJKFPkTvqEsylwysfGw==
X-Received: by 2002:a17:902:d58c:b0:234:b131:15a with SMTP id
 d9443c01a7336-237d9775661mr144441765ad.4.1750614653581; 
 Sun, 22 Jun 2025 10:50:53 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860a426sm64747445ad.117.2025.06.22.10.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 10:50:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix SME vs AdvSIMD exception priority
Date: Sun, 22 Jun 2025 10:50:52 -0700
Message-ID: <20250622175052.180728-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

We failed to raise an exception when
sme_excp_el == 0 and fp_excp_el == 1.

Cc: qemu-stable@nongnu.org
Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 297064806e..427f029e28 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1494,7 +1494,8 @@ bool sme_enabled_check(DisasContext *s)
      * to be zero when fp_excp_el has priority.  This is because we need
      * sme_excp_el by itself for cpregs access checks.
      */
-    if (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el) {
+    if (s->sme_excp_el
+        && (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el)) {
         bool ret = sme_access_check(s);
         s->fp_access_checked = (ret ? 1 : -1);
         return ret;
-- 
2.43.0


