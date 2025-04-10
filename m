Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D155DC369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mkL-00044d-Pe; Thu, 10 Apr 2025 03:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u2mkK-00044J-5Y
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:54:48 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u2mkH-0006AM-Lk
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:54:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30572effb26so434924a91.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744271684; x=1744876484;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KLuJ7ZXJXW04wJRzP1XCHXmkShxo6/bbyWvm9L3lZy8=;
 b=lsh+w/nzl51UaN81EcLiLWwzFNJnq1Cb5C/JZyWx/LK8hTlvG164SfFkRz2zsRpUd6
 2/z3pEONfNQXahGsKXL93AJmPggRbBQv7RD+pVBYv2q7Det2vysfNNLrcPfA9i6Q2RVA
 3l8mHUb+87c4rM+3xzzapD4AG3Weh31RV+UqwrZ0ewWb9x0fCO0/q4i1BmWL6H0u4aNm
 tMYC1xqzUmfl1XVUSBUDT/NLm+Rs8Z87I+hL27WrV/EoN8jks0BOhmO1NATDWkowagOc
 AISby1RqBFzavBJeBrIqvgG8sT2vn/uev1DH0HKb8/GiIuMtGcx+DBuuGrOcBKZd/Y4V
 1Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744271684; x=1744876484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLuJ7ZXJXW04wJRzP1XCHXmkShxo6/bbyWvm9L3lZy8=;
 b=FSPUrSugeneqUxgAx04sYyY9h/N0gY0HAAvHdovdFj9Euor3Q8xFR8tzZJPNNWz7Ls
 yhGdVcsuuSQ+sbg1gKofuCwZBGcZ1XWM+ylSwmG0Sdbyqdh7X1p2s+I7A1HW3MNS/kiI
 QMwtQthk1ui1TjX5vRDGdTztjxzgjIBPPxCpbFLk5U2Ku/L6Y44j9ge1pFXXWJttfVSY
 rvZiECDDcLgfiVAlLKPFD4977Y9LKhbOb7DsDBo0Xs7nnjSd5qz4T3c156jhs3oLhcEz
 ot3b+eNmaYrjzJhMZjA7OzTaWI1Vw9QjQ382VLDMdjz4Um74q0TXP9OVGjBq8uM8EJQF
 KV7g==
X-Gm-Message-State: AOJu0YyNApFSSBCfltDHCXCr3+ixGIHC1Uzu4rFRzbe0m5cEJXfXdhVi
 dhuu4i9NqJksTdBJPGt8KfuuGvpu5nmphVMQ7Wpqn5MzRpva9sc1nbgoBvCijjg=
X-Gm-Gg: ASbGnctNYHj159ObChOtKZESjQ6/g3wb47kZJ9lR4fQST6u3mSNe/BP+bUOMSf1wdZs
 0haklyC9O4eSK5v4OWbRzXP10WwORgUQ7fwj1LIvILEmNm5RJZDy7ptkWdgqkACrmH38QIV0WIN
 Ti6CU0tx1s4++yvfwj0nryn7/MjkAX2L/0qEJsebG5CbtzaE4Leeoa+3y3id2W2AIcQcUU6wm0/
 VK8o20nRfPjwNAZvN0ntVtw2Z0Ox/xrrN0dqe0HHFfSKtfN8noRay4D3XylTr6WtSYkiTkf8gJH
 mJeL9XhOw+7XPW/2P0G+vQGM1bKbs1jz4sy/uqDJlrcCquMqRtBHZN1CS5ykK+mCV416Ws3AShk
 LUmxcAoH82FONV1FaZVk=
X-Google-Smtp-Source: AGHT+IE0d16IYkcHqJIpuG4y2rN7Mk9Nc5wwq06j9EvbbaTNMBdRFRi1aZMbtakeno0vVNmhfAN0NQ==
X-Received: by 2002:a17:90b:2dcc:b0:2fe:a336:fe65 with SMTP id
 98e67ed59e1d1-30718b73161mr3138782a91.10.1744271683946; 
 Thu, 10 Apr 2025 00:54:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b8ea6csm24406155ad.97.2025.04.10.00.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:54:43 -0700 (PDT)
Message-ID: <ece28e1e-ea85-4247-b2b1-54fbd8d2ce37@daynix.com>
Date: Thu, 10 Apr 2025 16:54:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Call set_features during reset
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
 <20250410034550-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250410034550-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
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

On 2025/04/10 16:48, 'Michael S. Tsirkin' via devel wrote:
> On Thu, Apr 10, 2025 at 04:42:06PM +0900, Akihiko Odaki wrote:
>> virtio-net expects set_features() will be called when the feature set
>> used by the guest changes to update the number of virtqueues. Call it
>> during reset as reset clears all features and the queues added for
>> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
>>
>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
>> Buglink: https://issues.redhat.com/browse/RHEL-73842
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> The issue seems specific to virtio net: rset is reset,
> it is distict from set features.
> Why not just call the necessary functionality from virtio_net_reset?

set_features is currently implemented only in virtio-net; 
virtio-gpu-base also have a function set but it only has code to trace. 
If another device implements the function in the future, I think the 
device will also want to have it called during reset for the same reason 
with virtio-net.

virtio_reset() also calls set_status to update the status field so 
calling set_features() is more aligned with the handling of the status 
field.

> 
> 
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


