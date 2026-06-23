Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF99CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbtuF-00056A-5f; Tue, 23 Jun 2026 01:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wbtuD-00055n-Br
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 01:42:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wbtuA-0005GO-2c
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 01:42:41 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65N5fsKd048698
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 23 Jun 2026 14:41:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=R+rHLQfiqWYzylrjcX68OKQR52BzwBNkz/sM18NBbmo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782193314; v=1;
 b=SN43tZP2ZtHkJNyrA2M+YOtYZNTJGNZ8ha1mOpVoZxiy7CtiUFD+6rHUkXKQh5ge
 xAcFhVltF6VCaUnSzFOIUXWR/DVSj47xlDjk8+qqIyDOgPTHDfOqmsUBb4AogHIi
 kRQrYW5SMZ2skn9UHQKkWj38HHt8geaMODQgrn6jfMzU69Js9IuXZDY+H+U3uxvf
 hPffZolEnP0qYnBdok/4azw3mAVxT6ZCohUp20C4Z3j6adN7HtEGpNmtUcw5nGmi
 oJfGZt3VhKxj2Psi0XeIM98KCilawCsRldY9DofFokhAx0W9rO47P7SmBU9vjHwW
 IIqIbCf11fbWxZkr0MaawA==
Message-ID: <20d873d8-035b-4661-b8af-76e0d7bc8ed5@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 23 Jun 2026 14:41:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
To: Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
 <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
 <2660c118-474e-4160-9b26-25694d02d676@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR02MB94625343624EEBC89B3AE86F8BEF2@IA0PR02MB9462.namprd02.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR02MB94625343624EEBC89B3AE86F8BEF2@IA0PR02MB9462.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/23 6:24, Thanos Makatos wrote:
>> -----Original Message-----
>> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Sent: 22 June 2026 15:37
>> To: Paolo Bonzini <pbonzini@redhat.com>; BALATON Zoltan
>> <balaton@eik.bme.hu>
>> Cc: Daniel P. Berrangé <berrange@redhat.com>; qemu-devel@nongnu.org;
>> Philippe Mathieu-Daudé <philmd@mailo.com>; Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com>; Peter Xu <peterx@redhat.com>;
>> Hervé Poussineau <hpoussin@reactos.org>; Alex Bennée
>> <alex.bennee@linaro.org>; Michael S. Tsirkin <mst@redhat.com>; Aurelien
>> Jarno <aurelien@aurel32.net>; Fabiano Rosas <farosas@suse.de>; Mark Cave-
>> Ayland <mark.cave-ayland@ilande.co.uk>; Marc-André Lureau
>> <marcandre.lureau@redhat.com>; John Levon <john.levon@nutanix.com>;
>> Thanos Makatos <thanos.makatos@nutanix.com>; Cédric Le Goater
>> <clg@redhat.com>
>> Subject: Re: [RFC 4/7] system: add memory_region_new /
>> memory_region_new_io
>>
>> !-------------------------------------------------------------------|
>>    CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> On 2026/06/20 1:32, Paolo Bonzini wrote:
>>> On 6/18/26 00:44, BALATON Zoltan wrote:
>>>> On Wed, 17 Jun 2026, Paolo Bonzini wrote:
>>>>> On 6/16/26 17:55, Daniel P. Berrangé wrote:
>>>>>> Prepare for the move to dynamically allocated memory regions by
>>>>>> introducing memory_region_new and memory_region_new_io functions
>>>>>> which call through to object_new instead of object_initialize.
>>>>>
>>>>> MemoryRegionOps callback will certainly access fields in the parent.
>>>>> Having a separate object gives you no benefit because you still have
>>>>> the same use-after-free if the MemoryRegion outlives the device.
>>>>> Likewise for buses.
>>>>>
>>>>> If the device itself is embedded, then all the invariants must hold
>>>>> recursively:
>>>>>
>>>>> - the device must be kept alive by mutual references between the
>>>>> device itself and its parent;
>>>>>
>>>>> - unparent for the device should wait for all guest memory accesses
>>>>> to be either completed or cancelled.
>>>>>
>>>>> So, the problem is that "QEMU automatically references the owning
>>>>> Device to keep the MemoryRegion alive" is a hack that should die.
>>>>> [...] I disagree that removing embedding will fix any bugs
>>>>
>>>> I'm trying to understand this better. The way it originally meant to
>>>> work according to the memory region docs and implementation is that
>>>> memory region is added to an owner as a child which takes a reference
>>>> and when the owner is freed it will unparent its children which will
>>>> then get unrefed and freed as well if nothing else increased their ref
>>>> count.
>>>
>>> Yes, and that's broken.
>>>
>>>> The problem is that when something accesses the memory region it has
>>>> to keep the owner alive as well so instead of referencing the memory
>>>> region it references the owner (not directly but using
>>>> memory_region_ref which does this).
>>>
>>> A mechanism to keep the owner alive exists, and it is mutual references
>>> (so that neither owner nor MR die) + unparent of owner (which should
>>> wait for pending users to complete before returning).
>>>
>>> The fact that this mechanism is not used, i.e. unparent of a PCIDevice
>>> does not wait for pending BAR accesses to complete, is a bug.
>>>
>>>> So embedding seems unrelated to this passing refs on
>>>> memory regions to owner and could be fixed separately that my patches
>>>> attempted.
>>>
>>> Your patches add the possibility of not embedding; I don't like having
>>> two separate API, but I think we only have a disagreement on aesthetics.
>>>
>>> This is different for Daniel's patches, which try to fix something by
>>> not embedding, and I don't think they do.  Currently, if the owner dies,
>>> the MemoryRegion dies with it while it shouldn't (which is a problem,
>>> absolutely).  But these patches, while preventing the MR from dying,
>>> still leave around a dangling pointer to the owner from the MR, so
>>> there's not much gained if anything.
>>
>> I think we can stack follow-up patches that reject accesses to
>> MemoryRegions owned by unrealized devices. That would make this a more
>> complete solution. Accessing an unrealized device is an unsafe corner
>> case anyway, so it is better to close it explicitly.
>>
>> memory_region_init_ram_ptr() and memory_region_init_ram_device_ptr()
>> are
>> a little more complicated, because direct accesses to those regions can
>> happen outside the BQL. Still, we can unmap the memory when the
>> MemoryRegion is finalized, as memory_region_init_ram() already does.
>>
>> However, after looking into this further, I found one complication:
>> x-vfio-user-server. In that case, the unmap timing is controlled by
>> libvfio-user, so QEMU cannot keep the memory mapped until the
>> MemoryRegion reference is dropped. This is not a new issue; it is a
>> pre-existing use-after-free hazard. I think a practical fix would be to
>> extend the libvfio-user API to support asynchronous unmapping.
>>
>> Cc'ing the vfio-user maintainers.
> 
> VFIO_USER_DMA_UNMAP is already asynchronous, it sends the response only after it's done unmapping. What would that asynchronous unmapping API look like? VFIO_USER_DMA_UNMAP would send a respond that it received the operation and started unmapping, and then another one to say it's done unmapping?

The problem is of libvfio-user's API, not the vfio-user protocol. 
vfu_setup_device_dma() takes a DMA region unregistration callback, which 
is expected to synchronously unmap the region from the guest, and 
x-vfio-user-server attempts to do so by calling object_unparent().

However, object_unparent() does not actually synchronously unmap the 
region from the guest so it results in a use-after-free hazard. A 
possible solution is to have the following three changes in combination:
- This series, ensuring the MemoryRegion stays alive
- A change of memory_region_init_ram_ptr() to add a callback for
   asynchronous unmapping
- A libvfio-user API change to asynchronously complete unmapping

> Also, since (AFAIK) x-vfio-user-server is orphaned is it worth putting the effort in this?

I rechecked MAINTAINERS and found its status is Odd Fixes, not Orphan. 
That said, it is possible to leave a FIXME comment instead of fixing it 
right now, as it's already done by virtio-gpu-rutabaga:

 > There is small risk of the MemoryRegion dereferencing the pointer
 > after rutabaga unmaps it. Please see discussion here:
 >
 > https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg05141.html
 >
 > It is highly unlikely to happen in practice and doesn't affect known
 > use cases. However, it should be fixed and is noted here for
 > posterity.

A difference from virtio-gpu-rutabaga is that the Rutabaga library API 
does not interfere with asynchronous unmapping so it can be fixed 
entirely on the QEMU side. On contrary, anyone who would want to fix 
x-vfio-user-server would need to change the libvfio-user API because its 
current form is too restrictive.

Regards,
Akihiko Odaki

