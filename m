Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F34C52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbknf-0007sJ-Cv; Wed, 07 Aug 2024 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknd-0007l2-OU
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknb-0000ex-PQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723053008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpEGtHu3K56nxX32v7quHRWHOdQOFyRF1XKS4TQ5TIQ=;
 b=EqI4lIPcNNlJfDNlNdX0H86KgSwfBtux8aejtVesf79+Eq/OS0FpUcmMoQHoEGHf+BGF+7
 7DXOB3EvWyxuxlgBtgLxIpBcR3RVB2iT7Y8t5DOAV5Z/DRinHbajJaYSEqEkBabId9l2jY
 U+RRQ8hPC2333TWQNsBTHnIlELxiBeE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-jzofFtsFOBG97PaRYCzlrA-1; Wed,
 07 Aug 2024 13:50:04 -0400
X-MC-Unique: jzofFtsFOBG97PaRYCzlrA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71E451955F33; Wed,  7 Aug 2024 17:50:03 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AEED300018D; Wed,  7 Aug 2024 17:50:01 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v4 5/7] nbd/server: CVE-2024-7409: Close stray client sockets
 at shutdown
Date: Wed,  7 Aug 2024 12:43:31 -0500
Message-ID: <20240807174943.771624-14-eblake@redhat.com>
In-Reply-To: <20240807174943.771624-9-eblake@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A malicious client can attempt to connect to an NBD server, and then
intentionally delay progress in the handshake, including if it does
not know the TLS secrets.  Although this behavior can be bounded by
the max-connections parameter, the QMP nbd-server-start currently
defaults to unlimited incoming client connections.  Worse, if the
client waits to close the socket until after the QMP nbd-server-stop
command is executed, qemu will then SEGV when trying to dereference
the NULL nbd_server global which is no longer present, which amounts
to a denial of service attack.  If another NBD server is started
before the malicious client disconnects, I cannot rule out additional
adverse effects when the old client interferes with the connection
count of the new server.

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
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 blockdev-nbd.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 19c57897819..4e38ff46747 100644
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
     /* TODO - expose handshake limit as QMP option */
     nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_LIMIT,
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
2.45.2


