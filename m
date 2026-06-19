Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E96BCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 18:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wadYE-0000eS-DG; Fri, 19 Jun 2026 14:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadY9-0000dv-QK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:41 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadY6-0004F8-IQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=YqONhlrHRfFvrkeKcF4zVsbsxWXUSytVngRxBICCDsc=; b=pPwBcFU04NO0
 02srbnqIcop3bUDBEDJN9HjnMVTcRrZemMFLfQYKGM/glfiPRCXcWWY1EENArcbgU3ENUDbmVkUJv
 JhnV18Q90moVQd7j56ncy/ZRPC4ibboiy8dEGmkpKv+iDmQsAUrJjpheW71efloJv4y+xReYEp8aT
 YIP4DtBxCchfWHoOxJfYHk6oGQcBOhiftmXO0eou1d/CjZenQj51WRJEwUxjIwTIFmdGeNzJxGuCW
 ZEkG7euvqi5/Ah8P9D2w4dyerAWxOKKt2EX8PgFKTLjiEKqsI98DMayU93NgCDWv3+ulQGJrSxb67
 CwlTZMa5jkwfNccbia4dCw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=mami)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <polina.vishneva@virtuozzo.com>) id 1wadXV-001Gyc-1d;
 Fri, 19 Jun 2026 20:02:33 +0200
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: Polina Vishneva <polina.vishneva@virtuozzo.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Denis V . Lunev" <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 3/4] qga: Move common channel routines to channel-common
Date: Fri, 19 Jun 2026 20:00:21 +0200
Message-ID: <20260619180121.2982356-4-polina.vishneva@virtuozzo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=polina.vishneva@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Required to use them later in the Windows vsock path.

ga_channel_common_client_add() now takes ownership of client_ch on
success only; on failure the caller keeps it and disposes of it via the
new ga_channel_common_gio_destroy() helper.
The Windows vsock path needs this: it has to release the CRT fd wrapper
with qemu_close_socket_osfhandle() before channel teardown closes the
SOCKET, so the caller must still own the channel on the error path.

Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
---
 qga/channel-common.c | 115 +++++++++++++++++++++++++++
 qga/channel-common.h |  44 +++++++++++
 qga/channel-posix.c  | 179 +++++++++++++------------------------------
 qga/channel-win32.c  |  14 ++--
 qga/meson.build      |   3 +-
 5 files changed, 223 insertions(+), 132 deletions(-)
 create mode 100644 qga/channel-common.c
 create mode 100644 qga/channel-common.h

