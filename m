Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F57DC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKfS-0001r7-7Z; Fri, 09 May 2025 06:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKfO-0001QF-HS
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKfM-0001GG-97
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746785355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fOBX2mkQl2KEqLmo2nN8AZM005hvP8yT+wwHmgPjMP8=;
 b=HXyEIweXiFVQF7Marn8hCar8+I2bHTdoVWOgZ4fmW6fNt3Q7Ex5sp2Amvjhg7sVB3BusDd
 A2YFWOeTBrqY8IUsDLKn7IyuWdfIQmcNYddt0snLPI6vZJAqo02RDhw+zCCleJkDE3l9fH
 JpTx696tQmNI06UZlqy7FyVyB+5weEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-Q9HmLXU_MhylTM1eMROAtA-1; Fri, 09 May 2025 06:09:13 -0400
X-MC-Unique: Q9HmLXU_MhylTM1eMROAtA-1
X-Mimecast-MFC-AGG-ID: Q9HmLXU_MhylTM1eMROAtA_1746785353
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so7987995e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 03:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746785353; x=1747390153;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOBX2mkQl2KEqLmo2nN8AZM005hvP8yT+wwHmgPjMP8=;
 b=AXaPBxYdNLKQG4O8AszHyHtFrOpGOqiZCPkC1r4JK0/RT8rVRFKjSwfOoHeQ+8BI4L
 u2o12MW3IylkWIzTUteRVgz3ppxzl86Xcs2bQrVVD6buXpwgJnXm8QAQ8k45orYoIfu3
 ndm5xxUbZEDYIKr2oMugmeuH5gcc8XYn7Z7NTvwDzvbVT6HYFnKp6bKAw5/qs5i99H+V
 28LO/nWvTKC6qUmy+9CNkeP1EEnLXExqN24HEbm6h2yI9NaSh8OQgOSJonP0RumLK7v/
 7SA4OZ/+hb8Reck3zi30XR+mf2aXzSZpU72MaUr5GAev05dSXy/4NkqEENfn3cSZdILp
 TsAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbH6Q2LYw05cPsBPf/RHz3ZHXiN6dA9vGI/7OfQNsGVzIhAWpNSsavbZtUyMdu5N0XMuRP05gwupf2@nongnu.org
X-Gm-Message-State: AOJu0Ywf5M/YqFSt3y/A62tKHMwNQ5JGhow19J87alyxC7qJcXhXiyqB
 /9enEXzOVNEq2xDygR6yYzc2EAINq+HkZD6u0e0uz2mHu1yQteqMFIea7tL+xxa7/GaOi4GqijM
 3JBNVZtLj5y5TZ8gKw3f9GQP37Ydg+BItQ3vnI4YeSXWF1TH5YMbj
X-Gm-Gg: ASbGnctIdUY772OBMnvx6EsDbV/Gqlnc7CRAOlKdTXGlpfkNp1gvi2PgdbBkxTV1tfD
 I0q6yMZ11pXFKAlYxRet9ZgQzRZquyBvTXuj4B1iMhTyc+vxKdFA427IAdGQ4PdLaOJyBywWAE8
 fu1jzTtK+HLYLZliP2auG00GfhcXenIt0Iieiy/QoX2jB5AQJClRTXmEF3R/CmQYwSy2tdlf+qE
 v86XAZJUVg1NerNoYuQR/VgixNYDcYoEFt1ttw4ucAh+C4YCQoTrBcIR9wlFrPRA+LHfWQ3rZKF
 OkpOWcGy5vFbx71RIIGCD+b4CJFMt/Z9J1E7caYg/wqkpqi1UFOHh7OW
X-Received: by 2002:a05:600c:3f0f:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-442d6d5d9e3mr19352475e9.18.1746785352494; 
 Fri, 09 May 2025 03:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Xygbbq9BIupE3zmN1zuMcWfPc4dR2KVzvhUHXlEgPwR56Shy+x37svRXVWY2HW8bHZpl/A==
