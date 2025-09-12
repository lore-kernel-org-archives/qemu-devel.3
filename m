Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBB0CAC58F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3Vq-0003Ah-PB; Fri, 12 Sep 2025 09:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux3Vk-00039x-E4
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux3Vg-0007I4-Kh
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757682494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PHOL/kDx1wp78/VsrnCUVT+IcWbIJD/FcuVnjDBUQY=;
 b=irNU1QrNudgCdNcU79Ki4cLFH45cmEvVKF8cD5lPkaYQdNwuEnBUuJL5wWwVJ+Vlng57g/
 1gHbx6QDJZLp2yEwNu3WAgYVh4lFp+IPwmolmp18OPuJdGdDsZA1XkJ9zTmE+ggZxZ6n3i
 4Y3E3Bip4/YWchWIlJdSsi2JNhvuv9g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-7qnyqGzWP3-lrpPnsDvN9A-1; Fri,
 12 Sep 2025 09:08:09 -0400
X-MC-Unique: 7qnyqGzWP3-lrpPnsDvN9A-1
X-Mimecast-MFC-AGG-ID: 7qnyqGzWP3-lrpPnsDvN9A_1757682488
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF19D180045C; Fri, 12 Sep 2025 13:08:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D8B71954126; Fri, 12 Sep 2025 13:08:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v6 09/14] qmp: update virtio features map to support extended
 features
Date: Fri, 12 Sep 2025 15:07:00 +0200
Message-ID: <bef09bed78378da9c32d9913eefb83bd42ba8808.1757676218.git.pabeni@redhat.com>
In-Reply-To: <cover.1757676218.git.pabeni@redhat.com>
References: <cover.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend the VirtioDeviceFeatures struct with an additional u64
to track unknown features in the 64-127 bit range and decode
the full virtio features spaces for vhost and virtio devices.

Also add entries for the soon-to-be-supported virtio net GSO over
UDP features.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - cleanup unknown features init
  - update QMP example and doc accordingly
  - use new virtio_features macro names

v2 -> v3:
  - unknown-dev-features-dword2 -> unknown-dev-features2
  - _array -> _ex
  - fixed typos in entries description

v1 -> v2:
  - uint128_t -> uint64_t[]
---
 hw/virtio/virtio-hmp-cmds.c |  3 +-
 hw/virtio/virtio-qmp.c      | 91 +++++++++++++++++++++++++------------
 hw/virtio/virtio-qmp.h      |  3 +-
 qapi/virtio.json            |  9 +++-
 4 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 7d8677bcf0..1daae482d3 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
     }
 
     if (features->has_unknown_dev_features) {
-        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
+        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
+                       features->unknown_dev_features2,
                        features->unknown_dev_features);
     }
 }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d..502c9ae930 100644
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
+            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
+            "UDP tunnel packets"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
+            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
+            "UDP tunnel packets requiring checksum offload for the outer "
+            "header"),
     { -1, "" }
 };
 #endif
@@ -510,6 +524,24 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
         list;                                            \
     })
 
