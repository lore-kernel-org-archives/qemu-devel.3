Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31870C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 06:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u61oS-0007EV-Bg; Sat, 19 Apr 2025 02:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u61oQ-0007EB-DT
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 02:36:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u61oO-00049A-2l
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 02:36:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224100e9a5cso29881415ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 23:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745044582; x=1745649382;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l7pLlRPYl9IZ9VK/DyOgMPx8meh7il9zCjTpYyrFrdE=;
 b=FhbiSzKCLyHlGd8BuhvErGMV5CEg6zU+jzb1gE4daZj97xpIqfjWrPhCsrhEQDodiy
 /W32QEvDJZ7mssQy1RayD9bQ1/D8QolKXErV/5eVeq1OHPAptw3m9nxFF3WiHWZyZIwB
 vvmo23YVmCQCS8t/wstnQeIxX46dXsE/PttRI9XS1JeneqGz4C4Y8IHzHgqg7k8Ax/s3
 AgwQehnYZgwAv57cp9TJCN5zmxGyq2spCnUgCK05B6DAAVglrCH4Zc4/6L9TusQ46nHi
 /6UrHeY/4KNDO70X5ReQk43zSPL+fx1zsVzGvnuwzNvyxBYsaicN8myw8mknBeFuPS4d
 I5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745044582; x=1745649382;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l7pLlRPYl9IZ9VK/DyOgMPx8meh7il9zCjTpYyrFrdE=;
 b=eJj6ew4Z4gn6wB7Nl405fBHKnl8MUPPcQ8n3M/ZYXXG1py6EhIODmc+e4BdBVDtoHp
 dtiUAXYOHVgUeG0/FUb6Ch3kRBWNLhGpN6UOJ0u/1TCBD8/eYPwdECDhK+2WgWl8yiNO
 Ef6rmREShauDKvHcEDz9+D8yzoFQMJ+fIKp/TgTWkfoTdg+8swOM0hlyCBa4+i3AFDAp
 zgmCnsqDDPh2X/G2CoZ50fcWqtVFG2IfRPMNonRZpaby/cr+vSvTMPZoO5keAM1GLQ8u
 lDaqmR6h2P5xA7w2aYAmskwQ+vZWBKjatGesIuJsThofOKW2wbVeN+5RhxByv0wCiw2A
 UTXg==
X-Gm-Message-State: AOJu0YxW9og9eaUmAiHboO26lI/YdL/O3Jx3aI/qB9aoCbgJ9yMFKDiq
 5hwqt957UVmvzwZEG5u9BdB+ixPQmWdRJo0YE9gycowGHuD04pBSSZwZIP9VxoFxaUkqGen2UYC
 62QE=
X-Gm-Gg: ASbGncvSXT2YuQ6HGTyAYfOaLGhKQfo82ScT9loZXSOP2+nR0/DZ4GHqzAt9x12knxn
 RxL2p1U7MUw2m3uoIIvprBv4b9W1Gh4phujNMLrF23pue+nPR9qnZ5gH1Y4qmdvZ5ePhx9AqKXq
 VhszwC+ID5YojYMm+2cq8YjAq8WMkewgwXIHPdn2ryZG3vBRIHzGP/46bimzgAMtilcj4j8vvMS
 YbYEjjLKBZ7L2a4FwO0AZL4yLRMnvgEiwFr0XqvkwKvfvei+J8PPl2CS4ZBBgeEev6a0PDGnGA+
 lki13RYUXZbVYZwjRmiZJysaeKu/+78kFJfYXqkzzAttLTdCmSQskPncHPYH/nKqCIZKeXTMyIp
 gYeLLTP5FhTMYs1p0qwk=
X-Google-Smtp-Source: AGHT+IE+GcQShiNHg7UqPMGPQvE2ekrFZa4TzG3SRSTJQHASjtHYL3s9r2tRE+AS8OqV8mrQtHwZEg==
X-Received: by 2002:a17:902:d489:b0:224:e33:8896 with SMTP id
 d9443c01a7336-22c53285bbbmr70613555ad.11.1745044581847; 
 Fri, 18 Apr 2025 23:36:21 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb64fbsm27063875ad.158.2025.04.18.23.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 23:36:21 -0700 (PDT)
Message-ID: <87b634f1-b3fb-4911-bf97-0f941d07a2f0@daynix.com>
Date: Sat, 19 Apr 2025 15:36:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Call set_features during reset
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com, qemu-stable@nongnu.org
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
 <CACGkMEv5JfUFkwQzE5iHuxnKsVm6u1d89Ek5n4Gw2a2D2DEvVw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEv5JfUFkwQzE5iHuxnKsVm6u1d89Ek5n4Gw2a2D2DEvVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

