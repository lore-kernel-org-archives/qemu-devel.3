Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39924EA4E20
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 15:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx505-0007o7-Hy; Mon, 02 Mar 2026 10:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vx4zw-0007mD-71
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:15:53 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vx4zs-0006Gg-1q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:15:51 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so2564069a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 07:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772464545; cv=none;
 d=google.com; s=arc-20240605;
 b=KBm2zU+Vk6QW6Kaolsyby1uJNcRn4u/3SHDwBhdU2JQ7Auqh14z0oox8gYyxq0ZxJL
 MBer0B0KlyRrsfAbF+wr/p/UhGJcI0gL5sKtw8WDZid88FItG7ClZ7jsNUNj0p7QP8iH
 xtIGxGprCcigIEEOoxI5Q6Mz7LaA211c74YuSgvqXRwfBPYGTdz+kikjkRaOZI1RYdzp
 kMNns+YY0zaW5oTRwg2qDNHZ3aUql6SLQUo+ON/NSV/tNX571enim88n81UUoNgzT6Sm
 q0ljI7ZCvWu4oxyXXMCv5zh38lxPMLfJv6zx3J3bJ4hJLpwKwPHviZarNEbp/njbS7Gc
 OLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d8pGQ1k/wZjGEqvA7/4ALrNDF8MqwKM2+MNht4izAIA=;
 fh=8yEV2Rsm9PenCW1soDFu9ltaJMZ/eTQjdjfiG7wdwLo=;
 b=I8vMzOd0ONtaBIauEK9K+riZGDO+8XCmfkQqC0Lv1pzzoVZBpkdPtxBYLTgZ47BxJ0
 umifwtK6jH4vQgj8fmdN/wNCx8+7riaoVZDsPyR1K0051VtHkpQ4z+h9XAQTcVbGTjFs
 8P4EogSwBnf3TRi2v1cV4CQBKqxm++l0i92rby8TE9Tf8VG8WeZprUsxYaLAoKM2GrQ+
 VEDHbtMwHkgzFZ7KvzmXXe0GJ7fRD64+B1u7QVtkN5q5+dlEyJIfD31ENDdNcEJa1F0F
 c2GrLhwCVo31acriBY6QzqGrskMEzJWqFREguOsevDdR7E0kYihz3BCmcwsNNd5+DdkU
 Ww4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772464545; x=1773069345;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d8pGQ1k/wZjGEqvA7/4ALrNDF8MqwKM2+MNht4izAIA=;
 b=ygBLC3stjzxG7FiH3tHScD0GAXt72CMlgZIiFBrOnnteo0E6+/8ECRAHYiwo33oIG0
 gZql9PV4eCwMNMIulwFvenBx2FtrC1ez85qj9x7bfKeu2S+yUNFBDXIhakyVTg6rpOFM
 Bwatcg7ajdJbgAgWPXt9REEeg3WQSz9+fO3N0cEbgB55t4LbA5rRA0DDOa8YZeLqClFO
 TDoQNlZionlM8UeFWCaPGDdo5oO0JYL4qTZugEcNPWLFO4ZN5Gby+JD+jdGsuF7DFE9J
 v3Sckr4dMxFG+//ZshoLtM2N4jWHp3xR22PKU7TP6tMQ2AG5Pt1b9bS0A9RqgofoFMiB
 K3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772464545; x=1773069345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8pGQ1k/wZjGEqvA7/4ALrNDF8MqwKM2+MNht4izAIA=;
 b=o11n6L/TntTuGV+5hgdDLzWFAwUF9v6y4FsHqsjMezJV6Y/DFw0gfKA5Cb+ntJYFwz
 zHhFB3F1MmPlbclTBGOVoAeNNsTMX8TtXS4Hkkee2xbsJSbEqui/wa8lb98BhLhfLIqt
 0WG+d4tkQJEyu1XK4pGzCGkjQuDZBqSY8SP3ayrSUGu8wedSGVqwB9Y+LCTZoThkD+Ry
 JX5Ohxc/O2f2ifR4/8TJGhkGeQracJlMma4z1Xb9s0j5Hk6C1SWhVYjdg4FV+ibcmgUk
 dhI8qCjRz0PZD8jkLcaKUH3AwGPQ/4aEV7x68IqXA+MmWl71Xgv1D5+VlbfINAKJHEIm
 efSA==
