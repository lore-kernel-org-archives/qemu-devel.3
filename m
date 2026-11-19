Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28D60A260E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=fDi8YL5A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3Q6-0004Tk-N8; Thu, 19 Nov 2026 09:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pv-0004R1-Ab
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:47:17 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pp-0006D3-6l
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:47:12 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.58.62])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jVhBR26w5z7tDX;
 Thu, 19 Nov 2026 14:46:55 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 15:46:54 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <stefanha@redhat.com>,
 <fam@euphon.net>, Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 1/5] block/nbd: Extract request slot access and reconnection
Date: Thu, 19 Nov 2026 15:46:28 +0100
Message-ID: <20261119144632.232457-2-guillaume.vincke@ovhcloud.com>
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
x-ovh-tracer-id: 855402457656345053
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGNg8ZCMaeiEnm5IiUVUXzyhKI0RFBvxIMqnEJ1I1WQBifGe+C255M2IP0G0oWwZb95OrcL5+U9se63SmfHP1skwQNw0BHULBhUyMYdnupKYkpfuuR1RI2c5UPKJsDR7j/nHiZdWNolzrdPyEO5DQhbUqw9XIZodjSC+aDIVoGPaOOVVxvj7Pqs76s0IA/EFdC0FUElNYEy0+T4i10kgByx8od1JLgleLsDF7qdMs+jPuI19ToRtfq/1MPyRVV0JiTq9eQ7bqdj3CCbZQr5kSSqXcMYxKz0CpTFQ12zS0XiddxzOc6C5ovjxPdWBRPRRCfBxBreIMLVmpqeV73oSJOjp6/baUZGhQgbGbheaU84EXGdxYuY7KNdDzCgBpaaRsBUnZpNNngMKTUzSw25kLBgLxQywG6EYDCyIJurccft5E/hr6iDS8kCDz7TAPaKImuPPRCH69uhQwRs11GBjZx8UX02aD1lkvTr9VD/2SlAO2ECcmBHJsXk9i5SbqoiuPYJlcY4j49znft/zi8HnGGivS4SsNzKuQPR4jiCmWZBu7PHfKTPO1riB2v4j8HZu0OU1XTEBsS9IwZYhfo4m4qIoGMv83teMBTO6PkNLo/O+l9N2JaVkNwsSEhvF4GWdU5gH0rulwENSKbnHYEVRMjZipv8W1n16coIgETxB4pWdA
DKIM-Signature: a=rsa-sha256; bh=pkivKi2mGSn86PSOqWBospvkalCrAdgbwZmI0PynFMg=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795099615; v=1; 
 b=fDi8YL5A9rDPs3Y8rWckrj5fwFzUiRnsFmvaNDo0gEGL++MHSHqJG3seNbupONGZ+U2beNeB
 b5uZ8GuSOxzURpF17WxxwJ/EuqHtXpozqz2RV3ks9wPZkYncswZezP5ECmEnQoAd3v9JgqHqisS
 CTd6rkFfbXSVcA1fwLfeVP8c=
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

The number of concurrent requests in the NBD block driver is bounded by
MAX_NBD_REQUESTS. When reaching that level of concurrency, we park
coroutines in a queue and, on completion, we resume the first. That
logic is implemented in nbd_co_send_request().
Coroutines also get queued when the channel is disconnected to make
sure only one request triggers reconnection.

This patch extracts nbd_co_acquire_slot(), nbd_co_release_slot() and
nbd_co_reconnect() out of the request sending. This will help use
nbd_reconnect_attempt() outside of the request sending logic in a later
patch of the series.

No functional change.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 block/nbd.c | 56 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 49f585eab5..df72b17ade 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -510,6 +510,41 @@ err:
     return ret;
 }
 
+/*
+ * Parks until a slot in the request queue is available or when, being the only
+ * in flight operation running, the caller is ready to run reconnection.
+ * Increments s->in_flight on return.
+ * Called with s->requests_lock held.
+ */
+static void coroutine_fn nbd_co_acquire_slot(BDRVNBDState *s)
+{
+    while (s->in_flight == MAX_NBD_REQUESTS ||
+           (s->state != NBD_CLIENT_CONNECTED && s->in_flight > 0)) {
+        qemu_co_queue_wait(&s->free_sema, &s->requests_lock);
+    }
+    s->in_flight++;
+}
+
+/* Called with s->requests_lock held. */
+static void coroutine_fn nbd_co_release_slot(BDRVNBDState *s)
+{
+    s->in_flight--;
+    qemu_co_queue_next(&s->free_sema);
+}
+
+/* Called with s->requests_lock held. */
+static int coroutine_fn GRAPH_RDLOCK nbd_co_reconnect(BDRVNBDState *s)
+{
+    if (nbd_client_connecting(s)) {
+        nbd_reconnect_attempt(s);
+        qemu_co_queue_restart_all(&s->free_sema);
+    }
+    if (s->state != NBD_CLIENT_CONNECTED) {
+        return -EIO;
+    }
+    return 0;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,
                     QEMUIOVector *qiov)
@@ -518,19 +553,10 @@ nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,
     int rc, i = -1;
 
     qemu_mutex_lock(&s->requests_lock);
-    while (s->in_flight == MAX_NBD_REQUESTS ||
-           (s->state != NBD_CLIENT_CONNECTED && s->in_flight > 0)) {
-        qemu_co_queue_wait(&s->free_sema, &s->requests_lock);
-    }
-
-    s->in_flight++;
+    nbd_co_acquire_slot(s);
     if (s->state != NBD_CLIENT_CONNECTED) {
-        if (nbd_client_connecting(s)) {
-            nbd_reconnect_attempt(s);
-            qemu_co_queue_restart_all(&s->free_sema);
-        }
-        if (s->state != NBD_CLIENT_CONNECTED) {
-            rc = -EIO;
+        rc = nbd_co_reconnect(s);
+        if (rc != 0) {
             goto err;
         }
     }
@@ -573,8 +599,7 @@ err:
         if (i != -1) {
             s->requests[i].coroutine = NULL;
         }
-        s->in_flight--;
-        qemu_co_queue_next(&s->free_sema);
+        nbd_co_release_slot(s);
         qemu_mutex_unlock(&s->requests_lock);
     }
     return rc;
@@ -1085,8 +1110,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
 break_loop:
     qemu_mutex_lock(&s->requests_lock);
     nbd_request_by_cookie(s, cookie, &error_abort)->coroutine = NULL;
-    s->in_flight--;
-    qemu_co_queue_next(&s->free_sema);
+    nbd_co_release_slot(s);
     qemu_mutex_unlock(&s->requests_lock);
 
     return false;
-- 
2.43.0


