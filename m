Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C20BCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmBM-00005Y-Sc; Mon, 20 Oct 2025 05:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vAmBL-000057-8a
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:27:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vAmBI-0007Zj-D4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:27:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-782a77b5ec7so3737826b3a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760952474; x=1761557274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4qZvem4EwIGU4LYtNnkcNdEpGFcE9mHNzKBr062p7UM=;
 b=EAIExxwwxRmR1effvV77kbrHCLItSSlk7HbXJrhWldgPJyJ4n4eNFmzmZxdIct2ljk
 895R9847Rszl4Rkkv49ZFoONrczwpRhoIIzIQDVW8gmglp6Zqnc2BZNWSUKUyGwmjrXv
 B8RnpAVGVAwtgMiuzoh45MELqVSDW+N+F44XpKfKpOrIgdepj8A+urK8wGLE+bfrFi1g
 +k5lI9kEroNyYL2EjrdqQ9bj20X/0w62pSd36FHLypxhNhOr5uWup/BJLjTgcyzW0/PR
 D3ECJJo7sawNh7NfaV7Co+IpZQj+hmGYRG2QfDsDSi5Zn3OfYT6TIRbmtuhlpUHtHm5s
 uNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760952474; x=1761557274;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4qZvem4EwIGU4LYtNnkcNdEpGFcE9mHNzKBr062p7UM=;
 b=iOLeXn4oEkCIRb4GLyh0kl3fiwlj1B5POALArEaJ8nLKlJUJZvPU5WQw+cxvNvNWyB
 ifuoOuYp7gXDY8wouX/IfkYDo1Ob/q3qNjTsV9kuIdC1IZbPi2khAHW0eI3TYKXB4bfW
 2BKHWfpO0dFQ23hMCPjExhuzG+8LWu+LsgtZafFq68B2afncdIEcx7dyTE37y0Nd+O1H
 PE15Lk8unRptvbceCr+INBQOsUCQuZRjBKiOlv7s8g/HqKMok1sZLLptzLKmBWNofiWw
 OLMecWVhml2AiEQ4qKXKJcq7kk/EdPPElXbahb0xRnfHblDGI/kJFunnXQOmlDphgQz2
 3qmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ557ysDh2/YRR650CfzWbD43wBFEJH0UPu3ve4jKSDTGlF59sBKH1OEHyDXpiGmF9i6GR1X1EZLHn@nongnu.org
X-Gm-Message-State: AOJu0Yy62wm1uILSolRxFc9hlT10I825EQMDytuJ/QErff5MP6fj+6G1
 Q/ZTcZcOkivKo4Fv4cAlsokW0ZUo4oP99XdI/6hJSz3CVB7VclqWsU/OwXk3JR9aH7I=
X-Gm-Gg: ASbGncs/e5CmEE2F2VIPcVsYUVoF9K748eVxIS/Xz7BUNEgq2yUvs8fXP0xF1/KCgcD
 s9ceuWZcgkhIcpUcHnQwm63bjwSahHpEjLOZ1B/g21z+RSNVUVQN2y2sgPuu1T9bboU4Ea98rf5
 lhXLK+uRakl8IwATQ44lVY2omqAKZuSpUelq5/b+ZUbhbhaTkLGezx6+P7jyx/ql5Kx8HEGlUFQ
 5jaZTwHboHiU+e9I3e013lgRsMZ+TCN02Ehbe8+sSuZHWaXKsiw7vKF0SACbOFVQQ1D1densIc4
 H61clJya902BuR2LbObtD1smJZy1Toi3w8HCGfkRArhjopWRcqoWzjSiO+PTLMsA+gChH0LnDLP
 +yXlAwy7WTbyBadX4viEbpWHGUXP6LbPaWc8DpUY7fUsjf4HqNxV3WfyLYk/2TEZhenoGCX0RO9
 /qMoAIvby9SX8Jl61sXghcV1E5Gw==
X-Google-Smtp-Source: AGHT+IHMbR9jgDyxTbe0VHaUISG175QC0p/ufK3jM9yjfP15A5bCnXRuFkx5mHjJIdUOfs1QzQWIug==
X-Received: by 2002:a17:902:e552:b0:290:ac36:2ed8 with SMTP id
 d9443c01a7336-290c9ce63d6mr137614935ad.24.1760952474018; 
 Mon, 20 Oct 2025 02:27:54 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721948bsm74260765ad.109.2025.10.20.02.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 02:27:53 -0700 (PDT)
