Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9E6D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFi8-0004LO-4f; Fri, 09 Jan 2026 11:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhl-00048L-13
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhj-0007Km-8K
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so31095315e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977473; x=1768582273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zZ+dDg2AAGkhLg3iXfpGTgf3L8BMi8SqQDgfdcxl7o=;
 b=KGyWnPfE9rwi8Zkd6N6kD7ua8IPwhq7CQQDphGZ7uHMcWStwfIHchtGBLKArMCAlcp
 a51PTnw8zNN8HY8Nh6sC9E9x55UgVBSL+JM0CfpnO4qdYWyOsW/70JxEaH2H2YOcwH4V
 yTQT2Eo907A+klqPHJh+I5I6HX76aMXxnB2HTGO68ayns7u+OArgjXfxc4M2Nghmzyrd
 X3WhXDVF2rKy2qOxmkv6Bj0SBFuNBwGvOEW2ABRpyX+9ztiX4XmlyxI8BBDTlZEm6KZU
 hCBCl/GmGf6+K8lMvk10WpZhLar0nQAU3/ybEWJPVLToLKDyZVedJrS9VdGdMwLwcQIu
 sp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977473; x=1768582273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+zZ+dDg2AAGkhLg3iXfpGTgf3L8BMi8SqQDgfdcxl7o=;
 b=HdQ4aUqWvmkLpMHEkKw0e6+PSGwZXy3rKIIphRJXwzy6OHQtWWxhvcbQZkWDz3nrbh
 q97KaigJdZMv6jN6xhpwR/u4gPGaamRiDUjLmxVNzDnLBRs6tAXVu6hUSga+E9BuLNU7
 lesI7avXG4+rY6BUCrpNzG8Ckhv+GmkrD2invfnsTcpNusK2NZpyk57X5VofeCvv/Csc
 xG6S+Ny445vG/bgAlRJ9MVP4M9Vf8aLWzCggKRL4rXslrQBF5KH0JdwNa/I2pk8jYP2e
 /NORDb33xcXZ+43gZhbu17inLB9vCrceEOpW+gYQPQQwj0fPO1E8VE/pFQCYJHTWbb9m
 u3xA==
X-Gm-Message-State: AOJu0YzK2JVmCFYSKYQYXjqa0lwtysj5lzk/CFRfxnnDZgi/vsu6sU21
 6G44aTFJDEm/sXEzofDW+gUH1yu6bjACUYIpNeRbAuT6iWZE0bYwecZJijoa5efKzH+dHa5PHeg
 tKDTaWHs=
X-Gm-Gg: AY/fxX55zzknvSb6ypEFC64gRaOivswW1Ic+Bf//gwO0RYHT7ZrQ8fS3RWWPAtHuMFd
 N3uCIlyFduB3qJ9o8CFTaMzBkb1iwFDXxZEw12ccZEaMX3j7WF7I65KCwHYIdN9Uguo+frMCDVF
 uFC2gyZXLDowkHI7cLAMoBz4bb/NGBoT35NweKVb0e36zTmUg/qbW/M02zVVilHdrliyEecZbRU
 ZIWBejWztdgYo9Ek1+ZWMBKudEeU4DQWW08PjKXXlv0d9VAAJ0QYO13X1v9+RFMK79CFLWgvIkl
 BrOJvJJP11mJPU1VxvKsVkd5cEHwq2RNNiEDKesrrOSIXG2ar36VMxAI+6tcozwxjtGaXsfDvsz
 ZQ8xphZXV6OfJwkCuQCAVcd5JSu7TBMHoagV+bYDkxuLNd3NT+rRujUS9e5Qxttkq4+sewKivrc
 vDlqyRM2leW9EVhXHrF4I735vftCi/oUY6zuThjEJ1EEBa1QRPt9OvIR439KGW
X-Google-Smtp-Source: AGHT+IGfBX5ZEL4YgGTs+lz57QNk4mso7mW/2kECJmx/vj/PzGxDApso3ZuWoIWgdIusOLIG1o7lAg==
X-Received: by 2002:a05:600c:3114:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-47d84b18954mr105924645e9.2.1767977473318; 
 Fri, 09 Jan 2026 08:51:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm229120445e9.1.2026.01.09.08.51.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:51:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
