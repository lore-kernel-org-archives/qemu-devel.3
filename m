Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38859C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNDQ-0006k7-Jv; Fri, 24 Jan 2025 12:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNDP-0006jc-Bm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:11:31 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNDM-00064W-Pq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:11:31 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2163b0c09afso46002775ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738687; x=1738343487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h7GDB6hr+bb6mQuwcGJyYDs6n5LeT2y1TOI7F+iwvPk=;
 b=GY+T1I3dkjjFYKluYvy4Lc+WJ54SK0/3RKP1xo2Z5NWWFaUDIZ6rZUMYxIa8tGUFlJ
 UyIwbR4o6cSp+jcDKCZx1qchtDrYmExdcyl29dWWPaqOj4TAfjosB7uaB2WThpY8moBw
 vD8CzSj+FeAAxi+2U3H2BQFAapb2MVmVw/5yX95OayFgzRdYVwZzkGn0pzryrQHoyj4p
 f0xZe22E2XHo1HYQB42maDX4EtPZzIRON2z2hBXCM8EQ0qlDaZeHWDPMuVSJpPEg54bE
 7FjDbvCSiN5V+CEDg3eoq8vwm9QtqY7HCtbj0jjArpzh22mGeTXxgBKFJW8CX9Efwy7D
 zoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738687; x=1738343487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7GDB6hr+bb6mQuwcGJyYDs6n5LeT2y1TOI7F+iwvPk=;
 b=drJBxN3s0VyvYQng3V4H1FdDJWwuSxkCgHuYp/rKeSwZlahhAqczf/GC1UtR7BBupf
 L+bw2uCO5SIKTTDynzAgC9fFsCHb0rIvkAwZOh4xg2R+rVhhxAZMy+m+h2R1FDhMjDv6
 33RLH4C63jEjmSMFMpYfHxeXWPaa40tZivpU8M74i2WIaVbNZKiu8CUsXjbXnSlBvcus
 qGSvtG5TOlWtS9A5wJ892zUu6XubsSSCVMDM55mKmsFNz3+KfznRhzR/s90093kxKUef
 QFq1uq4hzbuWIZvbfXfVe0vPBrDhhlzyZt5D58W2y39Rstr/iYCyE6Y7ytBKP1lSlhTI
 VKbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMlvRwhaeM0Yb+6NCIZo08mgq88g25KGnLRrmDo7Du5iOM+acZn4U/DslAbS4gJWTCqR/huMv/ce7i@nongnu.org
X-Gm-Message-State: AOJu0YzCYKnRZFAo3RhAIA2Wn0+wpc5eSZ+bmdHdhnCMMbm5OAShWAo/
 o9XzF0Xw3ol00RsvGBAqnN1FIf6hwJ/Bi76C9k9+7JzK4TpvKaFi6SBgqX8Zra4=
X-Gm-Gg: ASbGnctjdZYexfFx4ON6NOf/zxE4HQcUsQnmwdbu/F6S6dsY2EaVV5TACQLIzWikI4F
 bIraQhPa/8MagMZDVa5UJjbovZ953d7hmJezC/R6tgBUIceiX0WBY/dVK4QNCIixB7i/Up9Uh5h
 MtQU6ICfBBbiFC89HnSv7+70DoKcaE3QNdQjfek+repl3YxEnMX4u/3UnzNt5rb8FSYdXmR4SRS
 HewISMRzJ0SfsTLrl95y+nl+kI80QIHFoqTMLs3t22tG1Z9V+qTOCVNYuN/C61igbdl8ngRyGPr
 rYnZ4KRns7AUaBNHqJ5k5rRs
X-Google-Smtp-Source: AGHT+IH8ZV4NYHFHdc1eoLrOYGxXM2jQfwOIWo9F86/COAJ/Hdvw2m23iuEscOrabDyMq+M/TpqQnQ==
X-Received: by 2002:a17:903:2342:b0:215:cbbf:8926 with SMTP id
 d9443c01a7336-21c355b053fmr469668635ad.35.1737738687271; 
 Fri, 24 Jan 2025 09:11:27 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da4141414sm18607445ad.125.2025.01.24.09.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:11:26 -0800 (PST)
Message-ID: <a082b2ae-5b50-4f04-acd1-24680169f615@linaro.org>
Date: Fri, 24 Jan 2025 09:11:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/28] target/m68k: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/m68k/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 41dfdf58045..eb7fb4f7e4c 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -51,10 +51,12 @@ static void m68k_restore_state_to_opc(CPUState *cs,
>       }
>   }
>   
> +#ifndef CONFIG_USER_ONLY
>   static bool m68k_cpu_has_work(CPUState *cs)
>   {
>       return cs->interrupt_request & CPU_INTERRUPT_HARD;
>   }
> +#endif /* !CONFIG_USER_ONLY */
>   
>   static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
>   {
> @@ -543,6 +545,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
>   #include "hw/core/sysemu-cpu-ops.h"
>   
>   static const struct SysemuCPUOps m68k_sysemu_ops = {
> +    .has_work = m68k_cpu_has_work,
>       .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
>   };
>   #endif /* !CONFIG_USER_ONLY */
> @@ -576,7 +579,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = m68k_cpu_class_by_name;
> -    cc->has_work = m68k_cpu_has_work;
>       cc->mmu_index = m68k_cpu_mmu_index;
>       cc->dump_state = m68k_cpu_dump_state;
>       cc->set_pc = m68k_cpu_set_pc;


