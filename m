Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4C8C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyLl-0008LR-MU; Wed, 16 Jul 2025 05:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubyLT-000803-1l
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubyLP-0007VO-Qp
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752657749;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dOL5e0PesikoAg6pRcQxfmzXuEAcN/D+5sdV+UGYpA=;
 b=G6Pqw1LTNaarQTLZeJ9bfljjAA1mOl/OotBMLub7CTOepHnM9z4+As4wmn0KlmE4xJaucK
 7Q1ivEDPIV7cjHx8z069HAchrMNVEZ3rHVri6XMbuKnybtDnAWbGg25iHuJh/rk3C41U4m
 eAdqzEuJNkCXYQJTpF9z+cYlOQNSvjE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-hVZtmcHVM4qKskCm-uR5IQ-1; Wed, 16 Jul 2025 05:22:26 -0400
X-MC-Unique: hVZtmcHVM4qKskCm-uR5IQ-1
X-Mimecast-MFC-AGG-ID: hVZtmcHVM4qKskCm-uR5IQ_1752657746
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so4624640f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 02:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752657745; x=1753262545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dOL5e0PesikoAg6pRcQxfmzXuEAcN/D+5sdV+UGYpA=;
 b=Qg71XLYyO0PI8D1psLQejw0nMceL68WWnMuFFSEjPBDIWNS3SuljK77iLA685AOoIa
 Ma6kYirB+DktFGGY+QwW80N2jeXTiBZfotFjkxkOt631wEcUrfWhtHk111lujUJbUwiB
 IDSppZ6myVoQ9fI5WE5Rg9ZLwu2KH+t6C8XI3fdCuWfinvwYOezuFAkkT1vemfFpz+9Z
 b8BPsbMM7isCBDzBEBCALCOY3g16m+vH32Bw0lDYSzCJM98phbWAnMKXhcfaMayMKIXl
 S4QQhBsoHfAJ5yuRERqspGHg38WBBF9+eBXu5i1xfc35uIUzHWZMvsOaV7XUd8mwRbZE
 fucQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCht/Qp6NYT3F4D6WGZ4PGh9iBpLtS1mvlwWSPSgplc6ACkU7Zgy4ONsqOUGSuaojkAfoFvLag5EKj@nongnu.org
X-Gm-Message-State: AOJu0YylF0mV3iQZve4ZZLoZUfKDnjKBBjfx42H3C7jqNrB9W2cyViYt
 KpsLEvkaqapLbjI1D6wKWAen+Z+C+JLvPMvGtlCtDN5JXj1oGQizw2tFFPKBl39rgZSB+V5jm2T
 pkTDJI0xyjcNpJJ0YcF8KNP5jVFMts2fjUHB0BadS/VY72zDt/IkeA0tn
X-Gm-Gg: ASbGnct0IjN8Kg9zTHUvXkLBUgWw0iPmW7YL45O8GpWhKPJ+DeyAfhDz/y8TvYAEHI9
 6Ds8rTsQcfOD3ORXrmXj9wwllsflPF2lodTu5Iik7IAxa1xThqGrhu1Mv0nQbsHlZ8szxgEEhB/
 VfG1KwRmEWZWdTB9qpcAWOXSRJlMuwhIslbx32gLyvjvYBJoF8lmxcy+YAdWO5InRh/+5106Zw7
 0LaZ+3YgS+ymPtDqBc+379iJnRWgGofWwZ6sfUkHoxlvkrZYivj0gQf6WGu9WwCbGAluV2fXtmB
 AkO1SUtPCg9CQaG4hnBCgY2PU2EEthxtQGLF3gGjPbLr8QaxPTMbpVSlxfvH+Wqq2bbZbrKeaWR
 zj3+nc9tQCJE=
X-Received: by 2002:a05:6000:280e:b0:3a4:fe9d:1b10 with SMTP id
 ffacd0b85a97d-3b60dd7b184mr1258571f8f.45.1752657745474; 
 Wed, 16 Jul 2025 02:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUjsRFzvR5gwhmJlOFKsOn2gR3z5KnQHSeDg9iaKZLW70+L3KdFSDYj1CjE1lP+WQEBOq7Q==
X-Received: by 2002:a05:6000:280e:b0:3a4:fe9d:1b10 with SMTP id
 ffacd0b85a97d-3b60dd7b184mr1258545f8f.45.1752657744999; 
 Wed, 16 Jul 2025 02:22:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e89c313sm15311765e9.28.2025.07.16.02.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 02:22:24 -0700 (PDT)
Message-ID: <342129d6-0b96-440c-83ac-e9b8bc5b18a0@redhat.com>
Date: Wed, 16 Jul 2025 11:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708110601.633308-8-zhenzhong.duan@intel.com>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
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
> ---
>  hw/i386/intel_iommu.c          | 30 +++++++++++++++++++++++++++++-
>  hw/i386/intel_iommu_internal.h |  1 +
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e90fd2f28f..c57ca02cdd 100644
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
> @@ -4355,7 +4356,34 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return true;
>      }
>  
> -    error_setg(errp, "host device is uncompatible with stage-1 translation");
> +#ifdef CONFIG_IOMMUFD
> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;

I am now confused about how this relates to vtd_get_viommu_cap().
PCIIOMMUOps.set_iommu_device = vtd_dev_set_iommu_device calls
vtd_check_hiod()
viommu might return HW_NESTED_CAP through PCIIOMMUOps.get_viommu_cap
without making sure the underlying HW IOMMU does support it. Is that a
correct understanding? Maybe we should clarify the calling order between
set_iommu_device vs get_viommu_cap? Could we check HW IOMMU
prerequisites in vtd_get_viommu_cap() by enforcing this is called after
set_iommu_device. I think we should clarify the exact semantic of
get_viommu_cap().Thanks Eric


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
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 7aba259ef8..18bc22fc72 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -192,6 +192,7 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_SC                 (1ULL << 7)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
> +#define VTD_ECAP_NEST               (1ULL << 26)
>  #define VTD_ECAP_SRS                (1ULL << 31)
>  #define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)


