Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C10E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdkG-0007NZ-7i; Tue, 17 Dec 2024 15:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdkC-0007NJ-4K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:00:36 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdk9-00057V-Ce
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:00:35 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so5004049b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734465630; x=1735070430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfEJ1Sr3gnxbkZq2JmXV3AdL5O9GnnYZrd2cGg3+Nug=;
 b=yfMAj55fWGtxw1AzhSFgMwNP/VWd7lqZlpU3DlPveyJtf3HkIswOFmiYGCbCfS/6Om
 QlgvkHUEctB6QkqrWqmC7u6RP7SNMYohaGdOrO/Hv2ajUf/mT/AfxijAo3ZN7KgY0u4W
 HehFwNeoxccl470GyLkaSYFi2xc2XDY4lWrggVzC/3Qaw5nXkLd2rJPM/iCy/Xkup0iM
 v/TkCBh07G+Py2Psa419FMvX+RrPcvXM4bXJvFMtoSAI2XxgFV408eMmTyIvETq0Z57Y
 4GpJ0+/En2AFkmkgpAHhvhEcpoV1LR+1DM/2sKJzbxoPyJJvIv0SVBZ3SDpW+jL0thu1
 uOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734465630; x=1735070430;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfEJ1Sr3gnxbkZq2JmXV3AdL5O9GnnYZrd2cGg3+Nug=;
 b=u1h/6hP5M62kaQuE5vZlORkh9+gUy2sk7+yqhKaI7C68CVxKtfTeO5L/seyl4FSY/W
 +6OjoIVY2oQ9z3CUEMwyqPe0UIQPPWtj09nv8nSuPbXbRnSoIvuZTU+6lw2PgsxOLyP3
 TK+mIEIjG+ygk+RisM5vY2my9vUwdxMAyD/nT368mVoHrm3Ct3zRwh7/AkA7/73ph+tC
 vOXa2rCfwF3DvzOS8bwFtQwTLKeMOZp/4sYJTdWhEb0yXUwivXB+RbwwDY8GItJEdyxO
 M2P0DnQgfejqzyoO+UFz5UaqnEOewXxOOjqrOwLibyEYKGb4AWdxuDWte7v5JtHYernz
 B5aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwqL97BJccnXUSli7JzeNrOyJw8K0JE0iSFc/rhFIYGlQMYhPuk70ejC69GOulWLGjtjL/G4syT7Hk@nongnu.org
X-Gm-Message-State: AOJu0Yxx+MPtOwxm7rcv0deMhBxogvk04PFXFx1CW39FFbKsbs21QIE4
 hviVBKh3hwvdkSIaRgS4u4nBmW0gxkInOGiY/yoGBriZPlGB7XCbwUe8pr1wIoU=
X-Gm-Gg: ASbGncsuKtJHCx5Jy4PXKtTfp1kNqKSgzhXpFhvi4tnBLdFBOX+oHzJaTholn00Qjna
 44nwErc9m1Y8urbc6L/mk3CzZ5C8u0sts0eSav4Nat2gtjleIO3b8YhlrGxAMyxoL9w/dAS/Pw9
 2fhsqlC3MBW7Nyt/yZwtc4AcFyPB/O2t7G37dusGEMIxh+RkOZ4nCb61YjnFl324NYyhZ+rcmXC
 WnaoH/3lyqjAEuVZ54L1cwqYTTL10wETFyUYvb8GuMgoC2Q7kSWjt/XuqlDEYSNIiLs7g==
X-Google-Smtp-Source: AGHT+IEa6RhpEwQYBH+0j/eAChW36NMyz5NUEyGXh1zgoAZlzL0x/4kFJs0Yn8RnOwdeoRFrdZx7Fw==
X-Received: by 2002:a05:6a20:12cb:b0:1db:ed8a:a607 with SMTP id
 adf61e73a8af0-1e5b480fd1bmr467760637.11.1734465629852; 
 Tue, 17 Dec 2024 12:00:29 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5a90832sm6272888a12.11.2024.12.17.12.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:00:29 -0800 (PST)
Message-ID: <21c2fcb6-254f-43c6-8f8a-260af69cecdf@linaro.org>
Date: Tue, 17 Dec 2024 12:00:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/46] tcg/optimize: Copy mask writeback to fold_masks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
> Use of fold_masks should be restricted to those opcodes that
> can reliably make use of it -- those with a single output,
> and from higher-level folders that set up the masks.
> Prepare for conversion of each folder in turn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 20c918e83b..1a9e3258e3 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1050,6 +1050,11 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
>       uint64_t a_mask = ctx->a_mask;
>       uint64_t z_mask = ctx->z_mask;
>       uint64_t s_mask = ctx->s_mask;
> +    const TCGOpDef *def = &tcg_op_defs[op->opc];
> +    TCGTemp *ts;
> +
> +    /* Only single-output opcodes are supported here. */
> +    tcg_debug_assert(def->nb_oargs == 1);
>   
>       /*
>        * 32-bit ops generate 32-bit results, which for the purpose of
> @@ -1062,8 +1067,6 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
>           a_mask = (int32_t)a_mask;
>           z_mask = (int32_t)z_mask;
>           s_mask |= MAKE_64BIT_MASK(32, 32);
> -        ctx->z_mask = z_mask;
> -        ctx->s_mask = s_mask;
>       }
>   
>       if (z_mask == 0) {
> @@ -1072,7 +1075,12 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
>       if (a_mask == 0) {
>           return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
>       }
> -    return false;
> +
> +    ts = arg_temp(op->args[0]);
> +    reset_ts(ctx, ts);
> +    ts_info(ts)->z_mask = z_mask;
> +    ts_info(ts)->s_mask = s_mask;
> +    return true;
>   }
>   
>   /*

Maybe it would be worth to add a comment stating that a_mask was not 
modified, but only clipped to a 32 bit value.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


