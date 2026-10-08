Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453BDCA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnvh-0002k5-P5; Thu, 08 Oct 2026 09:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvf-0002jL-Sz
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnve-0002Rh-De
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFrlMC8yeBQt7DzcMZs87HsbIFlEIHwemI/smmRJrOs=;
 b=WWyDr63VwRuzjATwEXJvd7QjngOFeOlWneuZ0xI66Wrp5CcoZcP84R2EosMiX+qVoRl98x
 FyckrCnf3mrw7qc4Do6WOdcrOTFIlS3GqWxqm3z0HfNwq/jq0Hjn64z1yLfTXaSRnUHw2C
 Sr+Kmd6pwzTjcpBNqWTNHfkVOMXFgzA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-tAiGAsBCPHeWlzqmSbJHRw-1; Thu,
 08 Oct 2026 09:12:54 -0400
X-MC-Unique: tAiGAsBCPHeWlzqmSbJHRw-1
X-Mimecast-MFC-AGG-ID: tAiGAsBCPHeWlzqmSbJHRw_1791465173
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F017B18088B7; Thu,  8 Oct 2026 13:12:52 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95E7330001BB; Thu,  8 Oct 2026 13:12:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guillaume Vincke <guillaume.vincke@ovhcloud.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 07/15] nbd/client-connection: Fix client returning a closed
 channel
Date: Thu,  8 Oct 2026 08:11:46 -0500
Message-ID: <20261008131216.2437896-24-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>

When a server closes the connection after a successful handshake but
before running any operations, the channel returned by
nbd_co_establish_connection() is the closed one and the connect thread
is not started.

When configured with reconnect-delay=0 (the default), this situation
generates at least two IO errors. The first one happens when trying to
issue an operation to the closed socket. The connect thread will be
started on the next request, which may happen long after, and will
create the second error as nbd_co_establish_connection() returns a NULL
channel.

Peeking the channel to detect FIN or RST avoids the first IO error and
does not delay the starting of the connect thread.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Message-ID: <20260925155346.357703-2-guillaume.vincke@ovhcloud.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: minor formatting changes]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client-connection.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 6a4f0807170..aec62934d1a 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -274,6 +274,23 @@ void nbd_client_connection_release(NBDClientConnection *conn)
     }
 }

+/* Only true when the peer closed the channel. Does not detect if dead. */
+static bool nbd_channel_is_closed(QIOChannel *ioc)
+{
+    char data;
+    struct iovec iov = { .iov_base = &data, .iov_len = 1 };
+    ssize_t len = -1;
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+        return false;
+    }
+
+    len = qio_channel_readv_full(
+        ioc, &iov, 1, NULL, NULL, QIO_CHANNEL_READ_FLAG_MSG_PEEK, NULL);
+
+    return len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK);
+}
+
 /*
  * Get a new connection in context of @conn:
  *   if the thread is running, wait for completion
@@ -295,6 +312,7 @@ nbd_co_establish_connection(NBDClientConnection *conn, NBDExportInfo *info,
                             bool blocking, Error **errp)
 {
     QemuThread thread;
+    QIOChannel *ioc;

     if (conn->do_negotiation) {
         assert(info);
@@ -308,6 +326,20 @@ nbd_co_establish_connection(NBDClientConnection *conn, NBDExportInfo *info,
         assert(!conn->wait_co);

         if (!conn->running) {
+            if (conn->sioc) {
+                /* discard if the socket got closed by its peer */
+                ioc = QIO_CHANNEL(conn->sioc);
+                if (!qio_channel_set_blocking(ioc, false, NULL) ||
+                    nbd_channel_is_closed(ioc)) {
+
+                    qio_channel_close(ioc, NULL);
+                    object_unref(OBJECT(conn->sioc));
+                    conn->sioc = NULL;
+                    object_unref(OBJECT(conn->ioc));
+                    conn->ioc = NULL;
+                }
+            }
+
             if (conn->sioc) {
                 /* Previous attempt finally succeeded in background */
                 if (conn->do_negotiation) {
-- 
2.56.0