On 2025/04/16 14:46, Jason Wang wrote:
> On Thu, Apr 10, 2025 at 3:42 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> virtio-net expects set_features() will be called when the feature set
>> used by the guest changes to update the number of virtqueues. Call it
>> during reset as reset clears all features and the queues added for
>> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
> 
> It's not clear to me what kind of problem we want to fix here. For
> example, what happens if we don't do this.

Without this change, if the device gets reset after VIRTIO_NET_F_MQ or 
VIRTIO_NET_F_RSS is configured:
- the guest will see too many virtqueues
- migration results in segfault due to the mismatch with the number of 
virtqueues and feature set

I'll add the description to the patch message with the next version.

> 
>>
>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
>> Buglink: https://issues.redhat.com/browse/RHEL-73842
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
>>   1 file changed, 43 insertions(+), 43 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 85110bce3744..033e87cdd3b9 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
>>       }
>>   }
>>
>> -void virtio_reset(void *opaque)
>> -{
>> -    VirtIODevice *vdev = opaque;
>> -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>> -    int i;
>> -
>> -    virtio_set_status(vdev, 0);
>> -    if (current_cpu) {
>> -        /* Guest initiated reset */
>> -        vdev->device_endian = virtio_current_cpu_endian();
>> -    } else {
>> -        /* System reset */
>> -        vdev->device_endian = virtio_default_endian();
>> -    }
>> -
>> -    if (k->get_vhost) {
>> -        struct vhost_dev *hdev = k->get_vhost(vdev);
>> -        /* Only reset when vhost back-end is connected */
>> -        if (hdev && hdev->vhost_ops) {
>> -            vhost_reset_device(hdev);
>> -        }
>> -    }
>> -
>> -    if (k->reset) {
>> -        k->reset(vdev);
>> -    }
>> -
>> -    vdev->start_on_kick = false;
>> -    vdev->started = false;
>> -    vdev->broken = false;
>> -    vdev->guest_features = 0;
>> -    vdev->queue_sel = 0;
>> -    vdev->status = 0;
>> -    vdev->disabled = false;
>> -    qatomic_set(&vdev->isr, 0);
>> -    vdev->config_vector = VIRTIO_NO_VECTOR;
>> -    virtio_notify_vector(vdev, vdev->config_vector);
>> -
>> -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>> -        __virtio_queue_reset(vdev, i);
>> -    }
>> -}
>> -
>>   void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>>   {
>>       if (!vdev->vq[n].vring.num) {
>> @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>>       return ret;
>>   }
>>
>> +void virtio_reset(void *opaque)
>> +{
>> +    VirtIODevice *vdev = opaque;
>> +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>> +    int i;
>> +
>> +    virtio_set_status(vdev, 0);
>> +    if (current_cpu) {
>> +        /* Guest initiated reset */
>> +        vdev->device_endian = virtio_current_cpu_endian();
>> +    } else {
>> +        /* System reset */
>> +        vdev->device_endian = virtio_default_endian();
>> +    }
>> +
>> +    if (k->get_vhost) {
>> +        struct vhost_dev *hdev = k->get_vhost(vdev);
>> +        /* Only reset when vhost back-end is connected */
>> +        if (hdev && hdev->vhost_ops) {
>> +            vhost_reset_device(hdev);
>> +        }
>> +    }
>> +
>> +    if (k->reset) {
>> +        k->reset(vdev);
>> +    }
>> +
>> +    vdev->start_on_kick = false;
>> +    vdev->started = false;
>> +    vdev->broken = false;
>> +    virtio_set_features_nocheck(vdev, 0);
> 
> I would just add a forward declaration instead for a smaller changset
> to ease the review and backport.

Moving virtio_reset() indeed requires a bigger change, but I still want 
to move it to the latter part of this file. I occasionally saw that 
functions that affect the whole device state like this calls a number of 
static functions. Moving virtio_reset() requires more lines to change 
now, but I hope it will minimize the possibility to require forward 
declarations or code movement in the future.

Regards,
Akihiko Odaki

> 
>> +    vdev->queue_sel = 0;
>> +    vdev->status = 0;
>> +    vdev->disabled = false;
>> +    qatomic_set(&vdev->isr, 0);
>> +    vdev->config_vector = VIRTIO_NO_VECTOR;
>> +    virtio_notify_vector(vdev, vdev->config_vector);
>> +
>> +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>> +        __virtio_queue_reset(vdev, i);
>> +    }
>> +}
>> +
>>   static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>>                                                              Error **errp)
>>   {
>>
>> ---
>> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
>> change-id: 20250406-reset-5ed5248ee3c1
>>
>> Best regards,
>> --
>> Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Thanks
> 
>>
>>
> 


