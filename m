Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F6F47CDA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFuZ-0000nD-99; Thu, 05 Mar 2026 16:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuX-0000md-Gs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:09 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuV-0008O2-KX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:09 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ae43042ea7so58419915ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744826; x=1773349626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjVg4k8L5YS0+fbIU3cK5+QxAukvdu0K3zvehSjPnuA=;
 b=w4SYJPnouxRNhZslUmRzOsubpAkJLfmsMmD2vrctjfKB/2o/nHEjnh7IEMfNu4rQk0
 3AOVovjGhKg6ZU9CYqLdrr3zzHRp8P7DsdB3JNOKpYnmGpCcbUWStsBiNS2q00TdDVBW
 UTjRk3/ohnx6xmZll4esNXfobPcq7EJRyTTdP6Ec67AH8T/7kyFPfQUFPZCSzl0SJULf
 Ike3KzuL3qstdABBo+sHJpB48M3z4803Mua4i34HUZGm/rHGpEq/qxGLczdpz1rOhsBB
 /lCYBSDQ3pZSwDYWhrmlERnd5L+Vd/SEUXlXrhqTuePdsECXL+sRAR1xadfMR29nlsqZ
 uQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744826; x=1773349626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjVg4k8L5YS0+fbIU3cK5+QxAukvdu0K3zvehSjPnuA=;
 b=rnodWLK50MGEJi1t1RNr55vnodPLwbuZgPQqTQB4hlYe6VkKNg/CRbS7ofHizYBqlR
 taOoWbMvJybHnCkV0sAYK6iBMRQQJZVheXDgjVhhTXWHlKMBC3wEeNU+NkLGKpKUxmVF
 N+T5goeOe1JSNgFP0zSuIYdvPXTTSa+L583OfPsrLsyYlyVflXjqZCncf0l8EPFJAlLz
 PPEddxxdugOfgbCNHeZjG0Rzk8goWsJlMMpBEGyHALr8QDnFUK7xZ6nIRKmWWDxLhyW8
 2Bu3reXeiOWSdi4o4aHgY+Bsym+12eiF/0tfdb3mdzQbykmKjWLC0Yu9a4OQIqgxVG7A
 lrmA==
X-Gm-Message-State: AOJu0YxfKmp7rTirgt3PQhB0DD8p1jj0FFgiOQrAn57vpQSgGdjqDmWY
 Mi6v8CkWyVVSafBLa0Oh2I1KjHM573q4uolH/RituhjQWTUwqHJiOtlo0XZFKCfybNb6Ufq4lUR
 +WqMK
X-Gm-Gg: ATEYQzxhpW+6QHwamct8t+Bucru3if5sDAOSt5Fbt80Ms5YIMyxTDvKxn7D9YN99PHm
 +HuMczsgsOj4IyaxN5RFTNPB5vjJmYZqOo6+G+31dJiLwhNLr+ljE4JF/4qZ5pbWaQ/8RehbhfO
 tHEo06E9OSU0wcenNs3uLkVWyBr+POEJ2q+xqtUM5rvlf1vtVQGfCydQ0YKPSCCKkQs40urB7dN
 RaJk6NNCzzn5FB796agdl765tfhrNLLsn19a3BZC419IU4E7wZgghKUGF0ty6TBZZyZTYcn5AGP
 a87V/+VPA4eK+tCU5Ohy82KUUOgRcOURQ9nfMtEDDSIYPwXRlUnFLfvJfBStnCftKu/7DC1mDm8
 I2RKnRx+b/ooWuGfURPAYmN/etpklcbS5a+Njv62hXmVa8ky/UaFAh503Jvpg/VaCYZzHHSqaxE
 si1JHcUy5gqZsHoC3UZgcMSeHLtO7ar3jcA5/RPc5oMg7GF2mKjaOVMPschaENFCY/LdOrRQD79
 kZE
X-Received: by 2002:a17:902:ce02:b0:2ae:7f6d:78a4 with SMTP id
 d9443c01a7336-2ae7f6d78c1mr12440495ad.56.1772744825937; 
 Thu, 05 Mar 2026 13:07:05 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b5813sm236992505ad.63.2026.03.05.13.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:07:05 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/6] hw/virtio: Add virtio_vdev_is_legacy()
Date: Thu,  5 Mar 2026 13:06:51 -0800
Message-ID: <20260305210656.2140206-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
References: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This simplifies code compared to having
virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-2-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h |  2 +-
 include/hw/virtio/virtio.h        |  7 ++++++-
 hw/virtio/vhost.c                 | 12 +++++-------
 hw/virtio/virtio-pci.c            |  6 +++---
 hw/virtio/virtio.c                |  8 ++++----
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index b58fb6ed7ea..b8aa7a520f5 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -30,7 +30,7 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
     return virtio_vdev_is_big_endian(vdev);
 #elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (!virtio_vdev_is_legacy(vdev)) {
         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
         return false;
     }
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9dd93cf965a..42d20899390 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,9 +468,14 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
+static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
+{
+    return !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+}
+
 static inline bool virtio_vdev_is_big_endian(const VirtIODevice *vdev)
 {
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
         return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
     }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b4cdb7762f9..b9dc4ed13ba 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1168,14 +1168,12 @@ static void vhost_log_stop(MemoryListener *listener,
  */
 static inline bool vhost_needs_vring_endian(VirtIODevice *vdev)
 {
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        return false;
+    if (virtio_vdev_is_legacy(vdev)) {
+        return vdev->device_endian == (HOST_BIG_ENDIAN
+                                       ? VIRTIO_DEVICE_ENDIAN_LITTLE
+                                       : VIRTIO_DEVICE_ENDIAN_BIG);
     }
-#if HOST_BIG_ENDIAN
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE;
-#else
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
-#endif
+    return false;
 }
 
 static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *dev,
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0f5654f459e..bcab2d18b80 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1449,11 +1449,11 @@ static bool virtio_pci_queue_enabled(DeviceState *d, int n)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        return proxy->vqs[n].enabled;
+    if (virtio_vdev_is_legacy(vdev)) {
+        return virtio_queue_enabled_legacy(vdev, n);
     }
 
-    return virtio_queue_enabled_legacy(vdev, n);
+    return proxy->vqs[n].enabled;
 }
 
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e9d55329525..c0c4599b586 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2753,7 +2753,7 @@ static bool virtio_device_endian_needed(void *opaque)
     VirtIODevice *vdev = opaque;
 
     assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
         return vdev->device_endian != virtio_default_endian();
     }
     /* Devices conforming to VIRTIO 1.0 or later are always LE. */
@@ -3460,10 +3460,10 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
              * to calculate used and avail ring addresses based on the desc
              * address.
              */
-            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-                virtio_init_region_cache(vdev, i);
-            } else {
+            if (virtio_vdev_is_legacy(vdev)) {
                 virtio_queue_update_rings(vdev, i);
+            } else {
+                virtio_init_region_cache(vdev, i);
             }
 
             if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
-- 
2.47.3


