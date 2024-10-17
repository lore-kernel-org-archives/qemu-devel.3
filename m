Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41EED374A9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SYP-0000V9-Fw; Thu, 17 Oct 2024 11:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t1SYN-0000Uu-Oy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:36:43 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t1SYL-0003s3-TI
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:36:43 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e5ef9e795bso758374b6e.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729179401; x=1729784201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70MDM0b8JZoh5VvNLZas1irY3W5GpOYSEWGddoeseow=;
 b=VFoZZMmSdk6HksiI1ND7qYQqrUXuUzlGBcTBso4qSC19Aqb/64jiKkzdBMTEpcVZ3W
 n0hRpIFr5VbE46kAZg7TtoXIieqjgyYsUMS6fFKTF1nn06D7Yj+AX1jkl7tlxyzRef49
 YD9DiWJ83dJNrMUX600fQPo4nT5l+R+peJs8BtnXwomyAa3qFl4obK1Jrn2EaBhGVvQp
 K4fw5EjuRm2/LjlHQUhIs1GCGV3V+bhpGfYrr3E4jbHjgJ2/5Moze3rpkEf3Wag+jK5W
 C2P6KrVFL3A8ajn81fBLffbORRgB0A5CiCGQwmyXVudHvnL5QVwRdE7f+LpE979Sr+ig
 7Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729179401; x=1729784201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70MDM0b8JZoh5VvNLZas1irY3W5GpOYSEWGddoeseow=;
 b=B42HIINIxFNi9L1Mv7lW7dk3pvoELli7Wq9rKXHfykmBe4BtJRfN1iFfyThb2N68x8
 ZhhXKYFOrtsUn+sXW9X6e8Tvg+XhcaPRT84/OsHvZr5m3C4o99RRABLtWr+bCPWnbXVR
 pMnvbbVlOtq6IFRNBKH1g/EwEwXLjSE4xKL0JuZhmU2IE0Z35t2INIb1CqNyvz6sIoi4
 ltncnvz5RlWGN3lZYHABr+CWIvM8RNqnctI7jrNWnSNiw3BI6+9IamPwRO2ES74R5WU0
 ZYK+hGf+oHx4yViCOCDAz0YFWsWCppEM9zzGAf6pCu5dmHkPnjlLAM7LtVlOVlXJWsXH
 vFGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2jlP+9fBxXcf15FVpIcOCd/90m5tETVkOPDEADjqlG/n/bnf44aUy2dQSEmYTc8ZgLVdOUdYGPaZU@nongnu.org
X-Gm-Message-State: AOJu0YxXI0XDe/o/7/2qFofl5H5tcGOWu53F2dR4cdvqQtI5+tq0pYhr
 tMi/nMIPpYN7ANATPvVRjIOcuEvLGXfVQ8/XCFC/2MADJ7n229Enmtg4bpWFcC8TZYXwAZqNWyZ
 x/7MIKNR57v5CLnH337LeU+R7uPh6jUql0q4a
X-Google-Smtp-Source: AGHT+IEA/GasKLT+fj/EEM+uA5c4Bt8Nls5NlGp99tY1sv1+CxZE2qJHVaYDA9VnExZcB2izlwN7L9RcxlI/yefwDW8=
X-Received: by 2002:a05:6808:3c44:b0:3e5:f35b:5f9f with SMTP id
 5614622812f47-3e5f35b5fc1mr6236835b6e.11.1729179400392; Thu, 17 Oct 2024
 08:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240906225451.1039718-1-roqueh@google.com>
 <20240906225451.1039718-3-roqueh@google.com>
 <87set8w75d.fsf@draig.linaro.org>
In-Reply-To: <87set8w75d.fsf@draig.linaro.org>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Thu, 17 Oct 2024 08:36:28 -0700
Message-ID: <CAKbPEtbL0_h_CmkrxjYAa_YX_YqNJfOLo1oR9E3O-LDJw7pQRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gdbstub: Apply breakpoints only to the selected PID
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@linaro.org, 
 slongfield@google.com, komlodi@google.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=roqueh@google.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

I'm reimplementing this in a new patchset with a new function
gdb_cpu_in_source_group instead of making public the PID and
multiptocess functions.

