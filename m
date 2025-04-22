Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883CEC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76FK-0006Iu-SJ; Tue, 22 Apr 2025 01:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Ci-0002Qr-F4; Tue, 22 Apr 2025 01:29:59 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Cf-0007wH-Ug; Tue, 22 Apr 2025 01:29:55 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af590aea813so5318969a12.0; 
 Mon, 21 Apr 2025 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299791; x=1745904591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPwJWv1XdL1SZLXg2WZ4ZVDBFmolVnjhl88zidFmCfI=;
 b=S0q12Uw3sD2gWe6x/fHe2SeNoWGwRVSN8YdlYX51J0MPGYLpa8WwTwlg6Ml4W4M263
 YuNkFl+oa5dJsG8kktTstt3eZmxjywhxq+ktnCu+f5wup2w0RoM3aH/LzO8jIJ9YphM4
 K8unxA8LABdFKUurc6icfInkHQxQJxPidLoHw2NAORj4xyG8JXeEecgGFPjBY3gIIHxd
 sHUUDPF+DZyx5ZBgYS3+PT9qWFInIUQ6ZADYft8eC/kPSnAnl6oZtxRl5iAJc4jnOqse
 X/wO6syHmRMM0chGxYQpVsHIx2nOWXHEDjNXNnEJTYPjLC+AREvNUGF5Xdb58ungjskl
 Ew0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299791; x=1745904591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPwJWv1XdL1SZLXg2WZ4ZVDBFmolVnjhl88zidFmCfI=;
 b=Qg/1VzDWrOsrB+Kkn6u0bcelVAWetQ49baf0nn9mJmzr0TM6+JlAVX1Jj1RVWgsxtH
 Q3BlxLo/snCwXEIoR5MmhV71oqKYq3mNoczAQ9gTD+6VO/9p3zRg6+miaKr19gd6i6Vv
 Tg9tlnl7CXRjyWRDi2E7faLA7j77m5rBZxZa8Az3j5NR7nMdVdnntYZuWZ4vYNkpFErX
 QDV1YEOkeZdD/p8zDrTDeecWp2XWh6VuBaPqTA8gB+1zsuYmHM1WQBNTIrC/lwRihIy3
 weFcnawpV2TmBBZrKL4qMl0nKQkFx2FOjFf4NXh4Zdn19dj6GS8uZ2b5fWA9rc5p+3LS
 I4jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXKNedXZpG4LIcm6oNUZCzq1YgNO9dR+x6BVeCVLMFYc4lwAc2QjsGcZGMVw5BebrVv6kfwWihAFKBEg==@nongnu.org,
 AJvYcCUbPs6t9OShnvjgnlLaD+Eer7bVvjUbdU53kVtxrXjuOitH+yTteXKO1cMTSqQaKhncZ+D7DddP+Q==@nongnu.org,
 AJvYcCV0wDkLNFPE2sDVfUrT6KyG4VEbEcqFFMg0NHQW45hGQDZZhMN0fHW6ADP9yIFZkescAkPmS0M04pRZRA==@nongnu.org,
 AJvYcCVjUsF0JrVDBGGzwVOqrBN9TGondc/d2AsV9vdMqh08ql92KtAvdnZ4gTS+MurnwqBdyqF57G33FXQ=@nongnu.org
X-Gm-Message-State: AOJu0YxYX5s6xtPyaE8/7gn1Yw8MkhO65/vYmUZHQxeOvisW5KrCwVDi
 3JbZI5HIkOp5YRNLNzPh+8gE4XTGKUqBFGwAVcLAsEAaRXJekcbTIKa6rCR/
