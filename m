Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D2FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfhg-0008Tn-P9; Fri, 20 Dec 2024 11:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgv-0007da-NI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgt-00081J-NZ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so15396685e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711446; x=1735316246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5FRDH0gT4B7UQ0jomsp7+xsvPjqSK3/SJlM1JYZrYg=;
 b=IjCp+Z0f62OWHVo8YCljdf9nR5dawDbVBa2f8bwKag4PSBIqBRpr0Y1/ba+tpfjU8k
 c11vkXkK3JEvC8Sm9LrCILMQ6FmIhiLfH9yNmnctSJfHWyfDePJIDbxsg2LnkRS33oD6
 zZ0cTMuORWwbEgrinXRKDA9/3X9D9ci2YhXIykIKx0RzDV6r2lT2hSnJ3C4LD17WJMb9
 5sTeAmyA6BpMlhJejRcncct9GV6+Mg96BW9CN3VW4jls0RnwcRcD/36V04j1SB2lJQoy
 WPOxpeDKl9YLsdN/qjO5oyhY6N7YVIJdnTxDUFeJqdRsQZB+xIbw/4CkGtKfiJSBFC6s
 B3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711446; x=1735316246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5FRDH0gT4B7UQ0jomsp7+xsvPjqSK3/SJlM1JYZrYg=;
 b=m808QthZYuH+J224p0iRD60b2VHSBlAU/QBlJ3TSe4Ebyk1PRbh6hz2Qdp9cVXcq1W
 swkxK9KYpH4s0WKpoHo7kwBDbDBPZMBhxmlU8U6ZUvV6cZO87PJE25SaBTxRDoSuzYWp
 IbUnWekNGnjAyWMB7dkM9LUOLBJggoSwSF+npia3fSuygq9ROJbMIN8h7V1F/1YioInd
 S/rnVdq6m1s9C2rUdrj5qScjYY7iWSwAk3gobeUuKSJFQRFrFWJVy1ISkRSSahGNh45i
 vIm9MI72kG6QspH/PvdT8UL48/5bnJ2K7mkfMy0+Z4QsIHjZlZjxobZ9axqiCYfwVX3n
 STzQ==
X-Gm-Message-State: AOJu0YyBHpr62gJsPozUJmUpo13xPkaewjZQyJpqDa8iIbUx/Wbfg48h
 vKIbptpYy1SQuHmji14IfhIz5OFgtfmi3/T7bwF7Nh+dR/mXLaYdUsbcjmWDQ5qjkem6Ai/yUAV
 E
X-Gm-Gg: ASbGncvhOdBBktsjssjg5eGD9/Vwfp93dOHjtqvitx3yyu3Vcl8gzeqWXuilSghi5ML
 5utGoEm1n7vFkQSrRlm8lcFXI0xD4DZft9Hm3pnPLtbf00hsEs5VX0H5ZWTlAvDs4FtaQOvJ+gl
 z3PDyBBbQjV6/fxdD1jEalq1vWPdBOIF6mpnvfwVh2Mt01+zcJ4E9SWRKYU8H5ltL1FklXl0+Zj
 xQ9aNikopF/8CA74BsgenPpNfn5uziIiZ8ndJZCRQ33jV/VwhmOAXPE83p4hOM1+hc2okFEhuk=
X-Google-Smtp-Source: AGHT+IFN+pfVtQNNjro8TRNErF9sQnPI0AGKja/cV6yC4j9L9tktRdo75ntHu7BETsPrCipIwE5sEg==
X-Received: by 2002:a05:600c:3150:b0:434:9fac:b158 with SMTP id
 5b1f17b1804b1-4366854718emr24861435e9.1.1734711445518; 
 Fri, 20 Dec 2024 08:17:25 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c515sm49852675e9.30.2024.12.20.08.17.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/59] user: Introduce 'user/guest-host.h' header
Date: Fri, 20 Dec 2024 17:15:11 +0100
Message-ID: <20241220161551.89317-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20241212185341.2857-2-philmd@linaro.org>
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
index c1dd424dc1b..769e9fc4404 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -73,52 +73,7 @@
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
2.47.1


