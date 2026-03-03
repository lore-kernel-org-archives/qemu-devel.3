Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC090E67A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJwN-00061y-5I; Tue, 03 Mar 2026 02:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxJwK-00060y-2R
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:13:08 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxJwG-0000yy-UL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:13:07 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6237CFNJ014602
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 16:12:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/4zBjPgniw6pnP4/1STARHWkfyciAGAY5GbVIjeYn14=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772521975; v=1;
 b=sfJzT7O5XqNM01IdFnaqmAvr9qZM2LJOPlhbYGywXRLFJJhPDtCx3BmU5TQlLAzY
 YAvzb69sc7rxl/5+HIxkHgfcV0Qq4a2HHdXpsBRgPH92T7JEryj3XgkcJzSkUxQm
 5pIDCZvhGQYhst6hb+z4TBwDE63wSPv5G/eXiLndagZNwVJ2rN0opxI8pvmvbVPl
 Ia99w02C8msSKuKZlSDKGuc1AoIHScT90OlsMBn6Xqm2hOT3d4hmQdY+QNWA9mZT
 Tebn/u+3II2p9gApWfFvu3jLkITB5g8D9ioRtJkBc8R8olBzbymk/Kn0nvwiILKp
 K+lvkQw/I/jGHAM0pVDj6g==
Message-ID: <e0887d59-9b0d-4f94-b00a-a57781d96061@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Mar 2026 16:12:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
 <20260227221632.827046-10-vivek.kasireddy@intel.com>
 <daa04cc8-c2ae-43f7-8e5c-a2e6d44b1f50@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185A75292BD4C70154A98CAF87EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <90bb995b-30f0-4d0a-b574-773ef47d798b@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177F7B3A2C4C062848D6D29F87FA@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CH3PR11MB7177F7B3A2C4C062848D6D29F87FA@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
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

