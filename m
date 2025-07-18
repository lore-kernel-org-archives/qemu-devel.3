Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CF9C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgqZ-0001Gi-KY; Fri, 18 Jul 2025 04:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqW-0001CG-PN
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqU-00018p-UQ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752828814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3TQfhpyStXbt0pfAiVguwtvMOM41Sx4QrHJWtkUaKM=;
 b=SyjricbQnkrqGrmdxc6b/UyRDybNky1FZAvXD61reezu0j+Ojhy4t6/Vzkp0sAY5k+kYJ7
 vSzh6MDvfy2+wyy5x6wNOEKcvB6MNcZCSf6l2eSy4BXyLCsEXvqs9uExM4p1aBHEfCAEcu
 ZKfONd1J7wUd7nWeVn1IDDfilJQOAlQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-SdNu9AuyPyKxe6cM2wQOkw-1; Fri,
 18 Jul 2025 04:53:30 -0400
X-MC-Unique: SdNu9AuyPyKxe6cM2wQOkw-1
X-Mimecast-MFC-AGG-ID: SdNu9AuyPyKxe6cM2wQOkw_1752828808
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F503180028C; Fri, 18 Jul 2025 08:53:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB37B1956089; Fri, 18 Jul 2025 08:53:22 +0000 (UTC)
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
Subject: [PATCH RFC v3 03/13] virtio: introduce extended features type
Date: Fri, 18 Jul 2025 10:52:29 +0200
Message-ID: <c1b14368e79fb3fd3cf402d7b03aed4449cdf0a8.1752828082.git.pabeni@redhat.com>
In-Reply-To: <cover.1752828082.git.pabeni@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

The virtio specifications allows for up to 128 bits for the
device features. Soon we are going to use some of the 'extended'
bits features (bit 64 and above) for the virtio net driver.

Represent the virtio features bitmask with a fixes size array, and
introduce a few helpers to help manipulate them.

Most drivers will keep using only 64 bits features space: use union
to allow them access the lower part of the extended space without any
per driver change.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - fix preprocessor guard name
  - use BIT_ULL
  - add missing parentheses
  - use memcmp()
  - _is_empty() -> _empty()
  - _andnot() returns a bool, true if dst has any non zero bits
  - _array -> _ex

v1 -> v2:
  - use a fixed size array for features instead of uint128
  - use union with u64 to reduce the needed code churn
---
 include/hw/virtio/virtio-features.h | 123 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h          |   7 +-
 2 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/virtio/virtio-features.h

diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
new file mode 100644
index 0000000000..68e326e3e8
--- /dev/null
+++ b/include/hw/virtio/virtio-features.h
@@ -0,0 +1,123 @@
+/*
+ * Virtio features helpers
+ *
+ * Copyright 2025 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_FEATURES_H
+#define QEMU_VIRTIO_FEATURES_H
+
+#include "qemu/bitops.h"
+
+#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
+#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
+
+#define VIRTIO_FEATURES_MAX        128
+#define VIRTIO_BIT(b)              BIT_ULL((b) % 64)
+#define VIRTIO_DWORD(b)            ((b) >> 6)
+#define VIRTIO_FEATURES_WORDS      (VIRTIO_FEATURES_MAX >> 5)
+#define VIRTIO_FEATURES_DWORDS     (VIRTIO_FEATURES_WORDS >> 1)
+
+#define VIRTIO_DECLARE_FEATURES(name)                        \
+    union {                                                  \
+        uint64_t name;                                       \
+        uint64_t name##_ex[VIRTIO_FEATURES_DWORDS];          \
+    }
+
+static inline void virtio_features_clear(uint64_t *features)
+{
+    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline void virtio_features_from_u64(uint64_t *features, uint64_t from)
+{
+    virtio_features_clear(features);
+    features[0] = from;
+}
+
+static inline bool virtio_has_feature_ex(const uint64_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    return features[VIRTIO_DWORD(fbit)] & VIRTIO_BIT(fbit);
+}
+
+static inline void virtio_add_feature_ex(uint64_t *features,
+                                         unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_DWORD(fbit)] |= VIRTIO_BIT(fbit);
+}
+
+static inline void virtio_clear_feature_ex(uint64_t *features,
+                                           unsigned int fbit)
+{
+    assert(fbit < VIRTIO_FEATURES_MAX);
+    features[VIRTIO_DWORD(fbit)] &= ~VIRTIO_BIT(fbit);
+}
+
+static inline bool virtio_features_equal(const uint64_t *f1,
+                                         const uint64_t *f2)
+{
+    return !memcmp(f1, f2, sizeof(uint64_t) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline bool virtio_features_use_extended(const uint64_t *features)
+{
+    int i;
+
+    for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i) {
+        if (features[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline bool virtio_features_empty(const uint64_t *features)
+{
+    return !virtio_features_use_extended(features) && !features[0];
+}
+
+static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
+{
+    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
+}
+
+static inline bool virtio_features_andnot(uint64_t *to, const uint64_t *f1,
+                                           const uint64_t *f2)
+{
+    uint64_t diff = 0;
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+        to[i] = f1[i] & ~f2[i];
+        diff |= to[i];
+    }
+    return diff;
+}
+
+static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+        to[i] = f1[i] & f2[i];
+    }
+}
+
+static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
+                                       const uint64_t *f2)
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
+        to[i] = f1[i] | f2[i];
+    }
+}
+
+#endif
+
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..39e4059a66 100644
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
+    VIRTIO_DECLARE_FEATURES(host_features);
+    VIRTIO_DECLARE_FEATURES(guest_features);
+    VIRTIO_DECLARE_FEATURES(backend_features);
 
     size_t config_len;
     void *config;
-- 
2.50.0


