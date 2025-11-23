Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE035CFA46B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 08:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vN5b3-0001S8-EH; Sun, 23 Nov 2025 03:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vN5af-0001EK-ND
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 03:37:01 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vN5aV-00012H-7E
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 03:36:57 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AN8aQkD034452
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 23 Nov 2025 17:36:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nD3YZRD+WQJxE7qrp5qrrSAWt82TbOvALzd1CoAcUUE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763886987; v=1;
 b=rJh1fveBuUkIYG8dbh2eR5Yh4wwMn6jHZnj4lEPCSgGASL6QalzB27UgWOx8VEXI
 osfww2DaEwjxzTtLcqVwWvi7MxgA1fuzfbUU0BiVk2LuJ4V0lsmbumC9fF0Jj6a7
 OMq5eMoz71O8Td/F3oOoRML+4lbXVzMPUupj5K7tQuhHsqIxYXsYFOHOPhgcWt3P
 6TM70g9Kdg6O4hzBwSDFuuJKnUDcBD6xJOuQnpNBdtcnP8qXvS2DsRK+EWGuSziG
 K88Eoc66aBKNxT8LE4DZhRpmKmLmlaidI/ZBUNtlLYp8wfkTNEB6ckhl1cy+geNO
 Gps3ziZrlApe+/BROVDizw==
Message-ID: <a52f86c1-9cd3-4c1e-9b25-880dbd756712@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 23 Nov 2025 17:36:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
 <20251122064936.2948632-10-vivek.kasireddy@intel.com>
 <74f4e219-a094-42b9-a30c-8de597692ab6@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185273C43DA53473EC8B796F8D3A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185273C43DA53473EC8B796F8D3A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/11/23 15:17, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
>> associated with VFIO devices
>>
>> On 2025/11/22 15:46, Vivek Kasireddy wrote:
>>> In addition to memfd, a blob resource can also have its backing
>>> storage in a VFIO device region. Therefore, we first need to figure
>>> out if the blob is backed by a VFIO device region or a memfd before
>>> we can call the right API to get a dmabuf fd created.
>>>
>>> So, we first call virtio_gpu_create_udmabuf() which further calls
>>> ram_block_is_memfd_backed() to check if the blob's backing storage
>>> is located in a memfd or not. If it is not, we call vfio_create_dmabuf()
>>> which identifies the right VFIO device and eventually invokes the
>>> API vfio_device_create_dmabuf_fd() to have a dmabuf fd created.
>>>
>>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
>>> use the VFIO device fd directly to create the CPU mapping.
>>>
>>> While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
>>> from virtio_gpu_create_udmabuf().
>>>
>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/Kconfig             |   5 ++
>>>    hw/display/virtio-gpu-dmabuf.c | 122
>> ++++++++++++++++++++++++++++++---
>>>    2 files changed, 119 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
>>> index 1e95ab28ef..0d090f25f5 100644
>>> --- a/hw/display/Kconfig
>>> +++ b/hw/display/Kconfig
>>> @@ -106,6 +106,11 @@ config VIRTIO_VGA
>>>        depends on VIRTIO_PCI
>>>        select VGA
>>>
>>> +config VIRTIO_GPU_VFIO_BLOB
>>> +    bool
>>> +    default y
>>> +    depends on VFIO
>>> +
>>>    config VHOST_USER_GPU
>>>        bool
>>>        default y
>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>> dmabuf.c
>>> index 258c48d31b..d121a2c9a7 100644
>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>> @@ -18,6 +18,7 @@
>>>    #include "ui/console.h"
>>>    #include "hw/virtio/virtio-gpu.h"
>>>    #include "hw/virtio/virtio-gpu-pixman.h"
>>> +#include "hw/vfio/vfio-device.h"
>>>    #include "trace.h"
>>>    #include "system/ramblock.h"
>>>    #include "system/hostmem.h"
>>> @@ -40,10 +41,42 @@ static bool ram_block_is_memfd_backed(RAMBlock
>> *rb)
>>>        return false;
>>>    }
>>>
>>> +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource *res)
>>> +{
>>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
>>> +    VFIODevice *vbasedev;
>>> +    RAMBlock *first_rb;
>>> +    ram_addr_t offset;
>>> +
>>> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false,
>> &offset);
>>> +    if (!first_rb) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: Could not find ramblock\n", __func__);
>>> +        return;
>>> +    }
>>> +
>>> +    vbasedev = vfio_device_lookup(first_rb->mr);
>>> +    if (!vbasedev) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: No VFIO device found to create dmabuf from\n",
>>> +                      __func__);
>>> +        return;
>>> +    }
>>> +
>>> +    res->dmabuf_fd = vfio_device_create_dmabuf_fd(vbasedev,
>>> +                                                  res->iov, res->iov_cnt);
>>> +    if (res->dmabuf_fd < 0) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
>>> +                      __func__, strerror(errno));
>>> +    }
>>> +#endif
>>> +}
>>> +
>>>    static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource
>> *res)
>>>    {
>>>        struct udmabuf_create_list *list;
>>> -    RAMBlock *rb;
>>> +    RAMBlock *rb, *first_rb;
>>>        ram_addr_t offset;
>>>        int udmabuf, i;
>>>
>>> @@ -52,15 +85,17 @@ static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>            return;
>>>        }
>>>
>>> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false,
>> &offset);
>>> +    if (!ram_block_is_memfd_backed(first_rb)) {
>>> +        return;
>>> +    }
>>> +
>>
>> We had an extensive discussion but I still don't understand the benefit
>> of this change while I see it adds complexity by having another call of
> I'll get rid of the extra call to qemu_ram_block_from_host() in the next version.

It is possible to reduce the number of the execution of 
qemu_ram_block_from_host() calls, but the code complexity remains unless 
you keep the original code.

> 
>> qemu_ram_block_from_host() and imposing an extra restriction that all
>> elements need to belong to one RAMBlock.
> I thought you suggested that we need to ensure all entries (need to be
> validated and) are associated with the same memory region? As
> virtio_gpu_create_udmabuf() was not doing that, I thought this
> change/restriction needs to be added.

My first comment I raised for "[PATCH v2 09/10] virtio-gpu-dmabuf: 
Introduce qemu_iovec_same_memory_regions()" was that it complicates the 
codebase without necessity.
https://lore.kernel.org/qemu-devel/83274ca7-dd37-4856-b198-f334bf630835@rsg.ci.i.u-tokyo.ac.jp/

> 
> And, since calling ram_block_is_memfd_backed() for each entry would
> incur extra overhead (as there can be thousands of entries and fcntl needs
> to check with the kernel), I figured calling it once for the first ram block
> and comparing all the other ram blocks against it made sense.

I don't think the change is irrelevant with adding support of VFIO, and 
I doubt its necessity either; the UDMABUF_CREATE_LIST ioctl will catch it.

> 
> Also, rethinking this whole situation again, I don't think we should try to create
> a dmabuf for a buffer that might have mixed/different memory regions or
> memfds (as this is most likely an invalid scenario that could lead to undefined
> behavior) so this change is meant to prevent such scenario.

In the email thread I cited I only said the check is unnecessary, but it 
can be also problematic.

For example, if you hotplug some memory, the memory can be backed by 
another memfd, and the kernel may use both the existing memory and the 
hotplugged one to back a virtually contiguous region allocated for a 
virtio-gpu resource. You may look at drm_gem_get_pages() in Linux and 
find out that it allocates on a per-page basis.

Regards,
Akihiko Odaki

