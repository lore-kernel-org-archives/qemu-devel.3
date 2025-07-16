Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C33C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5FS-00024u-KW; Wed, 16 Jul 2025 12:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uc5F8-0001cu-Gh
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uc5F4-0000EI-Gw
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752684264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kffe2GYA489S2xxu7eIgzYoaYfM3G+qyMCJfW8EuQgA=;
 b=Wcaesc6VV7MXERNtj0OD0+hEweca/nTXKZh6aovcr/nCCNm8IP6kkyRu6PDwMOCr6nocKF
 IQHmDY8sGwU9y3DaxdEkIMvte0NNmPUDlS+gxuMEKvdWJJpFstzSCJoMZ5tdtcSvvHmJQF
 ibZoAR1/KGtz6U0Sg75+8kaPWiBiLj0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-OYXqF5vYOL2yVXRH-LdOIQ-1; Wed, 16 Jul 2025 12:44:22 -0400
X-MC-Unique: OYXqF5vYOL2yVXRH-LdOIQ-1
X-Mimecast-MFC-AGG-ID: OYXqF5vYOL2yVXRH-LdOIQ_1752684261
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453817323afso290195e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 09:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752684261; x=1753289061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kffe2GYA489S2xxu7eIgzYoaYfM3G+qyMCJfW8EuQgA=;
 b=uBil/lRTutnk0g0IhFRhBFsptjYE0S2K7W0AOjFcqx2ZjqER8KHli9bsJrcqAdagBN
 I4c55WNIFZhVELoYM2ebdeTRn++ma1FU33jto2yizG8T3iuTcRngJK2xArW/8tdHZOwl
 lXccT84KzXyBCQRWyyAUAQ6kRvFby1ByJcY00tJ4gB7jPz0XdNk12gBKQRr+mQKs+fL4
 2xDS7ibF9+PVg4RSQao0zQc+MtjC7X+nXIPwnq4Z2Aqrajk2iq66q7WQBtRJNVZIsu8f
 FPw1IcnaFI0lD3dQm1ftj+YMUk/l8Ga/03Wo1ksStvI++MnIqsb/mqjv9NvbmlY9dyJk
 SQ1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmRCkTOTw7RVNMzVbRfhIjvh4mgBD15YTd5zYhk6nl353ZfrdYJ0dkA9kh1EfGdLI0Noi2/wV4opta@nongnu.org
X-Gm-Message-State: AOJu0Yxt62bx1Hx0/g6dJESXqkgSj5D2YCGZNr7A66oPDpYYCcNRvjEa
 bJIuZHBb8Y+mVgf20G0dH5QmyXV4d8bzjTrUS33PBP7ddypIdXJdOTotlgY9O7P71kNhghf+pPN
 lEBYD38342kwbln2U++0uyHy3z04fLtmunMZMCtuUZYHbBp43KA6FzPHL
X-Gm-Gg: ASbGncsjqo7lOsvxbWjmqL7QW9bv94uQVbKAWDKFQN+Iyn3TXR1z/MQwUFW2yfCB3y+
 cSyYDJO06BcvYFeKiAOTs78K/qLNdzTWLUz6rMslwI/gUG4pNA8Dk1DyuzDKefkYCIvbm2EBy/X
 XJWnRpFRKXj+AcXHqeZJnNKqvYdGVzXqQ/sPmN6NyzyjHubYXRPf/rwTJ4RsuodQR3rUz/obF2K
 kBS7yKNuzWNy7Bc1HawbIWrTZA3yl7Wcwd1J5T92wpNyfgmS4zgla0trNCUSdGAhlZOrnmgJuZ8
 do9pJczsLmVKdgwUfciicww3xVt0T+UC/0yqNycFTA62S0e8S7IKdpewvwO4naKai6KeesIXTLs
 mNUw8eb7y9vg=
