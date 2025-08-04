Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC12C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0Zl-000238-Pj; Mon, 04 Aug 2025 15:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uizUB-0000bY-D7
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:00:45 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uizU8-0001GR-8G
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:00:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23ffa7b3b30so34274175ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754330430; x=1754935230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oi+dQ4SDJivmuxMBX7qDtEv89Jw/veePsuWmRb0zeog=;
 b=wPTv2S7+rvgdMI4iVOz/QRAmmEOqO9psKryBhhdDfxfO+1QFRL1aUFm3f/GQsZZUmw
 cybIRmKRapsGY9txmIkxH7co5cbbj9ps+YB84eHjq47LtG+fZMGGWa/RbHGd7K9SOHPz
 QMQ3WBT5aZNMbjSZNW3d/Cxo0NfSaGMieEm1UlUJdsKWRb59sdZAUrZlrOwn/16maA2K
 09Mg8MeCYtG9bRNrMF9I+KcAK/H7c0bHlDAhEm/LDcvASNsI6Naf7vil0EPy8VIMM+GV
 CLNWhY4QdMZrEEZlniDTnlc66ZSaxE9dVt0JyGB+YC29CCwBreVBhuiSc33tmfh1YrDv
 0ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754330430; x=1754935230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi+dQ4SDJivmuxMBX7qDtEv89Jw/veePsuWmRb0zeog=;
 b=Xp9YUb4Af11s51SAZXF99EN6jKKdaDxvqYyyE+LCWzN6Imgds9kWs5Aw3yElL+hNrx
 /FE3jYy3m+0ZSTQ4+Xb+ZlzaFYxz+QoXBRThU0ZbS/ZV94Qx+rfpbFEkuTlBwXON16Ab
 CUbZeKZy19VwklgZo8wOfur98n55YTr1WG5Rmb4k5cu52IvTyXVZ5VZ1dAFki7xkcru/
 IzPbUjL7Sfp8BeiMSAeO16Qm+3SGJf5aDsB73WUpDyIa1ZzKM7r2Q2keEWJHhruG+V3Y
 jD4gZvYN/mfj4zsa87G0+qAw8fX4+XQuB3fhzzqrpxhsWFY0aM4sC5qBDo2IVAOweVss
 4iGA==
X-Gm-Message-State: AOJu0YyYN4ZwvtG7mJHqGKqqws+fe7oQu5dXALfc4OBQucc44OPyF+Pu
 SOnJU+RDqwqfF65/IE+4oc9VzS0Ol7gSSBUY3BictynACeEgCXqnRLuzz7rDWLiBt9k=
X-Gm-Gg: ASbGncvUSRCXneW5hDY3XgQUIEVEB1y7+3PURAvzUBHZQKGW22Vk4GJZTGbNvndjVND
 sNEySjFJNW2tZglvLWBMO9BlD8u8R3z5DgHwybWK0W+BKd/LYmLMRlurLcx0sFOc/IMExESXGrH
 Gr5D9WYvI59QZBhWMbH8NYC3SGQoS9EJF3WrzlYcZJt4pyej4iqo8YUtaZuqnoYPzOn8C+CPeaA
 tkDodMfdNMHBeRL/w1sGTOezx8hB90Tcsu9HBSpWegB8K3AuM8NoAWjU7oDDfS89FRP7anDVj/U
 ptuBT/JDtUerI3uSE/c3YouMsibFVGh0FP3/2Knnn4kof+HpFDqqW60RweAhLfN8Kd9dm4PrUyv
 UkZ1HC7+jVBviPEJAWvmFvEAsCAj8bi08DvKVbLXZQZshxQ==
X-Google-Smtp-Source: AGHT+IFrsOhahtbYwO5FI8a4RmJ4k/kxTGMy8cmQJPL72ToSwEigLh5/kso8bGCNrW+0LunUE1y9JQ==
X-Received: by 2002:a17:903:2b04:b0:240:b28:22a8 with SMTP id
 d9443c01a7336-2424700fb87mr147617035ad.28.1754330430449; 
 Mon, 04 Aug 2025 11:00:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aac4b5sm114797235ad.169.2025.08.04.11.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 11:00:29 -0700 (PDT)
Message-ID: <89b7d0e2-f8e1-4c22-a4ff-01faa18a7d8e@linaro.org>
Date: Mon, 4 Aug 2025 11:00:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] semihosting/arm-compat-semi: remove
 common_semi_sys_exit_extended
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
 <20250801232609.2744557-5-pierrick.bouvier@linaro.org>
 <CAFEAcA93+MwVESZCqayPr2HVYUc+3qMFy4vDdKaDNe3sN5o3og@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA93+MwVESZCqayPr2HVYUc+3qMFy4vDdKaDNe3sN5o3og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/2/25 12:58 PM, Peter Maydell wrote:
> On Sat, 2 Aug 2025 at 00:26, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> This allows to get rid of sizeof(target_ulong) for riscv, without
>> changing the semantic.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/common-semi-target.h   | 5 -----
>>   target/riscv/common-semi-target.h | 5 -----
>>   semihosting/arm-compat-semi.c     | 4 +++-
>>   3 files changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
>> index da51f2d7f54..7ebd2136d93 100644
>> --- a/target/arm/common-semi-target.h
>> +++ b/target/arm/common-semi-target.h
>> @@ -34,11 +34,6 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
>>       }
>>   }
>>
>> -static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
>> -{
>> -    return nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cpu_env(cs));
>> -}
>> -
>>   static inline bool is_64bit_semihosting(CPUArchState *env)
>>   {
>>       return is_a64(env);
>> diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
>> index 7c8a59e0cc3..63bbcd2d5fa 100644
>> --- a/target/riscv/common-semi-target.h
>> +++ b/target/riscv/common-semi-target.h
>> @@ -25,11 +25,6 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
>>       env->gpr[xA0] = ret;
>>   }
>>
>> -static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
>> -{
>> -    return (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 8);
>> -}
>> -
>>   static inline bool is_64bit_semihosting(CPUArchState *env)
>>   {
>>       return riscv_cpu_mxl(env) != MXL_RV32;
>> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
>> index 3f653c6e7a9..ef57d7205c8 100644
>> --- a/semihosting/arm-compat-semi.c
>> +++ b/semihosting/arm-compat-semi.c
>> @@ -755,7 +755,9 @@ void do_common_semihosting(CPUState *cs)
>>       {
>>           uint32_t ret;
>>
>> -        if (common_semi_sys_exit_extended(cs, nr)) {
>> +        bool extended = (nr == TARGET_SYS_EXIT_EXTENDED ||
>> +                         is_64bit_semihosting(cpu_env(cs)));
> 
> This doesn't look right. Whether a target supports the sensible
> (extended) semantics for SYS_EXIT is a different question from
> whether it's 32 bit or not. For Arm, it happens that the point
> where we defined the newer semantics coincided with the A64
> architecture. For riscv I don't know -- if they made the 32-bit
> riscv not have SYS_EXIT_EXTENDED that was an unfortunate choice
> but they're probably stuck with it now. For any future architecture
> that decides to adopt Arm-compatible semihosting the right
> choice will be to provide the extended semantics regardless of
> bit width.
> 
> This is why there's a common_semi_sys_exit_extended() function
> that each target architecture needs to implement.
>

It happens to coincide for now, so I felt it was useless to leave this 
function given both architecture have the exact same implementation:
nr == TARGET_SYS_EXIT_EXTENDED ||
is_64bit_semihosting(cpu_env(cs))

As you prefer we keep it for a potential new architecture, I will remove 
this patch and keep it.

> thanks
> -- PMM

Regards,
Pierrick

