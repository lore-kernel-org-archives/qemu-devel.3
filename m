Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2F9D65C40
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwq9-0002yk-6w; Wed, 17 Dec 2025 14:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVwq7-0002y8-6Q
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:05:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVwq4-00088j-Vd
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:05:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso5493135e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765998331; x=1766603131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pt92HLCtvDc3E9mopn34lz2s5csYP3EHsCvLiAlUXFg=;
 b=Q9zrRrPzl6bHLbi6RYeqWvozucemJ6oRGoM2X7WhINbbBLhWfdkwPakWB1BIIXG3sF
 XY/O6hEO366hUt4e6NXvozDk1c8PpQglwpGYdpodocf2AjPci8HBEiyjC+ErhVqKw6cN
 LA5wfSoeaDZFeB33fgF/e1jXjC/tQI2Ul1dnC80GcYszgjhu3Qh5RRQwfrR4fCLewSHV
 vGQSR1578s8I7jccehUsvyPgIhIPqhkV7grErsbvxaD+haEALlAgWKccjyMpEVkrTbl2
 fuiC9EmlH5n67CBgkRHrY+FHtJ6DOr/0JjDDkI/DGuVNZAFoY79P5vIcy6Pf3y4hVX+P
 VN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765998331; x=1766603131;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pt92HLCtvDc3E9mopn34lz2s5csYP3EHsCvLiAlUXFg=;
 b=crONckbfWpydfuCGq4+/qxNr0T4P5gdNrXIrzAnlieRMCaK4+nLoYwwQmAbHKitRhC
 JsdJrpNYnzVFnnoGKUsYPOijLw3juEr5g4BTOBov6qrCe1ch1FrrD/UK6QURCI/iPcpB
 EZn5XkitOPmMdjHA0vCBfpMois/3XphbL4Uh7jlAgJVRY10R8hE0ft/mMVlys8hhZNMO
 u1/lTAIMvu9rA/NkYNQsRY4z+t5MgSc8aeuQOKQWoGrHBW6OlmO845I5Gvt10kuKPYPg
 LjXpUwCqQzRXeWYMLP61x0ydXK5nPTi15MMw1NmY9t0i8q3zUU1xFdhKM1R2BI6W/pDi
 UIqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXJXQAnEqjig9MdPYoXj+Y3b+sO0VWCv7UhpJEdQgRQbntxtvB+6Z0cUElqV0YxURFWfzRhlXozpqH@nongnu.org
X-Gm-Message-State: AOJu0YwTDg7GT5gKg0xe7FQFym3WWqarmKcr9Cy2hTgIUGJsD8i6o2WZ
 mPGXtZ1shjqp5xkHJdAknqZH8Zw6E/lJ4RgNUjF8PYqdT6/AkFC4CRRtr9PcrOGOq58=
X-Gm-Gg: AY/fxX6LqC/ytY33yzbYAk50g0O0amWLMH0fUJBCS0IFyg9WuFKJ3h6HI0ESqfZjze1
 bQA2vdZCdfp8l14IxG9xcFGvEcrwMf+u8i7AWqvr6O9R/5f+TQDIVwyY7kvXblvyIuebNpOwd8F
 gsUTFDxUMsk20Y3et5isFMxORMAHktHjheBqmfZ3BuGjzRKiGeoeouOKG6ahWetej7EYwgKSg/+
 Pn9/Gce0vVvoxoDFgRd7WV2JKK3adwCcDUF+tT/uQPNhurjOLtUCV27CON8asgDOkSj2c3UjKXi
 No+BDsrRLUODmx15Z5oVQm6i3WH+GBUvI1rkD5swzuqad1q1Dm8nOvLJ/aTdg5NfTMo9nN7Dxii
 TVpYuH5ZF9N8R1Godsb6pHFeBcVLjoyGBH25UpGPBMmlIyd8FuOGDk2Mc4/xq2hAAuxdqDUpH61
 LxMeeMfveG5e7lxNtxUSRmxeElxmZwAT605ZKFLC7Q2tmDjwTn0Ii38Q==
X-Google-Smtp-Source: AGHT+IFnm7vnu4vjuCO7J4O7017IEg2ib1L5bgWFptXgCKaNNApuxg50VCieZGXhO7uDZlqxmB/KZg==
X-Received: by 2002:a05:600c:4ed4:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-47be29de6bamr4838925e9.15.1765998331111; 
 Wed, 17 Dec 2025 11:05:31 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3277a61sm1276125e9.12.2025.12.17.11.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 11:05:30 -0800 (PST)
