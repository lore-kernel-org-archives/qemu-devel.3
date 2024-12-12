Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C35E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlxi-00025w-NC; Thu, 12 Dec 2024 11:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLlxh-00025f-Jw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:22:49 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLlxf-0007DE-RE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:22:49 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb87127854so225134b6e.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734020564; x=1734625364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qW/6PBIXIPVPDm//dS49icD/ZllJH5gVfEI9MD/+feA=;
 b=Q+UMawHiQ+q81G0xA5+Ymfgha8cXRlkvCmvHz++M6Oic70GvdWBv4sdqhix+NdQdPa
 2WhP32k4+QJyma0Z24aK4WD7g08VgTpz/Wfvj9yG+crRij8Fny5nWw9HZ72pnBK0y+6k
 gkV9gaRUWrU8jdSGmsQFt7gfn3F4srU5FvHqLEpISrJuOXx5NvE7WVpjkjBOgCY0B+sk
 x7YJUyUayxl/en/5NOI9P0aFX0wztyZVjxj3pbjerS3utRJbiE/NoWctLZvG4rKJBV/s
 P22KnFK+jl6KbHMixm0U/MKJM/cR3GyfKBRNheBdrqkDrN2y+ld74Yj04iJ9biPZugtw
 Fp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734020564; x=1734625364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qW/6PBIXIPVPDm//dS49icD/ZllJH5gVfEI9MD/+feA=;
 b=pfG2aMxpaRtDGCwn2jAK4gDkpspHByZZdEbOMmUF+zuuRdYfyPhd7XPg21pTRgaPMS
 TXsxKUZqBXn3WyVe58F2Nw1POaEidvssaL9eNt930zsOnAlTj+fm62kCcIq3j+absIx5
 TK7GG4hlQQdjNL1kykH2demAvFYss3PV2hJYOp4y9jLepHN8D8jXNd77LRXE1kuMwzlt
 XkkfhHW0F2LFp08h/SmoUnwbaz2oUKEzIUTbkY0xdq7uY2IpM9+yuRMH/lNqjamtN7uI
 stqseuLQ/z1qK1eXEPJhKszce6jCOktVkFodLg+PWY+ZFo6GI0YBLNWHYtFS6kHhsW0U
 z6zA==
X-Gm-Message-State: AOJu0Yzv86z8nd8737idd+fMR3BuYApPkT1nnz9wUplOelYWG1VS0QhR
 se3gabwL+aa6kOU+kpvUGWZ0tF0cBYC916ZTSXs1hcVW2o2JsbYq8CjFiRWpEaNkUnvzt6c4aC/
 ImKhWvJG7
X-Gm-Gg: ASbGncteds3Vo7daNbXV2Z63oWBM92O83lFP/rLEZ4qsoryPe1kzYsFDe9jbAS9wJhg
 a3R3IRHKFklVn5Ir+xtyicOojVls6u7Fls2hdFpmBlt5s6DYSRluk9o14CnpRalbqhD6YbxEEh8
 iJSpFvxh6bWqRv/09tNUnYGExkzdzZrxjcXqKeKubdQN5055X8AnFfe+eO/V2G2VJ4VyxV/qY/3
 ++DATyZD6jfpS/aiPrd/wzc2yAYIsBtqHJgPLygmNj+KbiNi6d+bziNrc4eKFQsIdKQ8Y/HNw==
X-Google-Smtp-Source: AGHT+IGvoMQxCHQkhv7iNBnCZCLoeVauLWkxfrqbIK65ZE8EQicRKcoLKB9E+8jAmWEV++2bNhUz4Q==
X-Received: by 2002:a05:6808:bc7:b0:3eb:3894:42c8 with SMTP id
 5614622812f47-3eb85daeea3mr4465489b6e.42.1734020564162; 
 Thu, 12 Dec 2024 08:22:44 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f3183b3030sm294764eaf.43.2024.12.12.08.22.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 08:22:43 -0800 (PST)
Message-ID: <88317178-eb91-4a8e-a3ac-3f82c899ea63@linaro.org>
Date: Thu, 12 Dec 2024 10:22:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/11] target/ppc: implement address swizzle for
 gen_conditional_store()
To: qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-11-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> The gen_conditional_store() function uses tcg_gen_atomic_cmpxchg_tl() within its
> implementation. Update gen_conditional_store() so that it implements the address
> swizzle if required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index fc44e3293a..e8ae96cd46 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3345,9 +3345,18 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
>       tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
>       tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), lfail);
>   
> -    tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
> -                              cpu_gpr[rs], ctx->mem_idx,
> -                              DEF_MEMOP(memop) | MO_ALIGN);
> +    if (!need_addrswizzle_le(ctx)) {
> +        tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
> +                                  cpu_gpr[rs], ctx->mem_idx,
> +                                  DEF_MEMOP(memop) | MO_ALIGN);
> +    } else {
> +        TCGv ta = tcg_temp_new();
> +
> +        gen_addr_swizzle_le(ta, cpu_reserve, memop);
> +        tcg_gen_atomic_cmpxchg_tl(t0, ta, cpu_reserve_val,
> +                                  cpu_gpr[rs], ctx->mem_idx,
> +                                  DEF_MEMOP(memop) | MO_ALIGN);
> +    }
>       tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
>       tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
>       tcg_gen_or_tl(cr0, cr0, t0);

With

   if (need) {
      addr = swizzle
   }
   tcg_gen_atomic...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

