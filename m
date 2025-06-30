Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED06C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 16:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHgi-0006I9-GN; Mon, 30 Jun 2025 12:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHgh-0006Hq-4y
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:48:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHgf-0000mA-DU
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:48:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so2597110b3a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751302135; x=1751906935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//9dJhOtE2lkY/XekYzysjuTbyZ1SmC5V7ccVcBGw+k=;
 b=f/V8GDVMcKl59myXp2qwWHpNCxC7r5+3mqOnaPXouat/3UsKT+W6VXjeA+g2OWkZMC
 8dh19y0CQ2cCPKMu4tK1EW0nreGQbj8EfcU3R/JzGY3hg+V/cH/EjmJ/A/rxnuIbwX0k
 a4A0ePN2DTZV7FT+9dhJ7wh1RMMnUMYfkqvfzUqL+Ux+4819X47zWcg1dnpIVkgHmYYd
 5quPnVdl0he2rUFNUWI0IHlGR5H/S7jVkduZsiIZHePLMg4mnKgASCbt8n9j4gJAydnG
 yJ6amqwF3kKzc81bn7pp7tA+AGI26DcL6pFgiqjVLbRQ70tYLg7zJw68rzeUks2NYxKo
 p+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751302135; x=1751906935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//9dJhOtE2lkY/XekYzysjuTbyZ1SmC5V7ccVcBGw+k=;
 b=UGJQcLvQ5+o3RUQWDcH1Cc50pI9vGnGDMFqYlQUvm4S8N9dTE8rzgzGqh/iChh5ci/
 GBKPC43+KWHnbYOOUms8Z3jC84QpBxL9nBua2lq8wN2Qjo4eXzyTp2f7A49jqwFtwk/U
 BKSJn/vEcZLFafiGrO5NXL355WW+XvYPWEJ/uhT/lCCPZQSFIsiTzrZToXP1GKKl22sX
 6q+7bDf1EcUQDgCrRD7Uie1b5BBePL4IKWXF+UyBYM4EleTDjwZwWxXN2f90xRsQ7Q9q
 knKczeRrOIyxW+TyKX2wBzhJDKIA9rzh4fC2AUe8iLfEbmPaJesUrGG/wI2uKtQmE0bj
 dJ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZqC4HkJctG4VVCcWMsUYXY+ybSPl0rvMdGqyjsM2DzE+g2KJ3vV04p4D8By+/Uvko3/tuf4EV7Nqx@nongnu.org
X-Gm-Message-State: AOJu0YzsIMTM01CE+oIo4K0K0SdhXh04dABEdYf6CJWLp71zLS+S4xQe
 iD2bM/d3+LPd+Uly9NPMN1rrnljeBUCvhlWXbMuF0SqKPd8hcLVDWaJSu1e4A/EhrrPWgUpPEiT
 A01XO
X-Gm-Gg: ASbGncvyHGiFLH7Tnv5vZzxI5nzxCKJYaYqCxQfGYwlKqhGP4uD0zPwWJOtPDR9yUGO
 Acx7aJeuP8LVsVYs9mHnmYvm6LqSBl+b/iHB3GMMLKDbI0TfQ5BhyV0/RUV4mRuPxykDla9bYoH
 bhBfY93RA3kLRWPIbleuCV5nrnbbgMhKbieRjF5UvWvq30j+xXquzpprDJXvJ7a14Uc5zUn0Q9H
 KdkbTzptIXa0oOKmxDa333B50IW4pxCyGZqQwNI2iG+bpIvkty8DXJUixWO7rSBMl9pHtfi5bIM
 ujN0Eo0AKXMxOGPGBiliH+nbiEFtBXMcuX4kw8mNvf6vyhNkrfsUCFJopE0fl2XfOW5eApqFTKQ
 =
X-Google-Smtp-Source: AGHT+IEyyxGjDtBxgLK1AjzuQEapewl+2cC29y9rfEYPT7XWohXerOl6ssa6LAWSPt+qNDhOpMXqnw==
X-Received: by 2002:a05:6a00:997:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-74af6e3f46amr21115371b3a.3.1751302134683; 
 Mon, 30 Jun 2025 09:48:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af541e655sm9483237b3a.65.2025.06.30.09.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 09:48:54 -0700 (PDT)
Message-ID: <038363c8-36e8-4730-a1dc-eee360f6533f@linaro.org>
Date: Mon, 30 Jun 2025 09:48:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-2-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250630130937.3487-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/30/25 6:09 AM, Philippe Mathieu-Daudé wrote:
> Commit 34c45d53026 ("target-arm: kvm - re-inject guest debug
> exceptions") removed CPU_INTERRUPT_EXITTB from KVM, but it
> also appears on HVF. Better to restrict it to TCG.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


