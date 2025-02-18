Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07130C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 14:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkOBt-0001t5-Tq; Tue, 18 Feb 2025 09:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkOBm-0001rW-LR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:03:06 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkOBj-0002Lw-Bp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:03:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4396f579634so18804565e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 06:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739887381; x=1740492181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3evwv5LJ4stZxP5DRWSKF7lZmOAEVQm3rHkI99eJb3Y=;
 b=gJUYp+IEV1KCFrVMufWKjbKROYf/q046KpLUVmrTs/7ejZdbre3n4vkL0sukGN5L+o
 UnKGxr74QAevEsWgDlV64dFZFEWfeXJUJPkTo6rv/8CtfaKxHBAME/1lZdMJRhbtAxuj
 aJSs2ZPkypeD0ydqXzTyqFm9l3df+BnavXKusMPslaxu/NCejIM7E83bRL6yjrq0odue
 6UiVjvXhNNw4x7n0ITzmhMZz/lBPQQZMU4iCKl9JYCBlSaguUWYonJRRxlOOlUMdYDQH
 dHIk2Ep8n1/BnjaQxsYAxR0qDDhh0sITE+m0fq1RvH+2yeK2It7jgS3FGDttQFxdjN0n
 dV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739887381; x=1740492181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3evwv5LJ4stZxP5DRWSKF7lZmOAEVQm3rHkI99eJb3Y=;
 b=eCOcbvZg8KwQDPEvQFj2Hi5fl37R2r8VOZsNNuLib0dAUP2t60hIku30bH+utsfPCd
 Uqb86fjjMGxtcgH7nW0usYbFkW+EpUqmg6drnGO7H1iHNZaBjw78LpExkTsh+a0NXv0y
 Ig0p8VRbi/dK5zubHv4KvlD+xEigC0b4PnE63wdj6VAgV+d4Y/qkNMaXY9F5n5Bq/koA
 tOUGelMC6WlFf2rYPxN2srbgzC6B9sEAhvVX/po2M5YLT0/2eVrPjebkq6FCGAnnwf6f
 sW5pkrQYHtqkl0QBJxXLFHlQ9I2nxnsB8r9cVTXT5uDPcmTnrUrpncqOuPIr/pw2xSKA
 DZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHynEr6uE5YeSCGaFocLdDkhnyD0K2giyxPpsMzk24Z+2ydOCswzTkL7n9wgOhK3Lj364YVMKyAcK6@nongnu.org
X-Gm-Message-State: AOJu0YybwrOyYr2sViXHVrO3jQhowcftjrmIrPjOcTjtm6x3PKEy9bpX
 zBjrOXLISsg4A83xoZQUbMMJ7EFxxGjIUKnDMGDnnw+SiR1dFiKCFlhX5K6JE3c=
X-Gm-Gg: ASbGnctoq3qOc5qUrATVidBF0kc2ME351duGz8GCjQh4P3W3xHgGMEYqceGpPNDYMIf
 zJJqq93apz5xCG2sEHO4gsMSXv0rDVN1l5zkszvKHbpQqv8y7ipoWlHxzY7iP8xmIvMKL3v3HKl
 4DVQimM3VapLOGQHJS8M/S45oe6YP40rdPxts1CFhxajGdeHKoVHWskQal99gonpbd9nUWZRCbw
 MnXOuJz6nFkrbVVObCNorzMoSojIIdv7apflfogg0awuBTn+JayrcDMaibPUA505XY2uFubVZJU
 o0Ddci+x7+S6+nbA5+8iGDgEkeRdsGU07mtdVjbWdcP43bRzNrXkLob7gpA=
X-Google-Smtp-Source: AGHT+IEZQxuIp+fT3h4N9TAxGbLxZXKPdQ96iqEh06Qf2O+VRTnOiB5/2LhFFhIpmjt9eO1QwO+FzQ==
X-Received: by 2002:a05:600c:1c26:b0:439:98ca:e3a4 with SMTP id
 5b1f17b1804b1-43998cae4d9mr5132775e9.19.1739887380467; 
 Tue, 18 Feb 2025 06:03:00 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439618a9ab0sm150548685e9.35.2025.02.18.06.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 06:02:59 -0800 (PST)