X-Received: by 2002:a05:600c:3f0f:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-442d6d5d9e3mr19352185e9.18.1746785352018; 
 Fri, 09 May 2025 03:09:12 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f?
 ([2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb6esm67420475e9.25.2025.05.09.03.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:09:11 -0700 (PDT)
Message-ID: <fd4acf77-fc2b-46f9-8f22-f43563df44d3@redhat.com>
Date: Fri, 9 May 2025 12:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] vfio: add device IO ops vector
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
 <20250507152020.1254632-11-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250507152020.1254632-11-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/7/25 17:20, John Levon wrote:
> For vfio-user, device operations such as IRQ handling and region
> read/writes are implemented in userspace over the control socket, not
> ioctl() to the vfio kernel driver; add an ops vector to generalize this,
> and implement vfio_device_io_ops_ioctl for interacting with the kernel
> vfio driver.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h | 38 ++++++++++++++++++
>   hw/vfio/container-base.c      |  6 +--
>   hw/vfio/device.c              | 74 +++++++++++++++++++++++++++++------
>   hw/vfio/listener.c            | 13 +++---
>   hw/vfio/pci.c                 | 10 ++---
>   5 files changed, 114 insertions(+), 27 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 4a32202943..7e1e81e76b 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -41,6 +41,7 @@ enum {
>   };
>   
>   typedef struct VFIODeviceOps VFIODeviceOps;
> +typedef struct VFIODeviceIOOps VFIODeviceIOOps;
>   typedef struct VFIOMigration VFIOMigration;
>   
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
> @@ -66,6 +67,7 @@ typedef struct VFIODevice {
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
>       VFIODeviceOps *ops;
> +    VFIODeviceIOOps *io_ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;
>       unsigned int flags;
> @@ -151,6 +153,42 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIODeviceList vfio_device_list;
>   
>   #ifdef CONFIG_LINUX
> +/*
> + * How devices communicate with the server.  The default option is through
> + * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
> + * process.
> + */
> +struct VFIODeviceIOOps {
> +    /**
> +     * @device_feature
> +     *
> +     * Fill in feature info for the given device.
> +     */
> +    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
> +
> +    /**
> +     * @get_region_info
> +     *
> +     * Fill in @info with information on the region given by @info->index.
> +     */
> +    int (*get_region_info)(VFIODevice *vdev,
> +                           struct vfio_region_info *info);
> +
> +    /**
> +     * @get_irq_info
> +     *
> +     * Fill in @irq with information on the IRQ given by @info->index.
> +     */
> +    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
> +
> +    /**
> +     * @set_irqs
> +     *
> +     * Configure IRQs as defined by @irqs.
> +     */
> +    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
> +};
> +
>   void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>                            struct vfio_device_info *info);
>   
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 3ff473a45c..1c6ca94b60 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -198,11 +198,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>       feature->flags = VFIO_DEVICE_FEATURE_GET |
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -        return -errno;
> -    }
> -
> -    return 0;
> +    return vbasedev->io_ops->device_feature(vbasedev, feature);
>   }
>   
>   static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 5d837092cb..40a196bfb9 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -82,7 +82,7 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
>           .count = 0,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
>   void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
> @@ -95,7 +95,7 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
>           .count = 1,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
>   void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
> @@ -108,7 +108,7 @@ void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
>           .count = 1,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
>   static inline const char *action_to_str(int action)
> @@ -167,7 +167,7 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       pfd = (int32_t *)&irq_set->data;
>       *pfd = fd;
>   
> -    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +    if (!vbasedev->io_ops->set_irqs(vbasedev, irq_set)) {
>           return true;
>       }
>   
> @@ -188,22 +188,19 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>                                struct vfio_irq_info *info)
>   {
> -    int ret;
> -
>       memset(info, 0, sizeof(*info));
>   
>       info->argsz = sizeof(*info);
>       info->index = index;
>   
> -    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> -
> -    return ret < 0 ? -errno : ret;
> +    return vbasedev->io_ops->get_irq_info(vbasedev, info);
>   }
>   
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
> +    int ret;
>   
>       *info = g_malloc0(argsz);
>   
> @@ -211,10 +208,11 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   retry:
>       (*info)->argsz = argsz;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
> +    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
> +    if (ret != 0) {
>           g_free(*info);
>           *info = NULL;
> -        return -errno;
> +        return ret;
>       }
>   
>       if ((*info)->argsz > argsz) {
> @@ -320,11 +318,14 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>       vbasedev->fd = fd;
>   }
>   
> +static VFIODeviceIOOps vfio_device_io_ops_ioctl;
> +
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard)
>   {
>       vbasedev->type = type;
>       vbasedev->ops = ops;
> +    vbasedev->io_ops = &vfio_device_io_ops_ioctl;
>       vbasedev->dev = dev;
>       vbasedev->fd = -1;
>   
> @@ -442,3 +443,54 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>       QLIST_REMOVE(vbasedev, global_next);
>       vbasedev->bcontainer = NULL;
>   }
> +
> +/*
> + * Traditional ioctl() based io
> + */
> +
> +static int vfio_device_io_device_feature(VFIODevice *vbasedev,
> +                                         struct vfio_device_feature *feature)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
> +                                          struct vfio_region_info *info)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_get_irq_info(VFIODevice *vbasedev,
> +                                       struct vfio_irq_info *info)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
> +                                   struct vfio_irq_set *irqs)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
> +    .device_feature = vfio_device_io_device_feature,
> +    .get_region_info = vfio_device_io_get_region_info,
> +    .get_irq_info = vfio_device_io_get_irq_info,
> +    .set_irqs = vfio_device_io_set_irqs,
> +};
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index e7ade7d62e..2b93ca55b6 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -794,13 +794,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
>   
>       QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        int ret;
> +
>           if (!vbasedev->dirty_tracking) {
>               continue;
>           }
>   
> -        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
> +
> +        if (ret != 0) {
>               warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> -                        vbasedev->name, -errno, strerror(errno));
> +                        vbasedev->name, -ret, strerror(-ret));
>           }
>           vbasedev->dirty_tracking = false;
>       }
> @@ -901,10 +905,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>               continue;
>           }
>   
> -        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
>           if (ret) {
> -            ret = -errno;
> -            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
> +            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
>                                vbasedev->name);
>               goto out;
>           }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index f65c9463ce..da2ffc9bf3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -381,7 +381,7 @@ static void vfio_msi_interrupt(void *opaque)
>   static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>   {
>       g_autofree struct vfio_irq_set *irq_set = NULL;
> -    int ret = 0, argsz;
> +    int argsz;
>       int32_t *fd;
>   
>       argsz = sizeof(*irq_set) + sizeof(*fd);
> @@ -396,9 +396,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>       fd = (int32_t *)&irq_set->data;
>       *fd = -1;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -
> -    return ret < 0 ? -errno : ret;
> +    return vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
>   }
>   
>   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
> @@ -455,11 +453,11 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>           fds[i] = fd;
>       }
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    ret = vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
>   
>       g_free(irq_set);
>   
> -    return ret < 0 ? -errno : ret;
> +    return ret;
>   }
>   
>   static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,


