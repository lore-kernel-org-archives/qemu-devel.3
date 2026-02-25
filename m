Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F04E9B25A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8Tf-0005c6-BL; Wed, 25 Feb 2026 01:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vv8Td-0005bt-Fq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:34:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vv8Ta-0005lN-Bh
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:34:29 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61P6XrR6036492
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 25 Feb 2026 15:34:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=qi3HrN52qF/lSc7ilqzZSUySCUiydWvckGyYxQ2rTzU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772001258; v=1;
 b=IhFhUvvSqwBwIycGpDOTEaPKsEZOljLz0nDZ1gNzbcK8x8/CG7K/QaX7YuHTpKM4
 sfQy9HheyVyRrat4IxOH/KJE0dZvANsMDxmdZFMA33udd1IuxmhMWx69HOlm5Rcg
 3zgqtdmbgq4NixqJZHUQDru5+qznpVLQtY66irZNVlUSiF3IT/j+OhMuSFoX3f+I
 OniV8lP43SQhorsMhY4UO9z2br9LQ8ulx9kqoINWc9hI4uzCDAIdarrX8jaALLQU
 6HzGnJjeayAl0qeZnTG9V9NLTfrdnb0WTSHiqntZgZelsMupQj4/Til76b2DPPXS
 jw6b+rRKkvFc4TZcocci+A==
Message-ID: <4581f48a-5cc0-4584-a01d-0615c3bd5a71@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 25 Feb 2026 15:33:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
 <20260223080200.468558-7-vivek.kasireddy@intel.com>
 <829317cc-551b-457d-a27f-9db0fc749c52@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718522807D0371785F93337CF875A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB718522807D0371785F93337CF875A@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2026/02/25 15:04, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error
