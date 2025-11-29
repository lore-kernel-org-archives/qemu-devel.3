Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3712CD116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 13:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLFm-0005Qz-Ij; Sat, 29 Nov 2025 08:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFW-0005NA-U9
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:31 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFS-0002Xw-IO
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4A59B8086A;
 Sat, 29 Nov 2025 16:44:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:891::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Iigm2k0FK8c0-eR8gCsdA; Sat, 29 Nov 2025 16:44:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764423863;
 bh=ufOUVebbtXJdeX4ctqszGc+K8Ac9ZUq2Xm8ONEop/tM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DPsAg3tEomuPpn5MCQHPGp5BEB+2Yu9TgBSCsDG47+R19akPRizSEXtVMDlyXMrgl
 HFFVHVnoIJYts1VQ0cm3siwDq0+cVJaubXWJbn6Mi2j9Txic2JlryPDiR/UxK24KlE
 ijONyTUaL55w43nYAguJFuB3jZOxOolyLXLGDge0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] chardev: .chr_open(): drop be_opened parameter
Date: Sat, 29 Nov 2025 16:43:43 +0300
Message-ID: <20251129134350.487839-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129134350.487839-1-vsementsov@yandex-team.ru>
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The logic around the parameter is rather tricky. Let's instead
explicitly send CHR_EVENT_OPENED in all bakends where needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/baum.c           |  7 +++----
 chardev/char-console.c   |  5 ++---
 chardev/char-file.c      |  7 +++----
 chardev/char-hub.c       | 11 +++++------
 chardev/char-mux.c       | 19 +++++++++++--------
 chardev/char-null.c      |  7 ++-----
 chardev/char-parallel.c  | 15 ++++-----------
 chardev/char-pipe.c      | 14 ++++++--------
 chardev/char-pty.c       |  6 +-----
 chardev/char-ringbuf.c   |  3 ++-
 chardev/char-serial.c    | 18 +++++++++---------
 chardev/char-socket.c    | 10 +++-------
 chardev/char-stdio.c     |  7 +++----
 chardev/char-udp.c       |  6 +-----
 chardev/char-win-stdio.c |  2 +-
 chardev/char.c           | 11 +++--------
 chardev/msmouse.c        |  4 ++--
 chardev/spice.c          | 13 ++++---------
 chardev/wctablet.c       |  5 ++---
 gdbstub/system.c         |  5 ++---
 include/chardev/char.h   |  3 +--
 ui/console-vc.c          |  7 ++-----
 ui/dbus-chardev.c        |  6 ++----
 ui/gtk.c                 |  9 +++------
 ui/spice-app.c           | 10 +++-------
 ui/vdagent.c             |  3 +--
 26 files changed, 81 insertions(+), 132 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 6b81c97d10..58b74dc98d 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -642,10 +642,7 @@ static void char_braille_finalize(Object *obj)
     }
 }
 
-static void baum_chr_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
+static void baum_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     BaumChardev *baum = BAUM_CHARDEV(chr);
     brlapi_handle_t *handle;
@@ -670,6 +667,8 @@ static void baum_chr_open(Chardev *chr,
      * as an integer, but in practice it seems to work
      */
     qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 static void char_braille_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-console.c b/chardev/char-console.c
index f3ef1a7748..423f0f4cc4 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -26,12 +26,11 @@
 #include "chardev/char-win.h"
 #include "qemu/module.h"
 
-static void console_chr_open(Chardev *chr,
-                             ChardevBackend *backend,
-                             bool *be_opened,
+static void console_chr_open(Chardev *chr, ChardevBackend *backend,
                              Error **errp)
 {
     win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 static void char_console_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 568600bb7c..34ef386abc 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -34,10 +34,7 @@
 #include "chardev/char-fd.h"
 #endif
 
-static void file_chr_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
+static void file_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevFile *file = backend->u.file.data;
 #ifdef _WIN32
@@ -100,6 +97,8 @@ static void file_chr_open(Chardev *chr,
         return;
     }
 #endif
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 static void file_chr_parse(QemuOpts *opts, ChardevBackend *backend,
diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index 11556dfa72..aa6058c2f6 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -203,10 +203,7 @@ static void hub_chr_update_read_handlers(Chardev *chr)
     }
 }
 
-static void hub_chr_open(Chardev *chr,
-                         ChardevBackend *backend,
-                         bool *be_opened,
-                         Error **errp)
+static void hub_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHub *hub = backend->u.hub.data;
     HubChardev *d = HUB_CHARDEV(chr);
@@ -241,8 +238,10 @@ static void hub_chr_open(Chardev *chr,
         list = list->next;
     }
 
-    /* Closed until an explicit event from backend */
-    *be_opened = false;
+    /*
+     * Closed until an explicit event from backend, so we don't
+     * send CHR_EVENT_OPENED now.
+     */
 }
 
 static void hub_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index f38d66b21f..7210df431f 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -361,10 +361,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
-static void mux_chr_open(Chardev *chr,
-                         ChardevBackend *backend,
-                         bool *be_opened,
-                         Error **errp)
+static void mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevMux *mux = backend->u.mux.data;
     Chardev *drv;
@@ -377,11 +374,17 @@ static void mux_chr_open(Chardev *chr,
     }
 
     d->focus = -1;
-    /* only default to opened state if we've realized the initial
-     * set of muxes
+    if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
+        return;
+    }
+
+    /*
+     * Only move to opened state if we've realized
+     * the initial set of muxes:
      */
-    *be_opened = muxes_opened;
-    qemu_chr_fe_init(&d->chr, drv, errp);
+    if (muxes_opened) {
+        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    }
 }
 
 static void mux_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/chardev/char-null.c b/chardev/char-null.c
