Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26BBCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDW-0005W8-Ub; Tue, 16 Jun 2026 17:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDV-0005VR-Hw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:05 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDT-0007ON-Lk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:05 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36bcf3d2565so3683450a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644862; x=1782249662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1wZQ/Qn1GzjuZrxpS7V4I3MFKT1CnvQE5JHtvEeR4Q=;
 b=X4280poSUQ2KskU2y5PPMAn5n+OQNBmHb5+VlsKLbvzSjeSpdJ9+b3fIh9KMyoHo4N
 9FxCb1IQOYGXNEP+hDQ7XPRlXptkJ1dLV4PwijTAJPV58++1brDaaAVagcZAVz0j/bum
 1uaaEchyVtyrjq0j1i1xsVZt/4ICRLG68Y5u4ZFbjS4DCZYKrNkKzAdhpC9aptzfZdY7
 XqdYmkR2n9DhnP8Fks//7f/sN9JvbKmOaN90pXjsfM9VY34soIs+f3nIqdgQLI3w5LFB
 BKC+tyWbJ9auB3q3HgrQBcaXDXjZfuHd/Nu27jRFRy5G8BA3RilItK50LrjEKzfvo0D0
 QVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644862; x=1782249662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u1wZQ/Qn1GzjuZrxpS7V4I3MFKT1CnvQE5JHtvEeR4Q=;
 b=l4V8JUt5IMqiaQV/HbrxvSBIxx+yQHqGLN8ZOWURhcIdJ1j1E8ZWLcRE+VreodWMUI
 OnloyPGkW1UNGcdp4gD0eG6rWi5C3rKFX2TZSKh6o/wPFL7NbM2Qwv/OCK516+17pH8M
 gowMrh0dL/FCRtDAs+VnRgU65tnM+eFm1vgk7F/2REurzCykpG9r/w3fVrJRYG/KD7BQ
 uTgf3YPKIgIqf0ZeEJjmQZyOEqzXWhiZpyWoMwPMWPOCnWq6Iiz7tDZdHpjr8vp5SNyS
 9Ekq75hKrYFuUSIdogqSgaRdyttyHCiZ9LP09ZDPrmQwfHBpmd6SGDoXxS1ZLJtbC/ma
 ba9Q==
X-Gm-Message-State: AOJu0YynFtoPY7KQmYkUJC4j+FdeL42RZtJmbLQRuLUtsDiSTS3k4BLZ
 cl6hjmbBYU3l7uvEWoC61iP0PdaYm2/eDxj82/euMLkDBAXffNuFbCXCE2wqqMtmQO9hH6Nb2LN
 6zXPW
X-Gm-Gg: Acq92OH3gCJswYXsotOxX6FqldI3KIjbyxosjm2a3IkOX2gpsYeTqaXiNUIfOrWP+EA
 2Nrj1V5c5FPDG7Q//rewbYGI2Za3N3IGADxFJQ4vv/Oajumj6JHmKdRbBZlg9nI+cXtr8xLfGTi
 OxoF27bf/ki/IzGzCTbG3D9TGgRs30nmWUgNgB27XsWzl/yqLwN464IK0u9rWzTEXXmZj9RaOOh
 hEDyall7V4EHoNpKBP9jdE+6CKYDew8HQuW56+zONET46nYSk8o9XC3GhudFhxAjLDiTqfm15oC
 wiE/xnHBd0VGM1A6GOfw+OpuNTODIV+PFTI6fg6W9h+ofoPmXgAgFkrshPNHAQ2mS5p2nhlXUK2
 M/zx8D3x3HrSZdlCjWejkZ0GCNYCU/mX7z5KUUUyjTht5QjdHhD+dx/RegB5wip0JsIatpGz+Uz
 q2C2GUPy0MWW4nWcLlxRzAov3pVoI4SriEWLrWTSgbajucwkBrwtcJWRGgjzrr
X-Received: by 2002:a17:90b:3f08:b0:367:bf0c:54e9 with SMTP id
 98e67ed59e1d1-37c9370c659mr1077296a91.21.1781644862237; 
 Tue, 16 Jun 2026 14:21:02 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 06/13] common-user: Move mmap_min_addr from linux-user
Date: Tue, 16 Jun 2026 14:20:47 -0700
Message-ID: <20260616212055.334466-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce user/mmap-min-addr.h.  Initialize the variable
from a constructor instead of main.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/mmap-min-addr.h | 12 ++++++++++++
 linux-user/user-internals.h  |  1 -
 common-user/mmap-min-addr.c  | 37 ++++++++++++++++++++++++++++++++++++
 linux-user/elfload.c         |  1 +
 linux-user/main.c            | 33 +++-----------------------------
 linux-user/mmap.c            |  1 +
 common-user/meson.build      |  1 +
 7 files changed, 55 insertions(+), 31 deletions(-)
 create mode 100644 include/user/mmap-min-addr.h
 create mode 100644 common-user/mmap-min-addr.c

