Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F0BCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 07:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPFLk-0000rI-TL; Tue, 19 May 2026 03:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wPFLj-0000r0-Go; Tue, 19 May 2026 03:58:47 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wPFLZ-0005Ta-P2; Tue, 19 May 2026 03:58:39 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 7A1081520D89;
 Tue, 19 May 2026 09:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1779177513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tdKtXZbZmJURISFbusNmAnDHqrCPjGLAAcEd8EWVAug=;
 b=M1vQYu92C8B9eo8kVyNaOO63h6QWKGZSPMHNvdSulpHmQ35k83/K4fGBnCZK3fl9P+Tamx
 uQrq3nSnUqAlckqPhPumQuHc5CtGPLt9vYwc4qm9mSZ2Y7PWfMrgAXMQQ/puyiJzyCX4Dy
 z4DPw4MsthHRVbnxCO9PWbaY8lO1c5RaWgLV57Dk7hu0ar8fe5UlJLV9mqn5L6M+i3vBZK
 M06yHoooRkFO3Ui2DtN0EN4QTlLmIyMpY1+y8hPQmi+lwVipXJGguzrGkEd26ioH9kF2WX
 F3OEyksBAF1xjlZMav/whNuLC27zmk/nLDeYNE0mT8WSGFY262rlnhLUmgOFsQ==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH] qcow2: add functionality to repair bitmaps
Date: Tue, 19 May 2026 09:58:13 +0200
Message-ID: <20260519075813.955333-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In some cases, it might happen that bitmaps become corrupt.
For example when adding/removing bitmaps on a live image.

Of course this should not happen, but in case this happens, the image is
corrupt and cannot even be opened anymore. You get something like the
following for example:
qemu-img: Could not open 'disk.qcow2': Bitmap '' doesn't satisfy the constraints

So the image becomes useless, and cannot be repaired. This while in fact
only (one) bitmap entry is corrupt, and the rest of the data is just
intact.

This commit adds a way to fix this corruption, by just replacing the
bitmap list in the qcow2 image with the valid bitmaps, and dropping the
bitmaps that are corrupt.

qemu-img: Check failed: Invalid argument
qemu-img: Lost persistent bitmaps during inactivation of node '#block195': Bitmap '' doesn't satisfy the constraints

qcow2_free_clusters failed: Invalid argument
Leaked cluster 3 refcount=1 reference=0
Leaked cluster 26 refcount=1 reference=0
Repairing cluster 3 refcount=1 reference=0
Repairing cluster 26 refcount=1 reference=0
The following inconsistencies were found and repaired:

    2 leaked clusters
    1 corruptions

Double checking the fixed image now...
No errors were found on the image.
983056/1048576 = 93.75% allocated, 0.05% fragmented, 0.00% compressed clusters
Image end offset: 64435847168

And the image is valid again!
Worst case you lose all bitmaps, but at least the image and the data
itself is useable again.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2-bitmap.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        | 22 ++++++++++---
 block/qcow2.h        |  4 +++
 3 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 256ec99878..f107de3301 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1807,3 +1807,81 @@ uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *in_bs,
 
     return bitmaps_size;
 }
+
+/*
+ * qcow2_check_bitmaps - Check and optionally fix bitmap directory and bitmaps
+ * This function is called during image check to detect bitmap corruption.
+ * It attempts to load the bitmap directory and validates the structures.
+ * If BDRV_FIX_ERRORS is set, it removes corrupted bitmaps.
+ */
+int coroutine_fn GRAPH_RDLOCK
+qcow2_check_bitmaps(BlockDriverState *bs, BdrvCheckResult *result,
+                    BdrvCheckMode fix)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2BitmapList *fixed_list = NULL;
+    Qcow2Bitmap *bm;
+    int valid_bitmaps = 0;
+    int ret = 0;
+
+    if (s->nb_bitmaps == 0) {
+        /* No bitmaps - nothing to check */
+        return 0;
+    }
+
+    /* Try to load the bitmap directory */
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, NULL);
+    if (bm_list == NULL) {
+        /* Bitmap directory is corrupted */
+        result->corruptions++;
+
+        if (fix & BDRV_FIX_ERRORS) {
+            ret = update_ext_header_and_dir(bs, bitmap_list_new());
+            if (ret < 0) {
+                return ret;
+            }
+            result->corruptions_fixed++;
+        }
+
+        return 0;
+    }
+
+    if (fix & BDRV_FIX_ERRORS) {
+        fixed_list = bitmap_list_new();
+    }
+
+    /* Validate each bitmap */
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        uint64_t *bitmap_table = NULL;
+
+        /* Try to load the bitmap table */
+        ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
+        g_free(bitmap_table);
+        if (ret < 0) {
+            /* Bitmap table is corrupted */
+            result->corruptions++;
+            continue;
+        }
+
+        if (fix & BDRV_FIX_ERRORS) {
+            valid_bitmaps++;
+            QSIMPLEQ_INSERT_TAIL(fixed_list, bm, entry);
+        }
+    }
+
+    bitmap_list_free(bm_list);
+
+    /* If fixing, update the bitmap directory with the repaired list */
+    if ((fix & BDRV_FIX_ERRORS) && s->nb_bitmaps != valid_bitmaps) {
+        ret = update_ext_header_and_dir(bs, fixed_list);
+        bitmap_list_free(fixed_list);
+        if (ret < 0) {
+            return ret;
+        }
+        result->corruptions_fixed += s->nb_bitmaps - valid_bitmaps;
+    }
+
+    return 0;
+}
\ No newline at end of file
diff --git a/block/qcow2.c b/block/qcow2.c
index 81fd299b4c..156fec5de3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -608,12 +608,20 @@ static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_check_locked(BlockDriverState *bs, BdrvCheckResult *result,
                       BdrvCheckMode fix)
 {
+    BdrvCheckResult bitmap_res = {};
     BdrvCheckResult snapshot_res = {};
     BdrvCheckResult refcount_res = {};
     int ret;
 
     memset(result, 0, sizeof(*result));
 
+    /* Check and fix bitmaps */
+    ret = qcow2_check_bitmaps(bs, &bitmap_res, fix);
+    qcow2_add_check_result(result, &bitmap_res, false);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = qcow2_check_read_snapshot_table(bs, &snapshot_res, fix);
     if (ret < 0) {
         qcow2_add_check_result(result, &snapshot_res, false);
@@ -1927,11 +1935,17 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
         /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
         bool header_updated;
-        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, errp)) {
-            ret = -EINVAL;
-            goto fail;
+        Error *local_err = NULL;
+        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, &local_err)) {
+            /* Allow this to fail in check mode
+             * because otherwise we can't open the image at all.
+             */
+            if (!(flags & BDRV_O_CHECK)) {
+                ret = -EINVAL;
+                error_propagate(errp, local_err);
+                goto fail;
+            }
         }
-
         update_header = update_header && !header_updated;
     }
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 192a45d596..bf56b071fa 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -1036,6 +1036,10 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                               void **refcount_table,
                               int64_t *refcount_table_size);
 
+int coroutine_fn GRAPH_RDLOCK
+qcow2_check_bitmaps(BlockDriverState *bs, BdrvCheckResult *result,
+                    BdrvCheckMode fix);
+
 bool coroutine_fn GRAPH_RDLOCK
 qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
                          Error **errp);
-- 
2.54.0


