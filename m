Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93989C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wms4r-0003ND-Or; Thu, 23 Jul 2026 07:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wms4n-0003Me-U1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 07:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wms4l-0002F9-GC
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 07:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784807933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=k3hR2LKB54KqVvBl0oK91dbaFADAaXEYoFZ/tG2rZFM=;
 b=D/pp9VowPp/c7Zm84ikI9Bvyou1wlqj9/hu+7tmxTuc2M55UsRTnkrjaAO/GRqkQEuwAnd
 SqsbHDM/ltFHvXiFcMEkXrmLlKise/ZqNgieLS5sJ15MJLo2x3YIwbqC0zZ1MPl9Zr7l1u
 nQ8x7SL6rjgRbyoUe7YbZAt/TqeDAQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-pgTA8m24OiSVahpK2mMM0w-1; Thu, 23 Jul 2026 07:58:48 -0400
X-MC-Unique: pgTA8m24OiSVahpK2mMM0w-1
X-Mimecast-MFC-AGG-ID: pgTA8m24OiSVahpK2mMM0w_1784807927
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955edc851aso3699285e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784807927; x=1785412727; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k3hR2LKB54KqVvBl0oK91dbaFADAaXEYoFZ/tG2rZFM=;
 b=MceKa0flfiC8sGKtR9G0W7X8FQF7Rluqj/NzHwlbvcYc0leW6bmg+ZfCX9rD6RqTwD
 LgXgMQIziAKjsroT9cD0HWBiLw6A5+khZRHONmu162FsmSTYR+AD+SnY3NE9ngf2MJrF
 UnYGJaFUMqSi623Xp3CJOoFQl8o3tJ4SEhaf27f0JScE0wDanA/osBSBf8xFsqnGGdUL
 Y5xubZ/3X7x38yyGaNIFYPdlRf8GQMH4l4VDiRKwscLjVbU+DxgToFjJaibABJgZDTs6
 wr8ttd77dp97lxoLkPbNYMWnMjfYFJdvi3bu6qZlTeQwSPZHQG3LbEbqbFFJeeOkapoC
 oOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784807927; x=1785412727;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k3hR2LKB54KqVvBl0oK91dbaFADAaXEYoFZ/tG2rZFM=;
 b=Rag9YME6YjDFPUPtMWZFHS1hO8GxWzUEg+ght5bRqqSf2ckjZ9LmTXBmYA/qqRFlEZ
 yvSMl79IxCOb64994l2Rx17SjWwlOgcoP9x8SjupN9Lyj3hidGr7mBRmjKvpLPj9gGMz
 HIH7i3/zVRFk/pL7o/r8qjpR4AxgPRuz/Nv21dN/ufywxmV15DnW0hRJ7gYH/DFvMP40
 xOXqv3ED9ojzxlp+Ll1AlAH87elM31OV8rmLH4LJIcTQWrmK4qqHoA8DfojkT8TE88ND
 zhFkDnTQAnAVLeLDuvCZsGC7jC6RfHpBk+aBoDyfigVqOcayaAT1W9t48rzWA7nVH7iq
 l5iA==
X-Gm-Message-State: AOJu0YzScDuBs1+qH6n67gFe3KM3KCi1Mcqdmm2jiNnZ3jzTzcRrMHpZ
 dUQ8Q75oPKEqVF6lO0x2WtKYhXWZh3mVOaUqftUpizaPXNTGzD/kTsWzP6nvgAEEHstSRsZqzdi
 GQgizYTlvyaezjzLC7JWkKmS+r2LmzVn1jzTA1iFICXrcKxU78FBgnd2M/UfKvhqImm05WCwlsu
 Hcrk0uHPBSR3DVodCsfZUQU42lf3qv7sQDkQ==
