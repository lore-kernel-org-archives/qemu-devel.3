Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3BDCD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBN-0002qj-3m; Sun, 14 Jun 2026 15:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqB7-0002Lb-Kr
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqB5-0001xX-RQ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=viOnv7vns4x2QuQDCUIYzKJ96reRINzzZuhUSEBRK4k=;
 b=CSEvArDgBNoUVGH5Nk9WWXZL6XWOEKleVvo1b7bpAUqRuOzsVa5xRGJkuOBk5gGcxpa2Ff
 ZR28OM8uYhypUZXrzUHrhS28UsZaRkPUEr+6Yw7uGq1S00R79H7FSwjFvdm1KHSdw6gX+d
 +uuulWWQAGAhXMuzCFo6Bj4HtmSwAHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-qaycHxEMNQuaBkROYsHt9Q-1; Sun, 14 Jun 2026 15:07:26 -0400
X-MC-Unique: qaycHxEMNQuaBkROYsHt9Q-1
X-Mimecast-MFC-AGG-ID: qaycHxEMNQuaBkROYsHt9Q_1781464045
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so25300625e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464045; x=1782068845; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=viOnv7vns4x2QuQDCUIYzKJ96reRINzzZuhUSEBRK4k=;
 b=C68mF01HykChhH3yKYKxTMhptyEpCv7uorLKnMaePsxHkjeM9cfzAYZ2LtdD2cZZVp
 p1DRwQtkkU42tD/5UiRLplx8VibiUOaVwJpdYYXgs+HatTAyrWKBak19VT6/tIfvuADX
 5msyZ2Fy2a2UPzdxHsO2lAioNgHHDoZ0fVQ72ZkoS49KJEvNg1+RiP8D4UlvfMeUzHpr
 v9qhQXplvrj0E6nc921GG2+DdJE8efMMj15uVMj8ewxifbKbreOIWakHUr2BjCUAh+kA
 +B53epTbSlQ0iAT1JWX4vpH42YQwhAxhLWJ4SiC6NBJ61lULzDneD3yL0FsI3/ojtKR7
 JD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464045; x=1782068845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viOnv7vns4x2QuQDCUIYzKJ96reRINzzZuhUSEBRK4k=;
 b=cUt8leL/XofkRjSq9agZaQSNHEXIx/IyeNaTpcUge2k0j8fUz2raqoWSXmOLA+cUof
 wQTq21m1Svd2VUzUWKxvCjYdBa+QpmPWOmrYtPBg0MhBgI63vKp9W0DXRc25ZMaQkNnA
 y1X4lLA2b0547oOuBkn1Fw70HJCC1oK1sYP7zewqeJHO+6D8fm4II4ekoJiuwPs3zNCQ
 bJdjrmjYLN0bXpkfXWSWydvSGt1ONfLmrmISSPUeGAInOWyE8jCa8rZHh0SmUJLIvQTM
 nUNWVZTNp9G9w4W+XnpEX22rPrjz/Mf199dlC6Ke47kaxr6PD1PespZqugHj/yLw6F3Q
 uBsg==
X-Gm-Message-State: AOJu0YyEeHQsUGkfHLndZ9rIrsdrDfb/v8sUrUKPuZnqKiyu0CEWmlCL
 zyBY0pnhnvMGhz9F3ML7lTwuZVyejWqaM097mP0ROmTSkyDla23/kOwKmOgWL7HUDVCI5aOwJHx
 zDDokF1x8oyK0mmh7TNOgG9dRucinPEwWgw2NxkBgnDzdnCsBo1Zv3qhFeLQOO8jzV5F5Is30LD
 kYorj/IrcfQ1zDG7PJNZpZ55drqrDpWHHBhQ==