Message-ID: <30185454-1c2a-4a74-b094-7879e4f3c1ec@ventanamicro.com>
Date: Mon, 20 Oct 2025 06:27:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix a uninitialized variable warning
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20251019-vlen-v1-1-f7352a402f06@rsg.ci.i.u-tokyo.ac.jp>
 <b3cbe49d-e863-456d-a254-b7514e3bb33a@ventanamicro.com>
 <aafbce70-45a1-45cd-9006-df0871fdb3d9@rsg.ci.i.u-tokyo.ac.jp>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <aafbce70-45a1-45cd-9006-df0871fdb3d9@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



On 10/19/25 9:22 PM, Akihiko Odaki wrote:
> On 2025/10/19 19:01, Daniel Henrique Barboza wrote:
>>
>>
>> On 10/19/25 5:19 AM, Akihiko Odaki wrote:
>>> riscv_cpu_validate_v() left its variable, min_vlen, uninitialized if
>>> no vector extension is available, causing a compiler warning. Avoid
>>> the warning by calling g_assert_not_reached() in the case.
>>
>> For the compiler point of view the variable will be left uninitialized.
>> In reality we'll always set it to at least '32' in validate_v(). This
>> is how the function is being called:
>>
>>      if (cpu->cfg.ext_zve32x) {
>>          riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>>          if (local_err != NULL) {
>>              error_propagate(errp, local_err);
>>              return;
>>          }
>>      }
>>
>> This means that inside the function we guarantee that min_vlen will be
>> at least set to 32 because cfg->ext_zve32x will always be true:
>>
>>      if (riscv_has_ext(env, RVV)) {
>>          min_vlen = 128;
>>      } else if (cfg->ext_zve64x) {
>>          min_vlen = 64;
>>      } else if (cfg->ext_zve32x) {
>>          min_vlen = 32;
>>      }
>>
>>
>> To make the compiler happy and the code a bit clearer I suggest initializing
>> min_vlen = 32 and folding the "if (cpu->cfg.ext_zve32x)" check inside
>> validate_v() for an early exit. Something like this:
>>
>>
>> @@ -417,15 +417,19 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
>>   static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>>                                    Error **errp)
>>   {
>> -    uint32_t min_vlen;
>> -    uint32_t vlen = cfg->vlenb << 3;
>> +    uint32_t min_vlen, vlen;
>> +
>> +    if (cfg->ext_zve32x) {
>> +        return;
>> +    }
>> +
>> +    min_vlen = 32;
>> +    vlen = cfg->vlenb << 3;
>>
>>       if (riscv_has_ext(env, RVV)) {
>>           min_vlen = 128;
>>       } else if (cfg->ext_zve64x) {
>>           min_vlen = 64;
>> -    } else if (cfg->ext_zve32x) {
>> -        min_vlen = 32;
>>       }
> 
> What about:
> 
>      if (riscv_has_ext(env, RVV)) {
>          min_vlen = 128;
>      } else if (cfg->ext_zve64x) {
>          min_vlen = 64;
>      } else if (cfg->ext_zve32x) {
>          min_vlen = 32;
>      } else {
>          return;
>      }
> 
> Always initializing min_vlen with 32 looks a bit misleading to me. min_vlen is inherently dependent on the RVV and zve* flags; initializing the value after checking the flags show that more clearly.


LGTM

> 
> And I find separating the cfg->ext_zve64x and cfg->ext_zve32x checks a bit awkward as they are semantically not that different. In terms of semantics, I see the code like as follows:
> 
> if (RVV) {
>    initialize the extension parameters for RVV
> } else if (zve64x) {
>    initialize the extension parameters for zve64x
> } else if (zve32x) {
>    initialize the extension parameters for zve32x
> } else {
>    no vector extension is present so skip validation
> }
> 
>>
>>       if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
>> @@ -676,12 +680,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>>           return;
>>       }
>>
>> -    if (cpu->cfg.ext_zve32x) {
>> -        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>> -        if (local_err != NULL) {
>> -            error_propagate(errp, local_err);
>> -            return;
>> -        }
>> +    riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>> +    if (local_err != NULL) {
>> +        error_propagate(errp, local_err);
>> +        return;
> 
> Removing this duplicate cpu->cfg.ext_zve32x looks good.
> 
>>       }
>>
>>
>> Note: I wonder why we're allowing settings of VLEN and so on when we do
>> not have RVV set. Seems like a bug ...
> 
> I think this is because the ordering of property setting is not deterministic. It is possible to set the vlen property before setting the v, zve64x or zve32x properties.

Hmmm good point. The logic predates the current structure we have ATM.


Thanks,


Daniel

> 
> Regards,
> Akihiko Odaki


