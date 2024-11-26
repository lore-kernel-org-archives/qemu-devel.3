Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90747D3B98E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvUt-0008ND-I6; Tue, 26 Nov 2024 08:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvUm-0008Mg-GC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:20:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvUk-0004iy-Qy
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:20:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38245e072e8so5463880f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732627245; x=1733232045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dEHyBT7fNcPjFo7nEqMdEQ9kYOZb3iBk8z/fx9S3l0M=;
 b=cyJcLbo20I4YNByRXRtrrjh4rSES5xGtOUZhY4TS/gdYX6HND4S1v4QSjWDdNVV96U
 VlwRBqJ1T7VDz6tZ95qoizpHcLsAn8Z2jEzfcxq/g7su6zWi5r88EwViUb7zQeRvh+qh
 lDMdpdV9cFSj+YBio1iM53Muq6nRNJYQBX5gNUwanqp98p6CIwBC4DZix6jD8gkNzoWL
 SRCv9fa54j7Qx+DV6TQZzflL6oBwpaqgwVAuB/wVwKJjZYBbYGzO/12z1jDPoAQEch40
 WxnE2Srnjy7N8DAusbPQXnKzqJjNqHROEnQKoDp0/HGGm3rcCZnMAy+Jr/Ynlomm44CQ
 +BOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627245; x=1733232045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dEHyBT7fNcPjFo7nEqMdEQ9kYOZb3iBk8z/fx9S3l0M=;
 b=w5N8LZDB0E7IEjJEIFZd6cZ52N+1CRSlPy3TTay1NBL1+1q+Xho+T1xXsrjyGi7ytd
 mBH2hiedrsRE+8KFHxOjzm315hJgWhhhNumGxO63W/UcnOZo63n8jW+RMieuVHzxX0da
 3bMidoUzND75HABJhjDzYmcgwycwyF78X9LLtv/PUWniq54Njz1CunYrIwj3RFCtZWbO
 Va54fCxlUub2NjaJyEyGAE51/3utdhVrLybfoH1eb1cpJsXTP/0tM2/7M6GgqxCqIhP7
 fV7FUOixmJaBnTV4/oB1L7hUAD8u664M3PenWLsA7GOrIPWIprgHEn3N49DGCXr6ECiM
 m/Mg==
X-Gm-Message-State: AOJu0YzucJSILnjO/Sp9V8WoAE9Y82R97wetklc3o1V+iobAJcx8WUAT
 hMxGZ6FCs3PpvtlyG/+hjrLiOFlo/QPNFyw1H8cG5jCZNLWN7r1znf4fC0XO3QkLcwuJWeUNpqs
 5
X-Gm-Gg: ASbGnctD0zRGQV2BXcKWBceNmACNj2D/CFd7eR03N0N3jlpPkSSCTl4e+vEA9PpJUAl
 WCVK3TW9LqvIOrmDSUq+0yAshZfUYWtTyzjPoDsZLCYKV6h1r2rwwTRGoUg4owJhNOvouOKbHWx
 d49MVEK+BaKvPSR4/LENYcofMV38VmfAJ/KP5AtRJRGBdVfZczKIWjN2/L1/mgR2DE6coaA5XBr
 OrVSE+zP8xyQPTeQFPRJ1MmeUAWZVJOJxpTnDv+V5uHEmU69dspfNzXRvQYJlsFRg==
X-Google-Smtp-Source: AGHT+IEV/N4aqozMfSFlZdyYaGvftvHsW4UgILNevUi7ZEuH1drjRAZgKKBPJImtt1mwPqo1eXovwA==
X-Received: by 2002:a5d:47cc:0:b0:382:506b:f627 with SMTP id
 ffacd0b85a97d-38260bea7a0mr20202881f8f.57.1732627245007; 
 Tue, 26 Nov 2024 05:20:45 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349f9eca01sm72346435e9.29.2024.11.26.05.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:20:44 -0800 (PST)
Message-ID: <2be6cd2d-44c6-45ab-bfce-c5ae31dc63ab@linaro.org>
Date: Tue, 26 Nov 2024 14:20:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/mips: Introduce decode tree bindings for
 nanoMIPS ISA
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20241112172022.88348-1-philmd@linaro.org>
 <20241112172022.88348-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112172022.88348-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
> Introduce the nanoMIPS decodetree configs for the 16-bit
> and 32-bit instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h              |  2 ++
>   target/mips/tcg/nanomips16.decode        |  8 ++++++++
>   target/mips/tcg/nanomips32.decode        |  8 ++++++++
>   target/mips/tcg/nanomips_translate.c     | 14 ++++++++++++++
>   target/mips/tcg/nanomips_translate.c.inc |  7 +++++++
>   target/mips/tcg/meson.build              |  3 +++
>   6 files changed, 42 insertions(+)
>   create mode 100644 target/mips/tcg/nanomips16.decode
>   create mode 100644 target/mips/tcg/nanomips32.decode
>   create mode 100644 target/mips/tcg/nanomips_translate.c


> diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
> new file mode 100644
> index 0000000000..c148c13ed9
> --- /dev/null
> +++ b/target/mips/tcg/nanomips_translate.c
> @@ -0,0 +1,14 @@
> +/*
> + * MIPS emulation for QEMU - nanoMIPS translation routines
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
> +#include "decode-nanomips16.c.inc"
> +#include "decode-nanomips32.c.inc"
> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
> index 1e274143bb..e401b92bfd 100644
> --- a/target/mips/tcg/nanomips_translate.c.inc
> +++ b/target/mips/tcg/nanomips_translate.c.inc
> @@ -4482,6 +4482,13 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
>           return 2;
>       }
>   
> +    if (decode_isa_nanomips16(ctx, ctx->opcode)) {
> +        return 2;
> +    }
> +    if (decode_isa_nanomips32(ctx, ctx->opcode)) {

This call is incorrect, the caller previously called
translator_lduw() so ctx->opcode is incomplete.

> +        return 4;
> +    }

Discarding this series for now.

