Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DEDE6F077
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6w1u-0002On-79; Fri, 01 Nov 2024 14:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6w1p-0002Li-FX
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:05:45 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6w1n-0003zL-MX
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:05:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720be2b27acso1681698b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730484342; x=1731089142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ekUNwNHYyl2eKEpMY7PYshkgLFnJxloL47L92sOEPT0=;
 b=eDygEG+Ba2BfPeBDoRiM7Jxy5qy7j9PEziTcUnNcjISx96wT2njH8G3yaLWbPdflVM
 acjwzPBiXH8Cfc/6wXN1q2vW03FU8QxwF93n2Dm74wLa7wjqAQibxhV5ta2kYcy88mCj
 UNNi0LBbjFoLT2Stnetgigr1A6dKC/Z5GkHdcWg+KtS4zO1lxmofkwDauYDZCwYtRwlt
 F8jKJc+1V41mAXHadMsXdq6He+B7pjQwmTLInhEJKOtPdj370atbMj84taZ3Ap2QI6Il
 UIEXRjrDa8Dy9z8g2lv1ER6GkV+mrKYvbQ6aE5Sac/AzJYc+q6I7kz96fIUP8plnCQS0
 pk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730484342; x=1731089142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ekUNwNHYyl2eKEpMY7PYshkgLFnJxloL47L92sOEPT0=;
 b=kHBYnaR60iQvwmOjCIsBML5YrdZQpppMg/qQrKQb4zgVHPL5orqEccIlYw7/OpVspp
 uz1rAY1XgrGoSEW1K+NdaUqgQEC6xZewolzt47PdYQVMIdBsMFHLhwZq9mHmkd/Qku7h
 oUlA7r8IgWJ43cv3UGBpkVBNIQI5F4xFWhHYGCHsV5D9albreLcgtlj2T52kZKprKL3Q
 lR03tno/NSYk//J6Qv7WKoIoDUoJ2Am4SiGKIPa5DHjw4y5GlsGwsL5VRufXxbS4GvPg
 320hXS8RLHQbrLT4enVSeG+OPiP6idw/dEABFqfU/8Y0n89HCPz9utl3mM6TLaXEZlpr
 qqkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0wuAOW7OlK3ENmzsmDAcjyto6JRXQ6YFHn2ZO95Z6wqAYijB2vWU9I9aKiuWQf+p/xeYLyZnpul1D@nongnu.org
X-Gm-Message-State: AOJu0Yy7IuCJR1UKPoL0D+AuxIvoLP2uU1EMxcT4ypYFNRxNW+PvQPhS
 ziIZm4+KDKC5BYz7GUs4krPwIBGjo7NPP2Y2v8oj0kK6flwoxDJV//YWE/+t48s=
X-Google-Smtp-Source: AGHT+IFxhw8U0I4lKNqouN/CUzUNG7gYQbHJsNcb9RGJrHJQ/QAnTa9R8UvK2KUP632GIdAVhKqqWw==
X-Received: by 2002:a05:6a00:1488:b0:71e:4dc5:259e with SMTP id
 d2e1a72fcca58-720b9d9497bmr10735747b3a.17.1730484342113; 
 Fri, 01 Nov 2024 11:05:42 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1b894csm2945021b3a.40.2024.11.01.11.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 11:05:41 -0700 (PDT)
Message-ID: <e7eb15a5-0943-4d66-b071-ce77ab7b775a@linaro.org>
Date: Fri, 1 Nov 2024 11:05:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: fix build error with clang
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
 <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 11/1/24 10:35, Daniel Henrique Barboza wrote:
> 
> 
> On 11/1/24 2:08 PM, Pierrick Bouvier wrote:
>> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>>
>> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>>
>>     187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>
>>         |                 ^
>>
>> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
>>
>>     217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>>
>>         | ^
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/riscv/riscv-iommu.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index feb650549ac..f738570bac2 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>>    }
>>    
>>    /* Portable implementation of pext_u64, bit-mask extraction. */
>> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>> +static uint64_t pext_u64(uint64_t val, uint64_t ext)
> 
> I suggest name it 'riscv_iommu_pext_u64' to be clear that this is a local scope function,
> not to be mistaken with anything available in clang or any other compiler.
> 

Looks good to me. I'll wait to see if Tomasz or Alistair want to revisit 
this before pushing a v2.

> 
> Thanks,
> 
> Daniel
> 
>>    {
>>        uint64_t ret = 0;
>>        uint64_t rot = 1;
>> @@ -528,7 +528,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>>        int cause;
>>    
>>        /* Interrupt File Number */
>> -    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>> +    intn = pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>>        if (intn >= 256) {
>>            /* Interrupt file number out of range */
>>            res = MEMTX_ACCESS_ERROR;

