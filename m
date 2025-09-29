Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB7CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 08:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v39Kl-0004zu-Gq; Mon, 29 Sep 2025 04:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v39Ki-0004zd-RK; Mon, 29 Sep 2025 04:34:08 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v39KU-000579-Nv; Mon, 29 Sep 2025 04:34:06 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHnWBdRNpoQ8qIBw--.10833S2;
 Mon, 29 Sep 2025 16:33:33 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCH7OlURNpopLMuAA--.1062S2;
 Mon, 29 Sep 2025 16:33:24 +0800 (CST)
Message-ID: <fcf54e8a-d4c6-49ea-b31a-35e2f5df1222@phytium.com.cn>
Date: Mon, 29 Sep 2025 16:33:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] hw/arm/smmuv3: Add separate address space for
 secure SMMU accesses
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-7-tangtao1634@phytium.com.cn>
 <9ea1fc2a-8280-4a31-92b9-4870bf2bf940@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <9ea1fc2a-8280-4a31-92b9-4870bf2bf940@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCH7OlURNpopLMuAA--.1062S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscBTAANs0
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWry5Cr4kCFW5Cry8Xw4xWFg_yoW7Jw1kpF
 Z5AFZYy3yUK3W7ZrZ7Xr17ua48W395WF4UCr4xGw1kAFnIyr1Syr42k3W5KF98Cr4UG3W2
 vF12vrs3Xa1YqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

On 2025/9/29 15:44, Eric Auger wrote:
> Hi Tao,
>
> On 9/25/25 6:26 PM, Tao Tang wrote:
>> According to the Arm architecture, SMMU-originated memory accesses,
>> such as fetching commands or writing events for a secure stream, must
>> target the Secure Physical Address (PA) space. The existing model sends
>> all DMA to the global address_space_memory.
>>
>> This patch introduces the infrastructure to differentiate between secure
>> and non-secure memory accesses. A weak global symbol,
>> arm_secure_address_space, is added, which can be provided by the
>> machine model to represent the Secure PA space.
>>
>> A new helper, smmu_get_address_space(), selects the target address
>> space based on the is_secure context. All internal DMA calls
>> (dma_memory_read/write) are updated to use this helper. Additionally,
>> the attrs.secure bit is set on transactions targeting the secure
>> address space.
> The last sentence does not seem to be implemented in that patch?


You are right to point this out, and my apologies for the confusion. As 
I was preparing the series, the patches were intertwined, and I didn't 
manage their boundaries clearly. This led me to mistakenly describe a 
feature in this commit message that is only implemented in a subsequent 
patch #07.

I'm very sorry for the confusion and the unnecessary time this has cost 
you. In all future community interactions, I will pay special attention 
to ensuring each patch and its description are atomic and self-contained 
to reduce the review burden for everyone. Thank you for your guidance on 
this.

>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         |  8 ++++++++
>>   hw/arm/virt.c                |  5 +++++
>>   include/hw/arm/smmu-common.h | 20 ++++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 62a7612184..24db448683 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -30,6 +30,14 @@
>>   #include "hw/arm/smmu-common.h"
>>   #include "smmu-internal.h"
>>   
>> +/* Global state for secure address space availability */
>> +bool arm_secure_as_available;
>> +
>> +void smmu_enable_secure_address_space(void)
>> +{
>> +    arm_secure_as_available = true;
>> +}
>> +
>>   /* IOTLB Management */
>>   
>>   static guint smmu_iotlb_key_hash(gconstpointer v)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 02209fadcf..805d9aadb7 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -92,6 +92,8 @@
>>   #include "hw/cxl/cxl_host.h"
>>   #include "qemu/guest-random.h"
>>   
>> +AddressSpace arm_secure_address_space;
>> +
>>   static GlobalProperty arm_virt_compat[] = {
>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>>   };
>> @@ -2243,6 +2245,9 @@ static void machvirt_init(MachineState *machine)
>>           memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>>                              UINT64_MAX);
>>           memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
>> +        address_space_init(&arm_secure_address_space, secure_sysmem,
>> +                           "secure-memory-space");
>> +        smmu_enable_secure_address_space();
>>       }
>>   
>>       firmware_loaded = virt_firmware_init(vms, sysmem,
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 3df82b83eb..cd61c5e126 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -53,6 +53,26 @@ typedef enum SMMUSecurityIndex {
>>       SMMU_SEC_IDX_NUM,
>>   } SMMUSecurityIndex;
>>   
>> +extern AddressSpace __attribute__((weak)) arm_secure_address_space;
>> +extern bool arm_secure_as_available;
>> +void smmu_enable_secure_address_space(void);
>> +
>> +static inline AddressSpace *smmu_get_address_space(SMMUSecurityIndex sec_sid)
>> +{
>> +    switch (sec_sid) {
>> +    case SMMU_SEC_IDX_S:
>> +    {
>> +        if (arm_secure_as_available) {
>> +            return &arm_secure_address_space;
>> +        }
> don't you want to return NULL or at least emit an error in case
> !arm_secure_as_available. When adding Realm support this will avoid to
> return NS AS.


That's a great point. Silently falling back to the non-secure address 
space is indeed dangerous. I will update the logic to return NULL and 
emit an error if the secure address space is requested but not available.

>> +    }
>> +    QEMU_FALLTHROUGH;
>> +    case SMMU_SEC_IDX_NS:
>> +    default:
> Maybe return an error here in case of other value than NS

Also I will change the default case to handle unexpected values by 
returning NULL, which will make the code safer for future extensions 
like Realm.  Then a check for the NULL return value at the call sites of 
smmu_get_address_space will be applied to handle the error appropriately 
in v3 series.


Thanks again for your helpful feedback.


Best,

Tao


>> +        return &address_space_memory;
>> +    }
>> +}
>> +
>>   /*
>>    * Page table walk error types
>>    */
> Thanks
>
> Eric


