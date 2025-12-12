Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203DAD4921F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 12:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU2N7-00024H-93; Fri, 12 Dec 2025 07:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU2N4-00022j-5j
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:35:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU2N1-0003XJ-1Y
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:35:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso9714885e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765542937; x=1766147737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/c6P+j6ACvdRx3k4eJQm2Uj/1mHeIHA5LQ6Vm87JDE=;
 b=U3OZZ2rd6zkAcOaTpUuqjsSvocNB3zlp/nsFmq+QS3h+q3gCRa2T3oywxFMAzmgUXu
 YVT++RFOvBzMFxl4ul80ZscVFkgw0eWBaYp8wEOXRqTZmTCTkkvJRKS34LfiucXxvYu5
 9CCKPqrmYwInvptQ1I0Y985Xt3sf4sM93bnR9mq2ufvs9iBxCY8rMoryiogV840KzQ18
 id1kLd8SOXNUyQOl04ML0W0hLLg0lQSXAj/NNYgGVBJMwKys8svDceHFEwd3Pmnvnrc2
 +m4TzfV86UrtJycc1Lnnc3Elstg93/08oulhbuo88KHvlSLuZX6/asjj8iAYuWkZuqaO
 DWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765542937; x=1766147737;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e/c6P+j6ACvdRx3k4eJQm2Uj/1mHeIHA5LQ6Vm87JDE=;
 b=lihdUdjkRWvHWh9UhGeEdHVhbCigGO4nzFYSS3Y7INdAqcSedzFQ6Epwcli+eP+dLC
 M4K16B15cD0C/b0hl4l/tMK5bY+wYLxpEz6r+X8qRaeaEAtxbbeYDNisEKmAIX5WxUo1
 wnbZhRaL9gmiOf0SOzK2AG3Fp1k49qtBEAN9Wazlv1hWXLmd+ysA0pdGIaFHi/ZxA+yT
 1yRc+ukkeqyWkNUinY1+o81RccpMrfkoTGmK3yzrTXdQhhPEuBgZK7eMUKA8ogf04ltg
 my34mhufM8fri8g7xJbYcP7/BjdYMOA+AxmgeteCSyU4JYkYYTPU//x+YceyECD5RHSB
 V24w==
X-Gm-Message-State: AOJu0YyB1kKqDlphn+oz9/SboLG1qVAyrRZ5n8VrlrWOt2gnvLaTfTHR
 f6+7rb50zYFXlXH51443lAo4yJzyBEfaEk3veHwVrBadPYl8oclUE1KPynyz3tATRqo=
X-Gm-Gg: AY/fxX4pky6dKSoVk7mntSVb8I1z7dVTvziqw2yV2kfiVZggR/fyuH7aNXiGPg8dGFP
 1AAR82Z6aGqhtZawjIGbZmcQ4f0qFc3Svp2fdJ0fwRPmhUg1f+ejGettC8wLfoIS3UGV7VY9lrq
 t1sPih24qFjSgRdvbT7Cq4TJRvy7ja49IYEj1mMqXJrrr1Kjvt2OW9DMn2WU3H39Y9fxyxI4xsh
 D6OGu1Wh1N6gqUEujJHF+kdFkdhnyikSFVE97KwehwUpXpdpoSZ398mJuLTLVeL9r7/5td1Eqhc
 llD7euim3qpyZNfZz0ZaLXzVUYXTTQlXTaygWy5fTFiw7CWreHgbXj6GQWtgNfoysvIGS6ZBCVT
 dCFVXLCOsDI7/rSyiIrZegu40n5R46RXP1LgOj7Ukrs27zeqnivXunsHiAFNJgzByeCU2P7ZcJm
 E3u1YI0LZZaBBTrZH5X7fH3g==
