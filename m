Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0AFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdoR-0000bk-6x; Tue, 17 Dec 2024 15:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdoG-0000ZX-Pu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:04:50 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdoC-0005q8-7E
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:04:48 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216395e151bso467975ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734465883; x=1735070683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=646AgBz/JGsNgOfeywFbDhzliewiDpkeKh7zQ4SzUgM=;
 b=PoriCOpbTGeuIpP75sZc/dc0GqCcvdLdzbeWvNYm7p2Ew9Kb6+2JelAaRqF+6Do4/n
 Kj7iqn1r4zDR95mWVVKgjf1dR050l3C+Fkf+5Vd92XXg8cFvVxohQncg+Q3Cs+tyDnHV
 cGDWW4f3xcTGTRBCR3y4SmHB8aROkGybh+Y8/3RuFgLaoXAUjeCZ+m42ZxPX1DbWn+et
 c/zsfqhx6AP4GEuJWl83ATwGq6V4Eha72tlnNFouUkWiQsK5TcosZc20QD6lsb3yQZ68
 WwxHcwsR5SXFS+bFNOLvMyD8LpVdKThhkdCubXhdDLr42C+Mu1any9kpW8CRz/7jQSB3
 2AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734465883; x=1735070683;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=646AgBz/JGsNgOfeywFbDhzliewiDpkeKh7zQ4SzUgM=;
 b=Tv+DRPUYMIswktf6tUXLLW9JfQPKttLT6TX9OEOlARaN/YNg0hkVpf05JodChktL4B
 LX37s+OYyqFP9b+kGjflZd/J93AimD5qTgY78TyOr6X0NZbMhjFaN+I1xN3xHI0v+FyL
 5w8FNZnfF/AIqa1MAMwSnwJOYipVa9b8ntHd/tZT1xkOK7+aexoFMwEmUyl4k7AC5urV
 +cIqA2Z/mDPpuudva56fLs4jBPx4ADTYQ1yzZpCoLH9Tupbjrmf6zpyT09b7oT54LZ1X
 EZ9QRRQQHp3nClR/7txKbYAqy2KPt0BUlhIOMTdJ9Rute3fkNFS9K2+AWWVyZCzQTzNE
 AyZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwjkTFjFAvSJBIQTDhnqmv8F+FpuGIAj7ecCuXFRql+a1i5pje6vsOln1FfdPuDrEaj8MokH4VTF9D@nongnu.org
X-Gm-Message-State: AOJu0YyU7b3KFeYtDivgLSq3mtzMmq4upBMQPZRcWXeN/C81Y8shbBRs
 6FO3ML968yKkIu+2FuNrsi0GZ+XONXETxpbDNLhkKCraZIEEZUI1gAS3t12Jupk=
X-Gm-Gg: ASbGncuQ+Ksh4KI3jKRHnfd3SlSCA2GFvgqruOlpX+K5ibKN+6dM1oft9QdIo/Wz7Nj
 QlF19jiS/ggiSdDUun/DBS7tEP72nHLqrQm5Cnf7ZIz2N5KJqdDERqmghxEDQdqHArg3cFSIHBr
 C+nlI78Gf8lU2pZM2vlOZ4P/22K/avDQ2+ZiLP+CU922Z6N+VQJOVtFdEY6V4By2lLNsmFqg4fu
 vo7yKYE+3WpCAdkvcnUol6szk3aKCxdt6bj+q70FzobNUBpzDL00uTBxNriuyIfJR3fXA==
X-Google-Smtp-Source: AGHT+IHEiK+OOaWI2ILaLab/F/EHBE7+TFtMQ7DkF1vE4M4as9+wzSNcCmFHjyQNC5OSs8NUYA+thg==
X-Received: by 2002:a17:902:c402:b0:215:7e49:8202 with SMTP id
 d9443c01a7336-218d73b30f7mr1483225ad.13.1734465882822; 
 Tue, 17 Dec 2024 12:04:42 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db5e26sm63446725ad.51.2024.12.17.12.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:04:42 -0800 (PST)
Message-ID: <8caa6129-30c4-4f42-9946-b0bfd1c4d6a5@linaro.org>
Date: Tue, 17 Dec 2024 12:04:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/46] tcg/optimize: Use finish_folding in fold_add,
 fold_add_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 6644d24da6..3f2f351bae 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -978,7 +978,7 @@ static void finish_ebb(OptContext *ctx)
>       finish_bb(ctx);
>   }
>   
> -static void finish_folding(OptContext *ctx, TCGOp *op)
> +static bool finish_folding(OptContext *ctx, TCGOp *op)
>   {
>       const TCGOpDef *def = &tcg_op_defs[op->opc];
>       int i, nb_oargs;
> @@ -996,6 +996,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
>               ts_info(ts)->s_mask = ctx->s_mask;
>           }
>       }
> +    return true;
>   }
>   
>   /*
> @@ -1214,7 +1215,7 @@ static bool fold_add(OptContext *ctx, TCGOp *op)
>           fold_xi_to_x(ctx, op, 0)) {
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   /* We cannot as yet do_constant_folding with vectors. */
> @@ -1224,7 +1225,7 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
>           fold_xi_to_x(ctx, op, 0)) {
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


