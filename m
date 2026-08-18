Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822A9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNNs-0006cb-7w; Tue, 18 Aug 2026 13:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNNr-0006cO-Cj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:13:55 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNNp-0007Yj-1s
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:13:55 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-52d7a3defe8so398061cf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787073232; cv=none;
 d=google.com; s=arc-20260327;
 b=PoTeqjKR5cOlLSJLHTIT9ap0q9FWpBvlb25xBCnJlMjAbk58+qe22QbbJCllhIEXmt
 r2aaHtJVjNqKqhxMrarcKPU6v4TXirG6hGnWD/1iu1ap0TSqyikpEECrFRiLilfikQCv
 GqLwQEZvSkVdFBxYn15btYIcMIQfDnreD1BXX7BSpWalDefFvyNWqT4K8Ridu6CijuzD
 ZVby9xB7ACC/3AA3PR6ieG+bueVRD5ku4yoUqalURpDSo0+3IX8MtCCkM0fLzi6wooBC
 mN7H4vQrsB/CADpbIJF4R2Ltm11v3R4KQruL5B7hMk2UcsYeD47rsFi+KI6iwpwGFPWa
 qliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6sYePvUQKnpG4zY8DNGNc7jFS9qA+sHrNA2C9LUMszg=;
 fh=sPnp61a2YNNsKkD0W3RUEF+042aNl9Quj94CbgGh8Xs=;
 b=G9AnMEsxyaB5CAyWzYlHJw6qNrA39faOx8nUA9rdGALZdwWz8bRKXTxe7guOSf27L0
 bGENrJbdEpxCuFB9KOoTfFCfynio//cbqS9ORc+QHHZEdWarVRXuS7XB/sCrBz66I/b4
 ak3R5yunQku50HuJotahWttZTxKbBq7OLafnz2WbL/P2/ia3vpSw4xtsSa3X9AHqBCye
 TLRv/BJTUqZKSr4j8sRMQevkExEGErY9NB8g7S6KJef0mQJNBUzG09j57frIUuH40lie
 cCmzhLMeF+wZ67Cv6wBTuqootNDnqDRmD3iBNo+6q6zwyRdUimkCHO/QrmFrNN+ejvuU
 SLCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787073232; x=1787678032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6sYePvUQKnpG4zY8DNGNc7jFS9qA+sHrNA2C9LUMszg=;
 b=X1RVvuT1gP5Q0214dGLHm9oiP8YYHLhv0xkxFJjSqmlg7eWjSrA/sKzsg03XOazNvR
 j5sQORxT9Kh3mI9Zr6op7xz11/mI2x2GSMHZdPjv7cXGZEtKBSO1K3XaIjgx/YMgogqb
 C66mVPedV8SUThViwBLO/MMCjP5sTkMhO7Mq11D3G2sNlJJcVhjUJFUBxoyG5Avb/GGE
 HKCwxLOG2RRcUSWidz9ur07gMLSEZobaXQwAAhZ6iKTPYj4d6VDC+8tMZB7YgFo+ZCi6
 Fg+LsxNTCl5FOPqOqcjLD8Z8eNI7iTyLuVhyOab9taoD9fKSkfyw5/KbPy9CN4hS333b
 dvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073232; x=1787678032;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6sYePvUQKnpG4zY8DNGNc7jFS9qA+sHrNA2C9LUMszg=;
 b=Micqvv6mJUIEi0aOrlzRsiF/EHk/n9LsZfSOPZ0EgVPYOdkZFCTinIqwwrQBkTKlFk
 m2VrctiMn/Jvq2emiRUhfvx5vPbMkGDEppAdkkHhsMb7psdA2Ow9BJHHS8MC0qF3Un91
 gVKSiOiJBnSFeI6tGSQ7oFCzaeAEkCcdL/NjuzkzebEQdlvyRJEkSN0ivdxBwgcO8Gcd
 glGoQMfRN2ehhqwB063CZvXeBEOH6XYw3BcSGGw9+3Rvo4sPjKZrboJKRkEpCxvn0QbO
 JxyiHXmipjZXS6zAEUewxDe8Fp+iJndVCw7LMTsuDisS92z275qTG1BLu/USfrNL9u0J
 fdlw==
