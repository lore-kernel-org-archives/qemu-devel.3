Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22DDCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 15:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uokdE-0006RL-5A; Wed, 20 Aug 2025 11:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uokd0-0006Lj-3R; Wed, 20 Aug 2025 11:21:30 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uokcu-00066x-N1; Wed, 20 Aug 2025 11:21:29 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD3D23j56VoTIyCBw--.51S2;
 Wed, 20 Aug 2025 23:21:07 +0800 (CST)
Received: from [192.168.31.34] (unknown [113.246.119.62])
 by mail (Coremail) with SMTP id AQAAfwC3Pwfg56VowkIcAA--.36896S2;
 Wed, 20 Aug 2025 23:21:04 +0800 (CST)
Message-ID: <53607fe8-0555-4408-bfa6-e4b95d44e230@phytium.com.cn>
Date: Wed, 20 Aug 2025 23:21:02 +0800
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
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aKOaIcPp26kbS3Nn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3Pwfg56VowkIcAA--.36896S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWikxY4F6QADsk
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Wr48Zry8uw48Zr1rXF1UKFg_yoWfJry5pr
 W8GFnxKF4DGa1fWrsxXw47u3Wfu3ykGFn8ArZxGw1jya1jyrn3Kr1qk3y5CwsxJryDu3WI
 va1jvr4fuw12q3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 2025/8/19 05:24, Mostafa Saleh wrote:
> On Wed, Aug 06, 2025 at 11:11:25PM +0800, Tao Tang wrote:
>> This patch builds upon the previous introduction of secure register
>> definitions by providing the functional implementation for their access.
>>
>> The availability of the secure programming interface is now correctly
>> gated by the S_IDR1.SECURE_IMPL bit. When this bit indicates that
>> secure functionality is enabled, the I/O handlers (smmuv3_read and
>> smmuv3_write) will correctly dispatch accesses to the secure
>> register space.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3-internal.h |   5 +
>>   hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 456 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 483aaa915e..1a8b1cb204 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
>>   
>>   #define SMMU_CR0_RESERVED 0xFFFFFC20
>>   
>> +/*
>> + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
>> + */
>> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>> +
>>   REG32(CR0ACK,              0x24)
>>   REG32(CR1,                 0x28)
>>   REG32(CR2,                 0x2c)
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index ab67972353..619180d204 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>       s->gerrorn = 0;
>>       s->statusr = 0;
>>       s->gbpa = SMMU_GBPA_RESET_VAL;
>> +
>> +    /* Initialize secure state */
>> +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
>> +    /* Secure EL2 and Secure stage 2 support */
>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
> AFAIU, this is wrong, SEL2 means that the SMMU has dual stage-2,
> one for secure (S_S2TTB) and one for non-secure IPAs(S2TTB).
> Which is not implemented in this series.


Hi Mostafa,

Thank you for the very detailed and helpful review. Your feedback is 
spot on, and I'd like to address your points and ask for a quick 
confirmation on them.

Regarding the SEL2 bit, you are absolutely right, my understanding was 
incorrect. I've spent the last few days reviewing the manual to better 
understand the selection between Secure and Non-secure Stage 2 
translations. I would be very grateful if you could confirm if my new 
understanding is correct:

- In Stage 2-only mode (Stage 1 bypassed), the choice between a Secure 
or Non-secure IPA translation is determined solely by STE.NSCFG.

- In Stage 1-enabled mode, STE.NSCFG is ignored. The choice is 
determined by the translation process, starting from CD.NSCFGx, with the 
output NS attribute being the result of intermediate NSTable flags and 
the final descriptor.NS bit (TTD.NSTable, TTD.NS).

Based on this, I plan to have an internal flag, perhaps named 
target_ipa_is_ns in SMMUTransCfg.SMMUS2Cfg struct, to track the outcome 
of this process. This flag will then determine whether S_S2TTB or S2TTB 
is used for the Stage 2 translation.


>
>> +    /* Secure state implemented */
>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
>> +        SECURE_IMPL, 1);
>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
>> +        S_SIDSIZE, SMMU_IDR1_SIDSIZE);
>> +
>> +    s->secure_gbpa = SMMU_GBPA_RESET_VAL;
>>   }
>>   
>>   static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>> @@ -1278,6 +1290,12 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>>       }
>>   }
>>   
>> +/* Check if the SMMU hardware itself implements secure state features */
>> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
>> +{
>> +    return FIELD_EX32(s->secure_idr[1], S_IDR1, SECURE_IMPL);
>> +}
>> +
> I see that the secure SMMU support is unconditional. So, is this always true?
> Also, how that looks with migration?

