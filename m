Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C074D216A5
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRBUC-0006aV-3O; Thu, 04 Dec 2025 10:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTl-0006Qy-QS
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:51 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRBTf-0007ET-VA
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:42:48 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A66FF808DF;
 Thu, 04 Dec 2025 18:42:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id agnhnW0F9Gk0-6wRjCOnE; Thu, 04 Dec 2025 18:42:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764862961;
 bh=akmt9XxtO+1GFsZWuvYrbsOghtVMPH7mOzw4eMsnnS0=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=ODXRFVg+4I5zS5cYxL4LcqXIEvVXq/Ed8oobtSTkL70eixCJ5ZYIkxYE2VbOyw84U
 GPsF0pfVZKk+m5Ru+EIrDuI+C74RSCEpdKHUNTWQ58glVdRHZSGfRRzBEw3yr7wH6d
 0DylHdH1m9Z+o9u4xqB33Gy1xZisGCv2eAVcrJjE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 04/10] chardev: consistent naming for ChardevClass handlers
 implementations
Date: Thu,  4 Dec 2025 18:42:28 +0300
Message-ID: <20251204154235.149575-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251204154235.149575-1-vsementsov@yandex-team.ru>
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Most handlers implementations has name like {unit_name}_{handler_name},
which is usual and well-recognized pattern. Convert the rest (especially
with useless qemu_ prefixes and misleading qmp_ prefixes) to the common
pattern.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char-console.c                        | 10 ++---
 chardev/char-file.c                           | 16 ++++----
 chardev/char-hub.c                            | 15 ++++---
 chardev/char-mux.c                            | 15 ++++---
 chardev/char-parallel.c                       | 28 ++++++-------
 chardev/char-pipe.c                           | 24 +++++------
 chardev/char-pty.c                            | 19 +++++----
 chardev/char-ringbuf.c                        | 16 ++++----
 chardev/char-serial.c                         | 28 ++++++-------
 chardev/char-socket.c                         | 25 ++++++------
 chardev/char-stdio.c                          | 22 +++++-----
 chardev/char-udp.c                            | 15 ++++---
 chardev/char-win-stdio.c                      | 20 +++++-----
 chardev/msmouse.c                             |  4 +-
 chardev/spice.c                               | 40 +++++++++----------
 gdbstub/system.c                              |  8 ++--
 .../codeconverter/test_regexps.py             |  2 +-
 ui/gtk.c                                      |  4 +-
 18 files changed, 153 insertions(+), 158 deletions(-)

diff --git a/chardev/char-console.c b/chardev/char-console.c
index 9a2e012d53..f3ef1a7748 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -26,10 +26,10 @@
 #include "chardev/char-win.h"
 #include "qemu/module.h"
 
-static void qemu_chr_open_win_con(Chardev *chr,
-                                  ChardevBackend *backend,
-                                  bool *be_opened,
-                                  Error **errp)
+static void console_chr_open(Chardev *chr,
+                             ChardevBackend *backend,
+                             bool *be_opened,
+                             Error **errp)
 {
     win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
 }
@@ -38,7 +38,7 @@ static void char_console_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_open = qemu_chr_open_win_con;
+    cc->chr_open = console_chr_open;
 }
 
 static const TypeInfo char_console_type_info = {
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 1e293e7054..568600bb7c 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -34,10 +34,10 @@
 #include "chardev/char-fd.h"
 #endif
 
-static void qmp_chardev_open_file(Chardev *chr,
-                                  ChardevBackend *backend,
-                                  bool *be_opened,
-                                  Error **errp)
+static void file_chr_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
 {
     ChardevFile *file = backend->u.file.data;
 #ifdef _WIN32
@@ -102,8 +102,8 @@ static void qmp_chardev_open_file(Chardev *chr,
 #endif
 }
 
-static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
-                                    Error **errp)
+static void file_chr_parse(QemuOpts *opts, ChardevBackend *backend,
+                           Error **errp)
 {
     const char *path = qemu_opt_get(opts, "path");
     const char *inpath = qemu_opt_get(opts, "input-path");
@@ -133,8 +133,8 @@ static void char_file_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_file_out;
-    cc->chr_open = qmp_chardev_open_file;
+    cc->chr_parse = file_chr_parse;
+    cc->chr_open = file_chr_open;
 }
 
 static const TypeInfo char_file_type_info = {
diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index 082baa84ab..11556dfa72 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -203,10 +203,10 @@ static void hub_chr_update_read_handlers(Chardev *chr)
     }
 }
 