X-Gm-Message-State: AOJu0YxE6RRKVcVsqz3Z3xQttmdNuNSsyrCE1ftzM42IYB5MyumVDEur
 Hod0NnXGzYiGG/OivbaVerf5cLhPHUwZE9xjfBOUudlr4FRCGOpWFuEcjONtuSofdCDDdjiHrsc
 NxrpJZCQi722sG956DBSkPuMTSvFbZmc=
X-Gm-Gg: AR+sD10vwlqjiEksbSYMInrDKWu8IO1zv+3hJxIU94HM2NORAv8+qOeUzmfdCiwi03Z
 0y5W0W6sTzKQDx4uELdEu/aFuAzXgklxm6EuU2yWqVd51p0OQmY/Nn1+y1EgTjspnrchW4Im7sn
 zf2qRLqkmAtv9YnfUDHAPqtd4m+pCW9oIOen4j2+Rwa4EesnbAChN+uiR0leiNJ1E9TnbaQnyVm
 AqAfvMp/rSKMHkiIbGZCRR3CTQ8XpHJ0VcjPpt9PDFe6ECMHPvy0uoLkOjaIfSUGtxG7Y4Z1BeB
 WvNMncKQ8Q9yOQ08xBsCKenHMDuStBsXAS+NFiknld/t+rRPU1d1H0ufYwCsvgidijbe+Tt2QrB
 ZKjE=
X-Received: by 2002:a05:622a:c9:b0:51c:bb79:a52d with SMTP id
 d75a77b69052e-52d854221b7mr319513651cf.14.1787073231535; Tue, 18 Aug 2026
 10:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260817190038.580257-1-mattst88@gmail.com>
 <403cb8e2-5f3d-4c5c-a509-fc13b4cd50f9@oss.qualcomm.com>
In-Reply-To: <403cb8e2-5f3d-4c5c-a509-fc13b4cd50f9@oss.qualcomm.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 18 Aug 2026 13:13:37 -0400
X-Gm-Features: AcwNN1VBNzWVNP1s3qukGccYzRhmS5mmw44FMDOfJudYSw9b3d8d8jefcItX-eY
Message-ID: <CAEdQ38HnKhWa-bHabiZRMYgSu=QY4-jH502QudLzOm6J77heRg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] accel/tcg: cut per-block dispatch overhead
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 philmd@mailo.com, zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=mattst88@gmail.com; helo=mail-qt1-x836.google.com
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

On Tue, Aug 18, 2026 at 12:38=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Hi Matt,
>
> On 8/17/2026 12:00 PM, Matt Turner wrote:
> > For guests running large amounts of code, most of what TCG executes is =
not
> > translated guest work but the fixed overhead around it. Blocks are shor=
t and
> > there are a great many of them, so the constant cost at each end of a b=
lock
> > (the interrupt poll and the can_do_io stores on entry, the dispatch on
> > exit) ends up dominating everything else.
> >
> > The workload throughout is qemu-alpha running an emulated alpha gcc 16.=
2.0
> > compiling the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64
> > host, in a --static --enable-lto --target-list=3Dalpha-linux-user build=
. It
> > executes 34.2 billion TBs at 6.04 guest instructions each, and 24.6% of=
 its
> > TB exits cannot use goto_tb. That is a representative shape for any gue=
st
> > whose text is much larger than a page: indirect calls and returns
> > everywhere, plus direct branches that merely crossed a page boundary.
> >
> > The first three patches are ordinary cleanups that stand on their own. =
The
> > remaining five are marked RFC individually and are where the interestin=
g
> > questions are.
> >
> >   1  accel/tcg: cache the result of curr_cflags()
> >
> >      Recomputed on every one of the run's 8.4 billion dispatches, from
> >      state that changes only when gdb enables single-step or a log mask
> >      moves. Cache it in CPUState and recompute from the four places tha=
t
> >      can change an input.                                        -5.10%
> >
> >   2  accel/tcg: enlarge the TB jump cache to 64K entries
> >
> >      4096 entries is too small for a guest running a large program;
> >      tb_htable_lookup() is 5.73% of samples. 16 bits is the knee of the
> >      sizing curve, at 1 MiB per vCPU.                            -6.02%
> >
> >   3  accel/tcg: skip the can_do_io stores in user-only builds
> >
> >      Two stores per TB that nothing in a user-only build reads: 68 bill=
ion
> >      of them over the run.                              -4.55%, -4.32% =
wall
> >
> >   4  RFC: tcg: probe the TB jump cache inline instead of calling a help=
er
> >
> >      95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the ju=
mp
> >      cache. Emit the probe inline (hash, three guarded loads, goto_ptr)
> >      and call the helper only on a miss.               -36.51%, -27.05%=
 wall
