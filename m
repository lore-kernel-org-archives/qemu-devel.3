Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45F3CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 03:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJO3t-0005IS-Ce; Wed, 12 Nov 2025 22:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJO3d-0005Gk-Qw
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:31:39 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJO3Z-00009o-GL
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:31:36 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AD3VD72074127
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Nov 2025 12:31:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+xQ8A3ryBnNgadKDaVjJEvQAjbhgsh7M6ZksYAw6JxI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763004673; v=1;
 b=HNg2ksW2IXRkRaaHkLBiZD/Znm6BqlwXe8Sm+kUfMw9prSjoDjIR4U1CASckf60M
 aQfUybfwl0t5CUQIzpd3mXQWRH27FrXI9OK8K7UO5GVaKkm/vT+flC55MDtMZinl
 9U2Llb69ZaG0nN++zimxtwrkep6kecyLc+5Edan+mqP3sHExtiEpzwjTg10yScLd
 m4LUrN/ztyJsjFc6g7O7PKF+NqYlFHIa8HtZly1aavWGjpzdUFFuT7laTKZxU/VC
 gUG0M105ZupOaxQygkO0zH0C9xolXdJC3iBRYK9dboFBatkfpIo5RYjeoOCLgilM
 LYY9IyFnI88CgVNukOxyUg==
Message-ID: <8451c0ee-6c9d-4fbf-b1c2-05fd5fd8e4c3@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 13 Nov 2025 12:31:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
 <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3c0fe9e8-7efa-4936-b5ef-5cabc4239cdd@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71855ADFEEC4E3267B464768F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB71855ADFEEC4E3267B464768F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/11/13 12:17, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
>> associated with VFIO devices
>>
>> On 2025/11/12 13:26, Kasireddy, Vivek wrote:
>>> Hi Akihiko,
>>>
>>>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
>> blobs
>>>> associated with VFIO devices
>>>>
>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
>>>>> In addition to memfd, a blob resource can also have its backing
>>>>> storage in a VFIO device region. Therefore, we first need to figure
>>>>> out if the blob is backed by a VFIO device region or a memfd before
>>>>> we can call the right API to get a dmabuf fd created.
>>>>>
>>>>> So, once we have the ramblock and the associated mr, we rely on
>>>>> memory_region_is_ram_device() to tell us where the backing storage
>>>>> is located. If the blob resource is VFIO backed, we try to find the
>>>>> right VFIO device that contains the blob and then invoke the API
>>>>> vfio_device_create_dmabuf().
>>>>>
>>>>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
>>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
>>>>> use the VFIO device fd directly to create the CPU mapping.
>>>>
>>>> I have just remembered that mremap() will work for either of udmabuf
>> and
>>>> VFIO. That will avoid having two different methods and make
>>>> vfio_get_region_index_from_mr() and vfio_device_get_region_info()
>>>> unnecessary.
>>> IIUC, the name virtio_gpu_remap_dmabuf() is misleading because we are
>> not
>>> actually doing remap but are simply calling mmap(). In other words, we
>> are not
>>> expanding or shrinking existing mapping but are creating a new mapping.
>>> And, for dmabufs associated with VFIO devices, without having to call
>>> vfio_get_region_index_from_mr() and vfio_device_get_region_info(), I
>> don't see
>>> any other way to determine the region offset.
>>>
>>> So, I guess I'll create a new patch to do s/remapped/map.
>>
>> I mean calling mremap() with 0 as the old_size parameter. The man page
>> says:
>>   > If the value of old_size is zero, and old_address refers to a
>>   > shareable mapping (see the description of MAP_SHARED in mmap(2)),
>> then
>>   > mremap() will create a new mapping of the same pages.
> It might be possible to use mremap() here but using mmap() seems very
> straightforward given that we are actually not shrinking or expanding
> an existing mapping but are instead creating a new mapping. Also, I am
> wondering what benefit would mremap() bring as opposed to just using
> mmap()?

As I noted earlier, mremap() removes the need of having two different 
paths for udmabuf and VFIO, and make vfio_get_region_index_from_mr() and 
vfio_device_get_region_info() unnecessary, reducing code complexity.

mremap() is also sufficiently straightforward. The man page explicitly 
states it is designed to create a new mapping. Using it for the purpose 
(not shrinking or expanding an existing mapping) is not an abuse of the API.

Regards,
Akihiko Odaki

