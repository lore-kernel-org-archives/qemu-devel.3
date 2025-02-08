Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39001C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 07:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgfd1-00064m-Gu; Sat, 08 Feb 2025 02:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfd0-00063B-B9
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:50 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcy-0007uv-Hs
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:50 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f55fbb72bso24317075ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 23:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739001107; x=1739605907;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YXil5SQirdez18zIelkFLKwbjlIjiAsP2lun4WfVXEo=;
 b=T7nNQvJdOHPMXiaBZP+x64QqOidtQPQbpxo1CtbjDRTb+GJjPMVwICOCVxGQju8fYI
 hx0jmoz6um/i0hhPi8VXw/ynFIlJHkxHd3jz2yU/26sl9UirYGdM0+mTgolDcc/afji/
 9DSEr5aPmYGvYYxtlfnTH0kKPICwgtYXRybgi2yTdRdP6eWyD3vQq9uM+IXY0hGIDNWn
 vTWLoRK2/iLR1tLn1s8TnvOYKd0Bd2wuSvxf9FeI7I60WNjiQu2zbov130z0gbeOSfke
 7sWTFdh4AHfjWK3ENBnzZKak4GRktM6miGfrzpT4bAj6Z95NDq3uTMrpBEhHnQJHqNds
 WX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739001107; x=1739605907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXil5SQirdez18zIelkFLKwbjlIjiAsP2lun4WfVXEo=;
 b=YK5qyVqmvp5PMArfx/Nwev97YfnlCa95vOf1EXBEeAAWgcW7IjyjUB1u5XcvLCuEbc
 Q6Y4RD03tiddjDIF1XBxII/MzvBOTAD/sFhwLIUPJGgaCdrXSaaDbkT4XmkbwrLSMnPH
 hU8cdcwI1VR0sHoY77kWhkdTf0hxp6omRvOn32IhMk/ZtX6LNyYbCQLb3SpiD21yE81f
 n7z8ptaWeGY2Wm5BVs2mkno7axvPKQ6TR0xsLvxPjyu6bNvn7NZ9sqD0z23jWReY2I21
 5H5I/+tWtN7LCpNWTnv92tawHzhM1WLHRFRULwAHfTUVENe8qsgh8IWzMCv/mMNnjAGu
 K0VQ==
X-Gm-Message-State: AOJu0YwiaiQFZFcgjwGKX+eyzcHf8L3eeklkjl8jlp+N75U/qaSDx712
 C0YSi3qZ+WoO8uXmNapDrRvmYfnyALjwujXAEX6puVnI5knmKor1FT0bUqtVz5E=
X-Gm-Gg: ASbGncvXBvlj00l+XsM1qU/ACHxfDKSTVonltMVeckM4TUHu8xHUeaHuNrs/c/ZdKIU
 f3kXt3CoitEKAMm4SYpneYhKaoHEYq00Gkkye/HAmNrEpSuvBUpErDhYxKLj/2Sq67YbnaJlLsk
 mDV47r9Cgwrw2iKRe/4ADPr6z63ANups5Zb4VELGmeLJxQrZsJUrWGiC0sccdYyUl/qKVM4yE6G
 NNpyaboLOIqSQwSGMqAevcCvplb493YKd8cEMcGr9xEQmtqibzexShBuo38Q/dZyHvJvrLxtMml
 4eHeGPKFW+fxNhIiClk=
X-Google-Smtp-Source: AGHT+IG6aO+F2kUAB7v/qlYFWjtJxEBvCfWlRl0qN4dIAVV7ahzVPyVC+yNPyY0V7yFFZkblIm5NpQ==
X-Received: by 2002:a17:903:90e:b0:21f:3e2d:7d42 with SMTP id
 d9443c01a7336-21f4e6d2658mr92822125ad.23.1739001107245; 
 Fri, 07 Feb 2025 23:51:47 -0800 (PST)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21f3687c7b6sm41882355ad.196.2025.02.07.23.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 23:51:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 08 Feb 2025 16:51:10 +0900
Subject: [PATCH v5 4/4] virtio: Convert feature properties to OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-virtio-v5-4-4376cb218c0f@daynix.com>
References: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
In-Reply-To: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
 hw/core/machine.c          |  1 +
 hw/virtio/virtio-bus.c     | 14 ++++++++++++--
 hw/virtio/virtio.c         |  4 +++-
 4 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 638691028050d2599592d8c7e95c75ac3913fbdd..b854c2cb1d04da0a35165289c28f87e8cb869df6 100644
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
index c23b39949649054ac59d2a9b497f34e1b7bd8d6c..0de04baa61735ff02f797f778c626ef690625ce3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@
 
 GlobalProperty hw_compat_9_2[] = {
     {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 896feb37a1caa805543e971c150d3673675b9a6b..75d433b252d5337d91616a2847b3dc12e811c2da 100644
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
index 85110bce37443bb46c4159761af112d0dba466b4..83f803fc703da6257608e21476305c8e9c6a8b07 100644
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
2.48.1


