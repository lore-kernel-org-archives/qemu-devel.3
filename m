Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A89C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVK2-0005i1-OP; Thu, 01 May 2025 10:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJx-0005fj-Dc
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJv-0005T3-L3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22928d629faso10450615ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111326; x=1746716126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EmF5AKGTNJn4wCHiHLWI2Bve9d/Bi6dFsapJqoMpZyA=;
 b=rbgZhXm7GbP07vxR0Ywywa3MVq4wUFUntDAJQ/Muck6oHL17rRhAr8XGQbKXGxVrQK
 Jf4OEANWWW14rxQZSHEiPmQTKGJJA6zrO5ZRf/ZvzLuU+pPG32CaL1wxVDX6EPE0wbQ9
 T9dpgW/3TlYRUDZENvgZilnGriPc9y3A+9Z9hI4Dv2ZFFZUCWAnXgVsVaE9oGzdpjyM7
 gc5ZxPO/oQjOO0kRzmy1ZRcfTvp5qm392Ci9W/iMCtG1Rq6XtlaQXvWDOo5sQT8ynTlQ
 R+u9qESOwAzQ6k7DIMosY8XCwwiyGG8LGj06RU8RBUMhuO50ZI4EM9rm+IjSjLdnBQbh
 Q5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111326; x=1746716126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmF5AKGTNJn4wCHiHLWI2Bve9d/Bi6dFsapJqoMpZyA=;
 b=LqXejr0u+8ygh/XpmPIRfN+NFreInqhPv34X1C7Epos/gt94LlAXcAbFObSfHN8Pb1
 51foRsURF5xAg2z0kIjej4buZiKuhwxHWWCjax7KWTwszJ5R8a95I3+PhY92qYhSEn/C
 wmJdvK+IHe83IJBO3QaZ5qqBCVOkmaR970Stm0lWe3v0lzTqyEoYsqmS49iKrH1XjCzk
 OwnsU2aIwU8VNdBa4SesdQZ1v1WMD3VkOsw4RmgxOaeeagaKdZdGQkBh/ZTzrbAyH/TT
 pFxQktwUAuX0eU5sak4gmpdZ+1QTW6/sQY9ddPEFm1byXPAQHNHFTJ88YLipN2To2KE9
 dXbg==
X-Gm-Message-State: AOJu0Yx43HOeOSpMWEBvUfqO82tHdXWobnEkjgPdrQpHqRUK/CaSe+pr
 GEeAKErSvK2kBvkIWXZxHGhCSvwPJfXNzhSGmZIq9/azo8TZRYbkzLZEqd7yD1GnQEC8AbEGF2x
 3
X-Gm-Gg: ASbGncsoOAtbt5wbG32xPV7b2gZUXiwns2iOBJz85jYhkC3ilscnNAJxgdyB9k6OJpr
 blLTTxJTRqpSr0ANFLIbsIx8kTNRDhS8+SOTvzse+8acc9c+PZQXjWPDOnSQNm1oCd+KXxr2h1v
 cwEAYUNakSDD0PG8YQuvs0z6SxQ/sRIf3/IKkQno+x4WIDR4pYT+JMhvdCMsZ4zbEr2x8XDSCpE
 WHOMEJc7Wb2ZiZ/vEeMZDQTz7Nvg+JiL9uw1Q/pBtDNd9+XkNy01qvXnbP2pEj+okP+NHxqOkpO
 VD2dX5URkzRzLFikBOe98aNRDCDuralafLPNBUYMlMZtbcMC/IRhrqoFiFdWsDKoDLEaG9ZYcI4
 =
X-Google-Smtp-Source: AGHT+IE6SAH9kbTgkJ+jnw7yhNzoK54Oul71yEAnPeV5LHiXnQreS+IiT8t0t54yhIdpBeXZwiuVcw==
X-Received: by 2002:a17:903:1a6b:b0:224:2a6d:55ae with SMTP id
 d9443c01a7336-22e0863b023mr47358415ad.48.1746111326043; 
 Thu, 01 May 2025 07:55:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] include/user: Use vaddr in guest-host.h
Date: Thu,  1 May 2025 07:55:15 -0700
Message-ID: <20250501145520.2695073-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Replace abi_ptr and abi_ulong with vaddr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index 8e10d36948..0656f2e356 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -8,7 +8,7 @@
 #ifndef USER_GUEST_HOST_H
 #define USER_GUEST_HOST_H
 
-#include "user/abitypes.h"
+#include "exec/vaddr.h"
 #include "user/guest-base.h"
 #include "cpu.h"
 
@@ -30,29 +30,29 @@ extern unsigned long reserved_va;
 extern unsigned long guest_addr_max;
 
 #ifndef TARGET_TAGGED_ADDRESSES
-static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
+static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
 {
     return x;
 }
 #endif
 
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
-static inline void *g2h_untagged(abi_ptr x)
+static inline void *g2h_untagged(vaddr x)
 {
     return (void *)((uintptr_t)(x) + guest_base);
 }
 
-static inline void *g2h(CPUState *cs, abi_ptr x)
+static inline void *g2h(CPUState *cs, vaddr x)
 {
     return g2h_untagged(cpu_untagged_addr(cs, x));
 }
 
-static inline bool guest_addr_valid_untagged(abi_ulong x)
+static inline bool guest_addr_valid_untagged(vaddr x)
 {
     return x <= guest_addr_max;
 }
 
-static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
+static inline bool guest_range_valid_untagged(vaddr start, vaddr len)
 {
     return len - 1 <= guest_addr_max && start <= guest_addr_max - len + 1;
 }
@@ -62,7 +62,7 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
 
 #define h2g_nocheck(x) ({ \
     uintptr_t __ret = (uintptr_t)(x) - guest_base; \
-    (abi_ptr)__ret; \
+    (vaddr)__ret; \
 })
 
 #define h2g(x) ({ \
-- 
2.43.0


