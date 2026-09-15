Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B852C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6V6V-0007jh-AC; Tue, 15 Sep 2026 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6V68-0007e7-1S; Tue, 15 Sep 2026 11:29:32 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6V64-00056n-LI; Tue, 15 Sep 2026 11:29:27 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwC3Dd1MZKlqUWYEAA--.7770S2;
 Tue, 15 Sep 2026 23:29:16 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.118.246])
 by mail (Coremail) with SMTP id AQAAf8DwBnNKZKlqwXfWAA--.32208S2;
 Tue, 15 Sep 2026 23:29:15 +0800 (CST)
Message-ID: <4350246f-582c-4071-a31a-3fcb43cb3d72@phytium.com.cn>
Date: Tue, 15 Sep 2026 23:29:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 17/28] hw/arm/smmuv3: Add access checks for STRTAB_BASE
 and CR2 registers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-2-tangtao1634@phytium.com.cn>
 <485db89a-e0b8-46ec-b586-24e1ce0033a4@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <485db89a-e0b8-46ec-b586-24e1ce0033a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBnNKZKlqwXfWAA--.32208S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWqoS0kibQABsZ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3JFWfZF1fWFW3WryDGw13twb_yoW7KFW8pr
 Z5Ga45Kr4rtrsI93Waka10vrZIg3yvgF1UZry3GFykuFyYyrn8JF40grW5Wa1DXryUArsF
 yr42k39xurWjyFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On 8/28/2026 6:05 PM, Eric Auger wrote:
