Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E1FC982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 01:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x86L6-0005yK-UP; Sat, 19 Sep 2026 21:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x86L4-0005wB-HF
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 21:27:30 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x86L1-0006hj-4a
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 21:27:30 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8b402f4e3so2018707e87.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 18:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867645; cv=none;
 d=google.com; s=arc-20260327;
 b=oUrhI5Y7qKUF2Q1ZkzIybsHoMFpNME59cQ6hn4MSGgEYiunEM4llN/nzvZMECzFr7b
 ctI116Vq1OQFhIqEquqdl2T3N3fyL7+VCBNKdUo4jU+m+MvosQJFdtyrBMX/CgsRMT9p
 BtYWxql7dLT8sYgErHRX5blJHKnavyzkUkBc4aO9vruEBEUxzazDgsppXe1TXDbrMXXH
 Y0XMa+giiCtYSOTYD4TyxENZjVh2qmbQeZYGAsFXB3Hp26fosoko5oJ0555oQDMhuNGz
 rXoBSf+hYdl2Hg8uATxkjSSEr2IfcbxD5FTjpk1yKPLrPHjwvS5lBKR//wysFQvzYPCb
 McBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kgtjdvlp0rG0SdG0lByu9abgDS18kpFmRNdWEtnW6e8=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=WZ/43j35m5U45NpPDAHehZqipS9deTB8SYqxZc/gtJEzGQNAqW8xSMjE6O9Lt+ddcX
 kKelX0x9scwc8KWrzXMYyd2Hes4aM9Vx1ckaZUaRrBHwvvoCaJL6XjytDvHBxVjgVDvR
 xPmzFkCPbt6zctY9CfZ1IbTtBNSCHab6ArTlbkxoT3uNZvP5Gkz9fue2PDv8sZo7+Zth
 tO2cBEiymnkrhqDi+q6ZEVPjeoEhf/9m8GJJal36EnZ6QTHd3HY2g1qdBTxvMHh0mKBj
 3fLN8/8DmDIla6pPvA8EMo6SsW5uk8tBv4cOC5lF/AxC/DU4kStJqQhGDtO4zV1+ge7H
 4D/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789867645; x=1790472445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kgtjdvlp0rG0SdG0lByu9abgDS18kpFmRNdWEtnW6e8=;
 b=h3ydy8+heAqgueAgDVNy81ZHAojQLr9tkVPoOuvGrXaqM9SJ9SArH9KGWV91nYhwm/
 b3rKhdzek4hyoaYiv+vJddABLA4ImenlLq1xV+KThk5yHZalthOPfTSyJkxSL/l+mYv4
 K/7L/7KsYszU9uOXYnhIaCt82UlgchCeP1bzwnMQzq/C1k2VLmsW9IYlmZD8tClyxmXQ
 5vGdZYVr40JzkKCQjdoPVqFRVkh1yXnt28F0+2v9bDW1V3DzcRFKlp+ZlfmDsATxq+Y6
 CRP+3xuXx8b9wVpsHlFn0juQLIAXkjzT70SbnX9t9HumDv1VzzUBVainNOw/V4qgy8WI
 snYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789867645; x=1790472445;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kgtjdvlp0rG0SdG0lByu9abgDS18kpFmRNdWEtnW6e8=;
 b=aKukNwnMGlmg03wWlCPQduf5TyWu4rhfaheZWstQ1ynS5kcl6/cYKQoKY7Tmjzbtq9
 y18ShNM8K/tJXCcmwJI5DU1uVdgErPJ51unnfJ2g2KwxyM4xfu/NGd3wU3Jg9jMYZXt8
 /7p8UNYDGmxma++o2HU3MLHPcT+JdrBfwRFsxC4B5mQMkQ5otmXtv+puv/udHf9BSdsf
 iAW18AlkeMQ0EerTEU3b3Q3XNAVSiLbRhcnTOGriSLkBPy9XxOnms5MDReZJbY8TvZwk
 PZzxbOxWn/F8B4Vq/akewNueU69tOt32FiJlU5/6rpKUScCio6FUcl5Ke85ZMVRThyIk
 DMhg==