index 674603b380..900b5febb6 100644
--- a/chardev/char-null.c
+++ b/chardev/char-null.c
@@ -26,12 +26,9 @@
 #include "chardev/char.h"
 #include "qemu/module.h"
 
-static void null_chr_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
+static void null_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
-    *be_opened = false;
+    /* do not send CHR_EVENT_OPENED */
 }
 
 static void char_null_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 1be1ef4629..359efa3c9c 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -157,10 +157,7 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void parallel_chr_open_fd(Chardev *chr,
-                                int fd,
-                                bool *be_opened,
-                                Error **errp)
+static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
 {
     ParallelChardev *drv = PARALLEL_CHARDEV(chr);
 
@@ -172,6 +169,7 @@ static void parallel_chr_open_fd(Chardev *chr,
     }
 
     drv->mode = IEEE1284_MODE_COMPAT;
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 #endif /* __linux__ */
 
@@ -227,21 +225,16 @@ static int parallel_chr_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void parallel_chr_open_fd(Chardev *chr,
-                                int fd,
-                                bool *be_opened,
-                                Error **errp)
+static void parallel_chr_open_fd(Chardev *chr, int fd, Error **errp)
 {
     ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     drv->fd = fd;
-    *be_opened = false;
 }
 #endif
 
 #ifdef HAVE_CHARDEV_PARALLEL
 static void parallel_chr_open(Chardev *chr,
                               ChardevBackend *backend,
-                              bool *be_opened,
                               Error **errp)
 {
     ChardevHostdev *parallel = backend->u.parallel.data;
@@ -251,7 +244,7 @@ static void parallel_chr_open(Chardev *chr,
     if (fd < 0) {
         return;
     }
-    parallel_chr_open_fd(chr, fd, be_opened, errp);
+    parallel_chr_open_fd(chr, fd, errp);
 }
 
 static void parallel_chr_parse(QemuOpts *opts, ChardevBackend *backend,
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index e84492d42b..2f26372dfc 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -103,10 +103,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
     return -1;
 }
 
-static void pipe_chr_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
+static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     const char *filename = opts->device;
@@ -114,14 +111,13 @@ static void pipe_chr_open(Chardev *chr,
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
         return;
     }
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 #else
 
-static void pipe_chr_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
+static void pipe_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     int fd_in, fd_out;
@@ -158,6 +154,8 @@ static void pipe_chr_open(Chardev *chr,
         }
         return;
     }
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 #endif /* !_WIN32 */
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 909ab01f5f..d4d69a29a9 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -331,10 +331,7 @@ static int qemu_openpty_raw(int *aslave, char *pty_name)
     return amaster;
 }
 
-static void pty_chr_open(Chardev *chr,
-                         ChardevBackend *backend,
-                         bool *be_opened,
-                         Error **errp)
+static void pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     PtyChardev *s;
     int master_fd, slave_fd;
