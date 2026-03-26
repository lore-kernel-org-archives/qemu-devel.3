Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E391109E54B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5e0i-0007zW-Ed; Thu, 26 Mar 2026 02:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5e0c-0007y1-C4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:15:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5e0Y-0005ju-Jk
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:15:57 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62Q6Fkp8079800
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 26 Mar 2026 15:15:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RqDaR51bdyhAfveiktyrNwnK66F3M+NQSog/QVzqKj0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1774505746; v=1;
 b=UA2TGzOkCBk2ID7dToiwjOQgqhCTkQ3y4gsAzRvSaOhyypfzSvSoONFWn+hAvyie
 mEkpxVHB9A/VOZo3jl+bCtkUnpG0+suBBv9LQ9Jw9vv8GQfYfxLJXu+TRW7I3WNe
 23SJ/3Zvuj9n9HkZK4szbbM4ej1YSLYLPbhGgKBW6M73JOv648Nm4a5ZA7bZfzmK
 2ce22pI+BZ+h85susbWsyd+5bIs0OmDkwhPzFtyUMURMNScMoFY5sFXXqOji2GB2
 phI/3tP8itMzmrEvS38SB6GlhY6mEYCBm6pg2IkSyx9enomtBTKxAGlq9giPaqNa
 PurFafilZ8u3xJ1R3eXlDA==
Message-ID: <d235dd90-a39f-41c2-ba19-6d7ffc30ca79@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 26 Mar 2026 15:15:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-11-vivek.kasireddy@intel.com>
 <6af4e73c-4ad5-4684-9982-04276b6b7daa@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851291496AF53CF79309DAF849A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <c7ced616-2d9e-4180-ad40-c1f0d13fdc05@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177A36C95F8700D66402086F856A@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CH3PR11MB7177A36C95F8700D66402086F856A@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/03/26 14:52, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for