X-Gm-Message-State: AFuF++mf9feypC5JzMA8Wab/nJreNI7GXC93pA+nu/UfT8TezyMmsfuF
 xBrEio2eHr1hhOnC97Sc4yc0+7/9qur9So+HaBD/1ITFv8IF4ckzg/gA81E0k902WnYiXJ12Xwb
 9kQkzEVK0+XMbh8FmfQ9n/j+JOXVV8JiPFj1J
X-Gm-Gg: AYBFou29FCdioZmugvpGa7jOiydZGMtLkId8H89HIG/J/EwaMwc7PqRLYSuVgpk/xS8
 +ArwX0lMtXi1be2n56yhGUmPAYV9OGx4TkdIkHEVBixSqChrAg50KV/ubOP8jSVoWpVJ3rSKT9I
 L5piCA4yremTKI05XkEvk1sLIgJmgMsHc+RQQsUzP6zUuwdIO+YvVztmul72M3MjJ7lATUEU+Rn
 3FTauZXILoJcG9+9UmssyZtIK5t7y5LJJ0tvUGJr3yDhq8U2CLtgZJDOnx8vDW+jzDzhQTNdQgG
 HGfZrjIsVqhHmSLZ8gtX1cnQ3tH643alipmne7Kdy9An2GgTR1mx35JbBv2mOm7dd0SqDJv+ftQ
 qtjE6/eiTSJDcxQ==
X-Received: by 2002:a05:6512:2216:b0:5b8:bc5e:d114 with SMTP id
 2adb3069b0e04-5b8c1981e70mr2032575e87.62.1789867645013; Sat, 19 Sep 2026
 18:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260917220718.60899-1-richard.henderson@linaro.org>
 <20260917220718.60899-3-richard.henderson@linaro.org>
In-Reply-To: <20260917220718.60899-3-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 21:27:10 -0400
X-Gm-Features: AcwNN1XnIB4UJkTOZcHD8x9FAFxpd8sii8zM0Nd2xv84D7tWLaUa2mhmBK30r0Q
Message-ID: <CAEdQ38GKxqBBQEOiVczFOL1ftxB-8uYMZrjhaOzdXv6g-1wpBw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] accel/tcg: Allow cross-page goto_tb chaining in
 user-only builds
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

