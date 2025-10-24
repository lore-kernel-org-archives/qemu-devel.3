Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07CCCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBmd-0001fq-2l; Fri, 24 Oct 2025 03:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCBmZ-0001eD-8l
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:00:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCBmX-0007Ci-CE
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:00:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4710ff3ae81so5227115e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761289209; x=1761894009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J3oewQerbVdJbYGfiinD7DviXv6BGEOzK0GQV2zvJpY=;
 b=ySYtNgMriPtHDllRE6+/hyDUCEjYg/s34EGh5GbscX44hgoc2cAeyGYMNPfBtHQoCx
 QRO9zzA2B6PZZdNQOl0p5HANfMEVI5DuUrcJRyBsl8XBqZZils+bZdhxy6/uzBzPtIjd
 aUlXF4mVtKAqLTRQpP6lxLCtt9ysAMnoXZik1vFF5KtPExLYoY8cyFL2H2F2QqavBhoU
 Fkhj+hswcNBbc7MeghekO34/1Gbr6MOysNwp7wmQpI2UM4xgKrCwijbhyITAaYkomSl1
 42Bvwh0zxex/ufTCJtQmypyUEasiMzq+fdCG1wkKKGm1AhPLO1xbpDTSy0jsSM5fBP6Z
 zocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761289209; x=1761894009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J3oewQerbVdJbYGfiinD7DviXv6BGEOzK0GQV2zvJpY=;
 b=eSprtuAGrty0+vISlxlTpGvebCcGM/YRX3zLV42OzcS8o8sCIxfghUFqCOBda+tDpj
 y4722zpX+Af87fRf/6MQ8QZd39AlbOKBE5VSBATxPA88lCF067M3pKkVnrXIW8M+LeYn
 pUym4GyhpP7CDEnxFVHmmxkCUmOqGq5mdQjmfFxrfWkqsPx5ERtWPovongbm7qUxhyG6
 QRCd1oiT6De+AIimSWOsWx2UAe0Zqgi3GfXH9tWD45o7cYHcsa55j4evstCB/BrZDviy
 MoDIonBRBxQXgSzzico5/oEaQpE3Sa9D348hb4KNLIa9saHHJkWhsDJOuw0RGby8grkL
 jhJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW14EufI8DKeeTHvukgbOUAbU3b+fUHpAQgPmXqM+4ZFXZu/w+zYgzZOnjcui3zOrRRHnGn7FpLu1sq@nongnu.org
X-Gm-Message-State: AOJu0YwzMdA8cMejhOg0p4IgY+SI/zsXAPyWUTu4Z/6be6T3OXB+Q9ao
 nfPnoP22R3aN1wWlaLUfmcg9EzV1YaFDsTy5tAZsXnAdHl+mwT3l/tMgX+a44cyA440=
X-Gm-Gg: ASbGnctgzpHJI16NOb+0hfCdu4MWpxufWL8j1HsjqEm13VJHzUbtQGuvJZe3fosG/pB
 mikXXvCCu8PEz5TuQNKSBbFXokuUgQJWtfaoVO5yDWQT5Ini/1H1dY1t6s5z6tGwkSQOL9OvFQS
 KwiWVCOSQiI9I96rxlhOifJ6nQwUk0ZVsw6TyrDuak0wcXSu3tEc1wOsixPj6acgzbFfyMM6g6Q
 Xh7QreOz/JTv4BEleUCf9flCLj8EyLiXuTRr6oS/nk/HeJtoWnqz8I+KIUhRWjUXG7V4zkFK2h6
 Ut3oz9dIAD1lfWrPipqO8Scdj3XV0uouCy93fo1lQDqNyRPXUsJzuCODmHftv5fDPbcUnVTz6PA
 1ym1XR6FZW8NG/av8QUtZb1iglCMghR/8bPkrlnJPOPBUM0q3T0OYYv/itZS6B+8Nnthy5Q8yrD
 QRKwwtKjF7YbqzlccNVf0mlU2xNFDTzk7/VgnF+8Wp/4zSPHWQrYJ3fw==
X-Google-Smtp-Source: AGHT+IFIvIwc14w8iiS6qsz7+rVKEccSu+/tWVbFkJMU2E2cLsTUpfRNzznLtUAmwjmFlCGUJ8mT1A==
X-Received: by 2002:a05:600c:548c:b0:471:16e6:8e60 with SMTP id
 5b1f17b1804b1-471177c0948mr186341065e9.0.1761289209129; 
 Fri, 24 Oct 2025 00:00:09 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf15b10sm86798575e9.11.2025.10.24.00.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 00:00:08 -0700 (PDT)
Message-ID: <3d69a942-61da-4edb-9407-69a62aff9435@linaro.org>
Date: Fri, 24 Oct 2025 09:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] configs: drop SBSA_REF from minimal specification
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20251023163915.3199361-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023163915.3199361-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 23/10/25 18:39, Alex Bennée wrote:
> The whole point of SBSA_REF is for testing firmware which by
> definition requires TCG. This means the configuration of:
> 
>    --disable-tcg --with-devices-aarch64=minimal
> 
> makes no sense (and indeed is broken for the
> ubuntu-24.04-aarch64-notcg) test. Drop it from minimal and remove the
> allow_failure from the test case.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configs/devices/aarch64-softmmu/minimal.mak          | 1 -
>   .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 --
>   2 files changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


