Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0176E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSrW-0003ps-7h; Tue, 17 Feb 2026 16:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSrU-0003pL-MM
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:44:04 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSrT-0007JX-AM
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:44:04 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-506bad34f51so26186481cf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771364642; x=1771969442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wzu3ZL/yxVOmSBM8y0Saj5jVUPbZbGWfiz4ukvmT6wQ=;
 b=bGp/Q6Um0AzIWtjfnBUygXiJ3PzdXwo9bNy2IilVO4Y0XzL24vwm2W0KDgh7UTifoD
 6TmmQdPwv7loR2zRY/0Av48DxEnHS5/M6JId+lX2HahP/WgWeu8skDkThQ9aZw4NlAtf
 xDQlXi5vVqeDsibqOpDVe9CPZfy+DF+1WjYqCcbHHnsDeY/tJ/yUr0qpfry5Eiu0oiA8
 GkUFCQwxG91/tEWc1fcMU/GIRr5YtVF+9q7aKvdY7GhqgS+Ju171wC5U+bFM7nRbUw9E
 ToKNUwn48mxAxF+DaQ2OytixmFbUH4Gm7gcr1MF4JosKr4xvyCpSoM95iwn4nL58FoXm
 AWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771364642; x=1771969442;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzu3ZL/yxVOmSBM8y0Saj5jVUPbZbGWfiz4ukvmT6wQ=;
 b=PnTS5rHwfwRtgQ3oBTvjyzJfWL5EHmSa1YreGjGcKMv6XkKjRv/VeaRuMbiBkXtd+6
 LPFW63qNRcP3HSNO2cVRR5TkPTquibAeExuAQksm0AX1dFx56KgDfbwTGr0550Q58pLs
 2gGZJO7IsK5QPqqV/SGP+fZMNOPdwRkAuZlXQxYaNdLdxDwVg7Ve9Z2rKoy0lfmmTisD
 f0aEAsMeFup86WN4tSwEF7lKnq4NWHDvu9pLAjeGOzN/D7xFQtrNAw4NYnN6hJiVahnK
 jH4ZE67J1fitQY//gRjGCta411VWtULsZyOiJwZOwxdsNY0s5VYhU+BRdMWqzr2ei9pK
 OtjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbY0A0KQc5WREcmHrcERx3e4rMgmszFWEmEpwr3EhJWm5WuhKV92DYWddx/k2CXjOMN2m+4xflKoIz@nongnu.org
X-Gm-Message-State: AOJu0YwCZxdPJhNzR9AHgz49NahjyEGerQcAQnRvSqk2Htkxa3VqnCe4
 vwiFU4dHa/+9L2YmBhMhpxpLj4LvaT2SzHJ6M4L6gSRu252xol/mrfSD2fikbZgJz4U=
X-Gm-Gg: AZuq6aIOC8auhdFQPJNBAPUZ8CdPpJwCO6LgAYCCJLIsWMgwzWQ+rBKMis4yKDp8IH3
 ewejAiH8U3LwGc+7CnMw9219KhWVAMpInu9UHmYWOtvmj/WOhN5qiGPl4WSlzvMZ3jBbwKP4bqz
 kkXYwLPIJtFe7Lynd+Vagd8ioTEUaGmOgQmrijUL660kVX8i2rAH92kzMJcRZiqnFaX8iUBrzaH
 CpYa3HctjEqeg86/RbS2eBhEhqaeiVJPuBtLP8hHvhrKYCQ38kCUE34DD85uTQ8PWA0tl7gdwz6
 jE9LdS5tHpzgiC/0Omkvy8jw1QqzfTBkg3FXLM7vuZfUp109aK5rSULMWcBBRT3CQLFMrP60SKh
 gfUW9ryjbhWoG37ufk81/pe6ub7Z7ZE+1Ly+3sZEhn8NU3ffr1JLWMim9PQ2hAAtyuJuUkVjDCh
 DNVTVZGta99r+HqeX090OolYTw/Oa7crlPYH2IjK+O8IYCdlalrL8EElryWMpcRP994Q==
X-Received: by 2002:a05:622a:342:b0:506:9823:a61d with SMTP id
 d75a77b69052e-506a83a6484mr175254281cf.83.1771364641945; 
 Tue, 17 Feb 2026 13:44:01 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684b94f33sm161790341cf.25.2026.02.17.13.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:44:01 -0800 (PST)
Message-ID: <d679d49f-ebd3-42ba-be60-05f4edcda6ac@linaro.org>
Date: Tue, 17 Feb 2026 22:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] whpx: fix FP register loop
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260217210805.104427-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260217210805.104427-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x82a.google.com
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

On 17/2/26 22:08, Osama Abdelkader wrote:
> In whpx_get_registers and whpx_set_registers the loops over FP registers
> were using whpx_reg_match[i].reg instead of whpx_fpreg_match[i].reg
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   target/arm/whpx/whpx-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

