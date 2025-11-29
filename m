Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9085D116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 13:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLFk-0005Q0-Sl; Sat, 29 Nov 2025 08:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFU-0005Mi-Vx
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:29 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFQ-0002XZ-R9
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:28 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A83818087F;
 Sat, 29 Nov 2025 16:44:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:891::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Iigm2k0FK8c0-7XgFjcnm; Sat, 29 Nov 2025 16:44:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764423861;
 bh=PkljeRecBE8UmefL+okxsFVCEKdyAXFWhMSX/rcMjfw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pnSj37r55gzUPumpKpd0WS32kBCPgH9d36CnjiX2UGKu8yZn8zw89hcAasiRFEjax
 fWG7kHoUoupKCFPL/93Yj8TYCS+ghS39shKwbmydh1UGTN10CLp+GOacDmVuEJrTgK
 jSyv7CGg1Yg6kxsy+dww1yw27jjzFt2VyI/vTxn4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 1/8] chardev: ChardevClass: consistent naming for handlers
Date: Sat, 29 Nov 2025 16:43:41 +0300
Message-ID: <20251129134350.487839-2-vsementsov@yandex-team.ru>
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

Most handlers have name prefixed with "chr_". That's a good practice
which helps to grep them. Convert the rest: .parse, .open,
get/set_msgfds.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/baum.c                                      | 2 +-
 chardev/char-console.c                              | 2 +-
 chardev/char-fe.c                                   | 8 ++++----
 chardev/char-file.c                                 | 4 ++--
 chardev/char-hub.c                                  | 4 ++--
 chardev/char-mux.c                                  | 4 ++--
 chardev/char-null.c                                 | 2 +-
 chardev/char-parallel.c                             | 4 ++--
 chardev/char-pipe.c                                 | 4 ++--
 chardev/char-pty.c                                  | 4 ++--
 chardev/char-ringbuf.c                              | 4 ++--
 chardev/char-serial.c                               | 4 ++--
 chardev/char-socket.c                               | 8 ++++----
 chardev/char-stdio.c                                | 4 ++--
 chardev/char-udp.c                                  | 4 ++--
 chardev/char-win-stdio.c                            | 2 +-
 chardev/char.c                                      | 8 ++++----
 chardev/msmouse.c                                   | 2 +-
 chardev/spice.c                                     | 8 ++++----
 chardev/wctablet.c                                  | 2 +-
 gdbstub/system.c                                    | 2 +-
 include/chardev/char.h                              | 8 ++++----
 scripts/codeconverter/codeconverter/test_regexps.py | 2 +-
 ui/console-vc.c                                     | 4 ++--
 ui/dbus-chardev.c                                   | 8 ++++----
 ui/dbus.c                                           | 4 ++--
 ui/gtk.c                                            | 2 +-
 ui/spice-app.c                                      | 6 +++---
 ui/vdagent.c                                        | 4 ++--
 29 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index ad68321504..6b81c97d10 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -676,7 +676,7 @@ static void char_braille_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->open = baum_chr_open;
+    cc->chr_open = baum_chr_open;
     cc->chr_write = baum_chr_write;
     cc->chr_accept_input = baum_chr_accept_input;
 }
diff --git a/chardev/char-console.c b/chardev/char-console.c
index 7e1bf642eb..9a2e012d53 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -38,7 +38,7 @@ static void char_console_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->open = qemu_chr_open_win_con;
+    cc->chr_open = qemu_chr_open_win_con;
 }
 
 static const TypeInfo char_console_type_info = {
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 34b83fc1c4..a44f267373 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -130,8 +130,8 @@ int qemu_chr_fe_get_msgfds(CharFrontend *c, int *fds, int len)
         return -1;
     }
 
-    return CHARDEV_GET_CLASS(s)->get_msgfds ?
-        CHARDEV_GET_CLASS(s)->get_msgfds(s, fds, len) : -1;
+    return CHARDEV_GET_CLASS(s)->chr_get_msgfds ?
+        CHARDEV_GET_CLASS(s)->chr_get_msgfds(s, fds, len) : -1;
 }
 
 int qemu_chr_fe_set_msgfds(CharFrontend *c, int *fds, int num)
@@ -142,8 +142,8 @@ int qemu_chr_fe_set_msgfds(CharFrontend *c, int *fds, int num)
         return -1;
     }
 
