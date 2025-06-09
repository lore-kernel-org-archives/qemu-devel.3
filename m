Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27018C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uObc9-0004qo-Cf; Mon, 09 Jun 2025 08:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uObc7-0004qT-GG
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 08:28:31 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uObc5-0000EB-09
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 08:28:31 -0400
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-b2f1032e1c4so3923972a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749472105; x=1750076905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ub+MWuTeJwn0mWQ/V74oIXblSC0hZqAKQ7t+F27WxDQ=;
 b=BDKym024lSo28ZDe3iSUSzi1OuBiWzi1PCGQDh72Rbd3hfJfKL1j6WQSplhqYVyEKX
 Uwvw83ohgTd544L/NEKxdwVcvexPQYhDejBx46nPg0yheYyibfE4HI0RqNRDV4eMMXwi
 APBfqBxPn9Jl8W7oD22R+fmyTWhhceV4oWdxilQhLMg5sExw3WqGaqGI6OsyzNCCN2d1
 5OqHZvnqhFLuAgaotV1JrdJp+QgvqGZ+bYtWW23g+DE228Lb56UaEoBMCXJFBSWstwsA
 VypdrKctTxs2YwS6zdapwrs+aAh5A5VaoPF7NsaDQVlynkbl/q6ewyCucdo/a+hedL5S
 m6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749472105; x=1750076905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ub+MWuTeJwn0mWQ/V74oIXblSC0hZqAKQ7t+F27WxDQ=;
 b=N4rG6ByFY5eBg3U72jgrjJL9l97a4j3LMsBNWbo+5dpfFK3mU6MySBZHV0qxxjwqqP
 rwGvvmBuOmTr3iPOf3E4R2KGJUnG2kUjz/Js7Rup3Y+zC2nd3gfpREwi1C5aenUm/69r
 pyg10WyRgA+MiXy0pUVPFz4Q1BP/Vb2oQJUynGlVZ8psA4ipGMUTLaZjjepIk+pQ6gUk
 jh7gE/Yyjk8q7GYv06JJx3kWv+5IvKl0JQpwd747wYMDdMJHaYHw2aK4TKP0YHqiCWZz
 yJ+O/x3E9C//LmsD5udx3TVEll+fhJusvX27Y5AbbG8dwtwwUztFXvoEKnVgRpPp18JG
 gpZg==
X-Gm-Message-State: AOJu0YxtmsqZe7mWWi1nqzyIfFblSERH95hd6tuPAhFnKUnyhamNtwmY
 faxAMq5ZjocuyxLKR9RRp/R1Awtk+OcaUaUmNvzWLZjQckFC8Ss+dZTLI1G0gzcv/NM=
X-Gm-Gg: ASbGncvmhtxT3fnFrTvprTm39jnOqwM9mA/m011/KTcOrvnwzFcPAu9XX+ZqNkdQv/I
 3gf/eveYAwkvv14iKFWM1rVfLS+ACEdyWEqML4UduHOL8L83tWuFiwSSH/3TggGzl469Vv0ZQTx
 98GBhu0X/44BKTyvJ0CwWZxPHRexqeDYvVFNcGXe2UDW3ot4fO3NTHOnsuwS94WDhQP+lDmXSZS
 E1sO8WfYftqGnp0BGCgcCAAo/3YdtI3uD2mnhODEWOSiiiV9TJGbjdiY85hEMbcmy7dUBAKurh0
 6+vj5kBNNU3oAct+Tzrq/gYnM1IYkuwkPSP2HSb6z8Fz7Gmeo9+MJTKFsAFb33p4RK4CdOvg2Po
 =
X-Google-Smtp-Source: AGHT+IHt0mqDrjpqtzUwxoVLfq5NjbfpMtnYSiU7lJsOWM9Bnw9ULUM2WubsHlK6K9ZdESduoAV8Yw==
X-Received: by 2002:a17:90b:3911:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31347698038mr16727297a91.29.1749472104612; 
 Mon, 09 Jun 2025 05:28:24 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.21.192])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2360340fbffsm53323425ad.197.2025.06.09.05.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 05:28:24 -0700 (PDT)
Message-ID: <01cb822d-0587-44b5-a5a5-da8413a45386@ventanamicro.com>
Date: Mon, 9 Jun 2025 09:28:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: add cva6 core type
To: Ben Dooks <ben.dooks@codethink.co.uk>, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-3-ben.dooks@codethink.co.uk>
 <ef6c7b15-04a7-42cf-a89b-c2674388810f@ventanamicro.com>
 <06323162-66b9-4165-ab2e-86ec6272aca8@codethink.co.uk>
 <341224e9-d335-40ac-af98-6395b3aede84@ventanamicro.com>
 <a661eb0c-ba27-4348-93d2-dfb1a080c18e@codethink.co.uk>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a661eb0c-ba27-4348-93d2-dfb1a080c18e@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x542.google.com
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



