Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6CCC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8L7-0004xL-TD; Wed, 26 Aug 2026 03:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wz8L5-0004wz-Hu
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 03:46:27 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wz8L3-0001Um-0E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 03:46:27 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a156627e22so3260726a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787730383; x=1788335183; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yS6RNYeR52lTX1bKIrcf2CEDk6bxJWgYTJRm3M3n6Os=;
 b=KZNEzgkeqXdxhsYLgTnykVa7GXqfAxE/52hqUfD+b0f9iTSK+HDkkAAuadtlgr5XrA
 nfeTUtB4zpVZg3jP7yTPLkE9f7uQByruN+xvDtl9+5BCx5u6jQk62G2pA/pSAXH8+tzK
 T0dP5S4tB+sufq7fbOXLgb8Fs1LjwUwRqhYEDzX9PGcvU9lwap/794cce+zyP8OD2/V/
 8jVJGyOd/FwpEOU6AtYapprUBU8/tmuutsP8E6bwf5GiDMG1bbUrP4a8TOefpHFD/sAx
 XjNYxQ41+3vjBuPif5gDZYx9X1x2ivsNmZ/T+jSM4nyTErYgdSwZ6LCyA0jF7M96vpby
 uHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787730383; x=1788335183;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yS6RNYeR52lTX1bKIrcf2CEDk6bxJWgYTJRm3M3n6Os=;
 b=ijkEeGY8uVw1HIB4Ne70hjAiKsWxtAmbNCn0pDjIGEkBH4VbwgF9KIErFys5rAVcdD
 AV4VzL7Axgyd8S4tvkc6CSKA0jb9LgJv8WgnNye06hKpgEruZIng4yGYXWJBJcZPTryc
 afqxkugiiD9ZyfMqlHZQtU+oadlQULJ6FQ28sVqzOCK6JjhAl0u5NhyVgF6xz3bsX67C
 IC1t++Onc39m9+l2vo+UZpgrXlS0ZKbcSRK9Q1Te0uDcZ/KX8e3Z4XVhBWhJsViLLXSY
 NSiTkHUnrnhxmtD0d+POfJ5aKu98C83sggAV98mjFmTbtN3LfNUkYT618lkvCNkJmyVA
 yUdQ==
X-Gm-Message-State: AFuF++k6nnTCEU1/9dqyYRIDjQCLqJ0fsq2pyE/T5YjnLRB1nlRXfrJK
 i556Y//tBl/VMhRxfnALCa7J5RUiXvlGNjlU8+fv5GcGPzzrBvmMEbdBI2Rov2+B8No=
X-Gm-Gg: AR+sD12R3Y0sw/yjPkpAO2zSsKS5W+T1R1pWG4Nb1Dty4u+mfjgKQfwaex3TbcOyrx1
 FI5B1AqUv6WxWNKacgbiREvG/yPhKzMeSqbHSNOT1GxOdudMEcriHUEJvi82QoIT/oFYtZV89zX
 hSxtwpKt/eofze3ZdRUsMpGmbXXxZZEh8V4qBaBo6cac5e9+Jw8FL7tAnGJ0SnE8bDUGwdqgVh6
 rhXLZqooxF/JcSiiTiWbOVXrCFwPqeqqm4IytusWbxEEv/o07pejX7u0WvKveKfryMVWoCONCyc
 TUQzUPpKytOv/zST8Do7rq9lZLHCW24D+0uBd4NgneiyweOH3w9NNN546oIIo5VE+0ujijtVZwY
 d25pgLEi7XKhTRkI2hCaegvYvkPCKXwhv7eW+vTp7B0BplsIBjHIF8m35mTGcIhV+liuPdOV1rQ
 fdvld8xXJn3/yzgpIwwU0nD5k5GM4oWW9m8kTRG2SVTPTN3xvNxqa/6PVLEEE6
X-Received: by 2002:a05:6402:a68f:b0:6a0:50d8:142d with SMTP id
 4fb4d7f45d1cf-6a5c3a70ee9mr9889464a12.0.1787730382457; 
 Wed, 26 Aug 2026 00:46:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83ba0sm3136362a12.14.2026.08.26.00.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:46:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D48715F877;
 Wed, 26 Aug 2026 08:46:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  philmd@oss.qualcomm.com,  zhao1.liu@intel.com