-    return CHARDEV_GET_CLASS(s)->set_msgfds ?
-        CHARDEV_GET_CLASS(s)->set_msgfds(s, fds, num) : -1;
+    return CHARDEV_GET_CLASS(s)->chr_set_msgfds ?
+        CHARDEV_GET_CLASS(s)->chr_set_msgfds(s, fds, num) : -1;
 }
 
 void qemu_chr_fe_accept_input(CharFrontend *c)
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 1f7adf592f..1e293e7054 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -133,8 +133,8 @@ static void char_file_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_file_out;
-    cc->open = qmp_chardev_open_file;
+    cc->chr_parse = qemu_chr_parse_file_out;
+    cc->chr_open = qmp_chardev_open_file;
 }
 
 static const TypeInfo char_file_type_info = {
diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index d0967c2233..082baa84ab 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -276,8 +276,8 @@ static void char_hub_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_hub;
-    cc->open = qemu_chr_open_hub;
+    cc->chr_parse = qemu_chr_parse_hub;
+    cc->chr_open = qemu_chr_open_hub;
     cc->chr_write = hub_chr_write;
     cc->chr_add_watch = hub_chr_add_watch;
     /* We handle events from backends only */
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index db9e89f441..c82c2da56d 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -451,8 +451,8 @@ static void char_mux_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_mux;
-    cc->open = qemu_chr_open_mux;
+    cc->chr_parse = qemu_chr_parse_mux;
+    cc->chr_open = qemu_chr_open_mux;
     cc->chr_write = mux_chr_write;
     cc->chr_accept_input = mux_chr_accept_input;
     cc->chr_add_watch = mux_chr_add_watch;
diff --git a/chardev/char-null.c b/chardev/char-null.c
index 89cb85da79..674603b380 100644
--- a/chardev/char-null.c
+++ b/chardev/char-null.c
@@ -38,7 +38,7 @@ static void char_null_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->open = null_chr_open;
+    cc->chr_open = null_chr_open;
 }
 
 static const TypeInfo char_null_type_info = {
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 62a44b2f96..a0839b784b 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -274,8 +274,8 @@ static void char_parallel_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_parallel;
-    cc->open = qmp_chardev_open_parallel;
+    cc->chr_parse = qemu_chr_parse_parallel;
+    cc->chr_open = qmp_chardev_open_parallel;
     cc->chr_ioctl = pp_ioctl;
 }
 
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index e9f3bb8290..a2cd322efe 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -182,8 +182,8 @@ static void char_pipe_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_pipe;
-    cc->open = qemu_chr_open_pipe;
+    cc->chr_parse = qemu_chr_parse_pipe;
+    cc->chr_open = qemu_chr_open_pipe;
 }
 
 static const TypeInfo char_pipe_type_info = {
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 652b0bd9e7..1a15082b02 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -394,8 +394,8 @@ static void char_pty_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = char_pty_parse;
-    cc->open = char_pty_open;
+    cc->chr_parse = char_pty_parse;
+    cc->chr_open = char_pty_open;
     cc->chr_write = char_pty_chr_write;
     cc->chr_update_read_handler = pty_chr_update_read_handler;
     cc->chr_add_watch = pty_chr_add_watch;
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 98aadb6acf..6d5ba667bb 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -227,8 +227,8 @@ static void char_ringbuf_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_ringbuf;
-    cc->open = qemu_chr_open_ringbuf;
+    cc->chr_parse = qemu_chr_parse_ringbuf;
+    cc->chr_open = qemu_chr_open_ringbuf;
     cc->chr_write = ringbuf_chr_write;
 }
 
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 4c6ca713eb..97ed7adf73 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -305,8 +305,8 @@ static void char_serial_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_serial;
-    cc->open = qmp_chardev_open_serial;
+    cc->chr_parse = qemu_chr_parse_serial;
+    cc->chr_open = qmp_chardev_open_serial;
 #ifndef _WIN32
     cc->chr_ioctl = tty_serial_ioctl;
 #endif
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 26d2f11202..12916af7ff 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1576,14 +1576,14 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
 
     cc->supports_yank = true;
 
-    cc->parse = qemu_chr_parse_socket;
-    cc->open = qmp_chardev_open_socket;
+    cc->chr_parse = qemu_chr_parse_socket;
+    cc->chr_open = qmp_chardev_open_socket;
     cc->chr_wait_connected = tcp_chr_wait_connected;
     cc->chr_write = tcp_chr_write;
     cc->chr_sync_read = tcp_chr_sync_read;
     cc->chr_disconnect = tcp_chr_disconnect;