diff --git a/qga/channel-common.c b/qga/channel-common.c
new file mode 100644
index 0000000000..9732a19477
--- /dev/null
+++ b/qga/channel-common.c
@@ -0,0 +1,115 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU Guest Agent common GIOChannel lifecycle
+ *
+ * Copyright (c) 2026 Virtuozzo International GmbH.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/sockets.h"
+#include "channel-common.h"
+
+void ga_channel_common_gio_destroy(GIOChannel *ch)
+{
+    g_io_channel_shutdown(ch, true, NULL);
+    g_io_channel_unref(ch);
+}
+
+/* The vsock analogue of unix_listen(): returns a listening fd or -1. */
+int ga_channel_common_vsock_listen(const char *path, Error **errp)
+{
+    SocketAddress *addr;
+    char *addr_str;
+    int fd;
+
+    addr_str = g_strdup_printf("vsock:%s", path);
+    addr = socket_parse(addr_str, errp);
+    g_free(addr_str);
+    if (!addr) {
+        return -1;
+    }
+
+    fd = socket_listen(addr, 1, errp);
+    qapi_free_SocketAddress(addr);
+    return fd;
+}
+
+void ga_channel_common_listen_close(GAChannelCommon *c)
+{
+    g_assert(c->listen_channel);
+    ga_channel_common_gio_destroy(c->listen_channel);
+    c->listen_channel = NULL;
+}
+
+int ga_channel_common_client_add(GAChannelCommon *c, GIOChannel *client_ch,
+                                 GIOFunc event_fn, gpointer data)
+{
+    GError *err = NULL;
+
+    g_assert(c && !c->client_channel);
+    g_io_channel_set_encoding(client_ch, NULL, &err);
+    if (err != NULL) {
+        g_warning("error setting channel encoding to binary");
+        g_error_free(err);
+        return -1;
+    }
+    g_io_add_watch(client_ch, G_IO_IN | G_IO_HUP, event_fn, data);
+    c->client_channel = client_ch;
+    return 0;
+}
+
+void ga_channel_common_client_close(GAChannelCommon *c)
+{
+    g_assert(c->client_channel);
+    ga_channel_common_gio_destroy(c->client_channel);
+    c->client_channel = NULL;
+}
+
+GIOStatus ga_channel_common_read(GAChannelCommon *c, gchar *buf,
+                                 gsize size, gsize *count)
+{
+    return g_io_channel_read_chars(c->client_channel, buf, size, count, NULL);
+}
+
+GIOStatus ga_channel_common_write_all(GAChannelCommon *c,
+                                      const gchar *buf, gsize size)
+{
+    GError *err = NULL;
+    gsize written = 0;
+    GIOStatus status = G_IO_STATUS_NORMAL;
+
+    while (size) {
+        g_debug("sending data, count: %d", (int)size);
+        status = g_io_channel_write_chars(c->client_channel, buf, size,
+                                          &written, &err);
+        if (status == G_IO_STATUS_NORMAL) {
+            size -= written;
+            buf += written;
+        } else if (status != G_IO_STATUS_AGAIN) {
+            g_warning("error writing to channel: %s", err->message);
+            return status;
+        }
+    }
+
+    do {
+        status = g_io_channel_flush(c->client_channel, &err);
+    } while (status == G_IO_STATUS_AGAIN);
+
+    if (status != G_IO_STATUS_NORMAL) {
+        g_warning("error flushing channel: %s", err->message);
+    }
+
+    return status;
+}
+
+void ga_channel_common_free(GAChannelCommon *c)
+{
+    if (c->listen_channel) {
+        ga_channel_common_listen_close(c);
+    }
+    if (c->client_channel) {
+        ga_channel_common_client_close(c);
+    }
+}
diff --git a/qga/channel-common.h b/qga/channel-common.h
new file mode 100644
index 0000000000..8e82bf0909
--- /dev/null
+++ b/qga/channel-common.h
@@ -0,0 +1,44 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU Guest Agent common GIOChannel lifecycle
+ *
+ * Copyright (c) 2026 Virtuozzo International GmbH.
+ */
+#ifndef QGA_CHANNEL_COMMON_H
+#define QGA_CHANNEL_COMMON_H
+
+#include "channel.h"
+
+typedef struct GAChannelCommon {
+    GIOChannel *listen_channel;
+    GIOChannel *client_channel;
+    GAChannelMethod method;
+    GAChannelCallback event_cb;
+    gpointer user_data;
+} GAChannelCommon;
+
+/* Common GIOChannel lifecycle (channel-common.c) */
+void ga_channel_common_listen_close(GAChannelCommon *c);
+
+/* Start listening on a vsock "cid:port" path; returns an fd or -1. */
+int ga_channel_common_vsock_listen(const char *path, Error **errp);
+
+/* Shut down and unref a GIOChannel not tracked by a GAChannelCommon. */
+void ga_channel_common_gio_destroy(GIOChannel *ch);
+
+/*
+ * Takes ownership of client_ch on success only; on failure the caller keeps
+ * it and must dispose of it via ga_channel_common_gio_destroy().
+ */
+int ga_channel_common_client_add(GAChannelCommon *c,
+                                 GIOChannel *client_ch,
+                                 GIOFunc event_fn, gpointer data);
+void ga_channel_common_client_close(GAChannelCommon *c);
+GIOStatus ga_channel_common_read(GAChannelCommon *c, gchar *buf,
+                                 gsize size, gsize *count);
+GIOStatus ga_channel_common_write_all(GAChannelCommon *c,
+                                      const gchar *buf, gsize size);
+void ga_channel_common_free(GAChannelCommon *c);
+
+#endif /* QGA_CHANNEL_COMMON_H */
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 9ccc8b7bd1..9d346e82b2 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -3,7 +3,7 @@
 #include <termios.h>
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "channel.h"
+#include "channel-common.h"
 #include "cutils.h"
 
 #ifdef CONFIG_SOLARIS
