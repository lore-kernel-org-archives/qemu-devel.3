Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E3EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkfi-00029n-Lw; Tue, 16 Jul 2024 12:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTkfU-0001Xx-U5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTkfR-0001Lj-Kd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721145880;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TB2TtLJHlq6J/vlm7sIg8b+3MuhRSqc0nLuATWDyQko=;
 b=Quyv0MOb0e5E7jhV5KxjX7Zx94sWqKqT+gcAQyeQRL0yW3JUTOrQEfH+pZLBaxzsug8mZO
 oD+DK9a5F4Ny4cU7gmNreosvJ1QxaaC/Bhro4MAPm2a2v5rBNW0oC99atGN+8eYZq1HXJW
 TY4jTPqoQLIal9Kv5SRgJsRnf9kN+OE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-AJOlFLkCOKOOnuPSkJD0PQ-1; Tue, 16 Jul 2024 12:04:35 -0400
X-MC-Unique: AJOlFLkCOKOOnuPSkJD0PQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426703ac88dso37634805e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721145874; x=1721750674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TB2TtLJHlq6J/vlm7sIg8b+3MuhRSqc0nLuATWDyQko=;
 b=tNIYF3BH7gpMNy+GAc29Hsu9Ut7XLmJlQLtIfDG9ly0N18Anakkdaov8EuI6JBpDSb
 69JoMtUjmq08BYDxKs3dM/Ce8P5c9sEmZ2h0E7c/1kgFzsXeZnn4bUz8utzAic9Ee9jw
 1otdWTgNYiLRFaI9BGZtPaScW4+0RodLIv4mVEIDVbIsNAz3i0gr8EQm37elOnV7WKQE
 7atYRDU7ruOH3CWBR1FMVeD/dDioSrM8b0vIbPF0Zd5ktn4lTYZbmScs5VpvmBW6M0f9
 l5CZOWufgNbzro2nZahE+mK+NiPqgzoLFXgCiH0OwNPs9KjyFUSQ0wk/53D7dijmsEFF
 qWqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk9mb5DzYzXfqXcLzoCOrWsJY5+59Gs5UvPlAm44TcQClEbTeSUDeUIFR4bOOHQ1I+V51Yad3wl7npZK9U8PgcPq0+p0A=
X-Gm-Message-State: AOJu0Yyc1N59jjvK989S2YOcrqRCOq2WkCIkN9viOhqDDkHZC4U4VYCn
 7nidIvciSeKsIsigW4gc/etnyOCKUUjBNuN5yU+NaacBQDymwjvHi9o8e3BlfiOHthB/UAsuT7B
 n4TPdT0QGM/Yy4/y2HU9kIZpAYaOyd3Dpkcl7b7Z1o4dqsFwm0+9A
X-Received: by 2002:a05:600c:35d2:b0:423:791:f446 with SMTP id
 5b1f17b1804b1-427ba6552efmr17471645e9.7.1721145874210; 
 Tue, 16 Jul 2024 09:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHar3AoCUNbDSd+dp31Sq3gbhA4AA/lICfe+wcyrWttkrDcm5CnfNLpsY953uq0srKHbqjuog==
X-Received: by 2002:a05:600c:35d2:b0:423:791:f446 with SMTP id
 5b1f17b1804b1-427ba6552efmr17471385e9.7.1721145873704; 
 Tue, 16 Jul 2024 09:04:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb454sm132884625e9.32.2024.07.16.09.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 09:04:33 -0700 (PDT)
Message-ID: <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
Date: Tue, 16 Jul 2024 18:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-6-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Joao,

On 7/12/24 13:46, Joao Martins wrote:
> There's generally two modes of operation for IOMMUFD:
>
> * The simple user API which intends to perform relatively simple things
> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO

It generally creates? can you explicit what is "it"

I am confused by this automatic terminology again (not your fault). the doc says:
"

  *

    Automatic domain - refers to an iommu domain created automatically
    when attaching a device to an IOAS object. This is compatible to the
    semantics of VFIO type1.

  *

    Manual domain - refers to an iommu domain designated by the user as
    the target pagetable to be attached to by a device. Though currently
    there are no uAPIs to directly create such domain, the datastructure
    and algorithms are ready for handling that use case.

"


in 1) the device is attached to the ioas id (using the auto domain if I am not wrong)
Here you attach to an hwpt id. Isn't it a manual domain?

> and mainly performs IOAS_MAP and UNMAP.
>
> * The native IOMMUFD API where you have fine grained control of the
> IOMMU domain and model it accordingly. This is where most new feature
> are being steered to.
>
> For dirty tracking 2) is required, as it needs to ensure that
> the stage-2/parent IOMMU domain will only attach devices
> that support dirty tracking (so far it is all homogeneous in x86, likely
> not the case for smmuv3). Such invariant on dirty tracking provides a
> useful guarantee to VMMs that will refuse incompatible device
> attachments for IOMMU domains.
>
> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
> responsible for creating an IOMMU domain. This is contrast to the
> 'simple API' where the IOMMU domain is created by IOMMUFD automatically
> when it attaches to VFIO (usually referred as autodomains) but it has
> the needed handling for mdevs.
>
> To support dirty tracking with the advanced IOMMUFD API, it needs
> similar logic, where IOMMU domains are created and devices attached to
> compatible domains. Essentially mimmicing kernel
> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU domain
> it falls back to IOAS attach.
>
> The auto domain logic allows different IOMMU domains to be created when
> DMA dirty tracking is not desired (and VF can provide it), and others where
> it is. Here is not used in this way here given how VFIODevice migration

