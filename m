Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1386CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 23:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1CGG-0000rG-Vk; Tue, 23 Sep 2025 19:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1CGC-0000qn-Ly
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:17:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1CG9-0006Df-O7
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:17:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f35113821so2575767b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 16:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758669439; x=1759274239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SoRE6SQ/RRSpcu6XVYVnMkmCRu20mGPrEAEIMIbBxoc=;
 b=EKAmslts13icbA6gH+CR4ZuJLv8HxrN34YJ7CJyhu/u3HIl2wYnt25HDE+dboI9wfz
 H/ypJVMZaDTOe/wx+vzywooY97y8t87GnFWpTE1gWgetY5ME97ZsoGmXhCaYs/4JRT82
 uSN8bDl7PEM/xH+QAP8gKdwP88zgfzQXa3Ds6lHHZQnshHUGGPYtlbULrBAgzHU8kC4v
 FeOsHTtCs0SiMbN0Wou3rPF1pURFT/nXVVKCNnWvKsmVYUKfacN51+4keW32wJGD3rKE
 /xwVxcThH8wb8S7FiIUyCADyNnvKGVayxbLEfg1fAFJSYvHBdcLsN6l6JtPvKERoY/OF
 UDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758669439; x=1759274239;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SoRE6SQ/RRSpcu6XVYVnMkmCRu20mGPrEAEIMIbBxoc=;
 b=uggfVOhtLIBnwTbhATdGHnAMZ4ZMq4fP1xCo3Ey82ihA830neuxC4s1pZX+Uvle4uQ
 aeowesu5KuGCqQazldoJTZCY+TSJ/NP6LLpCKzosTp/b9cC/McWfAn9CnhTPMFkn3DeB
 +HPraoAPJxvPH0Vs9+opbu7tGdnyMBROh6Ma15bRa+k5fs4g08kj+IW7bTV5TwD/P4df
 7GeFmqM4tCbygByCujzTuQvpGHsrYbdQta2HdHgoFbyjFCnmIk8XE3q4Nk66NriL/m7K
 ABolSxeLMlVbtqtgF/22EDooyfFZJX0P+QZyl2JuCbEFwbYikZ529nGHXWBjkWmfwTjr
 p91w==
X-Gm-Message-State: AOJu0YxzYB3ZZnkoZRr+zPZ96Igvq5esuWQDnXmaWf8bvNKK0ekKk5KB
 s/rRwTPyhVEvHspbJBDEjpm6DybYBJq6NlgQFejFD8ZR+/sHsgtrkWXgLZn85nR7Ca0B4K7gXqK
 hGa5G
X-Gm-Gg: ASbGncuuBRJmul4B+rJLj7iQsWnWjdXGSvODhU5Zao3trk/npboAAkLzH+xqX6cW7af
 y2S9QX2vO3qRZMV8FBfW51nEWH840vhKlSjqu+gsc85d+OBQnJtgkKupygPzu26aJpI2iezGQOV
 7WxJ6qWEiCSduqYioY7jAMkZ931WMnPoT/eQASj3cNVOT0rHGOMjzBuf4NXcReH9ph9w7wkzac2
 iAdOw5Ti6gPlpANS2mUo0vFXc0ZZeSME1KrUwpk3RuhAP5VEKcYBGQij6CayJ//qpEKcbgiIWyF
 OiYknfEuqChiY8j+V1eKtQbWxT8+o67IY+/jiGVtz10JaBUvX/34VqVfAwJ3INDlRb8fwN2Q8hE
 QAmeQHFwghjhOWlzHEnwPFG04lImmdT9zuhRh3LV7fHsGMlY=
X-Google-Smtp-Source: AGHT+IEWCF9DHzl5FG8Oe+9cyR2jWCg4nc2Qw5Pi/63JhX35qq7lnTR0nRfELHDx4aN9bkZ2kMB6IQ==
X-Received: by 2002:a05:6a00:13a7:b0:77f:414d:3774 with SMTP id
 d2e1a72fcca58-77f53855c15mr5320876b3a.4.1758669438532; 
 Tue, 23 Sep 2025 16:17:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f2d414457sm8379236b3a.30.2025.09.23.16.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 16:17:18 -0700 (PDT)
Message-ID: <45f2be87-8cbd-45e5-a6ba-fb76f37eb718@linaro.org>
Date: Tue, 23 Sep 2025 16:17:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix folding of vector bitsel
To: WANG Rui <wangrui@loongson.cn>
Cc: qemu-devel@nongnu.org, qemu@hev.cc
References: <20250919124901.2756538-1-wangrui@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250919124901.2756538-1-wangrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 9/19/25 05:49, WANG Rui wrote:
> It looks like a typo. When the false value (C) is the constant -1, the
> correct fold should be: R = B | ~A
> 
> Reproducer (LoongArch64 assembly):
> 
>       .text
>       .globl  _start
>   _start:
>       vldi    $vr1, 3073
>       vldi    $vr2, 1023
>       vbitsel.v       $vr0, $vr2, $vr1, $vr2
>       vpickve2gr.d    $a1, $vr0, 1
>       xori    $a0, $a1, 1
>       li.w    $a7, 93
>       syscall 0
> 
> Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
> Link: https://github.com/llvm/llvm-project/issues/159610
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   tcg/optimize.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 3638ab9fea..f69702b26e 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1568,9 +1568,10 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
>               return fold_and(ctx, op);
>           }
>           if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
> +            TCGArg ta = op->args[2];
>               op->opc = INDEX_op_orc_vec;
>               op->args[2] = op->args[1];
> -            op->args[1] = op->args[3];
> +            op->args[1] = ta;
>               return fold_orc(ctx, op);
>           }
>       }


