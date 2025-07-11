Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B35C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDR9-0001eG-4H; Fri, 11 Jul 2025 09:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uaDPI-0000Pp-5p
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uaDPG-0003hE-6H
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752238992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yv/e9TfGTNAXq5vppeKFNtoeq3WG3Gxymxnt/da3xBQ=;
 b=R0WxqLQCtKqjRVdKrUlFyK5Tf7t2PPKgMcqau7MsxdQLCEE9Cki48u6zM1YmUkI/Vj9Aev
 dr8NfzIxjbOmnFB58LoeY8JsDC24Yn8QN7yG6tl0sZrZL//6ehH3656SrpM2viNsvA1TW5
 OX7iGxRBUn5MZ2V35GZp4hdiy0TV6FI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-M_7Cpp-BMBORHNtw_xWI-w-1; Fri,
 11 Jul 2025 09:03:09 -0400
X-MC-Unique: M_7Cpp-BMBORHNtw_xWI-w-1
X-Mimecast-MFC-AGG-ID: M_7Cpp-BMBORHNtw_xWI-w_1752238988
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2B82195609F; Fri, 11 Jul 2025 13:03:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDD5619560A3; Fri, 11 Jul 2025 13:03:01 +0000 (UTC)
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
 Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH RFC v2 04/13] virtio: serialize extended features state
Date: Fri, 11 Jul 2025 15:02:09 +0200
Message-ID: <d0f97a8157c718dcb0799353394e1469153c6b22.1752229731.git.pabeni@redhat.com>
In-Reply-To: <cover.1752229731.git.pabeni@redhat.com>
References: <cover.1752229731.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

If the driver uses any of the extended features (i.e. above 64),
serialize the full features range (128 bits).

This is one of the few spots that need explicitly to know and set
in stone the extended features array size; add a build bug to prevent
breaking the migration should such size change again in the future:
more serialization plumbing will be needed.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - uint128_t -> u64[2]
---
 hw/virtio/virtio.c | 97 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 82a285a31d..6a313313dd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2954,6 +2954,24 @@ static const VMStateDescription vmstate_virtio_disabled = {
     }
 };
 
+static bool virtio_128bit_features_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return virtio_features_use_extended(vdev->host_features_array);
+}
+
+static const VMStateDescription vmstate_virtio_128bit_features = {
+    .name = "virtio/128bit_features",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_128bit_features_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(guest_features_array, VirtIODevice, 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -2963,6 +2981,7 @@ static const VMStateDescription vmstate_virtio = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_device_endian,
+        &vmstate_virtio_128bit_features,
         &vmstate_virtio_64bit_features,
         &vmstate_virtio_virtqueues,
         &vmstate_virtio_ringsize,
@@ -3059,23 +3078,30 @@ const VMStateInfo  virtio_vmstate_info = {
     .put = virtio_device_put,
 };
 
-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
+static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    bool bad = (val & ~(vdev->host_features)) != 0;
+    uint64_t tmp[VIRTIO_FEATURES_DWORDS];
+    bool bad;
+
+    virtio_features_andnot(tmp, val, vdev->host_features_array);
+    bad = !virtio_features_is_empty(tmp);
+
+    virtio_features_and(tmp, val, vdev->host_features_array);
 
-    val &= vdev->host_features;
     if (k->set_features) {
-        k->set_features(vdev, val);
+        bad = bad || virtio_features_use_extended(tmp);
+        k->set_features(vdev, tmp[0]);
     }
-    vdev->guest_features = val;
+
+    virtio_features_copy(vdev->guest_features_array, tmp);
     return bad ? -1 : 0;
 }
 
 typedef struct VirtioSetFeaturesNocheckData {
     Coroutine *co;
     VirtIODevice *vdev;
-    uint64_t val;
+    uint64_t val[VIRTIO_FEATURES_DWORDS];
     int ret;
 } VirtioSetFeaturesNocheckData;
 
@@ -3094,12 +3120,41 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
         VirtioSetFeaturesNocheckData data = {
             .co = qemu_coroutine_self(),
             .vdev = vdev,
-            .val = val,
         };
+        virtio_features_from_u64(data.val, val);
         aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
                                 virtio_set_features_nocheck_bh, &data);
         qemu_coroutine_yield();
         return data.ret;
+    } else {
+        uint64_t features[VIRTIO_FEATURES_DWORDS];
+        virtio_features_from_u64(features, val);
+        return virtio_set_features_nocheck(vdev, features);
+    }
+}
+
+static void virtio_set_128bit_features_nocheck_bh(void *opaque)
+{
+    VirtioSetFeaturesNocheckData *data = opaque;
+
+    data->ret = virtio_set_features_nocheck(data->vdev, data->val);
+    aio_co_wake(data->co);
+}
+
+static int coroutine_mixed_fn
+virtio_set_128bit_features_nocheck_maybe_co(VirtIODevice *vdev,
+                                            const uint64_t *val)
+{
+    if (qemu_in_coroutine()) {
+        VirtioSetFeaturesNocheckData data = {
+            .co = qemu_coroutine_self(),
+            .vdev = vdev,
+        };
+        virtio_features_copy(data.val, val);
+        aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
+                                virtio_set_128bit_features_nocheck_bh, &data);
+        qemu_coroutine_yield();
+        return data.ret;
     } else {
         return virtio_set_features_nocheck(vdev, val);
     }
@@ -3107,6 +3162,7 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
 
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
+    uint64_t features[VIRTIO_FEATURES_DWORDS];
     int ret;
     /*
      * The driver must not attempt to set features after feature negotiation
@@ -3122,7 +3178,8 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
                       __func__, vdev->name);
     }
 
-    ret = virtio_set_features_nocheck(vdev, val);
+    virtio_features_from_u64(features, val);
+    ret = virtio_set_features_nocheck(vdev, features);
     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
         int i;
@@ -3145,6 +3202,7 @@ void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint64_t features[VIRTIO_FEATURES_DWORDS];
     int i;
 
     virtio_set_status(vdev, 0);
@@ -3171,7 +3229,8 @@ void virtio_reset(void *opaque)
     vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
-    virtio_set_features_nocheck(vdev, 0);
+    virtio_features_clear(features);
+    virtio_set_features_nocheck(vdev, features);
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->disabled = false;
@@ -3254,7 +3313,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
      * Note: devices should always test host features in future - don't create
      * new dependencies like this.
      */
-    vdev->guest_features = features;
+    virtio_features_from_u64(vdev->guest_features_array, features);
 
     config_len = qemu_get_be32(f);
 
@@ -3333,7 +3392,23 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (virtio_64bit_features_needed(vdev)) {
+    /*
+     * Serialization needs constant size features array. Avoid
+     * silently breaking migration should the feature space increase
+     * even more in the (far away) future
+     */
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);
+    if (virtio_128bit_features_needed(vdev)) {
+        uint64_t *val = vdev->guest_features_array;
+
+        if (virtio_set_128bit_features_nocheck_maybe_co(vdev, val) < 0) {
+            error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
+                         "Allowed features: 0x" VIRTIO_FEATURES_FMT,
+                         VIRTIO_FEATURES_PR(val),
+                         VIRTIO_FEATURES_PR(vdev->host_features_array));
+            return -1;
+        }
+    } else if (virtio_64bit_features_needed(vdev)) {
         /*
          * Subsection load filled vdev->guest_features.  Run them
          * through virtio_set_features to sanity-check them against
-- 
2.50.0


