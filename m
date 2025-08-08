Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A96C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPaz-0007wu-5E; Fri, 08 Aug 2025 12:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPaw-0007Xq-VZ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:05:27 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPau-00088N-Hz
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:05:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so1369520f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754669123; x=1755273923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y+DPg5+/JB+r+UDU2jDFCQd9KivoNuZf0EmbMmR0rLk=;
 b=gqKkYPlhGdW039vJgjMjmfBp5oZfaVwUYoSQStujdP8F+OmCm3fvQ1DxGCzpZKF1uB
 DD9y/czCj+UKITkjgMsaplMoA2wdCHpL9FuBqJDFWIO4t6DgU431hBhZMMv6MKjzDV7C
 b0H/XIs3GoQmU+pbKatdXkH9vNwgxdnlvwpxjDNmrQPdX9Ve0XI4d1bbqCTbr45wXgUt
 QQp4pHjVo9/brCEp2q674Z8WE0IK/Qza52Tg8uz9pjYF3tQrQWMVRo33lFgjA/ARbyA9
 jFZI+1Xwu6vjziu9AAQTTIxR261/6y1zFDaiiuACFlIYJvo8r7I9e48/Cco5YBw+4LZV
 vqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669123; x=1755273923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+DPg5+/JB+r+UDU2jDFCQd9KivoNuZf0EmbMmR0rLk=;
 b=U2zQDbKhwDIk0HPsr5OKymscp0WOq06ngb34JYdVzZTsKcX2UNw5nkm45wz1KnviR8
 8LucOKDDV5JMwVbahINGvTGS674/BRPxXzNE36MpmriiaQL0Kl3ILdnSW3rbyiTAnCdg
 uDvDu0OtQtdhIwhCeQ9U6Dc9inGEdDqq0xGxY4sIikJY+hEBPBNnib065uO9FJs5rGeC
 N7Na5Zomuzso/blOhYok1zXdo7yVOOvUGShyMfLT6duHZznOSPM4cv6EaWSg7D8quNG9
 s3fP0eE2XsECU4jkJ2mgtv5P50RQFy1shNkTxS9T4YVCB90yGwetwNlZVq41GeC+UzX1
 78Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTWspe+5pPXhCMvGqxuq/GkMFzRZWb5MGO8FZb/KcrJF8VMn45L15nmrWQ8wl0ZIhQsTNFXaefq7kd@nongnu.org
X-Gm-Message-State: AOJu0YzLz1WnzcCDeSpKq6zHFvsGYgPdFnk61NGOMGXI8huMaMP3nJjs
 u8Z7h7bSpoUT2HaoGfMvPGtJNequV+6sESUrYMzo51Vn+wTYjWr6hSDqVTPuE533CakbmAXe2HB
 D0V9P
X-Gm-Gg: ASbGncuSlf5MWr0JWxn4iRa4YqhI8/aEYkzWrAT2p3OOV6zz0q6f+tA729qY3kkTV6B
 Fw58676iU2fqeVxiFeHG3avv8zcLvdp/ztmC/Q4jw0TNqtVPnqLd4nwa05p0H2FDFbwhKP5aadK
 cF10QjWefEBYO2gU6fiB2EP3v4znsle6oBLmDdYx1r1M4fvnB+OfMwKqOQQsNyxum2PM0mLaAGu
 2EguxfHTYqndS4SDPduwcC9ZcaMVaIGPeTnJ6TS8zPZAAR88yuERFIKLpFJjwnqUn/80J3toSY6
 maVBdnOb7mK4yQb0oTelqBAsnhsvdw9V10CLZRAYuxty5Xd7rMzXfkgXG1+xnQnNDQi8ihFKCqn
 I+xKmO5R/HTzy+PGVyyCbwYlcsUTQbj5ht4tGrk4ISJUnOZ66LlTRExh44T4prVtxgg==
X-Google-Smtp-Source: AGHT+IHSn+PpPU66r8FVzHkt1WgG16nnuZg7ad9zsYPAQQNbouTmX3coZTAY5kp2YkLKSyRy9+9tOQ==
X-Received: by 2002:a05:6000:240d:b0:3b8:d15f:45a2 with SMTP id
 ffacd0b85a97d-3b900942614mr2904098f8f.14.1754669122639; 
 Fri, 08 Aug 2025 09:05:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453328sm32453021f8f.46.2025.08.08.09.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:05:22 -0700 (PDT)
Message-ID: <ed6b452e-87d6-48ee-b060-aa62eda7c4a9@linaro.org>
Date: Fri, 8 Aug 2025 18:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 17/7/25 11:38, Djordje Todorovic wrote:
> Add RISC-V implementation of the Coherent Manager Global Control
> Register (CMGCR) device. It is based on the existing MIPS CMGCR
> implementation but adapted for RISC-V systems.
> 
> The CMGCR device provides global system control for multi-core
> configurations in RISC-V systems.
> 
> This is needed for the MIPS BOSTON AIA board.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   hw/misc/Kconfig               |  10 ++
>   hw/misc/meson.build           |   2 +
>   hw/misc/riscv_cmgcr.c         | 234 ++++++++++++++++++++++++++++++++++
>   include/hw/misc/riscv_cmgcr.h |  49 +++++++
>   4 files changed, 295 insertions(+)
>   create mode 100644 hw/misc/riscv_cmgcr.c
>   create mode 100644 include/hw/misc/riscv_cmgcr.h
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index ec0fa5aa9f..e3fce37c01 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -108,6 +108,16 @@ config STM32L4X5_RCC
>   config MIPS_ITU
>       bool
>   
> +config RISCV_CMGCR
> +    bool
> +    default n

$ git grep 'default n' $(git ls-files|fgrep Kconfig) | wc -l
        0

I remember asking that already but maybe it was a different
series... Why don't you want this automatically selected by
default? All our codebase does it, why change suddenly?