X-Gm-Message-State: AOJu0YzOiCyLTbgvYhUKjGYocNQ0vyw+H85z4+QSVpsSY8FuesYez17J
 5AuCyrLtpSAPbPJrsd+i2uLZUUGMACTFYJ6obBEhexSYxzn4Fs5ECpMs+xpp79H2sxk7c+WDtZc
 yrGhyUUIsiZOOA1nEiLCdE5/LrK1O97SxUsnnZWHKIA==
X-Gm-Gg: ATEYQzx+DQw7MgewEnVY3IzhXRwAIulbkSrTdtYSLjGODXpDaHcy+bqfBT5GTOcF+Xk
 wFWSvm3t19Nw/HDGQFRrC+De62r8wYn32IoxmmJkvsmmqnNyWcn+rX743/vo8Wc3MoQJwzNLjPz
 iQUTcB5DyRXR+luiCQswzMcRMbouzGy1bwr9no+Xm9TcKgXLCa0hH7I9h1Di5ArBdemYbNKia8i
 c2WVhSJSBBlUdmo3Qs66w5fUxI0ntf41Or2C4Srvx2QmbpFzgsOHkB/kC6DFAwQx+X/sQ0IXPeV
 wfm9spk=
X-Received: by 2002:a17:90b:3cc7:b0:359:8d2e:6f79 with SMTP id
 98e67ed59e1d1-3598d2e724amr3201448a91.14.1772464545152; Mon, 02 Mar 2026
 07:15:45 -0800 (PST)
MIME-Version: 1.0
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
 <b280d4ad-522d-4d28-b203-b87f114d0d81@epfl.ch>
In-Reply-To: <b280d4ad-522d-4d28-b203-b87f114d0d81@epfl.ch>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 2 Mar 2026 08:15:33 -0700
X-Gm-Features: AaiRm517LTY3OqNVwFmvO1LAT9zcV1NssCfyA7ngvotEb-rHoD64A3nOMhu4gB0
Message-ID: <CANCZdfqML5j5TLOQn2vCNAgxF9iWrL=92x_+oL4_NOUUJqt+-Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] linux-user: make syscall emulation interruptible
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, berrange@redhat.com
Content-Type: multipart/alternative; boundary="000000000000974da1064c0c0f25"
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000974da1064c0c0f25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 7:03=E2=80=AFAM Florian Hofhammer <florian.hofhammer=
@epfl.ch>
wrote:

