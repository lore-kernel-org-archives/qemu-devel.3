Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9836CD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 01:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpI8J-0005g8-9v; Tue, 26 Mar 2024 21:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpI8G-0005fs-Uw
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpI8C-00040K-6y
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711503062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fk/8WpCis16alrDsadAD/keSsbupEqlLK6z5jeJxpA=;
 b=AVNFBqv6SLtRyX7B2xD3wJB64FvVAl4dMZJ0+Gi2U4udOK1IH5wEWlMPkvOsooB6pz8+Et
 6XT+nfLPKHZ+XyZ4cTaToI950A7mTlXatlv5WcrKu27wlg1FF6soIqeLKIdnR2rOJc/072
 QYaB2WngsXAzHUMPDW0KQntic57Ll3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Lt5MTGmONUCf6v89PZXknA-1; Tue, 26 Mar 2024 21:29:25 -0400
X-MC-Unique: Lt5MTGmONUCf6v89PZXknA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAA7588B7A1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:29:24 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C61B2492BD0;
 Wed, 27 Mar 2024 01:29:22 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [RFC 2/2] virtio-pci: check if the configure interrupt enable
Date: Wed, 27 Mar 2024 09:22:15 +0800
Message-ID: <20240327012905.70188-3-lulu@redhat.com>
In-Reply-To: <20240327012905.70188-1-lulu@redhat.com>
References: <20240327012905.70188-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If config_irq_enabled is not true, it means that configure interrupt is
not supported. Therefore, the config vector will not be handled during
the interrupt process.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/virtio-pci.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e433879542..36ad7da206 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1065,7 +1065,7 @@ static int virtio_pci_vector_unmask(PCIDevice *dev, unsigned vector,
         vq = virtio_vector_next_queue(vq);
     }
     /* unmask config intr */
-    if (vector == vdev->config_vector) {
+    if ((vector == vdev->config_vector) && (true == vdev->config_irq_enabled)) {
         n = virtio_config_get_guest_notifier(vdev);
         ret = virtio_pci_one_vector_unmask(proxy, VIRTIO_CONFIG_IRQ_IDX, vector,
                                            msg, n);
@@ -1111,7 +1111,7 @@ static void virtio_pci_vector_mask(PCIDevice *dev, unsigned vector)
         vq = virtio_vector_next_queue(vq);
     }
 
-    if (vector == vdev->config_vector) {
+    if ((vector == vdev->config_vector) && (true == vdev->config_irq_enabled)) {
         n = virtio_config_get_guest_notifier(vdev);
         virtio_pci_one_vector_mask(proxy, VIRTIO_CONFIG_IRQ_IDX, vector, n);
     }
@@ -1147,21 +1147,24 @@ static void virtio_pci_vector_poll(PCIDevice *dev,
         }
     }
     /* poll the config intr */
-    ret = virtio_pci_get_notifier(proxy, VIRTIO_CONFIG_IRQ_IDX, &notifier,
-                                  &vector);
-    if (ret < 0) {
-        return;
-    }
-    if (vector < vector_start || vector >= vector_end ||
-        !msix_is_masked(dev, vector)) {
-        return;
-    }
-    if (k->guest_notifier_pending) {
-        if (k->guest_notifier_pending(vdev, VIRTIO_CONFIG_IRQ_IDX)) {
+    if (true == vdev->config_irq_enabled) {
+        ret = virtio_pci_get_notifier(proxy, VIRTIO_CONFIG_IRQ_IDX, &notifier,
+                                      &vector);
+        if (ret < 0) {
+            return;
+        }
+
+        if (vector < vector_start || vector >= vector_end ||
+            !msix_is_masked(dev, vector)) {
+            return;
+        }
+        if (k->guest_notifier_pending) {
+            if (k->guest_notifier_pending(vdev, VIRTIO_CONFIG_IRQ_IDX)) {
+                msix_set_pending(dev, vector);
+            }
+        } else if (event_notifier_test_and_clear(notifier)) {
             msix_set_pending(dev, vector);
         }
-    } else if (event_notifier_test_and_clear(notifier)) {
-        msix_set_pending(dev, vector);
     }
 }
 
@@ -1282,9 +1285,11 @@ static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
             if (r < 0) {
                 goto config_assign_error;
             }
-            r = kvm_virtio_pci_vector_config_use(proxy);
-            if (r < 0) {
-                goto config_error;
+            if (true == vdev->config_irq_enabled) {
+                r = kvm_virtio_pci_vector_config_use(proxy);
+                if (r < 0) {
+                    goto config_error;
+                }
             }
         }
 
-- 
2.43.0


