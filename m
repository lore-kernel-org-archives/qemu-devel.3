Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED68C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslYd-00021X-Np; Thu, 13 Mar 2025 12:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslYc-00021A-08
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:37:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslYa-0005JN-EV
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:37:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22334203781so44312655ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883835; x=1742488635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2VzwgBIU79SKOBywylj2EhAIZV8PL6r7LqSVxTrv3ok=;
 b=A+VmvG8PriS8hUMGWd172+vYsMiDgEgJCCvVIMLv1mp6zPwcv04V2ZtIzb+HYtB7XC
 AL13ujMbEKPk4hr49gbSFSs5BqcTrxb4V1GT+h8wxfUoZFuzczsLMCOMSuHD7ksz749e
 bJzBRe+gWp8nMBMnpOJ68t/D47tHp/mU7Wqasv9IqNAM+xVoAeYcaKdGFYk/BpqGHn7C
 KCn0gwj7cqvMqH01JFMu2MRIOT9+4SFBMW4JDb0nKOa3EpWKJ/Nyc+rOYVzHTDB+K48r
 4Tzsi9k3Ozs9BCqwXgZVhbJAyvz4JAnmU9cQLjH4up3WQcO8QjksyA/D3Chh5v7UyqZZ
 hnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883835; x=1742488635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2VzwgBIU79SKOBywylj2EhAIZV8PL6r7LqSVxTrv3ok=;
 b=gLRwUqs4MvfkEYuFtNl7LyaR5wyrcTnh2aXVnW1he2aSDCC+F/NBZpzgScvlmf9c+S
 fdPswaOpit+r5MG/d84u47uL2Om14s6/iHAbzRTr1+E5hCPxc2xfPJMVyuaQEVag6JWK
 ztm1DV2PyVdZiWmJrlK23td8Em0q5HZsH9mUseFjRznn0Xx7Cgh4ppxRuse96IicLo1P
 DcPIv/DCHhGhOyXTcTazFAQd2i1GYQJxiMUrYgy7ZuS7GFWDxf+CDpYlW9jBtBlyW8iX
 6nnCjD8H9VDxsUdCEht0c1MsXkbNpUUyxR/vgDPkKCIYo781gwoHv10JWT5lU0iZLJnC
 75aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVesTNTMRGJDo3QebNundRzaihddl6iWrrPMd0cbWhDsRNDJ5Cf222utlAXFfppnEW7Dc6IBn/ozjCV@nongnu.org
X-Gm-Message-State: AOJu0YxBHEkQolp2k65Nw7L8euTli10QNVtaipVZw4dZ4/ZNxroTHRSa
 FC7yrJou3+n0IoBND5SddQMWQniAg9r+vtkG3x3hyGy8waVgN2dzinKlGR7xTQ4=
X-Gm-Gg: ASbGnctzdQ+LJL+TPYDBtZrZquz7QRXF8uvy18w0MQHQ11NFSGv8EN8pZHfjdBRdcts
 CN0YjoEsz8O1SRjw78dlEj1CLSsUe/dqV53BmwIjREDKhnfcv5t+EOfwUHJ4t3KCuuNnguW0P+b
 psPOc6e6QCTrieOxrijSTWv6Mshebgz1JUGR8HymYz2wcdUfOfeP/OAAAD85D4nSLPIGCTKw9yE
 p1gUd69uXuzbC7JWETPNP7uFimQN9H6eb9mHZPTwp9yRmHOdgNPQ7PQy15FiXhDE2SvBOOx/VEJ
 sW2LXEuOMkAP5BuiwBwbm0ZG2NZZjKQRO+DdxC3BXNEmFdZxvj4hN3KxQA==
X-Google-Smtp-Source: AGHT+IGBhoIp7zOC2fNnq02RoxYjUtGiKhnQPz0v3ir+EJc1zIYyyZzAb4yQ27bggpwKrRRqQzwqbw==
X-Received: by 2002:a05:6a00:1ad3:b0:732:1ce5:4a4c with SMTP id
 d2e1a72fcca58-737106ee6a1mr4394616b3a.1.1741883834850; 
 Thu, 13 Mar 2025 09:37:14 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167e109sm1535774b3a.115.2025.03.13.09.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 09:37:14 -0700 (PDT)
Message-ID: <5c1d437e-28a2-49bb-af87-5edf458ae5a9@linaro.org>
Date: Thu, 13 Mar 2025 09:37:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/37] accel/tcg: Build user-exec-stub.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> CONFIG_USER_ONLY == !CONFIG_SYSTEM_ONLY.
> Therefore it's cleaner to just add to user_ss.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 38ff227eb0..14bf797fda 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -12,7 +12,6 @@ tcg_specific_ss.add(files(
>     'translator.c',
>   ))
>   tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
> -tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
>   if get_option('plugins')
>     tcg_specific_ss.add(files('plugin-gen.c'))
>   endif
> @@ -22,6 +21,10 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'cputlb.c',
>   ))
>   
> +user_ss.add(when: ['CONFIG_TCG'], if_true: files(
> +  'user-exec-stub.c',
> +))
> +
>   system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>     'icount-common.c',
>     'monitor.c',

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


