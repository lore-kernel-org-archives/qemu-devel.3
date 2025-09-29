Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD79CCA470
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GLc-0006Rg-8h; Mon, 29 Sep 2025 12:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3GLM-00068y-Vv; Mon, 29 Sep 2025 12:03:20 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3GLG-0003PJ-2g; Mon, 29 Sep 2025 12:03:14 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBXRVywrdpoWgsAAA--.93S2;
 Tue, 30 Sep 2025 00:02:56 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.232.83])
 by mail (Coremail) with SMTP id AQAAfwCnDeuprdpoFI4vAA--.40173S2;
 Tue, 30 Sep 2025 00:02:51 +0800 (CST)
Message-ID: <36dc34ba-2673-4529-9af7-4f83b4478cbf@phytium.com.cn>
Date: Tue, 30 Sep 2025 00:02:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] hw/arm/smmuv3: Use iommu_index to represent the
 security context
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
 <39446b6c-d7dd-4aeb-a2ee-96db03997e4a@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <39446b6c-d7dd-4aeb-a2ee-96db03997e4a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCnDeuprdpoFI4vAA--.40173S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscNoQAAsY
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr1UAr48JF4DAw4kXw4fXwb_yoWrAF4DpF
 48GFZxKa1fJFy3Ar1fJa1UZF4a93ykKry7ZFZxK3Z5CF1DZrn7JryvkFyYgryDurWUCw42
 va109FW3WF1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025/9/29 23:33, Eric Auger wrote:
>
> On 9/26/25 5:08 AM, Tao Tang wrote:
>> Resending patches 12–14/14 that were missing due to a send issue. Sorry
>> for the noise.
>>
>> The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) to select
>> the programming interface. To support future extensions like RME, which
>> defines four security states (Non-secure, Secure, Realm, and Root), the
>> QEMU model must cleanly separate these contexts for all operations.
>>
>> This commit leverages the generic iommu_index to represent this
>> security context. The core IOMMU layer now uses the SMMU's .attrs_to_index
>> callback to map a transaction's ARMSecuritySpace attribute to the
>> corresponding iommu_index.
>>
>> This index is then passed down to smmuv3_translate and used throughout
>> the model to select the correct register bank and processing logic. This
>> makes the iommu_index the clear QEMU equivalent of the architectural
>> SEC_SID, cleanly separating the contexts for all subsequent lookups.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 37 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index eec36d5fd2..c92cc0f06a 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1099,6 +1099,38 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
>>       }
>>   }
>>
>> +static SMMUSecurityIndex smmuv3_attrs_to_security_index(MemTxAttrs attrs)
>> +{
>> +    switch (attrs.space) {
>> +    case ARMSS_Secure:
>> +        return SMMU_SEC_IDX_S;
>> +    case ARMSS_NonSecure:
>> +    default:
>> +        return SMMU_SEC_IDX_NS;
>> +    }
>> +}
>> +
>> +/*
>> + * ARM SMMU IOMMU index mapping (implements SEC_SID from ARM SMMU):
>> + * iommu_idx = 0: Non-secure transactions
>> + * iommu_idx = 1: Secure transactions
>> + *
>> + * The iommu_idx parameter effectively implements the SEC_SID
>> + * (Security Stream ID) attribute from the ARM SMMU architecture
>> + * specification, which allows the SMMU to differentiate between
>> + * secure and non-secure transactions at the hardware level.
>> + */
>> +static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
>> +{
>> +    return smmuv3_attrs_to_security_index(attrs);
>> +}
>> +
>> +static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
>> +{
>> +    /* Support 2 IOMMU indexes for now: NS/S */
>> +    return SMMU_SEC_IDX_NUM;
>> +}
>> +
>>   /* Entry point to SMMU, does everything. */
>>   static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>                                         IOMMUAccessFlags flag, int iommu_idx)
>> @@ -1111,7 +1143,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>                              .inval_ste_allowed = false};
>>       SMMUTranslationStatus status;
>>       SMMUTransCfg *cfg = NULL;
>> -    SMMUSecurityIndex sec_idx = SMMU_SEC_IDX_NS;
>> +    SMMUSecurityIndex sec_idx = iommu_idx;
>>       IOMMUTLBEntry entry = {
>>           .target_as = &address_space_memory,
>>           .iova = addr,
>> @@ -1155,6 +1187,7 @@ epilogue:
>>           entry.perm = cached_entry->entry.perm;
>>           entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>>           entry.addr_mask = cached_entry->entry.addr_mask;
>> +        entry.target_as = cached_entry->entry.target_as;
> this change looks unrelated to the commit desc.
>
> Eric


You are absolutely right. That line of code is clearly part of the IOTLB 
cache logic and doesn't belong in this commit.

I will move this change to the relevant IOTLB cache commit in the next 
version of the series.

Thanks for catching that.

Best,
Tao

>>           trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
>>                                          entry.translated_addr, entry.perm,
>>                                          cfg->stage);
>> @@ -2534,6 +2567,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>>
>>       imrc->translate = smmuv3_translate;
>>       imrc->notify_flag_changed = smmuv3_notify_flag_changed;
>> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
>> +    imrc->num_indexes = smmuv3_num_indexes;
>>   }
>>
>>   static const TypeInfo smmuv3_type_info = {
>> --
>> 2.34.1
>>


