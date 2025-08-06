Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D4CC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhh7-0007iO-QY; Wed, 06 Aug 2025 13:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujhKE-0005BP-Gu
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:49:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujhKB-0002Fu-5L
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:49:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so1167775e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754498948; x=1755103748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QM3QwiO1NJe3GKnsbAAnUZTy4SP7OQgvkiQ12EiRCAI=;
 b=g4MZsIjBKsOVBbx8aYiLXUee3OhrEDC0wnAZTn5uPBNvxk9rhjAjD4wa8pIzfFzvoN
 xJL+wVMTmeivnKpQq6kv4l67JP8iL0VK2730rc69O9oJBZWEQK2obbf3LDVThei0hP7p
 hZdAHjW4gpA4J/o87jOc4LyUepemWZS1/a/7Rk7PftlqgtEkZbp86NCcGmiKrOwl/RIf
 YRHU6COEpQm8m8j7f267+4hr+6r86/AJdq5TwPebHjve9Go7D0sRCx8zfXCzvTpgDVVR
 Zx6t+oVmLRK/gIff4nle9MejHNUcETNnt8yjBbzgQSe/oThODTWw+qasMGP5mIZJafoM
 a/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754498948; x=1755103748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QM3QwiO1NJe3GKnsbAAnUZTy4SP7OQgvkiQ12EiRCAI=;
 b=GWH+jat5ygqc8Lku/b+p+VIy21kV5JTweNO+VexzS9TZIpHX8tsSvUWrhW2NYSwww6
 +wN/NLJ3DzDCUY3EXMh3RFziFXsILRp3uPNpEPe/3u69W0P6j8jBToK8Th50ys3BP3+u
 l7gU5BZoG+FVni2sBhGoA0L6jNrFdHGlUlc9o6ihd49gm3F3pPBsIdu9Yf4LFI0U3Bwk
 Qmtm7oWDTDML0UpKJ/mt5v1txMjaXXZj0566TdC8lAz00mCdAXIyI/bzHZmcPbZ2V0f7
 kOI10Put5796PnxzfAFpo7lGcE8MR3IQ+x50i275ncbIWX82viB9SCvK/g6rbDX8T0ur
 Zveg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/Ggv8lGCY6hV9WYEsV41UJ2f7rYzevEsZjZqu0pMqSKCGk1oqGI6/xyeaUY4B1rZLFBuyc1vUV2j@nongnu.org
X-Gm-Message-State: AOJu0Yzw9jNMsR6LCHceC4jKxlOwrnfX86LYIt1eNEEBoIvggu8tzg5Q
 zQMREBp+8awTV2MVzvAmfIPsomNLT4/gG6InvbG+IsAvQ/aJFWQwkPTJj7LeElbaRRELwdxFf8k
 8oHrd
X-Gm-Gg: ASbGncvnXjQsOSzvYghrMaHkNzsyNWry7c9cfjd/CEE/YLPrTwqvKccwzxPBXeHORDY
 KLNr9oZz2eY6rHMIho3A3TbfDghVG4RW7ZJcGVD6HWXqQJb4toTyKdEoGPo1wuYUY1pyJ0DZ+bi
 U1H6RsWLJqOc+kn2irOUji8ZHf03YA0QVxJlMrSWgVge6zrf+Fwfis8OmetSG/YQ62VUltVbqZV
 Rk6bfN1wvnURVQ40+2lSj6OKB4xbjQzhWGBghUnecqj1pYOjGwTINGOgGxCWpwXug/2Jt5EGUYe
 6LN7iQSVgLoq46DWEN4D0rXnKtU+pQn3vK89f4N70YZZfmHjKC6GCEbfMKqmxoB9TkgXBTh66em
 ca6iMjKge51HMvDTES52UzGz9T9laHE/Dq2rl2eMMAAm5gDuynEKTnJYZR++sP80Hf2q1oHGDJe
 uc
X-Google-Smtp-Source: AGHT+IEDaucHpuT4xCT/H7TWuNI38HvtD8TqOoCHL1bIyYA4NWGdeXw4cw+cieSSzFd1Ew4KWE+xHg==
X-Received: by 2002:a05:6000:2dc5:b0:3b8:d0bb:7541 with SMTP id
 ffacd0b85a97d-3b8f41ad96emr3026127f8f.40.1754498948408; 
 Wed, 06 Aug 2025 09:49:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c489e81sm23860656f8f.68.2025.08.06.09.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 09:49:07 -0700 (PDT)
Message-ID: <2af1d5fb-fb74-4263-83f1-c23eb25757ab@linaro.org>
Date: Wed, 6 Aug 2025 18:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-net: make VirtIONet.vlans an array instead of
 a pointer
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <4eff3371-542c-43bc-a4aa-e58ceb369d1e@tls.msk.ru>
 <1904c947-151b-46bb-bc66-109d258c18df@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1904c947-151b-46bb-bc66-109d258c18df@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/8/25 09:38, Akihiko Odaki wrote:
> On 2025/08/02 23:45, Michael Tokarev wrote:
>> On 02.08.2025 17:21, Michael Tokarev wrote:
>>> This field is a fixed-size buffer (number of elements is MAX_VLAN,
>>> known at build time).  There's no need to allocate it dynamically,
>>> it can be made an integral part of VirtIONet structure.
>>>
>>> This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.
>>>
>>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>>> ---
>>>   hw/net/virtio-net.c            | 8 +++-----
>>>   include/hw/virtio/virtio-net.h | 2 +-
>>>   2 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> @@ -3524,7 +3524,7 @@ static const VMStateDescription 
>>> vmstate_virtio_net_device = {
>>>            * buffer; hold onto your endiannesses; it's actually used 
>>> as a bitmap
>>>            * but based on the uint.
>>>            */
>>> -        VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN 
>>> >> 3),
>>> +        VMSTATE_BUFFER(vlans, VirtIONet),
>>
>> This doesn't compile.  And I can't figure out, so far, what's needed
>> here :)
> 
> The type check is failing because VMSTATE_BUFFER() expects an array of 
> uint8_t but it is an array of uint32_t.
> 
> Now I get why it used an "UNSAFE" macro. We should usually use 
> VMSTATE_UINT32_ARRAY() instead, but we need "BUFFER" for compatibility, 
> so it needed the "UNSAFE" variant to disable the type check.
> 
> Fortunately there is a variant that is "BUFFER" and "UNSAFE" but not 
> "POINTER". So this should be:
> VMSTATE_BUFFER_UNSAFE(vlans, VirtIONet, 0,
>                        sizeof(typeof_field(VirtIONet, vlans)))

Nice.


