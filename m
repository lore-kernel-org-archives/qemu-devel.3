Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E75E68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIX0-0001TF-Ah; Sun, 22 Feb 2026 18:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWy-0001SY-C6
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:28 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWw-0005vm-MA
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:28 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso42603125e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801585; x=1772406385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rr8FkQBr/lYljYmGeFF82bNCM/SiTFsA//YlWk/hsy4=;
 b=as1k8jOU7bwtQ5EhPphj8n6lJ8cLCYlRAxLYwhTInp4LZadZiA962ygHwI22Kkuywd
 AjvEZZ2R5UkBImqou3F9H88j9DJi9bEN5nj5rsbzE5nS436BvD3eajdkQ1mYge0OzsDF
 fS3gd9em7MQw6XxlRtYiXAD4bx0Zj3TOqR2vQzwacdaLqIMNyt0RkyQht0Q0LQXZQBbb
 Z5zdOv/0eVtU/Ne50GTleQkXdqEwXkXfNUIvVCXAlNc8BooZnjiBWZJRTURGvmbLhK+a
 uAmTQwFhSBsxGTCMSwdJWIsPL5Uat3a9NhiK5tSvR4MiSGpsMarqt2Un3OOWA1rMN+95
 pYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801585; x=1772406385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rr8FkQBr/lYljYmGeFF82bNCM/SiTFsA//YlWk/hsy4=;
 b=K6NbzRor66gYUj5xF9AjSMkMDnbqIwwE7D7OqpSNywH6/zlcNOQ0MRp6+cVq/vZR+k
 jbegiIL/mUEzd/XMCJ0kGKxrdj/vWCMEaDhmnBcojX4lS4xcY6uI9sIZe32yDv+X25nx
 Sg6Kp4F7372PU4wC3kB2pDRvYV8tIZ8ugyaLmaYqnYicaJPrRZQiV66n9lm6O/eY95Mc
 JmtgVVI3t8xPovG0oxYbB6KvyXtDuuvHxkrdZOZuBBexcknv4cYTOSmL8eBXdBGwufN1
 divZch9wiOJrjezq08/DMacSkdqC2baey4wERgxtSC5p1weNQWHDhjOeQgJEu/E6ZKhq
 wF7g==
X-Gm-Message-State: AOJu0Yz58bUQX2nYB3dsT5na63LaN2rL3r6bbW3l807GXEzta8atdZXz
 abxcD6xURvz70Ff5pMEhG3+2+NcP0T76iyZ7/HlvtVDwE/14GdIPkmOqWgZ6ceV2g4CNnoNprzf
 U0gF7qpw=
X-Gm-Gg: AZuq6aKj4mR+KhYw2CXjNce03GsoUZ3tP3PzYeNCPguZ0RegSi3N7uUBOYiUGRmJY4F
 CEGtqW4zn4HPq8VAzlaGon2ohFG9zPd14+8ShqnIZ+GEnxe0ycWpT03n1Ee4O+Th/RYCaRoKL90
 ZKPIdB03/KCEi+vEspD4ZaHCzTivh3AOekfM/F7QaqZBr4LpGySXZpR4iIOQ3SHxgMDGvA1N7xS
 5TS0V3uaCmrW4asmmHU7U+aFK9mZ61T/qjYRVZ28SQAQPUTyI+uWip12KsBRB4n3Xc2NftJ2DOE
 wWL+2CR8WVcxB0X4ROCvOMRG/w1AGZbqK74H0PJ6flmzR/Jh6y38kgFDDBodxxJXQ6zZsLEfoVa
 TAuxZBj9IXQ7x9X1AlYCVxiz6jvAv8MgE0u2HYuu5Bl0301J31yOG9tvP8yZNrABSApMQd4kHAv
 TsyHuUnrlimszYPdIO0rEBP7frTUZcgQqIdNVn5BiulIjFRTMFVVBoc0T/AentfddEuIDaHW5l
X-Received: by 2002:a05:600c:6487:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-483a94d2fb5mr124628665e9.14.1771801584855; 
 Sun, 22 Feb 2026 15:06:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a429e49csm114613625e9.4.2026.02.22.15.06.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] hw/virtio: rename virtio_is_big_endian to
 virtio_vdev_is_big_endian
Date: Mon, 23 Feb 2026 00:05:44 +0100
Message-ID: <20260222230602.5756-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Renaming this function removes the confusion with
existing virtio_is_big_endian cpu ops.

Indeed, virtio_vdev_is_big_endian is *not* calling cpu
virtio_is_big_endian everytime.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260212234602.338131-3-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 2 +-
 include/hw/virtio/virtio.h        | 2 +-
 hw/net/virtio-net.c               | 4 ++--
 hw/virtio/vhost.c                 | 4 ++--
 hw/virtio/virtio-pci.c            | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index cd17d0c87eb..b58fb6ed7ea 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -28,7 +28,7 @@
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
 #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
+    return virtio_vdev_is_big_endian(vdev);
 #elif TARGET_BIG_ENDIAN
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 65872f2c54c..b3c6a9dc6f4 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,7 +468,7 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
-static inline bool virtio_is_big_endian(const VirtIODevice *vdev)
+static inline bool virtio_vdev_is_big_endian(const VirtIODevice *vdev)
 {
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index cc89619a433..eccb48ad426 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -301,7 +301,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
         if (n->needs_vnet_hdr_swap) {
             error_report("backend does not support %s vnet headers; "
                          "falling back on userspace virtio",
-                         virtio_is_big_endian(vdev) ? "BE" : "LE");
+                         virtio_vdev_is_big_endian(vdev) ? "BE" : "LE");
             return;
         }
 
@@ -343,7 +343,7 @@ static int virtio_net_set_vnet_endian_one(VirtIODevice *vdev,
                                           NetClientState *peer,
                                           bool enable)
 {
-    if (virtio_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return qemu_set_vnet_be(peer, enable);
     } else {
         return qemu_set_vnet_le(peer, enable);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 52801c1796b..e98e3a40a07 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1306,7 +1306,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
 
     if (vhost_needs_vring_endian(vdev)) {
         r = vhost_virtqueue_set_vring_endian_legacy(dev,
-                                                    virtio_is_big_endian(vdev),
+                                                    virtio_vdev_is_big_endian(vdev),
                                                     vhost_vq_index);
         if (r) {
             return r;
@@ -1423,7 +1423,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
      */
     if (vhost_needs_vring_endian(vdev)) {
         vhost_virtqueue_set_vring_endian_legacy(dev,
-                                                !virtio_is_big_endian(vdev),
+                                                !virtio_vdev_is_big_endian(vdev),
                                                 vhost_vq_index);
     }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fe13a7a9503..c7b5a79b936 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -586,13 +586,13 @@ static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
         break;
     case 2:
         val = virtio_config_readw(vdev, addr);
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap16(val);
         }
         break;
     case 4:
         val = virtio_config_readl(vdev, addr);
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap32(val);
         }
         break;
@@ -625,13 +625,13 @@ static void virtio_pci_config_write(void *opaque, hwaddr addr,
         virtio_config_writeb(vdev, addr, val);
         break;
     case 2:
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap16(val);
         }
         virtio_config_writew(vdev, addr, val);
         break;
     case 4:
-        if (virtio_is_big_endian(vdev)) {
+        if (virtio_vdev_is_big_endian(vdev)) {
             val = bswap32(val);
         }
         virtio_config_writel(vdev, addr, val);
-- 
2.52.0


