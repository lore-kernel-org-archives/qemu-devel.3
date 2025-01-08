Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8E3E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPP3-0001Ne-W4; Wed, 08 Jan 2025 01:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPOn-00014d-Fu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:39 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPOl-0000Hz-Gn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:37 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2eec9b3a1bbso19036675a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 22:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736317114; x=1736921914;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2WfOdMFhpM56iLiHN39KodrUfzohEYj4wntvgr2yc0s=;
 b=t1bIMh1HbQAJbHvENp29dHt/V279atF1P9w/6PCXQoKP84ofVsVOjtPuxZA89geiGS
 LASky3P+6VnUFroKZ1MlWzHbn0+NIrtU8QKMFgXSwujwq7za31/V912RGNslLqByv1cs
 OVU2wLHGzblJoMZEFhcVk7HB/KBvwVpXaYoESSL5exYVRfARsCqh3WEQl/XfAqPWJPcV
 YfFASFOV5y1NNCna7fkE1LLPHhle67KynOXa0hkb+DaSqjAU/wXqWSYivd64ZT0bW99X
 j3SX/bUAT9kqXp+Nt6hsdKSJdNnQ3K1SDINghV1u/UlyyimBiWIszeO/VdltXZgjlBPt
 gOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736317114; x=1736921914;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WfOdMFhpM56iLiHN39KodrUfzohEYj4wntvgr2yc0s=;
 b=lVryJb5Z0lt47OsQih1DO7hIdTYFJg7mwK1LBrW1URwnTqY3uTd1bDj5Ear25xO8vD
 TxymWAdR5rGMPOxFh01nCU/K2Zqoy5Obw8ybpQWtlyjrwOtH9XHxbF6Qnp0Mzrfjxc9e
 dQn8xHDJoBEIiK/+YDvR5/JfBxlPIUddvy5WdyYb+jhY8vwCW0v7VEPsjpO7wbp7P/oJ
 KquzRf+xaP/T7v/ADzqw6YtXZieGMkufkyJRnu0FQLaxA1wSgGtKpCaA/bNdoGhPQkhv
 NbnQ/adFMEYzOXOtQvlgXNnGU8ew0kIkRJE76xNITdJkK8XJOGdlsyXFeYgoVjHWfPHf
 3JJQ==
X-Gm-Message-State: AOJu0YwDPIWFMIZFyV+AZny5oo5RVzR/S5Jflan81n+KRTbpsKaWIqMS
 4GU9570njWHjvlvp9ikQklRxzrgdrhTu5uMY9zy/LLGBG4RZkYKCDJ5LxEztp4A=
X-Gm-Gg: ASbGncsqUR+5Aez7Hddpjl5z1ju+aW6nBfUKVV0swpfQFO3ql67oLEV2NgwoXJh9mgh
 uGJCJyvb0vQm6QGlZQnzJAW0UFJBlS/bJKQ2rOVzM/msLKV6x36J8wXYTejySTrF1AXVi7GTmuo
 5q9/VNmWzfpRhYcQNyaho/0+wBt8e3c/RfH71s37CkPowdYzthLbhLW4eGCdYcb59YiZzPqesfE
 nN7OfLD8TLj0jWpx367e6kVrf67ZtE29pjA2s1UALMlsVUlx8BktlW3fgE=
X-Google-Smtp-Source: AGHT+IE5Xte10lFwmZivfpV0OamABLydqvhHBdChutv75IqdB1WNBgiyHq9JpUhWtAb99ZRY7xfzKg==
X-Received: by 2002:a17:90b:534b:b0:2ea:7329:43 with SMTP id
 98e67ed59e1d1-2f548e9a5c2mr2411296a91.6.1736317113747; 
 Tue, 07 Jan 2025 22:18:33 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f54a2ad2c5sm602841a91.26.2025.01.07.22.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 22:18:33 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 15:17:53 +0900
Subject: [PATCH v4 4/4] virtio: Convert feature properties to OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com>
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
In-Reply-To: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some features are not always available with vhost. Legacy features are
not available with vp_vdpa in particular. virtio devices used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

