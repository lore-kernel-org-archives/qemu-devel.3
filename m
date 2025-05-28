Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6510CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKEJp-0001FH-QP; Wed, 28 May 2025 06:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKEJg-0001BS-9N
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKEJd-0006WG-Er
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748429239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cJxQ30O1brdNnVN+LO2wNj/GWFyyylvnxOhzZ2b03pM=;
 b=XGjewiAKfeKdxnYppFdijUXr3MD6RArAclT2gWhQ++T5T8ZZXxilDlXdYFYKprF7Kq3lfu
 cmTYN53ii/v0PruG9YfMVsbWRJFviuNg/UyJl64HFHaLxt0S1RyPHYAJBP8l0dhHjCc77p
 6f31yCF23WmIalt+Z7FpacLGKD3GC0Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-U3HOFEc3Phy0L-0Ga0-hdg-1; Wed, 28 May 2025 06:47:17 -0400
X-MC-Unique: U3HOFEc3Phy0L-0Ga0-hdg-1
X-Mimecast-MFC-AGG-ID: U3HOFEc3Phy0L-0Ga0-hdg_1748429237
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4c8c60c5eso2653582f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 03:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748429237; x=1749034037;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJxQ30O1brdNnVN+LO2wNj/GWFyyylvnxOhzZ2b03pM=;
 b=YzFvEzhvxSwmPtRZPUSLgVwMGHqh0MJzQQrwXodibN/FsBNzsI8E23Vys5eaZR677S
 SwdlZrL1ORci677Tp5n/JzWtbVe8kWi479XAaE68Nbf5dd1jcBeGxAHRFT+FvWu0fZt5
 auD+4WblfFlRmK/BQdZQSVmc6oVVeW70tuNo/pQzCn6K0LrkWlHOXYkYPB1yMU1TVSMp
 fdxxEhh4Iv1bvbEJokS3TBTuIOGi2VRmCGhCNFnWa9wZLJG2WVhYei2isbq5hLQTz4b6
 vriffKdcWEcrm3nSyVGyzC4CaXyI3oD4UeL6Yd3WZxId5pofZWzr2FgliF1mDPL1vzPS
 4biQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ccM7jtTPON7lgp1yLwHndtifUiVHd/BjVk1t8WTyZ4n9n4+dIPEeqIjOV1LVk236Gu/zL/QJEBIs@nongnu.org
X-Gm-Message-State: AOJu0Ywn1o67P90MTpBZjvKU/orREM2y08GzSE0evNBp/58NyUaSTXDY
 mDR1WSyZD7naptqvgOWRyjXlerxaTKTz1FJC2LhNrwlvT8X6Dqfx6IbHPA5t7As2DLOHmXJ3Yr2
 WvBzgRh0UYlnxW+UcNFU5jImbz2qBlUl38K8sdy5Ub3dWCXp2I3jLXLhU
X-Gm-Gg: ASbGncttMhQpghdsriYBay3L3Ctb7N69AZZR6TKxGz/FQb3zBPJJC+mM7VNGMGs6afh
 YQ8RnX9n2oVRHFlI9ji5826T/nsFKiWoF+FyATZIZ80m7IQpT7u3vraqKH283cEKHsnieDdIXqb
 aSN9RlrcKtnL1DWTr7nHPg2GfpFSRNDUdgDiaYG1LDRSxHCtbBZ/SOS2XRoUS5aorvucl53Fmf1
 yaFxIvzG6/Om4bhQktOxMkEqD43pxc1wVh69vDpBYrCZLvBlAgt09RxbO8lsXN/6xSV32p6cvkz
 b+1wqQ==
X-Received: by 2002:adf:f682:0:b0:3a4:cc90:85ea with SMTP id
 ffacd0b85a97d-3a4cc908670mr12028123f8f.11.1748429236609; 
 Wed, 28 May 2025 03:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+1NPiFtsRo7xajrABLkt9VlA8TEK3NnBdyHz1/DTS013UqrVBZ1e277CUgBHh9KfjwOAWLA==
X-Received: by 2002:adf:f682:0:b0:3a4:cc90:85ea with SMTP id
 ffacd0b85a97d-3a4cc908670mr12028091f8f.11.1748429236159; 
 Wed, 28 May 2025 03:47:16 -0700 (PDT)
