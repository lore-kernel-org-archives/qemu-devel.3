Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6798ECFD2F3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 21:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMuqt-0000qp-LW; Sat, 22 Nov 2025 16:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMuqo-0000o1-De; Sat, 22 Nov 2025 16:08:58 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMuqd-00077s-JC; Sat, 22 Nov 2025 16:08:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2947216D30A;
 Sun, 23 Nov 2025 00:03:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D539C3223DE;
 Sun, 23 Nov 2025 00:03:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.22 16/25] qio: Unwatch before notify in QIONetListener
Date: Sat, 22 Nov 2025 23:55:34 +0300
Message-ID: <20251122210344.48374-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
References: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Eric Blake <eblake@redhat.com>

When changing the callback registered with QIONetListener, the code
was calling notify on the old opaque data prior to actually removing
the old GSource objects still pointing to that data.  Similarly,
during finalize, it called notify before tearing down the various
GSource objects tied to the data.

In practice, a grep of the QEMU code base found that every existing
client of QIONetListener passes in a NULL notifier (the opaque data,
if non-NULL, outlives the NetListener and so does not need cleanup
when the NetListener is torn down), so this patch has no impact.  And
even if a caller had passed in a reference-counted object with a
notifier of object_unref but kept its own reference on the data, then
the early notify would merely reduce a refcount from (say) 2 to 1, but
not free the object.  However, it is a latent bug waiting to bite any
future caller that passes in data where the notifier actually frees
the object, because the GSource could then trigger a use-after-free if
it loses the race on a last-minute client connection resulting in the
data being passed to one final use of the async callback.

Better is to delay the notify call until after all GSource that have
been given a copy of the opaque data are torn down.

CC: qemu-stable@nongnu.org
Fixes: 530473924d "io: introduce a network socket listener API", v2.12.0
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113011625.878876-18-eblake@redhat.com>
(cherry picked from commit 6e03d5cdc991f5db86969fc6aeaca96234426263)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/net-listener.c b/io/net-listener.c
index 99c3ef0fdb..70e70c49fb 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -150,13 +150,6 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 
     trace_qio_net_listener_unwatch(listener, listener->io_func,
                                    "set_client_func");
-    if (listener->io_notify) {
-        listener->io_notify(listener->io_data);
-    }
-    listener->io_func = func;
-    listener->io_data = data;
-    listener->io_notify = notify;
-
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -165,6 +158,13 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
         }
     }
 
+    if (listener->io_notify) {
+        listener->io_notify(listener->io_data);
+    }
+    listener->io_func = func;
+    listener->io_data = data;
+    listener->io_notify = notify;
+
     trace_qio_net_listener_watch(listener, listener->io_func,
                                  "set_client_func");
     if (listener->io_func != NULL) {
@@ -302,10 +302,10 @@ static void qio_net_listener_finalize(Object *obj)
     QIONetListener *listener = QIO_NET_LISTENER(obj);
     size_t i;
 
+    qio_net_listener_disconnect(listener);
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
-    qio_net_listener_disconnect(listener);
 
     for (i = 0; i < listener->nsioc; i++) {
         object_unref(OBJECT(listener->sioc[i]));
-- 
2.47.3


