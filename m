Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F24D2F7DA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 10:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRTSM-0003JN-Uh; Fri, 05 Dec 2025 05:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRTSK-0003JB-E0; Fri, 05 Dec 2025 05:54:32 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRTSH-0006Li-SD; Fri, 05 Dec 2025 05:54:32 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDX31PguTJpV3E6AQ--.62741S2;
 Fri, 05 Dec 2025 18:54:24 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAXce7XuTJp_cUJAA--.24747S2;
 Fri, 05 Dec 2025 18:54:18 +0800 (CST)
Message-ID: <525bfc6f-041e-4fa5-8f11-c37a9fbcecba@phytium.com.cn>
Date: Fri, 5 Dec 2025 18:54:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 19/21] hw/arm/smmuv3: Use iommu_index to represent the
 security context
To: eric.auger@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151501.4131026-1-tangtao1634@phytium.com.cn>
 <dbc4d33e-3477-4f39-a745-4fdc0866fc08@linaro.org>
 <5bde6664-c830-44dd-9513-700980a43ade@phytium.com.cn>
 <75d10ffd-eafe-4daa-b763-6e1f3e90c766@linaro.org>
 <b5300243-01c0-4764-b2d1-5ed8ae70e499@phytium.com.cn>
 <8b1c2587-dd5c-481f-9509-a60b853208d2@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <8b1c2587-dd5c-481f-9509-a60b853208d2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXce7XuTJp_cUJAA--.24747S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAPBWkx6ywFAQAAsQ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtrWxKFy5CF1Duw43tryUAwb_yoWftFWUpF
 W8GFWUKrZ8JF1rAr1Iq3WUZrW3tryxJw13Xr1rKF1UAr4qyrn2qr48Xr1Y9r1DXr48AF1j
 vw1UJFW7ur15ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

