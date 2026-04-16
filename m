Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E953F8D76E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSoP-0006AL-NG; Thu, 16 Apr 2026 15:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSoI-00069x-TK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:55:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSoH-0005f2-28
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:55:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cfd96354aso5158360f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776369330; x=1776974130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m/tjUOO76sJoTge/fDdhDk866bjwglaInC0oLYRmy7E=;
 b=WvqtM82zFeL4pjdqU1dX4s+VY4uKmFKISNOu+cuzZ9gN80B+fV79FtmZXDXUi0FRbZ
 WAIM+hWaIZeiYzR5Kog079+RjHMTlcnGMc1nWA6TmESESKTy5ZRXSQmOBPa1O9XCTvw8
 PRKRziSPM0LfKdHqGRJwvN3QdLTLQBGv4Uj9SonF+MPwElKcv7NXIZOatHBv5AjB4JRf
 XuAiKJQ8OKC9ak+lbJM5hPZrVudp+LvFRmKOwSB+6TDhbCbv6FXKYiIYTrC1EIz6kb6w
 U6LmRmJ9d3d0Sk9W9WN0zWqesTp0uIjLWAgtiD+hGzT3dx5BHwnEg9i2lGz+u0B4jCZD
 QR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369330; x=1776974130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/tjUOO76sJoTge/fDdhDk866bjwglaInC0oLYRmy7E=;
 b=QqcoG9tCbQWkVp6bMw+Ceim/C9EAgXcctKz0r3euBTHSVWlKJtG0RhGODpTGv9/VBO
 XxlNd0hFqK/Kpk4WN0nSl/DGDH06fy58mHbwEiIYj4y/MVdXDZ14gCT4SA9ynBVS3SFF
 QI2RaRLbXQEXRHpf8pq6NAe/gnrEG7/JpGfFQ3bzpLyZ0pyX3OillrHPrWnDryMyqErd
 rQ5pzmvHC13ZTkBMZkJFALrno3WfetprS1uqBfL3n5vuIO3IhSb2uHT6NRXilK1jZNdO
 ElwCddXpysdq9ZVghgzluqLvcVuZnHFdloXzOnla/sSmBT4HD1s+c/BIJuumM74vVWty
 /3VA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QQhQZ9MZchfmfKM8PO4pXpZ/18sr2l/ujmOZoIsk7gjG0u0DvkQuSEXwjQ2LhbjCIJaQnkvP4UdSX@nongnu.org
X-Gm-Message-State: AOJu0YznTDCfBidsZ2b2LWac0WcDyVQsXvNJzm3pD7Q/XivdXG8qrDoa
 OcIWzdTWaKEZ7HrcTKtYIUYN/CI69c03lAE0gWbudb8y69IklbjYbu/bffMt4jEFa90=
X-Gm-Gg: AeBDietTLtDNQ7wh1EQM7oH5LYQnvoHyzJx9p2HeAND0ZPlOrFGkWGR8J4nP5r82Lf5
 wxEnpQoPruBHy4Mn52YtjGTc0rtZ8CDlYGk4BluhRhRP2jwqraG4VbV7kK4y9LUZp7hTaZiRcBM
 IfONoOUQsHQ4LPSEWvygMEnQ8JkirLty5wTald2H0w1Q350pevm5/7yMIVo5WD1ppRbD3g+DDVm
 w43dP1cet4Sy3QeUOAFivVtGuQFBxz2PWDyCmKFWauM9ktSs/u98UybwOefDEL+I3AasND1Ixtp
 cQGNiaWtEbaM8/TFeshMmjfmuzgooEvgQ3qRm2niAFFgKAR2EGH66uXaaMLJET8UthBzr3vugy/
 I+J9nxbUSHbhrCb3B40MJ/84/Ynn+JjUV1AuUg74XH90iaw2XvG+qFhsvhsumtaSnEEpLEARsjR
 zCQ+rG6TOaH+Yxw60uz8cK/jXOX61LeChRdGEBCg+2yHOfktUJQ3GV23rKAaG8iFdjAydi4OyiJ
 lxc
X-Received: by 2002:a05:6000:1887:b0:43d:de4:bd25 with SMTP id
 ffacd0b85a97d-43fe16a5e57mr1074505f8f.45.1776369330375; 
 Thu, 16 Apr 2026 12:55:30 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3553d7sm16040724f8f.9.2026.04.16.12.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 12:55:29 -0700 (PDT)
Message-ID: <dbf19914-774d-40cf-a9f7-0d75d73fe9b1@linaro.org>
Date: Thu, 16 Apr 2026 21:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/arm: Allow 'aarch64=off' to be set for TCG
 CPUs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
References: <20260416165353.589569-1-peter.maydell@linaro.org>
 <20260416165353.589569-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416165353.589569-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 16/4/26 18:53, Peter Maydell wrote:
> Allow the 'aarch64=off' property, which is currently KVM-only, to
> be set for TCG CPUs also.
> 
> Note that we don't permit it on the qemu-aarch64 user-mode binary:
> this makes no sense as that executable can only handle AArch64
> syscalls (and it would also assert at startup since it doesn't
> compile in the A32-specific GDB xml files like arm-neon.xml).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Clément Chigot <chigot@adacore.com>
> ---
> v1->v2: slight tweak to the docs wording
> ---
>   docs/system/arm/cpu-features.rst | 10 +++++----
>   target/arm/cpu-features.h        |  5 +++++
>   target/arm/cpu.c                 | 36 ++++++++++++++++++++++++++++----
>   tests/qtest/arm-cpu-features.c   |  8 ++-----
>   4 files changed, 45 insertions(+), 14 deletions(-)


> +            bool aa32_at_highest_el;
> +            if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
> +                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el3, cpu);
> +            } else if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
> +                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el2, cpu);
> +            } else {
> +                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el1, cpu);
> +            }
> +
> +            if (!aa32_at_highest_el) {
> +                error_setg(errp, "'aarch64' feature cannot be disabled for "
> +                           "this TCG CPU because it does not support 32-bit "
> +                           "execution at its highest implemented exception "
> +                           "level");
> +                return;
> +            }

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


