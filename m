Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E210BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 05:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqn2r-0004zd-BG; Wed, 18 Sep 2024 01:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sqn2n-0004yc-G8; Wed, 18 Sep 2024 01:16:01 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sqn2h-0003s0-Na; Wed, 18 Sep 2024 01:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726636542; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=InNITQKPzGA3TIvmfVIHoPSNCFwmwMHP7Zbh5w2mv0Q=;
 b=EQrFw0ltJold2UwircwVz3N+4oe3Zl6M6Lg/SRBmtX5Amd16TBLPZ4vo2gghU6/6rhd1C6ZbQjqmClNiNnN33vG3g7UZ243e6BeHz0WW8iQe8T2LROflTXYHVzW9pFkM75RsE62Cs1kEd9y3h3rcc0uMWqkx7uG4EQGI74RFxnE=
Received: from 30.166.64.79(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WFCsz4E_1726636539) by smtp.aliyun-inc.com;
 Wed, 18 Sep 2024 13:15:40 +0800
Message-ID: <0f3b7593-5963-40e4-9c4b-010081aa3b9a@linux.alibaba.com>
Date: Wed, 18 Sep 2024 13:14:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] util: Add RISC-V vector extension probe in
 cpuinfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-2-zhiwei_liu@linux.alibaba.com>
 <6c97e5d3-75a9-4884-8a6f-6498dfc5b12d@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <6c97e5d3-75a9-4884-8a6f-6498dfc5b12d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/9/12 2:34, Richard Henderson wrote:
> On 9/11/24 06:26, LIU Zhiwei wrote:
>> While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
>> we use RISCV_HWPROBE_IMA_V instead.
>
> Language is incorrect here.  The compiler has nothing to do with it.
> Perhaps "If the installed kernel header files do not support...".
OK. Thanks.
>
> However, if you use only RISCV_HWPROBE_IMA_V, then you do not have any 
> of the additional guarantees of Zve64x.

IMHO, RISCV_HWPROBE_IMA_V is more strictly constrainted than 
RISCV_HWPROBE_EXT_ZVE64X.
At least in current QEMU implemenation, the V vector extension depends 
on the Zve64d extension.

Thanks,
Zhiwei

> The kernel api for RISCV_HWPROBE_EXT_ZVE64X was introduced in 6.10.
> If that is acceptable as a minimum, the simplest solution is
>
> #ifndef RISCV_HWPROBE_EXT_ZVE64X
> #define RISCV_HWPROBE_EXT_ZVE64X        (1ULL << 39)
> #endif
>
> If the running kernel is old, then the bit will not be set and we will 
> not attempt to use RVV.
>
> If we need to support older kernels, then we'll have to go back to 
> probing with vsetvl to determine if all of the additional guarantees 
> of Zve64x are met.
>
>
> r~
>
>
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   host/include/riscv/host/cpuinfo.h |  2 ++
>>   util/cpuinfo-riscv.c              | 24 ++++++++++++++++++++++--
>>   2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/host/include/riscv/host/cpuinfo.h 
>> b/host/include/riscv/host/cpuinfo.h
>> index 2b00660e36..cdc784e7b6 100644
>> --- a/host/include/riscv/host/cpuinfo.h
>> +++ b/host/include/riscv/host/cpuinfo.h
>> @@ -10,9 +10,11 @@
>>   #define CPUINFO_ZBA             (1u << 1)
>>   #define CPUINFO_ZBB             (1u << 2)
>>   #define CPUINFO_ZICOND          (1u << 3)
>> +#define CPUINFO_ZVE64X          (1u << 4)
>>     /* Initialized with a constructor. */
>>   extern unsigned cpuinfo;
>> +extern unsigned riscv_lg2_vlenb;
>>     /*
>>    * We cannot rely on constructor ordering, so other constructors must
>> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
>> index 497ce12680..bab782745b 100644
>> --- a/util/cpuinfo-riscv.c
>> +++ b/util/cpuinfo-riscv.c
>> @@ -4,6 +4,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "qemu/host-utils.h"
>>   #include "host/cpuinfo.h"
>>     #ifdef CONFIG_ASM_HWPROBE_H
>> @@ -12,6 +13,7 @@
>>   #endif
>>     unsigned cpuinfo;
>> +unsigned riscv_lg2_vlenb;
>>   static volatile sig_atomic_t got_sigill;
>>     static void sigill_handler(int signo, siginfo_t *si, void *data)
>> @@ -33,7 +35,7 @@ static void sigill_handler(int signo, siginfo_t 
>> *si, void *data)
>>   /* Called both as constructor and (possibly) via other 
>> constructors. */
>>   unsigned __attribute__((constructor)) cpuinfo_init(void)
>>   {
>> -    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
>> +    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | 
>> CPUINFO_ZVE64X;
>>       unsigned info = cpuinfo;
>>         if (info) {
>> @@ -49,6 +51,9 @@ unsigned __attribute__((constructor)) 
>> cpuinfo_init(void)
>>   #endif
>>   #if defined(__riscv_arch_test) && defined(__riscv_zicond)
>>       info |= CPUINFO_ZICOND;
>> +#endif
>> +#if defined(__riscv_arch_test) && defined(__riscv_zve64x)
>> +    info |= CPUINFO_ZVE64X;
>>   #endif
>>       left &= ~info;
>>   @@ -64,7 +69,8 @@ unsigned __attribute__((constructor)) 
>> cpuinfo_init(void)
>>               && pair.key >= 0) {
>>               info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? 
>> CPUINFO_ZBA : 0;
>>               info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? 
>> CPUINFO_ZBB : 0;
>> -            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
>> +            info |= pair.value & RISCV_HWPROBE_IMA_V ? 
>> CPUINFO_ZVE64X : 0;
>> +            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZVE64X);
>>   #ifdef RISCV_HWPROBE_EXT_ZICOND
>>               info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? 
>> CPUINFO_ZICOND : 0;
>>               left &= ~CPUINFO_ZICOND;
>> @@ -112,6 +118,20 @@ unsigned __attribute__((constructor)) 
>> cpuinfo_init(void)
>>           assert(left == 0);
>>       }
>>   +    if (info & CPUINFO_ZVE64X) {
>> +        /*
>> +         * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
>> +         * We are guaranteed by Zve64x that VLEN >= 64, and that
>> +         * EEW of {8,16,32,64} are supported.
>> +         *
>> +         * Cache VLEN in a convenient form.
>> +         */
>> +        unsigned long vlenb;
>> +        /* Read csr "vlenb" with "csrr %0, vlenb" : "=r"(vlenb) */
>> +        asm volatile(".insn i 0x73, 0x2, %0, zero, -990" : 
>> "=r"(vlenb));
>> +        riscv_lg2_vlenb = ctz32(vlenb);
>> +    }
>> +
>>       info |= CPUINFO_ALWAYS;
>>       cpuinfo = info;
>>       return info;
>

