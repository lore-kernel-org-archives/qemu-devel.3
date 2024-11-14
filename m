Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA31CD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeJr-0001iu-28; Thu, 14 Nov 2024 13:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeJp-0001fG-UP
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:11:49 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeJm-0004KL-Cq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:11:49 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21145812538so8129025ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607905; x=1732212705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xg9pp8l/CyoaDyEoVwZdRsPnDZAApdSZc+1so0odPb4=;
 b=cgovHSB4Ivyk2vrfzIm3Tlpw701lr2jqH93EUNjVRxL8jd+saC/gNn019nJz7IeJ+C
 RYCg/sNh95ykXHG7FKvxPNN7Um9+fiJsJWf6D6f3CT0WI4O02GXM+AP8NnVmdwdKyQqd
 ppUUpuP+qtRvCYflElKxf2kGdy2Do+0HLpQFJkj0rH7QYAnj4lsMzki7xpcRkMkaWv/6
 /4y6e95KDjblziRP3GH1jj0ayKC0QbTLjDjvibLIrskzbiAnL7qnKCTjmnnJZbz8xDu8
 jwjyIKUhnn06SO+L+pWRPMFt9ze2o9wuKzFIRuccssWlkMGUqEXtUyhMvNUcT+Eoc1XV
 q40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607905; x=1732212705;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xg9pp8l/CyoaDyEoVwZdRsPnDZAApdSZc+1so0odPb4=;
 b=hEAS+h4u2bNfMadFMUKzWkGRhnPFCZf4mtd+s1RHEEoHXBGRGp2Wd2iD1SXdLe4YdJ
 F6iv/jtbQ90t0K4RMuPcmHuEsDm6wNuQiBDtUD2mBBH3XVjkoumSYBAY0U/HjJo4ZYaw
 e2RqW73KN+2rEb/fGjxJZ5uiSO7qqDyl+JyZncEA79m0KMOqCG3e6HgtimgGmwuIbHte
 PxY2zMXUWYbtH55k/zQt2FuyKGKzNNlfSlLHeJYEN2GPR+y2dpHrCmFQtlOB3JJw3yC+
 BhYQKtYtz7NXCfc1gNRQyUqk26zz6jVVRcTAm47YkmXp2AZTx6697GjS5en7TLIjxx3M
 G8PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVPyWDAWqVzolixUfdwqv/d6KRjPTTJBmJN0VzYh5ajbc2fKIRxDT3lKGs3wYlcv9ruF3bUzdNjJo7@nongnu.org
X-Gm-Message-State: AOJu0YxRVJI77tWQ6FVnv9dXWu6fgm7CJl+M6ZgO2SxVlnyJq5ClsRP7
 OZuJaNk14710clVWxAJYMGrs4y8lqDp124cY7cNHgPPnYcSBfpNxzabAWoAG+9r/guqzoDZzCD/
 lnGWOjw==
X-Google-Smtp-Source: AGHT+IHdMMyIWxvvLNI6uCxDJGLMaQuIxdAu0yn1k37KTNxy11jECM2s/J0BZ1WXxFbhRqFoG9KfqQ==
X-Received: by 2002:a17:903:41cf:b0:20b:ab4b:544a with SMTP id
 d9443c01a7336-21183d683dcmr347171075ad.43.1731607904598; 
 Thu, 14 Nov 2024 10:11:44 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d03bc9sm13612325ad.198.2024.11.14.10.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:11:44 -0800 (PST)
Message-ID: <3a42485b-8020-437f-a2bd-e64f31ccf531@linaro.org>
Date: Thu, 14 Nov 2024 10:11:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/54] accel/tcg: Return CPUTLBEntryFull not pointer in
 probe_access_full_mmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-26-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
