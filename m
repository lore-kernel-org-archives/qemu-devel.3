Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3ECC54798
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 03:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rftnV-0003xk-Ol; Thu, 29 Feb 2024 22:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rftnT-0003x5-FV; Thu, 29 Feb 2024 22:42:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rftnQ-0002bY-R4; Thu, 29 Feb 2024 22:42:55 -0500
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TmDPk4sLZz2Bdgx;
 Fri,  1 Mar 2024 11:40:26 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 2DE191A0172;
 Fri,  1 Mar 2024 11:42:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 11:42:42 +0800
Message-ID: <10add4f2-68c5-14df-59d7-f6e27457c8b5@huawei.com>
Date: Fri, 1 Mar 2024 11:42:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v5 12/22] target/arm: Handle NMI in
 arm_cpu_do_interrupt_aarch64()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-13-ruanjinjie@huawei.com>
 <e7fd1fba-ee1d-4b78-b743-128fa8217ed8@linaro.org>
In-Reply-To: <e7fd1fba-ee1d-4b78-b743-128fa8217ed8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=ruanjinjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.176,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 2024/3/1 7:09, Richard Henderson wrote:
> On 2/29/24 03:10, Jinjie Ruan via wrote:
>> According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
>> with superpriority is always IRQ, never FIQ, so the NMI exception trap
>> entry
>> behave like IRQ. However, VNMI can be IRQ or FIQ, FIQ can only come from
>> hcrx_el2.HCRX_VFNMI bit, IRQ can be raised from the GIC or come from the
>> hcrx_el2.HCRX_VINMI bit.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v4:
>> - Also handle VNMI in arm_cpu_do_interrupt_aarch64().
>> v3:
>> - Remove the FIQ NMI handle.
>> ---
>>   target/arm/helper.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index b796dbdf21..bd34b3506a 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -11459,12 +11459,21 @@ static void
>> arm_cpu_do_interrupt_aarch64(CPUState *cs)
>>           break;
>>       case EXCP_IRQ:
>>       case EXCP_VIRQ:
>> +    case EXCP_NMI:
>>           addr += 0x80;
>>           break;
>>       case EXCP_FIQ:
>>       case EXCP_VFIQ:
>>           addr += 0x100;
>>           break;
>> +    case EXCP_VNMI:
>> +        if (env->irq_line_state & CPU_INTERRUPT_VNMI ||
>> +            env->cp15.hcrx_el2 & HCRX_VINMI) {
>> +            addr += 0x80;
>> +        } else if (env->cp15.hcrx_el2 & HCRX_VFNMI) {
>> +            addr += 0x100;
>> +        }
>> +        break;
> 
> By not combining VFNMI with CPU_INTERRUPT_VNMI, you don't need this
> complication.
> Just
> 
>      case EXCP_IRQ:
>      case EXCP_VIRQ:
> +    case EXCP_NMI:

Not understand it. both VIRQ and VFIQ will set CPU_INTERRUPT_VNMI and
cause EXCP_VNMI if they have Superpriority, the distinction jump here is
necessary.

> 
> 
> r~

