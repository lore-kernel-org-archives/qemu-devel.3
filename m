Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04062D5A6D9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 04:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFmqO-0002UZ-18; Mon, 25 Nov 2024 23:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFmqJ-0002UC-3U
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFmqG-0000QZ-KK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 23:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732593984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RRMSPY1SLofs8v6wOz3QWgrxgYKX4TXuyavq1J8ViE=;
 b=hkXaJdqqGAZD7N6pJ+ezR1NPOpdRFxR+Osf8smmCz/Tbr3RJGWJgspLGPAmSKCosAFMQyW
 C/YH0S0GQ8j7IToWLEhCN2wXCLp5GI1wfck1aLMra51ab7gLnFd+7BbEbjXNk/L2T1bMpA
 L7tvoVQxUOYOnsNjEK3vmb7OZuxk/GI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-jO9FzPyYMvqaVAjFNi3nEQ-1; Mon,
 25 Nov 2024 23:06:20 -0500
X-MC-Unique: jO9FzPyYMvqaVAjFNi3nEQ-1
X-Mimecast-MFC-AGG-ID: jO9FzPyYMvqaVAjFNi3nEQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6BF9195608A; Tue, 26 Nov 2024 04:06:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.25])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 290921956086; Tue, 26 Nov 2024 04:06:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/1] virtio-net: Add queues before loading them
Date: Tue, 26 Nov 2024 12:06:07 +0800
Message-ID: <20241126040607.1704-2-jasowang@redhat.com>
In-Reply-To: <20241126040607.1704-1-jasowang@redhat.com>
References: <20241126040607.1704-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Call virtio_net_set_multiqueue() to add queues before loading their
states. Otherwise the loaded queues will not have handlers and elements
in them will not be processed.

Cc: qemu-stable@nongnu.org
Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c        | 10 ++++++++++
 hw/virtio/virtio.c         |  7 +++++++
 include/hw/virtio/virtio.h |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index bc0f31b666..6e8c51a2db 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3064,6 +3064,15 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     virtio_net_set_queue_pairs(n);
 }
 
+static int virtio_net_pre_load_queues(VirtIODevice *vdev)
+{
+    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
+                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_RSS) ||
+                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MQ));
+
+    return 0;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
@@ -4073,6 +4082,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
     vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
     vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
+    vdc->pre_load_queues = virtio_net_pre_load_queues;
     vdc->post_load = virtio_net_post_load_virtio;
     vdc->vmsd = &vmstate_virtio_net_device;
     vdc->primary_unplug_pending = primary_unplug_pending;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a26f18908e..f12c4aa81e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3255,6 +3255,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         config_len--;
     }
 
+    if (vdc->pre_load_queues) {
+        ret = vdc->pre_load_queues(vdev);
+        if (ret) {
+            return ret;
+        }
+    }
+
     num = qemu_get_be32(f);
 
     if (num > VIRTIO_QUEUE_MAX) {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index f526ecc8fc..6386910280 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -210,6 +210,8 @@ struct VirtioDeviceClass {
     void (*guest_notifier_mask)(VirtIODevice *vdev, int n, bool mask);
     int (*start_ioeventfd)(VirtIODevice *vdev);
     void (*stop_ioeventfd)(VirtIODevice *vdev);
+    /* Called before loading queues. Useful to add queues before loading. */
+    int (*pre_load_queues)(VirtIODevice *vdev);
     /* Saving and loading of a device; trying to deprecate save/load
      * use vmsd for new devices.
      */
-- 
2.42.0


