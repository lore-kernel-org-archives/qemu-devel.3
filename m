Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D78BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPREZ-0004ps-AX; Thu, 04 Jul 2024 14:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPREX-0004pX-DY
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:31:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRET-00032E-CF
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:31:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so548746f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720117858; x=1720722658; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kBz6wkB7tMJYy0wPftLZ4Ulgjae0KVvXGdcfYoc+8Eg=;
 b=SuvJ/jpg85ZOHYJQHfkBCDhxlgotxy35VnN1TRCnM3IHgQ4CyS7aLdY5+nXI9Y/kHt
 cGBiGSf9cDzQlWRQ0VShIKx3znIR0+Tz+DtRRikAAfGLYHi3FGhPkQa1KnYmwDEQSpsS
 IoWQHvJVbfp1OCpIiZW9mVL83TjSjqcicLeqJ8VroJolaH+bAzxWU6AYSKMIRxcVBkST
 R3A1EQeZT8HxsZ0MUW+2R5w5iAu6FmNVWj+EVe/12JwPXdI38vvezcruyn7P5RrfKc76
 rHwL9CplVKTT+MDFDbLbiry+wR3mBwv1Voh5/eLOMyqyIFHjo2XO2O6Gbbj0cAIHprGT
 y50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720117858; x=1720722658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBz6wkB7tMJYy0wPftLZ4Ulgjae0KVvXGdcfYoc+8Eg=;
 b=pXP0XNZd/swCdAKXfqG+BdAX+E23nBzIvAbYnVOvosG2dt6yw9ThCHxGoxg+ffNREV
 IfTNsm1r2616YaELHP1NdwdYAG2ujEbqmoGCFi7aulyOZ16lA3PsGrkb1vx8Pwpdakvv
 dDJrHkBh3BFDPYwPf5vZxpiO/TeZC6PQCXHpNjvmriLfOWShIIKt/VBi9M402204Xhk9
 ZQCc0Z0+Ecp3LW/7YJBqc5uiAmiEdxF16xWZOxImVMSsIDBVZWnNpAU73mP7H6IILeaz
 GB7av+4dKPV7BVDuUAZ2Z38bbXWQkAqgT4kKfND6p+LdqsYnqVyYeXPiv+gsd7O3b9Er
 BTGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Vel9/VNp/wJ9DgwH/FfbhW/+aDlWv+8t3V4hIutffZxQ5O4mOwg3+NCYiDl6EGcJZRAezNq8JYod5aa6WWWBM39Kga0=
X-Gm-Message-State: AOJu0Yxu5uJw+RyY42adipQs73/wIkuUJhOpfSByoDayWCQ5tvAW5Ltj
 4J/43cNpDbuFm784CQ+2nwMla0X47s7XiyF/ondKqkL/eLvK+bF9wvHknujLxrI=
X-Google-Smtp-Source: AGHT+IGk1rcRfobvCyz8ROSlgmGUT3lBfb91NhA3zH7UjjfwAbcYNb5Br5rKmV8SKHwTnTjqWRlm+w==
X-Received: by 2002:a05:6000:124d:b0:362:fc59:1ff5 with SMTP id
 ffacd0b85a97d-3679dd73891mr2021105f8f.59.1720117857623; 
 Thu, 04 Jul 2024 11:30:57 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a3b1e523sm853610f8f.53.2024.07.04.11.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:30:57 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:31:10 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 11/19] hw/arm/smmu-common: Support nested translation
Message-ID: <20240704183110.GH1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-12-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-12-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 01, 2024 at 11:02:33AM +0000, Mostafa Saleh wrote:
> When nested translation is requested, do the following:
> 
> - Translate stage-1 table address IPA into PA through stage-2.
> - Translate stage-1 table walk output (IPA) through stage-2.
> - Create a single TLB entry from stage-1 and stage-2 translations
>   using logic introduced before.
> 
> For stage-1 table translation, the spec (ARM IHI 0070 F.b) says in:
>     7.3.12 F_WALK_EABT:
>         Translation of an IPA for Stage 1 descriptor fetch:
> 	S2 == 1 (stage 2), CLASS == T
> So, F_WALK_EABT is used which propagtes to CLASS == TT.

I don't think the text applies to this case, the context is:

	A stage 2 table walk can encounter EABT accessing the physical
	address of a stage 2 descriptor, because of a:
	[...]
	* Translation of an IPA for Stage 1 descriptor fetch

