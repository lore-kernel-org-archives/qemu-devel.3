Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BC7D1715D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36rX-0002Dl-7M; Tue, 22 Oct 2024 00:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36rJ-00027v-Ab
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:51:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36rH-0008Rb-C7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:51:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so50540715ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729572662; x=1730177462;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q/GNOYUKbHrVkW8DjI8/OPo0jygVL2ZBNtJGkOtaWHo=;
 b=sU2xrFfhWW6oPiQ45oKcZVy/1mdkWqff1yij25hzCD9hCDFFC7vxXYVe0ELeIclBSf
 O/AdZZu+Gt5cotCbpsXQ3m3m1MEmp/bBoAJVOvWf2PMND59U6+4FY5GxXKNQQtnZCAHG
 9cJjm52v1dMk76271isYGvgfIDEoZMz1ndYL6+zixBthVUIWwgCAqIY/NtU5/3i2Z/Wp
 oNYMg/KWxriTjEyjNhBe9ODOr5/Nf4ht9u0yCk/dxAC6+CJNB9tLkIeuhdrFwMJDERsW
 /Up7tWVs3M5FEUbmBPy2hJ38EqtRPbSHHCcxBee+BCn+aMMQ8pc0OH4MgvnXi/M57/5e
 PjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729572662; x=1730177462;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/GNOYUKbHrVkW8DjI8/OPo0jygVL2ZBNtJGkOtaWHo=;
 b=rQX9qAVXCJto2pI57/NedApdoVbMjExUjlCafNktccCLTXHJAEGiAIbVZJBlNkc4ph
 ucyECKFpp06Xh/rBCXGSdLuZ6khdRBJy8GWkGrNpiKUvcxbEKbBQJUqd5R73uzrIDcVV
 7PEeXkaB2FcVF7qWC9X+2qMTt+Xt+6V7jD4mBgunHR2VrbW4nsKwD25/Zdn/ejN3gzoz
 5vMvIWWrokS7wOIZLcrWCfFv8vdsZj4EaSetrPhhFsPBqVfopSXc6MRRpZ5fibnLZIwB
 dsdr0jac1bWwJ+zrR10aH75dNQDjTzxpiTUlGEP4znDkYYYIBqHFgc6bzNHCwNAKFvSx
 VXgw==
X-Gm-Message-State: AOJu0Yy/Mf7+P96/TGaIbAvQcHBu+LhqcR1P+ecx8AN0fEMjo0EqZEVt
 jPeucHauPSRJ4173HPQbK6AL9rSv4J7OqoZjBxrEJP+uP4wQDt95gXvyMymBnGo=
X-Google-Smtp-Source: AGHT+IGqI10LdHIAupBeVIo+yRLJYmd9Uzza4t/E1j/f4FOFkgwrBbWpBIoIlwnryVlCdBYoc4JAPw==
X-Received: by 2002:a17:902:e54f:b0:20d:f55:8a17 with SMTP id
 d9443c01a7336-20e98453283mr19519985ad.6.1729572661982; 
 Mon, 21 Oct 2024 21:51:01 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20e7f0e1ba7sm34502545ad.238.2024.10.21.21.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:51:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 13:50:40 +0900
Subject: [PATCH v2 3/3] virtio: Convert feature properties to OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-virtio-v2-3-b2394236e053@daynix.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
In-Reply-To: <20241022-virtio-v2-0-b2394236e053@daynix.com>
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
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index f526ecc8fcc0..b4cb5642ddd0 100644
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
@@ -374,22 +377,23 @@ typedef struct VirtIOSCSIConf VirtIOSCSIConf;
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
index adaba17ebac1..3021d42fca12 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,7 +34,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_1[] = {};
+GlobalProperty hw_compat_9_1[] = {
+    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
+};
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
 GlobalProperty hw_compat_9_0[] = {
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
index a26f18908ea5..44ad58de33c8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4006,11 +4006,13 @@ static void virtio_device_instance_finalize(Object *obj)
 }
 
 static Property virtio_properties[] = {
-    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
+    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
     DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
                      disable_legacy_check, false),
+    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
+                     force_features_auto, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 

-- 
2.47.0


