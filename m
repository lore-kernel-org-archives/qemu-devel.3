Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C88D116F1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 13:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLFi-0005Po-QJ; Sat, 29 Nov 2025 08:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFX-0005ND-H2
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:32 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFS-0002Y4-NY
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:31 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 73E8D80885;
 Sat, 29 Nov 2025 16:44:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:891::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Iigm2k0FK8c0-QWhirveV; Sat, 29 Nov 2025 16:44:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764423864;
 bh=JIxYDuyoGw7oj0mgkQ6UoKxQLSafoXjs/OVv6Wb0oE0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=g0oGw9jiTQnLU5JQdV3FbdgpIgquFqHm990K/X6xswncaU4K8IX9SFJUp80zpUc5U
 W+08w+yMMGX7N2tHVIW3J1Pw+Adl0dfs/kfQM+2awX5DqDZUi1XvHahy6y6qAEaZRh
 OXsu3qIxf7RaTi+eYWi+Owgm+nNL5hArGjaJ7qRI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] chardev: .chr_open(): add boolean return value
Date: Sat, 29 Nov 2025 16:43:44 +0300
Message-ID: <20251129134350.487839-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129134350.487839-1-vsementsov@yandex-team.ru>
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add boolean return value to follow common recommendations for functions
with errrp in include/qapi/error.h

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/baum.c           |  5 +++--
 chardev/char-console.c   |  1 +
 chardev/char-file.c      | 13 +++++++------
 chardev/char-hub.c       | 11 ++++++-----
 chardev/char-mux.c       |  8 +++++---
 chardev/char-null.c      |  4 ++--
 chardev/char-parallel.c  | 14 ++++++++------
 chardev/char-pipe.c      | 12 +++++++-----
 chardev/char-pty.c       |  9 ++++++---
 chardev/char-ringbuf.c   |  5 +++--
 chardev/char-serial.c    | 15 +++++++++------
 chardev/char-socket.c    | 17 +++++++++--------
 chardev/char-stdio.c     | 11 ++++++-----
 chardev/char-udp.c       |  5 +++--
 chardev/char-win-stdio.c |  7 ++++---
 chardev/msmouse.c        |  3 ++-
 chardev/spice.c          | 13 ++++++++-----
 chardev/wctablet.c       |  3 ++-
 gdbstub/system.c         |  3 ++-
 include/chardev/char.h   |  2 +-
 ui/console-vc.c          |  3 ++-
 ui/dbus-chardev.c        |  6 +++---
 ui/gtk.c                 |  5 +++--
 ui/spice-app.c           | 10 ++++++----
 ui/vdagent.c             | 10 +++++-----
 25 files changed, 113 insertions(+), 82 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 58b74dc98d..0b0247dde0 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -642,7 +642,7 @@ static void char_braille_finalize(Object *obj)
     }
 }
 
-static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     BaumChardev *baum = BAUM_CHARDEV(chr);
     brlapi_handle_t *handle;
@@ -656,7 +656,7 @@ static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
                    brlapi_strerror(brlapi_error_location()));
         g_free(handle);
         baum->brlapi = NULL;
-        return;
+        return false;
     }
     baum->deferred_init = 0;
 
@@ -669,6 +669,7 @@ static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 static void char_braille_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-console.c b/chardev/char-console.c
index 423f0f4cc4..c911cc62e3 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -31,6 +31,7 @@ static void console_chr_open(Chardev *chr, ChardevBackend *backend,
 {
     win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 static void char_console_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 34ef386abc..b0dd9d5f87 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -34,7 +34,7 @@
 #include "chardev/char-fd.h"
 #endif
 
-static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevFile *file = backend->u.file.data;
 #ifdef _WIN32
@@ -44,7 +44,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     if (file->in) {
         error_setg(errp, "input file not supported");
-        return;
+        return false;
     }
 
     if (file->has_append && file->append) {
@@ -61,7 +61,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
                      FILE_ATTRIBUTE_NORMAL, NULL);
     if (out == INVALID_HANDLE_VALUE) {
         error_setg(errp, "open %s failed", file->out);
-        return;
+        return false;
     }
 
     win_chr_set_file(chr, out, false);
@@ -77,7 +77,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     out = qmp_chardev_open_file_source(file->out, flags, errp);
     if (out < 0) {
-        return;
+        return false;
     }
 
     if (file->in) {
@@ -85,7 +85,7 @@ static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         in = qmp_chardev_open_file_source(file->in, flags, errp);
         if (in < 0) {
             qemu_close(out);
-            return;
+            return false;
         }
     }
 
@@ -94,11 +94,12 @@ static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         if (in >= 0) {
             qemu_close(in);
         }
-        return;
+        return false;
     }
 #endif
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 static void file_chr_parse(QemuOpts *opts, ChardevBackend *backend,
diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index aa6058c2f6..05cf722b5b 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -203,7 +203,7 @@ static void hub_chr_update_read_handlers(Chardev *chr)
     }
 }
 
