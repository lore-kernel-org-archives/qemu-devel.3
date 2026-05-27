Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA87CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKfo-0000rU-LP; Wed, 27 May 2026 16:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKf6-0008F5-If
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKf4-0005ii-GC
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so73034115e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912929; x=1780517729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFt0e6x/Zi69UDOFZwUEpR6Wz4PUACFzWItgBxs6Ljs=;
 b=rrkAhFAcuFPcIWIKMHAKXcPlkk2M7Gs8v62CVRGHyeAVkMEh6qwG8/XfOzL/sU8krk
 /xrok5WJEh4pdSFRNL7gK56X4t6rrTWi/G7OAIPED9nl4u8bpzUHr2k0HrwDZ5eJoeXH
 oo4w2NowcFfh7WuPdQWKvXWqQZOGPbyvPr3r1ekr6tj82oqrHi0KgxZ4+rDN4y4LhKCj
 Qa9ZkhxlDkl9UjD/MQWx1d2UiBEFVtPG+2ckLMP/yXDsgeJJXLZx93MMZWYdVxH1QVH0
 PAdlCGvINv3MYFr4djgDd07mb/IiCOJhgT5qh1NxcvtPaVsAQczOQ64RagCV7wTpRgVn
 mS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912929; x=1780517729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qFt0e6x/Zi69UDOFZwUEpR6Wz4PUACFzWItgBxs6Ljs=;
 b=Yb2JAJj7Qad8bd2uXPZDDTL5Ly/Sce2bQlG0ueJrlkIwgA5XD1zdxtRiRE1bV2KKKs
 fYP6+lO2A/48UBq5QWmDhMepeUPgpG88zmFKi+1VUrEuqIg3AFhjW4S8yKKn3cJylyfN
 FZ9vQYA/FKKVECcnYnb0ac+Rz8ZFhY9gJHn9FuQYmRd9Dk2YNpxQMGssGUqjP32ckx6d
 g6JhggPHany7wbvcAvotyh8PZLZP+C8PrMh9dJBF/v/YhMpIcnoY3YVaieKhU3OwuqnK
 5uTNRBwZarTTr+wgtLM1ipce+xIBKIuXW4LJN/Kkm1sR5QlKL90TbuTMixJX05y5OkLq
 pqxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ832oi3O3//naGO6sOv9ko5dMVsmzBh2g8cW7iHO4PhMUoIaA6JdS7rz9gW+fmlh3NCBtYj5pEAStCM@nongnu.org
X-Gm-Message-State: AOJu0YxRlHn5IaQCEnL+Cve92n8ZLgHP+Lla8IjVDghoN9VpcLPQEL0I
 OMC620KvMVI3vc3rYfKPiwMMHl8YcNhbHtHzcdu/XvpUi9Kr4xD22X5kWoh1ifpEFmc=
X-Gm-Gg: Acq92OGGruEE4aVUtNPMQ/PWRHmeU4wydgGDX5qR7nahZezcHVbuLRzXh8PTNfxZp2h
 YYS7nvP2sWJk33+xBrjoETwUSDDem/bMbE9zgUfH+c9yB0tmGdRwqWBKUJtqnCkwRqTJuoX1YM2
 XSIPLqVBoKZq+GdtuXdq82ajWvk87NNrEN4DUb0n9OSCloJZ+7HpZeQ3pTjSb3uWukHsYkPpzQh
 B/q/mKTE0KpAeU2//Je5roSM3fyNBefOkL/mL+zSF1bDyBBzl1987U7vHNGlUOhEZBFRnLAzKuh
 eNHdYUymlxlk97zf+697+N/XDECZlmgMyGpqSQ1hpKeJq9cB9sQmH65zOAZDcMuIwoeYyrHjaGf
 OinVX87gbgfSoD9QFLDb5/J6GZwrPz/jrFopQoyaWcd/nNdXlhgQeUQdpYl15djy/YGjgoMi2Wq
 RFVfk8vkeVkzVAuIba/U9TsqPKZ/i16Sjil8Hl4fsCkPIRn0B08w1FfEQ8ju9cCgbC/xVnwA7Li
 asK
X-Received: by 2002:a05:600c:4f0f:b0:490:5149:a242 with SMTP id
 5b1f17b1804b1-4905149afd4mr395260365e9.5.1779912928985; 
 Wed, 27 May 2026 13:15:28 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm619573865e9.7.2026.05.27.13.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 13:15:27 -0700 (PDT)
Message-ID: <174c5540-2525-4fa9-9aaf-faf21f185fd4@linaro.org>
Date: Wed, 27 May 2026 22:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Add support for a custom CPU arch state
Content-Language: en-US
To: Portia Stephens <portias@tenstorrent.com>,
 Alistair <alistair@alistair23.me>, Portia Stephens
 <stephensportia@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260527030327.2289-1-stephensportia@gmail.com>
 <02b1f49a-84f8-4762-a21d-13c8087f6c0a@app.fastmail.com>
 <3455d2a8-2345-4810-a8bd-8cb9b0c284bb@linaro.org>
 <dbaa7445-b4a4-45df-8ec0-b71cfded9d6e@tenstorrent.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dbaa7445-b4a4-45df-8ec0-b71cfded9d6e@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/5/26 21:41, Portia Stephens wrote:
