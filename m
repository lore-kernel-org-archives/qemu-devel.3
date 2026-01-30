Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AE1D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhlk-0004mt-UB; Fri, 30 Jan 2026 01:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhli-0004l9-Gs
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:14:10 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhlf-0002oq-Mp
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:14:10 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8230c839409so1551291b3a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 22:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769753646; x=1770358446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybpPiDen6kRYEuGGyCXm8wFh6a3vF4xJphhTtncrlow=;
 b=bn1wcstT9WgPFQw3Joo/APP63jJxTAo/YxVq6XakP6s4AfyFRv7N6zS5W4KbRdqjNT
 FOTvnPTIoYVIpViKnSfnevZkLo27n0q7OEgesPTn+0Qia72qgDWekTSAiKtWwJFlWiPx
 kBq2IdGNLRYyfr+VqWwTcpluL01eHBgDBOpuODMXNOY0lEYx9DHwcNXrLv7I8xvyiz2p
 109kxSessERqVMQBl+8huFwEVOc2nmdIkdEOca4NYcUUJG9v04MgHgTfssn/5dYrItMB
 62YI28fVsV5rD6ufHbkGYl8HH5FqTDRbJa4/yEF1pk/JUMBIt+GClkwNWOdckCMaCkwf
 XKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769753646; x=1770358446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ybpPiDen6kRYEuGGyCXm8wFh6a3vF4xJphhTtncrlow=;
 b=UjDjeXMqynDnSr7gZWWS/BAsuATrHKPXq/YfKSgGgwqHfNn7qj4L3g10gQc0yBLOBt
 ldQELpRG8PItRvPolTwjW6u1A4uCRZz6RrX7+Csyfll09RUCFgwKEZaydsd7zEFmEn5K
 nPW2yyvTmuF6jzN1+YZ3SNzKx0h8JnO9q2ynlt2cR5szKcKnVCnm1vQ+qRBFMu0yn4cE
 bc27e7q56I2vjAb3xHrehuC0/WorNb1vhAIlpqN5elNT21N/yvRo2KHogWJZpT7c2Tid
 TlNdSupifaixVI6//7yaPgPCCkvGOiYD8iGazzcNSJwfqbsMKf5ArJ6iqBQBxdwSiTXY
 urqg==
X-Gm-Message-State: AOJu0YxfUu+4p0X45VJei26GDNufIcc3I7UOLUN0h+w9D1ZaI3laoG+w
 Ic6NgMQThO86UyHOZyCHhwmaHXpdMKJbXZILU74yXIl+m3JsFs7H25Eb
X-Gm-Gg: AZuq6aJ7se1nEREVO+wCBBRb+s4+AbSmuxr6uYe6w2hrfbM0BYrzgdHGmzLimurQIsJ
 btxjlYHpNNaKMcXMANYNoWo3IJK22qmN/h5t2Hr0lq66/+QoL0lpvoYdEiV/TlXwU95fi6/ESUg
 V9rZIItr5yWcpe0vOOaVCmkx66rI4u1S8KRSQ9xQvlknufrQosX2cJccuwfmHKdAIuV540+f2I7
 T3Fje60TvmdYs1UKwy5nKT5x/SGlApafUi/5Amz3d6wHJYG1BjpxaSBNyvcuuR1AJA4fLoldBm2
 weWNgQknJAQnycalsnMbg2H+G42SkNScBdD0KQu8R3AsGjz6hqBdM/oMpIPSa5quBpnS9RQsZAG
 DleB7Q9pqTuuxpuNURpJzZPMSejI9CplGaUqBrpKdINs2pL6HQvqF4+MraMSIn8ujACoq5Xw76v
 2+xcfFudUbw7Sjj+bRQnT4j3q06tM3GzWBOGSHjPWgKdYgfBEvG52mG2RHZ62caNWc7aU2Gw==
X-Received: by 2002:a05:6a00:8d87:b0:81e:ce07:7f3d with SMTP id
 d2e1a72fcca58-823ab6a04e7mr1947626b3a.31.1769753645777; 
 Thu, 29 Jan 2026 22:14:05 -0800 (PST)
