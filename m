Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC116CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 18:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wadYK-0000hb-N8; Fri, 19 Jun 2026 14:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadYD-0000eT-Ob
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:45 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadYB-0004Id-CU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=qMqk5rMPxrFoglWjWnmC7Ahe0HDQf2mbmfBMYYk6VlE=; b=hRq29yPpZror
 uukiOJ22ix30w7YlC7dmSUBY/2DpwKIAZiLvdgY+ytGLo1HUp0eLLJkvSXvzOmXMHBkusovwssBPN
 +2Tc7w1pgHIp8ZcAcR5HBaD1cjoR0WyrbCofcvzmjAU8oYW7/vHNz/FLu2Mpu0p05VttZ3xrgcYz1
 Jltry1U9W9CiNWmuUbqCdr/Hp0sbVhZpMfVmw8KFssEuXRsE32TatRUHFhkCLiWn/MxYCyrwwtnBr
 y+BnWJw1AgJa710LKRziqcRD55qjbtA+YKBu3mSawARaIjaFTOKQ2Nc8lPf/OWYA2gDAQ4XP4NSwL
 +ss9WGIxdoVKDQ5tjaaEzw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=mami)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <polina.vishneva@virtuozzo.com>) id 1wadXZ-001Gyc-1L;
 Fri, 19 Jun 2026 20:02:37 +0200
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
Subject: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
Date: Fri, 19 Jun 2026 20:00:22 +0200
Message-ID: <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
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

Add vsock-listen channel mode to the Windows guest agent.

The listen/accept path uses the standard QEMU socket helpers
(socket_parse(), socket_listen(), qemu_accept()) and plugs the resulting
SOCKET into the GMainLoop via g_io_channel_win32_new_socket().

Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
---
 docs/interop/qemu-ga.rst |   4 +
 qga/channel-win32.c      | 257 ++++++++++++++++++++++++++++++++-------
 qga/main.c               |   6 +
 3 files changed, 222 insertions(+), 45 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index d16cc1b9f0..9c415fc8f8 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -59,6 +59,10 @@ Options
   Transport method: one of ``unix-listen``, ``virtio-serial``, or
   ``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the default).
 
