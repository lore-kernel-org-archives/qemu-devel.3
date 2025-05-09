Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50074C3ABCB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 20:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDUZv-0004Jy-2H; Fri, 09 May 2025 16:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZq-0004Ic-8a
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZn-0000jN-Jg
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746823450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn6zBuqpNVmvcfbdxpgMz2X9n+bh2itxCd5KFp+3S5M=;
 b=LC03L8GAvYqcb5OkdtVt9qFchcDcEO1UkWNbGfi3w2s5KToVLUNZ/MnYuiFguuR7t6Gsup
 uOrYHE60pgzpwrDijgzeDjt9tZ4guPfG2L0N/5A7QTUwwVK+ElONXc5MeVlOUKZggoPBCx
 NNOxHe2ffgEuuhX2GCkv0VoOMjNcEdg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-Gl1PrUVGNkSgfKPkltYngw-1; Fri,
 09 May 2025 16:44:07 -0400
X-MC-Unique: Gl1PrUVGNkSgfKPkltYngw-1
X-Mimecast-MFC-AGG-ID: Gl1PrUVGNkSgfKPkltYngw_1746823446
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E1AA180045C; Fri,  9 May 2025 20:44:06 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71A2A30001A1; Fri,  9 May 2025 20:44:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 06/13] mirror: Minor refactoring
Date: Fri,  9 May 2025 15:40:23 -0500
Message-ID: <20250509204341.3553601-21-eblake@redhat.com>
In-Reply-To: <20250509204341.3553601-15-eblake@redhat.com>
References: <20250509204341.3553601-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 5791ba52 (v9.2) pre-initialized ret in mirror_dirty_init to
silence a false positive compiler warning, even though in all code
paths where ret is used, it was guaranteed to be reassigned
beforehand.  But since the function returns -errno, and -1 is not
always the right errno, it's better to initialize to -EIO.

An upcoming patch wants to track two bitmaps in
do_sync_target_write(); this will be easier if the current variables
related to the dirty bitmap are renamed.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/mirror.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index a53582f17bb..34c6c5252e1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -841,7 +841,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     int64_t offset;
     BlockDriverState *bs;
     BlockDriverState *target_bs = blk_bs(s->target);
-    int ret = -1;
+    int ret = -EIO;
     int64_t count;

     bdrv_graph_co_rdlock();
@@ -1341,7 +1341,7 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
 {
     int ret;
     size_t qiov_offset = 0;
-    int64_t bitmap_offset, bitmap_end;
+    int64_t dirty_bitmap_offset, dirty_bitmap_end;

     if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
         bdrv_dirty_bitmap_get(job->dirty_bitmap, offset))
@@ -1388,11 +1388,11 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
      * Tails are either clean or shrunk, so for bitmap resetting
      * we safely align the range down.
      */
-    bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
-    bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
-    if (bitmap_offset < bitmap_end) {
-        bdrv_reset_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
-                                bitmap_end - bitmap_offset);
+    dirty_bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
+    dirty_bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
+    if (dirty_bitmap_offset < dirty_bitmap_end) {
+        bdrv_reset_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
+                                dirty_bitmap_end - dirty_bitmap_offset);
     }

     job_progress_increase_remaining(&job->common.job, bytes);
@@ -1430,10 +1430,10 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
          * at function start, and they must be still dirty, as we've locked
          * the region for in-flight op.
          */
-        bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
-        bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
-        bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
-                              bitmap_end - bitmap_offset);
+        dirty_bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
+        dirty_bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
+        bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
+                              dirty_bitmap_end - dirty_bitmap_offset);
         qatomic_set(&job->actively_synced, false);

         action = mirror_error_action(job, false, -ret);
-- 
2.49.0


