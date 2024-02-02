Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74588C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvWu-0003xM-TS; Fri, 02 Feb 2024 10:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvWp-0003wL-53
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvWn-0000Cz-ME
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706887949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4kLnxg36usZFpQhx4sfCVBUfiBAwdw9PmM+uBUrSt0=;
 b=fw3cVibxe2aNvQkGg2VvlzWp/aP/ObiOOei9OEus0y914AyJBscn58IVFFwX8Kzv+ArZFm
 Nkc8j0SSkbF+3a43Yef9ypaXlA7NOSVFxsRxvClsEd8/blyVnhZORZ37/pTS8KC9Ux2Ekg
 NxdRntan49Q4R7tJG0J9PkABISPP3eE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-pr7SFxbtOc2-ddxnirvLDw-1; Fri, 02 Feb 2024 10:32:26 -0500
X-MC-Unique: pr7SFxbtOc2-ddxnirvLDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B2EC185A782;
 Fri,  2 Feb 2024 15:32:26 +0000 (UTC)
Received: from localhost (unknown [10.39.194.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B964A1C060AF;
 Fri,  2 Feb 2024 15:32:25 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 1/3] virtio-scsi: Attach event vq notifier with no_poll
Date: Fri,  2 Feb 2024 16:31:56 +0100
Message-ID: <20240202153158.788922-2-hreitz@redhat.com>
In-Reply-To: <20240202153158.788922-1-hreitz@redhat.com>
References: <20240202153158.788922-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/scsi/virtio-scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 690aceec45..9f02ceea09 100644
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
2.43.0


