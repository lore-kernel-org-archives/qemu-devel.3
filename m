Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B838CE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 15:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRC4o-0000rS-4g; Fri, 27 Dec 2024 10:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRC4k-0000qr-8a
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 10:16:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRC4i-0001QB-Rd
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 10:16:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21619108a6bso82081275ad.3
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 07:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735312587; x=1735917387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+49uq6Owt+Wr3uOM6i+R/bpvzi6JUtTTruyFT4JG0c4=;
 b=BmkjIuXu59tenGWWe2zxM6hCELoGciT4PIOMON/o1cVrWDY1JFoyhA9YrqASt4eJ4m
 btvLeVXR1sMAzMSYPE74CwOOcbVhITq7c6o33omKy+ol2IUpc4M9HyM5aaDaOO3vv6pu
 E57//WjhULA7nXAJ31xRAADPK/yFIR8H2vkEHpSt+gwfhTvTgyOznvit8tlPgS++z+IR
 7PAELfygo24rj685XkjTh7fU94KxyLE7RxNp4dXQFeWatCMvc5KsGv9Md8q+SVtujZEf
 RNFd9xa7g7XsuirY3BRyVT2AOvgxWdEjhUlCS4+qlOh4Pifs+h8XSLpvYWbk1QCbTjpR
 NqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735312587; x=1735917387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+49uq6Owt+Wr3uOM6i+R/bpvzi6JUtTTruyFT4JG0c4=;
 b=jCTmZIEVMaG1jSP444+wZEcrA4vGX832gj17Lb0XfmjUglXfkHTAK04AA4uYvLuxnm
 iuWmd2nPcNLIbJKpnlNt6tVUGa12WtU2mOyKFKVi4iGswsMWSWthnMHQfeY3CncWLsYX
 mQ3uvlHYlOcOq3DcwG/gPCO1r4lADT0H4NqWsr+VOanUSTi9jEyLfv07p9BRGBBkD2bI
 BVVzU9ZKKI1cWuOMeQSeUUsV1JNDIvBRWkzGebE4ZwINj6B4pcZ4gvcb8y+UzckwcjMf
 WVCYmxVtEVG3ijFDWnG9aYMhUgGMBXbwuP88BJ+LM8jH7RME2Hhg8BmeR283w22TA6tS
 IBrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUngqF6txjRw6qm4oNTylBbKeJvtC6EAgHAYyV/8sfoatyuDrkj98LZw1zgGdgkQAtmjGhkf7cPcjXO@nongnu.org
X-Gm-Message-State: AOJu0YxrKDMdm22HBZ2mPBdW83MrOpr8KOBPF7apftYJY8o0y2iJgoqm
 Z06TB+4YGnbSq7JqzA7wDELOmBzTYp6028O2Y3Rjp8eRmfncScUVZMpqJT38YJw=
X-Gm-Gg: ASbGncsk4zqw/Qr7m0mljn1GnsH7fq8ogcC7S6VJZrpztbv2s+KVI/xT4hWCeL+Un/t
 IiB7gpKEnC78f34RVoBkv6oRWktycFJeHzzF0PLUB3pXoHHzAyiTXcOQpNc0gn2xiKyhKPgfk5m
 8AsD6zLBswYk+bYCwBRKMhGoobNBTpvOuFfedTBYb0f95X/xG8TiB+eTKHOxc/urxkKwgAfP24k
 S/H1EVTZaDfXBfOC9FVgQ0fyozGwvoowE2nDP1a73LVHu5UqeudLtSnO3KvZuzu2NqO4y7pevEH
 FjJXbg8Ci9S9PUeI2VrwOEwxn8cbYTpatGDVlU4=
X-Google-Smtp-Source: AGHT+IHkkHOQt1kiD99/42RLHt2bvB79iHiDLaIny6FQwoFuIf9eIs3MkmCKS1PJlPV0NJQHh5VBPg==
X-Received: by 2002:a05:6a00:4485:b0:724:e80a:33a with SMTP id
 d2e1a72fcca58-72abdebc149mr43208812b3a.23.1735312586750; 
 Fri, 27 Dec 2024 07:16:26 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad816540sm15185407b3a.22.2024.12.27.07.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2024 07:16:26 -0800 (PST)
Message-ID: <8ff6dac5-067a-430e-90c2-67e07ba221a2@linaro.org>
Date: Fri, 27 Dec 2024 07:16:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc: use extract64 instead of 1 << i
To: Tigran Sogomonian <tsogomonian@astralinux.ru>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20241227104618.2526-1-tsogomonian@astralinux.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241227104618.2526-1-tsogomonian@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/27/24 02:46, Tigran Sogomonian wrote:
> 1 << i is casted to uint64_t while bitwise and with val.
> So this value may become 0xffffffff80000000 but only
> 31th "start" bit is required.
> Use the bitfield extract() API instead.

Again, I < 32.  There is no overflow.  The type of value is irrelevant.


> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
> ---
>   hw/misc/mps2-fpgaio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
> index d07568248d..04a3da5db0 100644
> --- a/hw/misc/mps2-fpgaio.c
> +++ b/hw/misc/mps2-fpgaio.c
> @@ -198,7 +198,7 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
>   
>               s->led0 = value & MAKE_64BIT_MASK(0, s->num_leds);
>               for (i = 0; i < s->num_leds; i++) {
> -                led_set_state(s->led[i], value & (1 << i));
> +                led_set_state(s->led[i], extract64(value, i, 1));
>               }
>           }
>           break;



