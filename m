Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0039C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 15:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSdvO-0001aI-1N; Fri, 20 Jun 2025 11:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSdvL-0001Zw-0r
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSdvI-0001sf-4N
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750434298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGoXtfVszoWCXj4PuSzpnuGUABKnE4Q4ah/OqZB3MUI=;
 b=LJB7kOcFwL/vmK4UNT8DStScn/81rJQ4XxXFpWVu4rzYqAChxNn2XjBCKp9TJxKU/PA0KX
 gOyGaNufdpuzQ6I0tu+89UGAT1DhFfRHr5Qo+tdPnTe64G8YRh7SdsjErzL8Zi8iBH2prQ
 OC6gnF197U7MeE+0dr8gCT2CtPlURiE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Dy-ZI-JiNSCtPmGjoTFqDQ-1; Fri, 20 Jun 2025 11:44:56 -0400
X-MC-Unique: Dy-ZI-JiNSCtPmGjoTFqDQ-1
X-Mimecast-MFC-AGG-ID: Dy-ZI-JiNSCtPmGjoTFqDQ_1750434295
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d290d542so12295645e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 08:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750434295; x=1751039095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGoXtfVszoWCXj4PuSzpnuGUABKnE4Q4ah/OqZB3MUI=;
 b=U8IKtz9da7GqlzRTtsBNZrsgIPVILVeJQZhe7j3VLwM/VQziMWqIlO5YQgzctCzpJh
 P3QW1TTZcrpRP3VpylBrrp46jcOld9WKRAyMrq+m/Tx+W5/Lx4ICiq9ys/PC5lmzATTD
 mafRLLNHeZZHkGj3x3A5J1WnnX3EJ6a/sL3M0U2Tn+h4xkBJm3ptPZfAbiYomkoe6Jqo
 U9KEOxohQPPaDdkok273S+eM62W1JoHZXb+IDa7gRdeTh0pLzBu/2nmTw8TX0aqV6tqy
 G2lObRyqHwe7MuhK10PawRCtfB3OTQw1vCO+uwRDDZRNvcfi3VngGZCEODgdteZgqMBD
 0IFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXxtESlvWKs815zgwMyGlmKqQOC51L2hcTEiTHgegazesQ7lJIKnSaHKQyzyXT+9WiB49ABBW8qqaI@nongnu.org
X-Gm-Message-State: AOJu0YwGC1TrRP8KmjtYaj6qZb55F55dfBa0L7X7BcnJ1HfJXmU65Ya0
 JyVkN8Snaz1uSefJZF+a54hHPj7P3tOODUb3Y8rQTN4K+iiyw19N0okBOB5yzW6GixOR7ndH2pl
 wlA/v8qQRRTanfCbDA2KHvHVvSIJ0OOjrSKd2FSaaeAYeDD9bIutF20Im
X-Gm-Gg: ASbGncuOB4D7oMybF3ZRb5I7baY8HA/W5+Mvvx0f9gPpzTBEUcEJMg6e7q9E41jPY7d
 BcWbidy6Ahyklq8sRGQzF8wBT6R8mNHavo2tdUAeY2+X2ryA3NBlAbbRTCyu7fdobubcfii6ahb
 VC6DHn6AqJAIQpdIQ6vqbOnn1OLkdyswvLSrHCIn8UH4G7Wo1cDHptC3J3P1tdA54sENGe/zwET
 D44vhjetIXCSzSNmMVlpjhyiClXEx2isJup0GZLkowaWaHrKpgHhJrZ5pnHiA383XORTWJ7oHk6
 mb5TyQXcvZBrBPiVOYQMU6bTQIca6AKMX1hHlWgCEygB+zmGpT4X0dlkE4h9F7QTH82tOw==
X-Received: by 2002:a05:600c:5296:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-453655c2b7dmr28104795e9.25.1750434294836; 
 Fri, 20 Jun 2025 08:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF00gc0ZJ2KTzEoIybOWABA9PFvzzweLhqwDrBe0OD6kVOi2Pge0aZKQ5cs0bcUVlaIHeNEWA==
X-Received: by 2002:a05:600c:5296:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-453655c2b7dmr28104475e9.25.1750434294303; 
 Fri, 20 Jun 2025 08:44:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364705748sm28558315e9.28.2025.06.20.08.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 08:44:53 -0700 (PDT)
Message-ID: <2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b@redhat.com>
Date: Fri, 20 Jun 2025 17:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/19] intel_iommu: Handle PASID entry removing and
 updating
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-11-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-11-zhenzhong.duan@intel.com>
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
I would suggest: Handle PASID entry removal and update instead of verbing.
> This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
> pasid entry and track PASID usage and future PASID tagged DMA address
> translation support in vIOMMU.
>
> VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
> never freed. For other pasid, VTDAddressSpace instance is created/destroyed
> per the guest pasid entry set up/destroy for passthrough devices. While for
> emulated devices, VTDAddressSpace instance is created in the PASID tagged DMA
> translation and be destroyed per guest PASID cache invalidation. This focuses
s/be detroyed/destroyed
> on the PASID cache management for passthrough devices as there is no PASID
> capable emulated devices yet.
if you don't handle the emulated device case, may be omit talking about
them here.
>
> When guest modifies a PASID entry, QEMU will capture the guest pasid selective
> pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
> invalidation reasons:
>
>     a) a present pasid entry moved to non-present
>     b) a present pasid entry to be a present entry
>     c) a non-present pasid entry moved to present
>
> This handles a) and b), following patch will handle c).
This -> This patch
>
> vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
> and compare it with the PASID cache.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  27 ++++
>  include/hw/i386/intel_iommu.h  |   6 +
>  hw/i386/intel_iommu.c          | 265 +++++++++++++++++++++++++++++++--
>  hw/i386/trace-events           |   3 +
>  4 files changed, 291 insertions(+), 10 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 18bc22fc72..01c881ed4d 100644
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
Adding some basic comments for the uncultured reader like me would help
doing the link with the vtd spec:
PASID-cache Invalidate Descriptor (pc_inv_dsc) fields
> +#define VTD_INV_DESC_PASIDC_G          (3ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID(val) (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PASIDC_DID(val)   (((val) >> 16) & VTD_DOMAIN_ID_MASK)
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0  0xfff000000000f1c0ULL
> +
> +#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
> +#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
as those are values for the granularity field using

