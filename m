Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C44C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpSnt-0007n5-Ei; Thu, 30 Jul 2026 11:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpSnr-0007mv-Vd
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpSnq-0003hg-EN
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785425769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bfd31Yj1FDZaxqXqNrgQSKke7QTjPVjn1zrtiq2q5Lw=;
 b=eTeLvV6Cqy8OZXz2kRXMF7NeRtzdIgzqi4fPjziLiJoESDq8rJfgZh7sATACP2+vV4Nf+v
 eq+jV/Cvwt+DyzzAQtg+kKSt8v4uwTJDKOng5j/YF/U1TjpHZ0dnPIJooZJplnxnC1zTLX
 QV8C+UJIDSKbgJvT3qIGV1nlwtF57D0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-ZMOT5RquPmSewOADC3QX9g-1; Thu,
 30 Jul 2026 11:36:07 -0400
X-MC-Unique: ZMOT5RquPmSewOADC3QX9g-1
X-Mimecast-MFC-AGG-ID: ZMOT5RquPmSewOADC3QX9g_1785425766
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 748F319560B4; Thu, 30 Jul 2026 15:36:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.178])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEC6141C; Thu, 30 Jul 2026 15:36:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtio: make virtio_add_queue() queue_size an unsigned int
Date: Thu, 30 Jul 2026 11:36:04 -0400
Message-ID: <20260730153604.1462722-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

virtio_add_queue()'s queue_size argument is a signed int. Coverity is
unhappy when that type is used as an argument to g_new0():

  *** CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
  /builds/qemu-project/qemu/hw/virtio/virtio.c: 2595             in virtio_add_queue()
  2589         }
  2590
  2591         vdev->vq[i].vring.num = queue_size;
  2592         vdev->vq[i].vring.num_default = queue_size;
  2593         vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
  2594         vdev->vq[i].handle_output = handle_output;
  >>>     CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
  >>>     "__n" is passed to a parameter that cannot be negative.
  2595         vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);

The vdev->vq[i].vring.num and num_default fields are already declared as
unsigned int, so change the virtio_add_queue() argument's type for
consistency.

A note on consistency: the VIRTIO specification defines queue size as an
unsigned 16-bit value. QEMU's device models variously use uint16_t,
uint32_t, and other unsigned types for queue size qdev properties.
virtio_add_queue() limits queue size to the much smaller
VIRTQUEUE_MAX_SIZE (1024) constant, so the different widths don't really
matter.

I have checked that all callers of virtio_add_queue() pass an unsigned
queue size.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio.h | 2 +-
 hw/virtio/virtio.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c99cb19d886..ff7f837fb92 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -302,7 +302,7 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
 
 typedef void (*VirtIOHandleOutput)(VirtIODevice *, VirtQueue *);
 
-VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
+VirtQueue *virtio_add_queue(VirtIODevice *vdev, unsigned int queue_size,
                             VirtIOHandleOutput handle_output);
 
 void virtio_del_queue(VirtIODevice *vdev, int n);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index daa5607338c..e1210f024c6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2564,7 +2564,7 @@ void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector)
     }
 }
 
-VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
+VirtQueue *virtio_add_queue(VirtIODevice *vdev, unsigned int queue_size,
                             VirtIOHandleOutput handle_output)
 {
     int i;
-- 
2.55.0


