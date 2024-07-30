Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E576C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYnmf-0004fs-3d; Tue, 30 Jul 2024 10:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sYnmd-0004eq-Nm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:24:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sYnmb-0006lt-Eg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:24:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so30132165ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722349496; x=1722954296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u1OVFnxKJQgUPMUUBzmRHrfwBY6t5p5CTgz0Jof1Y0E=;
 b=WiPY8Q0f1S2ezGTzN+vqNdk8wsVTJzYx65+DPaB+l7DHoogoKK3K70RDP0X5zxtqzq
 yofCOt89BnJb+phQPTUjI4AszOVepfDjNfV0zwtCYiavAgfDtcQ7vGKcX4P+ggpXGc3+
 7y557gDA+k4+NJCQTCN41MNDZd6NbJNnClJAsRUOg8zOMvxsL/uYHRv9JDLDvk/GzPLz
 5WWpYxfUNOQa/n3RV2M+TojncCjRy6iIH8ekuNu9jZ9Eegb54l4HhNX4LxscK3Fjz6Nk
 XmE2IKA+fGt1r7tEVo02FVoE4s9lmvfAxt8S3dKiCNM8Fe+KoE2NOtKsQ9gFJxtyXKgA
 PQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722349496; x=1722954296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1OVFnxKJQgUPMUUBzmRHrfwBY6t5p5CTgz0Jof1Y0E=;
 b=XFU0S7dKyl2zLfX7s4K0dn1IqqU8FJq1q1kas+tUP4kMpepxGL7gmEOesMpJ4+VGXO
 yrqB8ypjSy3R9jEF5JDaDsGySVwUd8BQiSlSqzsTPB4+c1eK1QzMnKnvFHvVz6WULZXG
 jv/GoSG2BXlyxtIfLGfj2jd+RoDE8C3nSyyWNEvfsJv7MS3vDKM1h8tGdowUJdYg/TjP
 H+Z8hYL8DskkDeXqyI1vjYc0b0OjBZhtHOFvczvPgIA7Z4w2NyifOWR56jyE8NkxSIPE
 ByHcjKo3OfnRxTTJMeg1e2rJTN4mQMY4n3ofS/zOvtkD9xes8Qo6DR2vROxMHKwK6kpz
 eSxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Rk2ZqMPihPbk2DE96s3D2A571i1r6pw2GaSmgJApu2iYnW9Huzzwum99yzrxdvsFkY/OmLCMLHWuzlA1yioVsH6eNmg=
X-Gm-Message-State: AOJu0YzmfcRYIA4rHcWeE18LQvsd8tWtlwkDpxtEoWfRbtIKVXRsLPrl
 q1lh8saX5IxVhKrcyjc/B2JK4+4wpRa/t6xMKBngxAvF7K1U7wx4urtp9h32oZ4=
X-Google-Smtp-Source: AGHT+IHT5dqWPZCur5FokalsFJBy7XEEMilT3rMhlGR1i/XPwN0+cU/azslSVT9AyfQEFJ7qjxtbOw==
X-Received: by 2002:a17:903:608:b0:1fd:9d0c:998c with SMTP id
 d9443c01a7336-1ff04930fdcmr77679785ad.56.1722349495796; 
 Tue, 30 Jul 2024 07:24:55 -0700 (PDT)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ce41c5sm102672625ad.85.2024.07.30.07.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 07:24:55 -0700 (PDT)
Message-ID: <5a77744c-f0d1-4007-b2b1-edeccc4bca0c@sifive.com>
Date: Tue, 30 Jul 2024 22:24:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unmasked unit-stride load/store
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
 <20240717133936.713642-3-max.chou@sifive.com>
 <a02bcaba-0712-44f2-924f-8972a4f98ce7@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <a02bcaba-0712-44f2-924f-8972a4f98ce7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62d.google.com
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

On 2024/7/25 1:51 PM, Richard Henderson wrote:
> On 7/17/24 23:39, Max Chou wrote:
>> @@ -199,7 +212,7 @@ static void
>>   vext_ldst_stride(void *vd, void *v0, target_ulong base,
>>                    target_ulong stride, CPURISCVState *env,
>>                    uint32_t desc, uint32_t vm,
>> -                 vext_ldst_elem_fn *ldst_elem,
>> +                 vext_ldst_elem_fn_tlb * ldst_elem,
>
> Extra space: "type *var"
I will fix this part at v6.
Thanks.

>
>>                    uint32_t log2_esz, uintptr_t ra)
>>   {
>>       uint32_t i, k;
>> @@ -221,7 +234,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong 
>> base,
>>                   continue;
>>               }
>>               target_ulong addr = base + stride * i + (k << log2_esz);
>> -            ldst_elem(env, adjust_addr(env, addr), i + k * 
>> max_elems, vd, ra);
>> +            ldst_elem(env, adjust_addr(env, addr),
>> +                      (i + k * max_elems) << log2_esz, vd, ra);
>
> Is this some sort of bug fix?  It doesn't seem related...
> If it is a bug fix, it should be a separate patch.
This modification is caused by replacing the idx by byte offset for the 
vector register accessing flow in the basic GEN_VEXT_LD/ST_ELEMENT macros.
But I think that it's not a good idea now, it will get unexpected result 
when the endian between host and guest are different.

