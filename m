Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A473E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe3n-0007lQ-CM; Tue, 17 Dec 2024 15:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe3j-0007Rt-BH
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:20:49 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe3d-0000Zn-8d
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:20:47 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso2395426b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466839; x=1735071639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lkc3QxL1D19ryeOo713fxoDSZyhHBrXJGIftr0w1L5Y=;
 b=luQqvCyOWUhrjnNohZ/KdlJ45bFnSTOUzeVwB0Zv6n5CBJI+gEVN2gESeeD0X8+TMe
 mZVhu39hou15iR1U/qVjsWpIonyb9Y2ix8OaGkFsEqHmvyETktbkLTnzpcwN3Srw0Nme
 dj37AuPEoH4sg/SaezDdRB3cBr646JytcHqSqmrL2qRsAUv0wO+taGRhaFMh89GEr8jl
 rY0QiU3oS8O2PJ3zuZ9XZOSEaAkaa7WWpU69pF3P3jJ1InMKVcnJ0nW5xp3nOm8ERbSk
 oFFbWdCNgAxl4NIxVaDuCEM8wStXqnA5tGwob8Rewu+T4ywAy9PbeZo9i3wqJ3EC67Mx
 A7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466839; x=1735071639;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lkc3QxL1D19ryeOo713fxoDSZyhHBrXJGIftr0w1L5Y=;
 b=pz0nuKnKw2cV0ok1VPlDFLFqPn6mxzqGS3ND6rHSpzQ5GCv/sQhEVs+BmqA1V9Omyq
 8knAW87itOoU19UbziMP1z3wOgA60VyfI37ryVYn3Px6IRI/Z/dVcj98ADTpzl4AX7T9
 OKVyWS5Q1fg+rbLsn03duDUg4tiKOJgtOgpL0vUAYMnOI+tRJ50iYHnXHLnFxtYdh+FZ
 +XYcUomIx3uMQeHyI3PHioCuPl35ZOhKBfxpjFQsfUFpaQL5Q47rCeBxZChN/+hYr73z
 2tQEyaTHgmwrcquU2iNYSS6+XH5N4WIYuDW8S5U2MscJ1scfytFnefq6tRCynvkPrcmV
 lMXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxu6BXN6yX9JHBZigAtHOlxJvHDvaaLik1zd+IhbcCochtde5b3eIaN1Ta8whRaIq/IwKEoyPm7aEi@nongnu.org
X-Gm-Message-State: AOJu0YwtKtyhnV44S0DHhVds8HIEyh/RHL+LSwyrfpDex+hZmnSopB3f
 0LSXC2n1aM8PbMEAVYPERNjAbqGfryvrST481o+IWp9VRo6kzfyNi8S8OmszSMA=
X-Gm-Gg: ASbGnctCpIsQuHKce6V1tPGKx2pYsyaVofBFOPPO7OhIy5g98OSY9ROV3+Vg41bIG6H
 zBpzLbLTVQP0/3D6FbZaZOPX4Di/BjXHpZWZfb9xuHzPjanGdx7iU7oJTKsWTraA0PGwYq2hCWx
 HZD09HS4RoriXqFg44z3DvL6vGTM36riIXUXpxqBgwfUSu8H40yNZsVHDabBL5jmCwIzsZCyYfx
 PdQY9vcvYeb+5cqy5J4BKswzdzzYVbLGScYpGKYDbuY8QDsqVRS6LobZZ0F6FmJN/VS1A==
X-Google-Smtp-Source: AGHT+IEhU1G7pf2/w0d5aWUzYpzOXq/2MOouGoJXlzSDJ6d7BDzsaLZou8dMO8tFwgNPkLmIDYFhWg==
X-Received: by 2002:a05:6a00:e18:b0:725:b201:2353 with SMTP id
 d2e1a72fcca58-72a8d24a3ecmr519447b3a.13.1734466839573; 
 Tue, 17 Dec 2024 12:20:39 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad621sm7087925b3a.156.2024.12.17.12.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:20:39 -0800 (PST)
Message-ID: <229d0c59-3e49-464b-844d-c09b6f9f53cc@linaro.org>
Date: Tue, 17 Dec 2024 12:20:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/46] tcg/optimize: Use finish_folding in fold_dup,
 fold_dup2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
>   tcg/optimize.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 59f510b49a..e6dc9f2e28 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1681,7 +1681,7 @@ static bool fold_dup(OptContext *ctx, TCGOp *op)
>           t = dup_const(TCGOP_VECE(op), t);
>           return tcg_opt_gen_movi(ctx, op, op->args[0], t);
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_dup2(OptContext *ctx, TCGOp *op)
> @@ -1696,7 +1696,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
>           op->opc = INDEX_op_dup_vec;
>           TCGOP_VECE(op) = MO_32;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_eqv(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


