Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2693CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZQy-0004xN-9G; Thu, 28 Aug 2025 06:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urZQs-0004ud-C3
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urZQq-0002l0-0P
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756375234;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bzmK7V309tmZRdy2t06yWD6T83WWSP0Y6b9i/iBwXA=;
 b=V0GXZuqmQ50dL4VlQA8Xtq/eGe6YnSFMEy6MyPUzN/RHla6r6uNkQaVYZzzhaRdAdWo3EJ
 kiOgDXkEBVwnPNGC4veBSvTapOikI6QYdgkH2i6MCx4GDp0lJwNMhF8TIsUAMAmKGSzG76
 CK5lNL5BM3u7K6p3NZtSdB2vrq/wPwo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-SWhsn5zMPdmEsMd5i8WXHQ-1; Thu, 28 Aug 2025 06:00:32 -0400
X-MC-Unique: SWhsn5zMPdmEsMd5i8WXHQ-1
X-Mimecast-MFC-AGG-ID: SWhsn5zMPdmEsMd5i8WXHQ_1756375231
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3cbe70a7861so549377f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 03:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756375231; x=1756980031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bzmK7V309tmZRdy2t06yWD6T83WWSP0Y6b9i/iBwXA=;
 b=Uy4AUNOkmzqazFaK98OMGq7jeQZ4hh7sR/5RqYhoe9Wv/pvBOZkBDEt1aZBWkT+LH5
 nPiTfsqw23VOVSKJy/oIQxU+PcZ0jWplskjpvPvkHD6vRK1bHQPtMArhDROjOyoDcIJ6
 iISypMtj0fLiFCuKNvvGF0nBXsJ7VyN1DhMKoq8YBiaWchdIKKhUS+rEYvTtgA9rDVES
 QZe1BuA8jA3fl5vbKB1cwT4Ju23YqnecBtkaaL0PhB9uIuuAMhHlV33F71FBiJTpz4V7
 AXvo91OE9KlZDn+2mkdoMjB8J/du/8doeIvS0oF2IJ8qpbnuY4kDyBiawxCRQnF0v6UD
 X7fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdVze5nytSF4fusNL/j5v0z8Yjh6KWe83q7fmMI7rK8KvpAgftEJOmxtrMwll6lYIBkXUJFz4PiLyF@nongnu.org
X-Gm-Message-State: AOJu0YycNGRkDEWGxi3xMyOVq0Nawnri/4S6BFFxSA79o5iBCIa/fYaG
 fYvhte+A7a/8XhdeBZ+or9vy5rNGSKNxGTmfXvt/5RwvQ+bwxhxlVOGzq2dzoJ1MXp6OJFeLDEP
 QzM2dTV9W3aThfC1RWg3tBC2UoH3TMrxFzxdCUDO6oOTiq6gQRaK3x4+g
X-Gm-Gg: ASbGncvtx6LEHs/lYmRVzHnKyN3YYW8LnKLyKX5sV/T/0nrk6EByH0rLTCyaViBmCby
 4zmSEq7HFU1l5weDD3FfN9onK7YDJHfMpKrc8+E1cN4/QirkT1zaMDJ316L5voL0WFmGJ/27Ccb
 f8yZJqrJRngRttQQuE3y0D2TPbZc7XnRwnYctXm5UNXLJInrmBJLIUGBKpUzLa5D14BMQvA2Phz
 3UY9K0QLDS7PM/+3UCfikj3gNYoqo0yR7SNBy5Cdz99VcwApaV0sgwyohrxAZwlg3O93AarxGaS
 463McFledssgFFNWnWJJbQc3iuhcaC620qXlzfg3M3sp0SXkTwvoYXCKKirK4QmKUtIJ4n54r3N
 5RYvmSYL0Qew=
X-Received: by 2002:a05:6000:2301:b0:3cd:f441:9222 with SMTP id
 ffacd0b85a97d-3cdf44195bemr1663266f8f.35.1756375230828; 
 Thu, 28 Aug 2025 03:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnsFWWTnISP0jdjL0kqytcV6jrX4JWAMt8TCZq/CCR16NZ8Du55IgZUeoiIy2a+pFVMjQa1w==
