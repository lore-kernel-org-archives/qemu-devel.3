Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D04CC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbn3-0007Jl-1k; Thu, 27 Aug 2026 11:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzbn1-0007JX-MH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzbmx-0002Y2-Je
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787843589;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKJ4rTqQ04M361yMWXkwuwjZCN6dxF96PuXuHpTSkR8=;
 b=FWWkxr74L1/PBBXHvV0hPp9VYy3hrYB0dSsZVgar8I0WBjdiSzOA4OFLI1PQjHs01GgAcj
 uq3U/U3Bnyq73MAR9XEp4vDz/LI80Vc8MTSed+wVhWQUYBQy586cGHG3t9OtMQ72TwcYad
 z5E7PuAhMv93huiQcHvRPCJQrQVUIz4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-FnsY34j5PzuljHjQR6ubHw-1; Thu, 27 Aug 2026 11:13:06 -0400
X-MC-Unique: FnsY34j5PzuljHjQR6ubHw-1
X-Mimecast-MFC-AGG-ID: FnsY34j5PzuljHjQR6ubHw_1787843585
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482bf4da3d5so1478819f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787843585; x=1788448385;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hKJ4rTqQ04M361yMWXkwuwjZCN6dxF96PuXuHpTSkR8=;
 b=ba3EEOKEZ6L92lkoY6dp4BSWwfykaHb1sJir5hdsZitGvBx+bkbvKLUlSz615j6hvo
 5b3JEAKvmcsRUduExwdqheKwEqpIG+hCv8tfs7mc/C3lS8MuilTCrV92+AIgSTVGIvmZ
 JtDiLWYCOSkJoWRfJZM1AorqXEwP2Kx82tb487GL88KAlQ96yJVmv8HaWzpdI83qSsia
 NarFS+KFWNU4m1r9Lhsp10kd38+O13hVNTFuhkqPsqEIUvY4aDahyaO6/zzR0/4iXBoc
 Xety1drbOBR7flL1mcozMv5oUnvKSewE+70ncUETj0Q96TImY9/imGu0NzaaIVTwYOGc
 6S5g==
X-Gm-Message-State: AFuF++k0wa10MwON3s8kBUKWb2DjFiD6T/CBqZ6SGlGOMN3jQGL8gDrk
 0h4Z7Zr2UmD36P1+XUZr+sjgpCTV9RfJNAJxmNlco3NQcejwc9V5L/hswLdCTCY6WBlBDA99DQr
 SAA98+jy1d93Cg4TnjH2fg+GavpLo1m4d0+UDczFYa0DcVWGefkDm9bWQ
X-Gm-Gg: AR+sD11/z7b7QFsmgUr0y9zf5ekfEh0NUt58NmcfbF9o4RYoTme6fhBoFtEUVGzs9M2
 Shit4ysjoBa5/gONGo8gzh/o+HBH9//SKWy3VkY9vPVTzwlK4roPW9HLxgldAIq8cMU9tkbIsHB
 w7ULsp68BSTAEtKluDpUTJzj+jc6xnz3KlCqLqwT2KE5O/FOjWDH2PwVNex7Kygth6RyvqVkzEG
 x2+ByLsJ4UyKV8BS8varAAKZ2G99bqTkhclhYn2mvntoJqKOWVG8ApM/Uox1TqpItpyAQEv/L06
 inOgSuSCZEnW2x/Cns32VQhgVuxOQ1Wv3iVtwnFB9vm5jFdpPwNhGjqFxVoV/dAKcRmVnGcarS9
 bt+hx4oPjktKVz9B8L6ikBVGmaWlPPrdjuzSUpS5kzUq91TIu
X-Received: by 2002:a05:6000:46cb:b0:482:aa2a:52f6 with SMTP id
 ffacd0b85a97d-482e26bf2admr14456217f8f.1.1787843584669; 
 Thu, 27 Aug 2026 08:13:04 -0700 (PDT)
X-Received: by 2002:a05:6000:46cb:b0:482:aa2a:52f6 with SMTP id
 ffacd0b85a97d-482e26bf2admr14456107f8f.1.1787843584170; 
 Thu, 27 Aug 2026 08:13:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab574sm9630325f8f.14.2026.08.27.08.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:13:03 -0700 (PDT)
