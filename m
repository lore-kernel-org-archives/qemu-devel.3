Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660F4D1712A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2xtG-0002G7-Pk; Mon, 21 Oct 2024 15:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t2xtF-0002Fz-Nd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:16:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t2xtC-00076O-Rj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:16:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e5ae69880so3754287b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729538185; x=1730142985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XJlshyed/Hm9obK4873RTSaIjUnI3fci1pdF5H4p5hw=;
 b=aAqlMYAl7Z01YP6fKWbXGvP08tBS66s7/O9BLJNb9wEFFydUkBGgMf528i5slLAubR
 raeaZVyJjChOJg13H4s5JKP3KZodmoCKyKSpAtXWUbw8B9OMjAbCVlkIAmRyu5Nss1w2
 gCMC0njRfOzVQhC/KLEXC5qYrbiS/raZRT8hGxM2H1sowIRYLdUMqOHDAz7b+Kuufzp/
 tt0RFFEqfpqRWCBz24ydAD4ZKUV7e0A20A9FHysZM/2X3kkf+BGLTwOobtyECNx5r03D
 ukI/DQxKsobHcNHM61f5BgffxurYUt/0htfINHYwjhWG5Fd7u/FOia11tX14BAl4P88P
 QDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729538185; x=1730142985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XJlshyed/Hm9obK4873RTSaIjUnI3fci1pdF5H4p5hw=;
 b=El9W6HRkvmyo3A+KzA9kCwIWw7FJlX1vqb5F22/TNJCs5g4+1q0/q/pdFJt0fGBJeT
 jd5eCKDqjgQ43ienZ26pUJIlPB/XtwYuh1je0Sn1NcAXfSgQDpBZvRmvfpA5YjN4BECs
 QoWluYzvv4QJ6S/SrJcvvChLPOWvv8CgSTE20fvvN+2Mvzb8PxwfeMSI214mvzZroCP9
 IDyad2yHdeCzmZq1BiYVCCGf+WjwbnBt51o9DROgBkJOY7ogMJebaQTei2pxqiy84gHm
 Y4BdJrobOdiJgG8OiwSMdxQPGt3KO7RDlcoecVWsTS/KE+xr8o2HWc+Gv+xmMSxD5SWa
 qblA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr6zTzHhLSHtPl+2DdyuufUpKya5KvqQTgqq/bXaFwIz4L8jgaMk24cOlYXLkty9YHpSu+sGbyZLyA@nongnu.org
X-Gm-Message-State: AOJu0YyeB3noq97HIoJ2Kx+ArAS/XngbKlADPCwGlP6iKdgCMpkqw8G+
 Wx8QBEeVOjyulasNUTSWKlGBDlKkCl61pokDnrA7zjZ3xX2hdZD+5d+cIkToukA=
X-Google-Smtp-Source: AGHT+IEy60EL8w7pUX9H9+TkBDZM3X1gGf6nuspztzh/w+qP8YIsenLLMsZGl6VtgpHhuWpyq5GSIg==
X-Received: by 2002:a05:6a00:929d:b0:71e:7a56:3eaf with SMTP id
 d2e1a72fcca58-71ee5afa3b1mr279228b3a.24.1729538184070; 
 Mon, 21 Oct 2024 12:16:24 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:242b:63dc:6000:cdfb:8dda?
 ([2804:7f0:bcc0:242b:63dc:6000:cdfb:8dda])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1312d05sm3244505b3a.35.2024.10.21.12.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 12:16:23 -0700 (PDT)
Message-ID: <95b15e0e-41da-4ca0-8ff8-c38de43c3ff8@ventanamicro.com>
Date: Mon, 21 Oct 2024 16:16:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/14] util: Add RISC-V vector extension probe in
 cpuinfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-4-richard.henderson@linaro.org>
 <f9a4f4ac-fb69-438d-aff9-b333408c80f3@ventanamicro.com>
 <0e589c57-0b37-400f-ade7-0d35027559b3@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <0e589c57-0b37-400f-ade7-0d35027559b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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



