Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156DACCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuPb-0001Pf-Ls; Mon, 03 Nov 2025 08:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuPF-0001Mg-C1
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:15:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuOw-0008Oa-61
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:15:33 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47114a40161so52349525e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762175707; x=1762780507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XNK3FEOei4OPeXoSL30jwVAn9mKlOqnotO0C4Roa6Ro=;
 b=omcT+4yWrYNp6PKlvx8dr7IkWhyh9WzTXDgcJ9QDwjKAYu30ohkL0I0NhJR+BpV7LQ
 AXtXv9GQv+76nVgPhoDqqwe6t+axGjFE9iXJtq6Nvj5VIo1m0dks+CqgYBrRq0WUuD2Q
 JB9V3lomo5lJFPXvKhwD6lugGZvfNuIg2Xtym4uQSJODvgJKyeNU1TlJ7gYRnenAKH4G
 zXfk+ab0wapnLXlNtW2n262QrGE2z/tezmltpE1WCs4ilk8z6nM6AmQvZfM6UO6QCMxh
 SaJb9ZmM8HKAl7R/dV1CNm6m0g3kyeWne+vk8LuwLwr7/TS1Na0XunvTHmGT71rzFUbj
 cXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762175707; x=1762780507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XNK3FEOei4OPeXoSL30jwVAn9mKlOqnotO0C4Roa6Ro=;
 b=s+wNjbo3bHyZ8fSzcccZ1DTaRg60mV4KoOsC40+4iTFzodE2PdVmpvRteiPChBPzjj
 R0r5baCsU+0aAkGUad9+yp+4x7xK2I1+Z9OwU+eqbcy9vsZ3T1yNJFTWcI+lw+7gtq5n
 6+7b2KDd5rAOUx9s+o6kQiEI68Jcot7eKijxeKyZCwyTXWT6r0Z1hMggCULyZISpwj2s
 Bs2SX1i76sLh17efTEU0eqre+yZFzl/adgPWjE/WYwifpuEMCKitC67lnjEBdcn1XqVF
 uYixMn4iAsjI4LOc6NJdRE2xJujvmSRV72T0wzxzIvbs79/alUEg6Ze8BFmHqPcEzPNG
 L0lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfczqug1As5hogxA/MiyEWckp7i7Nj3eQ6i6rnVe73zyC0wFJGPIlgbqvz6f29LEADloHqnXtKMAvS@nongnu.org
X-Gm-Message-State: AOJu0Yy8jgkx+5RNlFJpdEzlv2+jfcgxXytpWLu2KlaLl1VHe9P8qIUw
 lIIt9EsuGyGs0Rh3d6RMlEfNtvkhXdQ8boSy3Up5as0sEOtP7TvWQrOPc2CeWJd337XgPgBtEKN
 77jOxeF9k+1e8
X-Gm-Gg: ASbGncu/62rJKxnYBVR15fLA0XrG4+dvW0U2tPgktWWQYgdnp33G8JBR/uIiKh5pC0h
 tbuR/auvawwy/HYxvcmK3vg/Hh5n34r4avzOvjC95QZ52YaE+FdYGMCxBuK4QVnWyu8kdT6uT0v
 fa2t3cYY/gH07gyjICR4UwjfKkjzDzg2RnKj3lECtEZldMxRbSYAY0bOA6bbS4CmXw+S5n9Vf/d
 hCxHE6vkVPgwvJrmwHD3Vy/7Gh9mKThZB9cF396jpmpEyzcdSBoJaV8ArlROfGChuX6IwkswY9g
 m0pvzngtCoo6cFKTzzLzxsdfrtql86Or2ZHxPoBVWNyQs577a+QzrXnzdmyCZwF5NetOoGMnr6F
 Thy63AaXhOth9pUnPYmshUHNZ/csT7VagEGwbm5GoI88sCFozq3efzaErwcze1cFoUgSmyp+AkT
 p2FEKqpOj8hdH/NP5x84YZcN684GljhyJ4ivWFDPkMWVuoFBRyESfl
X-Google-Smtp-Source: AGHT+IG0Jr/tveK4yXoFGsFWNFuHHW7JSdtbsAeIec9poMB2DP7B7ZOppRvwQ/LzgOvlgUw8kSrh+w==
X-Received: by 2002:a05:600c:3b13:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4773089c52fmr108069685e9.26.1762175706845; 
 Mon, 03 Nov 2025 05:15:06 -0800 (PST)
Received: from [172.18.140.215] (ip-185-104-138-156.ptr.icomera.net.
 [185.104.138.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c394f0csm153913775e9.16.2025.11.03.05.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:15:06 -0800 (PST)
Message-ID: <a0a64cd9-7b7d-455a-ae61-d286d29aa990@linaro.org>
Date: Mon, 3 Nov 2025 14:15:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] docs: Add eMMC device model description
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <43c6bc1a28f449e59792526319ddc5ba23fd2fbf.1760702638.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <43c6bc1a28f449e59792526319ddc5ba23fd2fbf.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 17/10/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/system/device-emulation.rst |  1 +
>   docs/system/devices/emmc.rst     | 53 ++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
>   create mode 100644 docs/system/devices/emmc.rst

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


