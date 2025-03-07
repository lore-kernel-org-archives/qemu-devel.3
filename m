Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5649FC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsV-0007TW-Vy; Fri, 07 Mar 2025 13:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsO-0007RC-Ho
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:52 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsL-0007l3-RO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:52 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso4417549a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373808; x=1741978608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5b/Oejd0mTwwlW1J+0jZU46/YaPksZa78jQ92shGik=;
 b=NZjFxMbiJnCe7OFWxTCfer08Y75CrfFyE9ye2h4e5z2BffX4HYSLBbscVBujFVlRBZ
 fVSn1aUaZqrmuBE+E06/D8YlkxppI955j7JaqUBhG0WLk6X84GYAbesxVH4yJoD07K/6
 Pg+sgZbsLmbhLKUHicSXr7NvtfSIsHc8pc7glpNcg6Eeg6HEnIrLFCkAZaUpmwNr6LDW
 1GjGJ4FqQl2kODPjmKOAFQij65k2fPEeKikZH2z31dDgNTz/UGzuEun/65Jy6nxAmmWc
 7iIIU7FtSV6uSMjq5DGgD7gtEj5WyAcVqWHdq0u2liAMwCjrkXT3FKxAY5rI9ABDzCyh
 xgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373808; x=1741978608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5b/Oejd0mTwwlW1J+0jZU46/YaPksZa78jQ92shGik=;
 b=Oweh59GnSUvzZEE/jOTUVOpTD5PwheM2YFtEa06TQrGUkcy8pbagsq3YQVc30gvtle
 PFhrEZ5pEMeXzxUBlTsEWF28dPYn5TJptzC1Kah+WY783af+VNHuaZrVP0EB26ymg38C
 S6+sQbEPOu6MkjPiYOUfV8N17i1+m3mJePkfVVmufKb8iWwtad23ZGMPoneHGGFaZkNj
 BrkvV9Eo5W+YJkhFba8DAP+T5mmLVhIKjLy/VGpl5vQntbldyppggT+2qNhY/jH9I3b9
 5zJ81fM1T1xRjRhsPkSP7xeuxaTIE9yjx7a3jPIcQ8LFzwjyFxRLJ5gk1c/0YAl+tGRD
 O9gw==
X-Gm-Message-State: AOJu0YwZ5fbr6lwEHKVetOGnXGn5vdMKv5gd0Fnl8t9sBJxs4LO3N7us
 XVohQmX4fL3kALYguPLoa2CFo1cIIKceFRGzAeZbwQ5SGdgPkzWf+X29BUFAsP2X9avYGywIIOZ
 D
X-Gm-Gg: ASbGncvb+vOmmnhE8B0sqHbUtlO6cosZYOXpFEZ2aJbhLxFrrxfKk+jOn/In7ajpdzi
 VheUETCQ0vyh4rOLmP121UftcGiMm3Z8gmYst63+5Ld9k5bYpw3gh7y84hgzkfxS7FXpgAD6Vdy
 hRwzZSqenY/UXjmhfZYPmZnt+xCisavz+ttBZMLafmgwUJoQxnJ5AFB7fch8RfuWEVK5piNBMEV
 y69v6qrwGr7WkwRyEfzTflj+1krit4jKktbc9Y2Unpb2CTf02AU0bLwRmp1uCFUcuefSZxw7pif
 KsboNhFpXvCy2pztuIRP41/YUfWkiHnIRdOSSY/WltOaFRYCjnXYkw3AL661PMwpYUGLNoR8rdB
 D
X-Google-Smtp-Source: AGHT+IGxqRVkTw0z2OwhtYHb0KfpaLwYFeIosgZ1FGZ4vBWP2WG5+ntedd7BY53I3HlVgEW27Mkhtw==
X-Received: by 2002:a17:90b:3b4a:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-2ffbc147913mr987991a91.2.1741373808069; 
 Fri, 07 Mar 2025 10:56:48 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] include/exec: Move TARGET_PAGE_{SIZE, MASK,
 BITS} to target_page.h
Date: Fri,  7 Mar 2025 10:56:29 -0800
Message-ID: <20250307185645.970034-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Re-use the TARGET_PAGE_BITS_VARY mechanism to define
TARGET_PAGE_SIZE and friends when not compiling per-target.
Inline qemu_target_page_{size,mask,bits} as they are now trivial.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

After this, we could in fact remove qemu_target_page_foo(), etc.
We certainly don't need to convert any more uses of TARGET_PAGE_FOO.

r~

