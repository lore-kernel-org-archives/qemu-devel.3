Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ACACD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBx-0005hF-30; Sun, 14 Jun 2026 15:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBv-0005Rp-2N
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBs-00029O-I2
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6w5MPdQ6Q8V00xQPWk2w58F/DB6Chuw3ITEkFRbQpCI=;
 b=PuiuvXR/16EDAg1iel0crbMGvw+TikBV67W1s5LWbFVJOTAlLiua3SBUn+IKZ2E9IH4Jsy
 tvwmpasP+HbAF2VP89ImnD8BD2k0YFBSkYy1fXFtO92G6D0Ocj2OKm8hxGqus625Oe3Exv
 p86b2UBLiX64raDRckjUp/y0pjMaNGw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-XLSI9PgqOieISxxfTLHMtw-1; Sun, 14 Jun 2026 15:08:07 -0400
X-MC-Unique: XLSI9PgqOieISxxfTLHMtw-1
X-Mimecast-MFC-AGG-ID: XLSI9PgqOieISxxfTLHMtw_1781464084
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45f3d008865so2062708f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464084; x=1782068884; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6w5MPdQ6Q8V00xQPWk2w58F/DB6Chuw3ITEkFRbQpCI=;
 b=XQw7f8IJGM1yHHMSgseB6y2BwlFu4IoKCFdQp9h6dekHMfaf5ST4tho49TEwnhX+qj
 mYMU0f3xawmOysJ1R9Ts0k5WTeBL6y514RBFfNCeeZjhRZyd2r4Sg24WnMeQrGwdUhgE
 7Pw5RPzDxmDANv5EGCYY1VtT2Bxk4W/xGgo8SFNpvvC07NatZzTg7BxJ/VLpyIQSnTzx
 KeZGDFEPhHGE/h61LStzFxof83uSO4D/RsPfIiybUozGKjiN/BcvWyO3F+D8m034qnAM
 35M0AMnkLSFiJqnnznSY8XKL4PNMs+rFvFakEdVIujb4glojjTNL5eUwQrn2t5nrTRd+
 vFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464084; x=1782068884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6w5MPdQ6Q8V00xQPWk2w58F/DB6Chuw3ITEkFRbQpCI=;
 b=ZTyq3HkVh0YlYbvy9a4HWJrPY0P8B0Nu4Pp4N1vMmxGco4uWOeb7UfmqtWT1T+GaHx
 zWbU+3Wov2LlRXSCZHAgo4NNHfTYBqA3ZUQ2ETghp8fWrHsMtebwm9Ikumb6Jan786f9
 BNyQAd+ncTmGmefJ6Y15WBpeYsGPZrpBCrtMSdIS67WywrmbK3QwmQp4dr1Ahjb0VqTI
 qCIOVLLGCe2N6xn+bV9mv9BJhVS04rCX5Y3/qIoF3v/euSUArUi288BwX4XreuwfOXHZ
 iAhUXtFd++d5SKNtuCrHU6/7qMFCrk+Ej8RDR0mz1Sj02EJ1Pb1zlOnfwAgAjkgYEdXW
 h9Ow==
X-Gm-Message-State: AOJu0YwGKmkY+Ufp1YvYjYWrNwrU315j3a3RIQw73PURrhWTka45Phon
 5/wkn8jddEv3Fo+YL2uiefllylyTm2L0PSr8E5s/Nve8N+UtEahWn7tbPLRlFPbaHD5ZKU+neid
 rcof/A6r6F+6v3sjSxVA4NBjkcvL4NMCKGAldT0PEVVbMCcRi1+JXkaDhHonFK6M50lSoE8GcPj
 rEhJttS8NDezUDXH/6iR3jZxHWqeUe4SB6zQ==
