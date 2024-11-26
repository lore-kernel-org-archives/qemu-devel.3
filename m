Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2772BD3B998
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvU2-0006jP-Qb; Tue, 26 Nov 2024 08:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvTy-0006Lo-Gu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:19:58 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvTw-0004Gj-6v
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:19:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43169902057so49185415e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732627194; x=1733231994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9egLsmzqltW386IYYnCDQ/+h54aQH51LwCV5pFOr2e4=;
 b=h+c6ExABF58m9MtgZPyGKGQ6gkQ5b72S8QjVuZQ+/4KtCLWQir8ymhSUl30B6gQ2qp
 tdi8GEG11yReGnFQUk0Rb+FirPKIUSdKvFPceaDUxQbkv5IaoKvLLLW3PlnDDnej6isH
 8ocZFqg85KQRa61AJkL7AnXmvx++UiCXjWCE3EHZmQ3JiuPW4xU4uRCTMDh9RO/DQ1SG
 JWmYOAmkjQuScl4LVJ6+o0FhwJdbylFlKbvIfcpvuPoN0SyI2G9T4hM8Qr4qYDFydZKy
 bY1xI7HdhMgYdhx9ScDCWK8MNw/EZvjiQcAaaNcNkyh9S1Pypz9T+9jrLdvQeDgy2ybE
 LKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627194; x=1733231994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9egLsmzqltW386IYYnCDQ/+h54aQH51LwCV5pFOr2e4=;
 b=TIeUitryvfkigEU3cfNSOsOC5LRVAgKvRgl+/Fd5YH2apKD9/07WXDzkdI7f4NL3G2
 m29vyd2B9ILk7PLfValvFSVM8ZeAEXLi0PBNUSOqPvfwHWDU9q5p0dYERNj3F08mPchO
 4xAnw+HM5A+leQq8RtxlnWHaeH1Yaae5CjHms7PfgdtBlRiZYa15hOaxVEX/Yq1t1KEQ
 KEmeISrNp5eRg2HmI9Xi3+Y0q4bfYnFNkyVeysNjolBtjz/QWDun58qCs572Hrvf7g2D
 ksXNtYFzwoeSdPgz2atO3CMElqyAV4vUTZPZiN/fLfy+DvIeliGV637qPs10QkwNJQ3s
 3WVg==
X-Gm-Message-State: AOJu0Yzxzyz629wACpsOpctzjnLju9+bYvvSYd4vWF7OXUmYa5rm1qHA
 KH2phGkl1Ydq1Pm5SYd6TK/D1096zytKo9Ot4OjPAN/MbQFlj/6etM/1ehlZhOi4JN75pH2ho9N
 y
X-Gm-Gg: ASbGncuDPBe7nIZ1bZbaEQ9MZC+B/G7P1H30i8yv+xUABjzTLsEeZSVKCu5BesZ44IE
 WEjI3DuBwvRZNe8SmJXELBo05btZe62W9TnBsYUjzCBLIeSoyWEWA1HUOZyWW99OIsSP6boM6TI
 eLfNZ4iJ7EovVfbxpErLCDpJrLaP5JqWeaN1hr4jzR2xBOi0L0UND1es9u5eek4Pca5+m9j7Rk0
 rOf2drydWqI7a3O0Qvu3SOD+P++2G1NDobxei11pNmnBt6CXFgnVyFVTUWcHBO8vA==
X-Google-Smtp-Source: AGHT+IH79wvV2PmM+5ONRip7HWv9KMGczkPswS2KyaVz4bJmm+6BUenAlgrgMHduVw+ueXiSwS29gQ==
X-Received: by 2002:a05:600c:354e:b0:434:a315:196 with SMTP id
 5b1f17b1804b1-434a3150334mr40798445e9.19.1732627194134; 
 Tue, 26 Nov 2024 05:19:54 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a4b0af1csm32563845e9.40.2024.11.26.05.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:19:53 -0800 (PST)
Message-ID: <95da2038-4d3c-4d05-8d96-494d3fb49a2b@linaro.org>
Date: Tue, 26 Nov 2024 14:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/mips: Introduce decode tree bindings for
 microMIPS ISA
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>
References: <20241112172022.88348-1-philmd@linaro.org>
 <20241112172022.88348-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112172022.88348-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/11/24 18:20, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Introduce the microMIPS decodetree configs for the 16-bit
> and 32-bit instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h               |  2 ++
>   target/mips/tcg/micromips16.decode        |  9 +++++++++
>   target/mips/tcg/micromips32.decode        |  9 +++++++++
>   target/mips/tcg/micromips_translate.c     | 14 ++++++++++++++
>   target/mips/tcg/micromips_translate.c.inc |  6 ++++++
>   target/mips/tcg/meson.build               |  3 +++
>   6 files changed, 43 insertions(+)
>   create mode 100644 target/mips/tcg/micromips16.decode
>   create mode 100644 target/mips/tcg/micromips32.decode
>   create mode 100644 target/mips/tcg/micromips_translate.c


> diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
> index c479bec108..f504e15fa7 100644
> --- a/target/mips/tcg/micromips_translate.c.inc
> +++ b/target/mips/tcg/micromips_translate.c.inc
> @@ -3000,6 +3000,9 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
>                   gen_reserved_instruction(ctx);
>                   return 2;
>               }
> +            if (decode_isa_micromips32(ctx, ctx->opcode)) {

This call is incorrect, the caller previously called
translator_lduw() so ctx->opcode is incomplete.

> +                return 4;
> +            }
>               break;
>           case 1:
>           /* POOL16A, POOL16B, POOL16C, LWGP16, POOL16F */
> @@ -3011,6 +3014,9 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
>                   gen_reserved_instruction(ctx);
>                   return 2;
>               }
> +            if (decode_isa_micromips16(ctx, ctx->opcode)) {
> +                return 2;
> +            }
>               break;
>           }
>       }


