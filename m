Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD2FD0E6CF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nxg-00023J-LI; Mon, 21 Oct 2024 04:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t2nxc-00022x-Tq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:40:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t2nxX-0005ro-BS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:40:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c803787abso31868675ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729500013; x=1730104813;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c1W1/0pL83lFg7E4Jh4v/RVoD9ZlLB1reGMAanO6Gxw=;
 b=0Vk83vANspURXTqwNv6+BjeFiIzyFPZnP5aKfw8uAd+Y/c4IuUB0bHkOveoTNlUesd
 fFbs+1JTc5ATJxBt83+0Qz1K2k8OR3DtJZZXNHrUioLixz1YIq1X70KuTnc3MNVEqjVO
 AGC+HRL/uQZuPgKC7677L2tYL4WzvqZwznBcYYsFXTu1eF1ZQsCf+y0lQ3QaFK5zCoI1
 wxhsCkOostqcL9FuXWdpO26d1Kc2vzSzGwoMtKQWlHR3RSb3Tho6HThbiRM9fPBZ46CX
 KNn4/7j7acWRZf5ZyPJ835M/T5GKrSy0D4Cs0bUTGlvtOU+SYpbbPDz2tVuRteTK0vDg
 6BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729500013; x=1730104813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c1W1/0pL83lFg7E4Jh4v/RVoD9ZlLB1reGMAanO6Gxw=;
 b=BzlCpEtq5VwUhZJG6JwV87hiHc66XnlxQITLEBk90zSl57m4TPTbxaK+I6/3XPMs2t
 n/9tMBTas3iYq3uwNuaI0P967veHem3azuggH7zv7fNZNyTEa5aiZFmSCj5hEouAfx+Z
 IZpkDikdysCQfYBa+Y/P5Yzme7Sw/9zV7dsX8LpadqMcIESV8uBHnPojhhYmxACZCM73
 fa30R9bNc+0yyGR202Rk+cYELF/3+qwgnHysfvgbGwTXo1LCVb3m2QGerd4czALetgo1
 MFGEjPBwfr7ghjadpBJK4MbraVyZxOuDCobNrjV6yQwVgyW1xk4tr9uJyIeJuOMxGPir
 28Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ODz53TyKn8RSG3GDMaf7U1SIfwh5MZDHiyokLZUdou4fDk29AsMKaV8Npbsi0nOIfgPE8EBo0Km3@nongnu.org
X-Gm-Message-State: AOJu0YyLM/LwOhtsg/k43uVcQl7s/g6WxRQTGSc07viwGoRwoR2fGpTm
 jbblx2GHomTBENG2Y10DFFb7QQwxp2vtWJ+DKm2YsZGYLcDQpDOiFaec9IrfUSY=
X-Google-Smtp-Source: AGHT+IFH4jA2Jeg2n24bmfK+CdqCVlah+iGlnpXE1U0LJGFlS7n1PMooQyAwxQykl0E98snbT75djQ==
X-Received: by 2002:a17:902:daca:b0:205:8763:6c2d with SMTP id
 d9443c01a7336-20e5c10c9a5mr159739545ad.9.1729500013023; 
 Mon, 21 Oct 2024 01:40:13 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0e1b9csm20940895ad.233.2024.10.21.01.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 01:40:12 -0700 (PDT)
Message-ID: <2ad0ae6a-8bbf-429a-b762-7b4c452fa600@daynix.com>
Date: Mon, 21 Oct 2024 17:40:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/20] virtio-net: Add only one queue pair when realizing
To: Jason Wang <jasowang@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-9-jasowang@redhat.com>
 <a46a895a-4961-43fa-99d8-3bda7612bb9a@redhat.com>
 <14bcc2cf-f934-4aa3-8cab-21803a930adc@redhat.com>
 <CACGkMEs5P=Gmo4xTbwH1SPTjwjMoeAcK+fiVXQE0BRrRh-hAwg@mail.gmail.com>
 <d186fb3c-a036-4a20-a4e7-33119bd8b4b9@redhat.com>
 <60169858-3930-4490-b42d-d04117ab9abd@daynix.com>
 <bc493771-e507-4027-af76-f9a95e99b81d@redhat.com>
 <002f53e8-501e-4b4d-b1fc-67ec51e3a94f@daynix.com>
 <CACGkMEvfXDbYPX=itXWoNCzAR9tjYKf9DPNyuqsA_VQeXo9DXA@mail.gmail.com>
 <c4b14b61-8853-486c-9ac2-4b5728ecdf4c@daynix.com>
 <CACGkMEvQ8KtU6J6=SqR-t9T+sKMRPBeznGV96KqaV0P5n8MKMA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvQ8KtU6J6=SqR-t9T+sKMRPBeznGV96KqaV0P5n8MKMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

