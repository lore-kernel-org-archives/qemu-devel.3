Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB470CED611
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syhEg-0000wG-BU; Wed, 09 Oct 2024 20:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syhEY-0000vn-G1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:40:50 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syhEW-0006kQ-R4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:40:50 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ea0ae67df5so244673a12.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728520847; x=1729125647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DBen96MIVqDm/EOCrEBIqzS8bUrhEkYFa02a7ifycjk=;
 b=ieM5KCBrvm88qvescm5X2OKx7bODfJ9zw3aHnLygyKTBZYmBLIsaQpiGcdgW3lFfEH
 CG4IJTb0xhqLE/NMPD5164/33bobu/cyxr/LpiddhDpxAQmyfcWgcJW9E8oLZ3xF50Jz
 7ck4ChcC548I7TeDeDy0chbCfv8rMqx9y3YPXY3zq1fmiIKaZd9aigN8OfbNVg8My4OP
 5X1UOjgwC/I8ZCqTmyL5v+mVQQVh73r5AsOXqlmY3IytpB8QGhPZMDoYHx00gNBxtgH9
 Y2ltwfNH3/qRvWKttH+W+l3bkrrnFrNtdCXo0hGs3sP2KlJBZ5rJTlWwCKsBcfKTYyxK
 l6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520847; x=1729125647;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBen96MIVqDm/EOCrEBIqzS8bUrhEkYFa02a7ifycjk=;
 b=aPhhYgKc8LkyKcqPaRrJE1cBF8bEMHsvh6OinCO9bhOCvcWqIigXCBZedWlMqYy+yP
 vre3Y80V2VEbOkcZY4udi7oxXXmwxfJp2cQYGakQ8F2YFJhxG6Qq9KQq8A1CretQV35j
 Iwl14XaWeGJ7gVDb3dAtpGVj/yXOYqqrxpZ4eb9WYvPkeFJ6FchYGM8puMeVMCOA8WLV
 dAZKclMUBWeLJ7/b+zpI/xR4awcHIW8EUguLJGyA8M0JiN68nJIgPmrph0oZglg/3533
 o/TZu3ajsMevGxN3x1cYkEGJBXSC+9FWfaVFXi9+xlv45L5fzM6d6KSSMREVEoLpbvu9
 jJpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmJ5jrHDw/LNuMa/QZ0Aa9uuutqRS8lFMLgVx5BzZZH2CMh9KcDhHyzf4NNIQlPanrUwaQQ7Qd9ewY@nongnu.org
X-Gm-Message-State: AOJu0YyIWGy0vYqH6MVCRScNalpXnf0BNVG+o7+fkb9Oge1zNKJZQmnz
 O/pWo8hiQWMsvNEX8y1k4KRUBNwdEkYnaMuBVxLi1pxi/oRMiuVuSKXQc/3BRijcYq8AGkbaui3
 znqM=
X-Google-Smtp-Source: AGHT+IE9Z0LpRkJtNUd+D8awfaFxtBGTfol3lS8/J1xYgfM1r8dDcgFbpVXE3QsmaimG+lbU5ILY+A==
X-Received: by 2002:a05:6a21:4a4c:b0:1cf:6c64:ee6b with SMTP id
 adf61e73a8af0-1d8ad7e1056mr2876974637.27.1728520847375; 
 Wed, 09 Oct 2024 17:40:47 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aa9390dsm23132b3a.129.2024.10.09.17.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:40:46 -0700 (PDT)
Message-ID: <2f96c07f-8ee8-4cef-9836-3229c73e0040@linaro.org>
Date: Wed, 9 Oct 2024 17:40:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NOTYET PATCH 22/23] accel/tcg: Drop TCGCPUOps.tlb_fill
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> Now that all targets have been converted to tlb_fill_align,
> remove the tlb_fill hook.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 10 ----------
>   accel/tcg/cputlb.c            | 19 ++++---------------
>   2 files changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index c932690621..e73c8a03de 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -157,16 +157,6 @@ struct TCGCPUOps {
>       bool (*tlb_fill_align)(CPUState *cpu, CPUTLBEntryFull *out, vaddr addr,
>                              MMUAccessType access_type, int mmu_idx,
>                              MemOp memop, int size, bool probe, uintptr_t ra);
> -    /**
> -     * @tlb_fill: Handle a softmmu tlb miss
> -     *
> -     * If the access is valid, call tlb_set_page and return true;
> -     * if the access is invalid and probe is true, return false;
> -     * otherwise raise an exception and do not return.
> -     */
> -    bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
> -                     MMUAccessType access_type, int mmu_idx,
> -                     bool probe, uintptr_t retaddr);
>       /**
>        * @do_transaction_failed: Callback for handling failed memory transactions
>        * (ie bus faults or external aborts; not MMU faults)
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 47b9557bb8..55c7bf737b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1251,23 +1251,12 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
>                              int mmu_idx, MemOp memop, int size,
>                              bool probe, uintptr_t ra)
>   {
> -    const TCGCPUOps *ops = cpu->cc->tcg_ops;
>       CPUTLBEntryFull full;
>   
> -    if (ops->tlb_fill_align) {
> -        if (ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
> -                                memop, size, probe, ra)) {
> -            tlb_set_page_full(cpu, mmu_idx, addr, &full);
> -            return true;
> -        }
> -    } else {
> -        /* Legacy behaviour is alignment before paging. */
> -        if (addr & ((1u << memop_alignment_bits(memop)) - 1)) {
> -            ops->do_unaligned_access(cpu, addr, type, mmu_idx, ra);
> -        }
> -        if (ops->tlb_fill(cpu, addr, size, type, mmu_idx, probe, ra)) {
> -            return true;
> -        }
> +    if (cpu->cc->tcg_ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
> +                                         memop, size, probe, ra)) {
> +        tlb_set_page_full(cpu, mmu_idx, addr, &full);
> +        return true;
>       }
>       assert(probe);
>       return false;

Looks good!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