+  .. note::
+     On Windows, ``vsock-listen`` requires the viosock driver from
+     kvm-guest-drivers-windows recent enough to include commit ``687c776``.
+
 .. option:: -p, --path=PATH
 
   Device/socket path (the default for virtio-serial is
diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 2bd6fc1538..257576815a 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -1,6 +1,8 @@
 #include "qemu/osdep.h"
 #include <windows.h>
 #include <io.h>
+#include "qapi/error.h"
+#include "qemu/sockets.h"
 #include "guest-agent-core.h"
 #include "channel-common.h"
 
@@ -17,6 +19,9 @@ typedef struct GAChannelReadState {
 struct GAChannel {
     GAChannelCommon common;
 
+    int listen_fd;
+    int client_fd;
+
     HANDLE handle;
     GAChannelReadState rstate;
     GIOCondition pending_events; /* TODO: use GAWatch.pollfd.revents */
@@ -198,7 +203,116 @@ static GSource *ga_channel_create_watch(GAChannel *c)
     return source;
 }
 
-GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *count)
+/*
+ * Socket mode: GIOChannel-based listen/accept/client helpers
+ */
+
+static gboolean ga_channel_socket_client_event(GIOChannel *channel,
+                                               GIOCondition condition,
+                                               gpointer data);
+static gboolean ga_channel_socket_listen_accept(GIOChannel *channel,
+                                                GIOCondition condition,
+                                                gpointer data);
+
+static void ga_channel_socket_listen_add(GAChannel *c, bool create)
+{
+    if (create) {
+        c->common.listen_channel =
+            g_io_channel_win32_new_socket(_get_osfhandle(c->listen_fd));
+        g_assert(c->common.listen_channel);
+    }
+    g_io_add_watch(c->common.listen_channel, G_IO_IN,
+                   ga_channel_socket_listen_accept, c);
+}
+
+static gboolean ga_channel_socket_client_close(GAChannel *c)
+{
+    /* Free the CRT fd wrapper while the SOCKET is still valid. */
+    if (c->client_fd >= 0) {
+        qemu_close_socket_osfhandle(c->client_fd);
+        c->client_fd = -1;
+    }
+    ga_channel_common_client_close(&c->common);
+    if (c->common.listen_channel) {
+        ga_channel_socket_listen_add(c, false);
+    }
+    return false;
+}
+
+static gboolean ga_channel_socket_listen_accept(GIOChannel *channel,
+                                                GIOCondition condition,
+                                                gpointer data)
+{
+    GAChannel *c = data;
+    int client_fd;
+    GIOChannel *client_ch;
+    bool accepted = false;
+
+    client_fd = qemu_accept(c->listen_fd, NULL, NULL);
+    if (client_fd < 0) {
+        g_warning("error accepting connection: %s", strerror(errno));
+        goto out;
+    }
+
+    /*
+     * g_io_channel_win32_new_socket() makes the socket nonblocking via
+     * WSAEventSelect.
+     */
+    client_ch = g_io_channel_win32_new_socket(_get_osfhandle(client_fd));
+    g_assert(client_ch);
+
+    if (ga_channel_common_client_add(&c->common, client_ch,
+                                     ga_channel_socket_client_event, c)) {
+        g_warning("error setting up connection");
+        /*
+         * Release the CRT fd wrapper while its SOCKET is still open - only
+         * then qemu_close_socket_osfhandle() can detach the fd and let the
+         * channel teardown perform the single closesocket().
+         */
+        qemu_close_socket_osfhandle(client_fd);
+        ga_channel_common_gio_destroy(client_ch);
+        goto out;
+    }
+    c->client_fd = client_fd;
+    accepted = true;
+
+out:
+    /* only accept 1 connection at a time */
+    return !accepted;
+}
+
+static gboolean ga_channel_socket_client_event(GIOChannel *channel,
+                                               GIOCondition condition,
+                                               gpointer data)
+{
+    GAChannel *c = data;
+
+    g_assert(c);
+    if (!c->common.event_cb(condition, c->common.user_data)) {
+        return ga_channel_socket_client_close(c);
+    }
+    /*
+     * A peer that sends data and disconnects at once is never reported:
+     * GLib turns the coalesced FD_READ|FD_CLOSE into a plain G_IO_IN,
+     * and Winsock records FD_CLOSE only once, so no later event follows.
+     * Peek after each event to detect the disconnect.
+     */
+    if (c->client_fd >= 0) {
+        char peek;
+        ssize_t r = recv(c->client_fd, &peek, 1, MSG_PEEK);
+        if (r == 0 || (r < 0 && errno != EAGAIN)) {
+            return ga_channel_socket_client_close(c);
+        }
+    }
+    return true;
+}
+
+/*
+ * Handle mode: overlapped I/O read/write
+ */
+
+static GIOStatus ga_channel_handle_read(GAChannel *c, char *buf, size_t size,
+                                        gsize *count)
 {
     GAChannelReadState *rs = &c->rstate;
     GIOStatus status;
@@ -221,8 +335,8 @@ GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *count)
     return status;
 }
 
