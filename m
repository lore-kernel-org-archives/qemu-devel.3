Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E01D35172
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7shB-0001sD-GE; Wed, 01 Apr 2026 06:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sh9-0001rn-Ur
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:21:07 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sh7-0004KK-Pm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:21:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so61675045e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038864; x=1775643664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JD+KRbH51Y6l0xt0ZxrANuqzkw/1ZWXtY2NTuI2rzWA=;
 b=DfNr8ZsHmCeH73LFN992pp/q08o+NiVVXM3uiOkqrLTIQ2Kansapafv83QhXsyBixU
 mYdvzTP21Yg5RaJ1u7jiC6JFq9hAI4cb3y0FIZOj/tFgCXivpWQn6bZzEB+vM9dun6Pg
 qO70W3VcNickEG56YAK2YK+tt5TQ26nSre6DRg3cGzzGOnv7EMfW1FL1pkL77wgqhiaO
 Z9Q7f60jHIElvStbRx4IZQCayAO7vgKKHBBgsvzRriVzN5N/LbW2cHRxp51zLgeBbqBu
 J00ptkWqOeIjsX3sQwFj8jsvI/lF7l3hu2wqvPIyRGOy3GDpHRy5dsSHEG5Q+0KCvdZu
 P1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038864; x=1775643664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JD+KRbH51Y6l0xt0ZxrANuqzkw/1ZWXtY2NTuI2rzWA=;
 b=GCn9hl2XHOm9XXpCHWbLxAPjX/IHXa3RT8g4rg28wXCpI9TM1NKojte5oMNtxCgXvx
 3QgGFpvFCc7BXsotiB6v3drHCZMD+cGtk2xvCjc3lLBee0EHmMomiR0kFCaMg4wqcwKA
 yaba6EVKHY2O6MviBWC4p+Ksm8Agc/cGnDukiDjVeZNkhB3NnGr8szgqYCKlAm8oy7Ge
 uMhVvKfCoVBn8nkI/pJRetEY45DaZJMiqQFqWG/iElNk+DlUjPsYwjs41oBFMnjZTSUl
 LXVSR9xhW0/D5h+Fqia6oAxUl68gBzqM1nGtE/W999x5W9Z3SQiJp8R/+aOS6i0Cf8NE
 VDzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1t5TPWZL69LK7QkfGyQQy+fCSO5kjblrQ+DqJxNFYtXkucOdaDPQ7X+gbpLzNhQVNGB5/X57C73EG@nongnu.org
X-Gm-Message-State: AOJu0Yw6YCjS5m7WzhWdKiL+O/mVAJeYAM5EQQAK3OKCCDKp55kUdWgQ
 hGd5JZRGG4Oyn6eKbLR0tr9nfENlUrDyHBc0BywfhMJdFN4/cSZvlCIPmgZqG/KhzgY=
X-Gm-Gg: ATEYQzznc8HklfGaj7MxPpyWJhZS+pVposGO1h4OPELpqpKBWuGpjf6G2LfqXrS53+W
 ZFlSL+KCsKr8+bUE21Vd+E/B8qvI5iOYBCjxoaClkjA89te3edO8RNPw7w8rX6XL/YwDD9/kXTJ
 1gxCk6ZcAa/+ANlGUD+uNyHsWkVlorhQCdqy+5a8FeZhQerojt9x67ek+LpyCuJ9qNZh3lxJ0+e
 VFmn40XWDzxRVr9Em0BVoa6BoToV7FeNY4+AHFMyZEcZ6K/49Khnc+t4uVUHr2NGuXKUYH3JH/r
 nfNrUNge+nOe2mvXzUahs8T9CSNl/6jZuZTVy1Moyewjiwn/XftEDlrQtd6vHjySfWUARFe8fxR
 fTTmDYiQAWoyzmfiwi8QczBs2LJrYKKVX6cDM61P4/vrHPokxeDYif9s7QEny0w6G2K1pCYtGlO
 6UnORqZPrxgC5Dh30T6I7qmQ4G5k563BBkbyzVojxxnrZbYtaPpjXXpuuSiKxBqJw/ABajZou5K
 Kl2
X-Received: by 2002:a05:600c:1f11:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48883568b21mr42751215e9.4.1775038863930; 
 Wed, 01 Apr 2026 03:21:03 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887aab1de3sm60237855e9.1.2026.04.01.03.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:21:03 -0700 (PDT)
Message-ID: <a7b05743-c7f4-4626-b11c-ec8200913c33@linaro.org>
Date: Wed, 1 Apr 2026 12:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/display: modernise the vga debug code (!!GenAI!!)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <6c3214ac-1679-d9db-2fed-c934fde8ddf2@eik.bme.hu>
 <20260330222900.982404-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330222900.982404-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/3/26 00:28, Alex Bennée wrote:
> Remove dead code, replace debug prints with trace points.
> 
> Link: https://patchew.org/QEMU/20260330140656.46FE55969F2@zero.eik.bme.hu/
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> As an experiment I prompted Gemini with the thread contents and asked
> it to make the changes. It cost about 9p in inference and I would
> argue this barely counts as copyrightable as it is a simple
> transformation of existing patterns.
> ---
>   hw/display/vga.c        | 89 ++++++++---------------------------------
>   hw/display/trace-events | 11 +++++
>   2 files changed, 27 insertions(+), 73 deletions(-)


> @@ -873,9 +824,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
>       uint32_t write_mask, bit_mask, set_mask;
>       int plane = 0;
>   
> -#ifdef DEBUG_VGA_MEM
> -    printf("vga: [0x" HWADDR_FMT_plx "] = 0x%02x\n", addr, val);
> -#endif
> +    trace_vga_vram_write(addr, val);

OK, ...

>       /* convert to VGA memory offset */
>       memory_map_mode = (s->gr[VGA_GFX_MISC] >> 2) & 3;
>       addr &= 0x1ffff;
> @@ -945,9 +894,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
>       if (sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_CHN_4M) {
>           if (mask) {
>               s->vram_ptr[(addr << 2) | plane] = val;
> -#ifdef DEBUG_VGA_MEM
> -            printf("vga: chain4: [0x" HWADDR_FMT_plx "]\n", addr);
> -#endif
> +            trace_vga_vram_write((addr << 2) | plane, val);

... but why print the index instead of the address here?

>               s->plane_updated |= mask; /* only used to detect font change */
>               memory_region_set_dirty(&s->vram, addr, 1);
>           }


