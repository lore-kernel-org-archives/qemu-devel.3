Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E9CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urIup-0004yO-SG; Wed, 27 Aug 2025 12:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urIun-0004wx-Jd
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urIuj-0001nf-OF
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756311737;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DGv6MNNroM1+4SQ4acGAdFjN+zEuPGQ/Rho7Wqxy/o=;
 b=Tn9O6zlJUnxzsMKz2yMXgRSug/FdwmSuXcztVy7eenRqOPD5UED6lMVO2MEOvM43aqzr8U
 jv+nNK+4dRmvnhzUXdwSRxnp7IZCWYog5+F6W2C5XEsHSlA8XtpQ/7MfF2EHB9YYPA997y
 O1fyiAcEirtzF286AGDfitGd01nHfns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-zU2TWV_UPpaN98kJcDTtWg-1; Wed, 27 Aug 2025 12:22:16 -0400
X-MC-Unique: zU2TWV_UPpaN98kJcDTtWg-1
X-Mimecast-MFC-AGG-ID: zU2TWV_UPpaN98kJcDTtWg_1756311735
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0045a0so48843175e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 09:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756311735; x=1756916535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DGv6MNNroM1+4SQ4acGAdFjN+zEuPGQ/Rho7Wqxy/o=;
 b=uN7t/0ZZhz2vqnRfl3m9plPwpPqEPKrVjlQix1bn6HMmqonMHhOjxOIWqRFWUImLb+
 tBi1FXHQzbo+nhSvVTMPrOQPki30PNLV3xBM+UU9qgH0p4tjaXzjtmQfxjD1xRMzbor/
 1LAZZQPkabDnU9kbxS2FIsNiTMIlCzcGsDzFGzi+5N3KT3DUmYWlZ60U3GIiZGY4L9/v
 647cEOYC6rsa/zN2QSpYmc4Cpb+h0K7k9WOyg1x3IGrN/KpnMGfn29gP+eR4xix9BFu/
 b1je0kk4oVcMCm1AK4NjoTf02MSSiH9D8h2WlA023BaWNcZmbQxbUodYmWyty5FCBV+V
 XRqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz0HkdGSu4Z6UT9U/jVrlbhUJveIh+xheS5v1J4PwOrEuzJ1By0zf0443xg9RDYQqCuHMw3zYyIYPp@nongnu.org
X-Gm-Message-State: AOJu0YwnK3Mn7PfbJm7Z0U/P6ujHtWHzOnWIqBq/Nc4p8q6ijlPiuuqG
 QoCGd63KTPTDc7+QtsbhEih1y25IjNv2Y0s0ijRyZoMQvU/O5vOzceNqoHIP2pf4AbgbyV00r4w
 xLcNGHkuEnIlQXAAmDqTWxtQW8KroMf0ijEiLif+YoyECiW78uOL8teeo
X-Gm-Gg: ASbGncvfxei76eh4NpNoBVeTWeYwj69AlQ+JOCfhTiu3Yaxu+FOqFUdDEyWHVOcoZwI
 KoKe1wKdhI9zMytjFTFd3X4ZTfziTCEEuXpc6OBQTA8vN24cUfvCCRNKMMs+GUIzAwXHOJnWy01
 ddnFHvHwemIh3wsp37p0vcTAGyca4CI0zhl4TvOxxV5VZW5ItN94B87R5N9xYO8bsDrpCgdGcXL
 F1nG2PKSituoZlp1vM4KWh3JZzJWp3nXQKstanXgq4Xb3mD00iP9W8CAie11Ohzb1Gz2An2B2a5
 WeOWTDtSyLvZdchJyS9csGc5oFpAGUmQperUZdYPae+XnBGye5l+mL1WWTJVvr1XqIzcWcuNzFA
 ey+eZYa3KBwE=
X-Received: by 2002:a05:600c:1e85:b0:458:bc2c:b2ed with SMTP id
 5b1f17b1804b1-45b5179f402mr180086965e9.7.1756311734686; 
 Wed, 27 Aug 2025 09:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIHsinbLmuvsHxFTfgI+ESf2iHqIMnwKF3zQ1XuSOFVifyO4UTtQepQxkc8L0AYGc/1Ci91A==
