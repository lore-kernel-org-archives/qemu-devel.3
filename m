Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B599CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxp0B-0006Gx-85; Mon, 07 Oct 2024 10:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxp06-0006GD-3f
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:46:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxp02-00042G-0a
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:46:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20b833f9b35so38743345ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728312372; x=1728917172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Do9LiH9X8RX1hWoEsGCTdRHLNiTGr/IZhUukpXsXSxA=;
 b=npzN6cgv8cIwk69lg3whzTkn2TGhth7wy2BLiOdN6IkvLvvJAIV0HOhGgB7F+l1Lz1
 QJsHdWK3esW/UxsI8aba1dgaFQ6i09qvSDyLMY+wcoh2MTaiDOf7xt1vLxPo+QtEkXUb
 +yD0Fdzm+OAHRHW51Qzu7C3LsxMhCcUkQvAOVHbS0aIqUtC9/CAX8oLZqMaxmPThHtWW
 VDtL+Q6G0an1YpfvfjPhtBJHI51/IBkf7R6S+qpkxo1YnQdyM4LBp36jqmQRF6DJgJkP
 j4bV/+TlNE/t5Gs9+B5VYXTqQPHJ2CDvgI2olCmHU5io8rDQUt7Voo0VAzHsqqea0eCI
 tWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728312372; x=1728917172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Do9LiH9X8RX1hWoEsGCTdRHLNiTGr/IZhUukpXsXSxA=;
 b=Z4PUBxYF1/fxTtZDca21du6+OO9VxOYCzPSr4Hd5EuxzUHewlKcrK7rD0/HNklZPzR
 7yA4xc6UMkQWD506VjHrMee1y/isqlzE8XU3PXbSg0VUwdtbvbP+uDH4x9fgxCxhsI8g
 qGdqq67WB0yTYITP+35RJ57pSODYl7qMsTBImC4FurFrVcaLca6LdCiBAnI5Jl1lZxJC
 JEVoZOusl1MRUQdDqvqnmYQwdqHpDbdOVGXSmR49hl7BxSLxlaHHcJaRAi1u+xqzNNuH
 T/yK3UJeyH7x0nFop6fSJ9SMegBV5tXXS/e2WR/eKotH150a1GAxzySiVLwMbLPfbDRV
 1ZoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXUzIN7x/epB0b6QAlOo5Eg6ULPDU7kxylKUCGEQ3owNZ9mOiYafl9gFgCYzmh2HKJihAJW2zP5L3k@nongnu.org
X-Gm-Message-State: AOJu0YyMgPoCSOZET/oM5vTh7VVoG6c3SdR54RjkKLKSok9PJcqp0vHk
 pCqx9Gdfig6FL2wrC6YvgsKKTcbUxHoNPmMbSoPsonbSTvp70Xj0nvi5k7yaEYs=
X-Google-Smtp-Source: AGHT+IHlDk7GnjGBVKPGCuHSRJxECJ0XQvf8TH1WLa9Ql9kZYmLMhr35XT6hKF4nug+/ZpBdlUM3BQ==
X-Received: by 2002:a17:902:f64f:b0:20b:b5d5:8076 with SMTP id
 d9443c01a7336-20bfdfc0ca1mr152723035ad.22.1728312372177; 
 Mon, 07 Oct 2024 07:46:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139a2fdcsm40415145ad.299.2024.10.07.07.46.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 07:46:11 -0700 (PDT)
Message-ID: <86423148-2cbb-4263-a351-dac0ece198e7@linaro.org>
Date: Mon, 7 Oct 2024 07:46:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] meson: define qemu_isa_flags
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, qemu-stable@nongnu.org, alex.bennee@linaro.org
References: <20241007084342.1264048-1-pbonzini@redhat.com>
 <20241007084342.1264048-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241007084342.1264048-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 10/7/24 01:43, Paolo Bonzini wrote:
> Create a separate variable for compiler flags that enable
> specific instruction set extensions, so that they can be used with
> cc.compiles/cc.links.
> 
> Note that -mfpmath=sse is a code generation option but it does not
> enable new instructions, therefore I did not make it part of
> qemu_isa_flags.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 76335bb2a51..bbb0f6d9bcf 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -335,6 +335,10 @@ elif host_os == 'windows'
>     endif
>   endif
>   
> +# Choose instruction set (currently x86-only)
> +
> +qemu_isa_flags = []
> +
>   # __sync_fetch_and_and requires at least -march=i486. Many toolchains
>   # use i686 as default anyway, but for those that don't, an explicit
>   # specification is necessary
> @@ -351,7 +355,7 @@ if host_arch == 'i386' and not cc.links('''
>       sfaa(&val);
>       return val;
>     }''')
> -  qemu_common_flags = ['-march=i486'] + qemu_common_flags
> +  qemu_isa_flags = ['-march=i486']

Use += ?

> -      qemu_common_flags = ['-mcx16'] + qemu_common_flags
> +      qemu_isa_flags = ['-mcx16'] + qemu_isa_flags

Likewise, why verbosely prepend, rather than append with += ?
The same for all others, including

> +qemu_common_flags = qemu_isa_flags + qemu_common_flags


r~