-static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHub *hub = backend->u.hub.data;
     HubChardev *d = HUB_CHARDEV(chr);
@@ -213,7 +213,7 @@ static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     if (list == NULL) {
         error_setg(errp, "hub: 'chardevs' list is not defined");
-        return;
+        return false;
     }
 
     while (list) {
@@ -223,17 +223,17 @@ static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         if (s == NULL) {
             error_setg(errp, "hub: chardev can't be found by id '%s'",
                        list->value);
-            return;
+            return false;
         }
         if (CHARDEV_IS_HUB(s) || CHARDEV_IS_MUX(s)) {
             error_setg(errp, "hub: multiplexers and hub devices can't be "
                        "stacked, check chardev '%s', chardev should not "
                        "be a hub device or have 'mux=on' enabled",
                        list->value);
-            return;
+            return false;
         }
         if (!hub_chr_attach_chardev(d, s, errp)) {
-            return;
+            return false;
         }
         list = list->next;
     }
@@ -242,6 +242,7 @@ static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
      * Closed until an explicit event from backend, so we don't
      * send CHR_EVENT_OPENED now.
      */
+    return true;
 }
 
 static void hub_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 7210df431f..881443d869 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -361,7 +361,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
-static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevMux *mux = backend->u.mux.data;
     Chardev *drv;
@@ -370,12 +370,12 @@ static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     drv = qemu_chr_find(mux->chardev);
     if (drv == NULL) {
         error_setg(errp, "mux: base chardev %s not found", mux->chardev);
-        return;
+        return false;
     }
 
     d->focus = -1;
     if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
-        return;
+        return false;
     }
 
     /*
@@ -385,6 +385,8 @@ static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     if (muxes_opened) {
         qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     }
+
+    return true;
 }
 
 static void mux_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/chardev/char-null.c b/chardev/char-null.c
index 900b5febb6..d5a101178b 100644
--- a/chardev/char-null.c
+++ b/chardev/char-null.c
@@ -26,9 +26,9 @@
 #include "chardev/char.h"
 #include "qemu/module.h"
 
-static void null_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool null_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
-    /* do not send CHR_EVENT_OPENED */
+    return true;
 }
 
 static void char_null_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 359efa3c9c..cbf87e660d 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -157,7 +157,7 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
