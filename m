Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8AFC61DFD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Eep-0001tW-Pe; Mon, 31 Aug 2026 22:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1Eeo-0001pS-8P
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:55:30 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1Eem-0005MF-7a
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:55:30 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3a0faa764beso29250811fa.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 19:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788231325; cv=none;
 d=google.com; s=arc-20260327;
 b=KRof/ykuwC+F3jgNA4evEJyMEmYVdcpMHSaCrPdr27q8Hq8okGOeJZM9sgJATm02v/
 x9DDlTZpgT2NkPcxkPSgf7laMnfs4sTPs9bEFkic+Ub//FKwDTNMJvjsbhltNtvLKCLU
 2peiib5Osa5Z0lSabqoDFU7gO5BWUS+0mzX/pRRr6giFz5x0VBMm289WShMUxQEM25Su
 MNvhWT0ApJ4Nqe3Bxp26vARdUiZJRS6HxOD97WzqPb2p2Am4tO72hXmam6BrutPjZ652
 UgjG7pI9GuB0jwRH1AfhElgVtOxyuFNNSN/VPz/9gdPKwOJreabSdsIOutwStFjNQLqN
 HoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3BVne0iHEJBuJJBBcvikvYA+h1z4CGNmGqbLwbRctqI=;
 fh=QVe/7zv5OrYmrprO28ljpRmhYeOlvvTBoRQtHWn+3sI=;
 b=HJWNjksjdDgbKS0dJ6UlZyewM7I1x7ia4KRBONWrJBBwzqeD7ZghY81dbSOyRZbeZA
 qOr6n2GzyoQL7zWopcczyOm/SB5khMmTqg0BJf0j0k/jLJZB6eVTDx9hbCtpvYIvzGBX
 vPG2jFQ6IEr+/dy8pC8mOu5pANfjdEK//JPFWakd3EIBnRWNjOMwVdhIkIkCq9WX961k
 tJbT0NZW1tb8LJSHm8IcOsRh9/7v6OMIKkQYoGzRV+oLYHScyrItv3ztRoEypQ1DU5Fx
 DDwGCKby60wy/ZMeSBfc8giVtGQN8fkJQaO/j3Gh0QyIR5neENQdPC4pL4LEjsJVHTod
 8BrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788231325; x=1788836125; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3BVne0iHEJBuJJBBcvikvYA+h1z4CGNmGqbLwbRctqI=;
 b=QRMmgZoSIWLO/oFRnQQ/7GujjsaS7bZUYHdJigBIkAN2uNkxZqLxcVnqUESiXlIp5S
 kc0EASFNUN3SoRgAPtleZ6W3nNK87rb43PBM7PugdTJ0XuasVam2IfESEHBltinFekrR
 qTESpYGgkUTE8xFyzjHYEazE1FPC18/eAuP+c6ibQpeVWmDE5EA66rcUJr3iKEgwN+rR
 C4fQe95wFRdME2I2N184Cw9JzsDRq7BM3KsgSp7OpHEVhnU4IO5R5KaZRQZuK0Qcx7mH
 Uj8t1H0n41lTwkJyBVyzEiAsnG78+S4EmXnJlg4+YCtDWngCznoq3cyUEB0sJJJvLigG
 wuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788231325; x=1788836125;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3BVne0iHEJBuJJBBcvikvYA+h1z4CGNmGqbLwbRctqI=;
 b=ppyYYbKpBwxcj5lBkKOs43yKrCKBC/tVNr1vdNQ73S9rBdnjjhlH0o6n+y5pqZ7LGq
 esnsiTRRSeaq30w6sw7/USykAuaTWST+7uBZwxaovA0l3EHqF5IVMavybxFA4ODoFYIo
 uhKqEmBrV5ZDm2lmLIdim2tlxbNRE0hPsmO31LyZz6rGQjThbQdUzJipQWGpHJQ5pQAG
 XuFgzMm2I1w/8hteYOJzH24CFs9mje5h0+uHeV+fT/hYSyAuAm25akNXsTeqmPzW7c5C
 RhEGT4jIUfxNLEmXMbfrZ8PzF7000RGjPlpfV6wESeABSgw/ntrrHAyb0lNfA//PGLws
 dJRA==
