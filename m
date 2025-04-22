Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED4CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIE-0002O5-3M; Tue, 22 Apr 2025 15:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIC-0002Mw-8N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JI9-00069G-B0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224171d6826so79561335ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350103; x=1745954903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWWqDQpkYSHDISmeC6TzU4TbRuBzp7ZNAHRWv+UuIFE=;
 b=z8T/eSCZgmrsT8KbhAW/fnMfm61gJKjwvJF3aqGYvlwxv7q68061QQWtPEaukv/0EH
 uHVFg5MN1WPXn86m4rGjyUJ08Sc4aDl62t22HcTKZSxqrqIjeQcTZwh70eLfacpXFnme
 m5uCRZ5uah6MgTsP9ckgvJm3pKOm409RnNj08WHDhLXUhZozJ5GGTCJ/i8PgWuzC6Qi+
 qH2yBFCg/dvZl6xDlA9Qf/jZwP5FhVfdyKYr8Zt/+WqMMGWHwhmfH8ouSWSxO9fVW55Z
 bgqHb5eIE/kQ49Osqpv7nWiRpxrY+DnWaUEhW7ceQWFDOqoiGqlaDGGzxLrwCivKirw4
 xbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350103; x=1745954903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWWqDQpkYSHDISmeC6TzU4TbRuBzp7ZNAHRWv+UuIFE=;
 b=byGrFtSIgRzde2+2Jkk9A4L9wIjI6r3rrHZyZ237C3t/qNfOS6+vEBWQN70+6qyFV4
 X7VnzVLpclO7fCVKfq6VW2ImCfN3r4RHSPRDKS6dgel7eFPbBAarHuIcV8+H0J1mCDTg
 /qCYIOzfzJj3YAHsL+WTUq+dy+o6lmSOzyCyFLMMiwQs6Nmu0GyUD8yM+afB7cx2Dm/2
 v+DG1hdcRo9Pgmp0y8gCnb4X39OEU/q3jlWuJefqmkzgZsWWflWDO4V9ihtliEUsZg/S
 sReDJAXNUF/ZUuf9aCQAgdaqQ49d0REzEcKvFFPBjSIOcdU5ikIpoqRHWsTs4rSCyG/v
 olLA==
X-Gm-Message-State: AOJu0Yysl1p1x+Qg/1UnjU+NA/obQQCWhWg+AuZmE6t2mnjUxjYX75vh
 tLpL6tiTFuThYXBGS7YTB3VaRdVmo/oKf02jMZfoqikp2mG7yYLO0/Y9S5terDYHg3PYiJcDdQF
 o
X-Gm-Gg: ASbGncuRc8iebt2IMTJxUMArf1kI4tdaQRfJsFyrtPenu9ijxXjf0ETWHbhNRe4dFlB
 pQBuMjwnSZMeBTD8Mfcu9cd/YkTV2d4eOe8fqWM+RcYrYR7GM5RE4778I5XTswfFN+J5sjJMbAh
 Zr8utBeYfReZSPYM6OidB2QDRwLyCg5s12XpCcsuRcnSGu0SPaoon1BhHu62Fdnvrv+n4SPhRtZ
 VhJxRFmITNwwTpP7lM1m++kBZzGx9ILHY5ohZBmbRqp+y4GXzHFanAPARYoqGg2GfcBJaLsbafQ
 RZ3o2ky9zihn+Q8AvqHVgrMaaPlBUvhCzTegWUt7ZRnJpnmZJ8Zewnw7mM5l1AMw9rG7dI+zA5E
 =
X-Google-Smtp-Source: AGHT+IFjNGOr6kN0kRNsDskBJlp5cVQp9iX41/VjkgvsEaQT7PFUrDMvK1k1783RUU1ewH+aAQmOKA==
X-Received: by 2002:a17:90b:3885:b0:2ff:6aa6:47a3 with SMTP id
 98e67ed59e1d1-3087bbad709mr24953034a91.25.1745350103306; 
 Tue, 22 Apr 2025 12:28:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 004/147] exec/memory_ldst_phys: extract memory_ldst_phys
 declarations from cpu-all.h
Date: Tue, 22 Apr 2025 12:25:53 -0700
Message-ID: <20250422192819.302784-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

They are now accessible through exec/memory.h instead, and we make sure
all variants are available for common or target dependent code.

Move stl_phys_notdirty function as well.
Cached endianness agnostic version rely on st/ld*_p, which is available
through tswap.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-5-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h              | 31 -----------------------------
 include/exec/memory.h               | 10 ++++++++++
 include/exec/memory_ldst_phys.h.inc |  5 +----
 3 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7e8d66de31..66a4252269 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -25,37 +25,6 @@
 #include "exec/memory.h"
 #include "exec/tswap.h"
 #include "hw/core/cpu.h"
-
-/* MMU memory access macros */
-
-#if !defined(CONFIG_USER_ONLY)
-
-#include "exec/hwaddr.h"
-
-static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl_notdirty(as, addr, val,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-#define SUFFIX
-#define ARG1         as
-#define ARG1_DECL    AddressSpace *as
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst_phys.h.inc"
-
-/* Inline fast path for direct RAM access.  */
-#define ENDIANNESS
-#include "exec/memory_ldst_cached.h.inc"
-
-#define SUFFIX       _cached
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst_phys.h.inc"
-#endif
-
-/* page related stuff */
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e1c196a0c2..cc5915033c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -21,6 +21,7 @@
 #include "exec/memattrs.h"
 #include "exec/memop.h"
 #include "exec/ramlist.h"
+#include "exec/tswap.h"
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
@@ -2732,6 +2733,12 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "exec/memory_ldst.h.inc"
 
+static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
+{
+    address_space_stl_notdirty(as, addr, val,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
@@ -2798,6 +2805,9 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#define ENDIANNESS
+#include "exec/memory_ldst_cached.h.inc"
+
 #define ENDIANNESS   _le
 #include "exec/memory_ldst_cached.h.inc"
 
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index ecd678610d..db67de7525 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -19,7 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifdef TARGET_ENDIANNESS
 static inline uint16_t glue(lduw_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_lduw, SUFFIX)(ARG1, addr,
@@ -55,7 +54,7 @@ static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
     glue(address_space_stq, SUFFIX)(ARG1, addr, val,
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
-#else
+
 static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldub, SUFFIX)(ARG1, addr,
@@ -139,9 +138,7 @@ static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t va
     glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
                                        MEMTXATTRS_UNSPECIFIED, NULL);
 }
-#endif
 
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
-#undef TARGET_ENDIANNESS
-- 
2.43.0


