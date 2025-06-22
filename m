Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9D2C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBD6-0001zv-VD; Sat, 21 Jun 2025 23:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBD2-0001zZ-GI
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:17:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBD0-0004j2-A4
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:17:31 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c33677183so27556205ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562248; x=1751167048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EVk2Wv9Pr+J7COFwPvJplGOSW/ggGT78wPyLbVot9Ps=;
 b=o4cuAz+Ggi2Bt/EoJYx8X4nH0JjCBy3hpEqsT2BhO+PNfeLtt45DPqgWZg8N/mhxYA
 vI0e/eL+yf1h0cha+sh8FsaCnbrGNxc/dMdkn1+4uidKsrfKqSbnCAPFkW0i6osr1ExT
 /mUjZqna805rhBY59NSoOMJYwIpzO7XZDFcCo/++rvFSRrDzVcbMeUjV/mvbVIXUNvab
 Sr1Mx43C1/JaL5P/H5H1Xg/n4SKviHD3A+FtmAUGkfuoBu059ZPSg5xPY8XkOPNPg/SS
 lvGkOmOD0S128Q5AUzI/FO3zFwl/hfUD9b0JUWvam0rlHFEX4UjSuYHCOChIeloVyN73
 r71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562248; x=1751167048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVk2Wv9Pr+J7COFwPvJplGOSW/ggGT78wPyLbVot9Ps=;
 b=risnx0IuRvNg2cRFK8lKY38kqZVSGIGmWIDQdwckmUx2sOq8MlkCXLP0bg/ZQxsulC
 xOG5PcDu8GIu2C1oux4KUQC2HgOMva5CZ8m1FD5OgQAb3rQS+83WEoZb7AKNj0XcSYQB
 SgZNyf929cL4bayuPpNLkDmqJgMslpsZHTXEIf8oIDYeuTuQuDbTCwCcdJsHKAQh9WjD
 sa0n8DYVwrYkfuIZYIQ4BEIYmz1VxazxLTqc80h4S8Y4Ye3eOMSKJ/23oB/7AP5zArpU
 ZtqJz1d0ahyNOkaP6bqJzO4bghJyfIyS1rOVJyrcOep8FX53Ac3SxCTW2bInJQxzzdD3
 zcjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOOT+JFdWrWvtaTZU4ixDfh3wPBhiLfDwgIEcqmwJ0QsvIsiK1SmM28U57G97A6uHp/hYdhOWj9Yb7@nongnu.org
X-Gm-Message-State: AOJu0YxO396etNDjJf+P6RyyGlPxHRWVZW7oqI9PA8YXNXrOdD78R3+C
 XVU73wsEVyK7eb/op2ewdDpHrzD9x1r6OKeja3yRxW6WM7KMv2O5zeRXfWoYzm46TdQ=
X-Gm-Gg: ASbGnctJ5w5BakNVaibUTYB579zIgRdXDyu9xOt+u3p80pRBDef1W3e/wQgbXQc6VCx
 Y1O7tcZsjeKv+ouDFhQYwUEUpyeUiF6Ygqy5wo+dJaISNtTXL/xku7PRtR3+Q3f/Cdc3mUvWSNl
 PBHIyby2VKamxc2nP5G0YfbKUr7f90xVmNgmtXxAsr3DmupDhhMFgZVj2rKdA1dCyJEgiTeHbZn
 bppllXCUl9W0RKZAyvEiBNvYr3gr+Yuz/QwqxhVQcWhMOoa2WakkLLs6sYLmrNdX2lPsfIoQVi8
 tSEzOJEUhxI7sxz7rcIkjPo/bX4s4szpq51eHcjGUmF0yt3YdDYZmFoV4s5katq/tLL316+blyf
 /P71/dTmaHneNfR+NPx4trVs8v0Py
X-Google-Smtp-Source: AGHT+IGnm90Fqy2nZAeATTIqwAbDd8Q7ISSJbwbY1QvSI5yb1zlU8jD+F7kDnmxiYPXIqnQNEOPzCg==
X-Received: by 2002:a17:902:e88f:b0:235:f3df:bbff with SMTP id
 d9443c01a7336-237d97674eemr121830285ad.4.1750562247741; 
 Sat, 21 Jun 2025 20:17:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df812e1sm5430847a91.16.2025.06.21.20.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:17:27 -0700 (PDT)
Message-ID: <f2db3aa4-c88f-4ac5-86fb-097d6718c1f8@linaro.org>
Date: Sat, 21 Jun 2025 20:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 30/42] accel/split: Implement
 remove_all_breakpoints()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-31-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-31-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index e1d91ace2fa..0f3d48fc68d 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -269,7 +269,16 @@ static int split_remove_breakpoint(CPUState *cpu, int type,
>   
>   static void split_remove_all_breakpoints(CPUState *cpu)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +
> +    if (hwc->ops->remove_all_breakpoints) {
> +        hwc->ops->remove_all_breakpoints(cpu);
> +    }
> +    if (swc->ops->remove_all_breakpoints) {
> +        swc->ops->remove_all_breakpoints(cpu);
> +    }
>   }
>   
>   static void split_get_vcpu_stats(CPUState *cpu, GString *buf)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

