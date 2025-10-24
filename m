Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E303CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKuE-0006L7-UE; Fri, 24 Oct 2025 12:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKuA-0006KO-MT
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKu8-0004CE-Km
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761324279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qQbywWN35EL6EHEDA2f+DdynI7ul4AhmRqmNo0ONzkY=;
 b=IU8Bv8JvNceeaAHIlVgaOrIPmowXMhKVE7W5jzQfVfr+IXopwygCXvgU6B5gNpJiTMPs5/
 +jbsFqB5aCvb9uLmP5P44QEP4O6KvJJiYu7oCzH1dGq0pdIrAj9U7YwogznXeOEIukeiLc
 pAaBMVn5vdpqOoI4Np2I31rfabD14lY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-9hk-eSpKPAiJ1cAE4dIaIw-1; Fri, 24 Oct 2025 12:44:35 -0400
X-MC-Unique: 9hk-eSpKPAiJ1cAE4dIaIw-1
X-Mimecast-MFC-AGG-ID: 9hk-eSpKPAiJ1cAE4dIaIw_1761324274
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so1317587f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 09:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761324274; x=1761929074;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQbywWN35EL6EHEDA2f+DdynI7ul4AhmRqmNo0ONzkY=;
 b=NGOrBqmKCIptPd/34DFKQh+rdM+g3s3n2oK+pXTg6aFPusGlTvNzLLAF1xNekNjn4Q
 bNSRPSQ/ucpn1atSRg3yNd/f0BvksUJnqv3ZuVL1B2wGJgLAHVheeStkUGsLT2Bq91nV
 ZciK06hX9bzrzRL1dedQ8UtQT1d/J/+OIJL3ClXmL8x7Zaig6XSqEDWwSxyu22+PifZT
 dbQg5cFhF7IZC4x0WChnHYuxzAp7KagvRzY1afUAKbIeiRjHTtsjGeQEbx2kOGJqMYpZ
 ZgD7baOP6ibREE7zE/ZPJIdexMtTwA6cx4i0VRQ3Crs3PZ+P6kUGeYEDzX/6PkyyKRp4
 ZWgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpnRBySEsIrokpefJgQfO1QYLP0ylrhHEUAXWSMgdK4EpFezsjQIhkDuCAZlKFZg6RSnTVgCFJQpiT@nongnu.org
X-Gm-Message-State: AOJu0YzKkFr+VFcupExytrZ55bAmj0xy+heTpaPmer7mfMQt9LCenlAV
 aZ3JG649w9IZzPkzAJQ/rUTN8j6TaiCFHGQZXgs1vJ0E9ZIg3dGjWUPcLhkJixGboBMp2ll2Ulf
 iuyw+5QgOejSe7QYmgY9SCuoRUTth591sOmgTA2rFFY9YcDli2Zj8pHuD
X-Gm-Gg: ASbGncuchF1gk3SA2qAOjO0p7DY9bWhdC3E6rc35XqVEd0UxptzCqxoPq4EiXl08gYh
 jSLtFnMXJDZxA+VMMM4nK/S5MTeGN2WMhDL9MaztsCXauRUupD/kHNebNP9a0TR6DFoPfi9+gQZ
 Vg63eky9gXh8llqxOwyVvah61bI49OzFK+bkaMu9A7mDG4Tpp0dSTAvYROmBM0Ivukf2heQTDu0
 QQ2XNt9MsQRUjBQb9daA0wLD++XUDYGHZg5/PUzv6UcRGGKA//In/pGv4xRXGI69hmoGxMeBDkY
 NtX2NnPbtwHol3zBhNPxn9aIbsBRC00+w0KAg8bre0N5l0/l4zMwFxm/O4Ud5O2vMC4iCDeZ