X-Gm-Gg: ASbGncu89VQv2JzYi1ndnv6yZnrnIHszXyD6AsQXtKodE3r7H9+arhVqjygHC71vx/r
 qib8brGaFXmpvpgClukFDkCed0hR6sIRHnNANwLzHgQlkxMoNU+XpyUGTr0BsS1fuHXDcDAH5d9
 kdVDRkz4oZmJVUd+CBM2dF2YjibQLc7H477nStMD8rQZoD+ZPWtTs637ZnFvLD7f3ECKAF6XpUJ
 YqXarzQQnUCQZFG6RCnfWuJTfCL4y09KV2cpmQI/V6K9YUKsL3leQpihs8o9z37PClkXl/8kKlw
 2XiG2VoHMGbDBbpJQOC2cHrd085MScNI32rr+fSl0j+loQlIl2tsTYhjQRE=
X-Google-Smtp-Source: AGHT+IFWgOdnfzbxh+RFwzENK0J0t5tRSDmDBnU3UXjP+CGN99+rxRf7Y1bXIP0QFV+SCqBDTzPFfg==
X-Received: by 2002:a17:902:d04b:b0:21f:40de:ae4e with SMTP id
 d9443c01a7336-22c53e3b254mr155646575ad.9.1745299790588; 
 Mon, 21 Apr 2025 22:29:50 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:49 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 14/20] include/qemu/osdep.h: Add Emscripten-specific OS
 dependencies
Date: Tue, 22 Apr 2025 14:27:18 +0900
Message-Id: <5bad5a7ee50b6e3e18cf97ac07837988b25ad07f.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On emscripten, some implementations in os-posix.c can't be used such as
daemonizing and changing user. This commit introduces os-wasm.c and
os-wasm.h which are forked from os-posix.c and os-posix.h and patched for
targetting Emscripten.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS              |   6 ++
 include/qemu/osdep.h     |   8 ++-
 include/system/os-wasm.h | 104 ++++++++++++++++++++++++++++++++++
 os-wasm.c                | 119 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 include/system/os-wasm.h
 create mode 100644 os-wasm.c