Date: Fri,  9 Jan 2026 17:50:38 +0100
Message-ID: <20260109165058.59144-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Introduce load/store helpers which take a MemOp argument.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                   |  1 +
 include/qemu/ldst_unaligned.h | 25 +++++++++++++
 util/ldst.c                   | 69 +++++++++++++++++++++++++++++++++++
 util/meson.build              |  1 +
 4 files changed, 96 insertions(+)
 create mode 100644 util/ldst.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d8583cbb52..4eb4e34ce75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3272,6 +3272,7 @@ F: system/physmem.c
 F: system/memory-internal.h
 F: system/ram-block-attributes.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
+F: util/ldst.c
 
 Memory devices
 M: David Hildenbrand <david@kernel.org>
diff --git a/include/qemu/ldst_unaligned.h b/include/qemu/ldst_unaligned.h
index 63a091ad401..2c5c6723802 100644
--- a/include/qemu/ldst_unaligned.h
+++ b/include/qemu/ldst_unaligned.h
@@ -6,6 +6,8 @@
 #ifndef QEMU_LDST_UNALIGNED_H
 #define QEMU_LDST_UNALIGNED_H
 
+#include "exec/memop.h"
+
 /*
  * Any compiler worth its salt will turn these memcpy into native unaligned
  * operations.  Thus we don't need to play games with packed attributes, or
@@ -64,4 +66,27 @@ static inline void stq_unaligned_p(void *ptr, uint64_t v)
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
+/**
+ * ldm_p: Load value from host memory (byteswapping if necessary)
+ *
+ * @ptr: the host pointer to be accessed
+ * @mop: #MemOp mask containing access size and optional byteswapping
+ *
+ * Convert the value stored at @ptr in host memory and byteswap if necessary.
+ *
+ * Returns: the converted value.
+ */
+uint64_t ldm_p(const void *ptr, MemOp mop);
+
+/**
+ * stm_p: Store value to host memory (byteswapping if necessary)
+ *
+ * @ptr: the host pointer to be accessed
+ * @mop: #MemOp mask containing access size and optional byteswapping
+ * @val: the value to store
+ *
+ * Convert the value (byteswap if necessary) and stored at @ptr in host memory.
+ */
+void stm_p(void *ptr, MemOp mop, uint64_t val);
+
 #endif
diff --git a/util/ldst.c b/util/ldst.c
new file mode 100644
index 00000000000..fb11c073bcb
--- /dev/null
+++ b/util/ldst.c
@@ -0,0 +1,69 @@
+/*
+ * Load/Store helpers for QEMU
+ *
+ * Copyright (c) Linaro Ltd.
+ *
+ * Authors:
+ *   Philippe Mathieu-Daudé
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/ldst_unaligned.h"
+
+uint64_t ldm_p(const void *ptr, MemOp mop)
+{
+    const unsigned size = memop_size(mop);
+    uint64_t val;
+    uint8_t *pval = (uint8_t *)&val;
+
+    if (HOST_BIG_ENDIAN) {
+        pval += sizeof(val) - size;
+    }
+
+    __builtin_memcpy(pval, ptr, size);
+    if (unlikely(mop & MO_BSWAP)) {
+        switch (size) {
+        case sizeof(uint16_t):
+            val = __builtin_bswap16(val);
+            break;
+        case sizeof(uint32_t):
+            val = __builtin_bswap32(val);
+            break;
+        case sizeof(uint64_t):
+            val = __builtin_bswap64(val);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    return val;
+}
+
+void stm_p(void *ptr, MemOp mop, uint64_t val)
+{
+    const unsigned size = memop_size(mop);
+    const uint8_t *pval = (const uint8_t *)&val;
+
+    if (HOST_BIG_ENDIAN) {
+        pval += sizeof(val) - size;
+    }
+
+    if (unlikely(mop & MO_BSWAP)) {
+        switch (size) {
+        case sizeof(uint16_t):
+            val = __builtin_bswap16(val);
+            break;
+        case sizeof(uint32_t):
+            val = __builtin_bswap32(val);
+            break;
+        case sizeof(uint64_t):
+            val = __builtin_bswap64(val);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    __builtin_memcpy(ptr, pval, size);
+}
diff --git a/util/meson.build b/util/meson.build
index 35029380a37..b695b6e4728 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -38,6 +38,7 @@ util_ss.add(files('envlist.c', 'path.c', 'module.c'))
 util_ss.add(files('event.c'))
 util_ss.add(files('host-utils.c'))
 util_ss.add(files('bitmap.c', 'bitops.c'))
+util_ss.add(files('ldst.c'))
 util_ss.add(files('fifo8.c'))
 util_ss.add(files('cacheflush.c'))
 util_ss.add(files('error.c', 'error-report.c'))
-- 
2.52.0


