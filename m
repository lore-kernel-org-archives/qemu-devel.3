Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A643CE7B04
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWyj-000598-LZ; Fri, 06 Sep 2024 07:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWyZ-00043M-RA; Fri, 06 Sep 2024 07:18:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWyX-0008Cp-ND; Fri, 06 Sep 2024 07:18:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B3E9E8C4A2;
 Fri,  6 Sep 2024 14:12:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BE82F13370B;
 Fri,  6 Sep 2024 14:13:27 +0300 (MSK)
Received: (nullmailer pid 353705 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 49/69] nbd/server: CVE-2024-7409: Close stray clients
 at server-stop
Date: Fri,  6 Sep 2024 14:12:58 +0300
Message-Id: <20240906111324.353230-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

A malicious client can attempt to connect to an NBD server, and then
intentionally delay progress in the handshake, including if it does
not know the TLS secrets.  Although the previous two patches reduce
this behavior by capping the default max-connections parameter and
killing slow clients, they did not eliminate the possibility of a
client waiting to close the socket until after the QMP nbd-server-stop
command is executed, at which point qemu would SEGV when trying to
dereference the NULL nbd_server global which is no longer present.
This amounts to a denial of service attack.  Worse, if another NBD
server is started before the malicious client disconnects, I cannot
rule out additional adverse effects when the old client interferes
with the connection count of the new server (although the most likely
is a crash due to an assertion failure when checking
nbd_server->connections > 0).

For environments without this patch, the CVE can be mitigated by
ensuring (such as via a firewall) that only trusted clients can
connect to an NBD server.  Note that using frameworks like libvirt
that ensure that TLS is used and that nbd-server-stop is not executed
while any trusted clients are still connected will only help if there
is also no possibility for an untrusted client to open a connection
but then stall on the NBD handshake.

Given the previous patches, it would be possible to guarantee that no
clients remain connected by having nbd-server-stop sleep for longer
than the default handshake deadline before finally freeing the global
nbd_server object, but that could make QMP non-responsive for a long
time.  So intead, this patch fixes the problem by tracking all client
sockets opened while the server is running, and forcefully closing any
such sockets remaining without a completed handshake at the time of
nbd-server-stop, then waiting until the coroutines servicing those
sockets notice the state change.  nbd-server-stop now has a second
AIO_WAIT_WHILE_UNLOCKED (the first is indirectly through the
blk_exp_close_all_type() that disconnects all clients that completed
handshakes), but forced socket shutdown is enough to progress the
coroutines and quickly tear down all clients before the server is
freed, thus finally fixing the CVE.

This patch relies heavily on the fact that nbd/server.c guarantees
that it only calls nbd_blockdev_client_closed() from the main loop
(see the assertion in nbd_client_put() and the hoops used in
nbd_client_put_nonzero() to achieve that); if we did not have that
guarantee, we would also need a mutex protecting our accesses of the
list of connections to survive re-entrancy from independent iothreads.

Although I did not actually try to test old builds, it looks like this
problem has existed since at least commit 862172f45c (v2.12.0, 2017) -
even back when that patch started using a QIONetListener to handle
listening on multiple sockets, nbd_server_free() was already unaware
that the nbd_blockdev_client_closed callback can be reached later by a
client thread that has not completed handshakes (and therefore the
client's socket never got added to the list closed in
nbd_export_close_all), despite that patch intentionally tearing down
the QIONetListener to prevent new clients.

Reported-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Fixes: CVE-2024-7409
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240807174943.771624-14-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 3e7ef738c8462c45043a1d39f702a0990406a3b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 24ba5382db..f73409ae49 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -21,12 +21,18 @@
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
 
+typedef struct NBDConn {
+    QIOChannelSocket *cioc;
+    QLIST_ENTRY(NBDConn) next;
+} NBDConn;
+
 typedef struct NBDServerData {
     QIONetListener *listener;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
     uint32_t max_connections;
     uint32_t connections;
+    QLIST_HEAD(, NBDConn) conns;
 } NBDServerData;
 
 static NBDServerData *nbd_server;
@@ -51,6 +57,14 @@ int nbd_server_max_connections(void)
 
 static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
 {
+    NBDConn *conn = nbd_client_owner(client);
+
+    assert(qemu_in_main_thread() && nbd_server);
+
+    object_unref(OBJECT(conn->cioc));
+    QLIST_REMOVE(conn, next);
+    g_free(conn);
+
     nbd_client_put(client);
     assert(nbd_server->connections > 0);
     nbd_server->connections--;
@@ -60,14 +74,20 @@ static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
 static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
                        gpointer opaque)
 {
+    NBDConn *conn = g_new0(NBDConn, 1);
+
+    assert(qemu_in_main_thread() && nbd_server);
     nbd_server->connections++;
+    object_ref(OBJECT(cioc));
+    conn->cioc = cioc;
+    QLIST_INSERT_HEAD(&nbd_server->conns, conn, next);
     nbd_update_server_watch(nbd_server);
 
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
     /* TODO - expose handshake timeout as QMP option */
     nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
                    nbd_server->tlscreds, nbd_server->tlsauthz,
-                   nbd_blockdev_client_closed, NULL);
+                   nbd_blockdev_client_closed, conn);
 }
 
 static void nbd_update_server_watch(NBDServerData *s)
@@ -81,12 +101,25 @@ static void nbd_update_server_watch(NBDServerData *s)
 
 static void nbd_server_free(NBDServerData *server)
 {
+    NBDConn *conn, *tmp;
+
     if (!server) {
         return;
     }
 
+    /*
+     * Forcefully close the listener socket, and any clients that have
+     * not yet disconnected on their own.
+     */
     qio_net_listener_disconnect(server->listener);
     object_unref(OBJECT(server->listener));
+    QLIST_FOREACH_SAFE(conn, &server->conns, next, tmp) {
+        qio_channel_shutdown(QIO_CHANNEL(conn->cioc), QIO_CHANNEL_SHUTDOWN_BOTH,
+                             NULL);
+    }
+
+    AIO_WAIT_WHILE_UNLOCKED(NULL, server->connections > 0);
+
     if (server->tlscreds) {
         object_unref(OBJECT(server->tlscreds));
     }
-- 
2.39.2