diff --git a/include/user/mmap-min-addr.h b/include/user/mmap-min-addr.h
new file mode 100644
index 0000000000..ded0b6909d
--- /dev/null
+++ b/include/user/mmap-min-addr.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef USER_MMAP_MIN_ADDR_H
+#define USER_MMAP_MIN_ADDR_H
+
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+extern uintptr_t mmap_min_addr;
+
+#endif
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index d7f346b0d0..74d8eaabbe 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -29,7 +29,6 @@ void init_task_state(TaskState *ts);
 void task_settid(TaskState *);
 void stop_all_tasks(void);
 extern const char *qemu_uname_release;
-extern unsigned long mmap_min_addr;
 
 typedef struct IOCTLEntry IOCTLEntry;
 
diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c
new file mode 100644
index 0000000000..b2b3762386
--- /dev/null
+++ b/common-user/mmap-min-addr.c
@@ -0,0 +1,37 @@
+/*
+ * Utility function to get the minimum mmap address.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "user/mmap-min-addr.h"
+
+uintptr_t mmap_min_addr;
+
+static void __attribute__((constructor)) init(void)
+{
+#ifdef __linux__
+    /*
+     * We prefer to not make NULL pointers accessible to QEMU.
+     * If something goes wrong below, fall back to 1 page.
+     */
+    size_t min_addr = qemu_real_host_page_size();
+    /*
+     * Read in mmap_min_addr kernel parameter.  This value is used
+     * When loading the ELF image to determine whether guest_base
+     * is needed.  It is also used in mmap_find_vma.
+     */
+    FILE *fp = fopen("/proc/sys/vm/mmap_min_addr", "r");
+
+    if (fp) {
+        unsigned long tmp;
+        if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
+            min_addr = MAX(min_addr, tmp);
+        }
+        fclose(fp);
+    }
+    mmap_min_addr = min_addr;
+#else
+# error
+#endif
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d0605e33d4..f32c52a968 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -14,6 +14,7 @@
 #include "exec/translation-block.h"
 #include "exec/tswap.h"
 #include "user/guest-base.h"
+#include "user/mmap-min-addr.h"
 #include "user-internals.h"
 #include "signal-common.h"
 #include "loader.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index c08c73fd80..01cf5bf079 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -39,6 +39,7 @@
 #include "qemu/module.h"
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
+#include "user/mmap-min-addr.h"
 #include "user/page-protection.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
@@ -78,7 +79,6 @@ static envlist_t *envlist;
 static const char *cpu_model;
 static const char *cpu_type;
 static const char *seed_optarg;
-unsigned long mmap_min_addr;
 uintptr_t guest_base;
 bool have_guest_base;
 
@@ -914,35 +914,8 @@ int main(int argc, char **argv, char **envp)
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
-    /*
-     * Read in mmap_min_addr kernel parameter.  This value is used
-     * When loading the ELF image to determine whether guest_base
-     * is needed.  It is also used in mmap_find_vma.
-     */
-    {
-        FILE *fp;
-
-        if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
-            unsigned long tmp;
-            if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
-                mmap_min_addr = MAX(tmp, host_page_size);
-                qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
-                              mmap_min_addr);
-            }
-            fclose(fp);
-        }
-    }
-
-    /*
-     * We prefer to not make NULL pointers accessible to QEMU.
-     * If we're in a chroot with no /proc, fall back to 1 page.
-     */
-    if (mmap_min_addr == 0) {
-        mmap_min_addr = host_page_size;
-        qemu_log_mask(CPU_LOG_PAGE,
-                      "host mmap_min_addr=0x%lx (fallback)\n",
-                      mmap_min_addr);
-    }
+    qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%" PRIxPTR "\n",
+                  mmap_min_addr);
 
     /*
      * Prepare copy of argv vector for target.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 55277f7c3e..cc0c2ee6c2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -24,6 +24,7 @@
 #include "exec/mmap-lock.h"
 #include "qemu.h"
 #include "user/page-protection.h"
+#include "user/mmap-min-addr.h"
 #include "user-internals.h"
 #include "user-mmap.h"
 #include "target_mman.h"
diff --git a/common-user/meson.build b/common-user/meson.build
index ac9de5b9e3..f9e2e83f9a 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -5,6 +5,7 @@ endif
 common_user_inc += include_directories('host/' / host_arch)
 
 user_ss.add(files(
+  'mmap-min-addr.c',
   'safe-syscall.S',
   'safe-syscall-error.c',
 ))
-- 
2.43.0


