Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAA9CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySEk-0002uk-7W; Wed, 09 Oct 2024 04:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sySEh-0002u6-Gn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sySEf-0001KC-Qb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728463197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOuSbBaYBdDOGGWMn9gqpOjH0y5Y7jL5jQiHg5Kot78=;
 b=f3NS0/86SMboiJ/Bvj9ItwOo1pL5Fg0DR+G7jryA+G7X1Dc9+lkfKjkoJ3j0hoYHz2hvVc
 247h2OfCQNk8PSw8YP/dldwExdcJ+xnHok3YNzeLh30ngeMDQSCv7ixW8WtlGjLfSw1+MM
 ATRmxJFLENNI4pY6llo5lRrE3ehMfnE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-j4_OSMsZM5eoA2SonIY9jg-1; Wed,
 09 Oct 2024 04:39:53 -0400
X-MC-Unique: j4_OSMsZM5eoA2SonIY9jg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28C2C1944DE4; Wed,  9 Oct 2024 08:39:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A054130001A8; Wed,  9 Oct 2024 08:39:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: [PULL 1/2] chardev: introduce 'reconnect-ms' and deprecate 'reconnect'
Date: Wed,  9 Oct 2024 12:39:37 +0400
Message-ID: <20241009083938.1504695-2-marcandre.lureau@redhat.com>
In-Reply-To: <20241009083938.1504695-1-marcandre.lureau@redhat.com>
References: <20241009083938.1504695-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

The 'reconnect' option only allows to specify the time in seconds,
which is way too long for certain workflows.

We have a lightweight disk backend server, which takes about 20ms to
live update, but due to this limitation in QEMU, previously the guest
disk controller would hang for one second because it would take this
long for QEMU to reinitialize the socket connection.

Introduce a new option called 'reconnect-ms', which is the same as
'reconnect', except the value is treated as milliseconds. These are
mutually exclusive and specifying both results in an error.

'reconnect' is also deprecated by this commit to make it possible to
remove it in the future as to not keep two options that control the
same thing.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240913094604.269135-1-d-tatianin@yandex-team.ru>
---
 docs/about/deprecated.rst     |  6 ++++++
 qapi/char.json                | 17 +++++++++++++++--
 include/chardev/char-socket.h |  2 +-
 chardev/char-socket.c         | 33 ++++++++++++++++++++++++---------
 chardev/char.c                |  3 +++
 5 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c02bbb66f7..82bb4927e8 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -394,6 +394,12 @@ Backend ``memory`` (since 9.0)
 
 ``memory`` is a deprecated synonym for ``ringbuf``.
 
+``reconnect`` (since 9.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``reconnect`` option only allows specifiying second granularity timeouts,
+which is not enough for all types of use cases, use ``reconnect-ms`` instead.
+
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/qapi/char.json b/qapi/char.json
index 0d6de1ee35..42eda4f98b 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -273,7 +273,19 @@
 #
 # @reconnect: For a client socket, if a socket is disconnected, then
 #     attempt a reconnect after the given number of seconds.  Setting
-#     this to zero disables this function.  (default: 0) (Since: 2.2)
+#     this to zero disables this function.  The use of this member is
+#     deprecated, use @reconnect-ms instead. (default: 0) (Since: 2.2)
+#
+# @reconnect-ms: For a client socket, if a socket is disconnected,
+#     then attempt a reconnect after the given number of milliseconds.
+#     Setting this to zero disables this function.  This member is
+#     mutually exclusive with @reconnect.
+#     (default: 0) (Since: 9.2)
+#
+# Features:
+#
+# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
+#     instead.
 #
 # Since: 1.4
 ##
@@ -287,7 +299,8 @@
             '*telnet': 'bool',
             '*tn3270': 'bool',
             '*websocket': 'bool',
-            '*reconnect': 'int' },
+            '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
+            '*reconnect-ms': 'int' },
   'base': 'ChardevCommon' }
 
 ##
diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
index 0708ca6fa9..d6d13ad37f 100644
--- a/include/chardev/char-socket.h
+++ b/include/chardev/char-socket.h
@@ -74,7 +74,7 @@ struct SocketChardev {
     bool is_websock;
 
     GSource *reconnect_timer;
-    int64_t reconnect_time;
+    int64_t reconnect_time_ms;
     bool connect_err_reported;
 
     QIOTask *connect_task;
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ca9441b1b..91496ceda9 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -74,7 +74,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
     assert(!s->reconnect_timer);
     name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
     s->reconnect_timer = qemu_chr_timeout_add_ms(chr,
-                                                 s->reconnect_time * 1000,
+                                                 s->reconnect_time_ms,
                                                  socket_reconnect_timeout,
                                                  chr);
     g_source_set_name(s->reconnect_timer, name);
@@ -481,7 +481,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     if (emit_close) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     }
-    if (s->reconnect_time && !s->reconnect_timer) {
+    if (s->reconnect_time_ms && !s->reconnect_timer) {
         qemu_chr_socket_restart_timer(chr);
     }
 }
@@ -1080,9 +1080,9 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
         } else {
             Error *err = NULL;
             if (tcp_chr_connect_client_sync(chr, &err) < 0) {
-                if (s->reconnect_time) {
+                if (s->reconnect_time_ms) {
                     error_free(err);
-                    g_usleep(s->reconnect_time * 1000ULL * 1000ULL);
+                    g_usleep(s->reconnect_time_ms * 1000ULL);
                 } else {
                     error_propagate(errp, err);
                     return -1;
@@ -1267,13 +1267,13 @@ skip_listen:
 
 
 static int qmp_chardev_open_socket_client(Chardev *chr,
-                                          int64_t reconnect,
+                                          int64_t reconnect_ms,
                                           Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
-    if (reconnect > 0) {
-        s->reconnect_time = reconnect;
+    if (reconnect_ms > 0) {
+        s->reconnect_time_ms = reconnect_ms;
         tcp_chr_connect_client_async(chr);
         return 0;
     } else {
@@ -1354,6 +1354,12 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
         }
     }
 
+    if (sock->has_reconnect_ms && sock->has_reconnect) {
+        error_setg(errp,
+            "'reconnect' and 'reconnect-ms' are mutually exclusive");
+        return false;
+    }
+
     return true;
 }
 
@@ -1371,7 +1377,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;
-    int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
+    int64_t reconnect_ms = 0;
     SocketAddress *addr;
 
     s->is_listen = is_listen;
@@ -1443,7 +1449,13 @@ static void qmp_chardev_open_socket(Chardev *chr,
             return;
         }
     } else {
-        if (qmp_chardev_open_socket_client(chr, reconnect, errp) < 0) {
+        if (sock->has_reconnect) {
+            reconnect_ms = sock->reconnect * 1000ULL;
+        } else if (sock->has_reconnect_ms) {
+            reconnect_ms = sock->reconnect_ms;
+        }
+
+        if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0) {
             return;
         }
     }
@@ -1509,6 +1521,9 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->wait = qemu_opt_get_bool(opts, "wait", true);
     sock->has_reconnect = qemu_opt_find(opts, "reconnect");
     sock->reconnect = qemu_opt_get_number(opts, "reconnect", 0);
+    sock->has_reconnect_ms = qemu_opt_find(opts, "reconnect-ms");
+    sock->reconnect_ms = qemu_opt_get_number(opts, "reconnect-ms", 0);
+
     sock->tls_creds = g_strdup(qemu_opt_get(opts, "tls-creds"));
     sock->tls_authz = g_strdup(qemu_opt_get(opts, "tls-authz"));
 
diff --git a/chardev/char.c b/chardev/char.c
index ba847b6e9e..35623c78a3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -888,6 +888,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "reconnect",
             .type = QEMU_OPT_NUMBER,
+        },{
+            .name = "reconnect-ms",
+            .type = QEMU_OPT_NUMBER,
         },{
             .name = "telnet",
             .type = QEMU_OPT_BOOL,
-- 
2.47.0