X-Received: by 2002:a05:600c:1e85:b0:458:bc2c:b2ed with SMTP id
 5b1f17b1804b1-45b5179f402mr180086555e9.7.1756311734167; 
 Wed, 27 Aug 2025 09:22:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f2f31d2sm34890185e9.25.2025.08.27.09.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 09:22:13 -0700 (PDT)
Message-ID: <5b25de4b-ae84-4926-9e14-2ab4262e973f@redhat.com>
Date: Wed, 27 Aug 2025 18:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/21] intel_iommu: Handle PASID entry addition
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-13-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-13-zhenzhong.duan@intel.com>
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

Hi Zhenzhong,

On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> When guest creates new PASID entries, QEMU will capture the guest pasid
> selective pasid cache invalidation, walk through each passthrough device
> and each pasid, when a match is found, identify an existing vtd_as or
> create a new one and update its corresponding cached pasid entry.

You need to emphasize that the support is currently limited to
Requests-without-PASID
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |   2 +
>  hw/i386/intel_iommu.c          | 176 ++++++++++++++++++++++++++++++++-
>  2 files changed, 175 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index b9b76dd996..fb2a919e87 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -559,6 +559,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>  
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>  #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
> @@ -589,6 +590,7 @@ typedef struct VTDPASIDCacheInfo {
>  #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>  #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>  #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
>  
>  /* PASID Granular Translation Type Mask */
>  #define VTD_PASID_ENTRY_P              1ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a2ee6d684e..7d2c9feae7 100644
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
> @@ -3220,10 +3225,172 @@ remove:
>      return true;
>  }
>  
> +/*
> + * This function walks over PASID range within [start, end) in a single
> + * PASID table for entries matching @info type/did, then retrieve/create
> + * vtd_as and fill associated pasid entry cache.
> + */
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
> +             * create vtd_as dynamically. Other iommu pasid is same value
since you don't support somthing else than rid2pasid, I would drop that
and simplify the code. See below.
> +             * as PCI's pasid, so it's used as input of vtd_find_add_as().
> +             */
> +            vtd_as = vtd_as_from_iommu_pasid_locked(s, sid, pasid);
> +            vtd_iommu_unlock(s);
> +            if (!vtd_as) {
> +                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
you could check the vtd_as already exists here per the rid2pasid support
limitation
> +            }
> +
> +            if ((info->type == VTD_PASID_CACHE_DOMSI ||
> +                 info->type == VTD_PASID_CACHE_PASIDSI) &&
> +                (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
> +                /*
> +                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +                 * requires domain id check. If domain id check fail,
fails
> +                 * go to next pasid.
> +                 */
> +                pasid++;
> +                continue;
> +            }
> +
> +            pc_entry = &vtd_as->pasid_cache_entry;
> +            /*
> +             * pasid cache update and clear are handled in
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
if you never replay a range, you could simplify the code for now because
some code paths are not properly tested
> +       /* fall through */
> +    case VTD_PASID_CACHE_DOMSI:
Why can't we have other invalidation types along with request without
PASID? It is not obvious to me at least why it couldn't be used by the
guest. Would deserve a comment in the commit desc I think.
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
>  /*
>   * For a PASID cache invalidation, this function handles below scenarios:
>   * a) a present cached pasid entry needs to be removed
>   * b) a present cached pasid entry needs to be updated
> + * c) a present cached pasid entry needs to be created
>   */
>  static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>  {
> @@ -3239,6 +3406,9 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>      g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid_locked,
>                                  pc_info);
>      vtd_iommu_unlock(s);
> +
> +    /* c): loop all passthrough device for new pasid entries */
> +    vtd_replay_guest_pasid_bindings(s, pc_info);
>  }
>  
>  static bool vtd_process_pasid_desc(IntelIOMMUState *s,
Thanks

Eric


