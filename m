Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77569C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 11:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfeo-0006zD-5m; Mon, 23 Jun 2025 07:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTfek-0006uy-UE
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTfee-0004Wu-1L
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750679280;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9IVBIn6l+YXSkU3isE1skZBHR7aR9UyGEJX155a5HXE=;
 b=MZh5B9X6aRuzxiebGbn2/WVbEXfz4RzT6W/w3K2veK3VrHXtwookW37w6qzwuAckY/A+fP
 N57kEr2mbhY45N2bmCPOjcI1pPAhTdqwhCRPuV4BcmubroiLhjyzg8zkjUzHG2t4ny5Gjt
 zTFkekaSHin3DVgdD8fV+W2mnE0Z42U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-rgL8-0gPMOG89MCliQhlMQ-1; Mon, 23 Jun 2025 07:47:59 -0400
X-MC-Unique: rgL8-0gPMOG89MCliQhlMQ-1
X-Mimecast-MFC-AGG-ID: rgL8-0gPMOG89MCliQhlMQ_1750679278
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2073373f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 04:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750679278; x=1751284078;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9IVBIn6l+YXSkU3isE1skZBHR7aR9UyGEJX155a5HXE=;
 b=Ov3xTCKXDlv0K7JYJ2MP8iIzeJJ7Ce2YREOpnGujxj9dg60C/4IAUu/Dc5ANWYoUYG
 DmyjqCZ4fSLZu7K3YWSuZrhUsnn/aKuT+2L3HcCb/Gbyoga3OaPnVyNL/Y7ZC5rvFdAZ
 X3E4XbAmggMDkYJAsH94cexFY/9xOSztOQsehrKa7IprD4Y7ccMVuhY3Gq543IROG+nf
 0+Rfl/yqMwx4GHD8q+uBXeM7IkAO/iynCLH+z9wDJb3iAWKvKrUPI1ip+EeNbj9zAAtB
 A9wE/iNC1VEVRqXilgJQzcTKwxyzaXu+qE8+v2ZWk9V20WZcahGVobtkHhiQPHITRONa
 +IfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnDsyuegl+zT/6zOdWazskZnYJuHsOHoYQRlTjDK4tiotDm9LKyZ96EnyV1ImTmc8oi+tjmZuKm6eY@nongnu.org
X-Gm-Message-State: AOJu0YzQmbHuIOT4Ak+acprVEb/xaYRzNg4/kdsPITmubUyQMsQkWwS9
 7nWOSgi7jWHcNHhWYEeKljJPyqYS/Blf0vjRZdBEIVJAZGRWM6b1mYodUFjKQa4w8FS+yW2/Exx
 XefcxGVKb9FuFcgRJyzCXkqhjgpYogy+9DcfW8cLWSYjthhehhcxkr+F4
X-Gm-Gg: ASbGnctbNxmqFPk7Qj05umDizwNce4Afa9g5E7T2FYVc6PdEPSRLE1Zda0iR6eqp1Qq
 Bk6HCdQCwClZ06+eQaSFYsz6O43KxVrJ3eHmdt2teUEkNd4OVvyMtyd5Do5D9ssrBBw5UF/gtcJ
 CVIEx8kj/Ryn0y7Madvpz76jiRSYNtLv+ZZmzz956+xbDwKEp3KsiFwGaQbQyxa0MQ+9Ge7dtXE
 Q1AUcdrKDdIgwqQ6rwugPMRRz+MTJvMs6Hgx4TELRVCNWtZ20pNUmvdzvgrTaOXzHyjeJ+nYRsE
 Lrcf0ZHHC0y8cxgtPAxyt70fMQfFJpT4A16z+uZxqZ53tzKBoWNAg/TY5pqNoHhME4fAFA==
X-Received: by 2002:a05:6000:2084:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3a6d1192980mr7294093f8f.8.1750679277909; 
 Mon, 23 Jun 2025 04:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfWLiTjCaTjgjAMfFy2XEKuhsqNO1F/bBBVZCuxj80TXgfw93mq6hDB9opErW0pRlnW2IANg==
X-Received: by 2002:a05:6000:2084:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3a6d1192980mr7294074f8f.8.1750679277427; 
 Mon, 23 Jun 2025 04:47:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1188c6esm9027449f8f.81.2025.06.23.04.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 04:47:56 -0700 (PDT)
