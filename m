Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A4606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=caN3LSlK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzNf-0007zz-W9; Tue, 10 Nov 2026 22:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNd-0007xq-8o
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNb-0006hz-J2
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794369130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1AKJqaPnLKcQBMZBJ4NYyAtNxNC0XPLX9fc9JpHWoI=;
 b=caN3LSlKuOpWUMXbdnc2H/aPoqx81CsHIXGXCY7MNjCG0NvufV28o/l1dnjc16XgqYHF/M
 tnJvs975uIkYZSMUx6rjgXnEmrvup4edoHfH/HCGn2ZzQft87yxwd4+C6GIlXZQSF/45B4
 Wa5/sYbwgcesTYnkJRMHIMGJjIPCWnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-34Ytw5b_OvS1PkMZ6cNa8Q-1; Tue,
 10 Nov 2026 22:52:06 -0500
X-MC-Unique: 34Ytw5b_OvS1PkMZ6cNa8Q-1
X-Mimecast-MFC-AGG-ID: 34Ytw5b_OvS1PkMZ6cNa8Q_1794369125
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F32C180054F; Wed, 11 Nov 2026 03:52:05 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9444300019F; Wed, 11 Nov 2026 03:52:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guillaume Vincke <guillaume.vincke@ovhcloud.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 1/8] nbd/client-connection: Fix client returning a closed
 channel
Date: Tue, 10 Nov 2026 21:51:26 -0600
Message-ID: <20261111035200.1751734-11-eblake@redhat.com>
In-Reply-To: <20261111035200.1751734-10-eblake@redhat.com>
References: <20261111035200.1751734-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261105164124.249395-2-guillaume.vincke@ovhcloud.com>
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


