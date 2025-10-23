Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55D0CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 05:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBnnO-0004Nb-6E; Thu, 23 Oct 2025 01:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBnnK-0004NE-Ci
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:23:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBnnG-0007RX-N8
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:23:26 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59N5MsQE026236
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Oct 2025 14:22:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=gnati6YP6mPiXyAp+KO8yHdcLlM/qwFU7K+Yju1IIz8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1761196974; v=1;
 b=qaVRCohEZKRikvZ8WkzLBJDqXYrDJ3UuGs+cBPLEFhuSBrsjD94Nh1X+eswOw5hl
 9LvwCfqwbcIqbmBgE1m7985B9vmkTHE4OtCYCpOSBevNEM3elPNhFUOAYH0q06YH
 t2Hz1L5jG9aIEd8FvvV0YyPWNHJMwz3KzqUMnMCyjyn6EiD+ww3daOKCdnqAkIcg
 1solIcHrRyi27SqVUhqbYafjUjsxI2i81kNKlOsmZRJX9f9ntxa1WMYSOr/kuerN
 ETdXJcuoHAUdE8rrX/GPyW8G9acgchHmmH3T71ns4EhOOxeW8ZA6Mb0RL2aYv/+L
 QsecvQJQ5tu9tsyph68BBQ==
Message-ID: <d60ee137-736c-47e4-826b-800885085891@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Oct 2025 14:22:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177C4541131508F53BD27F3F8E8A@CH3PR11MB7177.namprd11.prod.outlook.com>
 <955ea687-ed25-47bd-9ba9-73c6b98c8e29@rsg.ci.i.u-tokyo.ac.jp>
 <1f127ac5-10dd-435e-9ff5-f70596d7aac4@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853F97E13556E781AAE104F8E9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a0bcfbed-b6a1-42e5-b482-eb056fc2cd25@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185A158F3DC20170E673E7BF8F6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <096c74d3-ffb7-4555-b8cd-caf88eb4de74@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71856839617B01F9CB852880F8F5A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d5d9d06c-368f-4098-bc04-41f08945778a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718515058F01C0E9F89AAC53F8F3A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB718515058F01C0E9F89AAC53F8F3A@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2025/10/22 14:10, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>>>>>