I'll fix this part at v6.
>
>>   /*
>>    * unit-stride: access elements stored contiguously in memory
>>    */
>>     /* unmasked unit-stride load and store operation */
>> +static void
>> +vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
>> +                  uint32_t elems, uint32_t nf, uint32_t max_elems,
>> +                  uint32_t log2_esz, bool is_load,
>> +                  vext_ldst_elem_fn_tlb *ldst_tlb,
>> +                  vext_ldst_elem_fn_host *ldst_host, uintptr_t ra)
>> +{
>> +    void *host;
>> +    int i, k, flags;
>> +    uint32_t esz = 1 << log2_esz;
>> +    uint32_t size = (elems * nf) << log2_esz;
>> +    uint32_t evl = env->vstart + elems;
>> +    int mmu_index = riscv_env_mmu_index(env, false);
>> +    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : 
>> MMU_DATA_STORE;
>
> You may want to pass in mmu_index, so that it is computed once in the 
> caller.
Thanks for the suggestion.
I'll try to pass in mmu_index at v6.

>
>> +
>> +    /* Check page permission/pmp/watchpoint/etc. */
>> +    flags = probe_access_flags(env, adjust_addr(env, addr), size, 
>> access_type,
>> +                               mmu_index, true, &host, ra);
>> +
>> +    if (host && flags == 0) {
>
> If flags == 0, host will always be non-null.
> You only need flags == 0.
Thanks for the suggestion.
I'll update this part at v6.

>
>>   static void
>>   vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, 
>> uint32_t desc,
>> -             vext_ldst_elem_fn *ldst_elem, uint32_t log2_esz, 
>> uint32_t evl,
>> -             uintptr_t ra)
>> +             vext_ldst_elem_fn_tlb *ldst_tlb,
>> +             vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
>> +             uint32_t evl, uintptr_t ra, bool is_load)
>>   {
>> -    uint32_t i, k;
>> +    uint32_t k;
>> +    target_ulong page_split, elems, addr;
>>       uint32_t nf = vext_nf(desc);
>>       uint32_t max_elems = vext_max_elems(desc, log2_esz);
>>       uint32_t esz = 1 << log2_esz;
>> +    uint32_t msize = nf * esz;
>>         VSTART_CHECK_EARLY_EXIT(env);
>>   -    /* load bytes from guest memory */
>> -    for (i = env->vstart; i < evl; env->vstart = ++i) {
>> -        k = 0;
>> -        while (k < nf) {
>> -            target_ulong addr = base + ((i * nf + k) << log2_esz);
>> -            ldst_elem(env, adjust_addr(env, addr), i + k * 
>> max_elems, vd, ra);
>> -            k++;
>> +    while (env->vstart < evl) {
>
> VSTART_CHECK_EARLY_EXIT has taken care of this condition for the first 
> page.
> We know that one contiguous operation can only consume 1024 bytes, so 
> cannot cross two pages.  Therefore this loop executes exactly once or 
> twice.
>
> I think it would be better to unroll this by hand:
>
>     calc page range
>     if (likely(elems)) {
>         vext_page_ldst_us(... elems ...);
>     }
>     if (unlikely(env->vstart < evl)) {
>         if (unlikely(page_split % msize)) {
>            ...
>         }
>         vext_page_ldst_us(... evl - vstart ...);
>     }
Yes, one contiguous operation can only consume 1024 bytes in vector 
unit-stride ld/st. It's a good idea to unroll it here.
I'll unroll this part at v6.
Thanks for the suggestion.

I'll try to extend the original loop implementation to other vector 
ld/st instructions that may cross multiple pages in the future.
>
>> +        /* Calculate page range */
>> +        addr = base + ((env->vstart * nf) << log2_esz);
>> +        page_split = -(addr | TARGET_PAGE_MASK);
>> +        /* Get number of elements */
>> +        elems = page_split / msize;
>> +        if (unlikely(env->vstart + elems >= evl)) {
>> +            elems = evl - env->vstart;
>> +        }
>> +
>> +        /* Load/store elements in page */
>> +        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, 
>> log2_esz,
>> +                          is_load, ldst_tlb, ldst_host, ra);
>> +
>> +        /* Cross page element */
>> +        if (unlikely((page_split % msize) != 0 && (env->vstart + 1) 
>> < evl)) {
>> +            for (k = 0; k < nf; k++) {
>> +                addr = base + ((env->vstart * nf + k) << log2_esz);
>> +                ldst_tlb(env, adjust_addr(env, addr),
>> +                         (k * max_elems + env->vstart) << log2_esz, 
>> vd, ra);
>> +            }
>> +            env->vstart++;
>>           }
>>       }
>> -    env->vstart = 0;
>>   +    env->vstart = 0;
>>       vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
>>   }
>
>
> r~