X-Received: by 2002:a05:6000:4212:b0:427:546:4378 with SMTP id
 ffacd0b85a97d-429907170c3mr2741203f8f.20.1761324274449; 
 Fri, 24 Oct 2025 09:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNYP+oAd2dwxMQKtwjqiCViN6cc6YlzS9BXuowxZcskfVoSGeCYnqISmbLJg8dwUWLKgAMyA==
X-Received: by 2002:a05:6000:4212:b0:427:546:4378 with SMTP id
 ffacd0b85a97d-429907170c3mr2741188f8f.20.1761324273951; 
 Fri, 24 Oct 2025 09:44:33 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42992e47f6asm1895635f8f.33.2025.10.24.09.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 09:44:32 -0700 (PDT)
Message-ID: <647cfdb2-6dee-4831-920e-a6440829c201@redhat.com>
Date: Fri, 24 Oct 2025 18:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/23] iommufd: Introduce a helper function to extract
 vendor capabilities
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-18-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-18-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/25 10:43, Zhenzhong Duan wrote:
> In VFIO core, we call iommufd_backend_get_device_info() to return vendor
> specific hardware information data, but it's not good to extract this raw
> data in VFIO core.
> 
> Introduce host_iommu_extract_quirks() to help extracting the raw data and
> return a bitmap in iommufd.c because it's the place defining
> iommufd_backend_get_device_info().
> 
> The other choice is to put vendor data extracting code in vendor vIOMMU
> emulation file, but that will make those files mixed with vIOMMU
> emulation and host IOMMU extracting code, also need a new callback in
> PCIIOMMUOps. So we choose a simpler way as above.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/hw/iommu.h                 |  5 +++++
>   include/system/host_iommu_device.h | 15 +++++++++++++++
>   backends/iommufd.c                 | 13 +++++++++++++
>   3 files changed, 33 insertions(+)
> 
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> index 9b8bb94fc2..6d61410703 100644
> --- a/include/hw/iommu.h
> +++ b/include/hw/iommu.h
> @@ -22,4 +22,9 @@ enum viommu_flags {
>       VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
>   };
>   
> +/* Host IOMMU quirks. Extracted from host IOMMU capabilities */
> +enum host_iommu_quirks {
> +    HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
> +};
> +
>   #endif /* HW_IOMMU_H */
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index ab849a4a82..9ae7f4cc6d 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -39,6 +39,21 @@ typedef struct HostIOMMUDeviceCaps {
>       uint64_t hw_caps;
>       VendorCaps vendor_caps;
>   } HostIOMMUDeviceCaps;
> +
> +/**
> + * host_iommu_extract_quirk: Extract host IOMMU quirks
> + *
> + * This function converts @type specific hardware information data
> + * into a standard bitmap format.
> + *
> + * @type: IOMMU Hardware Info Types
> + *
> + * @VendorCaps: IOMMU @type specific hardware information data
> + *
> + * Returns: bitmap with each representing a host IOMMU quirk defined in
> + * enum host_iommu_quirks
> + */
> +uint64_t host_iommu_extract_quirks(uint32_t type, VendorCaps *caps);

..._get_quirks() sounds nicer. This is minor.


Thanks,

C.




>   #endif
>   
>   #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 086bd67aea..61b991ec53 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -19,6 +19,7 @@
>   #include "migration/cpr.h"
>   #include "monitor/monitor.h"
>   #include "trace.h"
> +#include "hw/iommu.h"
>   #include "hw/vfio/vfio-device.h"
>   #include <sys/ioctl.h>
>   #include <linux/iommufd.h>
> @@ -411,6 +412,18 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>       return true;
>   }
>   
> +uint64_t host_iommu_extract_quirks(uint32_t type, VendorCaps *caps)
> +{
> +    uint64_t quirks = 0;
> +
> +    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
> +        caps->vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> +        quirks |= HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
> +    }
> +
> +    return quirks;
> +}
> +
>   bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>                                         uint32_t data_type, uint32_t entry_len,
>                                         uint32_t *entry_num, void *data,


