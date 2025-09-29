Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A77CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Fi3-0000P7-NT; Mon, 29 Sep 2025 11:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3Fhy-0000NH-8O; Mon, 29 Sep 2025 11:22:34 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3Fhm-0007yv-6Q; Mon, 29 Sep 2025 11:22:33 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3P9sfpNpo69CJBw--.5S2;
 Mon, 29 Sep 2025 23:22:07 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.232.83])
 by mail (Coremail) with SMTP id AQAAfwD3WecepNpoTmIvAA--.28826S2;
 Mon, 29 Sep 2025 23:22:06 +0800 (CST)
Message-ID: <fb2f172f-36ce-487e-88d8-3b354f25f183@phytium.com.cn>
Date: Mon, 29 Sep 2025 23:22:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] hw/arm/smmuv3: Add security-state handling for
 page table walks
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-9-tangtao1634@phytium.com.cn>
 <a9fe0e74-652d-48b7-89b1-73f28d1c63a4@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <a9fe0e74-652d-48b7-89b1-73f28d1c63a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3WecepNpoTmIvAA--.28826S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscNDwADs1
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3JFW7ZFy3JrWfZrWfWr13twb_yoW7ArWDp3
 ykG3Z8Kws7GF1Ivrn3Zr4293WFg395GF4UGr1agr95Ar4YqryfJF1IkF1YkFyDCrn5AF42
 vF1jgr98Ca15ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Eric,

On 2025/9/29 22:21, Eric Auger wrote:
> Hi Tao,
>
> On 9/25/25 6:26 PM, Tao Tang wrote:
>> This patch introduces the necessary logic to handle security states
>> during the page table translation process.
>>
>> Support for the NS (Non-secure) attribute bit is added to the parsing of
>> various translation structures, including CD and PTEs. This allows the
>> SMMU model to correctly determine the security properties of memory
>> during a translation.
>>
>> With this change, a new translation stage is added:
>>
>> - Secure Stage 1 translation
>>
>> Note that this commit does not include support for Secure Stage 2
>> translation, which will be addressed in the future.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         | 55 ++++++++++++++++++++++++++++++++----
>>   hw/arm/smmu-internal.h       |  7 +++++
>>   hw/arm/smmuv3-internal.h     |  2 ++
>>   hw/arm/smmuv3.c              |  2 ++
>>   hw/arm/trace-events          |  2 +-
>>   include/hw/arm/smmu-common.h |  4 +++
>>   6 files changed, 66 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index bc13b00f1d..f563cba023 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -398,20 +398,25 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>>    * @base_addr[@index]
> Wile we add some new params it may be relevant to add some new doc
> comments above


Thank you for another incredibly thorough and insightful review. I 
sincerely appreciate you taking the time to go through the code in such 
detail.


You're right. I missed some necessary comments when adding new 
parameters. I will add them in next series.

>>    */
>>   static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
>> -                   SMMUPTWEventInfo *info)
>> +                   SMMUPTWEventInfo *info, SMMUTransCfg *cfg, int walk_ns)
> I see a cfg param is added while not used.

My original plan was to cache the NS attr in a cfg->walk_ns field, which 
is why I passed cfg into this function. I later realized this caching 
wasn't necessary and removed the walk_ns member from the struct, but I 
clearly missed removing the now-redundant cfg parameter from the 
function signature. Thanks for spotting this oversight; I will remove it 
in v3.

> why walk_ns is an int while it seems to match a SecureIndex type? while
> not directly passing the sec_sid?


You're right. I will replace 'int walk_ns '  with sec_sid in v3.

>>
>> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
>> index d143d296f3..cb3a6eb8d1 100644
>> --- a/hw/arm/smmu-internal.h
>> +++ b/hw/arm/smmu-internal.h
>> @@ -58,6 +58,10 @@
>>       ((level == 3) &&                                                    \
>>        ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
>>   
>> +/* Non-secure bit */
>> +#define PTE_NS(pte) \
>> +    (extract64(pte, 5, 1))
>> +
> I have not read that code for a while. Might be worth to create
> differentiated sections for the different kinds of descriptors
> For instance NS belongs to block & page descriptor while NSTable belongs
> to a table descriptor.


The original code didn't have clear comments to differentiate between 
the descriptor types. Now that I've introduced the new NS and NSTable 
attribute bits, which can be easily confused, it has become necessary to 
add these clarifying sections. I will add comments to group the macros 
by descriptor type to improve readability in the next version. Thanks 
for the suggestion.

>>   
>>   
>>   /**
>>    * tg2granule - Decodes the CD translation granule size field according
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index eba709ae2b..2f8494c346 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -832,6 +832,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>>               tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
>>           }
>>   
>> +        tt->nscfg = i ? CD_NSCFG1(cd) : CD_NSCFG0(cd);
>>           tt->had = CD_HAD(cd, i);
>>           trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>>       }
>> @@ -929,6 +930,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>>           cfg->sec_idx = sec_idx;
>>           cfg->txattrs = smmu_get_txattrs(sec_idx);
>>           cfg->as = smmu_get_address_space(sec_idx);
>> +        cfg->sel2 = s->bank[SMMU_SEC_IDX_S].idr[1];
> S_IDR1 contains other feilds than SEL2 such as S_SIDSIZE?
>
> Can't you split that patch again into 2 patches:
> one related to the config data extraction and another one related to
> page table walk according to the config settings?


Sure. I'll split it into 2 patchs in v3 and cfg->sel2 will be corrected.

>>   
>>
>>   
>>   typedef struct SMMUTLBEntry {
>> @@ -116,6 +117,7 @@ typedef struct SMMUTLBEntry {
>>       uint8_t level;
>>       uint8_t granule;
>>       IOMMUAccessFlags parent_perm;
>> +    SMMUSecurityIndex sec_idx;
>>   } SMMUTLBEntry;
>>   
>>   /* Stage-2 configuration. */
>> @@ -156,6 +158,8 @@ typedef struct SMMUTransCfg {
>>       SMMUSecurityIndex sec_idx; /* cached security index */
>>       MemTxAttrs txattrs;        /* cached transaction attributes */
>>       AddressSpace *as;          /* cached address space */
>> +    bool current_walk_ns;      /* cached if the current walk is non-secure */
> this does not seem to be used?
>> +    bool sel2;
> would require a comment to remind the reader what sel2 is.
>>   } SMMUTransCfg;
>>   
>>   typedef struct SMMUDevice {
> Thanks
>
> Eric


Yes. current_walk_ns will be removed and comment will be add in v3.

Thanks,

Tao