> The syscall emulation code previously wasn't interruptible via
> cpu_loop_exit(), as this construct relies on a longjmp target that is not
> live anymore in the syscall handling code. Consequently, longjmp() would
> operate on a (potentially overwritten) stale jump buffer. This patch adds
> an additional
> setjmp and the necessary handling around it to make longjmp() (and by
> proxy cpu_loop_exit() safe to call even within a syscall context.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>

So bsd-user would need something similar, I'd think. But it still uses the
older-style
TARGET_EJUSTRETURN. With half of the archs still out of tree, I'm not
entirely
sure the best way to approach this.

The code does what you say, which is good, but there may be some subtle
reason to do something else.

Reviewed-by: Warner Losh <imp@bsdimp.com>


>  linux-user/aarch64/cpu_loop.c      |  2 +-
>  linux-user/alpha/cpu_loop.c        |  2 +-
>  linux-user/arm/cpu_loop.c          |  2 +-
>  linux-user/hexagon/cpu_loop.c      |  2 +-
>  linux-user/hppa/cpu_loop.c         |  1 +
>  linux-user/i386/cpu_loop.c         |  8 +++++---
>  linux-user/include/special-errno.h |  8 ++++++++
>  linux-user/loongarch64/cpu_loop.c  |  5 +++--
>  linux-user/m68k/cpu_loop.c         |  2 +-
>  linux-user/microblaze/cpu_loop.c   |  2 +-
>  linux-user/mips/cpu_loop.c         |  9 ++++++---
>  linux-user/or1k/cpu_loop.c         |  2 +
>  linux-user/ppc/cpu_loop.c          | 10 +++++++---
>  linux-user/riscv/cpu_loop.c        |  2 +-
>  linux-user/s390x/cpu_loop.c        |  2 +-
>  linux-user/sh4/cpu_loop.c          |  2 +-
>  linux-user/sparc/cpu_loop.c        |  4 +++-
>  linux-user/syscall.c               | 16 ++++++++++++++++
>  linux-user/xtensa/cpu_loop.c       |  1 +
>  19 files changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.=
c
> index 7f66a879ea..e7f643d69d 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)
>                               0, 0);
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->pc -=3D 4;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->xregs[0] =3D ret;
>              }
>              break;
> diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
> index f93597c400..bef196b1f5 100644
> --- a/linux-user/alpha/cpu_loop.c
> +++ b/linux-user/alpha/cpu_loop.c
> @@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
>                      env->pc -=3D 4;
>                      break;
>                  }
> -                if (sysret =3D=3D -QEMU_ESIGRETURN) {
> +                if (sysret =3D=3D -QEMU_ESIGRETURN || sysret =3D=3D -QEM=
U_ESETPC)
> {
>                      break;
>                  }
>                  /* Syscall writes 0 to V0 to bypass error check, similar
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 40aefc4c1d..19874f4c72 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)
>                                       0, 0);
>                      if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                          env->regs[15] -=3D env->thumb ? 2 : 4;
> -                    } else if (ret !=3D -QEMU_ESIGRETURN) {
> +                    } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D
> -QEMU_ESETPC) {
>                          env->regs[0] =3D ret;
>                      }
>                  }
> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.=
c
> index 5711055aff..9464246e9e 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
>                               0, 0);
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->gpr[HEX_REG_PC] -=3D 4;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->gpr[0] =3D ret;
>              }
>              break;
> diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
> index 972e85c487..4b4b663052 100644
> --- a/linux-user/hppa/cpu_loop.c
> +++ b/linux-user/hppa/cpu_loop.c
> @@ -124,6 +124,7 @@ void cpu_loop(CPUHPPAState *env)
>                  break;
>              case -QEMU_ERESTARTSYS:
>              case -QEMU_ESIGRETURN:
> +            case -QEMU_ESETPC:
>                  break;
>              }
>              break;
> diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
> index f3f58576af..fe922fceb5 100644
> --- a/linux-user/i386/cpu_loop.c
> +++ b/linux-user/i386/cpu_loop.c
> @@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
>      if (ret =3D=3D -TARGET_EFAULT) {
>          goto sigsegv;
>      }
> -    env->regs[R_EAX] =3D ret;
> +    if (ret !=3D -QEMU_ESETPC) {
> +        env->regs[R_EAX] =3D ret;
> +    }
>
>      /* Emulate a ret instruction to leave the vsyscall page.  */
>      env->eip =3D caller;
> @@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
>                               0, 0);
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->eip -=3D 2;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->regs[R_EAX] =3D ret;
>              }
>              break;
> @@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
>                               0, 0);
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->eip -=3D 2;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->regs[R_EAX] =3D ret;
>              }
>              break;
> diff --git a/linux-user/include/special-errno.h
> b/linux-user/include/special-errno.h
> index 4120455baa..1db757241a 100644
> --- a/linux-user/include/special-errno.h
> +++ b/linux-user/include/special-errno.h
> @@ -29,4 +29,12 @@
>   */
>  #define QEMU_ESIGRETURN   513
>
> +/*
> + * This is returned after a plugin has used the qemu_plugin_set_pc API, =
to
> + * indicate that the plugin deliberately changed the PC and potentially
> + * modified the register values. The main loop should not touch the gues=
t
> + * registers for this reason.
> + */
> +#define QEMU_ESETPC       514
> +
>  #endif /* SPECIAL_ERRNO_H */
> diff --git a/linux-user/loongarch64/cpu_loop.c
> b/linux-user/loongarch64/cpu_loop.c
> index 26a5ce3a93..603fcc39c7 100644
> --- a/linux-user/loongarch64/cpu_loop.c
> +++ b/linux-user/loongarch64/cpu_loop.c
> @@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
>                  env->pc -=3D 4;
>                  break;
>              }
> -            if (ret =3D=3D -QEMU_ESIGRETURN) {
> +            if (ret =3D=3D -QEMU_ESIGRETURN || ret =3D=3D -QEMU_ESETPC) =
{
>                  /*
> -                 * Returning from a successful sigreturn syscall.
> +                 * Returning from a successful sigreturn syscall or from
> +                 * control flow diversion in a plugin callback.
>                   * Avoid clobbering register state.
>                   */
>                  break;
> diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
> index 2c9f628241..b98ca8ff7b 100644
> --- a/linux-user/m68k/cpu_loop.c
> +++ b/linux-user/m68k/cpu_loop.c
> @@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
>                                   0, 0);
>                  if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                      env->pc -=3D 2;
> -                } else if (ret !=3D -QEMU_ESIGRETURN) {
> +                } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D
> -QEMU_ESETPC) {
>                      env->dregs[0] =3D ret;
>                  }
>              }
> diff --git a/linux-user/microblaze/cpu_loop.c
> b/linux-user/microblaze/cpu_loop.c
> index 78506ab23d..06d92c0b90 100644
> --- a/linux-user/microblaze/cpu_loop.c
> +++ b/linux-user/microblaze/cpu_loop.c
> @@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  /* Wind back to before the syscall. */
>                  env->pc -=3D 4;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->regs[3] =3D ret;
>              }
>              /* All syscall exits result in guest r14 being equal to the
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 2365de1de1..fa264b27ec 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -140,9 +140,12 @@ done_syscall:
>                  env->active_tc.PC -=3D 4;
>                  break;
>              }
> -            if (ret =3D=3D -QEMU_ESIGRETURN) {
> -                /* Returning from a successful sigreturn syscall.
> -                   Avoid clobbering register state.  */
> +            if (ret =3D=3D -QEMU_ESIGRETURN || ret =3D=3D -QEMU_ESETPC) =
{
> +                /*
> +                 * Returning from a successful sigreturn syscall or from
> +                 * control flow diversion in a plugin callback.
> +                 * Avoid clobbering register state.
> +                 */
>                  break;
>              }
>              if ((abi_ulong)ret >=3D (abi_ulong)-1133) {
> diff --git a/linux-user/or1k/cpu_loop.c b/linux-user/or1k/cpu_loop.c
> index 2167d880d5..e7e9929e6f 100644
> --- a/linux-user/or1k/cpu_loop.c
> +++ b/linux-user/or1k/cpu_loop.c
> @@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
>                               cpu_get_gpr(env, 8), 0, 0);
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->pc -=3D 4;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  cpu_set_gpr(env, 11, ret);
>              }
>              break;
> diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
> index b0b0cb14b4..1f9ee20bd0 100644
> --- a/linux-user/ppc/cpu_loop.c
> +++ b/linux-user/ppc/cpu_loop.c
> @@ -340,9 +340,13 @@ void cpu_loop(CPUPPCState *env)
>                  env->nip -=3D 4;
>                  break;
>              }
> -            if (ret =3D=3D (target_ulong)(-QEMU_ESIGRETURN)) {
> -                /* Returning from a successful sigreturn syscall.
> -                   Avoid corrupting register state.  */
> +            if (ret =3D=3D (target_ulong)(-QEMU_ESIGRETURN) ||
> +                ret =3D=3D (target_ulong)(-QEMU_ESETPC)) {
> +                /*
> +                 * Returning from a successful sigreturn syscall or from
> +                 * control flow diversion in a plugin callback.
> +                 * Avoid corrupting register state.
> +                 */
>                  break;
>              }
>              if (ret > (target_ulong)(-515)) {
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index ce542540c2..eecc8d1517 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
>              }
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->pc -=3D 4;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->gpr[xA0] =3D ret;
>              }
>              if (cs->singlestep_enabled) {
> diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
> index 4929b32e1f..67d2a803fb 100644
> --- a/linux-user/s390x/cpu_loop.c
> +++ b/linux-user/s390x/cpu_loop.c
> @@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
>                               env->regs[6], env->regs[7], 0, 0);
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->psw.addr -=3D env->int_svc_ilen;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->regs[2] =3D ret;
>              }
>
> diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
> index 0c9d7e9c46..ee2958d0d9 100644
> --- a/linux-user/sh4/cpu_loop.c
> +++ b/linux-user/sh4/cpu_loop.c
> @@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
>                               0, 0);
>              if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                  env->pc -=3D 2;
> -            } else if (ret !=3D -QEMU_ESIGRETURN) {
> +            } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_ESETP=
C) {
>                  env->gregs[0] =3D ret;
>              }
>              break;
> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
> index 7391e2add8..ab633eeae3 100644
> --- a/linux-user/sparc/cpu_loop.c
> +++ b/linux-user/sparc/cpu_loop.c
> @@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
>                                env->regwptr[2], env->regwptr[3],
>                                env->regwptr[4], env->regwptr[5],
>                                0, 0);
> -            if (ret =3D=3D -QEMU_ERESTARTSYS || ret =3D=3D -QEMU_ESIGRET=
URN) {
> +            if (ret =3D=3D -QEMU_ERESTARTSYS ||
> +                ret =3D=3D -QEMU_ESIGRETURN ||
> +                ret =3D=3D -QEMU_ESETPC) {
>                  break;
>              }
>              if ((abi_ulong)ret >=3D (abi_ulong)(-515)) {
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d466d0e32f..99e1ed97d9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -43,6 +43,7 @@
>  #include <linux/capability.h>
>  #include <sched.h>
>  #include <sys/timex.h>
> +#include <setjmp.h>
>  #include <sys/socket.h>
>  #include <linux/sockios.h>
>  #include <sys/un.h>
> @@ -600,6 +601,9 @@ const char *target_strerror(int err)
>      if (err =3D=3D QEMU_ESIGRETURN) {
>          return "Successful exit from sigreturn";
>      }
> +    if (err =3D=3D QEMU_ESETPC) {
> +        return "Successfully redirected control flow";
> +    }
>
>      return strerror(target_to_host_errno(err));
>  }
> @@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int
> num, abi_long arg1,
>          return -QEMU_ESIGRETURN;
>      }
>
> +    /*
> +     * Set up a longjmp target here so that we can call cpu_loop_exit to
> +     * redirect control flow back to the main loop even from within
> +     * syscall-related plugin callbacks.
> +     * For other types of callbacks or longjmp call sites, the longjmp
> target
> +     * is set up in the cpu loop itself but in syscalls the target is no=
t
> live
> +     * anymore.
> +     */
> +    if (unlikely(sigsetjmp(cpu->jmp_env, 0) !=3D 0)) {
> +        return -QEMU_ESETPC;
> +    }
> +
>      record_syscall_start(cpu, num, arg1,
>                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>
> diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
> index a0ff10eff8..d2b4ccdfad 100644
> --- a/linux-user/xtensa/cpu_loop.c
> +++ b/linux-user/xtensa/cpu_loop.c
> @@ -186,6 +186,7 @@ void cpu_loop(CPUXtensaState *env)
>                      break;
>
>                  case -QEMU_ESIGRETURN:
> +                case -QEMU_ESETPC:
>                      break;
>                  }
>                  break;
> --
> 2.53.0
>

