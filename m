Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2FCC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzQO-00055U-Lu; Wed, 02 Jul 2025 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzQL-00050P-9z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:31:02 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzQH-0004Vv-41
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:31:00 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7382ffcb373so3640531a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751470255; x=1752075055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C2jgzcZvb8y2CGvrF13/X+MqF9N4fEyMoa/4Cbfnllc=;
 b=lBcqFyzhilVdwtmv6V6oN+w73Of8lF6FWWco1VyezyBPi5vRJtU1Adr/n7zq4lKv3f
 9pvczIHOsyGueeAvt5ufea5rsQbJL+N0SWcZHtP8O0u4gmlKKB3GbYAfmzamsIJQthF1
 Sa+TmiZgpnraiR5VoIBZRghYtpWUmg50SLw7nPwkusEb2VsE9GeRjiet/143darjlOxh
 /s0GpAUi3VCE9uBjRATxpl4MAAYgj7jKl8Mv600Z0+n23vGR9d5xSLzdAJ/OhOSTTHEN
 d73JnPVArXn3F8n9sATKAAUfavHcBK1/qdWScxijCmp4KtguNaHJBHinvEwvHPupXlIC
 r23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470255; x=1752075055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2jgzcZvb8y2CGvrF13/X+MqF9N4fEyMoa/4Cbfnllc=;
 b=JB6PmERNmhzVgdyVeoxF0ekM89Rjztjyqy3FG3y6gf4dK8ubyiPLKi7qXTzLG0KGnt
 Nv7WI71BYEjHR25v5MEhU6nLfelQnP7+hbxhYZvH6jdTpYZwqVaW5I1IJzOYVmliPUdW
 ZWAmQm8QbF1S6qMPoXK555wP8U/txN5mujGt8BG495rsw1bP2ogsvyAsAJ/BJfH/lBqC
 M27L9NLqxk8Aq0NVmfP/XmI09viNT1q2J8Ugq+w2+9q0cs1bKaljTHUP46C9F57beQ4Y
 jzn5n13pFKNSnpmcJqP8w5IyYds4qlEb2lm1fmb//hdy5jhUaFgF8RCL+8+v7VCctBZN
 SUaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNcNSuyTAm3nrGMNR9XTnEiNh7AP0xc8wyGOc+AyhcEgAMHSTu/7DmQmKoJ9uMaqHGh25nnCokaGhc@nongnu.org
X-Gm-Message-State: AOJu0YxgPGvfi8jW/JFBux0nrFKl8rko4EQxnUFQkl9ISo8wdlpKOk+P
 lEvPanSgNXEOEHL/Jr9+amsX2iSHU+y01Rt+ym6JWTnHTCH52h1VBWZbYUFKcZXzM4g=
X-Gm-Gg: ASbGncsUoR+/H3FqddHnWjqBOHX6q9ZoZpowkmjgiJnxfpgBgM6qg/D5qysL2fkSDir
 n8M8W7ok58zCSex62cWS8Zij57acOhwfhn6JyM261gLGWs+50ZAF4tIzl8uy7JeBctPMlObHmZ8
 sZC684/MHZ6ZI7kK4DizphMtxp1ZG1N4YRVxfnkjumzec2nwAGEHiPEeOaoRHXwBbNtwK7N4dCH
 Lt4GevkvBRvZxyHSSbN4gGvslMfL/wvZz8qY/6e3LneHUy/fg8buWhVjkcl9+gwgAvyRlrTUyhi
 ISp+kTuRA/0NJkU1Nlqwk0ByE7Ovicb/sbaNTkL0gr8Bow7tQsWFTWalc7fn5FKZLDQ+CwlHGYm
 LUFR/be6DHP4=
X-Google-Smtp-Source: AGHT+IHM9OLypF+wieeEkVsZ3ptxHBAmKUYalFgaHY/YGBUZlu6o54UPQASz99o2JZE3Nr7xSVbS/A==
X-Received: by 2002:a05:6870:ec87:b0:2bc:8c4a:aac2 with SMTP id
 586e51a60fabf-2f5c7b465e4mr2682585fac.27.1751470255009; 
 Wed, 02 Jul 2025 08:30:55 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb101607sm2521714a34.56.2025.07.02.08.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:30:54 -0700 (PDT)
Message-ID: <8353d9c8-8dd6-4dd1-ade6-4dd7f5a4c8c5@linaro.org>
Date: Wed, 2 Jul 2025 09:30:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 67/68] accel: Have each accelerator implement the
 handle_interrupt() hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-68-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-68-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Better to make the interrupt handler an explicit implementation
> rather than depending on some generic handler.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/dummy-cpus.h                |  1 +
>   include/system/accel-ops.h        |  1 +
>   accel/dummy-cpus.c                |  7 +++++++
>   accel/hvf/hvf-accel-ops.c         |  8 ++++++++
>   accel/kvm/kvm-accel-ops.c         |  8 ++++++++
>   accel/qtest/qtest.c               |  1 +
>   accel/xen/xen-all.c               |  1 +
>   system/cpus.c                     | 15 ++-------------
>   target/i386/nvmm/nvmm-accel-ops.c |  8 ++++++++
>   target/i386/whpx/whpx-accel-ops.c |  8 ++++++++
>   10 files changed, 45 insertions(+), 13 deletions(-)

I had suggested exporting generic_handle_interrupt

> @@ -358,6 +365,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
>       ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
>       ops->exec_vcpu_thread = hvf_vcpu_exec;
>       ops->destroy_vcpu_thread = hvf_vcpu_destroy;
> +    ops->handle_interrupt = hvf_handle_interrupt;

... and then registering it in each accelerator,

> diff --git a/system/cpus.c b/system/cpus.c
> index 8c2647f5f19..e217e42ba03 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -246,13 +246,6 @@ int64_t cpus_get_elapsed_ticks(void)
>       return cpu_get_ticks();
>   }
>   
> -static void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
> -{
> -    if (!qemu_cpu_is_self(cpu)) {
> -        qemu_cpu_kick(cpu);
> -    }
> -}

... rather than removing the common implementation.


r~

