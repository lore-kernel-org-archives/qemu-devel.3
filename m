Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA33C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWQH-00043d-5q; Fri, 21 Feb 2025 12:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlWQF-0003zW-Gs
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlWQC-0001EE-Di
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY1CKxamvf0sVtYFPJLjZsBkSMUnKIHykNNOwyUPqUM=;
 b=ezXGqk4wDo1UI2Yby1X5NDl/fXpu1JU9fzCzHO3pVoQMPtA0ItbGsenkd95VyGsNd2yQCd
 FLSZKIUbRLWZDNxsFxRlSuUkDCMiZ9QEDyReEV5ybxtFJuUcRcwU3eszKJz6OW51+arAak
 Yf9A/qHlVjGQWU/HcSanqieLgyn6MSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-acoBHbJlObWwiGWzFeQBqA-1; Fri, 21 Feb 2025 12:02:38 -0500
X-MC-Unique: acoBHbJlObWwiGWzFeQBqA-1
X-Mimecast-MFC-AGG-ID: acoBHbJlObWwiGWzFeQBqA_1740157357
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so16840035e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157357; x=1740762157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tY1CKxamvf0sVtYFPJLjZsBkSMUnKIHykNNOwyUPqUM=;
 b=U0Q65nmNw4T2mzXiSbmZoKyCSZFGE/60x14YoEaf/gBI4da2Sp9Y1NFy0d9+WVwX3d
 YQWU+G5LA7agaEQqA8rVW9MKYohD9Xn2uQvcUUJU5LaM5S4qBFLjr7FmiOzE/kJyagQX
 sMn1qznhak/FQwmrrS+83i2Bn0AbuKlOHiV5oJmEUHJQmzZkrYrewYOhKQphPs9FtA5Y
 RZZpW76Ovgo3gcB9NmLdckr3IpqlAkSHceA+dhlr+tIAKELr7BkyWOFMgFpU22SJO9XO
 bA2d6nXLzkGvC9P1MnbXa34Tza3Ual1kQ8QJSV05I6pKIOKxAPwmnnyDITOuDsIm34Ia
 pz2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9ioBHVENym9i3yNY0aO6wMUGsyS3K+NjzQBMXHcsOheoYSdIlQI3rH6MSdrvwW0r2CMKynW+ueEX+@nongnu.org
X-Gm-Message-State: AOJu0YytUydREESoPon3dSLGJi168UNtk6oBUOzPh+6+vc/O3yoVa6xG
 68RVUF4NbcqWSlZ+UEwrsIXz8jNx16my0l/EbpFCMiMN7LvacAdoji0DzriTbIlNKbHp6/fraxw
 7pVVQHp5B+QgJ4I6lyLbqyvEqFqER8/FE8YN4QZKdnMVa95oSnEKf
X-Gm-Gg: ASbGnct/FHi7CO9vvQMnRa9SAUZeboR/U3MOE/eLL7VyzTl9J5u3mwkBibKD8tIThbh
 Yw/l1CgwihLil2MFkdOTj8ikqfkpA9pRjLFNjKpAXjmNv/yGADjQ448sAjKjUIqxrwikSFUh2mJ
 rFaFaK4DJHcLCx+tD+52jRRIJFzZSjLBW2PMfX3X93EMEm5A7BMN9XpTVKO7nv/V+W5VvYNL50A
 Wlc9CyPs+5+T7sXRk9QP2uWCfRD2rYQrKNUHbkeR+jQ+WAoYccl712Rc8X4l68WcvrDIcipNmxy
 lkBKM8eqRQ7BwXD/e6LM75WfTczIv3A3sqcnzLxlz9vvBIukhkiRcP4qoKA4dIs=
X-Received: by 2002:a05:600c:1c9d:b0:439:33dd:48ea with SMTP id
 5b1f17b1804b1-439ae1d7df6mr34448285e9.2.1740157356384; 
 Fri, 21 Feb 2025 09:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3p6uf3GgBuCe+coHOyE3DIN8GHKGUusjiKxAz+sTzc+fn5gaJnkJPG2XYvjndsKpmoly99g==
X-Received: by 2002:a05:600c:1c9d:b0:439:33dd:48ea with SMTP id
 5b1f17b1804b1-439ae1d7df6mr34446455e9.2.1740157355026; 
 Fri, 21 Feb 2025 09:02:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02d519dsm22437415e9.11.2025.02.21.09.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 09:02:34 -0800 (PST)
