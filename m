Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD3DC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 02:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcyve-0003UN-Bi; Wed, 21 Feb 2024 21:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcyva-0003Rt-0d; Wed, 21 Feb 2024 21:35:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcyvR-0000Cu-3y; Wed, 21 Feb 2024 21:35:12 -0500
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TgHHN2jtHz1h04l;
 Thu, 22 Feb 2024 10:32:48 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C6341402CD;
 Thu, 22 Feb 2024 10:34:57 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 10:34:56 +0800
Message-ID: <8978f3e1-b5b3-1a39-fe18-9e294b1bce07@huawei.com>
Date: Thu, 22 Feb 2024 10:34:56 +0800
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
In-Reply-To: <9fb9c74e-e4d3-4a8b-b736-c8603414245c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
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



On 2024/2/22 3:09, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> Add ALLINT MSR (immediate) to decodetree. And the EL0 check is necessary
>> to ALLINT. Avoid the unconditional write to pc and use raise_exception_ra
>> to unwind.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   target/arm/tcg/a64.decode      |  1 +
>>   target/arm/tcg/helper-a64.c    | 24 ++++++++++++++++++++++++
>>   target/arm/tcg/helper-a64.h    |  1 +
>>   target/arm/tcg/translate-a64.c | 10 ++++++++++
>>   4 files changed, 36 insertions(+)
>>
>> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
>> index 8a20dce3c8..3588080024 100644
>> --- a/target/arm/tcg/a64.decode
>> +++ b/target/arm/tcg/a64.decode
>> @@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010
>> 11111 @msr_i
>>   MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
>>   MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
>>   MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
>> +MSR_i_ALLINT    1101 0101 0000 0 001 0100 .... 000 11111 @msr_i
>>   MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
>>     # MRS, MSR (register), SYS, SYSL. These are all essentially the
>> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
>> index ebaa7f00df..3686926ada 100644
>> --- a/target/arm/tcg/helper-a64.c
>> +++ b/target/arm/tcg/helper-a64.c
>> @@ -66,6 +66,30 @@ void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t
>> imm)
>>       update_spsel(env, imm);
>>   }
>>   +static void allint_check(CPUARMState *env, uint32_t op,
>> +                       uint32_t imm, uintptr_t ra)
>> +{
>> +    /* ALLINT update to PSTATE. */
>> +    if (arm_current_el(env) == 0) {
>> +        raise_exception_ra(env, EXCP_UDEF,
>> +                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
>> +                                               extract32(op, 3, 3), 4,
>> +                                               imm, 0x1f, 0),
>> +                           exception_target_el(env), ra);
>> +    }
>> +}
> 
> A runtime check for EL0 is not necessary; you've already handled that in
> trans_MSR_i_ALLINT().  However, what *is* missing here is the test
> against TALLINT for EL1.

Thank you! I'll fix it.

> 
>> +
>> +void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
>> +{
>> +    allint_check(env, 0x8, imm, GETPC());
>> +    if (imm == 1) {
>> +        env->allint |= PSTATE_ALLINT;
>> +    } else {
>> +        env->allint &= ~PSTATE_ALLINT;
>> +    }
> 
> I think you should not write an immediate-specific helper, but one which
> can also handle the variable "MSR allint, <xt>".  This is no more
> difficult than

The kernel patches now uses the immediate-specific helper only, so it is
necessary for test.

> 
> void HELPER(msr_allint)(CPUARMState *env, target_ulong val)
> {
>     ... check ...
>     env->pstate = (env->pstate & ~PSTATE_ALLINT) | (val & PSTATE_ALLINT);
> }
> 
>> +    arm_rebuild_hflags(env);
>> +}
> 
> allint does not affect hflags; no rebuild required.

Thank you! I'll fix it.

> 
>> +static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
>> +{
>> +    if (!dc_isar_feature(aa64_nmi, s) || s->current_el == 0) {
>> +        return false;
>> +    }
>> +    gen_helper_msr_i_allint(tcg_env, tcg_constant_i32(a->imm));
> 
> You're passing all of #imm4, not #imm1, which meant the test in your
> msr_i_allint helper was wrong.

In fact, it's either 0 or 1 for CRm according to the arm manual, so it
is not necessary.

> 
> To work with the generalized helper above, this would be
> 
>     tcg_constant_tl((a->imm & 1) * PSTATE_ALLINT);
> 
> 
> r~

