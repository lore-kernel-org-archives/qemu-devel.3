Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD8CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmtI-0003Q0-GU; Wed, 03 Sep 2025 08:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmsq-0003Ik-79
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:46:41 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmsn-0008Px-1y
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:46:39 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61cf0901a72so10056645a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756903595; x=1757508395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uiEPZYL3P5yfCnyWgxr/DplYOOXT+KOSq8kuFS9sW+c=;
 b=WdvzxC2AyA1xGLikak6Lt0woJZb+YaqyVWXHpEk3jq9WdgmD7q6JGaUGJb/PCWgUv3
 1Bgl/gUVLmAQR/1r4JPv90mAwMaJpzBRNLfrGICqbXUdlUoao6g9OHPy31zsw9PqwJj+
 /KvJ4ophN/B1U25C2AMKKnDzMTWU6MA2a24WirGfg9p+AfQv1zi6Ah0SQKpZTp15TkzG
 vysmYF5Kwqu7fmw3t01dRLT/UVhm1hlpcLVYVqXZymGyyGiufStLnRh/R1dtF44J9mCH
 qU5IOdWdQ3ia6lqc5vGrfDqjUH9xPVj5pNGHqjtJ7zZ5RL6k+R+xeCzCgu4WFhHn9Hmb
 uDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756903595; x=1757508395;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uiEPZYL3P5yfCnyWgxr/DplYOOXT+KOSq8kuFS9sW+c=;
 b=dMEriVEIJdkCnUt3SzcmEWdoFKXqmC9Rqrgjou0C0rST5O3VFjpiwcpLoylDa1hRqq
 cDQSCJxyfQgDInGZaNEnoPFWVDXFIULxWpTY2w/C5CU78QnUF8psyyoBbtrbwPW+R5lO
 RagPr0p3+FZBFKKThYWqW+qz+dP9x2cj/8bI57EYy41RB0UYEnD/ML/Br20LyBxrZeR7
 w581ng6BixhhGtaxvYcejF3FWz/VSRS1d0lGsbD9Lsyms0g4rlaaE/p02d5eOtBE/RXj
 RXa/LLcB93xcIqfQ3XTat/b+srrb4ELzX4Z73D2VIFMXd2LwhDAkY3OOOn7cg4bpHEU1
 wpBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoZO1PVGEu6mPLQAeq3Z6tVtyVFXARMeqGjhM2nXL+nZQK1Q0gK9Zhm9tiJ0ca5lM26/XSHlhjJyKg@nongnu.org
X-Gm-Message-State: AOJu0YyARIL09D0nVWHW5w/ZB1nvTcHgkGxRKZ/6LIOW9nZE2+/KpaCX
 47MYDnVajnXLcNC4QuUeKTnKkkoGLJosXFomL76y9oyh7uoH2YcNYS5gKvq2GCxK9Pc=
X-Gm-Gg: ASbGncsCHpApu3WjVhrqDTeNji+X7LhM6nWEPhsl3bFDLs2fWLh1Q8A+PNIMcekI0Tl
 jQ/c/Ozuc9f9IY7Lhtt1wgJxPvaFuZxxENhNnvjioDvz9cVkJQwGG5h/iVGzAu2o1m5ZtoYkKbB
 FhktqKA5HlMM86ayTRempVQ0MjCBP96dhM8Rnm7ypza8u2lBnHhtZER28flNkbdLHDXaEUxcYhA
 7oUd0iwXHkQUEgBPaQiNwh4aN7ZAegVbysZtawOwKlY4duWWKfTbH6VGDwvj/UFrhV0yv3qbS2y
 7qg6BL8gINwBJSwXf5ZpKwK0tHs7c1VDtPfFVk9ENjbTSIzPo0TyKjTAM/7Jl5/Xnd8qguNNRn8
 ffGPGotncQ4HITzbGNogI+t9La+Ryymw/WrqvIspA8FNzpPzlEpwqlMMPDSIgv/wObHP7TNzkpg
 70yAB7Iw==
X-Google-Smtp-Source: AGHT+IEi+V9LPxqnLn+jGHDZGr1XZHAxrhKBmRxRpdm2kmDUPWTkdnUxpP6VmrtVKgTZpuobGH9k0Q==
X-Received: by 2002:a05:6402:84e:b0:61a:9385:c78b with SMTP id
 4fb4d7f45d1cf-61d26ecf561mr12776206a12.38.1756903594735; 
 Wed, 03 Sep 2025 05:46:34 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4e5229sm11814625a12.39.2025.09.03.05.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:46:34 -0700 (PDT)
Message-ID: <bdd54f2f-a7a4-4e07-9223-0e32d73dc5b8@linaro.org>
Date: Wed, 3 Sep 2025 14:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] target/arm/hvf: Factor hvf_handle_exception() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52b.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> +/* Must be called by the owning thread */

How could it not?

> +static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>   {
>       ARMCPU *arm_cpu = ARM_CPU(cpu);
...
> +int hvf_arch_vcpu_exec(CPUState *cpu)
> +{
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);

Don't dynamic cast twice.
Pass down the ARMCPU, or use env_archcpu(cpu_env(cpu)).


r~

