Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B5FC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuv5p-0005j5-5e; Wed, 19 Mar 2025 11:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tuv5j-0005gW-4V
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tuv5K-0005k2-5h
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742397113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crypJv0CMqxByWZJCUH/GnYCaNICZJQResmY26YAb94=;
 b=FIA7Ue9KXp9lmH+aB0pxDdHS2PdXYmCpoiEC09eBJrJzzOGuShXIi4tx36SdH9XTEIlAyf
 kkVkAzGsy1O0GsOTHOW2jkbsBqi22l9c5LT4xTQJ882Qi7OihvjwSQdmAZcN5vUyX7/t3W
 wGT3+XlMbQMILSweAkHMClC8idzpUC0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-5fey_PBaM9mop_fT5aCITA-1; Wed, 19 Mar 2025 11:11:50 -0400
X-MC-Unique: 5fey_PBaM9mop_fT5aCITA-1
X-Mimecast-MFC-AGG-ID: 5fey_PBaM9mop_fT5aCITA_1742397110
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so96193466b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 08:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742397110; x=1743001910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crypJv0CMqxByWZJCUH/GnYCaNICZJQResmY26YAb94=;
 b=wv8uPtAyIn84UM5ZPCtOeMdDdsYWqffxugssYyN+fjqMU79HATdCpHj6WNZu1TixNE
 CMl18F/FlgtoX9wcK2j/AMcsj4RERfIWs+NDLgqIwdHxnz82oM0h/mz0zhsUZRt0Vdnr
 DEZxtnRqQBXrc3hwwO0AMdO/LDOKGZ61YIr1GizQFzQm69Bu34BJkjXnxLFQqbN/B/jP
 782H2jN/0DWnAI//nCv3izESSdKJIST2cso0r7ufG9mImyBxFfQCI4lRFbsLYHOoeJux
 1seUxnT5HeaxjmIkGFX2N9MNr9X6mmvJoeMZqIdog4XyxpdCW7TOUrHb7G/2nBzJ9hED
 i2SA==
X-Gm-Message-State: AOJu0Ywf/3czCBdaaSVGaBOu8qGYR62nm2PzRgthE6zvLxq/SMHjded9
 eOcW2NgDcHiZFSR+PFc6gmYPfPVScSRiD6prW6I22/uYrK0PEkHM8w514farY6uNX7WKzallESz
 cfixv5W+Qql+YWnbuLq91H8knoRNxeRZIQeNfnaxIPYRPjwTDfD7R
X-Gm-Gg: ASbGncuT8xQz3KhjsNQbB+g5YDoa1gNLbV6dkomjsjsAEoCRVJrtxB3CgFPc/pqkaxY
 RTHLbd9xjlc0DvKPOOr10AogaWARL1qYRpvW7YUPr+PVZsD8t9HCLqSnSpvZHz1NwllU8WBqVDr
 1RiFyuUR7UDyd/yk4lL2EHvtd9yRRT5iIWRqY++6K5AAOQv92+A6tXW2SOhw/DifqLU1VITlrcK
 UdyG+16Bq57tGdAWmCRqDXzl7sAK5XECJI4dln/UEx2BdijrekmgDv9/X/+OsO9hiSg7SQC4p05
 EyoViFr5gjFI2MOO9uInKLhhCtg5A+D7HM0VqtMEiZu3AINU/oRPFbesbLQWOw==
X-Received: by 2002:a17:906:d7cc:b0:ac3:c171:32b1 with SMTP id
 a640c23a62f3a-ac3c1713a7emr214820266b.10.1742397109606; 
 Wed, 19 Mar 2025 08:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7UQUI/XnIkiY83WMe2k8FgGXa3GpaS/HWtLc+sk9jyRRRShhGUhOLFxK1dKz8XBBGDb9vFQ==
X-Received: by 2002:a17:906:d7cc:b0:ac3:c171:32b1 with SMTP id
 a640c23a62f3a-ac3c1713a7emr214812466b.10.1742397108820; 
 Wed, 19 Mar 2025 08:11:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-53.retail.telecomitalia.it.
 [79.53.30.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a462basm1027038766b.133.2025.03.19.08.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 08:11:48 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:11:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, fengli@smartx.com, yuhua@smartx.com, 
 Raphael Norwitz <raphael@enfabrica.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/3] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
