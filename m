Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507EDC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYB-0001MO-Dp; Tue, 18 Mar 2025 17:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXw-0001GD-Rp
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXu-0000lP-C2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22438c356c8so107498375ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333541; x=1742938341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ND0Di9AWhbRdiSFtP1yfC5dCcVpda7GL/aN3C0ZIrvs=;
 b=bFT/lf3wqosoVdyIceXskPORWaaDTfGyxNvVuMt237DPSUylBr8kZQsAOoeplvBLbH
 6MPTfnKyrt0TzhxMlMjpz8lSQ55VKPqE2fRlGLnQQitYprp/O6HitjxRbWYZsarNBlCi
 ni+8xAHEkzWOXs+pGEeXqxwSdhtpl2TjNitBrNGyspFKt824SwPxQi1ZKUUHCbVogBVF
 rBi2sjkzzc+w+tpxsjslDwLRH6sSlz/mMwANGeL6p9xR3mlmi9b1QPPyNPCkoeHqLFKQ
 yRfP+6wAVkBkdm3Rn409tlAhOF5wvgJ4mHJCcMqwE334jCHO8tkHOJqRMG1yMj3KKKiG
 gs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333541; x=1742938341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ND0Di9AWhbRdiSFtP1yfC5dCcVpda7GL/aN3C0ZIrvs=;
 b=k1BT61rI24wXeTQSNhLDpBqUFw3Vp9xC0vxjOFoatLxWSh3s3ihtuLEoYHKZ66k7fq
 eOp+FoQtZQgNXy/XHJtLgkaeLDQFiQWEgryTEZBmq6dZw4sZlXSLXtPv3TbdNZfnyJmn
 o6VkOnLL6Y7plv63DydWMFGU/IzoKHQeqKSYF89yrcl7QtdyyyGu/2LSEiBTniDH4QtT
 J6mHjOZmC6ASG5wjFJPnEZCeecKu5DcvofWX8VSLO2iAACVDqILiskeNK3g9sxUXdgtp
 uS81xrM1vSLwhq/AELHNI0LVv3vpIBmfWdCoDlwhWW//zFvL3IP351SvUsg1EcDyI7BX
 th+A==
X-Gm-Message-State: AOJu0YwlNqJL0k4IpRlSSFhXEiubWdyJZm4OuOBvLNYMiMJmU25YVrSL
 vpTtoVgxEw+kKSpE0qGpx7BacOTRmhP0KIbxIhgGToG4TVtuPAtdOU10P8o0p+cid4Lur3eGpSO
 Z
X-Gm-Gg: ASbGncuTeTF9fV4XYwkAIEh3wTp96RbIIjFm/LGWVz9F/aXqM9jR2GufHQOE+3b1WWq
 /wMXsa3QSbNN8JlW+6j4fE/1tJRW4L+ptHP2pbrkpab/X/iF780o8P6WTeceDoBa15N9/Au2kgX
 NcYYVqQ3jYJqw3QtWsuISnQ8PqhJPNNDgps0ydI87MbbinP2Kw2oHHxmlhIaybPDSkGqVSSZJnj
 E8XI8oqpB/KoLuRoBaz7E+ztKfO7jE8/u4CWzjDu2gCUaQ1fHSgCKTPgUIK6btMEBWc3pntuAJ7
 y0spT22AWaozIJINJtlxo28BqUjHMvtAedi5BMVi+sns3j+mgw9fNHEBrfy3yG8H7OirhPiu6QK
 nUlLf11wgJeM=
X-Google-Smtp-Source: AGHT+IE/AmNP5cRtgFX/GqrwK1VNTpcoQiBFbSYPHcC9wKnLGrrRbwz8zrasA6mGv1xCpcdFRDQFdg==
X-Received: by 2002:a05:6a21:329c:b0:1f5:8eec:e521 with SMTP id
 adf61e73a8af0-1fbeba8d6d0mr294393637.15.1742333540983; 
 Tue, 18 Mar 2025 14:32:20 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 15/42] include/exec: Split out mmap-lock.h
Date: Tue, 18 Mar 2025 14:31:40 -0700
Message-ID: <20250318213209.2579218-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h    |  1 +
 include/exec/mmap-lock.h       | 33 +++++++++++++++++++++++++++++++++
 include/exec/page-protection.h | 22 ----------------------
 accel/tcg/cpu-exec.c           |  1 +
 accel/tcg/tb-maint.c           |  1 +
 accel/tcg/translate-all.c      |  1 +
 linux-user/arm/cpu_loop.c      |  1 +
 linux-user/elfload.c           |  1 +
 linux-user/flatload.c          |  1 +
 linux-user/mmap.c              |  1 +
 linux-user/syscall.c           |  1 +
 target/arm/helper.c            |  1 +
 12 files changed, 43 insertions(+), 22 deletions(-)
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
diff --git a/include/exec/mmap-lock.h b/include/exec/mmap-lock.h
new file mode 100644
index 0000000000..eb02dd409c
--- /dev/null
+++ b/include/exec/mmap-lock.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU user-only mmap lock, with stubs for system mode
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
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
index 8799e4ea27..f54054dce3 100644
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
index b32de763f7..4928f0b080 100644
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


