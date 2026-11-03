Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7214606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DaXNXrBa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cl-0006gM-Sg; Mon, 02 Nov 2026 22:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5ch-0006dP-JN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cf-0000eY-BX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oe0DBpqOPzENdPHfYYs0jIPUlyTxk+RA3n49myVoAos=;
 b=DaXNXrBa5kLGwZQUBHfnoFEyOSSU1rat0HiwvTbpRbE+grdGlr+o0woLf3EpSW9YnXXetm
 tIsNjfhRXYxmhY3LSxnLSARLqgh6RNLug1ptMBHN6srK0X9wFbL+iuG4oK10Sg+xaIUmcA
 G3SrSR25l/rM57Q/vuDjZa2NnjsoEaw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220--iytbglPP3Ka7GQmvD502A-1; Mon,
 02 Nov 2026 22:55:41 -0500
X-MC-Unique: -iytbglPP3Ka7GQmvD502A-1
X-Mimecast-MFC-AGG-ID: -iytbglPP3Ka7GQmvD502A_1793678140
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1B0F1954B2E; Tue,  3 Nov 2026 03:55:39 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBB617E8; Tue,  3 Nov 2026 03:55:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 14/16] block/block-copy: replace zero_bitmap_valid with
 scan_done
Date: Mon,  2 Nov 2026 21:54:25 -0600
Message-ID: <20261103035506.2688772-32-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

zero_bitmap_valid says more than its name: a task created once it is
set skips its own block-status query, the sync=top skipping included,
because the scan has already settled what to copy. And the end of the
scan was announced twice, clearing skip_unallocated and then publishing
zero_bitmap_valid, with an ordering rule in a comment tying the two.

Rename the flag to scan_done, and let block_copy_set_scan_done() clear
skip_unallocated before publishing it, so backup_scan_source() makes one
call and the order is kept in one place. skip_unallocated is left to
mean that a sync=top scan is in progress. No behavior change.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-11-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block-copy.h |  2 +-
 block/backup.c             |  6 +-----
 block/block-copy.c         | 19 ++++++++++++-------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index dc51316fcff..e82c96586e6 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -102,6 +102,6 @@ void block_copy_call_cancel(BlockCopyCallState *call_state);
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 int64_t block_copy_cluster_size(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
-void block_copy_set_zero_bitmap_valid(BlockCopyState *s);
+void block_copy_set_scan_done(BlockCopyState *s);

 #endif /* BLOCK_COPY_H */
diff --git a/block/backup.c b/block/backup.c
index 60c00fca67d..1bf6cbedaca 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -254,7 +254,6 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
 static int coroutine_fn backup_scan_source(BackupBlockJob *s)
 {
     Job *job = &s->common.job;
-    bool top = s->sync_mode == MIRROR_SYNC_MODE_TOP;
     int64_t offset, cached_end = 0, count;
     int ret = 0;

@@ -279,10 +278,7 @@ static int coroutine_fn backup_scan_source(BackupBlockJob *s)
         }
     }

-    if (top) {
-        block_copy_set_skip_unallocated(s->bcs, false);
-    }
-    block_copy_set_zero_bitmap_valid(s->bcs);
+    block_copy_set_scan_done(s->bcs);

     return 0;
 }
diff --git a/block/block-copy.c b/block/block-copy.c
index 78cc855b5b1..3b7e282e5b9 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -161,8 +161,12 @@ typedef struct BlockCopyState {
     BdrvDirtyBitmap *copy_bitmap;
     /* Clusters reading as zero; allocated on demand, frozen once valid. */
     HBitmap *zero_bitmap;
-    /* Published only after the scan, with skip_unallocated already false. */
-    bool zero_bitmap_valid; /* atomic, store-release/load-acquire */
+    /*
+     * Set when the scan is over: zero_bitmap is complete, and for sync=top
+     * copy_bitmap holds no unallocated clusters, so a task needs no
+     * block-status query of its own.
+     */
+    bool scan_done; /* atomic, store-release/load-acquire */
     ProgressMeter *progress;
     SharedResource *mem;
     RateLimit rate_limit;
@@ -214,7 +218,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
      * The scan already knows how this range reads: pick the method here and
      * stop the task where the answer changes.
      */
-    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+    if (qatomic_load_acquire(&s->scan_done)) {
         int64_t boundary;

         if (hbitmap_get(s->zero_bitmap, offset)) {
@@ -687,7 +691,7 @@ int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
     return ret;
 }

-/* Only the scan allocates, and it runs before zero_bitmap_valid. */
+/* Only the scan allocates, and it runs before scan_done. */
 static HBitmap *block_copy_zero_bitmap(BlockCopyState *s)
 {
     if (!s->zero_bitmap) {
@@ -845,7 +849,7 @@ block_copy_set_task_method(BlockCopyState *s, BlockCopyTask *task)
     int64_t status_bytes;

     /* block_copy_task_create() already decided, from zero_bitmap. */
-    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+    if (qatomic_load_acquire(&s->scan_done)) {
         return true;
     }

@@ -1179,10 +1183,11 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
     qatomic_set(&s->skip_unallocated, skip);
 }

-void block_copy_set_zero_bitmap_valid(BlockCopyState *s)
+void block_copy_set_scan_done(BlockCopyState *s)
 {
     block_copy_zero_bitmap(s);
-    qatomic_store_release(&s->zero_bitmap_valid, true);
+    qatomic_set(&s->skip_unallocated, false);
+    qatomic_store_release(&s->scan_done, true);
 }

 void block_copy_set_speed(BlockCopyState *s, uint64_t speed)
-- 
2.56.0


