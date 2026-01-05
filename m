Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9D2C2A076
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 03:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcbig-00031E-Kl; Sun, 04 Jan 2026 22:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcbib-00030u-NQ
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 22:57:23 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcbiY-00033Y-Fe
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 22:57:20 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso10852867b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 19:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767585437; x=1768190237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rU2D6s3bv3SHIvLvjTLhJ4irZ9dwH+gwk9ZcaWu//gU=;
 b=iaXSHLIDkhnAvlmQwj/zdfQ9l+7ddgKthZSm5RgLaQlNfIDp8RARVhsH3Z4Zs5rzIv
 xWMzx1QowLOzyyRjusRk/USEvPABtIPDx3nXARhf973YqH7S4gZxqxMCwGM95RnXd66K
 coVuI5WW0cC18uHBHufPPdYUZ1M7+wT2T0sWPceatz7BDLrIXdxN0+GFiJQYnd/acb1f
 KTBXjk1cEL5rJNKVaDrun6r73/GUbbcMlEJIwzllSekfv4k+MEyt4zSksU1mOpskDiTM
 NCQsFVW7e9U/QN9HL8ewpdQAfLlrQp2TOBiXFF8zy7v8YJ8AgEcMmNX23eWOt9ttYMGJ
 E9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767585437; x=1768190237;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rU2D6s3bv3SHIvLvjTLhJ4irZ9dwH+gwk9ZcaWu//gU=;
 b=uW0HFlIR62hjh7TMEW5u3miaqeT/c2HvEjl1GCtn2NDEMatx386q/scQ1qvPTuA+HU
 b5iWkoAFuzauHcnHwPLph20aFOv7+vkaeedfpEPjOU2S3+kjNw1z5uj5OYJOZKRnM0W7
 mdEy+Hgp10q7LmCesCuuzEAGov1N0C64iMyw6V6Z/XEdo+1wZNcrHXk1xd/f0NACeIGd
 rHVOwTPWhWml9JIInjvbg5ueHRkByeqUWbQzF9C//BOzEQwE6kfhTGKPqAQtkw+/OXgm
 D2ryNE6Djh3FjaGgn+LtE1B7Et3OYmQydo8xvTx240uDAtMboiW/uiuWRf2EX557SHey
 dxXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUZZ/xaV3noyLbFxoygl5RwczS92mn+YyZhKKX6zigdwJzG2JjKJpzO8/0RpuECVMnB89qF+XHb7t5@nongnu.org
X-Gm-Message-State: AOJu0YwOoOXrINZouJRHBmvhuGeCdpWpq6jV/Ro1AFkwZnZwE7yi1W7k
 Y7F6+nEWPHbI5Y5X8633F4e4beWddS/axscJPtxkfkmZeBbjxj1BKugrff8ogDgKOuA=
X-Gm-Gg: AY/fxX7KP1dJ4Z4PqEjZ9klcxr2AnXrB1XHi2BZ+LubGcuv153ejhtVTZZZ2lBTonEB
 n5qtR+MM0qIM7gStDl432Xsvfo9N63vWryF8NKbwEcbxVh7Z2aGeTxELEviwk2uu9QYECQJVJOH
 ciKKiXp3mf1Fjgm30++YMCWOWuTNhsFhNfMdf0eIv6AKXPXVwTChuV2/u0NsXQ+aUv+NKsWJ+tO
 +BEei/bh+MflSi+gZQZxMOXeeWmZTgAyFFS8pHL69FT5mvHnWO5V2KEk4p4pgxzbrMmvvPhMyED
 MQrxO72UEj7yaiQc1ki3uvZTQnIPFR9+jG+rvCD25NuTMlHZ916cTA2mB5GS88//WjL0VYwjfrl
 7X30ZO+OGbVT0GMR6pSNTypxFbuXAe/ydAnpIzNjwsgvmM9xQDeClTUwslTEDeWRMZoCwfUozPD
 y98jx8EK5H6tRZLy3DY/M62WX7C1Likf12WFik8c7f
X-Google-Smtp-Source: AGHT+IEE8lCisGE/vBsBznbOAEEAzMVwm3NhQKj7+qwPy4enAwulUO3gor+7WqO5v2ItHJsNwEPk8g==
X-Received: by 2002:a05:6a00:409b:b0:7e8:4471:8c5 with SMTP id
 d2e1a72fcca58-7ff66277f3amr41504741b3a.38.1767585436482; 
 Sun, 04 Jan 2026 19:57:16 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a19besm45890267b3a.40.2026.01.04.19.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 19:57:16 -0800 (PST)
Message-ID: <e896f199-ae5c-485f-a8a4-75763a3140c4@linaro.org>
Date: Mon, 5 Jan 2026 14:57:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/arm: Don't specify ID_PFR1 accessfn twice
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251231170858.254594-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/1/26 04:08, Peter Maydell wrote:
> In the definition of ID_PFR1 we have an ifdef block; we specify the
> accessfn once in the common part of the ifdef and once in the
> not-user-only part, which is redundant but harmless.
> 
> The accessfn will always return success in user-only mode (because
> we won't trap to EL2), so specify it only in the not-user-only
> half of the ifdef, as was probably the intention.
> 
> This is only cc'd to stable to avoid a textual conflict with
> the following patch, which is a bug fix.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 0f150c8499e970bd ("target/arm: Constify ID_PFR1 on user emulation")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

