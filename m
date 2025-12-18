Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E91D6E2AD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 16:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGnE-0003QM-Li; Thu, 18 Dec 2025 11:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWGnC-0003Ok-Kb
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 11:23:54 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWGnA-0003F1-Mu
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 11:23:54 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477770019e4so7265905e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 08:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766075027; x=1766679827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FgVb9y9eBYbsTc6mNdZygFoDWtvReCxXi3YY4tBiiTo=;
 b=nBURY6lWqmdWElxxJGdICIfoovEGlpDoe5yBmAoOUoZ8Fpz67I75IqZrrPVqggeGPO
 ubr8c6xo8T4IToL8KbDOJim1D335XnPOwRErPSPPlyE0mG0S2eR0FIn4U/h8grq/tqcf
 DYxhdc/9Sx5IBT7WLgHMSPF2vONjpLEFzcyIlFE8VeKA4OysZP/rIjxpeH3iRV3SDx8b
 hNqbQpnDCCGCXnRjGZRJVNxlJtzp9V7TxOcfHFQi/aeamaTVKCh52HZZ6lqwY1wk8p2M
 uWNkc62U82TB0ifjSmOOmOroA238MoVreoLssZxuK3BQqhRYikanoyOnySECMh7tfI23
 Lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766075027; x=1766679827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FgVb9y9eBYbsTc6mNdZygFoDWtvReCxXi3YY4tBiiTo=;
 b=JWMIE5RW5SgBjSciHbXOls/RurAROWtQpTTdXMnmEcNO0VgFvcKX3ps6cgXx4owI6d
 MtTleG0cPp7D71o/1+sBsfqijRL6uGLNxSogZG8hWWOtjMM/vWV6Hy8CTiQEOjlYrfPT
 GzqowFrv6pvNnwW/s8T2MR0Cs39fpU9Pr7xHfsSUwa6yTWrUmcY8aeLnu+U+NAikdAOn
 Vb3JAW1dlbCeK/5UcIbm6Lp2eB5fl53FU9twGIwS8BhwO4fe5QHhaAxR+u0BZAh5ey+3
 jXx72MydCs2B9RffVH+gicBk4JeC+nM37dicOtG88QiyNZXwWDd9DAQOyT21xFPFNIr+
 B8oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNS6z3nYb7lOcqSjKksA/4tCs+DImrS0G0+F4FmjYaapWtYiAK3msLdRhQxJLcs+xzqkX2MTGeasKL@nongnu.org
X-Gm-Message-State: AOJu0YxJ3533AqTaCBd91BUoKTAUSzZ3R1By678dQv0HHxzsZ+P1ExNo
 lDA6oNGH/NkfA9JHN/lm/O4NEIiAPbLD6uHxn+kNwa1p4Nf1+3tJEACk9157g+v1HHQ=
X-Gm-Gg: AY/fxX7Qdu4Bf8/MsMJlDisVvPT8gnzvtddAP7syUOCKZN/LCo/t18zx7HjudNozGUO
 cQ08I3Ci9xiwoNmkGQltMQ8bpzZvcHnXdBdgC16oyYdlNI1Bp/s7ICgcJB0DHk8usb/k+G6r6dS
 utgvHBofJSEPYCl1ZmDX3jZv5CdXP18dwYV83s+TpzGGy56W22DAT4LP/wOAaDIVWIw7KCjnAYi
 LigiZXKGWoryJaS745lC/gYh+53Zkan39bmZ/9xFaqsjAIkqTh6iAhagVasG282JvopShm1hYXL
 gVA1wtF7rIdGcLhAA0w2yToS8Jl6QjYXLx/pAu++DV3QUfOurwpWOwFX7D9aHAKHnNgSeWgFmsy
 IISLXgpCiOsa2bmGqhN1BCGFUuaT4B6UYMM3mejSfwRHVkY6ri1tGE0PUxh7qAjVVFdEc690ghB
 N15omYFHKqLX0bTujGo1z93vj8coFRoCiXX9cy2DCqyXtmDzQiUPooPw==
X-Google-Smtp-Source: AGHT+IFKox1ZtEI7t0oP250LAve1EkjzW6yOjYNYAm7lr9xTo0nDSTquAiN07os3YKwjQq9pJ6aOZQ==
X-Received: by 2002:a05:600c:310e:b0:477:a246:8398 with SMTP id
 5b1f17b1804b1-47a8f8a8405mr207871985e9.2.1766075026915; 
 Thu, 18 Dec 2025 08:23:46 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a7b687sm18034745e9.6.2025.12.18.08.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 08:23:46 -0800 (PST)
Message-ID: <db34542a-61c0-460f-9ca1-a14a4ada0206@linaro.org>
Date: Thu, 18 Dec 2025 17:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/imx: Fix trace func name error
To: AlanoSong@163.com, qemu-devel@nongnu.org
Cc: cminyard@mvista.com, Bernhard Beschow <shentey@gmail.com>
References: <20251218141144.51001-1-AlanoSong@163.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251218141144.51001-1-AlanoSong@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 18/12/25 15:11, AlanoSong@163.com wrote:
> From: Alano Song <AlanoSong@163.com>
> 

Oops.

Fixes: e589c0ea9c9 ("hw/i2c/imx_i2c: Convert DPRINTF() to trace events")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>   hw/i2c/imx_i2c.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
> index d26177c85d..22b10e4166 100644
> --- a/hw/i2c/imx_i2c.c
> +++ b/hw/i2c/imx_i2c.c
> @@ -151,8 +151,8 @@ static void imx_i2c_write(void *opaque, hwaddr offset,
>   {
>       IMXI2CState *s = IMX_I2C(opaque);
>   
> -    trace_imx_i2c_read(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
> -                       offset, value);
> +    trace_imx_i2c_write(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
> +                        offset, value);
>   
>       value &= 0xff;
>   


