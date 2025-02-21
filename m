Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0066C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTR4-0002yy-64; Fri, 21 Feb 2025 08:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTR0-0002wB-2t
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:51:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTQy-0007FZ-G7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:51:17 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso9934335e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740145875; x=1740750675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ohPEaQmyGxdUjOAa3dXKalnzr8Ctl4h9bCCV5owieS0=;
 b=jhyYnZxa5hv785oMgUtF1WtIvpXRmjmAQ6lRNyH3VSJEiJzgkKuZGSjCJLeG8e0Xjq
 hUZVMBLkmJpOLAs/10YCOeZ5wALnGvzSBzyTnEvygIut3Gx8GCA8YSG4pmeTxWZkEqbt
 SgByopl5TzL8SlD2fcpkLOK2+ibiW9Zsh9GTTKxGZjBSu+znB049FUDzLN6Q2/6DqMe2
 6gIHqZp+Vw22E5dwt1qUXFKjhyOh/+xdoYxPmXaqXjYsq3d9wQwR97fGhabOb5qlupDd
 VQztJiQyJPQ4FdjS5gV2j/nRqmaa94n/c/1ajg9PM2/dV9gpkPRlosnd75gkisxPyki9
 Nvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740145875; x=1740750675;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohPEaQmyGxdUjOAa3dXKalnzr8Ctl4h9bCCV5owieS0=;
 b=ZEE9GFa4OGlpK6ZFytpQfwaLuvxALjO8Wass9gyOh3uremM3arz/itDgC/5zkyYP8V
 y/yaLNaTajdl0xXeZcHaTXASYez4VYoDKHoBvCcwoNVhdsHv6Ca4cU1pBX3FukO3qPnB
 z9kUU9FaYIooaPUVJxN0vFEv4lQ+FzxDIuwirCUwNyVRgjie/dAa2mNlVnF9ySXcTm+n
 cnWo+INeez6TAy26rWvArBZU+2e0sSQJrR++ddBY/7EfdFb8ItU2hHwXKpz1DLNcvZW1
 evQFcd5SOw+JomXQltRodOtw7ZII6KabfqG+xhk02/eyEDNNq8vUSixrKqwqUNn3P99H
 V5CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk/sr6Kz6cQFshkTnNpCiN4EFMG7Pd9T/xGLD0K24WX0fvgRlR7Jjcfr122azfsXK45VS0pm4vqkDL@nongnu.org
X-Gm-Message-State: AOJu0Ywo7WYzGndlrTzLG+L9b/b9G4evqjSkQE76AjqdfsceDof4EORE
 +VrmXHJwmSmmOWRPSq6WQugnkNN7QQ+pAvILjR+TCb6+Zy4j75t/ikJw+ESR6mc=
X-Gm-Gg: ASbGnctvYamQZJj8CI7uv7rWETPj2zSwSBas6hpgANw4o6jecxnAdUX06dEGZEXRzJj
 3fYdJFV7yTXjZAj2jUairJ/40Us5fjqLSQWpgEO0hCl10WZKYUlzifxCvr/WJqydXykPhP9ryS0
 4HvR7DsJtE6dFeyh8XGde8DO6xgCa2NhB4FCrR6umhvRD0ZDsI4v5VD8e4gzTELWgktRpryw1fU
 TxnxyvN1RIHQEkP+5Ac47luMBauhWqPqnaWLcipTNt2Uua4rjDT7pCqMC6oBH9Es3hifg5PaLb9
 lF1XwGBorzSuJu8TlYB7pHia0wezd23CmkMC/lqgY5D1HXeVAu7B8FqJDIQP2INBoK5Gnw==
X-Google-Smtp-Source: AGHT+IH+A+R57Bx3MBQ9JXpstExHEV9EypCuZM0MJQyEDRmMns3DEwU5q/9K0a/6RMS3eWx1xHDkwQ==
X-Received: by 2002:a05:600c:4ece:b0:439:9274:8203 with SMTP id
 5b1f17b1804b1-439aeae0543mr25219415e9.6.1740145874749; 
 Fri, 21 Feb 2025 05:51:14 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030be6fsm18037815e9.31.2025.02.21.05.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:51:14 -0800 (PST)
Message-ID: <ee050bea-96aa-4054-84d2-ee4041d10271@linaro.org>
Date: Fri, 21 Feb 2025 14:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/m68k: Avoid using floatx80_infinity global
 const
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> The global const floatx80_infinity is (unlike all the other
> float*_infinity values) target-specific, because whether the explicit
> Integer bit is set or not varies between m68k and i386.  We want to
> be able to compile softfloat once for multiple targets, so we can't
> continue to use a single global whose value needs to be different
> between targets.
> 
> Replace the direct uses of floatx80_infinity in target/m68k with
> calls to the new floatx80_default_inf() function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/softfloat.c | 47 ++++++++++++++---------------------------
>   1 file changed, 16 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


