Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E9CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 08:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEkCL-0006LD-9O; Fri, 31 Oct 2025 04:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vEkCJ-0006Kd-04
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vEkCD-0007cx-GA
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 04:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761898152;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0+5gqv9VOs85bmbQbEwidjxvMub2Y6ghknO7kleT8E=;
 b=b/NYuy/hu7RRdsKRTxZVXhZsiAqukOR9RcGUaGwCoETPr3F9NGklL4mNmzKl41C2Fe0yyu
 3e6KmAyAgjlFIjsyveQphqiuUM0VJjnlOpbNI5tSg/oWJ7AFCZLM6aIYwI+MU5Qa+Bl89G
 DJIUhO0q1JIEyXm+SHWwIJnX+P+DFMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-tMlK5it5PESKed7JsprgIw-1; Fri, 31 Oct 2025 04:09:10 -0400
X-MC-Unique: tMlK5it5PESKed7JsprgIw-1
X-Mimecast-MFC-AGG-ID: tMlK5it5PESKed7JsprgIw_1761898149
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429af6b48a8so2092213f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 01:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761898149; x=1762502949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0+5gqv9VOs85bmbQbEwidjxvMub2Y6ghknO7kleT8E=;
 b=Z0kHR2tMCMwRJiTgiNOyhfqR654U3QlWlGWt5k0bVKcDEz0YsFEipIkdRoVZxWb34k
 JJq5Q6ACTJjztDJqlbNVb3DQqXU0qANikc1lj97q3+MlXrtmw7HRKN7/XzrwE5yhyoim
 r/t0pl0PpZ77I/uGYmsSayCeB7tElotmAOrKDi3osDaypAi/mLTb2TS+/1BCyFwfRYip
 zndaL66AQBGGkSLvd/rGsJP1RdQUmZVcqueU3/rANwqtVooRrudplj2cHxxl05J29Rgo
 YU2EyRX69Etch1C7+cZthR2i7yIjfeUed5BlcORUeRlEIsWpZnQhX2OSQ7T9l2wMpVKk
 NVxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2w7S56wr1sONpeo+NrR5y+oOeqPAcj0WgtR3h8TkxCLtE0AqcjAzOZUfqDop4BUbQtxvmT6jzSCSG@nongnu.org
X-Gm-Message-State: AOJu0YxHFX2zf64v3eaa6wQMfI5uk/1oubOZCrFzrY4JeyDcxFcJi3Nv
 ocedAg0n5NPufLcYPXvOyeWbAzUECHpTofktEy5csfVU1n0q7bb6RrttZYzAyNOjPI61OAEKSCA
 icu/ZBX05bN0743wKfYwhz94uFh6pXdT+E9DL4gCwb316Y/XEX7B/CWH5
X-Gm-Gg: ASbGnctYQg7121aH+6U9ZISneVoOd/a7QvlMvOpZrP24euvQxgvn4fn1dw+myAlP/sE
 3pdy8QOZLVA60rhbfld5dCY9rDJL0rY33wEBa659NB0CiPcX57WRJeU3bKmUc5Gd+0eknYS5+m7
 pJeYJU8LLjXoLw6+qJq1FF0atD3hNRgrzBZ5eWlr0tGcm0+XsLdQFLjHQIa1UCLdfV4igUJ6ojK
 r6TkARN2qTB/nD+XkiiHsUvlbFr4jpn3zZshiOAslvlH6fpE2YZC8g2EKmi4gI8vysdaB6UpgH0
 0bbjx2oMBmFqEbdcmPqb4qxCANTNcj6by77IL/1UyiQN4Yw0RSameTkRdg8TVdWielM+aVmyXhl
 EpLtoWNvHLbKdFzWpkpjrcl3FyLStLZOVxQlefnEVNRTStQ==
X-Received: by 2002:a05:600c:820e:b0:475:de12:d3b2 with SMTP id
 5b1f17b1804b1-477308a6da5mr25467775e9.36.1761898148907; 
 Fri, 31 Oct 2025 01:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFknTLua7JG8KwW8svfiubdFR3wc7ri45LcPTxD599iZNU7zr9pFVBJLAbseK+5SSif17tc5A==
X-Received: by 2002:a05:600c:820e:b0:475:de12:d3b2 with SMTP id
 5b1f17b1804b1-477308a6da5mr25467385e9.36.1761898148422; 
 Fri, 31 Oct 2025 01:09:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732dc28ebsm19507725e9.2.2025.10.31.01.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 01:09:07 -0700 (PDT)
Message-ID: <d9eedc35-1548-4011-8eb3-5f6a4dcefe51@redhat.com>
Date: Fri, 31 Oct 2025 09:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/23] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-10-zhenzhong.duan@intel.com>
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

On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> When guest enables scalable mode and setup first stage page table, we don't
> want to use IOMMU MR but rather continue using the system MR for IOMMUFD
> backed host device.
>
> Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
> as nesting parent HWPT to construct nested HWPT in vIOMMU.

we had a discussion thread with Nicolin and Shameer about usage of AS
for nested SMMU
(https://lore.kernel.org/all/add07edd-3652-430d-b52c-cb2bdbc7f587@redhat.com/)
If I understand correctly you also rely on system MR for nested. I am
not sure this is a good usage of the API/AS objects as in practice you
have an actual translation in place (althout implemented by HW) while by
using the system MR you do not reflect that. I encouraged Shameer to try
using a dummy dedicated AS that can be shared. I think it would be
better if we could align the strategies.

>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4c83578c54..ce4c54165e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -41,6 +41,7 @@
>  #include "migration/misc.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "system/iommufd.h"
>  
>  /* context entry operations */
>  #define PASID_0    0
> @@ -1713,6 +1714,24 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>  
>  }
>  
> +static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
> +{
> +    IntelIOMMUState *s = as->iommu_state;
> +    struct vtd_as_key key = {
> +        .bus = as->bus,
> +        .devfn = as->devfn,
> +    };
> +    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
> +                                                       &key);
> +
> +    if (vtd_hiod && vtd_hiod->hiod &&
> +        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        return vtd_hiod;
> +    }
> +    return NULL;
> +}
> +
>  static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>  {
>      IntelIOMMUState *s;
> @@ -1738,12 +1757,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>  /* Return whether the device is using IOMMU translation. */
>  static bool vtd_switch_address_space(VTDAddressSpace *as)
>  {
> +    IntelIOMMUState *s;
>      bool use_iommu, pt;
>  
>      assert(as);
>  
> -    use_iommu = as->iommu_state->dmar_enabled && !vtd_as_pt_enabled(as);
> -    pt = as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
> +    s = as->iommu_state;
> +    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
> +    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
> +
> +    /*
> +     * When guest enables scalable mode and sets up first stage page table,
> +     * we stick to system MR for IOMMUFD backed host device. Then its
> +     * default hwpt contains GPA->HPA mappings which is used directly if
> +     * PGTT=PT and used as nesting parent if PGTT=FST. Otherwise fall back
> +     * to original processing.
According to the above comment you have a S1 translation in place but
you set use_iommu = false and use system MR?

Revoking my R-bs for now because I am not convinced we shall use system
MR when S1+S2 is setup. I may be wrong but at least I need more
explanations ;-)

Eric
> +     */
> +    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
> +        use_iommu = false;
> +    }
>  
>      trace_vtd_switch_address_space(pci_bus_num(as->bus),
>                                     VTD_PCI_SLOT(as->devfn),


