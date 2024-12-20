Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60611E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjRX-0008Lo-NO; Fri, 20 Dec 2024 15:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjRP-0008FQ-NJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:17:44 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjRO-0006eo-33
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:17:43 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21675fd60feso28266245ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725861; x=1735330661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGrcCad6tEYtQ0mrrz1ESTh9sM+ZznVASV57e0fdyKQ=;
 b=A6w4qxiACp6eM2lr3lnRVurfhkiW6wTHEEol2YPJ3EfLGQop+5wbcUZaqOqEkDYfaP
 M2zyTZ2Lmp5YaD6GUdI6+emWRuOieTK6y7SiXWPS250Mpx435jUwwU/0QJejTgbQsHZt
 8Fk5PBljSS6RWMEXtwchiRPDF8Odjk7QmC7JsthzVmvXVyv8llY5OBAy02HSs0wU095l
 g0vqI79jIP1k8x2H1Bt1gEMIrAIsW3Lh1Mat6bnT4zXtjSgNLH+ojpUqK+7YYpzIcgZm
 VtvJm+gIMWQg6Vmz4pV0DpZ45LiY3B096hxQnB4FhiEEE2/YeF8/aJ8tLEuxitX37xCI
 a0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725861; x=1735330661;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGrcCad6tEYtQ0mrrz1ESTh9sM+ZznVASV57e0fdyKQ=;
 b=LnE+iEIwZdsM3ZO7n2OLbMzfJrfzGYoW7WP3dnviGI/5561XulC1hRCTY2mDwbwgsn
 PRXG2tW4GgPTTftm7fBB/h7LGV3rBDNvO/QogoDFYic6ogsr9Yu7nwcOEabGiwYLUXab
 UntdHHxoRDOZZHRP7rnUNGkZwtqviUcrHEIABjspbolN9mRcARhEhW0pf5IW08xcy9HW
 EACWn9UPdLydqnma74dT+tn0bX1ma4FHxErPyg1hPI/fzES1jdpv+hc+m4OXMTXHAqUa
 +TBv0D9E0+NKW9Bf8t0kLvwtopyzXL+SRnahDNutSRXMaxhyv52O/FD7PJSy1UsZmaij
 SOqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsNPn6pvo8In1QsRj5qInjNJg8PLd/7dUd8Jfaa3QfynEc1ILhq+wBMeukvicedMWlDEotiDY89Psk@nongnu.org
X-Gm-Message-State: AOJu0Yx/8xW+MnA4tkKKpayw8OJ71kBppRRTzHxQToE/lOxs9l+yiUyc
 MUKrXbwtMyelaxmj7Hk2iw8ZGcAL84dPejUvrCVCZJotHciq014Zv1VaC2j1JRH+tWovIJQOK7G
 X
X-Gm-Gg: ASbGncvArMa0qOGwIyXg0MocLXc7vPiFPW8mOFg/JdlXqXEJz7JRMOjeLTrriSxYqOy
 l0PevFK0e7xkGeuWSLtefYMb0KGToSDj+ib2Ad4NAE6VAIX3C/6Z3SPPHBHe/1d3GGczj53aFZ1
 C154zSbOjUVZcJnKvzUBbpey01JlBFEDRXOHjwEQVRYtNlVM+QW8l97JCoI1dgqzupqfsvURmeK
 jxpepPypTXm5dKtzqFckMZ4neNUsR3OtDYuJxb08uTLJ5dIq4yVymcuENWq5inH39HJqQ==
X-Google-Smtp-Source: AGHT+IE0AHFqaiBff46pVTJlKbw/nwbNv+yzIhQt/q4rDmTsEQYD109/Btcn5yXi3qyybL9jlJ/SRg==
X-Received: by 2002:a17:903:2306:b0:216:49b1:fadc with SMTP id
 d9443c01a7336-219e6f1488dmr60898795ad.42.1734725860841; 
 Fri, 20 Dec 2024 12:17:40 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d444csm32879255ad.137.2024.12.20.12.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:17:40 -0800 (PST)
Message-ID: <f7b40ace-bd75-4f8a-96f9-8c083f9e5cd6@linaro.org>
Date: Fri, 20 Dec 2024 12:17:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/51] tcg/optimize: Compute sign mask in fold_deposit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/19/24 20:10, Richard Henderson wrote:
> The input which overlaps the sign bit of the output can
> have its input s_mask propagated to the output s_mask.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index de32cc0323..e4f68241ce 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1646,8 +1646,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>       TempOptInfo *t2 = arg_info(op->args[2]);
>       int ofs = op->args[3];
>       int len = op->args[4];
> +    int width;
>       TCGOpcode and_opc;
> -    uint64_t z_mask;
> +    uint64_t z_mask, s_mask;
>   
>       if (t1->is_const && t2->is_const) {
>           return tcg_opt_gen_movi(ctx, op, op->args[0],
> @@ -1657,9 +1658,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>       switch (ctx->type) {
>       case TCG_TYPE_I32:
>           and_opc = INDEX_op_and_i32;
> +        width = 32;
>           break;
>       case TCG_TYPE_I64:
>           and_opc = INDEX_op_and_i64;
> +        width = 64;
>           break;
>       default:
>           g_assert_not_reached();
> @@ -1684,8 +1687,15 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>           return fold_and(ctx, op);
>       }
>   
> +    /* The s_mask from the top portion of the deposit is still valid. */
> +    if (ofs + len == width) {
> +        s_mask = t2->s_mask << ofs;
> +    } else {
> +        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
> +    }
> +
>       z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
> -    return fold_masks_z(ctx, op, z_mask);
> +    return fold_masks_zs(ctx, op, z_mask, s_mask);
>   }
>   
>   static bool fold_divide(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


