Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4E3D35671
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 04:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkwoG-0003dR-5F; Tue, 27 Jan 2026 23:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkwo5-0003Vl-4V
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 23:05:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkwnt-0008Qi-UA
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 23:05:24 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60S43w4f089786
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 28 Jan 2026 13:05:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zRSQXBvEdBJwEaITDdesZdwyhPzbQJa2i/Ixc7LVewE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769573107; v=1;
 b=Xi4BT9Mg6fvj3dZd3VyeO35auitvziWgR9+Z7hzMqQIggUgleLZRs6n+TEFKL745
 YZwEtycdII7c2cNqe9ya3+pgvsep87ZxCvFAcImpz/tBrJcMBzaxwoiJXbzHJjzI
 S3IorPxflWqJSJ/ZOXQNYSMmnANLWTZLAOJvzu9R/Guy5wWSKR0AQV2VeKUvKKBs
 N/7AmefGsQEu7UHS5cmryXHe6LWwbaPmDwUCi3Wf0l/wShz8ylhNSR+1PlD6J7jR
 8XCWcARjHw4opU5ZXn0qfKCGvMw+lzL/IfqDW+De/89s64G0hO3xf24jjkQWrlYA
 /HwIT0MrDqE1Yu4/xFlmKA==
Message-ID: <0c2d8d6b-f93a-4548-ad3d-21253cce6fc4@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 28 Jan 2026 13:03:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-9-vivek.kasireddy@intel.com>
 <ef2f5779-a23b-44dc-b467-0da00e6b1243@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718584261475341CB7958A8FF890A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB718584261475341CB7958A8FF890A@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2026/01/27 15:14, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
>> associated with VFIO devices
>>
>> On 2026/01/23 15:17, Vivek Kasireddy wrote:
>>> In addition to memfd, a blob resource can also have its backing
>>> storage in a VFIO device region. Since, there is no effective way
>>> to determine where the backing storage is located, we first try to
>>> create a dmabuf assuming it is in memfd. If that fails, we try to
>>> create a dmabuf assuming it is in VFIO device region.
>>>
>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
>>> backing storage is located in a memfd or not. If it is not, we call
>>> vfio_create_dmabuf() which identifies the right VFIO device and
>>> eventually invokes the vfio_device_create_dmabuf_fd() API to have
>>> a dmabuf fd created.
>>>
>>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
>>> use the VFIO device fd directly to create the CPU mapping.
>>>
>>> While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
>>> from virtio_gpu_create_udmabuf() and also replace warn_report()
>>> with qemu_log_mask().
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
>>>    hw/display/virtio-gpu-dmabuf.c | 117
>> ++++++++++++++++++++++++++++++---
>>>    2 files changed, 113 insertions(+), 9 deletions(-)
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
>>> index c34d4c85bc..2dfe70d7eb 100644
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
>>> @@ -27,6 +28,38 @@
>>>    #include "standard-headers/linux/udmabuf.h"
>>>    #include "standard-headers/drm/drm_fourcc.h"
>>>
>>> +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource
>> *res)
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
>>
>> This API design of vfio_device_create_dmabuf_fd() has some room of
>> improvements.
>>
>> First, this function requires to pass VFIODevice * which is derived from
>> res->iov[0]. Since it is getting res->iov[0] anyway, such a parameter is
>> redundant. vfio_device_create_dmabuf_fd() can call
>> vfio_device_lookup()
>> itself instead.
> Yeah, I agree. I'll move the call to lookup into vfio_device_create_dmabuf_fd().
> 
>>
>> The second problem is the error handling. The error may not be caused by
>> VFIO_DEVICE_FEATURE_DMA_BUF but may be caused by the guest
>> passing
>> regions that do not belong to one VFIO device. The two cases should be
>> distinguished for a correct message.
> Ok, I'll add separate error messages.
> 
>>
>>> +#endif
>>> +}
>>> +
>>>    static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>    {
>>>        struct udmabuf_create_list *list;
>>> @@ -43,10 +76,7 @@ static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>                         sizeof(struct udmabuf_create_item) * res->iov_cnt);
>>>
>>>        for (i = 0; i < res->iov_cnt; i++) {
>>> -        rcu_read_lock();
>>>            rb = qemu_ram_block_from_host(res->iov[i].iov_base, false,
>> &offset);
>>> -        rcu_read_unlock();
>>> -
>>>            if (!rb || rb->fd < 0) {
>>>                g_free(list);
>>>                return;
>>> @@ -62,17 +92,84 @@ static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>
>>>        res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>>>        if (res->dmabuf_fd < 0) {
>>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
>>> -                    strerror(errno));
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: UDMABUF_CREATE_LIST: %s\n",
>>> +                      __func__, strerror(errno));
>>>        }
>>>        g_free(list);
>>>    }
>>
>> These changes of virtio_gpu_create_udmabuf() are independent so
>> should
>> go into separate patches with explanation.
> I called these out in the commit message and included them as they were
> trivial but I guess I could move them into separate patches.

