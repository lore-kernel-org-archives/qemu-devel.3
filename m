Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB85C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4gh-00069E-R2; Tue, 09 Jul 2024 02:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4gc-00067o-Ms
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4gX-0005hS-C0
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720507843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKOJuzDXUyoKlW7QJ+JBfGZi8J+Ez2Q16s/WDENRbNI=;
 b=EpAac4mv8MtiA05jqbiKKoDwiyalYnJ5S2LcThi1dpql5VB4xeYdsP5bbh3krrSlNNfaQa
 sYPiG6YfSriAvM7mivwkyvCq57ml0ueNPR5pyox2a0pVwscuVES76LJKH0tSYvXb6SNswa
 IrkF5BbTwaRhO2kJADhY/JHRnhLmcjs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-9A7GkTbLNxiE6BK69WLwnw-1; Tue, 09 Jul 2024 02:50:40 -0400
X-MC-Unique: 9A7GkTbLNxiE6BK69WLwnw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e960523ecso4643853e87.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 23:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720507838; x=1721112638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KKOJuzDXUyoKlW7QJ+JBfGZi8J+Ez2Q16s/WDENRbNI=;
 b=NrSoRdQlH3GgS4JiEvD2OH7YhYzywEnquezqGhoA8Qwl9iKNuplqsl9g4IJut/IBA2
 cBnpZekQw53RPjrKskmXAAN1xOQ395T+aZIsPnhvRc+ifccA0PZvBm8JG6B0wFsadlzf
 XnqS3hHui5Yn+L0w4L3DA7+hZNyQrPu038VCWyD0cfvqHFRAkYM2PlV9FgajnZNlrkTx
 4/V/8XPFpS6B2pPOisshwNOuqdVy1Nl+2tr1+ytTZ42j/hxXvLxQ4ZaSHjCqQHi8GmHf
 vJZPf5xKtPjd8uF1Po+UaNnPset4rIutf4R2th5eUoE31pT0WmN5GNtzBeSCwbOrzQVj
 WdXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQoXBuGLzhSKouabQL0ZCeeM0fKQiZCGrM2pVgBasMUu/sNf0AzTcVWndfqHU5rCS4p1oat/wjG05d3K+mJ8QE7BaaGrk=
X-Gm-Message-State: AOJu0Yyp7UcGExgIzaSheL0KBeo5UqO8NU5t6b0DOyAbqgpsNRWPGlQO
 UbiVyv3mBrepFQSRCMbxKIS3GIR+22j3q1MPGUt0HqdW1K56MD1f87WOYT8Rwn23RxNAtgwiyMh
 ibfXwNYfldXVZc1ZguT8ZVfzV6urolDHWP/RlP/1xkzUya+nS9LbW
X-Received: by 2002:a05:6512:318a:b0:52e:7444:162e with SMTP id
 2adb3069b0e04-52eb99d1527mr1006375e87.55.1720507838369; 
 Mon, 08 Jul 2024 23:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGhrFVNqA+NlNfYOcZIt3pexSvP4VGyzPHMGrD6qNTJoZ+bIDNNyugZBEL9b0izeWS/l6UUg==
X-Received: by 2002:a05:6512:318a:b0:52e:7444:162e with SMTP id
 2adb3069b0e04-52eb99d1527mr1006349e87.55.1720507837899; 
 Mon, 08 Jul 2024 23:50:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f74462esm25222095e9.48.2024.07.08.23.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 23:50:37 -0700 (PDT)
