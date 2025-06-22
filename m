Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD639C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTB0q-0006K7-TP; Sat, 21 Jun 2025 23:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB0o-0006IE-22
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:04:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB0m-0002BK-Em
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:04:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2363e973db1so21582725ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750561491; x=1751166291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lbBwVy0X8ZQNf/N9zWeMVdpiIztp101qF/K+CE1w8iM=;
 b=ZZnVA4zis3PrIO3jRiERwYF+yxHsem3PCCE4yCWZ3M10ZXFrKUH1Nifiad65nwNEfy
 sjjlKgRPPyp/Kud7BpfaZBkkKZ/epEMJy8DU0qLHmxdBhIRzVEF0OyyT98+OIuZPsYCY
 0Vei7DPI8IMC6e8soLfry6gvtP0Et77Hpc3rxM8fX5l06hOquKWx1mMmw6BWAGbEqBd2
 6AdfdKsm8LF6aJby2f2M+HpO6xqf+2R2VzS5FpglfU/0ywvVQkbNnSN/Qqj/3uHv+BYp
 Z8jb1T0AoxBHCOutZwqmuccgS6c6R04NjWujfFMjsd5dFFdnINp43B5iC9eYDGWVMiNt
 DQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750561491; x=1751166291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lbBwVy0X8ZQNf/N9zWeMVdpiIztp101qF/K+CE1w8iM=;
 b=cg35DIQkw683frAiBGPLI8lTxI/B9oJ371XDdXIsw+dNImHwctSz8CxvsVt/8cwmlm
 xP9gz2gqc6Boe8dRaxQEvXb4gR8ou/nPrJCpdFskGA6r7ZRhOhliWIqCdhEsIJADBNqA
 jNRRiczqXAMXeEhxckatTJ3zmWkqVrCf4/KRTTGphN9uaQEvhdRmKdwQQS7H05uszihR
 awtOZs6/Hfqy2n5aDze20DDyThkx7+YBwYV8Gb0MCNGJNh76evtMNFN7l4o39x4jouuo
 JElSZ7VeJ9c2COXHp4iuzKeVH3dMKDcHgalkpWkzDC64kpqy6hMEGKlhltzjUREIjnb5
 9i1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu6vU2ZYnaoQoR3Gr6Yy6ENCa+GWnKfofkmZBKVcbBuDejWwgLs57KfJjJo9cIROl6ML0W0viI/aof@nongnu.org
X-Gm-Message-State: AOJu0Yzq5Ypjmznycq9BePSTHMPi73Re34f+RlB2YFlJKfU9EPblnikS
 O/pgL/hxy6jB9fJjqLuZ3tPURpe+qir9c70ajmvKd3ig4jiTI/HDB6jblvgYpv0oUp/vC7waucC
 wWp2cQ6g=
X-Gm-Gg: ASbGnctMwTzo7sdy3Y4x6Ejae49GMCdz5npQVwxhBHqUra4epX7TWd56tSK0ugTrY7x
 eFwmFX5jJGSQssdaBI13qINoUG8Gscx7pPXrXE7tIH5Q1/rnLE+Fp/iSb9Sagel0vuBoI1Jkyjx
 6Uy+S7Gd7//NZ05mY8PGYSZKeFsQtA06n9kJWqYbNE2pfhJ7Dn5lfgifyQ5qxgp9bfO7ONgqtWD
 8cx/639tY3gEx5oVNJMNWJU8GKDJk0KFLI0t4wZRFBDYgBA4vkTgNLCbdgPGQrqomoEuE7CEsf0
 qgUcySCBQA68EN4GKtUY5li6feFB+Ki0VE6GMOelzffH2YyvMy09CnyctyDx3TlAxX3gtIM/zfE
 +mvkUedpxRDVL29kN9Be76DHsK6gR
X-Google-Smtp-Source: AGHT+IGsaOSgMwADu2jlIGk+njyVyfZ14Uc49TdHF+ga6gySOyeVb7MPH0xnw2a5cOOaT3TUcIn4Lw==
X-Received: by 2002:a17:903:285:b0:234:9fe1:8fc6 with SMTP id
 d9443c01a7336-237db0938a7mr113747665ad.18.1750561491002; 
 Sat, 21 Jun 2025 20:04:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8398dcbsm50946605ad.48.2025.06.21.20.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:04:50 -0700 (PDT)
Message-ID: <acd1d192-f016-48d3-90e1-39d70eac46f5@linaro.org>
Date: Sat, 21 Jun 2025 20:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 24/42] accel/split: Implement handle_interrupt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 399bf71a9ec..5a36e22f205 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -249,7 +249,15 @@ static void split_synchronize_pre_resume(bool step_pending)
>   
>   static void split_handle_interrupt(CPUState *cpu, int mask)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *ac = cpu->accel->use_hw ? ACCEL_GET_CLASS(sas->hw)
> +                                        : ACCEL_GET_CLASS(sas->sw);
> +
> +    if (ac->ops->handle_interrupt) {
> +        ac->ops->handle_interrupt(cpu, mask);
> +    } else {
> +        generic_handle_interrupt(cpu, mask);
> +    }

Better to have handle_interrupt always filled-in.

r~

