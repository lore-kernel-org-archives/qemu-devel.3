Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79423C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNqz-0003Ok-7D; Tue, 18 Aug 2026 13:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqy-0003Nd-9T
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:44:00 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqv-0008Iq-IG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:44:00 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5aeb98460c6so194736e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787075036; cv=none;
 d=google.com; s=arc-20260327;
 b=OpSUxGZgkgiEq6futgCqLZVUffunSb/9b0owXaESEvNovRs0Z8T/rnzlaxaokuLxEg
 aWGEsnrirtFDGzvgBb9NimbTpdNgnJbTG6RoYnPSflw8vhOn8LpCsH7nEnYNQgHm/UrD
 onCF56l9E0+vO5G0fi2DSoV9yBUZOC1XZIca63j+Dzb3OzXvAvQSKQAiCGIkoLxx11ua
 UWV6NBhYzrMHE2VHnYzN8DbUs5/xf7sTvMsbrluyPnyjBgXHgRPBN1dw0fHsc+BVjhIK
 H90KE5HgxDFT6Ai9l/des4FDK8naZl875U53mTUIp68T3pebj0/VWxRm4ww+4eGJRfEj
 x0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BwdA1309gp+EZghzvIry4OBPeX2QfOEgs+Vvyu5DCZ4=;
 fh=sPnp61a2YNNsKkD0W3RUEF+042aNl9Quj94CbgGh8Xs=;
 b=oqOwObPwR35/VgCtdDPvVnIeoSUeobYIH4brl08Yc6k6+7/gnmqJhQ0zTrIzZS4BUc
 2YDGaEV6IVH+FfrBkuNjaw1q2joNeF6LmhfY+dkAr841OB/vXVNnXtJklfEEOnONvvb5
 24QL5rXPKstUHqsP1H2yiiK4aCPnkYhqLZkRNds35xg9Q7b69bne0H9YUdMhJi0lQSb2
 LFlbBVCyvF6tErk9Ish+7PP5ttz53Sbr6E2yslJS4kCajL07rKnpvzBtobJxDwEf5SXC
 qLOUewjGJ/MwypN0Sv8GkoG70sYF0voKD2mP9XS5nwuXpe3ppWSgA66/Qc0q4jHnQ2p4
 EUvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787075036; x=1787679836; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BwdA1309gp+EZghzvIry4OBPeX2QfOEgs+Vvyu5DCZ4=;
 b=ecj2MoDuIrXrOhbDJdTNaJ7Hqzmhz7FPmHsFQSrLvlCWL9JPWm2ZYDAGdtXyFAgfjY
 CJmZhbgNyTbIxqrTlBmfNiMhFGHiIDmbk1PrFNLOf8ONSyg8DJbOXRzG3mEwDbjFLXwl
 0i+R4prwHluLf1fcf7s+9J/ozpWtcvT/efugjqczrDXs9nW/HWwuEJ9dTCftCq/pmwQq
 +vOSX1hDeYA24haM6aOoTGi/oXzVj4CGq+BVRDCwp5kEdyav70s5KqAFVBUWrX12j7xw
 Y66BjzrJQF18drJSSb3frGVJruaJRDZ1uEwQLaxPPHmDj1qkapN91qO2khCkrT5Q8SBm
 ZS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075036; x=1787679836;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BwdA1309gp+EZghzvIry4OBPeX2QfOEgs+Vvyu5DCZ4=;
 b=bDSmh1Fsa+zQpZ4Sybc/qE4mQk3JjFLW28jN1ZNT0GvCuqOeRfT2Kl/MVPr4EiIFdw
 b3FKyh8PCYNuEImsgwcfJ6PsSQxUodiCcUKQ4VLbLpNjFbn45eHm9zsdNrW0Hfo2Ec3u
 TXp1dPTdAd7/nMa/+870w8Iw5ctq8cxBZgppqwT35vwvYglVBpFlJ4mJ2I7lkUjLz8R4
 S2+kzYphRv6fO/wqp6DwO9d+oHelr3yqrVzPQB8NyVP/7fY/6NsTQC+xtM1cU9pD/Bw4
 Qoj/uYAy4YcP6GBrQumOdL7TMiBf9HU1nN+SDrDLAijCZFR6l2BJLvU6Iu9gQU+FZ7j+
 dpcw==
X-Gm-Message-State: AOJu0YyZefpe/DQ/AIJyvtHY9KulPvJkgv+MNKZyyewpMYwLCZdFKJjd
 gLFWCdcDaK6KvQBIV+sCrmUGR4qv6G9tSXQKqRXtkF4ajC5B10oqbvhipSWRpQXjLz13KCGzAIn
 IR9/XYnn6e8LNSX7EyNJ5SK5k1egohP8=
