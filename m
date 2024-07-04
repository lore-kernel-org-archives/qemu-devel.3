Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190A0C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPQxY-0002QR-KB; Thu, 04 Jul 2024 14:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQxL-0002EV-5o
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:13:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQxH-0005tZ-FN
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:13:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367a183df54so334334f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720116793; x=1720721593; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YW4wlSuOdKAVTH1hQaVXajuVHuYuIjCXdW92FIYm6MM=;
 b=KiLcZ+eJuWCLV8SUHx4gJuihjsFc7ObsQZGGMj+R3nnfgOjngNZKZiX5R653rh24co
 VbB2qyFJvBlQmsGUKwoojn9kECgcDW2wbhNoXYA1k9pAoTM84r4fwphOAOLuqErrxvR9
 WySxxHm9KXY5wNKukN5eiTxc/sOtMt8wbQZDkUtm1c0uS4d05DoGc9wfxfCRzYVW202x
 dW05sN9Q02x4TEOaut2wq3y+PIAJOIAh76XXPG6/GPx2x6qaPBDNSNxbLajfG4OvJu59
 1VglS6PoW78/o/cjZAtuWYP0aBrgKmvA04KUaleABo1O6uy8edO6MyDC65bvWOT9ZB4k
 Ol0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720116793; x=1720721593;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YW4wlSuOdKAVTH1hQaVXajuVHuYuIjCXdW92FIYm6MM=;
 b=UwOwha+QQ08XwFf3PS9zKXrsM99jEdSyBeLdpC6uDNBFkQDQ2eGgXUycnCwqwFQNS2
 X82knWtSoF0xYXzXWadREHOAtOerVl70JHsqpNT5u9/eIfiJdsRvjQmHzkeXwSmmtiuZ
 y+FHkTzoCWh2sL7c6d5wUwfzfeTPDtryxVkluB1nqDz2w5kwTvItthkfq/mv1CwDX8rT
 dpGaH/UVV7565JzK5Y3RdOT8/4s0IeaBYbCi3VHzNXn1xI9ZIed7JBbDd9dXBn0oWcZK
 8fo+T0blmzsAZK7SP+bYeLK3FSqMsOGxGGUh0nuFF/5tMqrbVjnF21ZLG5QWbj1bZd1g
 HyBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzkhLhtJOu+tU+VjkFhFUpbTSZKbnqkJoWFszuxhTPmafPwkaJTLxtu3PAiT1+sCD6RKtFFyrTJCM1yqSlHP0ac4sMbKA=
X-Gm-Message-State: AOJu0YwJZUR/HDOMQtuPTIScb8/YGkILmC28xJG6eKXs0xeFhgxTHVo8
 /pSPAx93/QFoQBwbXzmzXukK4XJFcn4zeIfsIz46Lwz5oNAwXSUdUuM5KD9T3jM=
X-Google-Smtp-Source: AGHT+IGnhknz3ZhTPYKEhVhVRHjuDrsZwdSjkP74rBnbaFPoSpIXQ622cWUCKEWmVeuP276irJI+/A==
X-Received: by 2002:a5d:4f05:0:b0:366:efa2:f2f7 with SMTP id
 ffacd0b85a97d-3679dd15b0emr1775871f8f.1.1720116793566; 
 Thu, 04 Jul 2024 11:13:13 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36788e37b53sm7524064f8f.45.2024.07.04.11.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:13:13 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:13:26 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 10/19] hw/arm/smmu-common: Add support for nested TLB
Message-ID: <20240704181326.GG1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-11-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701110241.2005222-11-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42c.google.com
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

On Mon, Jul 01, 2024 at 11:02:32AM +0000, Mostafa Saleh wrote:
> This patch adds support for nested (combined) TLB entries.
> The main function combine_tlb() is not used here but in the next
> patches, but to simplify the patches it is introduced first.
> 
> Main changes:
> 1) New field added in the SMMUTLBEntry struct: parent_perm, for
>    nested TLB, holds the stage-2 permission, this can be used to know
>    the origin of a permission fault from a cached entry as caching
>    the “and” of the permissions loses this information.
> 
>    SMMUPTWEventInfo is used to hold information about PTW faults so
>    the event can be populated, the value of stage used to be set
>    based on the current stage for TLB permission faults, however
>    with the parent_perm, it is now set based on which perm has
>    the missing permission
> 
>    When nesting is not enabled it has the same value as perm which
>    doesn't change the logic.
> 
> 2) As combined TLB implementation is used, the combination logic
>    chooses:
>    - tg and level from the entry which has the smallest addr_mask.
>    - Based on that the iova that would be cached is recalculated.
>    - Translated_addr is chosen from stage-2.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++++++++++++----
>  include/hw/arm/smmu-common.h |  1 +
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 0840b5cffd..24b7d09e2b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -426,7 +426,8 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = iova & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> +        tlbe->parent_perm = PTE_AP_TO_PERM(ap);
> +        tlbe->entry.perm = tlbe->parent_perm;
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -547,7 +548,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = ipa & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = s2ap;
> +        tlbe->parent_perm = s2ap;
> +        tlbe->entry.perm = tlbe->parent_perm;
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -562,6 +564,30 @@ error:
>      return -EINVAL;
>  }
>  
> +/*
> + * combine S1 and S2 TLB entries into a single entry.
> + * As a result the S1 entry is overriden with combined data.
> + */
> +static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> +                                                SMMUTLBEntry *tlbe_s2,
> +                                                dma_addr_t iova,
> +                                                SMMUTransCfg *cfg)
> +{
> +    if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
> +        tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> +        tlbe->granule = tlbe_s2->granule;
> +        tlbe->level = tlbe_s2->level;
> +    }
> +
> +    tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
> +                                    tlbe->entry.translated_addr);
> +
> +    tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
> +    /* parent_perm has s2 perm while perm keeps s1 perm. */
> +    tlbe->parent_perm = tlbe_s2->entry.perm;
> +    return;
> +}
> +
>  /**
>   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
>   *
> @@ -639,9 +665,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>  
>      cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
>      if (cached_entry) {
> -        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> +        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
> +            cached_entry->parent_perm & IOMMU_WO)) {
>              info->type = SMMU_PTW_ERR_PERMISSION;
> -            info->stage = cfg->stage;
> +            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
> +                          SMMU_STAGE_1 :
> +                          SMMU_STAGE_2;
>              return NULL;
>          }
>          return cached_entry;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 09d3b9e734..1db566d451 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -77,6 +77,7 @@ typedef struct SMMUTLBEntry {
>      IOMMUTLBEntry entry;
>      uint8_t level;
>      uint8_t granule;
> +    IOMMUAccessFlags parent_perm;
>  } SMMUTLBEntry;
>  
>  /* Stage-2 configuration. */
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