On 2024/10/21 16:23, Jason Wang wrote:
> On Sat, Oct 19, 2024 at 8:38 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/10/18 13:50, Jason Wang wrote:
>>> On Thu, Oct 17, 2024 at 5:42 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/10/17 18:17, Laurent Vivier wrote:
>>>>> On 17/10/2024 11:07, Akihiko Odaki wrote:
>>>>>> On 2024/10/17 16:32, Laurent Vivier wrote:
>>>>>>> On 17/10/2024 08:59, Jason Wang wrote:
>>>>>>>> On Mon, Oct 14, 2024 at 11:16 PM Laurent Vivier <lvivier@redhat.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 14/10/2024 10:30, Laurent Vivier wrote:
>>>>>>>>>> Hi Akihiko,
>>>>>>>>>>
>>>>>>>>>> On 04/06/2024 09:37, Jason Wang wrote:
>>>>>>>>>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>>>
>>>>>>>>>>> Multiqueue usage is not negotiated yet when realizing. If more than
>>>>>>>>>>> one queue is added and the guest never requests to enable
>>>>>>>>>>> multiqueue,
>>>>>>>>>>> the extra queues will not be deleted when unrealizing and leak.
>>>>>>>>>>>
>>>>>>>>>>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the
>>>>>>>>>>> guest doesn't support
>>>>>>>>>>> multiqueue")
>>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>>>>>> ---
>>>>>>>>>>>      hw/net/virtio-net.c | 4 +---
>>>>>>>>>>>      1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>>>>>>>> index 3cee2ef3ac..a8db8bfd9c 100644
>>>>>>>>>>> --- a/hw/net/virtio-net.c
>>>>>>>>>>> +++ b/hw/net/virtio-net.c
>>>>>>>>>>> @@ -3743,9 +3743,7 @@ static void
>>>>>>>>>>> virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>>>>>>>>>          n->net_conf.tx_queue_size =
>>>>>>>>>>> MIN(virtio_net_max_tx_queue_size(n),
>>>>>>>>>>>                                          n->net_conf.tx_queue_size);
>>>>>>>>>>> -    for (i = 0; i < n->max_queue_pairs; i++) {
>>>>>>>>>>> -        virtio_net_add_queue(n, i);
>>>>>>>>>>> -    }
>>>>>>>>>>> +    virtio_net_add_queue(n, 0);
>>>>>>>>>>>          n->ctrl_vq = virtio_add_queue(vdev, 64,
>>>>>>>>>>> virtio_net_handle_ctrl);
>>>>>>>>>>>          qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>>>>>>>>>>
>>>>>>>>>> This change breaks virtio net migration when multiqueue is enabled.
>>>>>>>>>>
>>>>>>>>>> I think this is because virtqueues are half initialized after
>>>>>>>>>> migration : they are
>>>>>>>>>> initialized on guest side (kernel is using them) but not on QEMU
>>>>>>>>>> side (realized has only
>>>>>>>>>> initialized one). After migration, they are not initialized by the
>>>>>>>>>> call to
>>>>>>>>>> virtio_net_set_multiqueue() from virtio_net_set_features() because
>>>>>>>>>> virtio_get_num_queues()
>>>>>>>>>> reports already n->max_queue_pairs as this value is coming from
>>>>>>>>>> the source guest memory.
>>>>>>>>>>
>>>>>>>>>> I don't think we have a way to half-initialize a virtqueue (to
>>>>>>>>>> initialize them only on
>>>>>>>>>> QEMU side as they are already initialized on kernel side).
>>>>>>>>>>
>>>>>>>>>> I think this change should be reverted to fix the migration issue.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Moreover, if I look in the code of virtio_load() and
>>>>>>>>> virtio_add_queue() we can guess it's
>>>>>>>>> not correct to migrate a virtqueue that is not initialized on the
>>>>>>>>> destination side because
>>>>>>>>> fields like 'vdev->vq[i].handle_output' or 'vdev->vq[i].used_elems'
>>>>>>>>> cannot be initialized
>>>>>>>>> by virtio_load() and neither by virtio_add_queue() after
>>>>>>>>> virtio_load() as fields like
>>>>>>>>> 'vring.num' are already initialized by virtio_load().
>>>>>>>>>
>>>>>>>>> For instance, in virtio_load() we set:
>>>>>>>>>
>>>>>>>>>         for (i = 0; i < num; i++) {
>>>>>>>>>             vdev->vq[i].vring.num = qemu_get_be32(f);
>>>>>>>>>
>>>>>>>>> and in virtio_add_queue() we search for the firt available queue to
>>>>>>>>> add with:
>>>>>>>>>
>>>>>>>>>         for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>>>>>>>             if (vdev->vq[i].vring.num == 0)
>>>>>>>>>                 break;
>>>>>>>>>         }
>>>>>>>>>
>>>>>>>>> So virtio_add_queue() cannot be used to set:
>>>>>>>>>
>>>>>>>>>         vdev->vq[i].handle_output = handle_output;
>>>>>>>>>         vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
>>>>>>>>>
>>>>>>>>> Moreover it would overwrite fields already set by virtio_load():
>>>>>>>>>
>>>>>>>>>         vdev->vq[i].vring.num = queue_size;
>>>>>>>>>         vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
>>>>>>>>>
>>>>>>>>> It also explains why virtio_net_change_num_queue_pairs()
>>>>>>>>> (indirectly called by
>>>>>>>>> virtio_net_set_features()) doesn't update the queue pair numbers:
>>>>>>>>> vring.num is already set
>>>>>>>>> so it thinks there is no more queues to add.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> LAurent
>>>>>>>>>
>>>>>>>>
>>>>>>>> I agree.
>>>>>>>>
>>>>>>>> Laurent, would you like to send a patch to revert this?
>>>>>>>>
>>>>>>>
>>>>>>> Yes. I will also try to fix the leak in unrealize that the patch
>>>>>>> wanted to fix initially.
>>>>>>
>>>>>> I wrote a fix so I will submit it once internal testing is done. You
>>>>>> can see the change at:
>>>>>> https://gitlab.com/akihiko.odaki/qemu-kvm/-/
>>>>>> commit/22161221aa2d2031d7ad1be7701852083aa9109a
>>>>>
>>>>> It works fine for me but I don't know if it's a good idea to add queues
>>>>> while the state is loading.
>>>>
>>>> I couldn't come up with other options. The problem is that the number of
>>>> queues added during realization does not match with the loaded state. We
>>>> need to add queues after knowing the negotiated feature set and before
>>>> loading the queue states to fix this problem.
>>>>
>>>> Reverting will add queues that are used when the multiqueue feature is
>>>> negotiated so it will fix migration for such cases, but will also break
>>>> the other cases (i.e., the multiqueue feature is not negotiated) as it
>>>> adds too many queues.
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>
>>> I wonder if the following is much more simpler:
>>>
>>> 1) introducing booleans whether the queue has been deleted
>>> 2) in unrelize, deleted only the queue that has not been deleted
>>
>> The memory leak problem is trivial to solve, but the problem with queue
>> state loading is not. We need to ensure the number of queues are
>> consistent with the number of loaded queues.
>>
>> We currently have too few queues if the multiqueue feature is
>> negotiated, which results in queues partially initialized with the
>> loaded state. Reverting will leave too many queues for the cases where
>> the multiqueue feature is not negotiated, which is also problematic
>> because virtio-net will reconfigure queues to reduce the number of
>> queues and dispose loaded states.
> 
> I'm not sure I would get here, if those queues were not visible to
> drivers. Why do we care?

We also need to reconfigure controlq, which is visible to drivers, and 
invalidate its loaded state. virtio_net_change_num_queue_pairs() has the 
following comment:
 > We always need to remove and add ctrl vq if
 > old_num_queues != new_num_queues. Remove ctrl_vq first,
 > and then we only enter one of the following two loops.

Regards,
Akihiko Odaki

