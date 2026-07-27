Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED10AC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsC-0000Eu-JM; Mon, 27 Jul 2026 15:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsB-0000EI-7e
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQs9-0000br-Bc
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZerDmu29tPHOdoZ7YzIqHXQfCFfVjQRukUAdYkaI9w=;
 b=KnRuWjUumCPait73cNL2F3OK9+Em+SCW1f0TpkU06+zcV765vCn71P5wYpjiNyXYt27luV
 KK4FtnPpnkP57oIDXtMYiJLiMBoQ2KwIotvqI5sT/smfNnLVGKNLs0F+EMVK9yfnBSpCo6
 C+xJPz94AbmJrf5f5YWs5Z1KNuaBWwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-aFbPSBe4MTGJq4xGNf-BJQ-1; Mon, 27 Jul 2026 15:20:19 -0400
X-MC-Unique: aFbPSBe4MTGJq4xGNf-BJQ-1
X-Mimecast-MFC-AGG-ID: aFbPSBe4MTGJq4xGNf-BJQ_1785180018
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so2351873f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180018; x=1785784818; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jZerDmu29tPHOdoZ7YzIqHXQfCFfVjQRukUAdYkaI9w=;
 b=KsgmAel20l56AKLFA08A4RgUonLNSGJMUL2tospwA6AKeNIDSiipT1a7ogk2qdZPfG
 49yTRGmPkF/bKsuowy0KAUEHLVMQ8HkjvUTNlg81EszJcovUcf+U7w2XnzEOxObTq+zG
 RUTHHhW2M58tdCeXT/JAC+g+FKvMbVzveEXje3j4pRSoC44uzaLQsgF3ciKgm5Gb0woE
 6yF7pTDGvGMVfU0ngEidKMO20bupSzj/vmPTu3ofEA3kh8j/GyvNFLOEzInNiaAkvcW8
 K5qutwegXdc1SDKZM35BxHNKqpYqd7nmYLogJexx58v1f+nkG6KJm0wZpA0TSO3/vgB7
 b69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180018; x=1785784818;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jZerDmu29tPHOdoZ7YzIqHXQfCFfVjQRukUAdYkaI9w=;
 b=D1h2LnFIryXJx5N0X2+OmmQQpr5SIVyzn8j+aD+7q2249+2KD8SPTPr0WRqStPDmeN
 3srCYYgJtytcNvzUi8518c4awM+EbuHz14e6fj+wgnOgVSQfWCD/HGyRYRvMBKhwfx11
 FCO4ZLkz1vra7lFSnqoxYWwcJwHVDz6ZqK+ePKHzghzTQDujQNPbhMotjFRp4UJLq3pu
 JCiXbZsADaBd73HpgeclA9nGO8fEKHuBEczM96mMMxRisDMCKbciMf/fVzeKRo8A81Vl
 rSw7xO/Emdwv5LFV8UEHGVAfEC3ZBM2F3ZGNnSJyAHefnElM18af4zY0J63LFe7WG6u+
 Hm/Q==
X-Gm-Message-State: AOJu0YyQmwxx3jDYIXJrgWES7UqLsj0422mPLFOyz3vRY8far+b5jlZa
 5WYAsFayI/q1z2baE24mPy5WlOmN5YHT9JkOr21ecsXwbpXBYYtIYmw+tkWDkJk7ePbIP+XDq1L
 2PRnqWBX+hCqcrt007/nsDdMGLNxaxGL7TaNHIsRenDhj7aefQQLhSKyaCEFPe0stUo+CaI5q6t
 2BW/l2Hz/Vr5e6OOdrtpa/Ec31T95SjBa/HQ==
X-Gm-Gg: AR+sD12VbFQtlw5KJEhgZ5hmgRy0vAdY+XZud4t06XihLYSqHXZqzqyQWwWTRN9+I5c
 dYwDbVHYV1M2kDQXEzr2xR0KzOXYuEigiGdJjDpV6MENgQDuSgm1yLwnbgl6LXq9DChY3cMhdyP
 /DflTwIRotz7Wb335rY5lQ7GMjEafctuRJSNg3IWD0FGRO8v974ILIoeChCxIb9CcRA8xo+7CPY
 UFOkSuYdF0qmC0T9lU20nexhwAO6e4IBNQCpBJ4xZ2UvMDfadzw+d1cXEwANBwjao6KdBigktKV
 qqVaCJSiadPHKrR5bEBoJx9ysVB+oUuMclrvtwomvhMOvTe7Sjsvw0jTmGwdDNKlYzI32tfezhN
 WvBaJCsLtIkm8m+J1thmJSw==
X-Received: by 2002:a05:600c:5492:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-496b5b5d9f1mr138316255e9.2.1785180017880; 
 Mon, 27 Jul 2026 12:20:17 -0700 (PDT)
X-Received: by 2002:a05:600c:5492:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-496b5b5d9f1mr138315695e9.2.1785180017202; 
 Mon, 27 Jul 2026 12:20:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c462512dsm12660045e9.13.2026.07.27.12.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:16 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jia Jia <physicalmtea@gmail.com>
Subject: [PULL v2 18/30] virtio-iommu: fix OOM due to unbounded call_rcu
Message-ID: <67550d65b4bfdbcbfee2dae7ae1ebbbccd01dfe5.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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


