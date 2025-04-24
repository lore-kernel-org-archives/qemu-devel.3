Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A3C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 16:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7zHN-0006hG-Iu; Thu, 24 Apr 2025 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7zHJ-0006gB-Rh
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7zHF-00084w-4k
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745511494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OpRf55zB0mJPVVRfUmKo5VkorBKfLH20I3ja7IFxs1U=;
 b=XWa+Pdp4mbRJpevULWhBQa53boru1EuCvHzrA6GQ2wmci3IwBPVbe4DdMzLNvpgUj96AKr
 oKPHa0TL2E/CCGcGVIK7pfFoKf0kAPSRXS8Zop5hTWQy/NhoXjZsuGlmIdENj+joVGrO6C
 cydBwNpJKwCNCnTH0atIX+LCN/JEi7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-88GKr65ANtCuvbWU-DWFiQ-1; Thu, 24 Apr 2025 12:18:12 -0400
X-MC-Unique: 88GKr65ANtCuvbWU-DWFiQ-1
X-Mimecast-MFC-AGG-ID: 88GKr65ANtCuvbWU-DWFiQ_1745511491
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39d8e5ca9c2so779353f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 09:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745511491; x=1746116291;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpRf55zB0mJPVVRfUmKo5VkorBKfLH20I3ja7IFxs1U=;
 b=Ulc1fLV2VNgbAUBEixA8dOaA3jMRrSzsGRMY7B49QR0LU2n9UUmO5HdxoCUogAGXSN
 k139SEJ0MhRGj/S8nDF/jo0V9dypdQEOTgzygj89YQr04OthSu6lSlZL1FxMXA4EQyYF
 +5+lptvZtckEXf61xJ7oOYnsgyoX+E6Yh1+E0jcPw2hlIMa2vy6J9vrNyhftwwx10dtc
 BpAacY27DVggkBE9KZ5Atp+Bi2hRkiLU/bSDLlZlALLXdrjYlN7NJGQwRFGlmp+DnrVn
 vWBgsHStKL+5o2Ryw8cNrnALt5Ai8oTfgqi7H2KDntYhc1qL03mjl3y2vzhA5NylQIde
 Y0Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSe0c7TUi7ndRlV78ippQP+fPfxKhq70RPmEqmSoKXHzXHIAx+t8IOdM5ArvlIwA5PfTmXFhAR+kaV@nongnu.org
X-Gm-Message-State: AOJu0Yxuf8N7xXihXOVwyB4f+vW3iUpYhDXewdJeXixihs3QLi20vxYb
 C+QOZSgLD+SLHFegOcHZDaIzBhnh534Xwb4v72QCGJOXjnCFNDAdMwIaBUjypcgznJfI1+z3tHT
 qga+1Z4MnmGsNwlZI7OQ6Gk58L0+SaKbh98m65HZ/8oBZZaJNCrgR
X-Gm-Gg: ASbGncsA2xcmW/bHf8p3brMODf5qL2bbAOiiwBAcY2m7WNMnOVZDb8njsHFP36x+Xw3
 q/pSWORkPmKKgp4fgvCWRGkbuPYiCw/Jso31rSq8dOOLrUWsCKjbex/4P7EfnWOOuJd1mla4bqI
 2n127u49dq1u9gIZJQMQJabja9zAL9l5qvwrkNC3v3lPbednB1zqQL84c5I3TOP0qehnr+Iodwi
 JDJcn55EoSVTSR/nrExUR3Mi3bqx/uNoVNu3MfJVvHkaLXAv/IhKF4ecs6BlRuvAa5vOm2Z1Z8o
 7PPeIl0Th+5yNVVlqtwFv5tYc4sFNqLbZPMVqsg3wvKXIlc=
X-Received: by 2002:a05:6000:1843:b0:39c:223f:2770 with SMTP id
 ffacd0b85a97d-3a06cf563ecmr2822695f8f.15.1745511490972; 
 Thu, 24 Apr 2025 09:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjs3A1O0kIOXZpye+TBlzdAorEPls2rFqCuzzOtWR857qewUC05JXbFCe1SzdBEXlaV2ByoA==
X-Received: by 2002:a05:6000:1843:b0:39c:223f:2770 with SMTP id
 ffacd0b85a97d-3a06cf563ecmr2822655f8f.15.1745511490429; 
 Thu, 24 Apr 2025 09:18:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54f162sm2613353f8f.99.2025.04.24.09.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 09:18:09 -0700 (PDT)
