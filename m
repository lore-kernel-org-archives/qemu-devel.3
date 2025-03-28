Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B7CC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFwz-0002qq-G4; Fri, 28 Mar 2025 16:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwx-0002pb-En
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:07 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwv-0007n4-Fp
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:07 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fbaa18b810so697028b6e.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192304; x=1743797104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dr/ia722bLIN9dEZ7twaM/nT3BoEXqpJL6WGPcn5bc=;
 b=J6imUvrzuG8w+QKV122rMtBq9bQwz24c2CmnBj4CGc7ZBIgfUckMufcSe5ZgWD5Y6v
 IFO83cVSlNRws9jJScJVEqz+gyO3FsvFEQ2dMeninv8bYS6RsKIEld8fpX7Eo70pIxZt
 QyAC4aZxYhtbxR8p1BceMml4BHX/k4dU6HWLdOlxr+EYKEYYywLbpyWi35PMRbuvWDcN
 Ar550vQv8DrWU+CTOg1T4RNydKmYSsiWt1JlCEthscgaK97rZuDK+UJRmuT8FyfGxoBa
 6yEUowUDHfHO7a8DtIrakDUdQItoBc1z0FG275ifFP8f5tyhLR6OokrjhdXWrV3Jenrd
 douw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192304; x=1743797104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dr/ia722bLIN9dEZ7twaM/nT3BoEXqpJL6WGPcn5bc=;
 b=Ihxs1+9RDYga/ILTVUQd4faAyXedw2Idi5DZKVpGz1m6hxW93U7Wv4Y5QT9vLxeZc3
 rm+722zMG/RsEw55sg+1251FA0ZDYYWtP81x5QgrmXjsTCqZDH++qiEO1vF0gV2sIzyP
 M7RsUjeog/+WSqSqndRqZ4wPWXaAzb9USmpxZb2kf0mF3QUA4/wkaVxUbgHc9h2/dtAt
 JhYZYhVyMQUUZhoLhjkT37o/kydTytrsF+RenAXHOmFPb6WX6eIAmDTBEioDMwk0Xh+J
 u3yyfSr+g0VkyFWUODAL8Xv7IjbOTgfMJ7L0T8jat7XrHYIB5zSP2THTEtNWIPJwThAm
 V/rg==
X-Gm-Message-State: AOJu0YweFSo1NYVizi72kXZcee+98RdrlQQrbVcut5l0xcmI1soUKmfK
 du4hB8uJwZRVoQQ4d4qAbxQA0agzDlghDY/VMuMtKyVJfSIZR4pMr8zmZG7j2OOFTf3PKy8rq22
 p
X-Gm-Gg: ASbGncsrNeR7d7J/DSa4WoN1N+lCLNgQXaVZ1d41SPB7JzhjhQy7bZCkhKzTWdsgLJ9
 Z6ko7IeGrH3p7ZCuqxRc0tuDTCAPzydgRpwwHW2wM64oQz5D53rMVzMQREEWS+20OxifQky9nmY
 4JIPxEQ4cXGo1/e8+NsPbSsdvZlrbMsceTpqxrDHlL3kVGuNUaxjph770StGm2T25Z+69oG7ECL
 erTGg6BwIVLScvlMb/MBvtECXuMNsCKriGJSYLVTNIu65XTUkf1J9x4oWJfG7AlaXpWMykVeXxF
 xd+YJIMwSqLavJSnX8ejxw5pEXaLmG/itgHHD6GpieDvAgSYTyRPt8pwLHasG3VrAPutFHa8QQr
 cGJavAXYypV4=
X-Google-Smtp-Source: AGHT+IFKJcFKMbsKAtbXh771OXmp2CVeSPiJZw5k5W6LxIR5YMmv9iw7OvuodCp59AJG/2LAHH7VtQ==
X-Received: by 2002:a05:6808:15a5:b0:3f8:b73b:683c with SMTP id
 5614622812f47-3ff0f4e59fbmr483472b6e.2.1743192303919; 
 Fri, 28 Mar 2025 13:05:03 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 3/9] accel/tcg: Remove page_protect
Date: Fri, 28 Mar 2025 15:04:53 -0500
Message-ID: <20250328200459.483089-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Merge the user-only page_protect function with the user-only
implementation of tb_lock_page0.  This avoids pulling
page-protection.h into tb-internal.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h        | 11 +++--------
 include/user/page-protection.h |  1 -
 accel/tcg/user-exec.c          |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 68aa8d17f4..f7c2073e29 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -51,28 +51,23 @@
 
 #endif /* CONFIG_SOFTMMU */
 
+void tb_lock_page0(tb_page_addr_t);
+
 #ifdef CONFIG_USER_ONLY
-#include "user/page-protection.h"
 /*
  * For user-only, page_protect sets the page read-only.
  * Since most execution is already on read-only pages, and we'd need to
  * account for other TBs on the same page, defer undoing any page protection
  * until we receive the write fault.
  */
-static inline void tb_lock_page0(tb_page_addr_t p0)
-{
-    page_protect(p0);
-}
-
 static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
 {
-    page_protect(p1);
+    tb_lock_page0(p1);
 }
 
 static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
 static inline void tb_unlock_pages(TranslationBlock *tb) { }
 #else
-void tb_lock_page0(tb_page_addr_t);
 void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_pages(TranslationBlock *);
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 51daa18648..d5c8748d49 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -16,7 +16,6 @@
 #include "exec/target_long.h"
 #include "exec/translation-block.h"
 
-void page_protect(tb_page_addr_t page_addr);
 int page_unprotect(tb_page_addr_t address, uintptr_t pc);
 
 int page_get_flags(target_ulong address);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 667c5e0354..72a9809c2d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -657,7 +657,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
     }
 }
 
-void page_protect(tb_page_addr_t address)
+void tb_lock_page0(tb_page_addr_t address)
 {
     PageFlagsNode *p;
     target_ulong start, last;
-- 
2.43.0


