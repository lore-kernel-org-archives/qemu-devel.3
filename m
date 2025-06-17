Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A589C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 17:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRaRs-00074y-Uz; Tue, 17 Jun 2025 13:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRaRj-00072E-Hf
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRaRg-0001J4-K0
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750182602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uUDTnH367m2YZr2J+PzST12ccxaUXG2Z3hId4PxOVU=;
 b=WnUEdokEstuZFQ0l3iQFZXJ+H4yCt+F6sLTPBAgNganR18ArnzwNmd7HfpEuFEa7+6TKgJ
 G/IlkdkjQi+8ACviiMeT0pygqYs4iNbaCzcF7xQ8JtgTfw4LVKEiKxzQRhaVSThEpo6Ont
 YISBRucJ9CcOJlSbxrTxyRNkzNxvZl0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-39jeuOLCO7iRbsTpbsucBQ-1; Tue, 17 Jun 2025 13:50:00 -0400
X-MC-Unique: 39jeuOLCO7iRbsTpbsucBQ-1
X-Mimecast-MFC-AGG-ID: 39jeuOLCO7iRbsTpbsucBQ_1750182600
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so36160155e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 10:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750182600; x=1750787400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3uUDTnH367m2YZr2J+PzST12ccxaUXG2Z3hId4PxOVU=;
 b=hj7W3FD1KG3bqHoUbyYn2AoW1wvgmzDHfd7SErkAMNREoS7Q90idVXzejju59A4Gh9
 5pvT7+3bTNkZhLVxj6OFO122gwJkAfPGGNGSelvZuOt9COwi8N2k1Z4vnEw3I8ln2Pcc
 XR7cwvebg9PO6Cj0Bl7OjqYQQH62ZQZfPJPcfbJWPq+ayvy34LFIwIpbLxnNXhZchcm9
 wQ+LLzG7XnUOD4jzmhj54AlsZspCt3PgV+xlqkXxTv5Md+IR2lo1kZbDzMAMXIkjmxDM
 0SBSS+REcDRunNlWYvYg9xWiZria/PR+r8vpQ4twx36XwOGrPLJjiImlrSlVu6KOQmRk
 kj3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1GwkF+qe367bXYwzKkT1c/qRctmn31Um/hb3Jln0VlieyYICod7juQgSP6Xce9zROrw+BLWn3bgfa@nongnu.org
X-Gm-Message-State: AOJu0Yw9ZWAMGNCKS6UCoaObrmx+q5IJ5I+1zgh6ammSWPyoX99GrYM6
 ZMOVkqfKZ2m59QOLVmYLsEo0etYUNKso+ZrBY0suEPO4hi6SayiHjgzpTkRsSSagxdjejWlqrEJ
 nkkVYhIVlZf2ZPZN1IjYlb9TGpSI0z04TETYOKw/nEtzSe05V26+oBuPk
X-Gm-Gg: ASbGncujOlDwIYMvd3mnH8j745UzZn1fABxios7t3qECXA3OY5WArTBR+SPcijWqLBy
 Vs9fIsEh+DG1W93BRxZqyBLu+2IN5RNtmJFa9bX7lorUlu5nuBy8MHNJ2ewxvKInMd2heZrZMSL
 /KRDWRGaPQ6IIRsnxwgn5tOtQLC8BL+LrINVreBS5ClWc/lkPzCxbEi3epbg5/+THk0fNhhdjFc
 1q+42O1ePfpUQ/ssamL9WLdO1rwW0+4gfwIBh54i8qFiRM4bTrfgTZgnGHhz3mvVgF7Y+PNSxyt
 dOUEmDsyFAuQSaLlwyimWHgClazJgLyRHqsPpBN8eT7D3FFlVadvvibWc8Xf/SYleJUDOA==
X-Received: by 2002:a05:600c:3e8c:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-4533ca9cc5cmr162166225e9.15.1750182599660; 
 Tue, 17 Jun 2025 10:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23FNIEVNafiKTRHqvF8XH/WJ7Y/i33oYfAqq3o7JIAkZsyyb+YLvceRu740m03eA14rU6gg==
X-Received: by 2002:a05:600c:3e8c:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-4533ca9cc5cmr162165885e9.15.1750182599279; 
 Tue, 17 Jun 2025 10:49:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14f283sm183367245e9.27.2025.06.17.10.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 10:49:58 -0700 (PDT)
Message-ID: <a8b1cf9e-260f-4659-8eac-77993ebab842@redhat.com>
Date: Tue, 17 Jun 2025 19:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] intel_iommu: Check for compatibility with
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
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250606100416.346132-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/6/25 12:04 PM, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
> is passed to host to construct nested page table. We need to check
> compatibility of some critical IOMMU capabilities between vIOMMU and
> host IOMMU to ensure guest stage-1 page table could be used by host.
>
> For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
> does not, then this IOMMUFD backed device should be failed.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  1 +
>  hw/i386/intel_iommu.c          | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index e8b211e8b0..2cda744786 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -191,6 +191,7 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_SC                 (1ULL << 7)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
> +#define VTD_ECAP_NEST               (1ULL << 26)
>  #define VTD_ECAP_SRS                (1ULL << 31)
>  #define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a2f3250724..c42ef83ddc 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -39,6 +39,7 @@
>  #include "kvm/kvm_i386.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "system/iommufd.h"
>  
>  /* context entry operations */
>  #define VTD_CE_GET_RID2PASID(ce) \
> @@ -4361,6 +4362,33 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          return true;
>      }
>  
> +#ifdef CONFIG_IOMMUFD
is it requested?

Cheers

Eric
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
>      return false;
>  }


