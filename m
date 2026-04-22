Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CCAF9B5F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTk6-00025y-5D; Wed, 22 Apr 2026 05:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFTk2-00025Q-FU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:19:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFTjv-0005dT-Gk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 05:19:26 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63M9JDit071759
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 22 Apr 2026 18:19:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8uuBCxRp38nhEdaOYBBq4h4erTkTTzzLt8aLUx5kKpw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1776849553; v=1;
 b=kkylVDrjqc/vzFFmmZWhb91JtSmfn9DX3gQZlN2+vujKcXycYRHfMoQdn7tKX6Ak
 kU4UrICiCd3El8Hnk2IxkR6zaqHng0C1a30Xl6RE8S6eU2/IMpL38laY2Yk3b2Kx
 yq4FXggCkdoz1J2XPR10UacL9MdNYmWAm5uySTM40lUK8V3IyZeAXNVGmsr/O0U/
 N7IQ35f7/9nnFjp97R0ZdCwAEoaQKipCRhRPOH9ittEPB0W33rQq/tzObMNy0GQW
 j1lNc+4ZA+g+18ISyhG41jSAuibqXVMS1ENymgAA4a76st6PPfIG56SlbLx27LWJ
 IY39DRnCa2CzvbidzRP/Gg==
Message-ID: <2a5817c4-cb61-4867-9bdd-fbe68cf5601e@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 22 Apr 2026 18:19:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
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
 <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F5B516E3FAC39290B6A0F8232@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e09e7494-8261-4ad3-a0c1-6dd41c163961@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <e09e7494-8261-4ad3-a0c1-6dd41c163961@redhat.com>
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