X-Gm-Gg: AR+sD12EsXbMQlFLkP4L3z0dpw7mIgs47txC2YdIbdgk/eslOc/2PHczfzhksHYIwTg
 GyTMS+G881xNBwxFOeocb+5wZXAHPBn4FRJpVf7CYZ8iWroK408qQpEbVJnsWl7hBH750oQkq5I
 fL6qMJX6rfHn8ZOkFdMAKeUeiITudHeqvH9Yl9YPw33Z7158VBelASkUa4m//l7XkEA0Yj+x3Pk
 cY3k07Vf/7QruQn+HL8hT7/MVBCv3NOn39nMLfxsoowu0CY7qxeDY9YxkicXY667c53p4yiIqoG
 NVkAvAhgbMgJ1cwU41jccoNtgiytE6k4nvshibqYl6BzGXuDX78Xxtg3WFPtpYYr+60Qvkl0Ew4
 T7rPbhLFEw/bJ4WWShrX7mw==
X-Received: by 2002:a05:600c:5489:b0:495:40aa:d982 with SMTP id
 5b1f17b1804b1-49573c8c272mr28724995e9.6.1784807926946; 
 Thu, 23 Jul 2026 04:58:46 -0700 (PDT)
X-Received: by 2002:a05:600c:5489:b0:495:40aa:d982 with SMTP id
 5b1f17b1804b1-49573c8c272mr28724665e9.6.1784807926297; 
 Thu, 23 Jul 2026 04:58:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm14445673f8f.24.2026.07.23.04.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 04:58:44 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:58:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH] virtio-iommu: fix OOM due to unbounded call_rcu
Message-ID: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Currently, within virtio-iommu, handle_command processes the command vq
without any limits on the number of entries processed.
This can easily and repeatedly enable/disable multiple memory regions.
Within the memory code, this causes an accumulation of an
unbounded number of RCU-deferred FlatViews - each of these
is supposed to be freed with call_rcu, but that never happens
because the main thread never returns to the main loop.

Given FlatView is big, it's easy to have this balloon out to multiple
Gigabytes of memory.

Limit the loop defer any remaining work to a timer.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3930
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 3b86050f2c..1f265540ad 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -65,6 +65,7 @@ struct VirtIOIOMMU {
     GTree *domains;
     QemuRecMutex mutex;
     GTree *endpoints;
+    QEMUTimer *cmd_timer;
     bool boot_bypass;
     Notifier machine_done;
     bool granule_frozen;
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 08f7e8b783..533bd5073f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -993,6 +993,18 @@ static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
     return ret ? ret : virtio_iommu_probe(s, &req, buf);
 }
 
+static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq);
+
+static void virtio_iommu_handle_command_timer(void *opaque)
+{
+    VirtIOIOMMU *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    if (virtio_device_started(vdev, vdev->status) && !vdev->broken) {
+        virtio_iommu_handle_command(vdev, s->req_vq);
+    }
+}
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
@@ -1003,10 +1015,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
     struct iovec *iov;
     void *buf = NULL;
     size_t sz;
+    unsigned int batch = 0;
 
     for (;;) {
         size_t output_size = sizeof(tail);
 
+        if (++batch > virtio_queue_get_num(vdev, virtio_get_queue_index(vq))) {
+            timer_mod(s->cmd_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
+            break;
+        }
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             return;
@@ -1416,6 +1435,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
                              virtio_iommu_handle_command);
     s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
+    s->cmd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
+                                virtio_iommu_handle_command_timer, s);
 
     /*
      * config.bypass is needed to get initial address space early, such as
@@ -1498,6 +1519,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
 
     qemu_rec_mutex_destroy(&s->mutex);
 
+    timer_free(s->cmd_timer);
     virtio_delete_queue(s->req_vq);
     virtio_delete_queue(s->event_vq);
     virtio_cleanup(vdev);
@@ -1509,6 +1531,8 @@ static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
 
     trace_virtio_iommu_device_reset_exit();
 
+    timer_del(s->cmd_timer);
+
     if (s->domains) {
         g_tree_destroy(s->domains);
     }
@@ -1628,6 +1652,11 @@ static int iommu_post_load(void *opaque, int version_id)
      * still correct.
      */
     virtio_iommu_switch_address_space_all(s);
+
+    if (virtio_device_started(VIRTIO_DEVICE(s), VIRTIO_DEVICE(s)->status)) {
+        timer_mod(s->cmd_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
+    }
     return 0;
 }
 
-- 
MST


