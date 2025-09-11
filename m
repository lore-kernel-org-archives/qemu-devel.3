Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89886CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjDb-0006eD-VU; Thu, 11 Sep 2025 11:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uwjDV-0006ZL-OS; Thu, 11 Sep 2025 11:28:09 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uwjDS-0001Ph-MZ; Thu, 11 Sep 2025 11:28:09 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3vDx66sJopEydCA--.191S2;
 Thu, 11 Sep 2025 23:27:54 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.232.247])
 by mail (Coremail) with SMTP id AQAAfwDXOed56sJo2EMOAA--.381S2;
 Thu, 11 Sep 2025 23:27:53 +0800 (CST)
Message-ID: <8987bd11-afae-4157-979d-ef10be69a7a5@phytium.com.cn>
Date: Thu, 11 Sep 2025 23:27:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/11] hw/arm/smmuv3: Implement read/write logic for secure
 registers
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-3-tangtao1634@phytium.com.cn>
 <aKOaIcPp26kbS3Nn@google.com>
 <53607fe8-0555-4408-bfa6-e4b95d44e230@phytium.com.cn>
 <aKma98hlAWG9M4h_@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aKma98hlAWG9M4h_@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXOed56sJo2EMOAA--.381S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWjB0oAKZwAAsY
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AryDuF45AFW7ur13Gw1Dtrb_yoWxuFy8pF
 Z3Kasakr4kGF1xArn2qw4UZFnakrW8Jr1DCr93K348Aa15Zr1xKr1jyryF9FWDWrykWF12
 v3Wjva1furWDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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


Hi Mostafa,

First, my apologies for the long delay in getting back to you. I was 
away on paternity leave for the last few weeks.

Thank you for the detailed follow-up, your advice is very helpful for 
simplifying the series.


On 2025/8/23 18:41, Mostafa Saleh wrote:
> On Wed, Aug 20, 2025 at 11:21:02PM +0800, Tao Tang wrote:
>> On 2025/8/19 05:24, Mostafa Saleh wrote:
>>> On Wed, Aug 06, 2025 at 11:11:25PM +0800, Tao Tang wrote:
>>>> This patch builds upon the previous introduction of secure register
>>>> definitions by providing the functional implementation for their access.
>>>>
>>>> The availability of the secure programming interface is now correctly
>>>> gated by the S_IDR1.SECURE_IMPL bit. When this bit indicates that
>>>> secure functionality is enabled, the I/O handlers (smmuv3_read and
>>>> smmuv3_write) will correctly dispatch accesses to the secure
>>>> register space.
>>>>
>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>> ---
>>>>    hw/arm/smmuv3-internal.h |   5 +
>>>>    hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 456 insertions(+)
>>>>
>>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>>> index 483aaa915e..1a8b1cb204 100644
>>>> --- a/hw/arm/smmuv3-internal.h
>>>> +++ b/hw/arm/smmuv3-internal.h
>>>> @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
>>>>    #define SMMU_CR0_RESERVED 0xFFFFFC20
>>>> +/*
>>>> + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
>>>> + */
>>>> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>>>> +
>>>>    REG32(CR0ACK,              0x24)
>>>>    REG32(CR1,                 0x28)
>>>>    REG32(CR2,                 0x2c)
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index ab67972353..619180d204 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>>>        s->gerrorn = 0;
>>>>        s->statusr = 0;
>>>>        s->gbpa = SMMU_GBPA_RESET_VAL;
>>>> +
>>>> +    /* Initialize secure state */
>>>> +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
>>>> +    /* Secure EL2 and Secure stage 2 support */
>>>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
>>> AFAIU, this is wrong, SEL2 means that the SMMU has dual stage-2,
>>> one for secure (S_S2TTB) and one for non-secure IPAs(S2TTB).
>>> Which is not implemented in this series.
>>
>> Hi Mostafa,
>>
>> Thank you for the very detailed and helpful review. Your feedback is spot
>> on, and I'd like to address your points and ask for a quick confirmation on
>> them.
>>
>> Regarding the SEL2 bit, you are absolutely right, my understanding was
>> incorrect. I've spent the last few days reviewing the manual to better
>> understand the selection between Secure and Non-secure Stage 2 translations.
>> I would be very grateful if you could confirm if my new understanding is
>> correct:
>>
>> - In Stage 2-only mode (Stage 1 bypassed), the choice between a Secure or
>> Non-secure IPA translation is determined solely by STE.NSCFG.
>>
> Yes, but that's only with SMMU_IDR1.ATTR_PERMS_OVR which Qemu doesn't
> advertise, so in our case it's always secure.
>
>> - In Stage 1-enabled mode, STE.NSCFG is ignored. The choice is determined by
>> the translation process, starting from CD.NSCFGx, with the output NS
>> attribute being the result of intermediate NSTable flags and the final
>> descriptor.NS bit (TTD.NSTable, TTD.NS).
>>
> You have to differentiate between the security state of the translation and
> the security state of the translation table access.
>
> For stage-1, the security state is determined by the NS bit in the last
> level PTE, which in case of nested translation it will choose between S2TTB
> or S_S2TTB.
>
> Also, note that the stage-2 also have an NS which define the final attribute
> of the transaction.
>
> You have to also be careful around things such as NSCFG{0,1} as it might
> change which stage-2 is used for the stage-1 TTB walk.
>
> I see, in your patches, all the page-table access is done using the secure
> state of the SID which is not correct.
>
>
>> Based on this, I plan to have an internal flag, perhaps named
>> target_ipa_is_ns in SMMUTransCfg.SMMUS2Cfg struct, to track the outcome of
>> this process. This flag will then determine whether S_S2TTB or S2TTB is used
>> for the Stage 2 translation.
>>
> I am worried that it's not that simple for a single secure nested translation
> you can have multiple stage-2 walks where some might be secure and others not,
> so I imagine this some how will be determined from each stage-1 walk and
> some how returned (maybe in the TLB struct) which is then the stage-2
> walk looks into.
>
> I am not sure how complicated it is to manage 2 stage-2 with the current code
> base, so my advice would be to split the problem; for now you can drop SEL2
> from this series and rely on NS stage-2.


