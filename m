Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C63E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoKA-0004dA-BK; Thu, 12 Dec 2024 13:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoK8-0004ca-HL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:08 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoK6-0006X5-Lt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:08 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2165448243fso10858735ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029643; x=1734634443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uY621Zpe5phiABfrjs1wu2fCtX/cc+LF2MmFvVEbl/U=;
 b=H/YwGtkoBKenFK3cuba5UZHJHPHQECf6cwcjBrdRKCeSPjh5xh51RSP6lP6g+cwFMr
 g8Y3ra+ETIbjBGa/YEX6GiF5/0AkiFdHT/7Kr0UpepcQZr1/dWF7FFHJmQ9sg1L+J1Ak
 Vp5zH2x7jbrylZDyJpgPvV6Y97Eenz8bbMG8a/qX4L3M79FIKFB8sD+HHgS1vFJWjrB3
 sD4HfHTTiFSJDYFe2il4vJpE778C6vQHbF2J5j5YdKRVYSkGfmJsTG1++2oKS6D5Xq0u
 Yt+XEj9abLUSlbtRTl4RvuHKCvwP9bfruKkswgr4fn7N07ytYNJe14+o2o6uFeiWn9Ky
 qIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029643; x=1734634443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uY621Zpe5phiABfrjs1wu2fCtX/cc+LF2MmFvVEbl/U=;
 b=q2Yi3AbLnCfcvUnWHE0S0YhLwzbvmtJ6pNnJRXbbfnjvJbF9vnWq9Z1OS6OzYslv9o
 hn6pnyj/MB+TGG3jK3AayAyK2SsKhK+Krizks/rYl+H/UCmireJ9dEDyyL9JL3sWI1f8
 w2xyyO09SFFcCTjHm047sj66ZSsob+TSGxMkEA1a0TQ/xEodKpm1szJh4bXAt73MMz5n
 PL/X8+vhViwWMDM0c2THVuykHH4GPINtGDwARnWhHxnZ/MfQUaDiSTZRU2j49XL04FdU
 pXf0bY7pbY8xujwrEQXKrz1irevKAxnhvlt8g0LMwHLlVkupkE3ihLW2U6LICDKJqwFE
 P3Uw==
X-Gm-Message-State: AOJu0YwJRDH3O/eLM0RKv/Oy+evjasbeIOxrjdo4jzKSf48pLvZ/AOw/
 1tZRph+Mxnr39y2qukcw/PSSXSWzb7m7UpRAw3DzntX6N2mbOnSYFCABktugP+6SHfuLMdSySnu
 Y
X-Gm-Gg: ASbGncv8/Bno2xU8UhsQG+3hQ+X8orolUCdE+WzUgWLQITTA5dbSvub0i2bBJ7/4+8+
 p05A0OVKsKFj4RUm80d93I77BWTmcChvlLatA3wAErGcyPC5vgyz7b/pkCOB8n58wt/nQQuRt78
 mOb0s9Bmf8SNySfAbe4ytk00Ks3sFXsyThkgWWHLRvjaVke2OVfu+lTeKBo49n3DShZKI/QQnwX
 f9mcXLz5v91xmS3B6jh+wIMBnJ44OJZO/5yi0+M4Eh4GkIrCiR79mXaOh/3x7lLN0uTAP0btMnn
 TlEgEBs+TzUEWNpGEeGM2Zy1ZPizpDI=
X-Google-Smtp-Source: AGHT+IF95yVjEzViHUIJFgEmelkcESNdFx72+teiAXxSXEmGO/vviLS7vjfDuNWNXVyS7FB683IA0A==
X-Received: by 2002:a17:902:db05:b0:215:f1c2:fcc4 with SMTP id
 d9443c01a7336-2178aeefc4fmr69485115ad.41.1734029642736; 
 Thu, 12 Dec 2024 10:54:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f29bcbsm126158075ad.262.2024.12.12.10.53.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:54:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/18] exec: Introduce 'user/guest-host.h' header
Date: Thu, 12 Dec 2024 19:53:24 +0100
Message-ID: <20241212185341.2857-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
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

Extract all declarations related to 'guest from/to host'
address translation to a new "user/guest-host.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 34 +--------------
 include/exec/cpu_ldst.h   | 47 +--------------------
 include/user/guest-host.h | 87 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 79 deletions(-)
 create mode 100644 include/user/guest-host.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1c40e276728..1c8e0446d06 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -64,39 +64,7 @@
 
 /* MMU memory access macros */
 
