Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C330CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 07:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEjug-0001Ww-8j; Fri, 31 Oct 2025 03:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vEjud-0001WJ-KH
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 03:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vEjuU-0005Mq-BR
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 03:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761897049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHHipnekQDVZGlIVWDYLqvqmAHouLFJUYgbU7HMbmQY=;
 b=XCtCtM3bK8/Pfhk/mBEIZG9T/lKiTHFqrHemMnE47A6HEM+3qvYQ4T1y4xqcOB9xZdqOxU
 Biot58ZMpBD/iloKod96lLsQmDoP/O/WvfETN+Z9lZvlVwo3JpvyOee9MyU5MP9MiWYSpV
 UkbUTFgtAxAbYsnVqNFGbvJgpvIABrk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-rnPIt5ZqORWf-Fw76gDtVw-1; Fri, 31 Oct 2025 03:50:46 -0400
X-MC-Unique: rnPIt5ZqORWf-Fw76gDtVw-1
X-Mimecast-MFC-AGG-ID: rnPIt5ZqORWf-Fw76gDtVw_1761897044
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429bf2f85d6so202811f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 00:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761897044; x=1762501844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHHipnekQDVZGlIVWDYLqvqmAHouLFJUYgbU7HMbmQY=;
 b=KJtzHB+YhIZ5HdoWJJwtrdunGA/kS4Sd/zPodNQjIkLpkmBxmpWQvRi5Hwo2HqFnhG
 pp2Z++zgyjtRv8pU9CBwGm1fw8zav1wMyCInc1wkEkuVUB6LA/hqDdonmZYujI2TKHcp
 ftYUgLlEpEFoyS/mBUjeuGDqmi15cG2ZdOr9N/KQM8vVRVf9NxbKfSQaTbCqUgROFL2s
 JdOdIH9UA5YCEm1cDX9dyfnnVJcoooMx03i1MYvR5quwsiaTVeqId33yEEK3kBQDGhQB
 1DNlDYnK2vEuJ0D/2uc8vFbTwMkeqgaPGkT9pTlhzWxW6G8xn6rp2YcGieiz5Ar7BqOh
 Nycw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyvbNID3jiZ73CeMMZJxX43Shs62V7J4QvFCNyPzYyboL8clMu2UZixCk1bBq+83QmlexzA6oV64DT@nongnu.org
X-Gm-Message-State: AOJu0YxWIX32ZQhhpxYz8EHwoxvlyBb9kxMkU1mDTCIR0SIpzbkTggDK
 9DyxPj1Rj1vA8o7BvrIez68otd8meyH+EMgkab4eXxNWTs7pnLSZhN1vpqb+aF+nzZElJx7mNmb
 Vh7UNfZ28MNNgk5vGSGD4706EO18sL5REEayOV1T8RhVAuPNNfZD0/1Ow
X-Gm-Gg: ASbGncvu+KV6HSgt6SY6Ly7eveG4uo6nG6jlsgcxiedMCT5CO5/hB10bG6TggwnYiX4
 jvWGgC+CRKpGa1vnW/8SqioU7oQwbIb21MLYnowZIbOgEnwKPcC9gkNklPkTSQp5CzeAt43KC6Q
 tD3m2QfZBSOEb24qYu7qnLzn29WAuKh93bn4d/ncYtE+Gr5lDhlCp7L5KpRpe3Pz7koJfC4zGV5
 XX8RVk2hyfUulfE4IIklqsZYD7+hM7apXbjEAjYRw8W0cE6af+UFHLueQioFnTDXQdxgN7N+vJM
 AI1SPZFJKQ9gGHZNBl9zuRL70hgCZ5J7t5nkOuJLnwY2JgqAoT7Y/D3urvL5/hwjKIhCF4kpV7W
 1StKVeXHNAUaw1jbeg2bRY6pkVHztXuq8b6/wZFD6Z+U2Sw==
X-Received: by 2002:a05:6000:2407:b0:3ee:15c6:9a6b with SMTP id
 ffacd0b85a97d-429bd6a621amr2002735f8f.48.1761897044123; 
 Fri, 31 Oct 2025 00:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpckl1cgQoes+hQV6yTICIb6LOFkmbkT/Srx8L7E4d96wQRnzbt9ici1w6DRO75K+ITy331Q==
X-Received: by 2002:a05:6000:2407:b0:3ee:15c6:9a6b with SMTP id
 ffacd0b85a97d-429bd6a621amr2002698f8f.48.1761897043610; 
 Fri, 31 Oct 2025 00:50:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe1075sm18258325e9.11.2025.10.31.00.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 00:50:43 -0700 (PDT)
