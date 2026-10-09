Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869FDCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF7GF-0004fp-Le; Fri, 09 Oct 2026 05:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xF7G9-0004fI-9z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:51:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xF7G5-0004tP-3y
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:51:25 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6999pEA0028884
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 9 Oct 2026 18:51:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=izYIcmETjMVhNCW9oyvy4vwnaMH7LPdepk5JJ7xFk0A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791539474; v=1;
 b=HDbgBbhe2YViSK7X291xlndURTZYtcGci5zs+vWpSm90Y4i1qJpepyiUgK2PccV+
 CA71+fRsKipam7JOLAH98RRXl02SVzP4gBg/l2jCmzcHh9eju0DKn29aZ3wjYEDb
 Jijh/OIVeb0WSHIMlWlmI7vSGloorivy0fdre3IstAUfaGLXAmCQjO/fVg9Cijer
 b9q62G8xA7EuRYuP4KpVptkC78FYYgVvKb5Q/1GcUyDaf6+09KKZMHC6Ciq9IMgT
 Gql5s51RIePP1lm+6314xMe9hbBifb1ym5B98c0KmKKwMHSCI97+OBrRDif+/P1g
 pORDtiKLRYSLUagmMAZaiQ==
Message-ID: <7bd99ac0-b126-43b4-870a-9211914a9701@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 9 Oct 2026 18:51:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-10-vivek.kasireddy@intel.com>
 <b87b6288-4226-442e-8802-d9bf31f5a7dd@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71857E6DC18C3B4B74CE235EF8922@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB71857E6DC18C3B4B74CE235EF8922@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On 2026/10/09 13:26, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for
>> blobs associated with VFIO devices
>>
>> On 2026/10/08 5:09, Vivek Kasireddy wrote:
>>> In addition to memfd, a blob resource can also have its backing
>>> storage in a VFIO device region. Since, there is no effective way
>>> to determine where the backing storage is located, we first try to
>>> create a dmabuf assuming it is in memfd. If that fails, we try to
>>> create a dmabuf assuming it is in VFIO device region.
>>>
>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
>>> backing storage is located in a memfd or not. If it is not, we invoke
>>> the vfio_device_create_dmabuf_fd() API which identifies the right
>>> VFIO device and eventually creates a dmabuf fd.
>>>
>>> Note that, for mmapping the dmabuf, we directly call mmap() if the
>>> dmabuf fd was created via virtio_gpu_create_udmabuf() since we
>> know
>>> that the udmabuf driver supports mmap(). However, if the dmabuf
>> was
>>> created via vfio_device_create_dmabuf_fd(), we use the
>>> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
>>>
>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/virtio-gpu-dmabuf.c | 22 +++++++++++++++++++---
>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>> dmabuf.c
>>> index c9de8e9ba3..f59a5e76ff 100644
>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>> @@ -153,9 +153,25 @@ bool virtio_gpu_init_dmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>            if (res->dmabuf_fd ==
>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>>                error_free_or_abort(&local_err);
>>>
>>> -            qemu_log_mask(LOG_GUEST_ERROR,
>>> -                          "Cannot create dmabuf: incompatible memory\n");
>>> -            return false;
>>> +            res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
>>> +                                                          res->iov_cnt,
>>> +                                                          &local_err);
>>> +            if (res->dmabuf_fd ==
>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>> +                error_free_or_abort(&local_err);
>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>> +                              "Cannot create dmabuf: incompatible memory\n");
>>> +                return false;
>>> +            }
>>> +
>>> +            if (res->dmabuf_fd >= 0) {
>>> +                pdata = vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
>>> +                                                &local_err);
>>
>> This maps the complete IOV size, while virtio_gpu_fini_dmabuf()
>> unmaps
>> only blob_size. Create and attach accept backing larger than the blob,
>> so excess pages remain mapped after detach, unref or reset.
> Good catch. I'll add a check in virtio_gpu_fini_dmabuf() to determine if
> IOV size > blob_size, then do munmap(res->remapped, IOV size);
> I think this should be safe even if the mapping (created with mmap)
> size is blob_size. Or, is there a better solution you can think of such as
> tracking the exact mapping size in res object?

Unmapping the IOV size is not safe if only blob_size was mapped: 
munmap() can also remove unrelated mappings in the excess range.

A cleaner fix is to update vfio_device_mmap_dmabuf() to take the size to 
map (or cap it to blob_size). This keeps it symmetric with the udmabuf 
path and allows virtio_gpu_fini_dmabuf() to continue unmapping blob_size 
without needing extra tracking variables.

Regards,
Akihiko Odaki

> 
> Thanks,
> Vivek
>>
>> Regards,
>> Akihiko Odaki
>>
>>> +                if (!pdata) {
>>> +                    virtio_gpu_fini_dmabuf(res);
>>> +                }
>>> +            } else {
>>> +                res->dmabuf_fd = -1;
>>> +            }
>>>            } else if (res->dmabuf_fd >= 0) {
>>>                pdata = virtio_gpu_remap_dmabuf(res, &local_err);
>>>                if (!pdata) {
> 


