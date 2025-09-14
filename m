Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E9CAC582
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 07:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxhB9-0000Ne-7u; Sun, 14 Sep 2025 03:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uxhB5-0000N4-SX
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 03:29:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uxhB2-00070F-HO
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 03:29:39 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58E7TFtB077871
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 14 Sep 2025 16:29:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Z6WFjEpaodzMMF65DDIrtiJaVKxy2pGw7ny/YRyjRsw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757834955; v=1;
 b=TtDcgavKFjeO0e/A8zVLGvizdJvz03cP6Xtg1XwCFKqucEo+J4BeaniO2TYmdLFA
 mITI7UP0BD0Zu3D2/IAMYO6mMSFZX5drh7BPhhy1VfuxCfVDvXgwVo9hLqphhvB9
 Mk9hiQLKsP7POq9J2N/j+NB3/2sIqSakJ1LZsdmL/FX8fg32c4Med+yuowuIr2VZ
 ig3FAprx5ZsdgM48u3Y0m0d2eOSihwFdZZX1srZUoVgdTp8vr2ROYAWXE0r9X3Bf
 zsnqe8+ADV/s/rzRgaMPHtJeiOrVqua7XK9+P6mtny5JiYYVkOhxHtailU2WWXfr
 lzzOVhamU3NrLT7BLx+9bw==
Message-ID: <0599691b-4838-42df-a22a-20a11e32f885@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 14 Sep 2025 16:29:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs associated
 with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-4-vivek.kasireddy@intel.com>
 <684609f1-bc19-4c28-8ae1-802fc9a1ad6f@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F10B489C1650577CE085F80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185F10B489C1650577CE085F80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2025/09/13 11:43, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs
>> associated with VFIO devices
>>
>> On 2025/09/03 7:42, Vivek Kasireddy wrote:
>>> In addition to memfd, a blob resource can also have its backing
>>> storage in a VFIO device region. Therefore, we first need to figure
>>> out if the blob is backed by a VFIO device region or a memfd before
>>> we can call the right API to get a dmabuf fd created.
>>>
>>> So, once we have the ramblock and the associated mr, we rely on
>>> memory_region_is_ram_device() to tell us where the backing storage
>>> is located. If the blob resource is VFIO backed, we try to find the
>>> right VFIO device that contains the blob and then invoke the API
>>> vfio_create_dmabuf().
>>>
>>> Note that we only call virtio_gpu_remap_udmabuf() if the blob is
>>> backed by a memfd. This is because the VFIO dmabuf implementation
>>> may not support mmap.
>>>
>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/virtio-gpu-udmabuf.c | 60 ++++++++++++++++++++++++++++--
>> ---
>>>    1 file changed, 52 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-
>> udmabuf.c
>>> index d804f321aa..0390a8f488 100644
>>> --- a/hw/display/virtio-gpu-udmabuf.c
>>> +++ b/hw/display/virtio-gpu-udmabuf.c
>>> @@ -18,6 +18,7 @@
>>>    #include "ui/console.h"
>>>    #include "hw/virtio/virtio-gpu.h"
>>>    #include "hw/virtio/virtio-gpu-pixman.h"
>>> +#include "hw/vfio/vfio-device.h"
>>>    #include "trace.h"
>>>    #include "system/ramblock.h"
>>>    #include "system/hostmem.h"
>>> @@ -27,6 +28,32 @@
>>>    #include "standard-headers/linux/udmabuf.h"
>>>    #include "standard-headers/drm/drm_fourcc.h"
>>>
>>> +static void vfio_create_dmabuf(VFIODevice *vdev,
>>> +                               struct virtio_gpu_simple_resource *res)
>>> +{
>>> +    res->dmabuf_fd = vfio_device_create_dmabuf(vdev, res->iov, res-
>>> iov_cnt);
>>> +    if (res->dmabuf_fd < 0) {
>>> +        warn_report("%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s", __func__,
>>> +                    strerror(errno));
>>> +    }
>>> +}
>>> +
>>> +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
>>> +{
>>> +    VFIODevice *vdev;
>>> +
>>> +    if (QLIST_EMPTY(&vfio_device_list)) {
>>> +        return NULL;
>>> +    }
>>
>> I think this QLIST_EMPTY() check can be removed.
> Yeah, agreed. I'll remove it.
> 
>>
>>> +
>>> +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
>>> +        if (vdev->dev == mr->dev) {
>>> +            return vdev;
>>> +        }
>>> +    }
>>> +    return NULL;
>>> +}
>>> +
>>>    static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource
>> *res)
>>>    {
>>>        struct udmabuf_create_list *list;
>>> @@ -130,6 +157,9 @@ bool virtio_gpu_have_udmabuf(void)
>>>
>>>    void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>>>    {
>>> +    bool memfd_blob = false;
>>> +    ram_addr_t offset;
>>> +    RAMBlock *rb;
>>>        void *pdata = NULL;
>>>
>>>        res->dmabuf_fd = -1;
>>> @@ -137,15 +167,31 @@ void virtio_gpu_init_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>            res->iov[0].iov_len < 4096) {
>>>            pdata = res->iov[0].iov_base;
>>>        } else {
>>> -        virtio_gpu_create_udmabuf(res);
>>> +        rb = qemu_ram_block_from_host(res->iov[0].iov_base, false,
>> &offset);
>>> +        if (rb && memory_region_is_ram_device(rb->mr)) {
>>> +            VFIODevice *vdev = vfio_device_lookup(rb->mr);
>>> +
>>> +            if (!vdev) {
>>> +                warn_report("Could not find device to create dmabuf");
>>
>> It is odd to print a warning only when the memory region is a RAM device
>> not backed by VFIO while it prints no warning for the other incompatible
>> memory regions. It is better to keep the behavior for the incompatible
>> memory regions consistent.
> Ok, I'll have the warning printed in other incompatible cases as well.
By the way, this condition should be reported with LOG_GUEST_ERROR 
instead of warn_report(). LOG_GUEST_ERROR is for the situation where the 
guest does something wrong while the host does the correct thing. It is 
the guest's fault if it passes an incompatible address.

Regards,
Akihiko Odaki

