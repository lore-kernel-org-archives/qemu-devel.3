Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F6AC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 23:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUDUc-0001mv-92; Tue, 24 Jun 2025 19:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUDUa-0001mh-0Q
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 19:55:56 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUDUY-0003gK-7g
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 19:55:55 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b2fca9dc5f8so1079810a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 16:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750809352; x=1751414152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ADF46uwDpYph2Bg7aGN0uA3rIBrA1UNgVxypr8EYUTg=;
 b=EcVudysLtWX3aelZZhbngdwVGhi/gGKxEJqlul28Df7kYq+agSnqydW+Oeydjv1KYg
 vf0/Prz2SwFfpJ0B8ZT65xcDLTAqv0dtWnsqpORRpNAU4W8fvlRhOfPwau/6JeBsoYCR
 Pt0wogg6lYLQAK69A1X+17A1IWwUBPoduuvGLEJshARQ7ott3lDOG9QLO8rqrWFen8Vw
 SeWCjkFU5PjrWs80IT+hcaEcqbplENTDJ/B50cVy6Zm91DkRxrbe/d7Fq/NalRFQCSeg
 MznvkKXw2/ImxcSj6Z2rJmGMS+hEB7F/nlY1bpuTs3gsKa6sMjZCwhQcF7g8tB9EbRB0
 b4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750809352; x=1751414152;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ADF46uwDpYph2Bg7aGN0uA3rIBrA1UNgVxypr8EYUTg=;
 b=PFHtmk0qgfuubcbpRAhAYwlhN92xCU09bJyULzW4y/SijBdgePS2crU5G7Ttj09Ebw
 okols72wYo5nBuAZoVXOCfVjP98ylZYpT2z94dRjtHsgwEU8MbvMjQ0WKB7ipT8w9LLf
 du4LGMbM80gHmsQ96SrJDac7/juGvESbALFfVPMz4Ymhfok+YNdlLj9q648X8n1MeoM8
 HWqHTmwR+Qq3rNQd67YQBW/+90IEadNkN63s6jQj3TnUi2yyU55L9LglKGWUU9GR0COj
 fkZ+sxNecFoE9hwTbakRcsiKPtJ+58YxILTx5Z/O+CmiGnRyoGL+ravOcI/TQXXmBYRJ
 474Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtPIEK05Ba4+kHfeLFlbpiMA6kWJR5m3DVVjO0RnF1pVkfNDpxymBKw7pv2mJ1DgCTgDWIuaGg2nmE@nongnu.org
X-Gm-Message-State: AOJu0YyUyAHZ7QKUbYfvE6wT9f1L0gxQGGU4iw/nbzFfQKwYiphZcK8y
 ux84x13EqqgfZvTnyi6fWQsxzSUHmUQ2cJbCW3iVtC1myyqw/OJxQTHGK/3szcF785M=
X-Gm-Gg: ASbGncuoV2zLoEmadA3Ikh/XOq8++bRFnoLH2BGsN4N1aeInx26a/Jm57DIJUt08I3a
 +Nt2AafgmeVa6y+2XKSVLmhKqEePrtXHrpHjq3o9W3ioiYAdIpFUnuop6BvxgOTXCZsh6yVfbxC
 6pmqqaI57z8tp5Jw4hqFF5ALz5QmxBUSRVs/NC5LJrbtm3/UaeJFW+mzsInKmRxoicP8vD5aprB
 3dIuO3iWRpxaeNVToFF/hi/Sa3hiYlZG+gNbplKmRVcK2v8vbFXECjboF2i8Lxa/b17cCO1IXyB
 jZEFWU0yS3PNBoyYXEi6iuKpFFLeAcBZHLNXxBxcT55Jhpb+/j/7Ay8Tg5Uf4Uv0DettolSDxFU
 =
X-Google-Smtp-Source: AGHT+IE1gH8rw8Vx0qNFqqBXkbxlxmnex0qdM2GBW7uLuHlglGjgkBWoJx59MNbwueG+/RUnF8cV/A==
X-Received: by 2002:a17:90a:fa0c:b0:315:9cae:bd8 with SMTP id
 98e67ed59e1d1-315f26b3874mr827402a91.23.1750809352518; 
 Tue, 24 Jun 2025 16:55:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53c295csm212544a91.27.2025.06.24.16.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 16:55:52 -0700 (PDT)
Message-ID: <46ee1961-9cd1-4024-b148-57cd3d5a9123@linaro.org>
Date: Tue, 24 Jun 2025 16:55:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_eqv
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250505202751.3510517-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/5/25 1:27 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index faee3e8580..08d15e5395 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1917,7 +1917,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_eqv(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t s_mask;
> +    uint64_t z_mask, o_mask, s_mask;
>       TempOptInfo *t1, *t2;
>   
>       if (fold_const2_commutative(ctx, op) ||
> @@ -1947,8 +1947,12 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
>       }
>   
>       t1 = arg_info(op->args[1]);
> +
> +    z_mask = (t1->z_mask | ~t2->o_mask) & (t2->z_mask | ~t1->o_mask);
> +    o_mask = ~(t1->z_mask | t2->z_mask) | (t1->o_mask & t2->o_mask);
>       s_mask = t1->s_mask & t2->s_mask;

Even after writing the truth table for eqv(t1, t2) = ~(t1 ^ t2), I'm not 
sure to understand directly how z_mask and o_mask are derived.

In this case, we have:
t1 | t2 | ~(t1 ^ t2)
0  | 0  | 1
0  | 1  | 0
1  | 0  | 0
1  | 1  | 1

In this commit, and in the series, it's confusing for me to have mask 
values set as 0 for 0, and 1 for 1. When mixing that with bitwise 
operations, it starts to get hard to follow, always having to remember 
if you deal with 0 or 1.

It could really help to have simple helpers for (known) zeroes(v) and 
ones(v). I feel as well some comments would be removed because it would 
become explicit what we are dealing with.

let:
   zeroes(v) = ~v->z_mask
   ones(v) = v->o_mask

res_zeroes = zeroes(t1) & ones(t2) | ones(t1) & zeroes(t2);
z_mask = ~res_zeroes;

which gives:
z_mask = ~zeroes
        = ~((~t1->z & t2->o) | (t1->o & ~t2->z))
        = ~(~t1->z & t2->o) & ~(t1->o & ~t2->z)
        = (t1->z | ~t2->o) | (~t1->o | t2->z)
which is the code we have here.

> -    return fold_masks_s(ctx, op, s_mask);
> +
> +    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
>   }
>   
>   static bool fold_extract(OptContext *ctx, TCGOp *op)

I'm not necessarily forcing a change, but I don't see myself rewriting 
truth tables and developing expressions on paper for all operations to 
review they are correct.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