On Thu, Sep 17, 2026 at 6:07=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Matt Turner <mattst88@gmail.com>
>
> translator_use_goto_tb() refuses to chain unless the destination is on th=
e
> same page as the start of the TB.  For guests whose text is much larger t=
han
> a page this is expensive: an emulated alpha gcc compiling a 255k line
> translation unit takes the indirect dispatch path for 8.4 billion of its
> 34.2 billion TB exits, and a large share of those are ordinary direct
> branches that simply crossed an 8 KiB page boundary.
>
> The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
> Introduce translator_use_goto_tb"), whose rationale was:
>
>     Various targets avoid the page crossing test for CONFIG_USER_ONLY,
>     but that is wrong: mmap and mprotect can change page permissions.
>
> That is true, but in user-only builds the invalidation path already cover=
s
> it.  There are no page tables: every mmap, mprotect and munmap reaches
> page_set_flags(), which calls tb_invalidate_phys_range() whenever the fla=
gs
> actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to reset
> incoming jumps.  A chained cross-page jump is therefore broken whenever t=
he
> destination page's permissions change. This is not true in system mode,
> where TBs are keyed by physical address and a page table change invalidat=
es
> nothing, so the restriction is kept there.
>
> The rule protects one more thing, which the original rationale does not
> mention: it guarantees that execution cannot enter a page without a TB
> lookup, and so without check_for_breakpoints().  That is what makes a
> breakpoint set after a block was translated take effect, since insertion
> deliberately invalidates nothing. A link established before the breakpoin=
t
> was set would jump straight over it.
>
> So the chaining is only enabled for a run that can never acquire a
> breakpoint. In user-only mode every breakpoint comes from gdb -- BP_CPU i=
s
> g_assert_not_reached() there, and the guest cannot ask for one -- and gdb
> has to be requested with -g before the first block is translated, even
> though with suspend=3Dn it may connect later. gdb_may_set_breakpoints()
> reports whether it was, and is fixed for the lifetime of the process.
>
> Add tests/tcg/multiarch/test-xpage-chain.c to cover both hazards directly=
.
> It writes the last instruction of one page and the first of the next, so
> that the fall-through between them is a cross-page goto_tb, runs it 20000=
0
> times so the chain is established, then checks that mprotect(PROT_NONE)
> makes the next call fault, and that different code written into the page
> once it is mapped back runs rather than a stale translation.
>
> The two instructions -- set the return value register, and return -- are
> all the architecture specific code there is; thirteen architectures suppl=
y
> them and the rest skip.
>
> The test detects the hazard it is meant to detect: with the
> tb_invalidate_phys_range() call in page_set_flags() commented out,
> it fails both phases, executing page B after PROT_NONE and returning
> the stale result.
>
> Run with -b, the same binary stops once the chain is established and
> lets tests/tcg/multiarch/gdbstub/xpage-bp.py set a breakpoint on the
> far side of it, which the next call has to stop on.
> With gdb_may_set_breakpoints() forced to false so that the chaining
> stays on under gdb, that breakpoint is missed and the test fails,
> which is what makes it a test of the gate rather than of gdb.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Update for meson test infrastructure]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260901034808.3524945-8-mattst88@gmail.com>
> ---
>  include/gdbstub/user.h                  |  11 +
>  accel/tcg/translator.c                  |  33 ++-
>  gdbstub/user.c                          |  14 +
>  tests/tcg/multiarch/test-xpage-chain.c  | 336 ++++++++++++++++++++++++
>  tests/tcg/multiarch/gdbstub/xpage-bp.py |  37 +++
>  tests/tcg/multiarch/meson.build         |   6 +
>  6 files changed, 436 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/multiarch/test-xpage-chain.c
>  create mode 100644 tests/tcg/multiarch/gdbstub/xpage-bp.py
>
> diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
> index 654986d483b..c091cd97586 100644
> --- a/include/gdbstub/user.h
> +++ b/include/gdbstub/user.h
> @@ -11,6 +11,17 @@
>
>  #define MAX_SIGINFO_LENGTH 128
>
> +/**
> + * gdb_may_set_breakpoints() - whether a breakpoint can ever be inserted
> + *
> + * In user-only mode every breakpoint comes from gdb, and gdb is only ev=
er
> + * reachable if -g was given at startup, before the guest ran a single
> + * instruction.  A run that has no gdbstub can therefore never acquire a
> + * breakpoint, which lets translation take shortcuts that a breakpoint
> + * would invalidate.  Stays true once true, even if gdb detaches.
> + */
> +bool gdb_may_set_breakpoints(void);
> +
>  /**
>   * gdb_handlesig() - yield control to gdb
>   * @cpu: CPU
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index e9943006947..7d1caf56553 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -15,6 +15,9 @@
>  #include "accel/tcg/cpu-mmu-index.h"
>  #include "exec/target_page.h"
>  #include "exec/translator.h"
> +#ifdef CONFIG_USER_ONLY
> +#include "gdbstub/user.h"
> +#endif
>  #include "exec/plugin-gen.h"
>  #include "tcg/tcg-op-common.h"
>  #include "internal-common.h"
> @@ -110,6 +113,34 @@ bool translator_is_same_page(const DisasContextBase =
*db, vaddr addr)
>      return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) =3D=3D 0;
>  }
>
> +/*
> + * Whether a direct jump may be chained to a destination outside the pag=
e
> + * the TB started in.
> + *
> + * In user-only mode there are no page tables.  Every mmap, mprotect and
> + * munmap goes through page_set_flags(), which calls tb_invalidate_phys_=
range()
> + * whenever the flags actually change, and tb_phys_invalidate() unlinks
> + * incoming jumps.  A cross-page link is therefore broken whenever the
> + * destination page's permissions change.

"whenever the flags actually change" is a bit looser than what
pageflags_set_clear() does. It sets inval_tb only when the existing
range has PAGE_EXEC and either exec is removed, write is added, or
clear_flags has PAGE_VALID, that is, a new mapping or an unmap. That is
still enough for the argument here, since a cached translation implies
the page was executable, but it would be good for the comment to say
that rather than the broader thing. My fault, that was my wording.

Otherwise this looks right to me.

> + *
> + * What the same-page rule also provides is that execution cannot enter =
a page
> + * without a TB lookup, and so without check_for_breakpoints(), which is=
 what
> + * makes a breakpoint set after a block was translated take effect.  Not=
hing
> + * invalidates on breakpoint insertion, so a link established beforehand=
 would
> + * jump straight over it.  In user-only mode breakpoints only ever come =
from
> + * gdb -- BP_CPU is g_assert_not_reached() there and the guest has no wa=
y to
> + * ask for one -- and gdb has to be requested with -g before the first b=
lock
> + * is translated, so a run that has no gdbstub can never acquire a break=
point.
> + */
> +static bool use_cross_page_goto_tb(void)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return !gdb_may_set_breakpoints();
> +#else
> +    return false;
> +#endif
> +}
> +
>  bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
>  {
>      /* Suppress goto_tb if requested. */
> @@ -118,7 +149,7 @@ bool translator_use_goto_tb(DisasContextBase *db, vad=
dr dest)
>      }
>
>      /* Check for the dest on the same page as the start of the TB.  */
> -    return translator_is_same_page(db, dest);
> +    return use_cross_page_goto_tb() || translator_is_same_page(db, dest)=
;
>  }
>
>  void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns=
,
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 9e6f9a6f376..d810f0f38c3 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -470,6 +470,18 @@ static void *gdbserver_accept_thread(void *arg)
>
>  #define USAGE "\nUsage: -g {port|path}[,suspend=3D{y|n}]"
>
> +/*
> + * Set before the guest runs and never cleared, so that code translated =
at
> + * any point can rely on it: with suspend=3Dn gdb may connect long after
> + * startup, and once connected it can insert a breakpoint at any time.
> + */
> +static bool gdbserver_requested;
> +
> +bool gdb_may_set_breakpoints(void)
> +{
> +    return gdbserver_requested;
> +}
> +
>  bool gdbserver_start(const char *args, Error **errp)
>  {
>      g_auto(GStrv) argv =3D g_strsplit(args, ",", 0);
> @@ -513,6 +525,8 @@ bool gdbserver_start(const char *args, Error **errp)
>          return false;
>      }
>
> +    gdbserver_requested =3D true;
> +
>      if (suspend) {
>          if (gdbserver_accept(port, gdb_fd, port_or_path)) {
>              gdb_handlesig(first_cpu, 0, NULL, NULL, 0);
> diff --git a/tests/tcg/multiarch/test-xpage-chain.c b/tests/tcg/multiarch=
/test-xpage-chain.c
> new file mode 100644
> index 00000000000..a4e34149e72
> --- /dev/null
> +++ b/tests/tcg/multiarch/test-xpage-chain.c
> @@ -0,0 +1,336 @@
> +/*
> + * Cross-page TB chaining hazard test.
> + *
> + * Two adjacent pages of hand-written code.  The last instruction of pag=
e A
> + * sets the return value and falls through into page B, which returns; a=
 TB
> + * always ends at a page boundary, so page A reaches page B through a
> + * cross-page goto_tb.
> + *
> + * Phase 1: run it enough times that QEMU chains TB_A -> TB_B.
> + * Phase 2: mprotect page B away. Re-running must fault.
> + * Phase 3: map it back and write different code into it. Re-running mus=
t
> + *          execute the NEW code, not a stale chained translation.
> + *
> + * With -b, phases 2 and 3 are replaced by a stop at break_here(), where=
 the
> + * gdbstub test sets a breakpoint on page B -- after the chain exists --=
 and
> + * checks that re-running the chain still stops on it.  See
> + * tests/tcg/multiarch/gdbstub/xpage-bp.py.
> + *
> + * The code the two pages hold is architecture specific, so each
> + * architecture supplies two emitters:
> + *
> + *   emit_set_ret(p, val) - set the integer return value register to val
> + *   emit_ret(p)          - return to the caller
> + *
> + * both writing at @p and returning the number of bytes written.  Neithe=
r
> + * may contain a branch: the fall-through from page A into page B is the
> + * whole point, and a delay slot must not straddle the boundary.  An
> + * architecture that supplies neither skips the test.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdint.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +static inline size_t put32(void *p, uint32_t insn)
> +{
> +    memcpy(p, &insn, sizeof(insn));
> +    return sizeof(insn);
> +}
> +
> +static inline size_t put16(void *p, uint16_t insn)
> +{
> +    memcpy(p, &insn, sizeof(insn));
> +    return sizeof(insn);
> +}
> +
> +#if defined(__aarch64__)
> +#define HAVE_EMITTERS
> +/* movz w0, #val */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x52800000u | ((uint32_t)val << 5));
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put32(p, 0xd65f03c0u);                       /* ret */
> +}
> +#elif defined(__alpha__)
> +#define HAVE_EMITTERS
> +/* lda $0, val($31) */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x201f0000u | (uint16_t)val);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put32(p, 0x6bfa8001u);                       /* ret */
> +}
> +#elif defined(__arm__)
> +#define HAVE_EMITTERS
> +/* mov r0, #val */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0xe3a00000u | (uint8_t)val);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put32(p, 0xe12fff1eu);                       /* bx lr */
> +}
> +#elif defined(__hppa__)
> +#define HAVE_EMITTERS
> +/* ldi val, %ret0 */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x341c0000u | ((uint32_t)val << 1));
> +}
> +static size_t emit_ret(void *p)
> +{
> +    size_t n =3D put32(p, 0xe840c000u);                   /* bv %r0(%rp)=
 */
> +    return n + put32((char *)p + n, 0x08000240u);       /* nop (delay sl=
ot) */
> +}
> +#elif defined(__i386__) || defined(__x86_64__)
> +#define HAVE_EMITTERS
> +/* mov $val, %eax */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    uint32_t imm =3D val;
> +    *(unsigned char *)p =3D 0xb8;
> +    return 1 + put32((char *)p + 1, imm);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    *(unsigned char *)p =3D 0xc3;                         /* ret */
> +    return 1;
> +}
> +#elif defined(__loongarch64)
> +#define HAVE_EMITTERS
> +/* ori $a0, $zero, val */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x03800004u | ((uint32_t)val << 10));
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put32(p, 0x4c000020u);                       /* jr $ra */
> +}
> +#elif defined(__m68k__)
> +#define HAVE_EMITTERS
> +/* moveq #val, %d0 */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put16(p, 0x7000u | (uint8_t)val);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put16(p, 0x4e75u);                           /* rts */
> +}
> +#elif defined(__mips__)
> +#define HAVE_EMITTERS
> +/* li $v0, val */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x24020000u | (uint16_t)val);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    size_t n =3D put32(p, 0x03e00008u);                   /* jr $ra */
> +    return n + put32((char *)p + n, 0x00000000u);       /* nop (delay sl=
ot) */
> +}
> +/*
> + * ELFv1 function pointers are descriptors rather than code addresses, s=
o
> + * there is nothing to call the raw code through.
> + */
> +#elif defined(__powerpc__) && \
> +      (!defined(__powerpc64__) || (defined(_CALL_ELF) && _CALL_ELF =3D=
=3D 2))
> +#define HAVE_EMITTERS
> +/* li r3, val */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x38600000u | (uint16_t)val);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put32(p, 0x4e800020u);                       /* blr */
> +}
> +#elif defined(__riscv)
> +#define HAVE_EMITTERS
> +/* addi a0, zero, val -- the 4 byte form, never c.li */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x00000513u | ((uint32_t)val << 20));
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put32(p, 0x00008067u);                       /* jalr zero, 0(=
ra) */
> +}
> +#elif defined(__s390x__)
> +#define HAVE_EMITTERS
> +/* lghi %r2, val */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    size_t n =3D put16(p, 0xa729u);
> +    return n + put16((char *)p + n, (uint16_t)val);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    return put16(p, 0x07feu);                           /* br %r14 */
> +}
> +#elif defined(__sh__)
> +#define HAVE_EMITTERS
> +/* mov #val, r0 */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put16(p, 0xe000u | (uint8_t)val);
> +}
> +static size_t emit_ret(void *p)
> +{
> +    size_t n =3D put16(p, 0x000bu);                       /* rts */
> +    return n + put16((char *)p + n, 0x0009u);           /* nop (delay sl=
ot) */
> +}
> +#elif defined(__sparc__)
> +#define HAVE_EMITTERS
> +/* mov val, %o0 */
> +static size_t emit_set_ret(void *p, int val)
> +{
> +    return put32(p, 0x90102000u | (uint32_t)(val & 0x1fff));
> +}
> +static size_t emit_ret(void *p)
> +{
> +    size_t n =3D put32(p, 0x81c3e008u);                   /* retl */
> +    return n + put32((char *)p + n, 0x01000000u);       /* nop (delay sl=
ot) */
> +}
> +#endif
> +
> +/* Where the fall-through lands, for the gdbstub test to breakpoint on. =
*/
> +void *page_b_entry;
> +
> +/* Somewhere for the gdbstub test to stop once the chain is established.=
 */
