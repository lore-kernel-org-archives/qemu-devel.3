Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBAAF55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSu3-0000sn-3q; Wed, 22 Apr 2026 04:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFStw-0000g9-Tb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFStu-0007ap-Vc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ABWnouuTkT+8bFZwDvpetpoV4T5M8mraGVmKtbpzdag=;
 b=E9fTBugrLBFKB82IUd185+3JrZE/hmTQRX6SGSMxpVt0HRDXV9XvzUyWrjh6YRFfd5B+x8
 PTRnBSVtHOsHRn5jGNOA3U83o8heNI7BcitvLHxa/l7RhGwfCdUEbJi/SyexzfahttMSyf
 aUqjg2t5DoF+x6p+wsj7ro6Yw0zwpx8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Of-UhXZGO0ax0GjWumh-eA-1; Wed, 22 Apr 2026 04:25:36 -0400
X-MC-Unique: Of-UhXZGO0ax0GjWumh-eA-1
X-Mimecast-MFC-AGG-ID: Of-UhXZGO0ax0GjWumh-eA_1776846335
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d7d0947aeso3633617f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846335; x=1777451135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ABWnouuTkT+8bFZwDvpetpoV4T5M8mraGVmKtbpzdag=;
 b=dJS7he8vDXMRkN30VxMeBLDRU5wAY7W2zwrav6HBi4B0UVku8llr4Eulj0XCwzY0IC
 dYOBNR//yZx1zF2wdcDBEcaZefT3OZborvQlJfKXfoU7YFr9/Vbmm7f8HXtfTzC5c7q9
 g4f9syOEY1mmaE0ndVyy88HVAwdVYWirbv5T38DJM+KmVSf9n6xYEISwzvyF34X0kql5
 HjRoGLXCHmobrpsn2mS+Im2pfpgs5RM8zrhBLP7bWR1RQnnoTtPKllbx61IzC8Y1pIL2
 HuoswZGQUPYt68tAaRHChx2T8thFnyEqArrjdIbNfuidloeuPxmtAYf6HG95XPElCBFb
 EGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846335; x=1777451135;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABWnouuTkT+8bFZwDvpetpoV4T5M8mraGVmKtbpzdag=;
 b=Q8f4nUiVyQUdtJaIU62iVAO5CcejlN2Bcgf1HzOtZqiriFr4b29rMDzjvexue64H2n
 tCjawLOlYKLYEUQJ0j2QAbpnX6a8cMpAgohCQyU0YdafwLH04xjGSWF8Ga3UR0IisOtA
 HYcK8BF2NgE/IatK7pkEPPghM0zE2PZvc6Xy2XveJLdWz1sNJFW05dFjJClpLYHUfy5S
 jk24xrp8NzpJmBJo+OnlCRa3vFQLKmFI0thl5vND1fu26906855MsBnXL0XjOZtCXoET
 88H1Az0WHdbicJzViPOC5wo2fV0+HAZBynvB7TSiih4NlKaUDIKl/3QlFcx3xgMAG49j
 z99A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Py+malRka9oVY08Km2cMe9RNqhTzgHIzocdoS9b3dzrIECZSRgu8PqQTFo9QyotnhCgMq0k81GVvb@nongnu.org
X-Gm-Message-State: AOJu0YyG05HixMcFzQKaWnra304jS5paMVAIg0p5Tzpq8ul0oFVwbqU8
 Qx4DbA5j+PQ+kf65cR/R8TvrfTIgDhW+znpQtqlTz80hKq5TOlu4M+yXpXWMJ6UJmT/03M4zDRH
 xFtQ9YbuBV0Gw3VByYN+LWq9g8+sKAgwT+AJnOJC9+0IVGse26b2IVmRS
