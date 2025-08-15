Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEA4CA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 06:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umnWn-0000sK-S5; Fri, 15 Aug 2025 02:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1umnWg-0000pR-Ur; Fri, 15 Aug 2025 02:02:54 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1umnWc-0003Ne-Ft; Fri, 15 Aug 2025 02:02:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3Dx9zZ5o37i9Bg--.1226S2;
 Fri, 15 Aug 2025 14:02:37 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHkglwzZ5om1MTAA--.27666S2;
 Fri, 15 Aug 2025 14:02:33 +0800 (CST)
Message-ID: <0c95f7de-ffbe-4787-ae14-6039bc4f31a3@phytium.com.cn>
Date: Fri, 15 Aug 2025 14:02:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
 <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
 <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
 <CAFEAcA-imgF9NLPWeXfE1JRL0gaKpVyfbbNKxojHDVz0t7EBKw@mail.gmail.com>
Content-Language: en-US
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA-imgF9NLPWeXfE1JRL0gaKpVyfbbNKxojHDVz0t7EBKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHkglwzZ5om1MTAA--.27666S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQADBWieOgABnAAGsQ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtF1xCFWxAw15Ar13WrWDCFg_yoW3XF1UpF
 Z5K3WYkrWDKF4Ivr1Iqw48Ja4Fv393JFWUur95Kr98Aws09rySqr1UKFyY9asrCrWxZw10
 vr4jyw4fuan8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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


On 2025/8/13 02:42, Peter Maydell wrote:
> On Mon, 11 Aug 2025 at 11:34, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> Hi,
>>
>> On 10/8/25 18:59, Tao Tang wrote:
>>> On 2025/8/7 05:55, Pierrick Bouvier wrote:
>>>> On 8/6/25 8:11 AM, Tao Tang wrote:
>>>>> This patch enables the secure command queue, providing a dedicated
>>>>> interface for secure software to issue commands to the SMMU. Based on
>>>>> the SMMU_S_CMDQ_BASE configuration, the SMMU now fetches command
>>>>> entries directly from the Secure PA space so that we need to pass the
>>>>> memory transaction attributes when reading the command queue.
>>>>>
>>>>> This provides a parallel command mechanism to the non-secure world.
>>>>>
>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>> ---
>>>>>    hw/arm/smmuv3-internal.h |  8 ++++--
>>>>>    hw/arm/smmuv3.c          | 55 +++++++++++++++++++++++++---------------
>>>>>    hw/arm/trace-events      |  2 +-
>>>>>    3 files changed, 41 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>>>> index 1a8b1cb204..5b2ca00832 100644
>>>>> --- a/hw/arm/smmuv3-internal.h
>>>>> +++ b/hw/arm/smmuv3-internal.h
>>>>> @@ -319,9 +319,13 @@ static inline void queue_cons_incr(SMMUQueue *q)
>>>>>        q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>>>>>    }
>>>>>    -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
>>>>> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool is_secure)
>>>>>    {
>>>>> -    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>>>> +    if (is_secure) {
>>>>> +        return FIELD_EX32(s->secure_cr[0], S_CR0, CMDQEN);
>>>>> +    } else {
>>>>> +        return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>>>> +    }
>>>>>    }
>>
>>>> This looks like a reasonable and readable approach to support secure
>>>> and non secure accesses.
>>> Hi Pierrick,
>>>
>>> Thank you so much for taking the time to review and for the very
>>> positive feedback.
>>>
>>> I'm very relieved to hear you find the approach "reasonable and
>>> readable". I was hoping that explicitly passing the parameter was the
>>> right way to avoid issues with global state or code duplication, and
>>> your confirmation is the best encouragement I could ask for.
>> An alternative (also suggested in patch #1) is to use index for banked
>> registers.
> This is often how we handle S/NS banked registers, yes.
> Other examples:
>
> include/hw/intc/arm_gicv3_common.h: the S/NS banked registers
> ICC_CTLR_EL1, GICD_STATUSR, GICR_STATUSR are implemented as
> uint32_t icc_ctlr_el1[2] etc. (The GICv3 also has some
> group-related registers which is why it also has 3-element arrays)
>
> The banked AArch32 system registers in cpu.h are a bit
> more complicated, and there we have some macros
> A32_BANKED_REG_GET/SET which access the right fields.
> This lets us define the mapping between the NS and S
> registers and the AArch32 ELx views. (I'm not sure I'd
> go down this path again if we did it now: our AArch32
> design here pre-dates AArch64. The AArch64 views use
> an array that they index by EL.)
>
> Sometimes when there are only a few registers that need
> to be banked S/NS we give them names, as with the
> GICv2 where we have separate apr[][] and nsapr[][] arrays.
>
> I think I would say that it depends mostly on how many
> registers there are, and whether you wind up wanting to do
> a lot of "the logic is the same for both S and NS, it
> just operates on the other register in the bank". It
> can make the code a lot easier to read in that case if
> you have functions that take the is_secure parameter
> and just use it all the way through to index into the
> register array. Even in the simple example above of
> smmuv3_cmdq_enabled(), you can see that
>
>    return FIELD_EX32(s->cr[is_secure][0], CR0, CMDQEN);
>
> is more succinct than the if-else version.
>
> I have not looked closely enough the SMMUv3 code or spec to
> be certain which side of the line it falls, but a glance
> at the register overview does suggest that the design
> has registers for all of normal, secure, realm and root.
> Using an array will probably make our lives easier
> if/when we have to implement the RME support in the SMMU.
>
> thanks
> -- PMM


Hi Peter, and all,

Thank you all for the very helpful feedback and discussion on this 
series. I will start refactoring the code to adopt the register banking 
approach as suggested.

While working on the design, I have some questions regarding the best 
way to index these banks, especially looking ahead to RME support, and I 
would appreciate your thoughts on them.

Here is my understanding of the current situation:
According to the ARM SMMUv3 specification (IHI 0070 G.b), the SEC_SID is 
the ground truth for determining the security context of a transaction. 
For an RME-capable SMMU, its encoding is:

SEC_SID=0 <-> Non-secure
SEC_SID=1 <-> Secure
SEC_SID=2 <-> Realm
SEC_SID=3 <-> Reserved

To accurately model the SMMU, our smmuv3_translate function must 
ultimately use this SEC_SID value. Taking the translate callback 
signature into consideration:

IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
                            IOMMUAccessFlags flags, int iommu_idx);