X-Gm-Gg: Acq92OES4Um8tvf9DCGmbcvFdUAWfKjDmyLR46NQm4ZQ2NkwQZHji4R0fnbhwNdmKwi
 ihmG51jEHFFyC3kj7P0E6S1b1Wf1Gif4xNWUjHqBbBlN8ETozv48ylM/VHpMFL2S2J/GSQaAF0G
 TxtR3AIVReYT16PAEFZJnmF8dMFDiIYv3B2YADudNImE5FFrtLESPi2D/EJ0AnamncRxeegxwAk
 O9Ls3Gl3gplQtt9d4ZNXdD+RivfxxZHZkCBGk9pP65CQncQZa95v/Paa+Rj00sYXkF97P/JS4YL
 j0slPchkLO0CgK34r5Q/w8m9YLiP1fDNYn8Vxl2/uqY6e6m0R2eovnp0+8D5ZKW72qbtihYQEV4
 Yg2DeBuEYLlmTjM5dAzQv9RPgpSC+B70m4+FIEMdHRww=
X-Received: by 2002:a5d:5f41:0:b0:460:11a7:f82e with SMTP id
 ffacd0b85a97d-4606cb29f5fmr12171302f8f.8.1781464084163; 
 Sun, 14 Jun 2026 12:08:04 -0700 (PDT)
X-Received: by 2002:a5d:5f41:0:b0:460:11a7:f82e with SMTP id
 ffacd0b85a97d-4606cb29f5fmr12171274f8f.8.1781464083711; 
 Sun, 14 Jun 2026 12:08:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm27904086f8f.11.2026.06.14.12.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:03 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 053/106] vhost: simplify vhost_memory_map() and
 vhost_memory_unmap()
Message-ID: <846a29de2bd2a299acf54af2169c14b52fba6706.1781463125.git.mst@redhat.com>
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

Make these functions simple wrappers around address_space_map() and
address_space_unmap(). Move IOMMU handling logic one layer up to the
callers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-6-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 564a5d4698..cc083572f4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -456,21 +456,17 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                               hwaddr len, bool is_write)
 {
-    if (!vhost_dev_has_iommu(dev)) {
-        hwaddr mapped_len = len;
-        void *res = address_space_map(dev->vdev->dma_as, addr, &mapped_len,
-                                      is_write, MEMTXATTRS_UNSPECIFIED);
-        if (!res) {
-            return NULL;
-        }
-        if (len != mapped_len) {
-            address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0);
-            return NULL;
-        }
-        return res;
-    } else {
-        return (void *)(uintptr_t)addr;
+    hwaddr mapped_len = len;
+    void *res = address_space_map(dev->vdev->dma_as, addr, &mapped_len,
+                                  is_write, MEMTXATTRS_UNSPECIFIED);
+    if (!res) {
+        return NULL;
     }
+    if (len != mapped_len) {
+        address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0);
+        return NULL;
+    }
+    return res;
 }
 
 static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
@@ -481,17 +477,18 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
         return;
     }
 
-    if (!vhost_dev_has_iommu(dev)) {
-        address_space_unmap(dev->vdev->dma_as, *buffer, len, is_write,
-                            access_len);
-    }
-
+    address_space_unmap(dev->vdev->dma_as, *buffer, len, is_write,
+                        access_len);
     *buffer = NULL;
 }
 
 static void vhost_vrings_unmap(struct vhost_dev *dev,
                                struct vhost_virtqueue *vq, bool touched)
 {
+    if (vhost_dev_has_iommu(dev)) {
+        return;
+    }
+
     vhost_memory_unmap(dev, &vq->used, vq->used_size, touched,
                        touched ? vq->used_size : 0);
     vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0,
@@ -519,6 +516,14 @@ static int vhost_vrings_map(struct vhost_dev *dev,
         /* Queue might not be ready for start */
         return 0;
     }
+
+    if (vhost_dev_has_iommu(dev)) {
+        vq->desc = (void *)(uintptr_t)vq->desc_phys;
+        vq->avail = (void *)(uintptr_t)vq->avail_phys;
+        vq->used = (void *)(uintptr_t)vq->used_phys;
+        return 1;
+    }
+
     vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
     if (!vq->desc) {
         goto fail;
-- 
MST