+static bool parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
 {
     ParallelChardev *drv = PARALLEL_CHARDEV(chr);
 
@@ -165,11 +165,12 @@ static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
 
     if (ioctl(fd, PPCLAIM) < 0) {
         error_setg_errno(errp, errno, "not a parallel port");
-        return;
+        return false;
     }
 
     drv->mode = IEEE1284_MODE_COMPAT;
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 #endif /* __linux__ */
 
@@ -225,15 +226,16 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
+static bool parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
 {
     ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     drv->fd = fd;
+    return true;
 }
 #endif
 
 #ifdef HAVE_CHARDEV_PARALLEL
-static void parallel_chr_open(Chardev *chr,
+static bool parallel_chr_open(Chardev *chr,
                               ChardevBackend *backend,
                               Error **errp)
 {
@@ -242,9 +244,9 @@ static void parallel_chr_open(Chardev *chr,
 
     fd = qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
     if (fd < 0) {
-        return;
+        return false;
     }
-    parallel_chr_open_fd(chr, fd, errp);
+    return parallel_chr_open_fd(chr, fd, errp);
 }
 
 static void parallel_chr_parse(QemuOpts *opts, ChardevBackend *backend,
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 2f26372dfc..472b3e0801 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -103,21 +103,22 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
     return -1;
 }
 
-static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     const char *filename = opts->device;
 
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
-        return;
+        return false;
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 #else
 
-static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     int fd_in, fd_out;
@@ -143,7 +144,7 @@ static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         );
         if (fd_in < 0) {
             error_setg_file_open(errp, errno, filename);
-            return;
+            return false;
         }
     }
 
@@ -152,10 +153,11 @@ static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         if (fd_out != fd_in) {
             close(fd_out);
         }
-        return;
+        return false;
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 #endif /* !_WIN32 */
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index d4d69a29a9..9e26e97baf 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -331,7 +331,7 @@ static int qemu_openpty_raw(int *aslave, char *pty_name)
     return amaster;
 }
 
-static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     PtyChardev *s;
     int master_fd, slave_fd;
@@ -342,13 +342,13 @@ static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     master_fd = qemu_openpty_raw(&slave_fd, pty_name);
     if (master_fd < 0) {
         error_setg_errno(errp, errno, "Failed to create PTY");
-        return;
+        return false;
     }
 
     close(slave_fd);
     if (!qemu_set_blocking(master_fd, false, errp)) {
         close(master_fd);
-        return;
+        return false;
     }
 
     chr->filename = g_strdup_printf("pty:%s", pty_name);
@@ -368,10 +368,13 @@ static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
         if (res != 0) {
             error_setg_errno(errp, errno, "Failed to create PTY symlink");
+            return false;
         } else {
             s->path = g_strdup(path);
         }
     }
+
+    return true;
 }
 
 static void pty_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 30b17a96d3..8f998d26a4 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -92,7 +92,7 @@ static void char_ringbuf_finalize(Object *obj)
     g_free(d->cbuf);
 }
 
-static void ringbuf_chr_open(Chardev *chr,
+static bool ringbuf_chr_open(Chardev *chr,
                              ChardevBackend *backend,
                              Error **errp)
 {
@@ -104,7 +104,7 @@ static void ringbuf_chr_open(Chardev *chr,
     /* The size must be power of 2 */
     if (d->size & (d->size - 1)) {
         error_setg(errp, "size of ringbuf chardev must be power of two");
-        return;
+        return false;
     }
 
     d->prod = 0;
@@ -112,6 +112,7 @@ static void ringbuf_chr_open(Chardev *chr,
     d->cbuf = g_malloc0(d->size);
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 void qmp_ringbuf_write(const char *device, const char *data,
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 9995f18425..0c73bafc54 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -41,15 +41,17 @@
 
 #ifdef _WIN32
 
-static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool serial_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
     int ret = win_chr_serial_init(chr, serial->device, errp);
     if (ret < 0) {
-        return;
+        return false;
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+
+    return true;
 }
 
 #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
@@ -259,7 +261,7 @@ static int serial_chr_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool serial_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
     int fd;
@@ -267,20 +269,21 @@ static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     fd = qmp_chardev_open_file_source(serial->device, O_RDWR | O_NONBLOCK,
                                       errp);
     if (fd < 0) {
-        return;
+        return false;
     }
     if (!qemu_set_blocking(fd, false, errp)) {
         close(fd);
-        return;
+        return false;
     }
     tty_serial_init(fd, 115200, 'N', 8, 1);
 
     if (!qemu_chr_open_fd(chr, fd, fd, errp)) {
         close(fd);
-        return;
+        return false;
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 #endif /* __linux__ || __sun__ */
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 3f57ef4016..31c9acd164 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1365,7 +1365,7 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
 }
 
 
-static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     ChardevSocket *sock = backend->u.socket.data;
@@ -1390,7 +1390,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         if (!creds) {
             error_setg(errp, "No TLS credentials with id '%s'",
                        sock->tls_creds);
-            return;
+            return false;
         }
         s->tls_creds = (QCryptoTLSCreds *)
             object_dynamic_cast(creds,
@@ -1398,7 +1398,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         if (!s->tls_creds) {
             error_setg(errp, "Object with id '%s' is not TLS credentials",
                        sock->tls_creds);
-            return;
+            return false;
         }
         object_ref(OBJECT(s->tls_creds));
         if (!qcrypto_tls_creds_check_endpoint(s->tls_creds,
@@ -1406,7 +1406,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
                                           ? QCRYPTO_TLS_CREDS_ENDPOINT_SERVER
                                           : QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
                                           errp)) {
-            return;
+            return false;
         }
     }
     s->tls_authz = g_strdup(sock->tls_authz);
@@ -1414,7 +1414,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     s->addr = addr = socket_address_flatten(sock->addr);
 
     if (!qmp_chardev_validate_socket(sock, addr, errp)) {
-        return;
+        return false;
     }
 
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
@@ -1431,7 +1431,7 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
      */
     if (!chr->handover_yank_instance) {
         if (!yank_register_instance(CHARDEV_YANK_INSTANCE(chr->label), errp)) {
-            return;
+            return false;
         }
     }
     s->registered_yank = true;
@@ -1441,15 +1441,16 @@ static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     if (s->is_listen) {
         if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
                                            is_waitconnect, errp) < 0) {
-            return;
+            return false;
         }
     } else {
         if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0) {
-            return;
+            return false;
         }
     }
 
     /* be isn't opened until we get a connection */
+    return true;
 }
 
 static void tcp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 534f6ed565..fe1cbb2d88 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -85,19 +85,19 @@ static void term_stdio_handler(int sig)
     stdio_chr_set_echo(NULL, stdio_echo_state);
 }
 
