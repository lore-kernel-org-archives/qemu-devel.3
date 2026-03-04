Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CDBEFCE20
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxq90-0003MU-Fa; Wed, 04 Mar 2026 12:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8n-0003De-P0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8l-0004uk-Ho
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772645766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CH5QCvElWuMKlv3q8MrRwa9vvlKsZCp58YnKNPAF+ZU=;
 b=JQ14q7HPvBIpwqcCC5B9rufPvQXLUcXhxs18Mn2nqnk2L4OLT2T80uiYfo5XFZFIJv0F62
 hlBQdbZsSVB2rV78t3Cblkx8iUdh/Sw8d4F7+jUVDLkwvi1FENKW/5Nc5kF3IJjI28F/rN
 QzVQDwRtmKWYHLWaE/lP2PMNnK1URRE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553--pSsULqLMf2bfkhrxF4vdg-1; Wed,
 04 Mar 2026 12:36:05 -0500
X-MC-Unique: -pSsULqLMf2bfkhrxF4vdg-1
X-Mimecast-MFC-AGG-ID: -pSsULqLMf2bfkhrxF4vdg_1772645764
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BACD18005B4; Wed,  4 Mar 2026 17:36:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.212])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C70D1958DC5; Wed,  4 Mar 2026 17:36:00 +0000 (UTC)
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
Subject: [PATCH 5/7] vhost: factor out the detach buf logic in SVQ
Date: Wed,  4 Mar 2026 18:35:33 +0100
Message-ID: <20260304173535.2702587-6-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-1-eperezma@redhat.com>
References: <20260304173535.2702587-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index e7e3c9155cd0..2d8fc82cc06f 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -473,11 +473,24 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
     return i;
 }
 
+G_GNUC_WARN_UNUSED_RESULT
+static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
+                                              uint16_t id)
+{
+    uint16_t num = svq->desc_state[id].ndescs;
+    uint16_t last_used_chain = vhost_svq_last_desc_of_chain(svq, num, id);
+
+    svq->desc_state[last_used_chain].next = svq->free_head;
+    svq->free_head = id;
+
+    return g_steal_pointer(&svq->desc_state[id].elem);
+}
+
 G_GNUC_WARN_UNUSED_RESULT
 static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                            uint32_t *len)
 {
-    uint16_t last_used, last_used_chain, num;
+    uint16_t last_used;
 
     if (!vhost_svq_more_used(svq)) {
         return NULL;
@@ -500,14 +513,9 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
         return NULL;
     }
 
-    num = svq->desc_state[last_used].ndescs;
+    svq->num_free += svq->desc_state[last_used].ndescs;
     svq->desc_state[last_used].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, last_used);
-    svq->desc_state[last_used_chain].next = svq->free_head;
-    svq->free_head = last_used;
-    svq->num_free += num;
-
-    return g_steal_pointer(&svq->desc_state[last_used].elem);
+    return vhost_svq_detach_buf(svq, last_used);
 }
 
 /**
-- 
2.53.0


