Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E810CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFr-0002pJ-Lo; Thu, 28 Aug 2025 13:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdpt-0001tK-1b
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:42:45 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdpo-0000xd-UL
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:42:42 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d605a70bdso6136197b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392157; x=1756996957; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9qWclpiN6jMwKb1GCF+UBItXxnlfbqyL6xd9BSEEJzg=;
 b=lO3TEB6G/C1HNjo5MdSxsEj+AwuNNlOnRPkgMyHxLEacvjh/919lBUYHOfviFW4ZsE
 zXuMbqVMhrRnXbNfRLbeD7V4J3NAQb4CL0YfzDxQxo0a74dmO7t1egFCIzOwnTEWrImr
 FZJ8itV/vLE1DEO4Z6qvmdGQ4i0RknHoew149vINHApkLmlYCRqcfHj4SfHjEOoDTWHk
 QbR2YT3HfbBtf0SsI/XxHyMmeV98A8QFPc0FM1NIzhpKWS8nBeQw7lSjRzunhcZlamCn
 fZXR6QNTx0NlQFemMowMUDHRdZ9VjrT4GUDq8wn7VkT1F4uEzwMqAMp0yie5XpF1TX2C
 ubLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392157; x=1756996957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qWclpiN6jMwKb1GCF+UBItXxnlfbqyL6xd9BSEEJzg=;
 b=US2d2gOTavcVQIW+4KVTU1mT+gM+T71zf6zdXFw+95A8KOFG2Yw1duhBYKj9W7+4D/
 qSpb5FLIWb+6G4B6Z8biQMfdqnSIWClDOZIot9LgejK99v3Ndz7xsEmR7ELTJ5RgmC9H
 ksh+qTHFcdScs/norP4tbfUWW6qqvdYWxxlEOlzuMbaeZzAK70NA6Y7T9zAoDY5QuHLI
 /0iDLJzSZUo6NXDi/S7n9DcAUfzJN0Oxb7o7R8LexAf/I+kWpgXYTh8yh/wCWib+aV5j
 p45jdMBQqbNfdStuy9qXzmv1AVskNG0+vo5S4IHt5InRP0I2rSEC8ExIfj9epv/Twmka
 X9nw==
X-Gm-Message-State: AOJu0YxUrM4AmCM6/RwQboVgyAgILBT2Pux5EIbSY9vJIOL1IAQIXcF1
 sUy3QU+tWsk9zUQ4Xi4U6forg0sDEd8Mat443x6JnhqHAww2pMGfRnjI11ngfAcLSJaQ1+8s7rx
 hGusoR/st3ihXIRWbGcJeUMpm7XwvsimQKSYoTUH23g==
X-Gm-Gg: ASbGncsoycwMh2ieXb15Ut7LttQLAhabPPMInXfWB+elG7OpNsxhJBazO8hj7pg0EJx
 M3pIQYV+eRizrfRDMrqupzItQdlpsxFHZRE3XS/VFeuYt4aMEW6FxRkIQa9U1VoF9UKyA0IxJNt
 Zq4fPZ3uqmAff9gipw2q51N6tQh2FAyA6nijhG56Wb0/E8KHfWma+iXGVpojD/1uzkm2ArdzycQ
 wYvU6bD
X-Google-Smtp-Source: AGHT+IEo3rMkqU+jM4kKuMPCBKs2+Qai0LDOEfjpTaszgJlCp35xaHNslA9+a20EBNkRT7E6Jic4/zRJ2AzL5woue4g=
X-Received: by 2002:a05:690c:6082:b0:721:10a3:6584 with SMTP id
 00721157ae682-72110a36c63mr175982417b3.11.1756392156851; Thu, 28 Aug 2025
 07:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-31-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:42:25 +0100
X-Gm-Features: Ac12FXzb7UaFXG3TuloNSd7YQoZvIS41plSsgLMOlLnDd_183hljDBeFoag9X-c
Message-ID: <CAFEAcA9AbA4pa9EjOnkmrGMOOC-4nS+FNqni91bfDDkH1wOAbA@mail.gmail.com>
Subject: Re: [PATCH v3 30/87] linux-user/i386: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the target_pt_regs structure from target_syscall.h.
> Rename the bits according to user_regs_struct, which is
> what is actually used by ELF_CORE_COPY_REGS; the layout
> of the two structure definitions is identical.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/i386/target_ptrace.h  | 31 +++++++++++++++++++++++++++++++
>  linux-user/i386/target_syscall.h | 18 ------------------
>  2 files changed, 31 insertions(+), 18 deletions(-)
>  create mode 100644 linux-user/i386/target_ptrace.h
>
> diff --git a/linux-user/i386/target_ptrace.h b/linux-user/i386/target_ptrace.h
> new file mode 100644
> index 0000000000..51edb637af
> --- /dev/null
> +++ b/linux-user/i386/target_ptrace.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef I386_TARGET_PTRACE_H
> +#define I386_TARGET_PTRACE_H
> +
> +/*
> + * Compare linux arch/x86/include/uapi/asm/ptrace.h (struct pt_regs) and
> + * arch/x86/include/asm/user_32.h (struct user_regs_struct).
> + * The structure layouts are identical; the user_regs_struct names are better.
> + */

Why do you think the user_regs_struct names are better?
"bx" suggests a 16-bit register, but these are 32-bit, right?

> +struct target_pt_regs {
> +    abi_ulong bx;
> +    abi_ulong cx;
> +    abi_ulong dx;
> +    abi_ulong si;
> +    abi_ulong di;
> +    abi_ulong bp;
> +    abi_ulong ax;
> +    abi_ulong ds;
> +    abi_ulong es;
> +    abi_ulong fs;
> +    abi_ulong gs;
> +    abi_ulong orig_ax;
> +    abi_ulong ip;
> +    abi_ulong cs;
> +    abi_ulong flags;
> +    abi_ulong sp;
> +    abi_ulong ss;
> +};
> +
> +#endif /* I386_TARGET_PTRACE_H */
> diff --git a/linux-user/i386/target_syscall.h b/linux-user/i386/target_syscall.h
> index aaade06b13..c214a909a6 100644
> --- a/linux-user/i386/target_syscall.h
> +++ b/linux-user/i386/target_syscall.h
> @@ -5,24 +5,6 @@
>  #define __USER_CS      (0x23)
>  #define __USER_DS      (0x2B)
>
> -struct target_pt_regs {
> -       long ebx;
> -       long ecx;
> -       long edx;
> -       long esi;
> -       long edi;
> -       long ebp;
> -       long eax;
> -       int  xds;
> -       int  xes;
> -       long orig_eax;
> -       long eip;
> -       int  xcs;
> -       long eflags;
> -       long esp;
> -       int  xss;
> -};


Commit message should say something about why we're changing
the types (though clearly here the target-specific types are
more sensible than the host-specific ones).

-- PMM