For the v2 series, my plan is to make SECURE_IMPL a user-configurable 
device property. I will add a "secure-enabled" property to 
smmuv3_properties and ensure all necessary states are added to the 
VMStateDescription to handle migration correctly. Does this approach 
sound reasonable to you?


>
>>   static int smmuv3_cmdq_consume(SMMUv3State *s)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>> @@ -1508,9 +1526,91 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>       return 0;
>>   }
>>   
>> +/* Helper function for secure register write validation */
>> +static bool smmu_validate_secure_write(MemTxAttrs attrs, bool secure_impl,
>> +                                       hwaddr offset, const char *reg_name)
>> +{
>> +    if (!attrs.secure || !secure_impl) {
>> +        const char *reason = !attrs.secure ?
>> +            "Non-secure write attempt" :
>> +            "SMMU didn't implement Security State";
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: %s at offset 0x%" PRIx64 " (%s, WI)\n",
>> +                      __func__, reason, offset, reg_name);
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +/* Helper function for secure register read validation */
>> +static bool smmu_validate_secure_read(MemTxAttrs attrs, bool secure_impl,
>> +                                      hwaddr offset, const char *reg_name,
>> +                                      uint64_t *data)
>> +{
>> +    if (!attrs.secure || !secure_impl) {
>> +        const char *reason = !attrs.secure ?
>> +            "Non-secure read attempt" :
>> +            "SMMU didn't implement Security State";
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: %s at offset 0x%" PRIx64 " (%s, RAZ)\n",
>> +                      __func__, reason, offset, reg_name);
>> +        *data = 0; /* RAZ */
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +/* Macro for secure write validation - returns early if validation fails */
>> +#define SMMU_CHECK_SECURE_WRITE(reg_name) \
>> +    do { \
>> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset, \
>> +                                        reg_name)) { \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>> +/* Macro for attrs.secure only validation */
>> +#define SMMU_CHECK_ATTRS_SECURE(reg_name) \
>> +    do { \
>> +        if (!attrs.secure) { \
>> +            qemu_log_mask(LOG_GUEST_ERROR, \
>> +                          "%s: Non-secure write attempt at offset " \
>> +                          "0x%" PRIx64 " (%s, WI)\n", \
>> +                          __func__, offset, reg_name); \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>> +/* Macro for secure read validation - returns RAZ if validation fails */
>> +#define SMMU_CHECK_SECURE_READ(reg_name) \
>> +    do { \
>> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset, \
>> +                                       reg_name, data)) { \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>> +/* Macro for attrs.secure only validation (read) */
>> +#define SMMU_CHECK_ATTRS_SECURE_READ(reg_name) \
>> +    do { \
>> +        if (!attrs.secure) { \
>> +            qemu_log_mask(LOG_GUEST_ERROR, \
>> +                          "%s: Non-secure read attempt at offset " \
>> +                          "0x%" PRIx64 " (%s, RAZ)\n", \
>> +                          __func__, offset, reg_name); \
>> +            *data = 0; \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>>
> Can’t we just have one check? If the access > SMMU_SECURE_BASE_OFFSET, just
> check the security state?
>
> And then based on banking, many of those switches will be common with
> non secure cases.
>
> Thanks,
> Mostafa


I have already refactored this part in my v2 series, exactly as you 
proposed. This also addresses your earlier feedback on patch #1 
regarding the overall structure:

> As Philippe mentioned, this would be better the secure state is separated
> in another instance of the struct, that seems it would reduce a lot of the
> duplication later around the logic of MMIO and queues... in the next
> patches.

The new code performs a single, necessary security state check at the 
entry point of the MMIO handlers. The rest of the logic relies on the 
banking mechanism, which makes the implementation generic for 
Non-secure, Secure, and future states like Realm/Root. The new structure 
looks like this:

/* Structure for one register bank */
typedef struct SMMUv3Bank {
     uint32_t idr[6];     /* IDR0-IDR5, note: IDR5 only used for NS bank */
     uint32_t cr[3];      /* CR0-CR2 */
     uint32_t cr0ack;
     uint32_t init;       /* S_INIT register (secure only), reserved for 
NS */
     uint32_t gbpa;

......

     SMMUQueue eventq, cmdq;
} SMMUv3Bank;

struct SMMUv3State {
     SMMUState     smmu_state;

     /* Shared (non-banked) registers and state */
     uint32_t features;
     uint8_t sid_size;
     uint8_t sid_split;

......

     /* Banked registers for all access */
     SMMUv3Bank bank[SMMU_SEC_IDX_NUM];
......
};


Thanks again for your valuable feedback. I've outlined my proposed plan 
above and would be grateful for any thoughts on it to ensure I'm on the 
right track for v2.

Best regards,

Tao






