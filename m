Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F7CE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSw4-0004qg-Ix; Fri, 06 Sep 2024 02:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSvH-0007YL-E1; Fri, 06 Sep 2024 02:58:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSvF-0003bg-L8; Fri, 06 Sep 2024 02:58:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BB908C25E;
 Fri,  6 Sep 2024 09:53:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 24002133416;
 Fri,  6 Sep 2024 09:54:32 +0300 (MSK)
Received: (nullmailer pid 43653 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:30 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 41/53] nbd/server: CVE-2024-7409: Avoid use-after-free
 when closing server
Date: Fri,  6 Sep 2024 09:54:11 +0300
Message-Id: <20240906065429.42415-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
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

Commit 3e7ef738 plugged the use-after-free of the global nbd_server
object, but overlooked a use-after-free of nbd_server->listener.
Although this race is harder to hit, notice that our shutdown path
first drops the reference count of nbd_server->listener, then triggers
actions that can result in a pending client reaching the
nbd_blockdev_client_closed() callback, which in turn calls
qio_net_listener_set_client_func on a potentially stale object.

If we know we don't want any more clients to connect, and have already
told the listener socket to shut down, then we should not be trying to
update the listener socket's associated function.

Reproducer:

> #!/usr/bin/python3
>
> import os
> from threading import Thread
>
> def start_stop():
>     while 1:
>         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-server-start",
+"arguments":{"addr":{"type":"unix","data":{"path":"/tmp/nbd-sock"}}}}\'')
>         os.system('virsh qemu-monitor-command VM \'{"execute": "nbd-server-stop"}\'')
>
> def nbd_list():
>     while 1:
>         os.system('/path/to/build/qemu-nbd -L -k /tmp/nbd-sock')
>
> def test():
>     sst = Thread(target=start_stop)
>     sst.start()
>     nlt = Thread(target=nbd_list)
>     nlt.start()
>
>     sst.join()
>     nlt.join()
>
> test()

Fixes: CVE-2024-7409
Fixes: 3e7ef738c8 ("nbd/server: CVE-2024-7409: Close stray clients at server-stop")
CC: qemu-stable@nongnu.org
Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240822143617.800419-2-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 3874f5f73c441c52f1c699c848d463b0eda01e4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f73409ae49..b36f41b7c5 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -92,10 +92,13 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
 
 static void nbd_update_server_watch(NBDServerData *s)
 {
-    if (!s->max_connections || s->connections < s->max_connections) {
-        qio_net_listener_set_client_func(s->listener, nbd_accept, NULL, NULL);
-    } else {
-        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+    if (s->listener) {
+        if (!s->max_connections || s->connections < s->max_connections) {
+            qio_net_listener_set_client_func(s->listener, nbd_accept, NULL,
+                                             NULL);
+        } else {
+            qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        }
     }
 }
 
@@ -113,6 +116,7 @@ static void nbd_server_free(NBDServerData *server)
      */
     qio_net_listener_disconnect(server->listener);
     object_unref(OBJECT(server->listener));
+    server->listener = NULL;
     QLIST_FOREACH_SAFE(conn, &server->conns, next, tmp) {
         qio_channel_shutdown(QIO_CHANNEL(conn->cioc), QIO_CHANNEL_SHUTDOWN_BOTH,
                              NULL);
-- 
2.39.2