Message-ID: <6b5f84b5-134c-4507-84aa-5086f20f6eaa@redhat.com>
Date: Tue, 9 Jul 2024 08:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] vfio/iommufd: Introduce auto domain creation
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-5-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240708143420.16953-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/8/24 4:34 PM, Joao Martins wrote:
> There's generally two modes of operation for IOMMUFD:
> 
> * The simple user API which intends to perform relatively simple things
> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
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
> iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
> to IOAS attach (which again is always the case for mdevs).
> 
> The auto domain logic allows different IOMMU domains to be created when
> DMA dirty tracking is not desired (and VF can provide it), and others where
> it is. Here is not used in this way here given how VFIODevice migration
> state is initialized after the device attachment. But such mixed mode of
> IOMMU dirty tracking + device dirty tracking is an improvement that can
> be added on. Keep the 'all of nothing' approach that we have been using
> so far between container vs device dirty tracking.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/hw/vfio/vfio-common.h |  9 ++++
>   include/sysemu/iommufd.h      |  4 ++
>   backends/iommufd.c            | 29 +++++++++++
>   hw/vfio/iommufd.c             | 91 +++++++++++++++++++++++++++++++++++
>   backends/trace-events         |  1 +
>   5 files changed, 134 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e8ddf92bb185..82c5a4aaa61e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>   
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
>   
> +typedef struct VFIOIOASHwpt {
> +    uint32_t hwpt_id;
> +    QLIST_HEAD(, VFIODevice) device_list;
> +    QLIST_ENTRY(VFIOIOASHwpt) next;
> +} VFIOIOASHwpt;
> +
>   typedef struct VFIOIOMMUFDContainer {
>       VFIOContainerBase bcontainer;
>       IOMMUFDBackend *be;
>       uint32_t ioas_id;
> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>   } VFIOIOMMUFDContainer;
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
> @@ -134,6 +141,8 @@ typedef struct VFIODevice {
>       HostIOMMUDevice *hiod;
>       int devid;
>       IOMMUFDBackend *iommufd;
> +    VFIOIOASHwpt *hwpt;
> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 57d502a1c79a..35a8cec9780f 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -50,6 +50,10 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp);
> +int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t flags,
> +                               uint32_t data_type, uint32_t data_len,
> +                               void *data_ptr, uint32_t *out_hwpt);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2b3d51af26d2..f5f73eaf4a1a 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -208,6 +208,35 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>       return ret;
>   }
>   
> +int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t flags,
> +                               uint32_t data_type, uint32_t data_len,
> +                               void *data_ptr, uint32_t *out_hwpt)
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
> +        ret = -errno;
> +        error_report("IOMMU_HWPT_ALLOC failed: %m");

Please add an 'Error **errp' parameter.

> +    } else {
> +        *out_hwpt = alloc_hwpt.out_hwpt_id;
> +    }
> +    return ret;
> +}
> +
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 5a5993b17c2e..2ca9a32cc7b6 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -212,10 +212,95 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
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
> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, NULL);
> +        if (ret) {
> +            /* -EINVAL means the domain is incompatible with the device. */
> +            if (ret == -EINVAL) {
> +                continue;
> +            }

We should propagate an error in the false case.

> +            return false;
> +        } else {
> +            vbasedev->hwpt = hwpt;
> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +            return true;
> +        }
> +    }
> +
> +    ret = iommufd_backend_alloc_hwpt(iommufd,
> +                                     vbasedev->devid,
> +                                     container->ioas_id, flags,
> +                                     IOMMU_HWPT_DATA_NONE, 0, NULL, &hwpt_id);
> +    if (ret) {
> +        /*
> +         * When there's no domains allocated we can still attempt a hardware
> +         * pagetable allocation for an mdev, which ends up returning -ENOENT
> +         * This is benign and meant to fallback into IOAS attach, hence don't
> +         * set errp.
> +         */

same here.

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
> +    if (QLIST_EMPTY(&hwpt->device_list)) {
> +        QLIST_REMOVE(hwpt, next);
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +    }
> +}
> +
>   static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                             VFIOIOMMUFDContainer *container,
>                                             Error **errp)
>   {
> +    if (iommufd_cdev_autodomains_get(vbasedev, container, errp)) {
> +        return true;
> +    }
> +
> +    /*
> +     * iommufd_cdev_autodomains_get() may have an expected failure (-ENOENT)
> +     * for mdevs as they aren't real physical devices. @errp is only set
> +     * when real failures happened i.e. failing to attach to a newly created
> +     * hardware pagetable. These are fatal and should fail the attachment.
> +     */
> +    if (*errp) {
> +        return false;
> +    }
> +
>       return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>   }
>   
> @@ -224,6 +309,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>   {
>       Error *err = NULL;
>   
> +    if (vbasedev->hwpt) {
> +        iommufd_cdev_autodomains_put(vbasedev, container);
> +        return;
> +    }
> +
>       if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>           error_report_err(err);
>       }
> @@ -354,6 +444,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>       container->be = vbasedev->iommufd;
>       container->ioas_id = ioas_id;
> +    QLIST_INIT(&container->hwpt_list);
>   
>       bcontainer = &container->bcontainer;
>       vfio_address_space_insert(space, bcontainer);
> diff --git a/backends/trace-events b/backends/trace-events
> index 211e6f374adc..4d8ac02fe7d6 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size
>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"