> >
> >   5  RFC: accel/tcg: allow cross-page goto_tb chaining in user-only bui=
lds
> >
> >      translator_use_goto_tb() refuses to chain across a page. In user-o=
nly
> >      builds the invalidation path already covers what that was protecti=
ng
> >      against: every mmap/mprotect/munmap reaches page_set_flags(), whic=
h
> >      invalidates and unlinks. Lift it there, keep it for system mode.
> >                                                         -2.42%, -4.68% =
wall
> >
> >   6  RFC: accel/tcg: only poll for interrupts in blocks that can close =
a
> >      cycle
> >
> >      The icount_decr poll needs to happen once per cycle in the guest C=
FG,
> >      not once per block, and any cycle must contain either a backward e=
dge
> >      or an indirect one. Record both during translation and emit the ch=
eck
> >      only for blocks that have one.                     -6.81%, -3.10% =
wall
> >
> >   7  RFC: accel/tcg: poison the jump cache instead of polling for indir=
ect
> >      exits
> >
> >      What patch 6 leaves behind is mostly blocks flagged for an indirec=
t
> >      exit. Give the inline probe its own jump cache base pointer and po=
int
> >      it at zeroes when an exit is requested: every dispatch then misses
> >      into the helper, which returns the epilogue. The poll becomes a
> >      pointer swap on the request path.                  -2.79%, -1.94% =
wall
> >
> >   8  RFC: tcg: fold a guest displacement into the host addressing mode
> >
> >      tcg_gen_qemu_ld/st cannot express a based access, so a target with=
 a
> >      displacement in its encodings materializes the address with an lea
> >      that the host addressing mode would have done for free. Fold a
> >      preceding constant add into a new argument on the op, opt-in per
> >      backend, wired up for x86_64 user-only.            -6.29%, -3.29% =
wall
> >
> > Each percentage is against the patch before it. End to end, measuring a=
n
> > unmodified build of the same base against the full series, five runs ea=
ch,
> > interleaved in one session so that host clock drift is shared rather th=
an
> > attributed (mean, with the run-to-run spread):
> >
> >     instructions retired: 1,646,129,294,236 -> 738,003,153,831   -55.17=
%
> >                                     (0.16%)           (0.03%)
> >     wall clock:                    134.934s ->          75.189s   -44.2=
8%
> >                                     (0.30%)           (0.99%)
> >
> > Both endpoints ran at the same 4.782 GHz effective clock, and the .s fi=
les
> > they produced are identical.
> >
> > The two figures do not track each other, and that is the interesting pa=
rt:
> > what the series removes is cheap, well-predicted, highly pipelined work=
, so
> > it retires far more instructions than it saves time. IPC falls from 2.5=
5 to
> > 2.05 as the remaining work gets less regular. Patch 4 also cuts
> > L1-icache load misses by 39.1%, because a dispatch no longer jumps into
> > qemu's .text and evicts translated code; qemu's own .text falls from 38=
.9%
> > to 5.4% of profile samples over the series.
> >
> > Every revision was built and measured separately, so the series bisects=
, and
> > the emulated compiler produces byte-identical assembly output at every =
step,
> > which is the correctness check these patches most need. Two new alpha
> > tests cover the hazards the series creates: tests/tcg/alpha/test-xpage-=
chain.c
> > (patch 5) and test-indirect-irq.c (patch 7). Both fail or hang if the
> > mechanism they cover is removed, which is what makes them tests of the =
new
> > behavior rather than of the old.
> >
> > The RFC patches need eyes I cannot supply myself. In rough order of how=
 much
> > I would like someone to look at them:
> >
> >   - Patch 5 reverses a deliberate decision made in d3a2a1d803 on the
> >     strength of an argument about the user-only invalidation paths.
> >
> >   - Patch 6 moves system-mode interrupt latency from "bounded by block
> >     count" to "bounded by guest control flow". The bound is one
> >     straight-line run between cycles, but timer-driven guests want a cl=
oser
> >     look than I can give them. Its soundness also assumes every goto_tb
> >     destination passes through translator_use_goto_tb(); no target in t=
he
> >     tree bypasses it today, but nothing enforces that.
> >
> >   - Patch 4 treats cpu flags and cflags as translation-time constants i=
n
> >     its guards, reads a jump cache entry without qatomic_read(), and pu=
ts
> >     knowledge of the CPUJumpCache layout in tcg/tcg-op.c, where it does=
 not