X-Gm-Message-State: AFuF++l7EQwkBx/kZtLI4+403Yegmy5IVH2BOzPAfMOtH9w+NPin32Af
 1gI/2ty53lO+gvavDIHw1b8A9s+BSgTdSyoApbSDk7q6OAgsnxc/4ntTVo7LDJdpgXmn7tTuCbK
 bFJkX5Y3V3W4HU5kLagFaNg3ORaLS8cY=
X-Gm-Gg: AYBFou3u3rqWWA7gPe1i2mHvPUXSSjJZE6Nry9Fi3OM2loGdhPHFk8SgwcxwXcejsfQ
 jQUeSKEML5gRg/kfVOVV4nGRuUq6JsYYgdpofb7jPBd++rUZwe2EenSFntUfMR4YVFscufY6ZyH
 7HBB0NwbzPErRB32u5JVxMHmKxmc7EhqGSqbINmEK9Fo42c0zBeMxcGQdRGasQiDh4lIKY5688K
 y365wRBWQbigldDXdXQwLm1fFOJ6cUpxywTMq/D4Susmu6sz/3sqvp6TKAm7sq4qJjIiNNamkgl
 yFAwNE6VSFfYUzI/+aBshEQIt9BXadh01dVY1+wnMMdWoBo=
X-Received: by 2002:a2e:be0e:0:b0:39c:7d57:a3ae with SMTP id
 38308e7fff4ca-3a3393ebb67mr9785471fa.0.1788231324820; Mon, 31 Aug 2026
 19:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260827050241.3713332-6-mattst88@gmail.com>
 <0a19da5b-e50f-447e-9630-37f951cc94db@linaro.org>
In-Reply-To: <0a19da5b-e50f-447e-9630-37f951cc94db@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 31 Aug 2026 22:55:10 -0400
X-Gm-Features: AcwNN1W4hlb5qW19CnHnBGLg7qoD-hwjiEQglNXtZ48XUPBo8_5zRH_QtUivNQs
Message-ID: <CAEdQ38EOECXHejZbQLbgFS9+XkAhb0nMZWbAPF=5DJR01UgtNg@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] accel/tcg: give the TB jump cache a second base
 pointer for generated code
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@oss.qualcomm.com, 
 alex.bennee@linaro.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 27, 2026 at 4:03=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/26/26 22:02, Matt Turner wrote:
> > +/*
> > + * The inline jump cache probe reads cpu->tb_jmp_cache_probe and takes=
 the
> > + * slow path when the entry it finds has a NULL tb.  Pointing the prob=
e at a
> > + * region that is all zeroes therefore forces every indirect dispatch =
into
> > + * helper_lookup_tb_ptr(), which does the full lookup the inline probe=
 only
> > + * approximates.  The real jump cache is untouched, so no contents are=
 lost
> > + * and recovery is a single store.
> > + *
> > + * Only ever read from, and only one entry per dispatch, so one shared
> > + * zero-filled cache is enough for every CPU.  Not const: that would p=
ut a
> > + * megabyte of zeroes in .rodata and so in the binary, where .bss cost=
s
> > + * nothing on disk and only faults in the handful of pages a poisoned =
run
> > + * happens to probe.
> > + */
> > +static CPUJumpCache tb_jmp_cache_poison;
>
> Hmm.  Maybe we should mmap it at startup then, because while we're not
> supposed to be writing into this, it would be nice to enforce that.

Done, also in 8/9.  It's a page-aligned qemu_memalign() + mprotect at
startup instead of a .bss object, which also removes the "1MB never
written" note from that patch's RFC list.  I added qemu_mprotect_ro()
next to the existing _rw/_rwx/_none forms for it.  A stray store into
a page every vCPU dispatches through is worth trapping rather than
debugging.

> > +/*
> > + * Poison @cpu's probe, from any thread.  Called when a breakpoint is
> > + * inserted, which is what makes the poison take effect at the dispatc=
h
> > + * after the insert rather than whenever @cpu next reaches its main lo=
op:
> > + * a vCPU chaining indirectly need never reach it, and would run past =
a
> > + * breakpoint another thread had just set.
> > + *
> > + * A plain store is enough.  The value only ever costs a slow path tha=
t is
> > + * correct on its own, and the generated code re-reads the base on eve=
ry
> > + * dispatch.  Un-poisoning is tcg_cpu_sync_jmp_cache()'s job.
> > + */
> > +void tcg_cpu_poison_jmp_cache(CPUState *cpu)
> > +{
> > +    if (qatomic_read(&cpu->tb_jmp_cache_probe) !=3D NULL) {
> > +        qatomic_set(&cpu->tb_jmp_cache_probe, &tb_jmp_cache_poison);
> > +    }
> > +}
>
> Why do we need to check for NULL?

Fixed, see below.

> > +
> > +/*
> > + * Called from the main loop, which is the only context that can estab=
lish
> > + * that no reason to be poisoned is left.  Cheap enough to call every =
time
> > + * round: the common case is a load, a compare and no store at all.
> > + */
> > +void tcg_cpu_sync_jmp_cache(CPUState *cpu)
> > +{
> > +    CPUJumpCache *want;
> > +
> > +    if (qatomic_read(&cpu->tb_jmp_cache_probe) =3D=3D NULL) {
> > +        return;  /* not realized, or already unrealized */
> > +    }
>
> If this function is only called by the main loop, we shouldn't have to
> deal with either unrealized state.
>
> > +
> > +    want =3D tcg_cpu_may_dispatch(cpu)
> > +           ? cpu->tb_jmp_cache
> > +           : &tb_jmp_cache_poison;
> > +
> > +    if (qatomic_read(&cpu->tb_jmp_cache_probe) !=3D want) {
> > +        qatomic_set(&cpu->tb_jmp_cache_probe, want);
> > +
> > +        if (want =3D=3D cpu->tb_jmp_cache) {
> > +            /*
> > +             * Un-poisoning races a concurrent tcg_cpu_poison_jmp_cach=
e():
> > +             * the reason may have appeared after tcg_cpu_may_dispatch=
() read
> > +             * it, and the poison may have landed before the store abo=
ve.
> > +             * Order that store against the re-read below, so that the=
 race
> > +             * is lost in the safe direction.
> > +             */
> > +            smp_mb();
> > +            if (!tcg_cpu_may_dispatch(cpu)) {
> > +                tcg_cpu_poison_jmp_cache(cpu);
>
> Why do we need to check for breakpoints twice?
> I don't think I understand this race.

Fixed, see below.

> I'm not familiar with how gdbstub interacts with user threads, but this
> feels overly complicated.  Up to and including needing to poison the
> jump cache just for adding a breakpoint.
>
> I suspect what we need is to add a CF_NO_GOTO_JC flag that suppresses
> the inline jump cache, which is set whenever any breakpoint exists,
> which falls back to the helper, which checks for breakpoints.

You're right, and this is much better.  v5 replaces this patch with
"accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present".

What makes the cflag sufficient rather than merely convenient: the
inline probe already compares the destination TB's cflags against the
constant cflags of the block doing the dispatching, and only takes the
destination when they're equal.  So a block translated while a
breakpoint exists neither dispatches inline itself nor can be reached
by a block that does. tcg_update_cflags() sets the flag while
cpu->breakpoints is non-empty, and
cpu_breakpoint_insert()/cpu_breakpoint_remove_by_ref() call it -- the
only two places the list changes, both of which already run on the
CPU's own thread or with it stopped, or reach another CPU exactly the
way cpu_single_step() does.

That deletes the entire mechanism you were objecting to.  The
cross-thread poison from breakpoint insertion, the un-poison, and the
double breakpoint check are all gone, so the questions above mostly
answer themselves.