-static void qemu_chr_open_hub(Chardev *chr,
-                                 ChardevBackend *backend,
-                                 bool *be_opened,
-                                 Error **errp)
+static void hub_chr_open(Chardev *chr,
+                         ChardevBackend *backend,
+                         bool *be_opened,
+                         Error **errp)
 {
     ChardevHub *hub = backend->u.hub.data;
     HubChardev *d = HUB_CHARDEV(chr);
@@ -245,8 +245,7 @@ static void qemu_chr_open_hub(Chardev *chr,
     *be_opened = false;
 }
 
-static void qemu_chr_parse_hub(QemuOpts *opts, ChardevBackend *backend,
-                                  Error **errp)
+static void hub_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     ChardevHub *hub;
     strList **tail;
@@ -276,8 +275,8 @@ static void char_hub_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_hub;
-    cc->chr_open = qemu_chr_open_hub;
+    cc->chr_parse = hub_chr_parse;
+    cc->chr_open = hub_chr_open;
     cc->chr_write = hub_chr_write;
     cc->chr_add_watch = hub_chr_add_watch;
     /* We handle events from backends only */
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index c82c2da56d..f38d66b21f 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -361,10 +361,10 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
-static void qemu_chr_open_mux(Chardev *chr,
-                              ChardevBackend *backend,
-                              bool *be_opened,
-                              Error **errp)
+static void mux_chr_open(Chardev *chr,
+                         ChardevBackend *backend,
+                         bool *be_opened,
+                         Error **errp)
 {
     ChardevMux *mux = backend->u.mux.data;
     Chardev *drv;
@@ -384,8 +384,7 @@ static void qemu_chr_open_mux(Chardev *chr,
     qemu_chr_fe_init(&d->chr, drv, errp);
 }
 
-static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
-                               Error **errp)
+static void mux_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     const char *chardev = qemu_opt_get(opts, "chardev");
     ChardevMux *mux;
@@ -451,8 +450,8 @@ static void char_mux_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_mux;
-    cc->chr_open = qemu_chr_open_mux;
+    cc->chr_parse = mux_chr_parse;
+    cc->chr_open = mux_chr_open;
     cc->chr_write = mux_chr_write;
     cc->chr_accept_input = mux_chr_accept_input;
     cc->chr_add_watch = mux_chr_add_watch;
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index a0839b784b..1be1ef4629 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -70,7 +70,7 @@ static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
     return 1;
 }
 
