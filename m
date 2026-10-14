Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA09FCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGoZE-0007yf-5o; Tue, 13 Oct 2026 22:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGoZB-0007yH-AK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 22:18:05 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGoZ7-00034V-MV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 22:18:05 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69E2HmJc040518
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 14 Oct 2026 11:17:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=iyC9r5fTaIJdjaUYqwQJXMSKSxslLmYbqtL3QgUkl5I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791944268; v=1;
 b=NjSA52LGg+EHuxy4VWJ1SVoqohrOvEythLRYF8pu/uGbyS7ddOXL+2teS/+vxHm+
 MCkIHJbNBVv0Xhp9AhtGHgdCWzXldOy3UUQik+2Ceag5VbiDxdgZ4Ie1QzCZw04y
 VwWUm1yQYObdfYyJyFWEz6qSUPkQ8iCmPhj30A24v9AQ9V4TnCClklZKoXWvSHJS
 aydxhQ10uL+lwXz4ppE9gRso8FMia0+WcpNapOL1C4ji+qEOmZmD2t+bsrl7Gg3O
 YtQN9qHC7+2CMPcwL/N20Knm60iuC0XamZ5DpQnthu1xoVrR3FeFoHZLgZJAaK86
 ZyIxLkc8aMGC1tf370G+OQ==
Message-ID: <12afec43-1da5-4326-9395-73441effe9c6@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 14 Oct 2026 11:17:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
 <c18f2fde-5dae-45c5-a61a-8cade3ae5286@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c18f2fde-5dae-45c5-a61a-8cade3ae5286@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/10/14 1:20, Cédric Le Goater wrote:
