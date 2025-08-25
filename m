Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F48CA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 15:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYjI-0002r6-UL; Mon, 25 Aug 2025 11:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqYjG-0002qM-TD
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 11:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqYjC-0005HI-TF
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 11:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756134201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uo+XruI8548gvlbgyudl9sYN+5f0IyR174ZzdauaxRg=;
 b=gJaEcjx6sxFGE7g08C2QS9t5Pz8auY4y1Ft+Pd0FtYqDjmguB9LZ12tbNjjLiKLSzW8HNO
 qZrH1lUOeVl6+JgBYpJzeS/DnCKeOMjWFogmq8D2oDJep7NcWRKDcjFxdwdevATkvIkxJw
 8vKDHK5TlVgT31qj0B0ljJJHy1JHGF0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Lr7q1Ez1Nn-LNbL4sR_qkQ-1; Mon, 25 Aug 2025 11:03:18 -0400
X-MC-Unique: Lr7q1Ez1Nn-LNbL4sR_qkQ-1
X-Mimecast-MFC-AGG-ID: Lr7q1Ez1Nn-LNbL4sR_qkQ_1756134197
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70d9eb2e971so57893576d6.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 08:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756134182; x=1756738982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uo+XruI8548gvlbgyudl9sYN+5f0IyR174ZzdauaxRg=;
 b=rwPgq+I+AkCC/qtcJc9lkm58dG1yC6s/I0y1DcRR4B/2EF40yUsOIrDuCbmBJD0LF8
 Cuq7F39IP2BS5APPbn6jSDlIYqwqDuCAvHL6m7PRvC8fR5gI/IV+STQBSe8pf/goOuKn
 LH+Rcr/1vwdEFnTa/vi/cXtfX3FYOAVTTN2w3n2eQgwgsR2FgdbQtLhsZfwmtrEvNFhr
 BHWrHWug4jL2YiIl73h0mOKe0Cw49zFyzBhQL6GzrDKprwDbSb4nDPLC3X27zS/0fT3M
 +Ewm2aT7mtxbQVY40zAEI5VaX+njK38BBjWADGmd1EaebEms6GztDWsLEN6Li27xTHZb
 uW4A==
X-Gm-Message-State: AOJu0YyKPu2DbqRo7a7O/XAxlJkyJo8n+Ys42fOyk6a2oAZhSB1w6R+t
 UfE3jWfonIF42DFuF21G1zig98elep7ezNYWY0dT2XZhvB8dzgqI8KRNrFc1ZVSNmuORDSdxZl2
 dRaLlDXpHZgsAUFOCh7L4omHZwXfMlXFhPObCV0AyZ/cC9c86lADumLIP
X-Gm-Gg: ASbGnct17xK8ad0IbQh9itoXW3Vu45oQmF7VsJhxuKZ+IYI2sLky0qMI9RKjM+o1XWz
 t7nrBClAvPoeXGyyCFPEL4tOFWjKVUS6xPoIeFnG85jKMcQtoMNSHdmB24fluroa5FOxNUkBMR0
 69qSFpzbJ6O38dwUCfntO+VrKOlXT4VdxSkkmAJ8mOdA0PJESwB38BQ4DfWU0zHmO190DeKvZHx
 HcYW8dd4jKx+S7ZqCRXEAhmZ0eZxvyvt4Te9/AuRuuXaFCOoYvIksfYaFYT4EgOCiDlMIAm9dvm
 KEltEzChYjQ1+NSubHaGGRrxJYu8bg==
X-Received: by 2002:ad4:5de9:0:b0:70d:ac6c:d5e with SMTP id
 6a1803df08f44-70dac6c152cmr85612426d6.17.1756134179954; 
 Mon, 25 Aug 2025 08:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv8eCrFNDO0lherB04MdWnrE7/si3AJQBQeeVWXJF6plrcPBMwu5wfSREvSOXxachUxzbc+w==