-static int pp_ioctl(Chardev *chr, int cmd, void *arg)
+static int parallel_chr_ioctl(Chardev *chr, int cmd, void *arg)
 {
     ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     int fd = drv->fd;
@@ -157,7 +157,7 @@ static int pp_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void qemu_chr_open_pp_fd(Chardev *chr,
+static void parallel_chr_open_fd(Chardev *chr,
                                 int fd,
                                 bool *be_opened,
                                 Error **errp)
@@ -185,7 +185,7 @@ typedef struct {
 #define PARALLEL_CHARDEV(obj)                                   \
     OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
 
-static int pp_ioctl(Chardev *chr, int cmd, void *arg)
+static int parallel_chr_ioctl(Chardev *chr, int cmd, void *arg)
 {
     ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     uint8_t b;
@@ -227,7 +227,7 @@ static int pp_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void qemu_chr_open_pp_fd(Chardev *chr,
+static void parallel_chr_open_fd(Chardev *chr,
                                 int fd,
                                 bool *be_opened,
                                 Error **errp)
@@ -239,10 +239,10 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
 #endif
 
 #ifdef HAVE_CHARDEV_PARALLEL
-static void qmp_chardev_open_parallel(Chardev *chr,
-                                      ChardevBackend *backend,
-                                      bool *be_opened,
-                                      Error **errp)
+static void parallel_chr_open(Chardev *chr,
+                              ChardevBackend *backend,
+                              bool *be_opened,
+                              Error **errp)
 {
     ChardevHostdev *parallel = backend->u.parallel.data;
     int fd;
@@ -251,11 +251,11 @@ static void qmp_chardev_open_parallel(Chardev *chr,
     if (fd < 0) {
         return;
     }
-    qemu_chr_open_pp_fd(chr, fd, be_opened, errp);
+    parallel_chr_open_fd(chr, fd, be_opened, errp);
 }
 
-static void qemu_chr_parse_parallel(QemuOpts *opts, ChardevBackend *backend,
-                                    Error **errp)
+static void parallel_chr_parse(QemuOpts *opts, ChardevBackend *backend,
+                               Error **errp)
 {
     const char *device = qemu_opt_get(opts, "path");
     ChardevHostdev *parallel;
@@ -274,9 +274,9 @@ static void char_parallel_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_parallel;
-    cc->chr_open = qmp_chardev_open_parallel;
-    cc->chr_ioctl = pp_ioctl;
+    cc->chr_parse = parallel_chr_parse;
+    cc->chr_open = parallel_chr_open;
+    cc->chr_ioctl = parallel_chr_ioctl;
 }
 
 static void char_parallel_finalize(Object *obj)
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index a2cd322efe..e84492d42b 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -103,10 +103,10 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
     return -1;
 }
 
-static void qemu_chr_open_pipe(Chardev *chr,
-                               ChardevBackend *backend,
-                               bool *be_opened,
-                               Error **errp)
+static void pipe_chr_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     const char *filename = opts->device;
@@ -118,10 +118,10 @@ static void qemu_chr_open_pipe(Chardev *chr,
 
 #else
 
-static void qemu_chr_open_pipe(Chardev *chr,
-                               ChardevBackend *backend,
-                               bool *be_opened,
-                               Error **errp)
+static void pipe_chr_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     int fd_in, fd_out;
@@ -162,8 +162,8 @@ static void qemu_chr_open_pipe(Chardev *chr,
 
 #endif /* !_WIN32 */
 
-static void qemu_chr_parse_pipe(QemuOpts *opts, ChardevBackend *backend,
-                                Error **errp)
+static void pipe_chr_parse(QemuOpts *opts, ChardevBackend *backend,
+                           Error **errp)
 {
     const char *device = qemu_opt_get(opts, "path");
     ChardevHostdev *dev;
@@ -182,8 +182,8 @@ static void char_pipe_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_pipe;
-    cc->chr_open = qemu_chr_open_pipe;
+    cc->chr_parse = pipe_chr_parse;
+    cc->chr_open = pipe_chr_open;
 }
 
 static const TypeInfo char_pipe_type_info = {
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 1a15082b02..909ab01f5f 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -105,7 +105,7 @@ static void pty_chr_update_read_handler(Chardev *chr)
     }
 }
 
-static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static int pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     PtyChardev *s = PTY_CHARDEV(chr);
     GPollFD pfd;
@@ -331,10 +331,10 @@ static int qemu_openpty_raw(int *aslave, char *pty_name)
     return amaster;
 }
 
-static void char_pty_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
+static void pty_chr_open(Chardev *chr,
+                         ChardevBackend *backend,
+                         bool *be_opened,
+                         Error **errp)
 {
     PtyChardev *s;
     int master_fd, slave_fd;
@@ -378,8 +378,7 @@ static void char_pty_open(Chardev *chr,
     }
 }
 
-static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
-                           Error **errp)
+static void pty_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     const char *path = qemu_opt_get(opts, "path");
     ChardevPty *pty;
@@ -394,9 +393,9 @@ static void char_pty_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = char_pty_parse;
-    cc->chr_open = char_pty_open;
-    cc->chr_write = char_pty_chr_write;
+    cc->chr_parse = pty_chr_parse;
+    cc->chr_open = pty_chr_open;
+    cc->chr_write = pty_chr_write;
     cc->chr_update_read_handler = pty_chr_update_read_handler;
     cc->chr_add_watch = pty_chr_add_watch;
 }
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 6d5ba667bb..19652fe2b3 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -92,10 +92,10 @@ static void char_ringbuf_finalize(Object *obj)
     g_free(d->cbuf);
 }
 
-static void qemu_chr_open_ringbuf(Chardev *chr,
-                                  ChardevBackend *backend,
-                                  bool *be_opened,
-                                  Error **errp)
+static void ringbuf_chr_open(Chardev *chr,
+                             ChardevBackend *backend,
+                             bool *be_opened,
+                             Error **errp)
 {
     ChardevRingbuf *opts = backend->u.ringbuf.data;
     RingBufChardev *d = RINGBUF_CHARDEV(chr);
@@ -206,8 +206,8 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
     return data;
 }
 
-static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
-                                   Error **errp)
+static void ringbuf_chr_parse(QemuOpts *opts, ChardevBackend *backend,
+                              Error **errp)
 {
     int val;
     ChardevRingbuf *ringbuf;
@@ -227,8 +227,8 @@ static void char_ringbuf_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_ringbuf;
-    cc->chr_open = qemu_chr_open_ringbuf;
+    cc->chr_parse = ringbuf_chr_parse;
+    cc->chr_open = ringbuf_chr_open;
     cc->chr_write = ringbuf_chr_write;
 }
 
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 97ed7adf73..54c2b3935c 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -41,10 +41,10 @@
 
 #ifdef _WIN32
 
-static void qmp_chardev_open_serial(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
+static void serial_chr_open(Chardev *chr,
+                            ChardevBackend *backend,
+                            bool *be_opened,
+                            Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
 
@@ -176,7 +176,7 @@ static void tty_serial_init(int fd, int speed,
     tcsetattr(fd, TCSANOW, &tty);
 }
 
-static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
+static int serial_chr_ioctl(Chardev *chr, int cmd, void *arg)
 {
     FDChardev *s = FD_CHARDEV(chr);
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc_in);
@@ -258,10 +258,10 @@ static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static void qmp_chardev_open_serial(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
+static void serial_chr_open(Chardev *chr,
+                            ChardevBackend *backend,
+                            bool *be_opened,
+                            Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
     int fd;
@@ -285,8 +285,8 @@ static void qmp_chardev_open_serial(Chardev *chr,
 #endif /* __linux__ || __sun__ */
 
 #ifdef HAVE_CHARDEV_SERIAL
-static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backend,
-                                  Error **errp)
+static void serial_chr_parse(QemuOpts *opts, ChardevBackend *backend,
+                             Error **errp)
 {
     const char *device = qemu_opt_get(opts, "path");
     ChardevHostdev *serial;
@@ -305,10 +305,10 @@ static void char_serial_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_serial;
-    cc->chr_open = qmp_chardev_open_serial;
+    cc->chr_parse = serial_chr_parse;
+    cc->chr_open = serial_chr_open;
 #ifndef _WIN32
-    cc->chr_ioctl = tty_serial_ioctl;
+    cc->chr_ioctl = serial_chr_ioctl;
 #endif
 }
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 12916af7ff..329cd9f0a8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -222,7 +222,7 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
     *size = j;
 }
 
-static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
+static int tcp_chr_get_msgfds(Chardev *chr, int *fds, int num)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
@@ -248,7 +248,7 @@ static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
     return to_copy;
 }
 
-static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
+static int tcp_chr_set_msgfds(Chardev *chr, int *fds, int num)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
@@ -367,7 +367,7 @@ static void tcp_chr_free_connection(Chardev *chr)
 
     remove_hup_source(s);
 
-    tcp_set_msgfds(chr, NULL, 0);
+    tcp_chr_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
     if (s->registered_yank &&
         (s->state == TCP_CHARDEV_STATE_CONNECTING
@@ -1365,10 +1365,10 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
 }
 
 
-static void qmp_chardev_open_socket(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
+static void tcp_chr_open(Chardev *chr,
+                         ChardevBackend *backend,
+                         bool *be_opened,
+                         Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     ChardevSocket *sock = backend->u.socket.data;
@@ -1456,8 +1456,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     }
 }
 
-static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
-                                  Error **errp)
+static void tcp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     const char *path = qemu_opt_get(opts, "path");
     const char *host = qemu_opt_get(opts, "host");
@@ -1576,14 +1575,14 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
 
     cc->supports_yank = true;
 
-    cc->chr_parse = qemu_chr_parse_socket;
-    cc->chr_open = qmp_chardev_open_socket;
+    cc->chr_parse = tcp_chr_parse;
+    cc->chr_open = tcp_chr_open;
     cc->chr_wait_connected = tcp_chr_wait_connected;
     cc->chr_write = tcp_chr_write;
     cc->chr_sync_read = tcp_chr_sync_read;
     cc->chr_disconnect = tcp_chr_disconnect;
-    cc->chr_get_msgfds = tcp_get_msgfds;
-    cc->chr_set_msgfds = tcp_set_msgfds;
+    cc->chr_get_msgfds = tcp_chr_get_msgfds;
+    cc->chr_set_msgfds = tcp_chr_set_msgfds;
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index b7e9af1388..f0920a23fa 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -56,7 +56,7 @@ static void term_exit(void)
     }
 }
 
-static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
+static void stdio_chr_set_echo(Chardev *chr, bool echo)
 {
     struct termios tty;
 
@@ -82,13 +82,13 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
 static void term_stdio_handler(int sig)
 {
     /* restore echo after resume from suspend. */
-    qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
+    stdio_chr_set_echo(NULL, stdio_echo_state);
 }
 
-static void qemu_chr_open_stdio(Chardev *chr,
-                                ChardevBackend *backend,
-                                bool *be_opened,
-                                Error **errp)
+static void stdio_chr_open(Chardev *chr,
+                           ChardevBackend *backend,
+                           bool *be_opened,
+                           Error **errp)
 {
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
@@ -122,11 +122,11 @@ static void qemu_chr_open_stdio(Chardev *chr,
     sigaction(SIGCONT, &act, NULL);
 
     stdio_allow_signal = !opts->has_signal || opts->signal;
-    qemu_chr_set_echo_stdio(chr, false);
+    stdio_chr_set_echo(chr, false);
 }
 #endif
 
-static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend,
+static void stdio_chr_parse(QemuOpts *opts, ChardevBackend *backend,
                                  Error **errp)
 {
     ChardevStdio *stdio;
@@ -142,10 +142,10 @@ static void char_stdio_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_stdio;
+    cc->chr_parse = stdio_chr_parse;
 #ifndef _WIN32
-    cc->chr_open = qemu_chr_open_stdio;
-    cc->chr_set_echo = qemu_chr_set_echo_stdio;
+    cc->chr_open = stdio_chr_open;
+    cc->chr_set_echo = stdio_chr_set_echo;
 #endif
 }
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index a6f496ac7b..099f76b8c2 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -131,8 +131,7 @@ static void char_udp_finalize(Object *obj)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
-                               Error **errp)
+static void udp_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
@@ -189,10 +188,10 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
     }
 }
 
