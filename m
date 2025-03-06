Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5706C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 23:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqKq9-0001A0-IL; Thu, 06 Mar 2025 18:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKq1-00019W-Cd
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:41:14 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKpz-000188-G2
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:41:13 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2234e4b079cso22703145ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 15:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741304470; x=1741909270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L5b/Oejd0mTwwlW1J+0jZU46/YaPksZa78jQ92shGik=;
 b=hbNmKUj3iAAmqdIgTQgStNqLane9PviKs2kkzm/PSCad2FQ4JX8AH9+JBI8Z9Rng3V
 e0Ly9ewh6Mcd5f4Sk8WiKbSMxp0UgL3rkXLBxiwEKZb+tuwOUOsE2/2fvBm1RSyWD+CE
 eVDitUhiz6+XLvYUQSwG4AblGzijfs74idKgSi/mX7LElwpLvtPWugtFDc5i36yWFSfg
 prD0Sb0vdCQdwYCGmZUx2GvWVA2Pq9uTzn08SQudvj1AbomgXKdF1xEtOIsH9+v3pnM+
 XF34fORFp5UMtrlGpr/DVf0JKxgwPBnRv1rXofLtRkWvCj6HeNDaNDwRapAiBZGTiPbg
 tzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741304470; x=1741909270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L5b/Oejd0mTwwlW1J+0jZU46/YaPksZa78jQ92shGik=;
 b=PVQbZiQxu4Mfb3PudRSuXgJRgpss96EX00eE5XmQTFqXxOGnzKSODtU/uEg/pr2mMh
 dKDnT9ioPvucSvVvk6l7kQaOD/u22clETJSgabfkCD+bHF1uYKEh1dTidXz0W5Td4Fwa
 RVrxlybJN556rs7yRzUHMgKDgy2XKDr/3M3i94S1f8Cf4OJBzWxOwpO2SP24TNZvZUtK
 OBNPBenEt+j1phnpXXvUUaPXXpfMdwqi6Ugr9Y2abuE79xV5ZAqVAg+BE7kWAXIwlfVZ
 Z02Ztx7dYtouUQiyFWqnwuQrQeXT503GOPVxAWrZLgDXGUPv5oIT1s2p5wHakUitLFBV
 f5Rw==
X-Gm-Message-State: AOJu0YyJaamxofTwtfJdD8BAvt5TTebfsl8q8+2JCxYa+54U4U7oX3Ti
 RrJZCi8EC4HL/N+vrRc3PLZLJSxnFpDeaBJ5v1zROeCgmej/1KOJcHH0GPmUeAPJgzRB0rCniz1
 C
X-Gm-Gg: ASbGncsV7gGpNhDvnWujhPxk+0tUsTvJlfpAjvc5wMiLO4ZGK7smWI0hCx1kgriXASa
 b9rfVPcVWbyh2tdMK5YduaeDsZqPWyCOHg6D4AjP28T1iiugsd/8B2KbWmUVJbwscCIXX9fhbHh
 DICJY32Ta4fqXO6jSoJs8U3Uu4VjdGt7AXn0maomeZrH+BNh087h0P8U4bUi2AEeDPVKKqKxknj
 zPOiiErhTdjsfH57rG6sVO/iSNIZqcB/V7SygbWRyruaJGtei6xeJiu9iu+ScirkPYu9DSMa5Rj
 1S3jBlA2C9Pp3382l4+ZBQrGgr0A37vDyDelGqwAE3/EvNmpQtkFk4vbIZPr09cbMIsYVKGUX21
 H
X-Google-Smtp-Source: AGHT+IF33HD4M0pE4rN22ZHk8lRSmH0oNc9NA9lGbaCFkPCfW2mcP1wfd/cj3KYrLaYjD0LHKkYwHA==
X-Received: by 2002:a05:6a21:3986:b0:1f3:2ad7:ef5c with SMTP id
 adf61e73a8af0-1f544b19bc2mr2736031637.22.1741304469704; 
 Thu, 06 Mar 2025 15:41:09 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126e09dsm1809545a12.53.2025.03.06.15.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:41:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH] include/exec: Move TARGET_PAGE_{SIZE, MASK,
 BITS} to target_page.h
Date: Thu,  6 Mar 2025 15:41:08 -0800
Message-ID: <20250306234108.378881-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