Message-ID: <e41fdd64-7cb5-4cf4-9529-e1ae5e6b4c63@redhat.com>
Date: Thu, 27 Aug 2026 17:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 11/28] hw/arm/smmu-common: Implement secure state
 handling in ptw
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162512.2807281-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 8/13/26 6:25 PM, Tao Tang wrote:
> Enhance the page table walker to correctly handle secure and non-secure
> memory accesses. This change introduces logic to select the appropriate
> address space and enforce architectural security policies during walks.
>
> The page table walker now correctly processes Secure Stage 1
> translations. Key changes include:
>
> - The get_pte() function now uses the effective security state to fetch
> page-table entries from either the Secure or Non-secure address space,
> with explicit transaction attributes matching that address space.
>
> - The stage 1 walker tracks the security state, respecting the NSCFG
> and NSTable attributes. It correctly handles the hierarchical security
> model: if a table descriptor in a secure walk has NSTable=1, all
> subsequent lookups for that walk are forced into the Non-secure space.
> This is a one-way transition, as specified by the architecture.
>
> - The final TLB entry is tagged with the correct output address space,
> ensuring proper memory isolation.
>
> Note: We do not yet support secure stage 2 translations. This patch
> only implements Secure stage 1 page-table walks. Baseline propagation
> of the incoming NS attribute for stage 1 bypass is handled separately
> in this series with ATTR_PERMS_OVR == 0. Full ATTR_PERMS_OVR support
> is left for a separate series.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 73 +++++++++++++++++++++++++++++-------
>  hw/arm/smmuv3.c              | 19 ++++++----
>  include/hw/arm/smmu-common.h |  7 ++--
>  3 files changed, 74 insertions(+), 25 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 63c36329a98..317cfafded2 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -408,13 +408,13 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>   * @base_addr[@index]
>   */
>  static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
> -                   SMMUPTWEventInfo *info)
> +                   SMMUPTWEventInfo *info, AddressSpace *as, MemTxAttrs attrs)
>  {
>      int ret;
>      dma_addr_t addr = baseaddr + index * sizeof(*pte);
>  
>      /* TODO: guarantee 64-bit single-copy atomicity */
> -    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
> +    ret = ldq_le_dma(as, addr, pte, attrs);
>  
>      if (ret != MEMTX_OK) {
>          info->type = SMMU_PTW_ERR_WALK_EABT;
> @@ -488,7 +488,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>  static inline int translate_table_addr_ipa(SMMUState *bs,
>                                             dma_addr_t *table_addr,
>                                             SMMUTransCfg *cfg,
> -                                           SMMUPTWEventInfo *info)
> +                                           SMMUPTWEventInfo *info,
> +                                           SMMUSecSID sec_sid)
do we need that change given secure S2 is not implemented yet. Can't we
focus on secure S1 first?
>  {
>      dma_addr_t addr = *table_addr;
>      SMMUTLBEntry *cached_entry;
> @@ -501,7 +502,7 @@ static inline int translate_table_addr_ipa(SMMUState *bs,
>      asid = cfg->asid;
>      cfg->stage = SMMU_STAGE_2;
>      cfg->asid = -1;
> -    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
> +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info, sec_sid);
>      cfg->asid = asid;
>      cfg->stage = SMMU_NESTED;
>  
> @@ -524,6 +525,7 @@ static inline int translate_table_addr_ipa(SMMUState *bs,
>   * @perm: access type
>   * @tlbe: SMMUTLBEntry (out)
>   * @info: handle to an error info
> + * @sec_sid: StreamID Security state
>   *
>   * Return 0 on success, < 0 on error. In case of error, @info is filled
>   * and tlbe->perm is set to IOMMU_NONE.
> @@ -532,12 +534,16 @@ static inline int translate_table_addr_ipa(SMMUState *bs,
>   */
>  static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>                            dma_addr_t iova, IOMMUAccessFlags perm,
> -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> +                          SMMUSecSID sec_sid)
>  {
>      dma_addr_t baseaddr, indexmask;
>      SMMUStage stage = cfg->stage;
>      SMMUTransTableInfo *tt = select_tt(cfg, iova);
>      uint8_t level, granule_sz, inputsize, stride;
> +    int nscfg, current_ns, new_nstable;
> +    bool sid_is_ns = sec_sid == SMMU_SEC_SID_NS;
prefer !smmu_sec_sid_is_secure()?
> +    SMMUSecSID table_sec_sid;
>  
>      if (!tt || tt->disabled) {
>          info->type = SMMU_PTW_ERR_TRANSLATION;
> @@ -552,6 +558,7 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>  
>      baseaddr = extract64(tt->ttb, 0, cfg->oas);
>      baseaddr &= ~indexmask;
> +    nscfg = tt->nscfg;
>  
>      while (level < VMSA_LEVELS) {
>          uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
> @@ -560,8 +567,19 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>          uint64_t pte, gpa;
>          dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>          uint8_t ap;
> +        AddressSpace *pte_as;
> +        MemTxAttrs pte_attrs;
> +        SMMUSecSID cur_sec_sid;
>  
> -        if (get_pte(baseaddr, offset, &pte, info)) {
> +        /*
> +         * Start in NS for Non-secure streams or CD.NSCFGx == 1.
May I suggest something like: 

at starting level we start fetching CD/TTBx in NS if non-secure SIDs of
if CD.NSCFGx == 1. Once we start fetching in NS space, then we continue
the PTW in next levels in NS space.
> +         * Once walk is in NS, NSTable is ignored on subsequent levels.
> +         */
> +        current_ns = sid_is_ns || nscfg;
> +        table_sec_sid = current_ns ? SMMU_SEC_SID_NS : sec_sid;
> +        pte_as = smmu_get_address_space(bs, table_sec_sid);
> +        pte_attrs = smmu_get_txattrs(table_sec_sid);
> +        if (get_pte(baseaddr, offset, &pte, info, pte_as, pte_attrs)) {
>                  goto error;
>          }
>          trace_smmu_ptw_level(stage, level, iova, subpage_size,
> @@ -582,10 +600,25 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>              }
>              baseaddr = get_table_pte_address(pte, granule_sz);
>              if (cfg->stage == SMMU_NESTED) {
> -                if (translate_table_addr_ipa(bs, &baseaddr, cfg, info)) {
> +                if (translate_table_addr_ipa(bs, &baseaddr, cfg,
> +                                             info, table_sec_sid)) {
>                      goto error;
>                  }
>              }
> +
> +            /*
> +             * NSTable can switch the walk to NS only while the current walk
> +             * level is Secure. Once switched to NS, NSTable is ignored according
> +             * to hierarchical control of Secure/Non-secure accesses:
> +             * (IHI 0070G.b)13.4.1 Stage 1 page permissions and
> +             * (DDI 0487H.a)D8.4.2 Control of Secure or Non-secure memory access
> +             */
above suggested comment may be sufficient
> +            if (!current_ns) {
> +                new_nstable = PTE_NSTABLE(pte);
not sure you need new_nstable local variable
> +                nscfg = new_nstable ? 1 : 0;
and I think you can directly assign nscfg to PTE_NSTABLE(pte), no?
> +            } else {
> +                nscfg = 1;
> +            }
>              level++;
>              continue;
>          } else if (is_page_pte(pte, level)) {
> @@ -628,6 +661,12 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>              goto error;
>          }
>  
> +        if (current_ns) {
> +            cur_sec_sid = SMMU_SEC_SID_NS;
> +        } else {
> +            cur_sec_sid = PTE_NS(pte) ? SMMU_SEC_SID_NS : SMMU_SEC_SID_S;
> +        }
> +        tlbe->entry.target_as = smmu_get_address_space(bs, cur_sec_sid);
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = iova & ~mask;
>          tlbe->entry.addr_mask = mask;
> @@ -697,7 +736,10 @@ static int smmu_ptw_64_s2(SMMUState *bs, SMMUTransCfg *cfg,
>          uint64_t pte, gpa;
>          dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>          uint8_t s2ap;
> -        if (get_pte(baseaddr, offset, &pte, info)) {
> +        AddressSpace *pte_as = &bs->memory_as;
> +        MemTxAttrs pte_attrs = MEMTXATTRS_UNSPECIFIED;
same question here, why do we care about smmu_ptw_64_s() atm
> +
> +        if (get_pte(baseaddr, offset, &pte, info, pte_as, pte_attrs)) {
>                  goto error;
>          }
>          trace_smmu_ptw_level(stage, level, ipa, subpage_size,
> @@ -792,7 +834,7 @@ static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
>  }
>  
>  /**
> - * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
> + * smmu_ptw - Walk the page tables for an IOVA, according to @cfg and @sec_sid
>   *
>   * @bs: smmu state which includes TLB instance
>   * @cfg: translation configuration
> @@ -800,18 +842,20 @@ static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
>   * @perm: tentative access type
>   * @tlbe: returned entry
>   * @info: ptw event handle
> + * @sec_sid: StreamID Security state
>   *
>   * return 0 on success
>   */
>  int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
> -             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> +             SMMUSecSID sec_sid)
>  {
>      int ret;
>      SMMUTLBEntry tlbe_s2;
>      dma_addr_t ipa;
>  
>      if (cfg->stage == SMMU_STAGE_1) {
> -        return smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
> +        return smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info, sec_sid);
>      } else if (cfg->stage == SMMU_STAGE_2) {
>          /*
>           * If bypassing stage 1(or unimplemented), the input address is passed
> @@ -830,7 +874,7 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>      }
>  
>      /* SMMU_NESTED. */
> -    ret = smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
> +    ret = smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info, sec_sid);
>      if (ret) {
>          return ret;
>      }
> @@ -846,7 +890,8 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>  }
>  
>  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> -                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
> +                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info,
> +                             SMMUSecSID sec_sid)
>  {
>      SMMUTLBEntry *cached_entry = NULL;
>      SMMUTransTableInfo *tt;
> @@ -888,7 +933,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>      }
>  
>      cached_entry = g_new0(SMMUTLBEntry, 1);
> -    status = smmu_ptw(bs, cfg, addr, flag, cached_entry, info);
> +    status = smmu_ptw(bs, cfg, addr, flag, cached_entry, info, sec_sid);
>      if (status) {
>              g_free(cached_entry);
>              return NULL;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6b34f76f11b..cc5d3ab696c 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -394,7 +394,8 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUEventInfo *event,
>                                                   IOMMUAccessFlags flag,
>                                                   SMMUTLBEntry **out_entry,
> -                                                 SMMUTranslationClass class);
> +                                                 SMMUTranslationClass class,
> +                                                 SMMUSecSID sec_sid);
>  /* @ssid > 0 not supported yet */
>  static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>                         uint32_t ssid, CD *buf, SMMUEventInfo *event,
> @@ -411,7 +412,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>  
>      if (cfg->stage == SMMU_NESTED) {
>          status = smmuv3_do_translate(s, addr, cfg, event,
> -                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
> +                                     IOMMU_RO, &entry, SMMU_CLASS_CD, sec_sid);
>  
>          /* Same PTW faults are reported but with CLASS = CD. */
>          if (status != SMMU_TRANS_SUCCESS) {
> @@ -796,7 +797,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event,
>  }
>  
>  static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
> -                     CD *cd, SMMUEventInfo *event)
> +                     CD *cd, SMMUEventInfo *event, SMMUSecSID sec_sid)
>  {
>      int ret = -EINVAL;
>      int i;
> @@ -869,7 +870,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>          /* Translate the TTBx, from IPA to PA if nesting is enabled. */
>          if (cfg->stage == SMMU_NESTED) {
>              status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
> -                                         &entry, SMMU_CLASS_TT);
> +                                         &entry, SMMU_CLASS_TT, sec_sid);
in the context secure S2 is not supported, can sec_sid be set here? In
other words, do we really need to add sed_sid arg to decode_cd() at that
stage or can we just invoke with ns and add a comment?
>              /*
>               * Same PTW faults are reported but with CLASS = TT.
>               * If TTBx is larger than the effective stage 1 output addres
> @@ -939,7 +940,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>          return ret;
>      }
>  
> -    return decode_cd(s, cfg, &cd, event);
> +    return decode_cd(s, cfg, &cd, event, sec_sid);
>  }
>  
>  /**
> @@ -1004,7 +1005,8 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUEventInfo *event,
>                                                   IOMMUAccessFlags flag,
>                                                   SMMUTLBEntry **out_entry,
> -                                                 SMMUTranslationClass class)
> +                                                 SMMUTranslationClass class,
> +                                                 SMMUSecSID sec_sid)
>  {
>      SMMUPTWEventInfo ptw_info = {};
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1030,7 +1032,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>          cfg->stage = SMMU_STAGE_2;
>      }
>  
> -    cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
> +    cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info, sec_sid);
>  
>      if (desc_s2_translation) {
>          cfg->asid = asid;
> @@ -1176,13 +1178,14 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      }
>  
>      status = smmuv3_do_translate(s, addr, cfg, &event, flag,
> -                                 &cached_entry, SMMU_CLASS_IN);
> +                                 &cached_entry, SMMU_CLASS_IN, sec_sid);
>  
>  epilogue:
>      qemu_mutex_unlock(&s->mutex);
>      switch (status) {
>      case SMMU_TRANS_SUCCESS:
>          entry.perm = cached_entry->entry.perm;
> +        entry.target_as = cached_entry->entry.target_as;
>          entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>          entry.addr_mask = cached_entry->entry.addr_mask;
>          trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 1aa4e3208da..0c5718ea684 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -224,18 +224,19 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>  
>  /**
>   * smmu_ptw - Perform the page table walk for a given iova / access flags
> - * pair, according to @cfg translation config
> + * pair, according to @cfg translation config and @sec_sid
>   */
>  int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>               IOMMUAccessFlags perm, SMMUTLBEntry *tlbe,
> -             SMMUPTWEventInfo *info);
> +             SMMUPTWEventInfo *info, SMMUSecSID sec_sid);
>  
>  /*
>   * smmu_translate - Look for a translation in TLB, if not, do a PTW.
>   * Returns NULL on PTW error or incase of TLB permission errors.
>   */
>  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> -                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info);
> +                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info,
> +                             SMMUSecSID sec_sid);
>  
>  /**
>   * select_tt - compute which translation table shall be used according to
Thanks

Eric


