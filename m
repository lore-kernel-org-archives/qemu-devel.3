Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B425C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8I1-0002lj-9R; Thu, 22 Feb 2024 07:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd8Hy-0002l6-VE; Thu, 22 Feb 2024 07:34:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd8Hw-0001cj-17; Thu, 22 Feb 2024 07:34:58 -0500
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TgXbW2rz3z1X2pv;
 Thu, 22 Feb 2024 20:32:39 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 87B8A1A016B;
 Thu, 22 Feb 2024 20:34:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 20:34:48 +0800
Message-ID: <1fada83b-a862-c705-5997-1d8d269d8de2@huawei.com>
Date: Thu, 22 Feb 2024 20:34:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v2 08/22] target/arm: Handle IS/FS in ISR_EL1 for NMI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-9-ruanjinjie@huawei.com>
 <edbe3faa-d83e-4410-811a-d15fe244817a@linaro.org>
In-Reply-To: <edbe3faa-d83e-4410-811a-d15fe244817a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ruanjinjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.172,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/2/22 5:36, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> Add IS and FS bit in ISR_EL1 and handle the read according to whether the
>> NMI is IRQ or FIQ.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   target/arm/cpu.h    | 2 ++
>>   target/arm/helper.c | 9 +++++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 051e589e19..e2d07e3312 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1476,6 +1476,8 @@ FIELD(CPTR_EL3, TCPAC, 31, 1)
>>   #define CPSR_N (1U << 31)
>>   #define CPSR_NZCV (CPSR_N | CPSR_Z | CPSR_C | CPSR_V)
>>   #define CPSR_AIF (CPSR_A | CPSR_I | CPSR_F)
>> +#define ISR_FS (1U << 9)
>> +#define ISR_IS (1U << 10)
>>     #define CPSR_IT (CPSR_IT_0_1 | CPSR_IT_2_7)
>>   #define CACHED_CPSR_BITS (CPSR_T | CPSR_AIF | CPSR_GE | CPSR_IT |
>> CPSR_Q \
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 0bd7a87e51..62c8e5d611 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2022,6 +2022,10 @@ static uint64_t isr_read(CPUARMState *env,
>> const ARMCPRegInfo *ri)
>>           if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
>>               ret |= CPSR_I;
>>           }
>> +
>> +        if ((cs->interrupt_request & CPU_INTERRUPT_NMI) &&
>> env->nmi_is_irq) {
>> +            ret |= ISR_IS;
>> +        }
>>       }
>>         if (hcr_el2 & HCR_FMO) {
>> @@ -2032,6 +2036,11 @@ static uint64_t isr_read(CPUARMState *env,
>> const ARMCPRegInfo *ri)
>>           if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
>>               ret |= CPSR_F;
>>           }
>> +
>> +        if ((cs->interrupt_request & CPU_INTERRUPT_NMI) &&
>> +            (!env->nmi_is_irq)) {
>> +            ret |= ISR_FS;
>> +        }
>>       }
> 
> The external CPU_INTERRUPT_NMI will never signal FIQ.
> 
> With CPU_INTERRUPT_NMI, both CPSR_I and ISR_IS must be set.

Right! The IRQ and NMI signal are both set when it is a NMI.
> 
> Missing is the handling of HCRX_EL2.{VFNMI,VINMI} to signal vFIQ and
> vIRQ with superpriority.  Unless I missed it, I don't see HCRX_EL2
> adjusted for FEAT_NMI at all.

Sorry! The vNMI has not yet been implemented.

The HCRX_EL2.TALLINT has yet been handled.

> 
> 
> r~
> 

