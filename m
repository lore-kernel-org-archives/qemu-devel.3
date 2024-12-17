Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC755E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNe9K-0002mM-H3; Tue, 17 Dec 2024 15:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe9J-0002lm-2t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:26:33 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNe9H-0001UZ-K0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:26:32 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so74452a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734467190; x=1735071990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XrrikY2cyjSFEq4pJLqMuswehKo/NgqtTar76wRVlPk=;
 b=FV/Bjk26fhWHWthHQD7J09RCMNwruv8lOveBvDCAjKLLwwisY0L3Pm9fnx9iSzTjvw
 N87FXWmL9d2Vy0hEHOQRBoMldWl9IDupF3cV4bsTq0ryyo/ST5yt+YA+DOl6Euh1DlsF
 hdC5rkNd4cB/CtC0fJ6vwePNdjB5n8ZF1v/cjaPBQkEFFRccjL7hHQpH9sn7ee+M5/Y5
 QOjeVA/7dmniJL/HeWXOpTDL6iG8m3y9Wgn962ENbqzANqKZU7HaA9VwKMJMbOpVbzUw
 OaL19aRvnky7ahhv5Jptv/yy98plEt2AtNZ1yOCKRGC74CmqMqCO+U6NDRk28IRZw4me
 IkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734467190; x=1735071990;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XrrikY2cyjSFEq4pJLqMuswehKo/NgqtTar76wRVlPk=;
 b=TL0nqtlnOaPhqwhRUBtjJ56bZsqdq7pxIGMO+2cM+1QyuptgMp14BXgT/Q0xR9LkuW
 fj3lEWYt8ymBRkRQhstDIsJHZvX9rYkaSnxYp9bJgAlQyYQlymT2PsaBuvkA5BYTCkEa
 n84lllQX1vqvUKH/faiWZffU5wiBzopIMhgVtBi+mueOJxthV7YByvIUmz0bfef5BO5A
 ZAWG1Jq2qNhGrgED7vh4Yp2nReo/rGIxdy7Pjdufgpt6vVcFg0r4dA5mqK9dr7Wzxm7H
 uqVEmrzS5lO1lCPuhGpbfaBSIns5kuiaFg254nDDW3fVO/5Mygz1vVjFt4x4jQmkVLmH
 oxCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNQVtvjamBXe+etJDlXp0zCyqgMZL3DryLgrk5BCzjgJ+h5LXcf7sBTCTn+Sr1dyEw3ndFBLdxEzm/@nongnu.org
X-Gm-Message-State: AOJu0Yy6PhZYNdgISEi1qiFNNjj9ziuW3ry3JY56fcFinnMzIeh9teRV
 AdvL4DiTHZACl87hunU3M/Qlh0f3yFJOcVlFx5sIMR1gsZ13z3yfkeoTIXk8OWI=
X-Gm-Gg: ASbGnct60laro3P9cPih/8CyJ+leNFQv5WCVFwEqbo/e7GexRyrMEWjh7yQV/8SMiKh
 gWoQBC5N0q4tBVAa5rx4NApceUFeIbP9Q423Pe+98qqr86mpWpIYFolN3/YDLescJSYiQXgqPRb
 zXKgFnekzT1fJBCqdCGQA8rVH5jOYfc9pz2atyYO257XmUrMmIxvVagnJn2AcHnyshn/4oIuA4O
 ALJSelc808esZ3STdKPSFAB51eoYOzZnfMiPdaiQqsXXLeOrKGcMTLinMlFn5VRD0b19Q==
X-Google-Smtp-Source: AGHT+IH/+ws5mW4s4Xs7YwhKQItjPFgU4zZQ/kr9bkcZxxWPvWUeBHuWUUofFCVzECXsi4R2DqrylA==
X-Received: by 2002:a17:90b:1f8b:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-2f2e95b07c4mr252742a91.9.1734467190147; 
 Tue, 17 Dec 2024 12:26:30 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142daea53sm10450415a91.14.2024.12.17.12.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:26:29 -0800 (PST)
Message-ID: <65ef199f-80de-4b47-8364-821661a6eb2d@linaro.org>
Date: Tue, 17 Dec 2024 12:26:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/46] tcg/optimize: Use finish_folding in fold_extract2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 955151f4cf..a0ccf7f3f2 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1754,7 +1754,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
>           }
>           return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_exts(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