-static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
 
     if (is_daemonized()) {
         error_setg(errp, "cannot use stdio with -daemonize");
-        return;
+        return false;
     }
 
     if (stdio_in_use) {
         error_setg(errp, "cannot use stdio by multiple character devices");
-        return;
+        return false;
     }
 
     stdio_in_use = true;
@@ -105,11 +105,11 @@ static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     old_fd1_flags = fcntl(1, F_GETFL);
     tcgetattr(0, &oldtty);
     if (!qemu_set_blocking(0, false, errp)) {
-        return;
+        return false;
     }
 
     if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
-        return;
+        return false;
     }
 
     atexit(term_exit);
@@ -122,6 +122,7 @@ static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     stdio_chr_set_echo(chr, false);
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 #endif
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index b835a967e1..3d3bc1f659 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -188,7 +188,7 @@ static void udp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
     }
 }
 
-static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevUdp *udp = backend->u.udp.data;
     SocketAddress *local_addr = socket_address_flatten(udp->local);
@@ -203,7 +203,7 @@ static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     qapi_free_SocketAddress(remote_addr);
     if (ret < 0) {
         object_unref(OBJECT(sioc));
-        return;
+        return false;
     }
 
     name = g_strdup_printf("chardev-udp-%s", chr->label);
@@ -212,6 +212,7 @@ static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     s->ioc = QIO_CHANNEL(sioc);
     /* be isn't opened until we get a connection */
+    return true;
 }
 
 static void char_udp_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 0535960ff1..bb9c195a8b 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -142,7 +142,7 @@ static void win_stiod_chr_set_echo(Chardev *chr, bool echo)
     }
 }
 
