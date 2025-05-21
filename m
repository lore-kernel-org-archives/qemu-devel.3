Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51064C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 03:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHaUL-0002f4-QW; Tue, 20 May 2025 23:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHaUJ-0002ep-9j
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:51:27 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHaUG-0002nK-1C
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:51:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso5583975b3a.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 20:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747799482; x=1748404282;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZKPfEkqbMC3Fn67c4OgivPjzVU/E6vlO8f69b9MnPk=;
 b=QSoQUsELRCTVnkzoBzJKmSWwc+HN2D9JBAbL8KMKbS+NR0DtSZRavIk1lhoHYIA3Js
 z0KXPqsBSkV6KGIFsiO92wE5bYmF0Yst0A9C+fFwgN9FKfxMBaAp/qmexMd484iU4MMk
 hu6XNiCe0SCMIYloDdDgRqhz8ReYjrC3k1pRE6AmGVDBX+cxKDh449s48E72NxQjTLmn
 ACnfc67YCS8Z8JpMMFEfV5VWgRyAn50KrUcjpttWeXFdS4vgCYocMMOXzXY4YWlszHf5
 bTpd2mtrAxt/l9Ng+eFJSHzlrK9eFTnX0GkXNxnwyxnHQMJU/5d+Itw7HRr4mPpsTX+Q
 a/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747799482; x=1748404282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bZKPfEkqbMC3Fn67c4OgivPjzVU/E6vlO8f69b9MnPk=;
 b=THKNmcIinzl1O+5iv7ql0TSbetfI3Vhc3erW9YhMOJhXKtEWP/UuURECB/CgOlzZVb
 GntLjJnSCr69XSt30/udjXY3Nrdp/8ygv1Mw5bXNCZlQmb4Si1a/noCqHFckM+Cq23Im
 6Q26SjUfFHn/p/0LGKMcUQfN5abP/6ASh4ay6VGBrF7+q+f+0obuC8nb8XzzEcohfXDW
 M46DqxWZoNpDiKyTPTiWf0uZH0jBkAn2ylX4u58dz2+DXEELacXHiSXeabJjSlGTTPVq
 Hlifp6Ds8uOgvcgyWar741PV+o9kPPzZ0molh8QwMKxm2Rg06rPJKKcavW5XUR8H1yqY
 zyMw==
X-Gm-Message-State: AOJu0Yx4T2qfnx3FKU+gZwzV8RfSnIpy5fpLzGoSGh2wB8Dk4tuDP1x4
 P+rbGgOlf5TSzxoA9F5tDS0mjDVgYuNU9kkuZ2GYjXbc3Gn0lsZHgrnXRHaAG0PlSOA=
X-Gm-Gg: ASbGncuCybABcccvf0kY+wRo8I46DmQ6+XU1obLUtX1M0OgHvlwFiAR0BWe12M5oR0T
 cy+lzyaQcaNBa0a9Td3mHAclE2Fp62QI1OzlYubKezWLuiU9U+n1NpZO8nLFpjy6Tg677nVnvV9
 +B6w1PHFOR7nEni5fQhz84D62Ht4943EyK1m3tXU4BmkOKR+O90pCeihqdFjt7Y8IZl23werMwS
 gzNEETXjwWYJ1sj7c9pS/aslYTCd5/EZikYOb4mpAq5hPO1Xr0zbNGc/eM1xzZTTrZ81vj0M/Tj
 LrPkem3fWxiJVEMIwmja6Ipnv4nAnCcLkRmESl0MllB/iNW4XJmXEItWB4ymKejE4COHUhGs
X-Google-Smtp-Source: AGHT+IFbDjK4CSmEznpP+P9uyF88RW5RF4IBisQaKGRPgWzSaScl2LyRyc5Bw502kO0Nk8RosyrtZg==
X-Received: by 2002:a05:6a00:a88f:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-742a98a32e1mr20410237b3a.17.1747799481912; 
 Tue, 20 May 2025 20:51:21 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm8647580b3a.164.2025.05.20.20.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 20:51:21 -0700 (PDT)
Message-ID: <f299600a-cf0b-47e4-85d1-5c3d1b4eaef0@daynix.com>
Date: Wed, 21 May 2025 12:51:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
 <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
 <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
 <CACGkMEu_hyc-mP4zk9kJprCpFQbVzO0D2SEMy9eid5TmUH7Uaw@mail.gmail.com>
 <7f1c31de-de22-4290-a4fd-44e523477ca5@daynix.com>
 <CACGkMEsPb6TdT5qx9CkNOeT3ScJmS8_-FDjGh916fi8pWkuxNQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsPb6TdT5qx9CkNOeT3ScJmS8_-FDjGh916fi8pWkuxNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

