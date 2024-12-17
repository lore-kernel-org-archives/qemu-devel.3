Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357B5E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeIN-00045h-NL; Tue, 17 Dec 2024 15:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeIM-00045Y-Ny
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:35:54 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeIJ-0002wn-Qn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:35:54 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216395e151bso643395ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467750; x=1735072550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bC0Kmeutt2tccu6LvN4/Hr2DPkEJRoSEkIPjB8PcLaU=;
 b=P04+sEH0vQYaP+VrMDuSegvbYY1WNmAonMQ3aY+PEvomrdAjAHXULQYXDuMhB3nXI9
 DyAXN7NiOiI8Icu6dxGiyYrrRaBv9KK1bBu7enlMZSkQCGzZ5Pn3mrrXicLBdWD5BLGo
 MWTjPi4dJQvL3bu5Qm61QPgfyOLH+RvFj7sijebXUA6Jw6v9+Vu/BnUgyK3f0KKozMIE
 rryuIDB1bCz/WjJu+EMElMgaiqzzgPby1joxho5J1R4Ta3cMDKcY/SOVZ8Nu/UZS/+rR
 OGlhfFSrXZ0w6R8cooZ93A5z09XLH+cQkSWxeDnISbyMCWnbbhwXDKzhQPx+C52WpA0Y
 Sleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467750; x=1735072550;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bC0Kmeutt2tccu6LvN4/Hr2DPkEJRoSEkIPjB8PcLaU=;
 b=USPeOx+1+eC3HZ30wez++jG8Y2D/uzlBCqyFoFgQJyT75wvYOMIzn5VuE4rnLNls7g
 wlv2OFoOxsXUXm58L6Bbf/16QOzvyHV1Vjji2AqMoLVcnbX4S6pj6vAyNgSU5Iboj1q8
 R1i9c6NkpvP1TZt8ypXCxr7w3Av7FxmQGr5/X8L3amzB64H7fKi3sNBOnttl+E7CVpyt
 UVoYEPjlh7UA8CMLkKeRSfqtEqDwuJvAfZvWdKN7AOB967zzYFFZ4HZ8ezAYrI0319V0
 nqjJgY96CZSGkS2AybL17wS2rC0d8LoVoOcr8FzkKg0+c79Av8PGzXGCW+42Dh16np1j
 KnMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvsXSBstGdjzcigbVSWrx2DGjY/HtwWTEDLRSmE7z+gQOAOo8W9xRzxcxwYrnWk6r9DhdO3D5XQY1/@nongnu.org
X-Gm-Message-State: AOJu0YzHT+wz7eomBy79sS1+O+spCNeaniz2MrZlzJOCfgdD5Kwy/kCQ
 Zwu3Dudtr2M/eKhMgP4sClJQ/eXzHhvoiEzWeNAHhjqKflKX5WKV6vwT4V77inM=
X-Gm-Gg: ASbGnctCsfWIe2QqDNrziznJ315ar0x+SUXC6fO7No/vmrB3tTxXgmXo54vY/qKGzDj
 ewF17h87xFj9TtBmrf1jEXg2x0mmNXDj2P0zYVHdmamQcEtKmCPveenuu+M5C4mqTpgjNkv+ttH
 UkOlOpdhAOov9vfQGJaPbOAghLKBRfE3hj2DfQA7lTIMFoQMVBjF6VmMC/K/LFq6XSwJ2IUi4c3
 ODp/vjXItrb7i4alPIz0Nl4MNP3kkebuC32bNwbRkfGtLzW1LrpoYlQnTu5LKiYibOU/A==
X-Google-Smtp-Source: AGHT+IG3JubFZ5hXtdmVqf3aIV2jXk55I/5RzZej1g0gOpP0JAQcOBVT7DIhxi/myKj7hfHl0mNnhA==
X-Received: by 2002:a17:903:2344:b0:215:ae61:27ca with SMTP id
 d9443c01a7336-218d7553b07mr2724725ad.26.1734467749953; 
 Tue, 17 Dec 2024 12:35:49 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcc463sm63620805ad.79.2024.12.17.12.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:35:49 -0800 (PST)
Message-ID: <26ad88d4-7614-4ea0-bc6d-7b7df69bf38d@linaro.org>
Date: Tue, 17 Dec 2024 12:35:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/46] tcg/optimize: Use fold_masks_zs in fold_qemu_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-28-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
> Be careful not to call fold_masks_zs when the memory operation
> is wide enough to require multiple outputs, so split into two
> functions: fold_qemu_ld_1reg and fold_qemu_ld_2reg.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 76ad02d73b..6f41ef5adb 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2092,24 +2092,33 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
>       return fold_masks_zs(ctx, op, -1, s_mask);
>   }
>   
> -static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
> +static bool fold_qemu_ld_1reg(OptContext *ctx, TCGOp *op)
>   {
>       const TCGOpDef *def = &tcg_op_defs[op->opc];
>       MemOpIdx oi = op->args[def->nb_oargs + def->nb_iargs];
>       MemOp mop = get_memop(oi);
>       int width = 8 * memop_size(mop);
> +    uint64_t z_mask = -1, s_mask = 0;
>   
>       if (width < 64) {
> -        ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
> +        s_mask = MAKE_64BIT_MASK(width, 64 - width);
>           if (!(mop & MO_SIGN)) {
> -            ctx->z_mask = MAKE_64BIT_MASK(0, width);
> -            ctx->s_mask <<= 1;
> +            z_mask = MAKE_64BIT_MASK(0, width);
> +            s_mask <<= 1;
>           }
>       }
>   
>       /* Opcodes that touch guest memory stop the mb optimization.  */
>       ctx->prev_mb = NULL;
> -    return false;
> +
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
> +}
> +
> +static bool fold_qemu_ld_2reg(OptContext *ctx, TCGOp *op)
> +{
> +    /* Opcodes that touch guest memory stop the mb optimization.  */
> +    ctx->prev_mb = NULL;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
> @@ -3001,11 +3010,18 @@ void tcg_optimize(TCGContext *s)
>               break;
>           case INDEX_op_qemu_ld_a32_i32:
>           case INDEX_op_qemu_ld_a64_i32:
> +            done = fold_qemu_ld_1reg(&ctx, op);
> +            break;
>           case INDEX_op_qemu_ld_a32_i64:
>           case INDEX_op_qemu_ld_a64_i64:
> +            if (TCG_TARGET_REG_BITS == 64) {
> +                done = fold_qemu_ld_1reg(&ctx, op);
> +                break;
> +            }
> +            QEMU_FALLTHROUGH;
>           case INDEX_op_qemu_ld_a32_i128:
>           case INDEX_op_qemu_ld_a64_i128:
> -            done = fold_qemu_ld(&ctx, op);
> +            done = fold_qemu_ld_2reg(&ctx, op);
>               break;
>           case INDEX_op_qemu_st8_a32_i32:
>           case INDEX_op_qemu_st8_a64_i32:

Couldn't we handle this case in fold_masks instead (at least the 64 bits 
store on 32 bits guest case)?

