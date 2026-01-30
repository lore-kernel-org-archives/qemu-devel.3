Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EBD358D6
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhsA-0000ba-KK; Fri, 30 Jan 2026 01:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vlhs6-0000bE-2C
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:20:46 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vlhs1-0004HT-Jh
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:20:45 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60U6ItvE073287
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 30 Jan 2026 15:20:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oG1Rkq+CejAIqoisUydvv389gbD+ZKDstD1GnxtJZOU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769754035; v=1;
 b=fI7pwDPC5D8a6le0+Z3MxZm+hChq30jeQLq98zwdTKxu3WlL7u/Z7CYmPq9MWAKd
 qpHrDj3gQsZsqjxUvhezmaFcy3VS5PJ1MjeIHcDuEicSmFd5ykwGzvL1ZAd/njlt
 eZt9R0gl02JFfp2qlIxHv0xde+iLgn6NvmKpDUrPmrcjj8HnK0C2WxGgxF1aKzKY
 QkDMyYyqbCPEsv9WFuC6jDmXMPuOhzjcoyTSEvhw3EwGJ0cdyilEinxR+en7ZE7q
 verLCV5Tj8ShiUkgni2dp7GRQ1T5o3xqs4tFaStP2ViXuJFAIOuH7ZZQ+VKpxuLh
 D1v0Bbd837qNb+4y/Qc8QQ==
Message-ID: <324415cd-f74f-4198-bee6-493b976656e9@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 30 Jan 2026 15:18:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-3-vivek.kasireddy@intel.com>
 <0d57e3df-3ae6-496f-b621-8d979e2ab3f8@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185FE7AA93FDB21AE6F8D14F890A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <2883c714-f03b-4381-920a-959a98380c23@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185A50C661BB777686D16A4F89EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <462b513c-c505-4570-bd52-a1cfacc7c769@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185D3C0DC8118D17DE156E2F89FA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185D3C0DC8118D17DE156E2F89FA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/30 14:57, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