X-Received: by 2002:a05:6000:2301:b0:3cd:f441:9222 with SMTP id
 ffacd0b85a97d-3cdf44195bemr1663208f8f.35.1756375230238; 
 Thu, 28 Aug 2025 03:00:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b797dcad5sm26863455e9.18.2025.08.28.03.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 03:00:29 -0700 (PDT)
Message-ID: <7d979fe7-95ba-4216-8cb9-05a047673e35@redhat.com>
Date: Thu, 28 Aug 2025 12:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/21] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-18-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-18-zhenzhong.duan@intel.com>
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
> configured as stage-1 page table on host side for a specific pasid, and host
> owns GPA->HPA translation. As guest owns stage-1 translation table, piotlb
> invalidation should be propagated to host since host IOMMU will cache first
> level page table related mappings during DMA address translation.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  6 +++
>  hw/i386/intel_iommu.c          | 95 +++++++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 8af1004888..c1a9263651 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -596,6 +596,12 @@ typedef struct VTDPASIDCacheInfo {
>      uint16_t devfn;
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
> index 6c0e502d1c..7efa22f4ec 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2611,12 +2611,99 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
>  
>      return ret;
>  }
> +
> +static void
> +vtd_invalidate_piotlb_locked(VTDAddressSpace *vtd_as,
> +                             struct iommu_hwpt_vtd_s1_invalidate *cache)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(s, vtd_as);
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    uint32_t entry_num = 1; /* Only implement one request for simplicity */
can you remind me what it is used for. What 1?
> +    Error *local_err = NULL;
> +
> +    if (!vtd_hiod || !vtd_as->s1_hwpt) {
> +        return;
> +    }
> +    idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
> +    if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->s1_hwpt,
> +                                          IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
> +                                          sizeof(*cache), &entry_num, cache,
> +                                          &local_err)) {
> +        /* Something wrong in kernel, but trying to continue */
> +        error_report_err(local_err);
> +    }
> +}
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
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    uint32_t pasid;
> +    uint16_t did;
> +
> +    /* Replay only fills pasid entry cache for passthrough device */
> +    if (!pc_entry->valid ||
> +        !vtd_pe_pgtt_is_flt(&pc_entry->pasid_entry)) {
> +        return;
> +    }
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        return;
> +    }
> +
> +    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +
> +    if (piotlb_info->domain_id == did && piotlb_info->pasid == pasid) {
> +        vtd_invalidate_piotlb_locked(vtd_as, piotlb_info->inv_data);
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
Are you likely to find several vts_as that match invalidation params?
> +     * invalidation should check pasid cache per architecture point of view.
> +     */
> +    g_hash_table_foreach(s->vtd_address_spaces,
> +                         vtd_flush_host_piotlb_locked, &piotlb_info);
> +}
>  #else
>  static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
>                                  Error **errp)
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
Can't you put those stub stuff in a specific header as it is usually done?
>  
>  static int vtd_bind_guest_pasid_report_err(VTDAddressSpace *vtd_as,
> @@ -3295,6 +3382,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>      vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
>                                  &info);
> +    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1, 0);
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> @@ -3316,7 +3404,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>  }
>  
>  static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> -                                       uint32_t pasid, hwaddr addr, uint8_t am)
> +                                       uint32_t pasid, hwaddr addr, uint8_t am,
> +                                       bool ih)
>  {
>      VTDIOTLBPageInvInfo info;
>  
> @@ -3328,6 +3417,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>      vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb,
>                                  vtd_hash_remove_by_page_piotlb, &info);
> +    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
>      vtd_iommu_unlock(s);
>  
>      vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
> @@ -3359,7 +3449,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>      case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>          am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
>          addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
> -        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
> +        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
> +                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
>          break;
>  
>      default:
Thanks

Eric


