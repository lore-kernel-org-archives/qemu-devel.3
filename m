Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65421C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 20:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uierY-0005MP-N7; Sun, 03 Aug 2025 15:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uierS-0005Ij-2d
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 15:59:14 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uierQ-0001zR-BA
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 15:59:13 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-31f325c1bc1so2199970a91.1
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754251150; x=1754855950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ba3npdw8YT7yk0USFaK/6SqEgWLixBefHFVqeL+hI5k=;
 b=PIctFXoxaMdmMEYiWeBnOlPyaHGIXS1QM8LeWej5anOl9CvOYFOnMoa3YhMnOsef0c
 kRUVTGSFEBRLcXUHfJwFHlfks19VBw0CfiIPRdPQuIe8O4FdRU67uNgwTCoQ/2cUuq+w
 rWBf/EA9r1BfnX2hJr+o3VxwLzyDWFswQSvOuL8wd2qGrd8A8xgL+IkjbnyVjnuIgwsM
 rB0ZjrDO1m655ylzjLdll4ldeNvWHh/kK7/XTfUeylpN1Eq+1aG3H6vEB9drtvPx9yx2
 NopBpmo5lAQorztReI6iUqHmhCx44JXBpbo116Q6oYc2FXbp0OCMMzkU3pkgKc1sFyU2
 rOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754251150; x=1754855950;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ba3npdw8YT7yk0USFaK/6SqEgWLixBefHFVqeL+hI5k=;
 b=KyAw1XjakJr/MfLAqcF45IWy0FS0cMpRH7mMH/UFQjKClI4byA0cQdeH7Xpfg8ikxi
 //pHBQ2NIevvVSjP3ZKEgYs14tMqQt0H08pHdB15o+mxleMCi4ck+EIcPuD36gR3SugB
 bn5j9cvxiE/Tw8qmW+xaDvZFX3vQb5vqFRsYZ3UvBYxM6vI/gLuAXPph/+M7gJo3bF6n
 nFyzovOLBi/HwDKi8s00eJikXFVGf1Ym8gsKC9LFQ5GfyDE+QM/DtnP8LI8vsWp6qzFC
 0EgpPRGxckfOV0mEaKuJkoup6gUE7sKfEhIsHKr6aZN3066+hNffYn4nUQaxYXGj26ef
 N5tQ==
X-Gm-Message-State: AOJu0YxQX5u6HZVIz7JQo6S9Hm0F8KqzMdn8mDw6oLKYjYV893XVsuLt
 jeakzA2wfTySIRCbeh5D638oMwIEADlMMfGqvul3TGHu+DK5D/SDHMA0Rw5UObYFWIE=
X-Gm-Gg: ASbGncu/DlBu8A2VjhsbM2fzVcGZUq114vkZkTeIC0T3PbDpEP64BLIFNVJIwlUmhgI
 OwhqdrrhBT8tBEtKGxrytzwv8yj7fd9rYbPJBIF40fGZ6HSjoSuEV2zv9mBNR2VDb6ho6ZZqBZU
 pdoKmPSXzA57Ev1pZr4rSNfANBLbzQw3kNixanW1CPNmEzNWXsnE8zLjC6EaijillwvhCPbup0C
 Kraj8q/HhMjC058tZ4qQQSPC1wmyVRCL0tpvaDYwIaTMuiSZJ6AcNCQrDdxEqrMFA3dtF75it2+
 KIte8mpJ9x3s264PtgpsjcaB+QOD9nM5o1mVklxOOz3aKAvxuRe33Yw4ZCnmIg7oicAha/YCRWs
 pX72PUEAMiTWhuOKUNDawNieW2gGZ7GYRoFEjXSg1
X-Google-Smtp-Source: AGHT+IE01/GgaWkg5Hbfq9AUgXqBb6vNBl3p5cfGqC9bP/pKs/QQBpHLjLrFYoqg5UygmwvYSYZz7A==
X-Received: by 2002:a17:90b:3b4f:b0:321:1680:e056 with SMTP id
 98e67ed59e1d1-3211680e0a8mr9231845a91.9.1754251150489; 
 Sun, 03 Aug 2025 12:59:10 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63f36327sm12568400a91.36.2025.08.03.12.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Aug 2025 12:59:09 -0700 (PDT)
Message-ID: <d9e68c48-305e-44bb-b2f4-9fed0df9c8b1@linaro.org>
Date: Mon, 4 Aug 2025 05:59:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/95] semihosting: Initialize heap once per process
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-3-richard.henderson@linaro.org>
 <CAFEAcA8miFBnjrV30Sy4iStDRS0+PkLjOwc9FyY6v_MbtdqiqQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8miFBnjrV30Sy4iStDRS0+PkLjOwc9FyY6v_MbtdqiqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/3/25 20:41, Peter Maydell wrote:
> On Sun, 3 Aug 2025 at 00:06, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> While semihosting isn't really thread aware, the current
>> implementation allocates space for the heap per-thread.
>>
>> Remove the heap_base and heap_limit fields from TaskState.
>> Replace with static variables within do_common_semihosting.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> @@ -492,19 +489,20 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
>>       for(i = 0; i < 16; i++) {
>>           env->regs[i] = regs->uregs[i];
>>       }
>> -#if TARGET_BIG_ENDIAN
>> -    /* Enable BE8.  */
>> -    if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
>> -        && (info->elf_flags & EF_ARM_BE8)) {
>> -        env->uncached_cpsr |= CPSR_E;
>> -        env->cp15.sctlr_el[1] |= SCTLR_E0E;
>> -    } else {
>> -        env->cp15.sctlr_el[1] |= SCTLR_B;
>> -    }
>> -    arm_rebuild_hflags(env);
>> -#endif
>>
>> -    ts->heap_base = info->brk;
>> -    /* This will be filled in on the first SYS_HEAPINFO call.  */
>> -    ts->heap_limit = 0;
>> +    if (TARGET_BIG_ENDIAN) {
>> +        CPUState *cpu = env_cpu(env);
>> +        TaskState *ts = get_task_state(cpu);
>> +        struct image_info *info = ts->info;
>> +
>> +        /* Enable BE8.  */
>> +        if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
>> +            && (info->elf_flags & EF_ARM_BE8)) {
>> +            env->uncached_cpsr |= CPSR_E;
>> +            env->cp15.sctlr_el[1] |= SCTLR_E0E;
>> +        } else {
>> +            env->cp15.sctlr_el[1] |= SCTLR_B;
>> +        }
>> +        arm_rebuild_hflags(env);
>> +    }
> 
> This change to the big-endian handling code seems unrelated.

The ifdef caused unused variable Werrors for little-endian.
The best solution seemed to be to convert to a C if.


r~

