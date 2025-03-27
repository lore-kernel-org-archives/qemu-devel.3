Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99C8C3600E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 06:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txgyN-0002Uc-3m; Thu, 27 Mar 2025 02:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1txgyK-0002To-SY
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:44:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1txgyI-0004Fw-II
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:44:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22435603572so12615485ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1743057849; x=1743662649;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NXX1X4hRiRNZUknx8LsP9b/fPPtl0kWy3TtPAhKCeU=;
 b=XG1lz4C5yat9FB3R1xnvmFDgvGFcFMntF9uHuu7uEMlK02lTcvaGS0zVWxuqpux8tO
 HOpoXwsQhKOJStAWhAk97A6OHsExK6bnyDqxHo1rqpMz9adrJeyi9B74b8ZUMmywUMRT
 VV6uIX0OhSFprG5rvPE8FjSrZtb+FuFW++GbQu64Vts+kpGv6xD5h7RhRzObh/216RHl
 681eaEGCoX/kC8H5Rv5aHtMoQzgJV3373jutwDcQiv3c7GGkzhoZy1E7KdDVCIY8HHcK
 hyM+KmI+2DSGsNrGGQ0A1vnmOhgNek0K/DuvYr0C4KpbPONS9kALkTQ7r2jECmwuGrBh
 TxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743057849; x=1743662649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NXX1X4hRiRNZUknx8LsP9b/fPPtl0kWy3TtPAhKCeU=;
 b=CzHA2+rpGwJLSqncuu9nbtSndKkaQiPXXZwC9f64TmQozmW28EPhvU54cAHKuFlr5q
 1cVO2SrO9Ptm6a3oeGXPrHjkrggHXYcZEJm3fgeCp5wtGkbwF9NEmUroSLCbG8/xbhtV
 vd4O3/u1F3kYgTMPLJXKN7kBfFUAyu1nuwSsHmCMghoUij5cKdt16MWN838kgctvdrjp
 ID2FQg+ShSLplf0LyS97WztJBXaZopC8/cWzO+LlPGjbib49KHmkoU2pRX/hRAjz6+hd
 eQyWDG4Mysk8yfnC+jbZ8tC8hZc+WbHYK2qQrNcZqxuy+IS0UrK7CVYqiZREeGH4GONm
 A0tQ==
X-Gm-Message-State: AOJu0YxBIvD+8b4Rc6MRTxv5oPlicdIQLgVk0zqEbHWgC7RoJgnqNI26
 Ui5XhNeHkRrlX1S1X4LniYOMJNObzPi0l9Io4HfYiYDTReqe6ji9kAbj0Z4lDcCLm0YwevnZjEV
 FyJM=
X-Gm-Gg: ASbGncstnDKzC4WBHd8YUG0VP7RhqrBpb4QDh6qycNoX1HI5lEvmKiURjLbRaLQBY7h
 jsZXW4Ij1UaC0k6rGoitmjrdg7KLYeGJB6FuPNqT5K1vFgcz18T/VB4KinQSCaYGe7L+P1/U+Rh
 O0QgJm9IdfBzeSPUluzZvtwhGaIW111ot6plieL7mRQ9k+zGX66JFnZZSekyV9eGVx5lbnoOq5b
 dA0KWiN8CjNdZmp2qSX1T/J+XNqxWJ7OwriE+crPUk5ZsUmAUwIk4m3WkhinQL1Uc47v/JR+eox
 +KQ98yt3ZQurzJVbGT2UVG250e+qIRs=
X-Google-Smtp-Source: AGHT+IHaOhLpe6TbeM+DqsxZp8oHnSg44s7BnhqVeoz3PH/V5XigwqmHEVGhiMCVf2y/Ww08jEXj4A==
X-Received: by 2002:a17:902:daca:b0:223:fabd:4f99 with SMTP id
 d9443c01a7336-2280482a885mr40124565ad.5.1743057848723; 
 Wed, 26 Mar 2025 23:44:08 -0700 (PDT)
Received: from fedora.smartx.com ([2001:df0:a640:1::4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4599fsm121983015ad.67.2025.03.26.23.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 23:44:08 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org, sgarzare@redhat.com, mst@redhat.com,
 raphael@enfabrica.net
Cc: fengli@smartx.com, yuhua@smartx.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com (reviewer:vhost-user-scmi),
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 virtio-fs@lists.linux.dev (open list:virtiofs)
Subject: [PATCH v3 2/3] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
Date: Thu, 27 Mar 2025 02:43:46 -0400
Message-ID: <20250327064348.3595732-3-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250327064348.3595732-1-haoqian.he@smartx.com>
References: <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250327064348.3595732-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch captures the error of vhost_virtqueue_stop() in vhost_dev_stop()
and returns the error upward.

Specifically, if QEMU is disconnected from the vhost backend, some actions
in vhost_dev_stop() will fail, such as sending vhost-user messages to the
backend (GET_VRING_BASE, SET_VRING_ENABLE) and vhost_reset_status.

Considering that both set_vring_enable and vhost_reset_status require setting
the specific virtio feature bit, we can capture vhost_virtqueue_stop()'s
error to indicate that QEMU has lost connection with the backend.

This patch is the pre patch for 'vhost-user: return failure if backend crashes
when live migration', which makes the live migration aware of the loss of
connection with the vhost-user backend and aborts the live migration.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 hw/virtio/vhost.c         | 23 +++++++++++++----------
 include/hw/virtio/vhost.h |  8 +++++---
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..bdd945c18d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1368,10 +1368,10 @@ fail_alloc_desc:
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
@@ -1381,7 +1381,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
 
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
-        return;
+        return 0;
     }
 
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
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
2.44.0


