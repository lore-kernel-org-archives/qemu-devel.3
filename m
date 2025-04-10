Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FECC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 08:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2nFx-0006MA-B2; Thu, 10 Apr 2025 04:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u2nFP-0005GI-Cm
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 04:26:55 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u2nFM-00029y-Ek
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 04:26:54 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22435603572so4576095ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744273610; x=1744878410;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w57KVPGKg8La+aVUTaGw45wclWirYeae/y6yoU83Txg=;
 b=ZzGnRhQFqCfUb8Irw7WUfrYNmZx/QRJ11pHFtUJLLPgkGyRmeOl/TpJ449AVwXDkA4
 68FL8ENChmLHk1qWi/NjZ4BMM7AeUMaaecZFMzAASyYVywlzNF6Brrx4bZSN5+jzERbd
 tBnPoCWzXxWP/2uLs7iNb3KLQa7qs93g4Q3hoc3q9QYNwP1U4+UxCLSlQt4B1wz3z/+y
 avvaAAVv4m38d58KPixfQryXC3dfTUqOyINeMHs2F3si/i+uGtLNyhKvmbBaPuRWtycr
 RKpgtd4ueAZ1MxNeDlDXifiqMg/kbKKWt8TtgJOwXzlEjwfnVRERMdFKNI407K4I0V2G
 X8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744273610; x=1744878410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w57KVPGKg8La+aVUTaGw45wclWirYeae/y6yoU83Txg=;
 b=IB7oETc3MCnCNW51vuU3Qg2WW3LQA/Epd8GjbaUoinfAP8QuwGOeKsW1HhIL/lxQwy
 VhQEHYe7eH7axmoQS0Qo5MTr+rFaQdXOWXGhUPUaus+Jbm8rnJDDxKUIWj9MuDNEqU1u
 SyHmKOzWeup9fFv6OEo3DIVgROG64Qec4+dksq/gj+ctagYbGZJdxbykD3tYZWZQvomt
 0x5hyJi+7F7Nu6TOuWmzv2W31ShL6wyWNNc9D6UCZ6z9kEcb3pqYgvibireY1w993xWz
 DI9f0I1tqLU0GOOIax0I8mb1TgdgVOApRdxKfwpfhFig1ldu0T89JK6EUER5JOscwboj
 RYzg==
X-Gm-Message-State: AOJu0YzCR2fxiobK0vl2Jk8z9vIBG2fWyEyiCaTe7cPVkLjN8RIK+JkR
 se0UKfAX+qvbcFxgkt7Lnut/cZ+zxtVu6bUib1bfgHNAXjjp3ygz61F3LTimnoo=
X-Gm-Gg: ASbGncvpNZxPQnRWA3fu6yLhzGp3UqWYbvan0na0JGJCdnYfr1+nsQqXuisraDo6szW
 CdfnzWk5yOssxFMii5TnASJHHi/fSeNJpGHevXkITMkmfcy2qYOjdO6bbk1nP+p9hR9AsTfZ7XF
 RCTTch0nJrwltMD6xhVouobptdKucl/xSiZzlal+Gh4AaHD4xKv+eWr4UFAdG5pFUvPbs9e3Y8Q
 PeTAVBPecdGri7tAB0IF81aLExybVqMN+uRHTI1JylcPqRD14BWS/w5zPOATknGTUfXK17Cpbmb
 E3znYl6rIEkjELNtT01L3xpl382Ios3ZbSKo9ZjtaXcH7DcHlGfYVPYR2YH6mEeEFAErcyTkDNo
 GwUN/yqImdOLOGalgqeA=
X-Google-Smtp-Source: AGHT+IHfMa4Hv0ZGyxpmFB9tzV+F1QROgKiVovqavU/AY4WAP+oFGGzHkTMTtfLOQXnDiBES82yJWQ==
X-Received: by 2002:a17:902:f64b:b0:223:39ae:a98 with SMTP id
 d9443c01a7336-22be03212a1mr26609045ad.22.1744273610249; 
 Thu, 10 Apr 2025 01:26:50 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b654adsm24831425ad.1.2025.04.10.01.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 01:26:49 -0700 (PDT)
Message-ID: <d387d721-a5fc-4661-8a3b-576c34780398@daynix.com>
Date: Thu, 10 Apr 2025 17:26:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Call set_features during reset
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
 <20250410034550-mutt-send-email-mst@kernel.org>
 <ece28e1e-ea85-4247-b2b1-54fbd8d2ce37@daynix.com>
 <20250410035935-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250410035935-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2025/04/10 17:02, Michael S. Tsirkin wrote:
