Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79FEEF48C5
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 11:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrE6e-0005q8-Fj; Sat, 14 Feb 2026 06:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrE6T-0005hi-4O
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 06:46:28 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrE6R-0003ql-Cm
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 06:46:24 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43626796202so1512452f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 03:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771069581; x=1771674381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K58w8STfLmO0fANjixOgmRI07dP7UvVCNU4cvc/V/1o=;
 b=RwV3oV52sAMprcdqd+h7HEwEDgCfmuWJm+74QM9Eea9X/eYtvZd++wRE3OLQLOdZfu
 FDgGHy95f4YtWWHao4IORtbN5ZndoVHqq8GCFOOjdSzVr4M3AcNhJ+kWZDop4a+FV1zo
 e0a2gCTh2g1Pdq31rCO1MDoaMjtfQCx8SULgAL0+fiORd+d37doO/XOV/h2jYCU5mqZf
 mJy0kQIpBS3lCyibocw10ydor7ZViMP22XmVSgXj6GtLBFgLDe7i9naBNcqWOBNzggeN
 zTMVNhAIVPffzWi8SN/TKeVyYCh+O6hjJr0CD5v1m0VcUlP5A3hZ6lG1L+NWbdaqb8gt
 TCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771069581; x=1771674381;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K58w8STfLmO0fANjixOgmRI07dP7UvVCNU4cvc/V/1o=;
 b=AHZdbrgsxJkXeH52z6fRNdQD9Mr/hGWlJHUoZlGSMu3AVvGjp9AVR3+gNdmISHKyDD
 r/2QnrmBBlD2BWymDWTNZEpDcwjzptgeD5xSg18VcPyLpSPwAl7n51aG6C8q3HDgX6Yv
 6NSJa3hGhcQ+RJ0GMqYifne+APb2UaOHaYbDj78V5dNLYekBMctloe4d36f+hdvE2yio
 qW8N2jlqN23lVfrh6AeLK2cKCwxZWoDcJC5uO8+p1weRFTr3JkimCBmGLr5CQDic79QZ
 phHQeZlzcBiPhz5GhyVGggg+/nJImJMDh0huBkd/lSwXCytREYy1xrXKOTVgNXCy3U7+
 WWgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI/nGHL4pBCWgruE/hKiHZZtFvioFYjtcjWm1v0530z7+slsDBprI0nXvDv9xwHLrJ4GOAtRkp8tCw@nongnu.org
X-Gm-Message-State: AOJu0YyZB83RXHe+6BbNr4tYdsW/guALYRxzVhvrFo1fsaJsaMzxHsv/
 7CzdXBSezcK0XxeDx/kOhTy4KAH0iBomQJQ6ToVBH5IUEDNz6d77B+o6Vq+EH5JraSw=
X-Gm-Gg: AZuq6aL9y9oYvv6C5g4YwHgn8NpVFI+IQRXf5ivmiFk5c3dQKD6jd9eV6EF5fS5F4rE
 aVpbVO/hJS1JLcocpAIG9WNaBKCWQK75UF1SS6JM/ssm4VKSl/H0LoCOjd/YCU+JzEs1mF3RDFY
 nWSiALDGPrE0mRpApjJ2w54a/DjgiHKNDmsvN6s1rlwCGoHiiDvfsKQwtdo+JLpy8Wu0ogQXksq
 r6HcdCykHcMMWd0CbNJnfolqVFhvYLScSuRXgXI0mOCuB9y+RXUdMYobuH3pxWRg56hdekibdqo
 v2VlrdrQQeTcuAsQH4E2/sKmaXsU3MWhhKsGw7P9Ams+AiitlyWc/0n+bR6dGVZNY3KFOSJ9bKu
 3Yap4eutixNmcIzRnedO0Svw479bl/V9ZqvjhHG/b3IGltc6JKqiaUlpzBZAnffvDazxgJsFlx4
 IJMlCrmt5SOSFayUaSgWd9Bau2BBm7W5PMb6Gf6mOVQ8Z2AeJcSf9rVIFvEg222heXng6lTnYje
 hmi
X-Received: by 2002:a05:600c:4f50:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-48373a662a4mr75487745e9.27.1771069581014; 
 Sat, 14 Feb 2026 03:46:21 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d46sm13642556f8f.32.2026.02.14.03.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 03:46:20 -0800 (PST)
Message-ID: <47a7d557-c864-4b43-a178-9adfa12bba9f@linaro.org>
Date: Sat, 14 Feb 2026 12:46:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/cpp: use __has_include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, jsnow@redhat.com
References: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 14/2/26 07:10, Pierrick Bouvier wrote:
> This make sure we can include all possible headers without breaking
> build for environments missing them. It fixes compilation on openbsd.
> 
> We don't want to pollute configure script, as it's really a special case
> here to make sure we don't have a compilation regression with
> qemu-plugins header.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/cpp.cpp | 261 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 259 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
> index 1ff54896d97..0673c4f074d 100644
> --- a/contrib/plugins/cpp.cpp
> +++ b/contrib/plugins/cpp.cpp
> @@ -6,103 +6,360 @@
>   
>   #include <qemu-plugin.h>
>   
> -/* https://en.cppreference.com/w/cpp/headers.html */
> +/*
> + * We include all C++ standard headers (without deprecated ones),
> + * taken from: https://en.cppreference.com/w/cpp/headers.html
> + *
> + * To update, copy page text, and then:
> + * grep '^<' |
> + * sort -u |
> + * grep -v strstream |
> + * grep -v codecvt |
> + * sed -e 's/\(.*\)/#if __has_include(\1)\n#include \1\n#endif/'
> + */
> +
> +#if __has_include(<algorithm>)
>   #include <algorithm>
> +#endif

Should we test __has_include is defined, as the GCC documentation
recommends?

   [...] the recommended use of the operators is as follows:

   #if defined __has_include
   #  if __has_include (<stdatomic.h>)
   #    include <stdatomic.h>
   #  endif
   #endif

https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005finclude.html