X-Received: by 2002:a05:600c:450f:b0:455:f380:32e2 with SMTP id
 5b1f17b1804b1-4562e27650bmr41737655e9.18.1752684261147; 
 Wed, 16 Jul 2025 09:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELYAR+b10JjsRcwXM7kb1VDzMeeWy/sK4Cs8t6TdfTwN4tDEFGX5exhIUI1kHr0WWVhKUf9A==
X-Received: by 2002:a05:600c:450f:b0:455:f380:32e2 with SMTP id
 5b1f17b1804b1-4562e27650bmr41737205e9.18.1752684260591; 
 Wed, 16 Jul 2025 09:44:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e82d58esm26455265e9.25.2025.07.16.09.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 09:44:19 -0700 (PDT)
Message-ID: <242b731f-3f83-47e7-8beb-dd92d2f7aee5@redhat.com>
Date: Wed, 16 Jul 2025 18:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] intel_iommu: Handle PASID entry adding
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708110601.633308-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
> When guest modifies a PASID entry, QEMU will capture the guest pasid selective
> pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
> invalidation reasons:

commit msg: intel_iommu: Handle PASID entry addition?
Same for previous patch, ie. use nouns
>
>     a) a present pasid entry moved to non-present
>     b) a present pasid entry to be a present entry
>     c) a non-present pasid entry moved to present
just focus on c to avoid extra noise?
>
> This handles c) by going through each passthrough device and each pasid. When
> a new valid pasid entry is founded, find or create a vtd_as and cache pasid
is found, identify an existing vtd_as or create a new one and update its
corresponding cached pasid entry.
> entry in it.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c          | 170 ++++++++++++++++++++++++++++++++-
>  hw/i386/intel_iommu_internal.h |   2 +
>  2 files changed, 169 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5bda439de6..cf2c959b60 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -826,6 +826,11 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>      }
>  }
>  
> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
> +{
> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
> @@ -1647,9 +1652,9 @@ static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
>  }
>  
>  /* Translate iommu pasid to vtd_as */
> -static inline
> -VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
> -                                                uint16_t sid, uint32_t pasid)
> +static VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
> +                                                       uint16_t sid,
> +                                                       uint32_t pasid)
>  {
>      struct vtd_as_raw_key key = {
>          .sid = sid,
> @@ -3206,6 +3211,162 @@ remove:
>      return true;
>  }
>  
I think this would deserve a doc comment explaining it retrieves/creates
vtd_as and associated cached PE for PASID range within [start, end] that
matches @info type/did. Also you may document that the "_one" means it
walks a single SM page table between start/end  (if my understanding is
correct)
> +static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
> +                                        dma_addr_t pt_base,
> +                                        int start,
> +                                        int end,
> +                                        VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDEntry pe;
> +    int pasid = start;
> +
> +    while (pasid < end) {
> +        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
> +            && vtd_pe_present(&pe)) {
> +            int bus_n = pci_bus_num(info->bus), devfn = info->devfn;
> +            uint16_t sid = PCI_BUILD_BDF(bus_n, devfn);
> +            VTDPASIDCacheEntry *pc_entry;
> +            VTDAddressSpace *vtd_as;
> +
> +            vtd_iommu_lock(s);
> +            /*
> +             * When indexed by rid2pasid, vtd_as should have been created,
> +             * e.g., by PCI subsystem. For other iommu pasid, we need to
I thought iommu pasid was rid2pasid, as opposed to regular PCI pasids.
> +             * create vtd_as dynamically. The other iommu pasid is same as
> +             * PCI's pasid, so it's used as input of vtd_find_add_as().
> +             */
> +            vtd_as = vtd_as_from_iommu_pasid_locked(s, sid, pasid);
> +            vtd_iommu_unlock(s);
> +            if (!vtd_as) {
> +                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
> +            }
> +
> +            if ((info->type == VTD_PASID_CACHE_DOMSI ||
> +                 info->type == VTD_PASID_CACHE_PASIDSI) &&
> +                (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
> +                /*
> +                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +                 * requires domain id check. If domain id check fail,
require
> +                 * go to next pasid.
> +                 */
> +                pasid++;
> +                continue;
> +            }
> +
> +            pc_entry = &vtd_as->pasid_cache_entry;
> +            /*
> +             * pasic cache update and clear are handled in
> +             * vtd_flush_pasid_locked(), only care new pasid entry here.
> +             */
> +            if (!pc_entry->valid) {
> +                pc_entry->pasid_entry = pe;
> +                pc_entry->valid = true;
> +            }
> +        }
> +        pasid++;
> +    }
> +}
> +
> +/*
> + * In VT-d scalable mode translation, PASID dir + PASID table is used.
> + * This function aims at looping over a range of PASIDs in the given
> + * two level table to identify the pasid config in guest.
> + */
> +static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
> +                                    dma_addr_t pdt_base,
> +                                    int start, int end,
> +                                    VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDDirEntry pdire;
> +    int pasid = start;
> +    int pasid_next;
> +    dma_addr_t pt_base;
> +
> +    while (pasid < end) {
> +        pasid_next =
> +             (pasid + VTD_PASID_TBL_ENTRY_NUM) & ~(VTD_PASID_TBL_ENTRY_NUM - 1);
> +        pasid_next = pasid_next < end ? pasid_next : end;
> +
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
> +
> +    if (!vtd_dev_to_context_entry(s, pci_bus_num(info->bus), info->devfn,
> +                                  &ce)) {
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
> + * This function replays the guest pasid bindings by walking the two level
> + * guest PASID table. For each valid pasid entry, it finds or creates a
> + * vtd_as and caches pasid entry in vtd_as.
> + */
> +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
> +                                            VTDPASIDCacheInfo *pc_info)
> +{
> +    /*
> +     * Currently only Requests-without-PASID is supported, as vIOMMU doesn't
> +     * support RPS(RID-PASID Support), pasid scope is fixed to [0, 1).
> +     */
> +    int start = 0, end = 1;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    VTDPASIDCacheInfo walk_info;
> +    GHashTableIter as_it;
> +
> +    switch (pc_info->type) {
> +    case VTD_PASID_CACHE_PASIDSI:
> +        start = pc_info->pasid;
> +        end = pc_info->pasid + 1;
> +       /* fall through */
> +    case VTD_PASID_CACHE_DOMSI:
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        /* loop all assigned devices */
> +        break;
> +    default:
> +        error_setg(&error_fatal, "invalid pc_info->type for replay");
> +    }
> +
> +    /*
> +     * In this replay, one only needs to care about the devices which are
> +     * backed by host IOMMU. Those devices have a corresponding vtd_hiod
> +     * in s->vtd_host_iommu_dev. For devices not backed by host IOMMU, it
> +     * is not necessary to replay the bindings since their cache could be
> +     * re-created in the future DMA address translation.
> +     *
> +     * VTD translation callback never accesses vtd_hiod and its corresponding
> +     * cached pasid entry, so no iommu lock needed here.
> +     */
> +    walk_info = *pc_info;
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> +        walk_info.bus = vtd_hiod->bus;
> +        walk_info.devfn = vtd_hiod->devfn;
> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
> +    }
> +}
> +
>  /* Update the pasid cache in vIOMMU */
>  static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>  {
> @@ -3228,6 +3389,9 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>      g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid_locked,
>                                  pc_info);
>      vtd_iommu_unlock(s);
> +
> +    /* c): loop all passthrough device for new pasid entries */
> +    vtd_replay_guest_pasid_bindings(s, pc_info);
>  }
>  
>  static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 87059d26aa..621e1f6947 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -558,6 +558,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>  
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>  #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
> @@ -588,6 +589,7 @@ typedef struct VTDPASIDCacheInfo {
>  #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>  #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>  #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
>  
>  /* PASID Granular Translation Type Mask */
>  #define VTD_PASID_ENTRY_P              1ULL
Thanks

Eric


