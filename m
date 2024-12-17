Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB9E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeA0-0003Xy-JQ; Tue, 17 Dec 2024 15:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe9y-0003TT-02
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:27:14 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe9w-0001Xv-Ct
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:27:13 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so3465187a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467230; x=1735072030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cTkv44S/1l8p2L7XBPeR2yeFlJ/dyB5n7hOzTnSepXY=;
 b=OIEwkn0nA/1wnJ8YcIAdasmBdLiW8WQzRJWKEMODGdZzQ3MmjARpqermNaGCIH5tXi
 cSqOHn7J8orIu/MY3v1b3CQzWg8dXUZvrI2ap7t+Xz2Sr/+IpZCjVHSy95xghpknEqT+
 k55CTnVVpJ1obFWPqIx3DTsPO/7eRrVZ1b4RZZA6TkRUo9elG44cH3oMb8SQP32wk3Y1
 YjQWEMXYkspmRNpMdHFaw3xCSgNYB5vP/Ja1DLGzz1DluQ1oPB/RrfPvXlavwSeuXQpz
 t5k/MrgGXn8LjIaPJduPzBw5GsHc4ifRxW1Vpo32pjSDR0UWx5ztdeCqbLKYyAvA8JDA
 Z4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467230; x=1735072030;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cTkv44S/1l8p2L7XBPeR2yeFlJ/dyB5n7hOzTnSepXY=;
 b=TcHHCLtpJioIFA2nPbzCVSDFLTrCPrKS5B1xUG+R4RPsQYG0FsGGJHuLe+PXUc+90y
 OHn4ZRvOu8ayJxvUjh9+D89oAtSLUQVaNWRqYY33PfGBMOzgzsP1047q2boVi0xDIfTj
 nfq7j4GCv5IYjD189Op8ui6LL/0sei/llZ90XrEvgrEh0qInsMnIGDfc+yBtmsfYd34q
 CexQ4CfgsPbkXPEuJHDQ4b2rPtKvpt63MDqhkFuR1Q5sRxuwjyfylD0hejSLy+H6N4An
 UxmFIUgH91e0CsRjzLzilgHvOMQjb2eFu9zNi1fF6oGl8GrZP4J0f/n59504dqZnc/IP
 d2eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq5hGCWrHCz2GnKO1HtMBk9OaYAbvBdXKkOQ/iI8xuO3LPYDVerb//W4pfJAvxWaw/PuuJyf6XauFy@nongnu.org
X-Gm-Message-State: AOJu0YwsQvDTEYkz8fyf+RLVUmRZyL5udK72mQyOo3v7J1NVLKtDzQHN
 BMtsbZWT5GgUwWP5ijzosg/6M4Np6n+mrA+UZfWWcV/p1zjHnZIcFfkmIKQEEkg=
X-Gm-Gg: ASbGncuOTAJeKfqYWZKEUkq6LXvoHGKyXgaPWDKtoUPKX8bafA/96OYCzRSvgiaMRfg
 h0L1qNcKp5ahi6Gq+83FH/LwBgdhKmLgyOVB70EfcM4ozHTSfh+girdgzbV6vj8l7OJadlnUiit
 vSBIXVSfMwZ4JQrK6NanE2UbiVEbF3le2QFK4aA3oqypI9qcBl0jwAwQJXm0fvMnYe1QTOfIoDs
 r63QUY9GCaoLA+0B1jfc4olR0oTCxdxFGOFZ85XdopW13kuQuB6zqzxOWfn+rhe201Jfg==
X-Google-Smtp-Source: AGHT+IFoNUgpZlcjGof07Us51/snKugTsCli3TmK7zbZYZCy3Zem6PA8O5KkYhjviVrOJRm/oehA3w==
X-Received: by 2002:a17:90a:c2c6:b0:2ee:7698:e565 with SMTP id
 98e67ed59e1d1-2f2e91c4e80mr385015a91.8.1734467230557; 
 Tue, 17 Dec 2024 12:27:10 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d90bd8sm11639791a91.10.2024.12.17.12.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:27:10 -0800 (PST)
Message-ID: <3a1bd18b-1cde-4144-b074-13019dabd887@linaro.org>
Date: Tue, 17 Dec 2024 12:27:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/46] tcg/optimize: Use fold_masks_zsa in fold_extu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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
>   tcg/optimize.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 5d10e704a7..260e3ea072 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1804,7 +1804,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_extu(OptContext *ctx, TCGOp *op)
>   {
> -    uint64_t z_mask_old, z_mask;
> +    uint64_t z_mask_old, z_mask, s_mask, a_mask = -1;
>       bool type_change = false;
>   
>       if (fold_const1(ctx, op)) {
> @@ -1835,12 +1835,12 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
>           g_assert_not_reached();
>       }
>   
> -    ctx->z_mask = z_mask;
> -    ctx->s_mask = smask_from_zmask(z_mask);
> +    s_mask = smask_from_zmask(z_mask);
>       if (!type_change) {
> -        ctx->a_mask = z_mask_old ^ z_mask;
> +        a_mask = z_mask_old ^ z_mask;
>       }
> -    return fold_masks(ctx, op);
> +
> +    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
>   }
>   
>   static bool fold_mb(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


