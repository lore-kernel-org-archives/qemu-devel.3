Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A8DC4828E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbVb-0006fG-4k; Thu, 01 Feb 2024 13:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVbVX-0006f1-H2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVbVS-00043j-F3
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706810984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIP/MlrRVjXgF3454g4Zb/2M6TLjZzW2UdY3TCSmNPw=;
 b=HF+eKcCf/5+BW+GWp9aWAooCcbnsDMFahvT1c3n9i5VPdbplwBDJpazIUQcUXtjE5evYAP
 TR8p7Ty75ZImprh/wToC+3H3eZYMJNWXAXMUIdWQFT7KPDG9XMEXPkhS9XQTpG3F13erIF
 0kR3ANGy8xPbjJCpJ380EyUGoH0Aqds=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-LYPFFbkhPXqYwD8k1fEbhg-1; Thu,
 01 Feb 2024 13:09:41 -0500
X-MC-Unique: LYPFFbkhPXqYwD8k1fEbhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 469DE280A9A6;
 Thu,  1 Feb 2024 18:09:39 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A51A2026D66;
 Thu,  1 Feb 2024 18:09:37 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH v2 4/7] vdpa: add listener_registered
Date: Thu,  1 Feb 2024 19:09:21 +0100
Message-ID: <20240201180924.487579-5-eperezma@redhat.com>
In-Reply-To: <20240201180924.487579-1-eperezma@redhat.com>
References: <20240201180924.487579-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Check if the listener has been registered or not, so it needs to be
registered again at start.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c         | 7 ++++++-
 include/hw/virtio/vhost-vdpa.h | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index bd4db7ba5f..b08349d57c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1331,7 +1331,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
-        memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+        if (!v->shared->listener_registered) {
+            memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+            v->shared->listener_registered = true;
+        }
 
         return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
     }
@@ -1351,6 +1354,8 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
     memory_listener_unregister(&v->shared->listener);
+    v->shared->listener_registered = false;
+
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 8f54e5edd4..03ed2f2be3 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -45,6 +45,12 @@ typedef struct vhost_vdpa_shared {
 
     bool iotlb_batch_begin_sent;
 
+    /*
+     * The memory listener has been registered, so DMA maps have been sent to
+     * the device.
+     */
+    bool listener_registered;
+
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 } VhostVDPAShared;
-- 
2.43.0


