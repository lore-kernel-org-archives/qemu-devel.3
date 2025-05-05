Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C1C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsWe-0002hA-EW; Mon, 05 May 2025 05:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <89f7b4da7662ecc6840ffb0846045f03f9714bc6@kylie.crudebyte.com>)
 id 1uBsWc-0002fU-I8
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:15 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <89f7b4da7662ecc6840ffb0846045f03f9714bc6@kylie.crudebyte.com>)
 id 1uBsWa-0005DI-Pm
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=t0gk0Gqr6Qzh1TrGyNei3b4Br5ttDRy7REOCNRUU2bg=; b=B/HM1
 kMH0ldrHxEjHlJGBcKS+9TlV9FjaYWX/W1LoKt1Uc/1ip8vH4VMbuvWoAIXYFVWjda+hLsWOkY0EE
 iyvM9sDN6XRwoJOKnftK9cZwGT+3YJiL1eWBzCxYPJ1xSMDWK4EWly4kF/a1ywIBNk1qTdJjJf4bM
 d1O/ogbyjaYYK9R6kX9f+d/SJyDNDr7aRez+T1cXjBE68qZHPWhAdSyJgcqLCaxB2z9uVevZrwJbC
 V1vgxHDS2NLUM/kpzKuXK10XP/6/jpP+/tcAhko8YfFlnoyy8da44Ihrrm97UxCIXhlAmDH2Asm81
 fKG0I1O16oxipb5PBYlLauv3na+/dZGGUJz9zg1YF9VuV4vAD7l9AQ2lpb2O9FmueNcZhTLIOOWqb
 UVV5CYUri6fqGvT4aNpGKjIKonUhGo7qHy4Ltlh3+zsjYKSJV1qEhHGSw+7T44mvjwXjILiwJtpKp
 sSufUyCuyurSFDwN3XlH415BiCl9+35QTmAfs2HBar4RcTxlJdA/QDyyZrH59AC2+UGWyKzT3Ccz5
 BzbkJVF9eIxTKOIm0Al6OFjwGJOrGe1FSFJ3D/q4JuiIkHjEnsfA0b3YtaPf8XuxJAL2zeV8s/Ahd
 1i4qet1dZYpkB3FkrMPgspgfDcIT2UEcL0cDmKPsYOfE76s2uslD6odh2pI4N0=;
Message-Id: <89f7b4da7662ecc6840ffb0846045f03f9714bc6.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 2/9] 9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=89f7b4da7662ecc6840ffb0846045f03f9714bc6@kylie.crudebyte.com;
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
---
 hw/9pfs/9p.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4f9c2dde9c..80b190ff5b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -434,6 +434,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
     V9fsFidState *f;
     GHashTableIter iter;
     gpointer fid;
+    int err;
+    int nclosed = 0;
 
     /* prevent multiple coroutines running this function simultaniously */
     if (s->reclaiming) {
@@ -446,10 +448,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
@@ -499,17 +501,26 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
2.30.2


