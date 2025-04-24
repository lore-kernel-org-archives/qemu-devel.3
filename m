Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD801C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7xCB-0005yg-OH; Thu, 24 Apr 2025 10:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7xC9-0005y2-91
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:04:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7xC7-0007q8-0s
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:04:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso807509f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745503489; x=1746108289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwS3aArchAQ2d+kedALxi9HZhQVZGNaLT3mure6dy9U=;
 b=VvLbLs+wnZvXLmG1UBSZnBsNUAJaaGfqx/ismCEUNA4wnrfL9/xvAfQuHzqQxkE80Q
 2d7Fd6jFhuXQQp4nX7ZKT17l9XO/WGRRO1fXxQkFVV7L0AMiYcLDDlGXucogiKbXsRLA
 P7dYwLG9lRpEO8agZAm5gtiqU4GZe4gRNhGBbUOW9m5OBbBk+TSOo+XyfGHQHiYeyCwn
 CwVoDLgquwMskS47EYRH3MTtpeR4XbKL89X5iKOaR/a80LrpCT/ls4npB6jZemihpzxd
 L1X9pYy2q4EbUuNKI4/8LxkZdK0Koi0UY0hwbG8p0UODA0DYnZ2nQQagXzrTWIVrXwRB
 hRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745503489; x=1746108289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwS3aArchAQ2d+kedALxi9HZhQVZGNaLT3mure6dy9U=;
 b=TFlqg/aVJqXZ2T/HZZapcHAlYXZcfUfoyVwElwHH6ymTfufgrAxbYTKK3A3pzxeTnu
 sTJ4IHbwWMKBc620uVYKmgkAKVtScD6q91CXMmWsaBgdZwvwLBC7T4cQtZgfSBwMrCOg
 hN6gyq9YERkbT/1I6OcHqBIUIYcepBytZNg1wgUP7OXJ43jxb4zQ9vI3LJzSyC1GX9ln
 lEMFxVFVPovkUmhWXjLlqSuXSlcMiNVqin48ZXXAHSuErnjXZqGEGbEAEv2xZ60MY3Te
 7LQsdwRgKr3WiHa/TWUwnEncKPyKStpwPri8wzSOEXwVPP0Rz+7JXkr1CwGJkJln/HQq
 3mGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTPPKYzMqLhPmPygGgfpAD0IaCO3rUYDuerHxfEDc4xl8FoJnLk3ZuwqM6S5N03PV2A6rsXZtJJntY@nongnu.org
X-Gm-Message-State: AOJu0Yw9x3iW0pNXAPcMQDNSO3KTMW/fdzLf5f4Y6HXS2wYRRfisdKN8
 57A4J2vQ86UdhL94Lcsv9ebJTJ+ajf5tGu7XG3HnwOygp15G6vAONy5UuC1Yorc=
X-Gm-Gg: ASbGncs3aPyEfYUBCaxFzYfNeUZhnKN+mPO2Vb/aBqvOZmQuqkooiDHrPSfRiHtWqnl
 XQtOVvove2i2T91i/2wKMRVUfKe1Ei2XC36aEISYiUGqZW764ZRrm/vOa5KiLafBp6S7NrvGs8w
 X9YmgToOKaL/Xkx6KosXEDWd5X4FrC5FITdYT5QuGFrEOdPjKSwB3I0EQF5+s396XiJKtpJOoH3
 MbQN5MpCGVHW5RRlJ7x9l8IZ1wpg2nxDFlD4KIb7u4tWIfu0TuF5oVlU+GacC+zOqgp6MdBkpZo
 ObVnH/r9YzCUf/qO0Sgc7PN9mijAUrWxOIB4wXXOmchcKKNb9KdnZajrir8k0QlUM6zAmpNq1vJ
 Nw5JcpymbEj302tr05mY=