My understanding is that we can use the iommu_idx parameter to carry the 
SEC_SID value for each transaction. The SMMU model would then use this 
index to select the correct programming interface, which in turn 
corresponds to the bank index for its internal registers (e.g., 
s->bank[iommu_idx]).

The dilemma arises when choosing the enum for this bank index. 
Philippe's suggestion to use ARMASIdx is great for the current S/NS 
case. For future RME support, one might consider ARMSecuritySpace. 
However, as Peter’s feedback highlighted, the SMMU architecture includes 
four states. The problem is that the values of ARMSecuritySpace do not 
match the SEC_SID encoding at all, so it cannot be used directly(e.g., 0 
for Secure, 1 for Non-secure BUT for SEC_SID, 0 for NON-secure, 1 for 
Secure ) .

This leads me to two questions on the best path forward:

1. How should the SEC_SID be propagated from the device? The only thing 
that is certain is that the hardware transaction will carry a SEC_SID 
value that is consistent with the manual. My initial thought was to 
extend MemTxAttrs.secure to carry the four states, but I am unsure if 
this is the best approach.

typedef struct MemTxAttrs {
     /*
      * ARM/AMBA: TrustZone Secure access
      * x86: System Management Mode access
      */
     unsigned int secure:1;
     /*
      * ARM: ArmSecuritySpace.  This partially overlaps secure, but it is
      * easier to have both fields to assist code that does not understand
      * ARMv9 RME, or no specific knowledge of ARM at all (e.g. pflash).
      */
     unsigned int space:2;

...

}


2. What should we use as the internal bank index within the SMMUv3 
model? I see two potential options:
a) Use the existing ARMSecuritySpace as the internal index. This would 
require conversions from the SEC_SID carried by each transaction.
b) Define a new, SMMU-specific enum that perfectly matches the SEC_SID 
hardware specification (e.g., enum SmmuSecSid { NS=0, S=1, REALM=2, 
ROOT=3 }). We would use this new enum as our bank index internally.

I am leaning towards option (2b) as it seems to offer better 
encapsulation and fidelity to the hardware specification, but I would be 
very grateful to hear your opinions and guidance on this architectural 
choice.

Thank you very much!

Best regards,

Tao


