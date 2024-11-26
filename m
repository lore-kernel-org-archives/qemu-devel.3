Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFAFD3B9B8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyF2-0001AT-W7; Tue, 26 Nov 2024 11:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyEv-00019t-B1
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:16:38 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyEs-0001eO-Vi
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:16:36 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-296994dd3bfso3363060fac.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732637793; x=1733242593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jUnZVHtD4Hg76AcYtT4C/WvTg3aqvDojtgQFOLhH7KM=;
 b=ShXdyMCjzIziOB6cCKm8LtX8oQpSoHxIKLJeYid97sK3v2IfaZgcJFewG+XAGDYx2V
 N0ayZYrqx6fk2nAToiLY1+cWPCf2xySeUSFrgEb9edtP6vN3DAG0c8OOU8j1xcMyTJiw
 yjVxRbO8RtQ5rOJ0LvApdwOlETlGrkpelke+WgWBXRdevwB0oYkhZTnis4KnsGXxebSK
 zSotn8qM0wMs3IZkdUubpEwzo5WYMO0ESQmPUBdVUXF5VXTjI2EMIic/24nIa8lBfE2A
 XVxqIoZrCOvyg2uap0DKc4oNrLwAflURpFmqfWRSSoLV3Vd4HYm+QUgSunsNDpm3Pou8
 XdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637793; x=1733242593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jUnZVHtD4Hg76AcYtT4C/WvTg3aqvDojtgQFOLhH7KM=;
 b=DqhlS+1spmgnzCGtmE0PqOVFAaD2hIS8XR6Y8A/6LHGZgykklkqBAlwP8nHXZMAMKH
 hOUi9I39gLw7AWXdmmrDcb/D+CyyjUW3bgGKD9dr+wJFav6TfSu2SptR5qrFyzzwej8p
 pi7YJ5ckY0qredEJVCY9IjCItrD+wHI987xaj+ERc/Yp2x529ZRuz8U2Dx/nna7gbbyl
 brA/oIhSEQyXNsBlWiB71CmCpMAr9QhDn1maI+GuP5feCCcoz0WiQj7QwfCbKkZnzpyf
 TOLrXXahls6VLlaX+PM+rvGBSpLA9Q+JuAnocKv0YxBdhPnUY1zu1x76krtvcAiFCWhL
 VkvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfPpfTUJ4gw9qhp+PZ8U0hLGTPOTjfzuSjbSCCwOtApMAGSBHQEbn59i7AdXNt7U3lU02XNZJ6+EWe@nongnu.org
X-Gm-Message-State: AOJu0Yw/sK4mAzUEG/lfIDK+g26XwqxkUtJfmrFsrVjGx6YxdE3yWgMI
 wH3TnyOLuN7I5qVb6rnRbx08Bz00JWtxXsc+fZYFf+0plqGdohrUNvz0Bt2hlR8=
X-Gm-Gg: ASbGncuF7IEt0bdkhcLbxcPAJWTcKL2GwY1fJAcDmVYBS4pb7smtmW7WyRUStzOjOTt
 5Sf/NWFeUp3ogJdxIuObn5VXS2azg8sCzfCddMQd8Uyo7lPS4uKIC91DsBy+y+mITi3im92I4uZ
 TjPmonYfRO4na59prhGGoeQWwnZyd0PccHhoQKJet/LXziQKTo7jOPOwkqVcuLGJFcpygzRHMHa
 7MFOlxk7Cbq/Ki/LeMM/Uu096Aip8V807golP9hls9CEKKN+jVZIZS5gSxP0gV6jQ==
X-Google-Smtp-Source: AGHT+IF5GqFpSWfTxUwDXMik3dWrxGxE3b7I5BIy9CFd8y74z1/bt0+3Vb+HLT1gG7f/cyIEKi8VLQ==
X-Received: by 2002:a05:6871:820a:b0:297:699:2ca8 with SMTP id
 586e51a60fabf-29720af123bmr14242626fac.1.1732637793446; 
 Tue, 26 Nov 2024 08:16:33 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f1fa5ac0d8sm720251eaf.20.2024.11.26.08.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:16:32 -0800 (PST)
Message-ID: <0ab3577a-87a6-4269-b888-4947d7f8de5b@linaro.org>
Date: Tue, 26 Nov 2024 10:16:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] target/mips: Introduce decode tree bindings for
 MIPS16e ASE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