On 2026/03/03 16:10, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v8 09/10] virtio-gpu-dmabuf: Improve error
>> handling with 'Error **' and err enum
>>>> On 2026/02/28 7:13, Vivek Kasireddy wrote:
>>>>> Make the error handling more robust in virtio_gpu_init_udmabuf()
>>>>> by introducing 'Error **' parameter to capture errors and using an
>>>>> enum from VFIO to categorize Guest and Host errors. This allows
>>>>> for better error reporting and handling of errors from
>>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
>>>>>
>>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>> ---
>>>>>     hw/display/virtio-gpu-dmabuf.c | 61 ++++++++++++++++++++++++-
>> ------
>>>> ---
>>>>>     1 file changed, 43 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>>>> dmabuf.c
>>>>> index 8d67ef7c2a..b2badfc1bd 100644
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
>>>>> @@ -27,16 +28,18 @@
>>>>>     #include "standard-headers/linux/udmabuf.h"
>>>>>     #include "standard-headers/drm/drm_fourcc.h"
>>>>>
>>>>> -static void virtio_gpu_create_udmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>> +static int virtio_gpu_create_udmabuf(struct
>>>> virtio_gpu_simple_resource *res,
>>>>> +                                     Error **errp)
>>>>>     {
>>>>>         g_autofree struct udmabuf_create_list *list = NULL;
>>>>>         RAMBlock *rb;
>>>>>         ram_addr_t offset;
>>>>> -    int udmabuf, i;
>>>>> +    int udmabuf, i, fd;
>>>>>
>>>>>         udmabuf = udmabuf_fd();
>>>>>         if (udmabuf < 0) {
>>>>> -        return;
>>>>> +        error_setg(errp, "udmabuf device not available or enabled");
>>>>> +        return VFIO_DMABUF_CREATE_HOST_ERROR;
>>>>
>>>> I failed to point out one thing for naming of the enum. The name
>> should
>>>> express if the error is caused by invalid iov or something else. Then
>>>> virtio-gpu decides how to recover the error; it's virtio-gpu who knows
>>>> the iov is from the guest and decides to report a guest error, not
>> vfio.
>>>> Otherwise, it reports a host error.
>>> So, it sounds like you are suggesting that there needs to be three
>> enum
>>> values:
>>> enum {
>>>       /* Guest is responsible for this error */
>>>       VFIO_DMABUF_CREATE_GUEST_ERROR = -1,
>>>       /* Guest is at fault as the IOVEC passed in is invalid */
>>>       VFIO_DMABUF_CREATE_INVALID_IOV_ERROR = -2,
>>>       /* Host is at fault for this error */
>>>       VFIO_DMABUF_CREATE_HOST_ERROR = -3,
>>> }
>>
>> vfio doesn't know if the guest or the host is responsible, so it cannot
>> make use of VFIO_DMABUF_CREATE_GUEST_ERROR and
>> VFIO_DMABUF_CREATE_HOST_ERROR.
>>
>>>
>>> Or, please let me know in detail what changes you would like to see.
>>
>> A possible combination of values is as follows:
>>
>> - VFIO_DMABUF_CREATE_ERR_UNSPEC
>> - VFIO_DMABUF_CREATE_ERR_INVALID_IOV
> Just these two error types are needed? Should I completely drop
> VFIO_DMABUF_CREATE_GUEST_ERROR and VFIO_DMABUF_CREATE_HOST_ERROR,
> even for udmabuf errors?

Yes, that's what I meant.

Regards,
Akihiko Odaki

> 
> Thanks,
> Vivek
> 
>>
>> I took the example of VIRTIO_GPU_RESP_ERR_UNSPEC and
>> VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER for naming.
>>
>>>
>>>>
>>>>>         }
>>>>>
>>>>>         list = g_malloc0(sizeof(struct udmabuf_create_list) +
>>>>> @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>>         for (i = 0; i < res->iov_cnt; i++) {
>>>>>             rb = qemu_ram_block_from_host(res->iov[i].iov_base, false,
>>>> &offset);
>>>>>             if (!rb || rb->fd < 0) {
>>>>> -            return;
>>>>> +            error_setg(errp, "IOV memory address incompatible with
>>>> udmabuf ");
>>>>> +            return VFIO_DMABUF_CREATE_GUEST_ERROR;
>>>>>             }
>>>>>
>>>>>             list->list[i].memfd  = rb->fd;
>>>>> @@ -56,22 +60,30 @@ static void
>> virtio_gpu_create_udmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>>         list->count = res->iov_cnt;
>>>>>         list->flags = UDMABUF_FLAGS_CLOEXEC;
>>>>>
>>>>> -    res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>>>>> -    if (res->dmabuf_fd < 0) {
>>>>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
>>>>> -                    strerror(errno));
>>>>> +    fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>>>>> +    if (fd < 0) {
>>>>> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
>>>> failed");
>>>>> +        if (errno == EINVAL || errno == EBADFD) {
>>>>> +            return VFIO_DMABUF_CREATE_GUEST_ERROR;
>>>>> +        }
>>>>> +        return VFIO_DMABUF_CREATE_HOST_ERROR;
>>>>>         }
>>>>> +    return fd;
>>>>>     }
>>>>>
>>>>> -static void virtio_gpu_remap_dmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>> +static bool virtio_gpu_remap_dmabuf(struct
>>>> virtio_gpu_simple_resource *res,
>>>>> +                                    Error **errp)
>>>>>     {
>>>>> -    res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>>>>> -                         MAP_SHARED, res->dmabuf_fd, 0);
>>>>> -    if (res->remapped == MAP_FAILED) {
>>>>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
>>>>> -                    strerror(errno));
>>>>> +    void *map;
>>>>> +
>>>>> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
>> res-
>>>>> dmabuf_fd, 0);
>>>>> +    if (map == MAP_FAILED) {
>>>>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
>>>>>             res->remapped = NULL;
>>>>> +        return false;
>>>>>         }
>>>>> +    res->remapped = map;
>>>>> +    return true;
>>>>>     }
>>>>>
>>>>>     static void virtio_gpu_destroy_dmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>> @@ -125,19 +137,32 @@ bool virtio_gpu_have_udmabuf(void)
>>>>>
>>>>>     void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
>> *res)
>>>>>     {
>>>>> +    Error *local_err = NULL;
>>>>>         void *pdata = NULL;
>>>>> +    int ret;
>>>>>
>>>>>         res->dmabuf_fd = -1;
>>>>>         if (res->iov_cnt == 1 &&
>>>>>             res->iov[0].iov_len < 4096) {
>>>>>             pdata = res->iov[0].iov_base;
>>>>>         } else {
>>>>> -        virtio_gpu_create_udmabuf(res);
>>>>> -        if (res->dmabuf_fd < 0) {
>>>>> +        ret = virtio_gpu_create_udmabuf(res, &local_err);
>>>>> +        if (ret < 0) {
>>>>> +            error_prepend(&local_err, "Cannot create dmabuf: ");
>>>>
>>>> This error_prepend() is redundant. The error messages
>>>> virtio_gpu_create_udmabuf() emits already suggests they are
>> problems
>>>> with DMA-BUF.
>>> Ok, I'll drop the error_prepend().
>>>
>>> Thanks,
>>> Vivek
>>>
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>> +
>>>>> +            if (ret == VFIO_DMABUF_CREATE_GUEST_ERROR) {
>>>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>>>> +                              "Cannot create dmabuf: incompatible
>> memory\n");
>>>>> +                error_free(local_err);
>>>>> +                return;
>>>>> +            }
>>>>> +            error_report_err(local_err);
>>>>>                 return;
>>>>>             }
>>>>> -        virtio_gpu_remap_dmabuf(res);
>>>>> -        if (!res->remapped) {
>>>>> +
>>>>> +        res->dmabuf_fd = ret;
>>>>> +        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
>>>>> +            error_report_err(local_err);
>>>>>                 return;
>>>>>             }
>>>>>             pdata = res->remapped;
>>>
> 