X-Gm-Gg: AR+sD136SeXjuxsi/v5qAzvvU85eI9ynM2UTZYAAq6kxGwb2qoAtRmVVPLsCTJZhaz3
 oOkgOB+dfgGffmYmQe2ThtcMAEPRZvKA2jRcpJXLWWK+rYCikGLtTY/uis6mjl9zwztUxsGPJTN
 dXTpeNsOLIl7pIMqvVDuxLvudwajrwiL/a2BCRLIC3nO0ahKL0AyoePdEqQsBetiz2P1274HIzO
 ttqSjJCrSu8Z15Vw17DSngf4+dB0vYghwZP0IHGxOZcxZhxXsM0Alu0wt3sJHuKt4rHy7yG2qhx
 /QbfF6lgk6SrTY2Gi1nOLAkZgWTgIMJ991fKZLYSiA+L6Oni6bdo/Q6ZZNaUu7Ih1wSYVGkudTj
 OtSA=
X-Received: by 2002:a05:6512:4028:b0:5ae:af98:497f with SMTP id
 2adb3069b0e04-5b477c9f3ddmr58207e87.7.1787075035240; Tue, 18 Aug 2026
 10:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260817190038.580257-1-mattst88@gmail.com>
 <403cb8e2-5f3d-4c5c-a509-fc13b4cd50f9@oss.qualcomm.com>
 <CAEdQ38HnKhWa-bHabiZRMYgSu=QY4-jH502QudLzOm6J77heRg@mail.gmail.com>
In-Reply-To: <CAEdQ38HnKhWa-bHabiZRMYgSu=QY4-jH502QudLzOm6J77heRg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 18 Aug 2026 13:43:43 -0400
X-Gm-Features: AcwNN1WR00bNiSotl36VK5CKMT6MxsBsq90i8I0cHXbJjGsvDWDPp132hO-8qCs
Message-ID: <CAEdQ38FKoO8OJD7mMbSH0s-EVzSVsQ5BafqSfpn4w9VJgO1O_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] accel/tcg: cut per-block dispatch overhead
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 philmd@mailo.com, zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Aug 18, 2026 at 1:13=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Tue, Aug 18, 2026 at 12:38=E2=80=AFPM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >
> > Hi Matt,
> >
> > On 8/17/2026 12:00 PM, Matt Turner wrote:
> > > For guests running large amounts of code, most of what TCG executes i=
s not
> > > translated guest work but the fixed overhead around it. Blocks are sh=
ort and
> > > there are a great many of them, so the constant cost at each end of a=
 block
> > > (the interrupt poll and the can_do_io stores on entry, the dispatch o=
n
> > > exit) ends up dominating everything else.
> > >
> > > The workload throughout is qemu-alpha running an emulated alpha gcc 1=
6.2.0
> > > compiling the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-=
64
> > > host, in a --static --enable-lto --target-list=3Dalpha-linux-user bui=
ld. It
> > > executes 34.2 billion TBs at 6.04 guest instructions each, and 24.6% =
of its
> > > TB exits cannot use goto_tb. That is a representative shape for any g=
uest
> > > whose text is much larger than a page: indirect calls and returns
> > > everywhere, plus direct branches that merely crossed a page boundary.
> > >
> > > The first three patches are ordinary cleanups that stand on their own=
. The
> > > remaining five are marked RFC individually and are where the interest=
ing
> > > questions are.
> > >
> > >   1  accel/tcg: cache the result of curr_cflags()
> > >
> > >      Recomputed on every one of the run's 8.4 billion dispatches, fro=
m
> > >      state that changes only when gdb enables single-step or a log ma=
sk
> > >      moves. Cache it in CPUState and recompute from the four places t=
hat
> > >      can change an input.                                        -5.1=
0%
> > >
> > >   2  accel/tcg: enlarge the TB jump cache to 64K entries
> > >
> > >      4096 entries is too small for a guest running a large program;
> > >      tb_htable_lookup() is 5.73% of samples. 16 bits is the knee of t=
he
> > >      sizing curve, at 1 MiB per vCPU.                            -6.0=
2%
> > >
> > >   3  accel/tcg: skip the can_do_io stores in user-only builds
> > >
> > >      Two stores per TB that nothing in a user-only build reads: 68 bi=
llion
> > >      of them over the run.                              -4.55%, -4.32=
% wall
> > >
> > >   4  RFC: tcg: probe the TB jump cache inline instead of calling a he=
lper
> > >
> > >      95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the =
jump
> > >      cache. Emit the probe inline (hash, three guarded loads, goto_pt=
r)
> > >      and call the helper only on a miss.               -36.51%, -27.0=
5% wall
> > >
> > >   5  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only b=
uilds
> > >
> > >      translator_use_goto_tb() refuses to chain across a page. In user=
-only
> > >      builds the invalidation path already covers what that was protec=
ting
> > >      against: every mmap/mprotect/munmap reaches page_set_flags(), wh=
ich
> > >      invalidates and unlinks. Lift it there, keep it for system mode.
> > >                                                         -2.42%, -4.68=
% wall
> > >
> > >   6  RFC: accel/tcg: only poll for interrupts in blocks that can clos=
e a
> > >      cycle
> > >
> > >      The icount_decr poll needs to happen once per cycle in the guest=
 CFG,
