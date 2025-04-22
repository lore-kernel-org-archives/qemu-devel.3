Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6E0C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIg-0002cW-JG; Tue, 22 Apr 2025 15:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIY-0002X7-8d
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:50 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006EB-Px
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3015001f862so4330994a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350122; x=1745954922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ub0hq5/yq5YmhOhnwj/NcA4w3lCN1y7A820aqoMspw=;
 b=F0/ejIix+gqutI+p1ecvyvFsxxMJoqpVAr5rVHV+ee8Dmu3mIczYksFMRnbnU8pLLl
 D0R+25HbQIjJ564wmqQj4L0Yti2PJ8sBF+JTNw7tUl7u7kdXx1bQFyui48dG/GjcRKk3
 imrjdaqCIOZpyLJlcpi+RqHwJrByQgTkad/viYBfxT4FDvMB8IiwsaVUslZeXU/Rsm9u
 X1bXXimptWJ6muTUOOxcRftk6+68aFimwA4jQVBavH+N3khxmGC5MltswbBaF3rSJe2n
 bNPQhl912PordvHJQlkJnum80i5DzExNywaZ7mxOyBxo+cszArX34e9FPYyfnCSdJLxV
 46FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350122; x=1745954922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ub0hq5/yq5YmhOhnwj/NcA4w3lCN1y7A820aqoMspw=;
 b=UjJ4nKFoAGIuxNHipe7CKhUDgQO61F43A5p7XEOk4T6Z0J1H2DTxwIQDiO1XEtrpC6
 Qc6M30K7+XqjRX4jj1z7P8ujI8EAJYHXe54C0j8p9KjjiRT6aVnhte1bUD/5WGZuVXoe
 wQtbwVSn0sgveHKp0NCrKfeeuVpK/5MONbCXGWr42RH/xOTv3y072jYyDDaUkFR3AM83
 kneKEYs+w/Rbqt/GPQlVx1AtLb/MJ1ZvSB2Eb/8ffDnhWDhh0LJXxxRRg5HPxzDAE3Hm
 5yPqDgJbdEZplMAk9M8IPR6KoJJUA/Qtn8mRWQdUl5n92rspe2mdGAqRMWUDPsMGITma
 grvA==
X-Gm-Message-State: AOJu0Yz5tsKS99FX8W098WxfTU2CwsQbulW83cCNKlA3Xec3TSAjV/QV
 7y/C/eOQukXqE+NOgNC4K5rUS3zmCu6+DR1q37iA+POha+tAEl6gvks8P1UyoCxAk6b5l1ukvTy
 T
X-Gm-Gg: ASbGncvuhfY+2vm5NoHvvZwcYa6iT9gM63emyUNeJcOajShyPWqijSeHRGo9UnVIgXl
 x1xt62fuv0swoklf/iCkFvkcH35Mf7XAJ3euxb2b21UuLS6gFYsZNGsVyZUBgQ59/Gl4PHsYDYF
 I8zdqwhfEnZkwT602A/mKO/nUqTSK22Kbe8GAQ9K5j0bXm/TN6nLuscI2gXm/m/xn/AObLt1TNF
 6xs20V0tBOXgl3pxGIa/sFUteka0jieO1HSA3r3ts6BE4sYCQo7+9pTMnIzHAuHYTP+T86eXx2o
 vZcGJj9WWTVFddjtuccTvGtG3l2gjI9pppHdtpyZxLIZg/Q+EKiXkLhSipE28hXXL1hXmNoMihY
 =
X-Google-Smtp-Source: AGHT+IFdl/0oxu06pG5VTBQfbSzz9TdtIe/00/xqLp0bUXlx9XI7fNHIPfzTK5t45Z+wDY9TNfF//Q==
X-Received: by 2002:a17:90b:5410:b0:2fc:a3b7:108e with SMTP id
 98e67ed59e1d1-3087bb3e865mr25026117a91.4.1745350122263; 
 Tue, 22 Apr 2025 12:28:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 033/147] include/exec: Split out mmap-lock.h
Date: Tue, 22 Apr 2025 12:26:22 -0700
Message-ID: <20250422192819.302784-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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


