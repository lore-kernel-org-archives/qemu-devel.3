Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B3C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 20:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x826E-0005UY-LP; Sat, 19 Sep 2026 16:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x826C-0005To-Hi
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:55:52 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x8269-0004aY-Tt
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:55:52 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b5e4f13d7aso2506477e87.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 13:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789851347; cv=none;
 d=google.com; s=arc-20260327;
 b=ZP4s6C9/hzYCf2rT/n2B0L7eIkZhSkamgCkz6f+bD3zgmoL6h2eK+8HjwsqmkBHg/C
 jSV5IlaztMj6MyXQQM0XzdLAJ2xXIz5gLT884P9ino43xKVTtKMYwMaIDByHwdnfzndM
 7tWxjbAcomGswY1qUHD8xPyyFX4dB+plTIKSe1q6TLbZMEaGIcyrb/RuAKQWPV3UUSya
 Fid1WBfRgRd/RD+mAe9WRAxfrwuYGa8/yYmQ0wg8Ai+QdFOsAwEVw1IrhBNNQAa+KTmn
 rzAQ+8m5BoRcUdZmSCmNAaAZmxTOxOd/oA/V56lAmC2xW9fH8WehbIQAXVUaDvTjuwZH
 cjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7I+nd7E1E2bfpkKFYDykhhCd91bXVvp4gwc2NRwSpnk=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=GqL3dToC+9/+4s8CC5ZPs5hNxikORDArBTOQ85mbD3YMbI2eK95WA7Zbb9LuCrdf0l
 TeASOKB7bu2DIgbfhXMSmJd3h2UMfL/jRA6xzeu6klMvPqFXN1UBGiu6a1dk7jDRC6G0
 eHHkZnayoBqiiDJXuFq2uHj2xMMNGJrL8kJ5guYrUJhFsrCDAZuZlJ7AgPQQ5pkAV/jZ
 DNwQhnp7jb1rBMYW7BTwwgUYmyv8CmSXNgfTelYB3/qDt/etsa6SFfapaKqa1GhpaPHO
 pqr4kV5zuETjBmctZ0DgfeHFIiNZXwN/V8i14dIMwuA5yXmyYY3j3diGaBO5ivFH69Bw
 OcGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789851347; x=1790456147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7I+nd7E1E2bfpkKFYDykhhCd91bXVvp4gwc2NRwSpnk=;
 b=ExZxDqybtQpno3w6JScEqVPNXoG121xpWHJG+YmPZYtPey7lpqbiQxVdsD0OJWUHc1
 o12t2CRnBCpHQZEqyRB+A4Jojmakuinu21e/u0SlYYXYQlBh5sc8JUgzqfaCQSI0Trql
 LGQu9RGkZWX7Ny1MAkdHpG0syq/fY8nz4RSnPt1mrMamhshlB73bCS/+XmAKqEfRPNV/
 yMFLJoZlUF4+4rbvZcu+GVOJKWgMzWjfWsAki3iZWMVU84rh5jP1/x2vSbVGt91iIyQM
 faVJnKXc1jREc4YPnTj0R4+830XoKBuzSPv10JoEsYXXAsLWvPxsoOf0fJkBvqz8caig
 Lzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789851347; x=1790456147;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7I+nd7E1E2bfpkKFYDykhhCd91bXVvp4gwc2NRwSpnk=;
 b=bWBuD5sFvSRjzTwAWrbeMTt/zCXufjgyYcpCivIqN+Xt6QGxrd5+EMkT4LbWuyvzXK
 4GYfShy3hCtgVE2vsfqKO+b39e/hmKQkuuFYlmGA8bBwFAozjh0elHPou6FEyrb6xtyW
 LU0Bt8Af/OV0CHq5WMJO+pYsZPWppbwAbmzRH3y9lGdlkA14ZKbNrfmGjsDmsZBT7pHC
 rMQfCOLdZeAMlypaAZ1+TPeeOVAMfo3vmAcJZi18Euy92RB1ObzoK/v1aceWwhZgxlBt
 s87wt/6WeX7F8JHpVpMxaVyEyzJD7sYq4iYFpQt+2l5s0fO9i0DAASPJjEsGY2f4EVTK
 XNBA==
X-Gm-Message-State: AFuF++lgxGGRZOEA8bqIPvsat5qyyWcmCE3WBQDxAAMNmbFsqNcxkqCu
 07/92+c1GxueVg0iKa1YC/dpfb3JaUQG//GepQs+t0Qm5W2Kg3utWJe1wcL0hLqQFeoX88Prj8B
 rp/SPIqONjGOTfDEec6z7IY7Fx7s8+L4=