On 2025/12/4 23:05, Eric Auger wrote:
>
> On 10/20/25 10:44 AM, Tao Tang wrote:
>> Hi Pierrick,
>>
>> On 2025/10/16 15:04, Pierrick Bouvier wrote:
>>> On 10/15/25 11:37 PM, Tao Tang wrote:
>>>> Hi Pierrick:
>>>>
>>>> On 2025/10/15 08:02, Pierrick Bouvier wrote:
>>>>> Hi Tao,
>>>>>
>>>>> On 10/12/25 8:15 AM, Tao Tang wrote:
>>>>>> The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) to
>>>>>> select
>>>>>> the programming interface. To support future extensions like RME,
>>>>>> which
>>>>>> defines four security states (Non-secure, Secure, Realm, and
>>>>>> Root), the
>>>>>> QEMU model must cleanly separate these contexts for all operations.
>>>>>>
>>>>>> This commit leverages the generic iommu_index to represent this
>>>>>> security context. The core IOMMU layer now uses the SMMU's
>>>>>> .attrs_to_index
>>>>>> callback to map a transaction's ARMSecuritySpace attribute to the
>>>>>> corresponding iommu_index.
>>>>>>
>>>>>> This index is then passed down to smmuv3_translate and used
>>>>>> throughout
>>>>>> the model to select the correct register bank and processing
>>>>>> logic. This
>>>>>> makes the iommu_index the clear QEMU equivalent of the architectural
>>>>>> SEC_SID, cleanly separating the contexts for all subsequent lookups.
>>>>>>
>>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>>> ---
>>>>>>     hw/arm/smmuv3.c | 36 +++++++++++++++++++++++++++++++++++-
>>>>>>     1 file changed, 35 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>>>> index c9c742c80b..b44859540f 100644
>>>>>> --- a/hw/arm/smmuv3.c
>>>>>> +++ b/hw/arm/smmuv3.c
>>>>>> @@ -1080,6 +1080,38 @@ static void smmuv3_fixup_event(SMMUEventInfo
>>>>>> *event, hwaddr iova)
>>>>>>         }
>>>>>>     }
>>>>>>     +static SMMUSecSID smmuv3_attrs_to_sec_sid(MemTxAttrs attrs)
>>>>>> +{
>>>>>> +    switch (attrs.space) {
>>>>>> +    case ARMSS_Secure:
>>>>>> +        return SMMU_SEC_SID_S;
>>>>>> +    case ARMSS_NonSecure:
>>>>>> +    default:
>>>>>> +        return SMMU_SEC_SID_NS;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * ARM IOMMU index mapping (implements SEC_SID from ARM SMMU):
>>>>>> + * iommu_idx = 0: Non-secure transactions
>>>>>> + * iommu_idx = 1: Secure transactions
>>>>>> + *
>>>>>> + * The iommu_idx parameter effectively implements the SEC_SID
>>>>>> + * (Security Stream ID) attribute from the ARM SMMU architecture
>>>>>> specification,
>>>>>> + * which allows the SMMU to differentiate between different security
>>>>>> state
>>>>>> + * transactions at the hardware level.
>>>>>> + */
>>>>>> +static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu,
>>>>>> MemTxAttrs attrs)
>>>>>> +{
>>>>>> +    return (int)smmuv3_attrs_to_sec_sid(attrs);
>>>>>> +}
>>>>>> +
>>>>>> +static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
>>>>>> +{
>>>>>> +    /* Support 2 IOMMU indexes for now: NS/S */
>>>>>> +    return SMMU_SEC_SID_NUM;
>>>>>> +}
>>>>>> +
>>>>>>     /* Entry point to SMMU, does everything. */
>>>>>>     static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr,
>>>>>> hwaddr
>>>>>> addr,
>>>>>>                                           IOMMUAccessFlags flag, int
>>>>>> iommu_idx)
>>>>>> @@ -1087,7 +1119,7 @@ static IOMMUTLBEntry
>>>>>> smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>>>>         SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>>>>>>         SMMUv3State *s = sdev->smmu;
>>>>>>         uint32_t sid = smmu_get_sid(sdev);
>>>>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>>>> +    SMMUSecSID sec_sid = iommu_idx;
>>>>>>         SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>>>>>         SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>>>>>>                                .sid = sid,
>>>>>> @@ -2540,6 +2572,8 @@ static void
>>>>>> smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>>>>>>           imrc->translate = smmuv3_translate;
>>>>>>         imrc->notify_flag_changed = smmuv3_notify_flag_changed;
>>>>>> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
>>>>>> +    imrc->num_indexes = smmuv3_num_indexes;
>>>>>>     }
>>>>>>       static const TypeInfo smmuv3_type_info = {
>>>>> I noticed that this commit breaks boot of a simple Linux kernel. It
>>>>> was already the case with v2, and it seems there is a deeper issue.
>>>>>
>>>>> Virtio drive initialization hangs up with:
>>>>> [    9.421906] virtio_blk virtio2: [vda] 20971520 512-byte logical
>>>>> blocks (10.7 GB/10.0 GiB)
>>>>> smmuv3_translate_disable smmuv3-iommu-memory-region-24-3 sid=0x18
>>>>> bypass (smmu disabled) iova:0xfffff040 is_write=1
>>>>>
>>>>> You can reproduce that with any kernel/rootfs, but if you want a
>>>>> simple recipe (you need podman and qemu-user-static):
>>>>> $ git clone https://github.com/pbo-linaro/qemu-linux-stack
>>>>> $ cd qemu-linux-stack
>>>>> $ ./build_kernel.sh
>>>>> $ ./build_rootfs.sh
>>>>> $ /path/to/qemu-system-aarch64 \
>>>>> -nographic -M virt,iommu=smmuv3 -cpu max -kernel out/Image.gz \
>>>>> -append "root=/dev/vda rw" out/host.ext4 -trace 'smmuv3*'
>>>>>
>>>>> Looking more closely,
>>>>> we reach SMMU_TRANS_DISABLE, because iommu_idx associated is 1.
>>>>> This values comes from smmuv3_attrs_to_sec_sid, by reading
>>>>> attrs.space, which is ArmSS_Secure.
>>>>>
>>>>> The problem is that it's impossible to have anything Secure given that
>>>>> all the code above runs in NonSecure world.
>>>>> After investigation, the original value read from attrs.space has not
>>>>> been set anywhere, and is just the default zero-initialized value
>>>>> coming from pci_msi_trigger. It happens that it defaults to SEC_SID_S,
>>>>> which probably matches your use case with hafnium, but it's an happy
>>>>> accident.
>>>>>
>>>>> Looking at the SMMU spec, I understand that SEC_SID is configured for
>>>>> each stream, and can change dynamically.
>>>>> On the opposite, a StreamID is fixed and derived from PCI bus and slot
>>>>> for a given device.
>>>>>
>>>>> Thus, I think we are missing some logic here.
>>>>> I'm still trying to understand where the SEC_SID should come from
>>>>> initially.
>>>>> "The association between a device and the Security state of the
>>>>> programming interface is a system-defined property."
>>>>> Does it mean we should be able to set a QEMU property for any device?
>>>>>
>>>>> Does anyone familiar with this has some idea?
>>>>>
>>>>> As well, we should check the SEC_SID found based on
>>>>> SMMU_S_IDR1.SECURE_IMPL.
>>>>> 3.10.1 StreamID Security state (SEC_SID)
>>>>> If SMMU_S_IDR1.SECURE_IMPL == 0, then incoming transactions have a
>>>>> StreamID, and either:
>>>>> • A SEC_SID identifier with a value of 0.
>>>>> • No SEC_SID identifer, and SEC_SID is implicitly treated as 0.
>>>>> If SMMU_S_IDR1.SECURE_IMPL == 1, incoming transactions have a
>>>>> StreamID, and a SEC_SID identifier.
>>>>>
>>>>> Regards,
>>>>> Pierrick
>>>> Thank you very much for your detailed review and in-depth analysis, and
>>>> for pointing out this critical issue that breaks the Linux boot.
>>>>
>>>>
>>>> To be transparent, my initial approach was indeed tailored to my
>>>> specific test case, where I was effectively hardcoding the device's
>>>> StreamID to represent it's a so-called Secure device in my self
>>>> testing.
>>>> This clearly isn't a general solution.
>>>>
>>> It's definitely not a bad approach, and it's a good way to exercise
>>> the secure path. It would have been caught by some of QEMU functional
>>> tests anyway, so it's not a big deal.
>>>
>>> A solution would be to define the secure attribute as a property of
>>> the PCI device, and query that to identify sec_sid accordingly.
>>> As you'll see in 3.10.1 StreamID Security state (SEC_SID), "Whether a
>>> stream is under Secure control or not is a different property to the
>>> target PA space of a transaction.", so we definitely should *not* do
>>> any funky stuff depending on which address is accessed.
>>
>> Thank you for the encouraging and very constructive feedback.
>>
>>
>> Your proposed solution—to define the security attribute as a property
>> on the PCIDevice—is the perfect way forward to resolve Secure device
>> issue. Perhaps we can implement this functionality in V4 as shown in
>> the following code snippet?
>>
>> 1)  define sec_sid in include/hw/pci/pci_device.h:
>>
>> struct PCIDevice {
>>      DeviceState qdev;
>> ......
>>      /* Add SEC_SID property for SMMU security context */
>>      uint8_t sec_sid;  /* 0 = Non-secure, 1 = Secure*/
>> ......
>>
>> }
>>
>>
>> 2) then add sec-sid field in the Property of PCI in hw/pci/pci.c:
>>
>> static const Property pci_props[] = {
>> ......
>>      /* SEC_SID property: 0=NS, 1=S */
>>      DEFINE_PROP_UINT8("sec-sid", PCIDevice, sec_sid, 0),
>>
>> ......
>>
>> };
> As this impacts the PCIe subsystem, I would encourage to submit that
> change in a separate pre-requisite series. This needs to be reviewed by
> Michael and other PCIe specialists.
>
> Thanks
>
> Eric


OK. I'll split this feature into another patch. Thanks for the guidance!


Best regards,
Tao



