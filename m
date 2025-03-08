Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDCEC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38Y-0004bf-GZ; Sat, 08 Mar 2025 17:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38P-0004WW-HV
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:09 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38N-0005KL-Gl
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:08 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224100e9a5cso56104295ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474746; x=1742079546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwmVXBfhomA9Bq+qJ9rthBcoWLqoBCovvXeLZWVVOjU=;
 b=QsOQKGtQroJWcgWUQ8UPo++0WWUmX8J4kKOhmBYjvY9OI9euJ6Xsp2E8KyBhP/5ffZ
 xteY/xqL80byLcE4uCeHs365omRaYYRtaB99LvMFhAqioOQ96QOTuSzWOck/bgHilqUe
 qb+0ByiJEMPGRVNNJ1ikkj9yI6ZxRBSERvfKwA63pSK84NCFP9/QEqnyEzmiG88b3WTC
 GWixZIY1tkVAYc766ZyRg2m881Kjx44bHrWCGFU9nUAhr7k0j+H9/VSFu3wn3B0ZhC9n
 xCRbdqKw46EDFIXPwUDBL2oZlaIcOWoju0ZJFr9qrPsLESkCARsfMsQI1RpD3/RPpoAE
 AmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474746; x=1742079546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwmVXBfhomA9Bq+qJ9rthBcoWLqoBCovvXeLZWVVOjU=;
 b=ehOiFesCBAMn4cIfV0m1CZYsKgOW2Ki4jMWcG0wfmMm1Vu9Z/r/q6ZqDWhlX2K51s0
 ib9xPDrLpJ2T7L32S0ZzQcq1b9yaQN42y684w3QEq1G/0YMN6ewUXSyfaZzfTK4kFgK4
 JIQB9SH0k9A5CFpnz9Z2EbdRzLtq+5LkFaaz7uS5YO07NQWKEgQhnStv8M3demt2Fr0G
 6C6HzgDPtkZ1UGBqMnxwDjIma1vmDG63BGjh+EroE2pJ9ic8xutw/hDvNI9uH/pxMEwb
 +Ib1faQ9qlR3osVAv7rY3Yn8rHRxg9ymt75wsy+MzZ0AR9EN+21jLYlpfLih1SE5aAut
 Kc4A==
X-Gm-Message-State: AOJu0YxQm10pF+XM19RacIBUdEXr+/2buWotxfn1fIiByTwTTNwUXnTQ
 1cXeW2m6yqA3GDNCR4/OBAQXGGHApfokHQoUBLEyeyEV5c7sQOR4z+t8oyu6xBSdOPHQm+1O7Nk
 Z
X-Gm-Gg: ASbGncso/HG+N0sM0f7tNefVOOuCiZvHeeKTla3f2NGffqEqdBnlHpRyNcPshqrqOLH
 ulo4gOJLgRPYf7Ro0cJEH1LK0WsN0fN8KFl5g41Emyp85YhbI5q3x3qaCAsppmvO9semgak6RaK
 kT/yvbBnWkl2Suh3XmdVA75YMAb9iImVqvF5BRWQv/tbSphyYl01wMndxVmTD52ZHNimk2eaMms
 jMnTDiC4Hqh+29eUdvU8gfPA9tXA6TriiTffPPPYIS6ymkdqB3J2swE3u/J1X64uBZqSuR/TVCA
 pWaL0In+4oeOtVW0Lelzqb3u0p2gelUlVl0GZfkl+DVjq5xl+S87lOVOnZtn63Sv2mg+Ts71nqe
 HDfDKWVYz8iI=
X-Google-Smtp-Source: AGHT+IGUfE4iEHmKdp+TEktXEdFDHwGoBoy6uot/g+/cXiQ8MzXB30jI9wtZv2Y2dtYjODMhLUlECg==
X-Received: by 2002:a17:902:f648:b0:220:d601:a704 with SMTP id
 d9443c01a7336-22428a967a4mr124452505ad.18.1741474746000; 
 Sat, 08 Mar 2025 14:59:06 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/23] include/exec: Move TARGET_PAGE_{SIZE, MASK,
 BITS} to target_page.h
Date: Sat,  8 Mar 2025 14:58:42 -0800
Message-ID: <20250308225902.1208237-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h     | 21 +-------------
 include/exec/poison.h      |  4 ---
 include/exec/target_page.h | 58 ++++++++++++++++++++++++++++++++++----
 page-target.c              | 18 ------------
 page-vary-target.c         |  2 --
 5 files changed, 53 insertions(+), 50 deletions(-)

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
index d6d4832854..35721366d7 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -44,10 +44,6 @@
 #pragma GCC poison TARGET_FMT_ld
 #pragma GCC poison TARGET_FMT_lu
 
-#pragma GCC poison TARGET_PAGE_SIZE
-#pragma GCC poison TARGET_PAGE_MASK
-#pragma GCC poison TARGET_PAGE_BITS
-#pragma GCC poison TARGET_PAGE_ALIGN
 #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
 
 #pragma GCC poison CPU_INTERRUPT_HARD
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
index 343b4adb95..3f81144cda 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -35,7 +35,5 @@ bool set_preferred_target_page_bits(int bits)
 
 void finalize_target_page_bits(void)
 {
-#ifdef TARGET_PAGE_BITS_VARY
     finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
-#endif
 }
-- 
2.43.0


