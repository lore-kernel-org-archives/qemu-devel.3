Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65894C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 22:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT8EK-0007WD-HL; Thu, 25 Jan 2024 17:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rT8EI-0007Vq-JO; Thu, 25 Jan 2024 17:29:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rT8EG-0001x0-NT; Thu, 25 Jan 2024 17:29:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D8EE47563;
 Fri, 26 Jan 2024 01:30:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B5E586BA53;
 Fri, 26 Jan 2024 01:29:42 +0300 (MSK)
Received: (nullmailer pid 147069 invoked by uid 1000);
 Thu, 25 Jan 2024 22:29:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial 1/2] close_all_open_fd(): move to oslib-posix.c
Date: Fri, 26 Jan 2024 01:29:35 +0300
Message-Id: <94fcee0d7595865b3a6fab744982ad47715e5faf.1706221377.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706221377.git.mjt@tls.msk.ru>
References: <cover.1706221377.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Initially in async-teardown.c, but the same construct is used
elsewhere too.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/sysemu/os-posix.h |  1 +
 system/async-teardown.c   | 37 +------------------------------------
 util/oslib-posix.c        | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index dff32ae185..4c91d03f44 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -53,6 +53,7 @@ bool os_set_runas(const char *user_id);
 void os_set_chroot(const char *path);
 void os_setup_post(void);
 int os_mlock(void);
+void os_close_all_open_fd(int minfd);
 
 /**
  * qemu_alloc_stack:
diff --git a/system/async-teardown.c b/system/async-teardown.c
index 396963c091..41d3d94935 100644
--- a/system/async-teardown.c
+++ b/system/async-teardown.c
@@ -26,40 +26,6 @@
 
 static pid_t the_ppid;
 
-/*
- * Close all open file descriptors.
- */
-static void close_all_open_fd(void)
-{
-    struct dirent *de;
-    int fd, dfd;
-    DIR *dir;
-
-#ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return;
-    }
-#endif
-
-    dir = opendir("/proc/self/fd");
-    if (!dir) {
-        /* If /proc is not mounted, there is nothing that can be done. */
-        return;
-    }
-    /* Avoid closing the directory. */
-    dfd = dirfd(dir);
-
-    for (de = readdir(dir); de; de = readdir(dir)) {
-        fd = atoi(de->d_name);
-        if (fd != dfd) {
-            close(fd);
-        }
-    }
-    closedir(dir);
-}
-
 static void hup_handler(int signal)
 {
     /* Check every second if this process has been reparented. */
@@ -85,9 +51,8 @@ static int async_teardown_fn(void *arg)
     /*
      * Close all file descriptors that might have been inherited from the
      * main qemu process when doing clone, needed to make libvirt happy.
-     * Not using close_range for increased compatibility with older kernels.
      */
-    close_all_open_fd();
+    os_close_all_open_fd(0);
 
     /* Set up a handler for SIGHUP and unblock SIGHUP. */
     sigaction(SIGHUP, &sa, NULL);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7c297003b9..09d0ce4da6 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -27,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <dirent.h>
 #include <termios.h>
 
 #include <glib/gprintf.h>
@@ -106,6 +107,41 @@ int qemu_get_thread_id(void)
 #endif
 }
 
+/*
+ * Close all open file descriptors starting with minfd and up.
+ * Not using close_range for increased compatibility with older kernels.
+ */
+void os_close_all_open_fd(int minfd)
+{
+    struct dirent *de;
+    int fd, dfd;
+    DIR *dir;
+
+#ifdef CONFIG_CLOSE_RANGE
+    int r = close_range(minfd, ~0U, 0);
+    if (!r) {
+        /* Success, no need to try other ways. */
+        return;
+    }
+#endif
+
+    dir = opendir("/proc/self/fd");
+    if (!dir) {
+        /* If /proc is not mounted, there is nothing that can be done. */
+        return;
+    }
+    /* Avoid closing the directory. */
+    dfd = dirfd(dir);
+
+    for (de = readdir(dir); de; de = readdir(dir)) {
+        fd = atoi(de->d_name);
+        if (fd >= minfd && fd != dfd) {
+            close(fd);
+        }
+    }
+    closedir(dir);
+}
+
 int qemu_daemon(int nochdir, int noclose)
 {
     return daemon(nochdir, noclose);
-- 
2.39.2


