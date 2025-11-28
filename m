Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78B4D116F3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 11:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOwwm-0008CR-Qp; Fri, 28 Nov 2025 06:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOwwj-0008Bb-9n
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 06:47:30 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOwwg-0002bW-Vj
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 06:47:29 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-29845b06dd2so23871935ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 03:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764330445; x=1764935245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1vmyIN7BttCD9LD8DeTSl4HVvhuksFzvDWuxJyd+D7s=;
 b=WeHV9h+yz4fLFqANVe+cjcdznS4ItGEpzpwNjQWNIWaFc+DeZKXjTj/K39lV89G7nB
 1Vq/ulHoMsUmPoA3Pi7bGW+GKNhQe5D08iDuTWqh+Yyk8E9250eWJVXfMdYyvxU0hfnO
 v2UW2cZt/4imovwxZOUCMko5LQnkQyMeBY9rpKhpZeDN1eEaLwaBvg3fq/Y7bnI8ZoTh
 UVygaqGH7Nvq+XncvWTMfYNxuK7m20eIeVTM6iicIS7nb2limRXsrTTRnB6PlwcLYnHy
 pEIlmjXI/O3pQGdehjQuC7VfQAnSEF3rpBhJTFZFWHe8zgQFi2+ObjFy0jwYX+pxIevm
 keXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764330445; x=1764935245;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1vmyIN7BttCD9LD8DeTSl4HVvhuksFzvDWuxJyd+D7s=;
 b=UPrUJipDqGZPMY8QlvDkO0wCUWF6SyM9Zt/4ucshyfZ/6uernlFokR9H0G2Zp6ae7c
 SzkQ6vpCB5DgrsztwympeMnURVdINOZbcZ6yeyRf0W88KtWktOtJE8fVKd+u1Yt+r/4N
 L38O3VBe/S+iCViH54rsuOmqZSW+2Uak2nTv11NCMyhR5cCaGi0ThyTKGffrjR/vhbgg
 Ki1J9b3+OkLvGiW3fPzKYsQwWzbpyMzlt39KlvS0IPoKDJSGiiA2ZIzEpe2WVb6STByt
 pYo7YF4vU3dfoctIbjVSnHbh84Qvr+wd33FUUQAkQt0pqMURT7X9/N5R4n2vv4NzN2Cw
 zPMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxS/0oYCMch3TWeQC2NIzpeT7lmY0zMC/irRMQtmymPiQoUW8lUrG7bRzIUEGLeALNuz/YUq2ABRv0@nongnu.org
X-Gm-Message-State: AOJu0YwG75DGTUbdhwxjrQac44Njh0fV6HMPkSu0OZumAq+7iYNczMOT
 JU78pkpam1MJ3DgcotLQxCUMdjFk44v6gFZNtPmWOGegsrCk7Su0KgODYmESLuKcy2M=
X-Gm-Gg: ASbGncumc5a4kfbbTPaeY7HHKO22fLGxgpiAfwkGH6DXEmnhFvrx+oAIRkVP3EbEUUp
 +ksoVNu5mFqyT1VR6V1n+ueATZhPBAzCJnqJKgL2WB956DjYLzff+YamafdIEM2ljv+ShvO2XGT
 NcRYbMqAPE90+J+1YeamUMVEIGWQGA7rRRcTDnTU6+2fMWqM4lZ6WahmAcJeMr2zgGw6/UoY5Ep
 KxSYwqWRNS+S47ZKyhQ0ODEsqbg+ek305p5kaR+5QwmiS8M79Ci8o2Ks0EmJ0vUdY8cOSYxOP9O
 Ea6kzLd8ttFvUCNu+5C40U5/O2NO4A2MHmvj/HkMxuuyt7whTpMypdPEL43ppMfwMqkPJkOoXk2
 6RGB/5bfuIPkyv7D1+w0dJEuSvyQz56s7RkkmDPq8EV4PwYHSrZrjUkyPO0otPoh0aMhwnf6J/l
 p1dKYeKN95u8WA83U5BOldggQcKw==
X-Google-Smtp-Source: AGHT+IEwwaWjrEWXhecEu7E2V8zr7SyV1fRNRFOxcLwzvMkFyDJ46VRAQBZOg12VufBHwo8wiSQBVA==
X-Received: by 2002:a17:902:f547:b0:295:557e:747e with SMTP id
 d9443c01a7336-29b6c69233emr270396625ad.40.1764330444813; 
 Fri, 28 Nov 2025 03:47:24 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bceb7cf89sm44094015ad.99.2025.11.28.03.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 03:47:24 -0800 (PST)
