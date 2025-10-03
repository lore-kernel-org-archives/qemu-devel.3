Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E903CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gNa-0000MS-3i; Fri, 03 Oct 2025 10:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v4gNQ-0000JY-88; Fri, 03 Oct 2025 10:03:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v4gNB-0004i6-QM; Fri, 03 Oct 2025 10:03:15 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 593E1cHl069581
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Oct 2025 23:01:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=HsR8eRSyzOQpT5X+eU0HvZgxEV7ohpeIT9WpErfuK1s=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1759500099; v=1;
 b=vemkqf5QiOAoLUpwyQpRLzqAgdZvf9GM9yP+cOOzKAjqPrVePzXxvOWsig2q9j/2
 ogJpWHUPqXiiv41ftRAYbA4Lo3jvz7TqZaNj5J9KWzbUJmJJ/YFS+m3Y4qwEc+08
 vd1i8BiCUmr3cKrsmHfPAk6D4GuyKOJ6/lEaYxa60xua0SAjzFbocuD5ZN62C2Hk
 qwObaYN3bHopZNqejycSYoGoAgS9j6QsuAAtHzJlQ4dxUzPVZ6q2pLp3TBSpcpi3
 rjTyEoPSwim9wDkHSN4Ex8tWDWXM8Hf56lkpaoWlItWqtsv1CZQrT9/k8Np99svU
 3PXfyB5d1wWUXJLqjBLlMQ==
Message-ID: <32e36e0c-c947-4fa4-bdbf-5ef3ce6ea0a3@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 3 Oct 2025 23:01:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] qdev: Automatically delete memory subregions
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-subregion-v1-2-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <aN7RHvjeQNtrXDcQ@x1.local> <aN7VH0j8HfaeRV1V@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aN7VH0j8HfaeRV1V@x1.local>
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

On 2025/10/03 4:40, Peter Xu wrote:
> On Thu, Oct 02, 2025 at 03:23:10PM -0400, Peter Xu wrote:
>> On Wed, Sep 17, 2025 at 07:32:48PM +0900, Akihiko Odaki wrote:
>>> +static int del_memory_region(Object *child, void *opaque)
>>> +{
>>> +    MemoryRegion *mr = (MemoryRegion *)object_dynamic_cast(child, TYPE_MEMORY_REGION);
>>> +
>>> +    if (mr && mr->container) {
>>> +        memory_region_del_subregion(mr->container, mr);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static void device_set_realized(Object *obj, bool value, Error **errp)
>>>   {
>>>       DeviceState *dev = DEVICE(obj);
>>> @@ -582,6 +593,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>>>           if (dc->unrealize) {
>>>               dc->unrealize(dev);
>>>           }
>>> +        object_child_foreach(OBJECT(dev), del_memory_region, NULL);
>>
>> PS: I'll keep throwing some pure questions here, again, Paolo - it doesn't
>> need to block merging if you're confident with the general approach.
>>
>> Said that, a few things I still want to mention after I read this series..
>>
>> One thing I really feel hard to review such work is, you hardly describe
>> the problems the series is resolving.
>>
>> For example, this patch proposed auto-detach MRs in unrealize() for qdev,
>> however there's nowhere describing "what will start to work, while it
>> doesn't", "how bad is the problem", etc..  All the rest patches are about
>> "what we can avoid do" after this patch.
> 
> For this part, I should be more clear on what I'm requesting on the
> answers.
> 
> I think I get the whole point that MRs (while still with MR refcount
> piggypacked, as of current QEMU master does) can circular reference itself
> if not always detached properly, so explicitly my question is about:
> 
> - What devices / use case you encountered, that QEMU has such issue?
>    Especially, this is about after we have merged commit ac7a892fd3 "memory:
>    Fix leaks due to owner-shared MRs circular references".  Asking because I
>    believe most of them should already auto-detach when owner is shared.
> 
> - From above list of broken devices, are there any devices that are
>    hot-unpluggable (aka, high priority)?  Is it a problem if we do not
>    finalize a MR if it is never removable anyway?
> 
>>
>> Meanwhile, the cover letter is misleading. It is:
>>
>> [PATCH 00/14] Fix memory region use-after-finalization
>>
>> I believe it's simply wrong, because the whole series is not about
>> finalize() but unrealize().  For Device class, it also includes the exit()
>> which will be invoked in pci_qdev_unrealize(), but that is also part of the
>> unrealize() routine, not finalize().

The subject of the cover letter "fix memory region 
use-after-finalization" is confusing. While this series has such fixes, 
it also contain refactoring patches. The cover letter says:

 > Patch "qdev: Automatically delete memory subregions" and the
 > succeeding patches are for refactoring, but patch "vfio-user: Do not
 > delete the subregion" does fix use-after-finalization.

More concretely, patch "qdev: Automatically delete memory subregions" 
implements a common pattern of device unrealization, and the suceeding 
patches remove ad-hoc implementations of it.

And since patch "hw/pci-bridge: Do not assume immediate MemoryRegion 
finalization" fixes nothing as you pointed out, only patch "vfio-user: 
Do not delete the subregion" fixes something.

Without patch "vfio-user: Do not delete the subregion", 
vfio_user_msix_teardown() calls memory_region_del_subregion(). However, 
this function is called from instance_finalize, so the subregion is 
already finalized and results in a use-after-finalization scenario.

Anything else is for refactoring and it's quite unlike patch "memory: 
Fix leaks due to owner-shared MRs circular references", which is a bug fix.

I think I'll drop patch "hw/pci-bridge: Do not assume immediate 
MemoryRegion finalization" and rename this series simply to "qdev: 
Automatically delete memory subregions" to avoid confusion.

>>
>> The other question is, what if a MR has a owner that is not the device
>> itself?  There's no place enforcing this, hence a qdev can logically have
>> some sub-objects (which may not really be qdev) that can be the owner of
>> the memory regions.  Then the device emulation will found that some MRs are
>> auto-detached and some are not.
>>
>> One example that I'm aware of is this:
>>
>> https://lore.kernel.org/all/20250910115420.1012191-2-aesteve@redhat.com/#t
>>
>> TYPE_VIRTIO_SHARED_MEMORY_MAPPING is an object, not qdev here, which can be
>> the owner of the MR.

Patch "qdev: Automatically delete memory subregions" and the succeeding 
patches are for refactoring of qdev. MRs not directly owned by qdev are 
out of scope of the change.

Regards,
Akihiko Odaki

