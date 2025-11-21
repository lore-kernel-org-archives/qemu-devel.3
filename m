Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CFACFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdRe-00059Y-Li; Fri, 21 Nov 2025 21:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdRZ-00055v-S5; Fri, 21 Nov 2025 21:33:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdQg-0000N1-Az; Fri, 21 Nov 2025 21:33:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D98DF16C6E7;
 Fri, 21 Nov 2025 16:51:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F0BE321984;
 Fri, 21 Nov 2025 16:52:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 15/76] hw/scsi: avoid deadlock upon TMF request
 cancelling with VirtIO
Date: Fri, 21 Nov 2025 16:50:53 +0300
Message-ID: <20251121135201.1114964-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

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
Message-id: 20251017094518.328905-1-f.ebner@proxmox.com
[Changed g_list_append() to g_list_prepend() to avoid traversing the
list each time.
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 6910f04aa646f63a0257f77201ad8ea15992b816)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 34ae14f7bf..3b635053b5 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -343,6 +343,7 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
     SCSIDevice *d = virtio_scsi_device_get(s, tmf->req.tmf.lun);
     SCSIRequest *r;
     bool match_tag;
+    g_autoptr(GList) reqs = NULL;
 
     if (!d) {
         tmf->resp.tmf.response = VIRTIO_SCSI_S_BAD_TARGET;
@@ -378,10 +379,21 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
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
+            reqs = g_list_prepend(reqs, r);
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


