Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBABC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 07:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHdtW-0008Dq-7K; Wed, 21 May 2025 03:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHdtU-0008D5-3t
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHdtR-000136-Rg
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747812575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uKhbBuqc70it5xk80+luwbcUq9MImIgT5up/B+STr/E=;
 b=Df6zgRG8qaLbsAnaHnYDUNrFuUONIzsejOIv5p0KB9aZ730IHPKh2JtLBMvUL6R7uoG7Oi
 ujjz/AsDiU7l0yM2GWJFxie7JpG99SnOOXlSLD/4Tgu7PV9XQqG+b5mLnfk+ZySHsyYF3a
 GdcZkLR4ijyI0j9PhNAxz+j/YuIM7wo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-pOH4uBnYN6maMCKLtI-YPA-1; Wed, 21 May 2025 03:29:33 -0400
X-MC-Unique: pOH4uBnYN6maMCKLtI-YPA-1
X-Mimecast-MFC-AGG-ID: pOH4uBnYN6maMCKLtI-YPA_1747812572
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a36e6b7404so2054188f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 00:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747812572; x=1748417372;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKhbBuqc70it5xk80+luwbcUq9MImIgT5up/B+STr/E=;
 b=xJG//keWk3XfOkmaqXOAa/U7IDlQdIXJ+YnEcctPfk4dD+b4H9U0DS/hhblebPPObX
 wDKVRj3ckmSU9Toge8IcBWR6TN05IyVixrkjulvexhBoPoVfoPUO6diYZUa6A+cBjdjr
 lUXFBw8Kn/loO4FQ65jCGglIyj+ogN9ELXVWh8SqP756wRJRPvPrsMlmPzFNzrWVvoeF
 GNIB86FlWHxFZy8e3MySUsdhtW0pUKyn+n4ucCr7pRbrvEltFAqBcpQVHfSca8P9YDLY
 pB4IW2WUqMPtt0icSKlu1SjYHxkOQHeJQciv3fe2xT7bPK23CAYuqPAtArvO8pe1at12
 bzLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsfP4G4KLw3/1OTyvXT2JfvRR2hwZfJVMTCbmnV8ejISXTu5DKxdx5XXYziHvvbF4FfdiGZuYWQBU3@nongnu.org
X-Gm-Message-State: AOJu0YwWzGWDD67SU+yfPf/rTTGNM7Ez7CC4k3tTIXwDTsKudpnLAQ15
 glcoNcgQSNLwY4/3w3JIZYElXuevtFQkyPsPoYYGinzaVh5eE/wBOX+UK6a6qsjhIcnkQKGPDUA
 9tFGSyaLBRkbSyi9bpSU93Mv1z5Kd7w98CfxPuXcsfw4PNt9mpJHe8v+k
X-Gm-Gg: ASbGncvmm8l4yV2Z3h9Ex8HuygPhcDo7Cx2Jsv0kk3sU6ozC5DOesRxTniW89KJ3nw9
 ZYUaxzDyxCnthJlsG+iNomp/ssc80rvfZr8vXJtlNeyf65HJMowwTWbw87i9QytoAi/kD/ACQTc
 d6CjQ0tbhetmug+V+93ufO50kcSu16l5ZrMzTgOLf7FDmzDV3w/11V7zpfuGOxOzNlJ30prVwnk
 FGHDRHKyBmEQ70jwR75WCvtgSUUf0HJLKrZ5IrX0D5/gX3KXmvnSGfck296n9zZ3L5F7jujbwLl
 3EGRN+mKxCKGMr70QyAPS7y9tYz0r1Czzp6O++JpVpv66aSBrA==
X-Received: by 2002:a05:6000:230f:b0:3a3:7749:9783 with SMTP id
 ffacd0b85a97d-3a37749987bmr7180737f8f.51.1747812572328; 
 Wed, 21 May 2025 00:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSTqxcCI1UlaJKEIVUTtEJekF1p7L78VMP+imBN9dr80kAFitgR4p6nG+7em6isRNDNlAjkw==
X-Received: by 2002:a05:6000:230f:b0:3a3:7749:9783 with SMTP id
 ffacd0b85a97d-3a37749987bmr7180695f8f.51.1747812571716; 
 Wed, 21 May 2025 00:29:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35e49262fsm18261125f8f.44.2025.05.21.00.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 00:29:31 -0700 (PDT)
Message-ID: <19e2b44d-0dcc-424a-904d-a7519e25d93e@redhat.com>
Date: Wed, 21 May 2025 09:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] vfio: enable per-IRQ MSI-X masking
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Steven Sistare <steven.sistare@oracle.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-7-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250520150419.2172078-7-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+Sẗeven

On 5/20/25 17:03, John Levon wrote:
> If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
> this in ->can_mask_msix, and use it to individually mask MSI-X
> interrupts as needed.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>


This one conflicts with the "live update" series. We will address it later.


Thanks,

C.