On Mon, Oct 7, 2024 at 3:15=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> Roque Arcudia Hernandez <roqueh@google.com> writes:
>
> > In the context of using the remote gdb with multiple
> > processes/inferiors (multi cluster machine) a given breakpoint will
> > target an specific inferior. Current implementation of
> > tcg_insert_breakpoint and tcg_remove_breakpoint apply a given
> > breakpoint to all the cpus available in the system.
>
> OK I can see this needs fixing.
>
> > Only the CPUs associated with the selected process ID should insert
> > or remove the breakpoint. It is important to apply it to all the CPUs
> > in the process ID regardless of the particular thread selected by the
> > 'Hg' packet because even in the case of a thread specific breakpoint.
> > A breakpoint on a specific thread is treated as a conditional break
> > similar to a 'break if'. This can be read in the code and comments of
> > function bpstat_check_breakpoint_conditions in the file
> > gdb/breakpoint.c
> >
> > /* For breakpoints that are currently marked as telling gdb to stop,
> >    check conditions (condition proper, frame, thread and ignore count)
> >    of breakpoint referred to by BS.  If we should not stop for this
> >    breakpoint, set BS->stop to 0.  */
> >
> > static void
> > bpstat_check_breakpoint_conditions (bpstat *bs, thread_info *thread)
> >
> > The patch needs to expose the currently private function
> > gdb_get_cpu_pid to the TCG and also expose the value of
> > gdbserver_state.multiprocess. The PID filtering will only be
> > applicable to multiprocess gdb because the PIDs are only defined in
> > that context.
>
> I don't like exposing those private functions, especially as the PID
> terminology is confusing. Could we not keep all the logic in the gdbstub
> itself so the tests become something like:
>
>     case GDB_BREAKPOINT_SW:
>     case GDB_BREAKPOINT_HW:
>         CPU_FOREACH(cpu) {
>             if (gdb_cpu_in_source_group(cs, cpu)) {
>                 err =3D cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
>                 if (err) {
>                     break;
>                 }
>             }
>         }
>         return err;
>
> ?
>
> Ilya has also posted a large series for non-stop mode on *-user guests
> which is on my review queue which I would want to check doesn't conflict
> with this:
>
>   Message-ID: <20240923162208.90745-1-iii@linux.ibm.com>
>   Date: Mon, 23 Sep 2024 18:12:55 +0200
>   Subject: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
>   From: Ilya Leoshkevich <iii@linux.ibm.com>
>
> >
> > Google-Bug-Id: 355027002
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > ---
> >  accel/tcg/tcg-accel-ops.c | 15 +++++++++++++++
> >  gdbstub/gdbstub.c         |  7 ++++++-
> >  include/exec/gdbstub.h    | 15 +++++++++++++++
> >  3 files changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> > index 3c19e68a79..557091c15e 100644
> > --- a/accel/tcg/tcg-accel-ops.c
> > +++ b/accel/tcg/tcg-accel-ops.c
> > @@ -33,6 +33,7 @@
> >  #include "qemu/guest-random.h"
> >  #include "qemu/timer.h"
> >  #include "exec/exec-all.h"
> > +#include "exec/gdbstub.h"
> >  #include "exec/hwaddr.h"
> >  #include "exec/tb-flush.h"
> >  #include "gdbstub/enums.h"
> > @@ -132,11 +133,15 @@ static int tcg_insert_breakpoint(CPUState *cs, in=
t type, vaddr addr, vaddr len)
> >  {
> >      CPUState *cpu;
> >      int err =3D 0;
> > +    bool match_pid =3D gdb_is_multiprocess();
> >
> >      switch (type) {
> >      case GDB_BREAKPOINT_SW:
> >      case GDB_BREAKPOINT_HW:
> >          CPU_FOREACH(cpu) {
> > +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid=
(cs)) {
> > +                continue;
> > +            }
> >              err =3D cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
> >              if (err) {
> >                  break;
> > @@ -147,6 +152,9 @@ static int tcg_insert_breakpoint(CPUState *cs, int =
type, vaddr addr, vaddr len)
> >      case GDB_WATCHPOINT_READ:
> >      case GDB_WATCHPOINT_ACCESS:
> >          CPU_FOREACH(cpu) {
> > +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid=
(cs)) {
> > +                continue;
> > +            }
> >              err =3D cpu_watchpoint_insert(cpu, addr, len,
> >                                          xlat_gdb_type(cpu, type), NULL=
);
> >              if (err) {
> > @@ -163,11 +171,15 @@ static int tcg_remove_breakpoint(CPUState *cs, in=
t type, vaddr addr, vaddr len)
> >  {
> >      CPUState *cpu;
> >      int err =3D 0;
> > +    bool match_pid =3D gdb_is_multiprocess();
> >
> >      switch (type) {
> >      case GDB_BREAKPOINT_SW:
> >      case GDB_BREAKPOINT_HW:
> >          CPU_FOREACH(cpu) {
> > +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid=
(cs)) {
> > +                continue;
> > +            }
> >              err =3D cpu_breakpoint_remove(cpu, addr, BP_GDB);
> >              if (err) {
> >                  break;
> > @@ -178,6 +190,9 @@ static int tcg_remove_breakpoint(CPUState *cs, int =
type, vaddr addr, vaddr len)
> >      case GDB_WATCHPOINT_READ:
> >      case GDB_WATCHPOINT_ACCESS:
> >          CPU_FOREACH(cpu) {
> > +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid=
(cs)) {
> > +                continue;
> > +            }
> >              err =3D cpu_watchpoint_remove(cpu, addr, len,
> >                                          xlat_gdb_type(cpu, type));
> >              if (err) {
> > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > index 98574eba68..628e599692 100644
> > --- a/gdbstub/gdbstub.c
> > +++ b/gdbstub/gdbstub.c
> > @@ -199,7 +199,12 @@ void gdb_memtox(GString *buf, const char *mem, int=
 len)
> >      }
> >  }
> >
> > -static uint32_t gdb_get_cpu_pid(CPUState *cpu)
> > +bool gdb_is_multiprocess(void)
> > +{
> > +    return gdbserver_state.multiprocess;
> > +}
> > +
> > +uint32_t gdb_get_cpu_pid(CPUState *cpu)
> >  {
> >  #ifdef CONFIG_USER_ONLY
> >      return getpid();
> > diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> > index d73f424f56..a7c95d215b 100644
> > --- a/include/exec/gdbstub.h
> > +++ b/include/exec/gdbstub.h
> > @@ -138,6 +138,21 @@ GArray *gdb_get_register_list(CPUState *cpu);
> >
> >  void gdb_set_stop_cpu(CPUState *cpu);
> >
> > +/**
> > + * gdb_get_cpu_pid() - Get the PID assigned to a CPU
> > + * @cpu - the CPU to query
> > + *
> > + * Return: The PID associated with the cpu
> > + */
> > +uint32_t gdb_get_cpu_pid(CPUState *cpu);
> > +
> > +/**
> > + * gdb_is_multiprocess() - Tells if the gdb server supports multiple p=
rocesses
> > + *
> > + * Return: True if supported
> > + */
> > +bool gdb_is_multiprocess(void);
> > +
> >  /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
> >  extern const GDBFeature gdb_static_features[];
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

