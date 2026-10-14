Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7629CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyi9-00005W-6c; Wed, 14 Oct 2026 09:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGyhy-0008VC-Fv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:07:50 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGyht-0003C4-Gf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:07:49 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69ED7Umn021795
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 14 Oct 2026 22:07:31 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JjW3/pCAh0G/RPOzvKqMfp6lDCOcywcZnvrbd+yqoQ0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791983251; v=1;
 b=HgHKdvXFRzQG+71zA9hJXOM5FZ8igT4+lxhaeC2cXb61E9IYsaWpj/9zklk4teiR
 oTwXrWtE4MJiPljqB6QibKrt6I4FYBTHiHiK6CdEwjNvE8sqyBYRnc7z9ykuBbrd
 ifS/tyvZhru/uGEdYUbHpd40xSuUCYBoyAGoKCRWcQIQ6IbsyzTf9RnVcNJ1F1Kp
 iIsWnmPEjvOddpsrkPSGRlTyXDA4Xv/tpl798F1pT4Um/3ZzUmGzsEB0iR6gIJDN
 BM7CFsng6tznc03Zyg+5JSmHMsJ0Nmy8SQK8WUjok3GXf16Bq1vc2Ho0lH8M7Peh
 7zn22i9O7+sXyfp7q4ROrA==
Message-ID: <3f38296f-012f-40af-807d-5979e4759015@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 14 Oct 2026 22:07:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
 <c18f2fde-5dae-45c5-a61a-8cade3ae5286@redhat.com>
 <87h5ioepb9.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <87h5ioepb9.fsf@pond.sub.org>
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

On 2026/10/14 16:03, Markus Armbruster wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> On 10/13/26 06:06, Kasireddy, Vivek wrote:
>>> Hi Akihiko,
>>>
>>>> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating
>>>> dmabuf from multiple ranges
>>>>
>>>>>>
>>>>>>> In order to create a dmabuf associated with a buffer that spans
>>>>>>> multiple ranges, we first need to identify the VFIO region and
>>>>>>> index the buffer (represented by iovec) belongs to and then
>>>>>>> translate its addresses to offsets within that region.
>>>>>>>
>>>>>>> The qemu_ram_block_from_host() API gives us both the region and
>>>>>>> the offset info we need to populate the dma ranges so that we can
>>>>>>> invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the dmabuf.
>>>>>>>
>>>>>>> Also, instead of iterating over all QOM devices to find the
>>>>>>> VFIODevice associated with a memory region, introduce a helper
>>>>>>> to just use the vfio_device_list to lookup the VFIODevice.
>>>>>>> And, introduce another helper to lookup the VFIO region given an
>>>>>>> address.
>>>>>>>
>>>>>>> Lastly, introduce an enum to return the type of error encountered
>>>>>>> while creating the dmabuf fd.
>>>>>>>
>>>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>>>> ---
>>>>>>>      include/hw/vfio/vfio-device.h |  22 +++++++
>>>>>>>      hw/vfio/device.c              | 109 ++++++++++++++++++++++++++++++++++
>>>>>>>      hw/vfio/dmabuf-stubs.c        |  17 ++++++
>>>>>>>      hw/vfio/meson.build           |   1 +
>>>>>>>      4 files changed, 149 insertions(+)
>>>>>>>      create mode 100644 hw/vfio/dmabuf-stubs.c
>>>>>>>
>>>>>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>>>>>> index 8472420d3f..c05430be8a 100644
>>>>>>> --- a/include/hw/vfio/vfio-device.h
>>>>>>> +++ b/include/hw/vfio/vfio-device.h
>>>>>>> @@ -41,6 +41,13 @@ enum {
>>>>>>>          VFIO_DEVICE_TYPE_AP = 3,
>>>>>>>      };
>>>>>>>
>>>>>>> +enum {
>>>>>>> +    /* The Guest passed addresses stored in IOV are invalid */
>>>>>>> +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
>>>>>>> +    /* Guest or Host may be at fault for this type of error */
>>>>>>> +    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
>>>>>>> +};
>>>>>>
>>>>>> Nack.
>>>>>>
>>>>>> As said a few times already : it's a VFIO-specific enum leaking
>>>>>> into vfio-device.h to serve virtio-gpu's fallback logic. The
>>>>>> cleanest alternative is to use standard -errno returns and
>>>>>> make the fd an output parameter.
>>>>> It looks like Cedric remains unconvinced about the value or usefulness
>>>>> of this error enum. Therefore, to make progress, I intend to adopt his
>>>>> suggestion to use standard -errno returns for the next version, considering
>>>>> that this series has been stuck for a year.
>>>>>
>>>>> AFAICS, dropping this error enum means that we would not be able to
>>>>> clearly identify and log (or attribute) Guest vs Host errors in virtio-gpu,
>>>>> particularly the INVALID_IOV case. I am not sure if this can be considered
>>>>> a significant limitation. However, if there is a reasonable middle ground
>>>>> solution or an alternative that you can think of that does not involve
>>>>> using VFIO error enums in virtio-gpu, then I would like to pursue that
>>>>> instead.
>>>>
>>>> Cédric's comment is a reiteration of previous points, but his concrete
>>>> code suggestion is new and brings to light some challenges with errno
>>>> propagation.
>>>>
>>>> First, errno does not precisely match the required semantics. We need
>>>> to
>>>> distinguish lookup failures from the other errors. However, with your
>>>> suggestion, lookup failures become -EINVAL and
>>>> vfio_device_get_feature()
>>>> also returns the same value when the backend lacks the operation,
>>>> making
>>>> it impossible to distinguish them.
> 
> This matters only when something actually needs to distinguish them.
> 
> If -EINVAL on lookup failure bothers you, consider -ENOENT.

