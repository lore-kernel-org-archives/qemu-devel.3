Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEE5CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uYH-0001DT-4h; Thu, 09 Oct 2025 13:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uYC-0001CE-3y
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:35:36 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uY9-0004Sm-QW
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:35:35 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-339c9bf3492so1614837a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031330; x=1760636130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sTBhalQdFrowqCMHaGpNPS1Ntjzk9O5yHFI/YTXvADI=;
 b=lMryLf24L76IAYWK7qH9k6DYdwHeS/1Z0XlgEQ9RvYhyckE2zKA9YYexqzyzCauMY8
 3m20b3XYSsKtwLd7okzUGnbHJQFqa4iwDYU6pIRiUVYFwKils1fZqoDnCN7JWrlQjfk0
 Ir+LdLefXLuy+9hXigDGiZS07SlBBahNg/mIf5jO+uvlYG3iVeIODTH500uIsw6r368B
 TxUJivVlWLYLK2UgfJnN0yh5U9bQlqsdfQP/zRRZdDgjiA/bQ0OPVBFqeeYsaeOpuFxa
 7Fx+Jzwg/2OT0oSO/ps3gyzGDc06qgEwUferPd8iZ1hBYZFsnXtdjnqtj8ONhSZMZEhi
 2oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031330; x=1760636130;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sTBhalQdFrowqCMHaGpNPS1Ntjzk9O5yHFI/YTXvADI=;
 b=HEp/KW28gmBGuU5QcFA9LYQdSX26U634gqhDGokJWt6BTatQTRqvEQIIezNh29+l+r
 LnbYa8E09J3+PnfX5++U9gk6bV6GmcA0YoxWlQOKqxjAeoxObPuAECh01+5YJTZTaBmC
 a4UuOP8dUE/kkBw1OTQ/JDJmPPD6dKJC1ZpkHPpKJwxc2Iz2ZA6s9duJwrpl44ed68+s
 zQNH5meyCv7PMALR+fucsdrAt1t1tnxohq7UTGFcxdqNsop97BkSZpgU2GT9mMnS+kfi
 dd83QIps3jy5Ptxu2GjTWOa1g/gpxRqXkMqPGKZE6WSIMQOi5WqEVuwLKyCR179kOmFA
 hInw==
X-Gm-Message-State: AOJu0YwLnORnVrvOoakH6JC6A5GRf/1VZHaOXAdmFxmgbd2xfWxB+fAz
 r6WJBo5LbopEGJEskKtzYWzM5vdDbVWUIvRNDEUd3eOzI85ZUzF3F/ILh689EJR2+wGgIjwkCqF
 TF8azdWs=
X-Gm-Gg: ASbGnctD55ozLhkc0rD/gqGfvKsvkNgFeMnm89H2pzDaUU10MnJC9hI7V825pac3aXZ
 7vpdcQz60MoU6hR5dL2glfUn87jBt94wFVaVODf3PXcsMV/AdBFIR2ynwaxrcxEOCTTjL4/YLnh
 fP6HnLDyzGS1I/642dC3B5t2b6jdFssUeeSCpOT3MP4MdVsq360gw8+ksnWIAi7P6+lanI2Ciwr
 QYqA+NBT46dcriFMCWfKS1up5nLjKoBvtPsyjCoI7anwzlJaGKz3kAL8s/kcPC8pNoLtzz0ejin
 mwkIdzleYjNnVQKmDe8LT+sdv2Y9xSIC0kuXhGLG2kqG2cJ/oX2x9HySVXfq3YtWd+tXvv0dk7N
 6Rs2FPWjEqXgMnKMxx/qRrzfqNaGNOnLKirA9BXGbyonSXW8QDjJB0v5Btfh2EJI4
X-Google-Smtp-Source: AGHT+IE4Xg7saq7+zgLKx2vSh4ACKkvHbYOua+oZrO8Ht8LIFrPHa2JvCQLgIqwiqkkVxmAzm/aJSA==
X-Received: by 2002:a17:90b:4a87:b0:335:2d4:8b3d with SMTP id
 98e67ed59e1d1-33b5138625emr10501869a91.31.1760031330050; 
 Thu, 09 Oct 2025 10:35:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626ec2f9sm107789a91.25.2025.10.09.10.35.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:35:29 -0700 (PDT)
Message-ID: <cc2764ee-97c1-4451-a49e-f3af41bcfd29@linaro.org>
Date: Thu, 9 Oct 2025 10:35:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target/rx: Replace MO_TE -> MO_LE
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> We only build the RX targets using little endianness order:
> 
>    $ git grep TARGET_BIG_ENDIAN configs/targets/rx-*
>    $
> 
> Therefore the MO_TE definition always expands to MO_LE.
> Use the latter to simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index 01a065f937a..c83e7afc60f 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -74,7 +74,7 @@ static TCGv_i64 cpu_acc;
>   
>   static inline MemOp mo_endian(DisasContext *dc)
>   {
> -    return MO_TE;
> +    return MO_LE;
>   }
>   
>   /* decoder helper */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

