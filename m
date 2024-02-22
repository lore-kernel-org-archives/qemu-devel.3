Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DE2C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 03:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd06t-0007SS-9A; Wed, 21 Feb 2024 22:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd06r-0007Re-5j; Wed, 21 Feb 2024 22:50:57 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rd06o-0004MD-8m; Wed, 21 Feb 2024 22:50:56 -0500
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TgJzl4qspzNlmc;
 Thu, 22 Feb 2024 11:49:23 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 794AD14011D;
 Thu, 22 Feb 2024 11:50:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 11:50:46 +0800
Message-ID: <09fde4c7-2000-5e78-f33d-c80fbcd49405@huawei.com>
Date: Thu, 22 Feb 2024 11:50:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v2 05/22] target/arm: Support MSR access to ALLINT
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-6-ruanjinjie@huawei.com>
 <699fbf87-8f24-4d3d-b230-f956ce371f20@linaro.org>
In-Reply-To: <699fbf87-8f24-4d3d-b230-f956ce371f20@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=ruanjinjie@huawei.com; helo=szxga03-in.huawei.com
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.297,
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



On 2024/2/22 3:28, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> Support ALLINT msr access as follow:
>>     mrs <xt>, ALLINT    // read allint
>>     msr ALLINT, <xt>    // write allint with imm
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   target/arm/helper.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index a3062cb2ad..211156d640 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -4618,6 +4618,31 @@ static void aa64_daif_write(CPUARMState *env,
>> const ARMCPRegInfo *ri,
>>       env->daif = value & PSTATE_DAIF;
>>   }
>>   +static void aa64_allint_write(CPUARMState *env, const ARMCPRegInfo
>> *ri,
>> +                              uint64_t value)
>> +{
>> +    env->allint = value & PSTATE_ALLINT;
>> +}
>> +
>> +static uint64_t aa64_allint_read(CPUARMState *env, const ARMCPRegInfo
>> *ri)
>> +{
>> +    return env->allint & PSTATE_ALLINT;
>> +}
>> +
>> +static CPAccessResult aa64_allint_access(CPUARMState *env,
>> +                                         const ARMCPRegInfo *ri, bool
>> isread)
>> +{
>> +    if (arm_current_el(env) == 0) {
>> +        return CP_ACCESS_TRAP_UNCATEGORIZED;
>> +    }
> 
> This is handled by .access PL1_RW.
> 
>> +
>> +    if (arm_current_el(env) == 1 && arm_is_el2_enabled(env) &&
>> +        cpu_isar_feature(aa64_hcx, env_archcpu(env)) &&
>> +        (env->cp15.hcrx_el2 & HCRX_TALLINT))
>> +        return CP_ACCESS_TRAP_EL2;
> 
> You should be using arm_hcrx_el2_eff(env).
> Missing braces.

I'll fix it, thank you!

> 
>> @@ -5437,6 +5462,13 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>>         .access = PL0_RW, .accessfn = aa64_daif_access,
>>         .fieldoffset = offsetof(CPUARMState, daif),
>>         .writefn = aa64_daif_write, .resetfn = arm_cp_reset_ignore },
>> +    { .name = "ALLINT", .state = ARM_CP_STATE_AA64,
>> +      .opc0 = 3, .opc1 = 0, .opc2 = 0, .crn = 4, .crm = 3,
>> +      .type = ARM_CP_NO_RAW,
>> +      .access = PL1_RW, .accessfn = aa64_allint_access,
>> +      .fieldoffset = offsetof(CPUARMState, allint),
>> +      .writefn = aa64_allint_write, .readfn = aa64_allint_read,
>> +      .resetfn = arm_cp_reset_ignore },
> 
> You cannot add ALLINT here in v8_cp_reginfo[].
> Compare fgt_reginfo[], and how it is registered.

I'll fix it, thank you!

> 
> 
> r~

