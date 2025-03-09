Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED00C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 09:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trD9e-0000CO-8D; Sun, 09 Mar 2025 05:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trD9a-00005r-1s
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:41:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trD9X-0004Ao-DB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:41:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2232aead377so67734005ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741513258; x=1742118058;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eh6xZmod1XJzdJDqa+dorzqnDF3twPcYJbdIGQ8yqlo=;
 b=VFsKcWzhSWSgAHaM8U54/pTx6Nzh2t0MccjEcz+0ttfnzo61UOe6iea57nq1nu+ckx
 tec+826oPokkXDb0S7s1bP059LRKMl3QZyRw2JBeJWvac4wqxP8ENJ2BV3EeQILcvclH
 RTNdE6IsBwIhtnmSd3I6HqKvImSd+n7NgVPByGXcXqvwhGTamsWhbOAht190cuVObgxk
 IAtDZZBrKTT3Q99ju1cw/XLRInN7eCQKifTV0K/zRwucMe8/dNh7y4xVE7unfmuQm989
 VYzarw+iCXnDF+QlE0f6fCkQPN/2U80EPJ5PnAWlVmYvTTa6gbK2SS+u5U2lJq73OLP4
 K9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741513258; x=1742118058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eh6xZmod1XJzdJDqa+dorzqnDF3twPcYJbdIGQ8yqlo=;
 b=O6LZdvim6DCfNbjPx8F9hqnaLpv9fGg/Aec0xn24N43llLM5OlhiY8tO0yQBh5wmCw
 pUCQtBXBWQFn6l+gJw+k1fSrv1mypyryrY0S7yb7sCmGKC6WYruMt1yEKTkpuzOJLPHs
 qt8vcZMcXED3+SenSici9RgGirlSR902dJJe+N95e1+TaUQ36iOOFRcZx85qRC29WPvL
 ehuyTSiQSdGI1ApsGccRpxzU54KbXGeXbmVCsaWKilzBV3zmVb00eKCsKEfRzUj82zol
 ihq/oxdHIZf9xz5XZekCIKEb2/Bj9CqOyjx0e/KC52DEyEExHvBetlPAbLKuFhtBvddT
 IdsA==
X-Gm-Message-State: AOJu0YwtRsuIYJwuL6dEiawGdhxNG8JBJP3WDCeje7wm3n3yUBfIiW0+
 3/Rpye6TngP899Cz3j5W3LnKCyS4MsyurcaxPuR7Hy6FWbyVeJCcae1xvQFFrQJhfgKy8JZbgxq
 bZOL66A==
X-Gm-Gg: ASbGnctyJriiF7Qw0z1ROxpPZ2ygrIXQzjhAARGmr5VKiKCyGR42xiVmMAt4rLKwkKZ
 77niE7mXQz2gzWp67SXZuxsZgM4VIVDEYuCo68OENTkWakBVNtutWlQuxaL9lFFD+7DiFVR8aqy
 rAmUQvkA49abtaQ/Ww+zATqMM7SLMbyXRAVLPSf7LCwkE0H4yXJXYAG6F4DYOWcdU/NfytNEeC/
 x1TjLs9VA82l5GyvfBvKuIUKvMMN+Kxvtd4WH8cKiV0TYPVwsVkUlGwtzO1Obt2t44PWXeKBLSb
 m2gdD4s2iCq0p6ZgLOdUGyWzFhmvniTGd3yzpISwzdCLKB+HLH5b
X-Google-Smtp-Source: AGHT+IFd+dUTlIZVThVJQpaxksgShVwmhZ3DuojwHwy13tAbGh3o917KVQ5nV+6J5rP6kyWftCoAZQ==
X-Received: by 2002:a17:902:cf07:b0:224:192a:9154 with SMTP id
 d9443c01a7336-22428a8cf90mr160892165ad.26.1741513257693; 
 Sun, 09 Mar 2025 01:40:57 -0800 (PST)
Received: from fedora.smartx.com ([103.85.74.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410ac0794sm57716185ad.259.2025.03.09.01.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 01:40:57 -0800 (PST)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org
Cc: fengli@smartx.com, yuhua@smartx.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 2/3] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
Date: Sun,  9 Mar 2025 05:40:50 -0400
Message-ID: <20250309094051.3655292-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250309090708.3928953-1-haoqian.he@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The backend maybe crash when vhost_dev_stop and GET_VRING_BASE
would fail, we can return failure to indicate the connection
with the backend is broken.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 hw/virtio/vhost.c         | 27 +++++++++++++++------------
 include/hw/virtio/vhost.h |  8 +++++---
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..c82bbbe4cc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1368,23 +1368,23 @@ fail_alloc_desc:
     return r;
 }
 
-void vhost_virtqueue_stop(struct vhost_dev *dev,
-                          struct VirtIODevice *vdev,
-                          struct vhost_virtqueue *vq,
-                          unsigned idx)
+int vhost_virtqueue_stop(struct vhost_dev *dev,
+                         struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq,
+                         unsigned idx)
 {
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
     };
-    int r;
+    int r = 0;
 
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
-        return;
+        return 0;
     }
 
-    r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
+    r |= dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
         VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
         /* Connection to the backend is broken, so let's sync internal
@@ -1412,6 +1412,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
                        0, virtio_queue_get_avail_size(vdev, idx));
     vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
                        0, virtio_queue_get_desc_size(vdev, idx));
+    return r;
 }
 
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
@@ -2136,9 +2137,10 @@ fail_features:
 }
 
 /* Host notifiers must be enabled at this point. */
-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
 {
     int i;
+    int rc = 0;
 
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
@@ -2157,10 +2159,10 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         vhost_dev_set_vring_enable(hdev, false);
     }
     for (i = 0; i < hdev->nvqs; ++i) {
-        vhost_virtqueue_stop(hdev,
-                             vdev,
-                             hdev->vqs + i,
-                             hdev->vq_index + i);
+        rc |= vhost_virtqueue_stop(hdev,
+                                   vdev,
+                                   hdev->vqs + i,
+                                   hdev->vq_index + i);
     }
     if (hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2177,6 +2179,7 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     hdev->started = false;
     vdev->vhost_started = false;
     hdev->vdev = NULL;
+    return rc;
 }
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a9469d50bc..fd96ec9c39 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -232,8 +232,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  * Stop the vhost device. After the device is stopped the notifiers
  * can be disabled (@vhost_dev_disable_notifiers) and the device can
  * be torn down (@vhost_dev_cleanup).
+ *
+ * Return: 0 on success, != 0 on error when stopping dev.
  */
-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
 
 /**
  * DOC: vhost device configuration handling
@@ -333,8 +335,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 
 int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
                           struct vhost_virtqueue *vq, unsigned idx);
-void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
-                          struct vhost_virtqueue *vq, unsigned idx);
+int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
+                         struct vhost_virtqueue *vq, unsigned idx);
 
 void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
-- 
2.48.1


