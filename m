Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8A8E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMqk-0000lc-M4; Thu, 05 Dec 2024 20:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJMqj-0000lK-Ai
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:09:41 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJMqh-0001hb-Mz
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:09:41 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea53011deaso449423b6e.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 17:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733447378; x=1734052178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBrT9cmtqC6Wc6NAGn+TMnvK8ES96RzIQWBhZXWJ4v0=;
 b=ZJ9Wx+P+Nt5GbrsjEq5QEycrHRfI5OHO7q+Nk+B1zifJyNDnJvZc54IHy4izDY3LzV
 4Pm8dcNZVOvpkn4r9ysEv+1d5LCtZ1DHh7DoAn0CCqrj8WS/KYSjyXPb/+T/Rzlmn/NE
 QbDoARCQJTdKyO5nY91ZvYY8omz3aEcqw/trJquMFL1rOp45ufDQtlpSD1dm5pOKD5/R
 rZZPuaoDjKvP3OHkRgkI+o9BiOTPkD0EBqwjivnl6ATXiLu0rUucFarfV2yUxNIJMo1c
 uWPQR23iwUcV87OuEldf+NnrKY8+JavCsTR05ZeUFEdWRhZWAZCuhffqLCD1l8usqC6Y
 +jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733447378; x=1734052178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBrT9cmtqC6Wc6NAGn+TMnvK8ES96RzIQWBhZXWJ4v0=;
 b=cSf74Rd1aJHGsB76GtoiKqMWvWloTzH9UklBQTCmWZ1dFFeC2mOsWsYxewGGdtIs9Z
 7bcZtOufCOjSlZFTmioSNiRMqObzLzhGc0D0jgBoY+ELASrqAyf6bsx4dvKH+JUvTxRY
 cHYw7BF0n4UQ3S5g+PIXMn+CH6oqvbEB8HV2kr8Ig87RY23V8cKemNqO+6sIpLtLXKd7
 xxNZZ8cxRnSweGkznyPRX9jdBYgUnSLlZH6A+Z/IWwOxjIJC6xKBpGpLWm4eFrOltpyE
 GjV1IoS8buWiNJs15S2yOZnIAKGVkjeeJPxYZWDK2sfbGjB2hDM4MYh9fBNTnmPkAS29
 xMxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNF/bwWk0gHsSBRQu0dB8vnRzYxKonblMbcoZ7eD3E2LJXYXqurqftdivY5AlWHHJyguR77z98c4OR@nongnu.org
X-Gm-Message-State: AOJu0Ywccc4JcF4LmCj2BWAEr4OsylESyK4gjQZCi7fV9MRZLRnqEgld
 gjvVb6GglrBeblicTGcLoEOPHj4iUFNBqJ9dzwbf2qObguksblTp2A2XGLUOOGg=
X-Gm-Gg: ASbGncthuh+uZfukwU7tdCzJJjloKiMXn/FH1VOkg4eMw8XgE0AmP2juXEI2CI/BfDK
 r5xw+jiHPP3PSggO57L5g8lnuHZvZqxUzbzNKi8NvGvQe4SNgHKAB/Tjm5mKqYTRZIYhDnPLIlX
 yLtaYu78dQFIypR88eyZsZpZ+fzKbKSgNKK2XoOqWfGDplJKe50G44XdFcMezTUO54GNyJnUcsk
 0TAOQQYWccZzlPtnIi0u/dFNEAmeFJDsZjG+ACLPjZmkimnskFRb9YGA3LkpoTfjiyXEd1in+6u
 cgOg2pbv/f89OgH+Bx+kvj3Z4rZY
X-Google-Smtp-Source: AGHT+IEC24fbXckmrB7N6QS85meRThP3tkz9MVa8mXTHzNCkvaUNWA2l3FP7TPr4kGK80PlUBQ3nsg==
X-Received: by 2002:a05:6830:650d:b0:71d:4757:8c8a with SMTP id
 46e09a7af769-71dcf56513emr687911a34.26.1733447378336; 
 Thu, 05 Dec 2024 17:09:38 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793249b6sm512861eaf.38.2024.12.05.17.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 17:09:37 -0800 (PST)
Message-ID: <03f56e2b-a095-4dae-b08d-227ce2db40b3@linaro.org>
Date: Thu, 5 Dec 2024 19:09:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove tswap() calls in semihosting
 uhi_fstat_cb()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20241205231330.82355-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241205231330.82355-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/5/24 17:13, Philippe Mathieu-Daudé wrote:
> In preparation of heterogeneous emulation where cores with
> different endianness can run concurrently, we need to remove
> the tswap() calls -- which use a fixed per-binary endianness.
> 
> Get the endianness of the UHI CPU accessed using
> mips_env_is_bigendian() and replace the tswap() calls
> by bswap() ones when necessary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/mips-semi.c | 43 +++++++++++++++++++++---------
>   1 file changed, 30 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +            bswap16s((uint16_t *)&dst->uhi_st_dev);

Rather than cast, maybe better to

     dst->uhi_st_dev = bswap16(dst->uhi_st_dev);


r~

