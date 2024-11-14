Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94618D637D6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBORw-0000Nn-LP; Wed, 13 Nov 2024 20:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORi-0008Ly-BG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:55 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORe-00029z-NX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-382026ba43eso73396f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546888; x=1732151688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/Mwf2dMLIwY53Hwy+X6Y1uqRqRvCrR6xhY52hogfuU=;
 b=vvEQxboJFU8COX+Da+B/7SrRCGQSsmSO/mWq+PvuFHjPm+ysEVGKKCo+19vg+G6jE9
 Gp9lXvBqEuFq0E4neXdYfTATS7/RoTss/o1loHLNooIDOhqUi5KkYUT/Oay/chG3soIU
 zp+MOcKVeWpg0+Bj8+QdkOe1me00R88Y8OZQLb3YyU8k2zKjlYE5OfVpzXd9UpdLNGn3
 845jKDPMlwQbjKCHfbTKpaPjDRP5NMpduZq5fS6kDPK0oiA8SwxqfNieCrpuqTDoXlFD
 XI+DsXVG6aKTG/W7hVPgE7N3hFPUw6Kg3vjknOOBzKQwBQudLBXhxWMUcZXe5Crt9Gyw
 1oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546888; x=1732151688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/Mwf2dMLIwY53Hwy+X6Y1uqRqRvCrR6xhY52hogfuU=;
 b=akbolGs6O53l8320c87QmoO9KDaWc5LJhn4o+qKmLANktUAwrBtu73cn55IsgbjjQV
 aCxfnbFTyWsetdvYBUxm4DvY54yLus0OxiJMIOyMhRl1Cr/nsibtNnzcU60myeeosII/
 1IG+sUEuHDEdZlNxw83jzA4/pqPbgUvLFIMYYsS5HO6bi3U77jeuiArLx7QTuDpSUjyU
 ZaovbKUOi/QMoHoIlYbFq/T5UbBC3SUT1LrYogxNKnZEjXPK7A/UiibwiH7hVdaBqP5w
 hyU8FuochkcVyaeZ4KN/SwDtQPBAxWSaWWFft7ojMRv/zrDvkcmss499mOzEj56yE3k4
 cLeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcPW8PXGUkHYk6SRcpsv3r6/iSos+nXacxChssSe9/BsJpnOPh9SbymL5M9ebLuvyebq+6miCPuETU@nongnu.org
X-Gm-Message-State: AOJu0YybClxl2YK8d0ljynSVYrKaK9YaRvqIOVvm4PtL8QV3e5U1waj4
 YU1gUVNB8g9lJcbLE/92ANTBQQnLFs+knJ6s8zldHYxwT2h8jtVG2BwR1ufpF7BHFUaBaBL15PN
 p
X-Google-Smtp-Source: AGHT+IGYsjllJjcWqtSFLvVfioihKxt7KGt6nILKJp1/7Hyu2p6hwA9EsQJ1WMNsoFs9SnNIT8G0og==
X-Received: by 2002:a5d:598d:0:b0:380:54f2:3408 with SMTP id
 ffacd0b85a97d-3820812360bmr6334702f8f.25.1731546888217; 
 Wed, 13 Nov 2024 17:14:48 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970d05sm20012547f8f.1.2024.11.13.17.14.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:14:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/24] exec: Introduce 'user/guest-host.h' header
Date: Thu, 14 Nov 2024 02:12:56 +0100
Message-ID: <20241114011310.3615-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Extract all declarations related to 'guest from/to host'
address translation to a new "user/guest-host.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h    | 34 +--------------
 include/exec/cpu_ldst.h   | 47 +--------------------
 include/user/guest-host.h | 87 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 79 deletions(-)
 create mode 100644 include/user/guest-host.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1c40e27672..1c8e0446d0 100644
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
index dac12bd8eb..a26ab49b0b 100644
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
index 0000000000..8d2079bbbb
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


