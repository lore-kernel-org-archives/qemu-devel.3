Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE96C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 19:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tucHn-00017i-S9; Tue, 18 Mar 2025 15:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tucHk-00017A-Cb
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:07:33 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tucHi-0007xs-F1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:07:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223594b3c6dso130631455ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1742324848; x=1742929648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCH8wxOJwzBxbM/iEeUn+tfPU/lOmxaIrFfqOLR5qo8=;
 b=ab1ZT2wO4+oh9Km21NoA8IvHAFCuqtN869AXCSusZfUktwjUxUfSPi25NAmcSsc1Y5
 sY2Fkcqsi1dj2jn5TgSR0seYP8VpoffSGVFKh7Hc9WpGJ+0VzEj8n4GpKCV/v1M0hS+Z
 5rYY+ZPTUO6NryIqY4rQMEkzIqtziVyPz64cVNCFSGxaD3IoSRhJAWo6auZsxF6+PfbK
 HYRonLsc1m3BlaEQQA2pEx1nE0fIFnmwmX8tmhdfR6UWaedIjmaDsQoAeOnBXpnBONql
 NiGQWOAKE9tMOGejavXgXtZhoy4CboGcQpkREIoZmgLSMsHbL/WNw73Ed+YROGzpn1bT
 SKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742324848; x=1742929648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sCH8wxOJwzBxbM/iEeUn+tfPU/lOmxaIrFfqOLR5qo8=;
 b=ZsOmg4hkLXLjy8hUOWIb5MWtmWJWlhsir101SjrQ8VkQ4eIE0ijD6iGwlUrzekxKE4
 h5AliB0kTv10CA+RresU4QsnerhzXWamqdJOiIDTTj2smBHtjlm7x6Hpeacmlck+NUfY
 qY/L35Tvkt9ivgOV66UT9iyXBukdro8SUjBH9I1Pl4CNffheMPrhgaWk4oKeMMJFZBsl
 fAZ4EuL1GKvR4J/ymiNopRwExmYxBR4cezYTNowcuuZ6tjFzx+tuQ2KvgfR8zfqFXcYd
 gC7X62xnFKJxLEbieZfEgc3T4BC6WjYNfmCOSXj6zDbJJc7XxUSNM6+PfErbLeCw/JFe
 Aspg==
X-Gm-Message-State: AOJu0Yxz+iSnFv2pZ1j7Y4Bg1Fxpcbm4QSjiJp5e/j9XyxjMY756haq8
 XQhnASyGwXEpza44FoLoQo0PV2bJCfqpaoKSL6SBPUDJWXgA2h/SQmiDlkKF7+E=
X-Gm-Gg: ASbGncujPFuRYP5HAmgXWbtoQuh0vU/L1q3VGUE9/EeNPOhgFNpABcVzGuoPY/a4biz
 rLnoEKwJNGrKMYPYLz0HvQRwD2mcPa1Eh/1vv36eatrEyyGbXEaWn8otXWy/DMg6dTagI2CA1u1
 jAv0/LaYH/xQQBWke+2c+6gpODrHOZrrySPD25+yxmJqDIpppU4wYV65e8M6KjeUtWO/VCuOkQU
 B5cueEb1MiGJLv8HNMf1b37Qqb9AvgHt9N6Yp4OxfPCIgmB6PjCaGr98VH/q2S6oDvvgPkrpXRY
 PooKBT9AO/Bvb3dqUzV+2tlYMiNwrusDldGcHZNHQ+HHRjudqiJAQDcr8nKboH5cOdxtrQM9Bm/
 yr+4CmuuQM14XFP8xlnJfyAzKp+S+9sy3SA==
X-Google-Smtp-Source: AGHT+IEfTMs8efQoCIy48fRBBCQheuC9VZDS5BowbbEYh0b8IrH/38HIGPlb7N3PiqToWPmzclzR9w==
X-Received: by 2002:a17:902:f706:b0:223:47e4:d288 with SMTP id
 d9443c01a7336-226483de593mr2098375ad.47.1742324848107; 
 Tue, 18 Mar 2025 12:07:28 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:89fc:59f0:a5a7:feb2:304e?
 ([2804:7f0:bcc0:89fc:59f0:a5a7:feb2:304e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22647996c7asm668955ad.20.2025.03.18.12.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 12:07:27 -0700 (PDT)
Message-ID: <c17a3e7e-9383-4f37-9fc5-b93afbf13bd3@ventanamicro.com>
Date: Tue, 18 Mar 2025 16:07:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in
 rmw_sctrdepth()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
 <CAFEAcA_P3XbJ-H9O=K-U7HtBAU9c=0TngEfV8fpQxcH0JRuGVA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA_P3XbJ-H9O=K-U7HtBAU9c=0TngEfV8fpQxcH0JRuGVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 3/18/25 1:42 PM, Peter Maydell wrote:
> On Fri, 7 Mar 2025 at 12:46, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Coverity found the following issue:
>>
>>    >>>     CID 1593156:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>    >>>     Potentially overflowing expression "0x10 << depth" with type
>>    "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then
>>    used in a context that expects an expression of type "uint64_t" (64
>>    bits, unsigned).
>>    4299             depth = 16 << depth;
>>
>> Fix it by forcing the expression to be 64 bits wide by using '16ULL'.
>>
>> Resolves: Coverity CID 1593156
>> Fixes: c48bd18eae ("target/riscv: Add support for Control Transfer Records extension CSRs.")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/csr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 0ebcca4597..e832ff3ca9 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -4296,7 +4296,7 @@ static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
>>           }
>>
>>           /* Update sctrstatus.WRPTR with a legal value */
>> -        depth = 16 << depth;
>> +        depth = 16ULL << depth;
>>           env->sctrstatus =
>>               env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
>>       }
> 
> This is a clear false-positive from Coverity, by the way: we just
> checked and enforced that depth is at most SCTRDEPTH_MAX, i.e. 4,
> and 16 << 4 cannot possibly overflow anything.

True. I wonder if we should keep this patch anyway due to the better code
pattern in using ULL when left shifting into a 64 bit var, regardless of
not fixing any overflows. There's a chance that we might copy/paste the
existing pattern into another situation where an overflow might actually
happen.

I'll leave to Alistair to decide whether to keep to drop this patch. Either
way works for me. Thanks,



Daniel

> 
> -- PMM