> Introduce the MIPS16e decodetree configs for the 16-bit
> and 32-bit instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h             |  2 ++
>   target/mips/tcg/mips16e_16.decode       |  9 +++++++++
>   target/mips/tcg/mips16e_32.decode       |  9 +++++++++
>   target/mips/tcg/mips16e_translate.c     | 14 ++++++++++++++
>   target/mips/tcg/mips16e_translate.c.inc |  8 ++++++++
>   target/mips/tcg/meson.build             |  3 +++
>   6 files changed, 45 insertions(+)
>   create mode 100644 target/mips/tcg/mips16e_16.decode
>   create mode 100644 target/mips/tcg/mips16e_32.decode
>   create mode 100644 target/mips/tcg/mips16e_translate.c
> 
> diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
> index a65ab4a747c..d1aa811cfa1 100644
> --- a/target/mips/tcg/translate.h
> +++ b/target/mips/tcg/translate.h
> @@ -223,6 +223,8 @@ bool decode_64bit_enabled(DisasContext *ctx);
>   
>   /* decodetree generated */
>   bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
> +bool decode_ase_mips16e_16(DisasContext *ctx, uint16_t insn);
> +bool decode_ase_mips16e_32(DisasContext *ctx, uint32_t insn);
>   bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
>   bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
>   bool decode_ext_loongson(DisasContext *ctx, uint32_t insn);
> diff --git a/target/mips/tcg/mips16e_16.decode b/target/mips/tcg/mips16e_16.decode
> new file mode 100644
> index 00000000000..82586493f68
> --- /dev/null
> +++ b/target/mips/tcg/mips16e_16.decode
> @@ -0,0 +1,9 @@
> +# MIPS16e 16-bit instruction set extensions
> +#
> +# Copyright (C) 2021  Philippe Mathieu-Daudé
> +#
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +#
> +# Reference: MIPS Architecture for Programmers, Volume IV-a
> +#            The MIPS16e Application Specific Extension
> +#            (Document Number: MD00076)
> diff --git a/target/mips/tcg/mips16e_32.decode b/target/mips/tcg/mips16e_32.decode
> new file mode 100644
> index 00000000000..fc429049e18
> --- /dev/null
> +++ b/target/mips/tcg/mips16e_32.decode
> @@ -0,0 +1,9 @@
> +# MIPS16e 32-bit instruction set extensions
> +#
> +# Copyright (C) 2021  Philippe Mathieu-Daudé
> +#
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +#
> +# Reference: MIPS Architecture for Programmers, Volume IV-a
> +#            The MIPS16e Application Specific Extension
> +#            (Document Number: MD00076)
> diff --git a/target/mips/tcg/mips16e_translate.c b/target/mips/tcg/mips16e_translate.c
> new file mode 100644
> index 00000000000..6de9928b37e
> --- /dev/null
> +++ b/target/mips/tcg/mips16e_translate.c
> @@ -0,0 +1,14 @@
> +/*
> + * MIPS emulation for QEMU - MIPS16e translation routines
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
> +#include "decode-mips16e_16.c.inc"
> +#include "decode-mips16e_32.c.inc"
> diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
> index defef3ce559..a57ae4e95b1 100644
> --- a/target/mips/tcg/mips16e_translate.c.inc
> +++ b/target/mips/tcg/mips16e_translate.c.inc
> @@ -657,6 +657,14 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
>       int n_bytes;
>   
>       ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
> +
> +    if (decode_ase_mips16e_16(ctx, ctx->opcode)) {
> +        return 2;
> +    }
> +    if (decode_ase_mips16e_32(ctx, ctx->opcode)) {
> +        return 4;
> +    }

This is misplaced wrt loading 32-bits of opcode.  You have two options:

     opcode = lduw(...)
     if (extract32(opcode, 11, 5) == M16_OPC_EXTEND) {
         opcode <<= 16;
         opcode |= lduw(...);
         decode_ase_mips16e_32(...);
     } else {
         decode_ase_mips16e_16(...);
     }

Or, make use of the variable-length support in decodetree.  Given the trivial test above, 
the complexity and oddness of the variable-length stuff doesn't seem worth it.


r~