Message-ID: <68c147b6-eecf-48ce-9da9-369885d6df9b@linaro.org>
Date: Wed, 17 Dec 2025 20:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/riscv: Define SiFive E/U CPUs using runtime
 conditions
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-13-d24a4048d3aa@rev.ng>
 <b1c5fa3e-f716-46f0-9ce1-1bdb8af18076@linaro.org>
Content-Language: en-US
In-Reply-To: <b1c5fa3e-f716-46f0-9ce1-1bdb8af18076@linaro.org>
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

On 17/12/25 16:13, Philippe Mathieu-Daudé wrote:
> On 17/12/25 00:51, Anton Johansson wrote:
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   include/hw/riscv/sifive_cpu.h | 26 +++++++++++++++++++-------
>>   hw/riscv/sifive_e.c           |  2 +-
>>   hw/riscv/sifive_u.c           |  4 ++--
>>   3 files changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/ 
>> sifive_cpu.h
>> index 136799633a..8391141d5e 100644
>> --- a/include/hw/riscv/sifive_cpu.h
>> +++ b/include/hw/riscv/sifive_cpu.h
>> @@ -20,12 +20,24 @@
>>   #ifndef HW_SIFIVE_CPU_H
>>   #define HW_SIFIVE_CPU_H
>> -#if defined(TARGET_RISCV32)
>> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
>> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
>> -#elif defined(TARGET_RISCV64)
>> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
>> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
>> -#endif
>> +#include "qemu/target-info.h"
>> +
>> +static inline const char *sifive_e_cpu(void)
>> +{
>> +    if (target_riscv64()) {
>> +        return TYPE_RISCV_CPU_SIFIVE_E51;
>> +    } else {
>> +        return TYPE_RISCV_CPU_SIFIVE_E31;
>> +    }
>> +}
>> +
>> +static inline const char *sifive_u_cpu(void)
>> +{
>> +    if (target_riscv64()) {
>> +        return TYPE_RISCV_CPU_SIFIVE_U54;
>> +    } else {
>> +        return TYPE_RISCV_CPU_SIFIVE_U34;
>> +    }
>> +}
>>   #endif /* HW_SIFIVE_CPU_H */
>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> index 7ed419cf69..458b21b9e3 100644
>> --- a/hw/riscv/sifive_e.c
>> +++ b/hw/riscv/sifive_e.c
>> @@ -151,7 +151,7 @@ static void 
>> sifive_e_machine_class_init(ObjectClass *oc, const void *data)
>>       mc->desc = "RISC-V Board compatible with SiFive E SDK";
>>       mc->init = sifive_e_machine_init;
>>       mc->max_cpus = 1;
>> -    mc->default_cpu_type = SIFIVE_E_CPU;
>> +    mc->default_cpu_type = sifive_e_cpu();
>>       mc->default_ram_id = "riscv.sifive.e.ram";
>>       mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
>> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> index 2ff2059bb9..a04481806e 100644
>> --- a/hw/riscv/sifive_u.c
>> +++ b/hw/riscv/sifive_u.c
>> @@ -723,7 +723,7 @@ static void 
>> sifive_u_machine_class_init(ObjectClass *oc, const void *data)
>>       mc->init = sifive_u_machine_init;
>>       mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 
>> SIFIVE_U_COMPUTE_CPU_COUNT;
>>       mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>> -    mc->default_cpu_type = SIFIVE_U_CPU;
>> +    mc->default_cpu_type = sifive_u_cpu();
>>       mc->default_cpus = mc->min_cpus;
>>       mc->default_ram_id = "riscv.sifive.u.ram";
>>       mc->auto_create_sdcard = true;
>> @@ -764,7 +764,7 @@ static void sifive_u_soc_instance_init(Object *obj)
>>                               TYPE_RISCV_HART_ARRAY);
>>       qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
>>       qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
>> -    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
>> +    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", 
>> sifive_e_cpu());
>>       qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
>>       object_initialize_child(obj, "u-cluster", &s->u_cluster, 
>> TYPE_CPU_CLUSTER);
>>
> 
> Just inline and remove the header. With that:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

If Alistair Acks the series and there is no other change requested,
I can address that cosmetic change myself, then no need to respin.
> 


