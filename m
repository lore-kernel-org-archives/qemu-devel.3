Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE07C531F8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 03:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtGn3-0005Es-94; Thu, 19 Feb 2026 22:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vtGn2-0005EW-8b
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 22:02:48 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vtGmz-0002NJ-QU
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 22:02:48 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12732165d1eso1916677c88.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 19:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771556564; x=1772161364; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QXHvGCPMR5Qk7bz9vRV445xL5KVRDg7+LrA3vNLDxfc=;
 b=KI3t7OkWA3BK2aAZpSQUNZl0XlXkgZJ8/HlztaG/JDpNsWfyouKZJXYh1FFfrSvsoq
 sFt9M8R+56f8qlLHZbghohlz5cfyymkakFAjWiL1N6JVDzKhfOx2s5VZAmW+vmMl5XiE
 Er5xAv9p4OttrIeCmUTsYylkcNS4T95AN/QwjEMMYl0aoyoMr9K7tSif+2cCfCB5AJDv
 t5oudIUxLv6XjVBUjZUcUlsOj9WQKGxaJTbNdu1Xde74gR/P6uffqB21yvKhgTUylnEc
 TivXyqOLj66yz7feJ1sFX4SzskQdHE05rfRzbjVHT+74CWq+QP5qeMTnpOSLC92QohUX
 RosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771556564; x=1772161364;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXHvGCPMR5Qk7bz9vRV445xL5KVRDg7+LrA3vNLDxfc=;
 b=L+HUmLX1FNvy2Ism6Vep393q4+HCtbcBynVuyqKq5DaxDIJei+sygUoqFLFU8AVK6O
 d4wV+/qI0o3zuVJfW0R5Bl6HlM8IwQdB4ctjrg+l40b121SIUel1zXiLsnlyluELMf7k
 0ZCJ2pOCSVZnQLYGJNfbPm3jaDtN7+AW2yBmheaAU3zPjGWOtsURSKDLUT3Z4RI8+pYQ
 sNSN+y2+7QKNd4m1hjeQSUBtrte/6G2KQXbql01Q9SwqZSQtbXRv2A9cioEDo8rD2xAM
 Tzez+FjMGhDm+3PgD/n8RGckSaL9Wsupe/Wu1H07iqU3dzEV+Gey7XNCviJ/kCqMua6n
 +RDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5qJLVfHI24YB6Kxu+EFU2nkob76+FalGhy5cQsvXFp8Gd5p6Qg18Ouqf2Tpp/7I3asNQ4vzpk859Y@nongnu.org
X-Gm-Message-State: AOJu0YxFUQTa/uHTj9gRnXzgQsHffE1pOIQ0Fzs3C1M3aj83j2qCLxOn
 vYcBnWnQL1wou5O+FtZ0F0kf4FZPIy63qYR/ACUTNSyjIYObKjLu4qMD
X-Gm-Gg: AZuq6aIpGyPyNHhrzeHhUaaBnY1kP+AxYOVeIew5aSrOe8NPa+e1XszXsPfIrea98uH
 Sid8rBDvVb5d2pCOjdpi/9R/RZ8R2Qa0dPwIJDw7stvQqB/jDjQ42gv4Su95ztqP+auSKHfdJ0m
 2hUSa/zrLXERXKnMZHM8YnSh2LbUWvD2dRLMW0QDaRkbEU34byQxx30qvn59LnxYmCX6RV/3SUy
 ftJP74rojrvlBbtox+zgeleAmGbbrEC9PGMV4ai6ay/ddz2/ku1A2+PiozHrpc0MvjclhHLiKPa
 8sEq/HiAdyJRanb6iv7SsQHgsjHT4HpPamrL0XAYwQz806/SQq0BmHR4YnwygILy0XRV3z85Dzu
 JdH44XWikOeRmSfg2UGiUUXC/lPkPz7WgjR6w3i0eG872wLDDc7fYASXQj+ps71X5OHxGNQ648V
 G3DDOcfJXXZBBHpt2c0x6Pwg3t46k8+aAtcNA8w+KZdi+2ZvlShuOuPAhVSs4bfQ+sL2SQCNKCu
 Fa1aaCo3/QicW492d/DSWLGUNJUxLk=
X-Received: by 2002:a05:7022:68a7:b0:119:e56b:98b1 with SMTP id
 a92af1059eb24-12759a60af4mr3740592c88.24.1771556563799; 
 Thu, 19 Feb 2026 19:02:43 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12742c6430asm25019049c88.6.2026.02.19.19.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 19:02:43 -0800 (PST)
