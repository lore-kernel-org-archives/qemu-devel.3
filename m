Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1EFC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 19:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7g2Q-0005NG-5B; Wed, 23 Apr 2025 15:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7g2N-0005Ml-Ur
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:45:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7g2L-0001F2-Eo
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 15:45:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso147972b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745437534; x=1746042334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1x2XXU6HyrQO/CrcNvsBVXdueGe/bg1VZLdlryJ27So=;
 b=WokbZCJ6Oo1HMtUALLgmG0GGs/5ui3Hdf/uTIsuJ5YZ9QhTRMq1hAbx85ftVxm/oA4
 PfRaQHYGnzbE6HhtDfwL+l2hqpL4+0ZNM7jYyEvTX9nwHer7qwUBWk+f319Ai338WEnF
 MnMtTSpsPMjsxp4KNGHC7BCS+ZICTNrroiwGOCUQlFGu5BD3s1s6gQBpF2T1QjVjJeGK
 KPCW8LnPmgPdLESySg1fuIlm5BTBH8ZlMszCTS6/7Rb8efRQSKCQ/yi9CHUImLZjuJuU
 35SQQeyg8eltq0TYcZvp70zqIVQUua5t9sfK/RXDUsuvyOpUs2qBYbrXR2IlJ+K4Dlgz
 OJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745437534; x=1746042334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1x2XXU6HyrQO/CrcNvsBVXdueGe/bg1VZLdlryJ27So=;
 b=fz0/PRvkix5WOtSic1gtYadR4GjNah/ia9H2MEx1yMIJov6ugMAZafVRdqeAG3evRA
 TcrQs1XZr7IdZotNYLi15Fonpgs/s+kGWJ2BruOqhB80pYiXzmRtvemQb5TGm/E64kbv
 zgMSYmvm+12SJlPudaL8zjnucL06sQ06bSP0Ng4wna0rHFIG2gRpWYf+1lSRmMQjyfGz
 xdujF1j1KUH9SBaL19VRyiNnaUaB9iYwdKFFnTZ8e5GmHWeaJtpMmzUdZmSN8rl+cttB
 h3NAaor7ILmojcqD6sDE/CLMMJDQBj5KgOfp0Jtqieu3I0kFsJOtPYZ0pb2V/80e1zu6
 3e3Q==
X-Gm-Message-State: AOJu0Yy/9bOqTBYXQ0/jPqwXtYd+eoI9hu58TsBTtDs0v4bN3/mcV3Mw
 YsoWOOBYPrDJRPmdsWZ+/3m7HRfi/Bas16EjgwCOjINyDz9lZ9RZUvAgpsAV6Og=
X-Gm-Gg: ASbGncsLRf5ZJWwUcjX8IDhymxP2KfQUNqmjasGDhMPu2Zas5NsADziInJSvKrQ2u4P
 MDuHEeEtN4yvZxPORARU7zChm0ba4ie/yU+1VfAs9D4KYDouDq58KHyLjlihrpCOtO8pO492JM9
 y66YvskVxjaydZ0Q63Q7LmCW8uPR8KDWBcstm5Ib+QzEna3vSM/vTwSUkMdvbtfdJGJJwp9CwVR
 QNk3ANWMpxScG6QiuRAl/ejzR7xkyeix7NnU+AyxfPZybN6kDK9FTr0RasktUXfq3mrtAdRb+8/
 uiNjYcU0d7ARxfqor31Vv1Oa6MQeCRSCvTz9LlFWKayNzESeoXkjHYY=
X-Google-Smtp-Source: AGHT+IG8JqVWxVGvLmHbDcXm8d33VsoFKH9624F9+oKlq67JhjSKRXrfJKe9CHwumGHVuW7s+DeMCA==
X-Received: by 2002:a05:6a20:9f07:b0:1f5:8e33:c417 with SMTP id
 adf61e73a8af0-203cbc25fe7mr33070795637.2.1745437534086; 
 Wed, 23 Apr 2025 12:45:34 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db14488casm9441855a12.56.2025.04.23.12.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 12:45:33 -0700 (PDT)
Message-ID: <6f1cfe50-3261-4121-8b5b-6f69456f1257@ventanamicro.com>
Date: Wed, 23 Apr 2025 16:45:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/riscv/kvm: add kvm_csr_cfgs[]
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 abologna@redhat.com
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
 <20250417124839.1870494-5-dbarboza@ventanamicro.com>
 <20250423-9623c5901480c9e7be10d9e5@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250423-9623c5901480c9e7be10d9e5@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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