-EINVAL itself is fine, but the problem is that 
vfio_device_get_feature() also returns -EINVAL.

-ENOENT would work, but I'm concerned that it might be fragile, for 
example, if called functions start returning different error codes or if 
a new function call is added in the future.

> 
>>>> Propagating errno also requires extra care to preserve it when
>>>> necessary. For patch "[PATCH v13 8/9] virtio-gpu-dmabuf: Improve error
>>>> handling with 'Error **' and err enum", you suggested to add the
>>>> "saved_errno" variable to save errno before error_setg_errno(). That is
>>>> redundant because error_setg_errno() preserves errno. Realizing that
>>>> requires careful attention.
>>>>
>>>> While we could spend effort fixing these issues, we can simply avoid the
>>>> churn by not using errno.
> 
> Two separate styles:
> 
> 1. Libc commonly sets @errno and returns a single error value.  Care may
>     indeed be necessary to preserve errno when passing errors up the
>     stack in this style.
> 
> 2. We commonly use negative errno codes as error values.  Preserving
>     @errno is a non-issue then.

It is style 1. As noted above, we actually need no additional code here 
since error_setg_errno() preserves errno, but it still requires careful 
attention to ensure correctness.

> 
>>>> In any case, I agree keeping this stuck is not ideal while I don't think
>>>> I can provide any further insights. So I'm inviting Markus Armbruster to
>>> Looks like you forgot to cc Markus. I have added him now.
>>>
>>>> this discussion. This is an area better handled by him, who maintains
>>>> the error reporting facility, including include/qapi/error.h, which
>>>> extensively documents codebase-wide error-handling convention.
>>>>
>>>> Markus, could you advise on the appropriate convention for returning
>>>> this kind of classification alongside Error **? Your perspective
>>>> across the codebase may help us settle on a consistent approach
>>>> beyond the individual subsystems involved here. Perhaps you may
>>>> improve
>>>> the documentation according to a design decision made here.
> 
> error.h indeed recommends use of negative integers as error values, but
> doesn't recommend any particular encoding.  Perhaps it should mention
> the common practice of using negative errno codes.
> 
>>> Markus, here is some additional context from Akihiko as to why there is
>>> a need to introduce an error enum in VFIO:
>>> https://lore.kernel.org/qemu-devel/09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp/
>>>
>>>>
>>>> If anyone else has a clean middle-ground solution in the meantime, I
>>>> would greatly appreciate your input as well.
>>> I am not sure if it can be considered clean or elegant but one middle-ground
>>> solution I can think of is to have (and use) the error enum just in virtio-gpu
>>> only but associate EINVAL (return value of vfio_device_create_dmabuf_fd())
>>> as the equivalent of INVALID_IOV. That is, the relevant code now becomes:
>>>           res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
>>>           if (res->dmabuf_fd == VIRTIO_GPU_DMABUF_CREATE_ERR_INVALID_IOV) {
>>>               error_free_or_abort(&local_err);
>>>               res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
>>>                                                             res->iov_cnt,
>>>                                                             &local_err);
>>>               if (res->dmabuf_fd == -EINVAL) {
>>>                   error_free_or_abort(&local_err);
>>>                   qemu_log_mask(LOG_GUEST_ERROR,
>>>                                 "Cannot create dmabuf: incompatible memory\n");
>>>                   return false;
>>>               }
>>> I think this is reasonable IMO, but is this proposal acceptable to you?
>>
>> The return value drives control flow.
>>
>> AFAICT, in virtio_gpu_init_dmabuf(), the only distinction that seems
>> to matter for control flow is : "should I try the next backend ?" and
>> that's EINVAL, which means "these addresses are incompatible with this
>> particular backend."
>>
>> The guest-vs-host attribution for logging/debugging is in the errp
>> messages :
>>
>>   - "IOV memory address incompatible with udmabuf" : guest gave addresses udmabuf can't handle
>>   - "No VFIO device found to create dmabuf from"   : guest addresses don't map to a VFIO device
>>   - "UDMABUF_CREATE_LIST: ioctl failed" + errno    :  host/kernel issue
>>
>> The Error* object is designed to encode a human-readable attribution
>> in a return value. It carries the diagnostic detail and the return
>> code carries the machine action.
> 
> Yes, this is the overwhelmingly common way to do this[*].
> 
> When all errors are handled the same, a single return value signifying
> failure suffices.  When callers need to handle different values
> differently, which is rare, we need several error values.  Negative
> errno is often convenient then.  Sometimes, it's a bad fit, so we come
> up with some other set of error codes.
> 
> Regardless, error values need to be clearly documented.
> 
> To decide what error values to use, you should start with how errors are
> handled.  Design for that.  In a library, you may not know.  But when
> you do, resist the temptation to encode all possible errors perfectly.
> KISS.  You can always make it more complicated when new callers require
> it.
> 
> Does this help?  If not, try asking pointed questions.

