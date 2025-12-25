Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999D9E784A6
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 06:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYeqr-00041F-OG; Thu, 25 Dec 2025 01:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vYeqq-00040x-DT
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:29:32 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1vYeqo-0001rn-Ej
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:29:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2725E178B38;
 Thu, 25 Dec 2025 09:28:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CFDA0340637;
 Thu, 25 Dec 2025 09:29:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 1/2] Revert "gdbstub: Try unlinking the unix socket before
 binding"
Date: Thu, 25 Dec 2025 09:29:18 +0300
Message-ID: <20251225062919.685146-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225062919.685146-1-mjt@tls.msk.ru>
References: <20251225062919.685146-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit fccb744f41c69fec6fd92225fe907c6e69de5d44.

This commit introduced dependency of linux-user on qemu-sockets.c.
The latter includes handling of various socket types, while gdbstub
only needs unix sockets.  Including different kinds of sockets
makes it more problematic to build linux-user statically.

The original issue - the need to unlink unix socket before binding -
will be addressed in the next change.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 gdbstub/user.c    | 29 ++++++++++++++++++++++++++---
 stubs/meson.build |  2 --
 util/meson.build  |  2 --
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index e233c59816..5e920a9b51 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -314,10 +314,12 @@ static bool gdb_accept_socket(int gdb_fd)
     return true;
 }
 
-static int gdbserver_open_socket(const char *path, Error **errp)
+static int gdbserver_open_socket(const char *path)
 {
     g_autoptr(GString) buf = g_string_new("");
+    struct sockaddr_un sockaddr = {};
     const char *pid_placeholder;
+    int fd, ret;
 
     pid_placeholder = strstr(path, "%d");
     if (pid_placeholder != NULL) {
@@ -327,7 +329,28 @@ static int gdbserver_open_socket(const char *path, Error **errp)
         path = buf->str;
     }
 
-    return unix_listen(path, errp);
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("create socket");
+        return -1;
+    }
+
+    sockaddr.sun_family = AF_UNIX;
+    pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun_path) - 1, path);
+    ret = bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
+    if (ret < 0) {
+        perror("bind socket");
+        close(fd);
+        return -1;
+    }
+    ret = listen(fd, 1);
+    if (ret < 0) {
+        perror("listen socket");
+        close(fd);
+        return -1;
+    }
+
+    return fd;
 }
 
 static bool gdb_accept_tcp(int gdb_fd)
@@ -483,7 +506,7 @@ bool gdbserver_start(const char *args, Error **errp)
     if (port > 0) {
         gdb_fd = gdbserver_open_port(port, errp);
     } else {
-        gdb_fd = gdbserver_open_socket(port_or_path, errp);
+        gdb_fd = gdbserver_open_socket(port_or_path);
     }
     if (gdb_fd < 0) {
         return false;
diff --git a/stubs/meson.build b/stubs/meson.build
index 0b2778c568..b6b1a3844e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -59,8 +59,6 @@ if have_user
   if not have_system
     stub_ss.add(files('qdev.c'))
   endif
-
-  stub_ss.add(files('monitor-internal.c'))
 endif
 
 if have_system
diff --git a/util/meson.build b/util/meson.build
index 35029380a3..a925c09169 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -87,8 +87,6 @@ if have_block or have_ga
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
   util_ss.add(files(f'coroutine-@coroutine_backend@.c'))
   util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
-endif
-if have_block or have_ga or have_user
   util_ss.add(files('qemu-sockets.c'))
 endif
 if have_block
-- 
2.47.3


