Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C766CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4zy-00055m-3z; Wed, 29 Oct 2025 08:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xb-0003Mf-5x
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xI-00054C-M4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FijhaPtVn+njHJagYWTs4WzK2Cj2l6bRC57/vMRMrY=;
 b=CwnKRC91IDT9K9UGIy1JSvQWaFVISerlB780d/vR5Tqo/9MuOfgAyg7vBdWd171Iq48OCd
 xJBcxNa51dT7j+2k2nE5pgqDoa+CxOtjO7g55LohrUarb7uu+Pah5r+eWz7qFn25Axk6lR
 HHK+iekbh097Umi/n9h/gXT+pOjd5uA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-0CfD0bBjPxm63R2WDDvGog-1; Wed,
 29 Oct 2025 08:06:59 -0400
X-MC-Unique: 0CfD0bBjPxm63R2WDDvGog-1
X-Mimecast-MFC-AGG-ID: 0CfD0bBjPxm63R2WDDvGog_1761739619
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0191218009C0; Wed, 29 Oct 2025 12:06:59 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B64E1180044F; Wed, 29 Oct 2025 12:06:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/18] block: make bdrv_co_parent_cb_resize() a proper IO API
 function
Date: Wed, 29 Oct 2025 13:06:27 +0100
Message-ID: <20251029120634.288467-12-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

In preparation for calling it via the bdrv_child_cb_resize() callback
that will be added by the next commit. Rename it to include the "_co_"
part while at it.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20250917115509.401015-3-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h | 6 ++++++
 block/io.c                   | 9 +++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4f94eb3c5a..ed8b5657d6 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -191,4 +191,10 @@ void bdrv_bsc_invalidate_range(BlockDriverState *bs,
  */
 void bdrv_bsc_fill(BlockDriverState *bs, int64_t offset, int64_t bytes);
 
+/*
+ * Notify all parents that the size of the child changed.
+ */
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_parent_cb_resize(BlockDriverState *bs);
+
 #endif /* BLOCK_INT_IO_H */
diff --git a/block/io.c b/block/io.c
index 9bd8ba8431..928c02d1ad 100644
--- a/block/io.c
+++ b/block/io.c
@@ -46,9 +46,6 @@
 /* Maximum read size for checking if data reads as zero, in bytes */
 #define MAX_ZERO_CHECK_BUFFER (128 * KiB)
 
-static void coroutine_fn GRAPH_RDLOCK
-bdrv_parent_cb_resize(BlockDriverState *bs);
-
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
@@ -2038,7 +2035,7 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
          end_sector > bs->total_sectors) &&
         req->type != BDRV_TRACKED_DISCARD) {
         bs->total_sectors = end_sector;
-        bdrv_parent_cb_resize(bs);
+        bdrv_co_parent_cb_resize(bs);
         bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
     }
     if (req->bytes) {
@@ -3570,11 +3567,11 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
                                    bytes, read_flags, write_flags);
 }
 
-static void coroutine_fn GRAPH_RDLOCK
-bdrv_parent_cb_resize(BlockDriverState *bs)
+void coroutine_fn bdrv_co_parent_cb_resize(BlockDriverState *bs)
 {
     BdrvChild *c;
 
+    IO_CODE();
     assert_bdrv_graph_readable();
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
-- 
2.51.0