> +void __attribute__((noinline)) break_here(void)
> +{
> +    asm volatile ("");
> +}
> +
> +#ifdef HAVE_EMITTERS
> +static sigjmp_buf jb;
> +/*
> + * Written by the SIGSEGV handler and read by main(), so it must not be
> + * cached in a register across the faulting call.
> + */
> +static volatile sig_atomic_t caught;
> +
> +static void segv(int sig)
> +{
> +    caught =3D 1;
> +    siglongjmp(jb, 1);
> +}
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +    bool bp_mode =3D argc > 1 && strcmp(argv[1], "-b") =3D=3D 0;
> +#ifndef HAVE_EMITTERS
> +    printf("SKIP: no code emitters for this architecture\n");
> +    if (bp_mode) {
> +        break_here();
> +    }
> +    return 0;
> +#else
> +    unsigned char tmp[16];
> +    struct sigaction sa;
> +    long (*fn)(void);
> +    size_t setlen, n;
> +    long ps =3D sysconf(_SC_PAGESIZE);
> +    int rc =3D 0;
> +    unsigned char *m =3D mmap(NULL, 2 * ps, PROT_READ | PROT_WRITE | PRO=
T_EXEC,
> +                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (m =3D=3D MAP_FAILED) {
> +        perror("mmap");
> +        return 2;
> +    }
> +
> +    unsigned char *pb =3D m + ps;
> +
> +    /*
> +     * Page A ends with the store to the return value register, so that =
the
> +     * next instruction executed is the first one on page B.
> +     */
> +    setlen =3D emit_set_ret(tmp, 1);
> +    memcpy(pb - setlen, tmp, setlen);
> +    emit_ret(pb);
> +    __builtin___clear_cache((char *)m, (char *)m + 2 * ps);
> +
> +    page_b_entry =3D pb;
> +    fn =3D (long (*)(void))(pb - setlen);
> +
> +    for (int i =3D 0; i < 200000; i++) {
> +        if (fn() !=3D 1) {
> +            printf("FAIL: phase 1 wrong result\n");
> +            return 1;
> +        }
> +    }
> +    printf("phase 1 ok (chained)\n");
> +
> +    if (bp_mode) {
> +        /*
> +         * The chain from page A to page B now exists.  gdb puts a break=
point
> +         * on page_b_entry here; the call below has to stop on it rather=
 than
> +         * jump over it.
> +         */
> +        break_here();
> +        if (fn() !=3D 1) {
> +            printf("FAIL: bp phase wrong result\n");
> +            return 1;
> +        }
> +        printf("bp phase ok\n");
> +        return 0;
> +    }
> +
> +    memset(&sa, 0, sizeof(sa));
> +    sa.sa_handler =3D segv;
> +    sigemptyset(&sa.sa_mask);
> +    if (sigaction(SIGSEGV, &sa, NULL) !=3D 0) {
> +        perror("sigaction");
> +        return 2;
> +    }
> +    if (mprotect(pb, ps, PROT_NONE) !=3D 0) {
> +        perror("mprotect");
> +        return 2;
> +    }
> +    if (sigsetjmp(jb, 1) =3D=3D 0) {
> +        fn();
> +        printf("FAIL: phase 2 executed page B after mprotect(PROT_NONE)\=
n");
> +        rc =3D 1;
> +    } else if (!caught) {
> +        printf("FAIL: phase 2 longjmp without entering the handler\n");
> +        rc =3D 1;
> +    } else {
> +        printf("phase 2 ok (faulted)\n");
> +    }
> +
> +    /* Phase 3: map back, overwrite, expect the new code to run. */
> +    if (mprotect(pb, ps, PROT_READ | PROT_WRITE | PROT_EXEC) !=3D 0) {
> +        perror("mprotect back");
> +        return 2;
> +    }
> +    n =3D emit_set_ret(pb, 2);
> +    emit_ret(pb + n);
> +    __builtin___clear_cache((char *)pb, (char *)pb + ps);
> +
> +    long r =3D fn();
> +    if (r !=3D 2) {
> +        printf("FAIL: phase 3 returned %ld, expected 2 (stale chain)\n",=
 r);
> +        rc =3D 1;
> +    } else {
> +        printf("phase 3 ok (new code ran)\n");
> +    }
> +    return rc;
> +#endif
> +}
> diff --git a/tests/tcg/multiarch/gdbstub/xpage-bp.py b/tests/tcg/multiarc=
h/gdbstub/xpage-bp.py
> new file mode 100644
> index 00000000000..f40024f16de
> --- /dev/null
> +++ b/tests/tcg/multiarch/gdbstub/xpage-bp.py
> @@ -0,0 +1,37 @@
> +"""Test that a breakpoint set after a cross-page chain is established is=
 hit.
> +
> +translator_use_goto_tb() lets a direct branch chain to another page in
> +user-only builds, which is only safe because a run with no gdbstub can n=
ever
> +acquire a breakpoint.  This runs with one, so the chaining must be off a=
nd
> +the breakpoint must still be reached.
> +
> +This runs as a sourced script (via -x, via run-test.py).
> +
> +SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +from test_gdbstub import main, report
> +
> +
> +def run_test():
> +    """Run through the tests one by one"""
> +    gdb.Breakpoint("break_here")
> +    gdb.execute("continue")
> +
> +    # The chain exists by now; put a breakpoint on the far side of it.
> +    target =3D int(gdb.parse_and_eval("(unsigned long)page_b_entry"))
> +    if target =3D=3D 0:
> +        report(True, "no code emitters for this architecture, skipped")
> +        return
> +    gdb.execute("break *{}".format(target))
> +    gdb.execute("continue")
> +
> +    pc =3D int(gdb.parse_and_eval("(unsigned long)$pc"))
> +    report(pc =3D=3D target, "stopped at {:#x}, expected {:#x}".format(p=
c, target))
> +
> +    gdb.execute("delete")
> +    gdb.execute("continue")
> +    exitcode =3D int(gdb.parse_and_eval("$_exitcode"))
> +    report(exitcode =3D=3D 0, "{} =3D=3D 0".format(exitcode))
> +
> +
> +main(run_test)
> diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.=
build
> index 508fdb585b7..6e68d75fb20 100644
> --- a/tests/tcg/multiarch/meson.build
> +++ b/tests/tcg/multiarch/meson.build
> @@ -118,6 +118,12 @@ tests +=3D {
>      'gdb_test': ['--test', files('gdbstub/follow-fork-mode-parent.py')],
>    },
>  }
> +tests +=3D {
> +  multiarch/'test-xpage-chain.c': {
> +    'test_name': 'xpage-chain',
> +    'gdb_test': ['--test', files('gdbstub/xpage-bp.py'), '--pargs=3D-b']=
,
> +  },
> +}

Thanks for doing the meson conversion. This entry is the only one the
test gets, though, so the test now only ever runs under gdb.

Every other gdb test in tests/tcg/multiarch/meson.build has a plain
entry in the first tests dict as well: sha1.c, segfault.c, prot-none.c,
catch-syscalls.c, late-attach.c, follow-fork-mode.c, testthread.c,
sha512.c. With only a 'gdb_test' key, tests/tcg/meson.build registers a
single test named gdb-xpage-chain, run with -g, which is exactly the
case where gdb_may_set_breakpoints() turns the cross-page chaining back
off.

So phases 2 and 3, which are the only coverage of the path this patch
enables, never run. On top of that, the whole test is skipped wherever
gdb_arch is not in gdb_arch_supported.

This restores the default-mode run:

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.bu=
ild
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -49,6 +49,7 @@ tests +=3D {
   multiarch/'tb-link.c': {'cflags': ['-lpthread']},
   multiarch/'test-mmap.c': {},
+  multiarch/'test-xpage-chain.c': {},
   multiarch/'testthread.c': {'cflags': ['-lpthread']},
 }

The default test_name derives from the source file, so it registers as
test-xpage-chain and does not collide with xpage-chain.

With that added, the test passes for me. Checked by hand in the
meantime, building the test with alpha-unknown-linux-gnu-gcc -static -O2
and running it under qemu-alpha:

  phase 1 ok (chained)
  phase 2 ok (faulted)
  phase 3 ok (new code ran)

With those two things fixed, this looks good to me.

