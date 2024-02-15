Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03935C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racV3-0002Lr-Ld; Thu, 15 Feb 2024 09:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1racUy-0002HH-Ay
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:14:00 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1racUv-00075Y-S1
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:14:00 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so704294a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708006436; x=1708611236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQPgdmNVNTph7kX5WBbCsPhSNY8S4N7EoDByPW7qJGY=;
 b=VxKK+Z1ezyXxs+W//tIcVPkwMI2VNWfUVlhM1FO60JoBde4e7xlhzvBIdEgza4dA21
 irOAm8pTHVePHHCg+5/ZyQ990DkUqw2MVaYov2PhjzqZ4Zo0KkvwdTGN68+z62fZFJkH
 /57giM7nykV8g23DbMQzYiBZCITgDePbNgS9iHNz11fLejoW4bIe3AG8j2y86YOcs/yu
 egFom997xiqBv9tf9tQVpypdWoEk0MiCUp//BQISjDLSlG6fkCxWhGs7pfArAtD2mPpw
 RPrGI24S1G8UPHsVtMlBGHlQAeyui9frA2G5l8rMd18ssGDWvlWImdhgEpknDnZQETmP
 lq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006436; x=1708611236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQPgdmNVNTph7kX5WBbCsPhSNY8S4N7EoDByPW7qJGY=;
 b=oFNbkp2plyEdPsnHHLgTQmIHht9f+o+dT+TGrhmaiIJgKWp/CInlRXLbm70F1r2cBN
 otgLhH0J4ZjJP2jP1O7B0pF3gsB59VO++jWS8lQEz5tNkC6ah09NwFpCnM26GUwNIHwg
 9jewdFAEICOOgDBDgWX9CrBuugRVz3N3f0SWUeKwBLEfIYA7+uwhYq5ZUwjQtXKFeKCL
 WOVgF3UsfCku0k0xop2bl5c8UsyqkRxT/HqNyQxmjJKVjGLlsCC0gtAVawi4UsMtIvxS
 vawOSrdxWdI02VXyyhNgs4MuDtEjA9I5yJSyiMODeFfvEMA2SCXGydaHRW8a9tp+5xGb
 s5Uw==
X-Gm-Message-State: AOJu0YzCIHVpU62UfaJCUpQsc4P+pldA26OhJGDVlRUtT5ZU36NqmLj/
 82sERj8T+r1Ta4xmGdN5nqCGPr0+lgn9IaIEumGEn6cYMAn01mWF77W43j4WPbo=
X-Google-Smtp-Source: AGHT+IGOxzeFe5lB+RFvqM2ewW+nwVGw6j1cdRAfh9gpyH6Acfgoqg8ZqZzQdLeLpxtww/6Mdg0Alg==
X-Received: by 2002:a05:6a20:c704:b0:19e:3a9f:f925 with SMTP id
 hi4-20020a056a20c70400b0019e3a9ff925mr2135714pzb.14.1708006436207; 
 Thu, 15 Feb 2024 06:13:56 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a62d443000000b006da19433468sm1416076pfl.61.2024.02.15.06.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:13:55 -0800 (PST)
Message-ID: <cb84b02b-eb4b-43e9-82e5-2367ee2a2789@ventanamicro.com>
Date: Thu, 15 Feb 2024 11:13:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
 <20240215-alkaline-saturday-275cd8e3aa39@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240215-alkaline-saturday-275cd8e3aa39@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52f.google.com
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



On 2/15/24 10:33, Conor Dooley wrote:
> On Fri, Feb 02, 2024 at 12:21:51PM -0300, Daniel Henrique Barboza wrote:
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
> 
> Why does an "rva22s64" cpu have "zicclsm" in it? Isn't zicclsm only
> present in "u" profiles?

According to the specs I've read  it seems  the S profiles includes all extensions
from U profiles. For RVA22:

"The RVA22S64 mandatory unprivileged extensions include all the mandatory
unprivileged extensions in RVA22U64."

So rva22s64 will have zicclsm and all other extensions from its U profile too.


> 
>>   # cat /proc/device-tree/cpus/cpu@0/riscv,isa
>> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
>> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
>> zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
> 
> I want to raise my frustration with the crock we've been given here by
> RVI. Any "named feature" that just creates a name for something that
> already is assumed is completely useless, and DT property that is used
> to communicate it's presence cannot be used - instead the property needs
> to be inverted - indicating the absence of that named feature.

Let's say that I'm not the biggest fan of how these profile extensions are being
dealt with in the spec :) the text is vague w.r.t whether zicclsm and others
are actual extensions, or a 'named feature'( like we're calling here in QEMU)
that is just a glorified way of saying, for example, "zic64b" instead of "all
cache blocks have 64 bytes".


Thanks,

Daniel

> 
> Without the inversion, software that parses "riscv,isa" cannot make any
> determination based on the absence of the property - it could be parsing
> an old DT that does not have the property or it could be parsing the DT
> of a system that does not support the extension.
> 
> This is part of why I deprecated `riscv,isa`. It's the same problem as
> with "zifencei" et al - does a system with `riscv,isa = "rv64imac"`
> support fence.i?
> 
> Cheers,
> Conor.
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++-------
>>   target/riscv/cpu_cfg.h     |  6 ++++++
>>   target/riscv/tcg/tcg-cpu.c |  2 ++
>>   3 files changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 28d3cfa8ce..94843c4f6e 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -101,6 +101,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
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
>> @@ -109,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
>>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>>       ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
>> @@ -170,8 +175,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
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
>> @@ -1512,6 +1521,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
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
>> @@ -1523,6 +1537,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
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
>> @@ -2116,13 +2147,10 @@ static const PropertyInfo prop_marchid = {
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
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index 698f926ab1..c5049ec664 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -126,6 +126,12 @@ struct RISCVCPUConfig {
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
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 90861cc065..673097c6e4 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -1347,6 +1347,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
>>       RISCVCPU *cpu = RISCV_CPU(cs);
>>       Object *obj = OBJECT(cpu);
>>   
>> +    cpu->cfg.ext_always_enabled = true;
>> +
>>       misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
>>       multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
>>       riscv_cpu_add_user_properties(obj);
>> -- 
>> 2.43.0
>>
>>

