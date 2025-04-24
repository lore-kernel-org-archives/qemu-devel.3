Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D597C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kp9-00087O-2I; Wed, 23 Apr 2025 20:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kn7-0005ev-3y
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmy-0004Nl-BH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso509021b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455800; x=1746060600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oon0vpY/g0fMqcKiyF4ogPUXdsQUvseLPptppKyoVRs=;
 b=NgQjl5Qg6Jod6lzDRI9bvH5fpeHBASOLTcRAkhL0HOhA3MPDssRY80ZT/GcYny47HD
 vwRyT621YeaBuEsLk2WQp2nl1kvl+gBtksnvEbhAgey5ONmraQlzuD3dEwXkqrkXH9wc
 CsIaYh/ymHxZELM7X/qOqJNh8wrRV0Ho4EecltlzocfL/yTwN6zA7dzEUDJYkhrUPm5Q
 qhdh4Zn1R8Ziu2rDT+iuGFKk9prnkvgpyLnQcwnbcKkciug9SrGTgd1EhXUJr0SFK3xR
 PqmDQ2cABHoB0l9MCDFdnpzs1oLCf9og2BPAdibJeGU7w7nIN1MUyu7Nb0GXA9dCyGVg
 a07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455800; x=1746060600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oon0vpY/g0fMqcKiyF4ogPUXdsQUvseLPptppKyoVRs=;
 b=XAfnjuBjQ+dE+mwPce8Wezyo9DUxYcIHaqdx2ViApUqijmHGaXTlG4v/bC4d28EXBd
 OKktj047B5A5ljGWcZ5PTPZovyEtN1WqhbV/66Ju8ezQoRLtLKjysqHjxKft9syAk4MU
 Kj2Xdf4pfRoZtv4To9xzxhBK6bMODx6LYU6ivL1ntGB0C4P1OKrM5yComojFRlhQ6EpK
 iV7upp2V8cL/DIPE6djN7ae5l/4bQnoM0whMK0LQrAiCyJM0QQcWBMkCaHCZOrx23XQS
 9Tzspsam1f/LR2naG71BSgbOcWDsIFa9khfP6TdnptuIGkwsffMN7UHGdqK0+6vDGL+6
 ALfg==
X-Gm-Message-State: AOJu0YzZt1emHawPjuiAvUVBGKOG6lf+iQBPzRWAP/3+Y75P0+49NsNO
 mNsXVSyDzatF/9h36fjUVWb8iBlmxmhN1nE0ms1WlSPyEkNZfCm2B6prsoMllGATwqRg8FcBmfJ
 G
X-Gm-Gg: ASbGncv1DDp4aYrjYC0a6CP4JNbIW+yNapJoEh7UItZ1Xaz0f/kc0xml5rTTa+gJs6k
 Eo5COM2V03oUhD1x4IW97oZ7mP5z1wkCDzNWtkTFvVEfF0H5SMpKPYuESE0LSJoHYOfzG9+KXVB
 /9pz0zX+Cf4hRCJTV8514THvaE4xqvuBHDf3V9ZK2AYbJ2Fk69QNd7jt4HaqlMhOqS5ja7GT2Ng
 rTCYjxskFjHoEKIxla5eTnPLyPfRTuxAo56ld98Tm95oN9MewIpNA6tv4uJWER4PndmIJTAFz0c
 O3tkRl4DbsIOLQUJrLtmp0jx1UXnalFii4IeOKrmqKiEHzmJIl8cW8sJsPE67iJlPFylxhLIbPw
 VdsWqxY+DBA==
X-Google-Smtp-Source: AGHT+IFXF+Olf8PBYBJCObD2mK0BnXSCySQJFyoTg1vdjzn8l9vn8sSGTCe8w3I7Sg4UM1VhzARfrA==
X-Received: by 2002:a05:6a00:8104:b0:732:5875:eb95 with SMTP id
 d2e1a72fcca58-73e267e0e51mr559653b3a.4.1745455799898; 
 Wed, 23 Apr 2025 17:49:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 033/148] include/exec: Split out mmap-lock.h
