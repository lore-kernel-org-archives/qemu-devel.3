Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD0AE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 19:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdhD-00067T-Ch; Tue, 17 Dec 2024 14:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdhC-00067H-FV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 14:57:30 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdhA-0004S7-6e
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 14:57:30 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2161eb95317so53242025ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734465445; x=1735070245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NsaxI0J86uUyaFfCTx23TBPCgcHgYyckq6oKAIuogzg=;
 b=VF7s2fpZvrpTjX7PWltCASe5rDvCFW/pfiO7g0NCoqejqkOxKacksnh6BXQdoqL4hT
 jdD25z+kcwjwix3cayUTPGmsB9ltBL8Y6toa/1uO+1+fOV2ligVBRKeCX++IbwlLjAk+
 yLDqMqALqrUOPddJhYLvPvEWdo3/pXbf/m2LzzkJzP7nS6yCjDkehFiWPcPDTJQ+bAEz
 YRYNwLjR9Fv6rFOHt4py0o57jfSncekThfFuqHOKwI1zdbCTLfvinym7VxEAUs7lrhpV
 4qEEW62+jf2Oyul4xAPr/PAqyRluiRBDejuSNBIVnlfPlPM19JfCVNsdivLvWF0zUcyK
 8VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734465445; x=1735070245;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NsaxI0J86uUyaFfCTx23TBPCgcHgYyckq6oKAIuogzg=;
 b=vgeBoOGwdqWZc+D11jmBi8kx7hemAlaQgUN9mbztz+Ji7jjlBWQKnFVnPYv+UPvjAC
 1Hj8yChQRNVJGo6P0Xg1hodSU1nZUho2gpBkxlAziW2NOwhBu6KaBKPIFWhDGpkcODfs
 azFB/ZIQqHx28qsli37NBU4zXYZdJHFr0OiOz+TpUtjVyWyVjP0RUsi0+/A8Y0/kBLtL
 0EsZtqX1HV7c8X+KRbrw52I/Ai6mQdyT9F1cb+DRwIU0ae+DOA7tnTQpZOu1SGeCWJY1
 d3rrOfjrazPVwk9ZUYhft/P8JUkZpjWOXagjRKTieZv1u437SXnYNDHIFKQ4G8wp5V0w
 qTSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb048G5kpox/738ScIlxf0UjcZu21WmGVplH/AwSAs7Y+OySKw7DKUB8rl707QELi63b8eiu5uojtf@nongnu.org
X-Gm-Message-State: AOJu0Yy4VWqZfWNk4UP2QKiR6isF8hulgNhf1OFE36FMV5WAyTbksxaj
 fZSSznpw2hBbS7MSJ8RLcthh63WVNZycNtvYTQKmjy5bJ61lMU4tfOJUoRzxNXc=
X-Gm-Gg: ASbGncshx+WER1VR5BHgYDyqyHiZLLDPtH+BZn4g9ZV9MiIZKL9e+0HC1LfW0e3j+Fz
 JsUnZeQG9TnP3HqV8enJINu/Sc05IxlGyjCOn65YDyzxAIyjDpeps9kc72m7RjOQjBsVzdu/yEW
 i0ryjHtUqNGvSdR5CpmE5bkc1tO0bSJqs8NgeLxFtpfmrrmh6rivJIxG4RcXdOyHbW6bQg2haPs
 XdpRCyHCXMnVOQcKQRGRGQGOYWm+YCsluAv58df+iNmn3LitvEiAR4WqDLRq1KzoF/erg==
X-Google-Smtp-Source: AGHT+IFe4oCtkYhbvXWrdxX4A+EkJfqFGbgjmAlQzaQpa0eu5AVqD4BhT0v6ouesY6KdWwBkN92wtQ==
X-Received: by 2002:a17:902:f70b:b0:216:28c4:61c6 with SMTP id
 d9443c01a7336-218d720c060mr1381005ad.34.1734465444931; 
 Tue, 17 Dec 2024 11:57:24 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e63afcsm63120065ad.225.2024.12.17.11.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 11:57:24 -0800 (PST)
Message-ID: <f8502cf5-5745-4330-beaf-1d586bb95be8@linaro.org>
Date: Tue, 17 Dec 2024 11:57:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/46] tcg/optimize: Split out finish_bb, finish_ebb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
> Call them directly from the opcode switch statement in tcg_optimize,
> rather than in finish_folding based on opcode flags.  Adjust folding
> of conditional branches to match.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 47 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index e9ef16b3c6..20c918e83b 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -964,24 +964,25 @@ static void copy_propagate(OptContext *ctx, TCGOp *op,
>       }
>   }
>   
> +static void finish_bb(OptContext *ctx)
> +{
> +    /* We only optimize memory barriers across basic blocks. */
> +    ctx->prev_mb = NULL;
> +}
> +
> +static void finish_ebb(OptContext *ctx)
> +{
> +    /* We only optimize across extended basic blocks. */
> +    memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
> +    remove_mem_copy_all(ctx);
> +    finish_bb(ctx);
> +}
> +
>   static void finish_folding(OptContext *ctx, TCGOp *op)
>   {
>       const TCGOpDef *def = &tcg_op_defs[op->opc];
>       int i, nb_oargs;
>   
> -    /*
> -     * We only optimize extended basic blocks.  If the opcode ends a BB
> -     * and is not a conditional branch, reset all temp data.
> -     */
> -    if (def->flags & TCG_OPF_BB_END) {
> -        ctx->prev_mb = NULL;
> -        if (!(def->flags & TCG_OPF_COND_BRANCH)) {
> -            memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
> -            remove_mem_copy_all(ctx);
> -        }
> -        return;
> -    }
> -
>       nb_oargs = def->nb_oargs;
>       for (i = 0; i < nb_oargs; i++) {
>           TCGTemp *ts = arg_temp(op->args[i]);
> @@ -1351,8 +1352,11 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
>       if (i > 0) {
>           op->opc = INDEX_op_br;
>           op->args[0] = op->args[3];
> +        finish_ebb(ctx);
> +    } else {
> +        finish_bb(ctx);
>       }
> -    return false;
> +    return true;
>   }
>   
>   static bool fold_brcond2(OptContext *ctx, TCGOp *op)
> @@ -1443,9 +1447,12 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
>           }
>           op->opc = INDEX_op_br;
>           op->args[0] = label;
> -        break;
> +        finish_ebb(ctx);
> +        return true;
>       }
> -    return false;
> +
> +    finish_bb(ctx);
> +    return true;
>   }
>   
>   static bool fold_bswap(OptContext *ctx, TCGOp *op)
> @@ -3037,6 +3044,14 @@ void tcg_optimize(TCGContext *s)
>           CASE_OP_32_64_VEC(xor):
>               done = fold_xor(&ctx, op);
>               break;
> +        case INDEX_op_set_label:
> +        case INDEX_op_br:
> +        case INDEX_op_exit_tb:
> +        case INDEX_op_goto_tb:
> +        case INDEX_op_goto_ptr:
> +            finish_ebb(&ctx);
> +            done = true;
> +            break;
>           default:
>               break;
>           }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