-static GIOStatus ga_channel_write(GAChannel *c, const char *buf, size_t size,
-                                  size_t *count)
+static GIOStatus ga_channel_handle_write(GAChannel *c, const char *buf,
+                                         size_t size, size_t *count)
 {
     GIOStatus status;
     OVERLAPPED ov = {0};
@@ -262,13 +376,25 @@ static GIOStatus ga_channel_write(GAChannel *c, const char *buf, size_t size,
     return status;
 }
 
+GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *count)
+{
+    if (c->common.method == GA_CHANNEL_VSOCK_LISTEN) {
+        return ga_channel_common_read(&c->common, buf, size, count);
+    }
+    return ga_channel_handle_read(c, buf, size, count);
+}
+
 GIOStatus ga_channel_write_all(GAChannel *c, const char *buf, size_t size)
 {
     GIOStatus status = G_IO_STATUS_NORMAL;
     size_t count = 0;
 
+    if (c->common.method == GA_CHANNEL_VSOCK_LISTEN) {
+        return ga_channel_common_write_all(&c->common, buf, size);
+    }
+
     while (size) {
-        status = ga_channel_write(c, buf, size, &count);
+        status = ga_channel_handle_write(c, buf, size, &count);
         if (status == G_IO_STATUS_NORMAL) {
             size -= count;
             buf += count;
@@ -276,86 +402,127 @@ GIOStatus ga_channel_write_all(GAChannel *c, const char *buf, size_t size)
             break;
         }
     }
-
     return status;
 }
 
 static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