X-Google-Smtp-Source: AGHT+IHk9KhT0QkZ/lDz1LKmpbh2yuE3Y8sm3isTfKPAa/1ndj0WplR+qxRF11NJsPfeGwEXb1Z/yg==
X-Received: by 2002:a5d:64c7:0:b0:391:4389:f36a with SMTP id
 ffacd0b85a97d-3a06cfaf773mr2170628f8f.48.1745503487125; 
 Thu, 24 Apr 2025 07:04:47 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d532ed6sm2216429f8f.79.2025.04.24.07.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 07:04:46 -0700 (PDT)
Message-ID: <b92509a8-43e5-4515-b609-fcc17805c32f@linaro.org>
Date: Thu, 24 Apr 2025 16:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/27] target/riscv: store RISCVCPUDef struct directly in
 the class
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-9-pbonzini@redhat.com>
 <8f3bae37-e1f3-4e55-9dc6-b7876992b47e@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8f3bae37-e1f3-4e55-9dc6-b7876992b47e@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 24/4/25 15:52, Daniel Henrique Barboza wrote:
> Hi,
> 
> This patch breaks RISC-V KVM build in my env. The issues are down there:
> 
> On 4/6/25 4:02 AM, Paolo Bonzini wrote:
>> Prepare for adding more fields to RISCVCPUDef and reading them in
>> riscv_cpu_init: instead of storing the misa_mxl_max field in
>> RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
>> and go through it.
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/riscv/cpu.h         |  2 +-
>>   hw/riscv/boot.c            |  2 +-
>>   target/riscv/cpu.c         | 23 ++++++++++++++++++-----
>>   target/riscv/gdbstub.c     |  6 +++---
>>   target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
>>   target/riscv/machine.c     |  2 +-
>>   target/riscv/tcg/tcg-cpu.c | 10 +++++-----
>>   target/riscv/translate.c   |  2 +-
>>   8 files changed, 39 insertions(+), 29 deletions(-)


>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 0f4997a9186..d7e6970a670 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
>>   }
>>   type_init(kvm_cpu_accel_register_types);
>> -static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
>> -{
>> -    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
>> -
>> -#if defined(TARGET_RISCV32)
>> -    mcc->misa_mxl_max = MXL_RV32;
>> -#elif defined(TARGET_RISCV64)
>> -    mcc->misa_mxl_max = MXL_RV64;
>> -#endif
>> -}
>> -
>>   static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>>       {
>>           .name = TYPE_RISCV_CPU_HOST,
>>           .parent = TYPE_RISCV_CPU,
>> -        .class_init = riscv_host_cpu_class_init,
>> +#if defined(TARGET_RISCV32)
>> +        .class_data = &((const RISCVCPUDef) {
>> +            .misa_mxl_max = MXL_RV32,
>> +        },
>> +#elif defined(TARGET_RISCV64)
>> +        .class_data = &((const RISCVCPUDef) {
>> +            .misa_mxl_max = MXL_RV64,
>> +        },
>> +#endif
>>       }
>>   };
> 
> 
> ../target/riscv/kvm/kvm-cpu.c:2013:5: error: expected expression before 
> '}' token
>   2013 |     }
>        |     ^
> ../target/riscv/kvm/kvm-cpu.c:2011:10: error: value computed is not used 
> [-Werror=unused-value]
>   2011 |         },
>        |          ^
> cc1: all warnings being treated as errors
> [11/13] Linking target qemu-nbd
> 
> 
> We're missing closing parenthesis after the "}".
> 
> If we fix that we'll get another error:
> 
> ../target/riscv/kvm/kvm-cpu.c:2009:23: error: initialization discards 
> 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>   2009 |         .class_data = &((const RISCVCPUDef) {
>        |                       ^
> cc1: all warnings being treated as errors
> 
> 
> Removing the 'const' qualifier fixes this other error.

Likely based on:
https://lore.kernel.org/qemu-devel/20250210133134.90879-1-philmd@linaro.org/
which was too late to get merged before soft-freeze, but
should get it soon.