X-Google-Smtp-Source: AGHT+IFSAFzevW/iZ51XHUeADrJX+6BbPis5oxlGylgoaQO2OxxXI1cXpMRlUUf16XjUoa7a8WybFg==
X-Received: by 2002:a05:600c:8b61:b0:477:6d96:b3ca with SMTP id
 5b1f17b1804b1-47a8f89b69fmr23295725e9.5.1765542936545; 
 Fri, 12 Dec 2025 04:35:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a70973sm12202354f8f.18.2025.12.12.04.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 04:35:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E546B5F82E;
 Fri, 12 Dec 2025 12:35:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH v2 1/2] plugins: Add PC diversion API function
In-Reply-To: <b461feb8-4ad5-481d-a497-dcb10b12ee79@epfl.ch> (Florian
 Hofhammer's message of "Mon, 6 Oct 2025 15:22:27 +0200")
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <b461feb8-4ad5-481d-a497-dcb10b12ee79@epfl.ch>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 12:35:34 +0000
Message-ID: <87cy4jubc9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> This patch adds a plugin API function that allows diverting the program
> counter during execution. A potential use case for this functionality is
> to skip over parts of the code, e.g., by hooking into a specific
> instruction and setting the PC to the next instruction in the callback.
>
> Redirecting control flow via cpu_loop_exit() works fine in callbacks
> that are triggered during code execution due to cpu_exec_setjmp() still
> being part of the call stack. If we want to use the new API in syscall
> callbacks, cpu_exec_setjmp() already returned and the longjmp()
> triggered by cpu_loop_exit() is undefined behavior. For this reason, we
> introduce a new return constant QEMU_ESETPC and do another setjmp()
> before executing syscall plugin callbacks and potentially the syscall
> itself.
>
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.h=
tml
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  include/qemu/qemu-plugin.h         | 15 +++++++++++++++
>  linux-user/aarch64/cpu_loop.c      |  2 +-
>  linux-user/alpha/cpu_loop.c        |  2 +-
>  linux-user/arm/cpu_loop.c          |  2 +-
>  linux-user/hexagon/cpu_loop.c      |  2 +-
>  linux-user/hppa/cpu_loop.c         |  4 ++++
>  linux-user/i386/cpu_loop.c         |  8 +++++---
>  linux-user/include/special-errno.h |  8 ++++++++
>  linux-user/loongarch64/cpu_loop.c  |  5 +++--
>  linux-user/m68k/cpu_loop.c         |  2 +-
>  linux-user/microblaze/cpu_loop.c   |  2 +-
>  linux-user/mips/cpu_loop.c         |  5 +++--
>  linux-user/openrisc/cpu_loop.c     |  2 +-
>  linux-user/ppc/cpu_loop.c          |  6 ++++--
>  linux-user/riscv/cpu_loop.c        |  2 +-
>  linux-user/s390x/cpu_loop.c        |  2 +-
>  linux-user/sh4/cpu_loop.c          |  2 +-
>  linux-user/sparc/cpu_loop.c        |  4 +++-
>  linux-user/syscall.c               |  8 ++++++++
>  linux-user/xtensa/cpu_loop.c       |  3 +++
>  plugins/api.c                      | 17 ++++++++++++++++-
>  plugins/core.c                     | 25 ++++++++++++++-----------
>  22 files changed, 96 insertions(+), 32 deletions(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c450106af1..be72ef9d70 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -261,11 +261,14 @@ typedef struct {
>   * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
>   * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>   * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
> + * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
> + *                             regs and updates the PC
>   */
>  enum qemu_plugin_cb_flags {
>      QEMU_PLUGIN_CB_NO_REGS,
>      QEMU_PLUGIN_CB_R_REGS,
>      QEMU_PLUGIN_CB_RW_REGS,
> +    QEMU_PLUGIN_CB_RW_REGS_PC,
>  };
>=20=20
>  enum qemu_plugin_mem_rw {
> @@ -943,6 +946,18 @@ QEMU_PLUGIN_API
>  int qemu_plugin_write_register(struct qemu_plugin_register *handle,
>                                GByteArray *buf);
>=20=20
> +/**
> + * qemu_plugin_set_pc() - set the program counter for the current vCPU
> + *
> + * @vaddr: the new virtual (guest) address for the program counter
> + *
> + * This function sets the program counter for the current vCPU to @vaddr=
 and
> + * resumes execution at that address. This function only returns in case=
 of
> + * errors.
> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_set_pc(uint64_t vaddr);
> +
>  /**
>   * qemu_plugin_read_memory_vaddr() - read from memory using a virtual ad=
dress
>   *
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index 50a4c99535..d220d18696 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -176,7 +176,7 @@ void cpu_loop(CPUARMState *env)
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
U_ESETPC) {
>                      break;
>                  }
>                  /* Syscall writes 0 to V0 to bypass error check, similar
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index cd89b7d6f5..ef77b56785 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -416,7 +416,7 @@ void cpu_loop(CPUARMState *env)
>                                       0, 0);
>                      if (ret =3D=3D -QEMU_ERESTARTSYS) {
>                          env->regs[15] -=3D env->thumb ? 2 : 4;
> -                    } else if (ret !=3D -QEMU_ESIGRETURN) {
> +                    } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QE=
MU_ESETPC) {
>                          env->regs[0] =3D ret;
>                      }
>                  }
> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
> index 1941f4c9c1..9adb3ec4c6 100644
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
> index 356cb48acc..5c8d2577ef 100644
> --- a/linux-user/hppa/cpu_loop.c
> +++ b/linux-user/hppa/cpu_loop.c
> @@ -17,6 +17,7 @@
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>=20=20
> +#include "qemu/compiler.h"
>  #include "qemu/osdep.h"
>  #include "qemu.h"
>  #include "user-internals.h"
> @@ -135,7 +136,10 @@ void cpu_loop(CPUHPPAState *env)
>                  env->iaoq_b =3D env->iaoq_f + 4;
>                  break;
>              case -QEMU_ERESTARTSYS:
> +                QEMU_FALLTHROUGH;
>              case -QEMU_ESIGRETURN:
> +                QEMU_FALLTHROUGH;
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
>=20=20
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
> diff --git a/linux-user/include/special-errno.h b/linux-user/include/spec=
ial-errno.h
> index 4120455baa..1db757241a 100644
> --- a/linux-user/include/special-errno.h
> +++ b/linux-user/include/special-errno.h
> @@ -29,4 +29,12 @@
>   */
>  #define QEMU_ESIGRETURN   513
>=20=20
> +/*
> + * This is returned after a plugin has used the qemu_plugin_set_pc API, =
to
> + * indicate that the plugin deliberately changed the PC and potentially
> + * modified the register values. The main loop should not touch the guest
> + * registers for this reason.
> + */
> +#define QEMU_ESETPC       514
> +
>  #endif /* SPECIAL_ERRNO_H */
> diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/c=
pu_loop.c
> index 26a5ce3a93..603fcc39c7 100644
> --- a/linux-user/loongarch64/cpu_loop.c
> +++ b/linux-user/loongarch64/cpu_loop.c
> @@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
>                  env->pc -=3D 4;
>                  break;
>              }
> -            if (ret =3D=3D -QEMU_ESIGRETURN) {
> +            if (ret =3D=3D -QEMU_ESIGRETURN || ret =3D=3D -QEMU_ESETPC) {
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
> +                } else if (ret !=3D -QEMU_ESIGRETURN && ret !=3D -QEMU_E=
SETPC) {
>                      env->dregs[0] =3D ret;
>                  }
>              }
> diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu=
_loop.c
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
> index 2365de1de1..af98138eb2 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -140,8 +140,9 @@ done_syscall:
>                  env->active_tc.PC -=3D 4;
>                  break;
>              }
> -            if (ret =3D=3D -QEMU_ESIGRETURN) {
> -                /* Returning from a successful sigreturn syscall.
> +            if (ret =3D=3D -QEMU_ESIGRETURN || ret =3D=3D -QEMU_ESETPC) {
> +                /* Returning from a successful sigreturn syscall or from
> +                   control flow diversion in a plugin callback.
>                     Avoid clobbering register state.  */
>                  break;
>              }
> diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loo=
p.c
> index 2167d880d5..e7e9929e6f 100644
> --- a/linux-user/openrisc/cpu_loop.c
> +++ b/linux-user/openrisc/cpu_loop.c
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
> index b0b0cb14b4..1f8aae14bb 100644
> --- a/linux-user/ppc/cpu_loop.c
> +++ b/linux-user/ppc/cpu_loop.c
> @@ -340,8 +340,10 @@ void cpu_loop(CPUPPCState *env)
>                  env->nip -=3D 4;
>                  break;
>              }
> -            if (ret =3D=3D (target_ulong)(-QEMU_ESIGRETURN)) {
> -                /* Returning from a successful sigreturn syscall.
> +            if (ret =3D=3D (target_ulong)(-QEMU_ESIGRETURN)
> +                    || ret =3D=3D (target_ulong)(-QEMU_ESETPC)) {
> +                /* Returning from a successful sigreturn syscall or from
> +                   control flow diversion in a plugin callback.
>                     Avoid corrupting register state.  */
>                  break;
>              }
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
>=20=20
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
> index 7391e2add8..f054316dce 100644
> --- a/linux-user/sparc/cpu_loop.c
> +++ b/linux-user/sparc/cpu_loop.c
> @@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
>                                env->regwptr[2], env->regwptr[3],
>                                env->regwptr[4], env->regwptr[5],
>                                0, 0);
> -            if (ret =3D=3D -QEMU_ERESTARTSYS || ret =3D=3D -QEMU_ESIGRET=
URN) {
> +            if (ret =3D=3D -QEMU_ERESTARTSYS
> +                    || ret =3D=3D -QEMU_ESIGRETURN
> +                    || ret =3D=3D -QEMU_ESETPC) {
>                  break;
>              }
>              if ((abi_ulong)ret >=3D (abi_ulong)(-515)) {
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d78b2029fa..f74b8ac596 100644
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
> @@ -584,6 +585,9 @@ const char *target_strerror(int err)
>      if (err =3D=3D QEMU_ESIGRETURN) {
>          return "Successful exit from sigreturn";
>      }
> +    if (err =3D=3D QEMU_ESETPC) {
> +        return "Successfully redirected control flow via qemu_plugin_set=
_pc";
> +    }
>=20=20
>      return strerror(target_to_host_errno(err));
>  }
> @@ -14077,6 +14081,10 @@ abi_long do_syscall(CPUArchState *cpu_env, int n=
um, abi_long arg1,
>          return -QEMU_ESIGRETURN;
>      }
>=20=20
> +    if (unlikely(sigsetjmp(cpu->jmp_env, 0) !=3D 0)) {
> +        return -QEMU_ESETPC;
> +    }
> +
>      record_syscall_start(cpu, num, arg1,
>                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>=20=20
> diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
> index a0ff10eff8..7680e243bb 100644
> --- a/linux-user/xtensa/cpu_loop.c
> +++ b/linux-user/xtensa/cpu_loop.c
> @@ -17,6 +17,7 @@
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>=20=20
> +#include "qemu/compiler.h"
>  #include "qemu/osdep.h"
>  #include "qemu.h"
>  #include "user-internals.h"
> @@ -185,6 +186,8 @@ void cpu_loop(CPUXtensaState *env)
>                      env->pc -=3D 3;
>                      break;
>=20=20
> +                case -QEMU_ESETPC:
> +                    QEMU_FALLTHROUGH;
>                  case -QEMU_ESIGRETURN:
>                      break;
>                  }
> diff --git a/plugins/api.c b/plugins/api.c
> index eac04cc1f6..fc19bdb40b 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -41,6 +41,7 @@
>  #include "qemu/log.h"
>  #include "system/memory.h"
>  #include "tcg/tcg.h"
> +#include "exec/cpu-common.h"
>  #include "exec/gdbstub.h"
>  #include "exec/target_page.h"
>  #include "exec/translation-block.h"
> @@ -450,13 +451,27 @@ int qemu_plugin_write_register(struct qemu_plugin_r=
egister *reg,
>  {
>      g_assert(current_cpu);
>=20=20
> -    if (buf->len =3D=3D 0 || qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN=
_CB_RW_REGS) {
> +    if (buf->len =3D=3D 0 || (
> +                qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REGS
> +                && qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REG=
S_PC)) {
>          return -1;
>      }

If we are exposing a specific qemu_plugin_set_pc we should probably
forbid setting it via write_register. Can we filter out the PC from the
register list?

>=20=20
>      return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(re=
g) - 1);
>  }
>=20=20
> +void qemu_plugin_set_pc(uint64_t vaddr)
> +{
> +    g_assert(current_cpu);
> +
> +    if (qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REGS_PC) {
> +        return;
> +    }

Given we aggressively assert that some functions are called in the
current_cpu context maybe we should do the same here? If the plugin
tries to set the PC and it doesn't work what is going to happen?

> +
> +    cpu_set_pc(current_cpu, vaddr);
> +    cpu_loop_exit(current_cpu);
> +}
> +
>  bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size=
_t len)
>  {
>      g_assert(current_cpu);
> diff --git a/plugins/core.c b/plugins/core.c
> index ead09fd2f1..b514293117 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -369,15 +369,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>                                     enum qemu_plugin_cb_flags flags,
>                                     void *udata)
>  {
> -    static TCGHelperInfo info[3] =3D {
> +    static TCGHelperInfo info[4] =3D {
>          [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
>          [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
>          [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
> +        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
>          /*
>           * Match qemu_plugin_vcpu_udata_cb_t:
>           *   void (*)(uint32_t, void *)
>           */
> -        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
> +        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
>                                dh_typemask(i32, 1) |
>                                dh_typemask(ptr, 2))
>      };
> @@ -399,15 +400,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **ar=
r,
>                                          uint64_t imm,
>                                          void *udata)
>  {
> -    static TCGHelperInfo info[3] =3D {
> +    static TCGHelperInfo info[4] =3D {
>          [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
>          [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
>          [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
> +        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
>          /*
>           * Match qemu_plugin_vcpu_udata_cb_t:
>           *   void (*)(uint32_t, void *)
>           */
> -        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
> +        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
>                                dh_typemask(i32, 1) |
>                                dh_typemask(ptr, 2))
>      };
> @@ -438,15 +440,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>          !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
>          !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
>=20=20
> -    static TCGHelperInfo info[3] =3D {
> +    static TCGHelperInfo info[4] =3D {
>          [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
>          [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
>          [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
> +        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
>          /*
>           * Match qemu_plugin_vcpu_mem_cb_t:
>           *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
>           */
> -        [0 ... 2].typemask =3D
> +        [0 ... 3].typemask =3D
>              (dh_typemask(void, 0) |
>               dh_typemask(i32, 1) |
>               (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32=
_t)
> @@ -508,7 +511,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, =
uint64_t a1, uint64_t a2,
>      QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>          qemu_plugin_vcpu_syscall_cb_t func =3D cb->f.vcpu_syscall;
>=20=20
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a=
7, a8);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -532,7 +535,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int6=
4_t num, int64_t ret)
>      QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>          qemu_plugin_vcpu_syscall_ret_cb_t func =3D cb->f.vcpu_syscall_re=
t;
>=20=20
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          func(cb->ctx->id, cpu->cpu_index, num, ret);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -542,7 +545,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>  {
>      /* idle and resume cb may be called before init, ignore in this case=
 */
>      if (cpu->cpu_index < plugin.num_vcpus) {
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -551,7 +554,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>  void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>  {
>      if (cpu->cpu_index < plugin.num_vcpus) {
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -788,6 +791,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_=
flags(int flags)
>      } else if (flags & TCG_CALL_NO_WG) {
>          return QEMU_PLUGIN_CB_R_REGS;
>      } else {
> -        return QEMU_PLUGIN_CB_RW_REGS;
> +        return QEMU_PLUGIN_CB_RW_REGS_PC;
>      }
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