Message-ID: <4a46df94-76dc-4c4b-b05c-09ecad583f7c@redhat.com>
Date: Fri, 31 Oct 2025 08:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/23] intel_iommu: Delete RPS capability related
 supporting code
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
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
> RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
> code is there but never takes effect.
>
> Meanwhile, according to VTD spec section 3.4.3:
> "Implementations not supporting RID_PASID capability (ECAP_REG.RPS is 0b),
> use a PASID value of 0 to perform address translation for requests without
> PASID."
>
> We should delete the supporting code which fetches RID_PASID field from
> scalable context entry and use 0 as RID_PASID directly, because RID_PASID
> field is ignored if no RPS support according to spec.
>
> This simplifies the code and doesn't bring any penalty.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  1 -
>  hw/i386/intel_iommu.c          | 82 +++++++++++-----------------------
>  2 files changed, 27 insertions(+), 56 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 75bafdf0cd..bf8fb2aa80 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -609,7 +609,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>  
> -#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 70746e3080..06065d16b6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -42,8 +42,7 @@
>  #include "trace.h"
>  
>  /* context entry operations */
> -#define VTD_CE_GET_RID2PASID(ce) \
> -    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
> +#define PASID_0    0
>  #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
>      ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
>  #define VTD_CE_GET_PRE(ce) \
> @@ -963,7 +962,7 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
>      int ret = 0;
while you are at it, get rid of ret and simply return
vtd_get_pe_from_pasid_table()?
>  
>      if (pasid == PCI_NO_PASID) {
> -        pasid = VTD_CE_GET_RID2PASID(ce);
> +        pasid = PASID_0;
>      }
>      pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>      ret = vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
> @@ -982,7 +981,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (pasid == PCI_NO_PASID) {
> -        pasid = VTD_CE_GET_RID2PASID(ce);
> +        pasid = PASID_0;
>      }
>      pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>  
> @@ -1522,17 +1521,15 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
> -                                  VTDContextEntry *ce)
> +static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
>  {
>      VTDPASIDEntry pe;
>  
>      /*
>       * Make sure in Scalable Mode, a present context entry
> -     * has valid rid2pasid setting, which includes valid
> -     * rid2pasid field and corresponding pasid entry setting
> +     * has valid pasid entry setting at PASID_0.
>       */
> -    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
> +    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
>  }
>  
>  /* Map a device to its corresponding domain (context-entry) */
> @@ -1593,12 +1590,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>          }
>      } else {
>          /*
> -         * Check if the programming of context-entry.rid2pasid
> -         * and corresponding pasid setting is valid, and thus
> -         * avoids to check pasid entry fetching result in future
> -         * helper function calling.
> +         * Check if the programming of pasid setting of PASID_0
> +         * is valid, and thus avoids to check pasid entry fetching
> +         * result in future helper function calling.
>           */
> -        ret_fr = vtd_ce_rid2pasid_check(s, ce);
> +        ret_fr = vtd_ce_pasid_0_check(s, ce);
I guess you should be able to return vtd_ce_pasid_0_check(s, ce)
directly too.
>          if (ret_fr) {
>              return ret_fr;
>          }
> @@ -2110,7 +2106,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>      bool reads = true;
>      bool writes = true;
>      uint8_t access_flags, pgtt;
> -    bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
>      VTDIOTLBEntry *iotlb_entry;
>      uint64_t xlat, size;
>  
> @@ -2122,21 +2117,23 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>  
>      vtd_iommu_lock(s);
>  
> -    cc_entry = &vtd_as->context_cache_entry;
any reason why cc_entry setting was moved? Seems a spurious change.
> +    if (pasid == PCI_NO_PASID && s->root_scalable) {
> +        pasid = PASID_0;
> +    }
>  
> -    /* Try to fetch pte from IOTLB, we don't need RID2PASID logic */
> -    if (!rid2pasid) {
> -        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
> -        if (iotlb_entry) {
> -            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> -                                     iotlb_entry->domain_id);
> -            pte = iotlb_entry->pte;
> -            access_flags = iotlb_entry->access_flags;
> -            page_mask = iotlb_entry->mask;
> -            goto out;
> -        }
> +    /* Try to fetch pte from IOTLB */
> +    iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
> +    if (iotlb_entry) {
> +        trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> +                                 iotlb_entry->domain_id);
> +        pte = iotlb_entry->pte;
> +        access_flags = iotlb_entry->access_flags;
> +        page_mask = iotlb_entry->mask;
> +        goto out;
>      }
>  
> +    cc_entry = &vtd_as->context_cache_entry;
> +
>      /* Try to fetch context-entry from cache first */
>      if (cc_entry->context_cache_gen == s->context_cache_gen) {
>          trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
> @@ -2173,10 +2170,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          cc_entry->context_cache_gen = s->context_cache_gen;
>      }
>  
> -    if (rid2pasid) {
> -        pasid = VTD_CE_GET_RID2PASID(&ce);
> -    }
> -
>      /*
>       * We don't need to translate for pass-through context entries.
>       * Also, let's ignore IOTLB caching as well for PT devices.
> @@ -2202,19 +2195,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          return true;
>      }
>  
> -    /* Try to fetch pte from IOTLB for RID2PASID slow path */
> -    if (rid2pasid) {
> -        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
> -        if (iotlb_entry) {
> -            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> -                                     iotlb_entry->domain_id);
> -            pte = iotlb_entry->pte;
> -            access_flags = iotlb_entry->access_flags;
> -            page_mask = iotlb_entry->mask;
> -            goto out;
> -        }
> -    }
> -
>      if (s->flts && s->root_scalable) {
>          ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
>                                     &reads, &writes, s->aw_bits, pasid);
> @@ -2477,20 +2457,14 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>          ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                         vtd_as->devfn, &ce);
>          if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            uint32_t rid2pasid = PCI_NO_PASID;
> -
> -            if (s->root_scalable) {
> -                rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> -            }
> -
>              /*
>               * In legacy mode, vtd_as->pasid == pasid is always true.
>               * In scalable mode, for vtd address space backing a PCI
>               * device without pasid, needs to compare pasid with
> -             * rid2pasid of this device.
> +             * PASID_0 of this device.
>               */
>              if (!(vtd_as->pasid == pasid ||
> -                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
> +                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
don't you need to check you are in s->root_scalable mode too?

Thanks

Eric
>                  continue;
>              }
>  
> @@ -2995,9 +2969,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                        vtd_as->devfn, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> -
> -            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
>                  vtd_as->pasid != pasid) {
>                  continue;
>              }