Message-ID: <c29ad506-5c5a-4bd3-816f-ce1617e38fbb@ventanamicro.com>
Date: Fri, 28 Nov 2025 08:47:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Add 'debug_ver' to set version of debug
 specification
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?WXVtaW5nIFl1LU1pbmcgQ2hhbmco5by16IKy6YqYKQ==?=
 <yumin686@andestech.com>
References: <20251126071258.4132239-1-alvinga@andestech.com>
 <20251126071258.4132239-2-alvinga@andestech.com>
 <641f8940-968f-423e-86af-c0faed18ff43@ventanamicro.com>
 <SEYPR03MB67009F0B6E81F45D55D6605BA8DEA@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <SEYPR03MB67009F0B6E81F45D55D6605BA8DEA@SEYPR03MB6700.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 11/26/25 11:20 AM, Alvin Che-Chia Chang(張哲嘉) wrote:
> Hi Daniel,
> 
>> -----Original Message-----
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Sent: Wednesday, November 26, 2025 7:38 PM
>> To: Alvin Che-Chia Chang(張哲嘉) <alvinga@andestech.com>;
>> qemu-riscv@nongnu.org; qemu-devel@nongnu.org
>> Cc: alistair.francis@wdc.com; bin.meng@windriver.com;
>> liwei1518@gmail.com; zhiwei_liu@linux.alibaba.com; Yuming Yu-Ming
>> Chang(張育銘) <yumin686@andestech.com>
>> Subject: Re: [PATCH 1/2] target/riscv: Add 'debug_ver' to set version of debug
>> specification
>>
>> [EXTERNAL MAIL]
>>
>> Hi,
>>
>>
>> There are 2 points I would like to bring here. First is the addition of a new
>> string property.
>>
>> Although it's not forbidden, and in fact we have string properties in RISC-V CPU
>> code (which I'll be dealing with in the next QEMU cycle), we would like to
>> avoid adding new str props. The reason is that str props are harder to work with
>> in management layers (e.g. libvirt) and to expose in QMP.
>>
>> I suggest using booleans instead. They are way easier to work with in the upper
>> layers and we don't have to maintain string parsing code as well. Instead of
>> adding a 'debug_ver' string prop and parse values, add two bool properties:
>> debug-0.13 and debug-1.0.
> 
> Using two bool properties instead of string properties is okay to us.
> Thank you for guiding us this concern.
> 
>>
>> Second, we have a 'debug' flag that is set to default 'true'. From what I'm
>> reading in this patch the existing flag would be equivalent to 'debug-0.13'
>> I proposed above. In this case we can keep the existing flag and add a single
>> 'debug-1.0' flag to indicate that the user wants to use v1.0 instead of v0.13.
> 
> I would prefer renaming existing 'debug' flag to 'debug-v0.13' and adding new flag 'debug-v1.0' in order not to confuse users.
> How should we handle the situation if user provides both debug-v0.13=true,debug-v1.0=true ?
> Should we throw an error or treat this situation as if only debug-v1.0=true ?

What you did in v2 works for me. The handling of both 'debug' and 'debug-1.0' is
mostly a backend decision that we're free to make, as long as we're having
common sense in how the flag disable/enable features.

As for renaming/removing existing flags and properties, we can't rename/delete
existing stuff unless we go through a deprecation cycle (add the flags in
deprecated.rst, flag is removed one year later). We do this because there
are existing users and apps that can be compromised when we delete/change
options from the command line.


Thanks,

Daniel

> 
> 
> Sincerely,
> Alvin Chang
> 
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>
>> On 11/26/25 4:12 AM, Alvin Chang wrote:
>>> The similar control did in 'priv_spec' and 'vext_spec' now is
>>> available for version of debug specification. Currently we accept
>>> "v0.13" and "v1.0" versions. Users can provide 'debug_spec' into CPU
>>> option to set intended version of the debug specification.
>>>
>>> For examples:
>>> 1. -cpu max,debug_spec=v0.13
>>> 2. -cpu max,debug_spec=v1.0
>>>
>>> Signed-off-by: Alvin Chang <alvinga@andestech.com>
>>> Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
>>> ---
>>>    target/riscv/cpu.c         | 69
>> ++++++++++++++++++++++++++++++++++++++
>>>    target/riscv/cpu.h         | 13 +++++++
>>>    target/riscv/machine.c     |  5 +--
>>>    target/riscv/tcg/tcg-cpu.c |  3 ++
>>>    4 files changed, 88 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c index
>>> 73d4280..dbcdfcd 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -1123,6 +1123,7 @@ static void riscv_cpu_init(Object *obj)
>>>        cpu->cfg.pmp_regions = 16;
>>>        cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
>>>        cpu->env.vext_ver = VEXT_VERSION_1_00_0;
>>> +    cpu->env.debug_ver = DEBUG_VERSION_0_13_0;
>>>        cpu->cfg.max_satp_mode = -1;
>>>
>>>        if (mcc->def->profile) {
>>> @@ -1138,6 +1139,9 @@ static void riscv_cpu_init(Object *obj)
>>>        if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
>>>            cpu->env.vext_ver = mcc->def->vext_spec;
>>>        }
>>> +    if (mcc->def->debug_spec != RISCV_PROFILE_ATTR_UNUSED) {
>>> +        cpu->env.debug_ver = mcc->def->debug_spec;
>>> +    }
>>>    #ifndef CONFIG_USER_ONLY
>>>        if (mcc->def->custom_csrs) {
>>>            riscv_register_custom_csrs(cpu, mcc->def->custom_csrs); @@
>>> -1720,6 +1724,66 @@ static const PropertyInfo prop_priv_spec = {
>>>        .set = prop_priv_spec_set,
>>>    };
>>>
>>> +static int debug_spec_from_str(const char *debug_spec_str) {
>>> +    int debug_version = -1;
>>> +
>>> +    if (!g_strcmp0(debug_spec_str, DEBUG_VER_0_13_0_STR)) {
>>> +        debug_version = DEBUG_VERSION_0_13_0;
>>> +    } else if (!g_strcmp0(debug_spec_str, DEBUG_VER_1_00_0_STR)) {
>>> +        debug_version = DEBUG_VERSION_1_00_0;
>>> +    }
>>> +
>>> +    return debug_version;
>>> +}
>>> +
>>> +static const char *debug_spec_to_str(int debug_version) {
>>> +    switch (debug_version) {
>>> +    case DEBUG_VERSION_0_13_0:
>>> +        return DEBUG_VER_0_13_0_STR;
>>> +    case DEBUG_VERSION_1_00_0:
>>> +        return DEBUG_VER_1_00_0_STR;
>>> +    default:
>>> +        return NULL;
>>> +    }
>>> +}
>>> +
>>> +static void prop_debug_spec_set(Object *obj, Visitor *v, const char *name,
>>> +                                void *opaque, Error **errp) {
>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>> +    g_autofree char *value = NULL;
>>> +    int debug_version = -1;
>>> +
>>> +    visit_type_str(v, name, &value, errp);
>>> +
>>> +    debug_version = debug_spec_from_str(value);
>>> +    if (debug_version < 0) {
>>> +        error_setg(errp, "Unsupported debug spec version '%s'", value);
>>> +        return;
>>> +    }
>>> +
>>> +    cpu_option_add_user_setting(name, debug_version);
>>> +    cpu->env.debug_ver = debug_version; }
>>> +
>>> +static void prop_debug_spec_get(Object *obj, Visitor *v, const char *name,
>>> +                                void *opaque, Error **errp) {
>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>> +    const char *value = debug_spec_to_str(cpu->env.debug_ver);
>>> +
>>> +    visit_type_str(v, name, (char **)&value, errp); }
>>> +
>>> +static const PropertyInfo prop_debug_spec = {
>>> +    .type = "str",
>>> +    .description = "debug_spec",
>>> +    .get = prop_debug_spec_get,
>>> +    .set = prop_debug_spec_set,
>>> +};
>>> +
>>>    static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
>>>                                   void *opaque, Error **errp)
>>>    {
>>> @@ -2648,6 +2712,7 @@ static const Property riscv_cpu_properties[] = {
>>>
>>>        {.name = "priv_spec", .info = &prop_priv_spec},
>>>        {.name = "vext_spec", .info = &prop_vext_spec},
>>> +    {.name = "debug_spec", .info = &prop_debug_spec},
>>>
>>>        {.name = "vlen", .info = &prop_vlen},
>>>        {.name = "elen", .info = &prop_elen}, @@ -2818,6 +2883,10 @@
>>> static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>>>                assert(def->vext_spec != 0);
>>>                mcc->def->vext_spec = def->vext_spec;
>>>            }
>>> +        if (def->debug_spec != RISCV_PROFILE_ATTR_UNUSED) {
>>> +            assert(def->debug_spec <= DEBUG_VERSION_LATEST);
>>> +            mcc->def->debug_spec = def->debug_spec;
>>> +        }
>>>            mcc->def->misa_ext |= def->misa_ext;
>>>
>>>            riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg); diff --git
>>> a/target/riscv/cpu.h b/target/riscv/cpu.h index 36e7f10..fc1ae7c
>>> 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -100,6 +100,7 @@ typedef struct riscv_cpu_profile {
>>>        bool present;
>>>        bool user_set;
>>>        int priv_spec;
>>> +    int debug_spec;
>>>        int satp_mode;
>>>        const int32_t ext_offsets[];
>>>    } RISCVCPUProfile;
>>> @@ -123,6 +124,16 @@ enum {
>>>        PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
>>>    };
>>>
>>> +/* Debug specification version */
>>> +#define DEBUG_VER_0_13_0_STR "v0.13"
>>> +#define DEBUG_VER_1_00_0_STR "v1.0"
>>> +enum {
>>> +    DEBUG_VERSION_0_13_0 = 0,
>>> +    DEBUG_VERSION_1_00_0,
>>> +
>>> +    DEBUG_VERSION_LATEST = DEBUG_VERSION_1_00_0, };
>>> +
>>>    #define VEXT_VERSION_1_00_0 0x00010000
>>>    #define VEXT_VER_1_00_0_STR "v1.0"
>>>
>>> @@ -245,6 +256,7 @@ struct CPUArchState {
>>>
>>>        target_ulong priv_ver;
>>>        target_ulong vext_ver;
>>> +    target_ulong debug_ver;
>>>
>>>        /* RISCVMXL, but uint32_t for vmstate migration */
>>>        uint32_t misa_mxl;      /* current mxl */
>>> @@ -563,6 +575,7 @@ typedef struct RISCVCPUDef {
>>>        uint32_t misa_ext;
>>>        int priv_spec;
>>>        int32_t vext_spec;
>>> +    int debug_spec;
>>>        RISCVCPUConfig cfg;
>>>        bool bare;
>>>        const RISCVCSR *custom_csrs;
>>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c index
>>> 18d790a..8658f55 100644
>>> --- a/target/riscv/machine.c
>>> +++ b/target/riscv/machine.c
>>> @@ -427,8 +427,8 @@ static const VMStateDescription vmstate_sstc = {
>>>
>>>    const VMStateDescription vmstate_riscv_cpu = {
>>>        .name = "cpu",
>>> -    .version_id = 10,
>>> -    .minimum_version_id = 10,
>>> +    .version_id = 11,
>>> +    .minimum_version_id = 11,
>>>        .post_load = riscv_cpu_post_load,
>>>        .fields = (const VMStateField[]) {
>>>            VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32), @@ -443,6
>>> +443,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>>            VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
>>>            VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
>>>            VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
>>> +        VMSTATE_UINTTL(env.debug_ver, RISCVCPU),
>>>            VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
>>>            VMSTATE_UINT32(env.misa_ext, RISCVCPU),
>>>            VMSTATE_UNUSED(4),
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index d396825..160fcf1 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -1598,6 +1598,9 @@ static void riscv_init_max_cpu_extensions(Object
>> *obj)
>>>        /* set vector version */
>>>        env->vext_ver = VEXT_VERSION_1_00_0;
>>>
>>> +    /* Set debug version */
>>> +    env->debug_ver = DEBUG_VERSION_0_13_0;
>>> +
>>>        /* Zfinx is not compatible with F. Disable it */
>>>        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);
>>>        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);
> 
> CONFIDENTIALITY NOTICE:
> 
> This e-mail (and its attachments) may contain confidential and legally privileged information or information protected from disclosure. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information contained herein is strictly prohibited. In this case, please immediately notify the sender by return e-mail, delete the message (and any accompanying documents) and destroy all printed hard copies. Thank you for your cooperation.
> 
> Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.