-static void qmp_chardev_open_udp(Chardev *chr,
-                                 ChardevBackend *backend,
-                                 bool *be_opened,
-                                 Error **errp)
+static void upd_chr_open(Chardev *chr,
+                         ChardevBackend *backend,
+                         bool *be_opened,
+                         Error **errp)
 {
     ChardevUdp *udp = backend->u.udp.data;
     SocketAddress *local_addr = socket_address_flatten(udp->local);
@@ -223,8 +222,8 @@ static void char_udp_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_udp;
-    cc->chr_open = qmp_chardev_open_udp;
+    cc->chr_parse = udp_chr_parse;
+    cc->chr_open = upd_chr_open;
     cc->chr_write = udp_chr_write;
     cc->chr_update_read_handler = udp_chr_update_read_handler;
 }
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 26e67aef1c..866f3a2039 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -128,7 +128,7 @@ static void win_stdio_thread_wait_func(void *opaque)
     SetEvent(stdio->hInputDoneEvent);
 }
 
-static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
+static void win_stiod_chr_set_echo(Chardev *chr, bool echo)
 {
     WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
     DWORD              dwMode = 0;
@@ -142,10 +142,10 @@ static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
     }
 }
 
-static void qemu_chr_open_stdio(Chardev *chr,
-                                ChardevBackend *backend,
-                                bool *be_opened,
-                                Error **errp)
+static void win_stdio_chr_open(Chardev *chr,
+                               ChardevBackend *backend,
+                               bool *be_opened,
+                               Error **errp)
 {
     ChardevStdio *opts = backend->u.stdio.data;
     bool stdio_allow_signal = !opts->has_signal || opts->signal;
@@ -206,7 +206,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
 
     SetConsoleMode(stdio->hStdIn, dwMode);
 
-    qemu_chr_set_echo_win_stdio(chr, false);
+    win_stiod_chr_set_echo(chr, false);
 
     return;
 
@@ -237,7 +237,7 @@ static void char_win_stdio_finalize(Object *obj)
     }
 }
 