X-Gm-Gg: AYBFou3ISxXR/6hdav+j2YZtaAyEFPTEPk7SXKPBayIWDuXzcSnh7agYUeLridexGkX
 wHeRiDw+LAGsn+LpzMD93T4izQgRugu4/fsnzqfuRZRRfS2HSTuxri/gcdDzkIKqxOc349j4BvM
 Pkvqo2uikiUBY5of1b5/E32Ecy44pYIemAf7lZR56o3NUk8WbWNHssDE29FjsQAnQhOcMTuorw9
 nNUjJMU5OCisbrKkDfneLGMzGUPBKXEGn551I38vTs9zlbSmn3S/0s2r+cZiUwFHyT3/q9tobJe
 V8Of9tpNnEKUgniyTeniYEMZFJXi5Bd/NHW0pGbkIQSaUT5XsAq28LXHD7lnDNJTpJzILMmRey4
 gulxtYs/mW8qTiw==
X-Received: by 2002:a05:6512:1394:b0:5b6:1a7c:2d with SMTP id
 2adb3069b0e04-5b8c18579e3mr1909592e87.48.1789851346939; Sat, 19 Sep 2026
 13:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
 <20260917082618.1076988-3-richard.henderson@linaro.org>
In-Reply-To: <20260917082618.1076988-3-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 16:55:32 -0400
X-Gm-Features: AcwNN1XCJ0mzH0hqrBEVXFAuYo37M9yrZA9uUOKQttlbnQq6zP0zQ-BihACKKyw
Message-ID: <CAEdQ38FJpgWVavxYRzEge1f1PxmsGGMbbAnezrA7Ow62uXOoZQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 17, 2026 at 4:26=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Matt Turner <mattst88@gmail.com>

Thanks for reworking this; routing the system-mode update through
update_guest_debug is much nicer than the version I posted.

