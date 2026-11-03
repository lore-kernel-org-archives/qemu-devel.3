Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C054606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+wvIiix
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5ce-0006Zx-RX; Mon, 02 Nov 2026 22:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cd-0006Yn-76
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5ca-0000do-W6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0fqfWx9gV3NJq86T/JzOQT8U48EXMHicFem5q0R9Qk=;
 b=h+wvIiixwEkxjdW0Tmqr2JTwJAaEQvRm5bHZyZFA6YYzR8Z64t4UjIN6yFTqyoWMh7bcWo
 bqAa1TfLTMfq8/VtwrZ3kMRta6wu0nakBskYg7pqiCoDsEzfqUEM1brz+lwO9e5OD3bhAI
 W3N0TQLJIDiX1nPwvKz5l+p75z69CsE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-xl6O2bZ6Pb6NTythXl8nag-1; Mon,
 02 Nov 2026 22:55:34 -0500
X-MC-Unique: xl6O2bZ6Pb6NTythXl8nag-1
X-Mimecast-MFC-AGG-ID: xl6O2bZ6Pb6NTythXl8nag_1793678133
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB5D51956073; Tue,  3 Nov 2026 03:55:32 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 529077E2; Tue,  3 Nov 2026 03:55:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 11/16] block/backup: pre-fill zero_bitmap for full/bitmap
Date: Mon,  2 Nov 2026 21:54:22 -0600
Message-ID: <20261103035506.2688772-29-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

Only sync=top runs an up-front scan, so the previous patch did nothing
for the other modes. FULL and BITMAP know their complete copy_bitmap
before copying starts, and the same copy-before-write guarantee holds:
a cluster still dirty when the copy loop reaches it has not been written
since the scan.

Add block_copy_calculate_zero_bitmap(), driven one query at a time from
backup_scan_source() so the graph rdlock and the pause point are taken
per query, and query each confirmed span once however many dirty areas
it covers. Each step searches copy_bitmap only a bounded window ahead,
since for sync=full the rest of the image is one dirty area. The scan
only fills zero_bitmap and never clears copy_bitmap, so sync=full still
writes zeroes for clusters the source never allocated; it just stops
re-querying to find that out. Unlike the per-task queries it replaces
the scan is serial, so a sparsely dirtied job against a slow source may
spend more time here than it saves. The sync=top loop had the same
shape, so both fold into backup_scan_source().

sync=none keeps the per-task query. Its bitmap says "anything may be
copied", not "this will be copied", and it only ever copies what the
guest writes during the fleecing window, so scanning the whole image at
attach is the wrong trade.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-8-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block-copy.h |  4 ++
 block/backup.c             | 98 ++++++++++++++++++++++++--------------
 block/block-copy.c         | 42 ++++++++++++++++
 3 files changed, 108 insertions(+), 36 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index e4e5b567538..3a61066b55f 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -44,6 +44,10 @@ void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes);
 int64_t coroutine_fn GRAPH_RDLOCK
 block_copy_reset_unallocated(BlockCopyState *s, int64_t offset, int64_t *count);

+void coroutine_fn GRAPH_RDLOCK
+block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
+                                 int64_t *cached_end, int64_t *count);
+
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                             bool ignore_ratelimit, uint64_t timeout_ns,
                             BlockCopyAsyncCallbackFunc cb,
diff --git a/block/backup.c b/block/backup.c
index 11d70243e24..38b0838d694 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -247,6 +247,51 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
     job_progress_set_remaining(&job->common.job, estimate);
 }

