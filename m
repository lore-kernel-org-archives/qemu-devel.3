Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD3ED21269
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1N1x-0006ke-82; Thu, 17 Oct 2024 05:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1N1v-0006kA-5e
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:42:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1N1s-00079C-Ne
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:42:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso290115b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729158167; x=1729762967;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2opMkNSPL6jtOfrXOVnnly5aTbGxcOKqHOI6wui0PZc=;
 b=cjqfOEl5Tn2DHQXNi2J7RAaLXOWZzbQf3lPx9kM63cC7WpNOY1Mo+17YPE3qc/BMec
 sTCmx5HaB45Fj4Sy+ey3kPSNjKOksWjJJEPCyzZb/U+E5bBzKoRrWgS/h+I0AwRvoQVu
 HSEfJjie5StiXFIziBTkNX4NNQp9XidVeMT6QAFd1DzORnts9++cQDOiOcqJQaM5k77Y
 +7JE+sKRPah3XtDbMEs/VYu3fbbo9VPznoGa1sGLvLvaC7EMlfAOIdapMusUApQ5CA3K
 8bowPs3Ay3aeGDWJPxyqfNyEQnVofFDzErs9t6F2KvlBgFriRcmRHY5CAbBqPAauvYKd
 6vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729158167; x=1729762967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2opMkNSPL6jtOfrXOVnnly5aTbGxcOKqHOI6wui0PZc=;
 b=IMKid++Ha7RbKrv8RTDtUBAIOj+26dBkMexPlUTbge+XRu0nUn9xmh8DMKL/xNB1P6
 xDDd7YxDpQmTTMJ1HtmTtf/0+eISSpkuDAORNmR2MJPb1ZkJ1SaMPel3k5/CAH+KWRAH
 pwVwQvKP7bkMeghxWZOqocRDk0/xQBrKmO+8sspVS7f6JPMY+hm4aiXATEWWNCWGrtVL
 4U3UlmY4H5iVlJopimtuoSBgsJXJzDmkG45ptLcA19gQ/AO1B88vT0sGTDglRXJIRg6e
 Ongubbp3n4R2rg2eI6DjR855CKXQVLv4rRW7iCrCYvLx5hsy095S3tl969miiXcRa+0p
 aPcA==
X-Gm-Message-State: AOJu0YzS+gP6ZL4XbcZo7pT1r9paO87NOS43ex6d+jdt6QIV/aiOLizf
 mE9NZhj7GUjhXpioVlyBGYGpDgurufqM3DtG6on/0YPYdYsAQvpOIUkd+ng1bJRFl01JxiIjkhJ
 DSwg=
X-Google-Smtp-Source: AGHT+IE6XtfhFpi/VLq/xlQWaucSBkhkY209NxdSb7XGmUpUHho37nr49QMUDUhzXM3K0qXGHaSNDw==
X-Received: by 2002:a05:6a00:21d5:b0:71e:98a:b6b4 with SMTP id
 d2e1a72fcca58-71e4c156e77mr27106573b3a.11.1729158166688; 
 Thu, 17 Oct 2024 02:42:46 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774cf4d8sm4521592b3a.149.2024.10.17.02.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 02:42:46 -0700 (PDT)
Message-ID: <002f53e8-501e-4b4d-b1fc-67ec51e3a94f@daynix.com>
Date: Thu, 17 Oct 2024 18:42:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/20] virtio-net: Add only one queue pair when realizing
To: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-9-jasowang@redhat.com>
 <a46a895a-4961-43fa-99d8-3bda7612bb9a@redhat.com>
 <14bcc2cf-f934-4aa3-8cab-21803a930adc@redhat.com>
 <CACGkMEs5P=Gmo4xTbwH1SPTjwjMoeAcK+fiVXQE0BRrRh-hAwg@mail.gmail.com>
 <d186fb3c-a036-4a20-a4e7-33119bd8b4b9@redhat.com>
 <60169858-3930-4490-b42d-d04117ab9abd@daynix.com>
 <bc493771-e507-4027-af76-f9a95e99b81d@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <bc493771-e507-4027-af76-f9a95e99b81d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/17 18:17, Laurent Vivier wrote:
