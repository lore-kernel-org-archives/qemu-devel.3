Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8649606A92B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=c3EBXAKZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0XT-0007vP-G7; Thu, 05 Nov 2026 11:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xP0XM-0007uu-Sp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:42:05 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xP0XJ-00029j-Jx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:42:04 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.109.249.23])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jL7Pd2skgz7tBr;
 Thu,  5 Nov 2026 16:41:57 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 17:41:56 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Guillaume Vincke
 <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v3 1/2] nbd/client-connection: Fix client returning a closed
 channel
Date: Thu, 5 Nov 2026 17:41:23 +0100
Message-ID: <20261105164124.249395-2-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
References: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 12814148314911097127
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEn9tFPusAA5Q4MqpjZoNzci9VQHLzLko0uQkRTM2DlaAFbwRwjsWYA3SgYuzW9N0fjh4Sfl6p/cqpgLJGf5atzEkfGH8mA7lwLEQeTYGX8Mzyt6Vth5v7GzqtsPvNY8hJmw7I1UHjbL9Wxati8Vbf3SShIjOIPnoKX50VnJJSJcPI7onvv6Oy1NjSye3oA9/gWuiSedOpPcYYW9IXyEmO7L6cHdETzxgAKwThIwZx+JRN1edq71TOWsfeNkaVsxkyjN/1CrJ1M+Pnidq9dUoYmc62gSu9siwv/eRHmy9W1CHJVcVoysXgZ38MyYSpuHxjzw0Xj50ErHGzKgN1XGuYMU0rYfMw3Yle/psUs/4jlqaXb+oL7UzXXicbSA0A9js7YzT2Q7dhaXW6pJMX96nJKCQexs7Mpbq7tsIkXjDJ0HxII2B2T7mc/9dwixdrS2PSVcKzdpjA5wvz193uFNLHymoSF5RfLGuVD3pNDzWh8eYW9rtv9NJZsHd19v2HnHbZibfkT3VriwcYnfNDF1xInhCoipdKWe0JiBwA8DyULCutKwQ3GqAurQsNMojuN5Rl+CbMmgcHYnGTBu42C7I1v234aWp7VE8THV5ZLQz4q41Iv6o/LW+nNFeGjTOt3SoII0LahSxjnAwVRdn24uvzDyozX4JhMryYSliWBrFmHJA
DKIM-Signature: a=rsa-sha256; bh=US8NJbCfg9WNF2BgSiZJeNvLqjLRNqts6mdflstllps=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1793896918; v=1; 
 b=c3EBXAKZhNBURQKDnNatecBb99ctgvMtaNR9vVJ8RptUNyv033Ft8dF93D95U+nVKPRJ8399
 zRj23sjiWF70OawNyBCH4MWnvuNvXotsuuasStMF41uO1zzvmGzcseWVu+p/C7PTzFCDztDSBrT
 397F6ePRJ5GpfkDmqJBscZEs=
Received-SPF: pass client-ip=5.135.90.176;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 nbd/client-connection.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 6a4f080717..aec62934d1 100644
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
2.43.0