>> blobs associated with VFIO devices
>>
>>>>
>>>> On 2026/03/19 14:15, Vivek Kasireddy wrote:
>>>>> In addition to memfd, a blob resource can also have its backing
>>>>> storage in a VFIO device region. Since, there is no effective way
>>>>> to determine where the backing storage is located, we first try to
>>>>> create a dmabuf assuming it is in memfd. If that fails, we try to
>>>>> create a dmabuf assuming it is in VFIO device region.
>>>>>
>>>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
>>>>> backing storage is located in a memfd or not. If it is not, we invoke
>>>>> the vfio_device_create_dmabuf_fd() API which identifies the right
>>>>> VFIO device and eventually creates a dmabuf fd.
>>>>>
>>>>> Note that, for mmapping the dmabuf, we directly call mmap() if the
>>>>> dmabuf fd was created via virtio_gpu_create_udmabuf() since we
>>>> know
>>>>> that the udmabuf driver supports mmap(). However, if the dmabuf
>>>> was
>>>>> created via vfio_device_create_dmabuf_fd(), we use the
>>>>> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
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
>>>>>     hw/display/virtio-gpu-dmabuf.c | 23 ++++++++++++++++++++---
>>>>>     1 file changed, 20 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>>>> dmabuf.c
>>>>> index 89aa487654..f953db0fbe 100644
>>>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>>>> @@ -147,9 +147,26 @@ void virtio_gpu_init_dmabuf(struct
>>>> virtio_gpu_simple_resource *res)
>>>>>             if (res->dmabuf_fd ==
>>>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>>>>                 error_free_or_abort(&local_err);
>>>>>
>>>>> -            qemu_log_mask(LOG_GUEST_ERROR,
>>>>> -                          "Cannot create dmabuf: incompatible memory\n");
>>>>> -            return;
>>>>> +            res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
>>>>> +                                                          res->iov_cnt,
>>>>> +                                                          res->blob_size,
>>>>
>>>> The correspondence between (iov, iov_cnt) and blob_size is more of a
>>>> internal concern of virtio-gpu, not of VFIO. This parameter is better
>>>> removed from vfio_device_create_dmabuf_fd() and
>>>> vfio_device_mmap_dmabuf().
>>> I don't disagree. So, should we add the following check in
>>> virtio_gpu_init_dmabuf() or somewhere?
>>> if (iov_size(iov, iov_cnt) != blob_size)
>>
>> I suggest to have a check in virtio_gpu_create_mapping_iov() since it's
>> not even specific to DMA-BUF.
> I think virtio_gpu_resource_create_blob() might be a better place to put
> this check in as blob_size is relevant (or valid) only for Guest based Blob
> resources. Otherwise, we would have to pass blob_size as a new parameter
> to virtio_gpu_create_mapping_iov() and modify all the call sites.

All the call sites need to be modified since blob_size is present and 
needs to be respected at all of them. It is a chore but necessary to 
fully fix the bug Codex found, unfortunately.

Regards,
Akihiko Odaki

> 
>>
>> And instead let's ensure iov_size(iov, iov_cnt) >= blob_size and reject
>> otherwise instead. I cited Codex's reasoning for this, which I totally
>> agree. (I applied the Codex for Open Source program for access to Codex.
>> And just in case: we are currently not allowed to use LLMs for writing
>> patches and its use is restricted for the other purposes.)
>>
>> It will be also more of a bug fix, so I think it is better to be sent as
>> an independent patch instead of including it into this series.
> Ok, will send this fix as a separate patch.
> 
> Thanks,
> Vivek
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>> Below is the Codex's output based on commit 8e711856d763 ("Merge tag
>> 'hppa-fixes-for-v11-pull-request' of
>> https://github.com/hdeller/qemu-hppa into staging"):
>>
>> In current QEMU, omitting the check leaves inconsistent state possible,
>> and the effect depends on the direction of the mismatch.
>>
>> If iov_size < blob_size, this is the bad case. The dmabuf/export backing
>> is built from the iov lengths in virtio-gpu-udmabuf.c (line 45) and
>> virtio-gpu-udmabuf.c (line 63), but remap and scanout bounds use
>> blob_size in virtio-gpu-udmabuf.c (line 73) and virtio-gpu.c (line 761).
>> There is also a fast path that directly exposes iov_base as res->blob
>> for small single-iov blobs in virtio-gpu-udmabuf.c (line 136), and
>> scanout later uses that pointer as image data in virtio-gpu.c (line 662)
>> and virtio-gpu.c (line 674). So a too-small backing is not a clean or
>> obviously safe case.
>> If iov_size > blob_size, it is mostly a semantics issue. QEMU still
>> bounds scanout using blob_size in virtio-gpu.c (line 761), so the extra
>> backing is usually just unused. But the resource state is still
>> inconsistent.
>> QEMU does not currently enforce the relationship elsewhere. blob_size
>> and the iov are populated independently at blob creation in virtio-gpu.c
>> (line 362) and virtio-gpu.c (line 366), and later backing attach also
>> does not compare them in virtio-gpu.c (line 946).
>> So if the question is "can we omit the check entirely?", the answer is:
>> yes, but then you are knowingly accepting malformed guest state and
>> relying on later backend behavior. If you want a defensive check,
>> iov_size < blob_size is the one with a concrete justification. iov_size
>> != blob_size is harder to defend from the spec.
>>
>>>
>>> Thanks,
>>> Vivek
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>> +                                                          &local_err);
>>>>> +            if (res->dmabuf_fd ==
>>>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>>>> +                error_free_or_abort(&local_err);
>>>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>>>> +                              "Cannot create dmabuf: incompatible memory\n");
>>>>> +                return;
>>>>> +            }
>>>>> +
>>>>> +            if (res->dmabuf_fd >= 0) {
>>>>> +                pdata = vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
>>>>> +                                                res->blob_size, &local_err);
>>>>> +                if (!pdata) {
>>>>> +                    virtio_gpu_destroy_dmabuf(res);
>>>>> +                }
>>>>> +            } else {
>>>>> +                res->dmabuf_fd = -1;
>>>>> +            }
>>>>>             } else if (res->dmabuf_fd >= 0) {
>>>>>                 pdata = virtio_gpu_remap_dmabuf(res, &local_err);
>>>>>                 if (!pdata) {
>>>
> 


