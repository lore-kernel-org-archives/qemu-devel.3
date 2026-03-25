Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A79AFEA830
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Jas-0002f2-5Q; Wed, 25 Mar 2026 04:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5Jao-0002ej-Bq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:27:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5Jai-0000Ob-39
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:27:55 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62P8RigX070787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 25 Mar 2026 17:27:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7/Qxkju2u10Tt4GdRGWifuVzAJCDQ9cjSufd8GeC3H0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1774427265; v=1;
 b=kc4XYMO4zVlRgmceS6L6DHteNN7QyRQczxsQMG6MBjtjZvZWr+DxKQFUzozQ2l+P
 wOYymEpVCjy/c39JtEGRWEgpV6dCnOAW9CvlnUXG4Mxq5G6NGt84ekjtpTQEf49a
 AbQQ/J1XBS/wCTakyAccsbmOob0P/Or5DKCR2nDWvubBieYLJNKrhuzVMyNq5sBb
 iMofY4pz+93delgl87U3eiTTMcMz6qIAwzhlWs/wb+823zcJGxTMr9srQ7j3OloU
 A4EMCzwZXgUlm8Al7WGzHzfLFksCpJT3XZ1iaxq36Ww3Aj6mSwSb9zqllphs5CK9
 PKcmaTCvz9oFjpUYJWuB+A==
Message-ID: <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 25 Mar 2026 17:27:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
 <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2026/03/25 14:31, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
>> handling with 'Error **' and err enum
>>>>
>>>> On 3/19/26 06:15, Vivek Kasireddy wrote:
>>>>> Make the error handling more robust in virtio_gpu_init_udmabuf()
>>>>> by introducing 'Error **' parameter to capture errors and using
>>>>> an enum from VFIO to categorize different errors. This allows for
>>>>> better error reporting and handling of errors from
>>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
>>>>>
>>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>> ---
>>>>>     hw/display/virtio-gpu-dmabuf.c | 67 +++++++++++++++++++++++--
>> -----
>>>> ----
>>>>>     1 file changed, 45 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>>>> dmabuf.c
>>>>> index e35f7714a9..89aa487654 100644
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
>>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>>>>
>>>> The function virtio_gpu_create_udmabuf() is returning
>> VFIO_DMABUF_*
>>>> enum
>>>> values, which is problematic because the function creates a
>> udmabuf,
>>>> not
>>>> a VFIO dmabuf.
>>>>
>>>> This creates a layering violation. The virtio-gpu-dmabuf code (which
>>>> handles both udmabuf and VFIO dmabuf creation) is using error
>> codes
>>>> defined in the VFIO-specific header.
>>
>> The rationale of using error codes is as follows:
>>
>>   > In that case, using it for udmabuf is cheating, but I think it's fine
>>   > since it's locally-contained in virtio-gpu-dmabuf.c, its intent is
>>   > still clear, and it has no adverse effect for users (at least there
>>   > will be no bug).
>>
>> https://lore.kernel.org/qemu-devel/becde56b-90bd-40ca-9329-
>> 0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp/
>>
>>>>
>>>> Please find another solution.
>>> Other solutions I can think of are either move these error enums into
>> virtio-gpu
>>> (and disregard the error return type from vfio) or move them to some
>> other header
>>> where they are visible to both virtio-gpu and vfio. I'd like hear
>> Akihiko's thoughts/
>>> comments on how to proceed given that he had reviewed virtio-gpu
>> patches in
>>> this series.
>>
>> Disregarding the error conditions of VFIO is not OK. That can cause a
>> guest error to be reported as a host error.
>>
>> I think the simplest alternative is just to have a duplicate enum for
>> virtio-gpu.
> That would address the layering violation but Cedric's other concern is
> that he believes having errp is sufficient and using these error enums in
> VFIO would be overkill.

It would be beneficial to describe the rationale behind the enums; the 
patch message only says "better error reporting", which is quite 
insufficient.

The rationale is that we need a special handling for the INVALID_IOV 
case. The INVALID_IOV case can happen in two cases:
- The memory is backed by VFIO. It will result in the INVALID_IOV error
   for the first attempt to use udmabuf, but this error can be properly
   recovered by letting the VFIO code to create a DMA-BUF instead.