Received: from [127.0.0.1] ([61.173.116.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b57fafsm7604596b3a.26.2026.01.29.22.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 22:14:05 -0800 (PST)
Message-ID: <a951ffca-9df6-4eef-8a9c-bd0e842564f6@gmail.com>
Date: Fri, 30 Jan 2026 14:14:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/7] target/riscv: add sdext debug CSRs state
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769517768.git.chao.liu.zevorn@gmail.com>
 <2d69ba8204da7d3e6f8700f0c41b72d01c9a6d26.1769517768.git.chao.liu.zevorn@gmail.com>
 <b4c0b660-7a06-4b09-9a6e-6e984d54de6c@ventanamicro.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <b4c0b660-7a06-4b09-9a6e-6e984d54de6c@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


Hi Daniel,

On 1/29/2026 3:42 AM, Daniel Henrique Barboza wrote:
> 
> 
> On 1/27/2026 10:15 AM, Chao Liu wrote:
>> RISC-V Debug Specification:
>> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
>>
>> Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
>> and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
>> them to Debug Mode (or host debugger access).
>>
>> The Sdext is not fully implemented, so it is disabled by default.
>>
>> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> ---
>>   target/riscv/cpu.c                |  10 +++
>>   target/riscv/cpu.h                |   4 +
>>   target/riscv/cpu_bits.h           |  33 ++++++++
>>   target/riscv/cpu_cfg_fields.h.inc |   1 +
>>   target/riscv/csr.c                | 126 ++++++++++++++++++++++++++++++
>>   target/riscv/machine.c            |  20 +++++
>>   6 files changed, 194 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 0ba98a62e4..ba8fd1557a 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -209,6 +209,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>> +    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
>>       ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>>       ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>>       ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>> @@ -779,6 +780,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType
>> type)
>>       /* Default NaN value: sign bit clear, frac msb set */
>>       set_float_default_nan_pattern(0b01000000, &env->fp_status);
>>       env->vill = true;
>> +    env->debug_mode = false;
>> +    env->dcsr = DCSR_DEBUGVER(4);
>> +    env->dpc = 0;
>> +    env->dscratch[0] = 0;
>> +    env->dscratch[1] = 0;
>>     #ifndef CONFIG_USER_ONLY
>>       if (cpu->cfg.ext_sdtrig) {
>> @@ -1131,6 +1137,9 @@ static void riscv_cpu_init(Object *obj)
>>        */
>>       cpu->cfg.ext_sdtrig = true;
>>   +    /* sdext is not fully implemented, so it is disabled by default. */
>> +    cpu->cfg.ext_sdext = false;
>> +
>>       if (mcc->def->profile) {
>>           mcc->def->profile->enabled = true;
>>       }
>> @@ -1245,6 +1254,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>       MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>>       MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>>       MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
>> +    MULTI_EXT_CFG_BOOL("sdext", ext_sdext, false),
>>       MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
>>       MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
>>       MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 5c6824f2d3..a474494dff 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -476,6 +476,10 @@ struct CPUArchState {
>>         /* True if in debugger mode.  */
>>       bool debugger;
>> +    bool debug_mode;
>> +    target_ulong dcsr;
>> +    target_ulong dpc;
>> +    target_ulong dscratch[2];
> 
> This patch (and I believe almost every single other patch that follows) won't
> build in the linux-user target. It will throw errors like this:
> 
> ../target/riscv/cpu_helper.c: In function ‘riscv_cpu_enter_debug_mode’:  
> ../target/riscv/cpu_helper.c:154:8: error: ‘CPURISCVState’ {aka ‘struct
> CPUArchState’} has no member named ‘debug_mode’       154 | env->debug_mode =
> true;                                              |        ^~  
>                    ../target/riscv/cpu_helper.c:155:10: error:
> ‘CPURISCVState’ {aka ‘struct CPUArchState’} has no member named ‘dpc’; did you
> mean ‘pc’?                                                               155 |
> env->dpc = pc & get_xepc_mask(env);                                             
> |          ^~~
> 
> 
> The reason is that the flags you're declaring up above exist only in the system
> emulation mode. If you double check target/riscv/cpu.h you'll notice that the
> flags you're adding are inside a big ifdef around line 270:
> 
> #ifndef CONFIG_USER_ONLY
>     /* This contains QEMU specific information about the virt state. */
> 
> 
> So debug_mode, dscr, dpc and dscratch aren't available for user mode. Note that
> this is correct - user mode can't deal with sdext or any other debug trigger
> extension. But you'll have to gate all logic that uses those flags in #ifndef
> CONFIG_USER_ONLY blocks.
> 
> 
> For example, in patch 3:
> 
> 
> +void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
> +                                uint32_t cause)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (!riscv_sdext_enabled(env)) {
> +        return;
> +    }
> +#endif
> +    env->debug_mode = true;
> +    env->dpc = pc & get_xepc_mask(env);
> +    env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
> +    env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
> +    env->dcsr |= env->priv & DCSR_PRV_MASK;
> +    if (env->virt_enabled && riscv_has_ext(env, RVH)) {
> +        env->dcsr |= DCSR_V;
> +    }
> +#ifndef CONFIG_USER_ONLY
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        if (env->elp) {
> +            env->dcsr |= DCSR_PELP;
> +        } else {
> +            env->dcsr &= ~DCSR_PELP;
> +        }
> +        env->elp = false;
> +    }
> +#endif
> 
> 
> We want the whole function body inside an "#ifndef CONFIG_USER_ONLY" because
> everything being done is unavailable in that mode.
> 
> You can use the build target 'riscv64-linux-user' to build qemu-riscv64 (i.e.
> user mode) to check if the patches will break it by accident. I usually build
> all riscv targets to catch this type of build errors:
> 
> 
> ./configure --target-list=riscv64-softmmu,riscv64-linux-user,riscv32-
> softmmu,riscv32-linux-user  (...)
> 
> 
Thanks for catching this! You're right - I missed the linux-user build
target entirely.