@@ -13,20 +13,36 @@
 #define GA_CHANNEL_BAUDRATE_DEFAULT B38400 /* for isa-serial channels */
 
 struct GAChannel {
-    GIOChannel *listen_channel;
-    GIOChannel *client_channel;
-    GAChannelMethod method;
-    GAChannelCallback event_cb;
-    gpointer user_data;
+    GAChannelCommon common;
 };
 
-static int ga_channel_client_add(GAChannel *c, int fd);
+static gboolean ga_channel_client_event(GIOChannel *channel,
+                                        GIOCondition condition, gpointer data);
+static gboolean ga_channel_listen_accept(GIOChannel *channel,
+                                         GIOCondition condition, gpointer data);
+
+static GIOChannel *ga_channel_make_gio(int fd)
+{
+    GIOChannel *ch = g_io_channel_unix_new(fd);
+    g_assert(ch);
+    return ch;
+}
+
+static void ga_channel_listen_add(GAChannel *c, int listen_fd, bool create)
+{
+    if (create) {
+        c->common.listen_channel = ga_channel_make_gio(listen_fd);
+    }
+    g_io_add_watch(c->common.listen_channel, G_IO_IN,
+                   ga_channel_listen_accept, c);
+}
 
 static gboolean ga_channel_listen_accept(GIOChannel *channel,
                                          GIOCondition condition, gpointer data)
 {
     GAChannel *c = data;
-    int ret, client_fd;
+    int client_fd;
+    GIOChannel *client_ch;
     bool accepted = false;
     Error *err = NULL;
 
@@ -42,10 +58,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
         error_free(err);
         goto out;
     }
-    ret = ga_channel_client_add(c, client_fd);
-    if (ret) {
+    client_ch = ga_channel_make_gio(client_fd);
+    if (ga_channel_common_client_add(&c->common, client_ch,
+                                     ga_channel_client_event, c)) {
         g_warning("error setting up connection");
-        close(client_fd);
+        ga_channel_common_gio_destroy(client_ch);
         goto out;
     }
     accepted = true;
@@ -55,39 +72,6 @@ out:
     return !accepted;
 }
 