> >     belong.
> >
> >   - Patch 7's restore in cpu_handle_interrupt() races a concurrent pois=
on
> >     from another thread. I believe the existing barrier around
> >     icount_decr.u16.high covers it, but my testing was single-threaded =
user
> >     mode.
> >
> >   - Patch 8 only examines the immediately preceding op, refuses any acc=
ess
> >     with a slow path (so user-only, and no alignment check), and leaves=
 the
> >     i128 pairs alone.
> >
> >   - Patch 2's 1 MiB per vCPU is easy to justify for a single-vCPU
> >     linux-user process and less obvious for system emulation with many
> >     vCPUs. It may want to be sized per target or made tunable rather th=
an
> >     raised unconditionally.
> >
> > Patches 4 and 8 are wired up for alpha and x86_64 respectively; everyth=
ing
> > else is target-independent, and no other backend changes behavior or ne=
eds
> > touching.
> >
> > Matt Turner (8):
> >   accel/tcg: cache the result of curr_cflags()
> >   accel/tcg: enlarge the TB jump cache to 64K entries
> >   accel/tcg: skip the can_do_io stores in user-only builds
> >   RFC: tcg: probe the TB jump cache inline instead of calling a helper
> >   RFC: accel/tcg: allow cross-page goto_tb chaining in user-only builds
> >   RFC: accel/tcg: only poll for interrupts in blocks that can close a
> >     cycle
> >   RFC: accel/tcg: poison the jump cache instead of polling for indirect
> >     exits
> >   RFC: tcg: fold a guest displacement into the host addressing mode
> >
> >  accel/tcg/cpu-exec-common.c         |  48 +++++++++++-
> >  accel/tcg/cpu-exec.c                |  54 ++++++++++++++
> >  accel/tcg/internal-common.h         |  22 +++++-
> >  accel/tcg/tb-jmp-cache.h            |   2 +-
> >  accel/tcg/tcg-accel-ops.c           |   2 +
> >  accel/tcg/tcg-all.c                 |   1 +
> >  accel/tcg/translator.c              |  77 ++++++++++++++++++-
> >  cpu-target.c                        |   3 +
> >  include/exec/translation-block.h    |   6 ++
> >  include/exec/translator.h           |   2 +
> >  include/hw/core/cpu.h               |  23 +++++-
> >  include/system/tcg.h                |   9 +++
> >  include/tcg/tcg-op-common.h         |   2 +
> >  include/tcg/tcg-opc.h               |   9 ++-
> >  linux-user/main.c                   |   2 +-
> >  stubs/meson.build                   |   1 +
> >  stubs/tcg-cflags.c                  |  16 ++++
> >  target/alpha/cpu.c                  |   2 +-
> >  target/alpha/translate.c            |   6 +-
> >  tcg/tcg-op-ldst.c                   |   3 +-
> >  tcg/tcg-op.c                        |  86 +++++++++++++++++++++
> >  tcg/tcg.c                           |  86 ++++++++++++++++++++-
> >  tcg/x86_64/tcg-target.c.inc         |  61 +++++++++++++++
> >  tcg/x86_64/tcg-target.h             |   3 +
> >  tests/tcg/alpha/Makefile.target     |   3 +-
> >  tests/tcg/alpha/test-indirect-irq.c |  53 +++++++++++++
> >  tests/tcg/alpha/test-xpage-chain.c  | 111 ++++++++++++++++++++++++++++
> >  util/log.c                          |   4 +
> >  28 files changed, 676 insertions(+), 21 deletions(-)
> >  create mode 100644 stubs/tcg-cflags.c
> >  create mode 100644 tests/tcg/alpha/test-indirect-irq.c
> >  create mode 100644 tests/tcg/alpha/test-xpage-chain.c
> >
>
> I was curious to give it a try and see if everything works before
> helping on review, however series does not apply on master currently.
>
> Could you please rebase it and send a v2?

Odd, it's based on commit af06b5df26 ("Merge tag 'qom-qdev-20260814'
of https://gitlab.com/mcayland-ntx/qemu into staging") from just a
couple of days ago. I'll handle feedback received so far and send a v2
today.

