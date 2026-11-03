Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B01606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VeciIhJk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5ce-0006Zh-Bh; Mon, 02 Nov 2026 22:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cc-0006XJ-H2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5ca-0000de-Il
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55V3OL4QOhL126zAS/6Em8pgp/CM9gX2lo3RNeHL3HA=;
 b=VeciIhJk2DH29PbIeb/IbokUmSnxSFGhO2j+XMOXVldR8MR3VXZn5smolQ0HGrx1VbrFYj
 gwngjBEcqlA18ZYWZLS3LQtdxlC5me7tfLn/ne7qk5IiYP9Q5tZdUM7OX0C1kj+YhtFLD0
 CzONeCYPb5Unu6RhiIa/yghBWxQUa7I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-U8yVPZEqMdGFECdLiA9DHw-1; Mon,
 02 Nov 2026 22:55:38 -0500
X-MC-Unique: U8yVPZEqMdGFECdLiA9DHw-1
X-Mimecast-MFC-AGG-ID: U8yVPZEqMdGFECdLiA9DHw_1793678137
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67FEA1955BCF; Tue,  3 Nov 2026 03:55:37 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ABDD7E5; Tue,  3 Nov 2026 03:55:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 13/16] block/block-copy: merge the two backup scan steps into
 block_copy_prescan()
Date: Mon,  2 Nov 2026 21:54:24 -0600
Message-ID: <20261103035506.2688772-31-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.238, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

block_copy_reset_unallocated() and block_copy_calculate_zero_bitmap()
are both one step of the same scan and differ only in what they do with
the answer. Fold them into block_copy_prescan(), which drops unallocated
clusters from copy_bitmap while skip_unallocated is set, so
backup_scan_source() loses its per-mode branch.

sync=top now walks the dirty areas the way full and bitmap do, so it no
longer queries what copy-before-write has already copied during the
scan. A failed query still fails sync=top, as nothing else can tell
which clusters to skip, and still leaves the area to be copied as data
otherwise.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-10-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block-copy.h |  9 ++----
 block/backup.c             |  7 +----
 block/block-copy.c         | 63 ++++++++++++++------------------------
 3 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 3a61066b55f..dc51316fcff 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -41,12 +41,9 @@ void block_copy_state_free(BlockCopyState *s);

 void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes);

-int64_t coroutine_fn GRAPH_RDLOCK
-block_copy_reset_unallocated(BlockCopyState *s, int64_t offset, int64_t *count);
-
-void coroutine_fn GRAPH_RDLOCK
-block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
-                                 int64_t *cached_end, int64_t *count);
+int coroutine_fn GRAPH_RDLOCK
+block_copy_prescan(BlockCopyState *s, int64_t offset, int64_t *cached_end,
+                   int64_t *count);

 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                             bool ignore_ratelimit, uint64_t timeout_ns,
diff --git a/block/backup.c b/block/backup.c
index 38b0838d694..60c00fca67d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -271,12 +271,7 @@ static int coroutine_fn backup_scan_source(BackupBlockJob *s)

         /* rdlock protects the block-status queries below */
         bdrv_graph_co_rdlock();
-        if (top) {
-            ret = block_copy_reset_unallocated(s->bcs, offset, &count);
-        } else {
-            block_copy_calculate_zero_bitmap(s->bcs, offset, &cached_end,
-                                             &count);
-        }
+        ret = block_copy_prescan(s->bcs, offset, &cached_end, &count);
         bdrv_graph_co_rdunlock();

         if (ret < 0) {
diff --git a/block/block-copy.c b/block/block-copy.c
index ad358f4d2f1..78cc855b5b1 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -153,8 +153,8 @@ typedef struct BlockCopyState {
      * This is indicated by skip_unallocated.
      *
      * In this case, block_copy() will query the source’s allocation status,
-     * skip unallocated regions, clear them in the copy_bitmap, and invoke
-     * block_copy_reset_unallocated() every time it does.
+     * skip unallocated regions and clear them in the copy_bitmap, as
+     * block_copy_prescan() does.
      */
     bool skip_unallocated; /* atomic */
     /* State fields that use a thread-safe API */
@@ -781,40 +781,17 @@ void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes)
 }

 /*
- * Reset bits in copy_bitmap starting at offset if they represent unallocated
- * data in the image. May reset subsequent contiguous bits.
- * @return 0 when the cluster at @offset was unallocated,
- *         1 otherwise, and -ret on error.
+ * One step of the scan run before copying: query the next dirty area, fill
+ * zero_bitmap and, while skip_unallocated is set, drop the clusters which
+ * are not allocated above the backing from copy_bitmap. @cached_end tracks
+ * progress across calls, @count how far @offset should move.
+ *
+ * A failed query only leaves the area unmarked, so it copies as data, but
+ * sync=top cannot tell what to skip and fails instead.
  */
-int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
-                                                  int64_t offset,
-                                                  int64_t *count)
-{
-    int ret;
-    int64_t clusters, bytes;
-
-    ret = block_copy_scan_status(s, offset, &clusters);
-    if (ret < 0) {
-        return ret;
-    }
-
-    bytes = clusters * s->cluster_size;
-
-    if (!ret) {
-        block_copy_reset(s, offset, bytes);
-    }
-
-    *count = bytes;
-    return ret;
-}
-
-/*
- * One scan step, like block_copy_reset_unallocated(); @cached_end
- * tracks progress across calls, @count how far @offset should move.
- */
-void coroutine_fn GRAPH_RDLOCK
-block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
-                                 int64_t *cached_end, int64_t *count)
+int coroutine_fn GRAPH_RDLOCK
+block_copy_prescan(BlockCopyState *s, int64_t offset, int64_t *cached_end,
+                   int64_t *count)
 {
     int64_t max_bytes = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
                                         s->cluster_size);
@@ -830,7 +807,7 @@ block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,

     if (!found) {
         *count = s->len - offset;
-        return;
+        return 0;
     }
     dirty_end = dirty_offset + dirty_bytes;

@@ -839,15 +816,21 @@ block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
         int64_t query_offset = MAX(dirty_offset, *cached_end);
         int ret = block_copy_scan_status(s, query_offset, &clusters);

-        if (ret >= 0) {
-            *cached_end = query_offset + clusters * s->cluster_size;
-        } else {
-            /* Best-effort: leave this area unmarked; it copies as data. */
+        if (ret < 0) {
+            if (qatomic_read(&s->skip_unallocated)) {
+                return ret;
+            }
             *cached_end = dirty_end;
+        } else {
+            *cached_end = query_offset + clusters * s->cluster_size;
+            if (!ret && qatomic_read(&s->skip_unallocated)) {
+                block_copy_reset(s, query_offset, clusters * s->cluster_size);
+            }
         }
     }

     *count = MIN(*cached_end, dirty_end) - offset;
+    return 0;
 }

 /*
-- 
2.56.0