+#define CONVERT_FEATURES_EX(type, map, bitmap)           \
+    ({                                                   \
+        type *list = NULL;                               \
+        type *node;                                      \
+        for (i = 0; map[i].virtio_bit != -1; i++) {      \
+            bit = map[i].virtio_bit;                     \
+            if (!virtio_has_feature_ex(bitmap, bit)) {   \
+                continue;                                \
+            }                                            \
+            node = g_new0(type, 1);                      \
+            node->value = g_strdup(map[i].feature_desc); \
+            node->next = list;                           \
+            list = node;                                 \
+            virtio_clear_feature_ex(bitmap, bit);        \
+        }                                                \
+        list;                                            \
+    })
+
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap)
 {
     VirtioDeviceStatus *status;
@@ -545,109 +577,112 @@ VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap)
     return vhu_protocols;
 }
 
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
+VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
+                                          const uint64_t *bmap)
 {
+    uint64_t bitmap[VIRTIO_FEATURES_NU64S];
     VirtioDeviceFeatures *features;
     uint64_t bit;
     int i;
 
+    virtio_features_copy(bitmap, bmap);
     features = g_new0(VirtioDeviceFeatures, 1);
     features->has_dev_features = true;
 
     /* transport features */
-    features->transports = CONVERT_FEATURES(strList, virtio_transport_map, 0,
-                                            bitmap);
+    features->transports = CONVERT_FEATURES_EX(strList, virtio_transport_map,
+                                               bitmap);
 
     /* device features */
     switch (device_id) {
 #ifdef CONFIG_VIRTIO_SERIAL
     case VIRTIO_ID_CONSOLE:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_serial_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_serial_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_BLK
     case VIRTIO_ID_BLOCK:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_blk_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_blk_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_GPU
     case VIRTIO_ID_GPU:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_gpu_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_gpu_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_NET
     case VIRTIO_ID_NET:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_net_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_net_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_SCSI
     case VIRTIO_ID_SCSI:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_scsi_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_scsi_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_BALLOON
     case VIRTIO_ID_BALLOON:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_balloon_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_balloon_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_IOMMU
     case VIRTIO_ID_IOMMU:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_iommu_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_iommu_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_INPUT
     case VIRTIO_ID_INPUT:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_input_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_input_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VHOST_USER_FS
     case VIRTIO_ID_FS:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_fs_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_fs_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VHOST_VSOCK
     case VIRTIO_ID_VSOCK:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_vsock_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_vsock_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_CRYPTO
     case VIRTIO_ID_CRYPTO:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_crypto_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_crypto_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_MEM
     case VIRTIO_ID_MEM:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_mem_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_mem_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_I2C_ADAPTER
     case VIRTIO_ID_I2C_ADAPTER:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_i2c_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_i2c_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_RNG
     case VIRTIO_ID_RNG:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_rng_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VHOST_USER_GPIO
     case VIRTIO_ID_GPIO:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_gpio_feature_map, bitmap);
         break;
 #endif
     /* No features */
@@ -680,10 +715,9 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         g_assert_not_reached();
     }
 
-    features->has_unknown_dev_features = bitmap != 0;
-    if (features->has_unknown_dev_features) {
-        features->unknown_dev_features = bitmap;
-    }
+    features->has_unknown_dev_features = !virtio_features_empty(bitmap);
+    features->unknown_dev_features = bitmap[0];
+    features->unknown_dev_features2 = bitmap[1];
 
     return features;
 }
@@ -743,11 +777,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
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
+                                                 vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
@@ -785,11 +819,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
         status->vhost_dev->features =
-            qmp_decode_features(vdev->device_id, hdev->features);
+            qmp_decode_features(vdev->device_id, hdev->features_ex);
         status->vhost_dev->acked_features =
-            qmp_decode_features(vdev->device_id, hdev->acked_features);
+            qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
         status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features);
+            qmp_decode_features(vdev->device_id, hdev->backend_features_ex);
+
         status->vhost_dev->protocol_features =
             qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 245a446a56..e0a1e49035 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -18,6 +18,7 @@
 VirtIODevice *qmp_find_virtio_device(const char *path);
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
 VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
+VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
+                                          const uint64_t *bitmap);
 
 #endif
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9d652fe4a8..05295ab665 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -247,6 +247,7 @@
 #              },
 #              "host-features": {
 #                  "unknown-dev-features": 1073741824,
+#                  "unknown-dev-features2": 0,
 #                  "dev-features": [],
 #                  "transports": [
 #                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
@@ -490,14 +491,18 @@
 #     unique features)
 #
 # @unknown-dev-features: Virtio device features bitmap that have not
-#     been decoded
+#     been decoded (bits 0-63)
+#
+# @unknown-dev-features2: Virtio device features bitmap that have not
+#     been decoded (bits 64-127) (since 10.2)
 #
 # Since: 7.2
 ##
 { 'struct': 'VirtioDeviceFeatures',
   'data': { 'transports': [ 'str' ],
             '*dev-features': [ 'str' ],
-            '*unknown-dev-features': 'uint64' } }
+            '*unknown-dev-features': 'uint64',
+            '*unknown-dev-features2': 'uint64' } }
 
 ##
 # @VirtQueueStatus:
-- 
2.51.0


