Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7AECD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBv-0005Uj-Ey; Sun, 14 Jun 2026 15:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBt-0005DX-56
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBq-00029G-Gs
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xchnRDkuMDmqYE0l4bXozaE3u6jXG7uZukZrRqShITs=;
 b=Q75JWVrye/IH3QhY8Q4KgnLNDxoC6cB5lgr6Gl6gB/cO7YahhF7RSIngid0rl69Be45rQO
 wfKrp3QKOWgExnsuHXHCXPlPNIRHKdKrlFdjrkrIxJPjgu+piX8q9FeXIkzCRKfO8TGn4A
 jIxz6jSyIdiaWYvHoGso4vNOvuPAxEo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-_y5p0wo1O1CJC2IDb8sZ9w-1; Sun, 14 Jun 2026 15:08:12 -0400
X-MC-Unique: _y5p0wo1O1CJC2IDb8sZ9w-1
X-Mimecast-MFC-AGG-ID: _y5p0wo1O1CJC2IDb8sZ9w_1781464091
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so25304325e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464091; x=1782068891; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xchnRDkuMDmqYE0l4bXozaE3u6jXG7uZukZrRqShITs=;
 b=i8kjYaVb9C9byOq5KkulgQDJ+x/G43WNhe83tVPRIpFrQoUbf3nLC+kUWQ2GFdpiFW
 Kp6mYLgPFrixeHCvq5t59iNLMYcDI8OYWZF/XZ99c9uVGTqD9ezH+UOjDJ91j4q6zZYF
 W5EiUqNMbYAsK5wVR1UwrYwfX+eu+JjCeIBOFw9qJEcu8uKalQ6hBLaKfc0mdrFDPEqA
 StjKfHLsviWvGVqSsTHvgR8FvDCib6gbMaqmyCBL3jPbGD+Pi0Ycx2wWD2iu0Iz7FvBP
 dHj33PdC/06B0FFzJN+xHRVqreK2/CgmhCyTVQYvhXpoYbtuyZ+4tP4Fo72zv6xK/wps
 9jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464091; x=1782068891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xchnRDkuMDmqYE0l4bXozaE3u6jXG7uZukZrRqShITs=;
 b=lftz8vUSrVuLL6NBd8xO6PZna5za+VmEgQKPKPHesaffcSjxljWME4zAX47fRZxLdb
 aZSCjVcl+GMlL8Rcn57pXm28pef+byeVzIQVkzR4DpPKmSo+qDdDcywYoOkRjHjhcCrB
 YMqvvkZxNwhzQMt3JX4dGShrEtN7T2NqHRn5UOdna48cTGvm0zIK8cnWo6wap8SHa4cM
 81eeCVbPKWEEQmKtH/jaYlJMfqe/JpudxRUmake/iJZgo8izqiuMJ8EcPM+XolGWQzmc
 tNWW5TjBGMFceTr7poW4Ghquw8gpnKvHo96b4A6MBvj+LwV+YDveM1I1e60BrTzs+Sg9
 zfMg==
X-Gm-Message-State: AOJu0YzYRKM8WkMl6/HdfWJP09yXJeMQe4v3k5+wyPTi3uj50L9HDfD1
 CNF5EswreZLr1f+Kx5ki2xCs+5Z1ZERiyigwwPyeIcPLp6fI1db7Em+KfKdEVZofV4h1tRQ6foW
 UN6siqeNPtTjEjy6CPLpToU0I7R6sUUE2xqywSGXdXPn9nCyKOULb8vbJMbyrduwpxWpXuGPH0t
 OphFnZ5q001cJZdV7ueudG0yJfsaYkuKE4Gw==
X-Gm-Gg: Acq92OHKKSHfnCCPVXACOMdxjj0AhymKI8ZJrWljEmGOykkfIvxQV43qRetFH2KQhvY
 bp+rXHrYvXFI6eznyFYNt+c5R90biQMWflYEbXIANOkB0ErQB5/f8nG5jhfeC5rSutV5aBE/CdM
 yJiT/Fzt4snFJPQmqK2gJJVJpyKyCTH9ZdcH/Bfk5g7yn0P9KMQVf06RBivB/rxojlpeQIi6Qkv
 9fV5L37DMJoferYeXb7xxSY55/4x23zl8kP23JAKE95drl19rMymCL944LbivZAngHyIu+H+BP9
 kw7/xFS8lkHp9vPfP6CoTS8mDQJ0iyJK2lDWWIvWoe9z42fNMwQm1J4KGi9hv+7dq5QsvZ/8ch2
 qRjU4clFkhUAz4h/B9pPobE/3eGzgWu0k6b0skBlKA8M=
