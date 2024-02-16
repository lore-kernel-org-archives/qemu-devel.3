Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF28C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravsT-0008Jt-Gi; Fri, 16 Feb 2024 05:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsR-0008HJ-MW; Fri, 16 Feb 2024 05:55:31 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsP-0007cM-IL; Fri, 16 Feb 2024 05:55:31 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id ADF2448550;
 Fri, 16 Feb 2024 11:55:19 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
Subject: [RFC 2/4] drive-mirror: add support for conditional and always bitmap
 sync modes
Date: Fri, 16 Feb 2024 11:55:11 +0100
Message-Id: <20240216105513.309901-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216105513.309901-1-f.ebner@proxmox.com>
References: <20240216105513.309901-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Teach mirror two new tricks for using bitmaps:

Always: no matter what, we synchronize the copy_bitmap back to the
sync_bitmap. In effect, this allows us resume a failed mirror at a later
date.

Conditional: On success only, we sync the bitmap. This is akin to
incremental backup modes; we can use this bitmap to later refresh a
successfully created mirror.

Originally-by: John Snow <jsnow@redhat.com>
[FG: add check for bitmap-mode without bitmap
     switch to bdrv_dirty_bitmap_merge_internal]
Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
[FE: rebase for 9.0]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

The original patch this was based on came from a WIP git branch and
thus has no Signed-off-by trailer from John, see [0]. I added an
Originally-by trailer for now. Let me know if I should drop that and
wait for John's Signed-off-by instead.

[0] https://lore.kernel.org/qemu-devel/1599140071.n44h532eeu.astroid@nora.none/

 block/mirror.c | 24 ++++++++++++++++++------
 blockdev.c     |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 315dff11e2..84155b1f78 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -689,8 +689,6 @@ static int mirror_exit_common(Job *job)
         bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
     }
 
-    bdrv_release_dirty_bitmap(s->dirty_bitmap);
-
     /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
      * before we can call bdrv_drained_end */
     bdrv_ref(src);
@@ -796,6 +794,18 @@ static int mirror_exit_common(Job *job)
     bdrv_drained_end(target_bs);
     bdrv_unref(target_bs);
 
+    if (s->sync_bitmap) {
+        if (s->bitmap_mode == BITMAP_SYNC_MODE_ALWAYS ||
+            (s->bitmap_mode == BITMAP_SYNC_MODE_ON_SUCCESS &&
+             job->ret == 0 && ret == 0)) {
+            /* Success; synchronize copy back to sync. */
+            bdrv_clear_dirty_bitmap(s->sync_bitmap, NULL);
+            bdrv_dirty_bitmap_merge_internal(s->sync_bitmap, s->dirty_bitmap,
+                                             NULL, true);
+        }
+    }
+    bdrv_release_dirty_bitmap(s->dirty_bitmap);
+
     bs_opaque->job = NULL;
 
     bdrv_drained_end(src);
@@ -1755,10 +1765,6 @@ static BlockJob *mirror_start_job(
                        " sync mode",
                        MirrorSyncMode_str(sync_mode));
             return NULL;
-        } else if (bitmap_mode != BITMAP_SYNC_MODE_NEVER) {
-            error_setg(errp,
-                       "Bitmap Sync Mode '%s' is not supported by Mirror",
-                       BitmapSyncMode_str(bitmap_mode));
         }
     } else if (bitmap) {
         error_setg(errp,
@@ -1775,6 +1781,12 @@ static BlockJob *mirror_start_job(
             return NULL;
         }
         granularity = bdrv_dirty_bitmap_granularity(bitmap);
+
+        if (bitmap_mode != BITMAP_SYNC_MODE_NEVER) {
+            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
+                return NULL;
+            }
+        }
     } else if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
diff --git a/blockdev.c b/blockdev.c
index c65d9ded70..aeb9fde9f3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2873,6 +2873,9 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             return;
         }
+    } else if (has_bitmap_mode) {
+        error_setg(errp, "Cannot specify bitmap sync mode without a bitmap");
+        return;
     }
 
     if (!replaces) {
-- 
2.39.2