X-Gm-Gg: AeBDietq2tNTV278/E9a7N7FNnM+Wr2dgBMah8hCJsQIOor+wx7J+lL5syJ4NbR4ffl
 zGDXJup/RYXS/yj8XueLHvmCqmMd2xEV34xaXzUpGn0wgtZ6FK+awQNnOae7ylwc6IbW8o93Ez5
 /ZujSK2aojNwlVk3b8i2zanlga30txC1pciF7hc179YCb8X9e48r5Uen+HROVP3sLE/o1zTs4lr
 3nROVFa+UMsWdhPmGvwYdGGj63GszBUSr7LmDuudVG/a/spumxVhN5/1/Pm/RNlQBKuuyyK9M0g
 TjRUep8iPHIAdvtO+RYyZiHbxZxZxtRxAMq+xw8rI1111Ucx5m2rCV+dOBbICuorZGD3WBgGyel
 7VFd+kh3BBa4H2ds084KQdBWBJco/0vk8APjItgSRd9rjZSLVl5LLf411oSXQMMDqZNyLQGA=
X-Received: by 2002:a05:6000:258a:b0:441:2381:b630 with SMTP id
 ffacd0b85a97d-4412381b6dfmr5225899f8f.24.1776846335116; 
 Wed, 22 Apr 2026 01:25:35 -0700 (PDT)
X-Received: by 2002:a05:6000:258a:b0:441:2381:b630 with SMTP id
 ffacd0b85a97d-4412381b6dfmr5225849f8f.24.1776846334595; 
 Wed, 22 Apr 2026 01:25:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm43558498f8f.16.2026.04.22.01.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:25:34 -0700 (PDT)