Subject: Re: [PATCH v3 1/7] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
In-Reply-To: <20260822190818.1829249-2-mattst88@gmail.com> (Matt Turner's
 message of "Sat, 22 Aug 2026 15:08:12 -0400")
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-2-mattst88@gmail.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 08:46:19 +0100
Message-ID: <8733w1qq7o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Matt Turner <mattst88@gmail.com> writes:

> curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
> and from the cpu_exec() loop. It recomputes the same value every time:
>
>     uint32_t cflags =3D cpu->tcg_cflags;
>     if (unlikely(cpu_single_stepping(cpu))) { ... }
>     else if (qatomic_read(&one_insn_per_tb)) { ... }
>     else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }
>
> That is three loads and three branches on the hottest path in the
> interpreter, for state that changes only when gdb enables single-step,
> when one-insn-per-tb is toggled, or when the log mask changes.
>
> None of the three has to be sampled at dispatch time. Fold each into
> CPUState::tcg_cflags where it changes and curr_cflags() becomes a single
> load of a field that TB lookup has to read anyway.
>
> The derived bits -- CF_COUNT_MASK, CF_NO_GOTO_TB, CF_NO_GOTO_PTR and
> CF_SINGLE_STEP -- are never set by tcg_cflags_set(), so tcg_update_cflags=
()
> can recompute them in place without disturbing the rest, and conversely
> tcg_cflags_set() ORs in its bits without disturbing them.
>
> There are three places to call it:
>
>   - tcg_exec_realizefn(), so that a CPU created after the command line has
>     been parsed starts out with the right value. This covers user-only,
>     where tcg_cpu_init_cflags() is not reached. linux-user's cpu_copy()
>     copies tcg_cflags wholesale, so a cloned thread inherits it.
>
>   - cpu_single_step(), which changes one CPU and runs either on that CPU's
>     thread or with it stopped.
>
>   - tcg_set_one_insn_per_tb() and qemu_set_log_internal(), which change
>     every CPU. Both can be reached from the monitor while the vCPUs are
>     running -- 'one-insn-per-tb on' and 'log nochain' -- so the update is
>     queued with async_safe_run_on_cpu() and each CPU writes its own cflags
>     with the others halted.
>
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, in a
> build configured with --enable-lto:
>
>     before: 1,646,994,254,249 instructions
>     after:  1,562,204,796,597 instructions   -5.15%
>
> That workload issues 8.4 billion dispatches, so the per-call saving is
> small but the aggregate is not. The emulated compiler produces
> byte-identical output before and after.
>
> Wall clock does not move: 133.19s to 132.58s, a 0.46% difference against a
> run-to-run spread larger than that. The removed work is a few predictable
> loads and branches that the host executes largely in parallel with the
> surrounding dispatch, so this patch is worth taking for the instruction
> count and for what it enables, not for a time saving that can be measured
> on its own.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  accel/tcg/cpu-exec-common.c | 33 ++++++++++++++++++++++++++++++---
>  accel/tcg/cpu-exec.c        |  3 +++
>  accel/tcg/internal-common.h | 11 +++++++++--
>  accel/tcg/tcg-all.c         |  1 +
>  cpu-target.c                |  3 +++
>  include/system/tcg.h        | 12 ++++++++++++
>  stubs/meson.build           |  1 +
>  stubs/tcg-cflags.c          | 16 ++++++++++++++++
>  util/log.c                  |  4 ++++
>  9 files changed, 79 insertions(+), 5 deletions(-)
>  create mode 100644 stubs/tcg-cflags.c
>
> diff --git ./accel/tcg/cpu-exec-common.c ./accel/tcg/cpu-exec-common.c
> index 44e84344f3..dd2be475e2 100644
> --- ./accel/tcg/cpu-exec-common.c
> +++ ./accel/tcg/cpu-exec-common.c
> @@ -36,9 +36,16 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags)
>      cpu->tcg_cflags |=3D flags;
>  }
>=20=20
> -uint32_t curr_cflags(CPUState *cpu)
> +/*
> + * The bits of CPUState::tcg_cflags that tcg_cflags_set() never sets, be=
cause
> + * they are derived from gdb single-step, one-insn-per-tb and -d nochain.
> + */
> +#define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
> +                     CF_SINGLE_STEP)
> +
> +void tcg_update_cflags(CPUState *cpu)
>  {
> -    uint32_t cflags =3D cpu->tcg_cflags;
> +    uint32_t cflags =3D cpu->tcg_cflags & ~CF_DERIVED;
>=20=20
>      /*
>       * Record gdb single-step.  We should be exiting the TB by raising
> @@ -55,7 +62,27 @@ uint32_t curr_cflags(CPUState *cpu)
>          cflags |=3D CF_NO_GOTO_TB;
>      }
>=20=20
> -    return cflags;
> +    cpu->tcg_cflags =3D cflags;
> +}
> +
> +static void tcg_update_cflags_work(CPUState *cpu, run_on_cpu_data data)
> +{
> +    tcg_update_cflags(cpu);
> +}
> +
> +void tcg_update_all_cflags(void)
> +{
> +    CPUState *cpu;
> +
> +    /*
> +     * one-insn-per-tb and -d nochain can both be changed from the monit=
or
> +     * while the vCPUs are running.  Have each CPU update its own cflags
> +     * with the others halted, so that no dispatch can read a value that
> +     * another thread is in the middle of writing.
> +     */
> +    CPU_FOREACH(cpu) {
> +        async_safe_run_on_cpu(cpu, tcg_update_cflags_work,
> RUN_ON_CPU_NULL);

I don't think this is wrong but are we really seeing cross-vCPU updates
of cpu->cflags? I suspect async_run_on_cpu would be enough to trigger an
update from a non-vCPU thread to the vCPU.

You could even pass the sub-set of flags down in the user data and maybe
avoid having to use global atomics for those flags.

> +    }
>  }
>=20=20
>  /* exit the current TB, but without causing any exception to be raised */
> diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
> index 257211235d..148e0f583e 100644
> --- ./accel/tcg/cpu-exec.c
> +++ ./accel/tcg/cpu-exec.c
> @@ -1068,6 +1068,9 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>          tcg_target_initialized =3D true;
>      }
>=20=20
> +    /* Pick up one-insn-per-tb and -d nochain from the command line. */
> +    tcg_update_cflags(cpu);
> +
>      cpu->tb_jmp_cache =3D g_new0(CPUJumpCache, 1);
>      tlb_init(cpu);
>  #ifndef CONFIG_USER_ONLY
> diff --git ./accel/tcg/internal-common.h ./accel/tcg/internal-common.h
> index 9e7be2d78d..853d1b51ee 100644
> --- ./accel/tcg/internal-common.h
> +++ ./accel/tcg/internal-common.h
> @@ -69,8 +69,15 @@ void tlb_destroy(CPUState *cpu);
>  bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
>  void tcg_exec_unrealizefn(CPUState *cpu);
>=20=20
> -/* current cflags for hashing/comparison */
> -uint32_t curr_cflags(CPUState *cpu);
> +/*
> + * Current cflags for hashing/comparison.  Everything that feeds into the
> + * value is folded into CPUState::tcg_cflags when it changes, by
> + * tcg_update_cflags(), so that TB dispatch only has to load it.
> + */
> +static inline uint32_t curr_cflags(CPUState *cpu)
> +{
> +    return cpu->tcg_cflags;
> +}
>=20=20
>  void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
>=20=20
> diff --git ./accel/tcg/tcg-all.c ./accel/tcg/tcg-all.c
> index 7186c10cf0..c9874a286a 100644
> --- ./accel/tcg/tcg-all.c
> +++ ./accel/tcg/tcg-all.c
> @@ -254,6 +254,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool=
 value, Error **errp)