As docs/devel/submitting-a-patch.rst says,
 > A commit message that mentions "Also, ..." is often a good candidate
 > for splitting into multiple patches.

I think there will be another round of review so I suggest taking the 
chance to do so.

> 
>>
>>>
>>> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource
>> *res)
>>> +{
>>> +    struct vfio_region_info *info = NULL;
>>> +    VFIODevice *vbasedev = NULL;
>>> +    ram_addr_t offset, len = 0;
>>> +    RAMBlock *first_rb, *rb;
>>> +    void *map, *submap;
>>> +    int i, ret = -1;
>>> +
>>> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false,
>> &offset);
>>> +    if (!first_rb) {
>>> +        return MAP_FAILED;
>>> +    }
>>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
>>> +    vbasedev = vfio_device_lookup(first_rb->mr);
>>> +#endif
>>> +    if (!vbasedev) {
>>> +        return MAP_FAILED;
>>> +    }
>>> +
>>> +    /*
>>> +     * We first reserve a contiguous chunk of address space for the entire
>>> +     * dmabuf, then replace it with smaller mappings that correspond to
>> the
>>> +     * individual segments of the dmabuf.
>>> +     */
>>> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
>> vbasedev->fd, 0);
>>
>> It should have PROT_NONE instead of PROT_READ to prevent accidental
>> accesses to the placeholder mapping.
>> Likewise, -1 should be passed instead of vbasedev->fd so that the
>> placeholder mapping won't result in a mapping to real device.
> I am OK with both suggestions. However, I don't see any problem if the
> placeholder mapping is associated with the real device. In other words,
> what specific problem do you see if we keep vbasedev->fd instead of -1?

These two suggestions are to avoid accidents. If the code is right, 
there will be no accesses to the head of the device memory. But if there 
is something wrong with it, these two changes will be safe guards. In 
other words, with these two changes, you will not have such an 
accidental access unless all of the following three happen:
1) Accidentally accessing the mapped page.
2) The protection is set something else PROT_NONE.
3) The mapping points to the device.

Each of these conditions make accidents rarer to occur.

> 
>>
>>> +    if (map == MAP_FAILED) {
>>> +        return map;
>>> +    }
>>> +
>>> +    for (i = 0; i < res->iov_cnt; i++) {
>>> +        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false,
>> &offset);
>>> +        if (rb != first_rb) {
>>> +            goto err;
>>> +        }
>>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
>>> +        ret = vfio_get_region_index_from_mr(rb->mr);
>>> +        if (ret < 0) {
>>> +            goto err;
>>> +        }
>>> +
>>> +        ret = vfio_device_get_region_info(vbasedev, ret, &info);
>>
>> This function can take rb->mr and call vfio_device_lookup() and
>> vfio_get_region_index_from_mr() internally to simplify the API as
>> similar can be done for vfio_device_create_dmabuf_fd().
> Right, but vfio_device_get_region_info() is an already existing API
> that is called from various places that I am trying to leverage. I could
> create another API to wrap the calls to vfio_get_region_index_from_mr()
> and vfio_device_get_region_info() but not sure if that makes sense given
> that it would only have one caller.

vfio_device_get_region_info() should be regarded as an internal function 
of VFIO.

Thinking of that, the current API design that relies on 
vfio_device_lookup() to expose VFIODevice * is not optimal. We never 
want virtio-gpu or anyone else VFIO to mess up with it using functions 
declared in include/hw/vfio/vfio-device.h. Likewise, exposing
vbasedev->fd introduces bunch of hazards.

I think this entire function is better moved to VFIO for better 
encapsulation. I also think it should be placed close to 
vfio_device_create_dmabuf_fd(). These functions are quite similar so are 
better reviewed togather. Any future event to change either of the 
function is also likely to require a change to the other, so placing 
them nearby will be convenient.

Regards,
Akihiko Odaki