Thank you for the guidance. Rephrasing your points:

- Negative errno is often convenient, but an alternative set of error
   codes are used when it's a bad fit.

- KISS: encode specific error conditions to be distinguished instead 
encoding all.

This brings us to a common architectural intersection: How should a 
function handle and propagate errors when its callees return overlapping 
-errno values that require different treatment by the caller?

Both virtio_gpu_create_udmabuf() and vfio_device_create_dmabuf_fd() face 
this challenge. Evaluating the available design options against your 
advice yields the following:

1. Use custom error code enum.

Defining an enum is not as convenient as negative errno, but it is KISS; 
it encodes specific error conditions we care about:

enum {
     VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
     VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
};

static int vfio_device_create_dmabuf_fd(..., Error **errp)
{
     ...

     if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
         return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
     }

     ...

     ret = vfio_device_get_feature(vbasedev, feature);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "Could not create dmabuf fd via VFIO device");
         return VFIO_DMABUF_CREATE_ERR_UNSPEC;
     }
     return ret;
}

2. Remap -errno.

This is what Cédric suggested [1].

The negative errno values returned by internal callees do not precisely 
represent the error conditions we need to handle, making negative errno 
a "bad fit" here. However, the main issue isn't negative errno itself, 
but rather that we must handle negative errno values originating from 
different function calls. We can remap the values to resolve this:

static int vfio_device_create_dmabuf_fd(..., Error **errp)
{
     ...

     if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
         return -EINVAL;
     }

     ...

     ret = vfio_device_get_feature(vbasedev, feature);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "Could not create dmabuf fd via VFIO device");
         /*
          * Remap -EINVAL: caller uses it to mean
          * "addresses incompatible"
          */
         return (ret == -EINVAL) ? -EIO : ret;
     }
     return ret;
}

The downside is that it is not KISS; the condition to remap errno 
encodes more possible errors, but they do not matter to the current 
caller (and it coalesces error codes from vfio_device_get_feature(), 
though that is also harmless for the caller).

3. Another better idea?

[1] 
https://lore.kernel.org/qemu-devel/458252ce-c1b8-4df6-8268-4ae09cd96d56@redhat.com/

Regards,
Akihiko Odaki

> 
> 
> [...]
> 
> 
> [*] There's also the ErrorClass carried by Error objects.  It was meant
> to carry the machine action, but it turned out to be a costly failure.
> Use of error classes other than ERROR_CLASS_GENERIC_ERROR is strongly
> discouraged.