Date: Fri, 20 Feb 2026 11:02:07 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
Message-ID: <aZe91c9A8bqKSG31@ZEVORN-PC.localdomain>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
 <385d1a8e-c202-4d72-a24a-1e49478278b4@yodel.dev>
 <28c7b18c-c998-4392-a1f2-9b287d7545c5@linaro.org>
 <CAFEAcA9Aha1TtTZZuCONmPP+baRxr=VE49mFk4zXwvM9O4p8gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9Aha1TtTZZuCONmPP+baRxr=VE49mFk4zXwvM9O4p8gQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Peter,

On Wed, Feb 18, 2026 at 04:47:50PM +0000, Peter Maydell wrote:
> On Tue, 17 Feb 2026 at 21:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > On 17/2/26 20:12, Yodel Eldar wrote:
> > > +Philippe
> > >
> > > Hi,
> > >
> > > On 17/02/2026 03:21, Peter Maydell wrote:
> > >> On Tue, 17 Feb 2026 at 06:35, Akihiko Odaki
> > >> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> > >>>
> > >>> alpha_cpu_realizefn() did not properly call cpu_reset(), which
> > >>> corrupted icount. Add the missing function call to fix icount.
> > >>>
> > >>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > >>> ---
> > >
> > > So, the real culprit was hiding in plain sight in Alpha-specific code
> > > all along? Congrats on finding it!
> > >
> > >>>   target/alpha/cpu.c | 1 +
> > >>>   1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> > >>> index 1780db7d1e29..74281ebdb367 100644
> > >>> --- a/target/alpha/cpu.c
> > >>> +++ b/target/alpha/cpu.c
> > >>> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev,
> > >>> Error **errp)
> > >>>       }
> > >>>
> > >>>       qemu_init_vcpu(cs);
> > >>> +    cpu_reset(cs);
> > >>>
> > >>>       acc->parent_realize(dev, errp);
> > >>>   }
> > >>
> > >> Realize functions shouldn't call reset on themselves.
> > >> For CPU objects it is currently the responsibility of the
> > >> board code to arrange that the CPU objects get reset.
> 
> > > I think the following addresses Peter's remarks; it passed 100
> > > repetitions of the Alpha replay test after reapplying the reverted
> > > commit:
> > >
> > > diff --git hw/alpha/dp264.c hw/alpha/dp264.c
> > > index 5e64528431..091ffc0085 100644
> > > --- hw/alpha/dp264.c
> > > +++ hw/alpha/dp264.c
> > > @@ -68,5 +68,7 @@ static void clipper_init(MachineState *machine)
> > >       memset(cpus, 0, sizeof(cpus));
> > >       for (i = 0; i < smp_cpus; ++i) {
> > > -        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
> > > +        CPUState *cpu = cpu_create(machine->cpu_type);
> > > +        cpu_reset(cpu);
> > > +        cpus[i] = ALPHA_CPU(cpu);
> >
> > Hmm this pattern is used a lot (creating CPUs in board_init without
> > manually calling cpu_reset). If this is the simplest fix, maybe
> > we could add a cpu_create_resetted() helper and use it where
> > appropriate (i.e. not where qemu_register_reset is then called).
> 
> Resetting the CPU either in realize or else in the machine
> after create causes it to get reset once on startup. But
> it doesn't do anything to cause it to be reset when the
> user (or the guest) triggers a system reset. If the board
> arranges for the CPUs to be reset during system reset then
> that also works for the initial startup case.
> 
> Reset is unfortunately a bit of a mess: I have periodically
> thought about it but still don't have an overview of what
> exactly it ought to be doing, let alone a plan (e.g. should

I'm quite interested in the CPU reset flow, so I tried to analyze the
related code across all architectures and organized my findings below.


== Current CPU Reset Strategies ==

There are essentially five different patterns in use now:

  Strategy | Who does it        | Initial | System  | Example
  ---------+--------------------+---------+---------+------------------------
  A        | realize only       | Yes     | No (*)  | x86
           |                    |         |         |
  ---------+--------------------+---------+---------+------------------------
  B        | realize + board    | Yes x2  | Yes     | RISC-V, ARM, OpenRISC
           | (simple wrapper)   |         |         |
  ---------+--------------------+---------+---------+------------------------
  C        | board only         | Yes     | Yes     | PPC, MIPS, SPARC, M68K,
           | (custom logic)     |         |         | SH4, Xtensa, Microblaze
  ---------+--------------------+---------+---------+------------------------
  D        | nobody             | No      | No      | Alpha (bug)
           |                    |         |         |
  ---------+--------------------+---------+---------+------------------------
  E        | board (SoC child   | Yes     | Yes     | MIPS CPS
           | on qbus tree)      |         |         |
  ---------+--------------------+---------+---------+------------------------

    (*) x86 gets away with this because the reset vector is architecturally
        fixed at 0xFFFFFFF0 and does not need board-level PC setup.

The root cause of this inconsistency is that cpu_create() calls
qdev_realize(dev, NULL, ...) with a NULL bus, so CPUs are not part of
the qbus tree. The only thing registered into the root reset container
in qemu_machine_creation_done() is sysbus_get_default():

```
  /* hw/core/machine.c */
  qemu_register_resettable(OBJECT(sysbus_get_default()));
```

The comment right above it says it all:

  "Note that this will *not* reset any Device objects
   which are not attached to some part of the qbus tree."

This means every board must independently arrange for CPU reset, and
as Alpha demonstrates, it is easy to forget.


== Per-Architecture Details ==


--- Strategy A: realize-only reset (x86) ---

x86_cpu_realizefn() calls cpu_reset() at the end of realize:

```
  /* target/i386/cpu.c */
  cpu_reset(cs);
  xcc->parent_realize(dev, &local_err);
```

But the board code in hw/i386/x86-common.c:x86_cpus_init() does NOT
register any qemu_register_reset() callback for CPUs. The CPU is
created with qdev_realize(DEVICE(cpu), NULL, errp) and is not on any
bus.

x86 has its own x86_cpu_reset_hold() (target/i386/cpu.c) which
correctly resets all architectural state including segment registers,
CR0, etc. But since the CPU object is not in the reset container,
this method would not be called during qemu_system_reset() through
the resettable framework alone.

x86 "works" because:
  1. The reset vector is hardwired (no board PC setup needed)
  2. KVM may handle reset internally for KVM-accelerated guests
  3. The firmware (SeaBIOS/OVMF) handles warm reboot via the
     keyboard controller reset mechanism


--- Strategy B: realize + board simple wrapper (RISC-V, ARM, OpenRISC) ---

These targets call cpu_reset() in their realize function AND the board
registers a qemu_register_reset() callback that also calls cpu_reset().
This results in the CPU being reset twice at startup.

RISC-V example:

```
  /* target/riscv/cpu.c - in riscv_cpu_realize() */
  qemu_init_vcpu(cs);
  cpu_reset(cs);                    /* first reset */

  /* hw/riscv/riscv_hart.c - board callback */
  static void riscv_harts_cpu_reset(void *opaque)
  {
      RISCVCPU *cpu = opaque;
      cpu_reset(CPU(cpu)); /* second reset (at startup + system reset) */
  }

  /* hw/riscv/riscv_hart.c */
  qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
  return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
```

Note the ordering:

qemu_register_reset() is called BEFORE qdev_realize(). So the
sequence at startup is:
  1. qdev_realize() -> riscv_cpu_realize() -> cpu_reset() [first]
  2. qemu_machine_creation_done() -> qemu_system_reset()
     -> LegacyReset callback -> cpu_reset()               [second]

The board callback here is a pure wrapper with no extra logic, so the
double reset is harmless but wasteful(we can use gdb to make sure).

ARM is similar but the board callback has substantial custom logic
(see Strategy C below). The realize-time cpu_reset() at
target/arm/cpu.c is redundant with the one in do_cpu_reset().

OpenRISC (target/openrisc/cpu.c) also calls cpu_reset() in
realize, and boards like hw/openrisc/openrisc_sim.c register
qemu_register_reset() with a simple wrapper.


--- Strategy C: board-only with custom post-reset logic (PPC, MIPS...) ---

These boards register qemu_register_reset() callbacks that first call
cpu_reset() and then apply board-specific state (PC, registers, TLB).

MIPS Malta (hw/mips/malta.c):

```
  static void main_cpu_reset(void *opaque)
  {
      MIPSCPU *cpu = opaque;
      CPUMIPSState *env = &cpu->env;

      cpu_reset(CPU(cpu));

      /* Clear ERL bit when booting a kernel */
      if (loaderparams.kernel_filename) {
          env->CP0_Status &= ~(1 << CP0St_ERL);
      }
  }
```

PPC e500 (hw/ppc/e500.c) - distinguishes primary/secondary:

```
  static void ppce500_cpu_reset(void *opaque)       /* primary */
  {
      /* ... */
      cpu_reset(cs);
      cs->halted = 0;
      env->gpr[1] = (16 * MiB) - 8;
      env->gpr[3] = bi->dt_base;    /* device tree address */
      /* ... sets up TLB mappings ... */
  }

  static void ppce500_cpu_reset_sec(void *opaque)   /* secondary */
  {
      cpu_reset(cs);
      cs->exception_index = EXCP_HLT;  /* halt until kicked */
  }

  /* Registration distinguishes primary vs secondary */
  if (!i) {
      qemu_register_reset(ppce500_cpu_reset, cpu);
  } else {
      qemu_register_reset(ppce500_cpu_reset_sec, cpu);
  }
```

SPARC sun4m (hw/sparc/sun4m.c) and about 30 other board
files across PPC, M68K, SH4, Xtensa, Microblaze, and OpenRISC
follow the same general pattern with varying amounts of custom
post-reset logic.

PS:

In this case, we can also talk about ARM.

ARM boot (hw/arm/boot.c) - the most complex case:

```
  static void do_cpu_reset(void *opaque)
  {
      ARMCPU *cpu = opaque;
      /* ... */
      cpu_reset(cs);
      if (info) {
          if (!info->is_linux) {
              /* Set endianness, jump to entry */
              cpu_set_pc(cs, info->entry);
          } else {
              /* Emulate firmware: set EL, configure SCTLR, ... */
              arm_emulate_firmware_reset(cs, target_el);
              if (cpu == info->primary_cpu) {
                  cpu_set_pc(cs, info->loader_start);
              } else if (info->secondary_cpu_reset_hook) {
                  info->secondary_cpu_reset_hook(cpu, info);
              }
          }
      }
  }
```

ARM boards don't call qemu_register_reset() directly. Instead,
arm_load_kernel() (hw/arm/boot.c) registers do_cpu_reset for
all CPUs in a loop:

```
  for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
      qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
  }
```


--- Strategy D: no reset at all (Alpha - BUG) ---

Alpha is the only architecture that neither calls cpu_reset() in
realize nor registers a qemu_register_reset() callback:

```
  /* target/alpha/cpu.c */
  static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
  {
      /* ... */
      cpu_exec_realizefn(cs, &local_err);
      /* ... */
      qemu_init_vcpu(cs);
      /* NO cpu_reset(cs) here! */
      acc->parent_realize(dev, errp);
  }

  /* hw/alpha/dp264.c */
  for (i = 0; i < smp_cpus; ++i) {
      cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
      /* NO qemu_register_reset() */
  }

  /* Later, board directly pokes env fields: */
  cpus[i]->env.pc = palcode_entry;
  cpus[i]->env.palbr = palcode_entry;
```

Alpha also has no target-specific reset_hold method -
alpha_cpu_class_init() does not set rc->phases.hold, so it relies
entirely on the parent cpu_common_reset_hold(). But since the CPU
is not in the reset container, even that never runs during system
reset.

This is the bug that corrupted icount, as Akihiko's patch identified.


--- Strategy E: SoC container on qbus tree (MIPS CPS) ---

Some SoC-level container devices create CPUs as child objects:

```
  /* hw/mips/cps.c */
  static void mips_cps_realize(DeviceState *dev, Error **errp)
  {
      for (i = 0; i < s->num_vp; i++) {
          cpu = MIPS_CPU(object_new(s->cpu_type));
          qdev_realize_and_unref(DEVICE(cpu), NULL, errp);
          qemu_register_reset(main_cpu_reset, s->cpus[i]);
      }
  }
```

Even here, the CPU itself is realized with a NULL bus, so it still
needs the explicit qemu_register_reset() call.


== The Core Problem ==

cpu_create() and most board code call qdev_realize(dev, NULL, ...)
for CPUs, placing them outside the qbus tree. The comment in
hw/core/cpu-common.c acknowledges this:

```
  /*
   * Reason: CPUs still need special care by board code: wiring up
   * IRQs, adding reset handlers, halting non-first CPUs, ...
   */
  dc->user_creatable = false;
```

The "adding reset handlers" part is exactly what is inconsistently
done across the codebase.


===

As the analysis above shows, the current CPU reset situation is indeed
quite messy -- multi different strategies across the codebase, with at
least one outright bug (Alpha) and several cases of redundant double
resets.

I think Peter's ideas about rethinking the reset infrastructure
are well worth pursuing. Whether that means cascading reset via the QOM
tree, or a separate reset infrastructure that defaults to the QOM tree
but allows SoC-level overrides, having a single consistent mechanism
would eliminate this entire class of "forgot to register CPU reset"
bugs.

The tricky part, as Peter noted, is getting from here to there
without breaking things or starting yet another never-completed API
transition.

If there is interest in moving forward with refactoring this area,
I'd be happy to help contribute patches or review work. :)


Thanks,
Chao

> we cascade reset via the QOM tree? or do we need a separate
> reset infrastructure that defaults to the QOM tree but that
> SoC objects can override if they have more complex reset
> requirements? How does this interact with bus-reset (which is
> definitely a thing for some buses? And once we've decided what
> we want, how do we get from where we are right now to there
> without breaking things and ideally without having another
> of the long-drawn-out never-completed API transitions we're so
> good at?)
> 
> thanks
> -- PMM
> 

