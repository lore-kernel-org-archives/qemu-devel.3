Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA5CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOcF-0003XD-Kc; Sat, 30 Aug 2025 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkAQ-0003bq-U0
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:28:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkAO-0006Zo-DE
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:28:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b629c8035so9028395e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756416498; x=1757021298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BlDpQGDeexgL4ACGGabqUtWDKUNnzKeqB7cELlVQs+8=;
 b=eGhyHlhsLBkSjgs5Aygf9/52QDZm9JG6urvZlwDRDxce1sXg7wOnwfQYen96HdGRpg
 b/hNJ37VljzAety5WdRH2aeyMnOqX3Ecj5knJET7Pdti6BmoebsxauyHcj1ZHK/tSC3b
 KaFgPpm0dCfPlx9xrlZZ4TqM/A6a4Rm/mVj1K5iOrhU6T9CGUHNcGFwo0rmlgPmQW4AU
 GNnkAVvW8URmGaT3w4QX3QKWMsvlp42HuBmlJ/97yH1D3FAxxGUYVuv7VFyw4bEQQNa/
 JnEuwB9iFdZFVKv0F+FaabAR30if74Z3Uh0N0MfBIPio9IzVWtA8refFPHoVPEmfzAF6
 9k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756416498; x=1757021298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BlDpQGDeexgL4ACGGabqUtWDKUNnzKeqB7cELlVQs+8=;
 b=lIZvWn1w7Q7LE7bbHSjNAAKuKyMuwiOOq9il1kzu4o24Ajo8H/xqcuv2m2WQ2uYm6w
 bQSpoulaSjhyjOfq2/S+YpLC5NPtr2E+7DJpTIqVGKPVMV6ES1bXGlxnB1DeowbePHAR
 0kNxIyA5VA60z9jopGxxQ6Sx63i6mUi/L00wYnimC2QjW3IrEAoEp0w9n7FglD4OYRZ6
 AJ/S0nQJHZRdvzCcHZvL6oMF4h7oEb5rPfhISw5GXhDFKXvunHg4oapxfiOUOHKuEJLA
 3ajS3fBiMM2cILkd2V0S3+OxvQcDWsceLqy2ZqkJVsWFycSUu97tZrM03zghWCuW8SF1
 5Cuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxOVfvapIpqMXmcjqRF3+ugJfBh+C0GbJzAsjeoQa5t0ttax5K0EwuHKZoR8YUnEFgztkpB9gilWhF@nongnu.org
X-Gm-Message-State: AOJu0YzfCbqaa5n8reT4wU2uTNKUdroQqlQNsetwqYtOrqE36VeqQnld
 2r3SYTk12ZWEXp/gfs4UnDmNLwZ2SabbBhflGYWiZJEh9rZUm7kRhRyZOUA1b26fcxA=
X-Gm-Gg: ASbGnctluHwl8p9cfz7Tna2JpSm/dJgsvwiSW6hWaIRSRLHW7Lw0zMyMcwAU9qwpTU1
 ROeBKaXzZmSmXFcw1kRGaa4n1KQt3EZNucETJ8K5Zu8rsoExgknYanhBuQtDNI2567iU0NzkGZ/
 mfz719d+n1abCMBgdkNDl9jPFrGNGwvIGuuKKXi9DZD5FSJU7TFgHHhK6nK/WHGsipQ3eQdVLy0
 o/jM+T03M1SXEAAuGjQtqsKFcOwC2U6tPQZwMNwfZgCpGLz9AzgxMyVAhtZgQSx/XudwZxuZgu6
 FTLS+QdIWUE8sRdL1V8GMcCV+42M1fj/5lo5FBVVl19770bi3R4kam4y0sQUBR9r3Bk7QpAHFy7
 6Eq0CDp0KhmOgMcn/vtFn+Nm0GMioUafnT65NiiaP7fEdf4DrMobIPWBRJdxdp5D/8ctRH0t09a
 ufqGD4pCUWWq4=
X-Google-Smtp-Source: AGHT+IGDHOLM+tjMssymUkWg8aQ5/CY+ews9bcwv7CsYLI0owO/EK0aksL+ggx8eAgmGenbiJEGbtw==
X-Received: by 2002:a05:600c:8b47:b0:456:19eb:2e09 with SMTP id
 5b1f17b1804b1-45b521ca71emr240993555e9.8.1756416497841; 
 Thu, 28 Aug 2025 14:28:17 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7f0dfasm9828025e9.7.2025.08.28.14.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:28:17 -0700 (PDT)
Message-ID: <23ec53e6-6cf3-4677-87a5-44063c5b0aa2@linaro.org>
Date: Thu, 28 Aug 2025 23:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/arm: Remove deprecated pxa CPU family
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250828140422.3271703-1-peter.maydell@linaro.org>
 <20250828140422.3271703-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250828140422.3271703-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 28/8/25 16:04, Peter Maydell wrote:
> In 10.0 we deprecated the pxa CPU family (pxa250, pxa255, pxa260
> pxa261, pxa262, pxa270-a0, pxa270-a1, pxa270, pxa270-b0, pxa270-b1,
> pxa270-c0, pxa270-c5).  Now we have released 10.1 we can remove them.
> 
> This commit removes only the top level CPU definitions and updates
> the documentation. Removing the CPUs means that there is now a lot
> of dead iwMMXt code, which we will delete in subsequent commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       |  21 ----
>   docs/about/removed-features.rst |  14 +++
>   target/arm/tcg/cpu32.c          | 163 --------------------------------
>   3 files changed, 14 insertions(+), 184 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


