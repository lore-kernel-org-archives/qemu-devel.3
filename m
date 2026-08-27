Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2997DC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSBc-0003Qg-VG; Thu, 27 Aug 2026 00:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBb-0003QU-Ro
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:57:59 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBZ-0000sY-Tz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:57:59 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5b5607bd3b5so255964e87.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787806676; cv=none;
 d=google.com; s=arc-20260327;
 b=ghJjXw3Sp/xtFGvXjICOuvsSeH17DO7Cjd3qug5AkLfcTGQO6U1jZubyniJcKyRBr6
 mWyRc0YhxaIRsE91Yc/9gFK7231I3dnGVD63xSV1WzwAvIVGlEeHvAOPlyqVFH4wny6j
 4SY8LPDQF78EW9Jvqm3BcVhVZ0h4aHwKYkluBFS8/iZLa0PBnpYAVVL/hFDZRlWzTDic
 Cd6GJRl0jQxAZc7yJOQM9tkflzhtd42C2H2ruhsq9W/xLKbzsQ7LWDEMkYTpH8Yo1lTY
 ZpJjhzx5K/dWRd0yQ+89CbYNEfqYgEjPMLh2UlYHp6mgEQxHf/rfZ9VOAesfBJgTavHg
 PM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a9ZArFkXlEH5mM1UKLIa6QRPl0lpAzd7IELtVjOWABI=;
 fh=JPyNvPMIwCrkCRfC7AfOHa3V7KQSEuSbWu8g6CBWLw8=;
 b=MOyIY/BEWOFNm320NclDXHQ33Su52KU2+g2ANTdOYKVab0Zn6wnp4BULcmO3s1V2Y+
 o8vpgu9o8ZT+ubhPjeSR/J26HW53PMbKem1HaI8kTw1gMjZ6Ehl9Lys4d66A4Y/4OvDc
 dN59nHtfW7SPNGBtQ7pP4fb3WkPXX+Yy3OBdjs3IJDyKX3T2RgFJ9TLzqZHZe5pcpZTa
 vWVXldV/gMli5cX+UpgdJx1cweBMvPXyVLxp2fTcIPyqPfLyuAdHo2cDuzc/c1mZ8Lzy
 XHgls8Qx6Qv96ZdrEKEcUARTcoqj7GKV66bx5PW2ncwUkvClohtUeNdxsUAJhYxdPtPD
 oyXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806676; x=1788411476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a9ZArFkXlEH5mM1UKLIa6QRPl0lpAzd7IELtVjOWABI=;
 b=aJ+QbKYDUYPmrS4v1664+wvcy0qDFxXcW7bWes8Ljs6FvqLj84tAhWdzjbZP5Vl2E1
 cVRu4mZ+jWjwx6xSVg/Az3u43tgo6qHk8NdxP7+iBMRaMg3SiRKoVric/89csuKofXJh
 dt5wwjUbKnOD6Uc5EZDHqBYLHj2kh4NgZMzz3bC1gy99irL8c2xT0CrgQklu7AQkdWFm
 +tUWW8FpIVsGn1iC53mT0wi/6O4JuLAFIM11/Hq9urWxpa3PzeLwRRvwWB0EDjm8ktJZ
 DEBiMd8ril+I21iF2gBwfnvSVB4TvenyhsyYKLlN7miVm8iv5w68BCTIW8EVMwHnHaq0
 v7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806676; x=1788411476;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a9ZArFkXlEH5mM1UKLIa6QRPl0lpAzd7IELtVjOWABI=;
 b=nkDbwA1e+WN0NSdZFOZnORA3qCqnxb/msmx1Ht03KY3+RL04cvMIA2bOLptS6kqLK0
 7JB6rtahVX77dVUZqrX3My5mFGnOVcjZemSgLC1Hh39rmwzeEpUUV0wcb656IbkdmhoW
 NwJkLPGXcM42i2pgRtbVtCsvmtAtKmdYHk6OLa6N55+mX7Aa8sykN7oQr7DL/AxgJIqt
 j+wR97mR95k1eJ8atsKxr2sh3y+jh/A0fRlY4+/Rh9LZL6hAZ70m6zrlgiEjYL9N752J
 iKTtCSkxl2+06XZ37V4HkfN7AkQ9eyIPtVP0XtKi4XP0Gz4XJFAftqN5mQsvI55EmbnP
 /fpw==
X-Gm-Message-State: AFuF++mZsy/3ABenyV8fc3+2qb9j6287Uqm9bCUryiRkVYDLZyIpWrzw
 TzYVZ3s7qTRG6xqZxqR+FWGpZzr2PrR9tEmf98aXVenlKkD27Fpmw0H3CkfL/MoxdrgdUB88RfW
 +NBSog9bahuV92mAyY+KX22fhLKA7SVw=
