Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61723D42B85
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArui-0006vj-R3; Tue, 12 Nov 2024 09:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAruU-0006v1-98
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:30:28 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAruS-0007xo-IU
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:30:26 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71ec997ad06so4726351b3a.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731421823; x=1732026623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vx9B7RO1IxMf0XzV5ktQ6S43si2ptBtKLIWDhdK9nIQ=;
 b=RyD4Vd9AH2AY6k0kPRHV7+L/FLi4kEcTcMM/mTwljs01Hby6nuGuXCpCnV+E4z8cMv
 RlDv4ChL8jEm9wwM7QwlmdmZFm2b8FZlmbUjuSN2N55guI2cuMnFXsTIpBXDERHRyp6b
 kS8CO62ZNJz20vrqV1si5ipsmJ7S2u/1LWiGEZnUbZawkOTlpkin6gQHTqw143BErm8X
 BvC4hZ60mKDdPIhFDTeiXBsVUifR9X0JXtl9vRQg+oe9RAYjFLJID0a7kaRE5Q8SFWXA
 f+gdebs/wEnAUQyuHWi9YLZ9RoENo0agm9slrLBPlmYJkUoZDC2O15kFeU+pKNCrfvdz
 Kltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731421823; x=1732026623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vx9B7RO1IxMf0XzV5ktQ6S43si2ptBtKLIWDhdK9nIQ=;
 b=rRATCmQY3+d+qW7Tdshpz5MBS62I91xdapc6vZj8E1TwwiyGjMtiJy2UwHzOxjxDjD
 GpZX/qNIU4yKy8WbRiCClCn3ex1PFqqy4LKfwruwN+TLJLjhqLrrMNN+hGp1rJV9Pdmz
 h35tLT32jSfslOBZck3TGVI6IrnZ53jz6WE8tHS7986yS63Gl0vPfbyiOozdeFJ6p2/E
 irfFL03Ax+JCgsV37/CdsZio53w+d/MtkvrLZ9CLu0nORkXKD1xvq5jUCEqNX6x0X9Pb
 CVA+4u8OCAJ7N6Q31Y8kjAU8rbxlqeVG4UmUnWf4VjKntQPr2ocjwpNUy9MRso5bwJ1i
 YalA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSTZS3dr8eNx+z6jRui+X13Yqepj+lS5/s02yScGkB/VDyEG/v0l8F2AZCpRL7kczmLvGiwMNoSRdV@nongnu.org
X-Gm-Message-State: AOJu0YwsO/AgutadQpkHhCJ6KfVo2/nSD2Fdy1drHnNbf6eMqu4aI3VB
 hSVN7jD0zPKyAHdC+2N4jf/FoZqbvcmgNCjOWTN2NPDsjAQY/K/IJXzmuLDJ3e3j6/b4EvudoIe
 C
X-Google-Smtp-Source: AGHT+IELnYQ3PzheDXDUAMhDFY2aLnGoLk6XmTvGt454t/S7nN3RrOSz2Gayu0Nw+sJ9/zBOcFrUSw==
X-Received: by 2002:a05:6a00:3a2a:b0:71e:4ee1:6d78 with SMTP id
 d2e1a72fcca58-7244a4fde5fmr3784025b3a.1.1731421822726; 
 Tue, 12 Nov 2024 06:30:22 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407860a4dsm11511043b3a.29.2024.11.12.06.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 06:30:22 -0800 (PST)
Message-ID: <a014d0a3-6692-41b1-84e0-6da07ed1e58b@linaro.org>
Date: Tue, 12 Nov 2024 06:30:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/mips: Convert nanoMIPS LSA opcode to decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>
References: <20241111224452.61276-1-philmd@linaro.org>
 <20241111224452.61276-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241111224452.61276-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 11/11/24 14:44, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Simply call the generic gen_lsa() helper, taking care
> to substract 1 to the shift field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/nanomips32.decode        |  8 ++++++++
>   target/mips/tcg/nanomips_translate.c     | 12 ++++++++++++
>   target/mips/tcg/nanomips_translate.c.inc |  9 ---------
>   3 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
> index 9cecf1e13d..11bf5cd6c4 100644
> --- a/target/mips/tcg/nanomips32.decode
> +++ b/target/mips/tcg/nanomips32.decode
> @@ -6,3 +6,11 @@
>   #
>   # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
>   #            (Document Number: MD01247)
> +
> +&r                  rs rt rd sa
> +
> +%lsa_u2             9:2  !function=minus_1
> +
> +@lsa                ...... rt:5 rs:5 rd:5 .. --- ... ...    &r sa=%lsa_u2
> +
> +LSA                 001000 ..... ..... ..... .. ... 001 111 @lsa
> diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
> index c148c13ed9..9a6db4a828 100644
> --- a/target/mips/tcg/nanomips_translate.c
> +++ b/target/mips/tcg/nanomips_translate.c
> @@ -9,6 +9,18 @@
>   #include "qemu/osdep.h"
>   #include "translate.h"
>   
> +static inline int minus_1(DisasContext *ctx, int x)
> +{
> +    return x - 1;
> +}
> +
>   /* Include the auto-generated decoders.  */
>   #include "decode-nanomips16.c.inc"
>   #include "decode-nanomips32.c.inc"
> +
> +static bool trans_LSA(DisasContext *ctx, arg_r *a)
> +{
> +    gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);

I think decoding shift-amount - 1 is misleading.
Surely it would be better for other callers to pass extract(...) + 1?


r~


