Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF612D42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvSh-0008Ml-CI; Tue, 12 Nov 2024 13:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvST-00087C-J6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:17:49 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvSR-0002dN-A2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:17:45 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso4778747a91.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435460; x=1732040260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PjzY9b7/Lsii6p3P1dftCewSULtBJw3/5DnbbkLiSAQ=;
 b=Wd2jngymEMpw0mZ8EhPqeXShYW9CaCFkFQqkXuBjVJM+LpU+jfCwCuh54pzxm7KNkK
 5UgKhw9shDvmlVOnDRJ8hv6JdOk0uGrgDxYZnNs0Dm3Q87cKIyLXF295NTWMhvv1dnxH
 Q02qRLCDAavkaB7KKkRJPZxu8X6bUUXLy/mrrQfH3qcmgUHe3Tnl//lMz4Tc1j9PPH31
 79Fxo/84qOQ4h67i7qk5h6qYpvgVJL4AdFRwCJb0CzLE0cB0Cf8f5JqkrIG4SsHAUIMp
 do3HgKaqLcS/ZwG2cjAhPtdfQD3vN+QgpvQZnDzk4mf9BrWW8WNN1VnXWzEEL6laOzHH
 zNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435460; x=1732040260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PjzY9b7/Lsii6p3P1dftCewSULtBJw3/5DnbbkLiSAQ=;
 b=ZPS8xrkwFor8qDuIsZ/5m4KX+PKXPE5OeskFKdN/+c9cQI1HHPsdalqJuqwXUbN23n
 B5Q85pavNNmWsG4rxjzIG9rG3V2F/iUI3Gio9FYiQUIpd/hYQdVQFO3S28+WL7sw3ClZ
 S3xmPPDfAv4eePEC+LCIic8EWSvVFv0tn9oN1Jxc2/aCjP8LJdEPeJJidCnoEB+OipM3
 RM1QgQWaZO3D1nR8BDxgMRLZCBct06nGKwPYFxoFhco+jkhDdFDyny9QGSrtmAd9CoBV
 +9DqH8bxWpzLok+0ENjUnZ7YqGlYfQ1Hay3uvmA2mA8wKcuCG3XnPXQWdKGg/E2r84jK
 NuHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtceYiscKkWXejXwZB0K/x6V/xexwE2phpG0mt6fw2HEr6GyZBDRENWWxgTUE6gn6ZKzJ8EewK7DAa@nongnu.org
X-Gm-Message-State: AOJu0YwmtkrzKZMm6kb43G/dfpq79S7udcN6QFNH14ikIv4Gq/qVAM5P
 O8PpRT3mNhSRtw7thaTYJd8Wv2Up1YluE1T83TSmaS8koDaH/B1nl4um1fy2+4wc+VIhA6XYb7Y
 6
X-Google-Smtp-Source: AGHT+IGUtukNoEZBbV8kqtWgpJoUgOIlFqDRR32wfHthuCquHcx1oJ/uWoEM4WbqMhEDF8ItafN0ZA==
X-Received: by 2002:a17:90b:4c10:b0:2e2:b513:d534 with SMTP id
 98e67ed59e1d1-2e9b1783a6amr22217493a91.37.1731435459989; 
 Tue, 12 Nov 2024 10:17:39 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a5f935dsm14380589a91.35.2024.11.12.10.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 10:17:39 -0800 (PST)
Message-ID: <fefc8934-b9aa-409d-bc99-d4554aa8d571@linaro.org>
Date: Tue, 12 Nov 2024 10:17:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] target/mips: Convert microMIPS LSA opcode to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241112172022.88348-1-philmd@linaro.org>
 <20241112172022.88348-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241112172022.88348-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 11/12/24 09:20, Philippe Mathieu-Daudé wrote:
> Simply call the generic gen_lsa(), using the plus_1()
> helper to add 1 to the shift amount.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/micromips32.decode        |  8 ++++++++
>   target/mips/tcg/micromips_translate.c     | 10 ++++++++++
>   target/mips/tcg/micromips_translate.c.inc |  5 -----
>   3 files changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/mips/tcg/micromips32.decode b/target/mips/tcg/micromips32.decode
> index c115ed2eab..958883ce84 100644
> --- a/target/mips/tcg/micromips32.decode
> +++ b/target/mips/tcg/micromips32.decode
> @@ -7,3 +7,11 @@
>   # Reference: MIPS Architecture for Programmers, Volume II-B
>   #            microMIPS32 Instruction Set
>   #            (Document Number: MD00582)
> +
> +&r                  rs rt rd sa
> +
> +%lsa_sa             9:2  !function=plus_1
> +
> +@lsa                ...... rt:5  rs:5  rd:5  .. ... ......  &r sa=%lsa_sa
> +
> +LSA                 000000 ..... ..... ..... .. 000 001111  @lsa
> diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
> index 49e90e7eca..f0b5dbf655 100644
> --- a/target/mips/tcg/micromips_translate.c
> +++ b/target/mips/tcg/micromips_translate.c
> @@ -9,6 +9,16 @@
>   #include "qemu/osdep.h"
>   #include "translate.h"
>   
> +static inline int plus_1(DisasContext *ctx, int x)
> +{
> +    return x + 1;
> +}
> +
>   /* Include the auto-generated decoders.  */
>   #include "decode-micromips16.c.inc"
>   #include "decode-micromips32.c.inc"
> +
> +static bool trans_LSA(DisasContext *ctx, arg_r *a)
> +{
> +    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
> +}
> diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
> index e8ec5a0ff2..4b4550872f 100644
> --- a/target/mips/tcg/micromips_translate.c.inc
> +++ b/target/mips/tcg/micromips_translate.c.inc
> @@ -191,7 +191,6 @@ enum {
>       /* The following can be distinguished by their lower 6 bits. */
>       BREAK32 = 0x07,
>       INS = 0x0c,
> -    LSA = 0x0f,
>       ALIGN = 0x1f,
>       EXT = 0x2c,
>       POOL32AXF = 0x3c,
> @@ -1793,10 +1792,6 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
>           case INS:
>               gen_bitops(ctx, OPC_INS, rt, rs, rr, rd);
>               return;
> -        case LSA:
> -            check_insn(ctx, ISA_MIPS_R6);
> -            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) + 1);
> -            break;
>           case ALIGN:
>               check_insn(ctx, ISA_MIPS_R6);
>               gen_align(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 9, 2));