> On 17/10/2024 11:07, Akihiko Odaki wrote:
>> On 2024/10/17 16:32, Laurent Vivier wrote:
>>> On 17/10/2024 08:59, Jason Wang wrote:
>>>> On Mon, Oct 14, 2024 at 11:16 PM Laurent Vivier <lvivier@redhat.com> 
>>>> wrote:
>>>>>
>>>>> On 14/10/2024 10:30, Laurent Vivier wrote:
>>>>>> Hi Akihiko,
>>>>>>
>>>>>> On 04/06/2024 09:37, Jason Wang wrote:
>>>>>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>
>>>>>>> Multiqueue usage is not negotiated yet when realizing. If more than
>>>>>>> one queue is added and the guest never requests to enable 
>>>>>>> multiqueue,
>>>>>>> the extra queues will not be deleted when unrealizing and leak.
>>>>>>>
>>>>>>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the 
>>>>>>> guest doesn't support
>>>>>>> multiqueue")
>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>> ---
>>>>>>>    hw/net/virtio-net.c | 4 +---
>>>>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>>>> index 3cee2ef3ac..a8db8bfd9c 100644
>>>>>>> --- a/hw/net/virtio-net.c
>>>>>>> +++ b/hw/net/virtio-net.c
>>>>>>> @@ -3743,9 +3743,7 @@ static void 
>>>>>>> virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>>>>>        n->net_conf.tx_queue_size = 
>>>>>>> MIN(virtio_net_max_tx_queue_size(n),
>>>>>>>                                        n->net_conf.tx_queue_size);
>>>>>>> -    for (i = 0; i < n->max_queue_pairs; i++) {
>>>>>>> -        virtio_net_add_queue(n, i);
>>>>>>> -    }
>>>>>>> +    virtio_net_add_queue(n, 0);
>>>>>>>        n->ctrl_vq = virtio_add_queue(vdev, 64, 
>>>>>>> virtio_net_handle_ctrl);
>>>>>>>        qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>>>>>>
>>>>>> This change breaks virtio net migration when multiqueue is enabled.
>>>>>>
>>>>>> I think this is because virtqueues are half initialized after 
>>>>>> migration : they are
>>>>>> initialized on guest side (kernel is using them) but not on QEMU 
>>>>>> side (realized has only
>>>>>> initialized one). After migration, they are not initialized by the 
>>>>>> call to
>>>>>> virtio_net_set_multiqueue() from virtio_net_set_features() because 
>>>>>> virtio_get_num_queues()
>>>>>> reports already n->max_queue_pairs as this value is coming from 
>>>>>> the source guest memory.
>>>>>>
>>>>>> I don't think we have a way to half-initialize a virtqueue (to 
>>>>>> initialize them only on
>>>>>> QEMU side as they are already initialized on kernel side).
>>>>>>
>>>>>> I think this change should be reverted to fix the migration issue.
>>>>>>
>>>>>
>>>>> Moreover, if I look in the code of virtio_load() and 
>>>>> virtio_add_queue() we can guess it's
>>>>> not correct to migrate a virtqueue that is not initialized on the 
>>>>> destination side because
>>>>> fields like 'vdev->vq[i].handle_output' or 'vdev->vq[i].used_elems' 
>>>>> cannot be initialized
>>>>> by virtio_load() and neither by virtio_add_queue() after 
>>>>> virtio_load() as fields like
>>>>> 'vring.num' are already initialized by virtio_load().
>>>>>
>>>>> For instance, in virtio_load() we set:
>>>>>
>>>>>       for (i = 0; i < num; i++) {
>>>>>           vdev->vq[i].vring.num = qemu_get_be32(f);
>>>>>
>>>>> and in virtio_add_queue() we search for the firt available queue to 
>>>>> add with:
>>>>>
>>>>>       for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>>>           if (vdev->vq[i].vring.num == 0)
>>>>>               break;
>>>>>       }
>>>>>
>>>>> So virtio_add_queue() cannot be used to set:
>>>>>
>>>>>       vdev->vq[i].handle_output = handle_output;
>>>>>       vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
>>>>>
>>>>> Moreover it would overwrite fields already set by virtio_load():
>>>>>
>>>>>       vdev->vq[i].vring.num = queue_size;
>>>>>       vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
>>>>>
>>>>> It also explains why virtio_net_change_num_queue_pairs() 
>>>>> (indirectly called by
>>>>> virtio_net_set_features()) doesn't update the queue pair numbers: 
>>>>> vring.num is already set
>>>>> so it thinks there is no more queues to add.
>>>>>
>>>>> Thanks,
>>>>> LAurent
>>>>>
>>>>
>>>> I agree.
>>>>
>>>> Laurent, would you like to send a patch to revert this?
>>>>
>>>
>>> Yes. I will also try to fix the leak in unrealize that the patch 
>>> wanted to fix initially.
>>
>> I wrote a fix so I will submit it once internal testing is done. You 
>> can see the change at:
>> https://gitlab.com/akihiko.odaki/qemu-kvm/-/ 
>> commit/22161221aa2d2031d7ad1be7701852083aa9109a
> 
> It works fine for me but I don't know if it's a good idea to add queues 
> while the state is loading.

I couldn't come up with other options. The problem is that the number of 
queues added during realization does not match with the loaded state. We 
need to add queues after knowing the negotiated feature set and before 
loading the queue states to fix this problem.

Reverting will add queues that are used when the multiqueue feature is 
negotiated so it will fix migration for such cases, but will also break 
the other cases (i.e., the multiqueue feature is not negotiated) as it 
adds too many queues.

Regards,
Akihiko Odaki

> 
> Jason, let me know which solution you prefer (revert or pre_load_queues 
> helper).
> 
> CC'ing MST
> 
> Thanks,
> Laurent
> 


