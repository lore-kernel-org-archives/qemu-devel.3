Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA74EF9011
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpTB-00021N-33; Wed, 04 Mar 2026 11:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxpT8-0001wz-UV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:53:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxpT7-0002fo-EV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772643184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfV0gEUJC+rSPvPi445xgxocRWiYcV/AAmpU7HARrQc=;
 b=L4S52V4DCQ+Y+qcBQ+nyWFnzeDWKFJ0kEHoWqn+Bl81HLaOE9EhWvGV1WkghyleAk4AmSL
 sAQhk8iGsC83CkI1jchnjS+bfWdTMT4GELKcnWTnNxaDc4agiqFsxHO/z/J5VfxfXEf1SG
 dhobK7i+0SevKK9plX0PGusicNNQ3Qk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-DGSIqf_hMvWVGhD-nYTXIw-1; Wed,
 04 Mar 2026 11:53:01 -0500
X-MC-Unique: DGSIqf_hMvWVGhD-nYTXIw-1
X-Mimecast-MFC-AGG-ID: DGSIqf_hMvWVGhD-nYTXIw_1772643180
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B32DC195605B; Wed,  4 Mar 2026 16:52:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10DBD180035F; Wed,  4 Mar 2026 16:52:53 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 manos.pitsidianakis@linaro.org, slp@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com, stevensd@chromium.org,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com,
 Peter Xu <peterx@redhat.com>, hi@alyssa.is,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, dbassey@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v14 4/7] vhost_user: Add frontend get_shmem_config command
Date: Wed,  4 Mar 2026 17:52:20 +0100
Message-ID: <20260304165223.2166175-5-aesteve@redhat.com>
In-Reply-To: <20260304165223.2166175-1-aesteve@redhat.com>
References: <20260304165223.2166175-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The frontend can use this command to retrieve
VirtIO Shared Memory Regions configuration from
the backend. The response contains the number of
shared memory regions, their size, and shmid.

This is useful when the frontend is unaware of
specific backend type and configuration,
for example, in the `vhost-user-device` case.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 10 ++++++++++
 include/hw/virtio/vhost-user.h    |  1 +
 include/hw/virtio/virtio.h        |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index ff94fa1734..ce58b4d2d6 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -163,6 +163,15 @@ typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
                                             int *reply_fd,
                                             Error **errp);
 typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
+/*
+ * Max regions is VIRTIO_MAX_SHMEM_REGIONS, so that is the maximum
+ * number of memory_sizes that will be accepted.
+ */
+typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
+                                         int *nregions,
+                                         uint64_t *memory_sizes,
+                                         Error **errp);
+
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -220,6 +229,7 @@ typedef struct VhostOps {
     vhost_supports_device_state_op vhost_supports_device_state;
     vhost_set_device_state_fd_op vhost_set_device_state_fd;
     vhost_check_device_state_op vhost_check_device_state;
+    vhost_get_shmem_config_op vhost_get_shmem_config;
 } VhostOps;
 
 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 53fe996686..0d8c7f1006 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -33,6 +33,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
     VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
+    VHOST_USER_PROTOCOL_F_SHMEM = 21,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 2dcf58639d..3d1b1b5e6d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -82,6 +82,8 @@ typedef struct VirtQueueElement
 
 #define VIRTIO_NO_VECTOR 0xffff
 
+#define VIRTIO_MAX_SHMEM_REGIONS 256
+
 /* special index value used internally for config irqs */
 #define VIRTIO_CONFIG_IRQ_IDX -1
 
-- 
2.52.0


