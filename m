Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AC0C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9iMu-0005ok-0i; Tue, 29 Apr 2025 06:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9iMr-0005oO-3o
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:39:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9iMo-0008Do-BG
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:39:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33e5013aso68805215ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745923148; x=1746527948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mX0gkXHGLlLQRmIkMaRRFU+x9lRowO7aLqDiYuJ/0u4=;
 b=FYbQz53vT/lDIlDwDTPV1jejwj4eJVnJIMyyRvD9xBBynotRghuWw9oarTF8nqVwxO
 DcgX6lZEswVcG+GbftkAJGuKX4m/sDXjbtOb36kUm0MurpOUUs3hJgZwYQatw1V1ZRAJ
 AJj4/hRfUd1Db7L9H9oleesUMzLSb/HyIUum2+BaujzzEndx1WkPhGC8NZVQlGLfn7Vq
 GE7JvVwyppXTA3IzGSNxj593G0bPft8mYEhwL9gGpIX5KfmhmhRdZviXg7J63J6u0Gll
 R4LZUbsqS4Z6xwB26VCeaRgfQBhn+Y35xJ2nIDK2ldEW5N5au1SwSHr5YulLn6KDjmLg
 Vhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745923148; x=1746527948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mX0gkXHGLlLQRmIkMaRRFU+x9lRowO7aLqDiYuJ/0u4=;
 b=H7M6I0ps5BP3X/kQitzKUZnOZ6VLwWF3euV2wpqANEaMwixUjJBDW/f1apTBhh0Iob
 DSC00Sjha+ydhcW1CfBA1OjsybPKgv2zB+AH4jLwPrsMtdK1Z7L1A0j2QyaxwYj9gTUP
 Uindcnhi1lgqG0Q/EF8qM56+F6I4rOzLsj56VC769w7p2X0ngWXzuminwm5hm/y6ZM7G
 vC48ObxKQ9Qlva89x/TRQ5kA2EGOIozFrccGXzL/9AnumVZIGpCareleepk3ZLMg1/ky
 BIVL8NxbfQ1QZNIRQrh1cqL33IwGx5SLYTB7NgexzRj7geDFvfz+3raX0EEk8NhnvHPx
 GMSQ==
X-Gm-Message-State: AOJu0YzeNhnUq1wLlhRRkKKn30GdPwnTec6zvcC636EER/I3LD9bMPfo
 axCJs/C4EW+XE8dtZdtsfWS/oTTRIG9WIDyPSFDXSSNEkmdjRkFJA7YrH5ZgCAw=
X-Gm-Gg: ASbGncs45XhKkVO4uAKcjcLoND24pF4lmY/q5NDtIK9Zz+oYBXUtE4ueacNMqpql3yj
 eRjrM83ENG9h9iIvFkvm6BMQ4CuHFb0XYkM4xdLZVVWaRT74ysjQK35BKK8+Okn6RVH3V5O+S/E
 3PuTrrAJAHDRBuAO19+k/o6KpPqTzdljTEQwyXs2Kdwr8060SXFCn44GGquqDctQ23xLr4EcHpo
 Y2Lsh6gI5s/Fm41f73A4wd79KdOEVvh+lMqaHcrFlGFdJXHUJM7RqyDT9vqZuG2h+cLubRXUEA6
 yof2Asbl08DCUbU63F/J5AyjlDKo432Y5vM+DmgyLN0w2jVhB3kZIqM=
X-Google-Smtp-Source: AGHT+IEi9nHbk//7ZmpgnECGVUmbVE/BT9dZwY30oN/aKvROIpPcg9hOpFgodzkUBhW4QQ26Hp7BKw==
X-Received: by 2002:a17:902:e841:b0:223:619e:71e9 with SMTP id
 d9443c01a7336-22dc69f3b71mr187575525ad.11.1745923147737; 
 Tue, 29 Apr 2025 03:39:07 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dc7b7asm99662495ad.102.2025.04.29.03.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 03:39:07 -0700 (PDT)
Message-ID: <bb6ee987-089e-4940-8e11-1b61d1e0b2e9@ventanamicro.com>
Date: Tue, 29 Apr 2025 07:39:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] target/riscv/kvm: read/write KVM regs via env size
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
 <20250428192323.84992-9-dbarboza@ventanamicro.com>
 <20250429-cfab3ab0131af8d6da2f0a14@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429-cfab3ab0131af8d6da2f0a14@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 4/29/25 6:02 AM, Andrew Jones wrote:
> On Mon, Apr 28, 2025 at 04:23:22PM -0300, Daniel Henrique Barboza wrote:
>> We're going to add support for scounteren in the next patch. KVM defines
>> as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
>> field. This will cause the current code to read/write a 64 bit CSR in a
>> 32 bit field when running in a 64 bit CPU.
>>
>> To prevent that, change the current logic to honor the size of the QEMU
>> storage instead of the KVM CSR reg.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 5efee8adb2..53c34b43a2 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
>>       const char *description;
>>       target_ulong offset;
>>       uint64_t kvm_reg_id;
>> +    uint32_t prop_size;
>>       bool user_set;
>>       bool supported;
>>   } KVMCPUConfig;
>> @@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
>>   
>>   #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
>>       {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
>> +     .prop_size = sizeof(((CPURISCVState *)0)->_env_prop), \
>>        .kvm_reg_id = reg_id}
>>   
>>   static KVMCPUConfig kvm_csr_cfgs[] = {
>> @@ -632,6 +634,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>>   {
>>       RISCVCPU *cpu = RISCV_CPU(cs);
>>       uint64_t reg;
>> +    uint32_t reg32;
> 
> We don't need this variable.
> 
>>       int i, ret;
>>   
>>       for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>> @@ -646,9 +649,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>>               return ret;
>>           }
>>   
>> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
>> -            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
>> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
>> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
>> +            reg32 = reg & 0xFFFF;
> 
> This is masking off too many bits. We want the lower 32, not just the
> lower 16.

ooops ....

> 
>> +            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg32);
> 
> If the compiler warns when giving this function reg, then we can cast it.
> 
>   kvm_cpu_csr_set_u32(cpu, csr_cfg, (uint32_t)reg);
> 
> otherwise we don't need to do anything special.

I'll remove the extra var and let the compiler do its thing. I'll add a cast
for extra clarity since some toolchains might nag about it.

Daniel

> 
>> +        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
>>               kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
>>           } else {
>>               g_assert_not_reached();
>> @@ -671,9 +675,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>>               continue;
>>           }
>>   
>> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
>> +        if (csr_cfg->prop_size == sizeof(uint32_t)) {
>>               reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
>> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
>> +        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
>>               reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
>>           } else {
>>               g_assert_not_reached();
>> -- 
>> 2.49.0
>>
> 
> Thanks,
> drew


