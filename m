Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08D0C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWms3-0006BS-Et; Tue, 01 Jul 2025 22:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWms1-0006Aq-Of
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:06:45 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWmrz-0002v6-PG
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:06:45 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-408fa4be483so2255622b6e.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 19:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751422002; x=1752026802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4yiF5IrOyxAjbvHg14hQjpBgBMge4ArYTidkU/xmVuQ=;
 b=Abtf39011RQO515bmJhEW4pLNEj7RC6J1LX72ZgP9TW5LUeFL/DOnPCasHCwmS665d
 VAh1ikMbXa56qey+TWaDqHG118/p2hzVZ1I6GfuaeIHLVr5IcP+fi/MXYBDp4Mk491wX
 6FxB+rps3tsUlnf4rUPjxHs2l4EoHnfPiQ4bAzOww4dDqjfYuSYn8mUwdkJFMurtBAOJ
 63SytYNQeI1wowh0bG8+IgZ730CRnSYLubmaI8ZOe/PDnL36ZbavnYkIwr6Plng2MzHz
 Xva+OizU7Qlv61nrG4DL9Au3wH9HqlE3xzvvXR9THcZQJGMxy5PNgvEvFfkscZOYVrZF
 nhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751422002; x=1752026802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yiF5IrOyxAjbvHg14hQjpBgBMge4ArYTidkU/xmVuQ=;
 b=olZQbWtwAhtpJm0V+DpoFYYic/bqHu6KRX8aUvcisWfWEIzAiQyYb3U0hiYqTbU5iZ
 gXN7UVS3EmyTlZ2HUNChwhVeYdA+xeptLGE02f9dKT7rV9ZMud3tO8X6a/gfR0NuAW4/
 g5zO+F4XOwZbE4fyoCZB/5rD4CW2Ykuuo397Ccri2Z2gypPOLTM2SVj82uA10kg/r8wX
 U8bYHORS7bo+z6B+ebtgU50fyvveMNR5Tqc3djB6bdQ8idDwTwRKmpsm/HWs0oT5QD4X
 LuOZG1Y+dXKG7+Ywadg+ajaSV3eHNxQboLgLz2LyDxeoNuQvsDP6NncLS25wZk68Gz3W
 iQWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGsnIEV8YcELzPfS02uMqf7keQX1m2OoKvhdz0TogtrR9KxruzqZJz9stsbRs0/M9MpLLlXv1Cf3vp@nongnu.org
X-Gm-Message-State: AOJu0Yy/nMVtBBvxg6yubW30WTT8/uy1fPjIn/c4BzfAHgCPHREwkxkv
 EafBpkOHV5q8SNd/ehPUr12m5jzgBEaMq3wwCwChAkb2SkRUIpPQw8Z/cTPLWtbjINU=
X-Gm-Gg: ASbGncvkX6so+532HkamwLle0c4OFUbItEmdZb4ZAfka3NWogggesVN6HrGCuIaYGdN
 Z6CisKuYHJAECvBm6WLVq7Ky1+bctUU6yG1Oep+M6ynNZhOh0AVF8kfhJXbC9o7vdIheT3ZpywJ
 iB/u3yJiFm/dqpz2ks3K4eD3j4GRTWBN8txKIB0upcsSW8AJErjQU6hiIbs3ZNHB9rUV79IkXl7
 U5pXD+99+oEFa1MNRNS4rvBgsUQLJkHLE6CLuiVMvhLHHUr7alpM687NLTc8YJqo9ddovBNkjdP
 Vwfk3qcgRQF5nm2pQkH3UycMA2pWymr3HGWr+AMqnAskdBoXgVvKjusOoau7bQpTQJGqy+XTC7q
 ZNQ==
X-Google-Smtp-Source: AGHT+IGxyT0fBeicXhygu5eGtQ4t1xiPfHzAuxTaICk2L0+FogJe5PrpDCo/PS4jK/C5Flwrz9reyA==
X-Received: by 2002:a05:6808:6909:b0:40b:1588:e005 with SMTP id
 5614622812f47-40b8877df29mr667132b6e.10.1751422002239; 
 Tue, 01 Jul 2025 19:06:42 -0700 (PDT)
Received: from [10.25.7.201] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b324050d2sm2370875b6e.32.2025.07.01.19.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 19:06:41 -0700 (PDT)
Message-ID: <0ac8967e-ce39-4820-8c60-474b702cc728@linaro.org>
Date: Tue, 1 Jul 2025 20:06:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] target/arm: Fix VLSTM/VLLDM helper load/store
 alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
 <20250701103159.62661-2-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701103159.62661-2-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/1/25 04:31, William Kosasih wrote:
> This patch adds alignment checks in the load operations in the VLLDM
> instruction, and in the store operations in the VLSTM instruction.
> 
> Manual alignment checks in the both helpers are retained because they
> enforce an 8-byte alignment requirement (instead of the 4-byte alignment for
> ordinary long loads/stores). References to cpu_*_data_* are still replaced
> with cpu_*_mmu(), so that the individual word accesses themselves also
> perform the standard alignment checks, in keeping with the ARM pseudocode.

So... this merely makes this function match the pseudocode, it doesn't actually fix a bug.
This description should be fixed to reflect that.

> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index 6614719832..251e12edf9 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -1048,6 +1048,9 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
>       bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
>       bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
>       uintptr_t ra = GETPC();
> +    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
> +    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
> +                                 arm_to_core_mmu_idx(mmu_idx));
>   
>       assert(env->v7m.secure);
>   
> @@ -1073,7 +1076,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
>        * Note that we do not use v7m_stack_write() here, because the
>        * accesses should not set the FSR bits for stacking errors if they
>        * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
> -     * or AccType_LAZYFP). Faults in cpu_stl_data_ra() will throw exceptions
> +     * or AccType_LAZYFP). Faults in cpu_stl_mmu() will throw exceptions
>        * and longjmp out.
>        */
>       if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
> @@ -1089,12 +1092,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
>               if (i >= 16) {
>                   faddr += 8; /* skip the slot for the FPSCR */
>               }
> -            cpu_stl_data_ra(env, faddr, slo, ra);
> -            cpu_stl_data_ra(env, faddr + 4, shi, ra);
> +            cpu_stl_mmu(env, faddr, slo, oi, ra);
> +            cpu_stl_mmu(env, faddr + 4, shi, oi, ra);

This is an improvement because the mmu index is resolved once, instead of within every 
call to cpu_stl_data_ra.


r~

