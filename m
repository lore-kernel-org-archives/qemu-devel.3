Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E139CC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkRJ-0002fs-2J; Tue, 14 Jan 2025 12:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXkRG-0002fj-Mm
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:10:51 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXkRC-0004mL-Od
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:10:50 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-216728b1836so101238825ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736874645; x=1737479445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TAky5vg5Ag3GZLa235vJgxAUlri8xAc7APzFcfCpyu0=;
 b=jDW3IIKE+RNZl1/MPUI+M3V8FgawKwJ0jTSUMzmxynzUvx98hDW5/XOBC+2rkauBd0
 jQyrdvbhxJ47Ee9V5LtjOnn4DwEyrPiuUK4mEq0gib660YZVlW94Mvh7nZG5Xevk/ngh
 wJaTjBPml/qupqCpnweeLnKNDjMavGbQqe/Pr4TeVfI/vyi4brQDv1CajKod3MshJzke
 VsDLHmxtq6PddQBkeEgY/awnpZquxO0z/xLd/LO7PfEUnbvk3zpQurd5c6xXD0iIVq5T
 /hkq+dlkIwbYODy5zADcX1lTEBDLVSNbZHNUJN95+pAOLJhepdxRBCf9b7MoSdgJxw2/
 FymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736874645; x=1737479445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TAky5vg5Ag3GZLa235vJgxAUlri8xAc7APzFcfCpyu0=;
 b=PXn4o1f6g0XEB6aWOaF8ULz4RQFML3rZLPRMD1FkmFs8DBRtpxq9thxO2HQDUznyzc
 fu8dYCQeis0OblBjqadEbS95Yy6oq9MpzThl3q6MiMQ+VKnZTHaQN6HI7TMtzeOtpEn2
 AKiBdDUjziIMXDje0gZjb+GL+MsPZJL/1Dqr2hAaBu0qE6hBGGHAGiTW3GH76ruh2HjL
 hCjQDYDL8rWf9IJFNPVzY+gTsQbbSLPbe6kVBYr1SgC76cl0qIL2TrVuTGVCqO/v2PRa
 mkq7tF3Wx4a+rWUjVIB+2O4V2ScO19WqBA9czQpHIXsQJcFNUg5u6nXqo48qrUXeMPa7
 3t2w==
X-Gm-Message-State: AOJu0YzMwFhI7h/gN+U3M+PLlkRqM9wwPhWvSQqAaf0lJW0e6fyYbSka
 HxNllUllBm4G5lmb5wkwIUnfGO6p1F1dy2V2pdBUw6m5v7zalA8oeQiI4YM/eNY=
X-Gm-Gg: ASbGnct9c1rXp5I/BFVL2qOeWFK0DVwLPlnCudTvCPs4RXFxKj+n4jvQUCt8kd6/ekg
 mK6yLBw4xHCKCdrZ/bPodBRaHJOj9SrH7yEWikczrxWUOwg6UQgU9GR0lkJXBGUabjjIeX9oqTP
 JDGgnu+EkciQ8JcOsRE65E1PgepXIR2GGDfivxuB3bsO7vl7tBgOz6Eo1DYBnaTdQLTBrMhp9c8
 tFUEOXH7gvz6rdV4mzJLmc3e5fvqiJQC1ipgmkrSKGOiZFX0DFMJ5uDAwlqQgoR+/I7Lijo
X-Google-Smtp-Source: AGHT+IHjF9Hi9NpIEmsjB9bi3Aw9HcDCQ2pCX6tkgpGcGp5b5mAnsSOqG4Kfa0ChcqXqUkdb4YMISA==
X-Received: by 2002:a17:902:d2ca:b0:216:56d5:d87 with SMTP id
 d9443c01a7336-21a83f8ea52mr404245415ad.34.1736874644618; 
 Tue, 14 Jan 2025 09:10:44 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f219324sm69933135ad.127.2025.01.14.09.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 09:10:44 -0800 (PST)
Message-ID: <d93fa5aa-ff25-45af-adf3-3ac4d386df42@ventanamicro.com>
Date: Tue, 14 Jan 2025 14:10:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/riscv: use RVB in RVA22U64
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
 <20250114132012.1224941-3-dbarboza@ventanamicro.com>
 <20250114-85b134099fa79adb42628ebc@orel>
 <f2919b99-d131-40ca-a5e8-63c91092e083@ventanamicro.com>
 <20250114-8a8ae2fa3de2faa3a300b907@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250114-8a8ae2fa3de2faa3a300b907@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x642.google.com
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



