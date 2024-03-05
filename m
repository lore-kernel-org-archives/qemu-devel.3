Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B878C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLwp-0002hp-KI; Mon, 04 Mar 2024 22:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rhLwn-0002ha-Rl; Mon, 04 Mar 2024 22:58:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rhLwj-0002QI-P2; Mon, 04 Mar 2024 22:58:32 -0500
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TphYw5tlyz1h1QB;
 Tue,  5 Mar 2024 11:56:04 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D32F1A016C;
 Tue,  5 Mar 2024 11:58:24 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 11:58:24 +0800
Message-ID: <ea5079e4-202e-a5d5-1c16-98b31a755f80@huawei.com>
Date: Tue, 5 Mar 2024 11:58:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v5 18/22] hw/intc/arm_gicv3: Implement NMI interrupt
 prioirty
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-19-ruanjinjie@huawei.com>
 <85d632e6-8eb9-4bb5-bef4-b6430d499e61@linaro.org>
 <895fa382-1c0f-ae33-ba6b-76387506ad16@huawei.com>
Content-Language: en-US
In-Reply-To: <895fa382-1c0f-ae33-ba6b-76387506ad16@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -82
X-Spam_score: -8.3
X-Spam_bar: --------
X-Spam_report: (-8.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.098,
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



On 2024/3/4 20:18, Jinjie Ruan wrote:
> 
> 
> On 2024/3/1 7:50, Richard Henderson wrote:
>> On 2/29/24 03:10, Jinjie Ruan via wrote:
>>> If GICD_CTLR_DS bit is zero and the NMI is non-secure, the NMI prioirty
>>> is higher than 0x80, otherwise it is higher than 0x0. And save NMI
>>> super prioirty information in hppi.superprio to deliver NMI exception.
>>> Since both GICR and GICD can deliver NMI, it is both necessary to check
>>> whether the pending irq is NMI in gicv3_redist_update_noirqset and
>>> gicv3_update_noirqset. And In irqbetter(), only a non-NMI with the same
>>> priority and a smaller interrupt number can be preempted but not NMI.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>> v4:
>>> - Replace is_nmi with has_superprio to not a mix NMI and superpriority.
>>> - Update the comment in irqbetter().
>>> - Extract gicv3_get_priority() to avoid code repeat.
>>> ---
>>> v3:
>>> - Add missing brace
>>> ---
>>>   hw/intc/arm_gicv3.c | 71 ++++++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 63 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
>>> index 0b8f79a122..1d16a53b23 100644
>>> --- a/hw/intc/arm_gicv3.c
>>> +++ b/hw/intc/arm_gicv3.c
>>> @@ -21,7 +21,8 @@
>>>   #include "hw/intc/arm_gicv3.h"
>>>   #include "gicv3_internal.h"
>>>   -static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
>>> +static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio,
>>> +                      bool has_superprio)
>>>   {
>>>       /* Return true if this IRQ at this priority should take
>>>        * precedence over the current recorded highest priority
>>> @@ -33,11 +34,24 @@ static bool irqbetter(GICv3CPUState *cs, int irq,
>>> uint8_t prio)
>>>       if (prio < cs->hppi.prio) {
>>>           return true;
>>>       }
>>> +
>>> +    /*
>>> +     * Current highest prioirity pending interrupt is an IRQ without
>>> +     * superpriority, the new IRQ with superpriority has same priority
>>> +     * should signal to the CPU as it have the priority higher than
>>> +     * the labelled 0x80 or 0x00.
>>> +     */
>>> +    if (prio == cs->hppi.prio && !cs->hppi.superprio && has_superprio) {
>>> +        return true;
>>> +    }
>>> +
>>>       /* If multiple pending interrupts have the same priority then it
>>> is an
>>>        * IMPDEF choice which of them to signal to the CPU. We choose to
>>> -     * signal the one with the lowest interrupt number.
>>> +     * signal the one with the lowest interrupt number if they don't
>>> have
>>> +     * superpriority.
>>>        */
>>> -    if (prio == cs->hppi.prio && irq <= cs->hppi.irq) {
>>> +    if (prio == cs->hppi.prio && !cs->hppi.superprio &&
>>> +        !has_superprio && irq <= cs->hppi.irq) {
>>>           return true;
>>>       }
>>>       return false;
>>> @@ -129,6 +143,35 @@ static uint32_t gicr_int_pending(GICv3CPUState *cs)
>>>       return pend;
>>>   }
>>>   +static bool gicv3_get_priority(GICv3CPUState *cs, bool is_redist,
>>> +                               uint32_t superprio, uint8_t *prio, int
>>> irq)
>>> +{
>>> +    bool has_superprio = false;
>>> +
>>> +    if (superprio) {
>>> +        has_superprio = true;
>>> +
>>> +        /* DS = 0 & Non-secure NMI */
>>> +        if (!(cs->gic->gicd_ctlr & GICD_CTLR_DS) &&
>>> +            ((is_redist && extract32(cs->gicr_igroupr0, irq, 1)) ||
>>> +             (!is_redist && gicv3_gicd_group_test(cs->gic, irq)))) {
>>> +            *prio = 0x80;
>>> +        } else {
>>> +            *prio = 0x0;
>>> +        }
>>> +    } else {
>>> +        has_superprio = false;
>>> +
>>> +        if (is_redist) {
>>> +            *prio = cs->gicr_ipriorityr[irq];
>>> +        } else {
>>> +            *prio = cs->gic->gicd_ipriority[irq];
>>> +        }
>>> +    }
>>> +
>>> +    return has_superprio;
>>> +}
>>
>> Did you not like the idea to map {priority, !superpriority} into a
>> single value?
>>
>> It would eliminate the change in irqbetter(), which is a bit more
>> complex than it needs to be.
> 
> I will try to change to implement this mapping scheme.

I try to implement this mapping scheme, but it seems more complex, more
change on a larger scale, although it would eliminate the change in
irqbetter(). The subpriority and group priority, eight-bit segmentation
is used, the same is true of the semantics of BPR. And currently, the
invalid values or initial value of all priorities in the QEMU are 0xff,
and all priority mask operations are 0xff.

Especially, what should hppi.prio save? the original priority value or
the mapped priority value. If hppi.prio save the mapped priority value,
all of the above things need to be updated. Otherwise,if hppi.prio save
the original priority value，it will be more simpler, but it also need
to convert from mapped priority to original priority when save
cs->hppi.prio and convert to mapped priority when comparing priority in
irqbetter(), it is also not more compact than existing implementation.

@Peter

> 
>>
>>> @@ -152,10 +197,13 @@ static void
>>> gicv3_redist_update_noirqset(GICv3CPUState *cs)
>>>               if (!(pend & (1 << i))) {
>>>                   continue;
>>>               }
>>> -            prio = cs->gicr_ipriorityr[i];
>>> -            if (irqbetter(cs, i, prio)) {
>>> +            superprio = extract32(cs->gicr_isuperprio, i, 1);
>>> +            has_superprio = gicv3_get_priority(cs, true, superprio,
>>> &prio, i);
>>
>> It would allow moving the read of gicr_isuperprio into
>> gicv3_get_priority(), alongside the read of gicr_ipriorityr.
>>
>> Is there a bug here not handling is_redist for GCIR_INMI*?
>>
>>> @@ -168,7 +216,7 @@ static void
>>> gicv3_redist_update_noirqset(GICv3CPUState *cs)
>>>       if ((cs->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) &&
>>> cs->gic->lpi_enable &&
>>>           (cs->gic->gicd_ctlr & GICD_CTLR_EN_GRP1NS) &&
>>>           (cs->hpplpi.prio != 0xff)) {
>>> -        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio)) {
>>> +        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio, false)) {
>>
>> Always passing false here is incorrect -- again missing the
>> redistributor nmi bit?
>>
>>
>> r~