>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to
>> identify
>>>>>> blob resources
>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to
>>>>>>>>>>> identify blob
>>>>>>>>>>> resources
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob
>> to
>>>>>>>>>>>>> identify
>>>>>>>>>>> blob
>>>>>>>>>>>>> resources
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
>>>>>>>>>>>>>> The res->blob pointer may not be valid (non-NULL) for some
>>>> blobs
>>>>>>>>>>>>>> where the backing storage is not memfd based. Therefore,
>> we
>>>>>> cannot
>>>>>>>>>>>>>> use it to determine if a resource is a blob or not. Instead, we
>>>>>>>>>>>>>> could use res->blob_size to make this determination as it is
>>>>>>>>>>>>>> non-zero for blob resources regardless of where their backing
>>>>>>>>>>>>>> storage is located.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I think this patch is no longer necessary since now you add
>> code to
>>>>>>>>>>>>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-
>> udmabuf:
>>>>>> Create
>>>>>>>>>>>>> dmabuf for blobs associated with VFIO devices".
>>>>>>>>>>>> Right, but given that mmap() can still fail for various reasons
>> and
>>>>>>>>>>>> this
>>>>>>>>>>>> use-case can work as long as dmabuf creation succeeds, I think
>> it
>>>>>> makes
>>>>>>>>>>>> sense to not rely on res->blob to determine if a resource is blob
>> or
>>>>>>>>>>>> not.
>>>>>>>>>>>
>>>>>>>>>>> I think the code will be simpler by making resource creation fail
>> when
>>>>>>>>>>> mmap() fails, and I am concerned that the guest may
>> mulfunction
>>>>>> with
>>>>>>>>>>> such an incomplete resource.
>>>>>>>>>> AFAICT, mmap() is a slow, optional path except for the cursor
>> (which
>>>>>>>>>> needs
>>>>>>>>>> further improvement). So, failing resource creation when mmap()
>> fails
>>>>>>>>>> does not seem like a good idea to me given the fact that
>> supporting
>>>>>>>>>> mmap()
>>>>>>>>>> is considered optional for dmabuf providers. And, even with vfio,
>>>>>> mmap()
>>>>>>>>>> can be blocked for various reasons by the kernel driver IIUC.
>>>>>>>>
>>>>>>>> Reviewing the code again, I don't think mmap() can fail with the
>> current
>>>>>>>> version of this series.
>>>>>>>>
>>>>>>>> udmabuf obviously always supports mmap().
>>>>>>>>
>>>>>>>> For VFIO, checking memory_region_is_ram_device() ensures that
>> VFIO
>>>>>>>> supports mmap(); memory_region_init_ram_device_ptr() is called
>> from
>>>>>>>> vfio_region_mmap(), which is only called when VFIO supports
>> mmap().
>>>>>>> My point is not whether a dmabuf provider provides support for
>> mmap()
>>>>>>> or not but about the fact that mmap() can fail (for various reasons
>>>>>> because
>>>>>>> it is not a guarantee) making res->blob NULL. But we are incorrectly
>> using
>>>>>>> res->blob pointer to determine whether a resource is a blob (and
>> usable)
>>>>>>> or not which doesn't make sense because even if res->blob is NULL,
>> the
>>>>>>> resource is still valid and usable via the dmabuf fd, which is the
>> preferred,
>>>>>>> accelerated path.
>>>>>>
>>>>>> Failing to mmap something that is already mmap-ed to another
>> address is
>>>>>> very unrealistic and I can't really think of a possibility of such a
>>>>>> failure aside bugs.
>>>>> The fact that it is already mmap'd to another address would only be
>> true for
>>>>> VFIO devices but as I mentioned previously, we cannot make such
>>>> assumptions
>>>>> with other (future) dmabuf providers.
>>>>
>>>> It is true for udmabuf, though the memfds that back udmabuf are
>> directly
>>>> mapped instead; I don't think the indirection of udmabuf makes any
>>>> difference.
>>>>
>>>> If it's only for future DMA-BUF exporter, it is better to make the
>>>> change when the exporter is actually added, or we are adding code that
>>>> cannot be tested right now and may or may not work when such an
>> exporter
>>>> is added.
>>>>
>>>>>
>>>>>>
>>>>>> If this condition (a valid resource with a NULL res->blob) could only
>>>>>> happen due to a bug, then, in my opinion, marking such a resource as
>>>>>> invalid is actually a more defensive and desirable approach. If a core
>>>>>> operation like mmap fails unexpectedly on a resource that should
>> support
>>>>> But mmap is not considered as a core operation for dmabuf. It is
>> considered
>>>>> optional by dmabuf providers. For example, although very unlikely, it
>> might
>>>>> be possible that support for mmap() can be removed from udmabuf
>> driver
>>>>> driver for some reason. And, when this happens, the only adverse effect
>>>> would
>>>>> be that gl=off would not work, which is not great but definitely not
>>>> catastrophic.
>>>>
>>>> We should be able to safely assume it never happens due to the "no
>>>> regressions" rule of Linux. If a userspace program breaks due to a UAPI
>>> I help maintain the udmabuf driver in the kernel and AFAICT, that rule
>> does
>>> not apply here because udmabuf driver providing support for mmap()
>> cannot
>>> be considered UAPI because it is not providing any direct (user visible)
>> interface
>>> to invoke mmap() as described here:
>>> https://docs.kernel.org/admin-guide/reporting-regressions.html#what-is-
>> a-regression-and-what-is-the-no-regressions-rule
>>
>> I suppose that the result of open("/dev/udmabuf", O_RDWR) and the
>> UDMABUF_CREATE_LIST ioctl is always compatible with mmap(). Not sure
>> what you mean by "direct" interface, but they are all plain userspace
>> interfaces.
>>
>> I suggest asking people maintaining the udmabuf and the DMA-BUF
>> infrastructure if you know them.
> I am one of the two maintainers of udmabuf driver and I am also involved
> in the discussions with dmabuf maintainers regarding upstreaming of
> vfio-pci dmabuf feature in the kernel. And, based on these interactions,
> it is clear that mmap() is completely optional for dmabuf providers and
> userspace should never make any assumptions about whether mmap()
> (for dmabuf) works or not. Here is one reference:
> https://lore.kernel.org/dri-devel/Zjs2bVVxBHEGUhF_@phenom.ffwll.local/

That adds nothing more than you have already told in the past discussion 
in this thread.

I started this thread because I found that the current implementation 
only exercises udmabuf and VFIO devices that is known to implement 
mmap(). On the other hand, the cited email discusses VFIO devices that 
are not known to implement mmap() or future DMA-BUF exporters in 
general. It says:
 > Just wanted to confirm that it's entirely legit to not implement
 > dma-buf mmap. Same for the in-kernel vmap functions. Especially for
 > really funny buffers like these it's just not a good idea, and the
 > dma-buf interfaces are intentionally "everything is optional".

This doesn't apply to udmabuf and VFIO devices we are concerned with. 
udmabuf is obviously not "funny buffers", and can be vmapped. Besides, 
the udmabuf already implements mmap() and *removing* it can break 
userspace unlike a DMA-BUF exporter that never implemented mmap(), which 
was discussed in the cited email.

Speaking of VFIO devices, the code already checks it's mmapped by 
calling memory_region_is_ram_device() and yet this patch tries to allow 
blobs that cannot be mmapped, which is inconsistent.

So, the discussion should be summarized as the following two questions:
1. Can the kernel remove an existing mmap() implementation that is known 
to be depended by the userspace (udmabuf)?
2. Can the kernel let an mmap() implementation fail though it once 
worked (VFIO)?

The cited email doesn't answer either of them.

Regards,
Akihiko Odaki