- The memory is not backed by memfd nor VFIO. In this case, the error
   is a guest's fault, so we should:
   - Use qemu_log_mask(LOG_GUEST_ERROR, ...) instead of
     error_report_err().
   - Emit a message useful to diagnose the guest error, which we have
     discussed in this thread.

A common pattern is to return -errno to let the caller implement a 
special error handling, but in this case we specifically need to 
distinguish the INVALID_IOV case from the others and these enums are 
more convenient for this.

Regards,
Akihiko Odaki

> 
> Thanks,
> Vivek
>>
>>>
>>>>
>>>>
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
>>>>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>>>>             }
>>>>>
>>>>>             list->list[i].memfd  = rb->fd;
>>>>> @@ -56,22 +60,28 @@ static void
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
>>>>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>>>> +        }
>>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>>>>>         }
>>>>> +    return fd;
>>>>>     }
>>>>>
>>>>> -static void virtio_gpu_remap_dmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>> +static void *virtio_gpu_remap_dmabuf(struct
>>>> virtio_gpu_simple_resource *res,
>>>>> +                                     Error **errp)
>>>>>     {
>>>>> -    res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>>>>> -                         MAP_SHARED, res->dmabuf_fd, 0);
>>>>> -    if (res->remapped == MAP_FAILED) {
>>>>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
>>>>> -                    strerror(errno));
>>>>> -        res->remapped = NULL;
>>>>> +    void *map;
>>>>> +
>>>>> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
>>>> res->dmabuf_fd, 0);
>>>>> +    if (map == MAP_FAILED) {
>>>>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
>>>>> +        return NULL;
>>>>>         }
>>>>> +    return map;
>>>>>     }
>>>>>
>>>>>     static void virtio_gpu_destroy_dmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>> @@ -125,22 +135,35 @@ bool virtio_gpu_have_udmabuf(void)
>>>>>
>>>>>     void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
>> *res)
>>>>>     {
>>>>> +    Error *local_err = NULL;
>>>>>         void *pdata = NULL;
>>>>>
>>>>> -    res->dmabuf_fd = -1;
>>>>>         if (res->iov_cnt == 1 &&
>>>>>             res->iov[0].iov_len < 4096) {
>>>>> +        res->dmabuf_fd = -1;
>>>>>             pdata = res->iov[0].iov_base;
>>>>>         } else {
>>>>> -        virtio_gpu_create_udmabuf(res);
>>>>> +        res->dmabuf_fd = virtio_gpu_create_udmabuf(res,
>> &local_err);
>>>>> +        if (res->dmabuf_fd ==
>>>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>>>> +            error_free_or_abort(&local_err);
>>>>
>>>> Why not report the error in the QEMU log below ?
>>> I think the idea is that in the case of INVALID_IOV error, it is sufficient
>>> to just report that the Guest passed in incompatible memory
>> addresses.
>>> But I guess we could also just do:
>>> qemu_log_mask(LOG_GUEST_ERROR, "%s\n",
>> error_get_pretty(local_err));
>>
>> The error message may not be useful. e.g., "UDMABUF_CREATE_LIST:
>> ioctl
>> failed" does not tell what error the guest made and how to fix it.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Thanks,
>>> Vivek
>>>>
>>>>> +
>>>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>>>> +                          "Cannot create dmabuf: incompatible memory\n");
>>>>> +            return;
>>>>> +        } else if (res->dmabuf_fd >= 0) {
>>>>> +            pdata = virtio_gpu_remap_dmabuf(res, &local_err);
>>>>> +            if (!pdata) {
>>>>> +                virtio_gpu_destroy_dmabuf(res);
>>>>> +            }
>>>>> +        } else {
>>>>> +            res->dmabuf_fd = -1;
>>>>> +        }
>>>>> +
>>>>>             if (res->dmabuf_fd < 0) {
>>>>> +            error_report_err(local_err);
>>>>>                 return;
>>>>>             }
>>>>> -        virtio_gpu_remap_dmabuf(res);
>>>>> -        if (!res->remapped) {
>>>>> -            return;
>>>>> -        }
>>>>> -        pdata = res->remapped;
>>>>> +        res->remapped = pdata;
>>>>>         }
>>>>>
>>>>>         res->blob = pdata;
>>>
> 


