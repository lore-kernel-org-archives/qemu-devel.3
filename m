Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B185C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 05:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sge5Q-0001E3-5y; Wed, 21 Aug 2024 01:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sge5N-0001DP-Mf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 01:40:45 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sge5K-0006Sa-Lo
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 01:40:44 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db19caec60so3947239b6e.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 22:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724218840; x=1724823640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFBUWOGnLv433bOScmhFK6R2sTq6PcLV/bVvuPf8/Y0=;
 b=mEd1P71dmMbwNLiRkjz6WR8xceV1z9n3IN3ToaAkwOUV8KXzZfLRjOWAkJxQIxuIYY
 lSyj2N+aHwb7aDKUW8pSOA8SYJwBC1k1sFPTWYqFXNpvhkra9MiTLu6D9P3FfVzJPaUN
 Bbqd3t7T6ytwQgf3PaIponoQwkWGpIol4AR1Csomey0DAKBds67+iBpDlnd0mpBCyudY
 qLHTpdp1H371jlmI0gt0OoFn0NRNbD+RuHnrwOjQm5yGwkZQJGlEwqE9Ooc6Mrk5uQ/3
 7ptxPEacPEvYB31zKwEfY2zzDJPX090cJM/1RXhGXYOP7gofWOMsXRhy473sm0ynRxuI
 lH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724218840; x=1724823640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFBUWOGnLv433bOScmhFK6R2sTq6PcLV/bVvuPf8/Y0=;
 b=rvBlY82Gl4IhwkgjR7MuB4B2qq8rM0OnSExUd9iuIBR/GLNnj9DVDD6JePnlz4I0pY
 A2i29K+lHldNl1tQxqVljPV+t5IOdVkSQRcnxDFXoYDS26Dpnq4jS+arisGPTBpZwPiJ
 DHs3JhGwNzHHVtLo/qoa3GDc9jKtUOikBjiV97b6QR5hGWZzIVg4gcGfhSFndqNy/FuV
 Bnju/7EzLsUUxVWC29GUnBWYHretY3/Jj536cG/SvaJWaJs6vT4osuo5jA/ZJJ6/poJz
 i2s5Ec6Y4wVyZ5zLZDo+K+3V+llXhGQo8dPPN+Z8oyM/zop/2+wb98yggnmb56DHeCJg
 ljpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZszNMqk5euSxGUMbdRe4K+jINDQQZur6z8Enw47Kt0T+NPg35zK5qpdkd2j/jU2FCz6RVPXK5iuCE@nongnu.org
X-Gm-Message-State: AOJu0YzaQhuCL6eQMoBKuA1wweWh7coolEwuSqW4hlFrb5a8trhyfmv9
 xHWWmwQ1vOoyWxHOtFqdHy9dtCQMlffiLG884EvyyuaUqA7DZlaEww7yoO8h384=
X-Google-Smtp-Source: AGHT+IE4CgxhCPxUoHwxdYx88INc5V6go60dRdcJq9RMZlrf0UxeSewydKWafJdobTPf5aJ2BBwGFQ==
X-Received: by 2002:a05:6808:3a1b:b0:3de:1428:10c7 with SMTP id
 5614622812f47-3de195c3408mr1908523b6e.37.1724218839990; 
 Tue, 20 Aug 2024 22:40:39 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7fdc:73f7:8bc4:7fda?
 (2403-580a-f89b-0-7fdc-73f7-8bc4-7fda.ip6.aussiebb.net.
 [2403:580a:f89b:0:7fdc:73f7:8bc4:7fda])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b61a7672sm10336909a12.4.2024.08.20.22.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 22:40:39 -0700 (PDT)
Message-ID: <5fcad222-6a85-4b6c-bc8c-76cdcac62399@linaro.org>
Date: Wed, 21 Aug 2024 15:40:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: philmd@linaro.org, peter.maydell@linaro.org
References: <20240808051531.3183498-1-gustavo.romero@linaro.org>
 <20240808051531.3183498-5-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240808051531.3183498-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/8/24 15:15, Gustavo Romero wrote:
> diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
> index 501685d0ec..79a2ada74a 100644
> --- a/tests/tcg/aarch64/system/boot.S
> +++ b/tests/tcg/aarch64/system/boot.S
> @@ -135,6 +135,17 @@ __start:
>   	orr	x1, x1, x3
>   	str	x1, [x2]			/* 2nd 2mb (.data & .bss)*/
>   
> +        /* Third block: .mte_page */
> +	adrp	x1, .mte_page
> +	add	x1, x1, :lo12:.mte_page
> +	bic	x1, x1, #(1 << 21) - 1

A bit silly to add in the low 12 bits and then mask them out again immediately.
I see that's common silliness with the other two ptes.

> diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
> index 7b3a76dcbf..7c00c1c378 100644
> --- a/tests/tcg/aarch64/system/kernel.ld
> +++ b/tests/tcg/aarch64/system/kernel.ld
> @@ -18,6 +18,11 @@ SECTIONS
>       .bss : {
>           *(.bss)
>       }
> +    /* align MTE section to next (third) 2mb */
> +    . = ALIGN(1 << 22);
> +    .mte : {
> +        *(.mte_page)
> +    }

This is likely to add 2mb of useless stuff to the image.

Maybe better to just define a symbol:

     mte_page = ALIGN(1 << 22);

and reference that instead.

Otherwise this looks good.


r~

