Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81228FC9EF5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 10:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyp8M-0000Px-9b; Sat, 07 Mar 2026 05:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyp8K-0000PN-Ur
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:43:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyp8J-0007JL-6W
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:43:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so84041135e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772880221; x=1773485021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Na46LPPaJn3Q05XskxsIzkdab0NAITm5NixAze0ucts=;
 b=SL4d80h61aNMXOoHsyKoSjHslM2GRihhqMb/xZHIUtTaeqmVT2Q083DxByipZw+IOn
 0P1gnlPTv8f3x2x1tJdSefch6uRoYrm67OEHUy4tRoFVw853A8soelysAEdGjqIcPIuT
 oynr7lSFpBXELBjmXa8zfBEjkB4UObCtSH2tiNzu4mDuasCEtEN2Gwq+fx87/QNxs8Gr
 /5IAmymVWBubYVGDON9kt7CS5NJYEIfh+BlKbd8gxKJnltJY5bz3DzlnhLbiYiwJ7Z4A
 LzizvGuwa0aFvhCGP2ltVoAkrTL7BteWQoOrWYVxDefPfYvUKiy61WVQbBfUl+jBLKiw
 H+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772880221; x=1773485021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Na46LPPaJn3Q05XskxsIzkdab0NAITm5NixAze0ucts=;
 b=p5p96ZXlPT42aqT9I4wmdIWzpukybcqF5D4wtZAvIfLMVv7ZexGDsjSIgEfNl4/0YO
 XFOC+h3XlechcnzV4Q/tbCWUQkU1vgQt9DTlo5jrxNveKz4Jj3+GgXQQDIwd4r7uAz+X
 b7lmcAkxiPZE5xmUdtRQK83FgYvILX9yx23wXbF+VT56j8T9uXBVQ3LvtOi13IBlCcHT
 hINb2lee/hI9nv+ZRT1Lf9chdgYCxO1lzaObUY8NsqunPQl3dKTwrGvH1Fm69iaVEZXM
 kID/3r7I7rf0tSoD16eTyly0/6JLynQ+aLQSvl4J0nShd4cMPTTSwq30Tg387K33yJRE
 qbIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr3LJ8lBGmSEyK3oTgknF44mXnY6pSbqLzTH1yCYyPpSaTEHOq3yS1yUR/pvTtqGcwJ3IbsEZrcn1N@nongnu.org
X-Gm-Message-State: AOJu0Yzf563TXwuQC0L2iHa1rCrWzRFSi5rjM11Fa0M2El6tcZx0oXwY
 ZGUC720jVGzVnj1evc1meYA9UFnmsO1phWa4pb5joCwfBGcPGhIwu1Rd4O/hQXm9nu4VZiwBAaQ
 exou0TGA=
X-Gm-Gg: ATEYQzykPTdD8JKXH0VHq88XRQnR8bG8A81inbrH+UDA/QML2mNrJim1cl+uaWRrmr+
 dftqvLL8qd3Yl3okWAPhr7RDSWAs+Vv7rZzR8hnnmMLumCz6K+8r0FBqNV0DdhB3RXxBPGUvozJ
 T3JX8RC5ej2sGA3ymacJcZAB3rtu6rx9HOHniGOtoBFnQpTU73JlxxBcG7wTh7I+hcsPrgm5pCO
 OkSL4m4HmJBKsgF8DUKXiQ2Mcn0fazJ29DP+SN5ZUPL0tLXcFUPXVG3wqzRtQGFpabRgjCN/a8M
 cj+GugxwfM5ZWcyn/5Ak9/U4Bd3Isuy7Qp1M7x2Ta8QGQzCnUkVNhz+1bSAfx3MM2iZphbGiPTO
 tU6LSpwJVcr9ZDY9sv4SoPyC3fvzWMjfFYRMUUNSYTol+YSRGuNVvoPPaKpoaHYMACzxM+NJgTE
 O3GGKQDmcCL//W7RHsEtVyRR+17c0rrWwaFQjMmGGsoj5uZK0SpigHHxhglWtfPxFarv+EKTNiV
 908
X-Received: by 2002:a05:600c:34c3:b0:47e:e8c2:905f with SMTP id
 5b1f17b1804b1-48526925423mr92395575e9.8.1772880221339; 
 Sat, 07 Mar 2026 02:43:41 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae46353sm11112537f8f.33.2026.03.07.02.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 02:43:40 -0800 (PST)
Message-ID: <25dd2ac5-7837-43f5-86f4-3069c2f06baa@linaro.org>
Date: Sat, 7 Mar 2026 11:43:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/m68k/mcf_intc: Use qdev input gpios for input IRQs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260306190425.3047580-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260306190425.3047580-1-peter.maydell@linaro.org>
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

On 6/3/26 20:04, Peter Maydell wrote:
> The m68k mcf_intc interrupt controller currently implements its
> inbound IRQ lines by calling qemu_allocate_irqs() in mcf_intc_init().
> This results in leaks like this:
> 
> Direct leak of 2944 byte(s) in 46 object(s) allocated from:
>      #0 0x5cf95ec15323 in malloc (/home/pm215/qemu/build/san/qemu-system-m68k+0xf9e323) (BuildId: 18d55ef8ea9856e68ee30802078af5050b8b06c5)
>      #1 0x7637c65c5ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x5cf95f6b2f27 in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:767:15
>      #3 0x5cf95f6aa62e in qemu_allocate_irq /home/pm215/qemu/build/san/../../hw/core/irq.c:91:25
>      #4 0x5cf95f6aa62e in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:79:16
>      #5 0x5cf95f5f6d99 in mcf5208evb_init /home/pm215/qemu/build/san/../../hw/m68k/mcf5208.c:310:11
> 
> This isn't an important leak, as it is memory we allocate once at
> QEMU startup and that has to stay live for the lifetime of the
> system.  However it does point at a code improvement.
> 
> Modernise this to have the device itself create inbound GPIOs with
> qdev_init_gpio_in() that the board can then refer to and wire up
> individually.
> 
> As the device is used in only a single board, we can update device
> and board in a single patch rather than having to try to figure out
> some way to change the API more piecemeal.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> there's quite a bit more in this board which could be
> modernised, but I stuck to just the thing getting reported
> as a memory leak...
> ---
>   hw/m68k/mcf5208.c     | 24 +++++++++++-------------
>   hw/m68k/mcf_intc.c    |  8 +++-----
>   include/hw/m68k/mcf.h |  5 ++---
>   3 files changed, 16 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

