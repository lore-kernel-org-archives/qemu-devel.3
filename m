Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F85C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhk8-0003nr-BZ; Wed, 21 May 2025 07:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjY-0003bh-KU
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjT-00013g-T5
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtpd/F9Kg9OS+alvH0U2zFB3IMxT0Cnkw+gwojoXVYY=;
 b=gV0Sl3lPQw3olaSyLdiTMW5L6YLDNsH16bXu8lJdiKYfDn6a6m0c81ZTKYsADbrlFReAZz
 vgum1+qeKy/Z8+mHyCRaRlIubIrz1KlAt4/NgGxIJ74TFSe2PIGo85ux+S0C3z6ERdllf5
 HHDqGDdfEieILqqQvphz2v4rLU69fE4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-HhyDetnbO-Wu0VxO9kAv1A-1; Wed,
 21 May 2025 07:35:29 -0400
X-MC-Unique: HhyDetnbO-Wu0VxO9kAv1A-1
X-Mimecast-MFC-AGG-ID: HhyDetnbO-Wu0VxO9kAv1A_1747827327
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19561180035C; Wed, 21 May 2025 11:35:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8228C19560B7; Wed, 21 May 2025 11:35:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC 05/16] qmp: update virtio features map to support extended
 features
Date: Wed, 21 May 2025 13:33:59 +0200
Message-ID: <666ad0179dd74bc263b13ef4050c72cbc23b4a81.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/virtio/virtio-hmp-cmds.c |  3 ++-
 hw/virtio/virtio-qmp.c      | 28 ++++++++++++++++++++++------
 hw/virtio/virtio-qmp.h      |  3 ++-
 qapi/virtio.json            |  8 ++++++--
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 7d8677bcf0..04c7fae1c8 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
     }
 
     if (features->has_unknown_dev_features) {
-        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
+        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
+                       features->unknown_dev_features_hi,
                        features->unknown_dev_features);
     }
 }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d..d172a6e9f9 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
             "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
             "negotiation supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
+            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
+            "UDP tunnel packets"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
+            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
+            "UDP tunnel packets requiring checksum offload for the outer "
+            "header"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
+            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Device can receive GSO over "
+            "UDP tunnel packets"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
+            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Device can receive GSO over "
+            "UDP tunnel packets requiring checksum offload for the outer "
+            "header"),
     { -1, "" }
 };
 #endif
@@ -496,7 +510,7 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
                 bit = map[i].virtio_bit;                 \
             }                                            \
             else {                                       \
-                bit = 1ULL << map[i].virtio_bit;         \
+                bit = VIRTIO_BIT(map[i].virtio_bit);     \
             }                                            \
             if ((bitmap & bit) == 0) {                   \
                 continue;                                \
@@ -545,10 +559,11 @@ VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap)
     return vhu_protocols;
 }
 
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
+VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
+                                          virtio_features_t bitmap)
 {
     VirtioDeviceFeatures *features;
-    uint64_t bit;
+    virtio_features_t bit;
     int i;
 
     features = g_new0(VirtioDeviceFeatures, 1);
@@ -683,6 +698,7 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
     features->has_unknown_dev_features = bitmap != 0;
     if (features->has_unknown_dev_features) {
         features->unknown_dev_features = bitmap;
+        features->unknown_dev_features_hi = bitmap >> 64;
     }
 
     return features;
@@ -743,11 +759,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     status->device_id = vdev->device_id;
     status->vhost_started = vdev->vhost_started;
     status->guest_features = qmp_decode_features(vdev->device_id,
-                                                 vdev->guest_features);
+                                                 vdev->guest_features_ex);
     status->host_features = qmp_decode_features(vdev->device_id,
-                                                vdev->host_features);
+                                                vdev->host_features_ex);
     status->backend_features = qmp_decode_features(vdev->device_id,
-                                                   vdev->backend_features);
+                                                   vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 245a446a56..b64899f04a 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -18,6 +18,7 @@
 VirtIODevice *qmp_find_virtio_device(const char *path);
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
 VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
+VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
+                                          virtio_features_t bitmap);
 
 #endif
diff --git a/qapi/virtio.json b/qapi/virtio.json
index d351d2166e..2fde8ed753 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -488,14 +488,18 @@
 #     unique features)
 #
 # @unknown-dev-features: Virtio device features bitmap that have not
-#     been decoded
+#     been decoded (lower 64 bit)
+#
+# @unknown-dev-features-hi: Virtio device features bitmap that have not
+#     been decoded (high 64 bit)
 #
 # Since: 7.2
 ##
 { 'struct': 'VirtioDeviceFeatures',
   'data': { 'transports': [ 'str' ],
             '*dev-features': [ 'str' ],
-            '*unknown-dev-features': 'uint64' } }
+            '*unknown-dev-features': 'uint64',
+            '*unknown-dev-features-hi': 'uint64' } }
 
 ##
 # @VirtQueueStatus:
-- 
2.49.0


