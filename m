Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F2CC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhu04-0001b8-0i; Fri, 01 Aug 2025 13:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsSV-0005aw-Nm
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:18:19 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsSS-0006XH-VX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:18:15 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71b71a8d5f0so9271427b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754065089; x=1754669889; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sqBi0kmcxA97evFpfHFevkQBfDph/n7SVFyF5HSfI3A=;
 b=tCQPiEtcZXCLRX+BLJ0AUJ6Icl5ZZqW2TtkRNYDxOI31Wq96nGCRADegHUsfnY053N
 PxE5xJssxzq1v+4eTwxB/cLAHCSbRDwGpdud/Xxxi5ysRnfyFq+FiFXy9DtNpjujm02x
 SFiINuO8N8AUFk0c7+sikChOqrjTs/aMGVPjjE8qNQIwM/Kq3v0qkvwauJUnuTHvU+fS
 SHDR2tEEwBh14fJ4+v/HVZghgNSgxxAn3Mge5FwrNBjtCqCN2XsBSVfwdAQ4uxfhsrYT
 7E3fPXdIr4cfk3N7eeeQ92URcb6UcvX9O15+hHd0fSo+oOiz7MhHMH9zz4F+R7UyjmNh
 4rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754065089; x=1754669889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqBi0kmcxA97evFpfHFevkQBfDph/n7SVFyF5HSfI3A=;
 b=h6y/sqFeM3jHhXgiwJKvlX+lNfFNKedmiI7WFDClH+wvmlK0vRXB1wurx+e1/CHM84
 WBO9/WoHXpoj2nVyYT2yamX0WvLsQMP/RhQWCcTpb6B1IrURnhe1SGXDWEHErZlHJyhj
 jg6Sg3kE+X9vHmNkvRWCfoiVPnXYooQnlRwYlfvemoox6aJYT1slfyxHODgvY/3mgS4o
 HMrlV2vWHDr94Njg4HzXFvGvdaWfjYZtlgd6yIzZRq+hDRkaLGMvmjG/HBH3mUVI6vW9
 Qj5kXw9HVOTza67xl92fhTkwP5PnPTRWBcBVdBoXmRsuC+uttDfbY/STOzn1zBS2zp/q
 XnTw==
X-Gm-Message-State: AOJu0Yz4QpZFlYs4P/5MA6VOGN7JmJOpFzaxxDe8tWBr+ffrRLGoDHWW
 4rIyVuzDtB6vXvl7mlS/uVNY+9MnedZIrRpOd9QbJXhkZJNgzYAdI9Z2Kc53h6EJ01l25u3p60B
 pgAh8QtdzN5mrDe1O40v7yKfjfq6vnewbgmT3osNLRkuUDfI4cmto
X-Gm-Gg: ASbGnctA+upgK932X81ZTaBwFUen+URbkGsAfKmpl1bmTzJSwv1eo5FnB9r8GV/jYqc
 hF81hLMnwOTVF5aHXwaSTNhipZ7hx//WHDBUtihRWryITmZAlDie7vlephzWGsH/upPRUxrzhEJ
 4MTUmORgoNRXUHhuvX8ONIYWkY+D037KNP0WcbkeGY6Tpuws+dxzSWCE4BR8TszrcAPlqL8sfAZ
 ASwKjLj
X-Google-Smtp-Source: AGHT+IF0yBt3Q7sn5wIjzlY4mm10COuiGK+cqQ2m8WJn2yhOQT3eYRkiK3AaMwoWrK0OlQEQ6aVGHhXhDbbx2l5wdW8=
X-Received: by 2002:a05:690c:6f02:b0:71a:3849:f88e with SMTP id
 00721157ae682-71b7ef6f9b4mr3536277b3.17.1754065089453; Fri, 01 Aug 2025
 09:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-24-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:17:58 +0100
X-Gm-Features: Ac12FXy97XYxZ6tbdlmzbsqfLHDh0yViYvsCpE9h-6Q2JYw-HwWwwcor6FUfpBA
Message-ID: <CAFEAcA_bRSRDxxj-OpDRYSh+P_BwO2iMLqqHPUerma69Lhxw7w@mail.gmail.com>
Subject: Re: [PATCH 23/89] linux-user/i386: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 30 Jul 2025 at 01:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
> Temporarily introduce HAVE_INIT_MAIN_THREAD during conversion.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/qemu.h          |  1 +
>  linux-user/elfload.c       | 29 ++++++-----------------------
>  linux-user/i386/cpu_loop.c | 31 ++++++-------------------------
>  3 files changed, 13 insertions(+), 48 deletions(-)

> -static inline void init_thread(struct target_pt_regs *regs,
> -                               struct image_info *infop)
> -{
> -    regs->esp = infop->start_stack;
> -    regs->eip = infop->entry;
> -
> -    /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program
> -       starts %edx contains a pointer to a function which might be
> -       registered using `atexit'.  This provides a mean for the
> -       dynamic linker to call DT_FINI functions for shared libraries
> -       that have been loaded before the code runs.
> -
> -       A value of 0 tells we have no such handler.  */

This seems like a useful comment to retain -- it's nice
to know whether we're zeroing a register as an ABI requirement
versus just being tidy.

> -    regs->edx = 0;
> -}

> +    memset(env->regs, 0, sizeof(env->regs));

Are we not allowed to assume the regs are zero out of reset ?

> +    env->regs[R_ESP] = info->start_stack;
> +    env->eip = info->entry;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