> Hi Tao,
>
> On 8/13/26 6:25 PM, Tao Tang wrote:
>> Add access control for SMMU_STRTAB_BASE and SMMU_CR2 registers to
>> ensure they can only be modified when the SMMU is disabled.
> About SMMU_STRTAB_BASE "
> SMMU_STRTAB_BASE is Guarded by SMMU_CR0.SMMUEN and must only be written when
> SMMU_CR0.SMMUEN == 0
> .../..
> In SMMUv3.2 and later, a write while SMMU_CR0.SMMUEN == 1 is IGNORED.
> ../..
> Accessible at offset 0x0080 from SMMUv3_PAGE_0
> • When SMMU_IDR1.TABLES_PRESET == 1, accesses to this register are RO.
> • When SMMU_CR0.SMMUEN == 0 and SMMU_CR0ACK.SMMUEN == 0, accesses to
> this register are
> RW.
> • Otherwise, accesses to this register are RO.
> "
>
> About SMMU_CR2:
> "
> This register is made read-only when the associated SMMU_CR0.SMMUEN is
> Updated to 1. This register must
> only be changed when SMMU_CR0.SMMUEN == 0.
> A write to this register after SMMU_CR0.SMMUEN has been changed but
> before its Update completes is
> CONSTRAINED UNPREDICTABLE and has one of the following behaviors:
> • Apply the new value.
> • Ignore the write. In SMMUv3.2 and later, this is the only permitted
> behavior.
> "
>
>
>> This implements:
>> - smmuv3_smmu_disabled_stable(): Check whether the SMMU is in a stable
>>     disabled state (CR0.SMMUEN == 0 and CR0ACK.SMMUEN == 0);
>> - smmu_strtab_base_writable(): returns true only when IDR1.TABLES_PRESET==0
>>     and SMMU is completely disabled.
>>
>> Additionally, mask reserved bits on writes to SMMU_STRTAB_BASE using
>> SMMU_STRTAB_BASE_RESERVED.
>>
>> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 67 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 628911d3f21..de8ca7cda48 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1484,6 +1484,36 @@ smmu_gerror_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>>       return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_GERROR);
>>   }
>>   
>> +static inline int smmuv3_get_cr0ack_smmuen(SMMUv3State *s, SMMUSecSID sec_sid)
>> +{
>> +    /*
>> +     * CR0, CR0ACK, S_CR0 and S_CR0ACK are bit-layout compatible, so we reuse
>> +     * the CR0 field definitions and only switch banks via sec_sid to reduce
>> +     * code duplication. Also the other bits in CR0/CR0ACK are relevant here.
>> +     */
>> +    return FIELD_EX32(s->bank[sec_sid].cr0ack, CR0, SMMUEN);
>> +}
>> +
>> +/* Check if SMMU is disabled in stable status */
>> +static inline bool smmuv3_smmu_disabled_stable(SMMUv3State *s, SMMUSecSID sec_sid)
> s/stable/updated?
> SMMU_CR0 spec quote:
...
>
>> +{
>> +    int cr0_smmuen = smmu_enabled(s, sec_sid);
>> +    int cr0ack_smmuen = smmuv3_get_cr0ack_smmuen(s, sec_sid);
>> +    return (cr0_smmuen == 0 && cr0ack_smmuen == 0);
> Each field in this register has a corresponding field in SMMU_CR0ACK. An
> individual field is described as
> Updated after the value of the field observed in SMMU_CR0ACK matches the
> value that was written to the field
> in SMMU_CR0.
>
> Besides I don't if its wort that complexity here because the update is
> done in the emulation
>      case A_CR0:
>          bank->cr[0] = data;
>          bank->cr0ack = data & ~SMMU_CR0_RESERVED;
>
> Just adding a coment would be enough I think
Agreed. I'll simplify the check to !smmu_enabled() and add a comment 
explaining that SMMUEN is acknowledged synchronously in this model.
> I would split this patch into 2 sparate patches, first one CR2 and then
> STRTAB_BASE
>
I'll also split this into a CR2 patch followed by a STRTAB_BASE/CFG 
patch in v6.
>
>
>> +}
>> +
>> +/* Check if STRTAB_BASE register is writable */
>> +static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>> +{
>> +    /* SMMU_IDR1.TABLES_PRESET applies to both modeled interfaces. */
>> +    if (FIELD_EX32(s->bank[SMMU_SEC_SID_NS].idr[1], IDR1, TABLES_PRESET)) {
>> +        return false;
>> +    }
>> +
>> +    /* Check SMMUEN conditions for the specific security domain */
>> +    return smmuv3_smmu_disabled_stable(s, sec_sid);
>> +}
>> +
>>   static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>> @@ -1801,7 +1831,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>>           bank->gerror_irq_cfg0 = data & SMMU_GERROR_IRQ_CFG0_RESERVED;
>>           return MEMTX_OK;
>>       case A_STRTAB_BASE:
>> -        bank->strtab_base = data;
>> +        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "STRTAB_BASE write ignored: register is RO\n");
>> +            return MEMTX_OK;
>> +        }
>> +
>> +        /* Clear reserved bits according to spec */
>> +        bank->strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
>>           return MEMTX_OK;
>>       case A_CMDQ_BASE:
>>           bank->cmdq.base = data;
>> @@ -1852,7 +1889,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>           bank->cr[1] = data;
>>           break;
>>       case A_CR2:
>> -        bank->cr[2] = data;
>> +        if (smmuv3_smmu_disabled_stable(s, reg_sec_sid)) {
>> +            /* Allow write: SMMUEN is 0 in both CR0 and CR0ACK */
>> +            bank->cr[2] = data;
>> +        } else {
>> +            /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "CR2 write ignored: register is read-only when "
>> +                          "CR0.SMMUEN or CR0ACK.SMMUEN is set\n");
> not sure those logs are requested.

I incorrectly described this as CONSTRAINED UNPREDICTABLE but that 
transition case cannot occur because SMMUEN is acknowledged 
synchronously in this model. So the comment should be removed.

And those logs indicate guest writes to CR2 after the SMMU has been 
enabled, with both CR0.SMMUEN==1 and CR0ACK.SMMUEN==1, making CR2 
read-only. Should we handle with this case?


Thanks,

Tao

>> +        }
>>           break;
>>


