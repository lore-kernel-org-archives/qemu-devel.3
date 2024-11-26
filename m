Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CB0D3B9BA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyPi-0006oA-Fh; Tue, 26 Nov 2024 11:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyPd-0006nr-7a
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:27:41 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyPb-0003g8-Pu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:27:40 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-296c184ed6bso3415013fac.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732638458; x=1733243258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VRRhWo663vXtOJoDDc5+oXCfZFOHoEyaoouCVQNGrTA=;
 b=cZkeJpizwuSEsylJkkTCAeeeGlquP2OhwTPMANHyo5nOGGN+DY7BA1UQE2QfFfuCVM
 fEqet0tIPdlbrsNk98qwLvT3de5k8Zal1Oa9cKK1bGNMaXg7FUgDkwCCB/JWlbhHA/YI
 iku7Z9MmJpj+3uJUks75Qqw2JAgAfOxMw/C0+7CW8Zg2I8nrjj7QalQjKHop/g2upWex
 MkCotsvvjqzeAoH7OCZ3SeSlunIOC3uBDNa6E9JnDTkIHDhq8XGzv5lzVEdbJ3ECi3I+
 jMeWKB/FXQXDE+ER177iiNKXunSuz/1MYxglt1Be/CEhS00vr2nSJTa9yfYdg73oTnT8
 1nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638458; x=1733243258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRRhWo663vXtOJoDDc5+oXCfZFOHoEyaoouCVQNGrTA=;
 b=HoZWW4IsuWM4txf+XATC2OCsqoPGsQo2pVX7+4I13CETsTi1P2hMAmOM1mKGm14Of+
 t9Q+TQ/wcS3m1YqMmjvvhtlimGsyU01hlJQM9CNn07Xm+V+ixQeWMSlpZAn/AKzYcfYb
 JdjCdoD+IusjFnmdc+gcXPwIM6xb1tBySBxxUQwc1/AYp8EA/rVdCq3CkfjCrR3UiDJB
 NCuF2UlGonsEpAP0oODyhgiDSA7Em1vEltTGgDFgWqqW3u18JByB3HdHt55MDXt/i3nO
 TEWUVGL2YlHXaf5xrFDbyMM0N/tKY6ELO4lC8twoEern+5cuwRo4pM+Wa5NjFy0d048I
 DIxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm7BRUHHVPFwVOjLlebVyFUem7OqZt+bJQ/ziEN6gi090SiITAApeOuAWHinbMf5IRK087GywbIdjG@nongnu.org
X-Gm-Message-State: AOJu0Yyu4oI5SrApdhD1rpYeN4H4ke7LIbgAdeJpjMJEa27+zIGAU9hA
 xGjNCVi/bEt/t6VErETP7u6/axtrPWd+tuxjXSJCn4RJSsy6uhG6rE03A8Xlcfo=
X-Gm-Gg: ASbGncu+kvsBdM+k5jw8g3xzaSmHpZmB6oJdh50lU3YGll3nhJcV65ZGeCjrIQrJ+Hn
 xz581Ua6d5l1rlQ3FHXGa9DNhpaVMKsXOKTVRSpRdv2JkCEXgSsaWS3sj45M1PmzBLYfH2M9/7+
 tvJX8sXTuDR6J6rij7hYHz/pX45QSsMe+DRymldkA2JEpZsAzErME/UZ1oXTqyQaxx3Oo/Z5YSU
 LQYM6Qa64cMbgXUa7dWxVlM6rUPmjHDGqMveRFLgwL32AqrHuIL7fkqJTj8u7ynMg==
X-Google-Smtp-Source: AGHT+IHLfY60kX/O80xUQ80/LouhNEaljXJIIfwLa9uNntOmKK3SLtOcT5Gt6kd5n8Z1LHmVVtJc7w==
X-Received: by 2002:a05:6870:8189:b0:260:ebf7:d0e7 with SMTP id
 586e51a60fabf-29720bf0409mr14582128fac.15.1732638458474; 
 Tue, 26 Nov 2024 08:27:38 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d822c9bsm4037692fac.36.2024.11.26.08.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:27:37 -0800 (PST)
Message-ID: <f14ea7a7-cdf2-4726-95f0-d767ed4a59e3@linaro.org>
Date: Tue, 26 Nov 2024 10:27:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/16] scripts/decodetree: Add support for 48-bit
 instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 11/26/24 07:59, Philippe Mathieu-Daudé wrote:
> Some nanoMIPS instructions are encoded using 48-bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   scripts/decodetree.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index e8b72da3a97..88cd476d2d3 100644
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -1543,6 +1543,10 @@ def main():
>                   insntype = 'uint64_t'
>                   insnmask = 0xffffffffffffffff
>                   bitop_width = 64
> +            elif insnwidth == 48:
> +                insntype = 'uint64_t'
> +                insnmask = 0xffffffffffff
> +                bitop_width = 64
>               elif insnwidth != 32:
>                   error(0, 'cannot handle insns of width', insnwidth)
>           elif o == '--test-for-error':

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This is probably simpler than falling back to the variable-length decodetree stuff.


r~

