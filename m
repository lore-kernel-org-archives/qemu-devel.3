Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DDDC54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQdq-0002hu-K9; Sun, 25 Feb 2024 21:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1reQdl-0002h4-T7; Sun, 25 Feb 2024 21:22:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1reQdh-0006xr-DK; Sun, 25 Feb 2024 21:22:49 -0500
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tjkq45hjGz1X3QS;
 Mon, 26 Feb 2024 10:20:16 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 149381400D3;
 Mon, 26 Feb 2024 10:22:30 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 10:22:29 +0800
Message-ID: <138ddc99-f6f4-9907-a1c2-6b2b88bd79d0@huawei.com>
Date: Mon, 26 Feb 2024 10:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v3 04/21] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-5-ruanjinjie@huawei.com>
 <9b20584a-3c4c-47a2-bf42-f8d7d4eabd9f@linaro.org>
In-Reply-To: <9b20584a-3c4c-47a2-bf42-f8d7d4eabd9f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ruanjinjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.331,
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



On 2024/2/24 3:03, Richard Henderson wrote:
> On 2/23/24 00:32, Jinjie Ruan via wrote:
>> Add ALLINT MSR (immediate) to decodetree. And the EL0 check is necessary
>> to ALLINT. Avoid the unconditional write to pc and use raise_exception_ra
>> to unwind.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v3:
>> - Remove EL0 check in allint_check().
>> - Add TALLINT check for EL1 in allint_check().
>> - Remove unnecessarily arm_rebuild_hflags() in msr_i_allint helper.
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
> 
> Decode is incorrect either here, or in trans_MSR_i_ALLINT, because CRm
> != '000x' is UNDEFINED.
> 
> MSR_i_ALLINT    1101 0101 0000 0 001 0100 000 imm:1 000 11111
> 
> is perhaps the clearest implementation.
> 
>> +static void allint_check(CPUARMState *env, uint32_t op,
>> +                       uint32_t imm, uintptr_t ra)
>> +{
>> +    /* ALLINT update to PSTATE. */
>> +    if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
>> +        (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {
>> +        raise_exception_ra(env, EXCP_UDEF,
>> +                           syn_aa64_sysregtrap(0, extract32(op, 0, 3),
>> +                                               extract32(op, 3, 3), 4,
>> +                                               imm, 0x1f, 0),
>> +                           exception_target_el(env), ra);
>> +    }
>> +}
>> +
>> +void HELPER(msr_i_allint)(CPUARMState *env, uint32_t imm)
>> +{
>> +    allint_check(env, 0x8, imm, GETPC());
> 
> As previously noted, the check for MSR_i only applies to imm==1, not 0.

Sorry! The hardware manual I looked at didn't say this.

> 
> As previously noted, with ALLINT in env->pstate, you can implement this
> completely inline for EL[23], or EL1 with imm==0.
> 
> No point in passing in "op" and extracting, because you know exactly
> what the value should be for all MSR ALLINT.
> 
> 
> r~

