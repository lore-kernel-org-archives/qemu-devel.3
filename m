Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B675BF5545D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8Av-0006Hg-8e; Wed, 25 Feb 2026 01:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vv8Ao-0006F2-HA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:15:02 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vv8Ak-0002uB-SZ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:15:02 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61P6EZ7N027841
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 25 Feb 2026 15:14:50 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2NeTJ7oZ5CYAhoXtQN3WCH+8lFArzCfoXS8EyK3CZE0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772000090; v=1;
 b=ISD/3KWpPIALipzKIIzXZlVyItJZxkRU/swzvjIQ04ma/OriYUDrrKyPbqfJlK8f
 9DiRXtm7Egvw0ZRaqqbRG6bD4/VVwQCKRMCCaCzTtsiC5H+3leSbUUZObE7ABHGM
 wx2KqUWoS3sa1sbaC9C082MUC4kCvN7PUSvd5pqBC7/DGOAi7tfYi+OCFuuGopOy
 NqqNC2tHioor6apzxQZ1M/4LbictY6QCj0r4MOsrNoNXRbVWzUlR7G0/4wiDdrAw
 N7EUblcCL7D28ziTC+/W+yj8SzQFiLxji+PSSfTewTk5vFATA9sKsTpze6Lj4qIV
 d5itemkIzAAC4Hx8kWADnQ==
Message-ID: <d2779f88-735e-4d14-9b5d-8577282c5477@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 25 Feb 2026 15:14:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
 <20260223080200.468558-11-vivek.kasireddy@intel.com>
 <aa496278-274c-4fb1-bb47-bfdda7337628@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F034A065CCE507F69F14F875A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185F034A065CCE507F69F14F875A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
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

