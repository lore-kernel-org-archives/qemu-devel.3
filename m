Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB97CEBF97
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 06:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLEnU-0002iW-V1; Tue, 18 Nov 2025 01:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLEnS-0002iM-27
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:02:34 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLEnO-000243-3d
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:02:33 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AI62OFn066626
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Nov 2025 15:02:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zsJu1UMzg+/CjOAizhlOCV+U72/Xaayq34U7zvmZQBc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763445744; v=1;
 b=M0D0d79diTz8j8Ilq1FWBbhQpOxQnKMHfyU61ww9WECDiZ4Z5oVBTDaJ2ePKiAni
 I0tw0oeW0gK31VUZgVYOfIFzqV9iJc4Z7TQRvC0h0/OGfRI+sipqnsAGIioJOm5c
 7wjJ4JtBomWpL9ZrUL7ROnRxva0o2rPlvT/JmkZ3H5D6CfhSc0q4A17OYavSOwSI
 GbvkyswMEuDbQdK5fH3m0PSea+aMl5ulasqgAoKeEsNTEfiND/RMozixFyyxZStc
 xBudTky+14L0/DOOqEwTedB1PxFRFCIx+72URr/31qx4AUUz5KQIB7RuXpXFbyMT
 fh2gdfpeLK88/kNpPOzKHg==
Message-ID: <04410e24-43e9-4302-8a88-8de870cd53e0@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 18 Nov 2025 15:02:23 +0900
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
 <8451c0ee-6c9d-4fbf-b1c2-05fd5fd8e4c3@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185D06DA886C3758E9B0FB5F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8dcffe42-da84-44cf-a240-90680cdb0953@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71850777A66759ADCAFEB53EF8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB71850777A66759ADCAFEB53EF8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2025/11/18 14:22, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
