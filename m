Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B95CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 16:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uolGG-00038e-8h; Wed, 20 Aug 2025 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uolFw-0002vT-Ru; Wed, 20 Aug 2025 12:01:50 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1uolFu-0003mw-ER; Wed, 20 Aug 2025 12:01:44 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHnWBc8aVo3FSsBg--.7249S2;
 Thu, 21 Aug 2025 00:01:32 +0800 (CST)
Received: from [192.168.31.34] (unknown [113.246.119.62])
 by mail (Coremail) with SMTP id AQAAfwBn8Qhb8aVoWVEcAA--.39861S2;
 Thu, 21 Aug 2025 00:01:31 +0800 (CST)
Message-ID: <c19380cc-0926-4a9c-99b4-c3b6aaf7bf0b@phytium.com.cn>
Date: Thu, 21 Aug 2025 00:01:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 03/11] hw/arm/smmuv3: Implement S_INIT for secure
 initialization
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 jean-philippe@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-4-tangtao1634@phytium.com.cn>
 <aKOad6FxdPB4r4Z1@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aKOad6FxdPB4r4Z1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBn8Qhb8aVoWVEcAA--.39861S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWikxY4F6QAEsj
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFW7tw43Ar17ZFW7Jr47urg_yoW5Zr48pF
 WkGa15Kay5tF43Wr13Kw4xZF15Z397Kry7CrZxG3s3ZF1qkrySyF1DKayY9FWDCr18Ja17
 Z3y09Fs3urn8t3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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


On 2025/8/19 05:26, Mostafa Saleh wrote:
> On Wed, Aug 06, 2025 at 11:11:26PM +0800, Tao Tang wrote:
>> This patch implements the S_INIT register, a secure-only register
>> with no non-secure counterpart. It provides a simple mechanism for
>> secure software to perform a global invalidation of all SMMU
>> configuration and translation caches.
>>
>> This is typically the final step in a SMMU's probe sequence, marking
>> the end of initialization for the SMMU's secure interface.
>>
>> With this and the previous change, a guest that is aware of the SMMUv3
>> secure extensions can probe the device's capabilities and perform basic
>> configuration of the secure interface, as is done by secure partition
>> managers like Hafnium in its smmuv3_driver_init function.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c     | 29 +++++++++++++++++++++++++++++
>>   hw/arm/trace-events |  1 +
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 619180d204..0ea9d897af 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -920,6 +920,21 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
>>       g_hash_table_remove(bc->configs, sdev);
>>   }
>>   
>> +static void smmuv3_invalidate_all_caches(SMMUv3State *s)
>> +{
>> +    trace_smmuv3_invalidate_all_caches();
>> +    SMMUState *bs = &s->smmu_state;
>> +
>> +    /* Clear all cached configs including STE and CD*/
>> +    if (bs->configs) {
>> +        g_hash_table_remove_all(bs->configs);
>> +    }
>> +
>> +    /* Invalidate all SMMU IOTLB entries */
>> +    smmu_inv_notifiers_all(&s->smmu_state);
>> +    smmu_iotlb_inv_all(bs);
>> +}
>> +
>>   /* Do translation with TLB lookup. */
>>   static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                                                    SMMUTransCfg *cfg,
>> @@ -1921,6 +1936,16 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>           SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG2");
>>           s->secure_eventq_irq_cfg2 = data;
>>           return MEMTX_OK;
>> +    case A_S_INIT:
>> +        SMMU_CHECK_SECURE_WRITE("S_INIT");
>> +        if (data & R_S_INIT_INV_ALL_MASK) {
>> +            /* write S_INIT and poll*/
>> +            s->secure_init = data & R_S_INIT_INV_ALL_MASK;
>> +            smmuv3_invalidate_all_caches(s);
> Do we need to check that the SMMU is enabled as the spec says?


Hi Mostafa,

Thanks for the feedback on this patch.

You are right, I did miss that necessary check in v1. I will review the 
specification and ensure that for the S_INIT register SMMUEN bit is 
checked. Additionally, I will take this opportunity to audit whether 
other registers also have dependencies on specific control bits before 
they can be accessed.


>
>> +        }
>> +        /* initialization is completed and set to 0 to terminate the polling */
>> +        s->secure_init = 0;
> All access to SMMU registers are serialised, so it’s safe to drop this and
> just return zero on reads.
>
This is a much cleaner way to model the Write-Only nature of this 
register. In v2, I will remove the secure_init field from the state 
structure and have the read handler for A_S_INIT always return zero.

Thanks again for the help.

Best regards,

Tao