On 2026/02/25 15:03, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for
>> blobs associated with VFIO devices
>>
>> On 2026/02/23 17:00, Vivek Kasireddy wrote:
>>> In addition to memfd, a blob resource can also have its backing
>>> storage in a VFIO device region. Since, there is no effective way
>>> to determine where the backing storage is located, we first try to
>>> create a dmabuf assuming it is in memfd. If that fails, we try to
>>> create a dmabuf assuming it is in VFIO device region.
>>>
>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
>>> backing storage is located in a memfd or not. If it is not, we invoke
>>> the vfio_device_create_dmabuf() API which identifies the right VFIO
>>> device and eventually creates a dmabuf fd.
>>>
>>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
>>> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
>>> created for the dmabuf.
>>>
>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/meson.build         |  1 +
>>>    hw/display/vfio-dmabuf-stubs.c | 23 +++++++++++++++++++++++
>>>    hw/display/virtio-gpu-dmabuf.c | 32 ++++++++++++++++++++++++-----
>> ---
>>>    3 files changed, 48 insertions(+), 8 deletions(-)
>>>    create mode 100644 hw/display/vfio-dmabuf-stubs.c
>>>
>>> diff --git a/hw/display/meson.build b/hw/display/meson.build
>>> index f5f92b1068..7d2bd839cc 100644
>>> --- a/hw/display/meson.build
>>> +++ b/hw/display/meson.build
>>> @@ -70,6 +70,7 @@ if
>> config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>>>                        if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c'), pixman])
>>>      if host_os == 'linux'
>>>        virtio_gpu_ss.add(files('virtio-gpu-dmabuf.c'))
>>> +    virtio_gpu_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-
>> dmabuf-stubs.c'))
>>>      else
>>>        virtio_gpu_ss.add(files('virtio-gpu-dmabuf-stubs.c'))
>>>      endif
>>> diff --git a/hw/display/vfio-dmabuf-stubs.c b/hw/display/vfio-dmabuf-
>> stubs.c
>>> new file mode 100644
>>> index 0000000000..12f016f0c5
>>> --- /dev/null
>>> +++ b/hw/display/vfio-dmabuf-stubs.c
>>> @@ -0,0 +1,23 @@
>>> +/*
>>> + * Copyright (c) 2026 Intel and/or its affiliates.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/error-report.h"
>>> +#include "qemu/iov.h"
>>> +
>>> +bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int
>> iov_cnt,
>>> +                               int *fd, Error **errp)
>>> +{
>>> +    error_setg(errp, "VFIO dmabuf support is not enabled");
>>> +    return false;
>>> +}
>>> +
>>> +bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int
>> iov_cnt,
>>> +                             void **addr, size_t total_size, Error **errp)
>>> +{
>>> +    error_setg(errp, "VFIO mmap dmabuf support is not enabled");
>>> +    return false;
>>> +}
>>
>> This is VFIO's implementation and shouldn't be here. Follow what
>> hw/vfio/iommufd-stubs.c, the previously-mentioned example, does.
> Ok, I'll move this file to hw/vfio directory.
> 
>>
>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>> dmabuf.c
>>> index fdcf8e53a2..3f39371de1 100644
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
>>> @@ -82,13 +83,21 @@ virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res, int *fd,
>>>    static bool virtio_gpu_remap_dmabuf(struct
>> virtio_gpu_simple_resource *res,
>>>                                        Error **errp)
>>>    {
>>> +    Error *mmap_err = NULL;
>>>        void *map;
>>>
>>>        map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
>> res->dmabuf_fd, 0);
>>>        if (map == MAP_FAILED) {
>>> -        error_setg_errno(errp, errno, "dmabuf mmap failed");
>>> +        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed: ");
>>>            res->remapped = NULL;
>>> -        return false;
>>> +
>>> +        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
>>> +                                     res->blob_size, errp)) {
>>> +            error_report_err(mmap_err);
>>> +            return false;
>>> +        }
>>> +        error_free(mmap_err);
>>> +        mmap_err = NULL;
>>>        }
>>>        res->remapped = map;
>>>        return true;
>>> @@ -145,7 +154,7 @@ bool virtio_gpu_have_udmabuf(void)
>>>
>>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>>>    {
>>> -    Error *local_err = NULL;
>>> +    Error *local_err = NULL, *vfio_err = NULL;
>>>        VirtIOGPUErrorType err;
>>>        void *pdata = NULL;
>>>        int fd;
>>> @@ -158,12 +167,19 @@ void virtio_gpu_init_dmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>            err = virtio_gpu_create_udmabuf(res, &fd, &local_err);
>>>            if (err != VIRTIO_GPU_NO_ERROR) {
>>>                error_prepend(&local_err, "Cannot create dmabuf: ");
>>> -            if (err == VIRTIO_GPU_GUEST_ERROR) {
>>> -                qemu_log_mask(LOG_GUEST_ERROR,
>>> -                              "Cannot create dmabuf: incompatible mem\n");
>>> +
>>> +            if (!vfio_device_create_dmabuf(res->iov, res->iov_cnt, &fd,
>>> +                                           &vfio_err)) {
>>> +                if (err == VIRTIO_GPU_GUEST_ERROR) {
>>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>>> +                                  "Cannot create dmabuf: incompatible mem\n");
>>
>> This logic is faulty. err is not set by vfio_device_create_dmabuf(), so
>> it reports a guest error even when the memory is compatible with
>> vfio_device_create_dmabuf() and it raised an error for a different
>> reason.
> Maybe I misunderstood your previous comment about this but I thought
> we are going to assume that if both virtio_gpu_create_udmabuf() and
> vfio_device_create_dmabuf() fail (assuming Guest error in case of
> virtio_gpu_create_udmabuf ()) then it is reasonable to assume that Guest
> is at fault for passing in incompatible memory addresses.

It's not what I suggested. What I suggested is as follows:
 > virtio_gpu_create_udmabuf(res);
 > if (it turned out the memory is incompatible with udmabuf) {
 >     virtio_gpu_create_vfio_dmabuf(res);
 >     if (it turned out the memory is not backed by VFIO) {
 >         qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
 >         return;
 >     }
 > }

https://lore.kernel.org/qemu-devel/c7c03384-4815-4032-89bd-de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp/

It is not correct to assume vfio_device_create_dmabuf() is failed due to 
a guest error when virtio_gpu_create_udmabuf(). For example, when mmap() 
fails in vfio_device_mmap_dmabuf(), it is a host error, and reporting a 
guest error in the case is a bug.

> 
> However, in order to fix this properly, I think we would have to have
> vfio_device_create_dmabuf() return VIRTIO_GPU_GUEST/HOST_ERROR
> (or something equivalent) which I was trying to avoid. Do you see any
> other proper way to fix this issue without messing with the return type
> of vfio_device_create_dmabuf()?
> 
> The reason why I am hesitant to make vfio_device_create_dmabuf() return
> Guest/Host error is because a future user of this API may not need this info.

A future user may not need it, but we need it to make this code bug-free.

Regards,
Akihiko Odaki

> 
> Thanks,
> Vivek
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>> +                }
>>> +                error_report_err(local_err);
>>> +                error_report_err(vfio_err);
>>> +                return;
>>>                }
>>> -            error_report_err(local_err);
>>> -            return;
>>> +            error_free(local_err);
>>> +            local_err = NULL;
>>>            }
>>>
>>>            res->dmabuf_fd = fd;
> 


