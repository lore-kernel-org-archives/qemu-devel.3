Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83606D3B9BA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyOY-0005Qa-Ga; Tue, 26 Nov 2024 11:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyOX-0005O4-9m
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:26:33 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyOV-0003Vd-LP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:26:33 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2974274180aso2212043fac.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732638390; x=1733243190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dzbPQPMY41clY4j/0hy2r2gp48DcROxbnE5UGzpBz/8=;
 b=lYL6tvKDgHKOlam+NA6J/QfYVm6M2ttZu7NdMhQM/RYFjV4guJbaIyWUM7bF80U/3J
 qjpIfnSuT70/SRtuIim6KDuwGZstmkpswfXwPcU6pnWAuuY1SaOzTJW29gbYNs9r2fx6
 skGAdtSpeTAY2/BrcZ8+aBFH3k+GT/1eXuJqt86E3Z68t2XHDJ7xzJtEpOinCjjFayVm
 vLhhcRcMzBsE+4M+0IDVjIfuNXHOilGiqUNP7wR9aLlmL36JyfvFXPPN1s8oEFJsJR6t
 CMXW0szo0azLAbwuFvSEteXJXVKlrXFeKQKCRvHQf4RiWksU6FF+5Tyhe2qlZMVQ1Rv0
 76mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638390; x=1733243190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dzbPQPMY41clY4j/0hy2r2gp48DcROxbnE5UGzpBz/8=;
 b=TObpl3qa0XOyMdP5xTAdVgaYDQYF3+GOmyN5C9MTtuBV5UFps3F93lOSpbRXmUSva9
 S0eTorKcYUibLRv5T7keL3UP4UHOMfsKPQGVQC/suUq5Bi5nMDsS5TzXF9Zrq2QQR2uE
 pIwB17InsLvRuTxs0rBqHHJXJCU5sCvFWCLwnRGm3H3HhDbOxBaWW82Uo2zB2N8JaPa2
 +m3UgAxRBnIYThrrHvpy5xcZzMJO7EcAGAZ5FYCSZKcQVIer43gV4AsKtmofXcwHRw2c
 v4DIVwVvuYEXejSXVnKJc8kNrbMnWbToM+vqlN/CSFdYNJJwFUzgWemLXDTriiPhE0uw
 9XTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4hFEHtzJlvJbZQm8fRfGkYf4PB9ZAqknjCkpeeQAnHom4M3a2QQMmAya8gCeOeQxldvXCbqsAXUy5@nongnu.org
X-Gm-Message-State: AOJu0YwOePMq69Y/letZNyLz10/Zay80NpOatjmC69UthVLQ4qpnA7ea
 0nzv0CRkGTrCB0t+KgM3kbFTh20KhJtHJTKUXBNESzg53J9zOA710bJE+I9A+g0=
X-Gm-Gg: ASbGncvFBmFJAxBC3448f2Gky5GHpR21rEqWci1uYrba7uQ9Ev+6RGKOiGHudu585lD
 HQ1uRP+KHmS3PwhKR5NYJ2CKgFnUcOMm6mZqn/abBql0LeIY64YlpU+cpGaRy+2hsKJxCgEQIDe
 UZpdIq3UPBYcTxsv0ZBUOSYSw5U9D9VAONoVOhYoMyA56cye1vgbB/eX9GhQ/Bl9Tp6E2ZKRsKA
 BQwGFZynE1ZQ/mu2eLmaZvLLzHT/5xrtGs3svudd+x0Ezfvesb1d+k0fb2vheTshg==
X-Google-Smtp-Source: AGHT+IHB+mr5bvWApd/9xamIGi0dFUKZ52HCcFk4tTnGVXFepIxweebbz/TIEBDe6sSkgkmly97Lpw==
X-Received: by 2002:a05:6870:d1ca:b0:27b:55af:ca2b with SMTP id
 586e51a60fabf-29720bb5b15mr13912787fac.11.1732638390383; 
 Tue, 26 Nov 2024 08:26:30 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-297215eb31fsm3858860fac.19.2024.11.26.08.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:26:30 -0800 (PST)
