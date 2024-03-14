Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1B4C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoPu-0006Ri-SY; Thu, 14 Mar 2024 12:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkoPp-0006PQ-Dp
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkoPk-0003Z4-MI
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710435523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31gUSxdMtfnI8RfpkSr3yYSOm01I+BkSu6LhD9mu5aw=;
 b=BHfuMX8qLseNSdQJw7UACHGtcMybTJ9CCLOUQnRovXwOTMKUwMeTIl+zBsxOEgaagVIs2r
 rhYRoX83FRK8ktAH/o894W6zLCbApNskg/6GOnQqnHsX9jYfUlx2cIqUQCJrUxSJWoBtwl
 6DS5EYxfkF1xBl/pcnUxpzB+8HR/Lhw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-aA9h54FHNKSx0T7eS7tCbw-1; Thu, 14 Mar 2024 12:58:39 -0400
X-MC-Unique: aA9h54FHNKSx0T7eS7tCbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B2B089C661;
 Thu, 14 Mar 2024 16:58:39 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFE83111E40C;
 Thu, 14 Mar 2024 16:58:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, aliang@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH for-9.0 1/2] nbd/server: Fix race in draining the export
Date: Thu, 14 Mar 2024 17:58:24 +0100
Message-ID: <20240314165825.40261-2-kwolf@redhat.com>
In-Reply-To: <20240314165825.40261-1-kwolf@redhat.com>
References: <20240314165825.40261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Fixes: fd6afc501a019682d1b8468b562355a2887087bd
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 941832f178..c3484cc1eb 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -3007,8 +3007,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
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
@@ -3037,8 +3037,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto done;
     }
 
-    req = nbd_request_get(client);
-
     /*
      * nbd_co_receive_request() returns -EAGAIN when nbd_drained_begin() has
      * set client->quiescing but by the time we get back nbd_drained_end() may
@@ -3112,9 +3110,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
 done:
-    if (req) {
-        nbd_request_put(req);
-    }
+    nbd_request_put(req);
 
     qemu_mutex_unlock(&client->lock);
 
@@ -3143,10 +3139,13 @@ disconnect:
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
2.44.0