QEMU already has OnOffAuto type, which includes the "auto" value to let
it automatically decide the effective value. Convert feature properties
to OnOffAuto and set them "auto" by default to utilize it. This allows
QEMU to report an error if they are set "on" and the corresponding
features are not available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
 hw/core/machine.c          |  4 +++-
 hw/virtio/virtio-bus.c     | 14 ++++++++++++--
 hw/virtio/virtio.c         |  4 +++-
 4 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 638691028050..b854c2cb1d04 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -113,7 +113,8 @@ struct VirtIODevice
     uint16_t queue_sel;
     /**
      * These fields represent a set of VirtIO features at various
-     * levels of the stack. @host_features indicates the complete
+     * levels of the stack. @requested_features indicates the feature
+     * set the user requested. @host_features indicates the complete
      * feature set the VirtIO device can offer to the driver.
      * @guest_features indicates which features the VirtIO driver has
      * selected by writing to the feature register. Finally
@@ -121,6 +122,7 @@ struct VirtIODevice
      * backend (e.g. vhost) and could potentially be a subset of the
      * total feature set offered by QEMU.
      */
+    OnOffAutoBit64 requested_features;
     uint64_t host_features;
     uint64_t guest_features;
     uint64_t backend_features;
@@ -149,6 +151,7 @@ struct VirtIODevice
     bool started;
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
     bool disable_legacy_check;
+    bool force_features_auto;
     bool vhost_started;
     VMChangeStateEntry *vmstate;
     char *bus_name;
@@ -376,22 +379,23 @@ typedef struct VirtIOSCSIConf VirtIOSCSIConf;
 typedef struct VirtIORNGConf VirtIORNGConf;
 
 #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
-    DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
-                      VIRTIO_RING_F_INDIRECT_DESC, true), \
-    DEFINE_PROP_BIT64("event_idx", _state, _field,        \
-                      VIRTIO_RING_F_EVENT_IDX, true),     \
-    DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
-                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
-    DEFINE_PROP_BIT64("any_layout", _state, _field, \
-                      VIRTIO_F_ANY_LAYOUT, true), \
-    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false), \
-    DEFINE_PROP_BIT64("packed", _state, _field, \
-                      VIRTIO_F_RING_PACKED, false), \
-    DEFINE_PROP_BIT64("queue_reset", _state, _field, \
-                      VIRTIO_F_RING_RESET, true), \
-    DEFINE_PROP_BIT64("in_order", _state, _field, \
-                      VIRTIO_F_IN_ORDER, false)
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("indirect_desc", _state, _field, \
+                                  VIRTIO_RING_F_INDIRECT_DESC, \
+                                  ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("event_idx", _state, _field, \
+                                  VIRTIO_RING_F_EVENT_IDX, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("notify_on_empty", _state, _field, \
+                                  VIRTIO_F_NOTIFY_ON_EMPTY, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("any_layout", _state, _field, \
+                                  VIRTIO_F_ANY_LAYOUT, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("iommu_platform", _state, _field, \
+                                  VIRTIO_F_IOMMU_PLATFORM, ON_OFF_AUTO_OFF), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("packed", _state, _field, \
+                                  VIRTIO_F_RING_PACKED, ON_OFF_AUTO_OFF), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("queue_reset", _state, _field, \
+                                  VIRTIO_F_RING_RESET, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_ON_OFF_AUTO_BIT64("in_order", _state, _field, \
+                                  VIRTIO_F_IN_ORDER, ON_OFF_AUTO_OFF)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c949af97668d..bff26b95dd74 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_2[] = {};
+GlobalProperty hw_compat_9_2[] = {
+    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
+};
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
 GlobalProperty hw_compat_9_1[] = {
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 896feb37a1ca..75d433b252d5 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -50,6 +50,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
     bool vdev_has_iommu;
     Error *local_err = NULL;
+    uint64_t features;
 
     DPRINTF("%s: plug device.\n", qbus->name);
 
@@ -63,13 +64,22 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
 
     /* Get the features of the plugged device. */
     assert(vdc->get_features != NULL);
-    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
-                                            &local_err);
+    features = vdev->host_features | vdev->requested_features.auto_bits |
+               vdev->requested_features.on_bits;
+    features = vdc->get_features(vdev, features, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
+    if (!vdev->force_features_auto &&
+        (features & vdev->requested_features.on_bits) != vdev->requested_features.on_bits) {
+        error_setg(errp, "A requested feature is not supported by the device");
+        return;
+    }
+
+    vdev->host_features = features;
+
     if (klass->device_plugged != NULL) {
         klass->device_plugged(qbus->parent, &local_err);
     }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce3744..83f803fc703d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4013,11 +4013,13 @@ static void virtio_device_instance_finalize(Object *obj)
 }
 
 static const Property virtio_properties[] = {
-    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
+    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
     DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
                      disable_legacy_check, false),
+    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
+                     force_features_auto, false),
 };
 
 static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)

-- 
2.47.1