>> associated with a ram device
>>>>>> On 2026/01/23 15:17, Vivek Kasireddy wrote:
>>>>>>> If the Guest provides a DMA address that is associated with a ram
>>>>>>> device (such as a PCI device region and not its system memory),
>>>>>>> then we can obtain the hva (host virtual address) by invoking
>>>>>>> address_space_translate() followed by
>>>> memory_region_get_ram_ptr().
>>>>>>>
>>>>>>> This is because the ram device's address space is not accessible
>>>>>>> to virtio-gpu directly and hence dma_memory_map() cannot be
>> used.
>>>>>>
>>>>>> This description is a bit confusing.
>>>>> I agree; the description does seem ambiguous.
>>>>>
>>>>>>
>>>>>> The first problem is with the phrase "the ram device's address
>> space".
>>>>>> The address space we are dealing with is always
>>>>>> VIRTIO_DEVICE(g)->dma_as. More precisely it is a memory region,
>> not
>>>>>> address space.
>>>>>>
>>>>>> The second problem is that it says the ram device's memory region is
>>>> not
>>>>>> directly accessible. It is usually true, but here we are directly
>>>>>> accessing it anyway because the guest knows how to do so.
>>>>> Does this look better:
>>>>>       "virtio-gpu: Find hva for Guest's DMA addr associated with a ram
>>>> device
>>>>>
>>>>>        If the Guest provides a DMA address that is associated with a ram
>>>>>        device (such as a PCI device region and not its system memory),
>>>>>        then we can obtain the hva (host virtual address) by invoking
>>>>>        address_space_translate() followed by
>>>> memory_region_get_ram_ptr().
>>>>>
>>>>>        We cannot use dma_memory_map() in this case to get the hva
>>>> because
>>>>>        it can only be used with addresses that are associated with the
>>>>>        system (or physical) memory region. Therefore, in order to handle
>>>>>        addresses associated with ram devices, we need to use the
>>>>>        address_space_translate() API to first identify the right memory
>>>>>        region and the appropriate offset within that region and then use
>>>>>        memory_region_get_ram_ptr() to get the hva. This approach also
>>>>>        works for addresses associated with the system memory region.
>>>>
>>>> Sorry but I don't think it's improved much. It still contains a phrase
>>>> not well-established ("system (or physical) memory region").
>>> I think it is well-established given this line in include/system/memory.h:
>>> /* address_space_map: map a physical memory region into a host
>> virtual address
>>> and considering the fact that address_space_map() is called by
>>> dma_memory_map().
>>
>> I guess not that particular phrase is wrong but the expression "it can
>> only be used with addresses that are associated with the system (or
>> physical) memory region" is not quite precise as whole.
>>
>> address_space_map() or dma_memory_map() can actually be used with
>> any
>> memory region. It however creates a bounce buffer if not directly
>> accessible.
>>
>>>
>>>>
>>>> The description of what the logic does is expanded, but it's not really
>>>> useful; it says the logic is to add the offset and the retrieved
>>>> pointer, but it's obvious if you read the code. So let's focus on "why"
>>>> the logic is added instead of what the logic does.
>>>>
>>>> Below is my analysis on "why":
>>>> First, let's stick to the phrase "direct access"; its meaning is
>>>> established in include/system/memory.h.
>>>>
>>>> With the concept of "direct access", the underlying problem being
>> solved
>>>> can be understood as follows: dma_memory_map() automatically
>>>> determines
>>>> what is directly accessible, and VFIO devices are considered not
>>>> directly accessible because such accesses may be part of MMIO. But
>>>> virtio-gpu is not doing MMIO, which leads to a disagreement with the
>>>> function and virtio-gpu.
>>> Here is another try:
>>>       "virtio-gpu: Find hva for Guest's DMA addr associated with a ram
>> device
>>>
>>>       If the Guest provides a DMA address that is associated with a ram
>>>       device (such as a VFIO PCI device region and not its system memory),
>>>       then we can obtain the hva (host virtual address) by invoking
>>>       address_space_translate() followed by
>> memory_region_get_ram_ptr().
>>>
>>>       We cannot use dma_memory_map() in this case to get the hva
>> because
>>>       it can only be used with addresses that are associated with memory
>>>       regions that support direct access. Since VFIO device regions are
>>>       not considered directly accessible (because they are mostly MMIO
>> based),
>>>       dma_memory_map() would fail to return the hva for such addresses
>>>       when invoked by virtio-gpu.
>>>
>>>       Therefore, in order to handle addresses associated with VFIO devices,
>>>       we need to use the address_space_translate() API to first identify
>>>       the right memory region and the appropriate offset within that
>>>       region and then use memory_region_get_ram_ptr() to get the hva.
>>>       This approach also works for addresses associated with the system
>>>       memory region.
>>>
>>>       Note that, although we take an explicit reference on the memory
>>>       region, we would still rely on dma_memory_unmap() to drop that
>>>       reference when the dma mapping is eventually unmapped."
>>
>> This is better. Can you also address the inaccuracy of the statement "We
>> cannot use dma_memory_map()..." which I noted above?
> Just to confirm if my rewrite matches with what you have in mind, here is
> how I am planning to replace the 2nd paragraph that starts with
> "We cannot use dma_memory_map()" in the next version:
> So, instead of
>    "We cannot use dma_memory_map() in this case to get the hva because
>      it can only be used with addresses that are associated with memory
>      regions that support direct access. Since VFIO device regions are
>      not considered directly accessible (because they are mostly MMIO based),
>      dma_memory_map() would fail to return the hva for such addresses
>      when invoked by virtio-gpu."
> 
> I am going to replace it with
>    "We cannot use dma_memory_map() because for memory regions that do
>      not support direct access, it would create bounce buffers instead
>      of returning the actual hva, which is not desirable here.
>      And, since VFIO device regions are not considered directly accessible
>      (because they are mostly MMIO based), virtio-gpu cannot invoke
>      dma_memory_map() to obtain the hva in this case."

That looks good to me. Thanks you for improving this.

Regards,
Akihiko Odaki

