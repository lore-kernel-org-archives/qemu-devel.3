Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49462CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzV-0005eR-3k; Sat, 30 May 2026 17:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzL-0005cn-Ft
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzJ-0000d2-EJ
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bf22d29dabso13273545ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175576; x=1780780376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/h6IUrlognRVrhf7VP7UXXkxNTUlEyz8hZZ9YneTZI=;
 b=mmGus7Qwa2xRUytoLml8K+INQCQBJl7shTvYAmG5eY+jB5ZSO+GUsach5xSDGFTuAC
 1Lm4AtftKQBMrkV0TntOUoSfBfmn1YhCynYsVCmqClPoIMZyH9XGHeYqtwh9TNL55oa+
 ODauGfqYCaFVdLTQRRuXXtUw/bCEJgPtfAswtNXvOS0AsVp2vkzxeLE7mx/nBD4er6Qi
 /BJtdbQuY+5yTRkpmoo3t0hZZ5qM14EHjnfOSgbJph/Op/l6+D2ATj1p5zjdZL8jvQ1a
 VUEV3p+czTr6dfgRDxtlakO8MBzCrDOfHUThWM3tsnI0EOuySFN11vVyWz34K6qMacAD
 FBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175576; x=1780780376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J/h6IUrlognRVrhf7VP7UXXkxNTUlEyz8hZZ9YneTZI=;
 b=d/80JeEM/ljwj6LcQol2aHYoiq+8BRy4GGC7dmP1sXQyMqYzqTnsWBIMF2b2+k6S0S
 Dw0hISSqiSMQ4X090HSgKzZJPRRp49Zg93T8VdUi4Y87SMyAW8Gw3j6zP8SGhrahcWka
 gUl8VwWXUbMvNp7f6m6e12wzu0nLiDKD1tCDUVqJKs4IhJeMP5b5J+f+FlBEYANSwMr1
 uUULkjj0DyREdxnMyVwsup+KE70Kdi68UINIglQNuZQOJ4+H+cKIyFHxPlMq/H/2trgg
 SQM90o9Q0X8UkgFDWNgiPx7C4z1GkVzhLX00PjfB179MeKXIiD+41RFGGY13+z1Al3oa
 1xoA==
X-Gm-Message-State: AOJu0YyadiofTFjto6sh7RQqsLihj09UnkXeVf5zfA5khEUAkLeoY7XT
 WV6f6Pn9E8W0IYwQquCLmT2tA6k6awNK2iiWEzugsS1HU/N/izAc2lHATJjSKJNLlcoRfHV/b5t
 0gUvISMA=
X-Gm-Gg: Acq92OHlmtC4QUUR7CFFLfhvP9ZK7h+l8/ZQeAyO0NALy03nuZZwQjn5rGeAtFFN0zn
 mUaaIYVcz2KXyOg977l8x8VpoOZW89UnbLh8ku1FBpZhqLiFl4nhgHEBKpWh+FfeHVJJ7thRSBc
 IRw4+zo/X5A14tHyf2tRglm4Mx+2q365oS6aio75rFKXWI1k3Ntlrd6LMd9+6S2/QIkJyt9Le/K
 IE+LqmKcSjcXMnr2VPGh7OgyDRCsSEcWlTGMCGY2BSEbvsi0IEvbP5ZS9if8ne0FEYH3YeSuk6d
 HaWScAPUaiNhLB+mvJ52hLtUdyXSrM2RNlVP0AJi0r7qCvk+ovXECqBKyLXIn7JSzLq4/qUEE9g
 GICOFfICed+FvGSqQOktOgU/whrHalT4dYFcY/R4FrqZoopVy5N5D+UxA7XTdFQhNkX8nrhRS3p
 vDa6Jc+ZZ7jldG+XKokCW11N+ze88lfwmtjb+8ihw=
X-Received: by 2002:a17:903:2bce:b0:2bf:128d:f7ff with SMTP id
 d9443c01a7336-2bf367d2311mr57768705ad.16.1780175575740; 
 Sat, 30 May 2026 14:12:55 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 06/13] common-user: Move mmap_min_addr from linux-user
Date: Sat, 30 May 2026 14:12:40 -0700
Message-ID: <20260530211248.375318-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
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
index 3f41d3f33c..bc6b9f44e6 100644
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
index 5a30cebcc3..93ab2661e3 100644
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
index b4b7b3e5cc..f81417182e 100644
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