-static void win_stdio_chr_open(Chardev *chr,
+static bool win_stdio_chr_open(Chardev *chr,
                                ChardevBackend *backend,
                                Error **errp)
 {
@@ -155,7 +155,7 @@ static void win_stdio_chr_open(Chardev *chr,
     stdio->hStdIn = GetStdHandle(STD_INPUT_HANDLE);
     if (stdio->hStdIn == INVALID_HANDLE_VALUE) {
         error_setg(errp, "cannot open stdio: invalid handle");
-        return;
+        return false;
     }
 
     is_console = GetConsoleMode(stdio->hStdIn, &dwMode) != 0;
@@ -208,7 +208,7 @@ static void win_stdio_chr_open(Chardev *chr,
     win_stiod_chr_set_echo(chr, false);
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-    return;
+    return true;
 
 err3:
     qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
@@ -217,6 +217,7 @@ err2:
     CloseHandle(stdio->hInputDoneEvent);
 err1:
     qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
+    return false;
 }
 
 static void char_win_stdio_finalize(Object *obj)
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 9dc04e3b3e..365f04546e 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -253,7 +253,7 @@ static void char_msmouse_finalize(Object *obj)
     fifo8_destroy(&mouse->outbuf);
 }
 
-static void msmouse_chr_open(Chardev *chr,
+static bool msmouse_chr_open(Chardev *chr,
                              ChardevBackend *backend,
                              Error **errp)
 {
@@ -265,6 +265,7 @@ static void msmouse_chr_open(Chardev *chr,
     fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
 
     /* Never send CHR_EVENT_OPENED */
+    return true;
 }
 
 static void char_msmouse_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/spice.c b/chardev/spice.c
index 612f358885..d110ed96f4 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -251,7 +251,7 @@ static void chr_open(Chardev *chr, const char *subtype)
     s->sin.subtype = g_strdup(subtype);
 }
 
-static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
+static bool spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
                                Error **errp)
 {
     ChardevSpiceChannel *spicevmc = backend->u.spicevmc.data;
@@ -272,7 +272,7 @@ static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
                           subtypes);
 
         g_free(subtypes);
-        return;
+        return false;
     }
 
 #if SPICE_SERVER_VERSION < 0x000e02
@@ -280,12 +280,14 @@ static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
     if (strcmp(type, "smartcard") == 0) {
         chr_open(chr, type);
         qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+        return true;
     }
 #endif
     chr_open(chr, type);
+    return true;
 }
 
-static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
+static bool spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
                                 Error **errp)
 {
     ChardevSpicePort *spiceport = backend->u.spiceport.data;
@@ -294,12 +296,12 @@ static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
 
     if (name == NULL) {
         error_setg(errp, "missing name parameter");
-        return;
+        return false;
     }
 
     if (!using_spice) {
         error_setg(errp, "spice not enabled");
-        return;
+        return false;
     }
 
     chr_open(chr, "port");
@@ -308,6 +310,7 @@ static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
     s->sin.portname = g_strdup(name);
 
     vmc_register_interface(s);
+    return true;
 }
 
 static void spice_vmc_chr_parse(QemuOpts *opts, ChardevBackend *backend,
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 65b2ceb58c..214d5ca2e2 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -324,7 +324,7 @@ static void wctablet_chr_finalize(Object *obj)
     }
 }
 
-static void wctablet_chr_open(Chardev *chr,
+static bool wctablet_chr_open(Chardev *chr,
                               ChardevBackend *backend,
                               Error **errp)
 {
@@ -339,6 +339,7 @@ static void wctablet_chr_open(Chardev *chr,
                                              &wctablet_handler);
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 static void wctablet_chr_class_init(ObjectClass *oc, const void *data)
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 49da1f73cc..ec24d812b3 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -233,9 +233,10 @@ static int gdb_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
-static void gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     /* Never send CHR_EVENT_OPENED */
+    return true;
 }
 
 static void char_gdb_class_init(ObjectClass *oc, const void *data)
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 47c75c3582..23a227dca9 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -260,7 +260,7 @@ struct ChardevClass {
     void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
     /* called after construction, open/starts the backend */
-    void (*chr_open)(Chardev *chr, ChardevBackend *backend, Error **errp);
+    bool (*chr_open)(Chardev *chr, ChardevBackend *backend, Error **errp);
 
     /* write buf to the backend */
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 4c8ea4c148..f22806fed7 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1093,7 +1093,7 @@ void qemu_text_console_update_size(QemuTextConsole *c)
     dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
 }
 
-static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
     VCChardev *drv = VC_CHARDEV(chr);
@@ -1142,6 +1142,7 @@ static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index 3e471f84cd..9442b47551 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -176,7 +176,7 @@ dbus_chr_send_break(
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
-static void dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ERRP_GUARD();
 
@@ -206,9 +206,9 @@ static void dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_parse(
         opts, be, errp);
     if (*errp) {
-        return;
+        return false;
     }
-    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
+    return CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
         chr, be, errp);
 }
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 3eeb5baa11..e2c0135646 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1967,7 +1967,7 @@ static void gd_vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     if (nb_vcs == MAX_VCS) {
         error_setg(errp, "Maximum number of consoles reached");
-        return;
+        return false;
     }
 
     vcs[nb_vcs++] = chr;
