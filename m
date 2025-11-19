Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA465CF2570
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 05:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLbAO-0003dW-Uh; Wed, 19 Nov 2025 00:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLbAM-0003dK-IZ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:55:43 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLbAJ-0001Cx-JR
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:55:42 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AJ5tTrt075905
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Nov 2025 14:55:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CaM/z6+Y+XgK1pLjHP4DGBGYHailL6QdFeh/ofYMUKM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763531730; v=1;
 b=XQJIs+VGiRkV2/YHply/XY6tUCdMUHLE6RzAL/L1HGvSKHKXkvLK5kd347g86Uf5
 8DqiUTA5i4Pxr691K1sftvS26S7zb1P9mEvoqBp7lsJJGTsp9rcTUJhLQgYfhelM
 2GJ7RpCq9AIYB/4q9KSiG+1eZPOYP1M6UPTKOU/nvkdbhdNw4l5HBohp1QuxpPeG
 FO/cOWLS9uG9H53kK0X7Y05uLsluFrL1LxH2J4PlMhmCM3oAM3q35oIblQxRC7cg
 WQ6fP47wTJtFlYwC1DUNpCCCReA2u8gx75Nj7emoN28HCvSAZWvmvi69ehY76MKZ
 ru7t2uHaRaX5xSDqopix4g==
Message-ID: <3c68353c-f62f-4e37-aa4e-3920e9ef0c5f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 19 Nov 2025 14:55:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-3-vivek.kasireddy@intel.com>
 <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185866AD30B9A73097934CCF8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8b8e3b19-7696-4b7c-8d74-eab2028dcd02@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71857687EC63A9A8D46476C7F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e9424a92-f612-4cce-abc1-5336949ca71b@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71852A2F1894A75CE0B7EB13F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a5b4e817-93b2-45c3-8c59-21a4b65174b4@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71852665F80155422F4714E2F8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <329aaeec-0fb6-467b-922a-a17743a62a05@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185B46F9919473A37BBFC0DF8D7A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185B46F9919473A37BBFC0DF8D7A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/19 14:42, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