Three optional nits inline. None of those need a respin on my account.

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
>   - tcg_exec_realizefn(), so that a CPU created after the command line ha=
s
>     been parsed starts out with the right value. This covers user-only,
>     where tcg_cpu_init_cflags() is not reached. linux-user's cpu_copy()
>     copies tcg_cflags wholesale, so a cloned thread inherits it.
>
>   - cpu_single_step(), which changes one CPU.  gdb is the only caller tha=
t
>     matters; in system mode it runs with the vCPUs stopped, and in user m=
ode
>     gdb_continue_partial() can reach a thread that is still running, beca=
use
>     gdb_handlesig() stops only the thread that trapped. That is exactly t=
he
>     plain cross-thread store to another CPU's CPUState that
>     cpu->singlestep_flags already was, read back by that CPU through
>     cpu_single_stepping() in curr_cflags(). This patch changes which fiel=
d
>     carries it, not who writes it or how.
>
>   - hmp_one_insn_per_tb() and hmp_log(), which change every CPU while the
>     vCPUs are running, so the update is queued with async_run_on_cpu() an=
d
>     each CPU writes its own cflags from its own thread. The command line
>     spellings of those two settings need nothing: they are parsed before
>     any CPU is realized, so tcg_exec_realizefn() picks them up.
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
> Wall clock does not move: 133.19s to 132.58s, a 0.46% difference against =
a
> run-to-run spread larger than that. The removed work is a few predictable
> loads and branches that the host executes largely in parallel with the
> surrounding dispatch, so this patch is worth taking for the instruction
> count and for what it enables, not for a time saving that can be measured
> on its own.
>
> v4: Update the cflags from the HMP handlers for 'log' and 'one-insn-per-t=
b'
>     rather than from qemu_set_log_internal() and the accelerator property
>     setter. Those are the paths that reach a running vCPU, and the monito=
r
>     is the only thing that does. Suggested by Richard Henderson.
>
> v4: Queue the per-CPU update with async_run_on_cpu() rather than
>     async_safe_run_on_cpu(). Halting the other vCPUs buys nothing: the
>     queued work already runs on the owning CPU's own thread. Suggested by
>     Alex Bennee, who also asked whether there are cross-vCPU updates of
>     tcg_cflags at all. With this change the monitor path has none: the
>     only remaining writer from another thread is cpu_single_step(), above=
,
>     which is neither new nor made worse here.
>
> v4: Move the stub to accel/stubs/, which is where the other accelerator
>     stubs live.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260901034808.3524945-2-mattst88@gmail.com>
> ---
>  accel/tcg/internal-common.h | 11 +++++++++--
>  include/system/tcg.h        | 12 ++++++++++++
>  accel/tcg/cpu-exec-common.c | 33 ++++++++++++++++++++++++++++++---
>  accel/tcg/cpu-exec.c        |  3 +++
>  accel/tcg/tcg-accel-ops.c   |  2 ++
>  cpu-target.c                |  5 ++++-
>  monitor/hmp-cmds.c          |  7 +++++++
>  system/runstate-hmp-cmds.c  | 18 ++++++++++++------
>  8 files changed, 79 insertions(+), 12 deletions(-)
>
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> index 9e7be2d78df..853d1b51eeb 100644
> --- a/accel/tcg/internal-common.h
> +++ b/accel/tcg/internal-common.h
> @@ -69,8 +69,15 @@ void tlb_destroy(CPUState *cpu);
>  bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
>  void tcg_exec_unrealizefn(CPUState *cpu);
>
> -/* current cflags for hashing/comparison */
> -uint32_t curr_cflags(CPUState *cpu);
> +/*
> + * Current cflags for hashing/comparison.  Everything that feeds into th=
e
> + * value is folded into CPUState::tcg_cflags when it changes, by
> + * tcg_update_cflags(), so that TB dispatch only has to load it.
> + */
> +static inline uint32_t curr_cflags(CPUState *cpu)
> +{
> +    return cpu->tcg_cflags;
> +}
>
>  void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
>
> diff --git a/include/system/tcg.h b/include/system/tcg.h
> index 7622dcea302..2c2dbc753b3 100644
> --- a/include/system/tcg.h
> +++ b/include/system/tcg.h
> @@ -17,6 +17,18 @@ extern bool tcg_allowed;
>  #define tcg_enabled() 0
>  #endif
>
> +/*
> + * Recompute the parts of CPUState::tcg_cflags that TB dispatch consumes=
 but
> + * tcg_cflags_set() does not provide: gdb single-step, one-insn-per-tb a=
nd
> + * the CPU_LOG_TB_NOCHAIN log flag.  Call whenever one of those changes.
> + *
> + * tcg_update_cflags() updates one CPU and must be called from that CPU'=
s
> + * thread, or with it stopped.  tcg_update_all_cflags() updates every CP=
U
> + * and is safe to call from the monitor while the vCPUs run.
> + */
> +void tcg_update_cflags(CPUState *cpu);
> +void tcg_update_all_cflags(void);
> +
>  /**
>   * qemu_tcg_mttcg_enabled:
>   * Check whether we are running MultiThread TCG or not.
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 44e84344f3b..9f3517f36b6 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -36,9 +36,16 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags)
>      cpu->tcg_cflags |=3D flags;
>  }
>
> -uint32_t curr_cflags(CPUState *cpu)
> +/*
> + * The bits of CPUState::tcg_cflags that tcg_cflags_set() never sets, be=
cause
> + * they are derived from gdb single-step, one-insn-per-tb and -d nochain=
.
> + */

tcg_cflags_set() could assert(!(flags & CF_DERIVED)).

> +#define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
> +                     CF_SINGLE_STEP)
> +
> +void tcg_update_cflags(CPUState *cpu)
>  {
> -    uint32_t cflags =3D cpu->tcg_cflags;
> +    uint32_t cflags =3D cpu->tcg_cflags & ~CF_DERIVED;
>
>      /*
>       * Record gdb single-step.  We should be exiting the TB by raising
> @@ -55,7 +62,27 @@ uint32_t curr_cflags(CPUState *cpu)
>          cflags |=3D CF_NO_GOTO_TB;
>      }
>
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

Could assert(bql_locked()) here, since CPU_FOREACH plus
async_run_on_cpu() requires it.

> +    /*
> +     * one-insn-per-tb and -d nochain can both be changed from the monit=
or
> +     * while the vCPUs are running.  Queue the update onto each CPU rath=
er
> +     * than writing tcg_cflags from here, so that the field is only ever
> +     * written by the CPU that owns it.
> +     */
> +    CPU_FOREACH(cpu) {
> +        async_run_on_cpu(cpu, tcg_update_cflags_work, RUN_ON_CPU_NULL);
> +    }
>  }
>
>  /* exit the current TB, but without causing any exception to be raised *=
/
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 46b723cb734..5226cfb7650 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1071,6 +1071,9 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp=
)
>          tcg_target_initialized =3D true;
>      }
>
> +    /* Pick up one-insn-per-tb and -d nochain from the command line. */
> +    tcg_update_cflags(cpu);
> +
>      cpu->tb_jmp_cache =3D g_new0(CPUJumpCache, 1);
>      tlb_init(cpu);
>  #ifndef CONFIG_USER_ONLY
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 9c3d2214162..2e50df20c18 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -48,6 +48,7 @@
>  #include "tcg-accel-ops-mttcg.h"
>  #include "tcg-accel-ops-rr.h"
>  #include "tcg-accel-ops-icount.h"
> +#include "internal-common.h"

