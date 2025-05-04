Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D38DC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc7C-0000XI-UB; Sun, 04 May 2025 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc74-0000UZ-Va
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:22:48 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc72-0007ph-65
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:22:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso5196384b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375762; x=1746980562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgIX1vsZuDFUCgCQi+gmJJxCZwsyyNSVWctppGjoyyk=;
 b=Jf/3bFun89cbcmd54uXLLFZMAlq3w+BvqxJ2aD1/kCTuyPoFxqQm+T7w1P3euK2kGY
 ARehvhPY86nTiskhAiYit6z1jqni4jCgEjLCFPdOoNV9023JPXsr596mojS167JO0LGc
 PKaksw9MJOjmV1Rr2JEneNHnMQri3KFIxhJ6oZ4u8/P0dQYv9D3/qEbfiIfVFGbR+OuE
 VEAvLBFxWx4tAM8WHfaaLFW1V79d0vDwQJIBQDPa/9zflL3j7zLkAl8P7lRMGGvq+/TL
 B6LSvi1WFpyv5oj0rSwKThtuK+UXpg/9OxCmm/3GgVU38Ozdm6ri40de5wgBQxJKZrV8
 MEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375762; x=1746980562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgIX1vsZuDFUCgCQi+gmJJxCZwsyyNSVWctppGjoyyk=;
 b=sHWTXZRaW2kSQ9pKcoDuMhxXtpH58TRppeFgnzofCGxS74Fbpg5hLGKVIgI8sbKcLB
 CylrkFGzKzUiZKAFXOBZIw6LwKsB0yvtwe1SVAdmVfvRjiFAohZhldvGP1mF44PkUAUf
 3rDZw7/SzHzx0OewGyB8S00XWqiUdarwEdPG3O0taE4zEdlcLet61J5vLUna5OWDyL8j
 CMFqWxb8JA8nrs1hg0eEcAKMro7rVKIs1Dp8mMIrj1IvLldpYpahuexAoN4tfEd3tPAv
 SVEhMqncb76wEDRPbNOpUYtXOoVZUBFIsNCf4jPzropD8NyLFIRZ/GjiW213Etx03iR3
 L8Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNVJyhffxdnShLWanqPUFVXXtTdAPSAwYUZ2WcOmh6ZKUtRHs4rH/WSZ7wuCnN1K7NzXhldHtTlTKK@nongnu.org
X-Gm-Message-State: AOJu0Yywx2jttdNk9masonQGpl6ECSWIdeKWDwmYCroqxBXKMrUa+eQE
 Zw1gKLh+Ak/CbRuIB9drj99rfHxAToxcYOXwMSj4GZ77rhBqNiqoyFZ3/CF68pTT5wkb773mbr8
 d
X-Gm-Gg: ASbGnct0VbL/DEydlYX2Qn6Q296PsFpYs8fT7WiSgVtm8ysnLWAU8pNAmOEwRoCiBak
 YUf+XTe/LAq7iHzX1Y9AHErX86pZPr+0Hm6lYk8tK5RPWh0tpXCxqdtVqxyGJQU79ohQRpfUJXK
 lgRc+5+CkeeeNn9pU1jruKnO/ZVfnPAP79OLzu2djxBj7J+z0V7felJhGfmzv/chIqGZ7iFKA+5
 fbCg2N0Zo44iFErb565SIFSqAXhY468yq56/JlNzxl0I81f0M9n3tQ5nb7YVsPfYLoryknbcEzD
 4P2WWOtHT1RAdx2fypMpfzGwxowQgmxW5ZF0nVaIJF37jSfv1Ln3Zf/15OIK6kTnCRIqkeIbV03
 2kF9fF2Y=
X-Google-Smtp-Source: AGHT+IHRYk5QgI7VMX8dTjZoYjvU+aCIcTnL50+b27cw+8DBfiz6tjKw/RO839BAj82CBUKEpNuImA==
X-Received: by 2002:a05:6a00:1d0a:b0:736:46b4:bef2 with SMTP id
 d2e1a72fcca58-7406f09cfb1mr5345964b3a.6.1746375761753; 
 Sun, 04 May 2025 09:22:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020fe7sm5186235b3a.102.2025.05.04.09.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:22:41 -0700 (PDT)
Message-ID: <3fc7e2c5-12bd-4a6e-be17-303bc870a0f9@linaro.org>
Date: Sun, 4 May 2025 09:22:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 39/40] target/arm/kvm-stub: add missing stubs
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-40-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-40-pierrick.bouvier@linaro.org>
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

On 5/3/25 22:29, Pierrick Bouvier wrote:
> Those become needed once kvm_enabled can't be known at compile time.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm-stub.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


> 
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 4806365cdc5..34e57fab011 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -109,3 +109,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
>   {
>       g_assert_not_reached();
>   }
> +
> +void kvm_arm_cpu_pre_save(ARMCPU *cpu)
> +{
> +    g_assert_not_reached();
> +}
> +
> +bool kvm_arm_cpu_post_load(ARMCPU *cpu)
> +{
> +    g_assert_not_reached();
> +}


