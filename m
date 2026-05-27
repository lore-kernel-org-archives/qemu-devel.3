Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CFCD6E43
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 19:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSK8C-0007JJ-5M; Wed, 27 May 2026 15:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wSK87-0007In-Rr
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:41:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wSK86-00076b-20
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:41:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-835451c5debso477565b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1779910882; x=1780515682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1uv2V9eNJqol31KIWezrM9t3ncL7xHa9H49nUk1I6w=;
 b=AByy8BIQgLZS3qygjRvoO+06YGDHlaTZzcY4fdTNIqO+CsWIQIdgwqrPys7jsljxV1
 UuQNV7ZNmOqgEa1AqphWoKQSiYfRvBN6+k4SrY6nQdkewNbJM6k+QS84FvZ4/yNFSdO3
 rMow0BugfIux7LT0iUXy0KgFI7bMZw0Uy6so08uchIKb4fCp5Y7nbzUwB9KWg5dbpdrn
 fyucWhU0+QfrP/wLhgwjnqcIXzEDd/xAW6RAaCoPTrPCpYhYYJVWOHvWR0/cgo9rZ1wp
 UXVxASoX9NAa6LnbHRoXQs39WbOLpdbr46KpZfoNoj97+/IHr2HRCkcNn2Qv7OKesDRa
 Unrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779910882; x=1780515682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I1uv2V9eNJqol31KIWezrM9t3ncL7xHa9H49nUk1I6w=;
 b=gKAKnsjeEfybv/dpl3gIT4rRCR9zmPSedrj+4QQBQSE2HNP6MwWTaE6fyDoHGRCsGM
 zWoqE61u3CHNwVwsB7z5YpNh+R8A9FRCoOKjeKVaoltjv4q30aTocT6d1vLzy9RGR1t9
 6DD/WAzhEgJc3xnlLsVoEQS1DrJxwx87gIuW/e1wMbZePalbCo+9L1Y4Sw1+jzPb7br3
 WIoYGCfD/J2FH7IcashiImMZpXEWqZ3dYeZF2JLISW4a5h69+knsNEKv6tqMy5ADMi+L
 E/CW4lh0aNhtfSfYLybavODky3ClVtG20pNM2Ut2samXXqlXbcwA8cM8+qb4rRBvGoKi
 Hudg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i4HA+USe7Q0lDYnG30gVVSJEfLp/j57oUex6Bb3l7Dy0jfSkSP8EFrR5/IkPRx2Frcfgrf2w4a3Pf@nongnu.org
X-Gm-Message-State: AOJu0YzGVfjK70TgQlZeavQ35qy9GuLmaWQx379adLdKCrzl923ou3mT
 Eh5+xVrT8fQ6kUOrowynpe1+yvCf77IpFTs9umVohgn1YZlEuenK1hkwoX8TYZXjgkw=
X-Gm-Gg: Acq92OHuk0t6aNr0wRE3hkvoTKBk99GRr6XXe6rRGXECjfPSZ7sxlrkXcy/9pbLFVmf
 VRvJNHOPR/sTp1A4jv7ER70Yr2YmoaANCmrzqPu3Af2aXxPsjgAjvpiOWpUPvT5A8dS43BP1243
 p5i89u+Eq88B1swVawHrckG5HcsO8F+43gDCqiNTqod+LqvzwBTc2NWy6N6GZbYdK8Dq9OW9EW4
 Kh0puIyWZEFoNJY6NuOu+ZwbhNm0nJ7lUqR4u8+TeFcsgkwWzI0CBRetdeWh9DVl6U7dxIKus4j
 m233mK34Ow4JxQW0jgtS2ZElADZxi0qky4ymi/ixj2i55IjkaWstT0FBJnkWR7eWWylSQammZaI
 3t5anoaExkK6U/VDlyL92qsjaau9Kd2Ts+/31mF/DWj6XMUyssgTiq099qwAppq9JrXxS4pZbj5
 Zvj7aZQf2kzkuOzcuJ2aR4RlcJsa8BtUexh7orV/gieX0UH+/DaUEB5z+5
X-Received: by 2002:a05:6a00:39aa:b0:82f:6a82:4231 with SMTP id
 d2e1a72fcca58-841ee07ea9emr120885b3a.1.1779910882355; 
 Wed, 27 May 2026 12:41:22 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d6e80246sm3818486b3a.12.2026.05.27.12.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 12:41:21 -0700 (PDT)
