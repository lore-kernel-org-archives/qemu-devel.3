Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0CBFCC056
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vya4X-0001QI-Ke; Fri, 06 Mar 2026 13:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya48-00014N-8D
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya45-00064Y-2j
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772822300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVGDVxGD0tLT4QGayoeRrXuNGBv8Ixvg3B40YKtCRw0=;
 b=VfkVKUXMUZB80bQI/obVIGtP4hEXm8c8dYhzi+3S/8Ls5JJCBMSLHI7TzhfhHeTqJkfUyp
 o8RaX46qg6Hu2fYoabF4qHdKaJxmGY7D0JPBByLa05w8zKdyX+a33FnhHgST0Y32kW/Xwr
 8f5eS77gUQX2aibLncWxJc9Pqz7qB1o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-3am_SvU-PdGd3oDJO7qVaw-1; Fri,
 06 Mar 2026 13:38:15 -0500
X-MC-Unique: 3am_SvU-PdGd3oDJO7qVaw-1
X-Mimecast-MFC-AGG-ID: 3am_SvU-PdGd3oDJO7qVaw_1772822295
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 214EC19560A5; Fri,  6 Mar 2026 18:38:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDC071800576; Fri,  6 Mar 2026 18:38:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/12] mirror: Fix missed dirty bitmap writes during startup
Date: Fri,  6 Mar 2026 19:36:58 +0100
Message-ID: <20260306183705.410357-6-kwolf@redhat.com>
In-Reply-To: <20260306183705.410357-1-kwolf@redhat.com>
References: <20260306183705.410357-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, mirror disables the block layer's dirty bitmap before its own
replacement is working. This means that during startup, there is a
window in which the allocation status of blocks in the source has
already been checked, but new writes coming in aren't tracked yet,
resulting in a corrupted copy:

1. Dirty bitmap is disabled in mirror_start_job()
2. Some request are started in mirror_top_bs while s->job == NULL
3. mirror_dirty_init() -> bdrv_co_is_allocated_above() runs and because
   the request hasn't completed yet, the block isn't allocated
4. The request completes, still sees s->job == NULL and skips the
   bitmap, and nothing else will mark it dirty either

One ingredient is that mirror_top_opaque->job is only set after the
job is fully initialized. For the rationale, see commit 32125b1460
("mirror: Fix access of uninitialised fields during start").

Fix this by giving mirror_top_bs access to dirty_bitmap and enabling it
to track writes from the beginning. Disabling the block layer's tracking
and enabling the mirror_top_bs one happens in a drained section, so
there is no danger of races with in-flight requests any more. All of
this happens well before the block allocation status is checked, so we
can be sure that no writes will be missed.

Cc: qemu-stable@nongnu.org
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3273
Fixes: 32125b14606a ('mirror: Fix access of uninitialised fields during start')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260219202446.312493-1-kwolf@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Jean-Louis Dupond <jean-louis@dupond.be>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 52 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index bc982cb99a8..fa1d975eb9f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -99,6 +99,7 @@ typedef struct MirrorBlockJob {
 
 typedef struct MirrorBDSOpaque {
     MirrorBlockJob *job;
+    BdrvDirtyBitmap *dirty_bitmap;
     bool stop;
     bool is_commit;
 } MirrorBDSOpaque;
@@ -1675,9 +1676,11 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
         abort();
     }
 
-    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
-        qatomic_set(&s->job->actively_synced, false);
-        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
+    if (!copy_to_target) {
+        if (s->job) {
+            qatomic_set(&s->job->actively_synced, false);
+        }
+        bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
     }
 
     if (ret < 0) {
@@ -1904,13 +1907,35 @@ static BlockJob *mirror_start_job(
 
     bdrv_drained_begin(bs);
     ret = bdrv_append(mirror_top_bs, bs, errp);
-    bdrv_drained_end(bs);
-
     if (ret < 0) {
+        bdrv_drained_end(bs);
+        bdrv_unref(mirror_top_bs);
+        return NULL;
+    }
+
+    bs_opaque->dirty_bitmap = bdrv_create_dirty_bitmap(mirror_top_bs,
+                                                       granularity,
+                                                       NULL, errp);
+    if (!bs_opaque->dirty_bitmap) {
+        bdrv_drained_end(bs);
         bdrv_unref(mirror_top_bs);
         return NULL;
     }
 
+    /*
+     * The mirror job doesn't use the block layer's dirty tracking because it
+     * needs to be able to switch seemlessly between background copy mode (which
+     * does need dirty tracking) and write blocking mode (which doesn't) and
+     * doing that would require draining the node. Instead, mirror_top_bs takes
+     * care of updating the dirty bitmap as appropriate.
+     *
+     * Note that write blocking mode only becomes effective after mirror_run()
+     * sets mirror_top_opaque->job (see should_copy_to_target()). Until then,
+     * we're still in background copy mode irrespective of @copy_mode.
+     */
+    bdrv_disable_dirty_bitmap(bs_opaque->dirty_bitmap);
+    bdrv_drained_end(bs);
+
     /* Make sure that the source is not resized while the job is running */
     s = block_job_create(job_id, driver, NULL, mirror_top_bs,
                          BLK_PERM_CONSISTENT_READ,
@@ -2005,24 +2030,13 @@ static BlockJob *mirror_start_job(
     s->base_overlay = bdrv_find_overlay(bs, base);
     s->granularity = granularity;
     s->buf_size = ROUND_UP(buf_size, granularity);
+    s->dirty_bitmap = bs_opaque->dirty_bitmap;
     s->unmap = unmap;
     if (auto_complete) {
         s->should_complete = true;
     }
     bdrv_graph_rdunlock_main_loop();
 
-    s->dirty_bitmap = bdrv_create_dirty_bitmap(s->mirror_top_bs, granularity,
-                                               NULL, errp);
-    if (!s->dirty_bitmap) {
-        goto fail;
-    }
-
-    /*
-     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
-     * mode.
-     */
-    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
-
     bdrv_graph_wrlock_drained();
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
@@ -2102,9 +2116,6 @@ fail:
         g_free(s->replaces);
         blk_unref(s->target);
         bs_opaque->job = NULL;
-        if (s->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(s->dirty_bitmap);
-        }
         job_early_fail(&s->common.job);
     }
 
@@ -2118,6 +2129,7 @@ fail:
     bdrv_graph_wrunlock();
     bdrv_drained_end(bs);
 
+    bdrv_release_dirty_bitmap(bs_opaque->dirty_bitmap);
     bdrv_unref(mirror_top_bs);
 
     return NULL;
-- 
2.53.0