> > >      not once per block, and any cycle must contain either a backward=
 edge
> > >      or an indirect one. Record both during translation and emit the =
check
> > >      only for blocks that have one.                     -6.81%, -3.10=
% wall
> > >
> > >   7  RFC: accel/tcg: poison the jump cache instead of polling for ind=
irect
> > >      exits
> > >
> > >      What patch 6 leaves behind is mostly blocks flagged for an indir=
ect
> > >      exit. Give the inline probe its own jump cache base pointer and =
point
> > >      it at zeroes when an exit is requested: every dispatch then miss=
es
> > >      into the helper, which returns the epilogue. The poll becomes a
> > >      pointer swap on the request path.                  -2.79%, -1.94=
% wall
> > >
> > >   8  RFC: tcg: fold a guest displacement into the host addressing mod=
e
> > >
> > >      tcg_gen_qemu_ld/st cannot express a based access, so a target wi=
th a
> > >      displacement in its encodings materializes the address with an l=
ea
> > >      that the host addressing mode would have done for free. Fold a
> > >      preceding constant add into a new argument on the op, opt-in per
> > >      backend, wired up for x86_64 user-only.            -6.29%, -3.29=
% wall
> > >
> > > Each percentage is against the patch before it. End to end, measuring=
 an
> > > unmodified build of the same base against the full series, five runs =
each,
> > > interleaved in one session so that host clock drift is shared rather =
than
> > > attributed (mean, with the run-to-run spread):
> > >
> > >     instructions retired: 1,646,129,294,236 -> 738,003,153,831   -55.=
17%
> > >                                     (0.16%)           (0.03%)
> > >     wall clock:                    134.934s ->          75.189s   -44=
.28%
> > >                                     (0.30%)           (0.99%)
> > >
> > > Both endpoints ran at the same 4.782 GHz effective clock, and the .s =
files
> > > they produced are identical.
> > >
> > > The two figures do not track each other, and that is the interesting =
part:
> > > what the series removes is cheap, well-predicted, highly pipelined wo=
rk, so
> > > it retires far more instructions than it saves time. IPC falls from 2=
.55 to
> > > 2.05 as the remaining work gets less regular. Patch 4 also cuts
> > > L1-icache load misses by 39.1%, because a dispatch no longer jumps in=
to
> > > qemu's .text and evicts translated code; qemu's own .text falls from =
38.9%
> > > to 5.4% of profile samples over the series.
> > >
> > > Every revision was built and measured separately, so the series bisec=
ts, and
> > > the emulated compiler produces byte-identical assembly output at ever=
y step,
> > > which is the correctness check these patches most need. Two new alpha
> > > tests cover the hazards the series creates: tests/tcg/alpha/test-xpag=
e-chain.c
> > > (patch 5) and test-indirect-irq.c (patch 7). Both fail or hang if the
> > > mechanism they cover is removed, which is what makes them tests of th=
e new
> > > behavior rather than of the old.
> > >
> > > The RFC patches need eyes I cannot supply myself. In rough order of h=
ow much
> > > I would like someone to look at them:
> > >
> > >   - Patch 5 reverses a deliberate decision made in d3a2a1d803 on the
> > >     strength of an argument about the user-only invalidation paths.
> > >
> > >   - Patch 6 moves system-mode interrupt latency from "bounded by bloc=
k
> > >     count" to "bounded by guest control flow". The bound is one
> > >     straight-line run between cycles, but timer-driven guests want a =
closer
> > >     look than I can give them. Its soundness also assumes every goto_=
tb
> > >     destination passes through translator_use_goto_tb(); no target in=
 the
> > >     tree bypasses it today, but nothing enforces that.
> > >
> > >   - Patch 4 treats cpu flags and cflags as translation-time constants=
 in
