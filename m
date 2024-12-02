Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F86BE69E86
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC91-0003Uk-Vm; Mon, 02 Dec 2024 14:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIC8z-0003TB-2D
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:31:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIC8x-00031L-Ex
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:31:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434a8640763so39725835e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733167897; x=1733772697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dJKDN6jr8ySadvZWVKnSe65KLieSaHaKpkpZnZuooYA=;
 b=HgpX1y9p1pxyooKQQLmeE5barmtU3jKZ74qY1ClqweqYk/sEr3vnO++s0JkL0XeYWH
 Gum6mIodv+pbefS8JMLIaQE6IPOpSSD4pfeoBCyyf7j2XJFtpRP9qiGU1OTYUVSVDV4x
 xJbTAgOJBJk3XSQGRtyQ8c7WpRC6eLLbajI7lsKWK1gYBrmi6ecjT95WmYwyTVPGggkk
 puuL8LZv4FR9QMAg4C2GQYvagPwIFy5DoNpDAAmSAvHfFvezd9GpQ+euRcw0cL1s5mCh
 FCvggSkJERD/dzNLBH9XXzXX1pTYED6k/ZYIBpqYo0kSLI+vZZH5HFDPZ2hnOJ5xnY6z
 DVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733167897; x=1733772697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dJKDN6jr8ySadvZWVKnSe65KLieSaHaKpkpZnZuooYA=;
 b=SaiH1wMXmEJyOUWJEr/Z9bpcoGDqDqVM0qxe2yBq7ge51s+d37qgrNeX9xPGLG6zeI
 fQxHxzvbRuYDPRfkTO/l+cWvb05wvpaVa7QplBv+8bu65m83aApsZ60JuSGGZ863nb/5
 45sV2FGlcuBa9KGl1Tg/PZ6il8YOXWZepQRM1fdNweLbtsRUaKEkvgyGgfEbYZcjQSWZ
 J2viND5CQQZlwaMJ46HE3aHXwWgf2H2aZq953hKLnLpkTOLnN9eXtzglxd29pTWe+6l8
 sw/ZKVCmfB3wE9OhZQfeFyozWIhbQbXbDvLqT0Lr3HJp5VRFCpupjpFYEWqFBvM5yfan
 IE0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVab9pbbo/EV1mNI8il+K8Rz2v3goXI9A3lhHZgDf8TWYW8NbC5pD3X2ITwkgzU5oOzJUXZme+KI5Xt@nongnu.org
X-Gm-Message-State: AOJu0YzalFCLZakeI7JSlpT/53QSfKhLDgPWPGhgqlhgLTlkDO3qNu5n
 e6/r24NP91W4qk/O291oDNzmVcV7jrfJcCHaN1S8zq4MM63eum7/oSUiTWmPJiw=
X-Gm-Gg: ASbGncu3KVNX9wwldAqyaJ+AcmW9Jfd2Ly3HuCJSJkgdPIc3A8zXsRD61cNPyi1b2E3
 8fkUPz2vx4lGywEVmbG/95ol2BwKpYZIW/bC3Euw6uhpQHsIreEVX5Dsc112SeAS8i+Yceq2mDs
 Xxl1Zg5s6Xa4eboboF2DAVErNueDaADob2fI4wC5Nr8bBa/N2XIbsP6RM2vEdicFYw8PertwwQI
 nNt78NKAgbGyLTO2aBmeNj4Szhj0KNMPJ42nY7wkrrQrmo3g8XpMiZul6/VD9zgGQlVJUDcMdQa
 tiQcutz+3Xk9sTGVcI/i
X-Google-Smtp-Source: AGHT+IG0MBE/7FtDMwupi9wQZflgLzNTQTzjH3Neb5SnbjpBUV3yh5sMYF+I8Nnyy1iyY+5HxxQB+g==
X-Received: by 2002:a05:600c:5102:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-434a9de3947mr203187505e9.22.1733167897561; 
 Mon, 02 Dec 2024 11:31:37 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa76b52bsm194768095e9.18.2024.12.02.11.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 11:31:37 -0800 (PST)
Message-ID: <faa05fd2-f343-4bf7-8403-5aeadd87fc79@linaro.org>
Date: Mon, 2 Dec 2024 20:31:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/67] target/arm: Convert LSLV, LSRV, ASRV, RORV to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-4-richard.henderson@linaro.org>
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

On 1/12/24 16:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 46 ++++++++++++++++------------------
>   target/arm/tcg/a64.decode      |  4 +++
>   2 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


