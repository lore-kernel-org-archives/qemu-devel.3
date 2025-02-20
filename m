Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B734C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBhb-00055K-V9; Thu, 20 Feb 2025 13:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBhZ-000556-LI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBhX-0007JL-Ql
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740077709;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OPmW/lcKlxfKDM4Ga6sPG1ct++MTnW7d23NyNSYg7U=;
 b=WQtQAmY3z9AdVP/KOG0SHjX1YnN5/XEeWCaeNJg3OEsibzu3ptH7ApCsVJosVaIfoJdHYi
 uS3AmnI2ZWyMZys6xyHozNpx3OR+Z2/ZBycroQdP9DZ3MDan5s5xl/2XQXCwP6No16PJ3J
 HayaYLGnXTxOVUoeHRp43R4MjRsV8Yo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-xGjT86QiP7SuYys3NklhAw-1; Thu, 20 Feb 2025 13:55:06 -0500
X-MC-Unique: xGjT86QiP7SuYys3NklhAw-1
X-Mimecast-MFC-AGG-ID: xGjT86QiP7SuYys3NklhAw_1740077705
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so6138825e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740077704; x=1740682504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6OPmW/lcKlxfKDM4Ga6sPG1ct++MTnW7d23NyNSYg7U=;
 b=UBzYCr3RNfV559AxiWn9XbZDs9R0DJvOJl4R5qHcznXgJvYJ44Irf35wmbhd8N+0kY
 3n4NOTIPrY/fDsDq66OFPIwNakeFluVLMuQDAmnmugH4UPDsU6BHT2RzjgvjW4hjeypH
 s6ktk10LDljZjTqA4wId6Xi2Z1Km1yw1g5+F5ZPc4l2060Tao6W4anXaycatFVDA8NjV
 fEvbgRMv8IqbHf1GpDKK4DyKtosn+AAgLej6IAq6Vlh0HwXZyaGDyF2iDCzemvKJoWxt
 691/Vo/Ua0SEaQVrWzpQaeoAU0BVWN3YkvUt48+VLycwzZkF3AR6kWfrYpS813K5owjp
 JBQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8go4RaaMHl3Hr57AY7Dwhto1Rv1LVY81NyirEEL8autsEyghSmFTYm5eMY49UiA3E2T1UUOE/GLax@nongnu.org
X-Gm-Message-State: AOJu0YzBonHi0GnxMMR+E9NcmMHNUD18TinFVNVrLjd+65Em2DPCeKcy
 ERVkhWC0WabLYhGTlbY1kAMUnGN4PGUj6+LLTewjsm/31FbeVGq4ZTaBOi3dYBMejNnBYV+g1VB
 bZz+N8bGhpyb+WCVic8d0NeBTfxNFnPeQov9pNowsGXKuTpgT9LiWaeOgCjDw
X-Gm-Gg: ASbGncvtQUyKbkqGC1HlBt9aS1bCCaqanlw8VV6Q6x/YD8e0hjpGYarVI2i2ET20Y8R
 AyTJWnai2axhVTDjnz+iiDPVydyh7OaU2cj+sZzxwtDSRQM9EUtiPMrrL2ygiDa74xY1/EXwLfu
 jSZH8JaKrQwyDDKHl6i+CsIKEilF1VppQDnKQ1fvI3sP5AON/dy0DRBSfuoy8StF5zqxI9fe2eR
 UqLnaAABjJQFv6iPVTK5g8hPaAOOylUpMdyLR4aA4El+NCFseqB+t2eHRYC80MyO5sZvbH9dSIF
 98DNGv+O4lmqciuVpI4Nnz8E4Ezr2oNw9aWI082RgSpP/4BxfyOP
X-Received: by 2002:a05:6000:1f8e:b0:38f:394f:d83 with SMTP id
 ffacd0b85a97d-38f6f0ae2acmr337949f8f.48.1740077704356; 
 Thu, 20 Feb 2025 10:55:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnlLWFpQheaNC5m+FYhnqZEVtdCHwh5tvun5HQu5hB5Pip2yC31wb6s9/qV/4qDDVv9qCSDw==
X-Received: by 2002:a05:6000:1f8e:b0:38f:394f:d83 with SMTP id
 ffacd0b85a97d-38f6f0ae2acmr337935f8f.48.1740077704005; 
 Thu, 20 Feb 2025 10:55:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4335sm21742409f8f.15.2025.02.20.10.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:55:03 -0800 (PST)
Message-ID: <e114b3ce-f470-444c-8aef-cd89f42da93b@redhat.com>
Date: Thu, 20 Feb 2025 19:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 08/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_ERRATA
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-9-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> Implement query of HOST_IOMMU_DEVICE_CAP_ERRATA for IOMMUFD
> backed host IOMMU device.
>
> Query on this capability is not supported for legacy backend
> because there is no plan to support nesting with leacy backend
legacy
> backed host device.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/host_iommu_device.h | 2 ++
>  backends/iommufd.c                 | 2 ++
>  hw/vfio/iommufd.c                  | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index 18f8b5e5cf..250600fc1d 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -32,6 +32,7 @@ typedef struct HostIOMMUDeviceCaps {
>      uint64_t hw_caps;
>      bool nesting;
>      bool fs1gp;
> +    uint32_t errata;
to be consistent with the others yu may have introduced this alongside
with the 2 others?
This is also not usable by other IOMMUs.

Eric
>  } HostIOMMUDeviceCaps;
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> @@ -130,6 +131,7 @@ struct HostIOMMUDeviceClass {
>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
>  #define HOST_IOMMU_DEVICE_CAP_NESTING           2
>  #define HOST_IOMMU_DEVICE_CAP_FS1GP             3
> +#define HOST_IOMMU_DEVICE_CAP_ERRATA            4
>  
>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 0a1a40cbba..3c23caef96 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -374,6 +374,8 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>          return caps->nesting;
>      case HOST_IOMMU_DEVICE_CAP_FS1GP:
>          return caps->fs1gp;
> +    case HOST_IOMMU_DEVICE_CAP_ERRATA:
> +        return caps->errata;
>      default:
>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index df6a12d200..58bff030e1 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -848,6 +848,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>          caps->nesting = !!(data.vtd.ecap_reg & VTD_ECAP_NEST);
>          caps->fs1gp = !!(data.vtd.cap_reg & VTD_CAP_FS1GP);
> +        caps->errata = data.vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
>          break;
>      case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
>      case IOMMU_HW_INFO_TYPE_NONE:


