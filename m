Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE58DCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSLj-0006fk-Sm; Wed, 10 Apr 2024 03:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKr-0005JN-TT; Wed, 10 Apr 2024 03:25:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKq-0004W9-Al; Wed, 10 Apr 2024 03:25:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E5845D68D;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3506DB02CE;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191737 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 30/87] nbd/server: Fix race in draining the export
Date: Wed, 10 Apr 2024 10:22:03 +0300
Message-Id: <20240410072303.4191455-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Kevin Wolf <kwolf@redhat.com>

When draining an NBD export, nbd_drained_begin() first sets
client->quiescing so that nbd_client_receive_next_request() won't start
any new request coroutines. Then nbd_drained_poll() tries to makes sure
that we wait for any existing request coroutines by checking that
client->nb_requests has become 0.

However, there is a small window between creating a new request
coroutine and increasing client->nb_requests. If a coroutine is in this
state, it won't be waited for and drain returns too early.

In the context of switching to a different AioContext, this means that
blk_aio_attached() will see client->recv_coroutine != NULL and fail its
assertion.

Fix this by increasing client->nb_requests immediately when starting the
coroutine. Doing this after the checks if we should create a new
coroutine is okay because client->lock is held.

Cc: qemu-stable@nongnu.org
Fixes: fd6afc501a01 ("nbd/server: Use drained block ops to quiesce the server")
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240314165825.40261-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 9c707525cbb1dd1e56876e45c70c0c08f2876d41)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/nbd/server.c b/nbd/server.c
index f8738f6d27..091b57119e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -3010,8 +3010,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
 /* Owns a reference to the NBDClient passed as opaque.  */
 static coroutine_fn void nbd_trip(void *opaque)
 {
-    NBDClient *client = opaque;
-    NBDRequestData *req = NULL;
+    NBDRequestData *req = opaque;
+    NBDClient *client = req->client;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
     int ret;
     Error *local_err = NULL;
@@ -3040,8 +3040,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto done;
     }
 
-    req = nbd_request_get(client);
-
     /*
      * nbd_co_receive_request() returns -EAGAIN when nbd_drained_begin() has
      * set client->quiescing but by the time we get back nbd_drained_end() may
@@ -3115,9 +3113,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
 done:
-    if (req) {
-        nbd_request_put(req);
-    }
+    nbd_request_put(req);
 
     qemu_mutex_unlock(&client->lock);
 
@@ -3146,10 +3142,13 @@ disconnect:
  */
 static void nbd_client_receive_next_request(NBDClient *client)
 {
+    NBDRequestData *req;
+
     if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS &&
         !client->quiescing) {
         nbd_client_get(client);
-        client->recv_coroutine = qemu_coroutine_create(nbd_trip, client);
+        req = nbd_request_get(client);
+        client->recv_coroutine = qemu_coroutine_create(nbd_trip, req);
         aio_co_schedule(client->exp->common.ctx, client->recv_coroutine);
     }
 }
-- 
2.39.2


