Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22293CA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 07:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy3dV-0008Qr-Qy; Mon, 15 Sep 2025 03:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy3dM-0008Pw-Fr
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:28:21 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy3dC-0001Gj-QI
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:28:20 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58F7RiHu017845
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Sep 2025 16:27:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=W1pRs3VTa9X252Grall8l13aqBaVEu0moyKS3NmsQmk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1757921264; v=1;
 b=Y4NTU2drahiflOn6poWy4BhvGBCsi7+FUfXeTCan4gr4uvAS0B3sZ8akyAN2tfNG
 q7sjhJR4sJcrrUASgqD9J9KH9RmPHdE1s+gI0CEGaGsSlwV4LS9gO5pSG2LRe07s
 r9k4SA6i0zum60D35LUXwlqwNVTNA0YKWZI3AyaVMJPxuEzJLpyC2cw6YsF4gr1G
 9OLLw+IQYLVRDlbOze1RXkLKpP5KX0IP94vnvr1h2GK5AgWr1x390T95uKHGBC0Q
 0Moz6uuewMjhHhqNeEkrXV79kSRYFh7O9Ro8o3oZ1jxCn2N36dqawRc6S2sGQVA/
 TUAJFZXTPPnnCLu7Ho9aAw==
Message-ID: <d107e7d4-f5cc-4714-b5f7-cd7d9a35dd6d@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Sep 2025 16:27:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-5-vivek.kasireddy@intel.com>
 <26c02124-eb57-4d50-bf8d-1fa809984adc@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185758D6CD5D2774E6373BBF80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <43a98363-0607-42c6-906b-4f79e5740ea8@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185329E174E270F6911FF03F815A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB7185329E174E270F6911FF03F815A@IA0PR11MB7185.namprd11.prod.outlook.com>
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/09/15 15:33, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
>> resources
>>
>> On 2025/09/13 11:48, Kasireddy, Vivek wrote:
>>> Hi Akihiko,
>>>
>>>> Subject: Re: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
>>>> resources
>>>>
>>>> On 2025/09/03 7:42, Vivek Kasireddy wrote:
>>>>> The res->blob pointer is only valid for blobs that have their
>>>>> backing storage in memfd. Therefore, we cannot use it to determine
>>>>> if a resource is a blob or not. Instead, we could use res->blob_size
>>>>> to make this determination as it is non-zero for blob resources
>>>>> regardless of where their backing storage is located.
>>>>
>>>> I guess this change needs to be applied before "[RFC 3/6]
>>>> virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
>>>> devices"; without this patch, the "create dmabuf" patch will probably
>>>> create an invalid blob.
>>> Ok, makes sense. I'll move it earlier in the patch series.
>>>
>>>>
>>>>>
>>>>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>> ---
>>>>>     hw/display/virtio-gpu.c | 19 +++++++++++--------
>>>>>     1 file changed, 11 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>>>> index 0a1a625b0e..2f9133c3b6 100644
>>>>> --- a/hw/display/virtio-gpu.c
>>>>> +++ b/hw/display/virtio-gpu.c
>>>>> @@ -57,7 +57,7 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>>>>>         }
>>>>>
>>>>>         if (res->blob_size) {
>>>>> -        if (res->blob_size < (s->current_cursor->width *
>>>>> +        if (!res->blob || res->blob_size < (s->current_cursor->width *
>>>>
>>>> I doubt that rejecting a valid blob due to an implementation concern
>>>> (whether the backing storage is in memfd) is tolerated in the specification.
>>> Are you suggesting that the whole if (res->blob_size < (s->current_cursor-
>>> width *...
>>> check needs to be removed? I think it is just a sanity check to ensure that the
>> blob
>>> size is big enough for cursor.
>>
>> I referred to !res->blob, the new condition. It rejects a valid blob
>> that is backed by VFIO.
> The problem is that for blobs backed by VFIO, res->blob can be NULL but this function
> (virtio_gpu_update_cursor_data) is relying on res->blob always being valid. That's why
> the new condition !res->blob is needed here to check the validity of res->blob.

I understand the host-side implementation difficulty to support this 
operation for VFIO, but the guest may not be prepared for the failure of 
the operation so we shouldn't simply reject it.

By the way, perhaps it may be possible to provide res->blob for VFIO. 
Since "[RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs associated 
with VFIO devices" checks memory_region_is_ram_device(), the VFIO 
backend providing the blob should support mmap().

Regards,
Akihiko Odaki