Message-ID: <644a3d77-3c95-4ca9-a453-933c74dbd40a@linaro.org>
Date: Tue, 18 Feb 2025 15:02:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Laurent Vivier <lvivier@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
 <bbee3d53-ac82-407b-91a5-b7e4c3f464bf@linaro.org>
 <23d119e5-ea42-4b0b-a491-0fb7b8c4dfb4@linux.ibm.com>
 <07a8be9a-d99e-4d02-b475-671435c11396@linaro.org>
 <90adacff-9409-44f2-9ae6-9e01c8dc6e5c@linux.ibm.com>
 <5e8b3f72-d29b-4b19-a00f-a1bd5125ec7c@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5e8b3f72-d29b-4b19-a00f-a1bd5125ec7c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Konstantin,

(Cc'ing more developers)

On 18/2/25 14:27, Konstantin Shkolnyy wrote:
> On 2/12/2025 14:01, Konstantin Shkolnyy wrote:
>> On 2/12/2025 12:07, Philippe Mathieu-Daudé wrote:
>>> On 12/2/25 18:24, Konstantin Shkolnyy wrote:
>>>> On 2/12/2025 08:52, Philippe Mathieu-Daudé wrote:
>>>>> On 11/2/25 17:19, Konstantin Shkolnyy wrote:
>>>>>> Add .set_vnet_le() function that always returns success, assuming 
>>>>>> that
>>>>>> vDPA h/w always implements LE data format. Otherwise, QEMU 
>>>>>> disables vDPA and
>>>>>> outputs the message:
>>>>>> "backend does not support LE vnet headers; falling back on 
>>>>>> userspace virtio"
>>>>>>
>>>>>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>>>>> ---
>>>>>>   net/vhost-vdpa.c | 6 ++++++
>>>>>>   1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>>>> index 231b45246c..7219aa2eee 100644
>>>>>> --- a/net/vhost-vdpa.c
>>>>>> +++ b/net/vhost-vdpa.c
>>>>>> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState 
>>>>>> *nc)
>>>>>>   }
>>>>>> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
>>>>>> +{
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>   static bool vhost_vdpa_check_peer_type(NetClientState *nc, 
>>>>>> ObjectClass *oc,
>>>>>>                                          Error **errp)
>>>>>>   {
>>>>>> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info = {
>>>>>>           .cleanup = vhost_vdpa_cleanup,
>>>>>>           .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
>>>>>>           .has_ufo = vhost_vdpa_has_ufo,
>>>>>> +        .set_vnet_le = vhost_vdpa_set_vnet_le,
>>>>>
>>>>> Dubious mismatch with set_vnet_be handler.
>>>>
>>>> I'm not sure what you are suggesting...
>>>
>>> Implement set_vnet_le for parity?
>>
>> To my (very limited) knowledge, kernel's vhost_vdpa that QEMU talks to 
>> doesn't have an API to "change h/w endianness". If so, 
>> vDPA's .set_vnet_le/be(), as well as qemu_set_vnet_le/be() have very 
>> limited choices. qemu_set_vnet_le/be() behavior with vDPA was to 
>> simply assume that h/w endianness by default matches host's. This 
>> assumption is valid for other types of "NetClients" which are 
>> implemented in s/w. However, I suspect, vDPA h/w might all be going to 
>> be LE, to match virtio 1.0. Such is the NIC I'm dealing with.
>>
>> My patch is only fixing a specific use case. Perhaps, for a complete 
>> fix, qemu_set_vnet_be() also shouldn't unconditionally return success 
>> on big endian machines, but always call .set_vnet_be() so that vDPA 
>> could fail it? But then it would start calling .set_vnet_be() on other 
>> "NetClients" where it didn't before.
>>
>> That's why I don't want to just add a .set_vnet_be(), before someone 
>> here even confirms that vDPA h/w is indeed assumed LE, and, hence, 
>> what the right path is to a complete solution...
>>
>> int qemu_set_vnet_be(NetClientState *nc, bool is_be)
>> {
>> #if HOST_BIG_ENDIAN
>>      return 0;
>> #else
>>      if (!nc || !nc->info->set_vnet_be)
>>          return -ENOSYS;
>>
>>      return nc->info->set_vnet_be(nc, is_be);
>> #endif
>> }
>>
> 
> Does anyone have any answers/suggestions?
> 

Since you mentioned "vDPA h/w always implements LE data format",
I'd expect virtio_is_big_endian(vdev) always return FALSE, and
thus this to be safe:

  static int vhost_vdpa_set_vnet_be(NetClientState *nc, bool is_le)
  {
      g_assert_not_reached();
  }

But I don't know much about vDPA, so I won't object to your patch.

Regards,

Phil.