Here is not used in this way here ?

> state is initialized after the device attachment. But such mixed mode of
> IOMMU dirty tracking + device dirty tracking is an improvement that can
> be added on. Keep the 'all of nothing' of type1 approach that we have
> been using so far between container vs device dirty tracking.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/hw/vfio/vfio-common.h |  9 ++++
>  include/sysemu/iommufd.h      |  5 +++
>  backends/iommufd.c            | 30 +++++++++++++
>  hw/vfio/iommufd.c             | 82 +++++++++++++++++++++++++++++++++++
>  backends/trace-events         |  1 +
>  5 files changed, 127 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7419466bca92..2dd468ce3c02 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>  
>  typedef struct IOMMUFDBackend IOMMUFDBackend;
>  
> +typedef struct VFIOIOASHwpt {
> +    uint32_t hwpt_id;
> +    QLIST_HEAD(, VFIODevice) device_list;
> +    QLIST_ENTRY(VFIOIOASHwpt) next;
> +} VFIOIOASHwpt;
> +
>  typedef struct VFIOIOMMUFDContainer {
>      VFIOContainerBase bcontainer;
>      IOMMUFDBackend *be;
>      uint32_t ioas_id;
> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>  } VFIOIOMMUFDContainer;
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>      HostIOMMUDevice *hiod;
>      int devid;
>      IOMMUFDBackend *iommufd;
> +    VFIOIOASHwpt *hwpt;
> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 57d502a1c79a..e917e7591d05 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -50,6 +50,11 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
>                                       uint64_t *caps, Error **errp);
> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t pt_id, uint32_t flags,
> +                                uint32_t data_type, uint32_t data_len,
> +                                void *data_ptr, uint32_t *out_hwpt,
> +                                Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2b3d51af26d2..5d3dfa917415 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -208,6 +208,36 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>      return ret;
>  }
>  
> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t pt_id, uint32_t flags,
> +                                uint32_t data_type, uint32_t data_len,
> +                                void *data_ptr, uint32_t *out_hwpt,
> +                                Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_hwpt_alloc alloc_hwpt = {
> +        .size = sizeof(struct iommu_hwpt_alloc),
> +        .flags = flags,
> +        .dev_id = dev_id,
> +        .pt_id = pt_id,
> +        .data_type = data_type,
> +        .data_len = data_len,
> +        .data_uptr = (uint64_t)data_ptr,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
> +                                     data_len, (uint64_t)data_ptr,
> +                                     alloc_hwpt.out_hwpt_id, ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
> +        return false;
> +    }
> +
> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
> +    return true;
> +}
> +
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
>                                       uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 077dea8f1b64..325c7598d5a1 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -212,10 +212,86 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>      return true;
>  }
>  
> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> +                                         VFIOIOMMUFDContainer *container,
> +                                         Error **errp)
> +{
> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
> +    uint32_t flags = 0;
> +    VFIOIOASHwpt *hwpt;
> +    uint32_t hwpt_id;
> +    int ret;
> +
> +    /* Try to find a domain */
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> +        if (ret) {
> +            /* -EINVAL means the domain is incompatible with the device. */
> +            if (ret == -EINVAL) {
> +                /*
> +                 * It is an expected failure and it just means we will try
> +                 * another domain, or create one if no existing compatible
> +                 * domain is found. Hence why the error is discarded below.
> +                 */
> +                error_free(*errp);
> +                *errp = NULL;
> +                continue;
> +            }
> +
> +            return false;
> +        } else {
> +            vbasedev->hwpt = hwpt;
> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +            return true;
> +        }
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
> +                                    container->ioas_id, flags,
> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
> +                                    &hwpt_id, errp)) {
> +        return false;
> +    }
> +
> +    hwpt = g_malloc0(sizeof(*hwpt));
> +    hwpt->hwpt_id = hwpt_id;
> +    QLIST_INIT(&hwpt->device_list);
> +
> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> +    if (ret) {
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +        return false;
> +    }
> +
> +    vbasedev->hwpt = hwpt;
> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    return true;
> +}
> +
> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
> +                                         VFIOIOMMUFDContainer *container)
> +{
> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
> +
> +    QLIST_REMOVE(vbasedev, hwpt_next);
don't you want to reset vbasedev->hwpt = NULL too?


> +    if (QLIST_EMPTY(&hwpt->device_list)) {
> +        QLIST_REMOVE(hwpt, next);
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +    }
> +}
> +
>  static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                            VFIOIOMMUFDContainer *container,
>                                            Error **errp)
>  {
> +    /* mdevs aren't physical devices and will fail with auto domains */
> +    if (!vbasedev->mdev) {
> +        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
> +    }
> +
>      return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>  }
>  
> @@ -224,6 +300,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>  {
>      Error *err = NULL;
>  
> +    if (vbasedev->hwpt) {
> +        iommufd_cdev_autodomains_put(vbasedev, container);
> +        return;
Where do we detach the device from the hwpt?

Thanks

Eric
> +    }
> +
>      if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>          error_report_err(err);
>      }
> @@ -354,6 +435,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>      container->be = vbasedev->iommufd;
>      container->ioas_id = ioas_id;
> +    QLIST_INIT(&container->hwpt_list);
>  
>      bcontainer = &container->bcontainer;
>      vfio_address_space_insert(space, bcontainer);
> diff --git a/backends/trace-events b/backends/trace-events
> index 211e6f374adc..4d8ac02fe7d6 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size
>  iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>  iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"


