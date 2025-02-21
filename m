Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73B2C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 09:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlPIv-0001BE-N0; Fri, 21 Feb 2025 04:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlPIt-0001AT-VD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:26:40 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlPIr-0007L8-M2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:26:39 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so3034084a91.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 01:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740129995; x=1740734795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtDOW8wCJplTCSwCZMX8yaUFZFOmk/YXX52PFbk8WZM=;
 b=CjrVrGis0R4gqoCqhHG5ZkDrLrMEshBti0oR+HTcYi2ZvTlVGiTnDP2xJzHWcmZztp
 HuydockyRS9iyoFJHZ8xaSe5uEvcw9CbQYhCk19x2jo6PtA5jNZo4uAEquZKRu5guc0V
 elE51Zfzv6tZnE9gG1Desg4gz815GZlkXog8FsQCMaN68VIqqlDgfNcdpjOUBkdCoGgo
 GpovmU1ZQ5Q7ScpKRhGIBuenPIquuLoJ2fHj8sPOY6RmFRgyVmMD5Y9Cx5TKT+F6ukj4
 ds5A02e42Jn/K50gNhh4QRETILPMavkiObCaX+/G7sUMD0HaGkFZRoqtL1MOxOAnbb0C
 39tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740129995; x=1740734795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZtDOW8wCJplTCSwCZMX8yaUFZFOmk/YXX52PFbk8WZM=;
 b=DMivl9i3eY3PG3yLC8x0N87kmM1ibT/1K8TAUHhGKwb9iGCnUyv/Q5oflp264exf0C
 4OVJVURaRK5/EN2jUwDvqhqur6bq5SEkOT3m5FHJZ1gqrWr551DTKLM3VAxMCkggDIJd
 J7QjEupbx/mskSNgY/5BtA0Cw01pSC/BB3AcFKvxolPQvtN5jOeWxWdhY6BfRctXnXXr
 SRn+xukS6q0vUxkZkB00n2uJrt5zOKc1y0NesV2IQCMRlG59GxG26upF0ks0l/DLz/Px
 9oP8D/DIlATJmzRmSTLCdGazJ89ElI7Vw0WKNVRpJUV9/v50G8IME+JHF8NelGBiJ1iw
 rfog==
X-Gm-Message-State: AOJu0YzV0qIFnM95yqUCuzxj2xFHZ1IlIsSook90otI/Dx5085uKOg1u
 9Ryqm78WkLBWn6DgamWbt+/mdweg68nDiB5lPmg7SNoC16V1VykIZFCv9IxTeOc=
X-Gm-Gg: ASbGncstdw3DSDCt2lasYHuzvJHOe8WR0oMliscwa0+L9XqzvoHwRAg3c6/vknl0nKa
 Kig3O28j2r722Y1Aa4iGtvcwSJ+xD2hELTbCQ6Hl+15H9kgqAQjudmUhlvxEXN02lerQM5nlZ8/
 lJTepdNDvG7oL5Ka3QJL0F7w+6ZmOEI0W80DcSOixAmwAultxR5+6875JeFt/4dgBQ+7pbbS7Iy
 GbAuI0knjbQm95nLCgSNsYIHqsNERWcnqAhSFznUYeQa47fVDQbGXo2itm8Uc2Ox+dlmn4VD7Rq
 VNZYp9xIx/2+IHnj8A8Ue1UE/88kMLAST1ire9d4
X-Google-Smtp-Source: AGHT+IECNkt/pIilE3p0kNClPATtYpuQSg3cnKYb3b53L+pRNuRG/3dyte0xFyIaOsEFKyD7n9p6Fg==
X-Received: by 2002:a17:90b:4c8b:b0:2fc:bc04:2092 with SMTP id
 98e67ed59e1d1-2fce78cbc7emr4885604a91.17.1740129995488; 
 Fri, 21 Feb 2025 01:26:35 -0800 (PST)
Received: from [192.168.68.110] ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb0a0ab7sm868164a91.47.2025.02.21.01.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 01:26:35 -0800 (PST)
Message-ID: <e57472d2-edc4-42ab-9048-0d71ffd91c28@ventanamicro.com>
Date: Fri, 21 Feb 2025 06:26:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/riscv/kvm: use env->sie to read/write 'sie' CSR
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
 <20250220161313.127376-3-dbarboza@ventanamicro.com>
 <20250221-770a4da9465046f4fae9dc20@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250221-770a4da9465046f4fae9dc20@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102f.google.com
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



On 2/21/25 5:37 AM, Andrew Jones wrote:
> On Thu, Feb 20, 2025 at 01:13:12PM -0300, Daniel Henrique Barboza wrote:
>> Using env->sie is clearer than using env->mie.
> 
> Maybe? Just as sstatus is a subset of mstatus, sip and sie can be
> subsets of mip and mie. However, the AIA can change sip/sie so they
> no longer alias mip/mie, which is why we have 'mvip' an 'sie' members
> in CPURISCVState. In the end, for KVM, it doesn't really matter since
> this is just s/r storage. I'd probably just drop this patch and keep
> using mie. Otherwise, what about mip?

We don't have env->sip so it would fall on the same case as using env->mstatus
to get/put sstatus.

But yeah this change isn't that big of a deal and can be replaced with a comment
in reset_vcpu like you said in v3. Or maybe we could put those assignments in a
kvm_riscv_reset_regs_csr(), and the name of the function itself is an indication
that we follow the same order as kvm_riscv_(get/put)_regs_csr().

I think I'll use patch 2 to do that and patch 3 to add the missing KVM CSRs
(scounteren and senvcfg).


Thanks,

Daniel

> 
> Thanks,
> drew
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 484b6afe7c..fea03f3657 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -610,7 +610,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>>       CPURISCVState *env = &RISCV_CPU(cs)->env;
>>   
>>       KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
>> -    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
>> +    KVM_RISCV_GET_CSR(cs, env, sie, env->sie);
>>       KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
>>       KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
>>       KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
>> @@ -627,7 +627,7 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>>       CPURISCVState *env = &RISCV_CPU(cs)->env;
>>   
>>       KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
>> -    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
>> +    KVM_RISCV_SET_CSR(cs, env, sie, env->sie);
>>       KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
>>       KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
>>       KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
>> -- 
>> 2.48.1
>>
>>


