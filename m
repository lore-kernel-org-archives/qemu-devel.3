Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC13AC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwX6-0004Cg-5X; Mon, 17 Feb 2025 03:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwX5-0004CF-71
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:31:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwX3-0002eT-7a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:31:14 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f286b5281so1799250f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739781071; x=1740385871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9rVPQIjVIl71fFYF/w4h3xXVNt0tfvblOdPb3+I9xr0=;
 b=aCt9hkmqZWYVdZX6pjg1Io81dEPMMC7/hvK+7TJo94THcBcyUZP/1GiqEFhw/CcDaa
 Z8+Csz+07fTeiZUV1XXyZSbzTNoM2DnKiF27T4RUb27VvAc6GlbGadN5W7NSQd8jXLf8
 I7+aH+Fr/5nmFcGt1slEHaYDCjF9BfSNA4VvQqx6RKPZGKNxb1bU8aKkUZJ2angrN4zF
 XvEB5Eg/bdIlg3wjrMlrLJk19ofkg0QKJnQmnInQpJj0ggv5kNZjpNplHAJwHebthjGg
 aa7Jv/kLZ/uTM6ZD7DAnV2pKfbYkLjvtCUG82vyNHewGB7qE/OkRFlWYfBTdN9TXR3oo
 4llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739781071; x=1740385871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rVPQIjVIl71fFYF/w4h3xXVNt0tfvblOdPb3+I9xr0=;
 b=fjm6LVrNEMw4AmURYjoBlFVWVP+w1nlVQnaY38J0zyW5V3n1rMxYKLkJcwSTfBMIKW
 CcvPCLhDNilveTax5oeBbrd7QVTOcd5FsrpKveC62DW8jX9wP7RCDe4QvT7gDdfismZV
 7aaX0251c50nqP88s5sFAGY/t824Yo2lp7wfYJRdag9dHoTwzKgDhNyP/R7UprZImvMj
 DqjNz9v1aUfoN6qvcPuJpDY3o4dmAxF7etSc9wB98STU8lK9uNRajCw+2bhX1B0FmxGg
 JwPTfufS0/xyWm+nXOpsZGloZEuqkKRLFvXDG1o+uwFrmZ8V0rn1HIF6NIqbRUZcEGw7
 a5UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnQltUU/35HbCE4edimLR73tj6TkkQFU9MXPGHk81CVS/SPSAd0BT+4UlAUDLJTI2v63ag6f7Vd/cF@nongnu.org
X-Gm-Message-State: AOJu0YzrZPd3fKMYdivu5bgfp1IIbMP3cLbgSjjoASQbm1EGgQCz/aDy
 10/5JdB6N4sHO6i30EObrhbIfAfl8QhzVZ6GVUgj+yofuL00H01VdSjB5I+KDSBG8b2arujgB6w
 S
X-Gm-Gg: ASbGncvoHxrRVGyvG0ShpltW4mDMvnvCESkJCmCHhaJyuwC1SUWcfTXXONX5WN2LVcD
 DqItNFNnlogn6P2ZF4b5y3ZmJjnweTzAWwlF6KJmqbeC+MEbC6BpqeDzn1KlRgAs57H4wx3AwTw
 +nrVb11yLNEx66uhw5iwegkspt5iaKeqEy1a/0jhjahkWZKyBRjMYZkJyMAh1fOb3wB1HuylmoM
 L44/cJIhh3Gyl5Bp65ofN2J0F/UhObG0wBl2wR1EDGFYLqADmeaLh1Exd14wfmuADbY2ok6QUv4
 j1Uf1Y8u0QIB3GFZYDuKAbg69t2v0w==
X-Google-Smtp-Source: AGHT+IFh6N62xRX0/NRqrOVvw89bQhH6VhfaciIDiAZrCEW6hguahse/j68060puXt5fs1NX56/UYw==
X-Received: by 2002:a05:6000:1849:b0:38f:338e:3cf0 with SMTP id
 ffacd0b85a97d-38f33f34d3fmr7424165f8f.32.1739781071025; 
 Mon, 17 Feb 2025 00:31:11 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258cccd3sm11571362f8f.23.2025.02.17.00.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:31:10 -0800 (PST)
Message-ID: <2aef9536-5c42-434e-8150-2a78380dbf83@linaro.org>
Date: Mon, 17 Feb 2025 09:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 053/162] tcg: Merge INDEX_op_shl_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-54-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 10 +++++-----
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 13 ++++---------
>   docs/devel/tcg-ops.rst   |  4 ++--
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 17 insertions(+), 25 deletions(-)


> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 6f0887f808..bc882dbe31 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -434,10 +434,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>       case INDEX_op_xor_vec:
>           return x ^ y;
>   
> -    case INDEX_op_shl_i32:
> -        return (uint32_t)x << (y & 31);
> -
> -    case INDEX_op_shl_i64:
> +    case INDEX_op_shl:
> +        if (type == TCG_TYPE_I32) {
> +            return (uint32_t)x << (y & 31);
> +        }
>           return (uint64_t)x << (y & 63);

Or directly:

     return (tcg_target_ulong)x << (y % TCG_TARGET_REG_BITS);