On 10/21/24 3:52 PM, Richard Henderson wrote:
> On 10/21/24 11:25, Daniel Henrique Barboza wrote:
>> Hi,
>>
>> This patch is breaking a KVM guest that runs  with '-cpu host' in an emulated
>> Risc-V host. The break happens regardless of the RVV support in the emulated
>> host:
>>
>>
>> $ qemu-system-riscv64 \
>>      -machine virt,accel=kvm -m 2G -smp 1 \
>>      -cpu host \
>>      -nographic -snapshot \
>>      -kernel ./guest_imgs/Image \
>>      -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
>>      -append "root=/dev/ram rw console=ttyS0 earlycon=sbi"
>>
>> qemu-system-riscv64: ../util/cpuinfo-riscv.c:119: cpuinfo_init: Assertion `left == 0' failed.
>> Aborted
>>
>>
>> In a quick debug:
>>
>>
>> On 10/16/24 4:31 PM, Richard Henderson wrote:
>>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>>
>>> Add support for probing RISC-V vector extension availability in
>>> the backend. This information will be used when deciding whether
>>> to use vector instructions in code generation.
>>>
>>> Cache lg2(vlenb) for the backend. The storing of lg2(vlenb) means
>>> we can convert all of the division into subtraction.
>>>
>>> While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
>>> we use RISCV_HWPROBE_IMA_V instead. RISCV_HWPROBE_IMA_V is more
>>> strictly constrainted than RISCV_HWPROBE_EXT_ZVE64X. At least in
>>> current QEMU implemenation, the V vector extension depends on the
>>> zve64d extension.
>>>
>>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> Message-ID: <20241007025700.47259-2-zhiwei_liu@linux.alibaba.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   host/include/riscv/host/cpuinfo.h |  2 ++
>>>   util/cpuinfo-riscv.c              | 24 ++++++++++++++++++++++--
>>>   2 files changed, 24 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
>>> index 2b00660e36..cdc784e7b6 100644
>>> --- a/host/include/riscv/host/cpuinfo.h
>>> +++ b/host/include/riscv/host/cpuinfo.h
>>> @@ -10,9 +10,11 @@
>>>   #define CPUINFO_ZBA             (1u << 1)
>>>   #define CPUINFO_ZBB             (1u << 2)
>>>   #define CPUINFO_ZICOND          (1u << 3)
>>> +#define CPUINFO_ZVE64X          (1u << 4)
>>>   /* Initialized with a constructor. */
>>>   extern unsigned cpuinfo;
>>> +extern unsigned riscv_lg2_vlenb;
>>>   /*
>>>    * We cannot rely on constructor ordering, so other constructors must
>>> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
>>> index 8cacc67645..16114ffd32 100644
>>> --- a/util/cpuinfo-riscv.c
>>> +++ b/util/cpuinfo-riscv.c
>>> @@ -4,6 +4,7 @@
>>>    */
>>>   #include "qemu/osdep.h"
>>> +#include "qemu/host-utils.h"
>>>   #include "host/cpuinfo.h"
>>>   #ifdef CONFIG_ASM_HWPROBE_H
>>> @@ -13,6 +14,7 @@
>>>   #endif
>>>   unsigned cpuinfo;
>>> +unsigned riscv_lg2_vlenb;
>>>   static volatile sig_atomic_t got_sigill;
>>>   static void sigill_handler(int signo, siginfo_t *si, void *data)
>>> @@ -34,7 +36,7 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
>>>   /* Called both as constructor and (possibly) via other constructors. */
>>>   unsigned __attribute__((constructor)) cpuinfo_init(void)
>>>   {
>>> -    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
>>> +    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUINFO_ZVE64X;
>>
>>
>> This will init 'left' with 30 (2 + 4 + 8 + 16)
>>
>>
>>>       unsigned info = cpuinfo;
>>>       if (info) {
>>> @@ -50,6 +52,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>>>   #endif
>>>   #if defined(__riscv_arch_test) && defined(__riscv_zicond)
>>>       info |= CPUINFO_ZICOND;
>>> +#endif
>>> +#if defined(__riscv_arch_test) && defined(__riscv_zve64x)
>>> +    info |= CPUINFO_ZVE64X;
>>>   #endif
>>>       left &= ~info;
>>> @@ -65,7 +70,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>>>               && pair.key >= 0) {
>>>               info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
>>>               info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
>>> -            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
>>> +            info |= pair.value & RISCV_HWPROBE_IMA_V ? CPUINFO_ZVE64X : 0;
>>> +            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZVE64X);
>>>   #ifdef RISCV_HWPROBE_EXT_ZICOND
>>>               info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
>>>               left &= ~CPUINFO_ZICOND;
>>> @@ -113,6 +119,20 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>>>           assert(left == 0);
>>
>> To better understand, this is the 'if' block that contains this assert:
>>
>>      if (left) {
>>          struct sigaction sa_old, sa_new;
>>
>>          memset(&sa_new, 0, sizeof(sa_new));
>>          sa_new.sa_flags = SA_SIGINFO;
>>          sa_new.sa_sigaction = sigill_handler;
>>          sigaction(SIGILL, &sa_new, &sa_old);
>>
>>          if (left & CPUINFO_ZBA) {
>>              /* Probe for Zba: add.uw zero,zero,zero. */
>>              got_sigill = 0;
>>              asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero"
>>                           : : : "memory");
>>              info |= got_sigill ? 0 : CPUINFO_ZBA;
>>              left &= ~CPUINFO_ZBA;
>>          }
>>
>>          if (left & CPUINFO_ZBB) {
>>              /* Probe for Zbb: andn zero,zero,zero. */
>>              got_sigill = 0;
>>              asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero"
>>                           : : : "memory");
>>              info |= got_sigill ? 0 : CPUINFO_ZBB;
>>              left &= ~CPUINFO_ZBB;
>>          }
>>
>>          if (left & CPUINFO_ZICOND) {
>>              /* Probe for Zicond: czero.eqz zero,zero,zero. */
>>              got_sigill = 0;
>>              asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero"
>>                           : : : "memory");
>>              info |= got_sigill ? 0 : CPUINFO_ZICOND;
>>              left &= ~CPUINFO_ZICOND;
>>          }
>>
>>          sigaction(SIGILL, &sa_old, NULL);
>>          assert(left == 0);
>>      }
>>
>>
>> The 'assert' is hit at this point because left is 16, i.e. left = CPUINFO_ZVE64X.
>>
>> I did a fix based on what seems to be the usual flow of how 'left' is being calculated:
>>
>>
>> $ git diff
>> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
>> index 16114ffd32..25a98a75ad 100644
>> --- a/util/cpuinfo-riscv.c
>> +++ b/util/cpuinfo-riscv.c
>> @@ -115,24 +115,27 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>>               left &= ~CPUINFO_ZICOND;
>>           }
>>
>> +        if (left & CPUINFO_ZVE64X) {
>> +            /*
>> +             * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
>> +             * We are guaranteed by Zve64x that VLEN >= 64, and that
>> +             * EEW of {8,16,32,64} are supported.
>> +             *
>> +             * Cache VLEN in a convenient form.
>> +             */
>> +            unsigned long vlenb;
>> +            got_sigill = 0;
>> +            /* Read csr "vlenb" with "csrr %0, vlenb" : "=r"(vlenb) */
>> +            asm volatile(".insn i 0x73, 0x2, %0, zero, -990" : "=r"(vlenb));
>> +            info |= got_sigill ? 0 : CPUINFO_ZVE64X;
>> +            left &= ~CPUINFO_ZVE64X;
>> +            riscv_lg2_vlenb = ctz32(vlenb);
>> +        }
>> +
>>           sigaction(SIGILL, &sa_old, NULL);
>>           assert(left == 0);
>>       }
>>
>> -    if (info & CPUINFO_ZVE64X) {
>> -        /*
>> -         * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
>> -         * We are guaranteed by Zve64x that VLEN >= 64, and that
>> -         * EEW of {8,16,32,64} are supported.
>> -         *
>> -         * Cache VLEN in a convenient form.
>> -         */
>> -        unsigned long vlenb;
>> -        /* Read csr "vlenb" with "csrr %0, vlenb" : "=r"(vlenb) */
>> -        asm volatile(".insn i 0x73, 0x2, %0, zero, -990" : "=r"(vlenb));
>> -        riscv_lg2_vlenb = ctz32(vlenb);
>> -    }
>> -
>>       info |= CPUINFO_ALWAYS;
>>       cpuinfo = info;
>>       return info;
>>
>>
>>
>> i.e. I moved the CPUINFO_ZVE64X inside the 'if (left)' block, then update both 'info' and
>> 'left' depending on if we found the vlenb CSR.
>>
>> Note that this fixes the issue I'm seeing (KVM guest boot), but I can't say if the original
>> intent of the patch is preserved. If this is a good fix feel free to squash this diff into
>> the patch.
> 
> This is not a good fix.  The vlenb probe must happen whenever vector support is detected -- it is not for detection itself.
> 
> It is my understanding that kernel support for riscv_hwprobe pre-dates kernel support for vectors in userspace.  I believe that we really don't care about old kernel header installs.
> 
> Therefore we should simply
> 
>      left &= ~CPUINFO_ZVE64X;
> 
> with a comment after the CONFIG_ASM_HWPROBE_H block.
> 
> I'll post a v7 for testing.

Put me in Cc for v7 and I'll give it a go. Thanks,

Daniel


> 
> 
> r~

