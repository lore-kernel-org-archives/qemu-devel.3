Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E2E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkRe-00058u-Aq; Mon, 09 Dec 2024 15:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkRX-00058S-7w
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:33:23 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkRV-0002jb-Bt
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:33:22 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso4045057f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733776395; x=1734381195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1B+Q01vnqUNG/lFizEfCBkoXRASoo575C36wvCtcJvk=;
 b=dZFm/hxuOQnBZhsX+lavt7YOMptSdUMlZvgquaPtSvxEuvlA+tawTPozeW5mImuBsE
 zmpV09kbdTbb+j68Bb0U2KIAPSkTZHrJ3UVgveWKIOb+b6d11ogjFN5MkVPoDtsldUpb
 rdPu0fWP/4I49TbD3nLsAGpZOQY49tbb9UzN6IoTXPyoyBsAU/Xfgc2duozUwPVyedHN
 LiJ/mrkbqe2L6sSsSkYdL2Zlfh7uLhq0/myYv4FM0i90/ZksVt5eqXtFgC5wM3QLYekf
 YxrERTjoawOomKgWvuYaqvquvr79DgqaWR41gUHJyk8rvfN0s63H59ojDzMzGXOI7KOk
 9cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776395; x=1734381195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1B+Q01vnqUNG/lFizEfCBkoXRASoo575C36wvCtcJvk=;
 b=giwHZWTgdVNNFwzfEfD2kG4FBk4w3dChL9cny7P9ze4dRD0qXgk3CCAwmc6iRr5mUb
 Sg401IvqFuEp2z4A2ytM5il8ZH1CYnKrWniNyMpgX1baxNUa7n6sRJs3dtG4L5ISYSb6
 IeAH0xKhZRoqYRCBm+BvgfpK58WPxz9MCwAU/Q0871dAriGyvG6tEv6s8b/7rI0FJgem
 baJwDDPzXDDsWdgJo3IU7E//Y5ltV4U/3b/cTxY0ag03rvurNTWuYpHjqcEc3inCE5X5
 qr+WQkPEKgaBwobGK+teiamudO2CSgtoUiJjQYA9DnMjhwGZuR7RyNMbrgPI4KGSE6US
 eJLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqvmnJulD1Qz9EQlBpOlyz2FAXDHJuL9kn2fh1/QvsBoO++AO/X44QkvJMl0RLTp+oZON60I6fog8m@nongnu.org
X-Gm-Message-State: AOJu0YyqP7n5D5VhSK4LMgYbNiyMBN3d2yCEjhGAJKjv6ugCstcF62fA
 gmjUx/NEevhxY5/jnwxgU73a5WiJkog+g+lyo+iUDMK1K7ejBJwmR4JSYQtYFvU=
X-Gm-Gg: ASbGncthSM5yWOIZYdVQu/s/Ap3xZE2QoB12VHMYdX56Xj+3Yy/muvNaKwRM8OrmgLu
 td9gQVFcUkYzyTCjxb040JaFsGLBvbhbWMbMt5hN+yezYH7VOZDIz91kSPf80XFdDol+IUoOvhu
 ySGEREeNtvyXZxqemfKPsMYmdNos8372NEwwQHkzxC1/VHtOtIS5gubGpbJA6UyGzig9scEr6s7
 xTSnpaCEA3rdV903g4TDcT6jJf1U/B+YylEV22hSz6JFbNf661lmzvw15CBrwbSWUA7RvsJM4kH
 3z3fAb5wIs1g9eTRcM084NLG+50XqfG3
X-Google-Smtp-Source: AGHT+IEGOceIo9r7UF2jg8q056dksDFbSv5uazkKhJXcUs3Hk2d4aNGF8tvzNzXu/tVK8yO4ndD7/g==
X-Received: by 2002:a5d:64c7:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-386453f96e6mr1925504f8f.44.1733776395234; 
 Mon, 09 Dec 2024 12:33:15 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf416fsm13864439f8f.16.2024.12.09.12.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 12:33:14 -0800 (PST)
Message-ID: <73cdfb51-aef9-4731-914a-7687f988997e@linaro.org>
Date: Mon, 9 Dec 2024 21:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241128201510.869974-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 28/11/24 21:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/devel/style.rst | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b500798..2d73e6a8f7a 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -416,6 +416,26 @@ definitions instead of typedefs in headers and function prototypes; this
>   avoids problems with duplicated typedefs and reduces the need to include
>   headers from other headers.
>   
> +Bitfields
> +---------
> +
> +C bitfields can be a cause of non-portability issues, especially under windows
> +where `MSVC has a different way to lay them out than gcc

"GCC" (as MSVC).

> +<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_, and on big and

"and on" sounds odd to me. Maybe ", or where endianness matters."?

> +little endian hosts.
> +
> +For this reason, we disallow usage of bitfields in packed structures and in any
> +structures which are supposed to exactly match a specific layout in guest
> +memory. Some existing code may use it, and we carefully ensured the layout was
> +the one expected.
> +
> +We also suggest avoiding bitfields even in structures where the exact
> +layout does not matter, unless you can show that they provide a significant
> +memory usage or usability benefit.

I don't think we should mention "significant memory usage benefit".

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
> +for bitfields.
> +
>   Reserved namespaces in C and POSIX
>   ----------------------------------
>   


