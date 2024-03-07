Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFDAC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCh0-0003Bw-TY; Thu, 07 Mar 2024 07:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1riCgz-0003BD-EZ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:17:45 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1riCgx-0000wp-1f
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:17:45 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 83A1848A9A
 for <qemu-devel@nongnu.org>; Thu,  7 Mar 2024 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709813859;
 bh=CMrxPE3sAVl+Ls4JsI4p4I9wXXaLt7gTl6yql2ZGE3c=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=QfVenOkunc/Cvhg87EgKG71AW390n2NZ1OXotuuO1f8bQ98skPHhP7eowSThAImsb
 i3V1rAnty8MK1LqeFIRxC9W3/luJKK6bsxVMDnqZhe6gfPArFFZ8Cl9bWAIhG2HvAX
 P1PrKhdE4DU6cgqJ7GdMUOq7jue/ooK8tngXAyKRqTDmIL4M7S8fyasA4JsFVJCeQm
 VrbHHOZxsCUAQaz/Zq0GPsryIXUTC3f6flY3q4NrLSQ0y0yTCpg62fBmbmRWfd/XpV
 eKkc/3DdDXbhiFKZS3TuJvIyLfihTSjNawPgELLYMgYGx+OAa15+eCmmDfzp6ukkH7
 9eZvv2s6O/FFQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e41caf403so358357f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709813858; x=1710418658;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CMrxPE3sAVl+Ls4JsI4p4I9wXXaLt7gTl6yql2ZGE3c=;
 b=B5N8LJDeI7bzR7n6Gco93+p9/govwAU03tcWD/x+qqoWRMiXlGEXR3xDzXju9Z8JKY
 z5CBz1Z+4MhnpH1y/gKq/N+3dalaJIlCcPYll85AiQKOud7193ExLQlwKoe70nFa0MeN
 HJCpgP8YoSn2sG08JEDTnTdX0eyRKI3MYG7/dUuKS2ytb+blkkn7G7c04xa12jM8eM2S
 /4ovryYVqasbPN5iDoLMZ86WEew0b+AMi2wh75R41OqoZBxIpUHfNTWPDH5gMBVMiP1h
 JJNajJLx7voAi4wiI0ljVe/EAzymu+n8cplTiccJuSZ7+2/+UR1k3iqDtKxn6BlLYwfY
 Vz6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzEepy9/dDPXX6zgRZXdsie69c4HOXIC04ZblkkNOHyoXNkjEY6ay0w/mtnYz6qZFyvHHu4Sur6uSw4bIpv4R7NgDR5CM=
X-Gm-Message-State: AOJu0YxKB7rsnQdyuZz0ga4/mmqUOdJjFW8sX0Xl4IJDbdorv0LDjvi8
 MT0b9Q+QyhI4uYr5QFmfJtL44GZSE62Y6HKq91NqpY77aSz7OuXMYY1D5dP0+mZwaGHBiwL/XZu
 kU2UUIiAB/z5AiKiqW0jlp42PPuI1n6qweBbczbnb4LB0Zmj91CARStDXKCjRd7P43nIg
X-Received: by 2002:a5d:4150:0:b0:33e:164d:c8c3 with SMTP id
 c16-20020a5d4150000000b0033e164dc8c3mr12380876wrq.31.1709813857982; 
 Thu, 07 Mar 2024 04:17:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7a/BSo+xMVnRwZoahkwRCi4QG/Xvf05eNIu1pH/KDvjGgMkVai/ztH8ep384xbD6Cr93xKg==
X-Received: by 2002:a5d:4150:0:b0:33e:164d:c8c3 with SMTP id
 c16-20020a5d4150000000b0033e164dc8c3mr12380841wrq.31.1709813857527; 
 Thu, 07 Mar 2024 04:17:37 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:772a:3a92:e643:5788?
 ([2a00:20:9:393f:772a:3a92:e643:5788])
 by smtp.gmail.com with ESMTPSA id
 w17-20020adfec51000000b0033cf60e268fsm20133348wrn.116.2024.03.07.04.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 04:17:36 -0800 (PST)
Message-ID: <95e45995-fb10-4c68-9937-fd9f7e032bf1@canonical.com>
Date: Thu, 7 Mar 2024 13:17:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-platform] [RISC-V][tech-server-soc] [RFC
 2/2] target/riscv: Add server platform reference cpu
To: "Wu, Fei2" <fei2.wu@intel.com>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-3-fei2.wu@intel.com>
 <bd34501b-3dda-40eb-aa92-73ea289297d1@ventanamicro.com>
 <8ad091f3-c00f-4786-a89b-799304eace73@intel.com>
 <56448108-c655-4684-bab9-b8d7747f79f7@intel.com>
 <4e16f394-fe9b-4edf-80eb-fc3220bcf6e1@intel.com>
