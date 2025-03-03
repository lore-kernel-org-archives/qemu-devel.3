Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C4DC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3tO-0002kq-Jx; Mon, 03 Mar 2025 06:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3tB-0002iW-Bi
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:23:16 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3t9-00074B-9o
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:23:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43998deed24so40811415e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741000989; x=1741605789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bcPSyr2ecHg504G3TC/wZai/ECXtY0e3pY5frzAVvZE=;
 b=LcAHAddtuecV0O+JfLUB/3xN6fvpNPXpzUqKnwiEGXHUjKPGQjA2IiFvgETGjnlFjY
 RBlhSrEE4uwA+/eQJWafmOhgztVfov7OMnB3Q+C0/KPg4ubxX5fOU3EmTg3oZd7bLeHN
 7PTmg17d25RnOv3YkUda7B5QQ/H2hFk9R5GuO6CXjxibyurOjpJfKnWJLuOlPp9RcCSe
 Pn1ugK0VVIy2CtK09gzjZbNaiJH/7SONLhlDO6X8oPRkjae7T6a/SeNzbI4vSAtKRIDt
 uHrwEQzb1eAVytOOeM42bbBEkS0DyyuUxiRsy6W9sMWXOUvhF0W1zjYus9Ca+T4FO+Tp
 GTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741000989; x=1741605789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bcPSyr2ecHg504G3TC/wZai/ECXtY0e3pY5frzAVvZE=;
 b=VQbo76ddf2iSXDwI612zmYvLjNd9VgQ6niz7+fJWRgOWQR/GoR9cVDpRLtbaA9kDub
 8nbbi7n9ialSNKe5yk+rxVePWTbmpcJrdYQit3a4/ZVQiYQZ2rMQfFGxce2ewr0eseO0
 dXJBNSQ5Z4UxdqvzUgoOcSu0UUzYVohQyNU8/dddSgnsZVCEZM1MzeWdxAxEAJRPvDRQ
 7S3owUiuKKCVWnuDXuEOm0u9BmgCxQkjQMYJlLs/CvYpmEtHtwsKQSgsmC85NQxkGHjq
 6v/rxDVDNfGAVbMU/vzonS/tFxcNf9BQA1j48V0HhzTFeykSSGkDmNo+E1Rwqn7zKiei
 sIHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNzeqLZK+QvuS33dOELbQ725CvRKUwabqPD9F3AhJZxAHgiH6WbEIyA1i193TRdg6EtctjPlTNPv7I@nongnu.org
X-Gm-Message-State: AOJu0Yy1Mw/bcD5t91FbqXB5AnTHqbmU+es71dHvjeRU3xWZ8Ltu3poo
 4zVNlONiy8dKPQig7L5hTfnb5fmqAAb2jgja7vU2KeQ1q53gfkkay90fYQvslHS1p1xjwtYR7Gz
 293FtZQ==
X-Gm-Gg: ASbGncs8EvrVYTK12CKnrAnY0sGNI6nVDFA0AkwXOLeHQ5HF1zZuxm11zX4W4lgVjqc
 URH7FgBlMN09v1v9DSmiFAy6NTX145aj47LoVscLJ2a/5xfvRge+tYUcIlNruo2kWccBL9avBv0
 CPYB2Q6da1HOdaufxN1xbnvyOT3UBwnnoFT5tALwR9peNPpi8CplzR5Ayd9qPCHGwjbGuN9OtSt
 Qpq+bZFLrD/FoBvr0AgKP6pBmzTwG4pRABQ/QLyCyNDSlh45nr7T6AQLRniTpPMUg7pZNwmX+3m
 4qA1Cd+Yga6yQBZ/NX6JlmglabjS6QC8s9F+3yT9yX4X+uVfrdJAvg/dvSAkCPCKQUeqQSGJB0r
 1vVoHXkAqefG5
X-Google-Smtp-Source: AGHT+IEv1ZCC5EEWc8ZizZ+IDuiO4VVNVFM5t5H7CVhFia+32SeAHtcDVwb5NX/y47+rPejrVn1E0w==
X-Received: by 2002:a05:600c:511e:b0:439:9aca:3285 with SMTP id
 5b1f17b1804b1-43ba66dfe1amr100994145e9.6.1741000989429; 
 Mon, 03 Mar 2025 03:23:09 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba538b9fsm191252295e9.17.2025.03.03.03.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:23:08 -0800 (PST)
Message-ID: <feff5b7e-0d56-4776-bec4-ffb745ae5120@linaro.org>
Date: Mon, 3 Mar 2025 12:23:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/nvram/eeprom_at24c: Reorganise init to avoid
 overwriting values
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1740839457.git.balaton@eik.bme.hu>
 <fd8e0478febd60d5f48c58bc77c60e043d1c3cdc.1740839457.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fd8e0478febd60d5f48c58bc77c60e043d1c3cdc.1740839457.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/3/25 15:35, BALATON Zoltan wrote:
> The init_rom can write values to the beginning of the memory but these
> are overwritten by values from a backing file that covers the whole
> memory. Do the init_rom handling only if it would not be overwritten.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/nvram/eeprom_at24c.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 78c81bea77..ff7a21eee7 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -191,10 +191,6 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
>   
>       ee->mem = g_malloc0(ee->rsize);
>   
> -    if (ee->init_rom) {
> -        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
> -    }
> -
>       if (ee->blk) {
>           int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
>   
> @@ -204,6 +200,8 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>           DPRINTK("Reset read backing file\n");
> +    } else if (ee->init_rom) {

Don't you want to keep overwritting the init_rom[] buffer?

IOW why not s/else//?

> +        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
>       }
>   
>       /*