So EABT is when failing to load the stage 2 descriptor. I can't find
exact text for this case but looking at the flowchart 15.5, I think
this should be F_TRANSLATION/F_ADDR_SIZE/F_PERMISSION/F_ACCESS with
CLASS=TT and S2.

Thanks,
Jean

> 
> smmu_ptw() has a new argument SMMUState which include the TLB as
> stage-1 table address can be cached in there.
> 
> Also in smmu_ptw() a separate path used for nesting to simplify the
> code, although some logic can be combined.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 72 +++++++++++++++++++++++++++++++-----
>  include/hw/arm/smmu-common.h |  2 +-
>  2 files changed, 64 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 24b7d09e2b..71afd486ba 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -318,6 +318,38 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>      return NULL;
>  }
>  
> +/* Translate stage-1 table address using stage-2 page table. */
> +static inline int translate_table_addr_ipa(dma_addr_t *table_addr,
> +                                           SMMUTransCfg *cfg,
> +                                           SMMUPTWEventInfo *info,
> +                                           SMMUState *bs)
> +{
> +    dma_addr_t addr = *table_addr;
> +    SMMUTLBEntry *cached_entry;
> +    int asid;
> +
> +    /*
> +     * The translation table walks performed from TTB0 or TTB1 are always
> +     * performed in IPA space if stage 2 translations are enabled.
> +     */
> +    asid = cfg->asid;
> +    cfg->stage = SMMU_STAGE_2;
> +    cfg->asid = -1;
> +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
> +    cfg->asid = asid;
> +    cfg->stage = SMMU_NESTED;
> +
> +    if (cached_entry) {
> +        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> +        return 0;
> +    }
> +
> +    info->stage = SMMU_STAGE_2;
> +    info->type = SMMU_PTW_ERR_WALK_EABT;
> +    info->addr = addr;
> +    return -EINVAL;
> +}
> +
>  /**
>   * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
>   * @cfg: translation config
> @@ -333,7 +365,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>   */
>  static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                            dma_addr_t iova, IOMMUAccessFlags perm,
> -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> +                          SMMUState *bs)
>  {
>      dma_addr_t baseaddr, indexmask;
>      SMMUStage stage = cfg->stage;
> @@ -381,6 +414,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                  goto error;
>              }
>              baseaddr = get_table_pte_address(pte, granule_sz);
> +            if (cfg->stage == SMMU_NESTED) {
> +                if (translate_table_addr_ipa(&baseaddr, cfg, info, bs)) {
> +                    goto error;
> +                }
> +            }
>              level++;
>              continue;
>          } else if (is_page_pte(pte, level)) {
> @@ -568,10 +606,8 @@ error:
>   * combine S1 and S2 TLB entries into a single entry.
>   * As a result the S1 entry is overriden with combined data.
>   */
> -static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> -                                                SMMUTLBEntry *tlbe_s2,
> -                                                dma_addr_t iova,
> -                                                SMMUTransCfg *cfg)
> +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> +                        dma_addr_t iova, SMMUTransCfg *cfg)
>  {
>      if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
>          tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> @@ -596,14 +632,19 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
>   * @perm: tentative access type
>   * @tlbe: returned entry
>   * @info: ptw event handle
> + * @bs: smmu state which includes TLB instance
>   *
>   * return 0 on success
>   */
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
>  {
> +    int ret;
> +    SMMUTLBEntry tlbe_s2;
> +    dma_addr_t ipa;
> +
>      if (cfg->stage == SMMU_STAGE_1) {
> -        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
> +        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
>      } else if (cfg->stage == SMMU_STAGE_2) {
>          /*
>           * If bypassing stage 1(or unimplemented), the input address is passed
> @@ -621,7 +662,20 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>          return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
>      }
>  
> -    g_assert_not_reached();
> +    /* SMMU_NESTED. */
> +    ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
> +    ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    combine_tlb(tlbe, &tlbe_s2, iova, cfg);
> +    return 0;
>  }
>  
>  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> @@ -677,7 +731,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>      }
>  
>      cached_entry = g_new0(SMMUTLBEntry, 1);
> -    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
> +    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
>      if (status) {
>              g_free(cached_entry);
>              return NULL;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 1db566d451..cf0fd3ec74 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -185,7 +185,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>   * pair, according to @cfg translation config
>   */
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
>  
>  
>  /*
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

