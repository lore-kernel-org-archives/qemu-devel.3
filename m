Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCA3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GFp-0002Mf-P1; Mon, 29 Sep 2025 11:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3GFi-0002GN-Cp; Mon, 29 Sep 2025 11:57:26 -0400
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3GFR-00024r-FG; Mon, 29 Sep 2025 11:57:25 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3JVxGrNpo9gQAAA--.39S2;
 Mon, 29 Sep 2025 23:56:54 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.232.83])
 by mail (Coremail) with SMTP id AQAAfwDnS+lDrNpoxIUvAA--.53536S2;
 Mon, 29 Sep 2025 23:56:52 +0800 (CST)
Message-ID: <e43de190-7643-49e1-8e57-0b5f28c33fe9@phytium.com.cn>
Date: Mon, 29 Sep 2025 23:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] hw/arm/smmuv3: Harden security checks in MMIO
 handlers
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-12-tangtao1634@phytium.com.cn>
 <81c98959-45dc-4cbc-836f-a34fdf160801@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <81c98959-45dc-4cbc-836f-a34fdf160801@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwDnS+lDrNpoxIUvAA--.53536S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscNIQAAsY
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKFy7Kr1UJr47JryrXFyUGFg_yoW7XFWfpr
 W8KFyYgF4kGF17XF1fJw1DAFyFkrWkKFZFkrsxGa48Za4qyw1xJa40k34YkasrGr1UZw4I
 yF1Ivr4fWF1ay3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=159.65.134.6;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_PBL=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2025/9/29 23:30, Eric Auger wrote:
> Hi Tao,
>
> On 9/25/25 6:26 PM, Tao Tang wrote:
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
>>   hw/arm/smmuv3.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 53c7eff0e3..eec36d5fd2 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1484,6 +1484,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s,
>>       return smmu_irq_ctl_evtq_irqen_disabled(s, sec_idx);
>>   }
>>   
>> +/* Check if the SMMU hardware itself implements secure state features */
>> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
>> +{
>> +    return FIELD_EX32(s->bank[SMMU_SEC_IDX_S].idr[1], S_IDR1, SECURE_IMPL);
>> +}
>> +
>>   static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>> @@ -1723,6 +1729,43 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>>       return 0;
>>   }
>>   
>> +static bool is_secure_impl_exempt_reg(hwaddr offset)
> Worth a comment: some secure registers can be accessed even if secure HW
> is not implemented. Returns true if this is the case or something alike.


You're right, that function definitely needs a comment to explain the 
architectural exception it handles. I will add one in the next version 
to improve clarity.

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
>> +static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
>> +                                     hwaddr offset, bool is_read)
>> +{   /* Check if the access is secure */
>> +    if (!(attrs.space == ARMSS_Secure || attrs.space == ARMSS_Root ||
> First occurence of ARMSS_Root in hw dir? Is it needed?


This is a good question, and I'd like to clarify your expectation. My 
thinking was that if we are using ARMSecuritySpace to propagate the 
security context at the device level, then ARMSS_Root will eventually be 
part of this check.

Is your suggestion that I should remove the ARMSS_Root check for now, as 
it's not strictly necessary for the current Secure-state implementation, 
and only re-introduce it when full Realm/Root support is added to the 
SMMU model? I'm happy to do that to keep this patch focused.

Thanks,
Tao

>> +          attrs.secure == 1)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +            "%s: Non-secure %s attempt at offset 0x%" PRIx64 " (%s)\n",
>> +            __func__, is_read ? "read" : "write", offset,
>> +            is_read ? "RAZ" : "WI");
>> +        return false;
>> +    }
>> +
>> +    /* Check if the secure state is implemented. Some registers are exempted */
>> +    /* from this check. */
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
>>                                  uint64_t data, MemTxAttrs attrs,
>>                                  SMMUSecurityIndex reg_sec_idx)
>> @@ -2038,6 +2081,13 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>>       offset &= ~0x10000;
>>       SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
>> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
>> +        if (!smmu_check_secure_access(s, attrs, offset, false)) {
>> +            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
>> +            return MEMTX_OK;
>> +        }
>> +        reg_sec_idx = SMMU_SEC_IDX_S;
>> +    }
>>   
>>       switch (size) {
>>       case 8:
>> @@ -2252,6 +2302,14 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>>       offset &= ~0x10000;
>>       SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
>> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
>> +        if (!smmu_check_secure_access(s, attrs, offset, true)) {
>> +            *data = 0;
>> +            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
>> +            return MEMTX_OK;
>> +        }
>> +        reg_sec_idx = SMMU_SEC_IDX_S;
>> +    }
>>   
>>       switch (size) {
>>       case 8:
> Thanks
>
> Eric