On 6/9/25 8:47 AM, Ben Dooks wrote:
> On 09/06/2025 12:30, Daniel Henrique Barboza wrote:
>>
>>
>> On 6/9/25 7:40 AM, Ben Dooks wrote:
>>> On 07/06/2025 21:17, Daniel Henrique Barboza wrote:
>>>>
>>>>
>>>> On 5/27/25 8:24 AM, Ben Dooks wrote:
>>>>> Add TYPE_RISCV_CPU_CVA6 for the CVA6 core
>>>>>
>>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>> ---
>>>>>   target/riscv/cpu-qom.h |  1 +
>>>>>   target/riscv/cpu.c     | 11 +++++++++++
>>>>>   2 files changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>>>> index 1ee05eb393..3daf75568c 100644
>>>>> --- a/target/riscv/cpu-qom.h
>>>>> +++ b/target/riscv/cpu-qom.h
>>>>> @@ -34,6 +34,7 @@
>>>>>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>>>>>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>>>>>   #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x- rv128")
>>>>> +#define TYPE_RISCV_CPU_CVA6             RISCV_CPU_TYPE_NAME("cva6")
>>>>>   #define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
>>>>>   #define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
>>>>>   #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>> index 629ac37501..fca45dc9d9 100644
>>>>> --- a/target/riscv/cpu.c
>>>>> +++ b/target/riscv/cpu.c
>>>>> @@ -3009,6 +3009,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>>>           .misa_mxl_max = MXL_RV64,
>>>>>       ),
>>>>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_CVA6, TYPE_RISCV_VENDOR_CPU,
>>>>> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | RVU,
>>>>> +        .misa_mxl_max = MXL_RV64,
>>>>> +        .cfg.max_satp_mode = VM_1_10_SV39,
>>>>> +        .priv_spec = PRIV_VERSION_1_12_0,
>>>>> +        .cfg.pmp = true,
>>>>> +        .cfg.mmu = true,
>>>>> +        .cfg.ext_zifencei = true,
>>>>> +        .cfg.ext_zicsr = true,
>>>>> +    ),
>>>>> +
>>>>
>>>> The CPU is being added inside a "#if defined(TARGET_RISCV64)" block, meaning
>>>> that it's a 64-bit CPU only. But the CVA6 board added in patch 1 is being
>>>> added for both 32 and 64 bit emulations in hw/riscv/Kconfig:
>>>
>>> Ah yes, it is possible to make a cva6 32bit, is it ok just to ove this
>>> into a different place or is there anything else needed to allow 32 or 64bit?
>>>
>>> I've only been building a 64bit userland to test so didn't notice the
>>> lack of 32bit was an issue.
>>>
>>>> config CVA6
>>>>      bool
>>>>      default y
>>>>      depends on RISCV32 || RISCV64  <------------------
>>>>
>>>> This setup (after patch 3 is added) triggered a test failure in 'check- qtest',
>>>> when polling all available boards in qemu-system-riscv32, because it didn't find
>>>> a default 32 bit CPU for the cva6 board:
>>>>
>>>> # starting QEMU: exec ./qemu-system-riscv32 -qtest unix:/tmp/ qtest-1683816.sock -qtest-log /dev/null -chardev socket,path=/tmp/ qtest-1683816.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine cva6 -accel qtest
>>>> ----------------------------------- stderr -----------------------------------
>>>> qemu-system-riscv32: ../hw/core/machine.c:1574: is_cpu_type_supported: Assertion `cc != NULL' failed.
>>>> Broken pipe
>>>> ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>>>>
>>>>
>>>>
>>>> We have 2 options here:
>>>>
>>>> - if the CVA6 board is supposed to run in RISCV32 and RISCV64, then its default
>>>> CPU must be 32 bit compliant too. The CPU declaration in this patch must be moved
>>>> outside the "#if defined(TARGET_RISCV64)" block (e.g right after
>>>> TYPE_RISCV_CPU_SIFIVE_U);
>>>>
>>>> - if the board is 64 bit only then the CPU declaration is fine, and we need to
>>>> change the board hw/riscv/Kconfig entry to "depends on RISCV64".
>>>>
>>>
>>> As long as it is just the #ifdef block I will move it.
>>
>> I just read the CV6 documentation at:
>>
>> https://github.com/openhwgroup/cva6/
>>
>>
>> The README states right at the start:
>>
>>
>> "CVA6 is a 6-stage, single-issue, in-order CPU which implements the 64- bit RISC-V instruction set."
>>
>>
>> So this means that CVA6 is a 64-bit CPU only. This means that we want the second
>> option: the CPU declaration is fine, but the CVA6 board must be built only for 64
>> bits. In patch 1, this line:
> 
> 
> There do seem to be some build variants for cva32a6 deep in the docs
> and the cva6-sdk has builds for both xlen==32 and xlen==64 so I am a
> bit confused here.

It looks like that the 32 bit version (which I assume to be this cva32a65x target)
is not the same CPU as you're adding here. At least in a quick read at the docs.

Even if we move the CPU declaration as I've suggested, making this cva6 work 32 bit
compliant too, that doesn't mean that it'll have the intended purpose as per its
own spec.

My suggestion is to get a clarification with the cva6 folks (or any other interested
party) about whether this is supposed to be a 64 bit only board/cpu or not. If
unsure, I suggest to contribute this as a 64 bit only CPU/board for now and then
revisit this later in case there's a 32 bit variant too.


Thanks,

Daniel



> 
> 


