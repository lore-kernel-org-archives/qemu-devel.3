Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FCFCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzRu-0005bi-Hx; Mon, 20 Oct 2025 19:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzRq-0005bA-H1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:37:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzRo-0001Cx-7G
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:37:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-782a77b5ec7so4516318b3a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761003470; x=1761608270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WpOxjUN0/rqCz47thJc+cdXxRrygG2VYhPCd4EwMj0A=;
 b=NN3MlDl9e1SPvAGqxdzU+7gOTvIAIm7z3hd1erioTkDT/IKl6Rd+W9Utv9L+Z7zQGP
 dD8tnK6fJ7P6JFALmFMWRC78BDnepb0PwER9So1jshIiQEmnIw/3thFqgbtIiWgSUm8H
 wryp1mjq/yzFtLduqMrDy3qQps79fe80wgRcx6OTxMpH8+WkdDWXyU4eka2GQFSA80dG
 13SbRkoTFyPwPzLb2JKIji96gfhXJwXmhyAxtqV06xmygR8Kyjr1pGHH293AqgjiH+xx
 91cfCvmfKrr1UAHc0/hGfpyQCqBmCJn6FlzCrXarq/u0IFLClkokISANHapqVgChSzrO
 R6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003470; x=1761608270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WpOxjUN0/rqCz47thJc+cdXxRrygG2VYhPCd4EwMj0A=;
 b=CJ1Fvb0J1tzRZIEoln1extgjlf9mwtPjwGDFJai+sKEHc1qtD/BvV1dLzSXu6CBULx
 F9UhIzqAwP47PAm0RlCMr0JpTIu96D0bczNmL6mK+HXX1CiWyQC5X6gPbIy4Asq8ZqDs
 Q0w1Gn9mIH7ntqwslrBqPhywuNYTXdkBRJ4/qqXdczdo2D1qhygP1HJ9wYjfLex8BoYY
 hy6lHyTJiNljm05hVT6LdVZ7lPabt8fhub92KzREoIAyF51x2jGtUzTrsdoBWs2eqTRW
 AWZ2W15+kZGyx0MiVGbht4qWuVg765Xrll84fQ73aKxhYgz3NfqpZAYYour55f3SdBJN
 7dMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh15uhOzr4xtwmtTTkAKtEWLcDIOY6fG8f93/3573fs+qM0FS99IyRqLSGByCQXH8XW71dcYyEN7C6@nongnu.org
X-Gm-Message-State: AOJu0YyH/niA4oLndotOSGcmjpvnDSyJvlM5SvgEV8DhyVUG6zYvvtgL
 ET7sBcaRJLI8xkZ6lPnZprqTx0vhIIHyzUGQPFNC8yGw/r4+mm22IJsIlwFgqQk8560=
X-Gm-Gg: ASbGncvSiQo/QdalBnrmHyySsBL7e3fGcXZqjf5CnXTmM2C/xSwe6MQB4LtLCSAbsfq
 Y7XIPIvXoBjNmg7RxNQiQfxc7tiB3Yu4MyJ2BIp6x8UfpAMg+BEvhUGZakSBNw0lbE/q4VMRgSE
 OdubGH18BTI/QJwiB9X26mlvrCgqgHPxKMVx+vUCl1FaUpIQa/SC4ID5ix4QqUFVDRr0e+C6mWw
 XURCf8I3z5+7bsyWFDIqdHOX4hslwdMWll9dpBPS9isO4NY9FlkB0u6EkJ62aTE8Pg0OuvSQu6u
 eI3xcvvd14Zh2X+psi/vgc/CgfToHf/P8RSmtcerO4nGbi+liDxD6sA3D1dOtwBojckyZRkukw/
 8VJEGl9RoovfQOGMdSQuebe5Y1D4yr1jcPxrdzKK8/5AP8HOGVsxtJ8VZjp312ORrJuCQqmaHIs
 C/b4q1tvToE4mb4psmcj0X2s4d
X-Google-Smtp-Source: AGHT+IF8DCMNzlPJcu5OkMQ6wrfEJzq0MrSWDDecrqVwTdhTHqbAjePeR1ac/WlA0iIj6ZWlcTwm6Q==
X-Received: by 2002:a05:6a00:3ccd:b0:781:17fb:d3d0 with SMTP id
 d2e1a72fcca58-7a2208f01dcmr17091156b3a.8.1761003470205; 
 Mon, 20 Oct 2025 16:37:50 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f3c8asm9487591b3a.41.2025.10.20.16.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:37:49 -0700 (PDT)
Message-ID: <741de7e0-de12-45fc-8306-0110e2d0aee6@linaro.org>
Date: Mon, 20 Oct 2025 16:37:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/30] hw/arm/virt: Get default CPU type at runtime
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhang Chen <zhangckid@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020221508.67413-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020221508.67413-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 2025-10-20 15:15, Philippe Mathieu-Daudé wrote:
> Prefer MachineClass::get_default_cpu_type() over
> MachineClass::default_cpu_type to get CPU type,
> evaluating TCG availability at runtime calling
> tcg_enabled().
> 
> It's worth noting that this is a behavior change:
> 
> - Previously only
> 
>    ./configure --disable-tcg --enable-kvm
>    ./qemu-system-aarch64 -M virt -accel kvm
> 
>    would default to 'max' and
> 
>    ./configure --enable-tcg --enable-kvm
>    ./qemu-system-aarch64 -M virt -accel kvm
> 
>    would default to 'cortex-a15'.
> 
> - Afterward, -accel kvm will always default to 'max'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Zhang Chen <zhangckid@gmail.com>
> ---
>   hw/arm/virt.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


