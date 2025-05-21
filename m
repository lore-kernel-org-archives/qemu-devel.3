Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A516C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhjL-0003Zf-I6; Wed, 21 May 2025 07:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjJ-0003Yx-BQ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjE-00010y-6e
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgN0+d7s/t88dhPMNH/Un4MUlEI3ZGm8MBQFbfKWW64=;
 b=V9nzN7FR6vPyZBbsYMU0E6tUtTUlqDTBN5ziYnYqeymqQfl39SJRRRpPIvHaWQHmx6tOoo
 s88AMkczO0pqZFkIUTGJMPn8lCD2ozP6VPFGJ0gG9gV4g3X3A5uqoMPbY0qTvyewOwqCs5
 73f5rqJ6v2FXNzMe6XkYRtt5nIcqJYA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-QVFlCDbJNdWzhgfjWEALeA-1; Wed,
 21 May 2025 07:35:16 -0400
X-MC-Unique: QVFlCDbJNdWzhgfjWEALeA-1
X-Mimecast-MFC-AGG-ID: QVFlCDbJNdWzhgfjWEALeA_1747827314
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8365F195608A; Wed, 21 May 2025 11:35:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C066419560B7; Wed, 21 May 2025 11:35:08 +0000 (UTC)
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
Subject: [PATCH RFC 03/16] virtio: introduce extended features type
Date: Wed, 21 May 2025 13:33:57 +0200
Message-ID: <968b3e3d162d161c1aaaa477979c4a11c46c68ea.1747825544.git.pabeni@redhat.com>
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

Introduce a specific type to represent the virtio features bitmask.
On platform where 128 bits integer are available use such wide int
for the features bitmask, otherwise maintain the current u64.

Most drivers will keep using only 64 bits features space; use union
to allow them access the lower part of the extended space without any
per driver change, but let the features field initializers set the
extended space.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/net/virtio-net.c                 |  2 +-
 hw/virtio/virtio-bus.c              |  4 +-
 hw/virtio/virtio.c                  |  4 +-
 include/hw/virtio/virtio-features.h | 90 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h          |  9 +--
 5 files changed, 100 insertions(+), 9 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2de037c273..9f500c64e7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -799,7 +799,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
     }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
-    vdev->backend_features = features;
+    vdev->backend_features_ex = features;
 
     if (n->mtu_bypass_backend &&
             (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 11adfbf3ab..9b84ead831 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -63,8 +63,8 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
 
     /* Get the features of the plugged device. */
     assert(vdc->get_features != NULL);
-    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
-                                            &local_err);
+    vdev->host_features_ex = vdc->get_features(vdev, vdev->host_features,
+                                               &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 480c2e5036..701f59884d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2346,7 +2346,7 @@ void virtio_reset(void *opaque)
     vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
-    vdev->guest_features = 0;
+    vdev->guest_features_ex = 0;
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->disabled = false;
@@ -3239,7 +3239,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
      * Note: devices should always test host features in future - don't create
      * new dependencies like this.
      */
-    vdev->guest_features = features;
+    vdev->guest_features_ex = features;
 
     config_len = qemu_get_be32(f);
 
diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
new file mode 100644
index 0000000000..a0a115cd66
--- /dev/null
+++ b/include/hw/virtio/virtio-features.h
@@ -0,0 +1,90 @@
+/*
+ * Virtio features helpers
+ *
+ * Copyright 2025 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _QEMU_VIRTIO_FEATURES_H
+#define _QEMU_VIRTIO_FEATURES_H
+
+#define VIRTIO_FEATURES_FMT             "%016"PRIx64"%016"PRIx64
+
+#ifdef CONFIG_INT128
+#define VIRTIO_BIT(b)              ((__int128_t)1 << b)
+#define VIRTIO_FEATURES_WORDS      4
+#define VIRTIO_FEATURES_HI(f)      ((uint64_t)((f) >> 64))
+#define VIRTIO_FEATURES_LOW(f)     ((uint64_t)(f))
+
+typedef __uint128_t virtio_features_t;
+
+#if HOST_BIG_ENDIAN
+#define DECLARE_FEATURES(name)      \
+    union {                         \
+        struct {                    \
+            uint64_t name##_hi;     \
+            uint64_t name;          \
+        };                          \
+        __uint128_t  name##_ex;     \
+    }
+#else
+#define DECLARE_FEATURES(name)      \
+    union {                         \
+        struct {                    \
+            uint64_t name;          \
+            uint64_t name##_hi;     \
+        };                          \
+        __uint128_t  name##_ex;     \
+    }
+#endif
+
+static inline void virtio_add_feature_ex(__uint128_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < 128);
+    *features |= VIRTIO_BIT(fbit);
+}
+
+static inline void virtio_clear_feature_ex(__uint128_t *features,
+                                           unsigned int fbit)
+{
+    assert(fbit < 128);
+    *features &= ~VIRTIO_BIT(fbit);
+}
+
+static inline bool virtio_has_feature_ex(__uint128_t features,
+                                         unsigned int fbit)
+{
+    assert(fbit < 128);
+    return !!(features & VIRTIO_BIT(fbit));
+}
+
+#else /* !CONFIG_INT128 */
+
+#define VIRTIO_BIT(b)              (1ULL << b)
+#define VIRTIO_FEATURES_WORDS      2
+#define VIRTIO_FEATURES_HI(f)      0
+#define VIRTIO_FEATURES_LOW(f)     f
+
+typedef uint64_t virtio_features_t;
+
+/*
+ * Without 128 bits support, 'features_ex' is just an alias for the 64 bits
+ * variable. This help avoiding conditionals in the core virtio code
+ * manipulation the features
+ */
+#define DECLARE_FEATURES(name)      \
+    union {                         \
+        uint64_t name;              \
+        uint64_t name##_ex;         \
+    }
+
+#define virtio_clear_feature_ex virtio_clear_feature
+#define virtio_add_feature_ex virtio_add_feature
+#define virtio_has_feature_ex virtio_has_feature
+
+#endif
+
+#endif
+
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7e0c471ea4..82ff6c1630 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -16,6 +16,7 @@
 
 #include "system/memory.h"
 #include "hw/qdev-core.h"
+#include "hw/virtio/virtio-features.h"
 #include "net/net.h"
 #include "migration/vmstate.h"
 #include "qemu/event_notifier.h"
@@ -121,9 +122,9 @@ struct VirtIODevice
      * backend (e.g. vhost) and could potentially be a subset of the
      * total feature set offered by QEMU.
      */
-    uint64_t host_features;
-    uint64_t guest_features;
-    uint64_t backend_features;
+    DECLARE_FEATURES(host_features);
+    DECLARE_FEATURES(guest_features);
+    DECLARE_FEATURES(backend_features);
 
     size_t config_len;
     void *config;
@@ -195,7 +196,7 @@ struct VirtioDeviceClass {
      * that are only exposed on the legacy interface but not
      * the modern one.
      */
-    uint64_t legacy_features;
+    virtio_features_t legacy_features;
     /* Test and clear event pending status.
      * Should be called after unmask to avoid losing events.
      * If backend does not support masking,
-- 
2.49.0