Message-ID: <2a67864b-5965-4786-9cc4-f469132f9d86@linaro.org>
Date: Tue, 26 Nov 2024 10:26:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] target/mips: Introduce decode tree bindings for
 microMIPS ISA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Introduce the microMIPS decodetree configs for the 16-bit
> and 32-bit instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h               |  2 ++
>   target/mips/tcg/micromips16.decode        | 11 +++++++++++
>   target/mips/tcg/micromips32.decode        | 11 +++++++++++
>   target/mips/tcg/micromips_translate.c     | 14 ++++++++++++++
>   target/mips/tcg/micromips_translate.c.inc |  9 +++++++++
>   target/mips/tcg/meson.build               |  3 +++
>   6 files changed, 50 insertions(+)
>   create mode 100644 target/mips/tcg/micromips16.decode
>   create mode 100644 target/mips/tcg/micromips32.decode
>   create mode 100644 target/mips/tcg/micromips_translate.c
> 
> diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
> index d1aa811cfa1..2a079cb28d9 100644
> --- a/target/mips/tcg/translate.h
> +++ b/target/mips/tcg/translate.h
> @@ -222,6 +222,8 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
>   bool decode_64bit_enabled(DisasContext *ctx);
>   
>   /* decodetree generated */
> +bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
> +bool decode_isa_micromips32(DisasContext *ctx, uint32_t insn);
>   bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
>   bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
>   bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
> diff --git a/target/mips/tcg/micromips16.decode b/target/mips/tcg/micromips16.decode
> new file mode 100644
> index 00000000000..d341da16b04
> --- /dev/null
> +++ b/target/mips/tcg/micromips16.decode
> @@ -0,0 +1,11 @@
> +# microMIPS32 16-bit instruction set extensions
> +#
> +# Copyright (C) 2021  Philippe Mathieu-Daudé
> +#
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +#
> +# Reference: MIPS Architecture for Programmers, Volume II-B
> +#            microMIPS32 Instruction Set
> +#            (Document Number: MD00582)
> +#            microMIPS64 Instruction Set
> +#            (Document Number: MD00594)
> diff --git a/target/mips/tcg/micromips32.decode b/target/mips/tcg/micromips32.decode
> new file mode 100644
> index 00000000000..333ab0969ca
> --- /dev/null
> +++ b/target/mips/tcg/micromips32.decode
> @@ -0,0 +1,11 @@
> +# microMIPS32 32-bit instruction set extensions
> +#
> +# Copyright (C) 2021  Philippe Mathieu-Daudé
> +#
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +#
> +# Reference: MIPS Architecture for Programmers, Volume II-B
> +#            microMIPS32 Instruction Set
> +#            (Document Number: MD00582)
> +#            microMIPS64 Instruction Set
> +#            (Document Number: MD00594)
> diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
> new file mode 100644
> index 00000000000..49e90e7eca2
> --- /dev/null
> +++ b/target/mips/tcg/micromips_translate.c
> @@ -0,0 +1,14 @@
> +/*
> + * MIPS emulation for QEMU - microMIPS translation routines
> + *
> + * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "translate.h"
> +
> +/* Include the auto-generated decoders.  */
> +#include "decode-micromips16.c.inc"
> +#include "decode-micromips32.c.inc"
> diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
> index 26006f84df7..7a884222eed 100644
> --- a/target/mips/tcg/micromips_translate.c.inc
> +++ b/target/mips/tcg/micromips_translate.c.inc
> @@ -3018,6 +3018,15 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
>           }
>       }
>   
> +    if (decode_isa_micromips16(ctx, opcode)) {
> +        return 2;
> +    }
> +    opcode <<= 16;
> +    opcode |= translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
> +    if (decode_isa_micromips32(ctx, opcode)) {
> +        return 4;
> +    }


In the switch just above, you have determined 16-bit vs 32-bit, have you not? I think you 
should make use of that and keep these two cases separate.


r~

