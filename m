Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56865CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrQX-0000Ou-Lg; Mon, 03 Nov 2025 05:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFrQV-0000OP-Qq
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFrQS-0000mt-TF
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762164273;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGoPGf8eD7yxTkJEEOexHB+ITQ99yHrCJ7E3TrRDSIU=;
 b=A0s9i0JiA7/1+eZHRSjIt8urr0O/9GOMFIe8Es14U019IiepIuoYLR4p2Jc69gdsUVXRb8
 7Pa4qe7TE44CanqWlAYOwWcsgZznhhagjG+qKIqolmLs0nyvkxrFmVZjnN8/vxWyYu8H0t
 RJg6iUIjDP2jiU1Q+c/Q/WXE2krJYG8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-uBRbZ63SNZCtNgIPvWBgig-1; Mon, 03 Nov 2025 05:04:27 -0500
X-MC-Unique: uBRbZ63SNZCtNgIPvWBgig-1
X-Mimecast-MFC-AGG-ID: uBRbZ63SNZCtNgIPvWBgig_1762164266
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477212937eeso29873685e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164266; x=1762769066;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pGoPGf8eD7yxTkJEEOexHB+ITQ99yHrCJ7E3TrRDSIU=;
 b=ERViLGjP92jNXV6IGOFWCu3UMvcfLpi0zTAky3QaIRoAzxjY/WuXbpWIaN4aWUGajv
 56dSPi67oTDwCXsZUTvmhVX472W6+x4Op1U490yBMk9pKS912ZMVI80MQn/29fnrxqpp
 OzZ33GSt8ciXHr6yJ2Xa7wLVcQTrkzmDU6us/YSc+QIPItPiQpA3mfFfqHawKjlvsvTg
 XMWS6J7Z4xcoG8JYkD88tIxOCE4INN6ZKVClaUI7U6abkvubYwwhZw1Xani5etKd5265
 9w5NexxpvK/YgtZFp6d2aVUPjRDogJyOzLdbbHf+Fmj/8eXMpDHPpm4gwmhsrpRMtZkW
 1VUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/mHzA8IBgKcH/5S2vABbJMgoufra54QAnQgOUWu68Uwg9p1vB76MbDrhHiuOSXITAXJqymGkm9GUQ@nongnu.org
X-Gm-Message-State: AOJu0Yw27wd7YQAKllnA979AKQda9JQBx++8SHdigE60O5YGkvPhiMJ0
 VNdP5DCNakNTz0y43znoK1GvuEtid6gP4OAZ+aqHEP9+oOl7qhMohEgWvv4KsKE1nlyi6SsE6W6
 TJZEdrq7u3DcFRzkzWNGX45p1CfU9tjOLggeZyLvg6end6Wt4TVGfJDKRsGo+sR77
X-Gm-Gg: ASbGncuR5j1btldzaThDXq1QbC5LBisgeG7WKmiqnaNtF6IbIpdXHym67nHRW5I7EEV
 lAAk+8bZmPf4haQmOcQL7LmmP/T6WKnPnUkmxo6ZnOshCwP9bVZkMm9v4I0BKixxwUCWMCc6tRL
 5JZGm0K9136HObYCHsJGJb5ZCNmpWRKgEU5lXZG83Bs0Rr7Ge/ucMZkZ62ndYpC0fstItgPsxsi
 Xpx0M/DmVzYPjKn8qDMvIKaBrHaGiFmDBx2ng8qLNq8l67wjVWFub96yLadJn5W3Whi/onMHtcl
 Wm0umJ7ItLZQiwx6wfLe89LRKPYfZ1llY6Yuk1SyYErXvXv5OBLi0CuRmkhGZ0aSORm5cibNFkM
 uEcaLG6TkMp0KYMI7iSD23yTMtnk4Yi8pVDXbAN4cf0ke+g==
X-Received: by 2002:a05:600d:8314:b0:477:4345:7c59 with SMTP id
 5b1f17b1804b1-47743458444mr34427215e9.40.1762164265718; 
 Mon, 03 Nov 2025 02:04:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzjEngy6Of3iDjYbNF+Sgp4dmBb0umtp7I8qmk+6CDNxmsOLDUy0k1ljttCndf540E4+QCJA==
X-Received: by 2002:a05:600d:8314:b0:477:4345:7c59 with SMTP id
 5b1f17b1804b1-47743458444mr34426955e9.40.1762164265287; 
 Mon, 03 Nov 2025 02:04:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48daa0sm148568585e9.3.2025.11.03.02.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 02:04:24 -0800 (PST)
Message-ID: <39bd639f-4b67-4e90-bed6-299cd7315a87@redhat.com>
Date: Mon, 3 Nov 2025 11:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/23] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-15-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Zhenzhong,