X-Gm-Gg: AR+sD13Ln7p8IGlDeeThJbN1Q3LoRMuatBBjjDWJKVD1ETWcQPkui4zlPNc9ruSXbJ9
 TSUGD3siDv2BPQJn2kQWAoMzAKsXbitibYZnfpdx8H3XvnoEwJZK7u3Vd/r0A3xdBt8o3LBDioP
 ng/zibUM4XSPt6RtRoSY3pvXU1TSJsjw2c3j2LZMAQ/Ts2kWPmcyL1PGcKHdFp+17B/SJmjyIX8
 YCAmc1YIVugWPpj+cPFiu3Ypmq2jgQ4MBOZwi4SDa4zQ24SVCfLy/2y7VonhIyn7/0ETuUSGxD4
 bSBpP+HYSoKMAEcyyANUg+9epq5HLd9G9Yd7hojvonYoXG8=
X-Received: by 2002:a05:6512:31cf:b0:5b5:e0dd:1c6c with SMTP id
 2adb3069b0e04-5b5e0dd1cafmr220979e87.4.1787806675353; Wed, 26 Aug 2026
 21:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-2-mattst88@gmail.com>
 <8733w1qq7o.fsf@draig.linaro.org>
In-Reply-To: <8733w1qq7o.fsf@draig.linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 27 Aug 2026 00:57:41 -0400
X-Gm-Features: AcwNN1U-40l3YlNf_aSw7ai8DZ7IIU-rWWHJgjTOYfGQI0mbJaiOtlldDC90N8E
Message-ID: <CAEdQ38ExK8a5QKJR0shezbdwEJ88bQFtU_+sKxt2_61x9f9yMw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 philmd@oss.qualcomm.com, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x131.google.com
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