-                                const gchar *path)
+                                const gchar *path, Error **errp)
 {
     COMMTIMEOUTS comTimeOut = {0};
     gchar newpath[MAXPATHLEN] = {0};
     comTimeOut.ReadIntervalTimeout = 1;
 
-    if (method != GA_CHANNEL_VIRTIO_SERIAL && method != GA_CHANNEL_ISA_SERIAL) {
-        g_critical("unsupported communication method");
-        return false;
-    }
+    c->common.method = method;
 
-    if (method == GA_CHANNEL_ISA_SERIAL) {
-        snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
-    } else {
-        g_strlcpy(newpath, path, sizeof(newpath));
-    }
+    switch (method) {
+    case GA_CHANNEL_VIRTIO_SERIAL:
+    case GA_CHANNEL_ISA_SERIAL:
+        if (method == GA_CHANNEL_ISA_SERIAL) {
+            snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
+        } else {
+            g_strlcpy(newpath, path, sizeof(newpath));
+        }
 
-    c->handle = CreateFile(newpath, GENERIC_READ | GENERIC_WRITE, 0, NULL,
-                           OPEN_EXISTING,
-                           FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED, NULL);
-    if (c->handle == INVALID_HANDLE_VALUE) {
-        g_autofree gchar *emsg = g_win32_error_message(GetLastError());
-        g_critical("error opening path %s: %s", newpath, emsg);
-        return false;
+        c->handle = CreateFile(newpath, GENERIC_READ | GENERIC_WRITE, 0, NULL,
+                               OPEN_EXISTING,
+                               FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED,
+                               NULL);
+        if (c->handle == INVALID_HANDLE_VALUE) {
+            g_autofree gchar *emsg = g_win32_error_message(GetLastError());
+            error_setg(errp, "error opening path %s: %s", newpath, emsg);
+            c->handle = NULL;
+            return false;
+        }
+
+        if (method == GA_CHANNEL_ISA_SERIAL
+                && !SetCommTimeouts(c->handle, &comTimeOut)) {
+            g_autofree gchar *emsg = g_win32_error_message(GetLastError());
+            error_setg(errp, "error setting timeout for com port: %s", emsg);
+            CloseHandle(c->handle);
+            c->handle = NULL;
+            return false;
+        }
+        return true;
+
+#ifdef CONFIG_AF_VSOCK
+    case GA_CHANNEL_VSOCK_LISTEN: {
+        int fd = ga_channel_common_vsock_listen(path, errp);
+        if (fd < 0) {
+            return false;
+        }
+
+        c->listen_fd = fd;
+        ga_channel_socket_listen_add(c, true);
+        return true;
     }
+#endif
 
-    if (method == GA_CHANNEL_ISA_SERIAL
-            && !SetCommTimeouts(c->handle, &comTimeOut)) {
-        g_autofree gchar *emsg = g_win32_error_message(GetLastError());
-        g_critical("error setting timeout for com port: %s", emsg);
-        CloseHandle(c->handle);
+    default:
+        error_setg(errp, "unsupported communication method");
         return false;
     }
-
-    return true;
 }
 
 GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
                           int listen_fd, GAChannelCallback cb, gpointer opaque)
 {
+    Error *err = NULL;
     GAChannel *c = g_new0(GAChannel, 1);
-    SECURITY_ATTRIBUTES sec_attrs;
 
-    if (!ga_channel_open(c, method, path)) {
-        g_critical("error opening channel");
-        g_free(c);
+    /* listen_fd is for systemd socket activation; not applicable on Windows. */
+    (void)listen_fd;
+    c->listen_fd = -1;
+    c->client_fd = -1;
+    c->common.event_cb = cb;
+    c->common.user_data = opaque;
+
+    if (!ga_channel_open(c, method, path, &err)) {
+        g_critical("%s", error_get_pretty(err));
+        error_free(err);
+        ga_channel_free(c);
         return NULL;
     }
 
-    c->common.event_cb = cb;
-    c->common.user_data = opaque;
+    if (c->common.method != GA_CHANNEL_VSOCK_LISTEN) {
+        SECURITY_ATTRIBUTES sec_attrs;
+
+        sec_attrs.nLength = sizeof(SECURITY_ATTRIBUTES);
+        sec_attrs.lpSecurityDescriptor = NULL;
+        sec_attrs.bInheritHandle = false;
 
-    sec_attrs.nLength = sizeof(SECURITY_ATTRIBUTES);
-    sec_attrs.lpSecurityDescriptor = NULL;
-    sec_attrs.bInheritHandle = false;
+        c->rstate.buf_size = QGA_READ_COUNT_DEFAULT;
+        c->rstate.buf = g_malloc(QGA_READ_COUNT_DEFAULT);
+        c->rstate.ov.hEvent = CreateEvent(&sec_attrs, FALSE, FALSE, NULL);
 
-    c->rstate.buf_size = QGA_READ_COUNT_DEFAULT;
-    c->rstate.buf = g_malloc(QGA_READ_COUNT_DEFAULT);
-    c->rstate.ov.hEvent = CreateEvent(&sec_attrs, FALSE, FALSE, NULL);
+        c->source = ga_channel_create_watch(c);
+        g_source_attach(c->source, NULL);
+    }
 
-    c->source = ga_channel_create_watch(c);
-    g_source_attach(c->source, NULL);
     return c;
 }
 
 void ga_channel_free(GAChannel *c)
 {
+    if (c->common.method == GA_CHANNEL_VSOCK_LISTEN) {
+        /* Free the CRT fd wrappers before the GIOChannels close the SOCKETs. */
+        if (c->listen_fd >= 0) {
+            qemu_close_socket_osfhandle(c->listen_fd);
+        }
+        if (c->client_fd >= 0) {
+            qemu_close_socket_osfhandle(c->client_fd);
+        }
+        ga_channel_common_free(&c->common);
+        g_free(c);
+        return;
+    }
+
+    /* Handle mode */
     if (c->source) {
         g_source_destroy(c->source);
     }
     if (c->rstate.ov.hEvent) {
         CloseHandle(c->rstate.ov.hEvent);
     }
-
-    ga_channel_common_free(&c->common);
     g_free(c->rstate.buf);
     g_free(c);
 }
diff --git a/qga/main.c b/qga/main.c
index fd19c7037d..35068ac7bb 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1675,6 +1675,12 @@ int main(int argc, char **argv)
 
     config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
 
+    /* Required for Windows, harmless otherwise. */
+    if (socket_init() < 0) {
+        g_critical("failed to initialize sockets");
+        goto end;
+    }
+
     qemu_init_exec_dir(argv[0]);
     qga_qmp_init_marshal(&ga_commands);
 
-- 
2.54.0


