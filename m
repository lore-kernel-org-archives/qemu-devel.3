Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFEBC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBgs-0002zo-5L; Wed, 14 May 2025 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgg-00029M-1r; Wed, 14 May 2025 08:58:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgd-0007nq-DM; Wed, 14 May 2025 08:58:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FD20121AD2;
 Wed, 14 May 2025 15:56:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C08620B84A;
 Wed, 14 May 2025 15:56:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.18 18/18] 9pfs: fix FD leak and reduce latency of
 v9fs_reclaim_fd()
Date: Wed, 14 May 2025 15:56:24 +0300
Message-Id: <20250514125640.91677-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
References: <qemu-stable-7.2.18-20250514114012@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

This patch fixes two different bugs in v9fs_reclaim_fd():

1. Reduce latency:

This function calls v9fs_co_close() and v9fs_co_closedir() in a loop. Each
one of the calls adds two thread hops (between main thread and a fs driver
background thread). Each thread hop adds latency, which sums up in
function's loop to a significant duration.

Reduce overall latency by open coding what v9fs_co_close() and
v9fs_co_closedir() do, executing those and the loop itself altogether in
only one background thread block, hence reducing the total amount of
thread hops to only two.

2. Fix file descriptor leak:

The existing code called v9fs_co_close() and v9fs_co_closedir() to close
file descriptors. Both functions check right at the beginning if the 9p
request was cancelled:

    if (v9fs_request_cancelled(pdu)) {
        return -EINTR;
    }

So if client sent a 'Tflush' message, v9fs_co_close() / v9fs_co_closedir()
returned without having closed the file descriptor and v9fs_reclaim_fd()
subsequently freed the FID without its file descriptor being closed, hence
leaking those file descriptors.

This 2nd bug is fixed by this patch as well by open coding v9fs_co_close()
and v9fs_co_closedir() inside of v9fs_reclaim_fd() and not performing the
v9fs_request_cancelled(pdu) check there.

Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
Fixes: bccacf6c792 ('hw/9pfs: Implement TFLUSH operation')
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <5747469d3f039c53147e850b456943a1d4b5485c.1741339452.git.qemu_oss@crudebyte.com>
(cherry picked from commit 89f7b4da7662ecc6840ffb0846045f03f9714bc6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 0afaf93645..e7cfc77071 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -440,6 +440,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
     V9fsFidState *f;
     GHashTableIter iter;
     gpointer fid;
+    int err;
+    int nclosed = 0;
 
     /* prevent multiple coroutines running this function simultaniously */
     if (s->reclaiming) {
@@ -452,10 +454,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
@@ -505,17 +507,26 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
+                /* total_open_fd must only be mutated on main thread */
+                nclosed++;
+            }
+        }
+    });
+    total_open_fd -= nclosed;
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


