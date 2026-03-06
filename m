Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D51F01815
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRV8-0003Te-KH; Fri, 06 Mar 2026 04:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyRV6-0003TB-Db
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:29:40 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyRV3-0001lY-PL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:29:40 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6269TQ3x064370
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Mar 2026 18:29:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4OuVxmaVR54DDooiuI8WJ8ijJebwIfcEq+SgvV86iXc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772789370; v=1;
 b=BjQkIW6JEnReOZm4kCkd79soKVt7O2r4I4jL1xGcbhxm+8IExLtz9qxO504s8ipj
 IfwQTsf/+/a83Cqjn5Fp0tTv6P3yEfYkeXvDJVluxI9adNgH9vA7vd3d8nb6+WIS
 b5wba+Nn9OBNDRg/EyVgWpPWP2mxpCji+6eyY6rtJ4IpXvJU6Li3iK15nLy7o96W
 lL8jfYCmjD8ZV6HfejgccbGB15ZVDZ8vFbW3NcVlH4ZSl/8IaJWk7xVOVekorvEU
 2kWKfaP3KaNK9LR5rkDnmccAivk/lQTHFOzjXfW4cysN3/nX1K8el3TiFKyajWm9
 OqCOs3vryM9y/20RZ5+j9Q==
Message-ID: <adfd8f81-1f65-4354-9c12-d0449f16849f@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 6 Mar 2026 18:29:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260305065700.1155146-1-vivek.kasireddy@intel.com>
 <20260305065700.1155146-11-vivek.kasireddy@intel.com>
 <6d5d1e1c-2ed3-4f2f-ac35-f7086b877fad@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185E548B48C9E6A8E4E595EF87AA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185E548B48C9E6A8E4E595EF87AA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

On 2026/03/06 16:47, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v9 10/10] virtio-gpu-dmabuf: Create dmabuf for
>> blobs associated with VFIO devices
>>
>> On 2026/03/05 15:54, Vivek Kasireddy wrote:
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
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    hw/display/virtio-gpu-dmabuf.c | 24 +++++++++++++++++++-----
>>>    1 file changed, 19 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
>> dmabuf.c
>>> index dd64fbbc2d..7f4c399416 100644
>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>> @@ -136,7 +136,7 @@ bool virtio_gpu_have_udmabuf(void)
>>>
>>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>>>    {
>>> -    Error *local_err = NULL;
>>> +    Error *local_err = NULL, *vfio_err = NULL;
>>>        void *pdata = NULL;
>>>        int ret;
>>>
>>> @@ -155,10 +155,24 @@ void virtio_gpu_init_dmabuf(struct
>> virtio_gpu_simple_resource *res)
>>>            }
>>>
>>>            if (ret == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>> -            qemu_log_mask(LOG_GUEST_ERROR,
>>> -                          "Cannot create dmabuf: incompatible memory\n");
>>> -            error_free(local_err);
>>> -            return;
>>> +            ret = vfio_device_create_dmabuf_fd(res->iov, res->iov_cnt,
>>> +                                               &vfio_err);
>>> +            if (ret > 0) {
>>
>> Zero represents a success by convention.
>>
>>> +                if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
>> &pdata,
>>> +                                            res->blob_size, &vfio_err)) {
>>> +                    error_free(local_err);
>>> +                    goto out;
>>> +                }
>>> +            }
>>> +
>>> +            if (ret == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>> +                              "Cannot create dmabuf: incompatible memory\n");
>>> +                error_free(vfio_err);
>>> +                error_free(local_err);
>>> +                return;
>>> +            }
>>> +            error_report_err(vfio_err);
>>>            }
>>>            error_report_err(local_err);
>>
>> This reports invalid IOV even when it is actually a valid pointer to
>> VFIO and the VFIO is failing. Such an error report does not help and we
>> should instead report only the VFIO error.
> I thought reporting more errors to the user made sense here in this case.

In that case we know udmabuf is doing fine but it still reports an 
error, which is misleading.

> 
>>
>> And there is another bug with the previous patch where res-
>>> dmabuf_fd is
>> invalid when virtio_gpu_remap_dmabuf() uses it.
> Yeah, I see it. Will fix it in the next version. FYI, this was the only version
> I did not test as my test environment was not available.
> 
>>
>> Below is my attempt to fix these issues:
> It is a different style and structure (compared to mine) but I guess I'll adopt
> it in the next version to get things going. I do have one comment/question below.
> 
>>
>>       if (res->iov_cnt == 1 &&
>>           res->iov[0].iov_len < 4096) {
>>           res->dmabuf_fd = -1;
>>           pdata = res->iov[0].iov_base;
>>       } else {
>>           res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
>>           if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>               error_free_or_abort(local_err);
>>
>>               res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
>>                                                             res->iov_cnt,
>>                                                             &local_err);
>>               if (res->dmabuf_fd ==
>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
>>                   res->dmabuf_fd = -1;
>>                   error_free_or_abort(local_err);
>>                   qemu_log_mask(LOG_GUEST_ERROR,
>>                                 "Cannot create dmabuf: incompatible
>> memory\n");
>>                   return;
>>               }
>>
>>               if (res->dmabuf_fd < 0 ||
>>                   !vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &pdata,
>>                                            res->blob_size, &local_err)) {
>>                   res->dmabuf_fd = -1;
> I am wondering here and in the below else if what is the benefit of setting
> res->dmabuf_fd to -1 if it is already negative? Also, if res->dmabuf_fd is
> valid (non-negative) and mmap fails, shouldn't we call virtio_gpu_destroy_dmabuf()
> to close the dmabuf fd?

Setting -1 is not strictly needed but improves consistency. You are 
right about virtio_gpu_destroy_dmabuf().

Regards,
Akihiko Odaki

> 
> Thanks,
> Vivek
> 
>>               }
>>           } else if (res->dmabuf_fd < 0 ||
>>                      !virtio_gpu_remap_dmabuf(res, &pdata, &local_err)) {
>>               res->dmabuf_fd = -1;
>>           }
>>
>>           if (res->dmabuf_fd < 0) {
>>               error_report_err(local_err);
>>               return;
>>           }
>>
>>           res->remapped = pdata;
>>       }
>>
>> Regards,
>> Akihiko Odaki
>>
>>>            return;
> 


