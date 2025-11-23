Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D99CFA46B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 09:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vN6WA-0001DX-3X; Sun, 23 Nov 2025 04:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vN6PW-0004WB-Ra; Sun, 23 Nov 2025 04:29:34 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vN6PK-0003DK-A5; Sun, 23 Nov 2025 04:29:31 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHaGDP0yJp4DqAAg--.224S2;
 Sun, 23 Nov 2025 17:28:47 +0800 (CST)
Received: from [192.168.31.151] (unknown [222.240.104.245])
 by mail (Coremail) with SMTP id AQAAfwC3D+3O0yJp9MMGAA--.14162S2;
 Sun, 23 Nov 2025 17:28:46 +0800 (CST)
Message-ID: <0420f365-a9b5-4e7b-9069-1fcc04da90b5@phytium.com.cn>
Date: Sun, 23 Nov 2025 17:28:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC v3 05/21] hw/arm/smmuv3: Introduce banked registers
 for SMMUv3 state
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-6-tangtao1634@phytium.com.cn>
 <c24578bc-8747-4267-b31d-e7e650f52af5@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <c24578bc-8747-4267-b31d-e7e650f52af5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3D+3O0yJp9MMGAA--.14162S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQACBWkiGRgACQADsG
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtF13Gw4DCryfWw43Cr1UAwb_yoW7WF4kpr
 93JFyS9ry8G3WrXr1xJr4UAa43Aw4rt3WDGr1rW3WrJ3WYyr1jqr1UWrnY9FyDGrW8JF1U
 tw1jgrs3uF43ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Note: Resending due to delivery failure to qemu-devel mailing list. I'm 
not sure if everyone received the original email (at least qemu-devel 
not), so please disregard if this is a duplicate.

On 2025/11/21 21:02, Eric Auger wrote:
> Hi Tao,
>
> On 10/12/25 5:06 PM, Tao Tang wrote:
>> Rework the SMMUv3 state management by introducing a banked register
>> structure. This is a purely mechanical refactoring with no functional
>> changes.
>>
>> To support multiple security states, a new enum, SMMUSecSID, is
>> introduced to identify each state, sticking to the spec terminology.
>>
>> A new structure, SMMUv3RegBank, is then defined to hold the state
>> for a single security context. The main SMMUv3State now contains an
>> array of these banks, indexed by SMMUSecSID. This avoids the need for
>> separate fields for non-secure and future secure registers.
>>
>> All existing code, which handles only the Non-secure state, is updated
>> to access its state via s->bank[SMMU_SEC_SID_NS]. A local bank helper
>> pointer is used where it improves readability.
>>
>> Function signatures and logic remain untouched in this commit to
>> isolate the structural changes and simplify review. This is the
>> foundational step for building multi-security-state support.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3-internal.h     |  24 ++-
>>   hw/arm/smmuv3.c              | 344 +++++++++++++++++++----------------
>>   include/hw/arm/smmu-common.h |   6 +
>>   include/hw/arm/smmuv3.h      |  38 +++-
>>   4 files changed, 239 insertions(+), 173 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index e420c5dc72..858bc206a2 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -248,7 +248,9 @@ REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
>>     static inline int smmu_enabled(SMMUv3State *s)
>>   {
>> -    return FIELD_EX32(s->cr[0], CR0, SMMUEN);
>> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>> +    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>> +    return FIELD_EX32(bank->cr[0], CR0, SMMUEN);
>>   }
>>     /* Command Queue Entry */
>> @@ -276,12 +278,16 @@ static inline uint32_t smmuv3_idreg(int regoffset)
>>     static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
>>   {
>> -    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
>> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>> +    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
> why aren't you using smmuv3_bank_ns(s) here and elsewhere. Some other
> functions are already using it.
> Is it to reduce the diffstat in subsequent patches?

Hi Eric,

Yes, you guessed correctly—my original intention was indeed to reduce 
the diffstat in subsequent patches.

The smmuv3_bank_ns helper was originally kept mainly to handle specific 
edge cases like IDR5.OAS, which is unique because it only exists in the 
Non-Secure bank. But it seems that IDR5.OAS is the ONLY case 
using smmuv3_bank_ns.

Therefore, for the sake of consistency, I plan to remove the 
smmuv3_bank_ns helper entirely and use smmuv3_bank(s, SMMU_SEC_SID_NS) 
uniformly in V4.

>> +    return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
>>   }
>>     static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
>>   {
>> -    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
>> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>> +    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>> +    return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +    bk->features = 0;
>> +    bk->sid_split = 0;
>>       s->aidr = 0x1;
> maybe put the non banked regs at the end to have a clear separation.
> There is no ordering concern I think.
>> -    s->cr[0] = 0;
>> -    s->cr0ack = 0;
>> -    s->irq_ctrl = 0;
>> -    s->gerror = 0;
>> -    s->gerrorn = 0;
>> +    bk->cr[0] = 0;
>> +    bk->cr0ack = 0;
>> +    bk->irq_ctrl = 0;
>> +    bk->gerror = 0;
>> +    bk->gerrorn = 0;
>>       s->statusr = 0;
>> -    s->gbpa = SMMU_GBPA_RESET_VAL;
>> +    bk->gbpa = SMMU_GBPA_RESET_VAL;
>>   }
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> @@ -548,7 +556,8 @@ static int decode_ste(SMMUv3State *s, 
>> SMMUTransCfg *cfg,
>>                         STE *ste, SMMUEventInfo *event)
>>   {
>>       uint32_t config;
>> -    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
>> +    /* OAS is shared between S and NS and only present on NS-IDR5 */
> I am not sure the comment belongs to this patch as up to now we are just
> converting the existing code

I will also remove the premature comment regarding OAS and reorder the 
non-banked registers initialization to the end in V4.

Thanks again for your suggestion.

Regards,
Tao


