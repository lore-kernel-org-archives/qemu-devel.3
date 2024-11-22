Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48342E65D10
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 02:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEJfX-0008HE-9G; Thu, 21 Nov 2024 21:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEJfW-0008Gx-C2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:45:14 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEJfU-00052Q-K9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:45:14 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29678315c06so942821fac.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 18:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732243511; x=1732848311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cEcdbL9bYS1JlPyzSCU29/ljJ65qnV2F5aVNbXuezy0=;
 b=mnD2I6F+L5/QJco4KBnQlxEgdAM3rY7CTbElaHCSmJ5uhHsjptlc978B7yn5BP1/4U
 SdSuUpeRx56XDHlvfDJspMmslZ9C6rtx0fENQJB361fb5PAsBbNyfi7OnP+1gykXHawB
 GY3h0S7Zs5BZsfdyjo699VXoS0+vPiPWiCUbe0ghyX8wnHLRvMXdxyIyeqYqeRWYUoDq
 wT85zmZJbP/BAVoOy0g+338MqyXYHF9VBFdl/5x1TY4MUVf7Ep7IojGRL8ArvyVCFnk3
 mcsC7+86IOLvg3jbPCNGMseJGw7//yOvuQ7gpv8vQBDhKpD6lrt3s2NIyXry5+UZ05N6
 ZQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732243511; x=1732848311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cEcdbL9bYS1JlPyzSCU29/ljJ65qnV2F5aVNbXuezy0=;
 b=osB+mXc9Fjm5dXPpNTPSKhtoqK7dD7oynK6IoYIflR9nm/bl0sS8sYlKag6sY5NFgT
 rRDqxMfOCUrOBH8ETsOdfGVdy90yZ89Vhgmi5J2nG/OC6oBFzBgfZiOQ2YLa2Pv/bOe7
 dSxPtHRxFOuTRxoOzxIIgsRhkhI1S6UPAZoascUC762Hiaeb8DAEYtoDeByiYkdZR7jz
 1VqasmJp3H51yQFucJs5NKKCbrSvsmQZwzbUUiqDwPC1pDmb/0a0Rgfcw5clyVr/Scta
 T8Zhdj+9P/hFl2Y8r9ObjSYJs3K9HacFp6c8g/cUhWaoI+TGZDDOOCR2V6BMQ+TtS0pr
 RgPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjWtqWq6x0ZsDoz1aK6cCFuXIzu6g26/txefEDhyl19zcU08fOuwop6g42G3uvAKk9LIann8XmYg3F@nongnu.org
X-Gm-Message-State: AOJu0Yyi/yCGOibQKm3xVJmhetyb9yFKDnA8v92R7Rtk/eQrInl9LA0P
 IE6iwnmxH+I8+OY9wTm+SPfXpLhPlkRHo0eGafJwDYB00ruF+UumSwvv1smKuDM=
X-Gm-Gg: ASbGncuSZ1HN3NFHH/p7mSETWfcmEMe0zZIji8fAHk64bWCPfl+XqDsFKYSSokh8qRW
 l4MKMsniAttuuCusuiaZaJock2tgCbYixl2MHbjjPKWN9I21EncaEJfQO3rqu2N+PFsKSebbErZ
 0K6HvpV9wlkbaWNx84WzUbg4y6fzBpxl/RwbiqDN4cUTmxc14kFu8fxtwKPDyGMOMPk3wN2+FXE
 bpYDiEScK3wBeoVWMJjVnJ7GApfMOEoPqZBNY5IPNNLBVXN38gWwHH38jKzXUfs+g==
X-Google-Smtp-Source: AGHT+IG/j+L2JrnWgRjwqOZLX+IJcMe0TH79b7Laze4cK30AbZQ0DSGX3HsLfP1Ht7xEj49W7JOkIQ==
X-Received: by 2002:a05:6870:b14d:b0:296:e660:5d80 with SMTP id
 586e51a60fabf-29720b63e1amr1285798fac.14.1732243510675; 
 Thu, 21 Nov 2024 18:45:10 -0800 (PST)
Received: from [10.25.2.159] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d897320sm318156fac.54.2024.11.21.18.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 18:45:10 -0800 (PST)
Message-ID: <c852f180-48ea-489d-a32b-61f7b4123ac6@linaro.org>
Date: Thu, 21 Nov 2024 20:45:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.0] tcg/optimize: fold recursively after optimizing
 deposit
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241121081909.227610-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121081909.227610-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 11/21/24 02:19, Paolo Bonzini wrote:
> When generating code for x86 targets, this is able to simplify XOR+SETcc
> sequences.  SETcc generates a setcond+deposit pair of TCG opcodes which
> used to become setcond+ext32u after optimization; now TCG recognizes
> that the output of setcond is itself already zero extended and turns
> the deposit into just a mov.
> 
> There are similar cases in fold_movcond and fold_setcond_zmask, but I couldn't
> trigger them and they require moving around functions to avoid forward
> references[1], so I am leaving them aside for now.
> 
> [1] I assume the lack of forward references is intentional in order to
> avoid possible mutual recursion
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/optimize.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

As far as this goes, it's certainly correct.  See also

https://lore.kernel.org/qemu-devel/20240312143839.136408-1-richard.henderson@linaro.org/

which I failed to pick up after the 9.0 release.  :-/


r~

> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index e9ef16b3c6b..e0fdaeb5500 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1620,7 +1620,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>           op->args[1] = op->args[2];
>           op->args[2] = arg_new_constant(ctx, mask);
>           ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> -        return false;
> +        return fold_and(ctx, op);
>       }
>   
>       /* Inserting zero into a value. */
> @@ -1630,7 +1630,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>           op->opc = and_opc;
>           op->args[2] = arg_new_constant(ctx, mask);
>           ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> -        return false;
> +        return fold_and(ctx, op);
>       }
>   
>       ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,


