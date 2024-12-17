Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12237E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeQQ-0003Hh-1U; Tue, 17 Dec 2024 15:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeQO-0003HE-Ts
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:44:12 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeQJ-00043X-Id
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:44:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2163bd70069so58935815ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468246; x=1735073046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7D+wKbSVGhk6ea4Pobmw1bGDSFWUpa/kJWtx5y8hOw=;
 b=ou+Me9Vm1xGZXU9oPyN5w8YJB8KK7lMhMb8iu92KjGRe6pf5RzA4twy3E843bU4Zt4
 uN0UkfPNFK3Ko9Y0rRA0o+bnO/Yy3/GfEmH1MuxXSU1sB+CSO7oqNRnNGdHS3CvClc1O
 IgtEC7+6CmTlDfMapjry3qSqp1vd1OK8W46i3XLHXhAuF7krnoWARuNbKElo+a/2f8Rw
 dV259c85rmYOzd8MDGzXEg/2d+c8b36/taeE56C8AFMZxYZrt48RlSXtzJSD2tyL+Bod
 QsI3kfOvwdz9a1twg1/flxRsbb8b1m/AFu6o5E+UOg+rIbK/KevCXDe844kg9KSdnIfF
 vHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468246; x=1735073046;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7D+wKbSVGhk6ea4Pobmw1bGDSFWUpa/kJWtx5y8hOw=;
 b=K/7SCkxv/iHyF4SAum/Q6w3uGSvA8KcZdPtvCya0VDW39Bjg9C05cWp/IThXMIhpA7
 ZSdDcvNe0SFcx+Al4SBWO50PINj5aiM+ueZkXDcH8J06cWpoa1M+F+ui2CwINnr70JjD
 2wsaWoPxwktefYyr3Q/eWl4krMzErveYm6CCS7WUTeWiMwTWgVJL3l3Vo9m9hOv7YBdl
 qhPg9ChkNbuX6e/NhtRUmYCahKxOMGsbayWDKPJ9HdOzy2MI7L56uhpP34dvtPtk5dXf
 sMx8TI3jPRjCaHsfRwSvA6wAuKvv8hO2dT+W6K1AhiydTlxNKgZckjshkrzQP/yGF5Y9
 rVvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYJh4ywailU50dNsSEsRCbAwv9Kpxu3KT1sFLFin8CJXsJg9hS2e47cELKbkWL3HBPLQREldF/1BZr@nongnu.org
X-Gm-Message-State: AOJu0YxBEybKsehrmC8lxaMgHd1x5XnyyHH/GM32eUsdbtj0kKMBHacF
 rB0SS2k6ncKDHJSZQuxvuf9eB3h9pLATIuhfF20hxOFXe6JYsTN+ptUfMWpssso=
X-Gm-Gg: ASbGncvbDByNPxYGUljCzmr0QKsvNNV8R1lUGXDSoVL/z4UUSDN5p6YexnBEBPs9B7W
 C3YsXOyKwyzEdHqU0Km3x2hBe5frSrsepK1M+jLVERhPLExalsZt1z+M6/S+PAFpx3FBUuDoylS
 64YFKth1i1RT4QbgR9QaP4GSVBzAiifx0zQHxt46Jbkn55fiJ5F7Xmnut5aFSJO705F+ynfbpZp
 SZHlCVoV90z2qSrUiLy/pB4Ut3/w28tnK4uNXSzBBf53+U22lBVdZxQ2QVJEwce1Xaf2A==
X-Google-Smtp-Source: AGHT+IFW2KaZ25p9BH8Clygtjfibcr/AivvtKFIfRtP7ZMM77tIx9CCsNiNhcF4WPVc5wk005xqQKw==
X-Received: by 2002:a17:903:2448:b0:216:6769:9eea with SMTP id
 d9443c01a7336-218d72477d0mr3597775ad.37.1734468245994; 
 Tue, 17 Dec 2024 12:44:05 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e65461sm63490595ad.238.2024.12.17.12.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:44:05 -0800 (PST)
Message-ID: <336080fc-64b5-4ebd-b04d-adbfbfc14ff7@linaro.org>
Date: Tue, 17 Dec 2024 12:44:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/46] tcg/optimize: Use finish_folding in fold_sub,
 fold_sub_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-39-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-39-richard.henderson@linaro.org>
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
> Duplicate fold_sub_vec into fold_sub instead of calling it,
> now that fold_sub_vec always returns true.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index bec5a07288..6412d5df37 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2606,12 +2606,15 @@ static bool fold_sub_vec(OptContext *ctx, TCGOp *op)
>           fold_sub_to_neg(ctx, op)) {
>           return true;
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_sub(OptContext *ctx, TCGOp *op)
>   {
> -    if (fold_const2(ctx, op) || fold_sub_vec(ctx, op)) {
> +    if (fold_const2(ctx, op) ||
> +        fold_xx_to_i(ctx, op, 0) ||
> +        fold_xi_to_x(ctx, op, 0) ||
> +        fold_sub_to_neg(ctx, op)) {
>           return true;
>       }
>   
> @@ -2623,7 +2626,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
>                      ? INDEX_op_add_i32 : INDEX_op_add_i64);
>           op->args[2] = arg_new_constant(ctx, -val);
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_sub2(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