-    cc->get_msgfds = tcp_get_msgfds;
-    cc->set_msgfds = tcp_set_msgfds;
+    cc->chr_get_msgfds = tcp_get_msgfds;
+    cc->chr_set_msgfds = tcp_set_msgfds;
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 2568164a10..b7e9af1388 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -142,9 +142,9 @@ static void char_stdio_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_stdio;
+    cc->chr_parse = qemu_chr_parse_stdio;
 #ifndef _WIN32
-    cc->open = qemu_chr_open_stdio;
+    cc->chr_open = qemu_chr_open_stdio;
     cc->chr_set_echo = qemu_chr_set_echo_stdio;
 #endif
 }
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 572fab0ad1..a6f496ac7b 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -223,8 +223,8 @@ static void char_udp_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_udp;
-    cc->open = qmp_chardev_open_udp;
+    cc->chr_parse = qemu_chr_parse_udp;
+    cc->chr_open = qmp_chardev_open_udp;
     cc->chr_write = udp_chr_write;
     cc->chr_update_read_handler = udp_chr_update_read_handler;
 }
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index fb802a00b1..26e67aef1c 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -260,7 +260,7 @@ static void char_win_stdio_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->open = qemu_chr_open_stdio;
+    cc->chr_open = qemu_chr_open_stdio;
     cc->chr_write = win_stdio_write;
     cc->chr_set_echo = qemu_chr_set_echo_win_stdio;
 }
diff --git a/chardev/char.c b/chardev/char.c
index 3e432195a5..df37d1df16 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -267,8 +267,8 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
         }
     }
 
-    if (cc->open) {
-        cc->open(chr, backend, be_opened, errp);
+    if (cc->chr_open) {
+        cc->chr_open(chr, backend, be_opened, errp);
     }
 }
 
@@ -604,8 +604,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
     backend = g_new0(ChardevBackend, 1);
     backend->type = CHARDEV_BACKEND_KIND_NULL;
 
-    if (cc->parse) {
-        cc->parse(opts, backend, &local_err);
+    if (cc->chr_parse) {
+        cc->chr_parse(opts, backend, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             qapi_free_ChardevBackend(backend);
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 1a55755d39..8405016489 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -271,7 +271,7 @@ static void char_msmouse_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->open = msmouse_chr_open;
+    cc->chr_open = msmouse_chr_open;
     cc->chr_write = msmouse_chr_write;
     cc->chr_accept_input = msmouse_chr_accept_input;
     cc->chr_ioctl = msmouse_ioctl;
diff --git a/chardev/spice.c b/chardev/spice.c
index db53b49da2..d55b3693b6 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -370,8 +370,8 @@ static void char_spicevmc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_spice_vmc;
-    cc->open = qemu_chr_open_spice_vmc;
+    cc->chr_parse = qemu_chr_parse_spice_vmc;
+    cc->chr_open = qemu_chr_open_spice_vmc;
     cc->chr_set_fe_open = spice_vmc_set_fe_open;
 }
 
@@ -386,8 +386,8 @@ static void char_spiceport_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = qemu_chr_parse_spice_port;
-    cc->open = qemu_chr_open_spice_port;
+    cc->chr_parse = qemu_chr_parse_spice_port;
+    cc->chr_open = qemu_chr_open_spice_port;
     cc->chr_set_fe_open = spice_port_set_fe_open;
 }
 
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 0dc6ef08f5..8285a56e7b 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -346,7 +346,7 @@ static void wctablet_chr_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->open = wctablet_chr_open;
+    cc->chr_open = wctablet_chr_open;
     cc->chr_write = wctablet_chr_write;
     cc->chr_ioctl = wctablet_chr_ioctl;
     cc->chr_accept_input = wctablet_chr_accept_input;
diff --git a/gdbstub/system.c b/gdbstub/system.c
index e2220c1ae4..fe2afeb107 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -244,7 +244,7 @@ static void char_gdb_class_init(ObjectClass *oc, const void *data)
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
     cc->internal = true;
-    cc->open = gdb_monitor_open;
+    cc->chr_open = gdb_monitor_open;
     cc->chr_write = gdb_monitor_write;
 }
 
