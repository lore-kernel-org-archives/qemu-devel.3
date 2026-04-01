Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAAED35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rb0-00064O-EJ; Wed, 01 Apr 2026 05:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rao-00061Q-25
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:10:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ram-0003id-Dk
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:10:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486ff201041so65250615e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034627; x=1775639427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qtN5pCYyfrEdn7+iZQa3Rodx7E+/9NCG0yLpziekoFw=;
 b=xXOX41PxBi2IUn5KYPwvxgYx3aaUtChkJsG9pTHxzURfJ8xtlcDbtS344D86+ZKnvj
 IvUXSGwQ2F3eAwfpuN1jEK6WOeG3Zxa7wibo/BjMpPiIKgAWGtpCumRZqIlLAwYXEmqB
 6NoFHDdtzyLoT9Kx2whhS0NlmO8m5qbyb6urZEFOgKPc8CHB54zePq6Y9dJF2Yb0uUjk
 HNur7sJ49w1dPL78EH4i/hu4DXLU7rhFlUzjUKiJHe90IfTEe3BjhhoFuae/NlrVfa2A
 mAc+r8qBOliFgr7flTkRdP6G1z4B2eelIini+CbAwXTgM8SM5dLd9gNbpCiuunvSItWz
 gFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034627; x=1775639427;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qtN5pCYyfrEdn7+iZQa3Rodx7E+/9NCG0yLpziekoFw=;
 b=cjdvuRVmsPoQynrl0UfcDlsYdCvZMMezX9aNQi9wDYwJ5cqbeLpRXIwJn7W10BR9dw
 aC2N3jkrOcM2lEGRROvt5BwfLLqpODrGtv6npM0idbIKH6eZSWMR/bMEGFXS6tfBZirE
 VHYt0sgSICCXb7Nn2kEVumL9eYYvv62r1B0kf6nm0VSqWtZOwDnYW6ADFgBXES3PRrjZ
 BBvHkQ+Pt/J1BTtz6pt5M2Js3p59jdWs1IXZYnJsLh7C1/8O6jL38T/BsciN1bISR00H
 4+QIa4ZRrnQKuVqNQXDgzCEPUkv28XnLzOXHuUzv8xI7T7/ckViILQ71lNEL+absSyLU
 JVBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3lfzy/LI2wLF55A25cYe3E07FMwhCM0nm5T+h3qJylBophmMdxWfhjjGTlIo3qv0FdnuYmJtSv3Di@nongnu.org
X-Gm-Message-State: AOJu0YyBqSiNocTIqEgfgtmzVEHc7wJ7wVd5pM9vER0i4Uvn667mxzZ8
 SgzebU4+8pZaSaqKlBbHzLi4Am7GL2emWAi0oxRFG45nGfAtbArno59aZPxcMjnu7/I=
X-Gm-Gg: ATEYQzwYKxft4s5uTUetz2i+iGGlmZ63fq2OTHpsUdSpl1gvGAI8P1YfQ6CxtlAxnl7
 wHU2XgzBY5NJAaoZOIVfkcXG3psHJRXyxY+PnRGa7w1iEp/1ALswA4MfPVaPHBaD1O2M8tKzyaG
 hqRsjO7bLDmcIkUjqVLaKeVHU6pEDlt9zI9p/6/8aQ+CVC1PTx6FdunJWQpb5ca09u0QkocmSkb
 0Ds3AqKKHdSB23gH5IDfgj5N1O+cj3Pcm+mXwO9sty8sCbpv/uIqiNjd57K33YJNBFFFVCKeaD2
 GXS8BHyQkL2fz9Xw+48OVVQr0aMPXcDRnJkyAo8cAJ80iwqQaVqbADL6jI2iJqr43vRk9fV2uuj
 vQn1VeSTKbWP32XmnAPSTdBJMX78m6u2YwMGTeB1NIlSjfL9yET1D7N4k8Mb7Y1ffHAT5ktQGaK
 VmPoBjVVV7NfelqYjdQHJ4q1mG3aknLlj2AV7bw2NM5Kzt14OlDkQy2aeZl3qaCguxqA==
X-Received: by 2002:a05:600c:a51:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-4888358cd01mr44116135e9.15.1775034626791; 
 Wed, 01 Apr 2026 02:10:26 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e81a20asm103225865e9.7.2026.04.01.02.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:10:26 -0700 (PDT)
Message-ID: <fa317521-8ab3-4dc3-a344-6c2015bf665f@linaro.org>
Date: Wed, 1 Apr 2026 11:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/60] ui/console-vc: vga_putcharxy()->vt100_putcharxy()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-17-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-17-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Have the character rendering function operate on QemuVT100 directly
> instead of taking a QemuConsole and extracting the VT100 state
> internally. This decouples glyph rendering from the console object,
> continuing the QemuVT100 abstraction introduced in the previous commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