I would like to confirm my understanding of the implementation. Does 
this mean that for the current RFC, we should set S_IDR1.SEL2=0, which 
implies that all Stage-2 translations will begin with a Non-secure IPA? 
And the final output PA space will then almost always be Non-secure PA, 
with the sole exception being when S2SW, S2SA, S2NSW, and S2NSA are ALL 
ZERO.


However, since these fields are RES0 when S_IDR1.SEL2=0, it seems we can 
conclude that for this version, the output will definitively be a 
Non-secure PA. I believe this is what you meant by your advice to "rely 
on NS stage-2". I would be grateful if you could let me know whether 
this interpretation is on the right track.


------------------------------<snip>------------------------------

>> The new code performs a single, necessary security state check at the entry
>> point of the MMIO handlers. The rest of the logic relies on the banking
>> mechanism, which makes the implementation generic for Non-secure, Secure,
>> and future states like Realm/Root. The new structure looks like this:
>>
>> /* Structure for one register bank */
>> typedef struct SMMUv3Bank {
>>      uint32_t idr[6];     /* IDR0-IDR5, note: IDR5 only used for NS bank */
>>      uint32_t cr[3];      /* CR0-CR2 */
>>      uint32_t cr0ack;
>>      uint32_t init;       /* S_INIT register (secure only), reserved for NS
>> */
>>      uint32_t gbpa;
>>
>> ......
>>
>>      SMMUQueue eventq, cmdq;
>> } SMMUv3Bank;
>>
>> struct SMMUv3State {
>>      SMMUState     smmu_state;
>>
>>      /* Shared (non-banked) registers and state */
>>      uint32_t features;
>>      uint8_t sid_size;
>>      uint8_t sid_split;
>>
>> ......
>>
>>      /* Banked registers for all access */
>>      SMMUv3Bank bank[SMMU_SEC_IDX_NUM];
>> ......
>> };
>>
> Yes, IMO,that’s the right approach. Although that might make the
> migration code more complicated as we changed the state struct.
>
> Thanks,
> Mostafa
I have almost completed the refactoring based on this new structure, and 
I will send out the v2 patch series in the next few days for review.

Thanks again for your invaluable guidance.

Best regards,

Tao


