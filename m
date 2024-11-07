Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0BAD4334B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90l7-0005Nw-22; Thu, 07 Nov 2024 06:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t90l5-0005Ne-Ho
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t90l3-0006rW-Q8
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730979180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EAlf1esU1xSfq+VtXu0Tm48LErSjqFQEjpSI19x/rUI=;
 b=CmfyR2mhVxvl5YCW2/5fY7ea/p9Wxc+6IBrglIA8Cw8fx9DB8dWiDAbQ4FMeGym4c2kZ7I
 VXUTSjG2sID+OZ+/4czqTWP79G05efk9KjwrkjHdoWEtCqGtWm3eg3tSgEVH4Y5E/C3U+2
 GGlHZHeSkmw6WNuvVLR9dQihSOTsxgk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-QtFhxlD-PA2snfeXzJRX0w-1; Thu,
 07 Nov 2024 06:32:59 -0500
X-MC-Unique: QtFhxlD-PA2snfeXzJRX0w-1
X-Mimecast-MFC-AGG-ID: QtFhxlD-PA2snfeXzJRX0w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CEA6195608D; Thu,  7 Nov 2024 11:32:58 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 654133003B7E; Thu,  7 Nov 2024 11:32:52 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 eperezma@redhat.com, mst@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v1] vhost: fail device start if iotlb update fails
Date: Thu,  7 Nov 2024 17:02:47 +0530
Message-ID: <20241107113247.46532-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

While starting a vhost device, updating iotlb entries
via 'vhost_device_iotlb_miss' may return an error.

  qemu-kvm: vhost_device_iotlb_miss:
    700871,700871: Fail to update device iotlb

Fail device start when such an error occurs.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 hw/virtio/vhost.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

v1:
 - Remove VHOST_OPS_DEBUG call.
 - Call vhost_set_iotlb_callback and vhost_dev_start with 'false' argument.

v0:
 - https://lore.kernel.org/qemu-devel/20241105060053.61973-1-ppandit@redhat.com/

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 76f9b2aaad..c40f48ac4d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2095,11 +2095,22 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
          * vhost-kernel code requires for this.*/
         for (i = 0; i < hdev->nvqs; ++i) {
             struct vhost_virtqueue *vq = hdev->vqs + i;
-            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            if (r) {
+                goto fail_iotlb;
+            }
         }
     }
     vhost_start_config_intr(hdev);
     return 0;
+fail_iotlb:
+    if (vhost_dev_has_iommu(hdev) &&
+        hdev->vhost_ops->vhost_set_iotlb_callback) {
+        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+    }
+    if (hdev->vhost_ops->vhost_dev_start) {
+        hdev->vhost_ops->vhost_dev_start(hdev, false);
+    }
 fail_start:
     if (vrings) {
         vhost_dev_set_vring_enable(hdev, false);
--
2.47.0


