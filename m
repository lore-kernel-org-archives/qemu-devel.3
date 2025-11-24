Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1740ECFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 04:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNt7-0002iP-AH; Sun, 23 Nov 2025 23:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNsz-0002gX-VS
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:09:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNsy-00047x-EV
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 23:09:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso24655015e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 20:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763957347; x=1764562147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/klbJN/gHD4VF+aHNU1Mk65m2COcsBn7mL4EyUaOkzw=;
 b=oOJ5Jy+qQq8EuC0Ki2BHK4m4ACpaZOFLRCFoMvGm9F2eedcp/rCWVGOizLcn2aosj6
 Eqj9dR9/wHSriB9U2FgHK6jlNMkSQHNykU7YZWJB6o5Ww7t933E4aAJcWcN7N/WToIr4
 T5iDCgAFNHKK0HNwXxKaGzxgnQhX3y1Knh+cLft8uG5OdpEcWJnriEg+FS9juLPxHlC6
 n9AqtG/N/b+oc5zdU4a5Ki2qJ7MtMs+jMHkJONbakPBxHVqFhRwawnpgf6fqrAe2+U35
 +qhqC2D01MX5/c6zRqcie6BYJSPNoULgDpGGRMMmN+u0erEaaWw0P2ESCBMlBvXnf1dh
 Nr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763957347; x=1764562147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/klbJN/gHD4VF+aHNU1Mk65m2COcsBn7mL4EyUaOkzw=;
 b=F/rlCQOZ9pnIhekqsBFBw1wo1ywSMetKEFPOW9Y15926zdUo5y2CZiwEqhShgzHLns
 Z5H+WSiOwrKKoNSJHcg1wmJWCkt9dKCGy80W3drJJjwm3+9WsvLP9RPDtJeGPF+wgeuB
 k+hegAXOZHo2txQBoSPbLrM8VbxPJNkmwy63PGzOOocNoQfGR+9n3k1MMafHFzaAHDHk
 EcZOHzgu9bkIjNIfx9GM94KPA2koRJlq/5OhbSk3eWv6VfHai+vrf2dS6rnUvFi3Gs0F
 7sX58HKUrTxRYzbw5kaCGmKiYyPtr8Jp1QOuKwoP/OZumsD+HbK7Qhvvj1xpeo7MIsYc
 cSZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQv4EHHrQBwntQW6qg9vhDy/Z4H16C+Nipfn3C2uqCzMn6kqChB+gNja4KMmeoTGoiFDvQXiwiqvj0@nongnu.org
X-Gm-Message-State: AOJu0Yxr3GTCwZ8xLA1GheIskKPXEn3s4K444kKraNwDB1/QMfB7bA4N
 R4rgUucBlNluepRWmjlNLqsYOCL8HwBQx1M1kFLmZsrpKnauGG3QnzkjmKdWeuFLDqU=
X-Gm-Gg: ASbGnctb8QLk6NVvvfgWvpDkqYH42HJK9F0ECa0ZwCB8pT07FoYmkI7Bvms7GXjNki2
 eUohU7McL3EIxSAbHC0RctboFmEky/6hkiBqcIIcpNAMmqawBecJZXqtgOj1G2j7e7mrJoFiXM7
 CkkyYDN6nxNfwQP4cPIuZUTd5a38YTv3jTpfNnfNsCRVKsOnsh5qOomCt3v8HIH77qkm4cFpcr5
 iedraporcGUIs0KO7xEUmVRrfG4OHoZHL450KxeCYEuDFcVILFZMaYxVudpq4blCFdM5VAM72C5
 dc6ndvTrK3QRQtvgQiQ1ansYjg6bdNb4cW8Ei+ToIUUiRUzbaPctghExD8x6QecIrkRxUnh2MVc
 Ze8DsnW5DSTcWxGhHXyE0KGRfJaEg4ki7sgxjrwsH1Pb1eOMpEAmOoWi0Pb9bPl2JKOVOZ2HpTG
 1mYMxfnHlmQsyMvrAJb7Z36+zprNnEODZowsxptLmuBYoI+cvYjSyrSg==
X-Google-Smtp-Source: AGHT+IHCPnxyzCEKtOE3B0lVxo7PEWAy9HZfM+9Qd1UCiL/aLgWKhS0MV01sMIcJOR8PZMZ/QCrxWw==
X-Received: by 2002:a05:600c:5253:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-477c01bf726mr77897445e9.25.1763957346715; 
 Sun, 23 Nov 2025 20:09:06 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa35c2sm24718417f8f.25.2025.11.23.20.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 20:09:05 -0800 (PST)
Message-ID: <a289ad27-20f2-46f1-bd33-a08cf8f1a14e@linaro.org>
Date: Mon, 24 Nov 2025 05:09:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/sd/sdcard: Erase blocks to zero
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
 <20250919-sdcard-performance-b4-v1-3-e1037e481a19@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250919-sdcard-performance-b4-v1-3-e1037e481a19@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 19/9/25 14:34, Christian Speich wrote:
> Currently, erased blocks are filled with 0xFF. However SCR Bit 55
> (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
> them is wrong.

You are right, we don't set DATA_STAT_AFTER_ERASE correctly.

> As erasing to zero is more performant and allows block devices to
> use optimizations, we the erase to produce 0x00.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 23764ed99f36cf39ee7abe02f08e51897c05e718..94ef3cc62582717ee044c4b114b7f22bd1b4a256 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1115,7 +1115,6 @@ static void sd_erase(SDState *sd)
>       sd->erase_end = INVALID_ADDRESS;
>       sd->csd[14] |= 0x40;
>   
> -    memset(sd->data, 0xff, erase_len);
>       for (erase_addr = erase_start; erase_addr <= erase_end;
>            erase_addr += erase_len) {
>           if (sdsc) {
> @@ -1127,7 +1126,8 @@ static void sd_erase(SDState *sd)
>                   continue;
>               }
>           }
> -        sd_blk_write(sd, erase_addr, erase_len);
> +        blk_pwrite_zeroes(sd->blk, erase_addr + sd_part_offset(sd),
> +                          erase_len, 0);
>       }
>   }

I'm OK with this change, but I'd rather having a device boolean property
so we can keep the old behavior for backward compatibility. Maybe
'erase-block-as-zero'? Do you mind updating this patch?

Regards,

Phil.