> On 10/13/26 06:06, Kasireddy, Vivek wrote:
>> Hi Akihiko,
>>
>>> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating
>>> dmabuf from multiple ranges
>>>
>>>>>
>>>>>> In order to create a dmabuf associated with a buffer that spans
>>>>>> multiple ranges, we first need to identify the VFIO region and
>>>>>> index the buffer (represented by iovec) belongs to and then
>>>>>> translate its addresses to offsets within that region.
>>>>>>
>>>>>> The qemu_ram_block_from_host() API gives us both the region and
>>>>>> the offset info we need to populate the dma ranges so that we can
>>>>>> invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
>>>>> dmabuf.
>>>>>>
>>>>>> Also, instead of iterating over all QOM devices to find the
>>>>>> VFIODevice associated with a memory region, introduce a helper
>>>>>> to just use the vfio_device_list to lookup the VFIODevice.
>>>>>> And, introduce another helper to lookup the VFIO region given an
>>>>>> address.
>>>>>>
>>>>>> Lastly, introduce an enum to return the type of error encountered
>>>>>> while creating the dmabuf fd.
>>>>>>
>>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>>> ---
>>>>>>     include/hw/vfio/vfio-device.h |  22 +++++++
>>>>>>     hw/vfio/device.c              | 109
>>> ++++++++++++++++++++++++++++++++++
>>>>>>     hw/vfio/dmabuf-stubs.c        |  17 ++++++
>>>>>>     hw/vfio/meson.build           |   1 +
>>>>>>     4 files changed, 149 insertions(+)
>>>>>>     create mode 100644 hw/vfio/dmabuf-stubs.c
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
>>>>> device.h
>>>>>> index 8472420d3f..c05430be8a 100644
>>>>>> --- a/include/hw/vfio/vfio-device.h
>>>>>> +++ b/include/hw/vfio/vfio-device.h
>>>>>> @@ -41,6 +41,13 @@ enum {
>>>>>>         VFIO_DEVICE_TYPE_AP = 3,
>>>>>>     };
>>>>>>
>>>>>> +enum {
>>>>>> +    /* The Guest passed addresses stored in IOV are invalid */
>>>>>> +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
>>>>>> +    /* Guest or Host may be at fault for this type of error */
>>>>>> +    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
>>>>>> +};
>>>>>
>>>>> Nack.
>>>>>
>>>>> As said a few times already : it's a VFIO-specific enum leaking
>>>>> into vfio-device.h to serve virtio-gpu's fallback logic. The
>>>>> cleanest alternative is to use standard -errno returns and
>>>>> make the fd an output parameter.
>>>> It looks like Cedric remains unconvinced about the value or usefulness
>>>> of this error enum. Therefore, to make progress, I intend to adopt his
>>>> suggestion to use standard -errno returns for the next version,
>>> considering
>>>> that this series has been stuck for a year.
>>>>
>>>> AFAICS, dropping this error enum means that we would not be able to
>>>> clearly identify and log (or attribute) Guest vs Host errors in 
>>>> virtio-gpu,
>>>> particularly the INVALID_IOV case. I am not sure if this can be
>>> considered
>>>> a significant limitation. However, if there is a reasonable middle
>>> ground
>>>> solution or an alternative that you can think of that does not involve
>>>> using VFIO error enums in virtio-gpu, then I would like to pursue that
>>>> instead.
>>>
>>> Cédric's comment is a reiteration of previous points, but his concrete
>>> code suggestion is new and brings to light some challenges with errno
>>> propagation.
>>>
>>> First, errno does not precisely match the required semantics. We need
>>> to
>>> distinguish lookup failures from the other errors. However, with your
>>> suggestion, lookup failures become -EINVAL and
>>> vfio_device_get_feature()
>>> also returns the same value when the backend lacks the operation,
>>> making
>>> it impossible to distinguish them.
>>>
>>> Propagating errno also requires extra care to preserve it when
>>> necessary. For patch "[PATCH v13 8/9] virtio-gpu-dmabuf: Improve error
>>> handling with 'Error **' and err enum", you suggested to add the
>>> "saved_errno" variable to save errno before error_setg_errno(). That is
>>> redundant because error_setg_errno() preserves errno. Realizing that
>>> requires careful attention.
>>>
>>> While we could spend effort fixing these issues, we can simply avoid the
>>> churn by not using errno.
>>>
>>> In any case, I agree keeping this stuck is not ideal while I don't think
>>> I can provide any further insights. So I'm inviting Markus Armbruster to
>> Looks like you forgot to cc Markus. I have added him now.
>>
>>> this discussion. This is an area better handled by him, who maintains
>>> the error reporting facility, including include/qapi/error.h, which
>>> extensively documents codebase-wide error-handling convention.
>>>
>>> Markus, could you advise on the appropriate convention for returning
>>> this kind of classification alongside Error **? Your perspective
>>> across the codebase may help us settle on a consistent approach
>>> beyond the individual subsystems involved here. Perhaps you may
>>> improve
>>> the documentation according to a design decision made here.
>> Markus, here is some additional context from Akihiko as to why there is
>> a need to introduce an error enum in VFIO:
>> https://lore.kernel.org/qemu- 
>> devel/09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp/
>>
>>>
>>> If anyone else has a clean middle-ground solution in the meantime, I
>>> would greatly appreciate your input as well.
>> I am not sure if it can be considered clean or elegant but one middle- 
>> ground
>> solution I can think of is to have (and use) the error enum just in 
>> virtio-gpu
>> only but associate EINVAL (return value of 
>> vfio_device_create_dmabuf_fd())
>> as the equivalent of INVALID_IOV. That is, the relevant code now becomes:
>>
>>          res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
>>          if (res->dmabuf_fd == 
>> VIRTIO_GPU_DMABUF_CREATE_ERR_INVALID_IOV) {
>>              error_free_or_abort(&local_err);
>>
>>              res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
>>                                                            res->iov_cnt,
>>                                                            &local_err);
>>              if (res->dmabuf_fd == -EINVAL) {
>>                  error_free_or_abort(&local_err);
>>                  qemu_log_mask(LOG_GUEST_ERROR,
>>                                "Cannot create dmabuf: incompatible 
>> memory\n");
>>                  return false;
>>              }
>>
>> I think this is reasonable IMO, but is this proposal acceptable to you?
> 
> The return value drives control flow.
> 
> AFAICT, in virtio_gpu_init_dmabuf(), the only distinction that seems
> to matter for control flow is : "should I try the next backend ?" and
> that's EINVAL, which means "these addresses are incompatible with this
> particular backend."
> 
> The guest-vs-host attribution for logging/debugging is in the errp
> messages :
> 
>   - "IOV memory address incompatible with udmabuf" : guest gave 
> addresses udmabuf can't handle
>   - "No VFIO device found to create dmabuf from"   : guest addresses 
> don't map to a VFIO device
>   - "UDMABUF_CREATE_LIST: ioctl failed" + errno    :  host/kernel issue
> 
> The Error* object is designed to encode a human-readable attribution
> in a return value. It carries the diagnostic detail and the return
> code carries the machine action.
> 
> Now the flow,
> 
>    udmabuf
>      ├─ -EINVAL ──► VFIO
>      │                ├─ >= 0 ──► vfio_device_mmap_dmabuf ──► success
>      │                ├─ -EINVAL ──► guest error: incompatible memory
>      │                └─ other -errno ──► error_report_err ──► host error
>      │
>      ├─ >= 0 ──► virtio_gpu_remap_dmabuf ──► success
>      │
>      ├─ -ENODEV ──► error_report_err ──► fail (VFIO NOT tried)
>      ├─ -ENOMEM ──► error_report_err ──► fail (VFIO NOT tried)
>      └─ other -errno ──► error_report_err ──► fail (VFIO NOT tried)
> 
> 
> The fallback trigger should be widen to -EINVAL || -ENODEV.
> 
> How's that ?

Choosing between qemu_log_mask(LOG_GUEST_ERROR, ...) and
error_report_err() is also a machine decision. The caller needs to
distinguish incompatible backing from other failures to select the
reporting path; human-readable attribution in Error * is insufficient.

The -EINVAL ambiguity therefore remains. vfio_device_get_feature()
also returns -EINVAL when the backend lacks the operation. If we
propagate that unchanged, your diagram classifies it as incompatible
guest memory. Using -EINVAL for that classification requires an
explicit mapping that keeps these other failures distinct.

Regarding -ENODEV, virtio_gpu_device_realize() already requires
virtio_gpu_have_udmabuf() for this blob path. udmabuf_fd() caches the
opened fd, so the availability-related -ENODEV should not occur
after successful realization.

Regards,
Akihiko Odaki

