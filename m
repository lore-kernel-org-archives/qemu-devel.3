Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185B6D3B7C1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 08:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFr6W-0001w2-QL; Tue, 26 Nov 2024 03:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFr6V-0001vq-RK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:39:27 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFr6U-00011j-82
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:39:27 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38246333e12so5320019f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 00:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732610364; x=1733215164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9rhTDNDlcmoEuMSSYLzJyCSZMnNBLZIp/7iQL6IIYlo=;
 b=vUkzVmMGZu+TdW4dagrvjPQdUzIQ3gXAocA+B7fWwhEuX4AnkRga4CH0OIvLpFvpqd
 1yi8bcsgc7lI7tRgnmEj4Y0qG5aPaOfcQTVCoDbQhIxdVWBw44LxadSCe6A3iq9yfxmR
 enwVQrgzLf6cijCKNpC/xYYt3yv1/Ns2b7TlpAZ0E04LR24as1KHqcAbpagSyfYh1yr2
 PwINsoi7FKgUWRaA2YivE1rVcHZL62veNXp/VI26V8eqvJN6/2sjpPonTEcbYr4yAKJI
 BhDWSFsyrUNgqIaT8IYroHkPDoAh3oFeMDdWprzVDn7hUMomXwLQrcxFJqlaPJ8f8W6e
 T6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732610364; x=1733215164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rhTDNDlcmoEuMSSYLzJyCSZMnNBLZIp/7iQL6IIYlo=;
 b=wU3n6etgftOt/djYb5zuMZRNhzhrKzEBi8BZY8s81YTf1qwsPRdyVW2ZnSQRuO5LlF
 S+8nh3J2McKz8nzTcprrZqWih/jFdWJqBgjZC38YQ1ANx5qK65vUxZSMFeeIk4X1v+HS
 9ZitfvKVTE2WNaCXdjrVhZya1OXgVGLctjNjDNvjbIIOEbhblZoMaP4Yir4qIvMC1Wgf
 t7YjCloTAljkIUSp2up8NlfiWUn69KlcTSZ/aBqWBq27cRSwLw1fwTP7+zb6p7sVhJgV
 fGe86uyBUU8OfaoR/fJ7K5woPT/rQYNo7qQcZfqXY6n7wH1Mkq4VZyHQ2Rq083K8znNF
 EfWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURLEqj92hFuyvbvOoNJ0Hw/nd3ke96TcmK0BiYv2LZmSJQKwjVOJn7KG63nz3A6MBq3anPIwWpRRKQ@nongnu.org
X-Gm-Message-State: AOJu0Yytz3K51aDoBndxERMKu7iM0ud/nhkxS/QzELPfiHTPbHXYvT4+
 IbWvkmRSGkh6wbkZrqVqe78cexmHOnqnKSPJD6H6AIO8K1PHL8k9iUsxG5fEYmk=
X-Gm-Gg: ASbGncvvy5bEyOU0CZS91pUzDWKtEJJxscAxrK5XsHIVq/HR+oaCJYiPLIWhrncWZG4
 nxbXpwuIyaLSMXYjx3deZ8mV+59spUV844fHm8CENBESdhRM7PCXuBKnlViv7v7nBQ6eUUeFn3u
 P32b1ojmrrgh1roFw0gJQqry5ocRCoUX8inaAB1bUI2fG9/t9j36TlIlV9n5ADkt2voQ2223ME6
 rYCXjYzUQZI8fXBQMBMbyOz0pbX/G5k6IIuhvzsfHMRf9lcWGi7l7uaO7VEIFxerA==
X-Google-Smtp-Source: AGHT+IEkUQB75KlqgDVq2a9nJp9OOIrDYxWUGVT3ddb13FOci1VO8b+RyFkbYvoqztUmxqqMnWSaHw==
X-Received: by 2002:a05:6000:400b:b0:382:5112:5631 with SMTP id
 ffacd0b85a97d-38260b60ff1mr15321177f8f.23.1732610363606; 
 Tue, 26 Nov 2024 00:39:23 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb2609csm12809351f8f.44.2024.11.26.00.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 00:39:22 -0800 (PST)
Message-ID: <39d99130-0d3f-4254-86dd-20151e57ec68@linaro.org>
Date: Tue, 26 Nov 2024 09:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer: fix int underflow
To: Dmitry Frolov <frolov@swemel.ru>, peter.maydell@linaro.org
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20241106104041.624806-2-frolov@swemel.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241106104041.624806-2-frolov@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi Dmitry,

On 6/11/24 11:40, Dmitry Frolov wrote:
> Both timeout and return value of imx_gpt_update_count() are unsigned.
> Thus "limit" can not be negative, but obviously it was implied.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>   hw/timer/imx_gpt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
> index 23b3d79bdb..06e4837fed 100644
> --- a/hw/timer/imx_gpt.c
> +++ b/hw/timer/imx_gpt.c
> @@ -238,7 +238,7 @@ static void imx_gpt_compute_next_timeout(IMXGPTState *s, bool event)
>       }
>   
>       /* the new range to count down from */
> -    limit = timeout - imx_gpt_update_count(s);
> +    limit = (long long)timeout - imx_gpt_update_count(s);

You posted similar automatic change in at least 3 different
code areas. Each time different maintainers made similar
comments. At this point you should be able to auto-review
this patch and respin a proper follow up IMHO. Reviewers and
maintainers time is scarce.

Regards,

Phil.