Message-ID: <76b94129-8061-4cd6-8a4b-004ec95ea54c@redhat.com>
Date: Fri, 21 Feb 2025 18:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 13/20] intel_iommu: Add PASID cache management
 infrastructure
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-14-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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




On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
> pasid entry and track PASID usage and future PASID tagged DMA address
> translation support in vIOMMU.
>
> VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
> never freed. For other pasid, VTDAddressSpace instance is created/destroyed
> per the guest pasid entry set up/destroy for passthrough devices. While for
> emulated devices, VTDAddressSpace instance is created in the PASID tagged DMA
> translation and be destroyed per guest PASID cache invalidation. This focuses
> on the PASID cache management for passthrough devices as there is no PASID
> capable emulated devices yet.
>
> When guest modifies a PASID entry, QEMU will capture the guest pasid selective
> pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
> invalidation reasons:
>
>     *) a present pasid entry moved to non-present
>     *) a present pasid entry to be a present entry
>     *) a non-present pasid entry moved to present
>
> vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
> and compare it with the PASID cache.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  29 ++
>  include/hw/i386/intel_iommu.h  |   6 +
>  hw/i386/intel_iommu.c          | 484 ++++++++++++++++++++++++++++++++-
Don't you have ways to split this patch. It has a huge change set and
this is really heavy to digest at once (at least for me).
>  hw/i386/trace-events           |   4 +
>  4 files changed, 513 insertions(+), 10 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 18bc22fc72..632fda2853 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -315,6 +315,7 @@ typedef enum VTDFaultReason {
>                                    * request while disabled */
>      VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>  
> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
>      /* PASID directory entry access failure */
>      VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>      /* The Present(P) field of pasid directory entry is 0 */
> @@ -492,6 +493,15 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>  #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>  
> +#define VTD_INV_DESC_PASIDC_G          (3ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID(val) (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PASIDC_DID(val)   (((val) >> 16) & VTD_DOMAIN_ID_MASK)
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0  0xfff000000000f1c0ULL
> +
> +#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
> +#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
> +
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
> @@ -548,10 +558,28 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>  
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(val)      (((val) >> 9) & 0x7)
>  #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  
> +typedef enum VTDPCInvType {
> +    /* force reset all */
> +    VTD_PASID_CACHE_FORCE_RESET = 0,
> +    /* pasid cache invalidation rely on guest PASID entry */
> +    VTD_PASID_CACHE_GLOBAL_INV,
> +    VTD_PASID_CACHE_DOMSI,
> +    VTD_PASID_CACHE_PASIDSI,
> +} VTDPCInvType;
> +
> +typedef struct VTDPASIDCacheInfo {
> +    VTDPCInvType type;
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    PCIBus *bus;
> +    uint16_t devfn;
> +} VTDPASIDCacheInfo;
> +
>  /* PASID Table Related Definitions */
>  #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>  #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> @@ -563,6 +591,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>  #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>  #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
>  
>  /* PASID Granular Translation Type Mask */
>  #define VTD_PASID_ENTRY_P              1ULL
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 50f9b27a45..fbc9da903a 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -95,6 +95,11 @@ struct VTDPASIDEntry {
>      uint64_t val[8];
>  };
>  
> +typedef struct VTDPASIDCacheEntry {
> +    struct VTDPASIDEntry pasid_entry;
> +    bool cache_filled;
> +} VTDPASIDCacheEntry;
> +
>  struct VTDAddressSpace {
>      PCIBus *bus;
>      uint8_t devfn;
> @@ -107,6 +112,7 @@ struct VTDAddressSpace {
>      MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
>      IntelIOMMUState *iommu_state;
>      VTDContextCacheEntry context_cache_entry;
> +    VTDPASIDCacheEntry pasid_cache_entry;
>      QLIST_ENTRY(VTDAddressSpace) next;
>      /* Superset of notifier flags that this address space has */
>      IOMMUNotifierFlag notifier_flags;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index fafa199f52..b8f3b85803 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -86,6 +86,8 @@ struct vtd_iotlb_key {
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  
> +static void vtd_pasid_cache_reset(IntelIOMMUState *s);
use _locked suffix to be consistent with the others and emphases the
lock is held?
> +
>  static void vtd_panic_require_caching_mode(void)
>  {
>      error_report("We need to set caching-mode=on for intel-iommu to enable "
> @@ -390,6 +392,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>      vtd_iommu_lock(s);
>      vtd_reset_iotlb_locked(s);
>      vtd_reset_context_cache_locked(s);
> +    vtd_pasid_cache_reset(s);
>      vtd_iommu_unlock(s);
>  }
>  
> @@ -825,6 +828,16 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>      }
>  }
>  
> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
> +{
> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
> +}
> +
> +static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe)

nit: vtd_pe_get_did as the filed is named DID?

> +{
> +    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
> @@ -1617,6 +1630,54 @@ static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
>      }
>  }
>  
> +/* Translate to iommu pasid if PCI_NO_PASID */
I don't really get the comment above. Ay best, shouldn't it be put in

(vtd_as->pasid == PCI_NO_PASID) block?
What you call "iommu pasid" is the value set in RID_PASID, right? Is "iommu pasid" a conventional terminology?

> +static int vtd_as_to_iommu_pasid(VTDAddressSpace *vtd_as, uint32_t *pasid)
> +{
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    ret = vtd_as_to_context_entry(vtd_as, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (vtd_as->pasid == PCI_NO_PASID) {
> +        *pasid = VTD_CE_GET_RID2PASID(&ce);
This is called RID_PASID in the spec. I think it would be easier for the
reader if could have a direct match with named fields so that we can
easily seach the spec.
> +    } else {
> +        *pasid = vtd_as->pasid;
> +    }
> +
> +    return 0;
> +}
> +
> +static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
> +                                                   gpointer user_data)
why iommu_pasid and not directly pasid?
> +{
> +    VTDAddressSpace *vtd_as = (VTDAddressSpace *)value;
> +    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
> +    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
> +    uint32_t pasid;
> +
> +    if (vtd_as_to_iommu_pasid(vtd_as, &pasid)) {
> +        return false;
> +    }
> +
> +    return (pasid == target->pasid) && (sid == target->sid);
> +}
> +
> +/* Translate iommu pasid to vtd_as */
> +static VTDAddressSpace *vtd_as_from_iommu_pasid(IntelIOMMUState *s,
> +                                                uint16_t sid, uint32_t pasid)
> +{
> +    struct vtd_as_raw_key key = {
> +        .sid = sid,
> +        .pasid = pasid
> +    };
> +
> +    return g_hash_table_find(s->vtd_address_spaces,
> +                             vtd_find_as_by_sid_and_iommu_pasid, &key);
> +}
> +
>  static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>                                       void *private)
>  {
> @@ -3062,6 +3123,412 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>      return true;
>  }
>  
> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> +                                            uint32_t pasid, VTDPASIDEntry *pe)
does "pe" means pasid entry? It is not obvious for a dummy reader like
me. May be worth a comment at least once.
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_as_to_context_entry(vtd_as, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
> +}
> +
> +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> +{
> +    return !memcmp(p1, p2, sizeof(*p1));
> +}
> +
> +/*
> + * This function fills in the pasid entry in &vtd_as. Caller
> + * of this function should hold iommu_lock.
> + */
> +static void vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
> +                                 VTDPASIDEntry *pe)
seems some other functions used the _locked suffix
> +{
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +
> +    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
> +        /* No need to go further as cached pasid entry is latest */
> +        return;
> +    }
> +
> +    pc_entry->pasid_entry = *pe;
> +    pc_entry->cache_filled = true;
> +    /*
> +     * TODO: send pasid bind to host for passthru devices
> +     */
what does it mean?
> +}
> +
> +/*
> + * This function is used to clear cached pasid entry in vtd_as
> + * instances. Caller of this function should hold iommu_lock.
> + */
> +static gboolean vtd_flush_pasid(gpointer key, gpointer value,
> +                                gpointer user_data)
> +{
> +    VTDPASIDCacheInfo *pc_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +    uint32_t pasid;
> +    int ret;
> +
> +    /* Replay only fill pasid entry cache for passthrough device */
filled

Eric

> +    if (!pc_entry->cache_filled) {
> +        return false;
> +    }
> +    did = vtd_pe_get_domain_id(&pc_entry->pasid_entry);
> +
> +    if (vtd_as_to_iommu_pasid(vtd_as, &pasid)) {
> +        goto remove;
> +    }
> +
> +    switch (pc_info->type) {
> +    case VTD_PASID_CACHE_FORCE_RESET:
> +        goto remove;
> +    case VTD_PASID_CACHE_PASIDSI:
> +        if (pc_info->pasid != pasid) {
> +            return false;
> +        }
> +        /* Fall through */
> +    case VTD_PASID_CACHE_DOMSI:
> +        if (pc_info->domain_id != did) {
> +            return false;
> +        }
> +        /* Fall through */
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        break;
> +    default:
> +        error_report("invalid pc_info->type");
> +        abort();
> +    }
> +
> +    /*
> +     * pasid cache invalidation may indicate a present pasid
> +     * entry to present pasid entry modification. To cover such
> +     * case, vIOMMU emulator needs to fetch latest guest pasid
> +     * entry and check cached pasid entry, then update pasid
> +     * cache and send pasid bind/unbind to host properly.
> +     */
> +    ret = vtd_dev_get_pe_from_pasid(vtd_as, pasid, &pe);
> +    if (ret) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry
> +         * was modified to be either all-zero or non-present. Either
> +         * case means existing pasid cache should be removed.
> +         */
> +        goto remove;
> +    }
> +
> +    vtd_fill_pe_in_cache(s, vtd_as, &pe);
> +    return false;
> +
> +remove:
> +    /*
> +     * TODO: send pasid unbind to host for passthru devices
> +     */
> +    pc_entry->cache_filled = false;
> +
> +    /*
> +     * Don't remove address space of PCI_NO_PASID which is created by PCI
> +     * sub-system.
> +     */
> +    if (vtd_as->pasid == PCI_NO_PASID) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/* Caller of this function should hold iommu_lock */
> +static void vtd_pasid_cache_reset(IntelIOMMUState *s)
> +{
> +    VTDPASIDCacheInfo pc_info;
> +
> +    trace_vtd_pasid_cache_reset();
> +
> +    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
> +
> +    /*
> +     * Reset pasid cache is a big hammer, so use
> +     * g_hash_table_foreach_remove which will free
> +     * the vtd_as instances. Also, as a big
> +     * hammer, use VTD_PASID_CACHE_FORCE_RESET to
> +     * ensure all the vtd_as instances are
> +     * dropped, meanwhile the change will be passed
> +     * to host if HostIOMMUDeviceIOMMUFD is available.
> +     */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces,
> +                                vtd_flush_pasid, &pc_info);
> +}
> +
> +/* Caller of this function should hold iommu_lock. */
> +static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
> +                                        dma_addr_t pt_base,
> +                                        int start,
> +                                        int end,
> +                                        VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDEntry pe;
> +    int pasid = start;
> +    int pasid_next;
> +
> +    while (pasid < end) {
> +        pasid_next = pasid + 1;
> +
> +        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
> +            && vtd_pe_present(&pe)) {
> +            int bus_n = pci_bus_num(info->bus), devfn = info->devfn;
> +            uint16_t sid = PCI_BUILD_BDF(bus_n, devfn);
> +            VTDAddressSpace *vtd_as;
> +
> +            vtd_as = vtd_as_from_iommu_pasid(s, sid, pasid);
> +            if (!vtd_as) {
> +                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
> +            }
> +
> +            if ((info->type == VTD_PASID_CACHE_DOMSI ||
> +                 info->type == VTD_PASID_CACHE_PASIDSI) &&
> +                !(info->domain_id == vtd_pe_get_domain_id(&pe))) {
> +                /*
> +                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +                 * requires domain ID check. If domain Id check fail,
> +                 * go to next pasid.
> +                 */
> +                pasid = pasid_next;
> +                continue;
> +            }
> +            vtd_fill_pe_in_cache(s, vtd_as, &pe);
> +        }
> +        pasid = pasid_next;
> +    }
> +}
> +
> +/*
> + * Currently, VT-d scalable mode pasid table is a two level table,
> + * this function aims to loop a range of PASIDs in a given pasid
> + * table to identify the pasid config in guest.
> + * Caller of this function should hold iommu_lock.
> + */
> +static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
> +                                    dma_addr_t pdt_base,
> +                                    int start,
> +                                    int end,
> +                                    VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDDirEntry pdire;
> +    int pasid = start;
> +    int pasid_next;
> +    dma_addr_t pt_base;
> +
> +    while (pasid < end) {
> +        pasid_next = ((end - pasid) > VTD_PASID_TBL_ENTRY_NUM) ?
> +                      (pasid + VTD_PASID_TBL_ENTRY_NUM) : end;
> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
> +            && vtd_pdire_present(&pdire)) {
> +            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
> +            vtd_sm_pasid_table_walk_one(s, pt_base, pasid, pasid_next, info);
> +        }
> +        pasid = pasid_next;
> +    }
> +}
> +
> +static void vtd_replay_pasid_bind_for_dev(IntelIOMMUState *s,
> +                                          int start, int end,
> +                                          VTDPASIDCacheInfo *info)
> +{
> +    VTDContextEntry ce;
> +    VTDAddressSpace *vtd_as;
> +
> +    vtd_as = vtd_find_add_as(s, info->bus, info->devfn, PCI_NO_PASID);
> +
> +    if (!vtd_as_to_context_entry(vtd_as, &ce)) {
> +        uint32_t max_pasid;
> +
> +        max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) * VTD_PASID_TBL_ENTRY_NUM;
> +        if (end > max_pasid) {
> +            end = max_pasid;
> +        }
> +        vtd_sm_pasid_table_walk(s,
> +                                VTD_CE_GET_PASID_DIR_TABLE(&ce),
> +                                start,
> +                                end,
> +                                info);
> +    }
> +}
> +
> +/*
> + * This function replay the guest pasid bindings to hosts by
> + * walking the guest PASID table. This ensures host will have
> + * latest guest pasid bindings. Caller should hold iommu_lock.
> + */
> +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
> +                                            VTDPASIDCacheInfo *pc_info)
> +{
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    int start = 0, end = 1; /* only rid2pasid is supported */
> +    VTDPASIDCacheInfo walk_info;
> +    GHashTableIter as_it;
> +
> +    switch (pc_info->type) {
> +    case VTD_PASID_CACHE_PASIDSI:
> +        start = pc_info->pasid;
> +        end = pc_info->pasid + 1;
> +        /*
> +         * PASID selective invalidation is within domain,
> +         * thus fall through.
> +         */
> +    case VTD_PASID_CACHE_DOMSI:
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        /* loop all assigned devices */
> +        break;
> +    case VTD_PASID_CACHE_FORCE_RESET:
> +        /* For force reset, no need to go further replay */
> +        return;
> +    default:
> +        error_report("invalid pc_info->type for replay");
> +        abort();
> +    }
> +
> +    /*
> +     * In this replay, only needs to care about the devices which
> +     * are backed by host IOMMU. For such devices, their vtd_hiod
> +     * instances are in the s->vtd_host_iommu_dev. For devices which
> +     * are not backed by host IOMMU, it is not necessary to replay
> +     * the bindings since their cache could be re-created in the future
> +     * DMA address translation.
> +     */
> +    walk_info = *pc_info;
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> +        /* bus|devfn fields are not identical with pc_info */
> +        walk_info.bus = vtd_hiod->bus;
> +        walk_info.devfn = vtd_hiod->devfn;
> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
> +    }
> +}
> +
> +/*
> + * This function syncs the pasid bindings between guest and host.
> + * It includes updating the pasid cache in vIOMMU and updating the
> + * pasid bindings per guest's latest pasid entry presence.
> + */
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> +                                 VTDPASIDCacheInfo *pc_info)
> +{
> +    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    /*
> +     * Regards to a pasid cache invalidation, e.g. a PSI.
> +     * it could be either cases of below:
> +     * a) a present pasid entry moved to non-present
> +     * b) a present pasid entry to be a present entry
> +     * c) a non-present pasid entry moved to present
> +     *
> +     * Different invalidation granularity may affect different device
> +     * scope and pasid scope. But for each invalidation granularity,
> +     * it needs to do two steps to sync host and guest pasid binding.
> +     *
> +     * Here is the handling of a PSI:
> +     * 1) loop all the existing vtd_as instances to update them
> +     *    according to the latest guest pasid entry in pasid table.
> +     *    this will make sure affected existing vtd_as instances
> +     *    cached the latest pasid entries. Also, during the loop, the
> +     *    host should be notified if needed. e.g. pasid unbind or pasid
> +     *    update. Should be able to cover case a) and case b).
> +     *
> +     * 2) loop all devices to cover case c)
> +     *    - For devices which are backed by HostIOMMUDeviceIOMMUFD instances,
> +     *      we loop them and check if guest pasid entry exists. If yes,
> +     *      it is case c), we update the pasid cache and also notify
> +     *      host.
> +     *    - For devices which are not backed by HostIOMMUDeviceIOMMUFD,
> +     *      it is not necessary to create pasid cache at this phase since
> +     *      it could be created when vIOMMU does DMA address translation.
> +     *      This is not yet implemented since there is no emulated
> +     *      pasid-capable devices today. If we have such devices in
> +     *      future, the pasid cache shall be created there.
> +     * Other granularity follow the same steps, just with different scope
> +     *
> +     */
> +
> +    vtd_iommu_lock(s);
> +    /* Step 1: loop all the existing vtd_as instances */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces,
> +                                vtd_flush_pasid, pc_info);
> +
> +    /*
> +     * Step 2: loop all the existing vtd_hiod instances.
> +     * Ideally, needs to loop all devices to find if there is any new
> +     * PASID binding regards to the PASID cache invalidation request.
> +     * But it is enough to loop the devices which are backed by host
> +     * IOMMU. For devices backed by vIOMMU (a.k.a emulated devices),
> +     * if new PASID happened on them, their vtd_as instance could
> +     * be created during future vIOMMU DMA translation.
> +     */
> +    vtd_replay_guest_pasid_bindings(s, pc_info);
> +    vtd_iommu_unlock(s);
> +}
> +
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    VTDPASIDCacheInfo pc_info;
> +    uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
> +                                     __func__, "pasid cache inv")) {
> +        return false;
> +    }
> +
> +    domain_id = VTD_INV_DESC_PASIDC_DID(inv_desc->val[0]);
> +    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc->val[0]);
> +
> +    switch (inv_desc->val[0] & VTD_INV_DESC_PASIDC_G) {
> +    case VTD_INV_DESC_PASIDC_DSI:
> +        trace_vtd_pasid_cache_dsi(domain_id);
> +        pc_info.type = VTD_PASID_CACHE_DOMSI;
> +        pc_info.domain_id = domain_id;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_PASID_SI:
> +        /* PASID selective implies a DID selective */
> +        trace_vtd_pasid_cache_psi(domain_id, pasid);
> +        pc_info.type = VTD_PASID_CACHE_PASIDSI;
> +        pc_info.domain_id = domain_id;
> +        pc_info.pasid = pasid;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_GLOBAL:
> +        trace_vtd_pasid_cache_gsi();
> +        pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
> +        break;
> +
> +    default:
> +        error_report_once("invalid-inv-granu-in-pc_inv_desc hi: 0x%" PRIx64
> +                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }
> +
> +    vtd_pasid_cache_sync(s, &pc_info);
> +    return true;
> +}
> +
>  static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                       VTDInvDesc *inv_desc)
>  {
> @@ -3223,6 +3690,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>          }
>          break;
>  
> +    case VTD_INV_DESC_PC:
> +        trace_vtd_inv_desc("pasid-cache", inv_desc.val[1], inv_desc.val[0]);
> +        if (!vtd_process_pasid_desc(s, &inv_desc)) {
> +            return false;
> +        }
> +        break;
> +
>      case VTD_INV_DESC_PIOTLB:
>          trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
>          if (!vtd_process_piotlb_desc(s, &inv_desc)) {
> @@ -3258,16 +3732,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>          }
>          break;
>  
> -    /*
> -     * TODO: the entity of below two cases will be implemented in future series.
> -     * To make guest (which integrates scalable mode support patch set in
> -     * iommu driver) work, just return true is enough so far.
> -     */
> -    case VTD_INV_DESC_PC:
> -        if (s->scalable_mode) {
> -            break;
> -        }
> -    /* fallthrough */
>      default:
>          error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
>                            " (unknown type)", __func__, inv_desc.hi,
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 53c02d7ac8..a26b38b52c 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,10 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>  vtd_inv_qi_tail(uint16_t head) "write tail %d"
>  vtd_inv_qi_fetch(void) ""
>  vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_gsi(void) ""
> +vtd_pasid_cache_reset(void) ""
> +vtd_pasid_cache_dsi(uint16_t domain) "Domain slective PC invalidation domain 0x%"PRIx16
> +vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16