Message-ID: <e2285d29-d4a3-45ff-b7fd-a40c8681d73b@redhat.com>
Date: Thu, 24 Apr 2025 18:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] vfio: add device IO ops vector
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-14-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-14-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On 4/9/25 15:48, John Levon wrote:
> For vfio-user, device operations such as IRQ handling and region
> read/writes are implemented in userspace over the control socket, not
> ioctl() or read()/write() to the vfio kernel driver; add an ops vector
> to generalize this, and implement vfio_device_io_ops_ioctl for
> interacting with the kernel vfio driver.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/ap.c                  |   2 +-
>   hw/vfio/ccw.c                 |   2 +-
>   hw/vfio/container-base.c      |   6 +-
>   hw/vfio/device.c              | 102 ++++++++++++++++++++++++++++++----
>   hw/vfio/listener.c            |  13 +++--
>   hw/vfio/pci.c                 |  40 +++++++------
>   hw/vfio/platform.c            |   2 +-
>   hw/vfio/region.c              |  17 ++++--
>   include/hw/vfio/vfio-device.h |  24 +++++++-
>   9 files changed, 155 insertions(+), 53 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index f311bca5b6..b6233b2107 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -229,7 +229,7 @@ static void vfio_ap_instance_init(Object *obj)
>        * handle ram_block_discard_disable().
>        */
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
> -                     DEVICE(vapdev), true);
> +                     &vfio_device_io_ops_ioctl, DEVICE(vapdev), true);


We only have one io_ops implementation currently. Please drop all
the vfio_device_init() changes and keep vfio_device_io_ops_ioctl
static.