X-Gm-Gg: Acq92OG3vG51UBCtsrH0voAE9MJYHnaQXV2BeMVdDuvZMiuj5mds4lc2p0flYtptIAJ
 0cW4Msqqkrwt03hv+agLr5NshYbmh0+ghoyfilAP3ejSvnY2/Kg8AVkS2Hr6gGY5YrtN1zaq/wk
 0pmm6UkRDVvvjlpXrYUZuSOxDOB23wgPSAt9nLhlCwMi2YefV82W0LPatWcPG0Yv4dc5lZZtNtZ
 dsFI5iPfF8G/j/CTUWE7/U+Va3nqL80eqvUD99Mmo0LtiyyQooK6boIlMO5/6NlLkowoYPis2rZ
 mTFavMyJQBVWzZtUeEUYtWfVGFlFEhVGcqlUCF6DtH7eJS3FJvrEpg11yTEMnSOu22p2AFaaiqU
 H3l3mDlyBGOBlKipCYidckR6W6ycZ1JFqErcSzRZa6Tg=
X-Received: by 2002:a05:600c:47d1:b0:490:e170:b7ee with SMTP id
 5b1f17b1804b1-492200c04c0mr59651985e9.17.1781464044643; 
 Sun, 14 Jun 2026 12:07:24 -0700 (PDT)
X-Received: by 2002:a05:600c:47d1:b0:490:e170:b7ee with SMTP id
 5b1f17b1804b1-492200c04c0mr59651785e9.17.1781464044067; 
 Sun, 14 Jun 2026 12:07:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea9563b8sm174731045e9.2.2026.06.14.12.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:22 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 037/106] vhost: make vhost_memory_unmap() null-safe
Message-ID: <558084367e9059dbe9f851699cc90be3499ed0fa.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This helps to simplify failure paths of vhost_virtqueue_start()
a lot. We also need to zero-out pointers on unmap, to not try
to unmap invalid pointers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-12-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 131a2fbf87..b9b7a984e3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -473,14 +473,20 @@ static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
     }
 }
 
-static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
+static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
                                hwaddr len, int is_write,
                                hwaddr access_len)
 {
+    if (!*buffer) {
+        return;
+    }
+
     if (!vhost_dev_has_iommu(dev)) {
-        address_space_unmap(dev->vdev->dma_as, buffer, len, is_write,
+        address_space_unmap(dev->vdev->dma_as, *buffer, len, is_write,
                             access_len);
     }
+
+    *buffer = NULL;
 }
 
 static int vhost_verify_ring_part_mapping(void *ring_hva,
@@ -1324,33 +1330,33 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
     if (!vq->desc) {
         r = -ENOMEM;
-        goto fail_alloc_desc;
+        goto fail;
     }
 
     l = vq->avail_size;
     vq->avail = vhost_memory_map(dev, vq->avail_phys, l, false);
     if (!vq->avail) {
         r = -ENOMEM;
-        goto fail_alloc_avail;
+        goto fail;
     }
 
     l = vq->used_size;
     vq->used = vhost_memory_map(dev, vq->used_phys, l, true);
     if (!vq->used) {
         r = -ENOMEM;
-        goto fail_alloc_used;
+        goto fail;
     }
 
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
     if (r < 0) {
-        goto fail_alloc;
+        goto fail;
     }
 
     file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
     r = dev->vhost_ops->vhost_set_vring_kick(dev, &file);
     if (r) {
         VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
-        goto fail_kick;
+        goto fail;
     }
 
     /* Clear and discard previous events if any. */
@@ -1370,24 +1376,19 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
-            goto fail_vector;
+            goto fail;
         }
     }
 
     return 0;
 
-fail_vector:
-fail_kick:
-fail_alloc:
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
+fail:
+    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
                        0, 0);
-fail_alloc_used:
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
                        0, 0);
-fail_alloc_avail:
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
                        0, 0);
-fail_alloc_desc:
     return r;
 }
 
@@ -1434,11 +1435,11 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
                        1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
                        0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
                        0, virtio_queue_get_desc_size(vdev, idx));
     return r;
 }
-- 
MST


