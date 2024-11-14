Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F766D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeGj-0006XY-Fr; Thu, 14 Nov 2024 13:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeGd-0006QK-Fh
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:08:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeGb-0003hD-Jy
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:08:31 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20e576dbc42so10987765ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607708; x=1732212508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P0QNvK0qfB+HFYrpEwBszZOE4zRIHV6W6CJKZ027KqU=;
 b=UenDsYh6m34GLufC/z3/zkbQfEXBnkPZwb/zaQpUaG60n95c6Wp9wQCm9AOfmIrceQ
 6UNm3gnzKBcRJ3EBOjkjJQ76dYHS2j41U8TvcJCbSevIfjhy/SuWAC6ZQNtklVtapY21
 H0J+d0QB8W85xDLVDZHsOq4NeCIAGC1FLepqfz1SMO/GKoAhCYwKtv94RftvDq6Bf4gU
 chsi+jBlM8udEehz1X1oWhmrTPZDDt9lT9EY2LSaxMgusZUBH2hB2UA2LWXKSBffNyA/
 6MaEoTXDWJAlgmkh6ivmXTBmyj5+aBE83JER0c+4v8jfL2KS5uiLB4CnD/QeD+TNc/Ki
 IKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607708; x=1732212508;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P0QNvK0qfB+HFYrpEwBszZOE4zRIHV6W6CJKZ027KqU=;
 b=tpFndtlzlNs+hlCd6wN6wTWQjwHEoF0PO8xIOap3VpWrZrw/nTftVPFfL9wjimAf2X
 RoSUgtEpjxEhxIWEgAOF4dfLOv3qJGEcpWJLJ98dE2IIUSNxLXERshotRKyMdHdUsH52
 2qqpVVEaRrf/tnyXlpFToBOb/6uRdO3pE5ZN835hrdzDCLq2YmH3lDcSiV21Mv3sEpn5
 mnF7H7vZirXRFUVcFBBzGy4eKhTC5JAAJE/dBUNoqqE0WUgyj7QDEIWVkiu11HJ8TeLv
 CJLXaCmV/ZwxXbpGvL9+sfdKxgDkuR+EUJHOtnM+K2rodAsDP9ERQyogPckq/7abSzWe
 qTQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW369zhyAbMx+wFGvUZppIzSFRgjX6UyLseE09knli7KwRqnBzoZdMLmfbNLzSX5zXFQU8bl1ofiq+B@nongnu.org
X-Gm-Message-State: AOJu0YzJE4tN/A+NUDBzVG3ylXDavwDy3q/6t7AhqzpAz0WKtGzAD4oA
 AapUJfoT2svN82HOFe6VITFiwPfzCsHn8ouC6VyMIfdtIvjOBtovGgw/7iWwU3y/DNdRRf0SFHU
 uNXjS6A==
X-Google-Smtp-Source: AGHT+IGHnWPb0f8wJvoKuwcPGvqnu+Uie2rvJlLVXCor2Rh+XJnSTGE/TXm0nH3VyznbOTuf9eViqg==
X-Received: by 2002:a17:903:32c7:b0:20c:e8df:251a with SMTP id
 d9443c01a7336-211b66a1792mr79635045ad.45.1731607707940; 
 Thu, 14 Nov 2024 10:08:27 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9d67c6sm1518872b3a.192.2024.11.14.10.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:08:27 -0800 (PST)
Message-ID: <bc7e7e41-ee89-4f6e-9b80-5d03b1fbb86f@linaro.org>
Date: Thu, 14 Nov 2024 10:08:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/54] include/exec/tlb-common: Move CPUTLBEntryFull
 from hw/core/cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/14/24 08:00, Richard Henderson wrote:
