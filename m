Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960F2CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF6rz-0001VS-NS; Fri, 09 Oct 2026 05:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xF6rs-0001VG-Jb
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:26:21 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xF6rn-0002lI-0G
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:26:19 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6999Q50H020788
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 9 Oct 2026 18:26:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=L8T71NZemyC0NfUGwy3a35O5SY82LrW4JzPbqaL+q7k=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791537965; v=1;
 b=a0FtdM1QAW4d2QSAgNT9xvhsVzNHpMXtPlOW4bv8prpjPh2+/LEOs8LNYl+aVw6J
 HS1Ooe1qtmyVnwCsBuhXqV1s9ClhPzvtrzBx8+h8oyZ6evzZho9tNueQoWd+CQ7l
 DHXZfhv8rVmhti46+nh/QIUtNI7Db7Gi+aN1fLgRDFHrMW6JMj4wXZs8tkjUwy1P
 QMcclzTuLstfOv3eVzMfyr0tz55pQqmFkBEq2R2DsqaXnP8GyIIfyD3OShV9vaG/
 8hspZZsy7MWomQ1CHNz3otw7gVfSXVUyXnXV7qh2UOD1H8e2fZH8jG43leMAysX7
 kGl3iLVviqJc17FXouI2/g==
Message-ID: <8da0d6fa-fe2e-4356-bf30-e17f07243ca6@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 9 Oct 2026 18:26:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-2-vivek.kasireddy@intel.com>
 <7ee490fc-7311-48a5-aa6a-434935ca0a84@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718508A4AD2A92CEB7A56B97F8922@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB718508A4AD2A92CEB7A56B97F8922@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/09 13:32, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
>> associated with a ram device
>>
>> On 2026/10/08 5:09, Vivek Kasireddy wrote:
>>> If the Guest provides a DMA address that is associated with a ram
>>> device (such as a VFIO PCI device region and not its system memory),
>>> then we can obtain the hva (host virtual address) by invoking
>>> address_space_translate() followed by memory_region_get_ram_ptr().
>>>
>>> We cannot use dma_memory_map() because for memory regions that
>> do
>>> not support direct access, it would create bounce buffers instead
>>> of returning the actual hva, which is not desirable here. And, since
>>> VFIO device regions are not considered directly accessible (because
>>> they are mostly MMIO based), virtio-gpu cannot invoke
>> dma_memory_map()
>>> to obtain the hva in this case.
>>>
>>> Therefore, in order to handle addresses associated with VFIO devices,
>>> we need to use the address_space_translate() API to first identify
>>> the right memory region and the appropriate offset within that
>>> region and then use memory_region_get_ram_ptr() to get the hva.
>>> This approach also works for addresses associated with the system
>>> memory region.
>>>
>>> Note that, although we take an explicit reference on the memory
>>> region, we would still rely on dma_memory_unmap() to drop that
>>> reference when the dma mapping is eventually unmapped.
>>>
>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/virtio-gpu.c | 21 ++++++++++++++++++---
>>>    1 file changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index bb0f41bb1e..386db05e5b 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -948,6 +948,23 @@ static void
>> virtio_gpu_set_scanout_blob(VirtIOGPU *g,
>>>                                  &fb, res, &ss.r, &cmd->error);
>>>    }
>>>
>>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
>>> +                                       struct virtio_gpu_ctrl_command *cmd,
>>> +                                       uint64_t a, hwaddr *len)
>>> +{
>>> +    MemoryRegion *mr;
>>> +    hwaddr xlat;
>>> +
>>> +    mr = address_space_translate(VIRTIO_DEVICE(g)->dma_as, a,
>> &xlat, len,
>>> +                                 DMA_DIRECTION_TO_DEVICE,
>>> +                                 MEMTXATTRS_UNSPECIFIED);
>>> +    if (memory_region_is_ram(mr)) {
>>> +        memory_region_ref(mr);
>>> +        return memory_region_get_ram_ptr(mr) + xlat;
>>
>> On rechecking this, I don't think it is safe with Xen.
>>
>> memory_region_get_ram_ptr(mr) + xlat assumes a contiguous host
>> mapping
>> of the entire region. Xen maps guest RAM on demand through its
>> mapcache.
>> Here, memory_region_get_ram_ptr() obtains a mapping at offset zero
>> without pinning the cache entry, and adding xlat afterward does not
>> ensure that the requested range is mapped.
>>
>> The MemoryRegion reference keeps the region alive, but does not
>> prevent
>> the mapcache entry from being reused. Resource backing can therefore
>> receive an invalid or unpinned pointer.
>>
>> I think we need to extend dma_memory_map() for this use case instead
>> of
>> replacing it, preserving its mapping and unmapping semantics.
> I am not sure if extending dma_memory_map() might be a better/cleaner
> solution for this use-case. If obtaining the hva/host ptr via
> memory_region_get_ram_ptr(mr) + xlat for guest RAM is not safe with
> Xen, then would it not make more sense to go back to using dma_memory_map()
> for Guest RAM and memory_region_get_ram_ptr(mr) + xlat for VFIO
> backed regions? That is, doing the following:
> 
> static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
>                                         struct virtio_gpu_ctrl_command *cmd,
>                                         uint64_t a, hwaddr *len)
> {
>      MemoryRegion *mr = NULL;
>      hwaddr xlat;
> 
>      mr = address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat, len,
>                                   DMA_DIRECTION_TO_DEVICE,
>                                   MEMTXATTRS_UNSPECIFIED);
>      if (memory_region_is_ram_device(mr)) {
>          memory_region_ref(mr);
>          return memory_region_get_ram_ptr(mr) + xlat;
>      }
> 
>      return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
>                            DMA_DIRECTION_TO_DEVICE,
>                            MEMTXATTRS_UNSPECIFIED);
> }

Checking this logic again, I found this patch is not necessary since 
commit ff77a515113f ("system/memory: Make ram device region directly 
accessible"). We can just drop it.

Regards,
Akihiko Odaki

> 
> Thanks,
> Vivek
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>> +    }
>>> +    return NULL;
>>> +}
>>> +
>>>    int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>>                                      uint32_t nr_entries, uint32_t offset,
>>>                                      struct virtio_gpu_ctrl_command *cmd,
>>> @@ -993,9 +1010,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU
>> *g,
>>>            /* TODO: a common DMA map SG helper */
>>>            do {
>>>                len = l;
>>> -            map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a,
>> &len,
>>> -                                 DMA_DIRECTION_TO_DEVICE,
>>> -                                 MEMTXATTRS_UNSPECIFIED);
>>> +            map = virtio_gpu_dma_memory_map(g, cmd, a, &len);
>>>                if (!map) {
>>>                    qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map
>> MMIO memory for"
>>>                                  " element %d\n", __func__, e);
> 


