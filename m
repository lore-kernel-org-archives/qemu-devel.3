Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22D5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 10:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1setrx-0004Vx-AP; Fri, 16 Aug 2024 06:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1setru-0004VK-Lo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:07:38 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1setrr-0001iD-HK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:07:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c0f:0:640:cad:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 68BEC60BB0;
 Fri, 16 Aug 2024 13:07:29 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b593::1:1f])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id O7GhxJ0gACg0-2j9T7cmM; Fri, 16 Aug 2024 13:07:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1723802848;
 bh=MOrL4YLgzsNM6+Jo2KZEeZLSI3TzEzfFCKW7qPYGL+k=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=I9lVKGFe7lf2UpygTcUOuCES4USRh5+PSGwdMTrAkEs/BIv8dlNOQeEIwswVPNAON
 a5MP+JGBZrUHA2UDyc9yhkwJOyjyJXLUtnRMMMti3bCLBn2mmVvpQqR1WoFqTjcWL9
 Jc2SYKXCjmA2Mt84IPifDLC30VZpwcSOinvumgBw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] chardev: allow specifying finer-grained reconnect timeouts
Date: Fri, 16 Aug 2024 13:07:23 +0300
Message-Id: <20240816100723.2815-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The "reconnect" option only allows to specify the time in seconds,
which is way too long for certain workflows.

We have a lightweight disk backend server, which takes about 20ms to
live update, but due to this limitation in QEMU, previously the guest
disk controller would hang for one second because it would take this
long for QEMU to reinitialize the socket connection.

Make it possible to specify a smaller timeout by treating the value in
"reconnect" as milliseconds via the new "reconnect-is-ms" option.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 chardev/char-socket.c |  7 +++++--
 chardev/char.c        |  3 +++
 qapi/char.json        | 12 +++++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ca9441b1b..d87859e641 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -74,7 +74,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
     assert(!s->reconnect_timer);
     name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
     s->reconnect_timer = qemu_chr_timeout_add_ms(chr,
-                                                 s->reconnect_time * 1000,
+                                                 s->reconnect_time,
                                                  socket_reconnect_timeout,
                                                  chr);
     g_source_set_name(s->reconnect_timer, name);
@@ -1082,7 +1082,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
             if (tcp_chr_connect_client_sync(chr, &err) < 0) {
                 if (s->reconnect_time) {
                     error_free(err);
-                    g_usleep(s->reconnect_time * 1000ULL * 1000ULL);
+                    g_usleep(s->reconnect_time * 1000ULL);
                 } else {
                     error_propagate(errp, err);
                     return -1;
@@ -1509,6 +1509,9 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->wait = qemu_opt_get_bool(opts, "wait", true);
     sock->has_reconnect = qemu_opt_find(opts, "reconnect");
     sock->reconnect = qemu_opt_get_number(opts, "reconnect", 0);
+    if (!qemu_opt_get_bool(opts, "reconnect-is-ms", false)) {
+        sock->reconnect *= 1000ULL;
+    }
     sock->tls_creds = g_strdup(qemu_opt_get(opts, "tls-creds"));
     sock->tls_authz = g_strdup(qemu_opt_get(opts, "tls-authz"));
 
diff --git a/chardev/char.c b/chardev/char.c
index 3c43fb1278..f6e5f1d5c9 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -859,6 +859,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "reconnect",
             .type = QEMU_OPT_NUMBER,
+        },{
+            .name = "reconnect-is-ms",
+            .type = QEMU_OPT_BOOL,
         },{
             .name = "telnet",
             .type = QEMU_OPT_BOOL,
diff --git a/qapi/char.json b/qapi/char.json
index ef58445cee..61aeccf09d 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -272,8 +272,13 @@
 #     (default: false) (Since: 3.1)
 #
 # @reconnect: For a client socket, if a socket is disconnected, then
-#     attempt a reconnect after the given number of seconds.  Setting
-#     this to zero disables this function.  (default: 0) (Since: 2.2)
+#     attempt a reconnect after the given number of seconds (unless
+#     @reconnect-is-ms is set to true, in that case the number is
+#     treated as milliseconds).  Setting this to zero disables
+#     this function.  (default: 0) (Since: 2.2)
+#
+# @reconnect-is-ms: The value specified in @reconnect should be treated
+#     as milliseconds.  (default: false) (Since: 9.2)
 #
 # Since: 1.4
 ##
@@ -287,7 +292,8 @@
             '*telnet': 'bool',
             '*tn3270': 'bool',
             '*websocket': 'bool',
-            '*reconnect': 'int' },
+            '*reconnect': 'int',
+            '*reconnect-is-ms': 'bool' },
   'base': 'ChardevCommon' }
 
 ##
-- 
2.34.1


