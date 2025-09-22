Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B66CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 22:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0obp-0005ns-Ou; Mon, 22 Sep 2025 18:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obk-0005jS-7R
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obi-0001st-4U
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758578520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+xonViXNrhX+Y2vsLPFiHj9moTtLnBh7lb0zW5gpSs=;
 b=NU70kbxSLbwhorBf3aznZUZfKoQYhQzQdbPhE+uaOE2MNwoY9ZR42z22Fr++fZVm93kXWB
 Y0M5qBjy5Kp0kIn1JiiPf5zhMwbo8y8n+shaM4YWY2Lz7yFwl2/fJY3NrZ3x2v199k6Tss
 UXO9E6vHzbXyVQzievYe0BbiiZiJGpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-8LiljfrPMYOFHj6hPTKjOg-1; Mon,
 22 Sep 2025 18:01:56 -0400
X-MC-Unique: 8LiljfrPMYOFHj6hPTKjOg-1
X-Mimecast-MFC-AGG-ID: 8LiljfrPMYOFHj6hPTKjOg_1758578515
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A33421800452; Mon, 22 Sep 2025 22:01:54 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E88211800452; Mon, 22 Sep 2025 22:01:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/5] vhost: use virtio_config_get_guest_notifier()
Date: Mon, 22 Sep 2025 18:01:45 -0400
Message-ID: <20250922220149.498967-2-stefanha@redhat.com>
In-Reply-To: <20250922220149.498967-1-stefanha@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There is a getter function so avoid accessing the ->config_notifier
field directly.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12..37b39aa0c2 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1817,7 +1817,7 @@ void vhost_config_mask(struct vhost_dev *hdev, VirtIODevice *vdev, bool mask)
     int r;
     EventNotifier *notifier =
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier;
-    EventNotifier *config_notifier = &vdev->config_notifier;
+    EventNotifier *config_notifier = virtio_config_get_guest_notifier(vdev);
     assert(hdev->vhost_ops);
 
     if ((hdev->started == false) ||
@@ -1848,13 +1848,15 @@ static void vhost_stop_config_intr(struct vhost_dev *dev)
 static void vhost_start_config_intr(struct vhost_dev *dev)
 {
     int r;
+    EventNotifier *config_notifier =
+        virtio_config_get_guest_notifier(dev->vdev);
 
     assert(dev->vhost_ops);
-    int fd = event_notifier_get_fd(&dev->vdev->config_notifier);
+    int fd = event_notifier_get_fd(config_notifier);
     if (dev->vhost_ops->vhost_set_config_call) {
         r = dev->vhost_ops->vhost_set_config_call(dev, fd);
         if (!r) {
-            event_notifier_set(&dev->vdev->config_notifier);
+            event_notifier_set(config_notifier);
         }
     }
 }
@@ -2139,12 +2141,13 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
 {
     int i;
     int rc = 0;
+    EventNotifier *config_notifier = virtio_config_get_guest_notifier(vdev);
 
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
-    event_notifier_test_and_clear(&vdev->config_notifier);
+    event_notifier_test_and_clear(config_notifier);
     event_notifier_cleanup(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
-- 
2.51.0


