Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EABC5AD4E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 18:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtVc0-0007aF-Gp; Fri, 20 Feb 2026 13:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vtVbx-0007ZZ-9r
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:52:21 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vtVbv-0001gZ-I6
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:52:20 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5670ea44187so1807555e0c.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 10:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771613538; x=1772218338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MfZaD0WBrjXyuFc0ZY6u+e6s5SbK+Mu7vMgh0LLtUDY=;
 b=ye7AC4HKsWrrwYCh8cL8K/bo4HYoGHZ9EGoAMcIv/QUtcqNBPLNaYv2ankX+wIMkK2
 5KNOzThOM0KcwFuGmhEnpUVWjU+T3s3UdROUiNxT7SPqZvIv9yVE45yDu9nWfWFi7KlT
 ZHjzMvK+tukqSbvbmaPm/xx90vyER164AedjgqahaOYQhQTNkEu2L2oB3P2CTQ6fQQ4A
 1mC15UrQ7r8+RlZijimi/y66HWepnGry701ekyc7xy6TdtDIn2ZmqD4q2Z9ZYlak/dVC
 VgI6Vu3hpI8ur8sM4/aEwc10X0IYA//CQuce5c0sT22jiWSkhj2cvkqG7KmV/qyIJ0zV
 Z3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771613538; x=1772218338;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MfZaD0WBrjXyuFc0ZY6u+e6s5SbK+Mu7vMgh0LLtUDY=;
 b=QRrzxRxo/rlWh1Ty2DveHVWDS2hxFaWLIAgFJWShtGBZNmyBs6iXnwlmzBPHHqNA+u
 sOiBW9fXK+/7dDklt75EZssKENZ8cnHwijvooP13KSdS5wn8yySsllX9jQwrsbByMVHo
 sCQVM4xy72+7bENLZGmon1fLzUZk+WhZIQrOdio7hd9Ym6hle+1GjMtEZTbeIaeNLUp8
 TN2ugsT11JJWzLFZwosY0QGFfqipdDBX/kGaxf1DReFSoQ07tYQwtDQ8SkW4wGeR2e3n
 6CUVL+rNcN8oUyRwVYR4H9H2CA+U2Fn337h6LTSajdHVwU5oSEX5uq1ZQC6X2gYleGsX
 GU0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGlzjKMvcrNKIKar9J857SeXG+aInFJ8TX8HwB3DNexzYGf0LS6W6gNcNOWEhP7hCgTx7cgZ3lm2ma@nongnu.org
X-Gm-Message-State: AOJu0YzpNafNo/SjYmujlloc290N2v2E9DhUXVRMBz+03WGRDcd+c2W/
 jy4aArShoPi6BAlSpSrjEpsdrbF69m76UAbgLb3jrUpA334a6qFjOs9s+qNZtB7oVaY=
X-Gm-Gg: AZuq6aKOOORrljrUJ29wm3OWpMaIkI4AQi+wSXF0R+1aBiRHqnlVvpE0V7l9ScI6YtS
 GDVKO3zc25yhQQW4QIS2yxrEn6So0Ft+6hwO9kG7HR7FTr0u6K5hBvtSgqk+TzLKn8OcekaKgB1
 6ZRZNAT5X5a4WmFA3nTNUZPQyE7uScE8+aPpiX1PbiJq7wkqp7XkBkhEaf3NqvU0HoIjJ1e0phQ
 sVpIiR8RbYa7YMlIIda/777XOapWZT/9ayQgMk9PiKirDvHgOzFvDlzctVP+idw2SpFE1rNlzQq
 KuxWLgyF2ltMgb2tD1LXqHug/N6El8RSl9u5LKX7akXd13EHY6goqgHvZXru464hCmtvS+r6Lsn
 T5x2OsLkw4QggNrQFe+/8zYcr5Tri92k9ytplzK3ee9CTQaWdDjNxviFvgkqlh/0VYxk0+vnEI1
 VRAfmdiyhUWrvaSW1vSUjUHZ+2ZRUBRUi6DKNY/tNQ3EewbWKmCdYO/Qt+paTA8tSRf5Hg5TyRC
 zM=
X-Received: by 2002:a05:6122:929:b0:566:2fc9:6c89 with SMTP id
 71dfb90a1353d-568e4881907mr432987e0c.10.1771613537809; 
 Fri, 20 Feb 2026 10:52:17 -0800 (PST)
Received: from [192.168.0.103] (200-100-75-206.dial-up.telesp.net.br.
 [200.100.75.206]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-568e57d42fbsm160239e0c.6.2026.02.20.10.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 10:52:17 -0800 (PST)
Message-ID: <d5839ed8-dc2c-4c90-95a5-d5442099911a@linaro.org>
Date: Fri, 20 Feb 2026 15:52:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: set the correct TI bits for WFIT traps
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20260220171945.1065102-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260220171945.1065102-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa33.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,

On 2/20/26 14:19, Alex Bennée wrote:
> The WFIT trap should be reported as 0b10.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/op_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 4d708635068..aa14f15eb62 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -448,7 +448,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
>   
>       if (target_el) {
>           env->pc -= 4;
> -        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el);
> +        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);

As per the AArch64.WFxTrap() Arm Arm pseudo code:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

>       }
>   
>       if (uadd64_overflow(timeout, offset, &nexttick)) {


