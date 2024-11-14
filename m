Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0094D6A22A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyn-0000xV-Jf; Thu, 14 Nov 2024 13:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyl-0000pm-7Q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:07 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyY-0007p2-Gx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:06 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso726789b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610432; x=1732215232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G1lhs1qpXUqWJm6ZOUt+OeEyAF4LT3tdcSBWH0PlA40=;
 b=TRNAooVNGF+iNsoOlbXjROn8leAFEioTtsK2dOe0klLkFu4ph7VtnwNFOCmIdmXidX
 6X2uYcTvAzuWd9cyjVztlrkLEBSIksTq8QhHnR6+X3qwqddBvS5Qrh09mNxe39YGvP6h
 xpgLnzYX/Goaafzx+EAp+3EwnW8SUx8w/LelqoI8u7fbCTfr5Tk4fpb/1LBmVd5KFw9y
 WoN/iNCas8PmI+0eAD5DLfzNgtE/ZA00X+1mRmEtygmnJD4Nu66wYkfn07IL5FFnb86M
 TVkhIX6Yu66kVBnDoV3LsGsyIhbWNrbcCJ1cMQ7Il12tXltXJNCajbB2pHHz7vV9khDg
 lAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610432; x=1732215232;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G1lhs1qpXUqWJm6ZOUt+OeEyAF4LT3tdcSBWH0PlA40=;
 b=WqmvhFDAXj3fh/YGseSnGkIndFfO8TnAVUA2sMHuMg7KtAN9Gi36F3wI81F4aAl3eV
 BTx76hMkzCyIYyxUHdE94fGQ9cB/sCz5lrfshMBphjUjwSMuYaOciASO8Ta661+A9V/n
 owAhbjeY+JBrxekMF4dDa1s4ZAgDvhLrpXea6BvazV/l/RaaCSk93nJSZE1KNXRaac2w
 TTrtSshHR4FuZkTKb9YgmpJecLGY3na6Nwa2BRRZUSVF4FzDPOM1lTYDybGH045He/m/
 NqI3ztyQjGAwnO1rxOAb6rNV3cF56W+BIcsKutEbgU8dzSWOadwjkBgS/6G+g3TKlfMD
 vlhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeWtZqLyOhvF7m5do2rhD/hf7GcAQGnX61xKUToNiDHu51hj5VnRDFAWnuFVd/KbXmHXrTb9K9KYYy@nongnu.org
X-Gm-Message-State: AOJu0YxsKr6WCVMwvT2vSCENio/72Hxm+rFxbRArk8JXXleoZSEfG9eL
 wHgM80CUDA5WbCj5gJfpBwdFPZgNroHr2XiK/+e7Qjc1xH6pwZtf/5j0O0Vn/fOrPQ2arYC40ij
 lLj/MZQ==
X-Google-Smtp-Source: AGHT+IElj5AMsokpdsh8YY2IDvUX00X19LehbFp5MWrSJyJaBsS+d9IsXDN3j6pP43hx4q5stcafeg==
X-Received: by 2002:a05:6a00:1ca6:b0:724:6bac:1003 with SMTP id
 d2e1a72fcca58-7246bac1753mr3523620b3a.24.1731610432502; 
 Thu, 14 Nov 2024 10:53:52 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:52 -0800 (PST)
Message-ID: <13f3a3c0-f7a2-433e-8f8b-ca4db4e498ad@linaro.org>
Date: Thu, 14 Nov 2024 10:53:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 41/54] target/mips: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-42-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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
>   target/mips/tcg/tcg-internal.h      |  6 +++---
>   target/mips/cpu.c                   |  2 +-
>   target/mips/tcg/sysemu/tlb_helper.c | 29 ++++++++++++++++++++---------
>   3 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
> index aef032c48d..f4b00354af 100644
> --- a/target/mips/tcg/tcg-internal.h
> +++ b/target/mips/tcg/tcg-internal.h
> @@ -61,9 +61,9 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                       MemTxResult response, uintptr_t retaddr);
>   void cpu_mips_tlb_flush(CPUMIPSState *env);
>   
> -bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                       MMUAccessType access_type, int mmu_idx,
> -                       bool probe, uintptr_t retaddr);
> +bool mips_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
> +                             MMUAccessType access_type, int mmu_idx,
> +                             MemOp memop, int size, bool probe, uintptr_t ra);
>   
>   void mips_semihosting(CPUMIPSState *env);
>   
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index d0a43b6d5c..3a453c9285 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -556,7 +556,7 @@ static const TCGCPUOps mips_tcg_ops = {
>       .restore_state_to_opc = mips_restore_state_to_opc,
>   
>   #if !defined(CONFIG_USER_ONLY)
> -    .tlb_fill = mips_cpu_tlb_fill,
> +    .tlb_fill_align = mips_cpu_tlb_fill_align,
>       .cpu_exec_interrupt = mips_cpu_exec_interrupt,
>       .cpu_exec_halt = mips_cpu_has_work,
>       .do_interrupt = mips_cpu_do_interrupt,
> diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
> index e98bb95951..ac76396525 100644
> --- a/target/mips/tcg/sysemu/tlb_helper.c
> +++ b/target/mips/tcg/sysemu/tlb_helper.c
> @@ -904,15 +904,28 @@ refill:
>   }
>   #endif
>   
> -bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                       MMUAccessType access_type, int mmu_idx,
> -                       bool probe, uintptr_t retaddr)
> +bool mips_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
> +                             MMUAccessType access_type, int mmu_idx,
> +                             MemOp memop, int size,
> +                             bool probe, uintptr_t retaddr)
>   {
>       CPUMIPSState *env = cpu_env(cs);
>       hwaddr physical;
>       int prot;
>       int ret = TLBRET_BADADDR;
>   
> +    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
> +        if (probe) {
> +            return false;
> +        }
> +        mips_cpu_do_unaligned_access(cs, address, access_type,
> +                                     mmu_idx, retaddr);
> +    }
> +
> +    memset(out, 0, sizeof(*out));
> +    out->attrs = MEMTXATTRS_UNSPECIFIED;
> +    out->lg_page_size = TARGET_PAGE_BITS;
> +
>       /* data access */
>       /* XXX: put correct access by using cpu_restore_state() correctly */
>       ret = get_physical_address(env, &physical, &prot, address,
> @@ -930,9 +943,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>           break;
>       }
>       if (ret == TLBRET_MATCH) {
> -        tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +        out->phys_addr = physical;
> +        out->prot = prot;
>           return true;
>       }
>   #if !defined(TARGET_MIPS64)
> @@ -948,9 +960,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>               ret = get_physical_address(env, &physical, &prot, address,
>                                          access_type, mmu_idx);
>               if (ret == TLBRET_MATCH) {
> -                tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                             physical & TARGET_PAGE_MASK, prot,
> -                             mmu_idx, TARGET_PAGE_SIZE);
> +                out->phys_addr = physical;
> +                out->prot = prot;
>                   return true;
>               }
>           }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