X-Received: by 2002:a05:600c:6542:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4922006283cmr65644785e9.14.1781464091011; 
 Sun, 14 Jun 2026 12:08:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6542:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4922006283cmr65644435e9.14.1781464090368; 
 Sun, 14 Jun 2026 12:08:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c5266sm29983246f8f.29.2026.06.14.12.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:09 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 056/106] vhost: rename vring pointer fields to reflect user
 addresses
Message-ID: <3fbef0689a3cde55efce72a3f6333031a3149f69.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Rename vq->desc/avail/used to vq->desc_user/avail_user/used_user to
clearly indicate these fields contain user space addresses, not
physical addresses.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-9-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c         | 37 +++++++++++++++++++------------------
 include/hw/virtio/vhost.h |  6 +++---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6bb6b07e19..e3d452a763 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -489,11 +489,11 @@ static void vhost_vrings_unmap(struct vhost_dev *dev,
         return;
     }
 
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, touched,
+    vhost_memory_unmap(dev, &vq->used_user, vq->used_size, touched,
                        touched ? vq->used_size : 0);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0,
+    vhost_memory_unmap(dev, &vq->avail_user, vq->avail_size, 0,
                        touched ? vq->avail_size : 0);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0,
+    vhost_memory_unmap(dev, &vq->desc_user, vq->desc_size, 0,
                        touched ? vq->desc_size : 0);
 }
 
@@ -504,13 +504,13 @@ static int vhost_vrings_map(struct vhost_dev *dev,
 {
     vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = NULL;
+    vq->desc_user = NULL;
     vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = NULL;
+    vq->avail_user = NULL;
     vq->used_size = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = NULL;
+    vq->used_user = NULL;
 
     if (vq->desc_phys == 0) {
         /* Queue might not be ready for start */
@@ -521,16 +521,17 @@ static int vhost_vrings_map(struct vhost_dev *dev,
         return 1;
     }
 
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
-    if (!vq->desc) {
+    vq->desc_user = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
+    if (!vq->desc_user) {
         goto fail;
     }
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
-    if (!vq->avail) {
+    vq->avail_user = vhost_memory_map(dev, vq->avail_phys, vq->avail_size,
+                                      false);
+    if (!vq->avail_user) {
         goto fail;
     }
-    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
-    if (!vq->used) {
+    vq->used_user = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
+    if (!vq->used_user) {
         goto fail;
     }
 
@@ -594,7 +595,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j = 0;
         r = vhost_verify_ring_part_mapping(
-                vq->desc, vq->desc_phys, vq->desc_size,
+                vq->desc_user, vq->desc_phys, vq->desc_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
@@ -602,7 +603,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j++;
         r = vhost_verify_ring_part_mapping(
-                vq->avail, vq->avail_phys, vq->avail_size,
+                vq->avail_user, vq->avail_phys, vq->avail_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
@@ -610,7 +611,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j++;
         r = vhost_verify_ring_part_mapping(
-                vq->used, vq->used_phys, vq->used_size,
+                vq->used_user, vq->used_phys, vq->used_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
@@ -1106,9 +1107,9 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
         addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
         addr.used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
     } else {
-        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc;
-        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail;
-        addr.used_user_addr = (uint64_t)(unsigned long)vq->used;
+        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc_user;
+        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_user;
+        addr.used_user_addr = (uint64_t)(unsigned long)vq->used_user;
     }
     addr.index = idx;
     addr.log_guest_addr = vq->used_phys;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b292e9f0fe..684bafcaad 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -24,9 +24,9 @@ struct vhost_inflight {
 struct vhost_virtqueue {
     int kick;
     int call;
-    void *desc;
-    void *avail;
-    void *used;
+    void *desc_user;
+    void *avail_user;
+    void *used_user;
     int num;
     unsigned long long desc_phys;
     unsigned desc_size;
-- 
MST


