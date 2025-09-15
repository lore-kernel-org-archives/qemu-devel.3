Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFFDCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 11:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7iP-0000aq-Bo; Mon, 15 Sep 2025 07:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uy7iC-0000ZT-1D
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:49:38 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uy7hu-0003SW-BZ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:49:33 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32e64d54508so808495a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 04:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1757936948; x=1758541748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7mxC0HuOzB+yJSqNf1nfsc6C+SkvCo5zuen1EsOI6o=;
 b=nUaezd8YmZhjpHvIErNX/nQUPWZ1heg6bRPlFdeDsI/IUvDVJ2TTFURDzQVu+2Z5Lq
 +5ZVokRyJnWUI7K8zYCPQ9y/XA309r7qDfY04VrPUWG4lwvijt3K5moP4EktVGSDNIGd
 1UZa7CvMV8YfTBWg2FOlkyoMmgMgd5QKQazYMVh62N3X4PQ5Ym/w38nPBHvs9tUYnT/8
 KQ02xiYRn8nurBDXLfOku7xzDgkBa3BMXhVjTaI1FRhYllV6l2vWmIBf6Hp90u+GKfvT
 y+gQ3qCToKPoYftdDVX5P5zs7QVKeYlOcZbMHKOsusnC4uuJ7kDfjfeHP5OtzPkjFCVs
 P8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757936948; x=1758541748;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7mxC0HuOzB+yJSqNf1nfsc6C+SkvCo5zuen1EsOI6o=;
 b=U6nhmwcBJY7XGPNjU9MGzs/a4v0SLryovuaVqWGKv8x9dQhQs3L5bymKT8hLPci40r
 h4nCzpMkDJ7fvBYRsFk9tN44d42cYqo1I+Yphw44009gLUtB13IyauWNLGSfoSxQb8tZ
 R7nL6e+AMFIe685UMtqJ8FjyGO99/BExpNTu6Cg6RF06sqBwGIbB9aJShxMncYvd73U/
 Dv/vw6BqwrScb5Ig2sfsp69jlPlk5tksVm6YearJxHTsNeXU+IStZlba/mNDFyhW2jZU
 kWDVrdje7eRYhrJDfrbVucjqZKTiJIb0J62PjDaNwWyi2jZtB6oOWjS9HpH1ZZrTBqRZ
 JhYw==
X-Gm-Message-State: AOJu0YyFRyvyeh3uF0PkAJbbfteWak1AZauFiYbSLwO6FQUyAnwku2mN
 jQpeMe0hcbcatPFBVadEOPq6PKbfddMEWQ5hehI0kq8SiLSaeidPsTUSzbujXxwvAro=
X-Gm-Gg: ASbGncsp10s4qpm727W1ILJTmr5SMRpI0tVb0TmnlECZnL7pVMhdgcDPHSbTBKoEy77
 +3W81eD4A1E7SteMBhSB15EKasjhCXLI+FitpTP6HnlZ24N5DNayZ3o8ylUft26lf+eEHLWaQEG
 mE+3t64DHyrIuoTOnCtJE6PoR9XquP/0wN+00unCkE8F9/pC4ncuVboMt5i8nPF6F73kwridSNP
 3SZ/ukx6wlRJjAO76vIuj0bd1XTX2MN/zbceYEOacr5ccwE3J+85z7adMrA0VfHkDFhhqp2hrAE
 G1YK5OAFcag3+IbPsuFyoKHtjgoxmcm6+BQGdYsY1+9VAtdArRNc2n6PTd5UlJ3eOUWLsSDuVZL
 p1doooyUjwyePhh0wqZHQU2x/R70a+ekvncGL8L9ZmybRkp0LP1P4ShK25J3XjqI5pldhUKrWp5
 HU