On 1/14/25 1:21 PM, Andrew Jones wrote:
> On Tue, Jan 14, 2025 at 01:08:46PM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 1/14/25 11:52 AM, Andrew Jones wrote:
>>> On Tue, Jan 14, 2025 at 10:20:10AM -0300, Daniel Henrique Barboza wrote:
>>>>   From the time we added RVA22U64 until now the spec didn't declare 'RVB'
>>>> as a dependency, using zba/zbb/zbs instead. Since then the RVA22 spec
>>>> [1] added the following in the 'RVA22U64 Mandatory Extensions' section:
>>>>
>>>> "B Bit-manipulation instructions
>>>>
>>>> Note: The B extension comprises the Zba, Zbb, and Zbs extensions. At the
>>>> time of RVA22U64's ratification, the B extension had not yet been
>>>> defined, and so RVA22U64 explicitly mandated Zba, Zbb, and Zbs instead.
>>>> Mandating B is equivalent."
>>>>
>>>> It is also equivalent to QEMU (see riscv_cpu_validate_b() in
>>>> target/riscv/tcg/tcg-cpu.c).
>>>>
>>>> Finally, RVA23U64 [2] directly mentions RVB as a mandatory extension,
>>>> not citing zba/zbb/zbs.
>>>>
>>>> To make it clear that RVA23U64 will extend RVA22U64 (i.e. RVA22 is a
>>>> parent of RVA23), use RVB in RVA22U64 as well. As a bonus we can also
>>>> exclude zba/zbb/zbs from 'ext_offsets' and make it a bit shorter.
>>>>
>>>> (bios-tables-test change: zba/zbb/zbs no longer on riscv,isa)
>>>
>>> We should still have zba/zbb/zbs on the ISA string. I don't think
>>> Linux yet supports expanding a 'B' bundle into them and other SW
>>> may also have not really cared about 'B' being designed to represent
>>> preexisting extensions after having already learned how to detect
>>> those extensions.
>>
>> This has to do with how bios-tables-test works. The test doesn't boot the CPU
>> up to realize() and finalize() and, with this change, we ended up removing
>> zba/zbb/zbs from it because we won't reach riscv_cpu_validate_b() to add
>> them back.
> 
> If we can't do a riscv_cpu_finalize_features() (and/or whatever else we
> need to do) to ensure we have a complete ISA string, then I think we
> should modify the test to somehow never check the ISA string entry of
> the RHCT table.
> 
>>
>> I guess that in the end, aside from having a smaller ext list, there's not
>> much to gain from removing zba/zbb/zbs from the profile definition. We
>> can just add RVB and keep them.
> 
> While it doesn't really matter if we add them or not, I still think
> the test should be modified such that we don't have to try to out-smart
> it with profile and cpu definitions. Getting it to work would be best,
> but getting it to ignore is also good since we wouldn't need to bother
> modifying it every time we touch a cpu config.

In theory the test is using rva22 cpus on purpose to try to minimize this
kind of thing. Back then we were worried that the changes in rv64 CPU would
trigger too much test changes. In practice every time we add some new
riscv,isa DT entry, due to an innate QEMU feature that we're now advertising
and whatnot, this test will break.

One thing that crossed my mind but I didn't get to implement it is to provide
a static riscv,isa based on accelerator, e.g. if we're running '-accel qtest'
then we would always return the same riscv,isa regardless of the changes
made in the common emulation. I'm not sure the implications of doing that but
it's something that I think it's worth exploring. Otherwise we'll have to
keep updating this ACPI bios table test from time to time.


Thanks,

Daniel

> 
> Thanks,
> drew
> 
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>>
>>> Anyway, what keeps them from being added? I don't see QEMU code
>>> for that. I do expect a bios tables change though, since the ISA
>>> string should now have 'B' added to it.
>>>
>>> Thanks,
>>> drew
>>>
>>>>
>>>> [1] https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc#61-rva22u64-profile
>>>> [2] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc#rva23u64-profile
>>>>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> ---
>>>>    target/riscv/cpu.c                |   5 ++---
>>>>    tests/data/acpi/riscv64/virt/RHCT | Bin 398 -> 400 bytes
>>>>    2 files changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index b187ef2e4b..8d0563527f 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -2351,13 +2351,12 @@ static const PropertyInfo prop_marchid = {
>>>>    static RISCVCPUProfile RVA22U64 = {
>>>>        .parent = NULL,
>>>>        .name = "rva22u64",
>>>> -    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
>>>> +    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
>>>>        .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
>>>>        .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
>>>>        .ext_offsets = {
>>>>            CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
>>>> -        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
>>>> -        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
>>>> +        CPU_CFG_OFFSET(ext_zfhmin),
>>>>            CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
>>>>            CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
>>>>            CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
>>>> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
>>>> index b14ec15e553200760a63aad65586913d31ea2edc..13c8025b868051485be5ba62974a22971a07bc6a 100644
>>>> GIT binary patch
>>>> delta 53
>>>> zcmeBUp1{l%<l!7LfsuiM@#{n`13^7TMg~>JqB1j+%-qDZl;ot1UQ&#clNpsc(ij;S
>>>> I3K$s}0ARKZK>z>%
>>>>
>>>> delta 52
>>>> zcmbQh+{ern<l!9B$H>6Im@tvcKtP9)kwJyAsLaeHGdD3UC3&N_6yxMHMkS6EMh1pF
>>>> HMg|4|IwT82
>>>>
>>>> -- 
>>>> 2.47.1
>>>>
>>>>
>>


