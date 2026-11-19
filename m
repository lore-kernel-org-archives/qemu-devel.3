Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C4606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=IjwTBi4b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3Q6-0004Tw-OT; Thu, 19 Nov 2026 09:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pv-0004R3-Ai; Thu, 19 Nov 2026 09:47:17 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pp-0006DA-Jo; Thu, 19 Nov 2026 09:47:13 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.0.133])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jVhBS1ckDz7tDg;
 Thu, 19 Nov 2026 14:46:56 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 15:46:55 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <stefanha@redhat.com>,
 <fam@euphon.net>, Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 3/5] block/nbd: Refresh the connection on block_resize
Date: Thu, 19 Nov 2026 15:46:30 +0100
Message-ID: <20261119144632.232457-4-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 855683929345114589
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGOS8EGrX643+ovyXsH+QFTmB5aOgoJ08jxUdSO/s6XgvT7M/VuQQ/Ds/8vMAVUddgP1bWDSw41OV9jyN0q52MhAPgS0yoC2ODGuYv1BBob7jhQ7dDNOfGz7zhBa7QJumewrS892C6gqnCQx9qVlOOB+KxYueih+lDUybnRAI53OitkcpkFTDvwmUxZnALuqa95QZrlzfljSUx8on3qABkAFuxLMjxQP7sm7omnCeHybC2x1J2w07QRuPY6b/1YmXdD271GM23xOVXa9HL1eexNQ/d+NppEKUVhgxm4GKbkD1Pt3B/0ooUNcyKYtby1iye42fekcpfDjPqPXYgcnp0LgOl5mlkJCyQuhgCd48i0hN/s+zx3P9wyeOjFnzin8r2vniNgSKVuZx3khYp80nKt6uQhrUP7FREiOxIBZdpSMwHCo/ovPjWyWU839tM6N4IescdiLITSzZpP6Hit1mUZ5eDYBKsqNH/IkVJ8hu7VOsgMw3BwD2S4+DSgifXHVuDVTg1jOs8MVg7wGcKHlzBaG3AIgNFSc74Y4tzsfQd1nTiLDG+4o2tRV6MfcYbsIxSkz8E263CWxezyhMhifdTTWGBrB+maeFj3qusnU2OHoXPruALoAuefb3FWrfuMTxIcmvvQDJrfuEYc3igiqbM1T+MAFswTwfhY5UcbPas4iA
DKIM-Signature: a=rsa-sha256; bh=3jEj/wqTF6rn/9Et/Rm6BzNnE8rRvY2zcwSFs49RLgE=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795099616; v=1; 
 b=IjwTBi4bstKlJlJQIygsHAiPEI7C9ZxoYmBBi04lepfKmtIRFKSTFWhkmwzC7MjDKJVt3tED
 PWLnQWSrzQ/v+EaA7OC0Une6MJup6jpSsajvoMJADActzFEAG8LF+PmJAZzbOxt9MwvhikrhSAh
 WeWNiS9cRupNWgmrC6atJmKw=
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

When an NBD device is resized, two steps are needed to propagate the
information. First, as the size is only exchanged at handshake, the
connection needs to be reset. Then, the new size needs to be updated by
calling bdrv_co_refresh_total_sectors().
The QMP block_resize method, by calling bdrv_co_truncate(), takes care
of the second step but, considering the NBD connection is lazy, nothing
deals with reconnection when the device is idle.

This patch uses the new bdrv_co_refresh_connection() to force the
handshake by manually starting the reconnection routine.
It creates a clean flow to resize an NBD-backed block device on the
server side by closing the connection and calling block_resize.
When the node is configured with reconnect-delay=0, refreshing starts
the reconnection but returns immediately with -EIO. The management
application can handle this case by waiting for the connection to be
established and re-running block_resize.

To detect disconnection, we peek the channel. This does not detect dead
peers or disconnected TLS-secured connections. Therefore, this flow
will not work if the server does not disconnect cleanly or if the
communication is encrypted.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 block/nbd.c             | 39 +++++++++++++++++++++++++++++++++++++++
 include/block/nbd.h     |  1 +
 nbd/client-connection.c |  7 +++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index df72b17ade..759a6ef480 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -2081,6 +2081,42 @@ static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
+/*
+ * Start the reconnection routine unless the node is connected and its channel
+ * is still open. When used with a zero reconnect-delay, this function
+ * triggers the reconnection and returns -EIO.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+nbd_co_refresh_connection(BlockDriverState *bs, Error **errp)
+{
+    BDRVNBDState *s = bs->opaque;
+    int ret;
+
+    QEMU_LOCK_GUARD(&s->requests_lock);
+
+    if (s->state == NBD_CLIENT_QUIT) {
+        error_setg(errp, "Cannot refresh a permanently unavailable NBD node");
+        return -ECONNREFUSED;
+    }
+
+    if (s->state == NBD_CLIENT_CONNECTED) {
+        if (!nbd_channel_is_closed(s->ioc)) {
+            return 0;
+        }
+        /* A connection closed by its peer is treated as an error */
+        nbd_channel_error_locked(s, -EIO);
+    }
+
+    nbd_co_acquire_slot(s);
+    ret = nbd_co_reconnect(s);
+    nbd_co_release_slot(s);
+
+    if (ret < 0) {
+        error_setg(errp, "Failed to reconnect NBD node");
+    }
+    return ret;
+}
+
 static int64_t coroutine_fn nbd_co_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
@@ -2205,6 +2241,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
     .bdrv_co_truncate           = nbd_co_truncate,
+    .bdrv_co_refresh_connection = nbd_co_refresh_connection,
     .bdrv_co_getlength          = nbd_co_getlength,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
@@ -2233,6 +2270,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
     .bdrv_co_truncate           = nbd_co_truncate,
+    .bdrv_co_refresh_connection = nbd_co_refresh_connection,
     .bdrv_co_getlength          = nbd_co_getlength,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
@@ -2261,6 +2299,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
     .bdrv_co_truncate           = nbd_co_truncate,
+    .bdrv_co_refresh_connection = nbd_co_refresh_connection,
     .bdrv_co_getlength          = nbd_co_getlength,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 15ddec91ac..b459788534 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -508,6 +508,7 @@ NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
                                                QCryptoTLSCreds *tlscreds,
                                                const char *tlshostname);
 void nbd_client_connection_release(NBDClientConnection *conn);
+bool nbd_channel_is_closed(QIOChannel *ioc);
 
 QIOChannel *coroutine_fn
 nbd_co_establish_connection(NBDClientConnection *conn, NBDExportInfo *info,
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 78caea3c37..e6e346d9fc 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -296,8 +296,11 @@ void nbd_client_connection_release(NBDClientConnection *conn)
     }
 }
 
-/* Only true when the peer closed the channel. Does not detect if dead. */
-static bool nbd_channel_is_closed(QIOChannel *ioc)
+/*
+ * Only true when the peer closed the channel. Always returns false for TLS
+ * channels. Does not detect if dead.
+ */
+bool nbd_channel_is_closed(QIOChannel *ioc)
 {
     char data;
     struct iovec iov = { .iov_base = &data, .iov_len = 1 };
-- 
2.43.0


