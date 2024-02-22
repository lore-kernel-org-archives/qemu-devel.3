Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D71C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 02:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcz0w-0004Yf-4N; Wed, 21 Feb 2024 21:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcz0u-0004Y2-62; Wed, 21 Feb 2024 21:40:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcz0r-000154-RU; Wed, 21 Feb 2024 21:40:43 -0500
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TgHPv1kLsz2Bd2d;
 Thu, 22 Feb 2024 10:38:27 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id AB42B1A0172;
 Thu, 22 Feb 2024 10:40:36 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 10:40:36 +0800
Message-ID: <ab2e74b1-31f6-807d-430f-22a2cc63291c@huawei.com>
Date: Thu, 22 Feb 2024 10:40:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v2 04/22] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-5-ruanjinjie@huawei.com>
 <9fb9c74e-e4d3-4a8b-b736-c8603414245c@linaro.org>
 <0911d6a4-7fd6-4d0f-83a8-ec4ba8420297@linaro.org>
In-Reply-To: <0911d6a4-7fd6-4d0f-83a8-ec4ba8420297@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=ruanjinjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.297,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2024/2/22 4:41, Richard Henderson wrote:
> On 2/21/24 09:09, Richard Henderson wrote:
>> On 2/21/24 03:08, Jinjie Ruan via wrote:
>>> Add ALLINT MSR (immediate) to decodetree. And the EL0 check is necessary
>>> to ALLINT. Avoid the unconditional write to pc and use
>>> raise_exception_ra
>>> to unwind.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>   target/arm/tcg/a64.decode      |  1 +
>>>   target/arm/tcg/helper-a64.c    | 24 ++++++++++++++++++++++++
>>>   target/arm/tcg/helper-a64.h    |  1 +
>>>   target/arm/tcg/translate-a64.c | 10 ++++++++++
>>>   4 files changed, 36 insertions(+)
>>>
>>> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
>>> index 8a20dce3c8..3588080024 100644
>>> --- a/target/arm/tcg/a64.decode
>>> +++ b/target/arm/tcg/a64.decode
>>> @@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 ....
>>> 010 11111 @msr_i
>>>   MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
>>>   MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
>>>   MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
>>> +MSR_i_ALLINT    1101 0101 0000 0 001 0100 .... 000 11111 @msr_i
>>>   MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
>>>   # MRS, MSR (register), SYS, SYSL. These are all essentially the
>>> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
>>> index ebaa7f00df..3686926ada 100644
>>> --- a/target/arm/tcg/helper-a64.c
>>> +++ b/target/arm/tcg/helper-a64.c
>>> @@ -66,6 +66,30 @@ void HELPER(msr_i_spsel)(CPUARMState *env,
>>> uint32_t imm)
>>>       update_spsel(env, imm);
>>>   }
>>> +static void allint_check(CPUARMState *env, uint32_t op,
>>> +                       uint32_t imm, uintptr_t ra)
>>> +{
>>> +    /* ALLINT update to PSTATE. */
>>> +    if (arm_current_el(env) == 0) {
>>> +        raise_exception_ra(env, EXCP_UDEF,
>>> +                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
>>> +                                               extract32(op, 3, 3), 4,
>>> +                                               imm, 0x1f, 0),
>>> +                           exception_target_el(env), ra);
>>> +    }
>>> +}
>>
>> A runtime check for EL0 is not necessary; you've already handled that
>> in trans_MSR_i_ALLINT().  However, what *is* missing here is the test
>> against TALLINT for EL1.
>>
>>> +
>>> +void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
>>> +{
>>> +    allint_check(env, 0x8, imm, GETPC());
>>> +    if (imm == 1) {
>>> +        env->allint |= PSTATE_ALLINT;
>>> +    } else {
>>> +        env->allint &= ~PSTATE_ALLINT;
>>> +    }
>>
>> I think you should not write an immediate-specific helper, but one
>> which can also handle the variable "MSR allint, <xt>".  This is no
>> more difficult than
>>
>> void HELPER(msr_allint)(CPUARMState *env, target_ulong val)
>> {
>>      ... check ...
>>      env->pstate = (env->pstate & ~PSTATE_ALLINT) | (val &
>> PSTATE_ALLINT);
>> }
> 
> Ho hum..  I just noticed that TALLINT only traps immediate write of 1,
> not also immediate write of 0.  So one helper for both MSR Xt and MSR
> imm is not practical.

it is a real problem.

> 
> 
> r~