Message-ID: <dbaa7445-b4a4-45df-8ec0-b71cfded9d6e@tenstorrent.com>
Date: Thu, 28 May 2026 05:41:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Add support for a custom CPU arch state
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
Content-Language: en-US
From: Portia Stephens <portias@tenstorrent.com>
In-Reply-To: <3455d2a8-2345-4810-a8bd-8cb9b0c284bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=portias@tenstorrent.com; helo=mail-pf1-x430.google.com
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



On 27/5/2026 3:58 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 27/5/26 05:41, Alistair wrote:
>> On Wed, 27 May 2026, at 1:03 PM, stephensportia@gmail.com wrote:
>>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>>
>>> Custom vendor CSR implementations may require custom state information.
>>> This adds a custom_arch-state struct to the CPUArchState. It also adds a
>>> RISCVCPUDef function pointer for handling allocation and initialization
>>> of the custom_arch_state as well as a reset function pointer for setting
>>> the custom_arch_state fields to known values on reset.
>>>
>>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>>> ---
>>> target/riscv/cpu.c | 15 +++++++++++++++
>>> target/riscv/cpu.h |  7 +++++++
>>> 2 files changed, 22 insertions(+)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 862834b480..ca557d27b5 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -819,6 +819,10 @@ static void riscv_cpu_reset_hold(Object *obj, 
>>> ResetType type)
>>>       if (kvm_enabled()) {
>>>           kvm_riscv_reset_vcpu(cpu);
>>>       }
>>> +
>>> +    if (mcc->def->custom_arch_state_reset) {
>>> +        mcc->def->custom_arch_state_reset(env);
> 
> ResetType shouldn't be discarded IMO.

Are you referring to Alistair's comment about why do we need reset? Yes 
it is necessary to set the registers to a known state after a reset. A 
finalize function is probably also needed since init will allocate the 
struct.

> 
>>> +    }
>>> #endif
>>> }
>>> @@ -1167,6 +1171,9 @@ static void riscv_cpu_init(Object *obj)
>>>       if (mcc->def->custom_csrs) {
>>>           riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
>>>       }
>>> +    if (mcc->def->custom_arch_state_init) {
>>> +        mcc->def->custom_arch_state_init(&cpu->env);
>>> +    }
>>> #endif
>>>       accel_cpu_instance_init(CPU(obj));
>>> @@ -2706,6 +2713,14 @@ static void 
>>> riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>>>               assert(!mcc->def->custom_csrs);
>>>               mcc->def->custom_csrs = def->custom_csrs;
>>>           }
>>> +        if (def->custom_arch_state_init) {
>>> +            assert(!mcc->def->custom_arch_state_init);
>>> +            mcc->def->custom_arch_state_init = def- 
>>> >custom_arch_state_init;
>>> +        }
>>> +        if (def->custom_arch_state_reset) {
>>> +            assert(!mcc->def->custom_arch_state_reset);
>>> +            mcc->def->custom_arch_state_reset = def- 
>>> >custom_arch_state_reset;
>>> +        }
>>>       }
>>>       if (!object_class_is_abstract(c)) {
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index 7d79c7a5a7..8132c65012 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -213,6 +213,9 @@ typedef struct PMUFixedCtrState {
>>>           uint64_t counter_virt_prev[2];
>>> } PMUFixedCtrState;
>>> +typedef void (*riscv_csr_custom_init_fn)(CPURISCVState *env);
>>> +typedef void (*riscv_csr_custom_reset_fn)(CPURISCVState *env);
>>> +
>>> struct CPUArchState {
>>>       target_ulong gpr[32];
>>>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
>>> @@ -509,6 +512,8 @@ struct CPUArchState {
>>>       uint64_t rnmip;
>>>       uint64_t rnmi_irqvec;
>>>       uint64_t rnmi_excpvec;
>>> +
>>> +    const void *custom_arch_state;
>>> };
>>> /*
>>> @@ -561,6 +566,8 @@ typedef struct RISCVCPUDef {
>>>       RISCVCPUConfig cfg;
>>>       bool bare;
>>>       const RISCVCSR *custom_csrs;
>>> +    riscv_csr_custom_init_fn custom_arch_state_init;
>>> +    riscv_csr_custom_reset_fn custom_arch_state_reset;
>>
>> Why do we need an init and a reset? I assume init is to allocate the 
>> stuct, but that should probably be commented here.
>>
>> How do you expect these to be set? Do you have an example?
> 
> I don't see the point of upstreaming this patch without concrete
> example. So far it is maintenance burden without any value.

Okay.

> 
>>
>> Alistair
>>
>>> } RISCVCPUDef;
>>> /**
>>> -- 
>>> 2.43.0
>>>
>>>
>>>
>>
> 


