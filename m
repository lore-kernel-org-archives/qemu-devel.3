Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B066AEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 21:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzM1u-0004YH-21; Sun, 08 Mar 2026 17:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM1r-0004VP-Bu
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:51:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM1p-0005fs-Sl
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:51:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso111025765e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773006672; x=1773611472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0+tqmKHu/+oqg/FK6qsOGhfaiZ9s2zEPwTyIgwoAC0U=;
 b=s4r8ue3dx19Dkio6qXaHSbNYSOLL9WHaE0ElW7FkKUzGa6o3TTdKzubKF9slTY5bZA
 pCKLo8NpM/8F6FsFH68K77BdSVG/VyQPmkQAGBpSJF5C3AKhPJG8KKDMUsJTi2/29cRk
 ioXUZtXbz0wypsp2qeuSomozV2Ip1bplgE0XfjuwrS6tEWUMz3yaAGlGq0Oy+zQqwlCM
 WdepvsJkz66BR25za37HRpcpeDbtuTMn4bhil3/nY4U1dACzkY/jphuk0nfWJHy98lXy
 SLWnFVRoHkR/pJca4kYVcExLiDdwI9LXEBUpxRXcjs3QTbjECuu6HlqqCw7fVIJxqoOB
 SMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773006672; x=1773611472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0+tqmKHu/+oqg/FK6qsOGhfaiZ9s2zEPwTyIgwoAC0U=;
 b=Qbu4hPCRGBrA+DF1Y2VuddH1CJoqpaRGVIhUIV7y7L79u8srOg0s70D8cavoueNimL
 rK+zdbxtSjzwGmk6VJ8Mfc0gMjdAwCPtFZm/J6Tj5JeytuLO0G6kDEbKXRduspxXAsDx
 H3YcwrA6Z2ZG4PM5aOTsj/RzzgvAbte0A+3IZLw8c7lvnr3K6J/nD8Dy1v0tKkHF9W8U
 hBridzowuDvhJgj0Qq9cMOC5hQHRNxCT8Czc+SDfrskiSqh0EcS/Jv0Uu5cYWBSzxIxk
 2VmckOtQ/mJoMoZ6gL/jleywe4fxGtpbdljYAmuMMWJx7z6R5Mkilt0V/Oi+x9TURXfd
 leQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkCgaFde7lZZq7TeTUbYGawivInIlvSa4SqZhv7eA1s1j+Ky4ulH1wH69Uy3pFZTB2+sHejZSA5lDt@nongnu.org
X-Gm-Message-State: AOJu0YxYoVYiVZJn1orjDZqojvRH0cYUeWy7AQfBEAxSjLUVV2mfX5Gq
 O0cHxKw0JeP5+uURd3bgnfg9VEu9AeE6SsYoUQwaeduR9c8+tsV8bGV4T2out/BHw+s=
X-Gm-Gg: ATEYQzxJ80+NJKvR3bhQK5bkngM/UWlgWk0k9WAijUI4cwriDN/1Gk8ZMuJiDaUyELG
 /wWbvWOkgcsp1dmGuUCeLiEMatqaYvy7OpwO9pBYlKd1RjRM02JWpCvILNFW2SNKM+tG8CqiWLv
 lxnd++RFxR2wwPUwEDqF3540IiVGz3CqidiPWHAJP7LmAq/K7oS3b7wuE8tkO/AdpXpPYtuCeSy
 WYmLGpwNLzYznmqEezVqorMnfsCVike98XY9rMj6INVkQmCFxBFRUfqHdn2GX+yyRFEZ/GQktX/
 /fZHrVoGCHCQH3vNxqTOBgsjbK5sIaVqfC9jeL/vlCQ5hqRKw/KIvmyJRtbnMiP8VZAsabWu1Tj
 +nURE6fNTnKvJF8QY7suANpNgritDTKd06o/4t+2SP3iKR9W4fepIxKyPkvk2T/jYpuMc9l/I2o
 NKItBBEeW1ego2Ca1ixaDFMKhqxsCzH6COH3FjMGaHzTAIkiQmByQqqc9OqWhpIBKVEQ==
X-Received: by 2002:a05:600c:45d1:b0:483:7b99:131d with SMTP id
 5b1f17b1804b1-4852675e55cmr157569005e9.16.1773006672055; 
 Sun, 08 Mar 2026 14:51:12 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485245dc298sm73897825e9.15.2026.03.08.14.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 14:51:11 -0700 (PDT)
Message-ID: <b5d5883f-5d37-476a-af2c-d1331360848b@linaro.org>
Date: Sun, 8 Mar 2026 22:51:10 +0100
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
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


Queued via hw-misc, thanks.

