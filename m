Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8081125875
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PNv-0005PZ-Ir; Wed, 11 Mar 2026 15:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNt-0005Ob-L8; Wed, 11 Mar 2026 15:38:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNq-0000Vw-O4; Wed, 11 Mar 2026 15:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257669; bh=CLgO+i9uE6yw0o/c7fPWp6c3Ly99nYGSb8fZpZqd5P0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=s+cLTIhqWI4OGBR+UDi4EYffNJ6MXT4F9sZc/cEattQtOF52p3anLPof6q39fmPRy
 riGorLamM9DXoh2Wp0+S1rwp/U1KE7WE7SWhwrSx5PbIbRde4gKLf3CCTnfr2k/829
 0L+aaF1u0NRYkb4dlfPBhhvgbgMU6RwnWRoYA1OK+9sM09oSXY7sItEiIQNVHp0DZC
 qYEhSMK1uQ8s0AmlHBkO/6jNwCXJsi42YTkTqs75k2hceofnpNhbXvAHqkcaJHHpjB
 93igfBwLEBLdJIvgAUOgW8oKv5ynAK7vSQ7GwFK8Q3/tL3UY+4c4ZWThejYcw0yhoN
 vKnl9oRl6URww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D03619210D;
 Wed, 11 Mar 2026 22:34:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5E0BC37C472;
 Wed, 11 Mar 2026 22:35:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 37/53] mirror: Fix missed dirty bitmap writes during
 startup
Date: Wed, 11 Mar 2026 22:34:30 +0300
Message-ID: <20260311193449.1096110-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Kevin Wolf <kwolf@redhat.com>

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
(cherry picked from commit 0f51f9c3420b31bb383e456dd7bf24d3056eeb73)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/mirror.c b/block/mirror.c
index bc982cb99a..fa1d975eb9 100644
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
2.47.3


