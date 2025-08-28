Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A767CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCQ-0003EZ-5f; Thu, 28 Aug 2025 13:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureUm-0002bH-34
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:25:00 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureUh-0007wC-Pa
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:24:58 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d60504788so8220647b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394694; x=1756999494; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7dq30+EQLDj1EFHAcfIExmcFDOzmtvdKXD/eIAiVKXc=;
 b=pM3ZAOiBaGF1ioWZw+Ao4Cl9ulxjrrzsQ1f8J3qn4tT1osVaUd8mh9284kkq0/l+bj
 VDaDLS0JuwzTUKves2HSL7FUyNaq6QiseALA+WB0HBbnNlfG0j0GcQPDxYeWm34AZBZO
 6PywZbnL3mB3YKIQc2PaIHcfgkUBUb/sBZfHqGrwpsZ/tzfZEiEjWbP1Fn/Tl3D/LHbD
 D2Ff8mh/PAlOqtB4tgPr5QEPo1DyCoz+9+uVTJqE79FDKIqusZ7LnafUZ9wbWFiRhSB7
 RVJMSqfCd0F9LBIGjByjsToF+XajipaAEwjgTLM1WUdc+5DT0D+WoiSFU70Yi41xo8o/
 fV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394694; x=1756999494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7dq30+EQLDj1EFHAcfIExmcFDOzmtvdKXD/eIAiVKXc=;
 b=pJfR+OYiqyxbw8754CB/OcsDeTyDeoDos+wnCKxZfXVVCEoaj0gTS4xO8s7JCkzZDj
 wDG7ATyXp0SVS8onHgPXgLY1KWnboGOivSZKM9O0wLEW8gkOXuWCBXYleKGV2zmN4OMN
 X3XGFTvuikADy0GSmRTluHKAUstraXhvkdLP+jbmj+FK7WnrnhuPjOYeaZtct2+d1akw
 6ZMFImcH7kVu/Zr2HKp6sHihtNLawnVjO7ZBRcw2gWIE+/gOXBUGp/4+aJYzArW0r4S8
 WvKqPZUCoLnG8XTk4MC+7ZnYhkx9B0m+vM3+IijNl0gpg+rLsl0CKl0tZ9T/2p/ygjNJ
 gLQw==
X-Gm-Message-State: AOJu0YzOXPzoLVNksQ4RjybkRzhpE6DZbgW0xocDXAWytmJbA023t4Yh
 y3O9MzFFLwAOTzjRreAcr55nBoVKr8SV+YX5vE05cGdfQLjiNOsd5jb8ucwocyM+gIn7ONAa8fr
 ZSTxyruB1JbQtMtQ/XkjotLNIXyZuA9bgGA7RQeEm67KX1k9hVh0n
X-Gm-Gg: ASbGnctWGxZ2od7CIOikeKZ1mBySLmfyA4X3pKWG1fizxhzrWsyvmJTu9P5v02ogHSm
 3hy2U6uqLslx7NxcBU5vVKSMOloExLsdrT8lQOPHRsVB7p8ZLaZQ5Qdxez36Ao0fotnKFqglYtu
 FdntNQ67ylIGLwxf8drphFiV2xbJfgwQks6JrE2MZWrcl0beGoOYNeORU3nqQkTdbm0kvo5OFKI
 /+91hMnt773LDgudUI=
X-Google-Smtp-Source: AGHT+IHTuWCCb1BV2qXFiMVe0B1HvWvt2CqrwAinJAB1vMB6mZ22GVsc64ofspTnkLu3G/MzMdH2XVPRVxyW9JsfqzQ=
X-Received: by 2002:a05:690c:6a8a:b0:721:6cf8:83c5 with SMTP id
 00721157ae682-7216cf888c9mr8256757b3.43.1756394693996; Thu, 28 Aug 2025
 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250827053822.4094239-1-richard.henderson@linaro.org>
 <20250827053822.4094239-2-richard.henderson@linaro.org>
In-Reply-To: <20250827053822.4094239-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:24:42 +0100
X-Gm-Features: Ac12FXwep9IfyG6Rod-hBkM4jmVzje1zhCmGJ6So-Elm_f9i3KOeONGIXFfWuxg
Message-ID: <CAFEAcA9YC1772qpnT4eT=WP8=pmoACkx0k-a1p8fuXYZh54z=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/core: Dump cpu_reset in the reset.exit phase
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Henk van der Laak <henk@laaksoft.nl>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 27 Aug 2025 at 06:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> During reset.hold, the cpu is in an inconsistent state,
> where the leaf class has not had a chance to initialize
> state at all.
>
> This is visible as a SIGSEGV in "qemu-system-sparc64 -d cpu_reset".
>
> Move the dump to the exit phase, where all initialization
> is certain to be complete.
>
> Reported-by: Henk van der Laak <henk@laaksoft.nl>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/core/cpu-common.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 39e674aca2..26321be785 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -119,11 +119,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
>  {
>      CPUState *cpu = CPU(obj);
>
> -    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
> -        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
> -        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
> -    }
> -
>      cpu->interrupt_request = 0;
>      cpu->halted = cpu->start_powered_off;
>      cpu->mem_io_pc = 0;
> @@ -137,6 +132,16 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
>      cpu_exec_reset_hold(cpu);
>  }
>
> +static void cpu_common_reset_exit(Object *obj, ResetType type)
> +{
> +    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
> +        CPUState *cpu = CPU(obj);
> +
> +        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
> +        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
> +    }
> +}
> +
>  ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
>  {
>      ObjectClass *oc;
> @@ -380,6 +385,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
>      dc->realize = cpu_common_realizefn;
>      dc->unrealize = cpu_common_unrealizefn;
>      rc->phases.hold = cpu_common_reset_hold;
> +    rc->phases.exit = cpu_common_reset_exit;
>      cpu_class_init_props(dc);
>      /*
>       * Reason: CPUs still need special care by board code: wiring up

If we ever have CPUs that actually update their state in
the reset exit phase (e.g. if we manage to complete the refactoring
that would let us implement M-profile "load starting PC and SP
from memory" in reset-exit after rom blob loading rather than
having a hack to do it in reset-hold), this won't capture that.
But it's clearly better than trying to do it in the common
reset-hold method...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

