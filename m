Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A615C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 04:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vteZv-0005Ov-Br; Fri, 20 Feb 2026 23:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vteZt-0005Ok-3A
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 23:26:49 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vteZp-0005oP-Gc
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 23:26:48 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61L4PLEY004973
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 21 Feb 2026 13:26:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5n8mGXDEXra90t8nXNH8HCF7HcePTc9+zDLNh+Zth+4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1771647998; v=1;
 b=GSxdVqXxjhnUlMLKwdLda93tituvCflFw9FoHTLRr6/dBCtIh6GR0nbV+IrT/1Rf
 IIPMKo1HWU8iOYZ/CkP+TFuS4/pmSKkiYrfPo7724wpKEKxB5qBWFJ/lhuCe9Y5A
 LQ4CfnbrQLaPEmc9V1eiTVT2wGRIt0QZTBwc/IlFXJOXXWYzvRQ0tVhvoC0A3OE1
 rF+c5G9b5jwjwcR0A6fy/4UryUcx7RDe+WbMuYknpiuGP5Er2BzpYktmUmhA4V4s
 is3/VARY6fZRneQ8Xp+M1yOsgwLLOxaAhzUT0lSFkazABYvkxH87tGNVQYs36Su7
 FKHTGXF5o9FFBQ6/LF7Y6g==
Message-ID: <40ca075b-51e5-4aad-aab5-fbaf1c9d530c@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 21 Feb 2026 13:25:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-12-vivek.kasireddy@intel.com>
 <c7c03384-4815-4032-89bd-de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71856CAA4507A8EFD5AF5F45F863A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a7b64dbd-9535-4927-bf36-e579b8bec4ca@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71855A99CC24E9367DFC8223F86BA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB71855A99CC24E9367DFC8223F86BA@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2026/02/19 16:23, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for
