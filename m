Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6964EC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIPPp-0002CQ-Bg; Fri, 23 May 2025 06:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIPPn-0002C0-2G
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:14:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIPPk-0001uZ-O4
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:14:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so7012548b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747995247; x=1748600047;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TgJYSl9bVviVQAmYdw6fpWcTNcQNdQIal5umXeWgRdg=;
 b=GIA3pfj1poFM5dc4+C9vc4C25dkMofx5DCVQf6M/p8xJe8VoF6/EiIwfxb9PfMLPKH
 yM9nNW4SbQ+/jad4BrJBb06DrCERSMbMsKND/Ri2YzG+NvKID9POz/89wUnAq2esWBSU
 Kd77lc7+5hiM39/5Ql37GakpMhfYx3W35tRn798IjcmcnfpuvLCkVAn0hhYJ03hG/onq
 7MZ/Pe7DBmh+P16uLiTG+sckEuOoXtHgt94uqOSh65TjKZ0fBSH76I3ddhEY8fxiuWg3
 KbQoU2uWfWfGg6MKlS7OIskybwznI6f1hT3QIDtRWVWvXnhWT8DFOjsGQ2kA4SxrFuJ0
 MOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747995247; x=1748600047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TgJYSl9bVviVQAmYdw6fpWcTNcQNdQIal5umXeWgRdg=;
 b=V/+OtmdLQromSoERaO8EETozDkBoSwJUZd7+aaz4y2AWO6adv86c5hqk92WhX4uo+a
 V+ADEwZTCafnuDMpiSmO5XA5cOQ5bBbxYzkR9/4FtkI9isy2Af/LwTNTtVGiOvgZfDYm
 UQQJqaOa2JM22l/4xBsTDondAPy9rY4AHm5Q9twmxbn7gA6LIF3X0UHYXO19EME364JL
 gEhPpMU8iMiy9QoKuhalLBeNf0oxuNyq6mZtlTzyEk0cKJEbDZvHGM8Vlu9bB2mt7g2X
 8juaYJVTJ8FiT6vA5+53+FhLZbgvVtepDeZjnDDN9gFH2ClRHqJcUTMgREE75P/PQYVY
 Qsng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEMiJtyJynWsbSYr6heDWLy2hnYTPH94Pbm02QH8aSPDPR3PFTtEHaZmN7qoRz6EpXameqCUS2ra+i@nongnu.org
X-Gm-Message-State: AOJu0Yw9ifRuogVKGoPEvUcWJwhQ3Fc0KiW3GWL5ObztkTbhktvfNFR+
 j+R7RBwmZPAHUeaq3Ldw5kiE/xtTnS09zwL74rTRJPPKQQS2v0uuCCT5e2VmKd54xTI=
X-Gm-Gg: ASbGncvgBLrUmjEIsdRtTl5Z8Q2p+4DhnPYUjgQARy+2kPS6wvlgopq41LIhg8GjXfR
 UxVJtb8tQlfuliJJhTRZ4aM1ESNqDeSayJVclVXjThfLL8cJnNmh2vRY1KAMnRAe8kj58k0Riop
 7fyzCbYHvSXuZCzTep8HTeKxNOAcJ4QGqrM+IEQmX5KlAyGkUWGwcMC8jlBKCTwWtA3Hmuxw4qd
 1LU4aPI2MccoNLeFQ9+vkS3pH6mExfQ9T7FMfU4DuhZ8+AhVHRo1V3yvVpf4LVsJ/rjeYSczXnL
 QbfBiCnNwLo4047yM/i63LlOK/v9T4EGcgIV40XWtW3oQKimciADGeHdfxM2pA==
X-Google-Smtp-Source: AGHT+IFd0+d5ItBajCrl8Gm1fLGRo0Bfvk4aK4XP5oGqrCy44vfEsyxYRzPDnspUD8b5Bb+2I/O7Yw==
X-Received: by 2002:a05:6a00:124d:b0:742:362c:d2e4 with SMTP id
 d2e1a72fcca58-742acc8ff66mr34374900b3a.5.1747995246650; 
 Fri, 23 May 2025 03:14:06 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96e58a9sm12528495b3a.34.2025.05.23.03.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 03:14:06 -0700 (PDT)