On 4/23/25 12:15 PM, Andrew Jones wrote:
> On Thu, Apr 17, 2025 at 09:48:36AM -0300, Daniel Henrique Barboza wrote:
>> At this moment we're not checking if the host has support for any
>> specific CSR before doing get/put regs. This will cause problems if the
>> host KVM doesn't support it (see [1] as an example).
>>
>> We'll use the same approach done with the CPU extensions: read all known
>> KVM CSRs during init() to check for availability, then read/write them
>> if they are present. This will be made by either using get-reglist or by
>> directly reading the CSRs.
>>
>> For now we'll just convert the CSRs to use a kvm_csr_cfg[] array,
>> reusing the same KVMCPUConfig abstraction we use for extensions, and use
>> the array in (get|put)_csr_regs() instead of manually listing them. A
>> lot of boilerplate will be added but at least we'll automate the get/put
>> procedure for CSRs, i.e. adding a new CSR in the future will be a matter
>> of adding it in kvm_csr_regs[] and everything else will be taken care
>> of.
>>
>> Despite all the code changes no behavioral change is made.
>>
>> [1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.h         |   1 +
>>   target/riscv/kvm/kvm-cpu.c | 119 ++++++++++++++++++++++++++-----------
>>   2 files changed, 84 insertions(+), 36 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 51e49e03de..7a56666f9a 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -79,6 +79,7 @@ const char *riscv_get_misa_ext_name(uint32_t bit);
>>   const char *riscv_get_misa_ext_description(uint32_t bit);
>>   
>>   #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
>> +#define ENV_CSR_OFFSET(_csr) offsetof(CPURISCVState, _csr)
>>   
>>   typedef struct riscv_cpu_profile {
>>       struct riscv_cpu_profile *u_parent;
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 0bcadab977..99a4f01b15 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -114,22 +114,6 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
>>       KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
>>                              KVM_REG_RISCV_VECTOR_CSR_REG(name))
>>   
>> -#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
>> -    do { \
>> -        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
>> -        if (_ret) { \
>> -            return _ret; \
>> -        } \
>> -    } while (0)
>> -
>> -#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
>> -    do { \
>> -        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
>> -        if (_ret) { \
>> -            return _ret; \
>> -        } \
>> -    } while (0)
>> -
>>   #define KVM_RISCV_GET_TIMER(cs, name, reg) \
>>       do { \
>>           int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
>> @@ -150,6 +134,7 @@ typedef struct KVMCPUConfig {
>>       const char *name;
>>       const char *description;
>>       target_ulong offset;
>> +    uint32_t prop_size;
>>       uint64_t kvm_reg_id;
>>       bool user_set;
>>       bool supported;
>> @@ -251,6 +236,54 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
>>       }
>>   }
>>   
>> +#define KVM_CSR_CFG(_name, _env_prop, _env_prop_size, reg_id) \
>> +    {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
>> +     .prop_size = _env_prop_size, .kvm_reg_id = reg_id}
>> +
>> +static KVMCPUConfig kvm_csr_cfgs[] = {
>> +    KVM_CSR_CFG("sstatus", mstatus, sizeof(uint64_t), RISCV_CSR_REG(sstatus)),
>> +    KVM_CSR_CFG("sie", mie, sizeof(uint64_t), RISCV_CSR_REG(sie)),
>> +    KVM_CSR_CFG("stvec", stvec, sizeof(target_ulong), RISCV_CSR_REG(stvec)),
>> +    KVM_CSR_CFG("sscratch", sscratch, sizeof(target_ulong),
>> +                RISCV_CSR_REG(sscratch)),
>> +    KVM_CSR_CFG("sepc", sepc, sizeof(target_ulong), RISCV_CSR_REG(sepc)),
>> +    KVM_CSR_CFG("scause", scause, sizeof(target_ulong), RISCV_CSR_REG(scause)),
>> +    KVM_CSR_CFG("stval", stval, sizeof(target_ulong), RISCV_CSR_REG(stval)),
>> +    KVM_CSR_CFG("sip", mip, sizeof(uint64_t), RISCV_CSR_REG(sip)),
>> +    KVM_CSR_CFG("satp", satp, sizeof(target_ulong), RISCV_CSR_REG(satp)),
> 
> We don't need to pass in sizeof(env_prop). We can just define KVM_CSR_CFG
> to do it for us.
> 
>   #define KVM_CSR_CFG(_name, csr, reg_id) \
>       { .name = _name, .offset = ENV_CSR_OFFSET(csr), \
>         .prop_size = sizeof(((CPURISCVState *)0)->csr), \
>         .kvm_reg_id = reg_id, }
> 
> But I don't think we need it at all. See below.
> 
>> +};
>> +
>> +static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
>> +{
>> +    return (void *)&cpu->env + csr_cfg->offset;
>> +}
>> +
>> +static uint64_t kvm_cpu_csr_get_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
> 
> This should return a uint32_t.
> 
>> +{
>> +    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
>> +    return *val32;
>> +}
>> +
>> +static uint64_t kvm_cpu_csr_get_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
>> +{
>> +    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
>> +    return *val64;
>> +}
>> +
>> +static void kvm_cpu_csr_set_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
>> +                                uint32_t val)
>> +{
>> +    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
>> +    *val32 = val;
>> +}
>> +
>> +static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
>> +                                uint64_t val)
>> +{
>> +    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
>> +    *val64 = val;
>> +}
>> +
>>   #define KVM_EXT_CFG(_name, _prop, _reg_id) \
>>       {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
>>        .kvm_reg_id = _reg_id}
>> @@ -598,34 +631,48 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>>   
>>   static int kvm_riscv_get_regs_csr(CPUState *cs)
>>   {
>> -    CPURISCVState *env = &RISCV_CPU(cs)->env;
>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>> +    uint64_t reg;
>> +    int i, ret;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>> +        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>>   
>> -    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
>> -    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
>> -    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
>> -    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
>> -    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
>> -    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
>> -    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
>> -    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
>> -    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
>> +        ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +
>> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
> 
>   if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
>       kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
>   } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
>       kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
>   } else {
>       uh, oh...
>   }