Message-ID: <ho2s47wmeqgeh6otsx4ttqdy3zudgehkokth2ccubsoywzvqhp@mv45e5do5rj7>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-3-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250314101535.1059308-3-haoqian.he@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 14, 2025 at 06:15:33AM -0400, Haoqian He wrote:
>The backend maybe crash when vhost_dev_stop and GET_VRING_BASE
>would fail, we can return failure to indicate the connection
>with the backend is broken.
>
>Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>---
> hw/virtio/vhost.c         | 27 +++++++++++++++------------
> include/hw/virtio/vhost.h |  8 +++++---
> 2 files changed, 20 insertions(+), 15 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 6aa72fd434..c82bbbe4cc 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1368,23 +1368,23 @@ fail_alloc_desc:
>     return r;
> }
>
>-void vhost_virtqueue_stop(struct vhost_dev *dev,
>-                          struct VirtIODevice *vdev,
>-                          struct vhost_virtqueue *vq,
>-                          unsigned idx)
>+int vhost_virtqueue_stop(struct vhost_dev *dev,
>+                         struct VirtIODevice *vdev,
>+                         struct vhost_virtqueue *vq,
>+                         unsigned idx)
> {
>     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
>     struct vhost_vring_state state = {
>         .index = vhost_vq_index,
>     };
>-    int r;
>+    int r = 0;
>
>     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
>         /* Don't stop the virtqueue which might have not been started */
>-        return;
>+        return 0;
>     }
>
>-    r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>+    r |= dev->vhost_ops->vhost_get_vring_base(dev, &state);

We can avoid this and also initialize r to 0.

>     if (r < 0) {
>         VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
>         /* Connection to the backend is broken, so let's sync internal
>@@ -1412,6 +1412,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
>                        0, virtio_queue_get_avail_size(vdev, idx));
>     vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
>                        0, virtio_queue_get_desc_size(vdev, idx));
>+    return r;
> }
>
> static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
>@@ -2136,9 +2137,10 @@ fail_features:
> }
>
> /* Host notifiers must be enabled at this point. */
>-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
> {
>     int i;
>+    int rc = 0;
>
>     /* should only be called after backend is connected */
>     assert(hdev->vhost_ops);
>@@ -2157,10 +2159,10 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>         vhost_dev_set_vring_enable(hdev, false);
>     }
>     for (i = 0; i < hdev->nvqs; ++i) {
>-        vhost_virtqueue_stop(hdev,
>-                             vdev,
>-                             hdev->vqs + i,
>-                             hdev->vq_index + i);
>+        rc |= vhost_virtqueue_stop(hdev,
>+                                   vdev,
>+                                   hdev->vqs + i,
>+                                   hdev->vq_index + i);

Also other function can fails, should we consider also them?
(e.g. vhost_dev_start, vhost_dev_set_vring_enable, etc.)

If not, why?

>     }
>     if (hdev->vhost_ops->vhost_reset_status) {
>         hdev->vhost_ops->vhost_reset_status(hdev);
>@@ -2177,6 +2179,7 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>     hdev->started = false;
>     vdev->vhost_started = false;
>     hdev->vdev = NULL;
>+    return rc;
> }
>
> int vhost_net_set_backend(struct vhost_dev *hdev,
>diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>index a9469d50bc..fd96ec9c39 100644
>--- a/include/hw/virtio/vhost.h
>+++ b/include/hw/virtio/vhost.h
>@@ -232,8 +232,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
>  * Stop the vhost device. After the device is stopped the notifiers
>  * can be disabled (@vhost_dev_disable_notifiers) and the device can
>  * be torn down (@vhost_dev_cleanup).
>+ *
>+ * Return: 0 on success, != 0 on error when stopping dev.
>  */
>-void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
>+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
>
> /**
>  * DOC: vhost device configuration handling
>@@ -333,8 +335,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
>
> int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
>                           struct vhost_virtqueue *vq, unsigned idx);
>-void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
>-                          struct vhost_virtqueue *vq, unsigned idx);
>+int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
>+                         struct vhost_virtqueue *vq, unsigned idx);
>
> void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
> void vhost_dev_free_inflight(struct vhost_inflight *inflight);
>-- 
>2.48.1
>