I'll fix this in v4 by moving debug_mode/dcsr/dpc/dscratch fields inside
the #ifndef CONFIG_USER_ONLY block in cpu.h, and wrapping all code using
these fields with proper guards.

Thanks,
Chao
> 
> Thanks,
> Daniel
> 
> 
> 
> 
>>         uint64_t mstateen[SMSTATEEN_MAX_COUNT];
>>       uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index b62dd82fe7..bb59f7ff56 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -467,6 +467,39 @@
>>   #define CSR_DCSR            0x7b0
>>   #define CSR_DPC             0x7b1
>>   #define CSR_DSCRATCH        0x7b2
>> +#define CSR_DSCRATCH1       0x7b3
>> +
>> +/* DCSR fields */
>> +#define DCSR_XDEBUGVER_SHIFT    28
>> +#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
>> +#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
>> +#define DCSR_EXTCAUSE_SHIFT     24
>> +#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
>> +#define DCSR_CETRIG             BIT(19)
>> +#define DCSR_PELP               BIT(18)
>> +#define DCSR_EBREAKVS           BIT(17)
>> +#define DCSR_EBREAKVU           BIT(16)
>> +#define DCSR_EBREAKM            BIT(15)
>> +#define DCSR_EBREAKS            BIT(13)
>> +#define DCSR_EBREAKU            BIT(12)
>> +#define DCSR_STEPIE             BIT(11)
>> +#define DCSR_STOPCOUNT          BIT(10)
>> +#define DCSR_STOPTIME           BIT(9)
>> +#define DCSR_CAUSE_SHIFT        6
>> +#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
>> +#define DCSR_V                  BIT(5)
>> +#define DCSR_MPRVEN             BIT(4)
>> +#define DCSR_NMIP               BIT(3)
>> +#define DCSR_STEP               BIT(2)
>> +#define DCSR_PRV_MASK           0x3u
>> +
>> +#define DCSR_CAUSE_EBREAK       1
>> +#define DCSR_CAUSE_TRIGGER      2
>> +#define DCSR_CAUSE_HALTREQ      3
>> +#define DCSR_CAUSE_STEP         4
>> +#define DCSR_CAUSE_RESET        5
>> +#define DCSR_CAUSE_GROUP        6
>> +#define DCSR_CAUSE_OTHER        7
>>     /* Performance Counters */
>>   #define CSR_MHPMCOUNTER3    0xb03
>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/
>> cpu_cfg_fields.h.inc
>> index 492fdd1553..4b157ac920 100644
>> --- a/target/riscv/cpu_cfg_fields.h.inc
>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>> @@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
>>   BOOL_FIELD(ext_zimop)
>>   BOOL_FIELD(ext_zcmop)
>>   BOOL_FIELD(ext_ztso)
>> +BOOL_FIELD(ext_sdext)
>>   BOOL_FIELD(ext_sdtrig)
>>   BOOL_FIELD(ext_smstateen)
>>   BOOL_FIELD(ext_sstc)
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 870fad87ac..3e38c943e0 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -3136,6 +3136,126 @@ static RISCVException write_mtval(CPURISCVState *env,
>> int csrno,
>>       return RISCV_EXCP_NONE;
>>   }
>>   +#if !defined(CONFIG_USER_ONLY)
>> +static RISCVException sdext(CPURISCVState *env, int csrno)
>> +{
>> +    if (!riscv_cpu_cfg(env)->ext_sdext) {
>> +        return RISCV_EXCP_ILLEGAL_INST;
>> +    }
>> +
>> +    if (!env->debug_mode && !env->debugger) {
>> +        return RISCV_EXCP_ILLEGAL_INST;
>> +    }
>> +
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static target_ulong dcsr_visible_mask(CPURISCVState *env)
>> +{
>> +    target_ulong mask = (target_ulong)-1;
>> +    RISCVCPU *cpu = env_archcpu(env);
>> +
>> +    if (!riscv_has_ext(env, RVH)) {
>> +        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
>> +    }
>> +    if (!riscv_has_ext(env, RVS)) {
>> +        mask &= ~DCSR_EBREAKS;
>> +    }
>> +    if (!riscv_has_ext(env, RVU)) {
>> +        mask &= ~DCSR_EBREAKU;
>> +    }
>> +    if (!cpu->cfg.ext_zicfilp) {
>> +        mask &= ~DCSR_PELP;
>> +    }
>> +    if (!cpu->cfg.ext_smdbltrp) {
>> +        mask &= ~DCSR_CETRIG;
>> +    }
>> +
>> +    return mask;
>> +}
>> +
>> +static RISCVException read_dcsr(CPURISCVState *env, int csrno,
>> +                                target_ulong *val)
>> +{
>> +    *val = env->dcsr & dcsr_visible_mask(env);
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static target_ulong dcsr_writable_mask(CPURISCVState *env)
>> +{
>> +    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
>> +                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
>> +                        DCSR_STEP | DCSR_PRV_MASK;
>> +    RISCVCPU *cpu = env_archcpu(env);
>> +
>> +    mask |= DCSR_MPRVEN;
>> +
>> +    if (riscv_has_ext(env, RVH)) {
>> +        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
>> +    }
>> +    if (riscv_has_ext(env, RVS)) {
>> +        mask |= DCSR_EBREAKS;
>> +    }
>> +    if (riscv_has_ext(env, RVU)) {
>> +        mask |= DCSR_EBREAKU;
>> +    }
>> +    if (cpu->cfg.ext_zicfilp) {
>> +        mask |= DCSR_PELP;
>> +    }
>> +    if (cpu->cfg.ext_smdbltrp) {
>> +        mask |= DCSR_CETRIG;
>> +    }
>> +
>> +    return mask;
>> +}
>> +
>> +static RISCVException write_dcsr(CPURISCVState *env, int csrno,
>> +                                 target_ulong val, uintptr_t ra)
>> +{
>> +    target_ulong mask = dcsr_writable_mask(env);
>> +    target_ulong new_val = env->dcsr;
>> +
>> +    new_val &= ~mask;
>> +    new_val |= val & mask;
>> +    new_val &= ~DCSR_XDEBUGVER_MASK;
>> +    new_val |= DCSR_DEBUGVER(4);
>> +    env->dcsr = new_val;
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException read_dpc(CPURISCVState *env, int csrno,
>> +                               target_ulong *val)
>> +{
>> +    *val = env->dpc & get_xepc_mask(env);
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException write_dpc(CPURISCVState *env, int csrno,
>> +                                target_ulong val, uintptr_t ra)
>> +{
>> +    env->dpc = val & get_xepc_mask(env);
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException read_dscratch(CPURISCVState *env, int csrno,
>> +                                    target_ulong *val)
>> +{
>> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
>> +
>> +    *val = env->dscratch[index];
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException write_dscratch(CPURISCVState *env, int csrno,
>> +                                     target_ulong val, uintptr_t ra)
>> +{
>> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
>> +
>> +    env->dscratch[index] = val;
>> +    return RISCV_EXCP_NONE;
>> +}
>> +#endif /* !CONFIG_USER_ONLY */
>> +
>>   /* Execution environment configuration setup */
>>   static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>>                                      target_ulong *val)
>> @@ -6297,6 +6417,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>>       [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
>>       [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
>>       [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
>> +#if !defined(CONFIG_USER_ONLY)
>> +    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
>> +    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
>> +    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
>> +    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
>> +#endif
>>         [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL,
>> rmw_xctrctl    },
>>       [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL,
>> rmw_xctrctl    },
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index 62c51c8033..52264cf047 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -248,6 +248,25 @@ static const VMStateDescription vmstate_sdtrig = {
>>           VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
>>           VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
>>           VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
>> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_sdext = {
>> +    .name = "cpu/sdext",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = sdtrig_needed,
>> +    .post_load = sdtrig_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
>> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> @@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           &vmstate_ctr,
>>           &vmstate_sstc,
>>           &vmstate_sdtrig,
>> +        &vmstate_sdext,
>>           NULL
>>       }
>>   };
> 


