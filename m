Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486E0D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBey5-0007sc-RM; Thu, 14 Nov 2024 13:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBey4-0007sS-0W
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:24 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBey1-0007RJ-Dz
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:22 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72475e29578so62568b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610400; x=1732215200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ybl+bA/DPJsVTOYEH4B3KflN2B2QFVPJdeXC/D3/mbk=;
 b=uEsBnuYRNGvmPKPTYVU42prckOeQpOLvflDyw2yx5r7w/1xtYoB/2Iaq9k+kwJcCGx
 RUQIfvQBaPmX2Gc3MkyxSMrUPfVzKUxpSsWhMxXGbV70ThgZKpxJ8Wcxb9q6lbNqNq3T
 A2qgBvMJ9Aj5lp4Vex9IPIs3ndNeG091chKsltx+tmpUHS02+qJNo32VuIoM4g1o9u4O
 CQilJXnCpi6hnPENVPD6jqSN6hPQGY8yA1w/t9tjHAUBerd39aHsIKE6/1JZAy4YxnD0
 v1jQSlwpFYXxQkLVJZn8x4g9NztfS4E9r0b7FS21ZUkQsLq1ULiaAYmtsBmX5Z8XnBLz
 fZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610400; x=1732215200;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ybl+bA/DPJsVTOYEH4B3KflN2B2QFVPJdeXC/D3/mbk=;
 b=QsVqRDY2rEuX61WIhUX2/Vx4m1k6HuMHLwFukxXMu8VjqdcG5ezQjsizmyH7+ji2BO
 ZVo1YW56jY0apZNIG0qIqq0ky1K05h7nEsxxqcRW9jjpuuyYtz2sSZJJZq0zWtxFAZ10
 JIFONBFkCOBU5bnq/hYmf/C/54I51SuzIslkdHt6syw9kUhoeiQ25zXVoTQkGisDl1tC
 7NqnmBEzVRedBMuzGPFPuwKTgaSP99Za3UN8ivMUNGfT70qF2ysOrSRBF8XYmklCRuPZ
 mfJCdvQUoWBh7Hse3aeuRMo9lTIjBHwfMIoANw2OArJrLgEBxW2HUYC/WSsddHJbJb2s
 lKIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLaUkL21v56KamDMsZS5pKzDnozg7McVuVwsjFbti5kNUpOJrPE9e7X3shVGIeP0LuZIM7Onmpw3io@nongnu.org
X-Gm-Message-State: AOJu0YyQpoQteTOYvV1J6XeR5AKb2xCjUREwWgzSEaOeP8IxRELVRkVC
 F3aKO1tUDRIg8+NdFd9+/KuP4XtmUoTawmUUExf7yH9APGWGIO3DbCvCxQzPWf8=
X-Google-Smtp-Source: AGHT+IFywWPD3XBuRMR6iEwGnjw7chSbAbFUGk6ay+MC9mF6eyjY8uNR8n81PmXhj8WBj8uP0VNmcA==
X-Received: by 2002:a05:6a00:929b:b0:71e:634e:fe0d with SMTP id
 d2e1a72fcca58-724579bcee2mr8281327b3a.12.1731610399762; 
 Thu, 14 Nov 2024 10:53:19 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5cfabdsm1587559b3a.13.2024.11.14.10.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:19 -0800 (PST)
Message-ID: <22cdd2fe-7ca7-4bde-9eb6-91995070ea76@linaro.org>
Date: Thu, 14 Nov 2024 10:53:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/54] target/alpha: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-35-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
>   target/alpha/cpu.h    |  6 +++---
>   target/alpha/cpu.c    |  2 +-
>   target/alpha/helper.c | 23 +++++++++++++++++------
>   3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 3556d3227f..70331c0b83 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -449,9 +449,9 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
>   void alpha_cpu_record_sigbus(CPUState *cs, vaddr address,
>                                MMUAccessType access_type, uintptr_t retaddr);
>   #else
> -bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                        MMUAccessType access_type, int mmu_idx,
> -                        bool probe, uintptr_t retaddr);
> +bool alpha_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
> +                              MMUAccessType access_type, int mmu_idx,
> +                              MemOp memop, int size, bool probe, uintptr_t ra);
>   G_NORETURN void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>                                                 MMUAccessType access_type, int mmu_idx,
>                                                 uintptr_t retaddr);
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 5d75c941f7..7bcc48420d 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -228,7 +228,7 @@ static const TCGCPUOps alpha_tcg_ops = {
>       .record_sigsegv = alpha_cpu_record_sigsegv,
>       .record_sigbus = alpha_cpu_record_sigbus,
>   #else
> -    .tlb_fill = alpha_cpu_tlb_fill,
> +    .tlb_fill_align = alpha_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
>       .cpu_exec_halt = alpha_cpu_has_work,
>       .do_interrupt = alpha_cpu_do_interrupt,
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 2f1000c99f..26eadfe3ca 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -294,14 +294,21 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>       return (fail >= 0 ? -1 : phys);
>   }
>   
> -bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> -                        MMUAccessType access_type, int mmu_idx,
> -                        bool probe, uintptr_t retaddr)
> +bool alpha_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
> +                              MMUAccessType access_type, int mmu_idx,
> +                              MemOp memop, int size, bool probe, uintptr_t ra)
>   {
>       CPUAlphaState *env = cpu_env(cs);
>       target_ulong phys;
>       int prot, fail;
>   
> +    if (addr & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        alpha_cpu_do_unaligned_access(cs, addr, access_type, mmu_idx, ra);
> +    }
> +
>       fail = get_physical_address(env, addr, 1 << access_type,
>                                   mmu_idx, &phys, &prot);
>       if (unlikely(fail >= 0)) {
> @@ -314,11 +321,15 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>           env->trap_arg2 = (access_type == MMU_DATA_LOAD ? 0ull :
>                             access_type == MMU_DATA_STORE ? 1ull :
>                             /* access_type == MMU_INST_FETCH */ -1ull);
> -        cpu_loop_exit_restore(cs, retaddr);
> +        cpu_loop_exit_restore(cs, ra);
>       }
>   
> -    tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
> -                 prot, mmu_idx, TARGET_PAGE_SIZE);
> +    memset(out, 0, sizeof(*out));
> +    out->phys_addr = phys;
> +    out->prot = prot;
> +    out->attrs = MEMTXATTRS_UNSPECIFIED;
> +    out->lg_page_size = TARGET_PAGE_BITS;
> +
>       return true;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


