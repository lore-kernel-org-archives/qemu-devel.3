Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1B0CFB458
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtqC-0003Ep-I2; Mon, 07 Oct 2024 15:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtq6-0003EC-4F
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:56:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtpy-0008Q8-Dj
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:56:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20aff65aa37so41317475ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728330967; x=1728935767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSxqW0uHxp+sUL9P9ODmytM1onOws+nrF3B0SCf/b5c=;
 b=H7lRvVfMCm1ymvsjeQy+xb2M4zNnSNJ6xgMYKZRihql+Y/G/6KDsUpr1RPywLSDOGH
 PaxKcFGWRnMnWHG6hIdJ2PrNfx9o+2SC7EmRDDxh+22DiHEBBCUyz6Ncq90DkD4N+kpg
 CGopWqVdjsgtriqnUOE3iRoSUriTNdk//6/wDOH9zPYvyDPdjhlQJtVngou+2o8pMBYN
 cIMTbFJ+Ts4Mv6hf0ejwbjLcw2rUa78ECZyA1+Saj8aRy6GwPTeqbsGSfbMSry4zI9BK
 9AYVgG+PFJOtsW3EMZfi3Yv5RNPAFKSomtnLWQJi9ECXVqeexOWBwVw6pjMpehUebIFn
 SweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728330967; x=1728935767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSxqW0uHxp+sUL9P9ODmytM1onOws+nrF3B0SCf/b5c=;
 b=XzdUPb4q/Mb/LwG5HgL9ljSP1oupdqRl1vuI4Eq+WpVd345s/QQ/ZTaxgMNc3G0n6Z
 mKWrPQFCGAJ5vSoDCAnNVlG24Wm5os0nTvdjbWWVimWOTW5Y7wrR1QZEpqRODOQ3SvH+
 m0/WhImaLsRveqgzxuaAsVsHZab7K0NnId8VPyW9aRoFz3dQtSseTJ+olhquNW3g8vUv
 XiFubbHHqGnCx+/sKPRBVQRC/NoeHq5lac/6DcP1x+xFfIIIrnTxn9+/Ezj9YgmdNGxS
 F4XuCoGajHrliAXG92b4kPs5/UNZFspp8PxntUzJnwnL6NTaajwU7QRV8N/Hf/m0sSLy
 dsRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWETuqmY8CWhTFGQ3bOTriOoALouMcudXn7QZHmoMCEIr6v/LhncbQx2JrrNy2vO4iTupejaa9PdzSL@nongnu.org
X-Gm-Message-State: AOJu0Yx2oBKkIX5jCSUBq3WB07tc0eiu+Ql6iUiKIPDEa5Q5PZBDtpcj
 6DjtkzKHQ/0WA/S7dGiy0H/06yVfw5YV081ApuLnWD3kASlF2dhZwFHxjAIfEbluJ6U1kt35Yj4
 g
X-Google-Smtp-Source: AGHT+IFKUK5pVrrHJmSVJEp7fl+OdxKbwkmrR4g8g7WF0SA/t3OSirc8UZXddWpN/FItyR6KZKO6gA==
X-Received: by 2002:a17:903:18a:b0:20b:7d09:8c86 with SMTP id
 d9443c01a7336-20bfe49666fmr217491655ad.38.1728330967028; 
 Mon, 07 Oct 2024 12:56:07 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f681fe06sm5352518a12.20.2024.10.07.12.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 12:56:06 -0700 (PDT)
Message-ID: <436ab3ab-4b07-4bfb-88aa-4c9b2c2ec6c1@linaro.org>
Date: Mon, 7 Oct 2024 16:56:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/pl011: Use correct masks for IBRD and FBRD
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-stable@nongnu.org
References: <20241007144732.2491331-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241007144732.2491331-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/10/24 11:47, Peter Maydell wrote:
> In commit b88cfee90268cad we defined masks for the IBRD and FBRD
> integer and fractional baud rate divider registers, to prevent the
> guest from writing invalid values which could cause division-by-zero.
> Unfortunately we got the mask values the wrong way around: the FBRD
> register is six bits and the IBRD register is 16 bits, not
> vice-versa.

Oops indeed, I didn't check this closely enough.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> You would only run into this bug if you programmed the UART to a baud
> rate of less than 9600, because for 9600 baud and above the IBRD
> value will fit into 6 bits, as per the table in
>   https://developer.arm.com/documentation/ddi0183/g/programmers-model/register-descriptions/fractional-baud-rate-register--uartfbrd
> 
> The only visible effects would be that the value read back from
> the register by the guest would be truncated, and we would
> print an incorrect baud rate in the debug logs.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: b88cfee90268 ("hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2610
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/pl011.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


