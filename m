Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A2CFC5FE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syytJ-0007jG-4i; Thu, 10 Oct 2024 15:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syytF-0007iz-Tp
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:32:01 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syytD-0007nf-Vq
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:32:01 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e0894f1b14so1029043a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728588718; x=1729193518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsxI5E6Lk3MMdfjkgsrkSUVETdXMGPx6Of5NOh/SYOM=;
 b=D8bVW9hyga1fXUL9qqAfOd+qdxbrsyvUa0OJKjDNKebgpFntQbdemi9yBxkEjKCZin
 9dNpwvMjekPewDtrbaDkRUxE1zwzCVOueOC+APk0zBGzjUcusCS/i1KD0RmRBkrpelIy
 O2wcBs4pYZxOjCS1i2z8ooyQkPR/pFlQKd5AdnQh2Q5Ow30PZa8bTj5RvM2TH5mDgLxs
 4I2PikVmDZ8fRo43zGYtZ9lpp9JCaWd7U1D25PB8aXY83GEgFvuD5pli4R9nW7x36V2T
 n2kIC8+3Em1cCJRmI4GrHv5LBaajtbOj14VDuiQcPbHuZD8W/4xDLss50C4CFGlq5PZz
 lj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728588718; x=1729193518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wsxI5E6Lk3MMdfjkgsrkSUVETdXMGPx6Of5NOh/SYOM=;
 b=IY6e/mCIipfxOk1W7pud8hTj1l5ZX1M2LALg1eYkncyRAhYwCs4aXlGp2bvt95XpDh
 uoAl/fJbzxWPhkUHCkuF8+Efk8BSIGk5E2OO+z2Rgrsmi9a/95zPazJiVZvmEVbIQzUo
 OpQILppAZfRodW7+a7zAfvtmQY+KaWiLOhisbKvFUpJ4vwVQCUZpTWXV/YKIbxnOUDu3
 UrmRbBFPOyq2p1zO0SuxM05jEJ9N2T3c1ruKsS4ClRnzhBmB4nSembkx29r3HQp72sZ/
 1pYb9tLNDkHcFwfV1roDCvW4vWIt65m8mOQzE6fcfxF941mvHYLaq/yNrj0SVN48ZpC8
 l3Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtYO2HZYExhlNt7Uh/vOfVNQxPyrD7sOKkws5o7WiZMPJ6nm95pp7nPNsHYw3jpooBHIgrgkPi9/XO@nongnu.org
X-Gm-Message-State: AOJu0YwJrRX7fX4GMscKJ45PSQBbvuFGTsYB7LXie4fjOoYBUzvj1Zlf
 NiChEZTw2fuwa75OGrhQZeNmhuFiJh3GZDJ33P2JO9OfCT6pZehr9wAl3epxA3chUcJzhIxOozE
 o
X-Google-Smtp-Source: AGHT+IFzvm6UpCvhZSqOJuvXVqDXTaG9iIjJjrlbhRvqxz9J7WRPX/ELjvpQGzh+Bgb0nsDJpiI/4A==
X-Received: by 2002:a17:90b:951:b0:2e2:ba35:356e with SMTP id
 98e67ed59e1d1-2e2f0ad1374mr330380a91.17.1728588718509; 
 Thu, 10 Oct 2024 12:31:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5eeb082sm1742379a91.21.2024.10.10.12.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 12:31:58 -0700 (PDT)
Message-ID: <7de0fccc-456f-446c-8c01-19daed0a3f5d@linaro.org>
Date: Thu, 10 Oct 2024 12:31:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-19-richard.henderson@linaro.org>
 <32195e57-9e94-4060-80cb-911505813788@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <32195e57-9e94-4060-80cb-911505813788@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 10/9/24 17:23, Pierrick Bouvier wrote:
> On 10/9/24 08:08, Richard Henderson wrote:
>> Ensure a common entry point for all code lookups.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/cputlb.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index 59ee766d51..61daa89e06 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -2954,28 +2954,28 @@ uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
>>   {
>>       CPUState *cs = env_cpu(env);
>>       MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
>> -    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
>> +    return cpu_ldb_code_mmu(env, addr, oi, 0);
>>   }
>>   uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
>>   {
>>       CPUState *cs = env_cpu(env);
>>       MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
>> -    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
>> +    return cpu_ldw_code_mmu(env, addr, oi, 0);
>>   }
>>   uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
>>   {
>>       CPUState *cs = env_cpu(env);
>>       MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
>> -    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
>> +    return cpu_ldl_code_mmu(env, addr, oi, 0);
>>   }
>>   uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
>>   {
>>       CPUState *cs = env_cpu(env);
>>       MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
>> -    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
>> +    return cpu_ldq_code_mmu(env, addr, oi, 0);
>>   }
>>   uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
> 
> This will still call the same functions behind _code_mmu variants, but I guess it's more 
> coherent overall.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Previously, I was modifying cpu_ld*_code_mmu, so this mattered.
But I dropped that, so I should drop this as well.


r~