Message-ID: <aef0acb5-cfda-4976-acd4-66fc544cddef@redhat.com>
Date: Mon, 23 Jun 2025 13:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/19] intel_iommu: Handle PASID entry adding
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
 <20250620071813.55571-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-12-zhenzhong.duan@intel.com>
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
> When guest modifies a PASID entry, QEMU will capture the guest pasid selective
> pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
> invalidation reasons:
>
>     a) a present pasid entry moved to non-present
>     b) a present pasid entry to be a present entry
>     c) a non-present pasid entry moved to present
>
> This handles c).

As you use the replay terminology in the patch, please explain what it
means in that case and how the patch achieve above goal.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |   1 +
>  hw/i386/intel_iommu.c          | 169 ++++++++++++++++++++++++++++++++-
>  2 files changed, 169 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 01c881ed4d..025787b3b9 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -558,6 +558,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>  
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(val)      (((val) >> 9) & 0x7)
>  #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1db581d14a..f4273dc640 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -826,6 +826,11 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>      }
>  }
>  
> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
> +{
> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
> +}
> +
>  static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
>  {
>      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
> @@ -3246,6 +3251,159 @@ remove:
>      return true;
>  }
>  
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
> +            vtd_iommu_lock(s);
> +            /*
> +             * When indexed by rid2pasid, vtd_as should have been created,
> +             * e.g., by PCI subsystem. For other iommu pasid, we need to
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
> +                !(info->domain_id == vtd_pe_get_did(&pe))) {
> +                /*
> +                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +                 * requires domain ID check. If domain Id check fail,
> +                 * go to next pasid.
> +                 */
> +                pasid = pasid_next;
> +                continue;
> +            }
> +            if (vtd_fill_pe_in_cache(s, vtd_as, &pe)) {
> +                pasid_cache_info_set_error(info);
> +            }
> +        }
> +        pasid = pasid_next;
> +    }
> +}
> +
> +/*
> + * Currently, VT-d scalable mode pasid table is a two level table,
do you mean PASID dir + PASID table? in the positive I would use that
terminology directly.
> + * this function aims to loop a range of PASIDs in a given pasid
aims at looping over a range of PASIDs in a given table?
so what do you call a table here? is a a PASID directory ot a PASID table.
> + * table to identify the pasid config in guest.
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
> + * This function replay the guest pasid bindings to hosts by
replays, host
> + * walking the guest PASID table. This ensures host will have
> + * latest guest pasid bindings.
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
this is still not totally clean to me. For domsi I would have expected a
different setting of start and end?
> +         */
> +    case VTD_PASID_CACHE_DOMSI:
fall though clause here and above?
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        /* loop all assigned devices */
> +        break;
> +    default:
> +        error_report("invalid pc_info->type for replay");
> +        abort();
> +    }
> +
> +    /*
> +     * In this replay, only needs to care about the devices which
one only needs to care
> +     * are backed by host IOMMU. For such devices, their vtd_hiod
Those devices have a corresponding vtd_hiod in s->vtd_host_iommu_dev
> +     * instances are in the s->vtd_host_iommu_dev. For devices which
> +     * are not backed by host IOMMU, it is not necessary to replay
> +     * the bindings since their cache could be re-created in the future
> +     * DMA address translation. Access to vtd_host_iommu_dev is already
> +     * protected by BQL, so no iommu lock needed here.
> +     */
> +    walk_info = *pc_info;
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> +        /* bus|devfn fields are not identical with pc_info */
Can you clarify?
> +        walk_info.bus = vtd_hiod->bus;
> +        walk_info.devfn = vtd_hiod->devfn;
> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
> +    }
> +    if (walk_info.error_happened) {
> +        pasid_cache_info_set_error(pc_info);
> +    }
> +}
> +
>  /*
>   * This function syncs the pasid bindings between guest and host.
>   * It includes updating the pasid cache in vIOMMU and updating the
> @@ -3301,7 +3459,16 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
>                                  pc_info);
>      vtd_iommu_unlock(s);
>  
> -    /* TODO: Step 2: loop all the existing vtd_hiod instances for pasid bind. */
> +    /*
> +     * Step 2: loop all the existing vtd_hiod instances for pasid bind.
> +     * Ideally, needs to loop all devices to find if there is any new
> +     * PASID binding regards to the PASID cache invalidation request.
> +     * But it is enough to loop the devices which are backed by host
> +     * IOMMU. For devices backed by vIOMMU (a.k.a emulated devices),
> +     * if new PASID happened on them, their vtd_as instance could
> +     * be created during future vIOMMU DMA translation.
the above comment is somehow redundant with the previous one
> +     */
> +    vtd_replay_guest_pasid_bindings(s, pc_info);
>  }
>  
>  static bool vtd_process_pasid_desc(IntelIOMMUState *s,
Thanks

Eric


