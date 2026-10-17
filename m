Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD8ECCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9dz-0005yT-6e; Sat, 17 Oct 2026 15:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9d1-0005Jg-4a; Sat, 17 Oct 2026 14:59:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9cx-0003z1-7K; Sat, 17 Oct 2026 14:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263409; bh=YlO931WFFyyG0i+43j3kHDkut8TQMRFC+XiQ8wIamE0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hYi61qTFa1BLHGt+SWVSUkbfm5ARLt1WSKJEWCmeoUakbPiqpqIFjfU8B4zI5IXnd
 2rpAWVZPorQwWzRcbJVLJvLhU8Gm+IlvF16LNyIWnwisXc5nppeAbabb18HxQqy6tN
 Lj4ukFvMNI0NvaQ0VpJCpTp3NpfbTgyxOkqqo17MeIMR9PMZgkt2QYfW/t5js5rICO
 cVR6/gDhEU/sNpkylVzRuHn7qNisoxv3zuAJ5UX6gCPN0uG4PzB5ot+pTWtVwgrlao
 xYfBWqhJ9tvg5CDXNePm0S5g56VdCAEv0XIGbW2IwTEZpbtJ2hUKI6m7A8Lkn1eiVX
 3IHrPhCxPjzJQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0811A1DE6CB;
 Sat, 17 Oct 2026 21:56:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3FEA8443394;
 Sat, 17 Oct 2026 21:56:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 41/63] block: Fix corruption from broken RMW atomicity
Date: Sat, 17 Oct 2026 21:54:57 +0300
Message-ID: <20261017185528.722197-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

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
(cherry picked from commit 0bd5a1b3d60cca595e19bb73eec83307259be671)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/io.c b/block/io.c
index 1e7c8658da..ae28a0ada1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -48,6 +48,9 @@ bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
+static void coroutine_fn
+bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self);
+
 static void GRAPH_RDLOCK
 bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore)
 {
@@ -618,6 +621,7 @@ static void coroutine_fn tracked_request_begin(BdrvTrackedRequest *req,
         .type           = type,
         .co             = qemu_coroutine_self(),
         .serialising    = false,
+        .active_owner   = false,
         .overlap_offset = offset,
         .overlap_bytes  = bytes,
     };
@@ -626,6 +630,15 @@ static void coroutine_fn tracked_request_begin(BdrvTrackedRequest *req,
 
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
 
@@ -686,6 +699,15 @@ bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
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
@@ -807,6 +829,7 @@ void coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
 
     tracked_request_set_serialising(req, align);
     bdrv_wait_serialising_requests_locked(req);
+    req->active_owner = true;
 
     qemu_mutex_unlock(&req->bs->reqs_lock);
 }
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a50..7fb2d228c6 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -80,6 +80,7 @@ typedef struct BdrvTrackedRequest {
     enum BdrvTrackedRequestType type;
 
     bool serialising;
+    bool active_owner;
     int64_t overlap_offset;
     int64_t overlap_bytes;
 
-- 
2.47.3


