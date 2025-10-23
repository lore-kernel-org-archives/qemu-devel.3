Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BC6CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBrEH-0002Sy-Qq; Thu, 23 Oct 2025 05:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vBrEC-0002SL-FZ; Thu, 23 Oct 2025 05:03:24 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vBrE5-0003xx-KG; Thu, 23 Oct 2025 05:03:22 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnLiY87_lo6JNpAA--.53219S2;
 Thu, 23 Oct 2025 17:02:52 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLes07_lo9v9mAA--.37095S2;
 Thu, 23 Oct 2025 17:02:48 +0800 (CST)
Message-ID: <d7a46d7a-a169-4d51-af82-2e42cf3e75f2@phytium.com.cn>
Date: Thu, 23 Oct 2025 17:02:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 19/21] hw/arm/smmuv3: Use iommu_index to represent the
 security context
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
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
 <9bb20018-3349-4557-b004-ce4861d9abde@linaro.org>
 <9091bc65-75ff-48d3-aeb1-548853763054@phytium.com.cn>
 <4870b7df-4cb3-457e-9a18-87f3558adf09@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <4870b7df-4cb3-457e-9a18-87f3558adf09@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHLes07_lo9v9mAA--.37095S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWj5PBkB+gAIsP
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3Aw48uF1rKw43ZF4kuw48WFg_yoW8CFy8Go
 WfKrsxJw4Fqr17uF1UC34DJr1rJw15Jr1DXryUXr47JF1kt3WUW348JryUXayUJry8Grsr
 Ja45Jr1rAFyUJF1rn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
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

Hi Pierrick,

