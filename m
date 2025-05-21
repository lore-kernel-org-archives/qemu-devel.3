Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D6C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhjz-0003dl-9R; Wed, 21 May 2025 07:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhja-0003cS-KI
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjY-00014a-Ii
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHYTDzDbqLXiCzMSclhXqCm2qiuVW6gwIJGPukVe9dI=;
 b=WB93NNGSNOOtEqpMqj3DNY3Ub5nUDX+i2aEvI8XuP26rlyCDbCSeHTj+DrrJ2t1NC/BCbt
 YO9zk2gCcQhp7IKGNby2FqG1wOBZZk5Lw8FKqYeTFaYatStucDlj14pJhiUjOJJc842YgP
 QNvwv40EBkmrNASyiNRFg7oNxZoEwwA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-0_GP6oTzOXycXwyVgNjgBQ-1; Wed,
 21 May 2025 07:35:35 -0400
X-MC-Unique: 0_GP6oTzOXycXwyVgNjgBQ-1
X-Mimecast-MFC-AGG-ID: 0_GP6oTzOXycXwyVgNjgBQ_1747827334
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFC5F195608B; Wed, 21 May 2025 11:35:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD0C619560B7; Wed, 21 May 2025 11:35:27 +0000 (UTC)
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
Subject: [PATCH RFC 06/16] virtio: add support for negotiating extended
 features.
Date: Wed, 21 May 2025 13:34:00 +0200
Message-ID: <7e11b2708f54fb30fea1801eff979d6a3230acf5.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
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

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (above 64) for the virtio net driver.

Add support to allow extended features negotiation on a per
devices basis. Devices willing to negotiated extended features
need to implemented a new pair of features getter/setter, the
core will conditionally use them instead of the basic one.

Note that 'bad_features' don't need to be extended, as they are
bound to the 64 bits limit.

No functional changes intended for host without 128 bit support.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/virtio/virtio-bus.c     | 15 ++++++++++++---
 hw/virtio/virtio.c         | 23 +++++++++++++++++------
 include/hw/virtio/virtio.h |  8 +++++++-
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 9b84ead831..40948fca39 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -62,9 +62,18 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     }
 
     /* Get the features of the plugged device. */
-    assert(vdc->get_features != NULL);
-    vdev->host_features_ex = vdc->get_features(vdev, vdev->host_features,
-                                               &local_err);
+#ifdef CONFIG_INT128
+    if (vdc->get_features_ex)
+        vdev->host_features_ex = vdc->get_features_ex(vdev,
+                                                      vdev->host_features_ex,
+                                                      &local_err);
+    else
+#endif
+    {
+        assert(vdc->get_features != NULL);
+        vdev->host_features_ex = vdc->get_features(vdev, vdev->host_features,
+                                                   &local_err);
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ef15a1835e..90822e54f8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3114,13 +3114,24 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev,
                                        virtio_features_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    bool bad = (val & ~(vdev->host_features)) != 0;
+    bool bad = (val & ~(vdev->host_features_ex)) != 0;
 
-    val &= vdev->host_features;
-    if (k->set_features) {
-        k->set_features(vdev, val);
+    val &= vdev->host_features_ex;
+#ifdef CONFIG_INT128
+    if (!k->set_features_ex) {
+        val = (uint64_t)val;
+    }
+
+    if (k->set_features_ex) {
+        k->set_features_ex(vdev, val);
+    } else
+#endif
+    {
+        if (k->set_features) {
+            k->set_features(vdev, val);
+        }
     }
-    vdev->guest_features = val;
+    vdev->guest_features_ex = val;
     return bad ? -1 : 0;
 }
 
@@ -3193,7 +3204,7 @@ virtio_set_features_ex_nocheck_maybe_co(VirtIODevice *vdev, __uint128_t val)
 
 #endif
 
-int virtio_set_features(VirtIODevice *vdev, uint64_t val)
+int virtio_set_features(VirtIODevice *vdev, virtio_features_t val)
 {
     int ret;
     /*
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 82ff6c1630..e98fd76e7f 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -178,6 +178,12 @@ struct VirtioDeviceClass {
     /* This is what a VirtioDevice must implement */
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+#ifdef CONFIG_INT128
+    virtio_features_t (*get_features_ex)(VirtIODevice *vdev,
+                                         virtio_features_t requested_features,
+                                         Error **errp);
+    void (*set_features_ex)(VirtIODevice *vdev, virtio_features_t val);
+#endif
     uint64_t (*get_features)(VirtIODevice *vdev,
                              uint64_t requested_features,
                              Error **errp);
@@ -366,7 +372,7 @@ void virtio_reset(void *opaque);
 void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
-int virtio_set_features(VirtIODevice *vdev, uint64_t val);
+int virtio_set_features(VirtIODevice *vdev, virtio_features_t val);
 
 /* Base devices.  */
 typedef struct VirtIOBlkConf VirtIOBlkConf;
-- 
2.49.0


