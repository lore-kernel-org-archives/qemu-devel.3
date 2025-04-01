Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05296C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzdOc-0006E2-Tm; Tue, 01 Apr 2025 11:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tzdO7-0005yn-Cl
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:18:55 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tzdO4-0005Aa-4t
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:18:51 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so9269324a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1743520726; x=1744125526;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NXX1X4hRiRNZUknx8LsP9b/fPPtl0kWy3TtPAhKCeU=;
 b=THshtjMS56Ub/nZ829BiNQIPs1F+ArYlAkmLEinZOzLTwM5OHZ5TsI7NhtdhkmlLde
 OlzEjL+UB+pJsZj/nAWwUQwpN9RLxfzU71vvm5jVJp5seH/WL14UqUswJdo03dJ3McaL
 zM+QNtFfQFg4fHzm9z4nn7/CyzyGega6WsscuyCt91NLh2EJHKYF/Jo8qp6NFjHtYj+Z
 FnrWM82eDW4xGlEqWQRfyW77bDGVhA4NxwbeihpuhkzteL7U9Fqppu7vc3oHFboD/BJW
 f0PnxuoVutpUKVbUMz0CHpiJuSDCmF18TudJdHjsJ8nWxgDRi+jFwORd41yzagSEct/H
 6a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743520726; x=1744125526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NXX1X4hRiRNZUknx8LsP9b/fPPtl0kWy3TtPAhKCeU=;
 b=gsLFxpXcnWz8//E5Zb+mLNoNydSScVK1EYLhOfG3yUOSoerT/GpGvRkWiGQCwfQc+Y
 +A0ZBtLzBTJ8NPlRRGA+9c7N8Rv2XYXvhBZZiV9w/joc+iL7YdgkK5+lA6I13EzqRhFG
 r4HnnokEzBmSkiVOQKtvMzak+Fi2m307tzDXfm4wuzCtcHwfn8VMBqeT9MBEhlX0kJJB
 bCDzh30BXHS/Ikem2jM2y7Oot82+Kg+OYZXe0izIfpD0vMuMOD0zdQCWIB4FwlVhzHmR
 rAeHwidpAuV+XxuWDmN7ARb8V4s8BEhtDy6tJxApOpkZtQJ15W7NDYHfQfmT2q3c9uCL
 DSKQ==
X-Gm-Message-State: AOJu0YwwJRPu9MV6exuglx7SwV1VkLx0+zyo6COxy9oxf2A2wP2rmkI2
 TYzpguW39vTUnsZbEbS73Q7oz0RKXDLXdEmfgccWoYyWSoAbIvbBRncpZKQVQYskMFd1PrVVgHZ
 /vmvFJQ==
X-Gm-Gg: ASbGncuKXxTK2oQjhRMzjtu9PdbqgcNetmoHsc1I8C12dD1BX+YfS55OhLinVofS6MS
 NCvkjrdF/16XlhHpVcVotGlx987dGt+bzE21V18YBUkUATP6PkjQm+H/xid5jC3HxV/NDz5ss03
 Vq6v6WaG1Mrg8DZhGHqhW0bKEcWmEwhauwnzODUKDf68FLWF9OR91hUA/T+7d8Y2eVXFDqgfHF8
 3nS2/z7ub0JGvPXoJJPbC5AZNqBpCAGUbcLWOO4+IbnfLjVs8Zc8aoENlnTX7xMmk4/ANzR0kQ1
 SJnI3+Glrdp+irQVq1xvGCAY9WQ3ZMI=
X-Google-Smtp-Source: AGHT+IFtnBfm3iEUuKkmkY4Wgfbu6YeM2h6VlJT3NVowOQMfk4p479pWxi+aoJAGqxAnh7LQT7UBvw==
X-Received: by 2002:a17:90b:5446:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-305608793e6mr6498428a91.14.1743520726364; 
 Tue, 01 Apr 2025 08:18:46 -0700 (PDT)
Received: from fedora.smartx.com ([2001:df0:a640:1::4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee029bsm90172195ad.62.2025.04.01.08.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 08:18:45 -0700 (PDT)
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
Subject: [PATCH v4 2/3] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
Date: Tue,  1 Apr 2025 11:18:16 -0400
Message-ID: <20250401151819.1526461-3-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250401151819.1526461-1-haoqian.he@smartx.com>
References: <20250327064348.3595732-1-haoqian.he@smartx.com>
 <20250401151819.1526461-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=haoqian.he@smartx.com; helo=mail-pj1-x1031.google.com
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