Message-ID: <25df923a-33b4-4593-a754-f3a92c8e7fb3@daynix.com>
Date: Fri, 23 May 2025 19:14:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/16] virtio-net: implement extended features support.
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <8fb9f142e25a0f1b01e8cf54a6c2a0971db00d83.1747825544.git.pabeni@redhat.com>
 <f598f776-e852-442c-a7c7-077d74b33503@daynix.com>
 <0c0efab7-826b-4759-b322-453a10499606@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <0c0efab7-826b-4759-b322-453a10499606@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

On 2025/05/23 19:01, Paolo Abeni wrote:
> On 5/23/25 10:09 AM, Akihiko Odaki wrote:
>> On 2025/05/21 20:34, Paolo Abeni wrote:
>>> Use the extended types and helpers to manipulate the virtio_net
>>> features.
>>>
>>> Note that offloads are still 64bits wide, as per specification,
>>> and extended offloads will be mapped into such range.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>    hw/net/virtio-net.c            | 87 +++++++++++++++++++++-------------
>>>    include/hw/virtio/virtio-net.h |  2 +-
>>>    2 files changed, 55 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 9f500c64e7..193469fc27 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -90,6 +90,17 @@
>>>                                             VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
>>>                                             VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
>>>    
>>> +#define VIRTIO_OFFLOAD_MAP_MIN    46
>>> +#define VIRTIO_OFFLOAD_MAP_LENGTH 4
>>> +#define VIRTIO_OFFLOAD_MAP        MAKE_64BIT_MASK(VIRTIO_OFFLOAD_MAP_MIN, \
>>> +                                                VIRTIO_OFFLOAD_MAP_LENGTH)
>>> +#define VIRTIO_FEATURES_MAP_MIN   65
>>> +#define VIRTIO_O2F_DELTA          (VIRTIO_FEATURES_MAP_MIN - \
>>> +                                   VIRTIO_OFFLOAD_MAP_MIN)
>>> +
>>> +#define VIRTIO_FEATURE_TO_OFFLOAD(fbit)  (fbit >= 64 ? \
>>> +                                          fbit - VIRTIO_O2F_DELTA : fbit)
>>> +
>>
>> These are specific to virtio-net but look like they are common for
>> virtio as the names don't contain "NET".
>>
>> VIRTIO_FEATURES_MAP_MIN is also a bit confusing. It points to the least
>> significant bit that refers to an offloading feature in the upper-half
>> of the feature bits, but the name lacks the context.
> 
> Uhmmm... putting the whole context in the macro name sounds very verbose
> and/or hard, what about:
> 
> How about VIRTIO_NET_OFFLOAD_MAPPED_MIN
> 
> ?

It looks like it represents a bit in the 64-bit mapping 
(VIRTIO_OFFLOAD_MAP) instead of a feature bit as it contains "MAPPED" 
while it doesn't contain "FEATURE".

Perhaps VIRTIO_OFFLOAD_MAP is the one that is confusing. As it is 
intended to be a compact 64-bit representation, how about:

VIRTIO_OFFLOAD_MAP -> VIRTIO_NET_OFFLOAD64
VIRTIO_FEATURE_TO_OFFLOAD -> VIRTIO_NET_FEATURE_TO_OFFLOAD64
VIRTIO_FEATURES_MAP_MIN -> VIRTIO_NET_OFFLOAD_FEATURE_MIN

> 
>> @@ -862,13 +881,13 @@ static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
>>>            (1ULL << VIRTIO_NET_F_GUEST_USO4) |
>>>            (1ULL << VIRTIO_NET_F_GUEST_USO6);
>>>    
>>> -    return guest_offloads_mask & features;
>>> +    return guest_offloads_mask & virtio_net_features_to_offload(features);
>>
>>
>> How about:
>>
>> static const virtio_features_t guest_offload_features_mask = ...
>> virtio_features_t masked_features = guest_offload_features_mask & features;
>>
>> return masked_features | ((masked_features >> VIRTIO_FEATURES_MAP_MIN)
>> << VIRTIO_OFFLOAD_MAP_MIN);
>>
>> This makes virtio_net_features_to_offload() unnecessary.
> 
> The above looks a little fragile, as (in future) 'features' could have
> some bit in the mapped range set (and not representing a guest offload):
> we need to explicitly mask such bits out before the first '&' operator.
My suggestion is to mask all feature bits that don't represent guest 
offloading first. masked_features should only contain guest offload 
features.

Regards,
Akihiko Odaki