Date: Wed, 23 Apr 2025 17:47:38 -0700
Message-ID: <20250424004934.598783-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Split out mmap_lock, et al from page-protection.h
to a new header.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h    |  1 +
 bsd-user/bsd-mem.h             |  1 +
 include/exec/mmap-lock.h       | 33 +++++++++++++++++++++++++++++++++
 include/exec/page-protection.h | 22 ----------------------
 accel/tcg/cpu-exec.c           |  1 +
 accel/tcg/tb-maint.c           |  1 +
 accel/tcg/translate-all.c      |  1 +
 bsd-user/mmap.c                |  1 +
 linux-user/arm/cpu_loop.c      |  1 +
 linux-user/elfload.c           |  1 +
 linux-user/flatload.c          |  1 +
 linux-user/mmap.c              |  1 +
 linux-user/syscall.c           |  1 +
 target/arm/helper.c            |  1 +
 14 files changed, 45 insertions(+), 22 deletions(-)
 create mode 100644 include/exec/mmap-lock.h

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 2cdf11c905..c88f007ffb 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -13,6 +13,7 @@
 #include "exec/translation-block.h"
 #include "tb-internal.h"
 #include "tcg-target-mo.h"
+#include "exec/mmap-lock.h"
 
 /*
  * Access to the various translations structures need to be serialised
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 90ca0e3377..1be906c591 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -56,6 +56,7 @@
 #include <fcntl.h>
 
 #include "qemu-bsd.h"
+#include "exec/mmap-lock.h"
 #include "exec/page-protection.h"
 #include "user/page-protection.h"
 
diff --git a/include/exec/mmap-lock.h b/include/exec/mmap-lock.h
new file mode 100644
index 0000000000..50ffdab9c5
--- /dev/null
+++ b/include/exec/mmap-lock.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU user-only mmap lock, with stubs for system mode
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef EXEC_MMAP_LOCK_H
+#define EXEC_MMAP_LOCK_H
+
+#ifdef CONFIG_USER_ONLY
+
+void TSA_NO_TSA mmap_lock(void);
+void TSA_NO_TSA mmap_unlock(void);
+bool have_mmap_lock(void);
+
+static inline void mmap_unlock_guard(void *unused)
+{
+    mmap_unlock();
+}
+
+#define WITH_MMAP_LOCK_GUARD() \
+    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
+         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
+
+#else
+
+static inline void mmap_lock(void) {}
+static inline void mmap_unlock(void) {}
+#define WITH_MMAP_LOCK_GUARD()
+
+#endif /* CONFIG_USER_ONLY */
+#endif /* EXEC_MMAP_LOCK_H */
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index 3e0a8a0333..c43231af8b 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -38,26 +38,4 @@
  */
 #define PAGE_PASSTHROUGH 0x0800
 
-#ifdef CONFIG_USER_ONLY
-
-void TSA_NO_TSA mmap_lock(void);
-void TSA_NO_TSA mmap_unlock(void);
-bool have_mmap_lock(void);
-
-static inline void mmap_unlock_guard(void *unused)
-{
-    mmap_unlock();
-}
-
-#define WITH_MMAP_LOCK_GUARD() \
-    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard))) \
-         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
-#else
-
-static inline void mmap_lock(void) {}
-static inline void mmap_unlock(void) {}
-#define WITH_MMAP_LOCK_GUARD()
-
-#endif /* !CONFIG_USER_ONLY */
-
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ef3d967e3a..372b876604 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -27,6 +27,7 @@
 #include "disas/disas.h"
 #include "exec/cpu-common.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3f1bebf6ab..d5899ad047 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -24,6 +24,7 @@
 #include "exec/log.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 82bc16bd53..16e5043597 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -45,6 +45,7 @@
 
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "tb-internal.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 3f0df79c37..47e317517c 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "exec/mmap-lock.h"
 #include "exec/page-protection.h"
 #include "user/page-protection.h"
 
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 7416e3216e..e8417d0406 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -25,6 +25,7 @@
 #include "signal-common.h"
 #include "semihosting/common-semi.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "user/page-protection.h"
 #include "target/arm/syndrome.h"
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fa83d78667..99811af5e7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -10,6 +10,7 @@
 #include "user/tswap-target.h"
 #include "user/page-protection.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
 #include "user/guest-base.h"
 #include "user-internals.h"
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index d5cb1830dd..4beb3ed1b9 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -35,6 +35,7 @@
 
 #include "qemu.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "user-internals.h"
 #include "loader.h"
 #include "user-mmap.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d1f36e6f16..f88a80c31e 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "exec/log.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include "qemu.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8bfe4912e1..5826ac3adb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -26,6 +26,7 @@
 #include "tcg/startup.h"
 #include "target_mman.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include <elf.h>
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb445e30cd..0454b06a6c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -14,6 +14,7 @@
 #include "cpu-features.h"
 #include "exec/helper-proto.h"
 #include "exec/page-protection.h"
+#include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
-- 
2.43.0


