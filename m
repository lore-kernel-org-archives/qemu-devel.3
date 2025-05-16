Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB96C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 03:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFllL-0003cN-W9; Thu, 15 May 2025 23:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFllK-0003YW-IU
 for qemu-devel@nongnu.org; Thu, 15 May 2025 23:29:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFllI-000565-6D
 for qemu-devel@nongnu.org; Thu, 15 May 2025 23:29:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7423df563d6so1766047b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 20:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747366166; x=1747970966;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j44xjdTIkX8CsMJXcewAO0pesnCIjMR1uV90sEHmW8I=;
 b=zwgL8Id1DVhP0v59kkANvdqkPtBU0iPltzUYFLXJkbJqTLc5QbhiHpK/5l+sj8Qukm
 WaVN5gjfOe4eJcErz39Re2n5Fr8I6mCFb2dZwt2pjYjm6NfxixMsDhehfxN3uiD+72mQ
 Tw8FsX8XnNLoNiTmF/t1N3q8jcf40QEnR8aPmbtU0zy1aYDBoV9jZf69UV7A3nPvqpJo
 z/LB3r64L11/aN74g6HX6vUYrxJlKZAO2z1yOY6fhvH2Qdw7RLmjOW9fh5+SCc4wy6vS
 KdS/LN9xcyx+ZwzKu5J+h2bAUNzBBAvv+a50RI3JrjxQp9Y304nqEvRPoGTBBjYVpGr7
 muVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747366166; x=1747970966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j44xjdTIkX8CsMJXcewAO0pesnCIjMR1uV90sEHmW8I=;
 b=o5myXFArpwTjZ02kyamzLMeHvbmfgSzntpz2Vg88R5cXSoN9gK3o49ARXiiO5diIWv
 WQo9cUfYY0V+x2mUM8iclquTmMx1iPLWYW6++epS6b+jR7jK0DuAHSSzTwaB6R0oL17I
 kQ0mKns1Kn4tukgwy7vdw38gPXgb09rihDfrIkPfDWRSrgybEjxnkW0fcMArv6wYNbHv
 5AeijVSXWjQJ3/gBmVxR0cVJwLPp2gEH6I/fN0Iz2gcA+wfrR8nIQ+YT6xZs0uJNKDYF
 RFiJwDGYaV/OduhD/gR1ZgJ7JLomBlQaE3+yneF0yK2L6D1tPmM9lSHsneEyyYcUAdQp
 cmUQ==
X-Gm-Message-State: AOJu0YywxfwEy19CWYYPUhVL3KNcBAgop9lGYkH00MkZEsVvx+Wmajan
 HhZnSFbYtqNMpeJlrStx3UN2ft+osTFLxF7jYJVmRxfEzYdmoFw//y1XK8sHVq1VHrvWeKparjx
 TKqfU
X-Gm-Gg: ASbGncv1p3rhaqAAn7VR/29UqucZ3CjCj09RFWJ3dIpTz4KljKCvOIdy/7K3l/g1tyR
 CSN5Vxe3CKKT4iuX5UCGHQ9ZvGSVQBZjJgsfGUy2udaRPv6oKLT//SAXJbrY46F+7L4C/ocVXCc
 eKQYmgTv123CXgibSP+iRP9wbuC/RZkmuSigwbn3Se7oX2KgO6nUYo9w/8SsBS442QYBQ/07yH8
 9eP0qX0yHyUV0KyWpLaGk2my2/eOXUP7XYcAsnwW+BrTZPWKEjoVVp22q7VH7ZL49UUNBnDMRHx
 5ztFpgjmkDegseNJqYkTn9A0CBlchvVV3BMf5dt0Hybz1fXDLe2QkTEhLmlTJr50
X-Google-Smtp-Source: AGHT+IH7q9Hi7FNmSkW9Wzl4Hr2Z6G5SHSr2xGsqaUS1jV26+AJ9iotAtvmi/5zifhDwzHRxgUI0Kg==
X-Received: by 2002:a05:6a20:6a10:b0:215:edce:4e2c with SMTP id
 adf61e73a8af0-216219d3976mr2632059637.28.1747366165754; 
 Thu, 15 May 2025 20:29:25 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970b6a1sm571139b3a.40.2025.05.15.20.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 20:29:25 -0700 (PDT)
Message-ID: <7f1c31de-de22-4290-a4fd-44e523477ca5@daynix.com>
Date: Fri, 16 May 2025 12:29:22 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu_hyc-mP4zk9kJprCpFQbVzO0D2SEMy9eid5TmUH7Uaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

On 2025/05/16 10:44, Jason Wang wrote:
> On Wed, May 14, 2025 at 2:58 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
>>> On Sat, May 10, 2025 at 3:24 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
>>>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
>>>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
>>>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
>>>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
>>>> VIRTIO_NET_F_MQ uses bit 22.
>>>>
>>>> Instead of inferring the required number of queues from
>>>> vdev->guest_features, use the number loaded from the vm state.
>>>>
>>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    include/hw/virtio/virtio.h |  2 +-
>>>>    hw/net/virtio-net.c        | 11 ++++-------
>>>>    hw/virtio/virtio.c         | 14 +++++++-------
>>>>    3 files changed, 12 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>> index 638691028050..af52580c1e63 100644
>>>> --- a/include/hw/virtio/virtio.h
>>>> +++ b/include/hw/virtio/virtio.h
>>>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
>>>>        int (*start_ioeventfd)(VirtIODevice *vdev);
>>>>        void (*stop_ioeventfd)(VirtIODevice *vdev);
>>>>        /* Called before loading queues. Useful to add queues before loading. */
>>>> -    int (*pre_load_queues)(VirtIODevice *vdev);
>>>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
>>>
>>> This turns out to be tricky as it has a lot of assumptions as
>>> described in the changelog (e.g only lower 32bit of guest_features is
>>> correct etc when calling this function).
>>
>> The problem is that I missed the following comment in
>> hw/virtio/virtio.c:
>>       /*
>>        * Temporarily set guest_features low bits - needed by
>>        * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>>        * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
>>        *
>>        * Note: devices should always test host features in future - don't
>> create
>>        * new dependencies like this.
>>        */
>>       vdev->guest_features = features;
>>
>> This problem is specific to guest_features so avoiding it should give us
>> a reliable solution.
> 
> I meant not all the states were fully loaded for pre_load_queues(),
> this seems another trick besides the above one. We should seek a way
> to do it in post_load() or at least document the assumptions.

The name of the function already clarifies the state is not fully 
loaded. An implementation of the function can make no assumption on the 
state except that you can add queues here, which is already documented.

> 
>>
>>>
>>> Looking at the commit that introduces this which is 9379ea9db3c that says:
>>>
>>> """
>>> Otherwise the loaded queues will not have handlers and elements
>>> in them will not be processed.
>>> """
>>>
>>> I fail to remember what it means or what happens if we don't do 9379ea9db3c.
>>
>> The packets and control commands in the queues except the first queue
>> will not be processed because they do not have handle_output set.
> 
> I don't understand here, the VM is not resumed in this case. Or what
> issue did you see here?

Below is the order of relevant events that happen when loading and 
resuming a VM for migration:

1) vdc->realize() gets called. virtio-net adds one RX queue, one TX 
queue, and one control queue.
2) vdc->pre_load_queues() gets called. virtio-net adds more queues if 
the "n" parameter requires that.
3) The state of queues are loaded.
4) The VM gets resumed.

If we skip 2), 3) will load states of queues that are not added yet, 
which breaks these queues and packets and leave control packets on them 
unprocessed.

Regards,
Akihiko Odaki