Received: from [10.0.5.211] ([91.126.222.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac7db82sm1104417f8f.24.2025.05.28.03.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 03:47:15 -0700 (PDT)
Message-ID: <96b8cd22-df17-4c3a-b28e-cf75268b6451@redhat.com>
Date: Wed, 28 May 2025 12:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] iommufd: Implement query of host VTD IOMMU's
 capability
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-7-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250528060409.3710008-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On 5/28/25 08:04, Zhenzhong Duan wrote:
> Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP|ERRATA] for IOMMUFD
> backed host VTD IOMMU device.
> 
> Query on these capabilities is not supported for legacy backend because there
> is no plan to support nesting with legacy backend backed host device.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h     |  1 +
>   include/system/host_iommu_device.h |  7 ++++++
>   backends/iommufd.c                 | 39 ++++++++++++++++++++++++++++--
>   3 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index e8b211e8b0..2cda744786 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -191,6 +191,7 @@
>   #define VTD_ECAP_PT                 (1ULL << 6)
>   #define VTD_ECAP_SC                 (1ULL << 7)
>   #define VTD_ECAP_MHMV               (15ULL << 20)
> +#define VTD_ECAP_NEST               (1ULL << 26)
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index 10fccc10be..c2770cb469 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -29,6 +29,10 @@ typedef union VendorCaps {
>    *
>    * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
>    *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> + *
> + * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
> + *               IOMMUFD this represents raw vendor data from data_uptr
> + *               buffer returned from IOMMU_GET_HW_INFO ioctl)
>    */
>   typedef struct HostIOMMUDeviceCaps {
>       uint32_t type;
> @@ -116,6 +120,9 @@ struct HostIOMMUDeviceClass {
>    */
>   #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
>   #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
> +#define HOST_IOMMU_DEVICE_CAP_NESTING           2
> +#define HOST_IOMMU_DEVICE_CAP_FS1GP             3
> +#define HOST_IOMMU_DEVICE_CAP_ERRATA            4
>   
>   #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index b114fb08e7..63209659f3 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -21,6 +21,7 @@
>   #include "hw/vfio/vfio-device.h"
>   #include <sys/ioctl.h>
>   #include <linux/iommufd.h>
> +#include "hw/i386/intel_iommu_internal.h"
>   
>   static void iommufd_backend_init(Object *obj)
>   {
> @@ -364,6 +365,41 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>       return idevc->detach_hwpt(idev, errp);
>   }
>   
> +static int hiod_iommufd_get_vtd_cap(HostIOMMUDevice *hiod, int cap,
> +                                    Error **errp)
> +{
> +    struct iommu_hw_info_vtd *caps = &hiod->caps.vendor_caps.vtd;
> +
> +    switch (cap) {
> +    case HOST_IOMMU_DEVICE_CAP_NESTING:
> +        return !!(caps->ecap_reg & VTD_ECAP_NEST);
> +    case HOST_IOMMU_DEVICE_CAP_FS1GP:
> +        return !!(caps->cap_reg & VTD_CAP_FS1GP);
> +    case HOST_IOMMU_DEVICE_CAP_ERRATA:
> +        return caps->flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
> +    default:
> +        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
> +        return -EINVAL;
> +    }
> +}


This is intel specific. Why not handle these capabilities directly from
vtd_check_hiod() under hw/i386/intel_iommu.c ?


Thanks,

C.


> +static int hiod_iommufd_get_vendor_cap(HostIOMMUDevice *hiod, int cap,
> +                                       Error **errp)
> +{
> +    enum iommu_hw_info_type type = hiod->caps.type;
> +
> +    switch (type) {
> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
> +        return hiod_iommufd_get_vtd_cap(hiod, cap, errp);
> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
> +    case IOMMU_HW_INFO_TYPE_NONE:
> +        break;
> +    }
> +
> +    error_setg(errp, "%s: unsupported capability type %x", hiod->name, type);
> +    return -EINVAL;
> +}
> +
>   static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>   {
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
> @@ -374,8 +410,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>       case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>           return vfio_device_get_aw_bits(hiod->agent);
>       default:
> -        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
> -        return -EINVAL;
> +        return hiod_iommufd_get_vendor_cap(hiod, cap, errp);
>       }
>   }
>   


