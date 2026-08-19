Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390ECC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmjk-00013b-68; Wed, 19 Aug 2026 16:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmjj-00013T-Aw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:18:11 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmjh-0006P7-RN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:18:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2297323a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787170688; x=1787775488; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MzOu+Ox55+TvKwDfULgkWDr0GLGQ+Pk1YhCbiT82vmM=;
 b=lmSxGwcN35Bm6mhaja38H+OghmLRdPfYtOOFhn/U/GUiI6qFbrWGLp63gryFGjUpti
 K0KyY+m2BsajCiVBxXp0WACb0DazXEOPmHjwEMFWE0ewUgZNVo9FWSSenNRM9uEnmB+t
 oINKmikGIBzkGn/Oas0M/DAbf5J65on0OSn9E7fI25QJyGE/vSC5oqPHlXG9coacgclT
 MNiQo69R/sMgwZKXITO5xKZwIKB3B/PtyHk0O7pp5qAvSZfkOeZOVyQ+yfFSThpIXyj2
 NPV/bap4qfOaVz0pep5m8HYwre/8ZSbeV2Yb2X4Y/RBF5Y1s7ycawaksEfx+8sQlCgcs
 kZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170688; x=1787775488;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MzOu+Ox55+TvKwDfULgkWDr0GLGQ+Pk1YhCbiT82vmM=;
 b=IjiPRJtkCA0B96XkC1iQ/XvTgE9otwpeRUO44POfJBmAW6RTHHE/rAGHS7HaEKC+j5
 eCuXpkB4yI75ug+1fWGj3XTRoRjw6jnSlDkqfrQWwWm0ONEDTnh2L9QQNGkjg9aYZgmI
 f26J2YPmSPaHtO/K0OlRTIAvndY959G5621LgrWKNWcwDQoT0P1hrVjNeawtr38t5kdK
 PlZ1zhfPUdd+XpMtE9k6GsNqe8PwXMUbQXJWYeAZ+UY8y68uaV4KW5xRZN2whNoReJgf
 o8fUDe7bomUwXkLu3tQhTn+s5uAeK2xqvCySjuK3WRO83BfH6ixJyCuPCnCkyPticxmm
 CsMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6fZ+Vg5Rie1L9MX69VassomFfPbvW5hunX3rqYPw8YUMnoVT+qeG85VjeMCoo2hUGDy6dj7VnpXkl@nongnu.org
X-Gm-Message-State: AFuF++ny1EiKjc1xpwqXJ3CDZyaoX+3kpAzsQxKW5AFSZcbyNpUdasK6
 s09wFlUUE0w0hGM3JA+4DZbUd4QURqhV+dhde8WdjoujCG2vfdY6ffgK3LNjv4wMkuo=
X-Gm-Gg: AR+sD10nnR+LsG6BhwkhQurRoQK0lgjM/ZTeb3E8FrvZqlLOlSXaIpF5RKCmO9LNOIf
 mvAbwx39Od0d1IlqCLQrkFTscwJ0dQvPA3eWbzfLSMWUWQmaYizYznPkBVJVbDceCyPicq1+rCb
 AmgZAVn9Nk4vdDg8kKPw5Nxwg6iOlYZne1PmKCQq6bwKRoGGZpp5PyvL0Xf4LSUf/dwW6hCSPnW
 ysgyXFgNLj8lOaI8t8YU6TD0Dgm7B9BTkVBc0lENUUkp81kqF6ea6MsP7xIPIl0PGU2CXjaeRHZ
 ZjPci6rC3eNKDYviWdAM2nUtEn5+i59bxuxB37Ez1rx9LmQgjz8V3j5MjwV4q+lV+nQgqSJPgvV
 DR0a+18KkFyyqfHvmS/peaKXJtIoFC+cCF1Zy7wTE1TQkSpRnWe+hblIg/d/3Qid2f5osJbeM+7
 Umo+6RBPYEgOQ+muFRCZipk//JihjBMAfvGqQfarnVTOks0VUuXGFc3f3g3x8qcJ+qHeqy/FcRD
 STgB5+G
X-Received: by 2002:a17:90b:394b:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-39580a53e78mr14078475a91.3.1787170687856; 
 Wed, 19 Aug 2026 13:18:07 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf726dsm3790044a91.12.2026.08.19.13.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:18:07 -0700 (PDT)
Message-ID: <fe476bc7-052b-48a8-ba51-6c257b386d5b@linaro.org>
Date: Wed, 19 Aug 2026 13:17:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] target/i386: Extract halt-to-exec transition out of
 x86_cpu_exec_halt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> Refactor the halt-to-execution target-specific transition logic
> (setting trap flag in debug register and injecting debug exceptions)
> into a separate x86_cpu_transition_halt_to_exec() function.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/i386/tcg/helper-tcg.h        |  1 +
>   target/i386/tcg/system/seg_helper.c | 20 +++++++++++++-------
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index cab197368b9..65819670493 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -39,6 +39,7 @@ void x86_cpu_do_interrupt(CPUState *cpu);
>   #ifndef CONFIG_USER_ONLY
>   void x86_cpu_process_async_events(CPUState *cpu);
>   bool x86_cpu_exec_halt(CPUState *cpu);
> +void x86_cpu_transition_halt_to_exec(CPUState *cpu);
>   bool x86_need_replay_interrupt(int interrupt_request);
>   bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
>   #endif
> diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
> index 4856a6b3bab..9b2adcca76c 100644
> --- a/target/i386/tcg/system/seg_helper.c
> +++ b/target/i386/tcg/system/seg_helper.c
> @@ -140,22 +140,28 @@ void x86_cpu_process_async_events(CPUState *cpu)
>       }
>   }
>   
> -bool x86_cpu_exec_halt(CPUState *cpu)
> +void x86_cpu_transition_halt_to_exec(CPUState *cpu)
>   {
>       X86CPU *x86_cpu = X86_CPU(cpu);
> -    CPUX86State *env = &x86_cpu->env;
> +    CPUX86State *env = cpu_env(cpu);
>   
> -    x86_cpu_process_async_events(cpu);
> -
> -    if (!cpu_has_work(cpu)) {
> -        return false;
> -    }
> +    assert(cpu_has_work(cpu));
>   

Likewise, why did you add this?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

