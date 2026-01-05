Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4191EC79F9B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 14:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vclLO-00046Z-Ri; Mon, 05 Jan 2026 09:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vclLM-00046I-K2
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:14:00 -0500
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vclLK-0003xF-6e
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 09:14:00 -0500
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-121b251438eso2687414c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 06:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767622436; x=1768227236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ooh8/kOqkoQU/z29OXOXaHXZ6VMmURoney0ynGHrHBo=;
 b=FCaZJolUQv0PmTGBCwlnHX923xEumMNluGQFRrYp02aeB02/Tp6gys1o0jjZfNGmoP
 yAxftO+ohQ5eFGNFHrtyQJt/zanipHmWpjfZIZZ/36xtksKjcef4hnS0jh4138Bak+7h
 gJ7FYrFBAPeZ6fLW3QEoh0kGbPOps4GdoRMV1j3b+qpaUfDcu2AHE+h3GbETPmGFQASb
 vzZ9Sz5CyijS4ml9wvB+BnBI9cChfZuTOvEByxdgqgRRWPptLpnJrBEYe/Ti/9+z9nsp
 BMiaX1GMxsX1BiRz1Q5lBulL5VnLwAL3OIHxsiEjOw4cu5Z+uALeVCCg0EfiHCCCx7r5
 cPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767622436; x=1768227236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ooh8/kOqkoQU/z29OXOXaHXZ6VMmURoney0ynGHrHBo=;
 b=Z6AvPlTS44PwAH2lYKL81j6Ni4cjFMy667KwiPwAw2bUfQefTNFkAvf9ehS5SLqsLq
 +GQfDTscF+MhKmjLHA8fqDHbJKfz2grOMm50gazDzsUa982DZLvllwPimAPGtrbiLITA
 5CKOD9SzabAusNSie0JgzDMDKj8Pa0Eb2O1uZIpAFfOhpZqpVsmMwl9Ho8maJbNZvGnw
 fcma/01T0IGRvBH8MMMy9nCaHMWz3vj8fjG2OUnpAMaHvpsQDfBjMkr/UNsfGXbwxljU
 MZiXRfel177Z7hzUj3OPKzDQ9TTZH33WxEWHr4NODIqveXsyFOHrAgoBNeBmwVO2qdgN
 R4cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEnuOBqf1onPM7BSXaNyqJypd7VH7pjuPJoVaa3ls3sVMGsH469oBFdBlNc/PClsMyJfcBGkOunmE@nongnu.org
X-Gm-Message-State: AOJu0YxlO0je3zvHIHPaSoTG3pzPtqiknP9QoOaMZn1mTXt5Odt0dG5D
 9GgvNr9HD9bwrOPcEtpS64ve8wWzOMVWbgb+uFeaUZRxwqDx6JDGgTlJVb/KTzDgThI=
X-Gm-Gg: AY/fxX4uot9RkSLsS6uI9x4aL16gSXSkTj98Uaz5j00q+hWPYgz83Rzm/H/sLBqYvZu
 bYIjtlBlTyZtIL3cXG8+M158mymQydxKszyukkqkjPmcFn0T4Oou2Tv0akw3w4w1bDDE1J5HH8C
 Ael2aaMRdgzs554Za3sHuLNPOkVMmGVd29cw+wWAwjEwTzy9axN1m9tt1zqQ3FZCTYIAtAyYOAz
 di/ftiVDiQErtOByOR1bn9jvbwuF7vFS2ebxC+fN4HXmxUVwn2P7D4PwvC+XkOXFE0XlOGmGsfD
 wAHRRdrTCimx96MmumeYRYcG3fofJMyhRiIBhE8TLi+3P0Qt3HYnnjJY23GhdqLqoWZ9EJPrPwK
 vllcbOHn6uLPXRgTpxroAH6ZIw1bJnVhvdhkekeqiUJxoFNCoOWi+FX1+/np1o6/LL5fV/DDU1D
 C6jlFmf6PgiE/Pebv+hBMvjTeKpoYkdOcCP9VIpwXHU8Q1S0TDEOsE99ctypbr9W1SO88CQqJmR
 Mb6axOmi5w=
X-Google-Smtp-Source: AGHT+IGoKJRb/wFePSgyifm+LVaSxN+SPgsW5z9vP/DXun9aWZ+hxkF4pvy1N9ZcOX00oXehIzR/+g==
X-Received: by 2002:a05:7022:a9a:b0:11b:3eb7:f9d7 with SMTP id
 a92af1059eb24-121d80d8b77mr5931865c88.14.1767622436269; 
 Mon, 05 Jan 2026 06:13:56 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121724de268sm135949737c88.8.2026.01.05.06.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 06:13:55 -0800 (PST)
Message-ID: <f469e4da-fa21-42bf-ae36-cf2235e47b97@ventanamicro.com>
Date: Mon, 5 Jan 2026 11:13:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/riscv: Add arch= CPU property for ISA
 configuration
To: Kito Cheng <kito.cheng@sifive.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, andrew.jones@oss.qualcomm.com,
 daniel.barboza@oss.qualcomm.com
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
 <bc812773-1a09-4541-ae6d-7a6d7327b6a5@ventanamicro.com>
 <CALLt3Tig9WLNxfHDKKBzpHz908mZWRACioQWoxfjMk5p7eVVbQ@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CALLt3Tig9WLNxfHDKKBzpHz908mZWRACioQWoxfjMk5p7eVVbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-dl1-x1233.google.com
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



