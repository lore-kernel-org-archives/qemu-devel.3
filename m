Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB664EEA86F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgO2-0004i2-5P; Thu, 12 Feb 2026 18:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNy-0004gQ-Dj
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:14 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNu-0008B7-HW
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:13 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82318b640beso207908b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770939969; x=1771544769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+sZ5I8NPsAH1XUC8CuVzuaEOJRie1BD5CLUQ6ZuKv0=;
 b=AFuQ0fM5ZxNiOy491CrM5V00UB+XHO6eC794JdyagzNShnCAvwxvxZrxivkMNuXgG6
 HevcpbSYkRTP1fTHmEFcaedOTG/le2T9Z1ymA36Gkqxkppegs4fARk7CTOmuauI7/g0A
 7lR4sVwJjCKRP2nloKJOu0l+s5IIKiO41Z7e4cjRX7B9SgrNHON9ePsH+ia816M5EYSr
 5HrCCX31QlIVQdJD+qBSFqgawWdy+X/fIyoNV41v/+1eN3QwU6omZQPyRF3JXnL2cxxL
 O+3L0t+kWp6FyjYOnaUjKsKW8xD5ecQUEa9op0rteAq+tgbKpQxqYJKQw96dR5fLI5Pq
 hfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770939969; x=1771544769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/+sZ5I8NPsAH1XUC8CuVzuaEOJRie1BD5CLUQ6ZuKv0=;
 b=LRU5oLeEvotA+nRwYlp4hDwiDH0x59xqwuWivr3VgRfaMNo9MhNLdaYpVZPcEPJJrS
 eFai0MGr4YJYklewkh4HTpxWng/izly5OZgeyYSRIQvQyyKEMxT20VosIxQG4iDDudst
 JGmc2s5OpqAb4klY29wdposmaxtuMS5DcYWfdGmc4zSQ53kjPAky4m0SF0k1VzKP/74Y
 NJJ5uFwDTzRdtlrfpGTKEC0S2Tn9Hal4pFFwA77eK+XmfeTNwxnbuMh7+CDEENQYpsF0
 P+MDLqduOQ2YPCuWO/iC22dFh6np/4PCs1dEyei0p9X6h+tiePKLHO+vsipHAWMsVq6T
 O/fg==
X-Gm-Message-State: AOJu0YxQwyoMDI7cK23x/g8JmINO41cchNng4HncQ3e2BABqdsyZC8gt
 hUBeWB8MaFe5v2BTYHd5dyqieIMSSIL6iAWKYjcj/YTKUJoE00gUmuJywf9gOJOanymAdROizbs
 IeQL/
X-Gm-Gg: AZuq6aL4plxOSB7UuprI2e19nKvlqk+du8MFg4hhb/tZHWzr9PmQ8pky5JNErJx1wix
 JsME1w/VaRyMW9MN1lIcI6SiQT/M+1bYAxsZkKr43KmpIKYACNDIoPMAsMzn+daYvMsWyMQCAp1
 7+mDch2QYzja1Y+0uOcChLqc9XWPsTZu6bcwLW8U/f0Z/Mc8o1o3h7hapDaw9gnSjtXODWBdi4a
 FZ6MGMfwYTGTCsB5E0eoioT0Elg8aFdz759waukGCFxQhzhOpGlIrbqx0SP137onvPXFYeIyWwJ
 uiLSBNShKNcvJOJ8Mn1yCI+lJTegpO3n/aw2t7ZpmljlDcnHxKRnaUJRobvd8guq3PYhln8eQJ/
 /RIKX79J9qCXlHKEbRK7eGKduoaJJdE7Xt7ycpK63KH5de7x8QdVTYaeMbHfgSlSzBuSpvPLwKb
 ucUmCunjVFIU1jArYIBE1bANV4dr/TXe6AZRLWyV0ueDI3AJeX8uk961TSF4s7/xU2IwVRoiREy
 BGk
X-Received: by 2002:a05:6a20:748b:b0:38b:de3d:d530 with SMTP id
 adf61e73a8af0-39467468ae4mr419290637.72.1770939968993; 
 Thu, 12 Feb 2026 15:46:08 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1ac0e004sm5609936a12.6.2026.02.12.15.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 15:46:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/virtio: add virtio_vdev_is_{modern, legacy}