-/* start polling for readable events on listen fd, new==true
- * indicates we should use the existing s->listen_channel
- */
-static void ga_channel_listen_add(GAChannel *c, int listen_fd, bool create)
-{
-    if (create) {
-        c->listen_channel = g_io_channel_unix_new(listen_fd);
-    }
-    g_io_add_watch(c->listen_channel, G_IO_IN, ga_channel_listen_accept, c);
-}
-
-static void ga_channel_listen_close(GAChannel *c)
-{
-    g_assert(c->listen_channel);
-    g_io_channel_shutdown(c->listen_channel, true, NULL);
-    g_io_channel_unref(c->listen_channel);
-    c->listen_channel = NULL;
-}
-
-/* cleanup state for closed connection/session, start accepting new
- * connections if we're in listening mode
- */
-static void ga_channel_client_close(GAChannel *c)
-{
-    g_assert(c->client_channel);
-    g_io_channel_shutdown(c->client_channel, true, NULL);
-    g_io_channel_unref(c->client_channel);
-    c->client_channel = NULL;
-    if (c->listen_channel) {
-        ga_channel_listen_add(c, 0, false);
-    }
-}
-
 static gboolean ga_channel_client_event(GIOChannel *channel,
                                         GIOCondition condition, gpointer data)
 {
@@ -95,44 +79,28 @@ static gboolean ga_channel_client_event(GIOChannel *channel,
     gboolean client_cont;
 
     g_assert(c);
-    if (c->event_cb) {
-        client_cont = c->event_cb(condition, c->user_data);
+    if (c->common.event_cb) {
+        client_cont = c->common.event_cb(condition, c->common.user_data);
         if (!client_cont) {
-            ga_channel_client_close(c);
+            ga_channel_common_client_close(&c->common);
+            if (c->common.listen_channel) {
+                ga_channel_listen_add(c, 0, false);
+            }
             return false;
         }
     }
     return true;
 }
 
-static int ga_channel_client_add(GAChannel *c, int fd)
-{
-    GIOChannel *client_channel;
-    GError *err = NULL;
-
-    g_assert(c && !c->client_channel);
-    client_channel = g_io_channel_unix_new(fd);
-    g_assert(client_channel);
-    g_io_channel_set_encoding(client_channel, NULL, &err);
-    if (err != NULL) {
-        g_warning("error setting channel encoding to binary");
-        g_error_free(err);
-        return -1;
-    }
-    g_io_add_watch(client_channel, G_IO_IN | G_IO_HUP,
-                   ga_channel_client_event, c);
-    c->client_channel = client_channel;
-    return 0;
-}
-
 static gboolean ga_channel_open(GAChannel *c, const gchar *path,
                                 GAChannelMethod method, int fd, Error **errp)
 {
-    int ret;
-    c->method = method;
+    c->common.method = method;
 
-    switch (c->method) {
+    switch (method) {
     case GA_CHANNEL_VIRTIO_SERIAL: {
+        GIOChannel *ch;
+
         assert(fd < 0);
         fd = qga_open_cloexec(
             path,
@@ -147,8 +115,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
             return false;
         }
 #ifdef CONFIG_SOLARIS
-        ret = ioctl(fd, I_SETSIG, S_OUTPUT | S_INPUT | S_HIPRI);
-        if (ret == -1) {
+        if (ioctl(fd, I_SETSIG, S_OUTPUT | S_INPUT | S_HIPRI) == -1) {
             error_setg_errno(errp, errno, "error setting event mask for channel");
             close(fd);
             return false;
@@ -173,16 +140,18 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
             return false;
         }
 #endif /* __FreeBSD__ */
-        ret = ga_channel_client_add(c, fd);
-        if (ret) {
+        ch = ga_channel_make_gio(fd);
+        if (ga_channel_common_client_add(&c->common, ch,
+                                         ga_channel_client_event, c)) {
             error_setg(errp, "error adding channel to main loop");
-            close(fd);
+            ga_channel_common_gio_destroy(ch);
             return false;
         }
         break;
     }
     case GA_CHANNEL_ISA_SERIAL: {
         struct termios tio;
+        GIOChannel *ch;
 
         assert(fd < 0);
         fd = qga_open_cloexec(path, O_RDWR | O_NOCTTY | O_NONBLOCK, 0);
@@ -206,10 +175,11 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
         /* flush everything waiting for read/xmit, it's garbage at this point */
         tcflush(fd, TCIFLUSH);
         tcsetattr(fd, TCSANOW, &tio);
-        ret = ga_channel_client_add(c, fd);
-        if (ret) {
+        ch = ga_channel_make_gio(fd);
+        if (ga_channel_common_client_add(&c->common, ch,
+                                         ga_channel_client_event, c)) {
             error_setg(errp, "error adding channel to main loop");
-            close(fd);
+            ga_channel_common_gio_destroy(ch);
             return false;
         }
         break;
@@ -226,18 +196,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
     }
     case GA_CHANNEL_VSOCK_LISTEN: {
         if (fd < 0) {
-            SocketAddress *addr;
-            char *addr_str;
-
-            addr_str = g_strdup_printf("vsock:%s", path);
-            addr = socket_parse(addr_str, errp);
-            g_free(addr_str);
-            if (!addr) {
-                return false;
-            }
-
-            fd = socket_listen(addr, 1, errp);
-            qapi_free_SocketAddress(addr);
+            fd = ga_channel_common_vsock_listen(path, errp);
             if (fd < 0) {
                 return false;
             }
@@ -255,37 +214,12 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
 
 GIOStatus ga_channel_write_all(GAChannel *c, const gchar *buf, gsize size)
 {
-    GError *err = NULL;
-    gsize written = 0;
-    GIOStatus status = G_IO_STATUS_NORMAL;
-
-    while (size) {
-        g_debug("sending data, count: %d", (int)size);
-        status = g_io_channel_write_chars(c->client_channel, buf, size,
-                                          &written, &err);
-        if (status == G_IO_STATUS_NORMAL) {
-            size -= written;
-            buf += written;
-        } else if (status != G_IO_STATUS_AGAIN) {
-            g_warning("error writing to channel: %s", err->message);
-            return status;
-        }
-    }
-
-    do {
-        status = g_io_channel_flush(c->client_channel, &err);
-    } while (status == G_IO_STATUS_AGAIN);
-
-    if (status != G_IO_STATUS_NORMAL) {
-        g_warning("error flushing channel: %s", err->message);
-    }
-
-    return status;
+    return ga_channel_common_write_all(&c->common, buf, size);
 }
 
 GIOStatus ga_channel_read(GAChannel *c, gchar *buf, gsize size, gsize *count)
 {
-    return g_io_channel_read_chars(c->client_channel, buf, size, count, NULL);
+    return ga_channel_common_read(&c->common, buf, size, count);
 }
 
 GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
@@ -293,8 +227,8 @@ GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
 {
     Error *err = NULL;
     GAChannel *c = g_new0(GAChannel, 1);
-    c->event_cb = cb;
-    c->user_data = opaque;
+    c->common.event_cb = cb;
+    c->common.user_data = opaque;
 
     if (!ga_channel_open(c, path, method, listen_fd, &err)) {
         g_critical("%s", error_get_pretty(err));
@@ -308,11 +242,6 @@ GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
 
 void ga_channel_free(GAChannel *c)
 {
-    if (c->listen_channel) {
-        ga_channel_listen_close(c);
-    }
-    if (c->client_channel) {
-        ga_channel_client_close(c);
-    }
+    ga_channel_common_free(&c->common);
     g_free(c);
 }
diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 779007e39b..2bd6fc1538 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -2,7 +2,7 @@
 #include <windows.h>
 #include <io.h>
 #include "guest-agent-core.h"
-#include "channel.h"
+#include "channel-common.h"
 
 typedef struct GAChannelReadState {
     guint thread_id;
@@ -15,9 +15,9 @@ typedef struct GAChannelReadState {
 } GAChannelReadState;
 
 struct GAChannel {
+    GAChannelCommon common;
+
     HANDLE handle;
-    GAChannelCallback cb;
-    gpointer user_data;
     GAChannelReadState rstate;
     GIOCondition pending_events; /* TODO: use GAWatch.pollfd.revents */
     GSource *source;
@@ -157,7 +157,7 @@ static gboolean ga_channel_dispatch(GSource *source, GSourceFunc unused,
     gboolean success;
 
     g_debug("dispatch");
-    success = c->cb(watch->pollfd.revents, c->user_data);
+    success = c->common.event_cb(watch->pollfd.revents, c->common.user_data);
 
     if (c->pending_events & G_IO_ERR) {
         g_critical("channel error, removing source");
@@ -330,8 +330,8 @@ GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
         return NULL;
     }
 
-    c->cb = cb;
-    c->user_data = opaque;
+    c->common.event_cb = cb;
+    c->common.user_data = opaque;
 
     sec_attrs.nLength = sizeof(SECURITY_ATTRIBUTES);
     sec_attrs.lpSecurityDescriptor = NULL;
@@ -354,6 +354,8 @@ void ga_channel_free(GAChannel *c)
     if (c->rstate.ov.hEvent) {
         CloseHandle(c->rstate.ov.hEvent);
     }
+
+    ga_channel_common_free(&c->common);
     g_free(c->rstate.buf);
     g_free(c);
 }
diff --git a/qga/meson.build b/qga/meson.build
index cfa2157efb..0e482e690a 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -66,7 +66,8 @@ qga_ss.add(files(
   'guest-agent-command-state.c',
   'main.c',
   'cutils.c',
-  'commands-common-ssh.c'
+  'commands-common-ssh.c',
+  'channel-common.c'
 ))
 if host_os == 'windows'
   qga_ss.add(files(
-- 
2.54.0


