Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F0FD2F7D8
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 10:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRTBU-0008OH-N7; Fri, 05 Dec 2025 05:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRTBS-0008NY-8a; Fri, 05 Dec 2025 05:37:06 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRTBO-0003Vs-EJ; Fri, 05 Dec 2025 05:37:06 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHtVzAtTJpbWE6AQ--.25252S2;
 Fri, 05 Dec 2025 18:36:48 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCn_eqytTJpU8QJAA--.4346S2;
 Fri, 05 Dec 2025 18:36:43 +0800 (CST)
Message-ID: <ab0edbd5-9556-424a-83ab-452801d617a8@phytium.com.cn>
Date: Fri, 5 Dec 2025 18:36:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 18/21] hw/arm/smmuv3: Harden security checks in MMIO
 handlers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151437.4130770-1-tangtao1634@phytium.com.cn>
 <04533911-e6f5-42d6-9813-85e97ce13d38@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <04533911-e6f5-42d6-9813-85e97ce13d38@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCn_eqytTJpU8QJAA--.4346S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAPBWkx6ywEzQAAsd
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKFy7Kr1UJr47JryrXFyUGFg_yoWxJr1xpr
 4DK3W5Gr4DKF17XF4Sqw4kCFyrCrZ2grW7C393K3yUZa45Cr95JF40k34Y93ZrGr1UZa1x
 AF1FvrWfur1YyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Eric,

On 2025/12/4 22:59, Eric Auger wrote:
>
> On 10/12/25 5:14 PM, Tao Tang wrote:
>> This patch hardens the security validation within the main MMIO
>> dispatcher functions (smmu_read_mmio and smmu_write_mmio).
>>
>> First, accesses to the secure register space are now correctly gated by
>> whether the SECURE_IMPL feature is enabled in the model. This prevents
>> guest software from accessing the secure programming interface when it is
>> disabled, though some registers are exempt from this check as per the
>> architecture.
>>
>> Second, the check for the input stream's security is made more robust.
>> It now validates not only the legacy MemTxAttrs.secure bit, but also
>> the .space field. This brings the SMMU's handling of security spaces
>> into full alignment with the PE.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 4ac7a2f3c7..c9c742c80b 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1458,6 +1458,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>>       return smmu_irq_ctl_evtq_irqen_disabled(s, sec_sid);
>>   }
>>   
>> +/* Check if the SMMU hardware itself implements secure state features */
>> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
>> +{
>> +    return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SECURE_IMPL);
>> +}
>> +
>>   static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>> @@ -1712,6 +1718,55 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
>>       return 0;
>>   }
>>   
>> +/*
>> + * Check if a register is exempt from the secure implementation check.
>> + *
>> + * The SMMU architecture specifies that certain secure registers, such as
>> + * the secure Event Queue IRQ configuration registers, must be accessible
>> + * even if the full secure hardware is not implemented. This function
>> + * identifies those registers.
>> + *
>> + * Returns true if the register is exempt, false otherwise.
>> + */
>> +static bool is_secure_impl_exempt_reg(hwaddr offset)
>> +{
>> +    switch (offset) {
>> +    case A_S_EVENTQ_IRQ_CFG0:
>> +    case A_S_EVENTQ_IRQ_CFG1:
>> +    case A_S_EVENTQ_IRQ_CFG2:
>> +        return true;
>> +    default:
>> +        return false;
>> +    }
>> +}
>> +
>> +/* Helper function for Secure register access validation */
> I think we shall improve the doc commennt for the function. I understand
> @offset is a secure register offset and the function returns whether the
> access to the secure register is possible. This requires a) the access
> to be secure and in general secure state support exccet for few regs?
>> +static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
>> +                                     hwaddr offset, bool is_read)
>> +{   /* Check if the access is secure */
>> +    if (!(attrs.space == ARMSS_Secure ||
>> +          attrs.secure == 1)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +            "%s: Non-secure %s attempt at offset 0x%" PRIx64 " (%s)\n",
>> +            __func__, is_read ? "read" : "write", offset,
>> +            is_read ? "RAZ" : "WI");
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * Check if the secure state is implemented. Some registers are exempted
>> +     * from this check.
>> +     */
>> +    if (!is_secure_impl_exempt_reg(offset) && !smmu_hw_secure_implemented(s)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +            "%s: Secure %s attempt at offset 0x%" PRIx64 ". But Secure state "
>> +            "is not implemented (RES0)\n",
>> +            __func__, is_read ? "read" : "write", offset);
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>>   static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>>                                   uint64_t data, MemTxAttrs attrs,
>>                                   SMMUSecSID reg_sec_sid)
>> @@ -2058,6 +2113,10 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>>        * statement to handle those specific security states.
>>        */
>>       if (offset >= SMMU_SECURE_REG_START) {
>> +        if (!smmu_check_secure_access(s, attrs, offset, false)) {
>> +            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
>> +            return MEMTX_OK;
> so the access to @offset is not permitted and we return MEMTX_OK? I am
> confused
>> +        }
>>           reg_sec_sid = SMMU_SEC_SID_S;
>>       }
>>   
>> @@ -2248,6 +2307,11 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>>       offset &= ~0x10000;
>>       SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       if (offset >= SMMU_SECURE_REG_START) {
>> +        if (!smmu_check_secure_access(s, attrs, offset, true)) {
>> +            *data = 0;
>> +            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
>> +            return MEMTX_OK;
> same here?
>> +        }
>>           reg_sec_sid = SMMU_SEC_SID_S;
>>       }
>>   
> Thanks
>
> Eric


Thanks for the review and for calling out the confusion around this helper.


The function `smmu_check_secure_access` and `return MEMTX_OK` statement 
after smmu_check_secure_access returned false is trying to follow the 
SECURE_IMPL rules from the architecture spec:

ARM IHI 0070 G.b , 6.2 Register overview

- When SMMU_S_IDR1.SECURE_IMPL == 1, SMMU_S_* registers are RAZ/WI to 
Non-secure access. See section 3.11 Reset, Enable and initialization 
regarding Non-secure access to SMMU_S_INIT. All other registers are 
accessible to both Secure and Non-secure accesses.
- When SMMU_S_IDR1.SECURE_IMPL == 0, SMMU_S_* registers are RES0.


So the MEMTX_OK in the MMIO handlers is deliberate: we are acknowledging 
the bus transaction while applying the architectural RAZ/WI/RES0 
semantics at the register level, rather than modelling a bus abort. Also 
there was another discussion about this issue [1]  in V1 series.

[1] 
  https://lore.kernel.org/qemu-devel/a5154459-a632-42b0-b599-d5dff85b5dd2@phytium.com.cn/


I'll add these needed details and parameters introduction as comment 
in `smmu_check_secure_access` and `return MEMTX_OK`. How do you think 
about it?


Thanks again for the feedback,

Tao


