Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1369AC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsJe-0006k9-NV; Sat, 24 May 2025 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsJc-0006jx-Tu
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:05:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsJR-0005Kn-UF
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:05:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so856918f8f.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748106332; x=1748711132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qLBdDqLEqq9ZKK1uTNmLGeqoTC7lrZBLmnvS2ePPyDA=;
 b=K8QuX4sb9ZNJzPVX9lA26jRw4QIRsxKRyqPGNspnGFKlNptez9PXIcJbKBD70byjPA
 v7bSpNUyCrOuXl8T7Z6NK/bH16xFM0eeJKxtHtjKKIgvfU2LZS6zUgopZm1GbNUo9CU5
 cz+5cQD/y3IR4RcwyiVRY5IUUD9UbBIaMdvtO1DSkLTUTlZn8gFnsavNX9PlYxdc62+b
 maPjlSwQA46yilMC+m0py1y4kbzVuMw9lBx4Mby3dRexJsvYcRvG3zCQ1TY8xeC7CV8V
 SeCjjUkg1vJU1uJY4H9Kvsp+tn+SSQBt2J8nb6EXDQuOATHYd5rfW/szoaCscbhIUo3X
 vUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106332; x=1748711132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qLBdDqLEqq9ZKK1uTNmLGeqoTC7lrZBLmnvS2ePPyDA=;
 b=iaaDpj/6KV3wgxb1iE+UR1z4QdpTBxqUFDzujYlwqygEhfTckwK7kSwzubVManx2Xu
 5FYC0frUgwhgcjiH9ht2zJqZtqJSapKu0js6NNolm3o548u/S8oeILVTGXUORcrolQJV
 QlN3kIs/69ar7I1kAG8/vyLTDDXQwRuterQ532LlgTaTZhxUqxZ8hIXwv2RfMU3wrhPP
 t+/OChwc3T19ddG8Jgl1jPcksq6nQIgxwf+gc3qlWuqYRHDGaybK2SrqC3xGjWJa3OvW
 OCSazKYdagXwbDchP/nUes1Yj2or7Ny7cdfQHAzEoPLt1rDgQeuO+D7bT4eagrc24PNW
 nR9g==
X-Gm-Message-State: AOJu0YxBC6pWq6abifV3YBq42bpTJL7HPI/U9yeCVS82BxBDABXHaR9W
 KEbSOBA3EkgFsGxYrI2UyKnt7IMa3XBo/lC+HdWtwGmTurM1p2pLT4Vah836zfI9zFIf4o9Ru3N
 FnMJMpQjEiA==
X-Gm-Gg: ASbGncuaJZiZZ2JysPYekk2tYjGOr47fZ8gJ1bIrC/NuRC+BfwQ96JArOTyOZn4SZTm
 Xd/3kikTU//ZTCuXfeLhnl97qFOJc8CBwzYSY6+0haxmkUHeOwL/3b4MteqzdVpwrdYtl+ZPo/l
 TUj+RnzP6Qozpj+qHpPgmE37V1G/GM9FbL+HscBF6QSrMA/Tca4Nt6LlfENv/XdhbDLA/AZfJb1
 wyQy7QZPU6WwQ6hW4HpruABHuO5CBIDzCJV84dN95vllt7NecsDJ1+TD20U89j595BTTbd2mUU0
 XsY3BSUq5RdRfXWDH8Bvqzrae0pSRSJ7S8DW1BuvkAhlV3VIlAz7xBdAH+VVkh9LQw==
X-Google-Smtp-Source: AGHT+IFu7kRaIppd+Iq9f1BZWy3opG9lUgfNcWgwF6p9FyAmi4xYrwA7Mz14ZwlnUYI6gqCdO1Deag==
X-Received: by 2002:a05:6000:40e1:b0:3a4:d0ed:2579 with SMTP id
 ffacd0b85a97d-3a4d0ed281bmr1126407f8f.22.1748106332174; 
 Sat, 24 May 2025 10:05:32 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm30274642f8f.71.2025.05.24.10.05.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:05:31 -0700 (PDT)
Message-ID: <174271ae-c735-493e-a656-1fc66c7960ae@linaro.org>
Date: Sat, 24 May 2025 18:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/25] target/arm: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <e90a289ac289d98ebf9982de302d2655f96b22d3.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e90a289ac289d98ebf9982de302d2655f96b22d3.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> @@ -10880,6 +10899,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
>       unsigned int new_el = env->exception.target_el;
> +    uint64_t last_pc = env->pc;

Incorrect.

env->pc is for aarch64 only.
env->regs[15] is for aarch32.

You probably want to use cpu->cc->tcg_ops->get_pc here.
Or export arm_cpu_get_pc from cpu.c so that you can call it directly.

> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index 6614719832..bcb4aae0d5 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -23,6 +23,7 @@
>   #if !defined(CONFIG_USER_ONLY)
>   #include "hw/intc/armv7m_nvic.h"
>   #endif
> +#include "qemu/plugin.h"
>   
>   static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
>                            uint32_t reg, uint32_t val)
> @@ -2185,6 +2186,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>       CPUARMState *env = &cpu->env;
>       uint32_t lr;
>       bool ignore_stackfaults;
> +    uint64_t last_pc = env->pc;

m-profile is always aarch32.

> +    switch (cs->exception_index) {
> +    case EXCP_IRQ:
> +    case EXCP_VIRQ:
> +    case EXCP_NMI:
> +    case EXCP_VINMI:
> +    case EXCP_FIQ:
> +    case EXCP_VFIQ:
> +    case EXCP_VFNMI:
> +    case EXCP_VSERR:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +    }

Share code with a-profile?  Perhaps place the function in internals.h.


r~