> Return a copy of the structure, not a pointer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h              |  2 +-
>   accel/tcg/cputlb.c                   | 13 ++++++++-----
>   target/arm/ptw.c                     | 10 +++++-----
>   target/i386/tcg/sysemu/excp_helper.c |  8 ++++----
>   4 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 2e4c4cc4b4..df7d0b5ad0 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -393,7 +393,7 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
>    */
>   int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>                             MMUAccessType access_type, int mmu_idx,
> -                          void **phost, CPUTLBEntryFull **pfull);
> +                          void **phost, CPUTLBEntryFull *pfull);
>   
>   #endif /* !CONFIG_USER_ONLY */
>   #endif /* CONFIG_TCG */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 585f4171cc..81135524eb 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1439,25 +1439,28 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
>   
>   int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>                             MMUAccessType access_type, int mmu_idx,
> -                          void **phost, CPUTLBEntryFull **pfull)
> +                          void **phost, CPUTLBEntryFull *pfull)
>   {
>       void *discard_phost;
> -    CPUTLBEntryFull *discard_tlb;
> +    CPUTLBEntryFull *full;
>   
>       /* privately handle users that don't need full results */
>       phost = phost ? phost : &discard_phost;
> -    pfull = pfull ? pfull : &discard_tlb;
>   
>       int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
> -                                      mmu_idx, true, phost, pfull, 0, false);
> +                                      mmu_idx, true, phost, &full, 0, false);
>   
>       /* Handle clean RAM pages.  */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
>           int dirtysize = size == 0 ? 1 : size;
> -        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, 0);
> +        notdirty_write(env_cpu(env), addr, dirtysize, full, 0);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> +    if (pfull) {
> +        *pfull = *full;
> +    }
> +
>       return flags;
>   }
>   
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 9849949508..3ae5f524de 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -592,7 +592,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
>           ptw->out_space = s2.f.attrs.space;
>       } else {
>   #ifdef CONFIG_TCG
> -        CPUTLBEntryFull *full;
> +        CPUTLBEntryFull full;
>           int flags;
>   
>           env->tlb_fi = fi;
> @@ -604,10 +604,10 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
>           if (unlikely(flags & TLB_INVALID_MASK)) {
>               goto fail;
>           }
> -        ptw->out_phys = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
> -        ptw->out_rw = full->prot & PAGE_WRITE;
> -        pte_attrs = full->extra.arm.pte_attrs;
> -        ptw->out_space = full->attrs.space;
> +        ptw->out_phys = full.phys_addr | (addr & ~TARGET_PAGE_MASK);
> +        ptw->out_rw = full.prot & PAGE_WRITE;
> +        pte_attrs = full.extra.arm.pte_attrs;
> +        ptw->out_space = full.attrs.space;
>   #else
>           g_assert_not_reached();
>   #endif
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 02d3486421..168ff8e5f3 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -436,7 +436,7 @@ do_check_protect_pse36:
>        * addresses) using the address with the A20 bit set.
>        */
>       if (in->ptw_idx == MMU_NESTED_IDX) {
> -        CPUTLBEntryFull *full;
> +        CPUTLBEntryFull full;
>           int flags, nested_page_size;
>   
>           flags = probe_access_full_mmu(env, paddr, 0, access_type,
> @@ -451,7 +451,7 @@ do_check_protect_pse36:
>           }
>   
>           /* Merge stage1 & stage2 protection bits. */
> -        prot &= full->prot;
> +        prot &= full.prot;
>   
>           /* Re-verify resulting protection. */
>           if ((prot & (1 << access_type)) == 0) {
> @@ -459,8 +459,8 @@ do_check_protect_pse36:
>           }
>   
>           /* Merge stage1 & stage2 addresses to final physical address. */
> -        nested_page_size = 1 << full->lg_page_size;
> -        paddr = (full->phys_addr & ~(nested_page_size - 1))
> +        nested_page_size = 1 << full.lg_page_size;
> +        paddr = (full.phys_addr & ~(nested_page_size - 1))
>                 | (paddr & (nested_page_size - 1));
>   
>           /*

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


