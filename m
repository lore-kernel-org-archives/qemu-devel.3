Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F072DC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3CYb-0005YO-Kk; Fri, 11 Apr 2025 07:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u3CYV-0005Th-44
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u3CYS-0006Pu-RZ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744370894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GdMykleHiepWyWR+KhGhJ+Sj8nEwl/tscZR0XrtMZNs=;
 b=YNPMNMZ0DT1R34Y8yg0yQQrSAVt0/cvwhKXBqV7DmioEJu8KvvTx2AOdICiZZ6hYWqjfxL
 +mnS8pkN92LqTFPUNaIlG9UvN8d8lLztsD/0jr72PIGs0KozmXcLQdzRxTdH8xUNJY4S5f
 Uq8b3p+bojuKXSWb8b2tDUnpyr9B6UE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-zJgh_C0gMc6fnoL8Ii-CkA-1; Fri, 11 Apr 2025 07:28:13 -0400
X-MC-Unique: zJgh_C0gMc6fnoL8Ii-CkA-1
X-Mimecast-MFC-AGG-ID: zJgh_C0gMc6fnoL8Ii-CkA_1744370892
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39d9243b1c2so764065f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 04:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744370892; x=1744975692;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdMykleHiepWyWR+KhGhJ+Sj8nEwl/tscZR0XrtMZNs=;
 b=JVj/34zWdQ2Ua3TG3SGqdHY1PV5YyXCm1wheeanxuhwpUxVEUEiYPlar5k/A1Q5Y+E
 DbblWPEbJWPa58EXJ6fljuy4wtl+1+4kn3BY7X6B4ogdoZfNS+8FWyMh8/tejpW/+Hhr
 yklwP1cJkHif+orDwYxq61nN+PIaaDwWzsTppEeSJNbzBzMVc7rtCiNFO/FBNitsDnW+
 uf4npjH8wSeLtJU8V+cjegd3t8x74e7+IS/+qmsaGMiZg6oBc0L4I/Lx1NI/DyiK8UFj
 azyi8H5aJqKbltX4Ws+p+Q4eIXuQX4+KcuJxq29kviaWxigCbHwWtCOI1EDO1dG5FzyO
 ahzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9YBM+SXLzzvdhi3Yqf6B+B29s6wzwI6TriG/Cfo8BVGmvtVlgDs0lL44NB38sJ4HZVdcMGNy3GOBS@nongnu.org
X-Gm-Message-State: AOJu0YyCRLwozEotxayJYraumW48HB4spF5ne0iFD+C+ovKSyIDihNXa
 w/SUO4Sjii/KAVFdgYz6iGmm3+iFKlz9hnZDHU1VR9e5Bub39eN7FegMGWXBbCVpoYdDjtRCpOR
 ME2YDGNNXInvz5UrBh6NZ5f/86Ft47zI8HTcNVNKQbr5BjNFF118e
X-Gm-Gg: ASbGnct+7p46zICc1jiFDhh4Hr/kWU3B0oj7If6BjY4PoVo+h7cNyidOm7nvbEsnOuG
 bBdTDRerg7sUKXG7WAeNqniE36r6wTdtOiptdY/3P2vYsDAQRrOrCXUzabmarISBdFcHM00CFvs
 0MaKuGnZKZxqbMISmGJtu7cFy8yJZ/YfovdSIJizemKHx53BGM5Nh1aSQjIMzHsIBnUZ4A6PZAz
 AiB7nrxQO9Ta5G844lxdg4dF4Ib8bUGnp6/vHX1XvcMcQF+RQuvUHA7816/qcWqxnhonKc7l+rB
 k6r9TVvRygJJAfVCtDwOFXDAj7tLQOTD87cgzQugBI3YzPSgYA==
X-Received: by 2002:a05:6000:2401:b0:39c:30c9:822 with SMTP id
 ffacd0b85a97d-39ea52149a4mr1817737f8f.30.1744370891838; 
 Fri, 11 Apr 2025 04:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWrHeCZDrP1+DrOxqLgOor4n8HHS1S0JA2en0uJDf1QSiKWPFKJs1IIXr7Yla6x2WaxIspNw==
X-Received: by 2002:a05:6000:2401:b0:39c:30c9:822 with SMTP id
 ffacd0b85a97d-39ea52149a4mr1817707f8f.30.1744370891372; 
 Fri, 11 Apr 2025 04:28:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9640fdsm1720106f8f.7.2025.04.11.04.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 04:28:10 -0700 (PDT)
Message-ID: <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
Date: Fri, 11 Apr 2025 13:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com, Yi Liu <yi.l.liu@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250411101707.3460429-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
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

On 4/11/25 12:17, Zhenzhong Duan wrote:
> The saved caps copy can be used to check dirty tracking capability.
> 
> The capabilities is gotten through IOMMUFD interface, so define a
> new structure HostIOMMUDeviceIOMMUFDCaps which contains vendor
> caps raw data in "include/system/iommufd.h".
> 
> This is a prepare work for moving .realize() after .attach_device().
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  1 +
>   include/system/iommufd.h      | 22 ++++++++++++++++++++++
>   hw/vfio/iommufd.c             | 10 +++++++++-
>   3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 66797b4c92..09a7af891a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -77,6 +77,7 @@ typedef struct VFIODevice {
>       bool dirty_tracking; /* Protected by BQL */
>       bool iommu_dirty_tracking;
>       HostIOMMUDevice *hiod;
> +    HostIOMMUDeviceIOMMUFDCaps caps;

IMO, these capabilities belong to HostIOMMUDevice and not VFIODevice.

I would simply call iommufd_backend_get_device_info() twice where needed :
iommufd_cdev_autodomains_get() and  hiod_iommufd_vfio_realize()


Thanks,

C.



>       int devid;
>       IOMMUFDBackend *iommufd;
>       VFIOIOASHwpt *hwpt;
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..0f337585c9 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -18,6 +18,9 @@
>   #include "exec/hwaddr.h"
>   #include "exec/cpu-common.h"
>   #include "system/host_iommu_device.h"
> +#ifdef CONFIG_LINUX
> +#include <linux/iommufd.h>
> +#endif
>   
>   #define TYPE_IOMMUFD_BACKEND "iommufd"
>   OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
> @@ -63,4 +66,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                         Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +
> +typedef union VendorCaps {
> +    struct iommu_hw_info_vtd vtd;
> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
> +} VendorCaps;
> +
> +/**
> + * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device capabilities.
> + *
> + * @type: host platform IOMMU type.
> + *
> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
> + *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> + */
> +typedef struct HostIOMMUDeviceIOMMUFDCaps {
> +    uint32_t type;
> +    uint64_t hw_caps;
> +    VendorCaps vendor_caps;
> +} HostIOMMUDeviceIOMMUFDCaps;
>   #endif
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48db105422..530cde6740 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -324,7 +324,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        * vfio_migration_realize() may decide to use VF dirty tracking
>        * instead.
>        */
> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +    if (vbasedev->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>           flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>       }
>   
> @@ -475,6 +475,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       int ret, devfd;
>       uint32_t ioas_id;
>       Error *err = NULL;
> +    HostIOMMUDeviceIOMMUFDCaps *caps = &vbasedev->caps;
>       const VFIOIOMMUClass *iommufd_vioc =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>   
> @@ -505,6 +506,13 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_alloc_ioas;
>       }
>   
> +    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> +                                         &caps->type, &caps->vendor_caps,
> +                                         sizeof(VendorCaps), &caps->hw_caps,
> +                                         errp)) {
> +        goto err_alloc_ioas;
> +    }
> +
>       /* try to attach to an existing container in this space */
>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>           container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);


