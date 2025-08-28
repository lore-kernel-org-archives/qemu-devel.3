Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541CCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOfg-00016j-9o; Sat, 30 Aug 2025 12:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1url7I-0001Xr-AE
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:29:12 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1url79-0002fE-K9
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:29:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so1191407b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756420130; x=1757024930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NEO214mYjsiaIagF7XRj11rivGelrTcbqrCQ3eJf0gM=;
 b=pNL/RQdRxv9ycAcnzy94GpaedpnGPc4JVZWohU7arkUO/9ops2gct3DfddyakoRTRQ
 9baRLGJ68CPVkfLa03vQnPmGS22xwcIfxbERP4PCyAUTcAESZRf/HDa/FWaLr6lo6b9h
 rMN5xcpB3WUHaC7q9OK/k1zTb3eWHHIrv4PkbN4klxH5dQq7s9jT2LmSOUXcoczDAzSb
 lnRrvITGgl2u8//QI0d0MzmOhB9MVtOJHeb+7OHgq7z2hL3/Ruf/+3Lob3hrrT2pswjl
 wa8JjRJsPnnJnmu0UffG5O+mPW06u7vPTN1M7obImFLsQpON6nOzP5LHgqdlsxOfvuXd
 DOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756420130; x=1757024930;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NEO214mYjsiaIagF7XRj11rivGelrTcbqrCQ3eJf0gM=;
 b=NwEJVIXfikq/z+ArQ1HHvSN2OsSrRvrk5sTu2O01coJL2u+6OjC912Mu6wahz5HGeh
 2k+G+ghJTcwgjCAL2UASOF+py6KG1/OFGY4Gn2H/yYXyq/AuLRUS9Egp3I6zDwubGTt5
 DzDKbaS3XmSfaVaUWKHUZbwnBK+FPKKYTeSDMDc6T0DyDNWtqPC9rKdOakJe32hmJWRk
 FE70AdqlIw8O1hJosf0uF8mmynNAHs66b+oQ4lvTHtVy8BHipu6DJb6uK97v9LrVOdYA
 OpbBlc+pwhAjaP8n/vXcC3zz5+U/noew/oFXh0wHwWAZvW9c/S2XJUiSNwPd5giiqWFl
 /bcw==
X-Gm-Message-State: AOJu0Yw0qp+mk2J7TqPREg0hLlOFy01OoA5cWB5tN0F31dOD9Ld/oVFB
 xTFlGsP7s7ROSKoYD47BDwbNhqAmW6S9qtM0tQosxjZwVZZhPh96njQzKYK74ZpM1QzgMidzlKU
 VSHw6JRI=
X-Gm-Gg: ASbGncshFEoX2FUjAbQbg8Y59tvDxw7yacKpevtgFku4p8Vm1Mletujvtz+KWvGURuH
 D9ovkd3gcdR/gKx4K+SeurDyK9UPEYtIOaDmW1TPV0jCe/Q9eLs9pNrzPsgrrrc4MkJIKuY99TU
 84oNhmBRxtYVvm0eOLHPWG4wLnGY/OY3ke4Xk+YitBYqSrvaJBin03iUN+3lBr9v15mb3vt3It2
 e47QttdQZcYOjz0OxNchSyciTd4aP1ThzemfKJUhi8XNPXUbNCKxpzUlRYaCy6gSHCCeC5ZpJkS
 bDC+NSJxgnzBFtZcYofbIOrxB3EeFOGO8WqboQkx+QwDhDjAK00WjfABhLqpijjoiaRV5nvamFe
 Yqc9DKrma4v2ZnOdcn3ggD7Q++clPPvXxfw9W
X-Google-Smtp-Source: AGHT+IFv3bIhbSIInNNUim/Y9PmYzQTaCxONQ7Rm8pecyboFeualwmVRz8c3tg0kGEiXrrP+TfY2IQ==
X-Received: by 2002:a05:6a20:258c:b0:243:a27e:5995 with SMTP id
 adf61e73a8af0-243a27e5bfcmr10028329637.32.1756420130411; 
 Thu, 28 Aug 2025 15:28:50 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd347e359sm403185a12.48.2025.08.28.15.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:28:49 -0700 (PDT)
Message-ID: <e5ff8c1a-4f6e-42f3-9ff5-38dcee98cefd@linaro.org>
Date: Fri, 29 Aug 2025 08:28:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 38/87] linux-user/arm: Expand target_elf_gregset_t
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-39-richard.henderson@linaro.org>
 <CAFEAcA_a-G1hgeefCxdZQMxcGv4=-23fRMM8TifPTuBCJcbKVw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_a-G1hgeefCxdZQMxcGv4=-23fRMM8TifPTuBCJcbKVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/29/25 00:47, Peter Maydell wrote:
> On Thu, 28 Aug 2025 at 13:10, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Make use of the fact that target_elf_gregset_t is a proper structure.
>> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/arm/target_elf.h | 11 +++++++----
>>   linux-user/arm/elfload.c    |  8 +++-----
>>   2 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
>> index 94db3738e8..fa8f8af2f3 100644
>> --- a/linux-user/arm/target_elf.h
>> +++ b/linux-user/arm/target_elf.h
>> @@ -8,16 +8,19 @@
>>   #ifndef ARM_TARGET_ELF_H
>>   #define ARM_TARGET_ELF_H
>>
>> +#include "target_ptrace.h"
>> +
>>   #define HAVE_ELF_HWCAP          1
>>   #define HAVE_ELF_HWCAP2         1
>>   #define HAVE_ELF_PLATFORM       1
>>   #define HAVE_ELF_CORE_DUMP      1
>>
>> -typedef abi_ulong target_elf_greg_t;
>> -
>> -#define ELF_NREG                18
>> +/*
>> + * See linux kernel: arch/arm/include/asm/elf.h, where
>> + * elf_gregset_t is mapped to struct pt_regs via sizeof.
>> + */
>>   typedef struct target_elf_gregset_t {
>> -    target_elf_greg_t regs[ELF_NREG];
>> +    struct target_pt_regs pt;
>>   } target_elf_gregset_t;
>>
>>   #endif
>> diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
>> index 47fe16a1a6..726d3ec25c 100644
>> --- a/linux-user/arm/elfload.c
>> +++ b/linux-user/arm/elfload.c
>> @@ -201,13 +201,11 @@ const char *get_elf_platform(CPUState *cs)
>>   #undef END
>>   }
>>
>> -#define tswapreg(ptr)   tswapal(ptr)
>> -
>>   void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
>>   {
>>       for (int i = 0; i < 16; ++i) {
>> -        r->regs[i] = tswapreg(env->regs[i]);
>> +        r->pt.regs[i] = tswapal(env->regs[i]);
>>       }
>> -    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
>> -    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
>> +    r->pt.cpsr = tswapal(cpsr_read((CPUARMState *)env));
>> +    r->pt.orig_r0 = tswapal(env->regs[0]);
> 
> Why is it OK to drop the "XXX" comment here ?

I assumed XXX meant "what is this", and the answer is orig_r0.
I'm not even sure the value is wrong as-is, due to the way we process syscalls.


r~