>> associated with VFIO devices
>>
>> On 2025/11/17 13:19, Kasireddy, Vivek wrote:
>>> Hi Akihiko,
>>>
>>>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
>>>> associated with VFIO devices
>>>>
>>>> On 2025/11/13 12:17, Kasireddy, Vivek wrote:
>>>>> Hi Akihiko,
>>>>>
>>>>>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
>>>> blobs
>>>>>> associated with VFIO devices
>>>>>>
>>>>>> On 2025/11/12 13:26, Kasireddy, Vivek wrote:
>>>>>>> Hi Akihiko,
>>>>>>>
>>>>>>>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
>>>>>> blobs
>>>>>>>> associated with VFIO devices
>>>>>>>>
>>>>>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
>>>>>>>>> In addition to memfd, a blob resource can also have its backing
>>>>>>>>> storage in a VFIO device region. Therefore, we first need to figure
>>>>>>>>> out if the blob is backed by a VFIO device region or a memfd before
>>>>>>>>> we can call the right API to get a dmabuf fd created.
>>>>>>>>>
>>>>>>>>> So, once we have the ramblock and the associated mr, we rely on
>>>>>>>>> memory_region_is_ram_device() to tell us where the backing storage
>>>>>>>>> is located. If the blob resource is VFIO backed, we try to find the
>>>>>>>>> right VFIO device that contains the blob and then invoke the API
>>>>>>>>> vfio_device_create_dmabuf().
>>>>>>>>>
>>>>>>>>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
>>>>>>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
>>>>>>>>> use the VFIO device fd directly to create the CPU mapping.
>>>>>>>>
>>>>>>>> I have just remembered that mremap() will work for either of udmabuf
>>>>>> and
>>>>>>>> VFIO. That will avoid having two different methods and make
>>>>>>>> vfio_get_region_index_from_mr() and vfio_device_get_region_info()
>>>>>>>> unnecessary.
>>>>>>> IIUC, the name virtio_gpu_remap_dmabuf() is misleading because we
>>>> are
>>>>>> not
>>>>>>> actually doing remap but are simply calling mmap(). In other words, we
>>>>>> are not
>>>>>>> expanding or shrinking existing mapping but are creating a new
>>>> mapping.
>>>>>>> And, for dmabufs associated with VFIO devices, without having to call
>>>>>>> vfio_get_region_index_from_mr() and vfio_device_get_region_info(), I
>>>>>> don't see
>>>>>>> any other way to determine the region offset.
>>>>>>>
>>>>>>> So, I guess I'll create a new patch to do s/remapped/map.
>>>>>>
>>>>>> I mean calling mremap() with 0 as the old_size parameter. The man page
>>>>>> says:
>>>>>>     > If the value of old_size is zero, and old_address refers to a
>>>>>>     > shareable mapping (see the description of MAP_SHARED in
>> mmap(2)),
>>>>>> then
>>>>>>     > mremap() will create a new mapping of the same pages.
>>>>> It might be possible to use mremap() here but using mmap() seems very
>>>>> straightforward given that we are actually not shrinking or expanding
>>>>> an existing mapping but are instead creating a new mapping. Also, I am
>>>>> wondering what benefit would mremap() bring as opposed to just using
>>>>> mmap()?
>>>>
>>>> As I noted earlier, mremap() removes the need of having two different
>>>> paths for udmabuf and VFIO, and make vfio_get_region_index_from_mr()
>>>> and
>>>> vfio_device_get_region_info() unnecessary, reducing code complexity.
>>> Sorry, I should have researched thoroughly before but after looking at the
>> code
>>> again, I don't see how mremap() removes the need for having two different
>>> paths for udmabuf and VFIO and make vfio_get_region_index_from_mr()
>>> and vfio_device_get_region_info() unnecessary. Could you please elaborate
>>> how it can be done?
>>
>> Not tested, but something like the following:
>>
>> head = qemu_ram_mmap(-1, res->blob_size, qemu_real_host_page_size(),
>>                        QEMU_MAP_READONLY | QEMU_MAP_SHARED, 0);
>> if (head == MAP_FAILED) {
>>       return NULL;
>> }
>>
>> cursor = head;
>>
>> for (i = 0; i < res->iov_cnt; i++) {
>>       if (mremap(res->iov[i].iov_base, 0, res->iov[i].iov_len,
>>                  MREMAP_FIXED, cursor) == MAP_FAILED) {
> This is very elegant and I can now see how it is expected to work. However,
> I went ahead and tested it and it does not seem to work for VFIO backed
> buffers. It works for buffers based out of System RAM though. Here is the
> actual code I tested with that I am unconditionally calling for both VFIO
> and udmabuf cases:
> static void *vfio_dmabuf_mmap2(struct virtio_gpu_simple_resource *res,
>                                 VFIODevice *vdev)
> {
>      void *head, *cursor;
>      int i;
> 
>      head = qemu_ram_mmap(-1, res->blob_size, qemu_real_host_page_size(),
>                           			QEMU_MAP_READONLY | QEMU_MAP_SHARED, 0);

By the way, please do:
head = mmap(NULL, res->blob_size, PROT_NONE, MAP_SHARED, -1, 0);

I forgot that we don't need to map a RAM but mmap() with PROT_NONE is 
sufficient. It will catch a bug that fails to mmap() a real resource on 
top of it.

>      if (head == MAP_FAILED) {
>          return head;
>      }
> 
>      cursor = head;
>      for (i = 0; i < res->iov_cnt; i++) {
>           if (mremap(res->iov[i].iov_base, 0, res->iov[i].iov_len,
>               MREMAP_FIXED | MREMAP_MAYMOVE, cursor) == MAP_FAILED) {
>               goto err;
>           }
>           cursor += res->iov[i].iov_len;
>      }
>      return head;
> err:
>      qemu_ram_munmap(-1, head, res->blob_size);
>      return MAP_FAILED;
> }
> 
> It (mremap) initially errored with -EINVAL in all cases but adding MREMAP_MAYMOVE
> fixed it for buffers based out of RAM but for VFIO backed buffers, it seems to be
> throwing -EFAULT/Bad Address error. I did not yet check why or where the kernel
> driver is returning this error from.

The man page says that EFAULT means:
 > Some address in the range old_address to old_address+old_size is an
 > invalid virtual memory address for this process. You can also get
 > EFAULT even if there exist mappings that cover the whole address space
 > requested, but those mappings are of different types.

None of this should be true so it should be a bug, though I'm not sure 
if it is a bug of QEMU, Linux, or the man page (i.e., the man page 
failed to mention another failure scenario). In any case it needs to be 
debugged.

Regards,
Akihiko Odaki