Message-ID: <e09e7494-8261-4ad3-a0c1-6dd41c163961@redhat.com>
Date: Wed, 22 Apr 2026 10:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA0PR11MB7185F5B516E3FAC39290B6A0F8232@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 4/16/26 08:31, Kasireddy, Vivek wrote:
> Hi Cedric,
> 
>> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
>> handling with 'Error **' and err enum
>>
>> On 2026/03/25 14:31, Kasireddy, Vivek wrote:
>>> Hi Akihiko,
>>>
>>>> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
>>>> handling with 'Error **' and err enum
>>>>>>
>>>>>> On 3/19/26 06:15, Vivek Kasireddy wrote:
>>>>>>> Make the error handling more robust in
>> virtio_gpu_init_udmabuf()
>>>>>>> by introducing 'Error **' parameter to capture errors and using
>>>>>>> an enum from VFIO to categorize different errors. This allows for
>>>>>>> better error reporting and handling of errors from
>>>>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
>>>>>>>
>>>>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>>>> ---
>>>>>>>      hw/display/virtio-gpu-dmabuf.c | 67
>> +++++++++++++++++++++++--
>>>> -----
>>>>>> ----
>>>>>>>      1 file changed, 45 insertions(+), 22 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
>> gpu-
>>>>>> dmabuf.c
>>>>>>> index e35f7714a9..89aa487654 100644
>>>>>>> --- a/hw/display/virtio-gpu-dmabuf.c
>>>>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
>>>>>>> @@ -18,6 +18,7 @@
>>>>>>>      #include "ui/console.h"
>>>>>>>      #include "hw/virtio/virtio-gpu.h"
>>>>>>>      #include "hw/virtio/virtio-gpu-pixman.h"
>>>>>>> +#include "hw/vfio/vfio-device.h"
>>>>>>>      #include "trace.h"
>>>>>>>      #include "system/ramblock.h"
>>>>>>>      #include "system/hostmem.h"
>>>>>>> @@ -27,16 +28,18 @@
>>>>>>>      #include "standard-headers/linux/udmabuf.h"
>>>>>>>      #include "standard-headers/drm/drm_fourcc.h"
>>>>>>>
>>>>>>> -static void virtio_gpu_create_udmabuf(struct
>>>>>> virtio_gpu_simple_resource *res)
>>>>>>> +static int virtio_gpu_create_udmabuf(struct
>>>>>> virtio_gpu_simple_resource *res,
>>>>>>> +                                     Error **errp)
>>>>>>>      {
>>>>>>>          g_autofree struct udmabuf_create_list *list = NULL;
>>>>>>>          RAMBlock *rb;
>>>>>>>          ram_addr_t offset;
>>>>>>> -    int udmabuf, i;
>>>>>>> +    int udmabuf, i, fd;
>>>>>>>
>>>>>>>          udmabuf = udmabuf_fd();
>>>>>>>          if (udmabuf < 0) {
>>>>>>> -        return;
>>>>>>> +        error_setg(errp, "udmabuf device not available or
>> enabled");
>>>>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>>>>>>
>>>>>> The function virtio_gpu_create_udmabuf() is returning
>>>> VFIO_DMABUF_*
>>>>>> enum
>>>>>> values, which is problematic because the function creates a
>>>> udmabuf,
>>>>>> not
>>>>>> a VFIO dmabuf.
>>>>>>
>>>>>> This creates a layering violation. The virtio-gpu-dmabuf code
>> (which
>>>>>> handles both udmabuf and VFIO dmabuf creation) is using error
>>>> codes
>>>>>> defined in the VFIO-specific header.
>>>>
>>>> The rationale of using error codes is as follows:
>>>>
>>>>    > In that case, using it for udmabuf is cheating, but I think it's fine
>>>>    > since it's locally-contained in virtio-gpu-dmabuf.c, its intent is
>>>>    > still clear, and it has no adverse effect for users (at least there
>>>>    > will be no bug).
>>>>
>>>> https://lore.kernel.org/qemu-devel/becde56b-90bd-40ca-9329-
>>>> 0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp/
>>>>
>>>>>>
>>>>>> Please find another solution.
>>>>> Other solutions I can think of are either move these error enums
>> into
>>>> virtio-gpu
>>>>> (and disregard the error return type from vfio) or move them to
>> some
>>>> other header
>>>>> where they are visible to both virtio-gpu and vfio. I'd like hear
>>>> Akihiko's thoughts/
>>>>> comments on how to proceed given that he had reviewed virtio-gpu
>>>> patches in
>>>>> this series.
>>>>
>>>> Disregarding the error conditions of VFIO is not OK. That can cause a
>>>> guest error to be reported as a host error.
>>>>
>>>> I think the simplest alternative is just to have a duplicate enum for
>>>> virtio-gpu.
>>> That would address the layering violation but Cedric's other concern is
>>> that he believes having errp is sufficient and using these error enums
>> in
>>> VFIO would be overkill.
>>
>> It would be beneficial to describe the rationale behind the enums; the
>> patch message only says "better error reporting", which is quite
>> insufficient.
>>
>> The rationale is that we need a special handling for the INVALID_IOV
>> case. The INVALID_IOV case can happen in two cases:
>> - The memory is backed by VFIO. It will result in the INVALID_IOV error
>>     for the first attempt to use udmabuf, but this error can be properly
>>     recovered by letting the VFIO code to create a DMA-BUF instead.
>> - The memory is not backed by memfd nor VFIO. In this case, the error
>>     is a guest's fault, so we should:
>>     - Use qemu_log_mask(LOG_GUEST_ERROR, ...) instead of
>>       error_report_err().
>>     - Emit a message useful to diagnose the guest error, which we have
>>       discussed in this thread.
>>
>> A common pattern is to return -errno to let the caller implement a
>> special error handling, but in this case we specifically need to
>> distinguish the INVALID_IOV case from the others and these enums are
>> more convenient for this.
> With the addition of the above rationale provided by Akihiko as to why these
> enums are needed in VFIO, would this solution (having duplicate enums in
> virtio-gpu that mimic VFIO's enums behavior to address layering violation)
> be acceptable to you?

If the new version of the series reintroduces the enums in VFIO,
expect me to complain :) So, no error enum please.


May be the iov API is not adequate for this purpose :

   int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
                                    size_t total_size, Error **errp);
   void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int iov_cnt,
                                 size_t total_size, Error **errp);

or the part validating the iov should be done before calling into
VFIO:

     if (iov_size(iov, iov_cnt) != total_size) {
         error_setg(errp, "Total size of iov does not match dmabuf size\n");
         return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
     }

     if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
         return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
     }

     for (i = 0; i < iov_cnt; i++) {
         if (!vfio_region_lookup(iov[i].iov_base, &region,
                                 first_rb, &offset, errp)) {
             return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
         }
     }

Thanks,

C.