> > >     its guards, reads a jump cache entry without qatomic_read(), and =
puts
> > >     knowledge of the CPUJumpCache layout in tcg/tcg-op.c, where it do=
es not
> > >     belong.
> > >
> > >   - Patch 7's restore in cpu_handle_interrupt() races a concurrent po=
ison
> > >     from another thread. I believe the existing barrier around
> > >     icount_decr.u16.high covers it, but my testing was single-threade=
d user
> > >     mode.
> > >
> > >   - Patch 8 only examines the immediately preceding op, refuses any a=
ccess
> > >     with a slow path (so user-only, and no alignment check), and leav=
es the
> > >     i128 pairs alone.
> > >
> > >   - Patch 2's 1 MiB per vCPU is easy to justify for a single-vCPU
> > >     linux-user process and less obvious for system emulation with man=
y
> > >     vCPUs. It may want to be sized per target or made tunable rather =
than
> > >     raised unconditionally.
> > >
> > > Patches 4 and 8 are wired up for alpha and x86_64 respectively; every=
thing
> > > else is target-independent, and no other backend changes behavior or =
needs
> > > touching.
> > >
> > > Matt Turner (8):
> > >   accel/tcg: cache the result of curr_cflags()
> > >   accel/tcg: enlarge the TB jump cache to 64K entries
> > >   accel/tcg: skip the can_do_io stores in user-only builds
> > >   RFC: tcg: probe the TB jump cache inline instead of calling a helpe=
r
> > >   RFC: accel/tcg: allow cross-page goto_tb chaining in user-only buil=
ds
> > >   RFC: accel/tcg: only poll for interrupts in blocks that can close a
> > >     cycle
> > >   RFC: accel/tcg: poison the jump cache instead of polling for indire=
ct
> > >     exits
> > >   RFC: tcg: fold a guest displacement into the host addressing mode
> > >
> > >  accel/tcg/cpu-exec-common.c         |  48 +++++++++++-
> > >  accel/tcg/cpu-exec.c                |  54 ++++++++++++++
> > >  accel/tcg/internal-common.h         |  22 +++++-
> > >  accel/tcg/tb-jmp-cache.h            |   2 +-
> > >  accel/tcg/tcg-accel-ops.c           |   2 +
> > >  accel/tcg/tcg-all.c                 |   1 +
> > >  accel/tcg/translator.c              |  77 ++++++++++++++++++-
> > >  cpu-target.c                        |   3 +
> > >  include/exec/translation-block.h    |   6 ++
> > >  include/exec/translator.h           |   2 +
> > >  include/hw/core/cpu.h               |  23 +++++-
> > >  include/system/tcg.h                |   9 +++
> > >  include/tcg/tcg-op-common.h         |   2 +
> > >  include/tcg/tcg-opc.h               |   9 ++-
> > >  linux-user/main.c                   |   2 +-
> > >  stubs/meson.build                   |   1 +
> > >  stubs/tcg-cflags.c                  |  16 ++++
> > >  target/alpha/cpu.c                  |   2 +-
> > >  target/alpha/translate.c            |   6 +-
> > >  tcg/tcg-op-ldst.c                   |   3 +-
> > >  tcg/tcg-op.c                        |  86 +++++++++++++++++++++
> > >  tcg/tcg.c                           |  86 ++++++++++++++++++++-
> > >  tcg/x86_64/tcg-target.c.inc         |  61 +++++++++++++++
> > >  tcg/x86_64/tcg-target.h             |   3 +
> > >  tests/tcg/alpha/Makefile.target     |   3 +-
> > >  tests/tcg/alpha/test-indirect-irq.c |  53 +++++++++++++
> > >  tests/tcg/alpha/test-xpage-chain.c  | 111 ++++++++++++++++++++++++++=
++
> > >  util/log.c                          |   4 +
> > >  28 files changed, 676 insertions(+), 21 deletions(-)
> > >  create mode 100644 stubs/tcg-cflags.c
> > >  create mode 100644 tests/tcg/alpha/test-indirect-irq.c
> > >  create mode 100644 tests/tcg/alpha/test-xpage-chain.c
> > >
> >
> > I was curious to give it a try and see if everything works before
> > helping on review, however series does not apply on master currently.
> >
> > Could you please rebase it and send a v2?
>
> Odd, it's based on commit af06b5df26 ("Merge tag 'qom-qdev-20260814'
> of https://gitlab.com/mcayland-ntx/qemu into staging") from just a
> couple of days ago. I'll handle feedback received so far and send a v2
> today.

I've sent v2, but v1 rebased cleanly onto master for me as well.