On Wed, Aug 26, 2026 at 3:46=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Matt Turner <mattst88@gmail.com> writes:
>
> > curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr=
()
> > and from the cpu_exec() loop. It recomputes the same value every time:
> >
> >     uint32_t cflags =3D cpu->tcg_cflags;
> >     if (unlikely(cpu_single_stepping(cpu))) { ... }
> >     else if (qatomic_read(&one_insn_per_tb)) { ... }
> >     else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }
> >
> > That is three loads and three branches on the hottest path in the
> > interpreter, for state that changes only when gdb enables single-step,
> > when one-insn-per-tb is toggled, or when the log mask changes.
> >
> > None of the three has to be sampled at dispatch time. Fold each into
> > CPUState::tcg_cflags where it changes and curr_cflags() becomes a singl=
e
> > load of a field that TB lookup has to read anyway.
> >
> > The derived bits -- CF_COUNT_MASK, CF_NO_GOTO_TB, CF_NO_GOTO_PTR and
> > CF_SINGLE_STEP -- are never set by tcg_cflags_set(), so tcg_update_cfla=
gs()
> > can recompute them in place without disturbing the rest, and conversely
> > tcg_cflags_set() ORs in its bits without disturbing them.
> >
> > There are three places to call it:
> >
> >   - tcg_exec_realizefn(), so that a CPU created after the command line =
has
> >     been parsed starts out with the right value. This covers user-only,
> >     where tcg_cpu_init_cflags() is not reached. linux-user's cpu_copy()
> >     copies tcg_cflags wholesale, so a cloned thread inherits it.
> >
> >   - cpu_single_step(), which changes one CPU and runs either on that CP=
U's
> >     thread or with it stopped.
> >
> >   - tcg_set_one_insn_per_tb() and qemu_set_log_internal(), which change
> >     every CPU. Both can be reached from the monitor while the vCPUs are
> >     running -- 'one-insn-per-tb on' and 'log nochain' -- so the update =
is
> >     queued with async_safe_run_on_cpu() and each CPU writes its own cfl=
ags
> >     with the others halted.
> >
> > Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> > the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, in =
a
> > build configured with --enable-lto:
> >
> >     before: 1,646,994,254,249 instructions
> >     after:  1,562,204,796,597 instructions   -5.15%
> >
> > That workload issues 8.4 billion dispatches, so the per-call saving is
> > small but the aggregate is not. The emulated compiler produces
> > byte-identical output before and after.
> >
> > Wall clock does not move: 133.19s to 132.58s, a 0.46% difference agains=
t a
> > run-to-run spread larger than that. The removed work is a few predictab=
le
> > loads and branches that the host executes largely in parallel with the
> > surrounding dispatch, so this patch is worth taking for the instruction
> > count and for what it enables, not for a time saving that can be measur=
ed
> > on its own.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> >  accel/tcg/cpu-exec-common.c | 33 ++++++++++++++++++++++++++++++---
> >  accel/tcg/cpu-exec.c        |  3 +++
> >  accel/tcg/internal-common.h | 11 +++++++++--
> >  accel/tcg/tcg-all.c         |  1 +
> >  cpu-target.c                |  3 +++
> >  include/system/tcg.h        | 12 ++++++++++++
> >  stubs/meson.build           |  1 +
> >  stubs/tcg-cflags.c          | 16 ++++++++++++++++
> >  util/log.c                  |  4 ++++
> >  9 files changed, 79 insertions(+), 5 deletions(-)
> >  create mode 100644 stubs/tcg-cflags.c
> >
> > diff --git ./accel/tcg/cpu-exec-common.c ./accel/tcg/cpu-exec-common.c
> > index 44e84344f3..dd2be475e2 100644
> > --- ./accel/tcg/cpu-exec-common.c
> > +++ ./accel/tcg/cpu-exec-common.c
> > @@ -36,9 +36,16 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags)
> >      cpu->tcg_cflags |=3D flags;
> >  }
> >
> > -uint32_t curr_cflags(CPUState *cpu)
> > +/*
> > + * The bits of CPUState::tcg_cflags that tcg_cflags_set() never sets, =
because
> > + * they are derived from gdb single-step, one-insn-per-tb and -d nocha=
in.
> > + */
> > +#define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | =
\
> > +                     CF_SINGLE_STEP)
> > +
> > +void tcg_update_cflags(CPUState *cpu)
> >  {
> > -    uint32_t cflags =3D cpu->tcg_cflags;
> > +    uint32_t cflags =3D cpu->tcg_cflags & ~CF_DERIVED;
> >
> >      /*
> >       * Record gdb single-step.  We should be exiting the TB by raising
> > @@ -55,7 +62,27 @@ uint32_t curr_cflags(CPUState *cpu)
> >          cflags |=3D CF_NO_GOTO_TB;
> >      }
> >
> > -    return cflags;
> > +    cpu->tcg_cflags =3D cflags;
> > +}
> > +
> > +static void tcg_update_cflags_work(CPUState *cpu, run_on_cpu_data data=
)
> > +{
> > +    tcg_update_cflags(cpu);
> > +}
> > +
> > +void tcg_update_all_cflags(void)
> > +{
> > +    CPUState *cpu;
> > +
> > +    /*
> > +     * one-insn-per-tb and -d nochain can both be changed from the mon=
itor
> > +     * while the vCPUs are running.  Have each CPU update its own cfla=
gs
> > +     * with the others halted, so that no dispatch can read a value th=
at
> > +     * another thread is in the middle of writing.
> > +     */
> > +    CPU_FOREACH(cpu) {
> > +        async_safe_run_on_cpu(cpu, tcg_update_cflags_work,
> > RUN_ON_CPU_NULL);
>
> I don't think this is wrong but are we really seeing cross-vCPU updates
> of cpu->cflags?

Fixed in v4. The monitor path was the cross-vCPU one -- v3 had the
monitor thread storing into every cpu->tcg_cflags -- and v4 queues the
update instead, so each vCPU writes its own field from its own thread.

The one foreign writer left is cpu_single_step(), and it's the same
one that was already there. gdb_continue_partial() in gdbstub/user.c
walks CPU_FOREACH and can hit a thread that's still running, since
gdb_handlesig() only parks the thread that trapped. But before this
patch, curr_cflags() on CPU X read X->singlestep_flags and
cpu_single_step() stored to it from whichever thread gdb was on. Now
the store lands in X->tcg_cflags. Same width, same plain accesses,
same writer, same reader -- the patch changes which field carries the
state, not how it's synchronized. Nothing here wants atomics that
didn't want them before.

I did fix the commit message, which claimed cpu_single_step() always
runs on the owning thread or with the CPU stopped. True in system
mode, not in the user-mode gdb_continue_partial() case.

> I suspect async_run_on_cpu would be enough to trigger an
> update from a non-vCPU thread to the vCPU.

Agreed, fixed in v4. async_safe_run_on_cpu() was overkill.

> You could even pass the sub-set of flags down in the user data and maybe
> avoid having to use global atomics for those flags.

I left this, but tell me if you'd rather have it. The only atomic is
qatomic_read(&one_insn_per_tb), and the patch already takes it off the
hot path -- it ran on every dispatch, now it runs at realize, at a gdb
step change, or on an HMP command. Passing a snapshot would remove
that last read, but one_insn_per_tb and qemu_loglevel are read by
other code too, so the queued CPU would be working from a snapshot
while everyone else sees the live global. For a path this cold that
seemed like the worse trade.

