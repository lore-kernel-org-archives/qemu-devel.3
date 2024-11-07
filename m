Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96384D4335D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92QU-0002LK-TL; Thu, 07 Nov 2024 08:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t92QT-0002Ku-D9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t92QQ-0001pD-Mu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730985588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kPjm09A6VYt3abIPkEfD2GHBoQhl8yI2rup48YCcxZc=;
 b=iM0eZDs4GKJ9wADKm6EsjX2vHt3zGEL/OI9AV85eIpS86NlgsV37nWcJhEn8fGBlKfRysK
 WlKnT2KzKpRyqghLYL1MSrXhdpuHxC3l+fRQgjyR7SyG3gIqhV4mIbhQVLpTPvp5dFKfdN
 3cKpPceAvVDvNMXt70lsEpIVTlF/J44=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-tosVm9ytPYO9R0krepUB9A-1; Thu, 07 Nov 2024 08:19:47 -0500
X-MC-Unique: tosVm9ytPYO9R0krepUB9A-1
X-Mimecast-MFC-AGG-ID: tosVm9ytPYO9R0krepUB9A
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so544725f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730985586; x=1731590386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPjm09A6VYt3abIPkEfD2GHBoQhl8yI2rup48YCcxZc=;
 b=k9e9CCiNb/uZ4TPUcvM2N1yo/lJLtmn/xoI/2JjyMeJbWOY8RyI44JvEvanQYkFsNO
 1I2Kl75KMVQ/mtHoQz3sQV2wCJDhtn/wMwGuEihR3tvBWPbriAFfnp1euGUK6eK6VX5j
 RjnUUTjdinGmKFKrkPFGXrXKLpHdn2rsrXkxSa8yrMozDMrnTYgnaD0gRYqg6BGydRYX
 jDcO+mEiY36hSrC8i7sq+TfjSaE1lReff6KJOJ3CC+jQEETEjtCNafXqH4dUevDczcsz
 0fi/kZEiTEPrIoePmDAkiQb0kNql1ak01O9cL7h1OFrn9eZqdwq3fHBBsJ+4faGe+zHL
 DrgA==
X-Gm-Message-State: AOJu0YzHB5B8IlA7v6v++RDGjGWau+VznvbzNA0XVEKsZqLv3jJw7TC3
 ptNNfBQ/m9qIvn+UL+ZxNsjbYTVuZVSqaEGPtEz+DNuDlj7nZKcArG42YghVmMSbFJSsToXIN3N
 FJZdS1TUPX+324apWUJq7xyfPnphxINQAmxpWuJOSo1Z7LeBFcZvn
X-Received: by 2002:a5d:64ad:0:b0:37c:d569:97b with SMTP id
 ffacd0b85a97d-381c7a5dbfbmr20334455f8f.19.1730985586237; 
 Thu, 07 Nov 2024 05:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgP0nP7is9SaY3KmhspPJd8bHqfuvjjf5UqMWHn+n61h/cjaYhuUBOcMlcpMdxb0/FSTpBUA==
X-Received: by 2002:a5d:64ad:0:b0:37c:d569:97b with SMTP id
 ffacd0b85a97d-381c7a5dbfbmr20334424f8f.19.1730985585572; 
 Thu, 07 Nov 2024 05:19:45 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970d4fsm1754469f8f.5.2024.11.07.05.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 05:19:45 -0800 (PST)
Date: Thu, 7 Nov 2024 14:19:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, eperezma@redhat.com, 
 mst@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1] vhost: fail device start if iotlb update fails
Message-ID: <swjwrfk6c3oz6fooobif6oxze4wyavfilfquzhmitltxbvg5sk@cwocepj5fwz7>
References: <20241107113247.46532-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241107113247.46532-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 07, 2024 at 05:02:47PM +0530, Prasad Pandit wrote:
>From: Prasad Pandit <pjp@fedoraproject.org>
>
>While starting a vhost device, updating iotlb entries
>via 'vhost_device_iotlb_miss' may return an error.
>
>  qemu-kvm: vhost_device_iotlb_miss:
>    700871,700871: Fail to update device iotlb
>
>Fail device start when such an error occurs.
>
>Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
>---
> hw/virtio/vhost.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
>v1:
> - Remove VHOST_OPS_DEBUG call.
> - Call vhost_set_iotlb_callback and vhost_dev_start with 'false' argument.

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>v0:
> - https://lore.kernel.org/qemu-devel/20241105060053.61973-1-ppandit@redhat.com/
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 76f9b2aaad..c40f48ac4d 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -2095,11 +2095,22 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>          * vhost-kernel code requires for this.*/
>         for (i = 0; i < hdev->nvqs; ++i) {
>             struct vhost_virtqueue *vq = hdev->vqs + i;
>-            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
>+            r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
>+            if (r) {
>+                goto fail_iotlb;
>+            }
>         }
>     }
>     vhost_start_config_intr(hdev);
>     return 0;
>+fail_iotlb:
>+    if (vhost_dev_has_iommu(hdev) &&
>+        hdev->vhost_ops->vhost_set_iotlb_callback) {
>+        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
>+    }
>+    if (hdev->vhost_ops->vhost_dev_start) {
>+        hdev->vhost_ops->vhost_dev_start(hdev, false);
>+    }
> fail_start:
>     if (vrings) {
>         vhost_dev_set_vring_enable(hdev, false);
>--
>2.47.0
>


