Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B813FC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp57n-0008JA-Pw; Mon, 03 Mar 2025 07:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp56A-0007o3-5N
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:40:43 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp566-0001Yf-EZ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:40:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390dc0a7605so2367021f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 04:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741005637; x=1741610437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=enPtnQyubkCLZfBRJeg8fqrmBvpEcC2NxZxZPkLba00=;
 b=hwNLpD5BMYHui4RhOqUUqzx6vpCcaM69Oxi5YAGNy2HVmQhQDDwuZDUkYPchR/Zzn9
 D/Xf/jRSpdAg8klzC6fOsKehUbNqbLfMI4+HvLFIiM+M4V6T/aWgBvp7+DjFU7KUtbdg
 RXs3cPNhOzDB+iqCKbYVFPsLT18hLJGL/9F2euKPJ53WxwYZEHWATGfPkGNXSWYMkZHD
 DqfFvYQzlR28pllv/P0TvzAgQm+8s1zbnYi+1xnWy9THDXVMRd7Db1toyjBq9BT2CrO7
 Wk8xlkoCu8MzQw5JQa4OVPlv8XsZUZeOaV+PW/u1WUFJNb/Q2ww98cfBG/TgnQ6MXPaP
 GRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741005637; x=1741610437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=enPtnQyubkCLZfBRJeg8fqrmBvpEcC2NxZxZPkLba00=;
 b=xUnqUVxuMMWh7OWtQ89L7SBIsKw63tK7rOJMjrTit3F+pd55PChEDdklViShBYcLV6
 EHaJPz0s7l+EdFh02TjtQC1vu4fBsFKLCUdNVviepGvl9p18VHHjL6bP7ClCm1zoBWlP
 Fr18O3GjPOMCAvHzNdAWqFNy7VD5RE6zi+IWMWyXGG+mK1Rd7BD4/XnBtc99ArQst3XV
 1LU1aeMFXtql4Ri5A4rjKnmN6E0C5ki/8Xo1ivzE/FGEahcTjYbhfEZuXqs1Xy9WlLnK
 FIM8XgTnx1i4XwX0O3Zio8rNcnKvTK+EMQglZ/HcFW3hzeHFRErbZDi8jWlIvjNEg3xr
 qzRQ==
X-Gm-Message-State: AOJu0YxYi4FC5CVctiGdp+grvUoTmyruQJ15kHSsPBX3iLIQ+gmB69ap
 xAZytF7a7lJLrcDscynEFbtCS3FaJCC7HnuXynNsMswQIVPLMUYp2aUFrebZLsgsSwGN8tN4hSM
 tWndILQ==
X-Gm-Gg: ASbGncu0ZOInFrL46PfCFCK+eW5nsT7j6S3/b/tK3zplmaenxdQCTSxe8keYIdC9/w9
 7+oadV6cbXs0HQ+sIXtbJPjHFzJKIMKZOkeMyBl6CS+eXxdW3FW16XhJVKSYK1t68fmZFPiuKbB
 eS9FeEOwdP/RQ5eZbMAgaVOowvorXk86iT+u+V+4Gs8QJ2KhAQGADC4Sb+Vy+EvpjQk0PtxHWw1
 b8ZIHL3KkY706QrBLuxeIqzWurjYfdbLI0opAwuIve4HGX5TjoqTAXAHkkBkbjLCXVcyb1uXLOf
 aMe3r8Xia8/Sp1Gjk0lmoJ8H7QlgjQZQdDyY436Ca5IfRkB1OjbeyKZIs6HJSgY+Zfw/0LIDGI0
 cWsRED+wj0Nsk
X-Google-Smtp-Source: AGHT+IHLv9mbfrY4vuXGTU0CmSyEb6eKoTrpd9gf2ZteD0VEqnaVwvxbqh0bhb82BBTSksZsoVOEQQ==
X-Received: by 2002:a05:6000:2c6:b0:390:fc60:b6d0 with SMTP id
 ffacd0b85a97d-390fc60bbeemr7304452f8f.16.1741005636704; 
 Mon, 03 Mar 2025 04:40:36 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f74e8sm165336545e9.7.2025.03.03.04.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 04:40:36 -0800 (PST)
Message-ID: <f71b59c9-13ab-4f58-96f8-78fee88e8319@linaro.org>
Date: Mon, 3 Mar 2025 13:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/nvram/eeprom_at24c: Reorganise init to avoid
 overwriting values
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <cover.1740839457.git.balaton@eik.bme.hu>
 <fd8e0478febd60d5f48c58bc77c60e043d1c3cdc.1740839457.git.balaton@eik.bme.hu>
 <feff5b7e-0d56-4776-bec4-ffb745ae5120@linaro.org>
 <5c7d100e-858f-52c3-e172-309529783663@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c7d100e-858f-52c3-e172-309529783663@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 3/3/25 13:32, BALATON Zoltan wrote:
> On Mon, 3 Mar 2025, Philippe Mathieu-Daudé wrote:
>> On 1/3/25 15:35, BALATON Zoltan wrote:
>>> The init_rom can write values to the beginning of the memory but these
>>> are overwritten by values from a backing file that covers the whole
>>> memory. Do the init_rom handling only if it would not be overwritten.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/nvram/eeprom_at24c.c | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
>>> index 78c81bea77..ff7a21eee7 100644
>>> --- a/hw/nvram/eeprom_at24c.c
>>> +++ b/hw/nvram/eeprom_at24c.c
>>> @@ -191,10 +191,6 @@ static void at24c_eeprom_realize(DeviceState 
>>> *dev, Error **errp)
>>>         ee->mem = g_malloc0(ee->rsize);
>>>   -    if (ee->init_rom) {
>>> -        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee- 
>>> >rsize));
>>> -    }
>>> -
>>>       if (ee->blk) {
>>>           int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
>>>   @@ -204,6 +200,8 @@ static void at24c_eeprom_realize(DeviceState 
>>> *dev, Error **errp)
>>>               return;
>>>           }
>>>           DPRINTK("Reset read backing file\n");
>>> +    } else if (ee->init_rom) {
>>
>> Don't you want to keep overwritting the init_rom[] buffer?
>>
>> IOW why not s/else//?
> 
> I've tried to explain that in the commit message. Current behaviour is 
> to use backing file content overwriting init_rom content. Removing else 
> here would change that and init_rom would overwrite data read from 
> backing file. I think normally 

OK, I'll amend in description:

---
> init_rom is used only if there's no 
> backing file (provides default content) but should not overwrite backing 
> file content (especially leaving the file unchanged and only change it 
> in memory).
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> So I don't see why would that be useful.
> 
> Regards,
> BALATON Zoltan
> 
>>> +        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee- 
>>> >rsize));
>>>       }
>>>         /*
>>
>>