The idea with this logic is to handle the cases where there is a mismatch
between the size of the KVM reg and the size of the flag we're using to
store it. All CSR regs are of size target_ulong but not all CPURISCVState
flags we're using are target_ulong. We're not storing the size of the KVM
CSR, we're storing the flag size.

E.g:

KVM_CSR_CFG("sstatus", mstatus, sizeof(uint64_t), RISCV_CSR_REG(sstatus)),

For a 32 bit CPU we're writing a 32 bit ulong sstatus into the 64 bit mstatus
field. If we assume that they're the same size we'll be read/writing a 32 bit val
inside a 64 bit field, i.e. we'll be reading/writing the upper words only.

In theory this would be ok if we always read/write the same way but it can be
a nuisance when trying to debug the value inside CPURISCVState.

One may argue whether we should change the type of these fields to match what
Linux/ISA expect of them. Not sure how much work that is.


scounteren is a more serious case because we're writing an ulong KVM reg into
a 32 bit field:

     KVM_CSR_CFG("scounteren", scounteren, sizeof(uint32_t),
                 RISCV_CSR_REG(scounteren)),

struct CPUArchState {
     target_ulong gpr[32];
     (...)
     uint32_t scounteren;
     uint32_t mcounteren;
     (...)


Perhaps it's a good idea to change this CPURISCVState field to ulong before
adding support for the scouteren KVM CSR.


Thanks,

Daniel


> 
>> +            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
>> +        } else {
>> +            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
>> +        }
>> +    }
>>   
>>       return 0;
>>   }
>>   
>>   static int kvm_riscv_put_regs_csr(CPUState *cs)
>>   {
>> -    CPURISCVState *env = &RISCV_CPU(cs)->env;
>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>> +    uint64_t reg;
>> +    int i, ret;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>> +        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>> +
>> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
>> +            reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
>> +        } else {
>> +            reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
>> +        }
> 
> same comment as above
> 
>>   
>> -    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
>> -    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
>> -    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
>> -    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
>> -    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
>> -    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
>> -    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
>> -    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
>> -    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
>> +        ret = kvm_set_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +    }
>>   
>>       return 0;
>>   }
>> -- 
>> 2.49.0
>>
>>
> 
> Thanks,
> drew