@@ -364,7 +361,6 @@ static void pty_chr_open(Chardev *chr,
     qio_channel_set_name(s->ioc, name);
     g_free(name);
     s->timer_src = NULL;
-    *be_opened = false;
 
     /* create symbolic link */
     if (path) {
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 19652fe2b3..30b17a96d3 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -94,7 +94,6 @@ static void char_ringbuf_finalize(Object *obj)
 
 static void ringbuf_chr_open(Chardev *chr,
                              ChardevBackend *backend,
-                             bool *be_opened,
                              Error **errp)
 {
     ChardevRingbuf *opts = backend->u.ringbuf.data;
@@ -111,6 +110,8 @@ static void ringbuf_chr_open(Chardev *chr,
     d->prod = 0;
     d->cons = 0;
     d->cbuf = g_malloc0(d->size);
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 void qmp_ringbuf_write(const char *device, const char *data,
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 54c2b3935c..9995f18425 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -41,14 +41,15 @@
 
 #ifdef _WIN32
 
-static void serial_chr_open(Chardev *chr,
-                            ChardevBackend *backend,
-                            bool *be_opened,
-                            Error **errp)
+static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
+    int ret = win_chr_serial_init(chr, serial->device, errp);
+    if (ret < 0) {
+        return;
+    }
 
-    win_chr_serial_init(chr, serial->device, errp);
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
@@ -258,10 +259,7 @@ static int serial_chr_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void serial_chr_open(Chardev *chr,
-                            ChardevBackend *backend,
-                            bool *be_opened,
-                            Error **errp)
+static void serial_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
     int fd;
@@ -281,6 +279,8 @@ static void serial_chr_open(Chardev *chr,
         close(fd);
         return;
     }
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 #endif /* __linux__ || __sun__ */
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 329cd9f0a8..3f57ef4016 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1365,10 +1365,7 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
 }
 
 
-static void tcp_chr_open(Chardev *chr,
-                         ChardevBackend *backend,
-                         bool *be_opened,
-                         Error **errp)
+static void tcp_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     ChardevSocket *sock = backend->u.socket.data;
@@ -1439,9 +1436,6 @@ static void tcp_chr_open(Chardev *chr,
     }
     s->registered_yank = true;
 
-    /* be isn't opened until we get a connection */
-    *be_opened = false;
-
     update_disconnected_filename(s);
 
     if (s->is_listen) {
@@ -1454,6 +1448,8 @@ static void tcp_chr_open(Chardev *chr,
             return;
         }
     }
+
+    /* be isn't opened until we get a connection */
 }
 
 static void tcp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index f0920a23fa..534f6ed565 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -85,10 +85,7 @@ static void term_stdio_handler(int sig)
     stdio_chr_set_echo(NULL, stdio_echo_state);
 }
 
-static void stdio_chr_open(Chardev *chr,
-                           ChardevBackend *backend,
-                           bool *be_opened,
-                           Error **errp)
+static void stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
@@ -123,6 +120,8 @@ static void stdio_chr_open(Chardev *chr,
 
     stdio_allow_signal = !opts->has_signal || opts->signal;
     stdio_chr_set_echo(chr, false);
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 #endif
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 099f76b8c2..b835a967e1 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -188,10 +188,7 @@ static void udp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
     }
 }
 
-static void upd_chr_open(Chardev *chr,
-                         ChardevBackend *backend,
-                         bool *be_opened,
-                         Error **errp)
+static void upd_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevUdp *udp = backend->u.udp.data;
     SocketAddress *local_addr = socket_address_flatten(udp->local);
@@ -215,7 +212,6 @@ static void upd_chr_open(Chardev *chr,
 
     s->ioc = QIO_CHANNEL(sioc);
     /* be isn't opened until we get a connection */
-    *be_opened = false;
 }
 
 static void char_udp_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 866f3a2039..0535960ff1 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -144,7 +144,6 @@ static void win_stiod_chr_set_echo(Chardev *chr, bool echo)
 
 static void win_stdio_chr_open(Chardev *chr,
                                ChardevBackend *backend,
-                               bool *be_opened,
                                Error **errp)
 {
     ChardevStdio *opts = backend->u.stdio.data;
@@ -208,6 +207,7 @@ static void win_stdio_chr_open(Chardev *chr,
 
     win_stiod_chr_set_echo(chr, false);
 
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return;
 
 err3:
diff --git a/chardev/char.c b/chardev/char.c
index df37d1df16..44bfed3627 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -246,8 +246,7 @@ int qemu_chr_add_client(Chardev *s, int fd)
         CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
 
-static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
-                           bool *be_opened, Error **errp)
+static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
     /* Any ChardevCommon member would work */
@@ -268,7 +267,7 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
     }
 
     if (cc->chr_open) {
-        cc->chr_open(chr, backend, be_opened, errp);
+        cc->chr_open(chr, backend, errp);
     }
 }
 
