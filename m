Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036BCCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9h1l-0006vV-Ey; Fri, 17 Oct 2025 05:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1v9h1j-0006us-3r; Fri, 17 Oct 2025 05:45:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1v9h1f-0006H3-MW; Fri, 17 Oct 2025 05:45:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 192D2899DE;
 Fri, 17 Oct 2025 11:45:25 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, mst@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v2] hw/scsi: avoid deadlock upon TMF request cancelling with
 VirtIO
Date: Fri, 17 Oct 2025 11:43:30 +0200
Message-ID: <20251017094518.328905-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1760694320673
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

When scsi_req_dequeue() is reached via
scsi_req_cancel_async()
virtio_scsi_tmf_cancel_req()
virtio_scsi_do_tmf_aio_context(),
there is a deadlock when trying to acquire the SCSI device's requests
lock, because it was already acquired in
virtio_scsi_do_tmf_aio_context().

In particular, the issue happens with a FreeBSD guest (13, 14, 15,
maybe more), when it cancels SCSI requests, because of timeout.

This is a regression caused by commit da6eebb33b ("virtio-scsi:
perform TMFs in appropriate AioContexts") and the introduction of the
requests_lock earlier.

To fix the issue, only cancel the requests after releasing the
requests_lock. For this, the SCSI device's requests are iterated while
holding the requests_lock and the requests to be cancelled are
collected in a list. Then, the collected requests are cancelled
one by one while not holding the requests_lock. This is safe, because
only requests from the current AioContext are collected and acted
upon.

Originally reported by Proxmox VE users:
https://bugzilla.proxmox.com/show_bug.cgi?id=6810
https://forum.proxmox.com/threads/173914/

Fixes: da6eebb33b ("virtio-scsi: perform TMFs in appropriate AioContexts")
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Different approach, collect requests for cancelling in a list for a
  localized solution rather than keeping track of the lock status via
  function arguments.

 hw/scsi/virtio-scsi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d817fc42b4..2896b05808 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -339,6 +339,7 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
     SCSIDevice *d = virtio_scsi_device_get(s, tmf->req.tmf.lun);
     SCSIRequest *r;
     bool match_tag;
+    g_autoptr(GList) reqs = NULL;
 
     if (!d) {
         tmf->resp.tmf.response = VIRTIO_SCSI_S_BAD_TARGET;
@@ -374,10 +375,21 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
             if (match_tag && cmd_req->req.cmd.tag != tmf->req.tmf.tag) {
                 continue;
             }
-            virtio_scsi_tmf_cancel_req(tmf, r);
+            /*
+             * Cannot cancel directly, because scsi_req_dequeue() would deadlock
+             * when attempting to acquire the request_lock a second time. Taking
+             * a reference here is paired with an unref after cancelling below.
+             */
+            scsi_req_ref(r);
+            reqs = g_list_append(reqs, r);
         }
     }
 
+    for (GList *elem = g_list_first(reqs); elem; elem = g_list_next(elem)) {
+        virtio_scsi_tmf_cancel_req(tmf, elem->data);
+        scsi_req_unref(elem->data);
+    }
+
     /* Incremented by virtio_scsi_do_tmf() */
     virtio_scsi_tmf_dec_remaining(tmf);
 
-- 
2.47.3



