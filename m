Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CBDC54E60
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgoA-0001uf-FK; Mon, 11 Mar 2024 10:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgo2-0001sT-0e
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:39:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgnz-0002bg-Dt
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:39:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dd81aee2b4so18128095ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710167946; x=1710772746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aLT3eKYjViMeboH5gpq2UwA6yadMigpcaNRH+Nfa5Wk=;
 b=LyRw6hCCRKejUhE9UYVCfX6G6QI4sDlU6VKCaPvRUVYqBKJ5+fVp7ELEY1VSHTcP9R
 wZGHDeXkty4lUlqD/GL1PPOPms1xhu+CNmqmZB0TKtuy0KEDq/KIRvUJu6cC7fAtw25E
 Z5d0JXolbmUmT/o4s30gR6d3UNbZR5B8dp6XTME2sxb6LLDiM31uG8l67cYwoMUU6vo8
 +MTe1WpN8WS8xJeb/WttCW5JFQrnwY3j5bgwUhCOHM+f/w1Q4jPra2oYcxCpiy0pRndI
 tF4qgdQGagDwTu3iJVYXauZoQrWNpt1VztnrkNJMppRTm+Q8q+8Qzz+squvx+f3brt+H
 CKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710167946; x=1710772746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aLT3eKYjViMeboH5gpq2UwA6yadMigpcaNRH+Nfa5Wk=;
 b=hJe/nvRqncGFll3CAljwQJOGsW1yqJDeKKD58HmOUiUf6Nd/54PjIA9kbLw06G2Fbx
 IvPZp/9Mp21UYSLXQ+YZUsTgZV8p0xiHVt2SA9Ty1ul8IvBiREZqq1G4lwHAf0yw5o5/
 kagBLzPaz9SStF8miZFIDMDAbWI14tWJb5KaDKhkt31tTM3gmC/kh9skCWv6lnKaYc1a
 LQuTKnh/8v6QP+xWwV1wz7E3Fvtktw76pOKTdLLDOMbdAhXurrstsSulC6ETYsYhFKt3
 o6xLWXwyjFFPbyPb2Po/BtSxfPtdS2MB0kdX5D6OBZY6tIVqIF1+pV9TGupbZhBoQXhG
 +4rA==
X-Gm-Message-State: AOJu0YxWMG/tNgRZh05yrim2NKVG1hLvjFlKLER1cu1cesStahalTScw
 UYlYivfV/VWJlqkaVLgxTe5Bni7y5VyP3cmGUuDSzjbxb1qRVJlqXRiMdP1xB0I/SUuWoc4X74p
 S
X-Google-Smtp-Source: AGHT+IEHcs38HaO8ZzMbHWGbkTOc37BorhlblmI+2jVcNgteMJjA/qkH3bTxCw0DZsaZZcVcluGrEw==
X-Received: by 2002:a17:903:1c9:b0:1db:ceb0:2022 with SMTP id
 e9-20020a17090301c900b001dbceb02022mr11005116plh.27.1710167945760; 
 Mon, 11 Mar 2024 07:39:05 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a170903125100b001db5fc51d71sm4823967plh.160.2024.03.11.07.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 07:39:05 -0700 (PDT)
Message-ID: <4d5bfb3d-d646-45bb-b8ec-300c14415d33@ventanamicro.com>
Date: Mon, 11 Mar 2024 11:39:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/34] target/riscv: add remaining named features
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
 <20240308111152.2856137-10-alistair.francis@wdc.com>
 <CAJ307EiYcXiiTKeZMgWYQNkZ2McOOOJYYGUMh1-CnuNoy7M0Gg@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAJ307EiYcXiiTKeZMgWYQNkZ2McOOOJYYGUMh1-CnuNoy7M0Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 3/11/24 10:47, Clément Chigot wrote:
> Hi Alistair,
> 
> Since this series, I'm getting warnings when using a CPU not
> supporting the latest ISA, such as the SIFIVE_E series.
>    | $ qemu-system-riscv32  -M sifive_e
>    | qemu-system-riscv32: warning: disabling zic64b extension for hart
> 0x00000000 because privilege spec version does not match
>    | qemu-system-riscv32: warning: disabling ziccamoa extension for
> hart 0x00000000 because privilege spec version does not match
> 
> Those are always enabled during the initialization but
> riscv_cpu_disable_priv_spec_isa_exts is detecting them as unsupported
> by the CPU and thus disabling them.
> However, are those extensions different from zicnptr and zihpm
> extensions ? As they are not enabled by the same mean, I'm wondering
> about that ? Or do we want to skip their ISA verification as well ?

Disabling zihpm and zicntr will impact the CPU because we'll remove timers from
the emulation. An exception was important in this case to not change existing
behavior.

Disabling 'zic64b' and 'ziccamoa' will only impact riscv,isa. We won't change
any cache block size when disabling zic64ba and 'ziccamoa' does nothing
because it's cache related and we do not implement cache.

All this said, I'm less than pleased with these warnings. And they'll be getting
worse and worse: priv_spec 1.13 is around the corner, we'll start adding profile
extensions that will be marked as 1.13, some of them will be mapped to something
that we already support, and then vendor CPUs will be getting more and more
warnings because they'll be running an old priv_spec.

