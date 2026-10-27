Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A73606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTxYe7Cx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0Oi-000570-T1; Wed, 28 Oct 2026 05:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1xM0Og-00056n-JQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1xM0Oe-0001oL-Hb
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793181399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HcrCWjOKmoCzFWTBS3JEEtit8pLa0tX6DsyD4nRyUYg=;
 b=YTxYe7Cxw9d1uMxpt+D7LXPDwICedhwinAxTuCh23c25RRqfB8NZwk5JH4QcVRkgUbBoaB
 lzzbYu3Jh3L/MD7vHqL1x/otv36O3dp2h8CBHrLgVf0NnTQ3aTfJY3zIDOn0zGVSKTKACy
 xzvjH5/Rz6xcongQan0wV8QqcmiANME=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-DcsiVid0MpuVjuJkPRs0YQ-1; Wed,
 28 Oct 2026 05:55:33 -0400
X-MC-Unique: DcsiVid0MpuVjuJkPRs0YQ-1
X-Mimecast-MFC-AGG-ID: DcsiVid0MpuVjuJkPRs0YQ_1793181332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 575C31954190
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:55:32 +0000 (UTC)
Received: from f44vm (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DC171800347; Wed, 28 Oct 2026 09:55:30 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: [RFC PATCH] vsock: optionally enable F_DGRAM support
Date: Tue, 27 Oct 2026 20:28:28 +0100
Message-ID: <20261027192828.42642-1-slp@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the "dgram" property to optionally expose the VIRTIO_VSOCK_F_DGRAM
feature to the guest.

Sent as an RFC until the feature is formalized in the specs and merged
into the Linux kernel (same reason why the headers have been manually
updated).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/virtio/vhost-vsock-common.c                | 15 +++++++++++++++
 hw/virtio/virtio-qmp.c                        |  2 ++
 include/hw/virtio/vhost-vsock-common.h        |  1 +
 include/standard-headers/linux/virtio_vsock.h |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 4ef037627b..1230f9855a 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -21,6 +21,7 @@
 
 const int feature_bits[] = {
     VIRTIO_VSOCK_F_SEQPACKET,
+    VIRTIO_VSOCK_F_DGRAM,
     VIRTIO_F_RING_RESET,
     VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
@@ -35,11 +36,23 @@ uint64_t vhost_vsock_common_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_add_feature(&features, VIRTIO_VSOCK_F_SEQPACKET);
     }
 
+    if (vvc->dgram != ON_OFF_AUTO_OFF) {
+        virtio_add_feature(&features, VIRTIO_VSOCK_F_DGRAM);
+    } else {
+        virtio_clear_feature(&features, VIRTIO_VSOCK_F_DGRAM);
+    }
+
     features = vhost_get_features(&vvc->vhost_dev, feature_bits, features);
 
     if (vvc->seqpacket == ON_OFF_AUTO_ON &&
         !virtio_has_feature(features, VIRTIO_VSOCK_F_SEQPACKET)) {
         error_setg(errp, "vhost-vsock backend doesn't support seqpacket");
+        return features;
+    }
+
+    if (vvc->dgram == ON_OFF_AUTO_ON &&
+        !virtio_has_feature(features, VIRTIO_VSOCK_F_DGRAM)) {
+        error_setg(errp, "vhost-vsock backend doesn't support datagrams");
     }
 
     return features;
@@ -289,6 +302,8 @@ static struct vhost_dev *vhost_vsock_common_get_vhost(VirtIODevice *vdev)
 static const Property vhost_vsock_common_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("seqpacket", VHostVSockCommon, seqpacket,
                             ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("dgram", VHostVSockCommon, dgram,
+                            ON_OFF_AUTO_OFF),
 };
 
 static void vhost_vsock_common_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 5aaeebdd96..4386fd25f8 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -375,6 +375,8 @@ static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
 static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_VSOCK_F_SEQPACKET, \
             "VIRTIO_VSOCK_F_SEQPACKET: SOCK_SEQPACKET supported"),
+    FEATURE_ENTRY(VIRTIO_VSOCK_F_DGRAM, \
+            "VIRTIO_VSOCK_F_DGRAM: SOCK_DGRAM supported"),
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
diff --git a/include/hw/virtio/vhost-vsock-common.h b/include/hw/virtio/vhost-vsock-common.h
index 01bf6062af..8235ac6406 100644
--- a/include/hw/virtio/vhost-vsock-common.h
+++ b/include/hw/virtio/vhost-vsock-common.h
@@ -39,6 +39,7 @@ struct VHostVSockCommon {
 
     /* features */
     OnOffAuto seqpacket;
+    OnOffAuto dgram;
 };
 
 int vhost_vsock_common_start(VirtIODevice *vdev);
diff --git a/include/standard-headers/linux/virtio_vsock.h b/include/standard-headers/linux/virtio_vsock.h
index 467e751b17..7b0419f158 100644
--- a/include/standard-headers/linux/virtio_vsock.h
+++ b/include/standard-headers/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
 
 struct virtio_vsock_config {
 	uint64_t guest_cid;
@@ -69,6 +70,7 @@ struct virtio_vsock_hdr {
 enum virtio_vsock_type {
 	VIRTIO_VSOCK_TYPE_STREAM = 1,
 	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
+	VIRTIO_VSOCK_TYPE_DGRAM = 3,
 };
 
 enum virtio_vsock_op {
-- 
2.55.0


