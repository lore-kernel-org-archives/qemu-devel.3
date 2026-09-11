Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B112C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAs-0005XP-5Z; Fri, 11 Sep 2026 05:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA7-0003v8-I9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA4-0008Go-IY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DD7zxYroH7IaX3wIfwdVw0uNvZf16+MQiMTQFIYE/+w=;
 b=T0lvbqzZlj7AZFYWl/iiXS9sOU5PbhZm1W98Bjl74vV/yYZ6srWLYvZDefgDYmIOZ0Wwg4
 qA6U9hsmM+4HVvmgzQqbzn/iL4H5ZH6OAWYYgD5uSgIjZ0gosvt7wVOCIbkDxGB66q2XVc
 Tz8OQMY8/t2wZzpNpsbVO56+4jEt2Ck=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-e35dekjcPl-CPvn32NUsdA-1; Fri, 11 Sep 2026 05:03:04 -0400
X-MC-Unique: e35dekjcPl-CPvn32NUsdA-1
X-Mimecast-MFC-AGG-ID: e35dekjcPl-CPvn32NUsdA_1789117383
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso1174505e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117383; x=1789722183; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DD7zxYroH7IaX3wIfwdVw0uNvZf16+MQiMTQFIYE/+w=;
 b=dKOnENMJeikD1qTfJSLdsri/bhh9ryEW6hA+4vbQ7M0EbbW+Vh54dCqjv6EbaMvqZ2
 br55h//PXELY0V42+sTgzkeNGVMxEUgYv8TmLsc+qx1nRTiB9+q8Awr/g7pfudxeatvw
 apuYjE0KGy7Pbyj6uzZRpIMnqVHt1UO6cCQEHbLHxk3gM5053FfcASZp+RLxHRMdpm3w
 Iliov40Tn+qKvDaXHPKZ6GiqR7Zn/GoekbchVvqT8Vvu/JqC7Vidb4s9X2kETWIDW7G0
 rjh3hFpq/l+88xr/D93pwfzXVjfEOR6MKAixAn/LixJliGdTqnCS3oiRT4e/4PeVCE0H
 vUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117383; x=1789722183;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DD7zxYroH7IaX3wIfwdVw0uNvZf16+MQiMTQFIYE/+w=;
 b=k7wPo0dNcsj31GJs7OoIgTTKx/pdGY37QvI2SAtDkEITgarRbyol+/S16OObtlhh/U
 dbnMi31jDB+Piw1ximMMmiICvOp7ofP9l9vp5ZOSY0JVjkG1ZO54bU3WXpt6aWQ72yvo
 ccgwZ+3mJcnruGuQONeJCZcCuVU6MvVSDz5H0m5UYJrdCh9SBRlJyHfcd4N2gk4M874v
 7mVzXPJvz8CF7E+4sqEGPo+g7DEg5Jpwf+vwBRwP1QglXP8j8cdX5XqUzuGZh/zp73L8
 4Oddn/y7VygQY59A+QoT3olTQhHg1VGlX4CL+Gmh38xdyaBwWYuCqmxIhGsvAN8iB4Nc
 TPcg==
X-Gm-Message-State: AFuF++m42z0DYXuI2w+I4PWkGBIcBBmUnyED02m1Qch7mf+wwXDPRG5p
 FjKXbFKYeGHtGOjp2sWzS9CwM3ulmz9ipiRO7kmfBzsm0/yuxjP6tw0zkoZbiLfYDnge8h7hZ4W
 HUhhnxhIv/9M02Ut1cT3zBqjihmEiT0qoB0K9TNOd2Tdgb8k75eBbPNrqYkwawK+jI4KaXFOOge
 tyLvWYTpNJ3qjd+tLgOhXLaMFFMTfTivTpZQ==
X-Gm-Gg: AYBFou3JUdndLhb6KZC1JLK3FT5OxX4t8OwVQbgKLpog/Nb7O9ONLnxT4y8IA6w/Abx
 ygaaNzupq2cI4g5H8QEblyseTI+gOKybUHoN5uFDT092Y5riiroJCDo+Ijc+xs+dCdXGZfKvAig
 D0fa8ICYzU+inUwNGGmeCkVus/6BWdzNUMitZ4SlyRyUoy8594LolT01KQJWv+pyN7fApy8IYod
 2KMZbMkB/y/PEiZIQq8GaCVKLl9L2B6oeJRlW1WPTkDXOKe/42vA9Z5erEx2FLV8HrERaMnGAo/
 uTnlj+caiRRb6jYhJfj6O6+4z+iD04+zQCJkLnZTi5BqsS/ZgVYoaBWN8o8kbuFwuP+lY+6rxza
 UmKGoTGfNShSgSW6fQEHSc5Y=
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr34603305e9.4.1789117383072; 
 Fri, 11 Sep 2026 02:03:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr34602545e9.4.1789117382371; 
 Fri, 11 Sep 2026 02:03:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm69492385e9.0.2026.09.11.02.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:01 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xiong Weimin <xiongweimin@kylinos.cn>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL v2 43/75] hw/virtio: Propagate vhost_virtqueue_mask errors
Message-ID: <4692630d1859603ad16ba46c9994d85f259adc12.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Xiong Weimin <xiongweimin@kylinos.cn>

vhost_virtqueue_mask() currently reports failures from
vhost_set_vring_call() but always returns void, so callers cannot
react.  In particular, vhost_virtqueue_start() has a TODO next to the
unmask call when !use_guest_notifier_mask.

Make vhost_virtqueue_mask() return the underlying errno, and on failure
in vhost_virtqueue_start() jump to the existing fail path which unmaps
the vring and propagates the error to the device start caller.  Other
call sites keep today's behavior by ignoring the return value.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807024359.2157914-1-xiongweimin@kylinos.cn>
---
 include/hw/virtio/vhost.h |  9 ++++++---
 hw/virtio/vhost.c         | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 684bafcaad..3db56433b6 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -310,10 +310,13 @@ void vhost_dev_set_config_notifier(struct vhost_dev *dev,
  */
 bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
 
-/* Mask/unmask events from this vq.
+/**
+ * vhost_virtqueue_mask(): mask/unmask events from this vq.
+ *
+ * Returns: 0 on success, a negative errno on failure.
  */
-void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
-                          bool mask);
+int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
+                         bool mask);
 
 /**
  * vhost_get_features_ex() - sanitize the extended features set
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 371dca17dd..52ea142bd4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1471,8 +1471,10 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
      * will do it later.
      */
     if (!vdev->use_guest_notifier_mask) {
-        /* TODO: check and handle errors. */
-        vhost_virtqueue_mask(dev, vdev, idx, false);
+        r = vhost_virtqueue_mask(dev, vdev, idx, false);
+        if (r < 0) {
+            goto fail;
+        }
     }
 
     if (k->query_guest_notifiers &&
@@ -1919,7 +1921,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n)
 }
 
 /* Mask/unmask events from this vq. */
-void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
+int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
                          bool mask)
 {
     struct VirtQueue *vvq = virtio_get_queue(vdev, n);
@@ -1940,7 +1942,9 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
     r = hdev->vhost_ops->vhost_set_vring_call(hdev, &file);
     if (r < 0) {
         error_report("vhost_set_vring_call failed %d", -r);
+        return r;
     }
+    return 0;
 }
 
 bool vhost_config_pending(struct vhost_dev *hdev)
-- 
MST


