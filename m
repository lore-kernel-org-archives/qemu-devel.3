Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D647C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSaVS-0008T0-7y; Fri, 20 Jun 2025 08:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSaVP-0008Sj-FU
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSaVM-0004kZ-If
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750421158;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAFg9Mjw9QBNgi09QFazoCt+hrJTtxd4d5823JObsGk=;
 b=cZenMtQcsNizLkiu6fKQvpYfF0LHlnd3BD4LhD1eq6vkMIoTDznVmTXvajFWxKSPj2THGB
 /z/ZNejiAG4Y7mR3fDnh7Sv/2bmK5Hxb1sFfykC3CN9YGdF3yAKkT6aEyRMlCgTfH4llnZ
 mpVi7ly46KxY7QM3gRrSuat9uGa2RAo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-nHDtIF6QNXG-o5PA3r-Hkg-1; Fri, 20 Jun 2025 08:05:54 -0400
X-MC-Unique: nHDtIF6QNXG-o5PA3r-Hkg-1
X-Mimecast-MFC-AGG-ID: nHDtIF6QNXG-o5PA3r-Hkg_1750421153
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso13849775e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750421153; x=1751025953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAFg9Mjw9QBNgi09QFazoCt+hrJTtxd4d5823JObsGk=;
 b=j6Owc2Xc0UlLKv+SI9cqGFNDZOb4/BdfD2k2NCcPD3WuAd0zyUu/+yVgNoVe9qWhnv
 IhkFon3vJEWSuV92GpzQ5UGMsRQD68Qfjjhg9/O/wMnutScBaoI3xiS0yXFipXbUzA9q
 yONF1ISDAOifniByn5t87Va3Thsl8lume/4nRnDm+x8bgaYTooTdLM2LyyjtmSGf/tdw
 aXkqdHLqzrBOHyJmh62xT/8+v3UuTrSd7vYcwDYar0oc51fumnDEn838+W2fp9HLMa+6
 yit+0bZtfJk2JMHGMjs1UnUYAGJVKghpkF5FtBxJWsMYi5dG0Jb+jX4NnDilQhrpLtMd
 l5ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAGUMGOUD6kPwKoFxksFEz2+l3FmsFmlxAyu5L8xOXxWaX4WAa8IQu7NS4BqFrhd3neHVz26Iqsn2v@nongnu.org
X-Gm-Message-State: AOJu0YyKnpF4Kzdk9Pt1cw8LPiu4kGZG1iXka8V8dtqb684mXf+oWLzK
 L5CHXTunAm+Ou6CEZ9W9jcf9LR5m4LLqpZ14nezeN43OIvPpBzrc5YSUfwAokVKa9kUj4kEAfkh
 Dex3+yoVFox7bVlzgSKpBdI8uDY9y+H5ypFlYsGvusGH66VlKmTNXElEs
X-Gm-Gg: ASbGncud2yUAsx3Jt6jgg99JNovNBJrvNCBTtl1trBu58EgB5eIuFwNGrXLGss44rsg
 Q4n+vjlG7lvaqrrrn/CeQMJt9RMhqgOmcnFw6+wbN5r2Gn+AGM1Qx26NwatJVqZocONEqqeOWab
 GL62DD3cjFIdkHgppc2fnie37uYw+RdG2UEyjg9sR1RKWhFDoLH4uARWE02E9PNttZ6rwe8uqDV
 LUXXSutnbdRLs+AyS62VeetJZmwFs72dDAlTyH0Ja+gMWK2bgJThnPLWC9kj+QNZ+UJ0xrW9Tiy
 PrE4dfnSz40hdW2KPQ9LDQslgJjUzFOfHre9absyNaNO5WI6KYYuBrOuedCsmSoI9giF/Q==
X-Received: by 2002:a05:600c:871b:b0:453:ec2:c7b2 with SMTP id
 5b1f17b1804b1-45365e3dfc0mr20663295e9.7.1750421153300; 
 Fri, 20 Jun 2025 05:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmMwdPp6HPxDvPOfmhiCHNuzqrdjq9OA5ON0dEoYqgUkr2MuoB7GZwqI5vu71Jrt+2/7+niQ==
X-Received: by 2002:a05:600c:871b:b0:453:ec2:c7b2 with SMTP id
 5b1f17b1804b1-45365e3dfc0mr20662795e9.7.1750421152849; 
 Fri, 20 Jun 2025 05:05:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead202asm57034835e9.27.2025.06.20.05.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 05:05:51 -0700 (PDT)
Message-ID: <b860ed2b-fa73-45a6-9958-a4da0e5f3811@redhat.com>
Date: Fri, 20 Jun 2025 14:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/19] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Zhenzhong,

On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
> is passed to host to construct nested page table. We need to check
> compatibility of some critical IOMMU capabilities between vIOMMU and
> host IOMMU to ensure guest stage-1 page table could be used by host.
>
> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
> does not, then this IOMMUFD backed device should be failed.
s/should be/should

You may add in the commit message than even of the checks pass, for now
we willingly reject the association because all the bits are not there yet.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  1 +
>  hw/i386/intel_iommu.c          | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
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
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e90fd2f28f..1c79efc1cb 100644
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
> @@ -4355,6 +4356,33 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return true;
>      }
>  
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
>      error_setg(errp, "host device is uncompatible with stage-1 translation");
s/uncompatible/incompatible
s/device/IOMMU
>      return false;
>  }


