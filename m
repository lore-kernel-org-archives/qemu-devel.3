Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A995C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchrq-0002KR-KR; Wed, 21 Feb 2024 03:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchrp-0002Iz-6j; Wed, 21 Feb 2024 03:22:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchrn-0002DR-Ii; Wed, 21 Feb 2024 03:22:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 05F454F3CF;
 Wed, 21 Feb 2024 11:21:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C36A4860AE;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142038 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 17/60] virtio-scsi: Attach event vq notifier with
 no_poll
Date: Wed, 21 Feb 2024 11:20:05 +0300
Message-Id: <20240221082058.2141850-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

As of commit 38738f7dbbda90fbc161757b7f4be35b52205552 ("virtio-scsi:
don't waste CPU polling the event virtqueue"), we only attach an io_read
notifier for the virtio-scsi event virtqueue instead, and no polling
notifiers.  During operation, the event virtqueue is typically
non-empty, but none of the buffers are intended to be used immediately.
Instead, they only get used when certain events occur.  Therefore, it
makes no sense to continuously poll it when non-empty, because it is
supposed to be and stay non-empty.

We do this by using virtio_queue_aio_attach_host_notifier_no_poll()
instead of virtio_queue_aio_attach_host_notifier() for the event
virtqueue.

Commit 766aa2de0f29b657148e04599320d771c36fd126 ("virtio-scsi: implement
BlockDevOps->drained_begin()") however has virtio_scsi_drained_end() use
virtio_queue_aio_attach_host_notifier() for all virtqueues, including
the event virtqueue.  This can lead to it being polled again, undoing
the benefit of commit 38738f7dbbda90fbc161757b7f4be35b52205552.

Fix it by using virtio_queue_aio_attach_host_notifier_no_poll() for the
event virtqueue.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Fixes: 766aa2de0f29b657148e04599320d771c36fd126
       ("virtio-scsi: implement BlockDevOps->drained_begin()")
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20240202153158.788922-2-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit c42c3833e0cfdf2b80fb3ca410acfd392b6874ab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 9c751bf296..4b0d476c8d 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1149,6 +1149,7 @@ static void virtio_scsi_drained_begin(SCSIBus *bus)
 static void virtio_scsi_drained_end(SCSIBus *bus)
 {
     VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     uint32_t total_queues = VIRTIO_SCSI_VQ_NUM_FIXED +
                             s->parent_obj.conf.num_queues;
@@ -1166,7 +1167,11 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
 
     for (uint32_t i = 0; i < total_queues; i++) {
         VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
+        if (vq == vs->event_vq) {
+            virtio_queue_aio_attach_host_notifier_no_poll(vq, s->ctx);
+        } else {
+            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
+        }
     }
 }
 
-- 
2.39.2