>      s->one_insn_per_tb =3D value;
>      /* Set the global also: this changes the behaviour */
>      qatomic_set(&one_insn_per_tb, value);
> +    tcg_update_all_cflags();
>  }
>=20=20
>  static void tcg_accel_class_init(ObjectClass *oc, const void *data)
> diff --git ./cpu-target.c ./cpu-target.c
> index 4783845c9b..50be591acf 100644
> --- ./cpu-target.c
> +++ ./cpu-target.c
> @@ -24,6 +24,7 @@
>  #include "exec/replay-core.h"
>  #include "exec/log.h"
>  #include "hw/core/cpu.h"
> +#include "system/tcg.h"
>  #include "trace/trace-root.h"
>=20=20
>  /* enable or disable single step mode. EXCP_DEBUG is returned by the
> @@ -35,6 +36,8 @@ void cpu_single_step(CPUState *cpu, unsigned flags)
>                                            cpu->singlestep_flags, flags);
>          cpu->singlestep_flags =3D flags;
>=20=20
> +        tcg_update_cflags(cpu);
> +
>  #if !defined(CONFIG_USER_ONLY)
>          const AccelOpsClass *ops =3D cpus_get_accel();
>          if (ops->update_guest_debug) {
> diff --git ./include/system/tcg.h ./include/system/tcg.h
> index 7622dcea30..2c2dbc753b 100644
> --- ./include/system/tcg.h
> +++ ./include/system/tcg.h
> @@ -17,6 +17,18 @@ extern bool tcg_allowed;
>  #define tcg_enabled() 0
>  #endif
>=20=20
> +/*
> + * Recompute the parts of CPUState::tcg_cflags that TB dispatch consumes=
 but
> + * tcg_cflags_set() does not provide: gdb single-step, one-insn-per-tb a=
nd
> + * the CPU_LOG_TB_NOCHAIN log flag.  Call whenever one of those changes.
> + *
> + * tcg_update_cflags() updates one CPU and must be called from that CPU's
> + * thread, or with it stopped.  tcg_update_all_cflags() updates every CPU
> + * and is safe to call from the monitor while the vCPUs run.
> + */
> +void tcg_update_cflags(CPUState *cpu);
> +void tcg_update_all_cflags(void);
> +
>  /**
>   * qemu_tcg_mttcg_enabled:
>   * Check whether we are running MultiThread TCG or not.
> diff --git ./stubs/meson.build ./stubs/meson.build
> index 3b2f2680b1..0025e79226 100644
> --- ./stubs/meson.build
> +++ ./stubs/meson.build
> @@ -3,6 +3,7 @@
>  # below, so that it is clear who needs the stubbed functionality.
>=20=20
>  stub_ss.add(files('cpu-get-clock.c'))
> +stub_ss.add(files('tcg-cflags.c'))
>  stub_ss.add(files('fdset.c'))
>  stub_ss.add(files('iothread-lock.c'))
>  stub_ss.add(files('is-daemonized.c'))
> diff --git ./stubs/tcg-cflags.c ./stubs/tcg-cflags.c
> new file mode 100644
> index 0000000000..cb278e94aa
> --- /dev/null
> +++ ./stubs/tcg-cflags.c
> @@ -0,0 +1,16 @@
> +/*
> + * Stub for tcg_update_all_cflags(), for binaries that link util/log.c
> + * or cpu-target.c but not TCG.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "system/tcg.h"
> +
> +void tcg_update_cflags(CPUState *cpu)
> +{
> +}
> +
> +void tcg_update_all_cflags(void)
> +{
> +}
> diff --git ./util/log.c ./util/log.c
> index 7cffbc1bf8..3fa46a67fa 100644
> --- ./util/log.c
> +++ ./util/log.c
> @@ -27,6 +27,7 @@
>  #include "qemu/thread.h"
>  #include "qemu/lockable.h"
>  #include "qemu/rcu.h"
> +#include "system/tcg.h"
>  #ifdef CONFIG_LINUX
>  #include <sys/syscall.h>
>  #endif
> @@ -301,6 +302,9 @@ static bool qemu_set_log_internal(const char *filenam=
e, bool changed_name,
>  #endif
>      qemu_loglevel =3D log_flags;
>=20=20
> +    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cflags. */
> +    tcg_update_all_cflags();
> +
>      daemonized =3D is_daemonized();
>      need_to_open_file =3D false;
>      if (!daemonized) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