V2:
- Moved the change that was incorrectly applied to os-posix.h into os-wasm.h
- Split the MAINTAINERS file change that adds os-wasm.c and os-wasm.h from
  the previous 19th patch into this commit.

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..c7a20ac8d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -619,6 +619,12 @@ F: .gitlab-ci.d/cirrus/macos-*
 F: */*.m
 F: scripts/entitlement.sh
 
+WebAssembly
+M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
+S: Maintained
+F: include/system/os-wasm.h
+F: os-wasm.c
+
 Alpha Machines
 --------------
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4397a90680..96fe51bc39 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -8,7 +8,7 @@
  * To avoid getting into possible circular include dependencies, this
  * file should not include any other QEMU headers, with the exceptions
  * of config-host.h, config-target.h, qemu/compiler.h,
- * system/os-posix.h, system/os-win32.h, glib-compat.h and
+ * system/os-posix.h, system/os-win32.h, system/os-wasm.h, glib-compat.h and
  * qemu/typedefs.h, all of which are doing a similar job to this file
  * and are under similar constraints.
  *
@@ -164,10 +164,14 @@ QEMU_EXTERN_C int daemon(int, int);
 #include "system/os-win32.h"
 #endif
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 #include "system/os-posix.h"
 #endif
 
+#if defined(EMSCRIPTEN)
+#include "system/os-wasm.h"
+#endif
+
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/include/system/os-wasm.h b/include/system/os-wasm.h
new file mode 100644
index 0000000000..3abb3aaa03
--- /dev/null
+++ b/include/system/os-wasm.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * posix specific declarations forked from os-posix.h, removing functions not
+ * working on Emscripten
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_OS_WASM_H
+#define QEMU_OS_WASM_H
+
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+#include <sys/un.h>
+
+#ifdef CONFIG_SYSMACROS
+#include <sys/sysmacros.h>
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+void os_set_line_buffering(void);
+void os_setup_early_signal_handling(void);
+void os_set_proc_name(const char *s);
+void os_setup_signal_handling(void);
+void os_setup_limits(void);
+void os_setup_post(void);
+int os_mlock(bool on_fault);
+static inline int os_set_daemonize(bool d)
+{
+    return -1;
+};
+bool is_daemonized(void);
+static inline void os_daemonize(void) {}
+
+/**
+ * qemu_alloc_stack:
+ * @sz: pointer to a size_t holding the requested usable stack size
+ *
+ * Allocate memory that can be used as a stack, for instance for
+ * coroutines. If the memory cannot be allocated, this function
+ * will abort (like g_malloc()). This function also inserts an
+ * additional guard page to catch a potential stack overflow.
+ * Note that the memory required for the guard page and alignment
+ * and minimal stack size restrictions will increase the value of sz.
+ *
+ * The allocated stack must be freed with qemu_free_stack().
+ *
+ * Returns: pointer to (the lowest address of) the stack memory.
+ */
+void *qemu_alloc_stack(size_t *sz);
+
+/**
+ * qemu_free_stack:
+ * @stack: stack to free
+ * @sz: size of stack in bytes
+ *
+ * Free a stack allocated via qemu_alloc_stack(). Note that sz must
+ * be exactly the adjusted stack size returned by qemu_alloc_stack.
+ */
+void qemu_free_stack(void *stack, size_t sz);
+
+/* POSIX and Mingw32 differ in the name of the stdio lock functions.  */
+
+static inline void qemu_flockfile(FILE *f)
+{
+    flockfile(f);
+}
+
+static inline void qemu_funlockfile(FILE *f)
+{
+    funlockfile(f);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/os-wasm.c b/os-wasm.c
new file mode 100644
index 0000000000..d240c180c5
--- /dev/null
+++ b/os-wasm.c
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * os-wasm.c
+ * Forked from os-posix.c, removing functions not working on Emscripten
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2010 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/resource.h>
+#include <sys/wait.h>
+#include <pwd.h>
+#include <grp.h>
+#include <libgen.h>
+
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "system/runstate.h"
+#include "qemu/cutils.h"
+
+void os_setup_post(void){}
+void os_set_line_buffering(void)
+{
+    setvbuf(stdout, NULL, _IOLBF, 0);
+}
+void os_setup_early_signal_handling(void)
+{
+    struct sigaction act;
+    sigfillset(&act.sa_mask);
+    act.sa_flags = 0;
+    act.sa_handler = SIG_IGN;
+    sigaction(SIGPIPE, &act, NULL);
+}
+void os_set_proc_name(const char *s)
+{
+    error_report("Change of process name not supported by your OS");
+    exit(1);
+}
+static void termsig_handler(int signal, siginfo_t *info, void *c)
+{
+    qemu_system_killed(info->si_signo, info->si_pid);
+}
+
+void os_setup_signal_handling(void)
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = termsig_handler;
+    act.sa_flags = SA_SIGINFO;
+    sigaction(SIGINT,  &act, NULL);
+    sigaction(SIGHUP,  &act, NULL);
+    sigaction(SIGTERM, &act, NULL);
+}
+void os_setup_limits(void)
+{
+    struct rlimit nofile;
+
+    if (getrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to query NOFILE limit: %s", strerror(errno));
+        return;
+    }
+
+    if (nofile.rlim_cur == nofile.rlim_max) {
+        return;
+    }
+
+    nofile.rlim_cur = nofile.rlim_max;
+
+    if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to set NOFILE limit: %s", strerror(errno));
+        return;
+    }
+}
+int os_mlock(bool on_fault)
+{
+#ifdef HAVE_MLOCKALL
+    int ret = 0;
+    int flags = MCL_CURRENT | MCL_FUTURE;
+
+    if (on_fault) {
+#ifdef HAVE_MLOCK_ONFAULT
+        flags |= MCL_ONFAULT;
+#else
+        error_report("mlockall: on_fault not supported");
+        return -EINVAL;
+#endif
+    }
+
+    ret = mlockall(flags);
+    if (ret < 0) {
+        error_report("mlockall: %s", strerror(errno));
+    }
+
+    return ret;
+#else
+    (void)on_fault;
+    return -ENOSYS;
+#endif
+}
-- 
2.25.1


