Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B986C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkU-000613-TZ; Sun, 21 Jul 2024 20:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkQ-0005Z3-Vc
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkP-0005nh-02
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qh9R5tJPsU6nQaE9x9stYdkZI3361sYm/2KiRgpRciY=;
 b=c54RqwRuQpaNNIXdoFJQ/SHjNekZ0ywyuU+vaZnk5tVQA56PENBz+TpNAxqS+5V/KvrKpl
 naa71TYl4as7IwJjDLSdbEnQsQsmgari59eMhlPKQrPBiJ6w0q4mwiMMycnbYyWJc/ehWh
 GQ+4QlrAudTadobVE1TnUw6JTa24iDw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-hVi_YfOnM_e9a_IX8GAmCw-1; Sun, 21 Jul 2024 20:17:45 -0400
X-MC-Unique: hVi_YfOnM_e9a_IX8GAmCw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36831873b39so1861898f8f.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607464; x=1722212264;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qh9R5tJPsU6nQaE9x9stYdkZI3361sYm/2KiRgpRciY=;
 b=cdRGnErZJBDmLBhKqb2mppWU214kABYng8PB1+IhV/Z3OIhE1coyMcbPOm01u7s38v
 LbuQRvXpu2SOYkLyAgHZkg9ZiCDgyISVMFx4ahnOwgiOVocXgOg8tK/u6UGxKgq2tz1B
 yLiu2Z1UK5ieoTolSFn3CRzH6/pyzM4ykgW/vR/2EofsRVRsoEGX0ylk3fENrUhqZU2u
 m/IMT/7J77Q6C+k0cxfrPnddRas6B+FaBsxBHJzWADIYn3Eeb+itsnJGXukM8Udtdck4
 +tkSjwHayLHfgPyt+qAflV5EOpuTEXyYjkkGeQ5Ss6NyhMAV1MIV66ng7/+A4XXgm+ws
 OOng==
X-Gm-Message-State: AOJu0YybcIZH1fhnXEYcR9QzGXWFZHaWdkWAkN2DF7Jjm+5CxOvqsHTi
 woBxlKGr3iSWsRovnq3u5F3Az14VvsIYNbftrEXu5/oCGn2IFQ6WqyosQTKWo7ZVS7AUmKnLy3m
 Dyay9lK3i9q/fL1+tj7gvVHNDMjmYytOP/XzhmofHEy9eW3y3AjNSAO00EuoLldXSMDfeYV87WS
 Em/KkCyGa3vsLQWCfsnjyctCEV1VYTnA==
X-Received: by 2002:a5d:5441:0:b0:368:37d5:3f2e with SMTP id
 ffacd0b85a97d-36837d53fdcmr8248834f8f.32.1721607464433; 
 Sun, 21 Jul 2024 17:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjcErND1fbND0ixpQbnVRCuRdnwW/Dwtjo26+SmsSamirHgBekXhlee7K8TbSQke9dxftQLQ==
X-Received: by 2002:a5d:5441:0:b0:368:37d5:3f2e with SMTP id
 ffacd0b85a97d-36837d53fdcmr8248823f8f.32.1721607463652; 
 Sun, 21 Jul 2024 17:17:43 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced33sm7052068f8f.86.2024.07.21.17.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:43 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 25/63] virtio: virtqueue_ordered_flush - VIRTIO_F_IN_ORDER
 support
Message-ID: <844619147c5110f335cbbbad51cda6a898c7ef33.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add VIRTIO_F_IN_ORDER feature support for the virtqueue_flush operation.

The goal of the virtqueue_ordered_flush operation when the
VIRTIO_F_IN_ORDER feature has been negotiated is to write elements to
the used/descriptor ring in-order and then update used_idx.

The function iterates through the VirtQueueElement used_elems array
in-order starting at vq->used_idx. If the element is valid (filled), the
element is written to the used/descriptor ring. This process continues
until we find an invalid (not filled) element.

For packed VQs, the first entry (at vq->used_idx) is written to the
descriptor ring last so the guest doesn't see any invalid descriptors.

If any elements were written, the used_idx is updated.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-5-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/virtio.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0000a7b41c..397c261c3c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1023,6 +1023,73 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
     }
 }
 
+static void virtqueue_ordered_flush(VirtQueue *vq)
+{
+    unsigned int i = vq->used_idx % vq->vring.num;
+    unsigned int ndescs = 0;
+    uint16_t old = vq->used_idx;
+    uint16_t new;
+    bool packed;
+    VRingUsedElem uelem;
+
+    packed = virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED);
+
+    if (packed) {
+        if (unlikely(!vq->vring.desc)) {
+            return;
+        }
+    } else if (unlikely(!vq->vring.used)) {
+        return;
+    }
+
+    /* First expected in-order element isn't ready, nothing to do */
+    if (!vq->used_elems[i].in_order_filled) {
+        return;
+    }
+
+    /* Search for filled elements in-order */
+    while (vq->used_elems[i].in_order_filled) {
+        /*
+         * First entry for packed VQs is written last so the guest
+         * doesn't see invalid descriptors.
+         */
+        if (packed && i != vq->used_idx) {
+            virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
+        } else if (!packed) {
+            uelem.id = vq->used_elems[i].index;
+            uelem.len = vq->used_elems[i].len;
+            vring_used_write(vq, &uelem, i);
+        }
+
+        vq->used_elems[i].in_order_filled = false;
+        ndescs += vq->used_elems[i].ndescs;
+        i += vq->used_elems[i].ndescs;
+        if (i >= vq->vring.num) {
+            i -= vq->vring.num;
+        }
+    }
+
+    if (packed) {
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[vq->used_idx], 0, true);
+        vq->used_idx += ndescs;
+        if (vq->used_idx >= vq->vring.num) {
+            vq->used_idx -= vq->vring.num;
+            vq->used_wrap_counter ^= 1;
+            vq->signalled_used_valid = false;
+        }
+    } else {
+        /* Make sure buffer is written before we update index. */
+        smp_wmb();
+        new = old + ndescs;
+        vring_used_idx_set(vq, new);
+        if (unlikely((int16_t)(new - vq->signalled_used) <
+                     (uint16_t)(new - old))) {
+            vq->signalled_used_valid = false;
+        }
+    }
+    vq->inuse -= ndescs;
+}
+
 void virtqueue_flush(VirtQueue *vq, unsigned int count)
 {
     if (virtio_device_disabled(vq->vdev)) {
@@ -1030,7 +1097,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
-    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
+        virtqueue_ordered_flush(vq);
+    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
         virtqueue_packed_flush(vq, count);
     } else {
         virtqueue_split_flush(vq, count);
-- 
MST