> CPUTLBEntryFull structures are no longer directly included within
> the CPUState structure.  Move the structure definition out of cpu.h
> to reduce visibility.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-common.h | 63 +++++++++++++++++++++++++++++++++++++++
>   include/hw/core/cpu.h     | 63 ---------------------------------------
>   2 files changed, 63 insertions(+), 63 deletions(-)
> 
> diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
> index dc5a5faa0b..300f9fae67 100644
> --- a/include/exec/tlb-common.h
> +++ b/include/exec/tlb-common.h
> @@ -53,4 +53,67 @@ typedef struct CPUTLBDescFast {
>       CPUTLBEntry *table;
>   } CPUTLBDescFast QEMU_ALIGNED(2 * sizeof(void *));
>   
> +/*
> + * The full TLB entry, which is not accessed by generated TCG code,
> + * so the layout is not as critical as that of CPUTLBEntry. This is
> + * also why we don't want to combine the two structs.
> + */
> +struct CPUTLBEntryFull {
> +    /*
> +     * @xlat_section contains:
> +     *  - in the lower TARGET_PAGE_BITS, a physical section number
> +     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> +     *    must be added to the virtual address to obtain:
> +     *     + the ram_addr_t of the target RAM (if the physical section
> +     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> +     *     + the offset within the target MemoryRegion (otherwise)
> +     */
> +    hwaddr xlat_section;
> +
> +    /*
> +     * @phys_addr contains the physical address in the address space
> +     * given by cpu_asidx_from_attrs(cpu, @attrs).
> +     */
> +    hwaddr phys_addr;
> +
> +    /* @attrs contains the memory transaction attributes for the page. */
> +    MemTxAttrs attrs;
> +
> +    /* @prot contains the complete protections for the page. */
> +    uint8_t prot;
> +
> +    /* @lg_page_size contains the log2 of the page size. */
> +    uint8_t lg_page_size;
> +
> +    /* Additional tlb flags requested by tlb_fill. */
> +    uint8_t tlb_fill_flags;
> +
> +    /*
> +     * Additional tlb flags for use by the slow path. If non-zero,
> +     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
> +     */
> +    uint8_t slow_flags[MMU_ACCESS_COUNT];
> +
> +    /*
> +     * Allow target-specific additions to this structure.
> +     * This may be used to cache items from the guest cpu
> +     * page tables for later use by the implementation.
> +     */
> +    union {
> +        /*
> +         * Cache the attrs and shareability fields from the page table entry.
> +         *
> +         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
> +         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
> +         * For shareability and guarded, as in the SH and GP fields respectively
> +         * of the VMSAv8-64 PTEs.
> +         */
> +        struct {
> +            uint8_t pte_attrs;
> +            uint8_t shareability;
> +            bool guarded;
> +        } arm;
> +    } extra;
> +};
> +
>   #endif /* EXEC_TLB_COMMON_H */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 8eda0574b2..4364ddb1db 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -201,69 +201,6 @@ struct CPUClass {
>    */
>   #define NB_MMU_MODES 16
>   
> -/*
> - * The full TLB entry, which is not accessed by generated TCG code,
> - * so the layout is not as critical as that of CPUTLBEntry. This is
> - * also why we don't want to combine the two structs.
> - */
> -struct CPUTLBEntryFull {
> -    /*
> -     * @xlat_section contains:
> -     *  - in the lower TARGET_PAGE_BITS, a physical section number
> -     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> -     *    must be added to the virtual address to obtain:
> -     *     + the ram_addr_t of the target RAM (if the physical section
> -     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> -     *     + the offset within the target MemoryRegion (otherwise)
> -     */
> -    hwaddr xlat_section;
> -
> -    /*
> -     * @phys_addr contains the physical address in the address space
> -     * given by cpu_asidx_from_attrs(cpu, @attrs).
> -     */
> -    hwaddr phys_addr;
> -
> -    /* @attrs contains the memory transaction attributes for the page. */
> -    MemTxAttrs attrs;
> -
> -    /* @prot contains the complete protections for the page. */
> -    uint8_t prot;
> -
> -    /* @lg_page_size contains the log2 of the page size. */
> -    uint8_t lg_page_size;
> -
> -    /* Additional tlb flags requested by tlb_fill. */
> -    uint8_t tlb_fill_flags;
> -
> -    /*
> -     * Additional tlb flags for use by the slow path. If non-zero,
> -     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
> -     */
> -    uint8_t slow_flags[MMU_ACCESS_COUNT];
> -
> -    /*
> -     * Allow target-specific additions to this structure.
> -     * This may be used to cache items from the guest cpu
> -     * page tables for later use by the implementation.
> -     */
> -    union {
> -        /*
> -         * Cache the attrs and shareability fields from the page table entry.
> -         *
> -         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
> -         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
> -         * For shareability and guarded, as in the SH and GP fields respectively
> -         * of the VMSAv8-64 PTEs.
> -         */
> -        struct {
> -            uint8_t pte_attrs;
> -            uint8_t shareability;
> -            bool guarded;
> -        } arm;
> -    } extra;
> -};
> -
>   /*
>    * Data elements that are per MMU mode, minus the bits accessed by
>    * the TCG fast path.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


