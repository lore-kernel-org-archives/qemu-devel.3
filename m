Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9CE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzRs-0002UN-3d; Sun, 28 Dec 2025 17:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzRp-0002Tt-HH
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:41:14 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzRo-0001HQ-8n
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:41:13 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6468f0d5b1cso3989176d50.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961671; x=1767566471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6iADNFH42pBrpJfN665BFUIbSvDe1G/eBSFwPlGkODc=;
 b=lryIFGyvhWITWzPxEEbebldjMAQnviMVy6gygKqt6bSFEML32xTyN/uZnNa3pBBKjg
 TLqUrWBoxpRm9SkYZb7OCERlW92+8NfbaHx+bMl029k/K9NAimmkB2o9wdE1702DcTvW
 XXMOxBUonMTWDBk3CR65XKOZE+TJ6hVtDKnCXuP6kxyp8t5dveGXR/IxG546edkaxDqo
 Ozuy/jOHgc3K1tz4g+Ff+rOFtyOlULlnP9faWUzftGk3i/FP8cc+WDIM8DM81babnoFL
 fpkk62BhKNLXnGQox8fmR7l/uqZNWFjnQ4k6fENQxw8DAHPqRzbifpehF428LGHKwHpG
 nVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961671; x=1767566471;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iADNFH42pBrpJfN665BFUIbSvDe1G/eBSFwPlGkODc=;
 b=jM+7UctIJi/eVpcVosuftKZE5rxYu9XgTYEslAv4pXHOBA6srqlSv03gK/3k85Dinn
 nMK6UFZbBHexJ3+jJ+/Dm2X43U/pAM7si208pbJaL1Uvpgh+F7NVZ1vBEckV3VAaAuNf
 1+kBSlGnC4msRDu0uE9Jjkzzxf2osMrmvniZWdNpHSsAA1rXnCQKjV76/58zBvubFp9l
 1E3UvYjI+gXKXoQR7UfIp2AZVERgC1WlG1EOyTY6fdXaEk6jlpytpJ3SBS93pJOimOC/
 CoqChpwyYrTVfxR9x3pUe7tsmceeRei7jHqOBe/1P0vjwvKnIoVO3ZpM3RVIFENz6kS5
 MddA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUllFp11BF7t2doQmeSnf8/xAbusanjzhphYMwAQdEjSz2fCwXUwhIt6DOol8GIKYnd24G2mgBjIDht@nongnu.org
X-Gm-Message-State: AOJu0Yz58Pu8INHuCqyAKeC0jIKuzLZL9QlnrSo+H5APgFYNgv5pCoi0
 2sNoMan38ESeNRSUQsi2mQBer1m78EAScYnkjt5l247TnPQ+CDMLKXRkH6yOVkoOrM4=
X-Gm-Gg: AY/fxX4GYXgYa1v6lEajGh0cNaN0J43XQO2B8bi6uzwYFnm2rJqYSFKx2wIAKQNDR6/
 k+cCuXEX0Tvj6xk4udEzv/OiwZr6eJ52SX06CATh7PxjoY+Nra4E5a+6MVPbdIcJLlY8xabfRgS
 JKCOZ2EGIjAr2/K80rtDRH+ZCmdHU3LahoLxrspWlBmlTX46yPzU9W9E4MfouzH2B72cqvbSL5x
 ACXyZSi231E2JoV6tZj39lCdQ5yjBjHr+hq+9UFe1M4xoH05gOUqFJjbdROKfQIdqrSKmli/nDf
 lGnPo24EhME9JdmjhHMaBMchSl39s7mf6XeyDjnriXDwk0ai+JmTuAWscr8RIsXJVk2gh2a58dr
 LykMDJRCIvKduCeraeA9YhoOa1BgYl7TBcpFLcnsJfrqsl/5gkx+xOiDotMCnJnxBLc+ByJrDKj
 hlDcJUY0jUpkvL5wnekHAquZ5YgeASq1G7CQvSjKUEH+M11mSKhXSvBE+iqovjpsMzdS6IDGyYL
 X3j7pPF
X-Google-Smtp-Source: AGHT+IHZjdvyLWph9jTHlosYSFx9ZaOlG8QzIqt1CGru2gXn5iKuwxvLTWT8KTqiTpGQa+c1jA7mKA==
X-Received: by 2002:a05:690e:1546:20b0:641:f5bc:698b with SMTP id
 956f58d0204a3-6466a912fd9mr17822735d50.71.1766961671105; 
 Sun, 28 Dec 2025 14:41:11 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6466a92d94asm14001129d50.19.2025.12.28.14.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:41:10 -0800 (PST)
Message-ID: <899a4d4b-11ef-48e8-81d5-6bcc66cdfdd6@linaro.org>
Date: Mon, 29 Dec 2025 09:41:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs/targets: Forbid AVR to use legacy native
 endianness API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251218213053.61665-1-philmd@linaro.org>
 <20251218213053.61665-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218213053.61665-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/19/25 08:30, Philippe Mathieu-Daudé wrote:
> The qemu-system-avr binary is buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/avr-softmmu.mak | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
> index 1aba1ccf13b..b6157fc465d 100644
> --- a/configs/targets/avr-softmmu.mak
> +++ b/configs/targets/avr-softmmu.mak
> @@ -1,4 +1,3 @@
>   TARGET_ARCH=avr
>   TARGET_XML_FILES= gdb-xml/avr-cpu.xml
> -TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
>   TARGET_LONG_BITS=32

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

