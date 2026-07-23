Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706DAC531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsq6-0008QQ-Vc; Thu, 23 Jul 2026 08:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <82bc736158e827e05d4b55da27c39d42e2062e96@kylie.crudebyte.com>)
 id 1wmsq5-0008Pr-BN; Thu, 23 Jul 2026 08:47:49 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <82bc736158e827e05d4b55da27c39d42e2062e96@kylie.crudebyte.com>)
 id 1wmsq3-0001BP-Lr; Thu, 23 Jul 2026 08:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=5s4DKpC1T0PeqN+HSt0e5weoQMg0AJgXHQ4lDgYkK8g=; b=LQx6M
 bbmcCxGkeHm/6RlU03Co+kEysM8bd4y2gvK940DACKFRw+Mw+DzIhjyBc7aY8e+pDHOCYd2ckk9JE
 xeQFaCtY7LJhi4V11oBZVmcxuPvGdg7TH5i1Z4qv4hJDSkfUkh0FCNPHnNLXFcVwAXAx6u8w+SWla
 O1RhvoR6nu6ZP1zylX+nfUuhzUQo4zZtfbPu0CvJxa7Z/VbFAuXYwGa2548Y3poxd/JW2SEPZXk7t
 5ZuXvDQMX4sqJdc2fJcRDugwRN0mJEzG3Iy6IIjvdrYgdJWXTpmMrTDHjTZOFRXLmjIXgKvJI6qF5
 lPwPI3JJox1dG8WussmPROJviVQL5AwjLS4Zxh5JdIs7tcKQLipCTrnJIZpwAD+tuTkCRPa05AfmR
 pobj+zw9Q4vadtkCsnmZlVxzUjKU5sze3BF7wPQ5eMSUohMBLbzwWfc8LmZsmDol5PvpDPzYExgPy
 LFNKu7kbuLK+fhmHP7zv6vY5cgeKA1IfZbgTpczzlRgBCGw45VKknokkiHgn5/PLgpv72yVF2qkFr
 3I1okD6QFMS9ehTjZkXw722+j/IrQNA3QYjvxlhxmomUuKs2ME71pMtchgfpZxmqr+q1nCT7efAEw
 VtFuHCZnl8eoKShCX9cfKLGFpAdWGOgO34P0n+P9KdD5Dg4O5reJTwXpPvrWeI=;
Message-ID: <82bc736158e827e05d4b55da27c39d42e2062e96.1784809978.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1784809978.git.qemu_oss@crudebyte.com>
References: <cover.1784809978.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 23 Jul 2026 14:43:24 +0200
Subject: [PATCH v3 2/2] hw/9pfs/xen: drain in-flight PDUs before xen-9p
 disconnect
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=82bc736158e827e05d4b55da27c39d42e2062e96@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The xen-9p disconnect path has two issues:

1. It frees the Xen9pfsRing structures while in-flight PDUs may still
   reference them via pdu->tag to index rings[]. This causes a UAF
   in xen_9pfs_push_and_notify() when worker threads resume after
   completing filesystem operations.

2. It never calls v9fs_device_unrealize_common(), which means server
   state (struct LocalData, mountfd, FIDs) is never cleaned up on
   disconnect, causing a resource leak on every guest-initiated
   disconnect.

Fix both by draining in-flight PDUs via v9fs_reset() before tearing
down rings, and calling v9fs_device_unrealize_common() to clean up
server state.

Additionally, explicit calls of xen_9pfs_disconnect() in the error
paths of xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal() must
be deferred (via aio_bh_schedule_oneshot()), because
xen_9pfs_pdu_v(un)marshal() are running within a coroutine context
which makes them unsafe [1] for calling v9fs_reset() directly, as
the latter e.g. has a loop like:

    while (!QLIST_EMPTY(&s->active_list)) {
        aio_poll(qemu_get_aio_context(), true);
    }

which would a) never terminate (as the coroutine is on the
active_list) and b) aio_poll() is marked as no_coroutine_fn.

[1] https://lore.kernel.org/qemu-devel/3351181.5fSG56mABF@weasel/

And finally, add an idempotent guard to xen_9pfs_disconnect()
for the v9fs_reset(s) and v9fs_device_unrealize_common(s) calls
specifically [2], just to be sure.

[2] https://lore.kernel.org/qemu-devel/alpine.DEB.2.22.394.2607221815520.5295@ubuntu-linux-20-04-desktop/

Fixes: b37eeb0201 ("xen/9pfs: introduce Xen 9pfs backend")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/9pfs/9p.c             |  1 +
 hw/9pfs/xen-9p-backend.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3119f01117..fc01791830 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4530,6 +4530,7 @@ void v9fs_device_unrealize_common(V9fsState *s)
     qp_table_destroy(&s->qpp_table);
     qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
+    s->transport = NULL;
 }
 
 typedef struct VirtfsCoResetData {
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 24c90d97ec..a2f118d2ca 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -68,6 +68,11 @@ typedef struct Xen9pfsDev {
 
 static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev);
 
+static void xen_9pfs_disconnect_bh(void *opaque)
+{
+    xen_9pfs_disconnect(opaque);
+}
+
 static void xen_9pfs_in_sg(Xen9pfsRing *ring,
                            struct iovec *in_sg,
                            int *num,
@@ -150,7 +155,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
                       "Failed to encode VirtFS reply type %d\n",
                       pdu->id + 1);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
     }
     return ret;
 }
@@ -173,7 +179,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
         xen_pv_printf(&xen_9pfs->xendev, 0,
                       "Failed to decode VirtFS request type %d\n", pdu->id);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                xen_9pfs_disconnect_bh, &xen_9pfs->xendev);
     }
     return ret;
 }
@@ -368,10 +375,16 @@ static void xen_9pfs_evtchn_event(void *opaque)
 static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
 {
     Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
+    V9fsState *s = &xen_9pdev->state;
     int i;
 
     trace_xen_9pfs_disconnect(xendev->name);
 
+    if (s->transport) {
+        v9fs_reset(s);
+        v9fs_device_unrealize_common(s);
+    }
+
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].evtchndev != NULL) {
             qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),
-- 
2.47.3


