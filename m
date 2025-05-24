Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC569C54E71
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 04:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIgGB-0003GH-Qk; Sat, 24 May 2025 00:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIgG9-0003G4-Ub
 for qemu-devel@nongnu.org; Sat, 24 May 2025 00:13:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIgG6-0004p5-Go
 for qemu-devel@nongnu.org; Sat, 24 May 2025 00:13:21 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso705712b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 21:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748059996; x=1748664796;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wf72flVlRAWJhLOSGPm+KlCRxYrHfvlbf3ZqrrDd/U=;
 b=ULBAd6z3Tax7UNuBhGbWEf7tAch0rwZFE0HFNpe+6DvxTVCD1J9Cz7LgDLgcaYyCGf
 xV5EIHw2o5lyuUEtRLJGuEar8f4eZACDEsAbIuluOarX6RzrMH/NUxbT5fW2lB1kjQ6y
 WAqtLigz4kx9Y/2SBeUmXNV3SAgdStj0mdaZAvcrRqB/Jp6R/UPMNBP0EhP/qasDpHUR
 5HXPReOzKJUl1ENdaOHC0I/JmNyWkCK25uRLiVbRJ38aYSm11i5aNkDbSLL0XVJsDCkq
 GEB3s98Qj5D5sazCJ8a9fOMz0PB4fhI7CiZwaYlVoOrWm2ApUlhTATXb5Es4ito2VwSJ
 hITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748059996; x=1748664796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wf72flVlRAWJhLOSGPm+KlCRxYrHfvlbf3ZqrrDd/U=;
 b=CPkYgbLNEmDrSDwegdbeuBIkWhAjgv6CzPcqMhhEQLSvzIEiFUNiIvKPQxUOP2zuyo
 RaQV5jbsBZH6wOwdFIVDVBLF3RmmD8Mgs9w9JMR8no/qnKNNQHI7m0vHSVZ5Xszab4Ai
 NT2d7b6jiRTv9N4wWX23ABVCNhZ/Zxr/Ggu9wBh88Sr9fLbLGBaPBmoC27Fac47hXimp
 3ZGR1PPKVyuzi7xDQubIbEX7HAq3Ta+nRDi4ued/qXdDUwnGDQf7rnA0jivHN1mnb/O/
 P726PC2Xu/tZD0PBhIsxMIuQ20ShmwRiPj4c0ZIU3oDgpQ5kBElOKXCavf6hYfSui09r
 bPRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF97WDFH6T1EQ5Ou/gHcivc6tkGU0vWxqOpDZke5SpgqKAulilXEP/HhGQg2irsM7eLoMyFRA5sggC@nongnu.org
X-Gm-Message-State: AOJu0YyWSxrXWRzSZc0ZDVzL8Qn2IU9VonkjEbzHltA1j48LI0MWW/ry
 H6V8wW6VpSI5g9bBsND+zIbxmgbSS9tZBDXQuWCBA8T1WqHwaYytusgWAn5qgMlpZz8=
X-Gm-Gg: ASbGnculdM1vHacldU9HvrVK0pbhEyJvMHaaDnHW5GA4olNhYIEnpFE+K1fvgWu4xwY
 8L5xKp4ytAla6zdfFLazh+MS4G7rdrhxO/s5ueTZuRO5ZA1/BZmebcfNuGlVFezoBS6omvdRstv
 m0U0BAMyzJiY667dH47dqwTErHDc6P4jl8sw6o6zf8e0ZssU/4AEuH0jXTCSqCLDiQTUbqw7kMs
 B/u3foZoJnv2lStrOtJArEshzalNhsjgatSuyuA1O4KvYRVCZ4Y5nL2LRf7cKIRle7oRuCE6zJm
 sbA3p2bfIdsMHs8ceFPSyYIIKU2GnxzbW1vXnhBM98qUnI3lX0GJDIDj00gacWiR