@@ -1009,7 +1008,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
     Object *obj;
     Chardev *chr = NULL;
     Error *local_err = NULL;
-    bool be_opened = true;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1020,7 +1018,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
     chr->label = g_strdup(id);
     chr->gcontext = gcontext;
 
-    qemu_char_open(chr, backend, &be_opened, &local_err);
+    qemu_char_open(chr, backend, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         object_unref(obj);
@@ -1030,9 +1028,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
     if (!chr->filename) {
         chr->filename = g_strdup(typename + 8);
     }
-    if (be_opened) {
-        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-    }
 
     return chr;
 }
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index d07cd998cb..9dc04e3b3e 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -255,16 +255,16 @@ static void char_msmouse_finalize(Object *obj)
 
 static void msmouse_chr_open(Chardev *chr,
                              ChardevBackend *backend,
-                             bool *be_opened,
                              Error **errp)
 {
     MouseChardev *mouse = MOUSE_CHARDEV(chr);
 
-    *be_opened = false;
     mouse->hs = qemu_input_handler_register((DeviceState *)mouse,
                                             &msmouse_handler);
     mouse->tiocm = 0;
     fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
+
+    /* Never send CHR_EVENT_OPENED */
 }
 
 static void char_msmouse_class_init(ObjectClass *oc, const void *data)
diff --git a/chardev/spice.c b/chardev/spice.c
index 800784da26..612f358885 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -251,9 +251,7 @@ static void chr_open(Chardev *chr, const char *subtype)
     s->sin.subtype = g_strdup(subtype);
 }
 