--000000000000974da1064c0c0f25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, =
2026 at 7:03=E2=80=AFAM Florian Hofhammer &lt;<a href=3D"mailto:florian.hof=
hammer@epfl.ch">florian.hofhammer@epfl.ch</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">The syscall emulation code previou=
sly wasn&#39;t interruptible via<br>
cpu_loop_exit(), as this construct relies on a longjmp target that is not<b=
r>
live anymore in the syscall handling code. Consequently, longjmp() would<br=
>
operate on a (potentially overwritten) stale jump buffer. This patch adds a=
n additional<br>
setjmp and the necessary handling around it to make longjmp() (and by<br>
proxy cpu_loop_exit() safe to call even within a syscall context.<br>
<br>
Signed-off-by: Florian Hofhammer &lt;<a href=3D"mailto:florian.hofhammer@ep=
fl.ch" target=3D"_blank">florian.hofhammer@epfl.ch</a>&gt;<br>
---<br></blockquote><div><br></div><div>So bsd-user would need something si=
milar, I&#39;d think. But it still uses the older-style</div><div>TARGET_EJ=
USTRETURN. With half of the archs still out of tree, I&#39;m not entirely</=
div><div>sure the best way to approach this.</div><div><br></div><div>The c=
ode does what you say, which is good, but there may be some subtle</div><di=
v>reason to do something else.</div><div><br></div><div>Reviewed-by: Warner=
 Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0linux-user/aarch64/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/alpha/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<b=
r>
=C2=A0linux-user/arm/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2=
 +-<br>
=C2=A0linux-user/hexagon/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0linux-user/hppa/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
 +<br>
=C2=A0linux-user/i386/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8=
 +++++---<br>
=C2=A0linux-user/include/special-errno.h |=C2=A0 8 ++++++++<br>
=C2=A0linux-user/loongarch64/cpu_loop.c=C2=A0 |=C2=A0 5 +++--<br>
=C2=A0linux-user/m68k/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
 +-<br>
=C2=A0linux-user/microblaze/cpu_loop.c=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0linux-user/mips/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9=
 ++++++---<br>
=C2=A0linux-user/or1k/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
 +<br>
=C2=A0linux-user/ppc/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++=
+++---<br>
=C2=A0linux-user/riscv/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<b=
r>
=C2=A0linux-user/s390x/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<b=
r>
=C2=A0linux-user/sh4/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2=
 +-<br>
=C2=A0linux-user/sparc/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-=
<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 16 ++++++++++++++++<br>
=C2=A0linux-user/xtensa/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br=
>
=C2=A019 files changed, 60 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c<=
br>
index 7f66a879ea..e7f643d69d 100644<br>
--- a/linux-user/aarch64/cpu_loop.c<br>
+++ b/linux-user/aarch64/cpu_loop.c<br>
@@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc -=
=3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;xregs=
[0] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c<br>
index f93597c400..bef196b1f5 100644<br>
--- a/linux-user/alpha/cpu_loop.c<br>
+++ b/linux-user/alpha/cpu_loop.c<br>
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0env-&gt;pc -=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sysret =3D=3D =
-QEMU_ESIGRETURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sysret =3D=3D =
-QEMU_ESIGRETURN || sysret =3D=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Syscall wr=
ites 0 to V0 to bypass error check, similar<br>
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c<br>
index 40aefc4c1d..19874f4c72 100644<br>
--- a/linux-user/arm/cpu_loop.c<br>
+++ b/linux-user/arm/cpu_loop.c<br>
@@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (ret =3D=3D -QEMU_ERESTARTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0env-&gt;regs[15] -=3D env-&gt;thumb ? 2 : 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } el=
se if (ret !=3D -QEMU_ESIGRETURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } el=
se if (ret !=3D -QEMU_ESIGRETURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0env-&gt;regs[0] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c<=
br>
index 5711055aff..9464246e9e 100644<br>
--- a/linux-user/hexagon/cpu_loop.c<br>
+++ b/linux-user/hexagon/cpu_loop.c<br>
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;gpr[H=
EX_REG_PC] -=3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;gpr[0=
] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c<br>
index 972e85c487..4b4b663052 100644<br>
--- a/linux-user/hppa/cpu_loop.c<br>
+++ b/linux-user/hppa/cpu_loop.c<br>
@@ -124,6 +124,7 @@ void cpu_loop(CPUHPPAState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case -QEMU_ERESTARTSYS:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case -QEMU_ESIGRETURN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case -QEMU_ESETPC:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c<br>
index f3f58576af..fe922fceb5 100644<br>
--- a/linux-user/i386/cpu_loop.c<br>
+++ b/linux-user/i386/cpu_loop.c<br>
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)<br>
=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -TARGET_EFAULT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto sigsegv;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 env-&gt;regs[R_EAX] =3D ret;<br>
+=C2=A0 =C2=A0 if (ret !=3D -QEMU_ESETPC) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;regs[R_EAX] =3D ret;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Emulate a ret instruction to leave the vsyscall page=
.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;eip =3D caller;<br>
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;eip -=
=3D 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[=
R_EAX] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;eip -=
=3D 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[=
R_EAX] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/linux-user/include/special-errno.h b/linux-user/include/specia=
l-errno.h<br>
index 4120455baa..1db757241a 100644<br>
--- a/linux-user/include/special-errno.h<br>
+++ b/linux-user/include/special-errno.h<br>
@@ -29,4 +29,12 @@<br>
=C2=A0 */<br>
=C2=A0#define QEMU_ESIGRETURN=C2=A0 =C2=A0513<br>
<br>
+/*<br>
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to=
<br>
+ * indicate that the plugin deliberately changed the PC and potentially<br=
>
+ * modified the register values. The main loop should not touch the guest<=
br>
+ * registers for this reason.<br>
+ */<br>
+#define QEMU_ESETPC=C2=A0 =C2=A0 =C2=A0 =C2=A0514<br>
+<br>
=C2=A0#endif /* SPECIAL_ERRNO_H */<br>
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu=
_loop.c<br>
index 26a5ce3a93..603fcc39c7 100644<br>
--- a/linux-user/loongarch64/cpu_loop.c<br>
+++ b/linux-user/loongarch64/cpu_loop.c<br>
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc -=
=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -QEMU_ESIGRETURN)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -QEMU_ESIGRETURN =
|| ret =3D=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Returning =
from a successful sigreturn syscall.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Returning =
from a successful sigreturn syscall or from<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* control fl=
ow diversion in a plugin callback.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Avoid clob=
bering register state.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c<br>
index 2c9f628241..b98ca8ff7b 100644<br>
--- a/linux-user/m68k/cpu_loop.c<br>
+++ b/linux-user/m68k/cpu_loop.c<br>
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=
=3D -QEMU_ERESTARTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0env-&gt;pc -=3D 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=
=3D -QEMU_ESIGRETURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=
=3D -QEMU_ESIGRETURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0env-&gt;dregs[0] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_l=
oop.c<br>
index 78506ab23d..06d92c0b90 100644<br>
--- a/linux-user/microblaze/cpu_loop.c<br>
+++ b/linux-user/microblaze/cpu_loop.c<br>
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Wind back =
to before the syscall. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc -=
=3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[=
3] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* All syscall exits result=
 in guest r14 being equal to the<br>
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c<br>
index 2365de1de1..fa264b27ec 100644<br>
--- a/linux-user/mips/cpu_loop.c<br>
+++ b/linux-user/mips/cpu_loop.c<br>
@@ -140,9 +140,12 @@ done_syscall:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;activ=
e_tc.PC -=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -QEMU_ESIGRETURN)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Returning from =
a successful sigreturn syscall.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Avoid=
 clobbering register state.=C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -QEMU_ESIGRETURN =
