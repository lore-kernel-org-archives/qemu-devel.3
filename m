Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88E9C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xzw-000636-DF; Wed, 16 Apr 2025 04:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwu-00025k-W6; Wed, 16 Apr 2025 04:16:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xws-0005v0-J1; Wed, 16 Apr 2025 04:16:48 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so5499966b3a.0; 
 Wed, 16 Apr 2025 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791404; x=1745396204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccz4kSlOllk0cHThqsViRN91zI+kCPXhAybNKVHZI0w=;
 b=AfgbLcJQXBmGT0/CqE5COVr+lhjQskB/Vw08wG+Myv5ksWu5TEEDz8ey2ZOJvvsgYb
 JnYixP5JdvbmWXevjAtEQchtxl7C+JKoULvWLLKhT51UxhPML1bJpfKVF3pptggZgKGN
 bf9FYmER7KKUS84LPu0J4f3psT+OGVe6vb73E4dMHnVstwSOsuNjDKZu+1vARwYtBoN3
 ZW+q7+iP+/WTcakAte9IRn4pR4ssa3CBCn861XIxEwt/cqKC7Fgs+cKFrB30BMx0bBu5
 5+wpBFtnS4rzV1GkdLmvOMJoctmc+gNc4FbXEalVLcxvitn1KorfANyckaoWEXR0MrDU
 Gn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791404; x=1745396204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ccz4kSlOllk0cHThqsViRN91zI+kCPXhAybNKVHZI0w=;
 b=Clf8H5lrjVBQ4cm4bcoQRo++2MVAIGQYiI8PUTWh232dxLJJYphWBhWoYz5keb/jvC
 sfagj4rpqWmRmw36otp0uW9A3IdbvHNKPpQ6MmhK+UvUDlHrfPRWayZuXswSvdRTWc7K
 oBzIo9qP8pd1nnn/JTziz4Wr/iYfN1ajNQpPOCzMPearkrj30DBLpmbUyXKMn2TS/6my
 6i0zT57hKhqBQphUKFKVThWT+SbqbNd2EwI0ejXmvxlWQp56iieXW+/POqrqhPeTiOOl
 wDKVQX4Yyde/UNpKrTk9vErMaSMvBqArLtZXQczuhSQ786o0Ax1bnUlKbEulPiwdYSyr
 keNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURiaNlxT0laODNkPpTQsQBSV2NrsiVpyH84GlmybWBmOyaa5Dk3ABSepzbs5Vi5C8nSFMRI3k2ZxHvlg==@nongnu.org,
 AJvYcCUpn0k1d1cZMZPfTD8oHBKv+x+IsxNrPHF0J7XvTqXI+5qmSAadSrkOO736ENNillc8boTHMNU9LdXM7Q==@nongnu.org,
 AJvYcCWhSGJ7z1r1ZL0V6yLPMfGmYDu4CYMCu8nz/ioAW4XEcpeX5Q/iJgIdcn8A6BKCWT6uw8ZZgU5UqWU=@nongnu.org,
 AJvYcCXug7fqCpIXghWFy1zsngr/lVCMs39+S9H2y8qQA6/y4ExYvCnWD9WwrsoRudikhKjKbJxR9x4moA==@nongnu.org
X-Gm-Message-State: AOJu0YyoqWSp8eDAgiWKa48hgqBuk7lAN5DK+0RagzydC/8//8T8D4sC
 zVXCTBSrBH+WMZQuHzk2Z3OJEtk1AevjKFLGUXAV+sigO8AbKCsJrU+n+cqb
X-Gm-Gg: ASbGnctguwD0o33hd9YmcB5BbAwGdW6q17SzBFzBKlPA02LEbnhvpJ7yIKHyVQMQfSE
 Ig6Y6++PWYqsoJMtG3KcSvzbJaeIjtId7bOIh218ApFTYLvuWb/HExcaUMb76IoIgFKgCeptBa4
 7ge+YB9fv7QIifUOAtVChiU5acS/wnU1T2Vay+LNY4fFilghQoePIZlCoURyjZ5PEXzw5aWP3Hr
 YWbOY1G9WLXHn0KIJvsxb1SErzc/TkX5lcaZjYKaVrJ7b/8xJw2OYEEvMQjkGFONZzlsPatlmOA
 Y8uLIAOh/WxNl1Pk87RPPKKUvsLFnIrjJE8TRoPAlulQWIKcFUAyyU5XSA==
X-Google-Smtp-Source: AGHT+IH7FmqWppk3JQIuvW4w32pZOoVj/pSA/IO3rWgKznIiLqDu3RFZw5/AmwOBaT1ZsrARHCFbIg==
X-Received: by 2002:a05:6a00:3d09:b0:739:b288:13e7 with SMTP id
 d2e1a72fcca58-73c267d3801mr1274214b3a.15.1744791403571; 
 Wed, 16 Apr 2025 01:16:43 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:42 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 13/19] include/qemu/osdep.h: Add Emscripten-specific OS
 dependencies
Date: Wed, 16 Apr 2025 17:14:18 +0900
Message-Id: <58863961cf88a72b76a90279da09ea332943924d.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42b.google.com
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
 include/qemu/osdep.h      |   8 ++-
 include/system/os-posix.h |   3 +-
 include/system/os-wasm.h  | 105 +++++++++++++++++++++++++++++++++
 os-wasm.c                 | 119 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 232 insertions(+), 3 deletions(-)
 create mode 100644 include/system/os-wasm.h
 create mode 100644 os-wasm.c

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
diff --git a/include/system/os-posix.h b/include/system/os-posix.h
index ce5b3bccf8..e87cc36a3a 100644
--- a/include/system/os-posix.h
+++ b/include/system/os-posix.h
@@ -1,5 +1,6 @@
 /*
- * posix specific declarations
+ * posix specific declarations forked from os-posix.c, removing functions not
+ * working on Emscripten
  *
  * Copyright (c) 2003-2008 Fabrice Bellard
  * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>
diff --git a/include/system/os-wasm.h b/include/system/os-wasm.h
new file mode 100644
index 0000000000..061c123c6f
--- /dev/null
+++ b/include/system/os-wasm.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * posix specific declarations
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>
+ *
+ * Forked from os-posix.h, removing functions not working on Emscripten
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


