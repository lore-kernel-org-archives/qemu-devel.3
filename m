Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7052BE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeRw-0005Pa-7q; Tue, 17 Dec 2024 15:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeRr-0005Oq-HZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:45:43 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeRo-0004SB-Et
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:45:42 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-728f28744c5so5356687b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468338; x=1735073138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJ6Tv8odW3s/XJhGnHntl2uMKZw4RQhYO7w6H5SAcMA=;
 b=zso5he3qSrU+NSx6mY0xDWqSwJG9c1XhNdl9umbYs5UYFl+rSGA6/yPdMln5lUJv4U
 VqpvI+0f/dSiRX/CqRctOSa2RVqaDrurHEdqS7X0KQFioz2RnuqW5Dn/lUoA4tRIkWFq
 qmQ9ftUda5jHs/h8hAemhX+EOkTHEN+jqTP8tPybDABptgACx7whSkCrq4Letttifjcc
 vX3hiuwx27vyCGcTuX80K/Zsc73KNMPhG3OoxaA6TqhJ5nYm+6mpuQmoLMSIX37WIkda
 jkSf0Bk9mcL1CwAk1ukJBNf67mofRgpHR685ncFBbCbwUhryWFVEndOYPdZnyztfrqLO
 LrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468338; x=1735073138;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IJ6Tv8odW3s/XJhGnHntl2uMKZw4RQhYO7w6H5SAcMA=;
 b=gLe8ZpJFJ+D4totbfGE7fGPAXyw4TDieuR9yUo7kl3WgSvNkh8qSxWerxPnbOGj4W2
 uXZ+/VfkDjgaXkXtIyJdn3vzp0+2X2IRZlj3B4qQCIuWY3hTczCwyWrhlzeG+Xkr1WfR
 rMS5jqynv7w0RZ4P6ADX7sEfHL5pcKcVHQ0f0g8l/BbvXhvHvDhR6fIBDt5OF294N/Fr
 k6Wijw6CBFN7iaIpBMm7GkpBuNV+JQImCfnYkpydPo439W0439LNA3ATdZgfUXe6mMo/
 C1LFOqVe1X3HQ6ttsz2PPEdasHZM4860a5ZC/DlSRKhRVvf818snTruul2W8tt+F/Xs/
 f5bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTjSuVLJyVABWjw2qKjoW1OlbX0XnZs3NwIAqeJXCWrZIky2wP90SNaktgmAYBPyVbvzbldMwlx+c+@nongnu.org
X-Gm-Message-State: AOJu0Yy8yZONNntTERCiLB1h8SFBgjglCwR+GXPYZcpVro9pywwY2czZ
 q9TnSW7lz9XqqPlza4ZJ5gonkubA3NTKSZPmbkZ/jQrJY9lx06iKfXXCIPUsdZ0=
X-Gm-Gg: ASbGncvaEGtLZ9p4cYLbx0UXHx59vP1eMRp4Lk0S/HdIqNijGBdzV53N/7zYzMtoTql
 GzDrneb3UQt4B3PNrFzG9o0BK9j8623SGT1u1uVN8CGXicrbK7WobXRT1wI010g+K5NW0ibROa4
 kJw0L3C2JOGEAY6J4oNFvAFp7P/m4sChcUWnOmNR3ZXnL4mCudJyDwaH6hSeqU/cJnnlg8AqPCU
 FA6lQ6M1dA5mhfHwlSpa6OUpiDsQ3u/DpYPOBNJkcDgQygyO+tqyBBEBtPKWt1YKrrD7Q==
X-Google-Smtp-Source: AGHT+IGn/Cs/T3ur6pu6Jj73cGA6uisQsU8/lhePDNk6oSR26AqoFoLZe5mEw3DQ3aiXtpEN9saaXQ==
X-Received: by 2002:a05:6a21:1192:b0:1e1:ccfb:240 with SMTP id
 adf61e73a8af0-1e5b48a3c1bmr651719637.41.1734468337951; 
 Tue, 17 Dec 2024 12:45:37 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918b78f7dsm7082914b3a.97.2024.12.17.12.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:45:37 -0800 (PST)
Message-ID: <6e176656-7c87-4dc6-8dcf-2a53a43e4981@linaro.org>
Date: Tue, 17 Dec 2024 12:45:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/46] tcg/optimize: Use fold_masks_zs in fold_xor
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-42-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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
>   tcg/optimize.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 46116970f3..fec46014be 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1093,11 +1093,6 @@ static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
>       return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
>   }
>   
> -static bool fold_masks(OptContext *ctx, TCGOp *op)
> -{
> -    return fold_masks_zsa(ctx, op, ctx->z_mask, ctx->s_mask, ctx->a_mask);
> -}
> -

Not so important, but eliminating this function could be done in its own 
commit.

>   /*
>    * Convert @op to NOT, if NOT is supported by the host.
>    * Return true f the conversion is successful, which will still
> @@ -2758,6 +2753,8 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
>   
>   static bool fold_xor(OptContext *ctx, TCGOp *op)
>   {
> +    uint64_t z_mask, s_mask;
> +
>       if (fold_const2_commutative(ctx, op) ||
>           fold_xx_to_i(ctx, op, 0) ||
>           fold_xi_to_x(ctx, op, 0) ||
> @@ -2765,11 +2762,11 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
>           return true;
>       }
>   
> -    ctx->z_mask = arg_info(op->args[1])->z_mask
> -                | arg_info(op->args[2])->z_mask;
> -    ctx->s_mask = arg_info(op->args[1])->s_mask
> -                & arg_info(op->args[2])->s_mask;
> -    return fold_masks(ctx, op);
> +    z_mask = arg_info(op->args[1])->z_mask
> +           | arg_info(op->args[2])->z_mask;
> +    s_mask = arg_info(op->args[1])->s_mask
> +           & arg_info(op->args[2])->s_mask;
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
>   static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


