Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D43FC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1S0w-0004g1-NQ; Mon, 29 Apr 2024 10:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1S0u-0004fR-Sc
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:29:52 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1S0t-0002tK-8G
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:29:52 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5883518135so514837166b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714400989; x=1715005789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RVpiZv/vXCeeCon7h+vC8IOmNUbbzhqpvCFWGm+H+Rs=;
 b=SJp5KD12PbiLKsl3nVIweYOsF0JQsUMeqcf/vWXO5XuWe11FZuyHunD0TdB8RZgtzg
 5aB/w33Yq2jtDYFXXXs4lzmZdyxEueiiZ2eQzHU6SKRKFXR4FpxOLjFt7x18ut8lTydq
 5szHqyvSogI2PuGCMzYwao6CwdmbPyujc98Imag9RCRYdYSeswSDftCYh/0zgixT3cRD
 TSwrdRjIBpUOMlvdQiA4RfZeZmM0QRppzn9npqFDcYlJSCGCldRBL7x7JL1SOM/MGdOL
 7js5Hjwziex5ND+1crLumbMGUcXbobpjjEAUp8WFwWxF/xlfj5bHnaTnETnFe7ipe5YS
 NCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714400989; x=1715005789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVpiZv/vXCeeCon7h+vC8IOmNUbbzhqpvCFWGm+H+Rs=;
 b=rbkdyHDR8TyVJqe8n3ks2pKUy79w+VtALxW4bg7ge2SC9vFf3TJXQfh7b1yRxabofE
 M4uWIzV5wrVTCgRhREA+fQElqX8aQUnc0gFOjIrteVvwzIEGfpYrCS0CpYnGGbXLUZmO
 I91kP1uyg3y7js7ezfqPvxQgLbAbyrPavyJZe5aaDY8jamkOSTUBH4mdc+W+kVIy/cTb
 /5u9wxcJEMHsu1ou2coHjYto2FyeX16Du43OYOFirbfiwfMZyrVTrac1pnb5azwXCAVL
 ruCsMf8yzNjscKjRybkfFgQEqd6ca09B3XBzfcr0Ee7/kzUpuAJD5EE2PG8duV6EEVsQ
 ONAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd28gG2hs7Sg5VvX7y3DlNHkZayi180QVLjVzHuKnnNX3OmUzmhQBP6AWDlHdWLwWqhtgnVTF8u4Xn7L2Nmq50+bffaYM=
X-Gm-Message-State: AOJu0YwV1QJq1E81HHFtEgxt7+kFJOWPL67akAb0qAWofkJfL2yvMfXS
 mIqzHV1q5WwBfQmhjM2wNB5edxDhdIWF4klqU4ZNhBdW+rmo9C12oRqwp+jw7pU=
X-Google-Smtp-Source: AGHT+IG8rK7njbUt+MECnAH5izY0gYADh/8847cRn6gpQn/f1Z56bJ2V7fPDpeIKUgPZUA90VxUZmg==
X-Received: by 2002:a17:906:2753:b0:a58:84e9:c669 with SMTP id
 a19-20020a170906275300b00a5884e9c669mr4082612ejd.52.1714400989449; 
 Mon, 29 Apr 2024 07:29:49 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 lj25-20020a170906f9d900b00a58d0a68608sm3990256ejb.136.2024.04.29.07.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:29:47 -0700 (PDT)
Message-ID: <0d3e039b-5900-4ad1-a103-849b17a380c8@linaro.org>
Date: Mon, 29 Apr 2024 16:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/alpha: Split out gen_pc_disp
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424234436.995410-1-richard.henderson@linaro.org>
 <20240424234436.995410-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424234436.995410-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 25/4/24 01:44, Richard Henderson wrote:
> Prepare for pcrel by not modifying cpu_pc before use,
> in the case of JSR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 41 ++++++++++++++++++++++------------------
>   1 file changed, 23 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