+/*
+ * Walk the source before copying starts: fill zero_bitmap and, for sync=top,
+ * drop the clusters that are not allocated above the backing.
+ */
+static int coroutine_fn backup_scan_source(BackupBlockJob *s)
+{
+    Job *job = &s->common.job;
+    bool top = s->sync_mode == MIRROR_SYNC_MODE_TOP;
+    int64_t offset, cached_end = 0, count;
+    int ret = 0;
+
+    for (offset = 0; offset < s->len; offset += count) {
+        if (job_is_cancelled(job)) {
+            return -ECANCELED;
+        }
+
+        job_pause_point(job);
+
+        if (job_is_cancelled(job)) {
+            return -ECANCELED;
+        }
+
+        /* rdlock protects the block-status queries below */
+        bdrv_graph_co_rdlock();
+        if (top) {
+            ret = block_copy_reset_unallocated(s->bcs, offset, &count);
+        } else {
+            block_copy_calculate_zero_bitmap(s->bcs, offset, &cached_end,
+                                             &count);
+        }
+        bdrv_graph_co_rdunlock();
+
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    if (top) {
+        block_copy_set_skip_unallocated(s->bcs, false);
+    }
+    block_copy_set_zero_bitmap_valid(s->bcs);
+
+    return 0;
+}
+
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
@@ -254,52 +299,33 @@ static int coroutine_fn backup_run(Job *job, Error **errp)

     backup_init_bcs_bitmap(s);

-    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
-        int64_t offset = 0;
-        int64_t count;
-
-        for (offset = 0; offset < s->len; ) {
-            if (job_is_cancelled(job)) {
-                return -ECANCELED;
-            }
-
-            job_pause_point(job);
-
-            if (job_is_cancelled(job)) {
-                return -ECANCELED;
-            }
-
-            /* rdlock protects the subsequent call to bdrv_is_allocated() */
-            bdrv_graph_co_rdlock();
-            ret = block_copy_reset_unallocated(s->bcs, offset, &count);
-            bdrv_graph_co_rdunlock();
-            if (ret < 0) {
-                return ret;
-            }
-
-            offset += count;
+    switch (s->sync_mode) {
+    case MIRROR_SYNC_MODE_TOP:
+    case MIRROR_SYNC_MODE_FULL:
+    case MIRROR_SYNC_MODE_BITMAP:
+        ret = backup_scan_source(s);
+        if (ret < 0) {
+            return ret;
         }
-        block_copy_set_skip_unallocated(s->bcs, false);
-        block_copy_set_zero_bitmap_valid(s->bcs);
-    }
+        break;

-    if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
+    case MIRROR_SYNC_MODE_NONE:
         /*
          * All bits are set in bcs bitmap to allow any cluster to be copied.
-         * This does not actually require them to be copied.
+         * This does not actually require them to be copied. Yield until the
+         * job is cancelled and let the before_write notify callback service
+         * CoW requests.
          */
         while (!job_is_cancelled(job)) {
-            /*
-             * Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests.
-             */
             job_yield(job);
         }
-    } else {
-        return backup_loop(s);
+        return 0;
+
+    default:
+        g_assert_not_reached();
     }

-    return 0;
+    return backup_loop(s);
 }

 static void coroutine_fn backup_pause(Job *job)
diff --git a/block/block-copy.c b/block/block-copy.c
index 507c4bab909..4f128a0ebdc 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -808,6 +808,48 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
     return ret;
 }

+/*
+ * One scan step, like block_copy_reset_unallocated(); @cached_end
+ * tracks progress across calls, @count how far @offset should move.
+ */
+void coroutine_fn GRAPH_RDLOCK
+block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
+                                 int64_t *cached_end, int64_t *count)
+{
+    int64_t max_bytes = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                        s->cluster_size);
+    int64_t dirty_offset, dirty_bytes, dirty_end;
+    bool found;
+
+    /* CBW mutates copy_bitmap from its own AioContext meanwhile. */
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        found = bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset,
+                                                  s->len, max_bytes,
+                                                  &dirty_offset, &dirty_bytes);
+    }
+
+    if (!found) {
+        *count = s->len - offset;
+        return;
+    }
+    dirty_end = dirty_offset + dirty_bytes;
+
+    if (*cached_end < dirty_end) {
+        int64_t clusters;
+        int64_t query_offset = MAX(dirty_offset, *cached_end);
+        int ret = block_copy_is_cluster_allocated(s, query_offset, &clusters);
+
+        if (ret >= 0) {
+            *cached_end = query_offset + clusters * s->cluster_size;
+        } else {
+            /* Best-effort: leave this area unmarked; it copies as data. */
+            *cached_end = dirty_end;
+        }
+    }
+
+    *count = MIN(*cached_end, dirty_end) - offset;
+}
+
 /*
  * Decide how @task is copied: COPY_WRITE_ZEROES if it reads as zero. May
  * shrink @task. Returns false if @task is to be skipped (already ended,
-- 
2.56.0


