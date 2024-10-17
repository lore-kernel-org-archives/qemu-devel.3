Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48088D2F7F9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1L02-00086O-9V; Thu, 17 Oct 2024 03:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1t1L01-00086B-A6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1t1Kzz-0006OT-KU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729150360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5Ns7Y7h3BXY8sjK3X2RjD4obu2pboMT4tHPwJEenVUs=;
 b=I7bjsj7fItVQCvAWG9ZGUPYOq3QgH/XJH1FlAtT6ZyD/MzFIqdoYkfJAbIVyMFZIZM8AX5
 z+iTM9l+r6bx2gO0wVjIjbZZw/QFfnlmRC8cDpXJYqIjwqI937KAAf4uHF3Lr3GFGHk3mm
 Qc7Q9AK0frRPIRON4AfA2EEfS/d3Pxc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-Xz7yqIzEPTGtnVbqixQ_Qg-1; Thu, 17 Oct 2024 03:32:38 -0400
X-MC-Unique: Xz7yqIzEPTGtnVbqixQ_Qg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso1776755e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729150357; x=1729755157;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ns7Y7h3BXY8sjK3X2RjD4obu2pboMT4tHPwJEenVUs=;
 b=rKFu+8iM9R+9Mqe+63w+9iSrp3BVmLAhTtppwDMu7H6iX/5vH/k5EsLvMzZymTqrnj
 NsPCNpm2OYmjuC9v97nav23kQh7L1L+n4TQRPr8j0jfQZBVVKVU9M/hbZP3HD4wQ0gWe
 inEydxpEwN2wHLipU63790tCK0jJK/IrKMEUhpixvwj0Vxr6ba8kol216+giG4y2/sWE
 VeyG0FQ85vhwXbaljOowomJM+FiojYac6y6fC9JcrtrJ3j/VBBsIRkT1ptvT0bq+3GKR
 6ANKXfqUh+YnpUyZO+KwGe1brmt6MIAadEawOxEwkC0P0N6uQQlFmAFGXlOuLjISRJjt
 NaZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgpTNJUKZPJ3QaW3FcHPy2OnN+7b1C5EsL9CEAJOEQBnt7OiKxyW8ri7lJ5g1RuEuO4pRg9bfn9yqy@nongnu.org
X-Gm-Message-State: AOJu0YwhSQzhva9W0U33MSUpgudrlD/IZIq+gBVIWFsfR3+tsZLjKibt
 V3AMmin1TZZTG8jkHAu7i+2R7nBrZoIWOpTfUB3QBgWOFJxTABbXiP34nXl9F37q62eOtJQr6GG
 bSgPRRtUpYcGjBkZ1XryH9wZpiKg+154AW7GqJgsggkDXgtdN3Fu3
X-Received: by 2002:a05:600c:4ecc:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-431586fc9b3mr11904735e9.3.1729150356754; 
 Thu, 17 Oct 2024 00:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXz5AgMrnL/JA2DZp2iqzhQWXgcUOD1VED7PYezijJZa+YWobCmjwctL5KlsKVJSde/xHNyQ==
X-Received: by 2002:a05:600c:4ecc:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-431586fc9b3mr11904505e9.3.1729150356237; 
 Thu, 17 Oct 2024 00:32:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:4c84:58cb:a1ef:8b78?
 ([2a01:e0a:e10:ef90:4c84:58cb:a1ef:8b78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87d48sm6352993f8f.32.2024.10.17.00.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 00:32:35 -0700 (PDT)
Message-ID: <d186fb3c-a036-4a20-a4e7-33119bd8b4b9@redhat.com>
Date: Thu, 17 Oct 2024 09:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/20] virtio-net: Add only one queue pair when realizing
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-9-jasowang@redhat.com>
 <a46a895a-4961-43fa-99d8-3bda7612bb9a@redhat.com>
 <14bcc2cf-f934-4aa3-8cab-21803a930adc@redhat.com>
 <CACGkMEs5P=Gmo4xTbwH1SPTjwjMoeAcK+fiVXQE0BRrRh-hAwg@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CACGkMEs5P=Gmo4xTbwH1SPTjwjMoeAcK+fiVXQE0BRrRh-hAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/10/2024 08:59, Jason Wang wrote:
> On Mon, Oct 14, 2024 at 11:16 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> On 14/10/2024 10:30, Laurent Vivier wrote:
>>> Hi Akihiko,
>>>
>>> On 04/06/2024 09:37, Jason Wang wrote:
>>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>
>>>> Multiqueue usage is not negotiated yet when realizing. If more than
>>>> one queue is added and the guest never requests to enable multiqueue,
>>>> the extra queues will not be deleted when unrealizing and leak.
>>>>
>>>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support
>>>> multiqueue")
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>    hw/net/virtio-net.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index 3cee2ef3ac..a8db8bfd9c 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -3743,9 +3743,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>>        n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
>>>>                                        n->net_conf.tx_queue_size);
>>>> -    for (i = 0; i < n->max_queue_pairs; i++) {
>>>> -        virtio_net_add_queue(n, i);
>>>> -    }
>>>> +    virtio_net_add_queue(n, 0);
>>>>        n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
>>>>        qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>>>
>>> This change breaks virtio net migration when multiqueue is enabled.
>>>
>>> I think this is because virtqueues are half initialized after migration : they are
>>> initialized on guest side (kernel is using them) but not on QEMU side (realized has only
>>> initialized one). After migration, they are not initialized by the call to
>>> virtio_net_set_multiqueue() from virtio_net_set_features() because virtio_get_num_queues()
>>> reports already n->max_queue_pairs as this value is coming from the source guest memory.
>>>
>>> I don't think we have a way to half-initialize a virtqueue (to initialize them only on
>>> QEMU side as they are already initialized on kernel side).
>>>
>>> I think this change should be reverted to fix the migration issue.
>>>
>>
>> Moreover, if I look in the code of virtio_load() and virtio_add_queue() we can guess it's
>> not correct to migrate a virtqueue that is not initialized on the destination side because
>> fields like 'vdev->vq[i].handle_output' or 'vdev->vq[i].used_elems' cannot be initialized
>> by virtio_load() and neither by virtio_add_queue() after virtio_load() as fields like
>> 'vring.num' are already initialized by virtio_load().
>>
>> For instance, in virtio_load() we set:
>>
>>       for (i = 0; i < num; i++) {
>>           vdev->vq[i].vring.num = qemu_get_be32(f);
>>
>> and in virtio_add_queue() we search for the firt available queue to add with:
>>
>>       for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>           if (vdev->vq[i].vring.num == 0)
>>               break;
>>       }
>>
>> So virtio_add_queue() cannot be used to set:
>>
>>       vdev->vq[i].handle_output = handle_output;
>>       vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
>>
>> Moreover it would overwrite fields already set by virtio_load():
>>
>>       vdev->vq[i].vring.num = queue_size;
>>       vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
>>
>> It also explains why virtio_net_change_num_queue_pairs() (indirectly called by
>> virtio_net_set_features()) doesn't update the queue pair numbers: vring.num is already set
>> so it thinks there is no more queues to add.
>>
>> Thanks,
>> LAurent
>>
> 
> I agree.
> 
> Laurent, would you like to send a patch to revert this?
> 

Yes. I will also try to fix the leak in unrealize that the patch wanted to fix initially.

Thanks,
Laurent


