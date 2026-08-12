Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CF7C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8dI-0006Zb-Iu; Wed, 12 Aug 2026 09:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dF-0006L8-0a; Wed, 12 Aug 2026 09:04:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dD-0004RI-57; Wed, 12 Aug 2026 09:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=bNYCM7AUlQaHgnOBi+mCWtNyBFh1HBzDF4jZQDmhflE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n4e7nrwBY9en9bEJ2+z0aGCYWtmNaCc7rBtEOd2GyEt5bheBE0X+ob961hT8Mn56y
 lWynt46G6o40CCwI9+hvwCqzPjDVbLPYFlD0DdezzLeYf6itpLPIBo/v4BBTNUPEg7
 0iG0OeHklTF8fy8iI4uxAfGBvJ8BoMrBPMa3cpLPGK6+DVtD2RajXUZhT7AlZaSm88
 tXH/V3L/BnkMIAENO1gtq3dh1+Vmy52QXLSyzPAqfi9Mzppvbkr9jQ7KTWXJLuCJQk
 Z8TGylqVyQRSwV1gXcsZh4tYnT3hp4kdqQHK2zz71yFyn9FHz0ySWFD37hD6DuVRF+
 CE4348+0gVm7Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A49C1CA491;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8FBB6409B74;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EF7472F8B8; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 018/102] hw/9pfs/xen: drain in-flight PDUs before
 xen-9p disconnect
Date: Wed, 12 Aug 2026 16:00:53 +0300
Message-ID: <20260812130233.621965-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/qemu-devel/82bc736158e827e05d4b55da27c39d42e2062e96.1784809978.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 1de8aea061b9d5bc7aaed182e2eebe9554debd68)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index bb263afe430..7a6655eb9b9 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4525,6 +4525,7 @@ void v9fs_device_unrealize_common(V9fsState *s)
     qp_table_destroy(&s->qpp_table);
     qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
+    s->transport = NULL;
 }
 
 typedef struct VirtfsCoResetData {
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 029a623bf76..5dbb74a4d20 100644
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
+        v9fs_reset(s); /* cancel all in-flight PDUs to prevent UAF */
+        v9fs_device_unrealize_common(s);
+    }
+
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].evtchndev != NULL) {
             qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),
-- 
2.47.3


