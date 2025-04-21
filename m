Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC88C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 12:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6pzM-0001kx-6I; Mon, 21 Apr 2025 08:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6pzE-0001kI-5O
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:10:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6pzA-0001aY-1B
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:10:55 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224341bbc1dso35743405ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745237448; x=1745842248;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2HwSkoHqEXvdI303QQu1Rr2Y+7K99N5lGQBF8icgfY=;
 b=evFP1RBIXjiE10IH3acaMciJ902AwQGvsHHoLVQdLW4qarg3/qYnRGMMf2KceoAmEi
 N/QNZc8NaUtOgvTI+mvZuFJ+RfxTp+2u4g9BQ96VA0H6/k+1jAyQhlm+myrnL9U7ot0z
 RlQIZ/9FSmq5be9Dt1kijSvRF/lCYfWngjw2Pn2nYL+coFgNvsVBZdixS/yMPnPetNiT
 4hT0YK14x3Zp0I/WA+pIfALtclpBaAw47JSgDMmv68wOXd7eOi5nXAaWqL4KgvEBUb1w
 17U8NSAsLpZLGqetEtkLMO2VVbkeFTSmq3SBy+Q4hV+3b1EDz7uuJyiWt8CbSZGO34xL
 uzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745237448; x=1745842248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2HwSkoHqEXvdI303QQu1Rr2Y+7K99N5lGQBF8icgfY=;
 b=rlhyLZLzXwRvYLYTFt9AqVOeo0Vl97HgSsMh7hxkzQW6BWbFklRMVRidDRk5ElLYpl
 nUALRVuXsXa8a7ZYA/M9m7hyrQv2VpHp/FwVi83NXU55dHwZ1ev0NfE9TiAwPNIG0yfT
 r0vLms1JzqNwNHu2uIOXznZNc0fDqs91w4WjWnPFnTunFURAHhBrVQCmOJedubccsMM7
 lS7mDsMeLodnYdfncLLBd+pILhEidOhphieMrVKTohMosP00CxY77F8x3dtBl7y3V5rp
 z5cXHT3U2DzpWagdQkchJXQBScKFRbTGmryQwxZn0D8dCJFJToKMnLDns9sHiL8CUknN
 im6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjUYyR5urt33nWM64wtBun19Mt7RbFjmTjZNds05VrpLLejN3Cfv1TnGhg0+zAljUYidyxWZcD1877@nongnu.org
X-Gm-Message-State: AOJu0YwC35bHyjixY6mObDuUwHmd0D4SfIGsia5zcyK2HKUA7ZdJX1+L
 e2qzG6auuAMUX9ygIOzDkZ43tFFBgsO4k8Y/LYcMGYZucbkX5QX1p3RkYGBN9Lo=
X-Gm-Gg: ASbGnctG5J7vUBAu+KQlRkyVNgFXdmLW8Nw92eEiIuI7mDfDo/li/wTbzA1IBgOQAAa
 2y6FVCHb/9AuzZqU8yLdX4K8BcOIXFEDTRIBcZds4GHJh6LiANxIoxVlpLejpZ+NMnp8jRLFyWX
 nOWhDnftE45VegsVzzW46xnj6900mwADAykc/lVa22nONk0CJHPxhYznCftnzMri3mk+f/EOX7f
 kv5xeO/9MOhwHzVG2hrXQ6LlPVgaCTd9v7Dg0pNModXE2RVn3r/4irxqwIOYFKd7YW0RPPM/YhK
 /QyLPTEBbx7xx82Om71FiWZPeciVMhK4sCdgF4XVYtdoHhH0bNIT1YLvT+ef1a52dhBZK+gxkdA
 OT4OyPTBOUN2suCT72bM=
X-Google-Smtp-Source: AGHT+IFW0Yt0JMusjqEQJxjEQqm9g1x9UKOCo0WYh4YCxmetiarYIhZWWsGcTCOMYoLTcCOsnSkIUQ==
X-Received: by 2002:a17:903:250:b0:224:1ec0:8a0c with SMTP id
 d9443c01a7336-22c535acd5cmr175862765ad.29.1745237448481; 
 Mon, 21 Apr 2025 05:10:48 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdb9f5sm64008565ad.218.2025.04.21.05.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 05:10:48 -0700 (PDT)
Message-ID: <be0997e0-b9c9-4fc8-a926-a5f9f38dab81@daynix.com>
Date: Mon, 21 Apr 2025 21:10:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Call set_features during reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, devel@daynix.com,
 qemu-stable@nongnu.org
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
 <59239d14-e50a-4a39-81dd-03580b025dc9@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <59239d14-e50a-4a39-81dd-03580b025dc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/04/10 18:32, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 10/4/25 09:42, Akihiko Odaki wrote:
>> virtio-net expects set_features() will be called when the feature set
>> used by the guest changes to update the number of virtqueues. Call it
>> during reset as reset clears all features and the queues added for
>> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
>>
>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest 
>> doesn't support multiqueue")
>> Buglink: https://issues.redhat.com/browse/RHEL-73842
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/virtio/virtio.c | 86 ++++++++++++++++++++++++++ 
>> +---------------------------
>>   1 file changed, 43 insertions(+), 43 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 85110bce3744..033e87cdd3b9 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, 
>> uint32_t queue_index)
>>       }
>>   }
>> -void virtio_reset(void *opaque)
>> -{
>> -    VirtIODevice *vdev = opaque;
>> -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>> -    int i;
>> -
>> -    virtio_set_status(vdev, 0);
>> -    if (current_cpu) {
>> -        /* Guest initiated reset */
>> -        vdev->device_endian = virtio_current_cpu_endian();
>> -    } else {
>> -        /* System reset */
>> -        vdev->device_endian = virtio_default_endian();
>> -    }
>> -
>> -    if (k->get_vhost) {
>> -        struct vhost_dev *hdev = k->get_vhost(vdev);
>> -        /* Only reset when vhost back-end is connected */
>> -        if (hdev && hdev->vhost_ops) {
>> -            vhost_reset_device(hdev);
>> -        }
>> -    }
>> -
>> -    if (k->reset) {
>> -        k->reset(vdev);
>> -    }
>> -
>> -    vdev->start_on_kick = false;
>> -    vdev->started = false;
>> -    vdev->broken = false;
>> -    vdev->guest_features = 0;
>> -    vdev->queue_sel = 0;
>> -    vdev->status = 0;
>> -    vdev->disabled = false;
>> -    qatomic_set(&vdev->isr, 0);
>> -    vdev->config_vector = VIRTIO_NO_VECTOR;
>> -    virtio_notify_vector(vdev, vdev->config_vector);
>> -
>> -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>> -        __virtio_queue_reset(vdev, i);
>> -    }
>> -}
>> -
>>   void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>>   {
>>       if (!vdev->vq[n].vring.num) {
>> @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, 
>> uint64_t val)
>>       return ret;
>>   }
>> +void virtio_reset(void *opaque)
>> +{
>> +    VirtIODevice *vdev = opaque;
>> +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>> +    int i;
>> +
>> +    virtio_set_status(vdev, 0);
>> +    if (current_cpu) {
>> +        /* Guest initiated reset */
>> +        vdev->device_endian = virtio_current_cpu_endian();
>> +    } else {
>> +        /* System reset */
>> +        vdev->device_endian = virtio_default_endian();
>> +    }
>> +
>> +    if (k->get_vhost) {
>> +        struct vhost_dev *hdev = k->get_vhost(vdev);
>> +        /* Only reset when vhost back-end is connected */
>> +        if (hdev && hdev->vhost_ops) {
>> +            vhost_reset_device(hdev);
>> +        }
>> +    }
>> +
>> +    if (k->reset) {
>> +        k->reset(vdev);
>> +    }
>> +
>> +    vdev->start_on_kick = false;
>> +    vdev->started = false;
>> +    vdev->broken = false;
>> +    virtio_set_features_nocheck(vdev, 0);
> 
> It would be simpler to review having a first patch doing code
> movement, then a second one with the addition.

I'm thinking of splitting in the reversed order: add this function call 
with a forward declaration in a first patch and move virtio_reset() in a 
second one. Hopefully it will also make backporting easier.

> 
> For my own education, are feature sets modifiable at runtime?

Looking at the code and spec, yes, I think so. The feature set cannot be 
modified if VIRTIO_CONFIG_S_FEATURES_OK is set as part of the "status", 
but the flag can be cleared anytime.

> 
>> +    vdev->queue_sel = 0;
>> +    vdev->status = 0;
>> +    vdev->disabled = false;
>> +    qatomic_set(&vdev->isr, 0);
>> +    vdev->config_vector = VIRTIO_NO_VECTOR;
>> +    virtio_notify_vector(vdev, vdev->config_vector);
>> +
>> +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>> +        __virtio_queue_reset(vdev, i);
>> +    }
>> +}
>> +
>>   static void 
>> virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>>                                                              Error 
>> **errp)
>>   {
>>
>> ---
>> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
>> change-id: 20250406-reset-5ed5248ee3c1
>>
>> Best regards,
> 