@@ -1976,13 +1976,14 @@ static void gd_vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
      * console/chardev init sometimes completes elsewhere in a 2nd
      * stage, so defer OPENED events until they are fully initialized
      */
+    return true;
 }
 
 static void char_gd_vc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_open = gd_vc_chr_open;
+    cc->chr_open = char_gtk_init;
     cc->chr_write = gd_vc_chr_write;
     cc->chr_accept_input = gd_vc_chr_accept_input;
     cc->chr_set_echo = gd_vc_chr_set_echo;
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 7ac9ae4e78..9e55f27371 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -49,7 +49,7 @@ struct VCChardev {
 
 struct VCChardevClass {
     ChardevClass parent;
-    void (*parent_open)(Chardev *chr, ChardevBackend *backend, Error **errp);
+    bool (*parent_init)(Chardev *chr, ChardevBackend *backend, Error **errp);
 };
 
 #define TYPE_CHARDEV_VC "chardev-vc"
@@ -66,11 +66,12 @@ chr_spice_backend_new(void)
     return be;
 }
 
-static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     VCChardevClass *vc = CHARDEV_VC_GET_CLASS(chr);
     ChardevBackend *be;
     const char *fqdn = NULL;
+    bool ok;
 
     if (strstart(chr->label, "serial", NULL)) {
         fqdn = "org.qemu.console.serial.0";
@@ -83,8 +84,9 @@ static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     be = chr_spice_backend_new();
     be->u.spiceport.data->fqdn = fqdn ?
         g_strdup(fqdn) : g_strdup_printf("org.qemu.console.%s", chr->label);
-    vc->parent_open(chr, be, errp);
+    ok = vc->parent_init(chr, be, errp);
     qapi_free_ChardevBackend(be);
+    return ok;
 }
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)
@@ -102,7 +104,7 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     VCChardevClass *vc = CHARDEV_VC_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    vc->parent_open = cc->chr_open;
+    vc->parent_init = cc->chr_open;
 
     cc->chr_parse = vc_chr_parse;
     cc->chr_open = vc_chr_open;
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 3becc6c076..d5c6e3340b 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -660,8 +660,7 @@ static void vdagent_chr_recv_clipboard(VDAgentChardev *vd, VDAgentMessage *msg)
 /* ------------------------------------------------------------------ */
 /* chardev backend                                                    */
 
-static void vdagent_chr_open(Chardev *chr,
-                             ChardevBackend *backend,
+static bool vdagent_chr_open(Chardev *chr, ChardevBackend *backend,
                              Error **errp)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(chr);
@@ -673,7 +672,7 @@ static void vdagent_chr_open(Chardev *chr,
      * so we have to byteswap everything on BE hosts.
      */
     error_setg(errp, "vdagent is not supported on bigendian hosts");
-    return;
+    return false;
 #endif
 
     vd->mouse = VDAGENT_MOUSE_DEFAULT;
@@ -692,6 +691,7 @@ static void vdagent_chr_open(Chardev *chr,
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    return true;
 }
 
 static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
@@ -1074,7 +1074,7 @@ static const VMStateDescription vmstate_vdagent = {
     }
 };
 
-static void vdagent_chr_init(Object *obj)
+static void vdagent_chr_instance_init(Object *obj)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
@@ -1097,7 +1097,7 @@ static const TypeInfo vdagent_chr_type_info = {
     .name = TYPE_CHARDEV_QEMU_VDAGENT,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VDAgentChardev),
-    .instance_init = vdagent_chr_init,
+    .instance_init = vdagent_chr_instance_init,
     .instance_finalize = vdagent_chr_fini,
     .class_init = vdagent_chr_class_init,
 };
-- 
2.48.1


