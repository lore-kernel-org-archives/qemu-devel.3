Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AEDC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp59N-0000lC-UN; Mon, 03 Mar 2025 07:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp58t-0000bq-SC
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:43:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp58r-0001ne-RL
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:43:31 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-439846bc7eeso27583545e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 04:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741005808; x=1741610608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J+s7GeidDlT+ozsOoCdqTA2qS5PcFNfsaTwWeEedSQI=;
 b=WXovn9bGUQ8j2peB4PV7aynwrGuzK12VImR7vTOgHTb0Uexo8+DzfnIApqdJwTrFjV
 2gObkEUmB4qhOroMnJ/um1ORIAJBmNcuz8zt+/IgMzx/J2dIGWkpijpHx/yNEJWHu/ah
 lyTQw0y9DpRtm3Rcbg+YqOWDUfOp2wguTHAIkxul3G/h5hqztLXeMbHGqp0XzGtATyNW
 cLDqNzvh8L3OjpszHZFxbM4Y0A2wxtC9aRUewMSALkhmomhLWxI1hbx6okxvsbJfGu5f
 7nIe4SjWxn5BOIfgyvnsdHBMf9EmdtfamTiClwQctwbDv0x4TAGn08k2pBxVYfEVDKGk
 W6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741005808; x=1741610608;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+s7GeidDlT+ozsOoCdqTA2qS5PcFNfsaTwWeEedSQI=;
 b=LxT7VwNweyfV38X8/2rSN5Z51f+JYR8LM0z5KBmaLNifZTWzSYSOmd7w/YiofxSSf5
 +NPNuBdOOvjeqX+n+ipYEhkHVO+R7AfmvGrRM5S6+yWKxE1ceIB2q1oRq/AYoLwZ6f/d
 zz1Rwr0je6lBYsrv81JkeGqA6LJlK2wkREVRoAu/IaW1FqkrCWTOPMm+1yN1c3vyHk3N
 e1+OT66w85dry1SCKAlNebsRYmfIJWJAwXP5mggv6Z38HfkZ3qNemMr4h0CBOyRFMAZI
 ZPQAz+05tsCuKGqArIsOvzX5VJVb13PNWKFT4CraxblvoKFT2DCzAuKkSsMm6kTzQ7uM
 UfGA==
X-Gm-Message-State: AOJu0Yx7mFY5lN8DzYR2zvIKv92e1oCmG4siBZ0zkDOReZ6bnZZhYFh5
 VYKzRlhabHFj7FAOyDScQvTJtR8Cz0oRBNqdqlJzpK914LyKO0/Om2ZKSyfO+nygOdzGYIk6kVD
 sKucqRg==
X-Gm-Gg: ASbGncsyHD3CEvegltFqJJEHZ3hQ0pwZsfTF/Bjxrhd0gg3wmXosJrkunwHyZLTHlxa
 u2MSxf6l9bsg4cM8PTNERKk0KjmTa/Xx7yRCtDkuPBryUf2fWVPDdq5iGdTCtsNKkciGLv4kPtd
 8HN3xrRTLBEadz3gxx3HbYA8x7DdDNMt0LSzvaAbb4fTMJoUWW9NZxf7UxWJklpGp3zQE6FqRgz
 oSyTNT43KGw0ir28pGuJqzz7+2EMKT0w1VMMCg/pED//6KAGXaEoVwKmLMHtPrSUNj6qKJTMjNz
 lRS1sWSim3ASsCMR3xHYVLO/0UEHBlXMniYJ7hyVwPEDQZBOf2PXpwSWkQ0yrTpC0DFmlx7BIS0
 MeWXZaiq18nI8
X-Google-Smtp-Source: AGHT+IGMAxaFkz+9N3mI5GcGWQX2+1z8ztoMmpdWik7YRxJxBmrMRmVRgKBUaeRtaS2dQmHTOoGc6Q==
X-Received: by 2002:a05:600c:4ed4:b0:439:98ca:e3a4 with SMTP id
 5b1f17b1804b1-43ba67475aamr97752405e9.19.1741005808166; 
 Mon, 03 Mar 2025 04:43:28 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbb15841dsm53942095e9.1.2025.03.03.04.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 04:43:27 -0800 (PST)
Message-ID: <760e025c-b21c-4f8a-946a-dad5ffa86213@linaro.org>
Date: Mon, 3 Mar 2025 13:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/nvram/eeprom_at24c: Reorganise init to avoid
 overwriting values
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <cover.1740839457.git.balaton@eik.bme.hu>
 <fd8e0478febd60d5f48c58bc77c60e043d1c3cdc.1740839457.git.balaton@eik.bme.hu>
 <feff5b7e-0d56-4776-bec4-ffb745ae5120@linaro.org>
 <5c7d100e-858f-52c3-e172-309529783663@eik.bme.hu>
 <f71b59c9-13ab-4f58-96f8-78fee88e8319@linaro.org>
Content-Language: en-US
In-Reply-To: <f71b59c9-13ab-4f58-96f8-78fee88e8319@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 3/3/25 13:40, Philippe Mathieu-Daudé wrote:
> On 3/3/25 13:32, BALATON Zoltan wrote:
>> On Mon, 3 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> On 1/3/25 15:35, BALATON Zoltan wrote:
>>>> The init_rom can write values to the beginning of the memory but these
>>>> are overwritten by values from a backing file that covers the whole
>>>> memory. Do the init_rom handling only if it would not be overwritten.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/nvram/eeprom_at24c.c | 6 ++----
>>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
>>>> index 78c81bea77..ff7a21eee7 100644
>>>> --- a/hw/nvram/eeprom_at24c.c
>>>> +++ b/hw/nvram/eeprom_at24c.c
>>>> @@ -191,10 +191,6 @@ static void at24c_eeprom_realize(DeviceState 
>>>> *dev, Error **errp)
>>>>         ee->mem = g_malloc0(ee->rsize);
>>>>   -    if (ee->init_rom) {
>>>> -        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee- 
>>>> >rsize));
>>>> -    }
>>>> -
>>>>       if (ee->blk) {
>>>>           int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
>>>>   @@ -204,6 +200,8 @@ static void at24c_eeprom_realize(DeviceState 
>>>> *dev, Error **errp)
>>>>               return;
>>>>           }
>>>>           DPRINTK("Reset read backing file\n");
>>>> +    } else if (ee->init_rom) {
>>>
>>> Don't you want to keep overwritting the init_rom[] buffer?
>>>
>>> IOW why not s/else//?
>>
>> I've tried to explain that in the commit message. Current behaviour is 
>> to use backing file content overwriting init_rom content. Removing 
>> else here would change that and init_rom would overwrite data read 
>> from backing file. I think normally 
> 
> OK, I'll amend in description:
> 
> ---
>> init_rom is used only if there's no backing file (provides default 
>> content) but should not overwrite backing file content (especially 
>> leaving the file unchanged and only change it in memory).
> ---

Reworded as:

---
The init_rom[] can write values to the beginning of the memory but
these are overwritten by values from a backing file that covers the
whole memory.

init_rom[] is used only if there's no backing file (provides default
content) but should not overwrite backing file content (especially
leaving the file unchanged and only change it in memory).
Do the init_rom[] handling only if it would not be overwritten.
---

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> So I don't see why would that be useful.
>>
>> Regards,
>> BALATON Zoltan
>>
>>>> +        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee- 
>>>> >rsize));
>>>>       }
>>>>         /*
>>>
>>>
> 