On 2025/10/23 05:23, Pierrick Bouvier wrote:
> On 2025-10-20 20:51, Tao Tang wrote:
>> Hi Pierrick,
>>
>> On 2025/10/21 06:55, Pierrick Bouvier wrote:
>>> On 2025-10-20 01:44, Tao Tang wrote:
>>>> Hi Pierrick,
>>>>
>>>> On 2025/10/16 15:04, Pierrick Bouvier wrote:
>>>>> On 10/15/25 11:37 PM, Tao Tang wrote:
>>>>>> Hi Pierrick:
>>>>>>
>>>>>> On 2025/10/15 08:02, Pierrick Bouvier wrote:
>>>>>>> Hi Tao,
>>>>>>>
>>>>>>> On 10/12/25 8:15 AM, Tao Tang wrote:
>>>>>>>> The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) to
>>>>>>>> select
>>>>>>>> the programming interface. To support future extensions like RME,
>>>>>>>> which
>>>>>>>> defines four security states (Non-secure, Secure, Realm, and 
>>>>>>>> Root),
>>>>>>>> the
>>>>>>>> QEMU model must cleanly separate these contexts for all 
>>>>>>>> operations.
>>>>>>>>
>>>>>>>> This commit leverages the generic iommu_index to represent this
>>>>>>>> security context. The core IOMMU layer now uses the SMMU's
>>>>>>>> .attrs_to_index
>>>>>>>> callback to map a transaction's ARMSecuritySpace attribute to the
>>>>>>>> corresponding iommu_index.
>>>>>>>>
>>>>>>>> This index is then passed down to smmuv3_translate and used
>>>>>>>> throughout
>>>>>>>> the model to select the correct register bank and processing 
>>>>>>>> logic.
>>>>>>>> This
>>>>>>>> makes the iommu_index the clear QEMU equivalent of the 
>>>>>>>> architectural
>>>>>>>> SEC_SID, cleanly separating the contexts for all subsequent 
>>>>>>>> lookups.
>>>>>>>>
>>>>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>>>>> ---
>>>>>>>>      hw/arm/smmuv3.c | 36 +++++++++++++++++++++++++++++++++++-
>>>>>>>>      1 file changed, 35 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>>>>>> index c9c742c80b..b44859540f 100644
>>>>>>>> --- a/hw/arm/smmuv3.c
>>>>>>>> +++ b/hw/arm/smmuv3.c
>>>>>>>> @@ -1080,6 +1080,38 @@ static void 
>>>>>>>> smmuv3_fixup_event(SMMUEventInfo
>>>>>>>> *event, hwaddr iova)
>>>>>>>>          }
>>>>>>>>      }
>>>>>>>>      +static SMMUSecSID smmuv3_attrs_to_sec_sid(MemTxAttrs attrs)
>>>>>>>> +{
>>>>>>>> +    switch (attrs.space) {
>>>>>>>> +    case ARMSS_Secure:
>>>>>>>> +        return SMMU_SEC_SID_S;
>>>>>>>> +    case ARMSS_NonSecure:
>>>>>>>> +    default:
>>>>>>>> +        return SMMU_SEC_SID_NS;
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * ARM IOMMU index mapping (implements SEC_SID from ARM SMMU):
>>>>>>>> + * iommu_idx = 0: Non-secure transactions
>>>>>>>> + * iommu_idx = 1: Secure transactions
>>>>>>>> + *
>>>>>>>> + * The iommu_idx parameter effectively implements the SEC_SID
>>>>>>>> + * (Security Stream ID) attribute from the ARM SMMU architecture
>>>>>>>> specification,
>>>>>>>> + * which allows the SMMU to differentiate between different
>>>>>>>> security
>>>>>>>> state
>>>>>>>> + * transactions at the hardware level.
>>>>>>>> + */
>>>>>>>> +static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu,
>>>>>>>> MemTxAttrs attrs)
>>>>>>>> +{
>>>>>>>> +    return (int)smmuv3_attrs_to_sec_sid(attrs);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
>>>>>>>> +{
>>>>>>>> +    /* Support 2 IOMMU indexes for now: NS/S */
>>>>>>>> +    return SMMU_SEC_SID_NUM;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      /* Entry point to SMMU, does everything. */
>>>>>>>>      static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr,
>>>>>>>> hwaddr
>>>>>>>> addr,
>>>>>>>> IOMMUAccessFlags flag, int
>>>>>>>> iommu_idx)
>>>>>>>> @@ -1087,7 +1119,7 @@ static IOMMUTLBEntry
>>>>>>>> smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>>>>>>          SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>>>>>>>>          SMMUv3State *s = sdev->smmu;
>>>>>>>>          uint32_t sid = smmu_get_sid(sdev);
>>>>>>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>>>>>> +    SMMUSecSID sec_sid = iommu_idx;
>>>>>>>>          SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>>>>>>>          SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>>>>>>>>                                 .sid = sid,
>>>>>>>> @@ -2540,6 +2572,8 @@ static void
>>>>>>>> smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>>>>>>>>            imrc->translate = smmuv3_translate;
>>>>>>>>          imrc->notify_flag_changed = smmuv3_notify_flag_changed;
>>>>>>>> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
>>>>>>>> +    imrc->num_indexes = smmuv3_num_indexes;
>>>>>>>>      }
>>>>>>>>        static const TypeInfo smmuv3_type_info = {
>>>>>>>
>>>>>>> I noticed that this commit breaks boot of a simple Linux kernel. It
>>>>>>> was already the case with v2, and it seems there is a deeper issue.
>>>>>>>
>>>>>>> Virtio drive initialization hangs up with:
>>>>>>> [    9.421906] virtio_blk virtio2: [vda] 20971520 512-byte logical
>>>>>>> blocks (10.7 GB/10.0 GiB)
>>>>>>> smmuv3_translate_disable smmuv3-iommu-memory-region-24-3 sid=0x18
>>>>>>> bypass (smmu disabled) iova:0xfffff040 is_write=1
>>>>>>>
>>>>>>> You can reproduce that with any kernel/rootfs, but if you want a
>>>>>>> simple recipe (you need podman and qemu-user-static):
>>>>>>> $ git clone https://github.com/pbo-linaro/qemu-linux-stack
>>>>>>> $ cd qemu-linux-stack
>>>>>>> $ ./build_kernel.sh
>>>>>>> $ ./build_rootfs.sh
>>>>>>> $ /path/to/qemu-system-aarch64 \
>>>>>>> -nographic -M virt,iommu=smmuv3 -cpu max -kernel out/Image.gz \
>>>>>>> -append "root=/dev/vda rw" out/host.ext4 -trace 'smmuv3*'
>>>>>>>
>>>>>>> Looking more closely,
>>>>>>> we reach SMMU_TRANS_DISABLE, because iommu_idx associated is 1.
>>>>>>> This values comes from smmuv3_attrs_to_sec_sid, by reading
>>>>>>> attrs.space, which is ArmSS_Secure.
>>>>>>>
>>>>>>> The problem is that it's impossible to have anything Secure given
>>>>>>> that
>>>>>>> all the code above runs in NonSecure world.
>>>>>>> After investigation, the original value read from attrs.space 
>>>>>>> has not
>>>>>>> been set anywhere, and is just the default zero-initialized value
>>>>>>> coming from pci_msi_trigger. It happens that it defaults to
>>>>>>> SEC_SID_S,
>>>>>>> which probably matches your use case with hafnium, but it's an 
>>>>>>> happy
>>>>>>> accident.
>>>>>>>
>>>>>>> Looking at the SMMU spec, I understand that SEC_SID is 
>>>>>>> configured for
>>>>>>> each stream, and can change dynamically.
>>>>>>> On the opposite, a StreamID is fixed and derived from PCI bus and
>>>>>>> slot
>>>>>>> for a given device.
>>>>>>>
>>>>>>> Thus, I think we are missing some logic here.
>>>>>>> I'm still trying to understand where the SEC_SID should come from
>>>>>>> initially.
>>>>>>> "The association between a device and the Security state of the
>>>>>>> programming interface is a system-defined property."
>>>>>>> Does it mean we should be able to set a QEMU property for any 
>>>>>>> device?
>>>>>>>
>>>>>>> Does anyone familiar with this has some idea?
>>>>>>>
>>>>>>> As well, we should check the SEC_SID found based on
>>>>>>> SMMU_S_IDR1.SECURE_IMPL.
>>>>>>> 3.10.1 StreamID Security state (SEC_SID)
>>>>>>> If SMMU_S_IDR1.SECURE_IMPL == 0, then incoming transactions have a
>>>>>>> StreamID, and either:
>>>>>>> • A SEC_SID identifier with a value of 0.
>>>>>>> • No SEC_SID identifer, and SEC_SID is implicitly treated as 0.
>>>>>>> If SMMU_S_IDR1.SECURE_IMPL == 1, incoming transactions have a
>>>>>>> StreamID, and a SEC_SID identifier.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Pierrick
>>>>>>
>>>>>> Thank you very much for your detailed review and in-depth analysis,
>>>>>> and
>>>>>> for pointing out this critical issue that breaks the Linux boot.
>>>>>>
>>>>>>
>>>>>> To be transparent, my initial approach was indeed tailored to my
>>>>>> specific test case, where I was effectively hardcoding the device's
>>>>>> StreamID to represent it's a so-called Secure device in my self
>>>>>> testing.
>>>>>> This clearly isn't a general solution.
>>>>>>
>>>>>
>>>>> It's definitely not a bad approach, and it's a good way to exercise
>>>>> the secure path. It would have been caught by some of QEMU functional
>>>>> tests anyway, so it's not a big deal.
>>>>>
>>>>> A solution would be to define the secure attribute as a property of
>>>>> the PCI device, and query that to identify sec_sid accordingly.
>>>>> As you'll see in 3.10.1 StreamID Security state (SEC_SID), "Whether a
>>>>> stream is under Secure control or not is a different property to the
>>>>> target PA space of a transaction.", so we definitely should *not* do
>>>>> any funky stuff depending on which address is accessed.
>>>>
>>>>
>>>> Thank you for the encouraging and very constructive feedback.
>>>>
>>>>
>>>> Your proposed solution—to define the security attribute as a 
>>>> property on
>>>> the PCIDevice—is the perfect way forward to resolve Secure device 
>>>> issue.
>>>> Perhaps we can implement this functionality in V4 as shown in the
>>>> following code snippet?
>>>>
>>>> 1)  define sec_sid in include/hw/pci/pci_device.h:
>>>>
>>>> struct PCIDevice {
>>>>        DeviceState qdev;
>>>> ......
>>>>        /* Add SEC_SID property for SMMU security context */
>>>>        uint8_t sec_sid;  /* 0 = Non-secure, 1 = Secure*/
>>>> ......
>>>>
>>>> }
>>>>
>>>>
>>>> 2) then add sec-sid field in the Property of PCI in hw/pci/pci.c:
>>>>
>>>> static const Property pci_props[] = {
>>>> ......
>>>>        /* SEC_SID property: 0=NS, 1=S */
>>>>        DEFINE_PROP_UINT8("sec-sid", PCIDevice, sec_sid, 0),
>>>>
>>>> ......
>>>>
>>>> };
>>>>
>>>>
>>>> 3) get sec-sid in smmu_find_add_as(hw/arm/smmu-common.c):
>>>>
>>>> static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int
>>>> devfn)
>>>> {
>>>>        SMMUState *s = opaque;
>>>>        SMMUPciBus *sbus =
>>>> g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
>>>>        SMMUDevice *sdev;
>>>>        static unsigned int index;
>>>>        ......
>>>>        sdev = sbus->pbdev[devfn];
>>>>        if (!sdev) {
>>>>
>>>>            PCIDevice *pcidev;
>>>>            pcidev = pci_find_device(bus, pci_bus_num(bus), devfn);
>>>>            if (pcidev) {
>>>>                /* Get sec_sid which is originally from QEMU options.
>>>>                 * For example:
>>>>                 * qemu-system-aarch64 \
>>>>                 * -drive if=none,file=/nvme.img,format=raw,id=nvme0 \
>>>>                 * -device nvme,drive=nvme0,serial=deadbeef,sec-sid=1
>>>>                 *
>>>>                 * This NVMe device will have sec_sid = 1.
>>>>                */
>>>>                sdev->sec_sid = pcidev->sec_sid;
>>>>            } else {
>>>>                /* Default to Non-secure if device not found */
>>>>                sdev->sec_sid = 0;
>>>>            }
>>>>
>>>> ......
>>>>
>>>> }
>>>>
>>>> The SEC_SID of device will be passed from QEMU options to PCIDevice 
>>>> and
>>>> then SMMUDevice. This would allow the SMMU model to perform the
>>>> necessary checks against both the security context of the DMA 
>>>> access and
>>>> the SMMU_S_IDR1.SECURE_IMPL capability bit.
>>>>
>>>>
>>>> Is this a reasonable implementation approach? I would greatly 
>>>> appreciate
>>>> any feedback.
>>>>
>>>
>>> Yes, this looks reasonable.
>>> However, for Realm support, the sec_sid is not static, and can be
>>> changed dynamically by the device itself, after interaction with RMM
>>> firmware, following TDISP protocol (T bit is set in PCI transactions,
>>> which we don't model in QEMU).
>>>
>>> See 3.9.4 SMMU interactions with the PCIe fields T, TE and XT.
>>>
>>> This T bit state is currently stored out of QEMU, as we use the
>>> external program spdm-emu for all that. So, we implemented a very
>>> hacky solution detecting when this device it set in "Realm" mode based
>>> on config prefetch with this new sec_sid:
>>> https://github.com/pbo-linaro/qemu/commit/c4db6f72c26ac52739814621ce018e65869f934b 
>>>
>>>
>>> It uses a dictionnary simply because of lifetime issue, as the config
>>> seems to be emitted before the first access of the device in our case.
>>> I didn't dig further. It all cases, it's ugly, not a reference, and
>>> just a work in progress to show you how we need to update it.
>>
>>
>> Thank you for the detailed feedback and for approving the new direction.
>> I'm glad we are aligned on the path forward.
>>
>>
>> It's interesting that you mention the dynamic update mechanism for
>> Realm. In my early testing, before submitting the RFC patches, I
>> actually experimented with a similar dynamic approach. I defined a
>> custom QMP interface to directly modify a bitmap structure inside the
>> SMMU model, which was used to dynamically mark or unmark a StreamID as
>> secure. The lookup logic was something like this:
>>
>> bool smmuv3_sid_is_secure(uint32_t sid)
>> {
>>       uint32_t chunk_idx;
>>       uint32_t bit_idx;
>>       SidBitmapChunk *chunk;
>>
>>       chunk_idx = SID_INDEX(sid);
>>       bit_idx = SID_BIT(sid);
>>
>>       /* Check if we have a bitmap for this chunk */
>>       chunk = sid_manager.chunks[chunk_idx];
>>       if (!chunk) {
>>           return false;
>>       }
>>       /* Fast bitmap lookup */
>>       return test_bit(bit_idx, chunk->bitmap);
>> }
>>
>>
>> Ultimately, I didn't include this in the patch series because managing
>> the security context completely separately from the device felt a bit
>> strange and wasn't a clean architectural fit.
>>
>>>
>>> All that to said that even though we can provide this static property
>>> for devices that are always secure, the design will have to support
>>> dynamic changes as well. Not a big deal, and you can keep this out of
>>> scope for now, we'll change that later when adding Realms support.
>>> As long as we have something that does not break non secure use case
>>> while allowing secure devices, I think we're good!
>>
>>
>> I completely agree. I will proceed with an initial version based on the
>> static property approach we discussed, ensuring that Non-secure
>> regression tests pass. The behavior will be as follows as you suggested
>> in previous thread:
>>
>> - For a Non-secure device (sec_sid=0), all accesses will be treated as
>> Non-secure.
>>
>> - For a Secure device (sec_sid=1), if MemTxAttrs.space is Secure and
>> SMMU_S_IDR1.SECURE_IMPL == 1, the access will be Secure.
>>
>> - For a Secure device (sec_sid=1), if MemTxAttrs.space is Non-secure,
>> the access will remain Non-secure.
>>
>
> That's good.
>
>>
>>>>
>>>>>
>>>>> By curiosity, which kind of secure device are you using? Is it one of
>>>>> the device available upstream, or a specific one you have in your 
>>>>> fork?
>>>>
>>>>
>>>> I just use IGB NIC for test with Hafnium + OP-TEE software stack.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> You've raised a crucial architectural point that I hadn't fully
>>>>>> considered: how a standard "Normal World" PCIe device should be
>>>>>> properly
>>>>>> associated with the "Secure World". To be honest, I didn't have a
>>>>>> clear
>>>>>> answer for this, so your feedback is a perfect opportunity for me
>>>>>> to dig
>>>>>> in and understand this area correctly.
>>>>>>
>>>>> It took time for us to reach that question also.
>>>>> Our current understanding is that SEC_SID == Realm is identified by
>>>>> bits on pci side (part of TDISP protocol), and that secure devices 
>>>>> are
>>>>> indeed hardcoded somewhere.
>>>>>
>>>>> We asked this question to some Arm folks working on this area, to
>>>>> confirm Secure devices are supposed to be defined this way.
>>>>
>>>>
>>>> Thank you also for sharing the invaluable context from your team's
>>>> internal discussions and your outreach to the Arm experts. This
>>>> clarification directly inspired my new proposal as described above.
>>>>
>>>
>>> We didn't receive an answer, but after looking more at how secure
>>> world is modelled (with separate address space), it makes sense to
>>> have this description built in in the firmware or the platform itself.
>>>
>>> I'm not familiar with Hafnium, but I don't expect any device to
>>> transition from Non secure to Secure world similar to Realm approach.
>>
>>
>> This has been a long-standing question of mine as well. Your intuition
>> makes perfect sense to me: if a device can switch between Secure and
>> Non-secure states at will, it seems physically insecure. A device could
>> be compromised while in the Non-secure state and then carry that
>> compromised state into the Secure World, which would undermine the very
>> protections the SMMU aims to provide. For the Realm state, I am not very
>> familiar with Realm either, but I will definitely study the PCIe and
>> SMMU specifications to better understand the mechanisms that ensure
>> security during these dynamic transitions between Realm and Non-Realm 
>> state.
>>
>
> For completeness, we received an answer about this topic, and this 
> confirm what we said on this thread.
>
> "Prior to RME and RME-DA, PCIe devices were only assignable to 
> Non-secure state (SEC_SID=NS) as there was no architected method to 
> allow them to be assigned to Secure state.
> RME-DA and TDISP allow a PCIe device to have SEC_SID that is either 
> Realm or Non-secure."
>
> > How SEC_SID == Secure is identified?
>
> "This would be set by the system, usually by statically marking 
> certain on-chip devices with SEC_SID=Secure."


Thank you for sharing the official confirmation from Arm. It's great to 
have this final validation for our approach.

With the architectural path now clear, I will proceed with implementing 
the v4 patch series as we've discussed.

Thanks again for your guidance and collaboration.

Best regards,

Tao

>
>>
>>>
>>>>
>>>> I will proceed with this plan for the v4 patch set. Thanks again for
>>>> your mentorship and for helping to clarify the correct path forward.
>>>>
>>>
>>> Thanks for your series, it's definitely a great base to work on Realm
>>> support, and we'll be glad to publish this later, after secure support
>>> is merged. It will be your turn to review and give feedback if you
>>> want :)
>>
>>
>> Thank you for the kind offer! I would be absolutely thrilled to
>> contribute in any way I can to the future Realm support work and I look
>> forward to it.
>>
>
> I will ping you on time for this!
>
>>
>> Yours,
>>
>> Tao
>>
> Regards,
> Pierrick


