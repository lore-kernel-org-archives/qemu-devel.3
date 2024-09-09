Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1195ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snibS-0002y0-Sh; Mon, 09 Sep 2024 13:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snibD-0002KJ-MM
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:54:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snibA-0000Et-F3
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:54:50 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so4723661a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904487; x=1726509287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5g2dVG1Ean0U62xTDBzCbRX8WvLQ6K4TzDkAxyvPPkk=;
 b=R00K4AuTWB+Frx6fvlKbchd9HXTh7yEdHgWPwB8nnKQ5YICaQi0q/88h2RGrb6VZ3Z
 443CKvUg1HPShw9umZJqVa6+4E7OJYyjhBYQ7cszAXthZr674YetFT4mVHyq8YJvHxay
 hhQ3YQc5adFVERqh2B7GoEAU8SrMR7pXgVdXkrvSorVXLzkOyMw2Z7g5oeW30rIodGNh
 7z5BYUjfWOtdfw2C/257XS9Gn+MrSgPVbPJDzYLW/3z1KhcDX727WCvTE6OCS6v7UvsF
 kniftwvvvkvG87KYxbcv9lXOUIARtR6t3Y44Ekp0ISSxPVeUNtJcfvxZ6HCsOYjR72nS
 m9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904487; x=1726509287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5g2dVG1Ean0U62xTDBzCbRX8WvLQ6K4TzDkAxyvPPkk=;
 b=pcUBJoQh20GQLuOhkUnE+3906B5EJWRonk7YglzfxZeiILwQv8Q8ZwyO9koqNaeomh
 weoG4daqelOXOOMxIXtPp4TP9Zl9xywvVrwTuXYrosZkX7AZAal/9JDv8x/dhHVmULm2
 lNe3yIhd8ie4BsYpkefE95aIPoiouhPF1/qJ7GoOOiaEv5zpPX5IAjbsbXCR+2tn2cDb
 GJLB9LEFxr/GhwVN4JOvn4TMefw9KiLNbrEnW2F8pbm/taPB9TyDflPPGxufun7+IpRx
 BNpPgWRedic5KtQ0vAENSW6nxb/LoJfgSDng8piX376iYabD+78PzyeEBrfub5dq5bSX
 kwBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXimhG4aMDzw84Hy1N19CqleoFM5sjskSk2dnKnFlJudzmQ+tqzoHBjy8qosSjy3CunOABzLKwvfDnr@nongnu.org
X-Gm-Message-State: AOJu0YzejbyIuM7OjnF2CbuqS1ZHC7Q6silPyzejhUXa092pLaIBa9s3
 QKR8DSHXtdAiVqeaXzZPkW2MwW7Hedvz3aNJ8ZcJU80S+pSB88OphB+joi9Yhus=
X-Google-Smtp-Source: AGHT+IEg/yNlhGdl3Nqifq79Urstz/ts7vVS7+hDcSN5dg+fPxiS+vo6Sj4m7M+segMaAYaZlUhNmg==
X-Received: by 2002:a05:6402:5386:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5c3dc7c4c45mr7425065a12.31.1725904486495; 
 Mon, 09 Sep 2024 10:54:46 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41ce2sm3264371a12.19.2024.09.09.10.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:54:46 -0700 (PDT)
Message-ID: <15e5c7e1-6bcd-455e-b977-ee374ff802ef@linaro.org>
Date: Mon, 9 Sep 2024 19:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 44/53] hw/timer: Remove omap_gptimer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-45-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-45-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The omap_gptimer device is only in the OMAP2 SoC, which we
> are removing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h   |   8 -
>   hw/timer/omap_gptimer.c | 512 ----------------------------------------
>   hw/timer/meson.build    |   1 -
>   3 files changed, 521 deletions(-)
>   delete mode 100644 hw/timer/omap_gptimer.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