X-Received: by 2002:ad4:5de9:0:b0:70d:ac6c:d5e with SMTP id
 6a1803df08f44-70dac6c152cmr85610226d6.17.1756134177610; 
 Mon, 25 Aug 2025 08:02:57 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70da728659fsm46415946d6.39.2025.08.25.08.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 08:02:57 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:02:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 pbonzini@redhat.com, peterx@redhat.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, mtosatti@redhat.com,
 richard.henderson@linaro.org, riku.voipio@iki.fi, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, david@redhat.com,
 jjherne@linux.ibm.com, shorne@gmail.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, zhao1.liu@intel.com,
 peter.maydell@linaro.org, agraf@csgraf.de, mads@ynddal.dk,
 mrolnik@gmail.com, deller@gmx.de, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, reinoud@netbsd.org, sunilmut@microsoft.com,
 gaosong@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, arikalo@gmail.com,
 chenhuacai@kernel.org, npiggin@gmail.com, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, yoshinori.sato@nifty.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <20250825170249.3cdd315f@fedora>
In-Reply-To: <d585141a-07ab-479e-9d56-f58ecc4e7207@linaro.org>
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
 <d585141a-07ab-479e-9d56-f58ecc4e7207@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 25 Aug 2025 12:35:51 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Igor,
>=20
> On 21/8/25 17:56, Igor Mammedov wrote:
> > the helpers form load-acquire/store-release pair and use them to replace
> > open-coded checkers/setters consistently across the code, which
> > ensures that appropriate barriers are in place in case checks happen
> > outside of BQL.
>=20
> I don't understand the beginning of this sentence (even prepending
> the patch subject).

yep, it looks botched, how about following?

"
The helpers form load-acquire/store-release pair and ensure
that appropriate barriers are in place in case checks happen
outside of BQL.
Use them to replace open-coded checkers/setters across the code,
to make sure that barriers are not missed.
Helpers also make code a bit more readable.
"


>=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> > ---
> > v5: fix copy/paste error in doc comment of cpu_set_interrupt()
> >     "Jason J. Herne" <jjherne@linux.ibm.com>
> > v4:
> >     add cpu_set_interrupt() and merge helpers patch with
> >     patches that use them (v3 6-7,9/10).
> >         Peter Xu <peterx@redhat.com>
> > ---
> >   include/hw/core/cpu.h               | 25 +++++++++++++++++++++
> >   accel/tcg/cpu-exec.c                | 10 ++++-----
> >   accel/tcg/tcg-accel-ops.c           |  2 +-
> >   accel/tcg/user-exec.c               |  2 +-
> >   hw/intc/s390_flic.c                 |  2 +-
> >   hw/openrisc/cputimer.c              |  2 +-
> >   system/cpus.c                       |  2 +-
> >   target/alpha/cpu.c                  |  8 +++----
> >   target/arm/cpu.c                    | 20 ++++++++---------
> >   target/arm/helper.c                 | 18 +++++++--------
> >   target/arm/hvf/hvf.c                |  6 ++---
> >   target/avr/cpu.c                    |  2 +-
> >   target/hppa/cpu.c                   |  2 +-
> >   target/i386/hvf/hvf.c               |  4 ++--
> >   target/i386/hvf/x86hvf.c            | 21 +++++++++---------
> >   target/i386/kvm/kvm.c               | 34 ++++++++++++++---------------
> >   target/i386/nvmm/nvmm-all.c         | 24 ++++++++++----------
> >   target/i386/tcg/system/seg_helper.c |  2 +-
> >   target/i386/tcg/system/svm_helper.c |  2 +-
> >   target/i386/whpx/whpx-all.c         | 34 ++++++++++++++---------------
> >   target/loongarch/cpu.c              |  2 +-
> >   target/m68k/cpu.c                   |  2 +-
> >   target/microblaze/cpu.c             |  2 +-
> >   target/mips/cpu.c                   |  6 ++---
> >   target/mips/kvm.c                   |  2 +-
> >   target/openrisc/cpu.c               |  3 +--
> >   target/ppc/cpu_init.c               |  2 +-
> >   target/ppc/kvm.c                    |  2 +-
> >   target/rx/cpu.c                     |  3 +--
> >   target/rx/helper.c                  |  2 +-
> >   target/s390x/cpu-system.c           |  2 +-
> >   target/sh4/cpu.c                    |  2 +-
> >   target/sh4/helper.c                 |  2 +-
> >   target/sparc/cpu.c                  |  2 +-
> >   target/sparc/int64_helper.c         |  4 ++--
> >   35 files changed, 141 insertions(+), 119 deletions(-)
> >=20
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 5eaf41a566..1dee9d4c76 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -942,6 +942,31 @@ CPUState *cpu_by_arch_id(int64_t id);
> >  =20
> >   void cpu_interrupt(CPUState *cpu, int mask);
> >  =20
> > +/**
> > + * cpu_test_interrupt:
>  > + * @cpu: The CPU to check interrupt(s) on.> + * @mask: The  =20
> interrupts to check.
>=20
> Can we use plural form to express we might test for more
> than one interrupt in the mask?
>=20
>    -> cpu_test_interrupts() =20

it follow the same pattern as existing cpu_interrupt()/
generic_handle_interrupt() which take the same 'mask'
and cpu_handle_interrupt() that also handles a bunch of interrupts
and CPUState::interrupt_request also in singular form.

I don't have preference here but plural here would be
inconsistent with existing pattern all over QEMU and
it would be better to be consistent here.

>=20
> otherwise cpu_test_interrupt_mask().
>=20
> > + *
> > + * Checks if any of interrupts in @mask are pending on @cpu.
> > + */
> > +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> > +{
> > +    return qatomic_load_acquire(&cpu->interrupt_request) & mask; =20
> How missing "qemu/atomic.h" header.

it's included implicitly via "qemu/rcu_queue.h"

>=20
> > +}
> > +
> > +/**
> > + * cpu_set_interrupt:
> > + * @cpu: The CPU to set pending interrupt(s) on.
> > + * @mask: The interrupts to set. =20
>=20
> Rename plural: cpu_set_interrupts() or _mask().
>=20
> > + *
> > + * Sets interrupts in @mask as pending on @cpu.
> > + */
> > +static inline void cpu_set_interrupt(CPUState *cpu, int mask)
> > +{
> > +    qatomic_store_release(&cpu->interrupt_request,
> > +        cpu->interrupt_request | mask); =20
>=20
> (indent is off)

checkpatch was fine with it and it is (4+4) which is
within codestyle rules and the pattern widely used in QEMU.

>=20
> > +}
> > + =20
> The field is described in CPUState as:
>=20
>    @interrupt_request: Indicates a pending interrupt request.
>=20
> Can we update the description, mentioning its access should be
> via the proper cpu_test_interrupts/cpu_set_interrupts/... helpers?

