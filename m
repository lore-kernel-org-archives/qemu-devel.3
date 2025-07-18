Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D97CC83F3B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgqx-0001m6-5M; Fri, 18 Jul 2025 04:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqg-0001YK-5h
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqe-0001CB-9h
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752828823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vG49PnliW3cNEtWWNfrKYkcxJt02WcjRiHMrTnlNddI=;
 b=SQr6mYDWJRTMi/FtNDIQKpTup04fx3sEMFueZ8uOMGB9AzROjqibgYC9gs3i9JJ4bNKpjq
 EYLrtvEOsW2/p002dJ2nSWKnZ7wml7Ktzq9LvEiKwbFcOBfuUO0bfcqPzinSYemmFpqY7B
 nWFaG73sTgTaoslUulX+ELBHgo0k1VA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-AFjn3_75OOWXEwqjFt-cQQ-1; Fri,
 18 Jul 2025 04:53:39 -0400
X-MC-Unique: AFjn3_75OOWXEwqjFt-cQQ-1
X-Mimecast-MFC-AGG-ID: AFjn3_75OOWXEwqjFt-cQQ_1752828818
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D1AC195608B; Fri, 18 Jul 2025 08:53:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8D5B1956089; Fri, 18 Jul 2025 08:53:33 +0000 (UTC)
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
Subject: [PATCH RFC v3 05/13] virtio: add support for negotiating extended
 features
Date: Fri, 18 Jul 2025 10:52:31 +0200
Message-ID: <ed1633d2bba97db8027c836428c23615b9349e0e.1752828082.git.pabeni@redhat.com>
In-Reply-To: <cover.1752828082.git.pabeni@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
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

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features for the virtio net driver.

Add support to allow extended features negotiation on a per
devices basis. Devices willing to negotiated extended features
need to implemented a new pair of features getter/setter, the
core will conditionally use them instead of the basic one.

Note that 'bad_features' don't need to be extended, as they are
bound to the 64 bits limit.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - _array -> _ex

v1 -> v2:
  - uint128_t -> uint64_t[]
---
 hw/virtio/virtio-bus.c     | 11 ++++++++---
 hw/virtio/virtio.c         | 18 +++++++++++++-----
 include/hw/virtio/virtio.h |  4 ++++
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 11adfbf3ab..cef944e015 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -62,9 +62,14 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     }
 
     /* Get the features of the plugged device. */
-    assert(vdc->get_features != NULL);
-    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
-                                            &local_err);
+    if (vdc->get_features_ex) {
+        vdc->get_features_ex(vdev, vdev->host_features_ex, &local_err);
+    } else {
+        assert(vdc->get_features != NULL);
+        virtio_features_from_u64(vdev->host_features_ex,
+                                 vdc->get_features(vdev, vdev->host_features,
+                                                   &local_err));
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2817d3a893..5b60617d33 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3087,7 +3087,9 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
     bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
     virtio_features_and(tmp, val, vdev->host_features_ex);
 
-    if (k->set_features) {
+    if (k->set_features_ex) {
+        k->set_features_ex(vdev, val);
+    } else if (k->set_features) {
         bad = bad || virtio_features_use_extended(tmp);
         k->set_features(vdev, tmp[0]);
     }
@@ -3130,9 +3132,8 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
     }
 }
 
-int virtio_set_features(VirtIODevice *vdev, uint64_t val)
+int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
 {
-    uint64_t features[VIRTIO_FEATURES_DWORDS];
     int ret;
     /*
      * The driver must not attempt to set features after feature negotiation
@@ -3142,13 +3143,12 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
         return -EINVAL;
     }
 
-    if (val & (1ull << VIRTIO_F_BAD_FEATURE)) {
+    if (features[0] & (1ull << VIRTIO_F_BAD_FEATURE)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: guest driver for %s has enabled UNUSED(30) feature bit!\n",
                       __func__, vdev->name);
     }
 
-    virtio_features_from_u64(features, val);
     ret = virtio_set_features_nocheck(vdev, features);
     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
@@ -3168,6 +3168,14 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return ret;
 }
 
+int virtio_set_features(VirtIODevice *vdev, uint64_t val)
+{
+    uint64_t features[VIRTIO_FEATURES_DWORDS];
+
+    virtio_features_from_u64(features, val);
+    return virtio_set_features_ex(vdev, features);
+}
+
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 39e4059a66..2aeb021fb3 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -178,6 +178,9 @@ struct VirtioDeviceClass {
     /* This is what a VirtioDevice must implement */
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+    void (*get_features_ex)(VirtIODevice *vdev, uint64_t *requested_features,
+                            Error **errp);
+    void (*set_features_ex)(VirtIODevice *vdev, const uint64_t *val);
     uint64_t (*get_features)(VirtIODevice *vdev,
                              uint64_t requested_features,
                              Error **errp);
@@ -373,6 +376,7 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
 int virtio_set_features(VirtIODevice *vdev, uint64_t val);
+int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *val);
 
 /* Base devices.  */
 typedef struct VirtIOBlkConf VirtIOBlkConf;
-- 
2.50.0


