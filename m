Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F9CEFCE20
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxq8y-0003JT-6J; Wed, 04 Mar 2026 12:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8k-0003Ca-KS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8g-0004sy-5L
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772645759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzDXKMg2pefPTIknL0wUIxM1JWnVeUAX/c1HcIFUrMc=;
 b=dNMQo8/NcfEKAKVJYUfsukw9T9Z/IP2asNb6bVgasqWOgH0TbfVyMx3Wfnt1f2xeQ/x1ws
 DycjqZCRPg+pCV5S1n1Iu8hmp+8wu2pnyy19ETk8NvuaXB47FlSt5B5oEYAStWrLPJyzth
 MYSKiu8JQ3H81IwiwqlyrnzA13YnXio=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-ArCh8zowPi-My8UpH2SOYQ-1; Wed,
 04 Mar 2026 12:35:56 -0500
X-MC-Unique: ArCh8zowPi-My8UpH2SOYQ-1
X-Mimecast-MFC-AGG-ID: ArCh8zowPi-My8UpH2SOYQ_1772645755
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B1B419560A1; Wed,  4 Mar 2026 17:35:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.212])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E3951958DC7; Wed,  4 Mar 2026 17:35:51 +0000 (UTC)
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
Subject: [PATCH 3/7] vhost: factor out the descriptor next fetching
Date: Wed,  4 Mar 2026 18:35:31 +0100
Message-ID: <20260304173535.2702587-4-eperezma@redhat.com>
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

The next field will not be used if IN_ORDER is enabled.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 901253d06e50..7adacd4f542a 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -139,6 +139,20 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
     return true;
 }
 
+/**
+ * Get the next descriptor in the chain in SVQ vring from a descriptor id
+ *
+ * @svq Shadow Virtqueue
+ * @id ID of the descriptor
+ *
+ * Return the id of the next descriptor.
+ */
+static uint16_t vhost_svq_next_desc(const VhostShadowVirtqueue *svq,
+                                    uint16_t id)
+{
+    return svq->desc_state[id].next;
+}
+
 /**
  * Write descriptors to SVQ vring
  *
@@ -173,9 +187,11 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
     }
 
     for (n = 0; n < num; n++) {
+        uint16_t next = vhost_svq_next_desc(svq, i);
+
         if (more_descs || (n + 1 < num)) {
             descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
-            descs[i].next = cpu_to_le16(svq->desc_state[i].next);
+            descs[i].next = cpu_to_le16(next);
         } else {
             descs[i].flags = flags;
         }
@@ -183,10 +199,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
-        i = svq->desc_state[i].next;
+        i = next;
     }
 
-    svq->free_head = svq->desc_state[last].next;
+    svq->free_head = vhost_svq_next_desc(svq, last);
     return true;
 }
 
@@ -432,7 +448,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
     for (uint16_t j = 0; j < (num - 1); ++j) {
-        i = svq->desc_state[i].next;
+        i = vhost_svq_next_desc(svq, i);
     }
 
     return i;
-- 
2.53.0