-#if defined(CONFIG_USER_ONLY)
-#include "user/abitypes.h"
-
-/*
- * If non-zero, the guest virtual address space is a contiguous subset
- * of the host virtual address space, i.e. '-R reserved_va' is in effect
- * either from the command-line or by default.  The value is the last
- * byte of the guest address space e.g. UINT32_MAX.
- *
- * If zero, the host and guest virtual address spaces are intermingled.
- */
-extern unsigned long reserved_va;
-
-/*
- * Limit the guest addresses as best we can.
- *
- * When not using -R reserved_va, we cannot really limit the guest
- * to less address space than the host.  For 32-bit guests, this
- * acts as a sanity check that we're not giving the guest an address
- * that it cannot even represent.  For 64-bit guests... the address
- * might not be what the real kernel would give, but it is at least
- * representable in the guest.
- *
- * TODO: Improve address allocation to avoid this problem, and to
- * avoid setting bits at the top of guest addresses that might need
- * to be used for tags.
- */
-#define GUEST_ADDR_MAX_                                                 \
-    ((MIN_CONST(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) ?  \
-     UINT32_MAX : ~0ul)
-#define GUEST_ADDR_MAX    (reserved_va ? : GUEST_ADDR_MAX_)
-
-#else
+#if !defined(CONFIG_USER_ONLY)
 
 #include "exec/hwaddr.h"
 
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index dac12bd8eb3..a26ab49b0b4 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -72,52 +72,7 @@
 #include "qemu/int128.h"
 
 #if defined(CONFIG_USER_ONLY)
-
-#include "user/guest-base.h"
-
-#ifndef TARGET_TAGGED_ADDRESSES
-static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
-{
-    return x;
-}
-#endif
-
-/* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
-static inline void *g2h_untagged(abi_ptr x)
-{
-    return (void *)((uintptr_t)(x) + guest_base);
-}
-
-static inline void *g2h(CPUState *cs, abi_ptr x)
-{
-    return g2h_untagged(cpu_untagged_addr(cs, x));
-}
-
-static inline bool guest_addr_valid_untagged(abi_ulong x)
-{
-    return x <= GUEST_ADDR_MAX;
-}
-
-static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
-{
-    return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
-}
-
-#define h2g_valid(x) \
-    (HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS || \
-     (uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)
-
-#define h2g_nocheck(x) ({ \
-    uintptr_t __ret = (uintptr_t)(x) - guest_base; \
-    (abi_ptr)__ret; \
-})
-
-#define h2g(x) ({ \
-    /* Check if given address fits target address space */ \
-    assert(h2g_valid(x)); \
-    h2g_nocheck(x); \
-})
-
+#include "user/guest-host.h"
 #endif /* CONFIG_USER_ONLY */
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
diff --git a/include/user/guest-host.h b/include/user/guest-host.h
new file mode 100644
index 00000000000..8d2079bbbba
--- /dev/null
+++ b/include/user/guest-host.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * guest <-> host helpers.
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ */
+
+#ifndef USER_GUEST_HOST_H
+#define USER_GUEST_HOST_H
+
+#include "user/abitypes.h"
+#include "user/guest-base.h"
+#include "cpu.h"
+
+/*
+ * If non-zero, the guest virtual address space is a contiguous subset
+ * of the host virtual address space, i.e. '-R reserved_va' is in effect
+ * either from the command-line or by default.  The value is the last
+ * byte of the guest address space e.g. UINT32_MAX.
+ *
+ * If zero, the host and guest virtual address spaces are intermingled.
+ */
+extern unsigned long reserved_va;
+
+/*
+ * Limit the guest addresses as best we can.
+ *
+ * When not using -R reserved_va, we cannot really limit the guest
+ * to less address space than the host.  For 32-bit guests, this
+ * acts as a sanity check that we're not giving the guest an address
+ * that it cannot even represent.  For 64-bit guests... the address
+ * might not be what the real kernel would give, but it is at least
+ * representable in the guest.
+ *
+ * TODO: Improve address allocation to avoid this problem, and to
+ * avoid setting bits at the top of guest addresses that might need
+ * to be used for tags.
+ */
+#define GUEST_ADDR_MAX_                                                 \
+    ((MIN_CONST(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) ?  \
+     UINT32_MAX : ~0ul)
+#define GUEST_ADDR_MAX    (reserved_va ? : GUEST_ADDR_MAX_)
+
+#ifndef TARGET_TAGGED_ADDRESSES
+static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
+{
+    return x;
+}
+#endif
+
+/* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
+static inline void *g2h_untagged(abi_ptr x)
+{
+    return (void *)((uintptr_t)(x) + guest_base);
+}
+
+static inline void *g2h(CPUState *cs, abi_ptr x)
+{
+    return g2h_untagged(cpu_untagged_addr(cs, x));
+}
+
+static inline bool guest_addr_valid_untagged(abi_ulong x)
+{
+    return x <= GUEST_ADDR_MAX;
+}
+
+static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
+{
+    return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
+}
+
+#define h2g_valid(x) \
+    (HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS || \
+     (uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)
+
+#define h2g_nocheck(x) ({ \
+    uintptr_t __ret = (uintptr_t)(x) - guest_base; \
+    (abi_ptr)__ret; \
+})
+
+#define h2g(x) ({ \
+    /* Check if given address fits target address space */ \
+    assert(h2g_valid(x)); \
+    h2g_nocheck(x); \
+})
+
+#endif
-- 
2.45.2


