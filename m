Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDF7CD11DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 01:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpI8L-0005ga-Ev; Tue, 26 Mar 2024 21:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpI8F-0005fq-U3
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpI87-0003zc-T7
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711503062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXKZoU8MHcfNRGyo/3SIhLzxK8Y11kXEEXLI+VH1j1Y=;
 b=GuOV8cP+dJHy9Rprt2pgy7rbbpMAtVEdd/oj90mYLk8fcO09MEh03j2R8jk+WvJR7BpOft
 ShmqtDSfXvQFCjwga5LZ9uNb++Xm/5M1Nl1vGos4haZDGftw2VyZKdS7ZIoG7VYfwWLIf1
 3w+QRizPEAQtckEZfwUp5ZLXS11VSOs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-nrMtFr7uNAa6U4I6d6Bg7Q-1; Tue,
 26 Mar 2024 21:29:21 -0400
X-MC-Unique: nrMtFr7uNAa6U4I6d6Bg7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3996F2802E26
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:29:21 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 248C4492BD0;
 Wed, 27 Mar 2024 01:29:18 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [RFC 1/2] virtio-net: disable the configure interrupt for not support
 device
Date: Wed, 27 Mar 2024 09:22:14 +0800
Message-ID: <20240327012905.70188-2-lulu@redhat.com>
In-Reply-To: <20240327012905.70188-1-lulu@redhat.com>
References: <20240327012905.70188-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
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

Only the vdpa device support configure interrupt, we need to disable the
configure interrupt process in all other device.
In order to achieve this, I added a check in the virtio_net_device_realize().
When the peer's type is vdpa, the value of config_irq_enabled in the structure
VirtIODevice will set to true.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c        | 5 ++++-
 hw/virtio/virtio.c         | 1 +
 include/hw/virtio/virtio.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 80c56f0cfc..3b487864a8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3749,12 +3749,15 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
+    vdev->config_irq_enabled = false;
 
-   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
         struct virtio_net_config netcfg = {};
         memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
         vhost_net_set_config(get_vhost_net(nc->peer),
             (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
+
+        vdev->config_irq_enabled = true;
     }
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3a160f86ed..6b52a7190d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3255,6 +3255,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
             virtio_vmstate_change, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
+    vdev->config_irq_enabled = false;
 }
 
 /*
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..a7763b71e0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -164,6 +164,7 @@ struct VirtIODevice
      */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
+    bool config_irq_enabled;
 };
 
 struct VirtioDeviceClass {
-- 
2.43.0


