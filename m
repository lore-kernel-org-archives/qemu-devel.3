Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC76FC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raieL-000169-0p; Thu, 15 Feb 2024 15:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raieG-000152-DZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:48:01 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raieE-0003ci-1l
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:47:59 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e12a430b92so590003b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030076; x=1708634876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2/GvBQbcy2M7DzdySdN1BFjdnMxeBt9nuXTinUh+IxA=;
 b=DC10qLAAeSeLLXfWfyA13505h8jczEqco7wBFovBNvB9rRWc048NoFb+81RAI3gtQD
 Vx3WdqizoT8sTHI+zQC/xfDaaMrWRaNP5V6pcescDqgt8suy/eO5+l/NepY2D1rUYm+0
 XtFY5uwgkmb4xR5xgRz8SWGUZIkPXuEJEhqIb1ElCGLbJBTP8wcu2eSN1Qr6tWEy+fhR
 zykNstm84u6ETjBrFdWCy1d5KMiaE7Pni6fMJVKS/DoqCvErEqKAEvMeL/yyZ6pDu9/J
 SQZdLygaiUOXGlTtwqaBKiM4mYxtleZ0GbmQX15WDHjYg/0vpDYv8Fcj3LglTKm4/8PN
 hcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030076; x=1708634876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2/GvBQbcy2M7DzdySdN1BFjdnMxeBt9nuXTinUh+IxA=;
 b=ILNsIXl97SdoU+HDaaegkWX+bAb2MIidVCUia3bkDGjG/lwRLSTiRGHQBxjnNwo8dt
 XBkn7irX/oQpyZasd6u6GDhWEfyLJErcOofr602QQJaayOt99m0gesJOLPUCE9DhRdsF
 jEvOrnu1u7+xGIvsQLG84isIdQiw6iIIesHHmfbNvoSJGycS3ogKWi1Ef/B27HMcXx60
 7F6B8MiUhqO9tzv59itgfouWAPwQOIcrMO/VR+3aXrfGVX+lNCtYXeIKz2TeGJHWeKoS
 hp1a4TgTg0FWyKDaL5uPrawFsSE+h3z5/SPeTDT4pnA+BIz3128yrBmNZkQ5NdOcZDwM
 rvlw==
X-Gm-Message-State: AOJu0YzEYf8XAjUZpfs/2a/bULYhmF6YK5Zh1giUfqkxv1N1BSwRTTiX
 uKGnZPJDFO8t7+RKSbYUijfMOCCWUGeXujxT3m2T4XrFPvF6DHuTKLZqNPwZu0E=
X-Google-Smtp-Source: AGHT+IFhsA/w2qzHssQkhVL3D4pS1tp3KS0zzicy9Ild/C+7WcIpX7s9QBacVK5RtDtXhsms99NNPQ==
X-Received: by 2002:a62:c1c5:0:b0:6e0:ed60:9a27 with SMTP id
 i188-20020a62c1c5000000b006e0ed609a27mr2628126pfg.7.1708030076352; 
 Thu, 15 Feb 2024 12:47:56 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 fa2-20020a056a002d0200b006e0414d7cf8sm1824215pfb.95.2024.02.15.12.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:47:55 -0800 (PST)
Message-ID: <e3a9fe96-8462-42d5-9e9d-b15dc304250c@linaro.org>
Date: Thu, 15 Feb 2024 10:47:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Advertise Cortex-A53 erratum #843419 fix via
 REVIDR
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 Ard Biesheuvel <ardb@kernel.org>
References: <20240215160202.2803452-1-ardb+git@google.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215160202.2803452-1-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/15/24 06:02, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The Cortex-A53 r0p4 revision that QEMU emulates is affected by a CatA
> erratum #843419 (i.e., the most severe), which requires workarounds in
> the toolchain as well as the OS.
> 
> Since the emulation is obviously not affected in the same way, we can
> indicate this via REVIDR bit #8, which on r0p4 has the meaning that no
> workarounds for erratum #843419 are needed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   target/arm/cpu64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 8e30a7993e..0f7a44a28f 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -663,7 +663,7 @@ static void aarch64_a53_initfn(Object *obj)
>       set_feature(&cpu->env, ARM_FEATURE_PMU);
>       cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
>       cpu->midr = 0x410fd034;
> -    cpu->revidr = 0x00000000;
> +    cpu->revidr = 0x00000100;

Is it worth indicating all three errata fixes (bits 7-9)?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

