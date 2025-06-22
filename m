Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BC5C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBNp-0006Tj-9C; Sat, 21 Jun 2025 23:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBNn-0006TK-8b
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:28:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBNl-00070A-Nc
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:28:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2366e5e4dbaso25064395ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562916; x=1751167716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ifHCU7SazBmp7ZnCg0PHUIWq4JazF0kgFO73JKChXrY=;
 b=AbVUa4Mr+RS6XeOLTzgHuk6gqq2e8z8CP+AETI3Wxui4bOq0W6F8mImzFDcOoUmvcs
 l5oLO7R9n6dkjWvmPSs2XNdrOUoYm1lNzKxPJ0ioHa22JBOUq6D8jrzRitIl0XixaxNC
 wKr2CuGhIERBliDi9Ga6v38harJytv2aW2auOOhGaQOtPCOm6twP780b9ZwzvP1IFzvr
 8Fij9CdHB3gqcGoubwkyKpIAr6266X/Xnfwd+hFEGKwxcP4tdFtJ9wuhemOyWGOnMCCa
 loe/Xlk26bV+mv5UAioSLATtUS4UBsAXksUtlg49U1KYJ8whZqUfKErP/VxAQ1BayxW0
 bXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562916; x=1751167716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ifHCU7SazBmp7ZnCg0PHUIWq4JazF0kgFO73JKChXrY=;
 b=C7KrpgfWd2MR+MBkBGDmzWZgUgf4dyXBisJeQ4yRknGAW3RhlwBVlgxePpxPH6UAf9
 nmC2r8ZBz7Qzn4Q1L3L6WWx4pS24sB4X4znTL7jVAhpZE0/vA5+3j06w+XYB/u2sjZBr
 qlAw12eBUGNocmt6ZyBXguoNK0r18niD0dUFmE98icwOW0tP58nvAifeqYaAMhF0SzDH
 dbakRGV1nVlY596QMgF99dF8obbwcCt1/kztFnjbIdM8b+04mHUT3LsyLeEo1EXdiq3W
 xbshrZHFOUtDjLQeokxIZGMPo9HWSkosODLb2n3xtJVtoktrEuPASkRhhGuZrEKswAqC
 mRww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCWkiRxV+sOOGEpHvcPyf4ibAkQ4cMdaSEK+IdgsSkcagQGYH8A8MlTHOhlukYw2HCACfRXVsI1v1P@nongnu.org
X-Gm-Message-State: AOJu0YzVgr9VzvedxZp90XWOwsb/CQmMq4L5R4xJNzx3nD4x0Z+J73o2
 oSbulvd6A7G8Ju9TbjXEZCZZb6efq3OqqFuHgKpQLvV80Un7mf9ExqLo7njE5STF2k4=
X-Gm-Gg: ASbGncvm6PqEYaN+jl0pKDa5PLgfL9B/gXqA7C6Lk8x4ZDquGT0HxO/871IaHdixCql
 vbEoYI1/vRP4ixqpR3hP1IaB9Ol73rFbAzwi1B3qQ7t7s5/pBucZdlhSPJh164DCkm0ysHPdaRH
 a8ryyxxfkDSW6ZgGWtmUM3z1CHm1XcSeXv64aiICnfDDMGNFzUCCLO5+XRQ2wzD4sjdyif8fPzS
 xfn9cUbYMooNPKvS1H3yQTLGxeDkSnnZmE/9EOpUdELFiyHUghUaBRYSMVh7VVW8E8xzbCoOJrd
 lEjtbE0jZjZABWsYu4TBWyWFi28lIi+ezl3ck0eY5iYvheNjKFjh5IkoDsCDqyvqf9Jy6MzhetR
 bFHA6Tj0rHWcghfw/5Nvv76/WweXD
X-Google-Smtp-Source: AGHT+IF9InTXR9Tl4pziPnES6qmHIWe8NN2hs1BeD6WK+FOjl6LhUqQaaGRVe2UdFcZ6+e+eNKEG0g==
X-Received: by 2002:a17:902:d50a:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-237dafecd35mr109623285ad.11.1750562916156; 
 Sat, 21 Jun 2025 20:28:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d873b5b2sm51588275ad.245.2025.06.21.20.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:28:35 -0700 (PDT)
Message-ID: <4bd8e983-d10f-437a-94fd-1cda26478e56@linaro.org>
Date: Sat, 21 Jun 2025 20:28:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 37/42] accel/hvf: Emulate HVC at EL2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-38-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-38-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 3907ea8791e..a4f823f834d 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -17,6 +17,7 @@
>   #include "system/hvf.h"
>   #include "system/hvf_int.h"
>   #include "system/hw_accel.h"
> +#include "system/tcg.h"
>   #include "hvf_arm.h"
>   #include "cpregs.h"
>   
> @@ -1117,6 +1118,8 @@ static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
>       env->exception.syndrome = syndrome;
>   
>       arm_cpu_do_interrupt(cpu);
> +    cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;

Why is this needed?

r~

> +    cpu->exception_index = -1;
>   }
>   
>   static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
> @@ -2090,6 +2093,9 @@ int hvf_vcpu_exec(CPUState *cpu)
>                   /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
>                   env->xregs[0] = -1;
>               }
> +        } else if (tcg_enabled()) {
> +            /* FIXME check we are called from EL1 (so EL0 -> UDEF) ? */
> +            hvf_raise_exception(cpu, EXCP_HVC, syn_aa64_hvc(0), 2);
>           } else {
>               trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
>               hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);


