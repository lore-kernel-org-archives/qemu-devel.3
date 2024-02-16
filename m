Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0DCC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravsS-0008Hf-Hd; Fri, 16 Feb 2024 05:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsR-0008H1-AD; Fri, 16 Feb 2024 05:55:31 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsP-0007cQ-K9; Fri, 16 Feb 2024 05:55:31 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BFF1D48556;
 Fri, 16 Feb 2024 11:55:19 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
Subject: [RFC 3/4] mirror: move some checks to qmp
Date: Fri, 16 Feb 2024 11:55:12 +0100
Message-Id: <20240216105513.309901-4-f.ebner@proxmox.com>
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

From: Fabian Grünbichler <f.gruenbichler@proxmox.com>

and assert the passing conditions in block/mirror.c. while incremental
mode was never available for drive-mirror, it makes the interface more
uniform w.r.t. backup block jobs.

Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
[FE: rebase for 9.0]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/mirror.c | 28 +++++-----------------------
 blockdev.c     | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 84155b1f78..15d1c060eb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1755,31 +1755,13 @@ static BlockJob *mirror_start_job(
 
     GLOBAL_STATE_CODE();
 
-    if (sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        error_setg(errp, "Sync mode '%s' not supported",
-                   MirrorSyncMode_str(sync_mode));
-        return NULL;
-    } else if (sync_mode == MIRROR_SYNC_MODE_BITMAP) {
-        if (!bitmap) {
-            error_setg(errp, "Must provide a valid bitmap name for '%s'"
-                       " sync mode",
-                       MirrorSyncMode_str(sync_mode));
-            return NULL;
-        }
-    } else if (bitmap) {
-        error_setg(errp,
-                   "sync mode '%s' is not compatible with bitmaps",
-                   MirrorSyncMode_str(sync_mode));
-        return NULL;
-    }
+    /* QMP interface protects us from these cases */
+    assert(sync_mode != MIRROR_SYNC_MODE_INCREMENTAL);
+    assert((bitmap && sync_mode == MIRROR_SYNC_MODE_BITMAP) ||
+           (!bitmap && sync_mode != MIRROR_SYNC_MODE_BITMAP));
+    assert(!(bitmap && granularity));
 
     if (bitmap) {
-        if (granularity) {
-            error_setg(errp, "granularity (%d)"
-                       "cannot be specified when a bitmap is provided",
-                       granularity);
-            return NULL;
-        }
         granularity = bdrv_dirty_bitmap_granularity(bitmap);
 
         if (bitmap_mode != BITMAP_SYNC_MODE_NEVER) {
diff --git a/blockdev.c b/blockdev.c
index aeb9fde9f3..519f408359 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2852,7 +2852,36 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         sync = MIRROR_SYNC_MODE_FULL;
     }
 
+    if ((sync == MIRROR_SYNC_MODE_BITMAP) ||
+        (sync == MIRROR_SYNC_MODE_INCREMENTAL)) {
+        /* done before desugaring 'incremental' to print the right message */
+        if (!bitmap_name) {
+            error_setg(errp, "Must provide a valid bitmap name for "
+                       "'%s' sync mode", MirrorSyncMode_str(sync));
+            return;
+        }
+    }
+
+    if (sync == MIRROR_SYNC_MODE_INCREMENTAL) {
+        if (has_bitmap_mode &&
+            bitmap_mode != BITMAP_SYNC_MODE_ON_SUCCESS) {
+            error_setg(errp, "Bitmap sync mode must be '%s' "
+                       "when using sync mode '%s'",
+                       BitmapSyncMode_str(BITMAP_SYNC_MODE_ON_SUCCESS),
+                       MirrorSyncMode_str(sync));
+            return;
+        }
+        has_bitmap_mode = true;
+        sync = MIRROR_SYNC_MODE_BITMAP;
+        bitmap_mode = BITMAP_SYNC_MODE_ON_SUCCESS;
+    }
+
     if (bitmap_name) {
+        if (sync != MIRROR_SYNC_MODE_BITMAP) {
+            error_setg(errp, "Sync mode '%s' not supported with bitmap.",
+                       MirrorSyncMode_str(sync));
+            return;
+        }
         if (granularity) {
             error_setg(errp, "Granularity and bitmap cannot both be set");
             return;
-- 
2.39.2