I didn't do this because not all places are using helpers
and there are places which just wouldn't use them
(example: plain copy of the field).
I'd would leave this change out.


> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 713bdb2056..1269c2c6ba 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -778,7 +778,7 @@ static inline bool cpu_handle_interrupt(CPUState *c=
pu,
> >        */
> >       qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
> >  =20
> > -    if (unlikely(qatomic_read(&cpu->interrupt_request))) {
> > +    if (unlikely(cpu_test_interrupt(cpu, ~0))) { =20
>=20
> Maybe nitpicking, but I'd introduce the API and use it first only where
> we already use atomic accesses. Then convert the rest of the code base
> to this API in a distinct patch.

I thought so and it was this way before v4,
but I was asked to merge API and users in the same patch.
It's all depends on how many changes we are going to squash together.

>=20
> >           int interrupt_request;
> >           bql_lock();
> >           interrupt_request =3D cpu->interrupt_request;
> > @@ -786,7 +786,7 @@ static inline bool cpu_handle_interrupt(CPUState *c=
pu,
> >               /* Mask out external interrupts for this step. */
> >               interrupt_request &=3D ~CPU_INTERRUPT_SSTEP_MASK; =20
> >           }> -        if (interrupt_request & CPU_INTERRUPT_DEBUG) { =20
> > +        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
> >               cpu->interrupt_request &=3D ~CPU_INTERRUPT_DEBUG;
> >               cpu->exception_index =3D EXCP_DEBUG;
> >               bql_unlock();
> > @@ -795,7 +795,7 @@ static inline bool cpu_handle_interrupt(CPUState *c=
pu,
> >   #if !defined(CONFIG_USER_ONLY)
> >           if (replay_mode =3D=3D REPLAY_MODE_PLAY && !replay_has_interr=
upt()) {
> >               /* Do nothing */
> > -        } else if (interrupt_request & CPU_INTERRUPT_HALT) {
> > +        } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HALT)) {
> >               replay_interrupt();
> >               cpu->interrupt_request &=3D ~CPU_INTERRUPT_HALT; =20
>=20
> Can we have a cpu_clear_interrupts() helper for completion? Likely we
> need the same BQL-safe access.

see below

>=20
> >               cpu->halted =3D 1;
> > @@ -805,7 +805,7 @@ static inline bool cpu_handle_interrupt(CPUState *c=
pu,
> >           } else {
> >               const TCGCPUOps *tcg_ops =3D cpu->cc->tcg_ops;
> >  =20
> > -            if (interrupt_request & CPU_INTERRUPT_RESET) {
> > +            if (cpu_test_interrupt(cpu, CPU_INTERRUPT_RESET)) {
> >                   replay_interrupt();
> >                   tcg_ops->cpu_exec_reset(cpu);
> >                   bql_unlock();
> > @@ -841,7 +841,7 @@ static inline bool cpu_handle_interrupt(CPUState *c=
pu,
> >               interrupt_request =3D cpu->interrupt_request;
> >           }
> >   #endif /* !CONFIG_USER_ONLY */
> > -        if (interrupt_request & CPU_INTERRUPT_EXITTB) {
> > +        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
> >               cpu->interrupt_request &=3D ~CPU_INTERRUPT_EXITTB;
> >               /* ensure that no TB jump will be modified as
> >                  the program flow was changed */ =20
> Looking at v4 applied on top of v10.1.0-rc4 reconstructing patch
> #6 with v5:
>=20
> $ git grep -F -- '->interrupt_request'
>=20
> * Missing cpu_test_interrupts()
>=20
> target/arm/machine.c:968:        env->irq_line_state =3D=20
> cs->interrupt_request &

it's not a test but a bitmask copy in cpu_post_load()
where a barrier won't make a difference.
though for consistency sake we can introduce something like
 int cpu_get_interrupt(CPUState*)
that will use acquire, but that won't guarantee much as
copy might get stale after it's read.

> target/i386/helper.c:600:    int sipi =3D cs->interrupt_request &=20
> CPU_INTERRUPT_SIPI;

ditto

> target/i386/kvm/kvm.c:5067:            events.smi.pending =3D=20
> cs->interrupt_request & CPU_INTERRUPT_SMI;
> target/i386/kvm/kvm.c:5068:            events.smi.latched_init =3D=20
> cs->interrupt_request & CPU_INTERRUPT_INIT;

these indeed could use the helper

>=20
> * Possible uses of qatomic_load_acquire()?
>=20
> accel/tcg/cpu-exec.c:801:            int interrupt_request =3D=20
> cpu->interrupt_request;

for TCG interrupt processing seems to be under BQL, so it
shouldn't make a difference.

It might be a separate patch, but tit would be hard to come up
with justification for it.

But see 8/8, this line is moved closer to user and=20
cpu_handle_interrupt() is cleaned up.

> accel/tcg/tcg-accel-ops-icount.c:152:    int old_mask =3D=20
> cpu->interrupt_request;

another copy example, executed within cpu thread,
we don't really need acquire here and following
tcg_handle_interrupt->cpu_set_interrupt adds implicit one.

>=20
> * Candidates for cpu_clear_interrupts()

it wasn't goal of this series
(Paolo suggested to include cpu_interrupt()+cpu_test_interrupt()
test pair assuming it would be relatively small change, and here we are).

Also taking in account that setting interrupts are usually* done under BQL,
cpu_clear_interrupts() would be just a wrapper without a barrier.

and then we already have cpu_reset_interrupt() which should clear interrupt=
s,
taking BQL if needed.

Anyways it's quite involving refactoring, derailing series even further
from its scope.

If it's deemed necessary probably another series taking care of
interrupt clearing tree wide is in order. (but I'd prefer take care of
it separately of this series).


> accel/tcg/cpu-exec.c:784:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_DEBUG;
> accel/tcg/cpu-exec.c:794:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HALT;
> accel/tcg/cpu-exec.c:842:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_EXITTB;
> hw/core/cpu-common.c:79:    cpu->interrupt_request &=3D ~mask;
> hw/core/cpu-system.c:207:        cpu->interrupt_request &=3D ~0x01;
> target/avr/helper.c:50:            cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_RESET;
> target/avr/helper.c:62:                cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HARD;
> target/i386/helper.c:605:    cs->interrupt_request =3D sipi;
> target/i386/hvf/x86hvf.c:400:            cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_NMI;
> target/i386/hvf/x86hvf.c:412:        cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HARD;
> target/i386/hvf/x86hvf.c:440:        cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_POLL;
> target/i386/hvf/x86hvf.c:453:        cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_TPR;
> target/i386/kvm/kvm.c:5069:            cs->interrupt_request &=3D=20
> ~(CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);

* this one might be cleared outside of BQL
  (kvm_cpu_exec->kvm_arch_put_registers->kvm_put_vcpu_events path)

Paolo, Peter,
should we take BQL here, if not then why?
(kvm_arch_pre_run() that does run after it, does take BQL when resetting in=
terrupts)

> target/i386/kvm/kvm.c:5459:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_NMI;
> target/i386/kvm/kvm.c:5470:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_SMI;
> target/i386/kvm/kvm.c:5505:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HARD;
> target/i386/kvm/kvm.c:5600:        cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_MCE;
> target/i386/kvm/kvm.c:5630:        cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_POLL;
> target/i386/kvm/kvm.c:5643:        cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_TPR;
> target/i386/nvmm/nvmm-all.c:422:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_NMI;
> target/i386/nvmm/nvmm-all.c:431:            cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HARD;
> target/i386/nvmm/nvmm-all.c:440:        cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_SMI;
> target/i386/nvmm/nvmm-all.c:700:        cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_POLL;
> target/i386/nvmm/nvmm-all.c:713:        cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_TPR;
> target/i386/tcg/system/seg_helper.c:181:        cs->interrupt_request &=
=3D=20
> ~CPU_INTERRUPT_POLL;
> target/i386/tcg/system/seg_helper.c:189:        cs->interrupt_request &=
=3D=20
> ~CPU_INTERRUPT_SMI;
> target/i386/tcg/system/seg_helper.c:194:        cs->interrupt_request &=
=3D=20
> ~CPU_INTERRUPT_NMI;
> target/i386/tcg/system/seg_helper.c:199:        cs->interrupt_request &=
=3D=20
> ~CPU_INTERRUPT_MCE;
> target/i386/tcg/system/seg_helper.c:204:        cs->interrupt_request &=
=3D=20
> ~(CPU_INTERRUPT_HARD |
> target/i386/tcg/system/seg_helper.c:218:        cs->interrupt_request &=
=3D=20
> ~CPU_INTERRUPT_VIRQ;

> target/i386/tcg/system/svm_helper.c:827:    cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_VIRQ;

I had a question wrt this one, in one of previous versions,
it's buried deep in opcode handling, and hard to tell if this one is
BQL protected or not. Perhaps someone more familiar with TCG can clarify
if it's safe as it is now.

for comparison target/openrisc/sys_helper.c: HELPER(mtspr) does take BQL ex=
plicitly

> target/i386/whpx/whpx-all.c:1474:            cpu->interrupt_request &=3D=
=20
> ~CPU_INTERRUPT_NMI;
> target/i386/whpx/whpx-all.c:1481:            cpu->interrupt_request &=3D=
=20
> ~CPU_INTERRUPT_SMI;
> target/i386/whpx/whpx-all.c:1505:                cpu->interrupt_request=20
> &=3D ~CPU_INTERRUPT_HARD;
> target/i386/whpx/whpx-all.c:1523:        cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HARD;
> target/i386/whpx/whpx-all.c:1610:        cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_POLL;
> target/i386/whpx/whpx-all.c:1626:        cpu->interrupt_request &=3D=20
> ~CPU_INTERRUPT_TPR;
> target/openrisc/sys_helper.c:199:                cs->interrupt_request=20
> &=3D ~CPU_INTERRUPT_TIMER;
> target/rx/helper.c:66:            cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_FIR;
> target/rx/helper.c:76:            cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HARD;
> target/s390x/tcg/excp_helper.c:562:        cs->interrupt_request &=3D=20
> ~CPU_INTERRUPT_HARD;
>=20


