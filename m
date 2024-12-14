Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B578E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSDY-0000r8-HF; Sat, 14 Dec 2024 08:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSDX-0000qz-6V
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:29:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSDU-0006iE-Ek
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:29:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361c705434so18836795e9.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734182994; x=1734787794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jg9uYNwTIhdKic0/eFwfk4JfuBopr67QrHO/JrKqnuk=;
 b=GCVDioDsP822w2N/88iRAnis5XDe74VNjoxQvh/infHDxA8gyFNSYsr8idwQc5zd7Y
 T33WHMPYTKRvnsnvRJCI87ZV+VKPYiuzXNudtevO0eZkWUOgX9Jjc69WYoP0QDaEjs0v
 WHMavBGi/IrahppNpSLdbjesraF7XnT3DvkEdf5djPlaxdDV5RB1KowzgTZ4i9QY/j42
 +qoymZ2D5xBQiDTQywIZJnzlqLINbMIscU/GVJoxyq/JC0AuX0VniBNNehoghLqqfpr2
 2GSYOxd4P1Gv8UgtOYqK3+cQJhacUQSYIsUMQcW+HrPfCvbkauwCV/p9lpa7A+DP6mEJ
 hN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734182994; x=1734787794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jg9uYNwTIhdKic0/eFwfk4JfuBopr67QrHO/JrKqnuk=;
 b=XrHbiAXULvs70/URJoc7mI/61kAiZNPHFuV+TV6ERla5JHxryCzjESo+sWh2ekur/V
 nuB7T52/2nCnHH0BKcKiq/bLzuh042FD2vOXFltVZTljhJs0sMch3ERinKBEMXtfT4zQ
 dTNRhStt9LUJATIEqxkCy+bd9dOZA+z8p4qWNXZxX0TuQZe+GGz2AzD3PfvwYEbkxg5e
 zhXRy1w7a4XpJIQ6NQpcwIev1ETrbwRGIxOWmfq+QzZR/wxHJuW/KJzuuo+7LnohwHOU
 26JAoEKLprSVLBuUxaiWW8TIUsGaH5yqqJM2pMbAWZl685oGmhc99BxlLjO+CWbIZcgt
 S2jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT44xpgESY5HeGPcAXFfYW/54XelKVWGa2ziKPVQUjnEbp8XQZES3TSI7ucmSsp4n6unoHZ6Ba/0g0@nongnu.org
X-Gm-Message-State: AOJu0YwL4fDeOdjgrzw6zbYbp7IyF/mb5vJ2/i1BpGECDHou0N9QNUGv
 Q38XKM1tzyyrqJXHE4Nv0Oj4xjEPf3n29p5rk8ZhmfVJ1/kreWtYmK8JpVqldJMvrS/KKJWuOro
 00QI=
X-Gm-Gg: ASbGncsEH8N6m7GP3wGBTS4ahltWjlwk+l82F2u+kYJtkXJlneqoOsqwcrrLTSGmxxU
 h249b78Mc0qZw7GqbzbRycJr7Znx+Pv1hG09FnrK+604VEwTo3d9kMhnWmFl8TqAZ4MxFkgYn2j
 jK6gGPMv94sWarERdrUqp1Gg+owXWcDeh0QCdSESBIH9SkrZ4v17u+F5Yq9F/UOzf8vmaTM05Gb
 y/g8x2O1b080uW2954MPPSMTfjtsMVosxxpPPCIWICpuw7MZCFoAoPs7jWtpuBtn3lFJXvzNvEx
 1CaGfN5T9w21zzurilY3CXITYQ==
X-Google-Smtp-Source: AGHT+IH6ZvM2QX8haKbWy7fDY1z2crOFHlrpwLucMmH4A/tPZBpl9UIu/ol34U0qnRZFm6sng3prmQ==
X-Received: by 2002:a05:600c:1d86:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-4362a98815cmr58343365e9.0.1734182994545; 
 Sat, 14 Dec 2024 05:29:54 -0800 (PST)
Received: from [192.168.224.213] (201.19.205.77.rev.sfr.net. [77.205.19.201])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436362c6818sm24295615e9.38.2024.12.14.05.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 05:29:53 -0800 (PST)
Message-ID: <1c80c24a-547e-4212-a4fa-5b9665edf09a@linaro.org>
Date: Sat, 14 Dec 2024 14:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/34] next-cube: move timer MMIO to separate memory
 region on next-pc device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-13-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-13-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/12/24 12:45, Mark Cave-Ayland wrote:
> Move the timer MMIO accesses to a separate memory region on the next-pc device
> instead of being part of the next.scr MMIO memory region.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/next-cube.c | 63 +++++++++++++++++++++++++++++++++++----------
>   1 file changed, 50 insertions(+), 13 deletions(-)


> +static uint64_t next_timer_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    uint64_t val;
> +
> +    switch (addr) {
> +    case 0 ... 3:
> +        /*
> +         * These 4 registers are the hardware timer, not sure which register
> +         * is the latch instead of data, but no problems so far.
> +         *
> +         * Hack: We need to have the LSB change consistently to make it work
> +         */
> +        val = extract32(clock(), (4 - addr - size) << 3,
> +                        size << 3);

Does this mean ...

> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps next_timer_ops = {
> +    .read = next_timer_read,
> +    .write = next_timer_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_BIG_ENDIAN,

... this should be in little endianness?

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +};

