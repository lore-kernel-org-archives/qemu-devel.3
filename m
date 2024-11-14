Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FECD6A229
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyD-0007tt-NB; Thu, 14 Nov 2024 13:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyC-0007tj-Ti
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:32 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyB-0007SK-Aq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:32 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e625b00bcso808007b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610410; x=1732215210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ymiN9t42sU7qUIr3P9FxWtuP4EqoPGdw0RrAdEv+RL8=;
 b=iwLvmuv0uUKX43fPiGgZhcLL/hTBgQU8rPxtFPsuXJpcGS3nNFh9B19DuQitAI+Nyl
 /DBYzqW6ZwEGz8GbJiN+uvzEVT8kz9QvmH6V58KUsicjwU6tJkmqV5y6vqSXV5zwTj0d
 jIRuoqkHdHvo0jduNe9P8rU0Mmxv7v9eQq77rpL5VkPl3qFsHn9OB2GGCWxFoPLyPLRD
 +pR8yAV1iF47p2RAXBrEWqKMSWxQlTatz/YwcDKSViUZnKsR4tBlAmYrRzvjjd4hT4Ay
 tf+UOpYHoYa5nwi50PH1qW/cglz6JfFlq+dkoMa9aSsmoEl5WnCF2+y13ZZi1ZX2cmBK
 y3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610410; x=1732215210;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ymiN9t42sU7qUIr3P9FxWtuP4EqoPGdw0RrAdEv+RL8=;
 b=RcDyHAuUbQC0Czt3pAQTNkxcKzZdpYiXycwuh1N+mJIrmos1nCVeM6SVzycdDiCrBR
 7betMgTsMVITJBbhTi3UnKEvLz8I9yPxxigSfsAr6Z/MS4eIX+aWVB8TLOtpFvy6sDPU
 6LxhY+9LmL7iJvtzOkVITCMBkBsPN6f8v8KsyN0MdPEITv3u8/BRtwiZuuQEXTagAnX0
 2ZmdN24VS1GImv67k/qitz2dOwlK97ywj4uo88I5Sh8vzKeYG/fusQsxv65TSPyOB1lp
 LsZFEiokm/5rzkwSs2NLaaoz8AoBgQfgEMYjpUMvMF8QkMQs/J94LF+V3+2TDN7U8wEF
 Wg0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXSydaEZl+r5iLesdQncnGCW50a6FutfsCUwAtDvnpNmBuHy5AGEACuK4mmAvXFxe+vrycbHIZU9t3@nongnu.org
X-Gm-Message-State: AOJu0YztesipOm4wJ34UTqv5VkxvoJTaucIN0kFOMZVyQbiLNKXt3Uuw
 ApCP94a5Wv4qde/9LET6CSrG1ADAX2oE7dN8NWhZFTgspCI33s9fewTCuiwLQvPWFcRBD07HygR
 TbbtPOg==
X-Google-Smtp-Source: AGHT+IGTbpiH3f8jeLDpcaqNxmS73n6rlbRU/MVa4LXCwYGe9+ZBVFuyQvMZten9K6cdN80p2B2nsg==
X-Received: by 2002:a05:6a00:3987:b0:71e:82b4:6e6e with SMTP id
 d2e1a72fcca58-7245796a053mr9371115b3a.4.1731610409732; 
 Thu, 14 Nov 2024 10:53:29 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5cfabdsm1587559b3a.13.2024.11.14.10.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:29 -0800 (PST)
Message-ID: <3f4a2c65-f5c7-4da3-9fd0-8ad4b32a480a@linaro.org>
Date: Thu, 14 Nov 2024 10:53:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 36/54] target/i386: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-37-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-37-richard.henderson@linaro.org>
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
>   target/i386/tcg/helper-tcg.h         |  6 +++---
>   target/i386/tcg/sysemu/excp_helper.c | 28 ++++++++++++++++------------
>   target/i386/tcg/tcg-cpu.c            |  2 +-
>   3 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index 696d6ef016..b2164f41e6 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -79,9 +79,9 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
>   void x86_cpu_record_sigbus(CPUState *cs, vaddr addr,
>                              MMUAccessType access_type, uintptr_t ra);
>   #else
> -bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool probe, uintptr_t retaddr);
> +bool x86_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            MemOp memop, int size, bool probe, uintptr_t ra);
>   G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>                                               MMUAccessType access_type,
>                                               int mmu_idx, uintptr_t retaddr);
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 168ff8e5f3..d23d28fef5 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -601,25 +601,29 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>       return true;
>   }
>   
> -bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool probe, uintptr_t retaddr)
> +bool x86_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *full, vaddr addr,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            MemOp memop, int size, bool probe,
> +                            uintptr_t retaddr)
>   {
>       CPUX86State *env = cpu_env(cs);
>       TranslateResult out;
>       TranslateFault err;
>   
> +    if (addr & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        x86_cpu_do_unaligned_access(cs, addr, access_type, mmu_idx, retaddr);
> +    }
> +
>       if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err,
>                                retaddr)) {
> -        /*
> -         * Even if 4MB pages, we map only one 4KB page in the cache to
> -         * avoid filling it too fast.
> -         */
> -        assert(out.prot & (1 << access_type));
> -        tlb_set_page_with_attrs(cs, addr & TARGET_PAGE_MASK,
> -                                out.paddr & TARGET_PAGE_MASK,
> -                                cpu_get_mem_attrs(env),
> -                                out.prot, mmu_idx, out.page_size);
> +        memset(full, 0, sizeof(*full));
> +        full->phys_addr = out.paddr;
> +        full->prot = out.prot;
> +        full->lg_page_size = ctz32(out.page_size);
> +        full->attrs = cpu_get_mem_attrs(env);
>           return true;
>       }
>   
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index cca19cd40e..6fce6227c7 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -117,7 +117,7 @@ static const TCGCPUOps x86_tcg_ops = {
>       .record_sigsegv = x86_cpu_record_sigsegv,
>       .record_sigbus = x86_cpu_record_sigbus,
>   #else
> -    .tlb_fill = x86_cpu_tlb_fill,
> +    .tlb_fill_align = x86_cpu_tlb_fill_align,
>       .do_interrupt = x86_cpu_do_interrupt,
>       .cpu_exec_halt = x86_cpu_exec_halt,
>       .cpu_exec_interrupt = x86_cpu_exec_interrupt,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


