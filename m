Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ADDC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmUX6-00062v-Bv; Mon, 24 Feb 2025 04:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUX3-00062M-K5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:13:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUWy-0002kK-BH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:13:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43989226283so27455425e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740388418; x=1740993218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/pxXgM/jJQ1y7JldAYYgpxkyydMmBle6xYMKLcPlQ44=;
 b=EgpqSL/2QjvEIQDpg9coElLun5CAr5tKTMBl+r1BL9nYvSLZr0LacqsYNaLiLC/U+d
 DACo1vkOR5/PVxLRG4PDP6sIP1p7wRqz7rbs2qE1nVEgo9hjNLi7nvkoXDGOSo4gGxHO
 QbaUnRBZN9SVp7WnGGHLpWi8Y8SNwk32l52OyNR6bgLkVkrg7r6qxlPZvq/pMiyXMWuG
 EKecjr3qiNYv6PNuuvaQha49hxUwiVbZ6YfnaXVEc5UGymeedMh5D98t5jjyMD3iBL4k
 bF2aO/s7Fx65/zrN3zkqHoEludhQfT+rv1jhox77QmapM/ZoFXpdxBUmxVN2KaVGMaSq
 tbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740388418; x=1740993218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/pxXgM/jJQ1y7JldAYYgpxkyydMmBle6xYMKLcPlQ44=;
 b=p0S0izWf1QZjWhpIryNbkeytRcb1J1j31BiMzbVppDEInzzeIybI7ibtKfP002g063
 +BG3mi1DkbWD1SjakHOyAKPpgaOPcJ+Zjgtsik3fvwJVoGFv+4JnCqBw/Aj4+J809UEE
 BtTaHAiIB/AzFPRGcrKoKfYmHvZl/W31/yTf31mxOyn7DKTBm0pGxEunzAM/VzUap55p
 AInYPvbxnbWZMdPptnmEFIIPxKwskhzIKDdI5B/MZWzoi2FJEWqDn35iKcqpiRWSYnbK
 L50XKZ9Fvw4w+tr9+9NAtAMtYQJi3Z0pqHeRiFs4hBX/dubYrfkerDCXUb37CC4m8jLh
 BCBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwWTpDkusXfkgmOlsCEv2DQxlywWmxJGZWjI+Bsmhi4YFSW9GI47xcUmA+++2hupBVEMbQ+ers25qV@nongnu.org
X-Gm-Message-State: AOJu0Ywj0Sxm5bPALgiVim82S+FiA9+rlb5RhJ1hK77awBMQFTx6kJsA
 i+/pWkx+qW7ZWghTr45cD9WkDeh4L5D1jpF1QAbWN9S86swdWo1fdhRLUJogJW8=
X-Gm-Gg: ASbGncu7K9NrYhTLiN2Y05FnrOlj9zjxpqd5yOU6/U6enVadDLoYMBfxeBoNMNlab0Z
 r6bfqg9xZUaxB+UiNBWykBsMDn9pxL23mOLxtvxQnSl1Dm6+ZGiBrdKFdQO5HZA3IvpsviMUcqS
 QeB37aJPkLcViy73CuUHjIi0hsQ+2D95e3P1JP8fWsa9tnhvmRKs5Ds8it5qSaO5f/99d9RU7hK
 mgKabXjDCTsaL/khJ+Zq0ddLA6MxubPvbmn3x1UAHFC8Xh64F4YozDghmwmF+BhupRZbKul6gp7
 TMcTZY3H7J52/fwwvxPt7iL6YenQ6WUnsIliHwLBI1pZm2ActMyUxd6Ts0T8A9sPteDdDQ==
X-Google-Smtp-Source: AGHT+IH2udHSwUNErSUylpjdwGrSfckpA+qNe/rHNu2Ysc9Z70q716OZFGPGThfbBCi52l6KiJJE8Q==
X-Received: by 2002:a05:600c:1c13:b0:439:98b0:f911 with SMTP id
 5b1f17b1804b1-439ae1e9aa8mr112740885e9.10.1740388417661; 
 Mon, 24 Feb 2025 01:13:37 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02e486csm99133075e9.18.2025.02.24.01.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 01:13:37 -0800 (PST)
Message-ID: <bf35aad7-17f1-4ab7-a9d8-118eb531f8fa@linaro.org>
Date: Mon, 24 Feb 2025 10:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/macio: Improve trace logs
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jd Lyons <lyons_dj@yahoo.com>
References: <20250222122850.9D8B84E603D@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250222122850.9D8B84E603D@zero.eik.bme.hu>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/2/25 13:28, BALATON Zoltan wrote:
> Add macio_gpio_read trace event and use that in macio_gpio_read()
> instead of macio_gpio_write. Also change log message to match
> macio_timer_{read,write}.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/misc/macio/gpio.c       | 2 +-
>   hw/misc/macio/trace-events | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


