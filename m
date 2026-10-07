Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9384ACA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcs-0004yY-2e; Wed, 07 Oct 2026 12:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUba-000327-1W
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbV-0006Og-VP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIF0St3KCIh2pMDuUdt0923blCovb+WQcXz//wWJXDE=;
 b=b3Y3Q9nRQ5jjFBG6P38vX+p/vFbb9pZvh5VnE7/juOs6SFQYKp/yfeEDAl4OUo2Fo9Y+qK
 m77uLA1NqqSe89jwbVbWTpRPUi23jy/rB1SJWG93mav7to+Ciu6ItBGOG5eKSRa1Q65Nyq
 cbHXIwu4mn2JYpqQ0fJWPLohp0juFKQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-TA9p1wvcMBSVPkn_m1RBWA-1; Wed,
 07 Oct 2026 12:34:51 -0400
X-MC-Unique: TA9p1wvcMBSVPkn_m1RBWA-1
X-Mimecast-MFC-AGG-ID: TA9p1wvcMBSVPkn_m1RBWA_1791390890
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12E68192D0A9; Wed,  7 Oct 2026 16:34:50 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B50351956087; Wed,  7 Oct 2026 16:34:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 20/21] block: Fix corruption from broken RMW atomicity
Date: Wed,  7 Oct 2026 18:33:01 +0200
Message-ID: <20261007163302.332250-21-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When emulating 512 byte sector devices on top of 4k native host storage,
QEMU performs a read-modify-write cycle for misaligned write requests.
These requests are marked as serialising so that any other writes to the
same 4k block will have to wait and can't overwrite the block in the
middle, which would make the RMW write back stale data.

In principle, this mechanism works fine, but there is a race condition
in the implementation: bdrv_find_conflicting_request() assumes that
req->waiting_for == NULL means that the request is the active owner of
the data blocks it touches and everyone else has to wait for this
request. However, there is a window between tracked_request_begin() and
bdrv_wait_serialising_requests_locked() where any new request has
req->waiting_for == NULL even if it conflicts with an already running
serialising request. So at this point, we have seemingly two active
owners at the same time until the new request checks for conflicts.

For a third request coming in, this isn't a problem, it just might wait
for a little longer than necessary. However, if the original RMW request
calls bdrv_wait_serialising_requests_locked() again (which it does in
bdrv_aligned_pwritev() -> bdrv_co_write_req_prepare() before writing
back the RMW buffer), it will now wait on the other request that snuck
in, which is fatal and makes the RMW buffer stale. This scenario causes
data corruption.

Fix this by checking for conflicts already in tracked_request_begin()
while holding the bs->reqs_lock mutex, so that the race window is closed
and req->waiting_for == NULL really has the intended meaning.

For good measure, add an active_owner boolean that is set when a request
is marked serialising and has completed waiting for other requests, and
assert that it is not set when waiting for another request, so that in
the case of another bug, we'd crash instead of causing data corruption.

Cc: qemu-stable@nongnu.org
Buglink: https://redhat.atlassian.net/browse/RHEL-272836
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20261002132135.93345-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h |  1 +
 block/io.c                       | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f7..46428b034de 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -80,6 +80,7 @@ typedef struct BdrvTrackedRequest {
     enum BdrvTrackedRequestType type;
 
     bool serialising;
+    bool active_owner;
     int64_t overlap_offset;
     int64_t overlap_bytes;
 
diff --git a/block/io.c b/block/io.c
index a916b236c3c..bd562d472fd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -50,6 +50,9 @@
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
+static void coroutine_fn
+bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self);
+
 static void GRAPH_RDLOCK
 bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore)
 {
@@ -616,6 +619,7 @@ static void coroutine_fn tracked_request_begin(BdrvTrackedRequest *req,
         .type           = type,
         .co             = qemu_coroutine_self(),
         .serialising    = false,
+        .active_owner   = false,
         .overlap_offset = offset,
         .overlap_bytes  = bytes,
     };
@@ -624,6 +628,15 @@ static void coroutine_fn tracked_request_begin(BdrvTrackedRequest *req,
 
     qemu_mutex_lock(&bs->reqs_lock);
     QLIST_INSERT_HEAD(&bs->tracked_requests, req, list);
+
+    /*
+     * Set .waiting_for while we're holding the lock, otherwise we'd open a race
+     * window where another request in the middle of its RMW cycle starts
+     * waiting for us, leading to potential data corruption if this request
+     * overwrites a block the RMW request has already read.
+     */
+    bdrv_wait_serialising_requests_locked(req);
+
     qemu_mutex_unlock(&bs->reqs_lock);
 }
 
@@ -684,6 +697,15 @@ bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
     BdrvTrackedRequest *req;
 
     while ((req = bdrv_find_conflicting_request(self))) {
+        /*
+         * If this request is the active owner of the data blocks it accesses,
+         * no other conflicting request may exist; other requests have to wait
+         * for this one, not the other way around. If this condition is
+         * violated, RMW operations may be interrupted in the middle, operate on
+         * stale data and introduce data corruption.
+         */
+        assert(!self->active_owner);
+
         self->waiting_for = req;
         qemu_co_queue_wait(&req->wait_queue, &self->bs->reqs_lock);
         self->waiting_for = NULL;
@@ -803,6 +825,7 @@ void coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
 
     tracked_request_set_serialising(req, align);
     bdrv_wait_serialising_requests_locked(req);
+    req->active_owner = true;
 
     qemu_mutex_unlock(&req->bs->reqs_lock);
 }
-- 
2.56.0


