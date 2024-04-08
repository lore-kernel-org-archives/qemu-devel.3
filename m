Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594F9C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 18:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rttda-0004DW-7J; Mon, 08 Apr 2024 14:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rttdY-0004D5-2i
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:22:32 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rttdV-0000oe-3l
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:22:31 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51381021af1so7665704e87.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712600546; x=1713205346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y01LwObyov7hxh7Z2VQbY0ucCuTeqD3CTvbb6qtrp/I=;
 b=nKYAyidNp7J65r0dihw3pIB2fupcIrYXTiG2xovkppG6DgACovfd7PYuOK7/BP66Zj
 8AiNbpLVAS7aVDwT4vc/Apr8MrFtk/RTlabd9J1wesxysxiZTsGL4uWVnUuCIoBJcp3O
 S64f6f8CP6AqCLIg+2tnN56ocSRrplYQsXuI8cAZ/MCaskduEiRFKZ6bvb8EOuxfP/o6
 98uRV1rS83zc41TB3nuuysB6BLzqknhX/dkVQCcKf6BgSosWLTl6cwZ3UAELYmzJYrs8
 j9w8z/MC6oDzOoS5HV7CaseT+DPKfCNIGKhkuG4pBhU1qDhjgPYJuV+zDLqpeWPMAr8/
 9lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712600546; x=1713205346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y01LwObyov7hxh7Z2VQbY0ucCuTeqD3CTvbb6qtrp/I=;
 b=I7aFVukoLpkKZy+TAuRtmqk6MKH15aLsipaTaggG086xZaDl8YlUr7GMmBHVZ64EM5
 EH+m5Ex46cISEH7Ljni9tNp6Huv/WAB2H1xfDrQh4Pv67dZZaKWiqTL32zajo51YF2ZU
 qEL6Pqz48C/x5lj+INHMkasZ69JTvOdBRlxFym/An7oXnM/f9iCzszZ6bM43nY5zAfqj
 DC5bDhoi7LARU/lArAZGUptwE0iUDMGAT3ElZvyyC0Qspku/a73fHIQk4clko818X5o/
 2Qyeh2A8fsb6YppcfmKVPkv5rHHNmWHXP8j5tN89GJD7k+sZUtjRqSVjHbN7Hv+D5Npc
 tFcg==
X-Gm-Message-State: AOJu0Yx0hXGmo2yytaHh0rKJoKVQU9qEFGeHaDtTvt6vKbf0DjmyIofY
 ahunJLdyW2cZlmbHGDv6fXklM9CAFxQm6wU5rbwT1KjJpHcyGHHqepNUAnzGnBM=
X-Google-Smtp-Source: AGHT+IHsWA0WxOxHfYIereIgplgO3Co2nb2OajZK6R3hM1z8njuOnkdvQLV+B0wj5MsOOfZHLKWGhg==
X-Received: by 2002:ac2:5302:0:b0:513:c223:f0e4 with SMTP id
 c2-20020ac25302000000b00513c223f0e4mr8728786lfh.10.1712600546442; 
 Mon, 08 Apr 2024 11:22:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 dr2-20020a170907720200b00a4ea1fbb323sm4693378ejc.98.2024.04.08.11.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 11:22:25 -0700 (PDT)
Message-ID: <01500a48-3d5a-4f6d-8922-f209fd2340e6@linaro.org>
Date: Mon, 8 Apr 2024 20:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 3/4] hw/char/virtio-serial-bus: Protect from DMA
 re-entrancy bugs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Amit Shah <amit@kernel.org>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20240404191339.5688-1-philmd@linaro.org>
 <20240404191339.5688-4-philmd@linaro.org>
 <942c06fd-fac0-49da-9421-92dc3a357cb3@linaro.org>
 <20240408060802-mutt-send-email-mst@kernel.org>
 <1daad71b-d1dd-44bf-ba6c-668bc80b99fd@linaro.org>
 <20240408112008-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408112008-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 8/4/24 17:20, Michael S. Tsirkin wrote:
> On Mon, Apr 08, 2024 at 01:04:11PM +0200, Philippe Mathieu-Daudé wrote:
>> On 8/4/24 12:08, Michael S. Tsirkin wrote:
>>> On Mon, Apr 08, 2024 at 09:14:39AM +0200, Philippe Mathieu-Daudé wrote:
>>>> On 4/4/24 21:13, Philippe Mathieu-Daudé wrote:
>>>>> Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
>>>>> so the bus and device use the same guard. Otherwise the
>>>>> DMA-reentrancy protection can be bypassed.
>>>>>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Suggested-by: Alexander Bulekov <alxndr@bu.edu>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>     hw/char/virtio-serial-bus.c | 3 +--
>>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>>>>> index 016aba6374..cd0e3a11f7 100644
>>>>> --- a/hw/char/virtio-serial-bus.c
>>>>> +++ b/hw/char/virtio-serial-bus.c
>>>>> @@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
>>>>>             return;
>>>>>         }
>>>>> -    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
>>>>> -                                   &dev->mem_reentrancy_guard);
>>>>> +    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
>>>>
>>>> Missing:
>>>> -- >8 --
>>>> -    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
>>>> +    port->bh = virtio_bh_new_guarded(VIRTIO_DEVICE(dev),
>>>> +                                     flush_queued_data_bh, port);
>>>> ---
>>>
>>> I don't get it. vdev is already the correct type. Why do you need
>>> VIRTIO_DEVICE here?
>>
>> This function doesn't declare vdev.
>>
>>>
>>>>>         port->elem = NULL;
>>>>>     }
>>>
> 
> 
> 
> But it seems clear it wasn't really tested, right?

Indeed, I only tested virtio-gpu, then added the other ones Alexander
suggested. I don't have virtio-specific tests, I rely on the GitLab CI
ones. Hope that's enough.

> Philipe here's my ack:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Feel free to merge these after testing.

Sure, thanks!

Phil.


