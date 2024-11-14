Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C839D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf15-0004cr-3m; Thu, 14 Nov 2024 13:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf0c-00037r-6m
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:56:03 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf0a-0000RU-2R
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:56:01 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71a4210bcfeso568229a34.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610558; x=1732215358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ojb8nBpKVYXjd2u5bC/Ui/48M1Q4AJk+hIp/A4henE0=;
 b=dP6xISoGBCW6q7j7JdtGr9GWjZVqSW80KXAHFRTygi3TGNf6GtEE8+Ce22bPqIcTQ7
 tZEk7QZodlwYDv8zptd7m8ndIhf6RbQlNrVXrOBbFSlC+D0CaYB6/+TOULVImdnnZqhg
 SIYCKht/382S3eA8Tqij/Z0IHhohzIH7SoRGCBeRj1V4Trm9err3ckPW81r7/i3uXng9
 wyAPnbIK0OWp4qX/7NIcct5jw/m4wb5qjLj0bIcnAjwbKb5QQ3iTeUkImM62k0x3kYDG
 Dcnr/XT/5WHJk+4848u8QOYwrp6kfoY4IWsz5f4Shr9G5AWRV/9eNU81QZw3TA+lEcvm
 K6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610558; x=1732215358;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ojb8nBpKVYXjd2u5bC/Ui/48M1Q4AJk+hIp/A4henE0=;
 b=Ny9IbfV+bhD6SDxwLeO0ohvUCWBhFp/JshW7bkIlIFjaZF+ES8QIrmGxe/j6TYqB9J
 5S8G5Xfq/TYr/dR72fJAHGzf6W7tAee2BU5b9CygOFlETJS/17yJyPFDyzeb3Wfiu5+8
 XSsswK6BHakoic0dPQ+B5liKODehgunIuUkZn0gU+z1Kv/6wEA8SghTaF1qpcQDWti94
 ZcWJ05ma/uI/jJsi0ReZ1M6kYFSO6G3QFvku0ve4/VXkGl+1sGquD9yYsIb3UlhPb1vR
 kl17ahCenHFHQ/GC9Lw+PE7FPbsfQHsVYfSTcnfw4wuxh1Uu0THRC+2FUdsUfmKyAyHe
 8uXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcDYrvsoPrOdW/QqlQX/xUDzBR8TiTUONi63Ra6Cul0d6CPUZR/YTtvFPBPhRKe/4d2MemPb+brLyI@nongnu.org
X-Gm-Message-State: AOJu0YwvHD3iU3e07bY06gqKFz1JiGAA2kEKKykAHkJybhw421z+dWqb
 gPIzYi440mSpq1R6JqLgOVJhKPfVh600LOlycJMFsb2yND6/lkkJ2ybKYLqnQ+w=
X-Google-Smtp-Source: AGHT+IHIgKgf5EkqVgh/R+drOrq+cNBlP7zZ9UbqHl+FvGz/87ZENdhCzL89igDRFMDnVT/fr0VVzw==
X-Received: by 2002:a05:6830:374c:b0:71a:21c9:cd62 with SMTP id
 46e09a7af769-71a77979c17mr41871a34.17.1731610558411; 
 Thu, 14 Nov 2024 10:55:58 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b39af62esm1275662a12.76.2024.11.14.10.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:55:58 -0800 (PST)
Message-ID: <1b6221c7-aa65-49fd-be52-1af422331806@linaro.org>
Date: Thu, 14 Nov 2024 10:55:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 51/54] accel/tcg: Drop TCGCPUOps.tlb_fill
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-52-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-52-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x335.google.com
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
> index 663efb9133..70cafcc6cd 100644
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
> index 7f63dc3fd8..ec597ed6f5 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1222,23 +1222,12 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