tcg_update_cflags() is declared in "system/tcg.h", which this file
already includes. The new include looks unnecessary.

>
>  /* common functionality among all TCG variants */
>
> @@ -222,6 +223,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
>      ops->insert_gdbstub_breakpoint =3D tcg_insert_gdbstub_breakpoint;
>      ops->remove_gdbstub_breakpoint =3D tcg_remove_gdbstub_breakpoint;
>      ops->remove_all_gdbstub_breakpoints =3D tcg_remove_all_gdbstub_break=
points;
> +    ops->update_guest_debug =3D tcg_update_cflags;
>  }
>
>  static void tcg_accel_ops_class_init(ObjectClass *oc, const void *data)
> diff --git a/cpu-target.c b/cpu-target.c
> index 4783845c9bf..9bd1605e831 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -24,6 +24,7 @@
>  #include "exec/replay-core.h"
>  #include "exec/log.h"
>  #include "hw/core/cpu.h"
> +#include "system/tcg.h"
>  #include "trace/trace-root.h"
>
>  /* enable or disable single step mode. EXCP_DEBUG is returned by the
> @@ -35,7 +36,9 @@ void cpu_single_step(CPUState *cpu, unsigned flags)
>                                            cpu->singlestep_flags, flags);
>          cpu->singlestep_flags =3D flags;
>
> -#if !defined(CONFIG_USER_ONLY)
> +#ifdef CONFIG_USER_ONLY
> +        tcg_update_cflags(cpu);
> +#else
>          const AccelOpsClass *ops =3D cpus_get_accel();
>          if (ops->update_guest_debug) {
>              ops->update_guest_debug(cpu);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 91701ddf331..9b1b94f8ea9 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -40,6 +40,7 @@
>  #include "system/hw_accel.h"
>  #include "system/memory.h"
>  #include "system/system.h"
> +#include "system/tcg.h"
>  #include "disas/disas.h"
>
>  /* Please update hmp-commands.hx when adding or changing commands */
> @@ -340,6 +341,12 @@ void hmp_log(MonitorHMP *hmp, const QDict *qdict)
>
>      if (!qemu_set_log(mask, &err)) {
>          error_report_err(err);
> +        return;
> +    }
> +
> +    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cflags. */
> +    if (tcg_enabled()) {
> +        tcg_update_all_cflags();
>      }
>  }
>
> diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
> index ad70b53f8ab..eb34d14d062 100644
> --- a/system/runstate-hmp-cmds.c
> +++ b/system/runstate-hmp-cmds.c
> @@ -22,6 +22,7 @@
>  #include "qapi/qapi-commands-run-state.h"
>  #include "qobject/qdict.h"
>  #include "qemu/accel.h"
> +#include "system/tcg.h"
>
>  void hmp_info_status(MonitorHMP *hmp, const QDict *qdict)
>  {
> @@ -43,16 +44,17 @@ void hmp_info_status(MonitorHMP *hmp, const QDict *qd=
ict)
>
>  void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    const char *option =3D qdict_get_try_str(qdict, "option");
> -    AccelState *accel =3D current_accel();
> +    const char *option;
> +    AccelState *accel;
>      bool newval;
>
> -    if (!object_property_find(OBJECT(accel), "one-insn-per-tb")) {
> -        monitor_hmp_printf(hmp,
> -                           "This accelerator does not support setting on=
e-insn-per-tb\n");
> +    if (!tcg_enabled()) {
> +        monitor_hmp_printf(hmp, "This accelerator does not support "
> +                           "setting one-insn-per-tb\n");
>          return;
>      }
>
> +    option =3D qdict_get_try_str(qdict, "option");
>      if (!option || !strcmp(option, "on")) {
>          newval =3D true;
>      } else if (!strcmp(option, "off")) {
> @@ -61,9 +63,13 @@ void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict =
*qdict)
>          monitor_hmp_printf(hmp, "unexpected option %s\n", option);
>          return;
>      }
> -    /* If the property exists then setting it can never fail */
> +
> +    accel =3D current_accel();
>      object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
>                               newval, &error_abort);
> +
> +    /* one-insn-per-tb feeds into the per-CPU cflags. */
> +    tcg_update_all_cflags();
>  }
>
>  void hmp_watchdog_action(MonitorHMP *hmp, const QDict *qdict)
> --
> 2.53.0
>

