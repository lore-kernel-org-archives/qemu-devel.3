Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B429CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bug-0006wP-0E; Tue, 30 Sep 2025 11:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3bue-0006w6-J8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3buX-0006NJ-3E
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759244697;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMy5Q/7/ZrZPO0XrFxLT6SJslYH0ttADcXH3nRvMBCw=;
 b=IHtwxzNCccpEVT9elPS7I8qgXeoI2FY1EO5G3P5mBnofFiInyOl0q4hXS9Ps5FPgGdPQFQ
 Zf/D/Ahd2PE6g/71G+y6qb7+4gxl+RIXy1TGfAVczm7Jnr8LswC28kVPiODeQqRkSaRrnn
 SOPy62dsizFPEHRZT8MtVwrvUgroA4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-hSZ2zdzvNu-PskYliP6dRw-1; Tue, 30 Sep 2025 11:04:56 -0400
X-MC-Unique: hSZ2zdzvNu-PskYliP6dRw-1
X-Mimecast-MFC-AGG-ID: hSZ2zdzvNu-PskYliP6dRw_1759244695
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e38bd6680so20657435e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 08:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759244695; x=1759849495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QMy5Q/7/ZrZPO0XrFxLT6SJslYH0ttADcXH3nRvMBCw=;
 b=QxQS/+ZQyDtlzcLRMNlYxFyTJgI408/aRIUAUcT5Y1YpjPjQVCf85k43qr4QQ/cQJ5
 kDtFWHa7qLQgNSy4BIRvqpqsxA9q7KxCW/5zkmjim8f47JtFOwDymso76nuea4OQi7Em
 Unh4SXlLNPThNvL/vWg3YQ2p0xMeNHvCDn6J7vObwLGqMhJE2ulvCDF15HTR75tWFoUY
 lZX3gFIg89P4cy8ZvJP1hsSYsMeBEuw+is6/f33YBIrO/88wqEuUEaOsORrJR+QRNEaI
 pDNpjlNpieirhVfubuMzu+nDTPBI5ez/dmFqkvXSIASjqJqn+IX/EHIPbuSyW8e0Wp9O
 c5gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXuN9w8MfmKFuJnr3he9qdF3qzIHQ5tRJDRKp8u9jufnoXfxAyzkRUnuC7LOh1vPt6oRcj6CXpHwzY@nongnu.org
X-Gm-Message-State: AOJu0Yw9CPm6+FifbEjkgGIn3Orfe2WePVUrWBSdSoqoyEHjS8SmXKH2
 E+tXuYU/dnmuBxlsmZk4r7VLal87CySqKlKGq3dfuM9HjzZC1Gbo+SMsZLf1/Mv5T9MhUFR8Pqg
 XzRTEnJURWx7HOcHEwD91R5HPBqqVTbTNnCq8wbvrWAV8B97EogjtjuoA
X-Gm-Gg: ASbGnctgz+/rxOts6QnjX1to2n8XuuuBxyrmcJ8gMVpAk1WAsAz0Jyrz99HSTNpjYJy
 57jmIXIzlqAfN3abBUNijv5SJLDpAbcrVM2hvV6YKff3h9wXXJTms7eL00OBYOtDLipWYpKcphj
 4Yl1umFoDouvTa4fPxB1Py4/9tYgz5dnarnL148aigxn9pMMQd3z2spgPZ2EdM5w8qbTAudIY9R
 Yi+jSMyJXpoglzdYWQp3dXxXDsYj6ovrlrLNuZSYwEddMGVmrLeMmkjcoiQkX7yvO6GxPzStZYj
 yiYWcKp/Jzbd3+wLxyIWF2esL/2L57mBm/QFtx4AUCsNXnyZhRRCJxS6LgSvFE2a/7n1UeJ9Vxi
 7MsE5QPBoBxDdKOCK
X-Received: by 2002:a05:600c:c0c5:b0:46e:59bb:63cf with SMTP id
 5b1f17b1804b1-46e612691efmr1386245e9.24.1759244694569; 
 Tue, 30 Sep 2025 08:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrqRwb+CLKWakHHcng4ppKPTALZ+3g3aI0O/iiHlMjaRNyZ2B1BAU8OsY4lKFb8D5Lx/rIUg==
X-Received: by 2002:a05:600c:c0c5:b0:46e:59bb:63cf with SMTP id
 5b1f17b1804b1-46e612691efmr1384775e9.24.1759244692660; 
 Tue, 30 Sep 2025 08:04:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b69bc0bsm15747785e9.3.2025.09.30.08.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 08:04:52 -0700 (PDT)
Message-ID: <0cfac891-cc6c-478a-9e6d-fc5dc44f0239@redhat.com>
Date: Tue, 30 Sep 2025 17:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/22] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250918085803.796942-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/18/25 10:57 AM, Zhenzhong Duan wrote:
> When guest enables scalable mode and setup first stage page table, we don't
> want to use IOMMU MR but rather continue using the system MR for IOMMUFD
> backed host device.
>
> Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
> as nesting parent HWPT to construct nested HWPT in vIOMMU.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ba40649c85..bd80de1670 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -40,6 +40,7 @@
>  #include "kvm/kvm_i386.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "system/iommufd.h"
>  
>  /* context entry operations */
>  #define RID_PASID    0
> @@ -1702,6 +1703,24 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
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
> @@ -1710,6 +1729,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>      assert(as);
>  
>      s = as->iommu_state;
> +
not needed
>      if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
>                                   &ce)) {
>          /*
> @@ -1727,12 +1747,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
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
nit: init could be done at declaration
> +    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
> +    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
> +
> +    /*
> +     * When guest enables scalable mode and setup first stage page table,
sets up?
> +     * we stick to system MR for IOMMUFD backed host device. Then its
> +     * default hwpt contains GPA->HPA mappings which is used directly
> +     * if PGTT=PT and used as nesting parent if PGTT=FST. Otherwise
> +     * fallback to original processing.
fall back?
> +     */
> +    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
> +        use_iommu = false;
> +    }
>  
>      trace_vtd_switch_address_space(pci_bus_num(as->bus),
>                                     VTD_PCI_SLOT(as->devfn),
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric



