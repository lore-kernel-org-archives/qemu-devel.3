Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101E3D65559
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG342-0000K7-KU; Tue, 26 Nov 2024 16:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG33q-0000Jl-Qw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:25:30 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG33p-0003yS-1b
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:25:30 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2971f46e065so97897fac.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732656327; x=1733261127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FAKENO2cLwXPiu3GS4W6+W1rWZOERuRZBCvsgjqRuic=;
 b=z4n76tOUbLsELHTls/HaGphyi2SuOYLj9O/nRl8oFpSW2t5Uy/XxqOSRFVkV6K6zOD
 lyzovgJkUnDPu8cXbAfyIAhOytMn6juJIcfQUL521A2X/P90RSWRNNGvzZVlVw9vgnFM
 xiwXVit4G9SKZXC2BfsNx/Tg76naU9Zz26HS+nN1ZB6BMsj1Pbv/uDCALCWIFdo0k8Eb
 HSGcX8rObbpoHrko+GoxSCTzK+/wLnqt6Rmu1JZtxKNEOmsSmkwqKf+A6KWAS5KKn8HX
 4EqgMFzA8CZrzYoki5/ndgd/scblnpLLbT5eSHBJn05h3B6FPHFNqUvqvM6QCO16mky/
 QiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732656327; x=1733261127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FAKENO2cLwXPiu3GS4W6+W1rWZOERuRZBCvsgjqRuic=;
 b=Y/d9ZE5WUzA6f1TSIbCuqm8XvRhMVsPkl+2l4Ox6akwLqHq81szqsYRQxtMc5aYavT
 k919unFuIJmsO3dqcRwUnv2NomRNmDjIEEI9SNb65PhF1Xzn1Bd/X/x8Z2N/veTxaLtx
 pAzk9nHHaDr/YmDVJRvI/OfqV6NFyxO82bKPb0n/OmtmKGaCFXiauUfHXzSFifaamZO3
 vWjQKPZXOkgZZOKM4Y60HFKxbLW0IkdlRvKrK9wJHO2ANkKuoBpkcr+CSHthV5sEJy1l
 HBQ9CzEZc7QwM/GwAeLvumo//vP6b2FB/M/Raikr0cGoMEQWgSCEPopmpiglPWBkCndj
 9C9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVITfmG+S1wGyxyUq92k3KXdOjmoD+A/TDfCgaAlxIqsqWDGrjespQgOqykHwKnggFGPaZ555zbJfcS@nongnu.org
X-Gm-Message-State: AOJu0Yxwt9NArthRgxyiBOPQQ2ZRIIDYyJbb01imlob5Qshk7TQa/t4h
 P4COXnrxt4xh3ElDbA+MIPkGzmQuL6x8toQPlpjmBV5a18YwJImwFKKVpJvDyPA=
X-Gm-Gg: ASbGncv4vjxewbHROECynR5jj2XS2pHkczKUaeDH+2ZjbL3CBULKuvew7bIcouGrwhr
 gHOptZQhpNwduLk0DS32PJ/I1qM09ReyVD0kzRvBQAekJax+hddrqV/fgTfLbnRNgZPz9ezhsls
 wVzkINnprqRZpVpOT0HJjZsy3A/pfn5X+RzBZ9sr8t+V9+l0XhoF3t4z+wgJqTtUhnDYsACYI+L
 HXSouwPMOTOB6HAWz8qwB4QnKyTVM9ETespmwP830BBkosVboWeRGx9uAZyiF9uL13aNGPA6J2P
 gDGEcju4Fiif6yPtU6zzYE5/oYBm
X-Google-Smtp-Source: AGHT+IEeKEjvSOx6xXFSFJqqxjKVyuu2yc1IWmBD0F9jdBb22EpwxSMS1XVoHG15QKuvyJdzsTO4DA==
X-Received: by 2002:a05:6871:319b:b0:29d:c4d4:9ed6 with SMTP id
 586e51a60fabf-29dc4d58c82mr173962fac.13.1732656327704; 
 Tue, 26 Nov 2024 13:25:27 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d822773sm4256787fac.37.2024.11.26.13.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 13:25:27 -0800 (PST)
Message-ID: <d4015a7e-9a84-473a-8779-0433aa153f2d@linaro.org>
Date: Tue, 26 Nov 2024 15:25:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] target/mips: Convert microMIPS LI opcode to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 11/26/24 08:00, Philippe Mathieu-Daudé wrote:
> Once the xlat() and simm7() helpers are added,
> the decoding is trivial.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/micromips16.decode        |  9 +++++++++
>   target/mips/tcg/micromips_translate.c     | 19 +++++++++++++++++++
>   target/mips/tcg/micromips_translate.c.inc | 12 +-----------
>   3 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/target/mips/tcg/micromips16.decode b/target/mips/tcg/micromips16.decode
> index d341da16b04..fdc3b131c9c 100644
> --- a/target/mips/tcg/micromips16.decode
> +++ b/target/mips/tcg/micromips16.decode
> @@ -9,3 +9,12 @@
>   #            (Document Number: MD00582)
>   #            microMIPS64 Instruction Set
>   #            (Document Number: MD00594)
> +
> +&rd_imm         rd imm
> +
> +%xlat_rd        7:3 !function=xlat
> +%simm7          0:7 !function=simm7

Hmm... simm7 sounds like sign-extended imm7, which this is not.
The encoding appears unique to LI16?  Perhaps just li16_imm7?

> +
> +@rd_imm7        ...... ... .......          &rd_imm         rd=%xlat_rd imm=%simm7

You need not define separate formats when they are one-off.

> +
> +LI              111011 ... .......          @rd_imm7        # LI16
> diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
> index f0b5dbf655d..198eb466057 100644
> --- a/target/mips/tcg/micromips_translate.c
> +++ b/target/mips/tcg/micromips_translate.c
> @@ -9,11 +9,23 @@
>   #include "qemu/osdep.h"
>   #include "translate.h"
>   
> +static int xlat(DisasContext *ctx, int x)
> +{
> +    static const int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
> +
> +    return map[x];
> +}
> +
>   static inline int plus_1(DisasContext *ctx, int x)
>   {
>       return x + 1;
>   }
>   
> +static inline int simm7(DisasContext *ctx, int x)
> +{
> +    return x == 0x7f ? -1 : x;
> +}

Don't mark inline.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

