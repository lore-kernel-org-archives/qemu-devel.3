Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB94DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrU-0008B1-Vw; Tue, 19 May 2026 13:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrQ-00088y-B4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrN-0004Ml-GT
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4/SuyQT4c25nLjf32oOO7pmyp/Ryy5z/5FjiQtnlRc=;
 b=V+CgiViiXxXIwxViwUqbam+fzP8xIoV1x4vvM/l4WJgv3R4Qexj+Dtuedvniv6yXxBO3xU
 cjr4MBf4wId/NC9P2lRIVf/pJy6MrJSjo6UFs6L1Pi9+gpMFAS7OstYUnBRVS4aUIVmN0F
 /Y3jKGf/TzB2NQKwan7KbQhp8hXsgvY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-86BOZv1lOpmxX3NrY1AlSw-1; Tue,
 19 May 2026 13:03:57 -0400
X-MC-Unique: 86BOZv1lOpmxX3NrY1AlSw-1
X-Mimecast-MFC-AGG-ID: 86BOZv1lOpmxX3NrY1AlSw_1779210236
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF28A1800367; Tue, 19 May 2026 17:03:56 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E9591681; Tue, 19 May 2026 17:03:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/18] qcow2: Fix corruption on discard during write with COW
Date: Tue, 19 May 2026 19:03:14 +0200
Message-ID: <20260519170317.345032-16-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Most code in qcow2 that accesses (and potentially modifies) L2 tables
does so while holding s->lock.

There is one exception, which is allocating writes. They hold the lock
initially while allocating clusters, but drop it for writing the guest
payload before taking the lock again for updating the L2 tables. This
allows concurrent requests that touch other parts of the image file to
continue in parallel and is an important performance optimisation.

However, this means that other requests that run while the lock is
dropped for writing guest data must synchronise with the list of
allocating requests in s->cluster_allocs and wait if they would overlap.
For writes, this is done in handle_dependencies(), but discard and write
zeros operations neglect to synchronise with s->cluster_allocs.

This means that discard can free a cluster whose L2 entry will already
be modified in qcow2_alloc_cluster_link_l2() by a previously started
write. In the case of a pre-allocated zero cluster that is in the
process of being overwritten, this means that discard can lead to a
situation where the cluster is still mapped (because the write will
restore the L2 entry just without the zero flag), but its refcount has
been decreased, resulting in a corrupted image.

Add the missing synchronisation to qcow2_cluster_discard() and
qcow2_subcluster_zeroize() to fix the problem.

Cc: qemu-stable@nongnu.org
Reported-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260427170520.101242-4-kwolf@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Tested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 52 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index c655bf6df42..8b1e80bd0b3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1392,6 +1392,9 @@ count_single_write_clusters(BlockDriverState *bs, int nb_clusters,
  * the same cluster. In this case we need to wait until the previous
  * request has completed and updated the L2 table accordingly.
  *
+ * If allow_shortening == true, instead of waiting for a dependency, *cur_bytes
+ * can be shortened so that the cluster allocations don't overlap.
+ *
  * Returns:
  *   0       if there was no dependency. *cur_bytes indicates the number of
  *           bytes from guest_offset that can be read before the next
@@ -1403,7 +1406,9 @@ count_single_write_clusters(BlockDriverState *bs, int nb_clusters,
  */
 static int coroutine_fn handle_dependencies(BlockDriverState *bs,
                                             uint64_t guest_offset,
-                                            uint64_t *cur_bytes, QCowL2Meta **m)
+                                            uint64_t *cur_bytes,
+                                            bool allow_shortening,
+                                            QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowL2Meta *old_alloc;
@@ -1434,7 +1439,7 @@ static int coroutine_fn handle_dependencies(BlockDriverState *bs,
 
         /* Conflict */
 
-        if (start < old_start) {
+        if (start < old_start && allow_shortening) {
             /* Stop at the start of a running allocation */
             bytes = old_start - start;
         } else {
@@ -1469,6 +1474,29 @@ static int coroutine_fn handle_dependencies(BlockDriverState *bs,
     return 0;
 }
 
+static void coroutine_mixed_fn wait_for_dependencies(BlockDriverState *bs,
+                                                     uint64_t guest_offset,
+                                                     uint64_t bytes)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCowL2Meta *m = NULL;
+    int ret;
+
+    /*
+     * Discard has some non-coroutine callers (creating internal snapshots and
+     * make empty). They are calling from qemu-img or in a drained section, so
+     * we know that no writes can be in progress.
+     */
+    if (!qemu_in_coroutine()) {
+        assert(QLIST_EMPTY(&s->cluster_allocs));
+        return;
+    }
+
+    do {
+        ret = handle_dependencies(bs, guest_offset, &bytes, false, &m);
+    } while (ret == -EAGAIN);
+}
+
 /*
  * Checks how many already allocated clusters that don't require a new
  * allocation there are at the given guest_offset (up to *bytes).
@@ -1840,7 +1868,7 @@ again:
          *         the right synchronisation between the in-flight request and
          *         the new one.
          */
-        ret = handle_dependencies(bs, start, &cur_bytes, m);
+        ret = handle_dependencies(bs, start, &cur_bytes, true, m);
         if (ret == -EAGAIN) {
             /* Currently handle_dependencies() doesn't yield if we already had
              * an allocation. If it did, we would have to clean up the L2Meta
@@ -2000,6 +2028,15 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
     int64_t cleared;
     int ret;
 
+    /*
+     * If we're touching a cluster for which allocating writes are in flight,
+     * wait for them to complete to avoid conflicting metadata updates.
+     *
+     * We don't need to allocate a QCowL2Meta for the discard operation because
+     * s->lock is held for the duration of the whole operation.
+     */
+    wait_for_dependencies(bs, offset, bytes);
+
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
@@ -2160,6 +2197,15 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
     int64_t cleared;
     int ret;
 
+    /*
+     * If we're touching a cluster for which allocating writes are in flight,
+     * wait for them to complete to avoid conflicting metadata updates.
+     *
+     * We don't need to allocate a QCowL2Meta for the zeroize operation because
+     * s->lock is held for the duration of the whole operation.
+     */
+    wait_for_dependencies(bs, offset, bytes);
+
     /* If we have to stay in sync with an external data file, zero out
      * s->data_file first. */
     if (data_file_is_raw(bs)) {
-- 
2.54.0