Content-Language: en-US
Cc: tech-server-soc@lists.riscv.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <4e16f394-fe9b-4edf-80eb-fc3220bcf6e1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07.03.24 08:36, Wu, Fei2 wrote:
> On 3/6/2024 9:26 PM, Wu, Fei wrote:
>> On 3/5/2024 1:58 PM, Wu, Fei wrote:
>>> On 3/5/2024 3:43 AM, Daniel Henrique Barboza wrote:
>>>>
>>>>
>>>> On 3/4/24 07:25, Fei Wu wrote:
>>>>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>>>>> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
>>>>> a virt CPU type (rvsp-ref) as compliant as possible.
>>>>>
>>>>> [1]
>>>>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>>>>
>>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>>> --->   hw/riscv/server_platform_ref.c |  6 +++-
>>>>>    target/riscv/cpu-qom.h         |  1 +
>>>>>    target/riscv/cpu.c             | 62 ++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 68 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/riscv/server_platform_ref.c
>>>>> b/hw/riscv/server_platform_ref.c
>>>>> index ae90c4b27a..52ec607cee 100644
>>>>> --- a/hw/riscv/server_platform_ref.c
>>>>> +++ b/hw/riscv/server_platform_ref.c
>>>>> @@ -1205,11 +1205,15 @@ static void
>>>>> rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>>>>    {
>>>>>        char str[128];
>>>>>        MachineClass *mc = MACHINE_CLASS(oc);
>>>>> +    static const char * const valid_cpu_types[] = {
>>>>> +        TYPE_RISCV_CPU_RVSP_REF,
>>>>> +    };
>>>>>          mc->desc = "RISC-V Server SoC Reference board";
>>>>>        mc->init = rvsp_ref_machine_init;
>>>>>        mc->max_cpus = RVSP_CPUS_MAX;
>>>>> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>>>>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>>>>> +    mc->valid_cpu_types = valid_cpu_types;
>>>>
>>>> I suggest introducing this patch first, then the new machine type that
>>>> will use it as a default
>>>> CPU. The reason is to facilitate future bisects. If we introduce the
>>>> board first, a future bisect
>>>> might hit the previous patch, the board will be run using RV64 instead
>>>> of the correct CPU, and
>>>> we'll have different results because of it.
>>>>
>>> Good suggestion.
>>>
>>>>>        mc->pci_allow_0_address = true;
>>>>>        mc->default_nic = "e1000e";
>>>>>        mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>>>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>>>> index 3670cfe6d9..adb934d19e 100644
>>>>> --- a/target/riscv/cpu-qom.h
>>>>> +++ b/target/riscv/cpu-qom.h
>>>>> @@ -49,6 +49,7 @@
>>>>>    #define TYPE_RISCV_CPU_SIFIVE_U54
>>>>> RISCV_CPU_TYPE_NAME("sifive-u54")
>>>>>    #define TYPE_RISCV_CPU_THEAD_C906
>>>>> RISCV_CPU_TYPE_NAME("thead-c906")
>>>>>    #define TYPE_RISCV_CPU_VEYRON_V1
>>>>> RISCV_CPU_TYPE_NAME("veyron-v1")
>>>>> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>>>>>    #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>>>>>      OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>> index 5ff0192c52..bc91be702b 100644
>>>>> --- a/target/riscv/cpu.c
>>>>> +++ b/target/riscv/cpu.c
>>>>> @@ -2282,6 +2282,67 @@ static void rva22s64_profile_cpu_init(Object *obj)
>>>>>          RVA22S64.enabled = true;
>>>>>    }
>>>>> +
>>>>> +static void rv64_rvsp_ref_cpu_init(Object *obj)
>>>>> +{
>>>>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>>>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>>>> +
>>>>> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
>>>>> +
>>>>> +    /* FIXME: change to 1.13 */
>>>>> +    env->priv_ver = PRIV_VERSION_1_12_0;
>>>>> +
>>>>> +    /* RVA22U64 */
>>>>> +    cpu->cfg.mmu = true;
>>>>> +    cpu->cfg.ext_zifencei = true;
>>>>> +    cpu->cfg.ext_zicsr = true;
>>>>> +    cpu->cfg.ext_zicntr = true;
>>>>> +    cpu->cfg.ext_zihpm = true;
>>>>> +    cpu->cfg.ext_zihintpause = true;
>>>>> +    cpu->cfg.ext_zba = true;
>>>>> +    cpu->cfg.ext_zbb = true;
>>>>> +    cpu->cfg.ext_zbs = true;
>>>>> +    cpu->cfg.zic64b = true;
>>>>> +    cpu->cfg.ext_zicbom = true;
>>>>> +    cpu->cfg.ext_zicbop = true;
>>>>> +    cpu->cfg.ext_zicboz = true;
>>>>> +    cpu->cfg.cbom_blocksize = 64;
>>>>> +    cpu->cfg.cbop_blocksize = 64;
>>>>> +    cpu->cfg.cboz_blocksize = 64;
>>>>> +    cpu->cfg.ext_zfhmin = true;
>>>>> +    cpu->cfg.ext_zkt = true;
>>>>
>>>> You can change this whole block with:
>>>>
>>>> RVA22U64.enabled = true;
>>>>
>>>>
>>>> riscv_cpu_add_profiles() will check if we have a profile enabled and, if
>>>> that's the
>>>> case, we'll enable all its extensions in the CPU.
>>>>
>>>> In the near future, when we implement a proper RVA23 support, we'll be
>>>> able to just do
>>>> a single RVA23S64.enabled = true in this cpu_init(). But for now we can
>>>> at least declare
>>>> RVA22U64 (perhaps RVA22S64) support for this CPU.
>>>>
>>
>> Hi Daniel,
>>
>> I'm not sure if it's a regression or the usage has been changed. I'm not
>> able to use '-cpu rva22s64' on latest qemu (db596ae190).
>>
> I did a quick git bisect and found that commit d06f28db6 "target/riscv:
> move 'mmu' to riscv_cpu_properties[]" disabled mmu by default, so that
> an explicit mmu option should be added to qemu command line like '-cpu
> rva22s64,mmu=true', I think rva22s64 should enable it by default.
> 
> Thanks,
> Fei.

It is nice that the MMU can be disabled. But is there any reason why the 
MMU should be disabled by default on the virt machine (which typically 
is used to run an operating system)?

Can we add mmu=true as default to the rv64 CPU?

Best regards

Heinrich