>> associated with a ram device
>>>>>>>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
>>>>>>>>>>> If the Guest provides a DMA address that is associated with a
>> ram
>>>>>>>>>>> device (such as a PCI device region and not its system memory),
>> then
>>>>>>>>>>> we can obtain the hva (host virtual address) by invoking
>>>>>>>>>>> address_space_translate() followed by
>>>>>> memory_region_get_ram_ptr().
>>>>>>>>>>>
>>>>>>>>>>> This is because the ram device's address space is not accessible
>> to
>>>>>>>>>>> virtio-gpu directly and hence dma_memory_map() cannot be
>> used.
>>>>>>>>>>> Therefore, we first need to identify the memory region
>> associated
>>>>>> with
>>>>>>>>>>> the DMA address and figure out if it belongs to a ram device or
>> not
>>>>>>>>>>> and decide how to obtain the host address accordingly.
>>>>>>>>>>>
>>>>>>>>>>> Note that we take a reference on the memory region if it belongs
>> to a
>>>>>>>>>>> ram device but we would still call dma_memory_unmap() later
>> (to
>>>>>> unref
>>>>>>>>>>> mr) regardless of how we obtained the hva.
>>>>>>>>>>>
>>>>>>>>>>> Cc: Marc-André Lureau<marcandre.lureau@redhat.com>
>>>>>>>>>>> Cc: Alex Bennée<alex.bennee@linaro.org>
>>>>>>>>>>> Cc: Akihiko Odaki<odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>>>>>> Cc: Dmitry Osipenko<dmitry.osipenko@collabora.com>
>>>>>>>>>>> Cc: Alex Williamson<alex.williamson@redhat.com>
>>>>>>>>>>> Cc: Cédric Le Goater<clg@redhat.com>
>>>>>>>>>>> Signed-off-by: Vivek Kasireddy<vivek.kasireddy@intel.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
>>>>>>>>>>>        1 file changed, 21 insertions(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index
>>>>>>>>>>> 199b18c746..d352b5afd6 100644
>>>>>>>>>>> --- a/hw/display/virtio-gpu.c
>>>>>>>>>>> +++ b/hw/display/virtio-gpu.c
>>>>>>>>>>> @@ -798,6 +798,26 @@ static void
>>>>>>>> virtio_gpu_set_scanout_blob(VirtIOGPU
>>>>>>>>>> *g,
>>>>>>>>>>>                                      &fb, res, &ss.r, &cmd->error);
>>>>>>>>>>>        }
>>>>>>>>>>>
>>>>>>>>>>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
>>>>>>>>>>> +                                       struct virtio_gpu_ctrl_command *cmd,
>>>>>>>>>>> +                                       uint64_t a, hwaddr *len) {
>>>>>>>>>>> +    MemoryRegion *mr = NULL;
>>>>>>>>>>> +    hwaddr xlat;
>>>>>>>>>>> +
>>>>>>>>>>> +    mr = address_space_translate(VIRTIO_DEVICE(g)->dma_as, a,
>>>>>> &xlat,
>>>>>>>> len,
>>>>>>>>>>> +                                 DMA_DIRECTION_TO_DEVICE,
>>>>>>>>>>> +                                 MEMTXATTRS_UNSPECIFIED);
>>>>>>>>>>> +    if (memory_region_is_ram_device(mr)) {
>>>>>>>>>>> +        memory_region_ref(mr);
>>>>>>>>>>> +        return memory_region_get_ram_ptr(mr) + xlat;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
>>>>>>>>>>> +                          DMA_DIRECTION_TO_DEVICE,
>>>>>>>>>>> +                          MEMTXATTRS_UNSPECIFIED);
>>>>>>>>>> This function should:
>>>>>>>>>> - call memory_region_get_ram_ptr(mr)
>>>>>>>>>>         if memory_region_is_ram(mr)
>>>>>>>>>> - return NULL otherwise
>>>>>>>>>>
>>>>>>>>>> There are a few reasons. First, the documentation of
>>>>>>>> dma_memory_map()
>>>>>>>>>> tells to use it "only for reads OR writes - not for read-modify-write
>>>>>>>>>> operations." It can be used for read-modify-write operations so
>>>>>>>>>> dma_memory_map() should be avoided.
>>>>>>>>> This patch series only deals with non-virgl use-cases where AFAICS
>>>>>>>> resources
>>>>>>>>> are not written to on the Host.
>>>>>>>>>
>>>>>>>>>> Second, it ensures that the mapped pointer is writable.
>>>>>>>>>> "[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
>>>>>>>> associated
>>>>>>>>>> with VFIO devices" adds checks for memory_region_is_ram() and
>>>>>>>>>> memory_region_is_ram_device() to virtio_gpu_init_dmabuf(), but
>> the
>>>>>>>> other
>>>>>>>>>> callers also use the function to map writable pointers.
>>>>>>>>> Unless I am missing something, I don't see where writable pointers
>> are
>>>>>>>> used
>>>>>>>>> in non-virgl use-cases?
>>>>>>>> Rutabaga uses too, but you are right about that 2D operations won't
>> use
>>>>>> it.
>>>>>>>>
>>>>>>>> That said, exposing non-writable memory to Virgl and Rutabaga lets
>> the
>>>>>>>> guest corrupt memory so should be avoided. On the other hand, it is
>>>>>>>> unlikely that rejecting non-writable memory will cause any problem.
>> You
>>>>>>>> can also add another code path to use
>>>>>>>> memory_region_supports_direct_access() instead of
>>>>>>>> memory_region_is_ram()
>>>>>>>> for virtio-gpu for 2D and avoid calling memory_region_is_ram() in
>>>>>>>> virtio_gpu_init_dmabuf() if you want to keep non-writable memory
>>>>>> working.
>>>>>>> AFAICS, virtio_gpu_init_dmabuf() is only called in non-virgl/non-
>> rutabaga
>>>>>> code.
>>>>>>> And, this patch series and my use-case (GPU SRIOV) only needs to
>> deal
>>>>>> with
>>>>>>> non-writeable memory because the rendering is already done by the
>>>>>> Guest and
>>>>>>> the Host only needs to display the Guest's FB.
>>>>>>>
>>>>>>> However, I see that virtio_gpu_create_mapping_iov() is used by
>>>>>> virgl/rutabaga
>>>>>>> code as well, so I am wondering how do things work right now given
>> that
>>>>>>> virtio_gpu_create_mapping_iov() always calls dma_memory_map()?
>>>>>>> In other words, is there no problem currently with non-writeable
>> memory
>>>>>>> in virgl/rutabaga use-cases?
>>>>>>
>>>>>> The current code is problematic, and using memory_region_is_ram()
>> will
>>>>>> fix it.
>>>>> Ok, I'll make the change.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>>> It also makes the check of memory_region_is_ram_device() and
>>>>>>>>>> memory_region_is_ram() unnecessary for
>> virtio_gpu_init_dmabuf(),
>>>>>>>> reducing
>>>>>>>>>> the overall complexity.
>>>>>>>>> Since buffers reside completely in either ram or ram_device
>> regions,
>>>>>> using
>>>>>>>> both
>>>>>>>>> memory_region_is_ram_device() and memory_region_is_ram() to
>>>> check
>>>>>>>> where
>>>>>>>>> they are located seems necessary and unavoidable.
>>>>>>>> It can unconditionally call virtio_gpu_create_udmabuf(), and if the
>>>>>>>> function finds the memory is incompatible with udmabuf, it can call
>>>>>>>> vfio_device_lookup() to tell if the memory belongs to VFIO or not.
>>>>>>> Yeah, what you suggest is doable but seems a bit convoluted to have
>> to
>>>>>>> first call virtio_gpu_create_udmabuf() and if it fails then call VFIO
>> related
>>>>>>> functions.
>>>>>>>
>>>>>>> I think using memory_region_is_ram_device() and
>>>>>> memory_region_is_ram()
>>>>>>> to identify the right memory region and calling either
>>>>>> virtio_gpu_create_udmabuf()
>>>>>>> or vfio_create_dmabuf() is much more intuitive and readable.
>>>>>>
>>>>>> memory_region_is_ram_device() and memory_region_is_ram() are not
>>>>>> sufficient to identify the right memory region.
>>>>>> memory_region_is_ram_device() returns true for RAM device created
>> by
>>>>>> non-VFIO devices, and memory_region_is_ram() returns true for
>> memory
>>>>>> regions created with memory_region_init_ram_ptr(), which is not
>> backed
>>>>>> with memfd.
>>>>> Right, but structuring the code in the following way would address your
>>>> concerns
>>>>> and make it more robust:
>>>>>            if (memory_region_is_ram_device(rb->mr) && (vdev =
>>>> vfio_device_lookup(rb->mr))) {
>>>>> 	vfio_create_dmabuf(vdev, res);
>>>>>            } else if (memory_region_is_ram(rb->mr) &&
>>>> virtio_gpu_have_udmabuf()) {
>>>>> 	virtio_gpu_create_udmabuf(res);
>>>>>            } else {
>>>>> 	...
>>>>>            }
>>>>
>>>> One of the concerns I raised is that having such checks has an inherent
>>>> hazard that they can be inconsistent with the actual implementations.
>>>>
>>>> The original checks had such inconsistency, and the updated one still
>>>> have too. memory_region_is_ram(rb->mr) &&
>> virtio_gpu_have_udmabuf()
>>>> can
>>>> be still true even for memory regions that do not have memfd; please
>>>> refer to the example of memory_region_init_ram_ptr() I pointed out in
>>>> the last email.
>>>>
>>>> Even if you somehow managed to write checks that match with the
>>>> implementations, it is still possible that a future change can break it.
>>>> Letting the implementations check their prerequisite conditions
>>>> completely prevents such an error by construction and makes the code
>>>> more robust.
>>> IIUC, your suggestion is to add a check for
>> memory_region_supports_direct_access()
>>> inside virtio_gpu_create_udmabuf() and call it unconditionally right?
>>
>> No, my suggestion is to remove it at all. Creating udmabuf only requires
>> that the memory regions are backed with memfd.
> If we unconditionally call virtio_gpu_create_udmabuf() for VFIO backed buffers,
> I think it makes sense to return early without having to iterate over all the iov
> entries to check their memory regions. So, I am thinking adding a
> memory_region_supports_direct_access() or !memory_region_is_ram_device()
> check would help with this.

They don't make a difference.

If the first memory region is backed by VFIO, the loop ends with the 
first iteration and you do not need to iterate over all the iov entries.

If the first memory region is backed by memfd but a succeeding memory 
regions is backed by VFIO, checking 
memory_region_supports_direct_access() or !memory_region_is_ram_device() 
only for the first memory region is ineffective.

Regards,
Akihiko Odaki

