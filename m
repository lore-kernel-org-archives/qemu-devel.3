Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318E3D13C3F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkP2D-00034l-Bc; Mon, 26 Jan 2026 11:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkP0Y-0002Sz-56
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:00:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkOyX-0004Fs-5L
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:58:50 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3008124f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769443079; x=1770047879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=he9pvxHC3LHdWUTJt1INCC3GtwtjExEDtZavIVp+1QA=;
 b=DzoRR/tiJcgUH9bQ0IQMde+wbm4B515Bia66nNbe3IpZgjWyXYoniiPIyg8KFqCo2h
 VeRZTewHfyKT/w1KwG9hRWZ5lB3kQOPuetfo2J+b0dlnf8gsNZkldV4rYqjTXWIWdmpr
 twNRjeSmRcpQsrWG0Fac2tpbxKOZNbEwnQOWFCYdKO16Y1p8+E2oulbCFcIYpmGFzvqF
 +jAWpKTDNjBgBpnvFHkQtmt0obzNR3De+xXFYffGK0m7a/420Z/Ai3ReX8Q4M4DcVhVR
 HIZL32uwywnP0RlRPOQV8hazII8uP5oX4WSK1TKxdRxcYpuZSs9Zn9UYZ9faswYBH6DB
 Ry/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443079; x=1770047879;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=he9pvxHC3LHdWUTJt1INCC3GtwtjExEDtZavIVp+1QA=;
 b=caY+Q/dOixVti0+v4tEPtB/0EtrulESDUZQzOSLrkYh2/m6HfuZjyerCsGDFux92KP
 HHaRtpKFMK1he0hwLOCBLbjdl9XMTVOxS8dgLAQBS0PFrJf6mbqzcLkSd/PcYOwNG+sQ
 cMPvb/8MG9Z8YLGzp6W7DG9lxzJR+Ols1vCvLvuaq6d+0ot1gIZYJMhP0o2Yes/Hp4I1
 5m03kXyDzAY1RNJENpdoA8o+scUsVn1J0lJ3vbnrwJmV1W8J16ncv4nDQs6FzO+iGAeN
 y2bgSxrKu+9pIB5kusBhYbaYVcn57isasqvZg2bn7ZA3CV46/f30Fd86iEP/fP8V8tXi
 EuHQ==
X-Gm-Message-State: AOJu0YzvcsrkRvk6RtXUWAphCKYdQHPoIQBtoXEe3uHaKaN/FPIeIWYd
 M56WCPaceM89k5jd6j60tpmwvIX/9O877dYEkR1dqqtmqYk42kN3cFi/JyEd9wkct8o=
X-Gm-Gg: AZuq6aLrftbQeeqvmrotIMC5ARlHCVdOZy34WPtsSUllK9jRnmCTg0sKGw9yiDTTPuk
 zeawSZfMYAIpGle6UouPxJhFkOCApe8p0IduDJf73fjdXFl2DFuzmqDsAQWVExjrChSqG7qzA2y
 wSSqoL26Q2FMzLwS82AfiRco/GIiSCrFVbICT5WebpHUh6EPLKC28TI0JJEOtbsUhRv43pgPyQa
 3BEEuixLrTOs/xmi9N0niZLtYssHLIm+rkV7ILFIseAhvpeQiczfst8f9Ll0Pd6g290LNqGR6yd
 N6tCpwGrGZFarnmPyOGAX2NXGTuhaNAmbtUAFTxUvY+GI8kaTH+3jyLf8NcCkwRhd4m5knII9JX
 jOIzKjEPbXbp0NJ9fPScPzav5TZyd9wA2AxzIyBssf0JIPpEYBlMRWzbNJJvMB/rQM5zLNaXclQ
 GXTmmjNgdKbxmU
X-Received: by 2002:a05:6000:22c9:b0:435:a7ac:660a with SMTP id
 ffacd0b85a97d-435ca0d13d2mr6807871f8f.9.1769443078865; 
 Mon, 26 Jan 2026 07:57:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31149032f8f.9.2026.01.26.07.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:57:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B8C05F8C4;
 Mon, 26 Jan 2026 15:57:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandr Sergeev <sergeev0xef@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] linux-user/syscall.c: Prevent acquiring clone_lock
 while fork()
In-Reply-To: <20260126151612.2176451-1-sergeev0xef@gmail.com> (Aleksandr
 Sergeev's message of "Mon, 26 Jan 2026 18:16:12 +0300")
References: <20260126151612.2176451-1-sergeev0xef@gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 26 Jan 2026 15:57:57 +0000
Message-ID: <87a4y0e58a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Aleksandr Sergeev <sergeev0xef@gmail.com> writes:

(Adding Paolo/Richard to Cc for exclusive discussion)

> By the spec, fork() copies only the thread which executes it.
> So it may happen, what while one thread is doing a fork,
> another thread is holding `clone_lock` mutex
> (e.g. doing a `fork()` or `exit()`).
> So the child process is born with the mutex being held,
> and there are nobody to release it.
>
> As the thread executing do_syscall() is not considered running,
> start_exclusive() does not protect us from the case.

I see the logic of what you say as:

    /* Write pending_cpus before reading other_cpu->running.  */
    smp_mb();
    running_cpus =3D 0;
    CPU_FOREACH(other_cpu) {
        if (qatomic_read(&other_cpu->running)) {
            other_cpu->has_waiter =3D true;
            running_cpus++;
            qemu_cpu_kick(other_cpu);
        }
    }

but...

>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3226
> Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
> ---
>  linux-user/main.c           |  2 ++
>  linux-user/syscall.c        | 14 ++++++++++++++
>  linux-user/user-internals.h |  2 ++
>  3 files changed, 18 insertions(+)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index db751c07576..c49d1e91d22 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -145,6 +145,7 @@ unsigned long guest_stack_size =3D TARGET_DEFAULT_STA=
CK_SIZE;
>  void fork_start(void)
>  {
>      start_exclusive();
> +    clone_fork_start();
>      mmap_fork_start();
>      cpu_list_lock();
>      qemu_plugin_user_prefork_lock();
> @@ -174,6 +175,7 @@ void fork_end(pid_t pid)
>          cpu_list_unlock();
>      }
>      gdbserver_fork_end(thread_cpu, pid);
> +    clone_fork_end(child);
>      /*
>       * qemu_init_cpu_list() reinitialized the child exclusive state, but=
 we
>       * also need to keep current_cpu consistent, so call end_exclusive()=
 for
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3944004568f..e64e5db1139 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6856,6 +6856,20 @@ static void *clone_func(void *arg)
>      return NULL;
>  }
>=20=20
> +void clone_fork_start(void)
> +{
> +    pthread_mutex_lock(&clone_lock);
> +}
> +
> +void clone_fork_end(bool child)
> +{
> +    if (child) {
> +        pthread_mutex_init(&clone_lock, NULL);
> +    } else {
> +        pthread_mutex_unlock(&clone_lock);
> +    }
> +}
> +

This looks like it should just be open-coded in the:

  if (flags & CLONE_VM) {

  }

leg of do_fork()?

Or maybe I'm missing the subtly of the race condition?


>  /* do_fork() Must return host values and target errnos (unlike most
>     do_*() functions). */
>  static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong news=
p,
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 067c02bb93e..24d35998f07 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -69,6 +69,8 @@ abi_long get_errno(abi_long ret);
>  const char *target_strerror(int err);
>  int get_osversion(void);
>  void init_qemu_uname_release(void);
> +void clone_fork_start(void);
> +void clone_fork_end(bool child);
>  void fork_start(void);
>  void fork_end(pid_t pid);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

