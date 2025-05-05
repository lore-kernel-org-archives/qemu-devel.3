Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341CBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBz2L-0006gY-3g; Mon, 05 May 2025 12:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBz1r-0006Xe-MR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:50:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBz1p-0002Bp-P2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:50:55 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5f6c3f7b0b0so9243801a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746463852; x=1747068652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=50pPYFfyKWT3q17oqBMXFK2A/u8T8fwQ62NGtMV9zqg=;
 b=ZBMyOUPi1mjf/+Gjbv/ZrXwZa/GJIFliC4hzl/gMA8Sg6fkVZlgrO9kpr5G3EVaVYL
 UjxShq9qI5jNuEGE+zbTwQ2RyH5pG4tKuin2RchseRBHeGgRvW6Nn8UUyXfSk8xgB0oR
 klQLZR5dG1iPJHWCMFSmFOc4JAl+WWHdcBmJ3XqbSlsv1LllVj0aF92vINaDey5WQp2e
 wY8P9xeDkMLVq1Bvy/v5GJAgbG5JPPPs5PPJWYRjIssS/YY5TsgmFgTEqULirSW+Rgko
 cG608uzpuyoNochYp++m1NGy90/2CTmujoLj9Lr2B4Oo0ZItOfZ3ke6RmhQOoC8pcxjy
 Mabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463852; x=1747068652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50pPYFfyKWT3q17oqBMXFK2A/u8T8fwQ62NGtMV9zqg=;
 b=vOSStglVw53OUEUJfoG++6ei+Rm+z+2Y0ei0/+lhcbyrs9E/4EOMExRo15cQya+//a
 iIPjzyVUagvpDYMLYtAm0T1+A/d0p6UHvQgpGX31GJ7I/ObpYl0G1mMXloVubSPVmteJ
 QMsgO6RJfr/wV3hgHlXNhDMyA7JP7dIym8hLZCfcbXOhPw2T30HJFJbT23/YmAKfn3og
 QhMiDREiKSQs+OwlVr278O/7Lx6abMXdz6SnAoVE33qrJTVQa7lYs0mZ6LjVt+3IyK5y
 qVzBJhao/LV/PDZERyFv3YWdbZcwsembg3j+09chtsuLBDEN9Y4CNa6gyo31hRO4edZA
 78dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCZ575M3aZ2ZhRL308HDY9GWNVLxZzy6RpEByHYETMzSQ6PnI7Z4l5ELkc7w+waPQEw125eI6eyk2i@nongnu.org
X-Gm-Message-State: AOJu0YwL6IyP7U51EGawV5rGBch8YyQk7gsPN4kgADpeaVen/kIXZSYI
 +7J6X9p0PMLb5Ihr980+8RmRwwblk/VVQu1/pUg9BF6fEyI8yoyLDWzou2usy/c=
X-Gm-Gg: ASbGncs67dsBVkEAsvKnqUC3sN19ETs1EJLeOgpMqIs+caXxcJoXt1PI5wgtcd2OGGz
 a1VduS93eXm3kjFzy6cKbxBkVVAYIkc3GnIt1yb5jtJH8FMEKfb4QEiUbThQi3U5o29XCSQvD9/
 3ngQz1KHlSPOuhIAa/xDj4x+Zd39oDbWe+UcjLJOeBaig3jrgJhihGOOoY5L5CgnHl0GAQImy4p
 +g+nKUwKbwyJh9B7BvAgb2kWjBUc724M6MKoP9sYtsof0Tqzw+9H9354bt2mkLvl6ey06AeQAMr
 7XbYvDI9HLOSVEy8fHJMa8fcwNqrsLhL6pv4VPa8zA1X1U/Sbh1wzAT6kwJaOjbOqWUXDIH+Dcd
 A
X-Google-Smtp-Source: AGHT+IElfIcOOITzKcXzzZ6eHi6DbH7EARmxXkrX6QeL2frbRr2FX1kpcbJs9/6I02v5TsvgsFg5Zw==
X-Received: by 2002:a05:6402:268c:b0:5fb:3ca1:fb3c with SMTP id
 4fb4d7f45d1cf-5fb3ca1fcdamr1390305a12.27.1746463851859; 
 Mon, 05 May 2025 09:50:51 -0700 (PDT)
Received: from [10.194.152.213] (69.21.205.77.rev.sfr.net. [77.205.21.69])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77b914d9sm5644070a12.62.2025.05.05.09.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:50:51 -0700 (PDT)
Message-ID: <e59a8b0f-7342-4fa7-aec5-98aebd2fa70b@linaro.org>
Date: Mon, 5 May 2025 18:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/ppc: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-ppc@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Check 32 vs 64-bit state.
> 
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/cpu_init.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index cf88a18244..1f18967b62 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7386,6 +7386,12 @@ static void ppc_cpu_exec_exit(CPUState *cs)
>           cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
>       }
>   }
> +
> +static vaddr ppc_pointer_wrap(CPUState *cs, int mmu_idx,
> +                              vaddr result, vaddr base)
> +{
> +    return (cpu_env(cs)->hflags >> HFLAGS_64) & 1 ? result : (uint32_t)result;

Alternatively expose and use NARROW_MODE().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +}
>   #endif /* CONFIG_TCG */
>   
>   #endif /* !CONFIG_USER_ONLY */
> @@ -7490,6 +7496,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>     .record_sigsegv = ppc_cpu_record_sigsegv,
>   #else
>     .tlb_fill = ppc_cpu_tlb_fill,
> +  .pointer_wrap = ppc_pointer_wrap,
>     .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
>     .cpu_exec_halt = ppc_cpu_has_work,
>     .cpu_exec_reset = cpu_reset,