>   
>       /* AP device is mdev type device */
>       vbasedev->mdev = true;
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 14dee7cd19..aee52b5a8d 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -676,7 +676,7 @@ static void vfio_ccw_instance_init(Object *obj)
>        * ram_block_discard_disable().
>        */
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_CCW, &vfio_ccw_ops,
> -                     DEVICE(vcdev), true);
> +                     &vfio_device_io_ops_ioctl, DEVICE(vcdev), true);
>   }
>   
>   #ifdef CONFIG_IOMMUFD
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 613fe1a00d..16fe5f79d2 100644
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
> index 102fa5a9b4..545d9f1faf 100644
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
> @@ -155,6 +155,7 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       int argsz;
>       const char *name;
>       int32_t *pfd;
> +    int ret;
>   
>       argsz = sizeof(*irq_set) + sizeof(*pfd);
>   
> @@ -167,7 +168,9 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       pfd = (int32_t *)&irq_set->data;
>       *pfd = fd;
>   
> -    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +    ret = vbasedev->io_ops->set_irqs(vbasedev, irq_set);
> +
> +    if (!ret) {
>           return true;
>       }
>   
> @@ -188,22 +191,19 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
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
>       /* create region info cache */
>       if (vbasedev->reginfo == NULL) {
> @@ -222,10 +222,11 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
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
> @@ -332,10 +333,12 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>   }
>   
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
> -                      DeviceState *dev, bool ram_discard)
> +                      VFIODeviceIOOps *io_ops, DeviceState *dev,
> +                      bool ram_discard)
>   {
>       vbasedev->type = type;
>       vbasedev->ops = ops;
> +    vbasedev->io_ops = io_ops;
>       vbasedev->dev = dev;
>       vbasedev->fd = -1;
>   
> @@ -463,3 +466,78 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>   
>       vfio_device_get_all_region_info(vbasedev);
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
> +static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
> +                                      off_t off, uint32_t size, void *data)
> +{
> +    struct vfio_region_info *info = vbasedev->reginfo[index];
> +    int ret;
> +
> +    ret = pread(vbasedev->fd, data, size, info->offset + off);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
> +                                       off_t off, uint32_t size, void *data)
> +{
> +    struct vfio_region_info *info = vbasedev->reginfo[index];
> +    int ret;
> +
> +    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +VFIODeviceIOOps vfio_device_io_ops_ioctl = {
> +    .device_feature = vfio_device_io_device_feature,
> +    .get_region_info = vfio_device_io_get_region_info,
> +    .get_irq_info = vfio_device_io_get_irq_info,
> +    .set_irqs = vfio_device_io_set_irqs,
> +    .region_read = vfio_device_io_region_read,
> +    .region_write = vfio_device_io_region_write,
> +};
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index bcf2b98e79..7ea9e0dfb7 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -821,13 +821,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
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
> @@ -928,10 +932,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
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
> index b40d5abdfd..ff2b15ff02 100644
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
> @@ -917,18 +915,22 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       memset(vdev->rom, 0xff, size);
>   
>       while (size) {
> -        bytes = pread(vbasedev->fd, vdev->rom + off,
> -                      size, vdev->rom_offset + off);
> +        bytes = vbasedev->io_ops->region_read(vbasedev,
> +                                              VFIO_PCI_ROM_REGION_INDEX,
> +                                              off, size, vdev->rom + off);
> +
>           if (bytes == 0) {
>               break;
>           } else if (bytes > 0) {
>               off += bytes;
>               size -= bytes;
>           } else {
> -            if (errno == EINTR || errno == EAGAIN) {
> +            if (bytes == -EINTR || bytes == -EAGAIN) {
>                   continue;
>               }
> -            error_report("vfio: Error reading device ROM: %m");
> +            error_report("vfio: Error reading device ROM: %s",
> +                         strerror(-bytes));
> +
>               break;
>           }
>       }
> @@ -968,22 +970,18 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
>                                         uint32_t size, void *data)
>   {
> -    ssize_t ret;
> -
> -    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> -
> -    return ret < 0 ? -errno : (int)ret;
> +    return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
> +                                              VFIO_PCI_CONFIG_REGION_INDEX,
> +                                              offset, size, data);
>   }
>   
>   /* "Raw" write of underlying config space. */
>   static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
>                                          uint32_t size, void *data)
>   {
> -    ssize_t ret;
> -
> -    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> -
> -    return ret < 0 ? -errno : (int)ret;
> +    return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
> +                                               VFIO_PCI_CONFIG_REGION_INDEX,
> +                                               offset, size, data);
>   }
>   
>   static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> @@ -3405,7 +3403,7 @@ static void vfio_instance_init(Object *obj)
>       vdev->host.function = ~0U;
>   
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_pci_ops,
> -                     DEVICE(vdev), false);
> +                     &vfio_device_io_ops_ioctl, DEVICE(vdev), false);
>   
>       vdev->nv_gpudirect_clique = 0xFF;
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index fd176c18a4..28eedfa571 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -650,7 +650,7 @@ static void vfio_platform_instance_init(Object *obj)
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PLATFORM, &vfio_platform_ops,
> -                     DEVICE(vdev), false);
> +                     &vfio_device_io_ops_ioctl, DEVICE(vdev), false);
>   }
>   
>   #ifdef CONFIG_IOMMUFD
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index ef2630cac3..35fb81c04a 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -45,6 +45,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           uint32_t dword;
>           uint64_t qword;
>       } buf;
> +    int ret;
>   
>       switch (size) {
>       case 1:
> @@ -64,11 +65,13 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           break;
>       }
>   
> -    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
> +    ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
> +                                         addr, size, &buf);
> +    if (ret != size) {
>           error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
> -                     ",%d) failed: %m",
> +                     ",%d) failed: %s",
>                        __func__, vbasedev->name, region->nr,
> -                     addr, data, size);
> +                     addr, data, size, ret < 0 ? strerror(ret) : "short write");
>       }
>   
>       trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
> @@ -96,11 +99,13 @@ uint64_t vfio_region_read(void *opaque,
>           uint64_t qword;
>       } buf;
>       uint64_t data = 0;
> +    int ret;
>   
> -    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
> -        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
> +    ret = vbasedev->io_ops->region_read(vbasedev, region->nr, addr, size, &buf);
> +    if (ret != size) {
> +        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
>                        __func__, vbasedev->name, region->nr,
> -                     addr, size);
> +                     addr, size, ret < 0 ? strerror(ret) : "short read");
>           return (uint64_t)-1;
>       }
>       switch (size) {
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 967b07cd89..cb2f581826 100644
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
> @@ -140,6 +142,25 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIODeviceList vfio_device_list;
>   
>   #ifdef CONFIG_LINUX
> +/*
> + * How devices communicate with the server.  The default option is through
> + * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
> + * process.
> + */
> +struct VFIODeviceIOOps {
> +    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
> +    int (*get_region_info)(VFIODevice *vdev,
> +                           struct vfio_region_info *info);
> +    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
> +    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
> +    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> +                       void *data);
> +    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> +                        void *data);
> +};


Could you please add documentation for this new struct.


Thanks,

C.




> +extern VFIODeviceIOOps vfio_device_io_ops_ioctl;
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info);
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
> @@ -154,6 +175,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
> -                      DeviceState *dev, bool ram_discard);
> +                      VFIODeviceIOOps *io_ops, DeviceState *dev,
> +                      bool ram_discard);
>   int vfio_device_get_aw_bits(VFIODevice *vdev);
>   #endif /* HW_VFIO_VFIO_COMMON_H */


