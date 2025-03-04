Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA698C282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpU9k-0001uZ-9t; Tue, 04 Mar 2025 10:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <35b3e1bc74c4f2825acb98252398d2f8805fc99f@kylie.crudebyte.com>)
 id 1tpU9S-0001rh-FP
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:25:50 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <35b3e1bc74c4f2825acb98252398d2f8805fc99f@kylie.crudebyte.com>)
 id 1tpU9O-0006ub-MJ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=qs3hdQFdbF+iWTUVIJhD79rAzTaqIH0Vi558ltmbvFs=; b=cMbs7
 r64DZioGb9vW1HMoKlftk3HoT4xKpegbLxewRjt6vGzlZqwK9czdjwM94oDfiHdowzBDf7PA5e/wC
 bWXIkf6XEns/OFV4NzzhNLzxXLptiQKEWSwD6rJ1nYjDlcODJDVBdNokqvWXUZ23IN3AkzzM8DD+r
 cShWV0xGgUgfK7AeIBDsp8mV20O3FMyQiocjXg04KNdUm2nEw9lYHdJTK7ks4F92BDUwNyAhArHDe
 UA3LQ8aXrHfquHkvENLGKZ/SFYN/Hh1IGsNUZ6Tb06hzVReC3lRF1FxRFpR9wqoS/vDS6EEEuZgRK
 +iarH+z0MNAJYC2eXwqkT2kZIwMQzXcp4vrWQ5xfvbA83XxXnZbg+qrSv0eWp72iOVCgRLeN/8vYe
 HTGmAG2d46YfblMYcW1e91P0DBoi3w1ZQp2JacWjlgubpH+qmnJOFB3DXp2mqJQ5Hsf91b+4y06ix
 SnGfqhmYPEaDGU9qxT6RVm8tFh2n1lDl3MnqH1TsGylNhnJLDb5zTqYg9ILS9kpYXivEWiNIEO2Iu
 /S2YvuMEsBeKifAart/qWl1BCBXOXAD0eShLcbU9vS8XJ1A8IkKcfyC4JsPaHK0uAQVmWdfixnKak
 uDqsT8zV4wW5S3zAIkOYcutc28wzgpuGjTGSYVT3hi40m8HYAPcGpfoyMtl9Aw=;
Message-Id: <35b3e1bc74c4f2825acb98252398d2f8805fc99f.1741101468.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1741101468.git.qemu_oss@crudebyte.com>
References: <cover.1741101468.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 4 Mar 2025 16:16:05 +0100
Subject: [PATCH 2/2] 9pfs: reduce latency of v9fs_reclaim_fd()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=35b3e1bc74c4f2825acb98252398d2f8805fc99f@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This function calls v9fs_co_close() and v9fs_co_closedir() in a loop. Each
one of the calls adds two thread hops (between main thread and a fs driver
background thread). Each thread hop adds latency, which sums up in
function's loop to a significant duration.

Reduce overall latency by open coding what v9fs_co_close() and
v9fs_co_closedir() do, executing those and the loop itself altogether in
only one background thread block, hence reducing the total amount of
thread hops to only two.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4f9c2dde9c..4b52b1a22a 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -434,6 +434,7 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
     V9fsFidState *f;
     GHashTableIter iter;
     gpointer fid;
+    int err;
 
     /* prevent multiple coroutines running this function simultaniously */
     if (s->reclaiming) {
@@ -446,10 +447,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
     QSLIST_HEAD(, V9fsFidState) reclaim_list =
         QSLIST_HEAD_INITIALIZER(reclaim_list);
 
+    /* Pick FIDs to be closed, collect them on reclaim_list. */
     while (g_hash_table_iter_next(&iter, &fid, (gpointer *) &f)) {
         /*
-         * Unlink fids cannot be reclaimed. Check
-         * for them and skip them. Also skip fids
+         * Unlinked fids cannot be reclaimed, skip those, and also skip fids
          * currently being operated on.
          */
         if (f->ref || f->flags & FID_NON_RECLAIMABLE) {
@@ -499,17 +500,24 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
         }
     }
     /*
-     * Now close the fid in reclaim list. Free them if they
-     * are already clunked.
+     * Close the picked FIDs altogether on a background I/O driver thread. Do
+     * this all at once to keep latency (i.e. amount of thread hops between main
+     * thread <-> fs driver background thread) as low as possible.
      */
+    v9fs_co_run_in_worker({
+        QSLIST_FOREACH(f, &reclaim_list, reclaim_next) {
+            err = (f->fid_type == P9_FID_DIR) ?
+                s->ops->closedir(&s->ctx, &f->fs_reclaim) :
+                s->ops->close(&s->ctx, &f->fs_reclaim);
+            if (!err) {
+                total_open_fd--;
+            }
+        }
+    });
+    /* Free the closed FIDs. */
     while (!QSLIST_EMPTY(&reclaim_list)) {
         f = QSLIST_FIRST(&reclaim_list);
         QSLIST_REMOVE(&reclaim_list, f, V9fsFidState, reclaim_next);
-        if (f->fid_type == P9_FID_FILE) {
-            v9fs_co_close(pdu, &f->fs_reclaim);
-        } else if (f->fid_type == P9_FID_DIR) {
-            v9fs_co_closedir(pdu, &f->fs_reclaim);
-        }
         /*
          * Now drop the fid reference, free it
          * if clunked.
-- 
2.39.5


