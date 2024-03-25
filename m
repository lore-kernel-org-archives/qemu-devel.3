Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61838C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolBT-0006lt-IK; Mon, 25 Mar 2024 10:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1rolBR-0006iz-Dp; Mon, 25 Mar 2024 10:20:17 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1rolBP-00070P-69; Mon, 25 Mar 2024 10:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID;
 bh=QexzJ9cYy2KD0jegfeEsjBpTMHG2d/u49cn46Vy/+d0=; b=XG49cDPVrEeGTdHwQ+Y8Uo5TCf
 a7OSVOSP+GdrejbjJ0syoGwG3jri9ZaVJrpw/GXfxmEtN8cjMp67+7h7Z8Qh8jTcz5GS+G59TjzRs
 XH0GZUId6SxcTseKutCWcJCjG7OItgKYaRyYkalBZw6Ydv6spJszWm8fAinQHwqfLaq0=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1rolBJ-0003kg-Bi; Mon, 25 Mar 2024 14:20:09 +0000
Received: from gw1.octic.net ([88.97.20.152] helo=[10.0.1.240])
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1rolBJ-0001Lc-1i; Mon, 25 Mar 2024 14:20:09 +0000
Message-ID: <bd24dc1a-d474-4cc7-87f9-2d5059a19602@xen.org>
Date: Mon, 25 Mar 2024 14:20:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/12] hw/arm/smmu-common: Support nested translation
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 eric.auger@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com
References: <20240325101442.1306300-1-smostafa@google.com>
 <20240325101442.1306300-8-smostafa@google.com>
From: Julien Grall <julien@xen.org>
In-Reply-To: <20240325101442.1306300-8-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=julien@xen.org;
 helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Mostafa,

On 25/03/2024 10:14, Mostafa Saleh wrote:
> @@ -524,7 +551,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>           tlbe->entry.translated_addr = gpa;
>           tlbe->entry.iova = ipa & ~mask;
>           tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = s2ap;
> +        tlbe->parent_perm = tlbe->entry.perm = s2ap;
>           tlbe->level = level;
>           tlbe->granule = granule_sz;
>           return 0;
> @@ -537,6 +564,35 @@ error:
>       return -EINVAL;
>   }
>   
> +/* Combine 2 TLB enteries and return in tlbe. */
> +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> +                        dma_addr_t iova, SMMUTransCfg *cfg)
> +{
> +        if (cfg->stage == SMMU_NESTED) {
> +
> +            /*
> +             * tg and level are used from stage-1, while the addr mask can be
With the current approach, I can't boot a guest if I create a dummy 
stage-1 using 512GB mapping and a stage-2 using 2MB mapping. It looks 
like this is because the level will be used during the TLB lookup.

I managed to solve the issue by using the max level of the two stages. I 
think we may need to do a minimum for the granule.


> +             * smaller in case stage-2 size(based on granule and level) was
> +             * smaller than stage-1.
> +             * That should have no impact on:
> +             * - lookup: as iova is properly aligned with the stage-1 level and
> +             *   granule.
> +             * - Invalidation: as it uses the entry mask.
> +             */
> +            tlbe->entry.addr_mask = MIN(tlbe->entry.addr_mask,
> +                                        tlbe_s2->entry.addr_mask);
> +            tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
> +                                          tlbe->entry.translated_addr);
> +
> +            /* parent_perm has s2 perm while perm has s1 perm. */
> +            tlbe->parent_perm = tlbe_s2->entry.perm;
> +            return;
> +        }
> +
> +        /* That was not nested, use the s2. */
> +        memcpy(tlbe, tlbe_s2, sizeof(*tlbe));
> +}

Cheers,

-- 
Julien Grall

