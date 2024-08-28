Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2076AC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 10:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFcQ-00058I-Qp; Wed, 28 Aug 2024 06:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sjFcO-00051f-Pv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sjFcN-0003V7-3q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724839774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6u976r1UbeXOX7Y6RAdw8ezHrTuTKZo87ydEZqwOg4=;
 b=jHOXeqWL48QkedFi4g22cEBCOGct0jX0Q6QnG+8YUFCyKowROpv0kM4H4izdt6bpI28Vo5
 D/iAo4xmYQ9LQnMHW0gboHO8E4OlkI3u+JciAf9TjLlHldK0B0qePgKALH9AFNZaGHhld6
 HVGRu9YgPUxlPXPk0RVehvC4qqH4xfg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-YCjo7GvHP3Co0OdbdqhbkA-1; Wed,
 28 Aug 2024 06:09:30 -0400
X-MC-Unique: YCjo7GvHP3Co0OdbdqhbkA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E41F01955D55; Wed, 28 Aug 2024 10:09:29 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.39.192.70])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B8711955F1B; Wed, 28 Aug 2024 10:09:25 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, farosas@suse.de, jasowang@redhat.com, mcoqueli@redhat.com,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2 1/2] vhost: fail device start if iotlb update fails
Date: Wed, 28 Aug 2024 15:39:13 +0530
Message-ID: <20240828100914.105728-2-ppandit@redhat.com>
In-Reply-To: <20240828100914.105728-1-ppandit@redhat.com>
References: <20240828100914.105728-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

While starting a vhost device, updating iotlb entries
via 'vhost_device_iotlb_miss' may return an error.

  qemu-kvm: vhost_device_iotlb_miss:
    700871,700871: Fail to update device iotlb

Fail device start when such an error occurs.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 hw/virtio/vhost.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

v2:
 - Needs review/ack

v1:
 - https://lore.kernel.org/qemu-devel/20240808095147.291626-2-ppandit@redhat.com/

v0:
 - https://lore.kernel.org/all/20240711131424.181615-3-ppandit@redhat.com/

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 06fc71746e..a70b7422b5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2151,7 +2151,11 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
          * vhost-kernel code requires for this.*/
         for (i = 0; i < hdev->nvqs; ++i) {
             struct vhost_virtqueue *vq = hdev->vqs + i;
-            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            if (r) {
+                VHOST_OPS_DEBUG(r, "vhost_device_iotlb_miss failed");
+                goto fail_start;
+            }
         }
     }
     vhost_start_config_intr(hdev);
--
2.46.0