|| ret =3D=3D -QEMU_ESETPC) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Returning =
from a successful sigreturn syscall or from<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* control fl=
ow diversion in a plugin callback.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Avoid clob=
bering register state.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((abi_ulong)ret &gt;=3D =
(abi_ulong)-1133) {<br>
diff --git a/linux-user/or1k/cpu_loop.c b/linux-user/or1k/cpu_loop.c<br>
index 2167d880d5..e7e9929e6f 100644<br>
--- a/linux-user/or1k/cpu_loop.c<br>
+++ b/linux-user/or1k/cpu_loop.c<br>
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_get_gpr(env, 8), 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc -=
=3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_set_gpr(e=
nv, 11, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c<br>
index b0b0cb14b4..1f9ee20bd0 100644<br>
--- a/linux-user/ppc/cpu_loop.c<br>
+++ b/linux-user/ppc/cpu_loop.c<br>
@@ -340,9 +340,13 @@ void cpu_loop(CPUPPCState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;nip -=
=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D (target_ulong)(-Q=
EMU_ESIGRETURN)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Returning from =
a successful sigreturn syscall.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Avoid=
 corrupting register state.=C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D (target_ulong)(-Q=
EMU_ESIGRETURN) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D=3D (target=
_ulong)(-QEMU_ESETPC)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Returning =
from a successful sigreturn syscall or from<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* control fl=
ow diversion in a plugin callback.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Avoid corr=
upting register state.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &gt; (target_ulong)=
(-515)) {<br>
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c<br>
index ce542540c2..eecc8d1517 100644<br>
--- a/linux-user/riscv/cpu_loop.c<br>
+++ b/linux-user/riscv/cpu_loop.c<br>
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc -=
=3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;gpr[x=
A0] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cs-&gt;singlestep_enabl=
ed) {<br>
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c<br>
index 4929b32e1f..67d2a803fb 100644<br>
--- a/linux-user/s390x/cpu_loop.c<br>
+++ b/linux-user/s390x/cpu_loop.c<br>
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;regs[6], env-&gt;regs[7], 0, 0);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;psw.a=
ddr -=3D env-&gt;int_svc_ilen;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regs[=
2] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c<br>
index 0c9d7e9c46..ee2958d0d9 100644<br>
--- a/linux-user/sh4/cpu_loop.c<br>
+++ b/linux-user/sh4/cpu_loop.c<br>
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -QEMU_ERESTA=
RTSYS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc -=
=3D 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -QEMU_ESIGRE=
TURN &amp;&amp; ret !=3D -QEMU_ESETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;gregs=
[0] =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c<br>
index 7391e2add8..ab633eeae3 100644<br>
--- a/linux-user/sparc/cpu_loop.c<br>
+++ b/linux-user/sparc/cpu_loop.c<br>
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regwptr[2], env-&gt;regwptr[3=
],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;regwptr[4], env-&gt;regwptr[5=
],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -QEMU_ERESTARTSYS=
 || ret =3D=3D -QEMU_ESIGRETURN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -QEMU_ERESTARTSYS=
 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D=3D -QEMU_E=
SIGRETURN ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D=3D -QEMU_E=
SETPC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((abi_ulong)ret &gt;=3D =
(abi_ulong)(-515)) {<br>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index d466d0e32f..99e1ed97d9 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -43,6 +43,7 @@<br>
=C2=A0#include &lt;linux/capability.h&gt;<br>
=C2=A0#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;sys/timex.h&gt;<br>
+#include &lt;setjmp.h&gt;<br>
=C2=A0#include &lt;sys/socket.h&gt;<br>
=C2=A0#include &lt;linux/sockios.h&gt;<br>
=C2=A0#include &lt;sys/un.h&gt;<br>
@@ -600,6 +601,9 @@ const char *target_strerror(int err)<br>
=C2=A0 =C2=A0 =C2=A0if (err =3D=3D QEMU_ESIGRETURN) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;Successful exit from sigretu=
rn&quot;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (err =3D=3D QEMU_ESETPC) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;Successfully redirected control f=
low&quot;;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return strerror(target_to_host_errno(err));<br>
=C2=A0}<br>
@@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -QEMU_ESIGRETURN;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Set up a longjmp target here so that we can call cpu=
_loop_exit to<br>
+=C2=A0 =C2=A0 =C2=A0* redirect control flow back to the main loop even fro=
m within<br>
+=C2=A0 =C2=A0 =C2=A0* syscall-related plugin callbacks.<br>
+=C2=A0 =C2=A0 =C2=A0* For other types of callbacks or longjmp call sites, =
the longjmp target<br>
+=C2=A0 =C2=A0 =C2=A0* is set up in the cpu loop itself but in syscalls the=
 target is not live<br>
+=C2=A0 =C2=A0 =C2=A0* anymore.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (unlikely(sigsetjmp(cpu-&gt;jmp_env, 0) !=3D 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -QEMU_ESETPC;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0record_syscall_start(cpu, num, arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 arg2, arg3, arg4, arg5, arg6, arg7, arg8);<br>
<br>
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c<br=
>
index a0ff10eff8..d2b4ccdfad 100644<br>
--- a/linux-user/xtensa/cpu_loop.c<br>
+++ b/linux-user/xtensa/cpu_loop.c<br>
@@ -186,6 +186,7 @@ void cpu_loop(CPUXtensaState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case -QEMU_ES=
IGRETURN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case -QEMU_ESETPC:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.53.0<br>
</blockquote></div></div>

--000000000000974da1064c0c0f25--