On 1/5/26 10:43 AM, Kito Cheng wrote:
> Hi Daniel:
> 
> Thanks for your reply, and here is my response :)
> 
>>> 1. How do you run RISC-V QEMU with a specific extension configuration?
>>>      Please try to configure an rv64im user mode QEMU before you answer
>>>      this question.
>>
>> I would use the 'rv64i' bare CPU that we introduced a few releases ago
>> and enable just 'm':
>>
>> qemu-riscv64 -cpu rv64i,m=on
>>
>>
>> It gives you a bare bones CPU with only "RVI" enabled. We added this CPU
>> specifically to support the use case you mentioned: users that want to
>> have full control of what is enabled in the CPU.
> 
> Oh, thanks for this info, my impression of this is stuck in my memory of 2022,
> which is the time I wrote the qemu wrapper for riscv-gnu-toolchain,
> So I'm still using a rather clumsy way to play with qemu.
> 
> It's really good to know this, and I definitely need to update the
> script in riscv-gnu-toolchain :)
> 
>> We can't control how riscv-gnu-toolchain and others implement their scripts and
>> wrappers. These are the kind of thing that people write once and never look it
>> back, and that's fine.
>>
>> That said, we have 'rv64i' and other bare CPUs since QEMU 9.0, released in April
>> 24. We don't need to do this kind of massive extension disablement to get a
>> clean CPU for almost 2 years.
>>
>> I advise to not take QEMU wrappers, scripts and etc from other projects as a sort
>> of proof of what QEMU is currently capable. They're usually outdated.
> 
> Yeah, I admit that, I always spend time updating the script for
> mapping extension to
> extension to qemu option...and it's hard to always be up to date.
> 
>>> So how do other tools/simulators address these problems? Toolchains like
>>> Clang and GCC use -march with an arch string to configure, and Spike uses
>>> --isa=<ISA-string> to configure.
>>>
>>> Could we introduce a similar way to configure QEMU? Yes, I think we can.
>>> That's what this patch set does.
>>>
>>>     -cpu rv64,arch=<ISA-string>
>>
>> I don't mind the 'arch' property if users find it easier to enable extensions with
>> it rather than the boolean properties, but it should be used on top of bare CPUs
>> only. Otherwise the 'arch' property would include the already enabled extensions
>> from 'rv64' and others.
>>
>> And we would need to be okay with the fact that this is redundant to what we already
>> can do with bare CPUs + manual extension enablement.
> 
> One point here is that the ISA string is the official way to represent
> the ISA configuration in RISC-V, it would be simpler if we can use the
> same string to set up every tool.
> 
>> We have profile CPUs for this use case:
>>
>> $ ./qemu-riscv64 -cpu help
>> Available CPUs:
>>     max
>>     rv64
>>     rv64e
>>     rv64i
>>     rva22s64
>>     rva22u64
>>     rva23s64
>>     rva23u64
>> (...)
>>
>>
>> So 'qemu-riscv64 -cpu rva23u64'  creates an user mode QEMU with RVA23.
> 
> To be honest, I was a little hesitant about adding the `arch=<profile>` syntax,
> because as you said, `-cpu` is already supported.
> 
> My final decision was to add it for alignment with the toolchain interface,
> but that's because I'm a toolchain developer.
> 
>>> 5. zvl*b extensions
>>>      Specify vector length (VLEN) in bits using zvl<N>b where N is a power
>>>      of 2 (32-65536). Requires v or zve* extension.
>>>
>>>      Examples:
>>>        $ qemu-riscv64 -cpu rv64,arch=rv64gcv_zvl256b /bin/true
>>>        $ qemu-riscv64 -cpu rv64,arch=rv64i_zve64f_zvl128b /bin/true
>>
>> We already have vlen and elen properties. Not sure if we need another way to set
>> the same stuff.
>>
>> I'll give a closer look later at the first 2 patches (arch=dump and arch=help)
>> since these are nice additions for the user experience.
> 
> The first two patches should be less controversial, so I'm okay with
> that if we decide to get the first two first :)
> 
>>
>> I would like to hear other opinions about arch=<ISA_STRING> because it would be
>> just another way (probably an easier way) of doing what we already support with
>> bare CPUs + manual extension enablement.
>>
>> I don't see the need to support arch=PROFILE given that we have profile CPUs
>> that does exactly that. Same thing for the 'vlen' setting.
> 
> The primary motivation for supporting zvl*b/VLEN syntax is to align
> with the toolchain interface, allowing users to process both qemu and
> the toolchain using a single string, and again, that is the official
> way to describe that info in RISC-V ISA spec, so I adding this syntax
> sugar in arch=<isa-str>.

I see.

Maybe there's an argument for supporting arch=ISA_STR in its entirely instead of
cherry-picking what we want.

In the end the discussion you're prompting here is whether do we want/need to
implement and support an alternative way of enabling extensions, and in this
case one that is more compatible with the rest of the SW stack we use in the
RISC-V land.

The implementation per se isn't the hard part: the hard part is how to deal
with the upkeep of supporting both the ISA_STR and our current extension
enable/disable code in the long run. I'm not entirely sure also whether we can
use this new arch=ISA_STR as just a superficial layer to do what we already
do or if this would require additional changes in QMP and what not. Drew,
care to comment?


Daniel