On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This traps the guest PASID-based iotlb invalidation request and propagate it
> to host.
>
> Intel VT-d 3.0 supports nested translation in PASID granularity. Guest SVA
> support could be implemented by configuring nested translation on specific
> pasid. This is also known as dual stage DMA translation.
>
> Under such configuration, guest owns the GVA->GPA translation which is
> configured as first stage page table on host side for a specific pasid, and
> host owns GPA->HPA translation. As guest owns first stage translation table,
> piotlb invalidation should be propagated to host since host IOMMU will cache
> first level page table related mappings during DMA address translation.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  6 +++
>  hw/i386/intel_iommu.c          | 87 ++++++++++++++++++++++++++++++++--
>  2 files changed, 90 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index df80af839d..97b48544d2 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -621,6 +621,12 @@ typedef struct VTDPASIDCacheInfo {
>      uint32_t pasid;
>  } VTDPASIDCacheInfo;
>  
> +typedef struct VTDPIOTLBInvInfo {
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    struct iommu_hwpt_vtd_s1_invalidate *inv_data;
> +} VTDPIOTLBInvInfo;
> +
>  /* PASID Table Related Definitions */
>  #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>  #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3789a36147..ef6477de53 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2504,11 +2504,88 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
>  
>      return ret;
>  }
> +
> +/*
> + * This function is a loop function for the s->vtd_address_spaces
> + * list with VTDPIOTLBInvInfo as execution filter. It propagates
> + * the piotlb invalidation to host.
> + */
> +static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    VTDPIOTLBInvInfo *piotlb_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    uint16_t did;
> +
> +    if (!vtd_hiod) {
> +        return;
> +    }
> +
> +    assert(vtd_as->pasid == PCI_NO_PASID);
> +
> +    /* Nothing to do if there is no first stage HWPT attached */
> +    if (!pc_entry->valid ||
> +        !vtd_pe_pgtt_is_fst(&pc_entry->pasid_entry)) {
> +        return;
> +    }
> +
> +    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +
> +    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
> +        HostIOMMUDeviceIOMMUFD *idev =
> +            HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +        uint32_t entry_num = 1; /* Only implement one request for simplicity */
> +        Error *local_err = NULL;
> +        struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
> +
> +        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt,
> +                                              IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
> +                                              sizeof(*cache), &entry_num, cache,
> +                                              &local_err)) {
> +            /* Something wrong in kernel, but trying to continue */
> +            error_report_err(local_err);
> +        }
> +    }
> +}
> +
> +static void
> +vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
> +                                 uint16_t domain_id, uint32_t pasid,
> +                                 hwaddr addr, uint64_t npages, bool ih)
> +{
> +    struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
> +    VTDPIOTLBInvInfo piotlb_info;
> +
> +    cache_info.addr = addr;
> +    cache_info.npages = npages;
> +    cache_info.flags = ih ? IOMMU_VTD_INV_FLAGS_LEAF : 0;
> +
> +    piotlb_info.domain_id = domain_id;
> +    piotlb_info.pasid = pasid;
> +    piotlb_info.inv_data = &cache_info;
> +
> +    /*
> +     * Go through each vtd_as instance in s->vtd_address_spaces, find out
> +     * the affected host device which need host piotlb invalidation. Piotlb
the affected host devices? There might be several of them, isn't it?
> +     * invalidation should check pasid cache per architecture point of view.
> +     */
> +    g_hash_table_foreach(s->vtd_address_spaces,
> +                         vtd_flush_host_piotlb_locked, &piotlb_info);
> +}
>  #else
>  static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
>  {
>      return 0;
>  }
> +
> +static void
> +vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
> +                                 uint16_t domain_id, uint32_t pasid,
> +                                 hwaddr addr, uint64_t npages, bool ih)
> +{
> +}
>  #endif
>  
>  /* Do a context-cache device-selective invalidation.
> @@ -3155,6 +3232,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>      vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
>                                  &info);
> +    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1, 0);
UINT64_MAX

>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> @@ -3174,7 +3252,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>  }
>  
>  static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> -                                       uint32_t pasid, hwaddr addr, uint8_t am)
> +                                       uint32_t pasid, hwaddr addr, uint8_t am,
> +                                       bool ih)
>  {
>      VTDIOTLBPageInvInfo info;
>  
> @@ -3186,6 +3265,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>      vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb,
>                                  vtd_hash_remove_by_page_piotlb, &info);
> +    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
>      vtd_iommu_unlock(s);
>  
>      vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
> @@ -3217,7 +3297,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>      case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>          am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
>          addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
> -        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
it is not obvious we hold the lock here
> +        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
> +                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
>          break;
>  
>      default:
> @@ -5439,7 +5520,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>      ret = 0;
>      switch (pgtt) {
>      case VTD_SM_PASID_ENTRY_FST:
> -        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0);
> +        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0, 0);
>          break;
>      /* Room for other pgtt values */
>      default:
Thanks

Eric