X-Google-Smtp-Source: AGHT+IEhU/EqHXq050TcJH7kFm4XwLwg97JsrIWqAI24+iCjMiEl7yM4xaGhOajEaO3Unf71sgsGZA==
X-Received: by 2002:a05:6a00:140f:b0:742:da7c:3f30 with SMTP id
 d2e1a72fcca58-745fe035e87mr2799422b3a.19.1748059995831; 
 Fri, 23 May 2025 21:13:15 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a987150bsm13933446b3a.136.2025.05.23.21.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 21:13:15 -0700 (PDT)
Message-ID: <7963b55e-3f82-4e20-92f4-4324d375d800@daynix.com>
Date: Sat, 24 May 2025 13:13:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/16] net: implement tnl feature offloading
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
 <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
 <0aba4f0d-f6e8-4c46-a183-eebb401c13a2@daynix.com>
 <3277a9a5-10a7-49a9-901d-cdeef503b1d1@redhat.com>
 <6520193c-0a14-4641-8e5f-f9084d264f1c@daynix.com>
 <b68a7715-d8f8-41e0-a4b7-6277b0972f1d@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b68a7715-d8f8-41e0-a4b7-6277b0972f1d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

On 2025/05/23 23:46, Paolo Abeni wrote:
> On 5/23/25 1:35 PM, Akihiko Odaki wrote:
>> On 2025/05/23 19:40, Paolo Abeni wrote:
>>> On 5/23/25 10:16 AM, Akihiko Odaki wrote:
>>>> On 2025/05/21 20:34, Paolo Abeni wrote:
>>>>> @@ -890,6 +915,12 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>>>>>            .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>>>>>            .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>>>>>            .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
>>>>> +#ifdef CONFIG_INT128
>>>>> +       .tnl  = !!(n->curr_guest_offloads &
>>>>> +                  (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)),
>>>>> +       .tnl_csum = !!(n->curr_guest_offloads &
>>>>> +                      (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)),
>>>>
>>>> "[PATCH RFC 14/16] net: bundle all offloads in a single struct" added a
>>>> struct for offloading, but how about passing n->curr_guest_offloads as
>>>> is instead?
>>>>
>>>> It loses some type safety and makes it prone to have unknown bits, but
>>>> omitting duplicate these bit operations may outweigh the downside.
>>>
>>> I *think* that one of the relevant point about the current interface is
>>> that qemu_set_offload() abstracts from the virtio specifics, as it's
>>> also used by other drivers. Forcing them to covert the to-be-configured
>>> offloads to a virtio specific bitmask sound incorrect to me. Possibly I
>>> misread your suggestion?
>>>
>>
>> virtio is also an interface, and we can reuse it for QEMU-internal
>> interfaces too if it is appropriate.
>>
>> That said, the feature bitmask defined by virtio is inappropriate for
>> for qemu_set_offload() because it also contains other features not
>> related to guest offloading. We need an alternative interface, and the
>> current qemu_set_offload() just passes each flag separately.
>>
>> Now, "[PATCH RFC 12/16] virtio-net: implement extended features
>> support." is adding another format that derives from virtio for guest
>> offloading. This format only contains bits related to guest offloading
>> by definition and suits well with qemu_set_offload().
>>
>> Bit names like VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO will imply that it
>> derives from the virtio spec I think this is actually an improvement;
>> the virtio spec have been the definitive document of the offloading
>> features of tuntap, and some features even used the virtio header (so
>> e1000e and igb parse and build virtio headers). These bit names make
>> this relationship between tuntap and the virtio spec explicit.
> 
> Let me check we are on the same page. You are suggesting the following:
> 
> - change set_offload() signature to:
> typedef void (SetOffload)(NetClientState *, uint64_t);
> 
> - define VIRTIO_NET_O_GUEST_<offload> masks for known/supported offload
> in include/net/net.h (including TSO, USO, etc...)
> 
> - adapt the drivers to the above interface.
> 
> - move this patch as series pre-req.
> 
> Am I correct?

Yes, that's what I meant.

Regards,
Akihiko Odaki