Date: Thu, 12 Feb 2026 15:46:00 -0800
Message-ID: <20260212234602.338131-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h |  3 +--
 include/hw/virtio/virtio.h        | 12 +++++++++++-
 hw/net/virtio-net.c               |  2 +-
 hw/virtio/vhost.c                 |  2 +-
 hw/virtio/virtio-pci.c            |  2 +-
 hw/virtio/virtio.c                | 16 ++++++++--------
 6 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index cd17d0c87eb..324ba907e93 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -30,8 +30,7 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
     return virtio_is_big_endian(vdev);
 #elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+    if (virtio_vdev_is_modern(vdev)) {
         return false;
     }
     return true;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27cd98d2fe1..8f1e4323599 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,9 +468,19 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
+static inline bool virtio_vdev_is_modern(const VirtIODevice *vdev)
+{
+    return virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+}
+
+static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
+{
+    return !virtio_vdev_is_modern(vdev);
+}
+
 static inline bool virtio_is_big_endian(VirtIODevice *vdev)
 {
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
         return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
     }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 512a7c02c93..313d3b88400 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -217,7 +217,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
     memcpy(&netcfg, config, n->config_size);
 
     if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
-        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+        virtio_vdev_is_legacy(vdev) &&
         memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
         memcpy(n->mac, netcfg.mac, ETH_ALEN);
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 52801c1796b..70a112242b0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1168,7 +1168,7 @@ static void vhost_log_stop(MemoryListener *listener,
  */
 static inline bool vhost_needs_vring_endian(VirtIODevice *vdev)
 {
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_modern(vdev)) {
         return false;
     }
 #if HOST_BIG_ENDIAN
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1e8f90df34e..6126187a164 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1449,7 +1449,7 @@ static bool virtio_pci_queue_enabled(DeviceState *d, int n)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_modern(vdev)) {
         return proxy->vqs[n].enabled;
     }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 77ca54e5206..b0987e66d5b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2279,7 +2279,7 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
     trace_virtio_set_status(vdev, val);
     int ret = 0;
 
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_modern(vdev)) {
         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
             val & VIRTIO_CONFIG_S_FEATURES_OK) {
             ret = virtio_validate_features(vdev);
@@ -2365,7 +2365,7 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
      * be re-enabled for new machine types only, and also after
      * being converted to LOG_GUEST_ERROR.
      *
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
         error_report("queue_enable is only supported in devices of virtio "
                      "1.0 or later.");
     }
@@ -2454,7 +2454,7 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     /* virtio-1 compliant devices cannot change the alignment */
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_modern(vdev)) {
         error_report("tried to modify queue alignment for virtio-1 device");
         return;
     }
@@ -2753,7 +2753,7 @@ static bool virtio_device_endian_needed(void *opaque)
     VirtIODevice *vdev = opaque;
 
     assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
         return vdev->device_endian != virtio_default_endian();
     }
     /* Devices conforming to VIRTIO 1.0 or later are always LE. */
@@ -3228,7 +3228,7 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
     }
     if (!ret) {
         if (!virtio_device_started(vdev, vdev->status) &&
-            !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            virtio_vdev_is_legacy(vdev)) {
             vdev->start_on_kick = true;
         }
     }
@@ -3446,7 +3446,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     if (!virtio_device_started(vdev, vdev->status) &&
-        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        virtio_vdev_is_legacy(vdev)) {
         vdev->start_on_kick = true;
     }
 
@@ -3461,7 +3461,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
              * to calculate used and avail ring addresses based on the desc
              * address.
              */
-            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            if (virtio_vdev_is_modern(vdev)) {
                 virtio_init_region_cache(vdev, i);
             } else {
                 virtio_queue_update_rings(vdev, i);
@@ -4019,7 +4019,7 @@ void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     error_vreport(fmt, ap);
     va_end(ap);
 
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_modern(vdev)) {
         vdev->status = vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET;
         virtio_notify_config(vdev);
     }
-- 
2.47.3


