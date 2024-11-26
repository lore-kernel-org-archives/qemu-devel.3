Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D1BD3B9BC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyV6-0008J6-4B; Tue, 26 Nov 2024 11:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyV0-0008I9-Uu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:33:15 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFyUy-0004ds-Ka
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:33:14 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2973b53ec02so2050777fac.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732638791; x=1733243591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4F8s6SrU56PruEe/KmY6saoDUrF89MJtM/KSfxOJbFE=;
 b=vbm+KSczyO1h0uF+Vbz/0nUTSfR1u+cemtLYMihGtfQTvEWOMi/fx5Peohbv8bNozi
 i6lwHsOLnhcM5SZIzFDlCKn45eOsef1AFFnftB1PpH6gxbm99NAGDkZyChcd8EgWbEdW
 i5XdFLfTrIptLxkyFEDp5L0Oc8gH7FNx0Sepi81vJM7SN+UGgPyWwuTX9AQzsrqcbwLN
 h9aaIiiNkVObPnOPFrbfA7xomyIkrHwYDZWzDYUWmCY6Irn6C8pfx7Js+3K7w/Vo11xs
 Yrc7Y46s8wmcd3oExJdXJ7//LYKbyDQIiPB8d/JngWrWD/WFg8rE9vOiqsB6/vmdZfIo
 /ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638791; x=1733243591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4F8s6SrU56PruEe/KmY6saoDUrF89MJtM/KSfxOJbFE=;
 b=kQ7uFkTebpf9WQ41TXzisvn5jz+O82lA7nLhQdE9OGhUmDeLaffTEWKjVC9UUG5jC4
 Dm0Udu9KglEktcEeXCm7JoX7C8EjKc6A9QYijR+NGEo7/RWHdAZPSisik5jTQ9ltLpsp
 qkSNs8LInDhwouRG+qVlH5y74pDqIVxyfx0wU6C4toY13UU6abZLdCWL5V70PDKaEjct
 PwUpavuXnB79CuOqIqOFwHBsZ65bCA2mK4rhAW7AEED4k3AYtzkOyo++19lE0y0FsorA
 nlEfNQhy9oEKUUIx3CmePlBz1pfm+A0mfsuZyERTHxiipoblJzKuI3xiEAMlE774cLD9
 gsZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1SsAYnLkFlmTe9shpS5gUu5Uaxn7j131mvTA+ksxoKZ4Lf/+yx7RI9e1SlRyxi0tMBuaY4u09KY+i@nongnu.org
X-Gm-Message-State: AOJu0Yzwhhj1rRTkGxiMnALnyHLRll+UYqJlJJkcvVw96CQuwskRgijT
 5mG1XvW6ULbVDzwdbtBaiPt9KDST0dEXWxJn+YhzSxalnMQ+y8wiuIuCfN63vdM=
X-Gm-Gg: ASbGncs5x4LpnUAGpgbSsckwrmDHUADLS0XFMkydngF+a7IqkBPEbuqTAtXqTyMpVXZ
 jvggTCrplIfCEk7NBSQRnNJ3pg+azti1C6asucopHuaCjjnvo2g9DFu1NzFtd3wtsPta6tF1Wpo
 i1XCgcEFv8A0BGkxKViu7uzqVSOzCUtrGgXD/NFwvE6sMpycuZeqsCU5Iq18Vq9RCVfrv10z/vU
 jV5yngZs/kVOa8mmI+HCKUo7RegHTb4tFSW54tlw6temtZfNY0Ghhz0Nrsyn0LYUw==
X-Google-Smtp-Source: AGHT+IEPd8aYpx5CBKRC0fHzyxiKY5wtHbYxQZjz3SNm4QWksyBxcCgJWwPkMtWwR5RQCkgay6rFCg==
X-Received: by 2002:a05:6870:a104:b0:289:2126:6826 with SMTP id
 586e51a60fabf-29720d9057dmr17777889fac.30.1732638790955; 
 Tue, 26 Nov 2024 08:33:10 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c03783309sm3057763a34.29.2024.11.26.08.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:33:10 -0800 (PST)
Message-ID: <f73364c0-88d3-40a5-a44e-5d7153f55029@linaro.org>
Date: Tue, 26 Nov 2024 10:33:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/16] target/mips: Introduce decode tree bindings for
 nanoMIPS ISA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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
> @@ -4480,6 +4480,22 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
>   
>       opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
>       ctx->opcode = opcode;
> +    if (decode_isa_nanomips16(ctx, opcode)) {
> +        return 2;
> +    }
> +
> +    opcode <<= 16;
> +    opcode |= translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
> +    if (decode_isa_nanomips32(ctx, opcode)) {
> +        return 4;
> +    }
> +
> +    opcode <<= 16;
> +    opcode |= translator_lduw(env, &ctx->base, ctx->base.pc_next + 4);
> +    if (decode_isa_nanomips48(ctx, opcode)) {
> +        return 6;
> +    }

Oof.  Trivial to determine 32 vs 48 bit (NM_P48I), but much harder for 16 vs 32 bit.

Maybe this *would* be easier with decodetree --varinsnwidth.


r~

