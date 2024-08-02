Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37057C3DA64
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 01:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZhPT-0000Ye-NG; Thu, 01 Aug 2024 21:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPS-0000SP-4h
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPQ-0001xO-MI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722563324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxAzcDsi1iz86GOHCJ9ayawpjFUbZ6PZtv8LMf8bBW0=;
 b=M7O6eLLLaIjMrWa6/4FyG4T/33dnxb/zUQqeCc2+aBBVgRCTg9k8fsgJqOOLhR93CY6/dl
 tCl1DfwvM4gjTcZ4ajHoY7ivxvAEBWhu3oPuGsCh2QHWSh+5vLEvyFj6z4ufZ3TojNa+4K
 YWIkJnpt6R/Zw5GIG5Wjsa3bcY+M3lM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-26CX9LkqPM2VV-ViySvhKQ-1; Thu,
 01 Aug 2024 21:48:40 -0400
X-MC-Unique: 26CX9LkqPM2VV-ViySvhKQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73EA71955D47; Fri,  2 Aug 2024 01:48:38 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44487195605A; Fri,  2 Aug 2024 01:48:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v2 2/3] nbd: CVE-XXX: Close stray client sockets at server
 shutdown
Date: Thu,  1 Aug 2024 20:32:07 -0500
Message-ID: <20240802014824.1906798-7-eblake@redhat.com>
In-Reply-To: <20240802014824.1906798-5-eblake@redhat.com>
References: <20240802014824.1906798-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
intentionally not progress in the handshake.  This can form a resource
leak for as long as the client wants, when the client does not catch
our attention by failing to provide TLS credentials; although it can
be bounded by max-connections per NBD server that does not use the
default of unlimited.  Better is to forcefully disconnect any
remaining client sockets when the NBD server is shut down.  While less
severe than the issue fixed in the previous patch, this can still be
considered defense against a potential denial of service attack, so it
is still categorized under the same CVE.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

I do not know if I need to worry about multi-threaded access (is it
possible that more than one client trying to connect simultaneously
means that I need to access nbd_server->conns atomically)?

 blockdev-nbd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 1ddcbd7b247..9bbd86ebc31 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -21,12 +21,18 @@
 #include "io/channel-socket.h"
 #include "io/net-listener.h"

+typedef struct NBDConn {
+    QIOChannelSocket *cioc;
+    QSLIST_ENTRY(NBDConn) next;
+} NBDConn;
+
 typedef struct NBDServerData {
     QIONetListener *listener;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
     uint32_t max_connections;
     uint32_t connections;
+    QSLIST_HEAD(, NBDConn) conns;
 } NBDServerData;

 static NBDServerData *nbd_server;
@@ -65,8 +71,13 @@ static void nbd_blockdev_client_closed(NBDClient *client, uint32_t cookie,
 static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
                        gpointer opaque)
 {
+    NBDConn *conn = g_new0(NBDConn, 1);
+
     assert(nbd_server);
     nbd_server->connections++;
+    object_ref(OBJECT(cioc));
+    conn->cioc = cioc;
+    QSLIST_INSERT_HEAD(&nbd_server->conns, conn, next);
     nbd_update_server_watch(nbd_server);

     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
@@ -89,8 +100,21 @@ static void nbd_server_free(NBDServerData *server)
         return;
     }

+    /*
+     * Forcefully close the listener socket, and any clients that have
+     * not yet disconnected on their own.
+     */
     qio_net_listener_disconnect(server->listener);
     object_unref(OBJECT(server->listener));
+    while (!QSLIST_EMPTY(&server->conns)) {
+        NBDConn *conn = QSLIST_FIRST(&server->conns);
+
+        qio_channel_close(QIO_CHANNEL(conn->cioc), NULL);
+        object_unref(OBJECT(conn->cioc));
+        QSLIST_REMOVE_HEAD(&server->conns, next);
+        g_free(conn);
+    }
     if (server->tlscreds) {
         object_unref(OBJECT(server->tlscreds));
     }
-- 
2.45.2