>> blobs associated with VFIO devices
>>
>>>>> In addition to memfd, a blob resource can also have its backing
>>>>> storage in a VFIO device region. Since, there is no effective way
>>>>> to determine where the backing storage is located, we first try to
>>>>> create a dmabuf assuming it is in memfd. If that fails, we try to
>>>>> create a dmabuf assuming it is in VFIO device region.
>>>>>
>>>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
>>>>> backing storage is located in a memfd or not. If it is not, we invoke
>>>>> the vfio_device_create_dmabuf() API which identifies the right VFIO
>>>>> device and eventually creates a dmabuf fd.
>>>>>
>>>>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
>>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
>>>>> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
>>>>> created for the dmabuf.
>>>>>
>>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>> ---
>>>>>     hw/display/Kconfig             |  5 ++++
>>>>>     hw/display/virtio-gpu-dmabuf.c | 50
>>>> ++++++++++++++++++++++++++++------
>>>>>     2 files changed, 47 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
>>>>> index 1e95ab28ef..0d090f25f5 100644
>>>>> --- a/hw/display/Kconfig
>>>>> +++ b/hw/display/Kconfig
>>>>> @@ -106,6 +106,11 @@ config VIRTIO_VGA
>>>>>         depends on VIRTIO_PCI
>>>>>         select VGA
>>>>>
>>>>> +config VIRTIO_GPU_VFIO_BLOB
>>>>> +    bool
>>>>> +    default y
>>>>> +    depends on VFIO
>>>>> +
>>>>>     config VHOST_USER_GPU
>>>>>         bool
>>>>>         default y
>>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>>>> dmabuf.c
>>>>> index d9b2ecaf31..54d010b995 100644
>>>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>>>> @@ -18,6 +18,7 @@
>>>>>     #include "ui/console.h"
>>>>>     #include "hw/virtio/virtio-gpu.h"
>>>>>     #include "hw/virtio/virtio-gpu-pixman.h"
>>>>> +#include "hw/vfio/vfio-device.h"
>>>>>     #include "trace.h"
>>>>>     #include "system/ramblock.h"
>>>>>     #include "system/hostmem.h"
>>>>> @@ -27,6 +28,27 @@
>>>>>     #include "standard-headers/linux/udmabuf.h"
>>>>>     #include "standard-headers/drm/drm_fourcc.h"
>>>>>
>>>>> +static bool virtio_gpu_create_vfio_dmabuf(struct
>>>> virtio_gpu_simple_resource *r,
>>>>> +                                          Error **errp)
>>>>> +{
>>>>> +    bool ret = false;
>>>>> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
>>>>> +    Error *local_err = NULL;
>>>>> +    int fd;
>>>>> +
>>>>> +    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd,
>> &local_err))
>>>> {
>>>>> +        error_report_err(*errp);
>>>>> +        *errp = NULL;
>>>>> +        error_propagate(errp, local_err);
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    ret = true;
>>>>> +    r->dmabuf_fd = fd;
>>>>> +#endif
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>     static bool virtio_gpu_create_udmabuf(struct
>>>> virtio_gpu_simple_resource *res,
>>>>>                                           Error **errp)
>>>>>     {
>>>>> @@ -73,16 +95,28 @@ static bool
>> virtio_gpu_create_udmabuf(struct
>>>> virtio_gpu_simple_resource *res,
>>>>>     static bool virtio_gpu_remap_dmabuf(struct
>>>> virtio_gpu_simple_resource *res,
>>>>>                                         Error **errp)
>>>>>     {
>>>>> +    Error *local_err = NULL;
>>>>> +    bool ret = true;
>>>>>         void *map;
>>>>>
>>>>>         map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
>>>> res->dmabuf_fd, 0);
>>>>>         if (map == MAP_FAILED) {
>>>>>             error_setg_errno(errp, errno, "dmabuf mmap failed");
>>>>> -        res->remapped = NULL;
>>>>> -        return false;
>>>>> +        map = NULL;
>>>>> +        ret = false;
>>>>> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
>>>>> +        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
>>>>> +                                    res->blob_size, &local_err)) {
>>>>> +            ret = true;
>>>>> +        } else {
>>>>> +            error_report_err(*errp);
>>>>> +            *errp = NULL;
>>>>> +        }
>>>>> +#endif
>>>>> +        error_propagate(errp, local_err);
>>>>>         }
>>>>>         res->remapped = map;
>>>>> -    return true;
>>>>> +    return ret;
>>>>>     }
>>>>>
>>>>>     static void virtio_gpu_destroy_dmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>> @@ -145,8 +179,10 @@ void virtio_gpu_init_dmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>>             pdata = res->iov[0].iov_base;
>>>>>         } else {
>>>>>             if (!virtio_gpu_create_udmabuf(res, &local_err)) {
>>>>
>>>> virtio_gpu_create_udmabuf() will log "Could not find valid ramblock"
>>>> even for VFIO, which shouldn't happen.
>>> AFAICS, it won't log a failure here because rb->fd is valid in the VFIO
>> case
>>> especially after 8cfaf22668 ("Create dmabuf for PCI BAR per region").
>>> The failure would occur in UDMABUF_CREATE_LIST IOCTL most likely
>>> because rb->fd is not memfd in this case.
>>
>> It is still nice to ensure that the log will never be emitted in the
>> VFIO case without relying on the internal behavior of the VFIO device
>> code.
> Ok, got it.
> 
>>
>>>
>>>>
>>>> This logic should look like as follows:
>>>>
>>>> virtio_gpu_create_udmabuf(res);
>>>> if (it turned out the memory is incompatible with udmabuf) {
>>>>        virtio_gpu_create_vfio_dmabuf(res);
>>>>        if (it turned out the memory is not backed by VFIO) {
>>>>            qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
>>>>            return;
>>> I think this is mostly how I have it right now except that I am using
>>> error_report_err() instead of qemu_log_mask(). Do you want me
>>> to only use qemu_log_mask() when we cannot create a dmabuf via
>>> udmabuf and vfio?
>>
>> More precisely, use LOG_GUEST_ERROR if and only if creating a DMA-
>> BUF
>> failed:
>> - in *both* virtio_gpu_create_udmabuf() and
>>     virtio_gpu_create_vfio_dmabuf()
> Ok, but should we also set the 'Error *' when this failure occurs?
> 
>> - and it is due to a guest's fault.
> I think the only case where we can consider Guest is at fault is invalid rb/addr
> (i.e, qemu_ram_block_from_host() returning NULL). Can we limit it to just this
> particular case because in all other failure cases (for example, UDMABUF_CREATE_LIST
> IOCTL failure), I don't see any obvious way to deduce whether Guest or Host
> is at fault?

We should assume that the guest is at fault. In general, when a feature 
is missing and the guest tries to use it (e.g., by accessing MMIO 
registers present only with the feature), there is a possibility that 
the user misconfigured the VM. But we just emit LOG_GUEST_ERROR for such 
cases.

> 
>>
>>> As you can see, I am using a mix of error_report_err() and
>> qemu_log_mask()
>>> after Cedric suggested to improve error handling by using 'Error *'.
>>>
>>> On a slightly different note, do you (or Cedric/anyone) know how to
>>> properly include CONFIG_DEVICES header to fix the following error:
>>> ../hw/display/virtio-gpu-dmabuf.c: In function
>> 'virtio_gpu_create_vfio_dmabuf':
>>> ../hw/display/virtio-gpu-dmabuf.c:35:13: error: attempt to use
>> poisoned 'CONFIG_VIRTIO_GPU_VFIO_BLOB'
>>>      35 | #if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
>>>
>>> Looks like I am missing some key detail as I have tried different things
>> but
>>> have not been able to fix this compilation error.
>>
>> I think you are supposed to add stubs. See hw/vfio/iommufd-stubs.c for
>> example.
> I have tried adding stubs following the example of:
> cca621c782 ("intel_iommu_accel: Check for compatibility with IOMMUFD backed device when x-flts=on")
> but it doesn't help. I still get the following errors:

You are looking at the wrong example. It uses target-specific macros 
because intel_iommu_accel is specific to i386; virtio-gpu isn't. Refer 
to hw/vfio/iommufd-stubs.c, which I mentioned. For the user-side 
example, refer to migration/cpr.c.

> In file included from ../hw/display/virtio-gpu-dmabuf.c:21:
> /media/myvdi/build/git-libs-64/cedric_qemu/qemu/hw/display/virtio-gpu-vfio-dmabuf.h:14:10: error: '#include' expects '"FILENAME"' or '<FILENAME>'
>     14 | #include CONFIG_DEVICES
>        |          ^~~~~~~~~~~~~~

CONFIG_DEVICES is a target-specific macro. Directly include the relevant 
header as migration/cpr.c includes hw/vfio/vfio-device.h.

> /media/myvdi/build/git-libs-64/cedric_qemu/qemu/hw/display/virtio-gpu-vfio-dmabuf.h:16:8: error: attempt to use poisoned 'CONFIG_VIRTIO_GPU_VFIO_BLOB'
>     16 | #ifdef CONFIG_VIRTIO_GPU_VFIO_BLOB
>        |        ^
> In file included from /media/myvdi/build/git-libs-64/cedric_qemu/qemu/include/exec/poison.h:7,
>                   from /media/myvdi/build/git-libs-64/cedric_qemu/qemu/include/qemu/osdep.h:38,
>                   from ../hw/display/virtio-gpu-dmabuf.c:14:
> ./config-poison.h:233:20: note: poisoned here
>    233 | #pragma GCC poison CONFIG_VIRTIO_GPU_VFIO_BLOB

CONFIG_VIRTIO_GPU_VFIO_BLOB should be removed. It should always use the 
necessary symbols as migration/cpr.c always uses vmstate_cpr_vfio_devices.

Regards,
Akihiko Odaki

