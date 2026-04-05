Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65338E9D820
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 21:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9VIV-0001hn-Sy; Sun, 05 Apr 2026 17:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9VIQ-0001h1-TE
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 17:46:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9VIN-0006Zk-EK
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 17:46:16 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82cd9d0eceaso2589508b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775425573; x=1776030373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnwBYYH9Il0dGXbrZmpVTL65kvhw+6RgGJ2d+c7LBGU=;
 b=kdgA0NRdHAGWdLkNZIIQSvJ5Cw9BAPCPVCucbx+cFQ/BIv28QbiMmAmGC04cCTZ4h5
 DJAD6TbnjYKKyIrTUsedHA+ZiOAMJsyGr9dLK8ri2C8x/6IprBZGpK2r2LAWfpgYe93/
 ol9kl3BlMdVK7Uk6GYx2jMekm0yywxh7zBvoM6gvouUjxlq33BQy0s0msafevYWu+U/c
 fdZ7/o0UGWRbi028IwKDO/8eny1GQIhWZdz4m87LlxvrdUIpt+0lR/557UWFSSEOb1N5
 XwQy9aOZ3P/Iv/Ht0xG7RZ9oYpmgBi1yacEU3Ntx28pPdlQINjm0I7syyvMUdzJ6cCof
 R0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775425573; x=1776030373;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LnwBYYH9Il0dGXbrZmpVTL65kvhw+6RgGJ2d+c7LBGU=;
 b=MBN/yhRyi+ezJZkqgcVvj+oivjNLkvgyS4DOJLSgKb59qCrn7/5eeOuMoW5aeyhJaC
 n2FeslVdC/1CAsy57tZWtgJpqyT8E80MnSFhfvG8k6PIKbB/1kZYcrg0V5JnYrnlXmul
 Ub9QrkGnOJUtuEWz1wcTvkrergUyZaENz5Bnh56jdanAcB6wD6ZFFiI+63JnxNr2NTLx
 wb0I4D7hvGaouWD3K2h0JVKqQD/FCsMzsfI4v/0hssgS8G1fhxroMipzjRFTDJa9FgiS
 m3mKBlxk7dxHNRUxmyNltSrn6IzMRk6UouynFycvc4xYLFburAgQY6omGpaeFf3kFN/A
 QxGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyxxC+ZfHDE52WDtmyeVDyxhKGwDBDr5lzybLhJNyiBD52xcHOqCwbjeSNt1DCiXlJ/NrGe68BYDJ0@nongnu.org
X-Gm-Message-State: AOJu0Yw8HK+N6WCDf+XuJJCgN5xalgAYWIyc/LkuxkiQiM/KX4nYraHm
 iBzKozTHjSuO8FleRvDSPmwjY9+VzI15GsBLIhnG5VmrGnDdXNepwyJzw3QFGw4gmjc=
X-Gm-Gg: AeBDievYgwV1GIbfdF2H8HiS04siWnEROapQqhv2PUy/yI0WbPDFCl4Q5VN/2BwBY7g
 9272zHwj6ZKB710sY5e5qsGXt4V65pSpc+SE2ALM8vrmasDZeAwEKfeBdcEMXj8tnfrSFMcyn+8
 ikv3+eWRiEApMVrBWxcDjDHD0+A6NbzQBt/0x/m6Q2KwojVJyR7ojdowMQajQH6t8D5c31GyV8p
 bDX1pFIo4xw3lUW11tmtnDa+F0D+k7OSvalCxB/Z4R9hsbDuqUM5AXxr4sVWHlvrT7oi5oxjmEs
 lj+FQ86hvA2OyXrRcV716h1iRj35SNHrcqK3RWqx6XkvfwKw4zXeJxQESQzmKNZ2VStxvVdBxFd
 ctfN5qGVNIb9lz76/KVFvyPaL0/iAdgijowNxaCl2ydAzKZAiCu5xzvvdkvwxhnd3FG/Ojj5xoh
 nKw+XV47/ZaVPJJERzrkAvm+axMM4NJCeCBlB90qUdo+hl1LNv4XGydxG2Ip6LyM/tlMU=
