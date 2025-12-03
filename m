Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2A3D12D62
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 13:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnFa-0003Jv-NL; Wed, 03 Dec 2025 08:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQnFX-0003Ik-Id; Wed, 03 Dec 2025 08:50:31 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQnFV-0000Si-Bu; Wed, 03 Dec 2025 08:50:31 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDn7SUXQDBpvZwrAQ--.12510S2;
 Wed, 03 Dec 2025 21:50:15 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwAnge4VQDBpl1EJAA--.24071S2;
 Wed, 03 Dec 2025 21:50:14 +0800 (CST)
Message-ID: <11a16f71-6849-4601-9a62-61d37eaa8265@phytium.com.cn>
Date: Wed, 3 Dec 2025 21:50:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 08/21] hw/arm/smmuv3: Add separate address space for
 secure SMMU accesses
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-9-tangtao1634@phytium.com.cn>
 <ac4ba17f-47ac-4c67-b2e6-c8d835ee0e6f@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <ac4ba17f-47ac-4c67-b2e6-c8d835ee0e6f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnge4VQDBpl1EJAA--.24071S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQAAso
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCw4Dur1UGFyxWw17Jr1UJrb_yoW5tr45pF
 Z5AFZ0y3yDK3W7ZFs3Xr1UuFy8u395WF4UGrs7Krn5CF1a9r1ayr1qkw1YkFykJr18J3W2
 vF1UZr4fXF1YqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025/12/2 21:53, Eric Auger wrote:
> Hi Tao,
>
> On 10/12/25 5:06 PM, Tao Tang wrote:
>> According to the Arm architecture, SMMU-originated memory accesses,
>> such as fetching commands or writing events for a secure stream, must
>> target the Secure Physical Address (PA) space. The existing model sends
>> all DMA to the global non-secure address_space_memory.
>>
>> This patch introduces the infrastructure to differentiate between secure
>> and non-secure memory accesses. Firstly, SMMU_SEC_SID_S is added in
>> SMMUSecSID enum to represent the secure context. Then a weak global
>> symbol, arm_secure_address_space, is added, which can be provided by the
>> machine model to represent the Secure PA space.
>>
>> A new helper, smmu_get_address_space(), selects the target address
>> space based on SEC_SID. All internal DMA calls
>> (dma_memory_read/write) will be updated to use this helper in follow-up
>> patches.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         |  8 ++++++++
>>   hw/arm/virt.c                |  5 +++++
>>   include/hw/arm/smmu-common.h | 27 +++++++++++++++++++++++++++
>>   3 files changed, 40 insertions(+)
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
> don't you need to initialize it?
>
> why is it local to the SMMU. To me the secure address space sounds
> global like address_space_memory usable by other IPs than the SMMU and
> the CPUs.
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
>> index 175023897a..83dc62a095 100644
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
>> @@ -2257,6 +2259,9 @@ static void machvirt_init(MachineState *machine)
>>           memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>>                              UINT64_MAX);
>>           memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
>> +        address_space_init(&arm_secure_address_space, secure_sysmem,
>> +                           "secure-memory-space");
> besides using dynamic allocation like in cpu_address_space_init() would
> allow to get rid of arm_secure_as_available


Thanks for the feedback.

I also think the extra arm_secure_as_available flag is unnecessary after 
read the cpu_address_space_init code.

For the next version I plan to:

- Drop the arm_secure_as_available concept entirely.

- Make the secure address space dynamically allocated in the machine 
code : secure_address_space = g_new0(AddressSpace, 1);

- Have smmu_get_address_space() simply check whether the secure 
AddressSpace * is non-NULL, instead of relying on a separate 
availability flag.

Thanks again for the review and suggestions. Best regards, Tao


