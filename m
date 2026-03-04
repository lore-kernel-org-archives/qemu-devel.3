Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1C3EFCE23
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxq8y-0003JU-61; Wed, 04 Mar 2026 12:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8k-0003Cd-Ox
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8j-0004tu-30
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772645764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAOW4K1EpW75YeuYdYjpjD4JVh2qQvzbdBEf2KCXE/Q=;
 b=V3u1J747omeN+D3eaAJj1bCx6yAeymcf4S6b2Jz/mBc87AZHlCdKoD+tgDLVyiK3btWPQ0
 84B/BaGYtKNkbZonHWOZz56ig7NCLhYVnJTMwuvfCPahj5Vrg128R4cm2PiROb3V4mhe+f
 yZAE1UBles5l0viupP/h8z+yMnw4nBQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-9AtE4JQEOXG_we_zdqTudA-1; Wed,
 04 Mar 2026 12:36:01 -0500
X-MC-Unique: 9AtE4JQEOXG_we_zdqTudA-1
X-Mimecast-MFC-AGG-ID: 9AtE4JQEOXG_we_zdqTudA_1772645760
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E56D319560B5; Wed,  4 Mar 2026 17:35:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.212])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C55D81958DC5; Wed,  4 Mar 2026 17:35:55 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea DE <dtatulea@nvidia.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Koushik Dutta <kdutta@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 4/7] vhost: factor out the get of last used desc in SVQ
Date: Wed,  4 Mar 2026 18:35:32 +0100
Message-ID: <20260304173535.2702587-5-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-1-eperezma@redhat.com>
References: <20260304173535.2702587-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This code path is modified to handle in order devices.  Abstract here so
we can generalize on the caller.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 45 +++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 7adacd4f542a..e7e3c9155cd0 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -444,6 +444,25 @@ static void vhost_svq_disable_notification(VhostShadowVirtqueue *svq)
     }
 }
 
+/*
+ * Gets the next buffer id and moves forward the used idx, so the next time
+ * SVQ calls this function will get the next one.
+ *
+ * @svq: Shadow VirtQueue
+ * @len: Consumed length by the device.
+ *
+ * Return the next descriptor consumed by the device.
+ */
+static uint16_t vhost_svq_get_last_used_split(VhostShadowVirtqueue *svq,
+                                              uint32_t *len)
+{
+    const vring_used_t *used = svq->vring.used;
+    uint16_t last_used = svq->last_used_idx++ & (svq->vring.num - 1);
+
+    *len = le32_to_cpu(used->ring[last_used].len);
+    return le32_to_cpu(used->ring[last_used].id);
+}
+
 static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
@@ -458,8 +477,6 @@ G_GNUC_WARN_UNUSED_RESULT
 static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                            uint32_t *len)
 {
-    const vring_used_t *used = svq->vring.used;
-    vring_used_elem_t used_elem;
     uint16_t last_used, last_used_chain, num;
 
     if (!vhost_svq_more_used(svq)) {
@@ -468,33 +485,29 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
 
     /* Only get used array entries after they have been exposed by dev */
     smp_rmb();
-    last_used = svq->last_used_idx & (svq->vring.num - 1);
-    used_elem.id = le32_to_cpu(used->ring[last_used].id);
-    used_elem.len = le32_to_cpu(used->ring[last_used].len);
+    last_used = vhost_svq_get_last_used_split(svq, len);
 
-    svq->last_used_idx++;
-    if (unlikely(used_elem.id >= svq->vring.num)) {
+    if (unlikely(last_used >= svq->vring.num)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
-                      svq->vdev->name, used_elem.id);
+                      svq->vdev->name, last_used);
         return NULL;
     }
 
-    if (unlikely(!svq->desc_state[used_elem.id].ndescs)) {
+    if (unlikely(!svq->desc_state[last_used].ndescs)) {
         qemu_log_mask(LOG_GUEST_ERROR,
             "Device %s says index %u is used, but it was not available",
-            svq->vdev->name, used_elem.id);
+            svq->vdev->name, last_used);
         return NULL;
     }
 
-    num = svq->desc_state[used_elem.id].ndescs;
-    svq->desc_state[used_elem.id].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
+    num = svq->desc_state[last_used].ndescs;
+    svq->desc_state[last_used].ndescs = 0;
+    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, last_used);
     svq->desc_state[last_used_chain].next = svq->free_head;
-    svq->free_head = used_elem.id;
+    svq->free_head = last_used;
     svq->num_free += num;
 
-    *len = used_elem.len;
-    return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
+    return g_steal_pointer(&svq->desc_state[last_used].elem);
 }
 
 /**
-- 
2.53.0