diff --git a/include/chardev/char.h b/include/chardev/char.h
index b65e9981c1..2baf2a8a1a 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -257,10 +257,10 @@ struct ChardevClass {
     bool supports_yank;
 
     /* parse command line options and populate QAPI @backend */
-    void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
+    void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
     /* called after construction, open/starts the backend */
-    void (*open)(Chardev *chr, ChardevBackend *backend,
+    void (*chr_open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
 
     /* write buf to the backend */
@@ -282,10 +282,10 @@ struct ChardevClass {
     int (*chr_ioctl)(Chardev *s, int cmd, void *arg);
 
     /* get ancillary-received fds during last read */
-    int (*get_msgfds)(Chardev *s, int* fds, int num);
+    int (*chr_get_msgfds)(Chardev *s, int* fds, int num);
 
     /* set ancillary fds to be sent with next write */
-    int (*set_msgfds)(Chardev *s, int *fds, int num);
+    int (*chr_set_msgfds)(Chardev *s, int *fds, int num);
 
     /* accept the given fd */
     int (*chr_add_client)(Chardev *chr, int fd);
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index b00e9ef15b..d3a5cc3ad3 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -57,7 +57,7 @@ def fullmatch(regexp, s):
 
     print(RE_TYPEINFO_START)
     assert re.search(RE_TYPEINFO_START, r'''
-    cc->open = qmp_chardev_open_file;
+    cc->chr_open = qmp_chardev_open_file;
 }
 
 static const TypeInfo char_file_type_info = {
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 830842064d..931068d43a 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1185,8 +1185,8 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = vc_chr_parse;
-    cc->open = vc_chr_open;
+    cc->chr_parse = vc_chr_parse;
+    cc->chr_open = vc_chr_open;
     cc->chr_write = vc_chr_write;
     cc->chr_accept_input = vc_chr_accept_input;
     cc->chr_set_echo = vc_chr_set_echo;
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index d05dddaf81..f6c426e220 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -205,12 +205,12 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
     opts = qemu_opts_create(qemu_find_opts("chardev"), NULL, 0, &error_abort);
     qemu_opt_set(opts, "server", "on", &error_abort);
     qemu_opt_set(opts, "wait", "off", &error_abort);
-    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->parse(
+    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_parse(
         opts, be, errp);
     if (*errp) {
         return;
     }
-    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->open(
+    CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_SOCKET))->chr_open(
         chr, be, be_opened, errp);
 }
 
@@ -274,8 +274,8 @@ char_dbus_class_init(ObjectClass *oc, const void *data)
     DBusChardevClass *klass = DBUS_CHARDEV_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse = dbus_chr_parse;
-    cc->open = dbus_chr_open;
+    cc->chr_parse = dbus_chr_parse;
+    cc->chr_open = dbus_chr_open;
     cc->chr_set_fe_open = dbus_chr_set_fe_open;
     cc->chr_set_echo = dbus_chr_set_echo;
     klass->parent_chr_be_event = cc->chr_be_event;
diff --git a/ui/dbus.c b/ui/dbus.c
index d2dff33258..31f6eb1189 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -451,8 +451,8 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
     DBusVCClass *klass = DBUS_VC_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    klass->parent_parse = cc->parse;
-    cc->parse = dbus_vc_parse;
+    klass->parent_parse = cc->chr_parse;
+    cc->chr_parse = dbus_vc_parse;
 }
 
 static const TypeInfo dbus_vc_type_info = {
diff --git a/ui/gtk.c b/ui/gtk.c
index 48571bedbf..7aa97907ed 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1985,7 +1985,7 @@ static void char_gd_vc_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->open = gd_vc_open;
+    cc->chr_open = gd_vc_open;
     cc->chr_write = gd_vc_chr_write;
     cc->chr_accept_input = gd_vc_chr_accept_input;
     cc->chr_set_echo = gd_vc_chr_set_echo;
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 24f78f305c..ea0b62a22b 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -106,10 +106,10 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     VCChardevClass *vc = CHARDEV_VC_CLASS(oc);
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    vc->parent_open = cc->open;
+    vc->parent_open = cc->chr_open;
 
-    cc->parse = vc_chr_parse;
-    cc->open = vc_chr_open;
+    cc->chr_parse = vc_chr_parse;
+    cc->chr_open = vc_chr_open;
     cc->chr_set_echo = vc_chr_set_echo;
 }
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 660686c9c0..9972a9c476 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -924,8 +924,8 @@ static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    cc->parse            = vdagent_chr_parse;
-    cc->open             = vdagent_chr_open;
+    cc->chr_parse        = vdagent_chr_parse;
+    cc->chr_open         = vdagent_chr_open;
     cc->chr_write        = vdagent_chr_write;
     cc->chr_set_fe_open  = vdagent_chr_set_fe_open;
     cc->chr_accept_input = vdagent_chr_accept_input;
-- 
2.48.1


