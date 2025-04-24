Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C39C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 12:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7vpB-0004Fd-VK; Thu, 24 Apr 2025 08:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7vpA-0004FR-NP
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:37:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7vp5-0005Df-6d
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:37:04 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2295d78b45cso13929725ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745498216; x=1746103016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2oSaACM7GlIMV0DBZTqcymR84A9w/s0wWubUjKg6ujE=;
 b=hexk6NoApwKdLjar4HcLV83qAMK9ZAWBpk7xICUQNGoSrCunrZtBgKcwzCczK7PPxs
 iJ3ibE+5xm8HcUhHsdaJQ2Ia6N+4Q1Q+WX7BRvBjcKEH3sFnaxr2bidEw6mpf/QFQ+Hr
 52yjCfNwqEIPXjJ3ixNq4NHYcyAmo9acZYfbAdkvtviOlVIfxky7YedfPfQQy0lMwW6t
 kYjvgIPbCJOijwfc2FrPeI425qAZxEQkq0Z8SqHqMqhmOpVori89Titu2HlKSHbIfjNR
 RvpYvGm9hZhH+W1RgwQs5/zYfqlCCv0B1qtL9zYbeXHcmpoC9byUJQvHJ70TSvvZJUyq
 eBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745498216; x=1746103016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2oSaACM7GlIMV0DBZTqcymR84A9w/s0wWubUjKg6ujE=;
 b=SxRF5kjp08RJ9aKBPyuyZ1T1k8eyWTqfyo57hSfKuDDkjbPVVjYsiTDR0D5mYVIRi7
 70yvt1ZSrVkzC+HTHo2ktAm/VFHXongilne+3T5PzIqYyxGWjFF0Vrjkwh/qvbE5AnbA
 9jzzMoDqUjM/mdpMs54vdPb68EXmFAkKWwH2sfArbuTwScCC9117krQyaCzXeyAQ8AA5
 KB6kMlgs0+dtftpFrmlSmiKJ++Zhbv9p7OGF9RKq7gm9MXXNnU4F8oYejWsm+1/H7Krc
 df6yMAFSFcUMq5VnrK9wQ4hA45DlkzIEiHWUIOpCNbMS/rij/Fj9A6iS7SCgeeyeySdd
 iuLg==
X-Gm-Message-State: AOJu0YzNfuRzpXjqnP/sBcfPZvC2KNn9MpSbwPwsRpZ1WoIR9bVI7JeU
 bHkDsXEz76gsZzQwKqs2b8TajWaSE2bvRUGXp2QfmRWtyUk7mOKmn7jbRno+oAA=
X-Gm-Gg: ASbGncvw1iOghaqVpFTKratYfnGlX44//tYHskFJsZNtvBM2g8Bx/hQX+1EO/xyPxop
 zSanG7+ByQQ7jeF3kJ5uCi7MVipNCltrd6X+dbUO6CgfiDU+s464kXGQdAOVZTft5jhM5/EHLL/
 BUROPL0faXPOpccqQXsiJ7xn3zygZkICOSQh2jgJ1RfOHRlk+YXae4Yy2jHuuNDJQw3f1hRs7m/
 8vcymlObCM3XZrGYg6xLXaAkrtLLfKnQyyDOQ9gAie2AujgvFrg2tFnK/kYYMzPWvV94nx5bJS/
 UV07/cWI2AEsQNqm/ncrmGCeH4yks2OFcKZm65VW+ssFApr3k0qoNtA=
X-Google-Smtp-Source: AGHT+IH6ZuB13dX+AnpGKoeN/i/D0xziBG7KuJ3kWOBfLb4fAiKhG2ocjVEPZjTJsU8QRZHv/RmOAQ==
X-Received: by 2002:a17:902:dac8:b0:215:7421:262 with SMTP id
 d9443c01a7336-22db3bc6978mr43613375ad.12.1745498215869; 
 Thu, 24 Apr 2025 05:36:55 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db521614dsm11877895ad.215.2025.04.24.05.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 05:36:55 -0700 (PDT)
Message-ID: <be399375-9dd6-464e-aeb3-553ed65ae237@ventanamicro.com>
Date: Thu, 24 Apr 2025 09:36:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/riscv/kvm: do not read unavailable CSRs
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 abologna@redhat.com
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
 <20250417124839.1870494-6-dbarboza@ventanamicro.com>
 <20250423-a12702769cccc76e1e56feca@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250423-a12702769cccc76e1e56feca@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 4/23/25 12:25 PM, Andrew Jones wrote:
