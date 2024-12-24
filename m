Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4434FE7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtj7-0004VT-8T; Mon, 23 Dec 2024 20:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tPtiz-0004Uz-9p
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:28:41 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tPtiw-000216-N2
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:28:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso42628585ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 17:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735003716; x=1735608516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K/RTG9Slqc+2ICwCP85x9jyF8ogOwsIe/r/+ktEcz9w=;
 b=bM8MVxUpohU+Wdni97BDEKXd1CJPk2rIhzpcMU0VQNoRF2tiLgmK+oWR/QVT+Yx1rZ
 zaZr2gmE51GvSLYMG6WgblrVpeeR9xlj333VELqAiCcj+yE0XwRPj+x/MX0LRg+FKJWk
 fhycwD9hXzL5TQmjpdDyCyCPRc3v+cOLqFbPsUw5d/5BLFyZZPT1ONSUz9131Vd4H0Lt
 ud4prAFhqYhdjwz7XbIgN3Ka8aRvcZgM537JwH/3D2lnDDPLLT/U9HTdxltmqxyWr7Q3
 w8bLjJrAs3JPNLYll/a+DHDMhjAIeJH7ceAfpqKWYBXZyON/vsUFwfSWLLkEHDOR7xIF
 QN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735003716; x=1735608516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/RTG9Slqc+2ICwCP85x9jyF8ogOwsIe/r/+ktEcz9w=;
 b=HxGYGIAGlRptPYaKb/ANqpp6U0S67aAie5/A/jSPJ7iWHW7m8XCJG1fTWcOp182jsU
 nNX1bz/T8tfR4CINUnH8JDdJ8vpTwwLtnLqF8OLn19dM1HC4IzSq4VKgUAZkOQljQSp/
 N2pjOB+rH0pJh9jFKDMLxIVcLnAxeDfFdo9k8YZABdNQ9jkHic7dQWe4OYhVtBCNquqV
 DqQFEbAPaxW7275/1wxTLWafkyCls7YAaMLxu13wNxMYURQ3dgolpiwbR5VzsyuakzyS
 OLkKQKal73hzpKyVJDFsCmjYoTfTOse9gpBQ4LMF8NNuJ5oURjeQpuFbY4EQF9hxAxYa
 wosw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWssSwTbJwtDUDK8+La+s2+B8G5GtBWos3aCHrKD5PGgNHxwy4wMSiBEhtmE10QWK09dbjwWZTXZwQr@nongnu.org
X-Gm-Message-State: AOJu0Yyld7HwCDUAluB0FKwGbwWABd8FhH/m2MaJakIgefCfc6q/QzBD
 HITbH6PkVDF1FaZ385gW+tkJj1MCFv3Z5qMQQoRsh9uRkleIZbrukN+f3xLhz2k=
X-Gm-Gg: ASbGnctSXiFpk6gb7+REVSd3uNNqmz0oDalgpRcX4VJz/LnSn4MQS0ISXSRECxn856v
 iwutNa1E9fdGX3zn3dFj/QOFujCn4c7t0R77Rl1s6WObAS1jP2b/kNAYNAYVA1oPD//ZeK2ekqa
 4UIXP+tBUgjUpAjWHBQ2qEdUdaxaF9U0uBu/rQMJBVhsMpuck6sblNReY0rqsuhrClbqPVleU9k
 B6fmeLiYkeCtilBUPYscIe94GxbaUn+pJMSvpKQe8SmwGV3WjoCL969CBcmF/MGs+lilQ==
X-Google-Smtp-Source: AGHT+IFtj5TKZR05rd6gk3sMeFEFUZWVIIyFQezfm8pPVYvVJFpPSPaV+jJA/T0ePoEQvTWmQvjpsg==
X-Received: by 2002:a05:6a21:9103:b0:1e0:d766:8da1 with SMTP id
 adf61e73a8af0-1e5e083e4f5mr24051702637.39.1735003715872; 
 Mon, 23 Dec 2024 17:28:35 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad83616asm8581747b3a.76.2024.12.23.17.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 17:28:35 -0800 (PST)
Message-ID: <b7fef366-64f3-4d4f-b2f7-354d9feb5ad6@linaro.org>
Date: Mon, 23 Dec 2024 17:28:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 49/51] tcg/optimize: Re-enable sign-mask optimizations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
 <20241222162446.2415717-50-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241222162446.2415717-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 12/22/24 08:24, Richard Henderson wrote:
> All instances of s_mask have been converted to the new
> representation.  We can now re-enable usage.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 902c219032..607697e19c 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1780,7 +1780,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>           g_assert_not_reached();
>       }
>   
> -    if (0 && !type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
> +    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
>           return true;
>       }
>   
> @@ -2489,7 +2489,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
>       s_mask = s_mask_old >> pos;
>       s_mask |= -1ull << (len - 1);
>   
> -    if (0 && pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
> +    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
>           return true;
>       }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