X-Received: by 2002:a05:6a00:2293:b0:827:3d52:5d1a with SMTP id
 d2e1a72fcca58-82d0d7525abmr10047342b3a.0.1775425573016; 
 Sun, 05 Apr 2026 14:46:13 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2714dsm14802935b3a.1.2026.04.05.14.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 14:46:12 -0700 (PDT)
Message-ID: <7be8b426-8f0d-4759-afdd-4de882748d2b@linaro.org>
Date: Mon, 6 Apr 2026 07:46:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] target/arm: add canonical tag check logic
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
 <20260309-feat-mte4-v4-6-daaf0375620d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260309-feat-mte4-v4-6-daaf0375620d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/10/26 08:59, Gabriel Brookman wrote:
> This feature causes tag checks to compare logical address tags against
> their canonical form rather than against allocation tags, when the check
> happens in a canonically tagged memory region. Described in the ARM ARM
> section "Logical Address Tagging".
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/cpu-features.h      |  5 +++++
>   target/arm/cpu.h               |  1 +
>   target/arm/internals.h         | 31 ++++++++++++++++++++++++++++++-
>   target/arm/tcg/hflags.c        |  4 ++++
>   target/arm/tcg/mte_helper.c    | 21 +++++++++++++++++++++
>   target/arm/tcg/translate-a64.c |  7 +++++++
>   target/arm/tcg/translate.h     |  1 +
>   7 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 38fc56b52e..5e3dc5256f 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1154,6 +1154,11 @@ static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
>   }
>   
> +static inline bool isar_feature_aa64_mte_mtx(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTEX) == 1;
> +}

!= 0.

> +/* Return true if Canonical Tagging is enabled. */
> +static inline bool canonical_tagging_enabled(CPUARMState *env, bool selector)
> +{
> +    int mmu_idx;
> +    uint64_t tcr, mtx_bit;
> +
> +    /* If mte4 is not implemented, then mtx is by definition not enabled */
> +    if (!cpu_isar_feature(aa64_mte_mtx, env_archcpu(env))) {
> +        return false;
> +    }
> +
> +    mmu_idx = arm_mmu_idx_el(env, arm_current_el(env));
> +    tcr = regime_tcr(env, mmu_idx);
> +
> +    /*
> +     * In two-range regimes, mtx is governed by bit 60 or 61 of TCR, and in
> +     * one-range regimes, bit 33 is used.
> +     */
> +    mtx_bit = regime_has_2_ranges(mmu_idx) ? 60 + selector : 33;
> +
> +    return extract64(tcr, mtx_bit, 1);
> +}

Unused?

> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 1484087a19..b54fbd11c0 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -854,6 +854,13 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
>           mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, sizem1 + 1,
>                                     MMU_DATA_LOAD, ra);
>           if (!mem1) {
> +            /*
> +             * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
> +             * otherwise it is Untagged. See AArch64.CheckTag.

CheckTag is not where this is decided, but S1DecodeMemAttrs (and similarly in 
S1DisabledOutput).

> @@ -867,6 +874,12 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
>                                     ptr_last - next_page + 1,
>                                     MMU_DATA_LOAD, ra);
>   
> +        /* If either region is canonically tagged, do a canonical tag check */
> +        if (mtx_check(desc, bit55) && (!mem1 || !mem2)
> +            && (!tag_is_canonical(ptr_tag, bit55))) {
> +            return 0;
> +        }
> +

This fails to set *fault correctly for the second page.
You need to split checks into the separate !mem1 and !mem2 tests below.

> @@ -974,6 +987,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
>           goto done;
>       }
>   
> +
>       /*

Watch the spurrious changes.

The whole patch could be split into smaller parts.


r~

