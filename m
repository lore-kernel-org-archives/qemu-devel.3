Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15C8D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyX-0008Vh-P3; Thu, 14 Nov 2024 13:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyV-0008NS-Se
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:52 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyU-0007lL-43
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso759859b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610429; x=1732215229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HiWvYQI8dzRWbrX3hhvS7Vj6DSkL57R+F3WTlsTJwJc=;
 b=IpwuJMySup4CJR3u26ZRp6l9hWLkhJTgAPqu7fRpZOX8O0hlAw6jIZn/oWZ7JL3tlz
 pZdvrCsPJ0bjB+fyEt06QN+tO5dmZnzW3RL8f2L/lcpDHtD5/z9Fv0vXe7I3Npka+kpG
 R6NikZaZH/qyg7F4JwbCe4TaQTifE4dvNVuDSVXLVdajPH5pnDoRFPzz6C73+5VyeAGS
 CZYHbVfuQOSAhQjeIzqheA3ocSTWUgkRhiWWCC9cG19KB/rQjI+J0LRVqznMpE3YRbe2
 pyvkwKBlVpV7Nkd8DAi1IbT5Y1pdn9NNB9gDRQh0C80bLMBvnTV6MWBDvF2cRVExiEu1
 Xisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610429; x=1732215229;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HiWvYQI8dzRWbrX3hhvS7Vj6DSkL57R+F3WTlsTJwJc=;
 b=unRuWtp4dpw/omknOslLbRQ90LGNE1MX1nb+9ochKKq3d3nRBlmh4jafbJFuZBBHFW
 UgPH0wlWI9Osq58XA2tux2aAQpV119ZwgPQlEzt+IDao/fgIIj0ElbMHVHld83YCrr0X
 vJmIvDkaEMsXrYLYBkx4+eogSrKa9GkntYiHP5cX/rUvgvJmk8ReBsN4ft0G9VBllVdL
 ntc/A/vLXXcp87BpCV42BIITuzIWtKP4g0NzHH+m4EYddflguTG8ft+V5NUm3+SXty0Y
 Itvx6c/KFerRKRbU13Sqg/kZFsuf28Br6gVuWKJa8a/hGplKploLAY3S1q86bjhn6N9K
 wtmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm/Bnxq+3xzNedISVKb60UXGaTXlMdxfgtvbNDd4bQ9mPwe/YKGMZg90qteetN2cQgHrdx6MAks5AX@nongnu.org
X-Gm-Message-State: AOJu0Yw6qSq9TLfxsq+BshCuMFmszHwwL0EBcDkcdfUpYPVCs4EZVnkL
 aBHTT3c63nm9hBxJNuuMn3LlEj99iFMNVl9LNa+qREcmfMFxjl7LaTZ4li+3/H0=
X-Google-Smtp-Source: AGHT+IHCg5SCBayvw94JKsyxZmKg/zrRFx2EsBB/fsuIZ5YBkiC3GT105BFkGBAFFwYryBQZFZBrvQ==
X-Received: by 2002:a05:6a00:181b:b0:71e:427a:68de with SMTP id
 d2e1a72fcca58-72469e27d06mr4477358b3a.24.1731610428688; 
 Thu, 14 Nov 2024 10:53:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:48 -0800 (PST)
Message-ID: <dc93400f-5987-4267-b07a-333267ab892d@linaro.org>
Date: Thu, 14 Nov 2024 10:53:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/54] target/microblaze: Convert to
 TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-41-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/cpu.h    |  7 +++----
>   target/microblaze/cpu.c    |  2 +-
>   target/microblaze/helper.c | 33 ++++++++++++++++++++-------------
>   3 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 3e5a3e5c60..b0eadfd9b1 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -421,10 +421,9 @@ static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
>   }
>   
>   #if !defined(CONFIG_USER_ONLY)
> -bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                     MMUAccessType access_type, int mmu_idx,
> -                     bool probe, uintptr_t retaddr);
> -
> +bool mb_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
> +                            MMUAccessType access_type, int mmu_idx,
> +                           MemOp memop, int size, bool probe, uintptr_t ra);
>   void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>                                  unsigned size, MMUAccessType access_type,
>                                  int mmu_idx, MemTxAttrs attrs,
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 710eb1146c..212cad2143 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -425,7 +425,7 @@ static const TCGCPUOps mb_tcg_ops = {
>       .restore_state_to_opc = mb_restore_state_to_opc,
>   
>   #ifndef CONFIG_USER_ONLY
> -    .tlb_fill = mb_cpu_tlb_fill,
> +    .tlb_fill_align = mb_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = mb_cpu_exec_interrupt,
>       .cpu_exec_halt = mb_cpu_has_work,
>       .do_interrupt = mb_cpu_do_interrupt,
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 5d3259ce31..b6375564b4 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -36,37 +36,44 @@ static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
>       }
>   }
>   
> -bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                     MMUAccessType access_type, int mmu_idx,
> -                     bool probe, uintptr_t retaddr)
> +bool mb_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
> +                           MMUAccessType access_type, int mmu_idx,
> +                           MemOp memop, int size,
> +                           bool probe, uintptr_t retaddr)
>   {
>       MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>       CPUMBState *env = &cpu->env;
>       MicroBlazeMMULookup lu;
>       unsigned int hit;
> -    int prot;
> -    MemTxAttrs attrs = {};
>   
> -    attrs.secure = mb_cpu_access_is_secure(cpu, access_type);
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        mb_cpu_do_unaligned_access(cs, address, access_type, mmu_idx, retaddr);
> +    }
> +
> +    memset(out, 0, sizeof(*out));
> +    out->attrs.secure = mb_cpu_access_is_secure(cpu, access_type);
> +    out->lg_page_size = TARGET_PAGE_BITS;
>   
>       if (mmu_idx == MMU_NOMMU_IDX) {
>           /* MMU disabled or not available.  */
> -        address &= TARGET_PAGE_MASK;
> -        prot = PAGE_RWX;
> -        tlb_set_page_with_attrs(cs, address, address, attrs, prot, mmu_idx,
> -                                TARGET_PAGE_SIZE);
> +        out->phys_addr = address;
> +        out->prot = PAGE_RWX;
>           return true;
>       }
>   
>       hit = mmu_translate(cpu, &lu, address, access_type, mmu_idx);
>       if (likely(hit)) {
> -        uint32_t vaddr = address & TARGET_PAGE_MASK;
> +        uint32_t vaddr = address;
>           uint32_t paddr = lu.paddr + vaddr - lu.vaddr;
>   
>           qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
>                         mmu_idx, vaddr, paddr, lu.prot);
> -        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, lu.prot, mmu_idx,
> -                                TARGET_PAGE_SIZE);
> +
> +        out->phys_addr = paddr;
> +        out->prot = lu.prot;
>           return true;
>       }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


