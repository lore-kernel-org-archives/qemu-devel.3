Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8C8C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhjz-0003dd-8L; Wed, 21 May 2025 07:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjV-0003bS-Ni
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjP-00012r-OY
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5RrZ8gaODIz2f20pZnxWw3ECS5vPxsdWXWwTpC9Sgo=;
 b=gezD3u/WKK7grMpb0CjXEMm7AxNgWFZ7fK48lepiu7aIQJ7zLrKqL30J2fZZ2fIGXQB92I
 5LA3mdwbCO9dJ7ADIocyYhTR5vGowLWWYMBn9Kjd38hn1aV0jtAeXDABjDsQ1B49//C6fl
 feS9VsEbR93498SlGtE3WHFMbXhBJfg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-XsHL_GJgP4KFnk6LM6jHdw-1; Wed,
 21 May 2025 07:35:23 -0400
X-MC-Unique: XsHL_GJgP4KFnk6LM6jHdw-1
X-Mimecast-MFC-AGG-ID: XsHL_GJgP4KFnk6LM6jHdw_1747827321
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED15C1801A33; Wed, 21 May 2025 11:35:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F32F19560B7; Wed, 21 May 2025 11:35:14 +0000 (UTC)
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
Subject: [PATCH RFC 04/16] virtio: serialize extended features state
Date: Wed, 21 May 2025 13:33:58 +0200
Message-ID: <f5c6c83ac2af8281b4bd5115d1d9107ec132e07f.1747825544.git.pabeni@redhat.com>
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
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If the host supports 128 bit-wide features, and the driver
use any of them, serialize the full features range leveraging
newly introduced 128bits integer helpers.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/virtio/virtio.c | 76 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 701f59884d..ef15a1835e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2982,6 +2982,26 @@ static const VMStateDescription vmstate_virtio_disabled = {
     }
 };
 
+#ifdef CONFIG_INT128
+static bool virtio_128bit_features_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return (vdev->host_features_ex >> 64) != 0;
+}
+
+static const VMStateDescription vmstate_virtio_128bit_features = {
+    .name = "virtio/128bit_features",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_128bit_features_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT128(guest_features_ex, VirtIODevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -2991,6 +3011,9 @@ static const VMStateDescription vmstate_virtio = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_device_endian,
+#ifdef CONFIG_INT128
+        &vmstate_virtio_128bit_features,
+#endif
         &vmstate_virtio_64bit_features,
         &vmstate_virtio_virtqueues,
         &vmstate_virtio_ringsize,
@@ -3087,7 +3110,8 @@ const VMStateInfo  virtio_vmstate_info = {
     .put = virtio_device_put,
 };
 
-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
+static int virtio_set_features_nocheck(VirtIODevice *vdev,
+                                       virtio_features_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     bool bad = (val & ~(vdev->host_features)) != 0;
@@ -3133,6 +3157,42 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
     }
 }
 
+#ifdef CONFIG_INT128
+typedef struct VirtioSetFeaturesExNocheckData {
+    Coroutine *co;
+    VirtIODevice *vdev;
+    __uint128_t val;
+    int ret;
+} VirtioSetFeaturesExNocheckData;
+
+static void virtio_set_features_ex_nocheck_bh(void *opaque)
+{
+    VirtioSetFeaturesExNocheckData *data = opaque;
+
+    data->ret = virtio_set_features_nocheck(data->vdev, data->val);
+    aio_co_wake(data->co);
+}
+
+static int coroutine_mixed_fn
+virtio_set_features_ex_nocheck_maybe_co(VirtIODevice *vdev, __uint128_t val)
+{
+    if (qemu_in_coroutine()) {
+        VirtioSetFeaturesExNocheckData data = {
+            .co = qemu_coroutine_self(),
+            .vdev = vdev,
+            .val = val,
+        };
+        aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
+                                virtio_set_features_ex_nocheck_bh, &data);
+        qemu_coroutine_yield();
+        return data.ret;
+    } else {
+        return virtio_set_features_nocheck(vdev, val);
+    }
+}
+
+#endif
+
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
     int ret;
@@ -3318,6 +3378,20 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->device_endian = virtio_default_endian();
     }
 
+#ifdef CONFIG_INT128
+    if (virtio_128bit_features_needed(vdev)) {
+        __int128_t features128 = vdev->guest_features_ex;
+        if (virtio_set_features_ex_nocheck_maybe_co(vdev, features128) < 0) {
+            error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
+                         "Allowed features: 0x" VIRTIO_FEATURES_FMT,
+                         VIRTIO_FEATURES_HI(features128),
+                         VIRTIO_FEATURES_LOW(features128),
+                         VIRTIO_FEATURES_HI(vdev->host_features_ex),
+                         VIRTIO_FEATURES_LOW(vdev->host_features_ex));
+            return -1;
+        }
+    } else
+#endif
     if (virtio_64bit_features_needed(vdev)) {
         /*
          * Subsection load filled vdev->guest_features.  Run them
-- 
2.49.0


