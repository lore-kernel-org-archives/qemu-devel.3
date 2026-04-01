Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C71D2ED0A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vrO-0006wj-SD; Wed, 01 Apr 2026 09:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vrI-0006li-JM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:43:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vrF-0000PE-Vi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:43:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4888375f735so8659415e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775051024; x=1775655824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IjcACLtznN1PHlQRUmna0PKC2gd7SFRl6cagc9NWQYQ=;
 b=LB5VNCDouIQLgLKhIn1zJTkXlKy2517f6I+LbNtIG3F7djtA+ySBrJzC5Pz9I+FiJf
 ZY2o4vMP5Jt2odkPjROxeNY9Bjz9riiqT4mMd1so1rJNKnIVKnSqUIaod29CJoY7nHKe
 P0nva9UM8Gh7NzZyUimDRgCF9HSNJ+kbO7kC5YOMxwXIPUrVspnPxqvp/jPeBaX+X+27
 r0ia27q6UDeuf2IFRW9p9Iln8n89rT2jKQG+sZA8g6rdCQVZtgVGbo3q7eJpfjsjHhxI
 Htl+rtpvTg//AVb/IWzPNblLY5wQCOIZnLUIHBIeg5BNz4l7LU0fcalC9eH10HYKNzqI
 I+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775051024; x=1775655824;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjcACLtznN1PHlQRUmna0PKC2gd7SFRl6cagc9NWQYQ=;
 b=aO709WxRLBLEsQPDAGDVJzl25sZFqOw9zo23T7XlzSmoVXk5uOMgT+OEjV09TUbpoa
 M8EdCT+bLt1Gjs5xu/B1BiygY+2nMfmsanqjHHRwsqLkP3jbvdA+5fcHnYV4x5+tBMr3
 NpzpgeLXoJjG01E9yGaY+TudTRLQkPH3KkVkXZ7WrFSQVvtIWPm4MZHItjKVXWv3PyP3
 /3AblChXNdgv363kLVUwm3WBSHPsyzfktoBWT7mERlnZvbTQP9dvNT5Suio2tfCVQPL7
 NbtE1ZU629QY6y2/Zzo1f34N0U0vZhjDTzvYxC9h7LqmAwSKAU5sOPHm/tgvG3+Nwfkd
 a4jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjJ2yhFVmplzjWhBLzRphkXRbh22DEdqxCVYbqXl8r+GFCqCoZonTl8FHjoDOgyQF7L7lK6PkF2Tfk@nongnu.org
X-Gm-Message-State: AOJu0YzNYF+UMcrdevdtd87zoNQ2cpCeS2SQibtErP1652cspCTXUHSm
 UOSS79u9dtkZqqv0WCUuUKar9Du72szckUF+6vu8PmOvH8wa6i2bF1ni5OudYRLMMIQ=
X-Gm-Gg: ATEYQzxhR+J5Ios8CeTjGzLNWBFDhZM3u/BiwvZgMEC4Xcvkfv2OXfIoMmWA9z7Yr8B
 3wXbEJBY+aYC061egSzLYzddSvxE+lfUFfdYIL8q4IGQSt3727h7sj5cKp/nSnq0TevRctZRPmf
 R4CHPjMmJZhIKse6zvqCFpyr0Feq7uWkfMwKSd0BoSSk2iLBVVdeU6BP2q61qi6HMvodFtvqntG
 TSnKFPqtHHVBnXG24ZYpCbiF8ZbFwzVrdtCu9m/os858wi/7GKIkB5ZYFF4rjjtqw80fW0OayEt
 ZlEO3f/8+rfHt57aNxcBPMlOidRKGc2efEKH88De814OZiWwd/fCD1HSbWY36GyBQls7GoEpXpx
 d5Pqdyop6dEhHvNfvBvAnXNR0TqDP0uBM+RgWOeQ7xc7SKJir4biAHQfrqXBmL1sNn9EmJmDRvY
 CJFSLgWqSndBd6KcHK/Gf9m6AJgPUKdv6aKeGYQbbI/ySu2uhnqzgrTx5iMgkAakSplQ==
X-Received: by 2002:a05:600c:810a:b0:485:3812:36f6 with SMTP id
 5b1f17b1804b1-4888359db64mr62654515e9.21.1775051024315; 
 Wed, 01 Apr 2026 06:43:44 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a65635fsm147475e9.6.2026.04.01.06.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:43:43 -0700 (PDT)
Message-ID: <9067946b-b7cc-45e3-9788-6bcfc0e8f0fe@linaro.org>
Date: Wed, 1 Apr 2026 15:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/60] ui/console-vc: extract vt100_keysym() from
 qemu_text_console_handle_keysym()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-29-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-29-48eb1dcf7b76@redhat.com>
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
> Move the keysym handling logic out of qemu_text_console_handle_keysym()
> into a new vt100_keysym() helper that operates on QemuVT100 directly,
> continuing the effort to decouple the VT100 layer from the console layer.
> 
> The echo path is updated to call vt100_input() instead of
> qemu_chr_write(), since the function no longer has direct access
> to the chardev.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