---
 include/exec/cpu-all.h     | 21 +-------------
 include/exec/poison.h      |  5 ----
 include/exec/target_page.h | 58 ++++++++++++++++++++++++++++++++++----
 page-target.c              | 18 ------------
 page-vary-target.c         |  2 ++
 5 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 09f537d06f..8f7aebb088 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -105,26 +105,7 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 
 /* page related stuff */
 #include "exec/cpu-defs.h"
-#ifdef TARGET_PAGE_BITS_VARY
-# include "exec/page-vary.h"
-extern const TargetPageBits target_page;
-# ifdef CONFIG_DEBUG_TCG
-#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
-                                target_page.bits; })
-#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
-                                (target_long)target_page.mask; })
-# else
-#  define TARGET_PAGE_BITS   target_page.bits
-#  define TARGET_PAGE_MASK   ((target_long)target_page.mask)
-# endif
-# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
-#else
-# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
-# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
-# define TARGET_PAGE_MASK    ((target_long)-1 << TARGET_PAGE_BITS)
-#endif
-
-#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
+#include "exec/target_page.h"
 
 CPUArchState *cpu_copy(CPUArchState *env);
 
diff --git a/include/exec/poison.h b/include/exec/poison.h
index f4283f693a..ce43a12965 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -44,11 +44,6 @@
 #pragma GCC poison TARGET_FMT_ld
 #pragma GCC poison TARGET_FMT_lu
 
-#pragma GCC poison TARGET_PAGE_SIZE
-#pragma GCC poison TARGET_PAGE_MASK
-#pragma GCC poison TARGET_PAGE_BITS
-#pragma GCC poison TARGET_PAGE_ALIGN
-
 #pragma GCC poison CPU_INTERRUPT_HARD
 #pragma GCC poison CPU_INTERRUPT_EXITTB
 #pragma GCC poison CPU_INTERRUPT_HALT
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index 98ffbb5c23..8e89e5cbe6 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -14,10 +14,56 @@
 #ifndef EXEC_TARGET_PAGE_H
 #define EXEC_TARGET_PAGE_H
 
-size_t qemu_target_page_size(void);
-int qemu_target_page_mask(void);
-int qemu_target_page_bits(void);
-int qemu_target_page_bits_min(void);
-
-size_t qemu_target_pages_to_MiB(size_t pages);
+/*
+ * If compiling per-target, get the real values.
+ * For generic code, reuse the mechanism for variable page size.
+ */
+#ifdef COMPILING_PER_TARGET
+#include "cpu-param.h"
+#include "exec/target_long.h"
+#define TARGET_PAGE_TYPE  target_long
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_TYPE  int
+#endif
+
+#ifdef TARGET_PAGE_BITS_VARY
+# include "exec/page-vary.h"
+extern const TargetPageBits target_page;
+# ifdef CONFIG_DEBUG_TCG
+#  define TARGET_PAGE_BITS   ({ assert(target_page.decided); \
+                                target_page.bits; })
+#  define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
+                                (TARGET_PAGE_TYPE)target_page.mask; })
+# else
+#  define TARGET_PAGE_BITS   target_page.bits
+#  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
+# endif
+# define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
+#else
+# define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
+# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
+# define TARGET_PAGE_MASK    ((TARGET_PAGE_TYPE)-1 << TARGET_PAGE_BITS)
+#endif
+
+#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
+
+static inline size_t qemu_target_page_size(void)
+{
+    return TARGET_PAGE_SIZE;
+}
+
+static inline int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
+
+static inline int qemu_target_page_bits(void)
+{
+    return TARGET_PAGE_BITS;
+}
+
+int qemu_target_page_bits_min(void);
+size_t qemu_target_pages_to_MiB(size_t pages);
+
 #endif
diff --git a/page-target.c b/page-target.c
index 82211c8593..321e43d06f 100644
--- a/page-target.c
+++ b/page-target.c
@@ -8,24 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
-#include "exec/cpu-defs.h"
-#include "cpu.h"
-#include "exec/cpu-all.h"
-
-size_t qemu_target_page_size(void)
-{
-    return TARGET_PAGE_SIZE;
-}
-
-int qemu_target_page_mask(void)
-{
-    return TARGET_PAGE_MASK;
-}
-
-int qemu_target_page_bits(void)
-{
-    return TARGET_PAGE_BITS;
-}
 
 int qemu_target_page_bits_min(void)
 {
diff --git a/page-vary-target.c b/page-vary-target.c
index 343b4adb95..1b4a9a10be 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -37,5 +37,7 @@ void finalize_target_page_bits(void)
 {
 #ifdef TARGET_PAGE_BITS_VARY
     finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
+#else
+    finalize_target_page_bits_common(TARGET_PAGE_BITS);
 #endif
 }
-- 
2.43.0