> 
> 
> On 27/5/2026 3:58 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 27/5/26 05:41, Alistair wrote:
>>> On Wed, 27 May 2026, at 1:03 PM, stephensportia@gmail.com wrote:
>>>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>>>
>>>> Custom vendor CSR implementations may require custom state information.
>>>> This adds a custom_arch-state struct to the CPUArchState. It also 
>>>> adds a
>>>> RISCVCPUDef function pointer for handling allocation and initialization
>>>> of the custom_arch_state as well as a reset function pointer for 
>>>> setting
>>>> the custom_arch_state fields to known values on reset.
>>>>
>>>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>>>> ---
>>>> target/riscv/cpu.c | 15 +++++++++++++++
>>>> target/riscv/cpu.h |  7 +++++++
>>>> 2 files changed, 22 insertions(+)
>>>>
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index 862834b480..ca557d27b5 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -819,6 +819,10 @@ static void riscv_cpu_reset_hold(Object *obj, 
>>>> ResetType type)
>>>>       if (kvm_enabled()) {
>>>>           kvm_riscv_reset_vcpu(cpu);
>>>>       }
>>>> +
>>>> +    if (mcc->def->custom_arch_state_reset) {
>>>> +        mcc->def->custom_arch_state_reset(env);
>>
>> ResetType shouldn't be discarded IMO.
> 
> Are you referring to Alistair's comment about why do we need reset? Yes 
> it is necessary to set the registers to a known state after a reset. A 
> finalize function is probably also needed since init will allocate the 
> struct.

No; you introduce the RISCVCPUDef::custom_arch_state_init() handler
but discard the ResetType argument. Implementations could use it.

> 
>>
>>>> +    }
>>>> #endif
>>>> }
>>>> @@ -1167,6 +1171,9 @@ static void riscv_cpu_init(Object *obj)
>>>>       if (mcc->def->custom_csrs) {
>>>>           riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
>>>>       }
>>>> +    if (mcc->def->custom_arch_state_init) {
>>>> +        mcc->def->custom_arch_state_init(&cpu->env);
>>>> +    }
>>>> #endif
>>>>       accel_cpu_instance_init(CPU(obj));
>>>> @@ -2706,6 +2713,14 @@ static void 
>>>> riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>>>>               assert(!mcc->def->custom_csrs);
>>>>               mcc->def->custom_csrs = def->custom_csrs;
>>>>           }
>>>> +        if (def->custom_arch_state_init) {
>>>> +            assert(!mcc->def->custom_arch_state_init);
>>>> +            mcc->def->custom_arch_state_init = def- 
>>>> >custom_arch_state_init;
>>>> +        }
>>>> +        if (def->custom_arch_state_reset) {
>>>> +            assert(!mcc->def->custom_arch_state_reset);
>>>> +            mcc->def->custom_arch_state_reset = def- 
>>>> >custom_arch_state_reset;
>>>> +        }
>>>>       }
>>>>       if (!object_class_is_abstract(c)) {
>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>> index 7d79c7a5a7..8132c65012 100644
>>>> --- a/target/riscv/cpu.h
>>>> +++ b/target/riscv/cpu.h
>>>> @@ -213,6 +213,9 @@ typedef struct PMUFixedCtrState {
>>>>           uint64_t counter_virt_prev[2];
>>>> } PMUFixedCtrState;
>>>> +typedef void (*riscv_csr_custom_init_fn)(CPURISCVState *env);
>>>> +typedef void (*riscv_csr_custom_reset_fn)(CPURISCVState *env);
>>>> +
>>>> struct CPUArchState {
>>>>       target_ulong gpr[32];
>>>>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
>>>> @@ -509,6 +512,8 @@ struct CPUArchState {
>>>>       uint64_t rnmip;
>>>>       uint64_t rnmi_irqvec;
>>>>       uint64_t rnmi_excpvec;
>>>> +
>>>> +    const void *custom_arch_state;
>>>> };
>>>> /*
>>>> @@ -561,6 +566,8 @@ typedef struct RISCVCPUDef {
>>>>       RISCVCPUConfig cfg;
>>>>       bool bare;
>>>>       const RISCVCSR *custom_csrs;
>>>> +    riscv_csr_custom_init_fn custom_arch_state_init;
>>>> +    riscv_csr_custom_reset_fn custom_arch_state_reset;
>>>
>>> Why do we need an init and a reset? I assume init is to allocate the 
>>> stuct, but that should probably be commented here.
>>>
>>> How do you expect these to be set? Do you have an example?
>>
>> I don't see the point of upstreaming this patch without concrete
>> example. So far it is maintenance burden without any value.
> 
> Okay.
> 
>>
>>>
>>> Alistair
>>>
>>>> } RISCVCPUDef;
>>>> /**
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>>>
>>>
>>
> 