> On Thu, Apr 17, 2025 at 09:48:37AM -0300, Daniel Henrique Barboza wrote:
>> [1] reports that commit 4db19d5b21 broke a KVM guest running kernel 6.6.
>> This happens because the kernel does not know 'senvcfg', making it
>> unable to boot because QEMU is reading/wriiting it without any checks.
>>
>> After converting the CSRs to do "automated" get/put reg procedures in
>> the previous patch we can now scan for availability. Two functions are
>> created:
>>
>> - kvm_riscv_read_csr_cfg_legacy() will check if the CSR exists by brute
>>    forcing KVM_GET_ONE_REG in each one of them, interpreting an EINVAL
>>    return as indication that the CSR isn't available. This will be use in
>>    absence of KVM_GET_REG_LIST;
>>
>> - kvm_riscv_read_csr_cfg() will use the existing result of get_reg_list
>>    to check if the CSRs ids are present.
>>
>> kvm_riscv_init_multiext_cfg() is now kvm_riscv_init_multiext_csr_cfg()
>> to reflect that the function is also dealing with CSRs.
>>
>> [1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/
>>
>> Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
>> Reported-by: Andrea Bolognani <abologna@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 63 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 60 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 99a4f01b15..ec74520872 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -638,6 +638,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>>       for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>>           KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>>   
>> +        if (!csr_cfg->supported) {
>> +            continue;
>> +        }
>> +
>>           ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
>>           if (ret) {
>>               return ret;
>> @@ -662,6 +666,10 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>>       for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>>           KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>>   
>> +        if (!csr_cfg->supported) {
>> +            continue;
>> +        }
>> +
>>           if (csr_cfg->prop_size == sizeof(uint32_t)) {
>>               reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
>>           } else {
>> @@ -1088,6 +1096,32 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
>>       }
>>   }
>>   
>> +static void kvm_riscv_read_csr_cfg_legacy(KVMScratchCPU *kvmcpu)
>> +{
>> +    uint64_t val;
>> +    int i, ret;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>> +        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>> +        struct kvm_one_reg reg;
>> +
>> +        reg.id = csr_cfg->kvm_reg_id;
>> +        reg.addr = (uint64_t)&val;
>> +        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>> +        if (ret != 0) {
>> +            if (errno == EINVAL) {
>> +                csr_cfg->supported = false;
>> +            } else {
>> +                error_report("Unable to read KVM CSR %s: %s",
>> +                             csr_cfg->name, strerror(errno));
>> +                exit(EXIT_FAILURE);
>> +            }
>> +        } else {
>> +            csr_cfg->supported = true;
>> +        }
>> +    }
>> +}
>> +
>>   static int uint64_cmp(const void *a, const void *b)
>>   {
>>       uint64_t val1 = *(const uint64_t *)a;
>> @@ -1144,7 +1178,27 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
>>       }
>>   }
>>   
>> -static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>> +static void kvm_riscv_read_csr_cfg(struct kvm_reg_list *reglist)
>> +{
>> +    struct kvm_reg_list *reg_search;
>> +    uint64_t reg_id;
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
>> +        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
>> +
>> +        reg_id = csr_cfg->kvm_reg_id;
>> +        reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
>> +                             sizeof(uint64_t), uint64_cmp);
>> +        if (!reg_search) {
>> +            continue;
>> +        }
>> +
>> +        csr_cfg->supported = true;
>> +    }
>> +}
>> +
>> +static void kvm_riscv_init_multiext_csr_cfg(RISCVCPU *cpu,
>> +                                            KVMScratchCPU *kvmcpu)
> 
> I'm not sure we want to keep extending the name of this function with each
> thing it does (and it does SBI as well, which isn't in the name). Maybe
> just shorten it instead to kvm_riscv_init_cfg()?


Yeah, I'll rename it in v2.

> 
>>   {
>>       KVMCPUConfig *multi_ext_cfg;
>>       struct kvm_one_reg reg;
>> @@ -1161,7 +1215,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>>        * (EINVAL). Use read_legacy() in this case.
>>        */
>>       if (errno == EINVAL) {
>> -        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
>> +        kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
>> +        kvm_riscv_read_csr_cfg_legacy(kvmcpu);
>> +        return;
>>       } else if (errno != E2BIG) {
>>           /*
>>            * E2BIG is an expected error message for the API since we
>> @@ -1224,6 +1280,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>>       }
>>   
>>       kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
>> +    kvm_riscv_read_csr_cfg(reglist);
> 
> Shouldn't there be a g_free(reglist) here?

It should. It seems we're leaking 'reglist'. I'll fix it in v2. Thanks,


Daniel


> 
>>   }
>>   
>>   static void riscv_init_kvm_registers(Object *cpu_obj)
>> @@ -1237,7 +1294,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
>>   
>>       kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>>       kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
>> -    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
>> +    kvm_riscv_init_multiext_csr_cfg(cpu, &kvmcpu);
>>   
>>       kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>>   }
>> -- 
>> 2.49.0
>>
>>
> 
> Thanks,
> drew


