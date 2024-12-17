Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75376E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeOI-0007LL-0z; Tue, 17 Dec 2024 15:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOG-0007L4-9k
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOE-0003l9-T0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:00 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2163dc5155fso50456525ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468115; x=1735072915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bXw2NVhNNsBooIkpPgRP4n+B6JxrueiTLf2ROSA1Ilo=;
 b=pO2XjnD7pPcqZbLpwQFx9xFZL9KtOkfoVCRLfJD+akZZWz5zQKF7LNc6hsOdklSZjE
 ujAxr361egsuK8bLMknyo4qwVmVd+wB3kmFKq4WrkaWJ3DH1p5z98rW8oQgw6EKzONgc
 StE2QeEy4Nsr8dZZJy+SIwfvQW13YJeZAhkET7EvYbjhndEmA4xVL0LK+2JrLKXJxdxc
 0/ric8r6B8Ucfoak2WojELU6KR7/drzkGjvTy+uhj01xjXQ+jNg9XD4NrOdBApnSg02i
 U1MRVLy7Mu7ACrKbRi86ejuIYz/vkoHAsiyADXf82a+qg9q8X9wYjO4wJ8yTe0+4+tKT
 MIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468115; x=1735072915;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bXw2NVhNNsBooIkpPgRP4n+B6JxrueiTLf2ROSA1Ilo=;
 b=ubtc0POYtpGpem/29ewCtgtXZzKJjxHjcyJMTcQN9KQ4n6H+C41aP7N08JwShxnGdz
 zDWpImqS/NTe7lPpWJrETE7gVzDTyac7Sj19rh6cqRQ6+O5qhUp4l3OihiJVf57ArYC+
 rtCiS0KPz7XgTbaYCBTYdhqhtn1p/kjYzjVvF9cRATMaFaiAugLqUG5TEcySG6U29lRk
 jzUZw35sKV2faZafovEX8Bp9jNN69Vo7Ph8Ow8Borqu0qpU1F1N5t1d9M2lkoaLjRyUC
 3gBW3fRJyOX8f+IBfoG8c2eKEdzDNJbevgOtkg4RZdV2fj+mWAAe5yzY6kt5KfNmwgaL
 iCcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+HtlwhK7qQN3SDY/q9Fin9ihnuIiTmUX50ci1x7AhnKGNEDIXLz9oxHSbXoUGNsiQgdFSoVepiaew@nongnu.org
X-Gm-Message-State: AOJu0YzTvlfBwiNhQPyrVLtT+sLI06g01aOx2sOoPPDASa5/vZnHvdad
 BdM6gCLgMuxp79UYCy7E8dt2TEGhgGVoGf/4iMbxr+HhVDNRk08eGDa3ddJ21zAbkZeHMdo01zs
 uezvNvg==
X-Gm-Gg: ASbGncs1gKTqU6LcNkJ/FRDhdL4gMl1mCBJq6XlJ8tV27C6jpcLm3D7Kcy6Rot6z7m0
 9AaZAdpjkt1NQj8hl5BMmqx9FhnYuI5mScdFQcZfilKQ+aai0gysiSCAMBJAheBhcW+AWJMnJgW
 hzW8To+09uvry3Q3X1kz00om1yjIaTq1S+VISL3EqcHoK25k0ZNl1RYdzqghELrA3VKrSe5+HVm
 mHjdIfR+IBpjr01iP5EyCZjxZL2Xip5XFlC66EU6StJR8KM46b0m8ci7bg1pyKw56CArA==
X-Google-Smtp-Source: AGHT+IHfqYHkmLPOQ+1jqgyp7o94/ihLhT7z0nPOAoa/09W7R2b5haclFetAsheT1VODwVW83HskqQ==
X-Received: by 2002:a17:902:db01:b0:216:5867:976a with SMTP id
 d9443c01a7336-218d725b7aamr2963565ad.45.1734468114757; 
 Tue, 17 Dec 2024 12:41:54 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb99dsm63730425ad.87.2024.12.17.12.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:41:54 -0800 (PST)
Message-ID: <4cdcb3f7-50f7-4c7c-99e8-059706635bd6@linaro.org>
Date: Tue, 17 Dec 2024 12:41:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/46] tcg/optimize: Use fold_masks_zs in fold_negsetcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-33-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
>   tcg/optimize.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index cfd4c08f11..0097502425 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2369,8 +2369,7 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
>       }
>   
>       /* Value is {0,-1} so all bits are repetitions of the sign. */
> -    ctx->s_mask = -1;
> -    return false;
> +    return fold_masks_zs(ctx, op, -1, -1);
>   }
>   
>   static bool fold_setcond2(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


