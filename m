Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628EE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYoD-0001Rp-Cv; Wed, 08 Jan 2025 11:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVYo0-0001Nh-B5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:21:18 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVYnx-00056f-RD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:21:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361c705434so123226395e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736353271; x=1736958071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zSj9J8PaRrqj5CYg9Lfkjte9vnQLNuRpW9jbou5F1cE=;
 b=AUYLfPt468ggbHMdzllT8TGHQSICTv/4isbGULt269ALpVJJ9d6mmlHG+kc3QDXFpR
 AnLaA3wBMav179gw6FXZ51aIkXPoin+RQYE119AaB8w1hFeWkzZ5O5As395ZT3AKx092
 0JnuXbAHvrya+FQcESqgV6PAcePrwMCd7BpqnYItczCkDFypZmuk4jVom1XU7hUKNYqA
 On8N03LGMAioO4KhqSMadaSZHnwms9+oe96Sy97fyzL3vPxEOkYBc92Fzcf9zi0cLzIh
 uXFz9PhBZacOo9+T+/p9O1h8ShC15RWX1kXkwamH0wJpFgHoi1ti4b2Sj/3NYF9mj+Zt
 1QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736353271; x=1736958071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zSj9J8PaRrqj5CYg9Lfkjte9vnQLNuRpW9jbou5F1cE=;
 b=nGfUg14eJFJF4PsTAHlAgix6/Rp+OpCF+JyIvKTZ0k2tKNu0s7M6hHs2MSAl23+gQ5
 KZH3cleOJx3Kn0KgfH4YbsN0sDUTJ6Z9uYDWjs0gYKiI70RrvHP2bi0Ij5Z/AqDnUpME
 rcpvRKiGLkLy38QC1VywO4lppFxPVyZIlvad0J26y/7GB+ekN3ZtqplnAR9hEkgyDftR
 vYiGW/S3uGrz1qlz2FW+YdBLRTg0S1G9lfirxEI/50AVBIVbaT/nnII3p49szRNJAspA
 h2fPJj/q5v/Lw+bpsdLv5Qp2ER0e1PuJEN+tKMBlxFLEW6XAehcDm+w+fDw9Dh9L8erZ
 kvSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlwRp6QhnKElsNsOZaqXLbyGkQCUOhA1xoaPNafS4ucVbblOAMnINf+/wczZqC9LDz68zeBgfRY8u5@nongnu.org
X-Gm-Message-State: AOJu0Yx20NBQ2oIZNtrKSBdigbySunSvcegLaYUfls5FUExeE+pOHZe5
 q+kkm/ILMzKIZihwKzPTvl76oMZOmbjpkIumrIwWzfRVzQIIjGbCnAVY+LH3HKc=
X-Gm-Gg: ASbGncuhFnD9T97FcB3W2fKB77dq3J4h3/NRIAH0WEPZnRdQcB7p1HkH4e/ymRYmrDV
 18kjL9E42L/2e7WLVk/QsujTw1OqYWPTwj21PFhvOtS4ruz8gV7sskG4Wgf3gucCNr+fb+tG2jT
 R4hszPpq+YsvKqmT1T9g2OmXE6tJFMxt/GhFDwYT0kkjXTMrQwCGgS9zbZYkJqd7LMonXpXYpbr
 B5Nc9MrYZ5g8OqgZyQUjEkbiAksA2lBVaybXDpnVnFG7liFu6A8dlDXlwJ19O0/Dak7EaDQwGP5
 RCqSPbzaLWcNjIr0aSQHvNWZ
X-Google-Smtp-Source: AGHT+IEb7S9UM994wU07Bmp3Fg+29hW0UsMEfztVStoxr6lbA7H2z55KXy5KzxpEZTVc3JjvhCDYwg==
X-Received: by 2002:a05:600c:3143:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-436e26b9d45mr27502465e9.18.1736353271340; 
 Wed, 08 Jan 2025 08:21:11 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84840asm53174908f8f.61.2025.01.08.08.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 08:21:10 -0800 (PST)
Message-ID: <33849af9-4edf-4acd-9611-0de6f88e82aa@linaro.org>
Date: Wed, 8 Jan 2025 17:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] hw/timer/imx_gpt: Remove unused define
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-11-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-11-shentey@gmail.com>
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

On 8/1/25 10:25, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/timer/imx_gpt.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


