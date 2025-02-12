Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A47FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiHEG-0005EK-Ar; Wed, 12 Feb 2025 13:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHE8-00050E-Tc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:12:51 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHE4-0003RL-Mi
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:12:45 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa40c0bab2so145854a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383963; x=1739988763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6EebdLKQC8jKWgqGaLEWJbkkKWXkq812mFkBTiD+VN8=;
 b=wpFfxAnDCtv2770U1wV3zX92lGFouGP/wZxwjl1jXvUDg1cGW5kQNzfq1B4NBe3Hvg
 /n+dlRtIjGyb0ZqfaTPks557t3hxFeVa9mMw+AvY36MI8qVzZhn6drVw7R/YqC4hzvKU
 9GrDo8cJXL5bdJEVg13hwTIvniiKpclv/y12BKS0IOS5EiUEvhC9qYxIGYbyhlmK3cms
 lHWLvaQdVrYh/Ln/YlWkm3FMpzmH6CjsAVX2p+tsyoiQr9VPcOixQe43AkfqaQu3XnUY
 mFkmWjOHcVyxWQUO5FjJdR3fxGVlnvPAUYzhWlYI65u+469XtYyS0TC+wTH2nXHYC6qs
 iU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383963; x=1739988763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6EebdLKQC8jKWgqGaLEWJbkkKWXkq812mFkBTiD+VN8=;
 b=U/7pB6k/pegxdHRMEm4VjPqg9rPYhqh3iMTAft/aABS7qhtvW1F+ofMdnrIEgd+fVo
 iUKuiW1ukiOndv/cOrHoOGCh/+ccQrbLNpVhaNLv9gPuGjds7HAyDrrjLsaHw2pjAwSX
 YjIoedBVKPxPA5y+dDWd445/s1mkMEbhMiaMZLHYTSmARcOXUmbSB4lc4nTLYqnix+/T
 JlZvhptPjsbFdD13ktu6zLAAfXedxIhSq1OCvaCiJPlxcx9lLgmY8rz8erpyW02XbrbP
 tzxWOiwbKf8xwWPxktt3uszbzA7jH7/7yDCXAffgUC0Jj8oTMJ5l9CZZOH3N7piFjBim
 V3/w==
X-Gm-Message-State: AOJu0YwIQaQfHvsoQxOw6y3zfVyUsjid7oWn727QTifMLU0RPR4fqWww
 0WtD8ztDQoZkErzfMGoCY9+AiVbQ1iE6j2AQcOFZnPvm8mbGP6/4ghzzQWigTPRZjyjVDWE3ro9
 q
X-Gm-Gg: ASbGncsc0uOSi7oqKUnDruuyCr+F5luNoo+9lX6tTtahoo9tSG7ReHTSI7ddiGHEXvv
 vSCtuKFkBOY8vZadxVnaqo2amc6WHjktj5ldUOjpufhRZC8cNE0sc+IOxXXn5jO67HrarJJN3ZG
 qn+29bLjjCR5jNORSxIvPDhZnqFY3lpHOSlWx6Qpsl01aztdrItSz39e6I9k7YbjBjH2tOjbsvf
 cF867K5Q7FgD57uqPUm7FpVivfX0OdxkIirtvS9AHtda5zqjmlZpj8rWybz6YPxuQDBnKKba4Ql
 xhHadMXsmu0pygxADMTxQcwx2X+r5yBdaEh5NKH5U3MsBUEtS2QAa4Q=
X-Google-Smtp-Source: AGHT+IHxwV3IF365hdXtJmBC6WPpRXilCYAOqxslTbMHXXuU84oOLGcbEm0tLS/Qp63OlyW9uBQ4+Q==
X-Received: by 2002:a17:90b:5444:b0:2ef:2d9f:8e58 with SMTP id
 98e67ed59e1d1-2fbf5c73570mr5641414a91.34.1739383963143; 
 Wed, 12 Feb 2025 10:12:43 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98986ccsm1808587a91.4.2025.02.12.10.12.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:12:42 -0800 (PST)
Message-ID: <ba6d579f-9bae-4bb3-9fd6-7645230fccae@linaro.org>
Date: Wed, 12 Feb 2025 10:12:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] hw/arm/highbank: Specify explicitly the GIC has
 128 external IRQs
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> When not specified, Cortex-A9MP configures its GIC with 64 external
> IRQs, (see commit a32134aad89 "arm:make the number of GIC interrupts
> configurable"), and Cortex-15MP to 128 (see commit  528622421eb
> "hw/cpu/a15mpcore: Correct default value for num-irq").
> The Caldexa Highbank board however expects a fixed set of 128
> interrupts (see the fixed IRQ length when this board was added in
> commit 2488514cef2 ("arm: SoC model for Calxeda Highbank"). Add the
> GIC_EXT_IRQS definition (with a comment) to make that explicit.
> 
> Except explicitly setting a property value to its same implicit
> value, there is no logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/highbank.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