My suggestion is to not send user warnings when disabling extensions for vendor
CPUs. Vendor CPUs don't allow extensions to be enabled, so if an extension is
violating priv_spec it's not the user fault. We can add a LOG_GUEST_ERROR when
disabling exts but user warnings will only be shown for non-vendor CPUs.


Thanks,

Daniel



> 
> Thanks,
> Clément
> 
> On Fri, Mar 8, 2024 at 12:13 PM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
>> until now, we were implying that they were available.
>>
>> We can't do this anymore since named features also has a riscv,isa
>> entry. Let's add them to riscv_cpu_named_features[].
>>
>> Instead of adding one bool for each named feature that we'll always
>> implement, i.e. can't be turned off, add a 'ext_always_enabled' bool in
>> cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
>> named features will point to it. This also means that KVM won't see
>> these features as always enable, which is our intention.
>>
>> If any accelerator adds support to disable one of these features, we'll
>> have to promote them to regular extensions and allow users to disable it
>> via command line.
>>
>> After this patch, here's the riscv,isa from a buildroot using the
>> 'rva22s64' CPU:
>>
>>   # cat /proc/device-tree/cpus/cpu@0/riscv,isa
>> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
>> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
>> zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Message-ID: <20240215223955.969568-4-dbarboza@ventanamicro.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/cpu_cfg.h     |  6 ++++++
>>   target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
>>   target/riscv/tcg/tcg-cpu.c |  2 ++
>>   3 files changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index e68a4ddb92..be39870691 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -128,6 +128,12 @@ struct RISCVCPUConfig {
>>       bool ext_svade;
>>       bool ext_zic64b;
>>
>> +    /*
>> +     * Always 'true' boolean for named features
>> +     * TCG always implement/can't be disabled.
>> +     */
>> +    bool ext_always_enabled;
>> +
>>       /* Vendor-specific custom extensions */
>>       bool ext_xtheadba;
>>       bool ext_xtheadbb;
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index f0cd408237..4c4fa79145 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -102,6 +102,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>>       ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>>       ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
>> +    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_always_enabled),
>> +    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_always_enabled),
>> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled),
>> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled),
>>       ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>>       ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>>       ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
>> @@ -110,6 +114,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
>>       ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>>       ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>> @@ -173,8 +178,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled),
>>       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_enabled),
>>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled),
>> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled),
>>       ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>>       ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>> @@ -1567,6 +1576,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>
>> +#define ALWAYS_ENABLED_FEATURE(_name) \
>> +    {.name = _name, \
>> +     .offset = CPU_CFG_OFFSET(ext_always_enabled), \
>> +     .enabled = true}
>> +
>>   /*
>>    * 'Named features' is the name we give to extensions that we
>>    * don't want to expose to users. They are either immutable
>> @@ -1578,6 +1592,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
>>       MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
>>       MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>>
>> +    /*
>> +     * cache-related extensions that are always enabled
>> +     * in TCG since QEMU RISC-V does not have a cache
>> +     * model.
>> +     */
>> +    ALWAYS_ENABLED_FEATURE("za64rs"),
>> +    ALWAYS_ENABLED_FEATURE("ziccif"),
>> +    ALWAYS_ENABLED_FEATURE("ziccrse"),
>> +    ALWAYS_ENABLED_FEATURE("ziccamoa"),
>> +    ALWAYS_ENABLED_FEATURE("zicclsm"),
>> +    ALWAYS_ENABLED_FEATURE("ssccptr"),
>> +
>> +    /* Other named features that TCG always implements */
>> +    ALWAYS_ENABLED_FEATURE("sstvecd"),
>> +    ALWAYS_ENABLED_FEATURE("sstvala"),
>> +    ALWAYS_ENABLED_FEATURE("sscounterenw"),
>> +
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>
>> @@ -2171,13 +2202,10 @@ static const PropertyInfo prop_marchid = {
>>   };
>>
>>   /*
>> - * RVA22U64 defines some 'named features' or 'synthetic extensions'
>> - * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
>> - * and Zicclsm. We do not implement caching in QEMU so we'll consider
>> - * all these named features as always enabled.
>> - *
>> - * There's no riscv,isa update for them (nor for zic64b, despite it
>> - * having a cfg offset) at this moment.
>> + * RVA22U64 defines some 'named features' that are cache
>> + * related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
>> + * and Zicclsm. They are always implemented in TCG and
>> + * doesn't need to be manually enabled by the profile.
>>    */
>>   static RISCVCPUProfile RVA22U64 = {
>>       .parent = NULL,
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 2307999387..ea763abb31 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -1315,6 +1315,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
>>       RISCVCPU *cpu = RISCV_CPU(cs);
>>       Object *obj = OBJECT(cpu);
>>
>> +    cpu->cfg.ext_always_enabled = true;
>> +
>>       misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
>>       multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
>>       riscv_cpu_add_user_properties(obj);
>> --
>> 2.44.0
>>
>>