-static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
+static int win_stdio_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     HANDLE  hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
     DWORD   dwSize;
@@ -260,9 +260,9 @@ static void char_win_stdio_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_open = qemu_chr_open_stdio;
-    cc->chr_write = win_stdio_write;
-    cc->chr_set_echo = qemu_chr_set_echo_win_stdio;
+    cc->chr_open = win_stdio_chr_open;
+    cc->chr_write = win_stdio_chr_write;
+    cc->chr_set_echo = win_stiod_chr_set_echo;
 }
 
 static const TypeInfo char_win_stdio_type_info = {
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 8405016489..d07cd998cb 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -178,7 +178,7 @@ static const QemuInputHandler msmouse_handler = {
     .sync  = msmouse_input_sync,
 };
 
-static int msmouse_ioctl(Chardev *chr, int cmd, void *arg)
+static int msmouse_chr_ioctl(Chardev *chr, int cmd, void *arg)
 {
     MouseChardev *mouse = MOUSE_CHARDEV(chr);
     int c, i, j;
@@ -274,7 +274,7 @@ static void char_msmouse_class_init(ObjectClass *oc, const void *data)
     cc->chr_open = msmouse_chr_open;
     cc->chr_write = msmouse_chr_write;
     cc->chr_accept_input = msmouse_chr_accept_input;
-    cc->chr_ioctl = msmouse_ioctl;
+    cc->chr_ioctl = msmouse_chr_ioctl;
 }
 
 static const TypeInfo char_msmouse_type_info = {
diff --git a/chardev/spice.c b/chardev/spice.c
index 61caa6d0ef..3ea2570665 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -215,7 +215,7 @@ static void char_spice_finalize(Object *obj)
     g_free((char *)s->sin.portname);
 }
 
-static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
+static void spice_vmc_chr_set_fe_open(struct Chardev *chr, int fe_open)
 {
     SpiceChardev *s = SPICE_CHARDEV(chr);
     if (fe_open) {
@@ -225,7 +225,7 @@ static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
     }
 }
 
-static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
+static void spice_port_chr_set_fe_open(struct Chardev *chr, int fe_open)
 {
     SpiceChardev *s = SPICE_CHARDEV(chr);
 
@@ -251,10 +251,10 @@ static void chr_open(Chardev *chr, const char *subtype)
     s->sin.subtype = g_strdup(subtype);
 }
 
-static void qemu_chr_open_spice_vmc(Chardev *chr,
-                                    ChardevBackend *backend,
-                                    bool *be_opened,
-                                    Error **errp)
+static void spice_vmc_chr_open(Chardev *chr,
+                               ChardevBackend *backend,
+                               bool *be_opened,
+                               Error **errp)
 {
     ChardevSpiceChannel *spicevmc = backend->u.spicevmc.data;
     const char *type = spicevmc->type;
@@ -281,10 +281,10 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     chr_open(chr, type);
 }
 
-static void qemu_chr_open_spice_port(Chardev *chr,
-                                     ChardevBackend *backend,
-                                     bool *be_opened,
-                                     Error **errp)
+static void spice_port_chr_open(Chardev *chr,
+                                ChardevBackend *backend,
+                                bool *be_opened,
+                                Error **errp)
 {
     ChardevSpicePort *spiceport = backend->u.spiceport.data;
     const char *name = spiceport->fqdn;
@@ -309,8 +309,8 @@ static void qemu_chr_open_spice_port(Chardev *chr,
     vmc_register_interface(s);
 }
 
-static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend *backend,
-                                     Error **errp)
+static void spice_vmc_chr_parse(QemuOpts *opts, ChardevBackend *backend,
+                                Error **errp)
 {
     const char *name = qemu_opt_get(opts, "name");
     ChardevSpiceChannel *spicevmc;
@@ -325,8 +325,8 @@ static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend *backend,
     spicevmc->type = g_strdup(name);
 }
 
-static void qemu_chr_parse_spice_port(QemuOpts *opts, ChardevBackend *backend,
-                                      Error **errp)
+static void spice_port_chr_parse(QemuOpts *opts, ChardevBackend *backend,
+                                 Error **errp)
 {
     const char *name = qemu_opt_get(opts, "name");
     ChardevSpicePort *spiceport;
@@ -364,9 +364,9 @@ static void char_spicevmc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_spice_vmc;
-    cc->chr_open = qemu_chr_open_spice_vmc;
-    cc->chr_set_fe_open = spice_vmc_set_fe_open;
+    cc->chr_parse = spice_vmc_chr_parse;
+    cc->chr_open = spice_vmc_chr_open;
+    cc->chr_set_fe_open = spice_vmc_chr_set_fe_open;
 }
 
 static const TypeInfo char_spicevmc_type_info = {
@@ -380,9 +380,9 @@ static void char_spiceport_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_parse = qemu_chr_parse_spice_port;
-    cc->chr_open = qemu_chr_open_spice_port;
-    cc->chr_set_fe_open = spice_port_set_fe_open;
+    cc->chr_parse = spice_port_chr_parse;
+    cc->chr_open = spice_port_chr_open;
+    cc->chr_set_fe_open = spice_port_chr_set_fe_open;
 }
 
 static const TypeInfo char_spiceport_type_info = {
diff --git a/gdbstub/system.c b/gdbstub/system.c
index fe2afeb107..61b2b4b8da 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -225,7 +225,7 @@ static void gdb_sigterm_handler(int signal)
 }
 #endif
 
-static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
+static int gdb_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     g_autoptr(GString) hex_buf = g_string_new("O");
     gdb_memtohex(hex_buf, buf, len);
@@ -233,7 +233,7 @@ static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
-static void gdb_monitor_open(Chardev *chr, ChardevBackend *backend,
+static void gdb_chr_open(Chardev *chr, ChardevBackend *backend,
                              bool *be_opened, Error **errp)
 {
     *be_opened = false;
@@ -244,8 +244,8 @@ static void char_gdb_class_init(ObjectClass *oc, const void *data)
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
     cc->internal = true;
-    cc->chr_open = gdb_monitor_open;
-    cc->chr_write = gdb_monitor_write;
+    cc->chr_open = gdb_chr_open;
+    cc->chr_write = gdb_chr_write;
 }
 
 #define TYPE_CHARDEV_GDB "chardev-gdb"
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index d3a5cc3ad3..2b9f5b8011 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -57,7 +57,7 @@ def fullmatch(regexp, s):
 
     print(RE_TYPEINFO_START)
     assert re.search(RE_TYPEINFO_START, r'''
-    cc->chr_open = qmp_chardev_open_file;
+    cc->chr_open = file_chr_open;
 }
 
 static const TypeInfo char_file_type_info = {
diff --git a/ui/gtk.c b/ui/gtk.c
index 7aa97907ed..b5498a7ce3 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1963,7 +1963,7 @@ static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 
 static int nb_vcs;
 static Chardev *vcs[MAX_VCS];
-static void gd_vc_open(Chardev *chr,
+static void gd_vc_chr_open(Chardev *chr,
                        ChardevBackend *backend,
                        bool *be_opened,
                        Error **errp)
@@ -1985,7 +1985,7 @@ static void char_gd_vc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->chr_open = gd_vc_open;
+    cc->chr_open = gd_vc_chr_open;
     cc->chr_write = gd_vc_chr_write;
     cc->chr_accept_input = gd_vc_chr_accept_input;
     cc->chr_set_echo = gd_vc_chr_set_echo;
-- 
2.48.1


