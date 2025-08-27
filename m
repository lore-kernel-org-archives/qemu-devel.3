Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2950CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urElF-0007DY-Ll; Wed, 27 Aug 2025 07:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urElD-0007CA-QR
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEl4-00074d-Fp
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756295760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3D22a7cKGzBlAUnIpaPjGJhGxLKu7IwjgELp06xQ28Y=;
 b=S+dM3Vmq7OdTiP8YaBankl16/sDGEoEQ/lG2gOngkNnZBTajXKl+GWqDc7gMIDbdeclS88
 zQ7AaxkAkW1N/o/TMMdIcnppaCJfp/c3webIm4Y9xqVyuhv1tCDSccQjMDoBedq/uO+1Xc
 djTVDgpNd2y6EfV3TSuZL2WKalPDu1M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-0K2Ec-KnNLStNdxlvwdWww-1; Wed, 27 Aug 2025 07:55:58 -0400
X-MC-Unique: 0K2Ec-KnNLStNdxlvwdWww-1
X-Mimecast-MFC-AGG-ID: 0K2Ec-KnNLStNdxlvwdWww_1756295757
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c456849a25so177392f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 04:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756295757; x=1756900557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3D22a7cKGzBlAUnIpaPjGJhGxLKu7IwjgELp06xQ28Y=;
 b=fO+BEUE5V+KzHUMRPt/Gt+9jMTW89jVrULNxlQbNeEuKspojxvS9EDDOHiS1swr2bf
 JJLeHsNapEv4Qp9jksN5RzqLT5DxzZzeFTVBBmkxNBVxlvAc60b3p55Jn4SnNOvNGcl/
 VrDpJROt1SId4RI6HHUx7iOQnXoKP2BOjZXx9ivWINT6w6oqpa24gutFc10qgaPArlYc
 Dng9ugSfuvcjdm1314+hcGXy4yg+tboCQxYqkHszrB+Aa0RiwVjM5tX3CJ03c9MrYr1r
 kSG4h2WfDtTNAZRdZkHYMz5B0OSlZ9tWuI/Hwp0fjhMttZm6SgQ/oXm6/K4mhPeX2BHU
 wSvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURkYdJINFBtEbsaszQRiCdx7TALYC/VcOyZuZo22Yp3pAJdDylVwHoHpjly0MViZxSxmDC7d4lve2Z@nongnu.org
X-Gm-Message-State: AOJu0YxsUQqMujm1JWn48euM9EHgcIVkmEgeq+KLeuOoauQlLtJFEgED
 FtzNcjXcQB3mQcLi7eYHh1ludS9yOfQvW4m6mL4XJx+GGVwevah4VnM0ZgX0ksiGO8crk2MJ1C5
 Ey1u7YgJTlyRzC58XqHUAxCStysh6+mAo8K2d2JuEX5dqO4S2VzB3H3Ds
X-Gm-Gg: ASbGncsOycKVp4urMYX8w0aJBCZfEVsFyjr2wRwOSR31j8oDdpjeRlBIcNnUGhyfmFz
 Qa+GFsszRqFl+gwiAz/gEPqY0xqmPHJL2gj81JH2/NHrexL+dNLFF++q6ITWe1lY1DUKyc5g3/O
 lmVcc4UM7rE+u7r0XT0CSasFXswnKD1Sey97GADWkxBx9iFtuAgPhsPEcEcSkXP2dwEHCJbiCjZ
 zLw12CAeDrx2GHrhZEdwJZVKl3/9KkL5IeAeUKfYbGgQrDR4a5biP4kMlTUWszIzv22YyOPxWST
 ulmRObNf2YDgfpU52Inz18AN2Ds+rgHFMwbCTtePdGNJzP+AWgKVaNELddl8kqhbHfj2WVOcHCD
 xqIF5O6j3K98=
X-Received: by 2002:a05:6000:21c9:b0:3cc:bb5c:e82a with SMTP id
 ffacd0b85a97d-3ccbb5cf788mr953622f8f.3.1756295757154; 
 Wed, 27 Aug 2025 04:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPjr2DBKg4oQuHGFZb2gkMebwj3vZlYPv2fVcfIUJDvfusEoxB0PbUVy09shDYu3GKhJgXWw==
X-Received: by 2002:a05:6000:21c9:b0:3cc:bb5c:e82a with SMTP id
 ffacd0b85a97d-3ccbb5cf788mr953607f8f.3.1756295756689; 
 Wed, 27 Aug 2025 04:55:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cc98998781sm2821698f8f.49.2025.08.27.04.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 04:55:56 -0700 (PDT)
Message-ID: <d1767208-7448-4f50-b685-f5f1fac3ab24@redhat.com>
Date: Wed, 27 Aug 2025 13:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/21] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-9-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
> is passed to host to construct nested page table. We need to check
> compatibility of some critical IOMMU capabilities between vIOMMU and
> host IOMMU to ensure guest stage-1 page table could be used by host.
>
> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
> does not, then this IOMMUFD backed device should fail.
>
> Even of the checks pass, for now we willingly reject the association
> because all the bits are not there yet.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/intel_iommu_internal.h |  1 +
>  hw/i386/intel_iommu.c          | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c7046eb4e2..f7510861d1 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -192,6 +192,7 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_SC                 (1ULL << 7)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
> +#define VTD_ECAP_NEST               (1ULL << 26)
>  #define VTD_ECAP_SRS                (1ULL << 31)
>  #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
>  #define VTD_ECAP_PASID              (1ULL << 40)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 512ca4fdc5..da355bda79 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -40,6 +40,7 @@
>  #include "kvm/kvm_i386.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "system/iommufd.h"
>  
>  /* context entry operations */
>  #define VTD_CE_GET_RID2PASID(ce) \
> @@ -4366,7 +4367,34 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return true;
>      }
>  
> -    error_setg(errp, "host device is uncompatible with stage-1 translation");
> +#ifdef CONFIG_IOMMUFD
> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +
> +    /* Remaining checks are all stage-1 translation specific */
> +    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
> +        return false;
> +    }
> +
> +    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
> +        error_setg(errp, "Incompatible host platform IOMMU type %d",
> +                   caps->type);
> +        return false;
> +    }
> +
> +    if (!(vtd->ecap_reg & VTD_ECAP_NEST)) {
> +        error_setg(errp, "Host IOMMU doesn't support nested translation");
> +        return false;
> +    }
> +
> +    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
> +        error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
> +        return false;
> +    }
> +#endif
> +
> +    error_setg(errp, "host IOMMU is incompatible with stage-1 translation");
>      return false;
>  }
>  