X-Google-Smtp-Source: AGHT+IHA+iUL5IPdvnwzKSs0hmIGoESId0wNDYCa/UrO2sXNqAD1pp9hIg598iipXD0Hxra06hhaxQ==
X-Received: by 2002:a17:90b:5403:b0:32b:c610:6ef6 with SMTP id
 98e67ed59e1d1-32de4f7df23mr13405996a91.21.1757936948546; 
 Mon, 15 Sep 2025 04:49:08 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:a026:14f7:a39e:7d17:ef5a?
 ([2804:7f0:bcc0:a026:14f7:a39e:7d17:ef5a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ded1ac2fdsm10574102a91.27.2025.09.15.04.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 04:49:07 -0700 (PDT)
Message-ID: <72b57d2b-9e18-4177-a079-b30a7e1e6243@ventanamicro.com>
Date: Mon, 15 Sep 2025 08:49:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: print all available CSRs in
 riscv_cpu_dump_state()
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
 <20250623172119.997166-4-dbarboza@ventanamicro.com>
 <CAKmqyKMdio17PjxfRVUbF33Y0p2vk8SxFUCr0WXN_uSDE+25gA@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKMdio17PjxfRVUbF33Y0p2vk8SxFUCr0WXN_uSDE+25gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 9/15/25 12:22 AM, Alistair Francis wrote:
> On Tue, Jun 24, 2025 at 3:22 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> At this moment we're printing a small selection of CSRs. There's no
>> particular reason to not print all of them.
> 
> The reason was that there are just so many and printing everything
> makes it hard for people to read. So we just print the "main" ones and
> people can then probe the more obscure ones they are interested in.
> 
> Do we actually want to print all of them?

In case we have no idea what is going on with the CPU, e.g. there is something
wrong and you can't quite put your finger on it, outputting all CSRs can help
identify errors in unusual places you wouldn't expect.

After identifying the problematic CSRs we can then use the MonitorDef API to
fetch just the CSRs we want with "p $<reg>".

At this is the sort of use case I was imagining with these patches. They'll be
more effective when used together.


Thanks,

Daniel
  

> 
>>
>> We're ignoring the note about CSR_SSTATUS being ommited because it can
>> be read via CSR_MSTATUS. There's a huge list of CSRs that would fall in
>> this category and it would be an extra burden to manage them, not
>> mentioning having to document "we're not listing X because it's the same
>> value as Y" to users.
>>
>> Remove 'dump_csrs' and use the existing 'csr_ops' array to print all
>> available CSRs. Create two helpers in csr.c to identify FPU and VPU CSRs
>> and skip them - they'll be printed in the FPU/VPU blocks later.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> The actual code looks fine though
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Alistair
> 
>> ---
>>   target/riscv/cpu.c | 55 ++++++++++++++++------------------------------
>>   target/riscv/cpu.h |  2 ++
>>   target/riscv/csr.c | 18 +++++++++++++++
>>   3 files changed, 39 insertions(+), 36 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 95d0b88937..ed1bf18625 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -544,44 +544,27 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>>   #endif
>>       qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
>>   #ifndef CONFIG_USER_ONLY
>> -    {
>> -        static const int dump_csrs[] = {
>> -            CSR_MHARTID,
>> -            CSR_MSTATUS,
>> -            CSR_MSTATUSH,
>> -            /*
>> -             * CSR_SSTATUS is intentionally omitted here as its value
>> -             * can be figured out by looking at CSR_MSTATUS
>> -             */
>> -            CSR_HSTATUS,
>> -            CSR_VSSTATUS,
>> -            CSR_MIP,
>> -            CSR_MIE,
>> -            CSR_MIDELEG,
>> -            CSR_HIDELEG,
>> -            CSR_MEDELEG,
>> -            CSR_HEDELEG,
>> -            CSR_MTVEC,
>> -            CSR_STVEC,
>> -            CSR_VSTVEC,
>> -            CSR_MEPC,
>> -            CSR_SEPC,
>> -            CSR_VSEPC,
>> -            CSR_MCAUSE,
>> -            CSR_SCAUSE,
>> -            CSR_VSCAUSE,
>> -            CSR_MTVAL,
>> -            CSR_STVAL,
>> -            CSR_HTVAL,
>> -            CSR_MTVAL2,
>> -            CSR_MSCRATCH,
>> -            CSR_SSCRATCH,
>> -            CSR_SATP,
>> -        };
>> +    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
>> +        int csrno = i;
>>
>> -        for (i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
>> -            riscv_dump_csr(env, dump_csrs[i], f);
>> +        /*
>> +         * Early skip when possible since we're going
>> +         * through a lot of NULL entries.
>> +         */
>> +        if (csr_ops[csrno].predicate == NULL) {
>> +            continue;
>>           }
>> +
>> +        /*
>> +         * FPU and VPU CSRs will be printed in the
>> +         * CPU_DUMP_FPU/CPU_DUMP_VPU blocks later.
>> +         */
>> +        if (riscv_csr_is_fpu(csrno) ||
>> +            riscv_csr_is_vpu(csrno)) {
>> +            continue;
>> +        }
>> +
>> +        riscv_dump_csr(env, csrno, f);
>>       }
>>   #endif
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 4a862da615..ecdf709c2d 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -967,6 +967,8 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>>
>>   /* CSR function table */
>>   extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
>> +bool riscv_csr_is_fpu(int csrno);
>> +bool riscv_csr_is_vpu(int csrno);
>>
>>   extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 6296ecd1e1..229257b31b 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -5799,6 +5799,24 @@ static RISCVException write_jvt(CPURISCVState *env, int csrno,
>>       return RISCV_EXCP_NONE;
>>   }
>>
>> +bool riscv_csr_is_fpu(int csrno)
>> +{
>> +    if (!csr_ops[csrno].predicate) {
>> +        return false;
>> +    }
>> +
>> +    return csr_ops[csrno].predicate == fs;
>> +}
>> +
>> +bool riscv_csr_is_vpu(int csrno)
>> +{
>> +    if (!csr_ops[csrno].predicate) {
>> +        return false;
>> +    }
>> +
>> +    return csr_ops[csrno].predicate == vs;
>> +}
>> +
>>   /*
>>    * Control and Status Register function table
>>    * riscv_csr_operations::predicate() must be provided for an implemented CSR
>> --
>> 2.49.0
>>
>>