>> handling with 'Error **' and err enum
>>
>> On 2026/02/23 17:00, Vivek Kasireddy wrote:
>>> Make the error handling more robust in virtio_gpu_init_udmabuf()
>>> by introducing 'Error **' parameter to capture errors and an enum
>>> to categorize Guest and Host errors. This allows for better error
>>> reporting and handling of errors from virtio_gpu_create_udmabuf()
>>> and virtio_gpu_remap_dmabuf().
>>>
>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/virtio-gpu-dmabuf.c | 65 +++++++++++++++++++++++++---
>> ------
>>>    1 file changed, 48 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>> dmabuf.c
>>> index 8d67ef7c2a..fdcf8e53a2 100644
>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>> @@ -27,7 +27,17 @@
>>>    #include "standard-headers/linux/udmabuf.h"
>>>    #include "standard-headers/drm/drm_fourcc.h"
>>>
>>> -static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>> +typedef enum VirtIOGPUErrorType {
>>> +    VIRTIO_GPU_NO_ERROR = 0,
>>> +    /* Guest is responsible for this error */
>>> +    VIRTIO_GPU_GUEST_ERROR = 1,
>>> +    /* Host is at fault for this error */
>>> +    VIRTIO_GPU_HOST_ERROR = 2,
>>
>> include/qapi/error.h says:
>>   > - Whenever practical, also return a value that indicates success /
>>   >   failure.  This can make the error checking more concise, and can
>>   >   avoid useless error object creation and destruction.  Note that
>>   >   we still have many functions returning void.  We recommend
>>   >   . bool-valued functions return true on success / false on failure,
>>   >   . pointer-valued functions return non-null / null pointer, and
>>   >   . integer-valued functions return non-negative / negative.
>>
>> Do what it says. Non-negative if *errp is set. Negative otherwise.
> Ok, I'll change the values in the following way:
> typedef enum VirtIOGPUErrorType {
>      VIRTIO_GPU_NO_ERROR = 1,
>      /* Guest is responsible for this error */
>      VIRTIO_GPU_GUEST_ERROR = -1,
>      /* Host is at fault for this error */
>      VIRTIO_GPU_HOST_ERROR = -2,
> } VirtIOGPUErrorType;
> 
>>
>>> +} VirtIOGPUErrorType;
>>> +
>>> +static VirtIOGPUErrorType
>>> +virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
>> int *fd,
>>> +                          Error **errp)
>>>    {
>>>        g_autofree struct udmabuf_create_list *list = NULL;
>>>        RAMBlock *rb;
>>> @@ -36,7 +46,8 @@ static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>
>>>        udmabuf = udmabuf_fd();
>>>        if (udmabuf < 0) {
>>> -        return;
>>> +        error_setg(errp, "udmabuf device not available");
>>> +        return VIRTIO_GPU_HOST_ERROR;
>>>        }
>>>
>>>        list = g_malloc0(sizeof(struct udmabuf_create_list) +
>>> @@ -45,7 +56,8 @@ static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>        for (i = 0; i < res->iov_cnt; i++) {
>>>            rb = qemu_ram_block_from_host(res->iov[i].iov_base, false,
>> &offset);
>>>            if (!rb || rb->fd < 0) {
>>> -            return;
>>> +            error_setg(errp, "Could not find valid ramblock");
>>
>> It is a valid ramblock even if rb->fd < 0. It is just "incompatible"
>> with udmabuf.
> Does "IOV memory address incompatible with udmabuf " sound better?
> 
>>
>>> +            return VIRTIO_GPU_GUEST_ERROR;
>>>            }
>>>
>>>            list->list[i].memfd  = rb->fd;
>>> @@ -56,22 +68,30 @@ static void virtio_gpu_create_udmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>        list->count = res->iov_cnt;
>>>        list->flags = UDMABUF_FLAGS_CLOEXEC;
>>>
>>> -    res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>>> -    if (res->dmabuf_fd < 0) {
>>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
>>> -                    strerror(errno));
>>> +    *fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>>> +    if (*fd < 0) {
>>> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
>> failed");
>>> +        if (errno == EINVAL || errno == EBADFD) {
>>> +            return VIRTIO_GPU_GUEST_ERROR;
>>> +        }
>>> +        return VIRTIO_GPU_HOST_ERROR;
>>>        }
>>> +    return VIRTIO_GPU_NO_ERROR;
>>>    }
>>>
>>> -static void virtio_gpu_remap_dmabuf(struct
>> virtio_gpu_simple_resource *res)
>>> +static bool virtio_gpu_remap_dmabuf(struct
>> virtio_gpu_simple_resource *res,
>>> +                                    Error **errp)
>>>    {
>>> -    res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>>> -                         MAP_SHARED, res->dmabuf_fd, 0);
>>> -    if (res->remapped == MAP_FAILED) {
>>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
>>> -                    strerror(errno));
>>> +    void *map;
>>> +
>>> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
>> res->dmabuf_fd, 0);
>>> +    if (map == MAP_FAILED) {
>>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
>>>            res->remapped = NULL;
>>> +        return false;
>>>        }
>>> +    res->remapped = map;
>>> +    return true;
>>>    }
>>>
>>>    static void virtio_gpu_destroy_dmabuf(struct
>> virtio_gpu_simple_resource *res)
>>> @@ -125,19 +145,30 @@ bool virtio_gpu_have_udmabuf(void)
>>>
>>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>>>    {
>>> +    Error *local_err = NULL;
>>> +    VirtIOGPUErrorType err;
>>>        void *pdata = NULL;
>>> +    int fd;
>>>
>>>        res->dmabuf_fd = -1;
>>>        if (res->iov_cnt == 1 &&
>>>            res->iov[0].iov_len < 4096) {
>>>            pdata = res->iov[0].iov_base;
>>>        } else {
>>> -        virtio_gpu_create_udmabuf(res);
>>> -        if (res->dmabuf_fd < 0) {
>>> +        err = virtio_gpu_create_udmabuf(res, &fd, &local_err);
>>> +        if (err != VIRTIO_GPU_NO_ERROR) {
>>> +            error_prepend(&local_err, "Cannot create dmabuf: ");
>>> +            if (err == VIRTIO_GPU_GUEST_ERROR) {
>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>> +                              "Cannot create dmabuf: incompatible mem\n");
>>
>> s/mem/memory/
>>
>> The log is not that long so we can have a full correct spelling.
> It was going over the 80 char limit and I was reluctant to split it
> across lines.

scripts/checkpatch.pl explicitly allows to have a longer line for string 
literals. Priotize the user-visible behavior than keeping the code tidy.

> 
>>
>>> +            }
>>> +            error_report_err(local_err);
>>
>> This prints a message even for a guest error.
> This is intentional. My thinking is that if the user did not enable logging
> then it will fail silently in the case of Guest error. So, I thought it makes
> sense to print an error regardless of the type of error.

Do not locally override the behavior of the codebase-wide 
infrastructure. If you think a guest error needs to be logged by 
default, you should make a change to the logging infrastructure.

I also think the decision of the logging infrastructure not logging 
guest errors by default makes sense since, if you log guest errors by 
default, it will allow the guest to spam the output and can cause 
security and reliability issues.

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
>>>                return;
>>>            }
>>> -        virtio_gpu_remap_dmabuf(res);
>>> -        if (!res->remapped) {
>>> +
>>> +        res->dmabuf_fd = fd;
>>> +        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
>>> +            error_report_err(local_err);
>>>                return;
>>>            }
>>>            pdata = res->remapped;
> 