On 2026/04/22 17:25, Cédric Le Goater wrote:
> On 4/16/26 08:31, Kasireddy, Vivek wrote:
>> Hi Cedric,
>>
>>> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
>>> handling with 'Error **' and err enum
>>>
>>> On 2026/03/25 14:31, Kasireddy, Vivek wrote:
>>>> Hi Akihiko,
>>>>
>>>>> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
>>>>> handling with 'Error **' and err enum
>>>>>>>
>>>>>>> On 3/19/26 06:15, Vivek Kasireddy wrote:
>>>>>>>> Make the error handling more robust in
>>> virtio_gpu_init_udmabuf()
>>>>>>>> by introducing 'Error **' parameter to capture errors and using
>>>>>>>> an enum from VFIO to categorize different errors. This allows for
>>>>>>>> better error reporting and handling of errors from
>>>>>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
>>>>>>>>
>>>>>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>>>>> ---
>>>>>>>>      hw/display/virtio-gpu-dmabuf.c | 67
>>> +++++++++++++++++++++++--
>>>>> -----
>>>>>>> ----
>>>>>>>>      1 file changed, 45 insertions(+), 22 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
>>> gpu-
>>>>>>> dmabuf.c
>>>>>>>> index e35f7714a9..89aa487654 100644
>>>>>>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>>>>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>>>>>>> @@ -18,6 +18,7 @@
>>>>>>>>      #include "ui/console.h"
>>>>>>>>      #include "hw/virtio/virtio-gpu.h"
>>>>>>>>      #include "hw/virtio/virtio-gpu-pixman.h"
>>>>>>>> +#include "hw/vfio/vfio-device.h"
>>>>>>>>      #include "trace.h"
>>>>>>>>      #include "system/ramblock.h"
>>>>>>>>      #include "system/hostmem.h"
>>>>>>>> @@ -27,16 +28,18 @@
>>>>>>>>      #include "standard-headers/linux/udmabuf.h"
>>>>>>>>      #include "standard-headers/drm/drm_fourcc.h"
>>>>>>>>
>>>>>>>> -static void virtio_gpu_create_udmabuf(struct
>>>>>>> virtio_gpu_simple_resource *res)
>>>>>>>> +static int virtio_gpu_create_udmabuf(struct
>>>>>>> virtio_gpu_simple_resource *res,
>>>>>>>> +                                     Error **errp)
>>>>>>>>      {
>>>>>>>>          g_autofree struct udmabuf_create_list *list = NULL;
>>>>>>>>          RAMBlock *rb;
>>>>>>>>          ram_addr_t offset;
>>>>>>>> -    int udmabuf, i;
>>>>>>>> +    int udmabuf, i, fd;
>>>>>>>>
>>>>>>>>          udmabuf = udmabuf_fd();
>>>>>>>>          if (udmabuf < 0) {
>>>>>>>> -        return;
>>>>>>>> +        error_setg(errp, "udmabuf device not available or
>>> enabled");
>>>>>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>>>>>>>
>>>>>>> The function virtio_gpu_create_udmabuf() is returning
>>>>> VFIO_DMABUF_*
>>>>>>> enum
>>>>>>> values, which is problematic because the function creates a
>>>>> udmabuf,
>>>>>>> not
>>>>>>> a VFIO dmabuf.
>>>>>>>
>>>>>>> This creates a layering violation. The virtio-gpu-dmabuf code
>>> (which
>>>>>>> handles both udmabuf and VFIO dmabuf creation) is using error
>>>>> codes
>>>>>>> defined in the VFIO-specific header.
>>>>>
>>>>> The rationale of using error codes is as follows:
>>>>>
>>>>>    > In that case, using it for udmabuf is cheating, but I think 
>>>>> it's fine
>>>>>    > since it's locally-contained in virtio-gpu-dmabuf.c, its 
>>>>> intent is
>>>>>    > still clear, and it has no adverse effect for users (at least 
>>>>> there
>>>>>    > will be no bug).
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/becde56b-90bd-40ca-9329-
>>>>> 0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp/
>>>>>
>>>>>>>
>>>>>>> Please find another solution.
>>>>>> Other solutions I can think of are either move these error enums
>>> into
>>>>> virtio-gpu
>>>>>> (and disregard the error return type from vfio) or move them to
>>> some
>>>>> other header
>>>>>> where they are visible to both virtio-gpu and vfio. I'd like hear
>>>>> Akihiko's thoughts/
>>>>>> comments on how to proceed given that he had reviewed virtio-gpu
>>>>> patches in
>>>>>> this series.
>>>>>
>>>>> Disregarding the error conditions of VFIO is not OK. That can cause a
>>>>> guest error to be reported as a host error.
>>>>>
>>>>> I think the simplest alternative is just to have a duplicate enum for
>>>>> virtio-gpu.
>>>> That would address the layering violation but Cedric's other concern is
>>>> that he believes having errp is sufficient and using these error enums
>>> in
>>>> VFIO would be overkill.
>>>
>>> It would be beneficial to describe the rationale behind the enums; the
>>> patch message only says "better error reporting", which is quite
>>> insufficient.
>>>
>>> The rationale is that we need a special handling for the INVALID_IOV
>>> case. The INVALID_IOV case can happen in two cases:
>>> - The memory is backed by VFIO. It will result in the INVALID_IOV error
>>>     for the first attempt to use udmabuf, but this error can be properly
>>>     recovered by letting the VFIO code to create a DMA-BUF instead.
>>> - The memory is not backed by memfd nor VFIO. In this case, the error
>>>     is a guest's fault, so we should:
>>>     - Use qemu_log_mask(LOG_GUEST_ERROR, ...) instead of
>>>       error_report_err().
>>>     - Emit a message useful to diagnose the guest error, which we have
>>>       discussed in this thread.
>>>
>>> A common pattern is to return -errno to let the caller implement a
>>> special error handling, but in this case we specifically need to
>>> distinguish the INVALID_IOV case from the others and these enums are
>>> more convenient for this.
>> With the addition of the above rationale provided by Akihiko as to why 
>> these
>> enums are needed in VFIO, would this solution (having duplicate enums in
>> virtio-gpu that mimic VFIO's enums behavior to address layering 
>> violation)
>> be acceptable to you?
> 
> If the new version of the series reintroduces the enums in VFIO,
> expect me to complain :) So, no error enum please.
> 
> 
> May be the iov API is not adequate for this purpose :
> 
>    int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int 
> iov_cnt,
>                                     size_t total_size, Error **errp);
>    void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
>                                  size_t total_size, Error **errp);
> 
> or the part validating the iov should be done before calling into
> VFIO:
> 
>      if (iov_size(iov, iov_cnt) != total_size) {
>          error_setg(errp, "Total size of iov does not match dmabuf 
> size\n");
>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>      }

The value of the "total_size" parameter is actually an internal state of 
virtio-gpu so I have suggested to move the check to virtio-gpu and 
remove the parameter.

> 
>      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>      }
> 
>      for (i = 0; i < iov_cnt; i++) {
>          if (!vfio_region_lookup(iov[i].iov_base, &region,
>                                  first_rb, &offset, errp)) {
>              return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>          }
>      }

The remaining checks, however, are VFIO-specific. `vfio_device_lookup()`
and `vfio_region_lookup()` translate the HVA/RAMBlock information into a
VFIO device/region, so moving them into virtio-gpu would require 
virtio-gpu to know about VFIO device/region internals.

Regards,
Akihiko Odaki