> ---
>   hw/vfio/pci.h                 |  1 +
>   include/hw/vfio/vfio-device.h |  2 ++
>   hw/vfio/device.c              | 26 +++++++++++++++++++
>   hw/vfio/pci.c                 | 47 ++++++++++++++++++++++++++++++-----
>   4 files changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 61fa385ddb..43c2d72b84 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -191,6 +191,7 @@ struct VFIOPCIDevice {
>       bool defer_kvm_irq_routing;
>       bool clear_parent_atomics_on_exit;
>       bool skip_vsc_check;
> +    bool can_mask_msix;
>       VFIODisplay *dpy;
>       Notifier irqchip_change_notifier;
>   };
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 8bcb3c19f6..923f9cd116 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -133,7 +133,9 @@ struct VFIODeviceOps {
>       (ret < 0 ? strerror(-ret) : "short write")
>   
>   void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
> +void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq);
>   void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
> +void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq);
>   void vfio_device_irq_mask(VFIODevice *vbasedev, int index);
>   bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex,
>                                      int action, int fd, Error **errp);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 9fba2c7272..d0068086ae 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -85,6 +85,19 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
>       vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
> +void vfio_device_irq_unmask_single(VFIODevice *vbasedev, int index, int irq)
> +{
> +    struct vfio_irq_set irq_set = {
> +        .argsz = sizeof(irq_set),
> +        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
> +        .index = index,
> +        .start = irq,
> +        .count = 1,
> +    };
> +
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
> +}
> +
>   void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
>   {
>       struct vfio_irq_set irq_set = {
> @@ -98,6 +111,19 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
>       vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
> +void vfio_device_irq_mask_single(VFIODevice *vbasedev, int index, int irq)
> +{
> +    struct vfio_irq_set irq_set = {
> +        .argsz = sizeof(irq_set),
> +        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
> +        .index = index,
> +        .start = irq,
> +        .count = 1,
> +    };
> +
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
> +}
> +
>   void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
>   {
>       struct vfio_irq_set irq_set = {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5159198bdb..ef38b4692a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -535,6 +535,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector;
> +    bool new_vec = false;
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>   
> @@ -549,6 +550,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>               error_report("vfio: Error: event_notifier_init failed");
>           }
>           vector->use = true;
> +        new_vec = true;
>           msix_vector_use(pdev, nr);
>       }
>   
> @@ -575,6 +577,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                   kvm_irqchip_commit_route_changes(&vfio_route_change);
>                   vfio_connect_kvm_msi_virq(vector);
>               }
> +            new_vec = true;
>           }
>       }
>   
> @@ -584,6 +587,9 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>        * in use, so we shutdown and incrementally increase them as needed.
>        * nr_vectors represents the total number of vectors allocated.
>        *
> +     * Otherwise, unmask the vector if the vector is already setup (and we can
> +     * do so) or send the fd if not.
> +     *
>        * When dynamic allocation is supported, let the host only allocate
>        * and enable a vector when it is in use in guest. nr_vectors represents
>        * the upper bound of vectors being enabled (but not all of the ranges
> @@ -594,13 +600,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       }
>   
>       if (!vdev->defer_kvm_irq_routing) {
> -        if (vdev->msix->noresize && resizing) {
> -            vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
> -            ret = vfio_enable_vectors(vdev, true);
> -            if (ret) {
> -                error_report("vfio: failed to enable vectors, %s",
> -                             strerror(-ret));
> +        if (resizing) {
> +            if (vdev->msix->noresize) {
> +                vfio_device_irq_disable(&vdev->vbasedev,
> +                                        VFIO_PCI_MSIX_IRQ_INDEX);
> +                ret = vfio_enable_vectors(vdev, true);
> +                if (ret) {
> +                    error_report("vfio: failed to enable vectors, %d", ret);
> +                }
> +            } else {
> +                set_irq_signalling(&vdev->vbasedev, vector, nr);
>               }
> +        } else if (vdev->can_mask_msix && !new_vec) {
> +            vfio_device_irq_unmask_single(&vdev->vbasedev,
> +                                          VFIO_PCI_MSIX_IRQ_INDEX, nr);
>           } else {
>               set_irq_signalling(&vdev->vbasedev, vector, nr);
>           }
> @@ -630,6 +643,13 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>   
>       trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
>   
> +    /* just mask vector if peer supports it */
> +    if (vdev->can_mask_msix) {
> +        vfio_device_irq_mask_single(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                    nr);
> +        return;
> +    }
> +
>       /*
>        * There are still old guests that mask and unmask vectors on every
>        * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
> @@ -702,6 +722,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>               error_report("vfio: failed to enable vectors, %s",
>                            strerror(-ret));
>           }
> +    } else if (vdev->can_mask_msix) {
> +        /*
> +         * If we can use single irq masking, send an invalid fd on vector 0
> +         * to enable MSI-X without any vectors enabled.
> +         */
> +        vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                      0, VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
>       } else {
>           /*
>            * Some communication channels between VF & PF or PF & fw rely on the
> @@ -2842,6 +2869,14 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           }
>       }
>   
> +    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                   &irq_info);
> +    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
> +        vdev->can_mask_msix = true;
> +    } else {
> +        vdev->can_mask_msix = false;
> +    }
> +
>       ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
>       if (ret) {
>           /* This can fail for an old kernel or legacy PCI dev */


