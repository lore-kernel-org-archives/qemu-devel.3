Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7C1CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE24H-0003vm-53; Wed, 29 Oct 2025 05:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE247-0003t8-6O; Wed, 29 Oct 2025 05:02:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE241-00031Y-CE; Wed, 29 Oct 2025 05:01:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9660B163E5E;
 Wed, 29 Oct 2025 12:01:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BF4753084A5;
 Wed, 29 Oct 2025 12:01:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/7] chardev: remove deprecated 'reconnect' option
Date: Wed, 29 Oct 2025 12:01:39 +0300
Message-ID: <20251029090148.648212-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029090148.648212-1-mjt@tls.msk.ru>
References: <20251029090148.648212-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

It was deprecated in 9.2, time to remove.

Note, that (which become obvious with this commit) we forget to do some
checks for reconnect-ms options, for example, it was silently ignored
for listening server, instead of error-out. The commit fixes this, as
now we use reconnect_ms everywhere.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 chardev/char-socket.c           | 24 +++++-------------------
 chardev/char.c                  |  3 ---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst | 12 ++++++++++++
 qapi/char.json                  | 14 +-------------
 5 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index cb4ec78ebe..62852e3caf 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1296,9 +1296,9 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
     /* Validate any options which have a dependency on address type */
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_FD:
-        if (sock->has_reconnect) {
+        if (sock->has_reconnect_ms) {
             error_setg(errp,
-                       "'reconnect' option is incompatible with "
+                       "'reconnect-ms' option is incompatible with "
                        "'fd' address type");
             return false;
         }
@@ -1342,9 +1342,9 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
 
     /* Validate any options which have a dependency on client vs server */
     if (!sock->has_server || sock->server) {
-        if (sock->has_reconnect) {
+        if (sock->has_reconnect_ms) {
             error_setg(errp,
-                       "'reconnect' option is incompatible with "
+                       "'reconnect-ms' option is incompatible with "
                        "socket in server listen mode");
             return false;
         }
@@ -1361,12 +1361,6 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
         }
     }
 
-    if (sock->has_reconnect_ms && sock->has_reconnect) {
-        error_setg(errp,
-            "'reconnect' and 'reconnect-ms' are mutually exclusive");
-        return false;
-    }
-
     return true;
 }
 
@@ -1384,7 +1378,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;
-    int64_t reconnect_ms = 0;
+    int64_t reconnect_ms = sock->has_reconnect_ms ? sock->reconnect_ms : 0;
     SocketAddress *addr;
 
     s->is_listen = is_listen;
@@ -1456,12 +1450,6 @@ static void qmp_chardev_open_socket(Chardev *chr,
             return;
         }
     } else {
-        if (sock->has_reconnect) {
-            reconnect_ms = sock->reconnect * 1000ULL;
-        } else if (sock->has_reconnect_ms) {
-            reconnect_ms = sock->reconnect_ms;
-        }
-
         if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0) {
             return;
         }
@@ -1526,8 +1514,6 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
      */
     sock->has_wait = qemu_opt_find(opts, "wait") || sock->server;
     sock->wait = qemu_opt_get_bool(opts, "wait", true);
-    sock->has_reconnect = qemu_opt_find(opts, "reconnect");
-    sock->reconnect = qemu_opt_get_number(opts, "reconnect", 0);
     sock->has_reconnect_ms = qemu_opt_find(opts, "reconnect-ms");
     sock->reconnect_ms = qemu_opt_get_number(opts, "reconnect-ms", 0);
 
diff --git a/chardev/char.c b/chardev/char.c
index bbebd246c3..a43b7e5481 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -892,9 +892,6 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "nodelay",
             .type = QEMU_OPT_BOOL,
-        },{
-            .name = "reconnect",
-            .type = QEMU_OPT_NUMBER,
         },{
             .name = "reconnect-ms",
             .type = QEMU_OPT_NUMBER,
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dacf2882e4..aff3f13163 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -468,12 +468,6 @@ Backend ``memory`` (since 9.0)
 
 ``memory`` is a deprecated synonym for ``ringbuf``.
 
-``reconnect`` (since 9.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The ``reconnect`` option only allows specifying second granularity timeouts,
-which is not enough for all types of use cases, use ``reconnect-ms`` instead.
-
 
 Net device options
 ''''''''''''''''''
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 53829f59e6..269f6bb654 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1367,4 +1367,16 @@ The ``blacklist`` config file option has been renamed to ``block-rpcs``
 (to be in sync with the renaming of the corresponding command line
 option).
 
+Device options
+--------------
+
+Character device options
+''''''''''''''''''''''''
+
+``reconnect`` (removed in 10.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
+better precision.
+
 .. _Intel discontinuance notification: https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
diff --git a/qapi/char.json b/qapi/char.json
index f0a53f742c..b07e3bb827 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -269,22 +269,11 @@
 # @websocket: enable websocket protocol on server sockets
 #     (default: false) (Since: 3.1)
 #
-# @reconnect: For a client socket, if a socket is disconnected, then
-#     attempt a reconnect after the given number of seconds.  Setting
-#     this to zero disables this function.  The use of this member is
-#     deprecated, use @reconnect-ms instead.  (default: 0) (Since: 2.2)
-#
 # @reconnect-ms: For a client socket, if a socket is disconnected,
 #     then attempt a reconnect after the given number of milliseconds.
-#     Setting this to zero disables this function.  This member is
-#     mutually exclusive with @reconnect.
+#     Setting this to zero disables this function.
 #     (default: 0) (Since: 9.2)
 #
-# Features:
-#
-# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
-#     instead.
-#
 # Since: 1.4
 ##
 { 'struct': 'ChardevSocket',
@@ -297,7 +286,6 @@
             '*telnet': 'bool',
             '*tn3270': 'bool',
             '*websocket': 'bool',
-            '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
             '*reconnect-ms': 'int' },
   'base': 'ChardevCommon' }
 
-- 
2.47.3