VTD_INV_DESC_PASIDC_G_* look relevant to me.


I think you would gain in readability if you adopt extract32/64 syntax
like in hw/arm/smmuv3-internal.h
Looks more readable to me.
> +
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
> @@ -552,6 +562,22 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  
> +typedef enum VTDPCInvType {
> +    /* pasid cache invalidation rely on guest PASID entry */
> +    VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
> +    VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
> +    VTD_PASID_CACHE_PASIDSI,    /* pasid cache pasid selective invalidation */
> +} VTDPCInvType;
> +
> +typedef struct VTDPASIDCacheInfo {
> +    VTDPCInvType type;
> +    uint16_t domain_id;
did?
> +    uint32_t pasid;
> +    PCIBus *bus;
> +    uint16_t devfn;
> +    bool error_happened;
wouldn't it make more sense to store an Error * directly so that you can
fill it whenever there is an error occuring.
Something like VFIOContainerBase::error
> +} VTDPASIDCacheInfo;
> +
>  /* PASID Table Related Definitions */
>  #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>  #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> @@ -563,6 +589,7 @@ typedef struct VTDRootEntry VTDRootEntry;
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
> index 8948b8370f..1db581d14a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -826,11 +826,24 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>      }
>  }
>  
> +static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
> +{
> +    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
see my previous comment about extract*
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
>  }
>  
> +static inline void pasid_cache_info_set_error(VTDPASIDCacheInfo *pc_info)
not sure whether this helper is really needed
> +{
> +    if (pc_info->error_happened) {
Besides why not simply overwriting unconditionnally?
> +        return;
> +    }
> +    pc_info->error_happened = true;
> +}
> +
>  /**
>   * Caller of this function should check present bit if wants
>   * to use pdir entry for further usage except for fpd bit check.
> @@ -3103,6 +3116,241 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>      return true;
>  }
>  
> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> +                                            uint32_t pasid, VTDPASIDEntry *pe)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
> +                                   &ce);
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
> +static int vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
> +                                VTDPASIDEntry *pe)
> +{
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +
> +    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
> +        /* No need to go further as cached pasid entry is latest */
> +        return 0;
> +    }
> +
> +    pc_entry->pasid_entry = *pe;
> +    pc_entry->cache_filled = true;
> +
> +    /*
> +     * TODO: send pasid bind to host for passthru devices
> +     */
> +
> +    return 0;
> +}
> +
> +/*
> + * This function is used to update or clear cached pasid entry in vtd_as
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
> +    if (!pc_entry->cache_filled) {
> +        return false;
> +    }
> +    did = vtd_pe_get_did(&pc_entry->pasid_entry);
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        goto remove;
> +    }
> +
> +    switch (pc_info->type) {
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
if you don't do that in that patch I would put that in a subsequent
patch. Focus on the PASID cache in this patch. See my subsequent comment
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
> +    if (vtd_fill_pe_in_cache(s, vtd_as, &pe)) {
> +        pasid_cache_info_set_error(pc_info);
> +    }
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
> +/*
> + * This function syncs the pasid bindings between guest and host.
> + * It includes updating the pasid cache in vIOMMU and updating the
> + * pasid bindings per guest's latest pasid entry presence.
> + */
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> +                                 VTDPASIDCacheInfo *pc_info)
> +{
> +    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
you don't update error_happened. Is that OK?
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
I would put all the stuff related to interactions with host in a
subsequent patch. This patch could concentrate on the IOMMU PASID cache
only. And then you would add the extra complexity of syncs with the
host. I think it would simplify the review.
> +     *
> +     */
> +
> +    vtd_iommu_lock(s);
> +    /*
> +     * Step 1: loop all the existing vtd_as instances for pasid unbind and
> +     * update.
> +     */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid,
> +                                pc_info);
> +    vtd_iommu_unlock(s);
> +
> +    /* TODO: Step 2: loop all the existing vtd_hiod instances for pasid bind. */
> +}
> +
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    VTDPASIDCacheInfo pc_info = {};
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
Make it end-user understandable? invalid granulrity field in PASID-cache
invalidate descriptor.
> +                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }
> +
> +    vtd_pasid_cache_sync(s, &pc_info);
> +    return !pc_info.error_happened ? true : false;
> +}
> +
>  static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                       VTDInvDesc *inv_desc)
>  {
> @@ -3264,6 +3512,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
> @@ -3299,16 +3554,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
> index ac9e1a10aa..ae5bbfcdc0 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>  vtd_inv_qi_tail(uint16_t head) "write tail %d"
>  vtd_inv_qi_fetch(void) ""
>  vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_gsi(void) ""
> +vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
Would use pasid cache instead of PC
> +vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
Thanks

Eric