> On Thu, Apr 10, 2025 at 04:54:41PM +0900, Akihiko Odaki wrote:
>> On 2025/04/10 16:48, 'Michael S. Tsirkin' via devel wrote:
>>> On Thu, Apr 10, 2025 at 04:42:06PM +0900, Akihiko Odaki wrote:
>>>> virtio-net expects set_features() will be called when the feature set
>>>> used by the guest changes to update the number of virtqueues. Call it
>>>> during reset as reset clears all features and the queues added for
>>>> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
>>>>
>>>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
>>>> Buglink: https://issues.redhat.com/browse/RHEL-73842
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> The issue seems specific to virtio net: rset is reset,
>>> it is distict from set features.
>>> Why not just call the necessary functionality from virtio_net_reset?
>>
>> set_features is currently implemented only in virtio-net; virtio-gpu-base
>> also have a function set but it only has code to trace. If another device
>> implements the function in the future, I think the device will also want to
>> have it called during reset for the same reason with virtio-net.
>>
>> virtio_reset() also calls set_status to update the status field so calling
>> set_features() is more aligned with the handling of the status field.
> 
> That came to be because writing 0 to status resets the virtio device.
> For a while, this was the only way to reset vhost-user so we just
> went along with it.

It is possible to have code to send a command to write 0 to status to 
vhost-user in reset(), but calling set_status() in virtio_reset() is 
more convenient and makes sense as the status is indeed being set to 0. 
I think the same reasoning applies to features.

> 
> 
>>>
>>>
>>>> ---
>>>>    hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
>>>>    1 file changed, 43 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>> index 85110bce3744..033e87cdd3b9 100644
>>>> --- a/hw/virtio/virtio.c
>>>> +++ b/hw/virtio/virtio.c
>>>> @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
>>>>        }
>>>>    }
>>>> -void virtio_reset(void *opaque)
>>>> -{
>>>> -    VirtIODevice *vdev = opaque;
>>>> -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>>>> -    int i;
>>>> -
>>>> -    virtio_set_status(vdev, 0);
>>>> -    if (current_cpu) {
>>>> -        /* Guest initiated reset */
>>>> -        vdev->device_endian = virtio_current_cpu_endian();
>>>> -    } else {
>>>> -        /* System reset */
>>>> -        vdev->device_endian = virtio_default_endian();
>>>> -    }
>>>> -
>>>> -    if (k->get_vhost) {
>>>> -        struct vhost_dev *hdev = k->get_vhost(vdev);
>>>> -        /* Only reset when vhost back-end is connected */
>>>> -        if (hdev && hdev->vhost_ops) {
>>>> -            vhost_reset_device(hdev);
>>>> -        }
>>>> -    }
>>>> -
>>>> -    if (k->reset) {
>>>> -        k->reset(vdev);
>>>> -    }
>>>> -
>>>> -    vdev->start_on_kick = false;
>>>> -    vdev->started = false;
>>>> -    vdev->broken = false;
>>>> -    vdev->guest_features = 0;
>>>> -    vdev->queue_sel = 0;
>>>> -    vdev->status = 0;
>>>> -    vdev->disabled = false;
>>>> -    qatomic_set(&vdev->isr, 0);
>>>> -    vdev->config_vector = VIRTIO_NO_VECTOR;
>>>> -    virtio_notify_vector(vdev, vdev->config_vector);
>>>> -
>>>> -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>> -        __virtio_queue_reset(vdev, i);
>>>> -    }
>>>> -}
>>>> -
>>>>    void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>>>>    {
>>>>        if (!vdev->vq[n].vring.num) {
>>>> @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>>>>        return ret;
>>>>    }
>>>> +void virtio_reset(void *opaque)
>>>> +{
>>>> +    VirtIODevice *vdev = opaque;
>>>> +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>>>> +    int i;
>>>> +
>>>> +    virtio_set_status(vdev, 0);
>>>> +    if (current_cpu) {
>>>> +        /* Guest initiated reset */
>>>> +        vdev->device_endian = virtio_current_cpu_endian();
>>>> +    } else {
>>>> +        /* System reset */
>>>> +        vdev->device_endian = virtio_default_endian();
>>>> +    }
>>>> +
>>>> +    if (k->get_vhost) {
>>>> +        struct vhost_dev *hdev = k->get_vhost(vdev);
>>>> +        /* Only reset when vhost back-end is connected */
>>>> +        if (hdev && hdev->vhost_ops) {
>>>> +            vhost_reset_device(hdev);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (k->reset) {
>>>> +        k->reset(vdev);
>>>> +    }
>>>> +
>>>> +    vdev->start_on_kick = false;
>>>> +    vdev->started = false;
>>>> +    vdev->broken = false;
>>>> +    virtio_set_features_nocheck(vdev, 0);
>>>> +    vdev->queue_sel = 0;
>>>> +    vdev->status = 0;
>>>> +    vdev->disabled = false;
>>>> +    qatomic_set(&vdev->isr, 0);
>>>> +    vdev->config_vector = VIRTIO_NO_VECTOR;
>>>> +    virtio_notify_vector(vdev, vdev->config_vector);
>>>> +
>>>> +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>> +        __virtio_queue_reset(vdev, i);
>>>> +    }
>>>> +}
>>>> +
>>>>    static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>>>>                                                               Error **errp)
>>>>    {
>>>>
>>>> ---
>>>> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
>>>> change-id: 20250406-reset-5ed5248ee3c1
>>>>
>>>> Best regards,
>>>> -- 
>>>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
> 


