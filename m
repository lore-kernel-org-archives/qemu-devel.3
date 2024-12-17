Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62D1E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNePe-0002dI-15; Tue, 17 Dec 2024 15:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNePc-0002d7-PU
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:43:24 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNePa-0003xn-2b
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:43:24 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso3462912a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468200; x=1735073000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M1p8dMsGinnNXliU4Mw1yTJqoO542Zl3RMCe94EWBFI=;
 b=N/xsdk9zASUfh6A+X6n7K41SwrNYvqVKqoRB31iAHlmqHCiqnrIQpoHigIPmJ0p8pO
 Avzf6+HtdOuW6rvW30Ind0i4unjHz7eg2S0J0VvMfhJXGN/s7gTYU0AMO/ZAQGF82tiG
 q+N0n3ER0aIUUoBsBCQkEYDhAtPyqTIADRtTt+RmaikS5Je+TN5htLxGiN+0tlXTsyM5
 ZAkQC7a8OwJrFntMdcWVb0VogyhLWL+d5w3qtiZ1YSsREk26L69YvI8lr2FkBQmgKbE/
 C18FVOmkHLKf27Bl9v4E1j8+24I5P6guBR2N6kl9IdMVOaE1u8lsEQYmGtwdTjeoVqly
 IF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468200; x=1735073000;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M1p8dMsGinnNXliU4Mw1yTJqoO542Zl3RMCe94EWBFI=;
 b=Lp8gljAkIDHPDD6y7r29sq14bxT/A1UTLTJOOrxyQ0M+5m7UOuz7UXwImaA4kZDQVE
 E/cwXCaomobDCnb0wLr/swOcMdMDilPnS486k9r/h1WugprZwqeropgUFfGT6e5EEKTG
 E4imqkciPXMYtpg/19X0M9JixHsYgdaYP9Mlj/QSBibVB1OXm4qNkLD29QYsE2kyAoxk
 5Qw+a20ljs3cZsLznTRNE8zqv1fatD6rTZWS/+wuTQ44C7GThoPFYVgUrcGUBXsnA+Bn
 9oJi2okn9/qyxgXGwn6QINjzs4BJxkq3xVTG3J2s3wUMEOL160lXy+6oKUE9CRM2egP+
 wGCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAoknsmBk3GQ9afuGyNIuqV64oYq3Rbig8JzJLfNPoHJ8Cignf+uIgS87PHCgBwNmCPjh3Gg9Bfk6w@nongnu.org
X-Gm-Message-State: AOJu0YyCJ91yckWJGFaQhN9KvsVRmqsdHuNqgWAptvMP3ajy0qPponFt
 YrrRNJwV+iyn7JgYV1nls3RwAP6ISrZMF8w9cSmW/71nx6Id+c3CawZbYseZBU4=
X-Gm-Gg: ASbGncsxa3QK/5AP9opkSb7HEPGNlt4aFUTYx+G+hheaFPHO3fATwJ6HkoLhOVowkXI
 Xh00hBEvQ/fvqFrEy5AMHmPhhPyWyK7OXZKnqTDkckdnHUu7lG6el9hmLlUqadP9eVp9ibzBsPt
 IlfHumHVWD1OKp4ClpFUIvbZy/SLmt/YAosVpYoecY+3mneU6E3TuFkyon0efPJ/fxFn3tuEw4Q
 qcTdjF8EBPJkymM7sFHbaBtsJ6ljK3WBlIGkngStURI/NzOXcDqZ63qQM13nD0qVruBpA==
X-Google-Smtp-Source: AGHT+IEz5waPkEAiHz5wauXJXwofxU95GTKGAZnH+aIIKab5TKOVwwHZA24liMqVvOa753TfnTxMbg==
X-Received: by 2002:a17:90b:544e:b0:2ee:c6c8:d8a2 with SMTP id
 98e67ed59e1d1-2f2e91f0db3mr453409a91.14.1734468200377; 
 Tue, 17 Dec 2024 12:43:20 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d90bbdsm10445759a91.1.2024.12.17.12.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:43:19 -0800 (PST)
Message-ID: <c7e56e68-ba69-4a00-a022-6c32f5ff8477@linaro.org>
Date: Tue, 17 Dec 2024 12:43:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/46] tcg/optimize: Use fold_masks_zs in fold_shift
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-38-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 551f96dfaa..bec5a07288 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2530,12 +2530,12 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
>       if (arg_is_const(op->args[2])) {
>           int sh = arg_info(op->args[2])->val;
>   
> -        ctx->z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
> +        z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
>   
>           s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
> -        ctx->s_mask = smask_from_smask(s_mask);
> +        s_mask = smask_from_smask(s_mask);
>   
> -        return fold_masks(ctx, op);
> +        return fold_masks_zs(ctx, op, z_mask, s_mask);
>       }
>   
>       switch (op->opc) {
> @@ -2544,23 +2544,22 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
>            * Arithmetic right shift will not reduce the number of
>            * input sign repetitions.
>            */
> -        ctx->s_mask = s_mask;
> -        break;
> +        return fold_masks_zs(ctx, op, -1, s_mask);
>       CASE_OP_32_64(shr):
>           /*
>            * If the sign bit is known zero, then logical right shift
> -         * will not reduced the number of input sign repetitions.
> +         * will not reduce the number of input sign repetitions.
>            */
>           sign = (s_mask & -s_mask) >> 1;
>           if (sign && !(z_mask & sign)) {
> -            ctx->s_mask = s_mask;
> +            return fold_masks_zs(ctx, op, -1, s_mask);
>           }
>           break;
>       default:
>           break;
>       }
>   
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