On 2025/05/21 9:51, Jason Wang wrote:
> On Fri, May 16, 2025 at 11:29 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/05/16 10:44, Jason Wang wrote:
>>> On Wed, May 14, 2025 at 2:58 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
>>>>> On Sat, May 10, 2025 at 3:24 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
>>>>>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
>>>>>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
>>>>>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
>>>>>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
>>>>>> VIRTIO_NET_F_MQ uses bit 22.
>>>>>>
>>>>>> Instead of inferring the required number of queues from
>>>>>> vdev->guest_features, use the number loaded from the vm state.
>>>>>>
>>>>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> ---
>>>>>>     include/hw/virtio/virtio.h |  2 +-
>>>>>>     hw/net/virtio-net.c        | 11 ++++-------
>>>>>>     hw/virtio/virtio.c         | 14 +++++++-------
>>>>>>     3 files changed, 12 insertions(+), 15 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>>>> index 638691028050..af52580c1e63 100644
>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
>>>>>>         int (*start_ioeventfd)(VirtIODevice *vdev);
>>>>>>         void (*stop_ioeventfd)(VirtIODevice *vdev);
>>>>>>         /* Called before loading queues. Useful to add queues before loading. */
>>>>>> -    int (*pre_load_queues)(VirtIODevice *vdev);
>>>>>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
>>>>>
>>>>> This turns out to be tricky as it has a lot of assumptions as
>>>>> described in the changelog (e.g only lower 32bit of guest_features is
>>>>> correct etc when calling this function).
>>>>
>>>> The problem is that I missed the following comment in
>>>> hw/virtio/virtio.c:
>>>>        /*
>>>>         * Temporarily set guest_features low bits - needed by
>>>>         * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>>>>         * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
>>>>         *
>>>>         * Note: devices should always test host features in future - don't
>>>> create
>>>>         * new dependencies like this.
>>>>         */
>>>>        vdev->guest_features = features;
>>>>
>>>> This problem is specific to guest_features so avoiding it should give us
>>>> a reliable solution.
>>>
>>> I meant not all the states were fully loaded for pre_load_queues(),
>>> this seems another trick besides the above one. We should seek a way
>>> to do it in post_load() or at least document the assumptions.
>>
>> The name of the function already clarifies the state is not fully
>> loaded. An implementation of the function can make no assumption on the
>> state except that you can add queues here, which is already documented.
> 
> Where? I can only see this:
> 
>      /* Called before loading queues. Useful to add queues before loading. */

I meant it is documented that it can add queues. There is nothing else 
to document as an implementation of the function can make no assumption 
else.

> 
>>
>>>
>>>>
>>>>>
>>>>> Looking at the commit that introduces this which is 9379ea9db3c that says:
>>>>>
>>>>> """
>>>>> Otherwise the loaded queues will not have handlers and elements
>>>>> in them will not be processed.
>>>>> """
>>>>>
>>>>> I fail to remember what it means or what happens if we don't do 9379ea9db3c.
>>>>
>>>> The packets and control commands in the queues except the first queue
>>>> will not be processed because they do not have handle_output set.
>>>
>>> I don't understand here, the VM is not resumed in this case. Or what
>>> issue did you see here?
>>
>> Below is the order of relevant events that happen when loading and
>> resuming a VM for migration:
>>
>> 1) vdc->realize() gets called. virtio-net adds one RX queue, one TX
>> queue, and one control queue.
>> 2) vdc->pre_load_queues() gets called. virtio-net adds more queues if
>> the "n" parameter requires that.
>> 3) The state of queues are loaded.
>> 4) The VM gets resumed.
>>
>> If we skip 2), 3) will load states of queues that are not added yet,
>> which breaks these queues and packets and leave control packets on them
>> unprocessed.
> 
> Ok, let's document this and
> 
> 1) explain why only virtio-net requires the pre_load_queues (due to
> the fact that the index of ctrl vq could be changed according to
> #queue_paris)

We would need this logic even if the index of ctrl vq didn't change. We 
need it because virtio-net have varying number of queues, which needs to 
be added before loading.

> 2) the commit also fixes the issue that changing the TAP queue pairs twice

Commit 9379ea9db3c makes it change the TAP queue pairs once more. This 
patch reverts it, but that doesn't matter because the operation is 
idempotent.

More concretely, before commit 9379ea9db3c, we had two points that 
updates the TAP queue pairs when loading a VM for migration:
1) virtio_net_set_features()
2) virtio_net_post_load_device()

Commit 9379ea9db3c added a third point: virtio_net_pre_load_queues().
This patch removes the third point by avoid calling 
virtio_net_set_queue_pairs(), which is a nice side effect.

Regards,
Akihiko Odaki

