Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C00E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeOU-0007R8-QI; Tue, 17 Dec 2024 15:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOS-0007QR-2n
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:12 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOQ-0003nI-Ko
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:11 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216426b0865so50958825ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468129; x=1735072929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/0lYT/3XJuh5BMTqWmFaKEhNp70yDrscn5Ji/Q+ao4=;
 b=ZHybe/QVYcGJaPOUvbGRzeoo6OM1cnrCxdM2Aw7XsJrImdkw2yOPw5ic3YOTtJ0+cy
 xvOaEVkAM0+GJk/TZcx2ABAWX9zuGl92Z42RIZ2f9Iu5AYfUv6E94Dsvp6+Pp9xD0UiY
 ydHCV+436B7QcZywJ83wgxdCZ0YEFBXNKOFgjCTCwRJ1kCku5FOt6oi8RlSMPDNqxMwp
 xOcU+HAIoO/R6ykEFjXMWbAvdKJmBHQ+MI8So6ZgdzopOYbnXkqXHoUh3Hlx/gvqS2oA
 obeOL4r5aMZIfjqbTV0YCZjZjnCwpNTpI9+gGJtEwJBgS64DHpU8Sv+MKIQpAuSw3Jgd
 zsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468129; x=1735072929;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/0lYT/3XJuh5BMTqWmFaKEhNp70yDrscn5Ji/Q+ao4=;
 b=Vh3+z1N66IANagRnSqw75RYszSRLZDYsGvxMhvMRLBaLcuUueuNkhHun/QEhu1lxA6
 eJkPsVXhceTDgzXfUyEuKkdcVE3KznfJmgfy8UC+OJHuEvErs/t/ArK6iWdidhDftQHx
 xUTDD+cpyRPZ871pWNxPASr/MEnQkGdpPJeUVeEIF06U/R2gBk1+BSCVGK3WKqE6klpY
 kq0tX64Xfur0hVCbyPlus+o9DgJawdylDRdpYdgc8LcW+uPADjhNr2ejp7S5bMiV7ACF
 JyRyH5Gnbnux0OSAV7lhT8yAHjhkEzx1TIzWEhrXqxjU/lbtodT+w6VQbgxOtz1Mc9Nh
 HBXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLqWmtBYOgux6UObVhSaz0lvKqQ+hwKIiJMAiQJxrJVRywwc6gdgBt/mFPKEEVpw6drkYJUVZ906X8@nongnu.org
X-Gm-Message-State: AOJu0YzCpyicPpLoqo+XW3HyshQJUSsuqTRkuo74YbQPmJmGw2pm/0Eg
 SXeI+r1hTUFYNsd/j6hvTeIgDqgYyq302efdPNsgWSAJzYq/E0tmMqnqr7Aop38=
X-Gm-Gg: ASbGncvqx6YQnatP5A9kENqrMBkH7Wa2n/CHJpyx+/FGMIZqTQdCduhBEC0sJ7tvh0o
 VoY3b7ElzjhNkq/lq+6pYNr4JhdyI63DR7cSvXBq/hepXip63dAIhVv+lEmxb6WitswnYaV0T59
 QyggGN75t+xfJvKprsmlXf84CUqBZgKYIR3vOkpULeW/cnEDaG/GFNcRCgXPZokpoHGDxEThtO3
 KpxI9ZJTxg2TwVYkiUEOhWZ9SFdM8MpvDZ5hVr65z3PwLZO5T+VI+elUKSDGvdts02Msg==
X-Google-Smtp-Source: AGHT+IGXo0dsueqfLG6u5hyLv4b55aZNqKALayX2q+7df/wlXREKeeovSiMdK7uRBAMLztHI5kMhjA==
X-Received: by 2002:a17:90b:2d4c:b0:2ee:a04b:92d3 with SMTP id
 98e67ed59e1d1-2f2e9391214mr346389a91.34.1734468127461; 
 Tue, 17 Dec 2024 12:42:07 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142fc2fb1sm10375065a91.44.2024.12.17.12.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:42:07 -0800 (PST)
Message-ID: <24ad8e30-f1fc-4e86-a692-3ca39614349f@linaro.org>
Date: Tue, 17 Dec 2024 12:42:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/46] tcg/optimize: Use fold_masks_z in fold_setcond2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-34-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
>   tcg/optimize.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 0097502425..dd6ef3d831 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2450,9 +2450,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
>           return fold_setcond(ctx, op);
>       }
>   
> -    ctx->z_mask = 1;
> -    ctx->s_mask = smask_from_zmask(1);
> -    return false;
> +    return fold_masks_z(ctx, op, 1);
>   
>    do_setcond_const:
>       return tcg_opt_gen_movi(ctx, op, op->args[0], i);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