-static void spice_vmc_chr_open(Chardev *chr,
-                               ChardevBackend *backend,
-                               bool *be_opened,
+static void spice_vmc_chr_open(Chardev *chr, ChardevBackend *backend,
                                Error **errp)
 {
     ChardevSpiceChannel *spicevmc = backend->u.spicevmc.data;
@@ -277,19 +275,17 @@ static void spice_vmc_chr_open(Chardev *chr,
         return;
     }
 
-    *be_opened = false;
 #if SPICE_SERVER_VERSION < 0x000e02
     /* Spice < 0.14.2 doesn't explicitly open smartcard chardev */
     if (strcmp(type, "smartcard") == 0) {
-        *be_opened = true;
+        chr_open(chr, type);
+        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     }
 #endif
     chr_open(chr, type);
 }
 
-static void spice_port_chr_open(Chardev *chr,
-                                ChardevBackend *backend,
-                                bool *be_opened,
+static void spice_port_chr_open(Chardev *chr, ChardevBackend *backend,
                                 Error **errp)
 {
     ChardevSpicePort *spiceport = backend->u.spiceport.data;
@@ -308,7 +304,6 @@ static void spice_port_chr_open(Chardev *chr,
 
     chr_open(chr, "port");
 
-    *be_opened = false;
     s = SPICE_CHARDEV(chr);
     s->sin.portname = g_strdup(name);
 
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 8285a56e7b..65b2ceb58c 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -326,13 +326,10 @@ static void wctablet_chr_finalize(Object *obj)
 
 static void wctablet_chr_open(Chardev *chr,
                               ChardevBackend *backend,
-                              bool *be_opened,
                               Error **errp)
 {
     TabletChardev *tablet = WCTABLET_CHARDEV(chr);
 
-    *be_opened = true;
-
     /* init state machine */
     memcpy(tablet->outbuf, WC_FULL_CONFIG_STRING, WC_FULL_CONFIG_STRING_LENGTH);
     tablet->outlen = WC_FULL_CONFIG_STRING_LENGTH;
@@ -340,6 +337,8 @@ static void wctablet_chr_open(Chardev *chr,
 
     tablet->hs = qemu_input_handler_register((DeviceState *)tablet,
                                              &wctablet_handler);
+
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 static void wctablet_chr_class_init(ObjectClass *oc, const void *data)
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 61b2b4b8da..49da1f73cc 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -233,10 +233,9 @@ static int gdb_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
-static void gdb_chr_open(Chardev *chr, ChardevBackend *backend,
-                             bool *be_opened, Error **errp)
+static void gdb_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
-    *be_opened = false;
+    /* Never send CHR_EVENT_OPENED */
 }
 
 static void char_gdb_class_init(ObjectClass *oc, const void *data)
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 2baf2a8a1a..47c75c3582 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -260,8 +260,7 @@ struct ChardevClass {
     void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
     /* called after construction, open/starts the backend */
-    void (*chr_open)(Chardev *chr, ChardevBackend *backend,
-                 bool *be_opened, Error **errp);
+    void (*chr_open)(Chardev *chr, ChardevBackend *backend, Error **errp);
 
     /* write buf to the backend */
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 931068d43a..4c8ea4c148 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1093,10 +1093,7 @@ void qemu_text_console_update_size(QemuTextConsole *c)
     dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
 }
 
-static void vc_chr_open(Chardev *chr,
-                        ChardevBackend *backend,
-                        bool *be_opened,
-                        Error **errp)
+static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
     VCChardev *drv = VC_CHARDEV(chr);
@@ -1144,7 +1141,7 @@ static void vc_chr_open(Chardev *chr,
         drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
-    *be_opened = true;
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index f6c426e220..3e471f84cd 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -176,9 +176,7 @@ dbus_chr_send_break(
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
-static void
-dbus_chr_open(Chardev *chr, ChardevBackend *backend,
-              bool *be_opened, Error **errp)
+static void dbus_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ERRP_GUARD();
 
@@ -211,7 +209,7 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
         return;
     }
     CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
-        chr, be, be_opened, errp);
+        chr, be, errp);
 }
 
 static void
diff --git a/ui/gtk.c b/ui/gtk.c
index b5498a7ce3..3eeb5baa11 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1963,10 +1963,7 @@ static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 
 static int nb_vcs;
 static Chardev *vcs[MAX_VCS];
-static void gd_vc_chr_open(Chardev *chr,
-                       ChardevBackend *backend,
-                       bool *be_opened,
-                       Error **errp)
+static void gd_vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     if (nb_vcs == MAX_VCS) {
         error_setg(errp, "Maximum number of consoles reached");
@@ -1975,10 +1972,10 @@ static void gd_vc_chr_open(Chardev *chr,
 
     vcs[nb_vcs++] = chr;
 
-    /* console/chardev init sometimes completes elsewhere in a 2nd
+    /*
+     * console/chardev init sometimes completes elsewhere in a 2nd
      * stage, so defer OPENED events until they are fully initialized
      */
-    *be_opened = false;
 }
 
 static void char_gd_vc_class_init(ObjectClass *oc, const void *data)
diff --git a/ui/spice-app.c b/ui/spice-app.c
index ea0b62a22b..7ac9ae4e78 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -49,8 +49,7 @@ struct VCChardev {
 
 struct VCChardevClass {
     ChardevClass parent;
-    void (*parent_open)(Chardev *chr, ChardevBackend *backend,
-                        bool *be_opened, Error **errp);
+    void (*parent_open)(Chardev *chr, ChardevBackend *backend, Error **errp);
 };
 
 #define TYPE_CHARDEV_VC "chardev-vc"
@@ -67,10 +66,7 @@ chr_spice_backend_new(void)
     return be;
 }
 
-static void vc_chr_open(Chardev *chr,
-                        ChardevBackend *backend,
-                        bool *be_opened,
-                        Error **errp)
+static void vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     VCChardevClass *vc = CHARDEV_VC_GET_CLASS(chr);
     ChardevBackend *be;
@@ -87,7 +83,7 @@ static void vc_chr_open(Chardev *chr,
     be = chr_spice_backend_new();
     be->u.spiceport.data->fqdn = fqdn ?
         g_strdup(fqdn) : g_strdup_printf("org.qemu.console.%s", chr->label);
-    vc->parent_open(chr, be, be_opened, errp);
+    vc->parent_open(chr, be, errp);
     qapi_free_ChardevBackend(be);
 }
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 9972a9c476..3becc6c076 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -662,7 +662,6 @@ static void vdagent_chr_recv_clipboard(VDAgentChardev *vd, VDAgentMessage *msg)
 
 static void vdagent_chr_open(Chardev *chr,
                              ChardevBackend *backend,
-                             bool *be_opened,
                              Error **errp)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(chr);
@@ -692,7 +691,7 @@ static void vdagent_chr_open(Chardev *chr,
                                                    &vdagent_mouse_handler);
     }
 
-    *be_opened = true;
+    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
 static void vdagent_clipboard_peer_register(VDAgentChardev *vd)
-- 
2.48.1


