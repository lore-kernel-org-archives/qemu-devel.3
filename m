Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDDACFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 10:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkmn-0007Fc-35; Mon, 07 Oct 2024 06:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sxkmf-0007Es-0g
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 06:16:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sxkmX-0000N0-7z
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 06:16:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso31137475e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728296144; x=1728900944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4TGUV35iy6Os1aNJuWcKUBfoyJEDAoTDT6jW/rYftE=;
 b=aBzxBfQeLfIGMPnCoyl/1ZKjNfvBbSyj92v6tzg7oaywI1J1PKg/2FUU/QqR5G11MM
 kzPx2kLvaCIpPw3Kp91fu8oRxzPHUQprqnNUJfvoqjo9YWz/lbskLMlHLuhWnYEpb/fj
 2R7+ElqWrTvG+c6i1hybzVf9olTg+Q0I+nDMSMDPbLRqVqqRxZtwAx5et6WNqxLgOp6T
 mntvIitmGfpm/roJCqpGOlw4ZbNVWNIKiE0Esq66yWhA/7WXaUZPjJ0E0tASl0bFOIGk
 jZVIFJkma3ys8fodNf1wMYrUe7UwFBlQRzMkSffRIqrXsW7fptJivkJJiEidg0j3tPx+
 kJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728296144; x=1728900944;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4TGUV35iy6Os1aNJuWcKUBfoyJEDAoTDT6jW/rYftE=;
 b=WRxcMSj3XYN1gP/iccSRfVco58vKJ5zELUQZ6pM5MQz3UkiJXzshEqfDvwYN44PycJ
 2Km/15IlECRFBpU7z71DQMQQXYHCpMXMBJGkVtZi16jSHvV+6K6M6ruckARN4aaA/kSz
 d1ouwWy5G7ZEmc4uCQQc91EuWBrrWSu1KbmMjdiXrlpH6R/9dI9Z1JFGFP6kcAJM8CBj
 Qmg/w2rGHOgVFvbQQTNzDizI4/r7CJkL8+/k5kecf9SbdrTv8h1rTwO5463Gcn+Q8iFN
 XflE0z/fs1TEVWSIOfLSU3GCFGPeK/LH1WksCzJDJ4sFCKtWwFPkWM9xmPFPsFzHNR7p
 WDrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNEKcXpHobJeVCbNx+orJGc8DtyCZ7TUlNlZ+oEStBD2qUyQhtFEMaDqeJmbBqfdUzM1Z80hFZ9psC@nongnu.org
X-Gm-Message-State: AOJu0YxyLRUDBh5dSG9GZCZCsUDkFAe+5G5Xta9ffn9yKltwaf+yc394
 2HJA9Mhu8JChFym0P8zqqAtQOuCQJ0U0h24kJiHAHRx7SC73B7ITdSRNSNvmTGI=
X-Google-Smtp-Source: AGHT+IGFQcfpyxLQZPmGj5hJr/DDjG8VqnZ2pPyCVzax2PzTSeFQeCw0QrwHVbZiYjZg8wrA1s1hAg==
X-Received: by 2002:a5d:5587:0:b0:374:cc89:174b with SMTP id
 ffacd0b85a97d-37d049b7de3mr9120798f8f.4.1728296143631; 
 Mon, 07 Oct 2024 03:15:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1697301fsm5324522f8f.100.2024.10.07.03.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 03:15:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55F425F875;
 Mon,  7 Oct 2024 11:15:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: richard.henderson@linaro.org,  pbonzini@redhat.com,  philmd@linaro.org,
 slongfield@google.com,  komlodi@google.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] gdbstub: Apply breakpoints only to the selected PID
In-Reply-To: <20240906225451.1039718-3-roqueh@google.com> (Roque Arcudia
 Hernandez's message of "Fri, 6 Sep 2024 15:54:51 -0700")
References: <20240906225451.1039718-1-roqueh@google.com>
 <20240906225451.1039718-3-roqueh@google.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 07 Oct 2024 11:15:42 +0100
Message-ID: <87set8w75d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Roque Arcudia Hernandez <roqueh@google.com> writes:

> In the context of using the remote gdb with multiple
> processes/inferiors (multi cluster machine) a given breakpoint will
> target an specific inferior. Current implementation of
> tcg_insert_breakpoint and tcg_remove_breakpoint apply a given
> breakpoint to all the cpus available in the system.

OK I can see this needs fixing.

> Only the CPUs associated with the selected process ID should insert
> or remove the breakpoint. It is important to apply it to all the CPUs
> in the process ID regardless of the particular thread selected by the
> 'Hg' packet because even in the case of a thread specific breakpoint.
> A breakpoint on a specific thread is treated as a conditional break
> similar to a 'break if'. This can be read in the code and comments of
> function bpstat_check_breakpoint_conditions in the file
> gdb/breakpoint.c
>
> /* For breakpoints that are currently marked as telling gdb to stop,
>    check conditions (condition proper, frame, thread and ignore count)
>    of breakpoint referred to by BS.  If we should not stop for this
>    breakpoint, set BS->stop to 0.  */
>
> static void
> bpstat_check_breakpoint_conditions (bpstat *bs, thread_info *thread)
>
> The patch needs to expose the currently private function
> gdb_get_cpu_pid to the TCG and also expose the value of
> gdbserver_state.multiprocess. The PID filtering will only be
> applicable to multiprocess gdb because the PIDs are only defined in
> that context.

I don't like exposing those private functions, especially as the PID
terminology is confusing. Could we not keep all the logic in the gdbstub
itself so the tests become something like:

    case GDB_BREAKPOINT_SW:
    case GDB_BREAKPOINT_HW:
        CPU_FOREACH(cpu) {
            if (gdb_cpu_in_source_group(cs, cpu)) {
                err =3D cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
                if (err) {
                    break;
                }
            }
        }
        return err;

?

Ilya has also posted a large series for non-stop mode on *-user guests
which is on my review queue which I would want to check doesn't conflict
with this:

  Message-ID: <20240923162208.90745-1-iii@linux.ibm.com>
  Date: Mon, 23 Sep 2024 18:12:55 +0200
  Subject: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
  From: Ilya Leoshkevich <iii@linux.ibm.com>

>
> Google-Bug-Id: 355027002
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  accel/tcg/tcg-accel-ops.c | 15 +++++++++++++++
>  gdbstub/gdbstub.c         |  7 ++++++-
>  include/exec/gdbstub.h    | 15 +++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 3c19e68a79..557091c15e 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -33,6 +33,7 @@
>  #include "qemu/guest-random.h"
>  #include "qemu/timer.h"
>  #include "exec/exec-all.h"
> +#include "exec/gdbstub.h"
>  #include "exec/hwaddr.h"
>  #include "exec/tb-flush.h"
>  #include "gdbstub/enums.h"
> @@ -132,11 +133,15 @@ static int tcg_insert_breakpoint(CPUState *cs, int =
type, vaddr addr, vaddr len)
>  {
>      CPUState *cpu;
>      int err =3D 0;
> +    bool match_pid =3D gdb_is_multiprocess();
>=20=20
>      switch (type) {
>      case GDB_BREAKPOINT_SW:
>      case GDB_BREAKPOINT_HW:
>          CPU_FOREACH(cpu) {
> +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid(c=
s)) {
> +                continue;
> +            }
>              err =3D cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
>              if (err) {
>                  break;
> @@ -147,6 +152,9 @@ static int tcg_insert_breakpoint(CPUState *cs, int ty=
pe, vaddr addr, vaddr len)
>      case GDB_WATCHPOINT_READ:
>      case GDB_WATCHPOINT_ACCESS:
>          CPU_FOREACH(cpu) {
> +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid(c=
s)) {
> +                continue;
> +            }
>              err =3D cpu_watchpoint_insert(cpu, addr, len,
>                                          xlat_gdb_type(cpu, type), NULL);
>              if (err) {
> @@ -163,11 +171,15 @@ static int tcg_remove_breakpoint(CPUState *cs, int =
type, vaddr addr, vaddr len)
>  {
>      CPUState *cpu;
>      int err =3D 0;
> +    bool match_pid =3D gdb_is_multiprocess();
>=20=20
>      switch (type) {
>      case GDB_BREAKPOINT_SW:
>      case GDB_BREAKPOINT_HW:
>          CPU_FOREACH(cpu) {
> +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid(c=
s)) {
> +                continue;
> +            }
>              err =3D cpu_breakpoint_remove(cpu, addr, BP_GDB);
>              if (err) {
>                  break;
> @@ -178,6 +190,9 @@ static int tcg_remove_breakpoint(CPUState *cs, int ty=
pe, vaddr addr, vaddr len)
>      case GDB_WATCHPOINT_READ:
>      case GDB_WATCHPOINT_ACCESS:
>          CPU_FOREACH(cpu) {
> +            if (match_pid && gdb_get_cpu_pid(cpu) !=3D gdb_get_cpu_pid(c=
s)) {
> +                continue;
> +            }
>              err =3D cpu_watchpoint_remove(cpu, addr, len,
>                                          xlat_gdb_type(cpu, type));
>              if (err) {
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 98574eba68..628e599692 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -199,7 +199,12 @@ void gdb_memtox(GString *buf, const char *mem, int l=
en)
>      }
>  }
>=20=20
> -static uint32_t gdb_get_cpu_pid(CPUState *cpu)
> +bool gdb_is_multiprocess(void)
> +{
> +    return gdbserver_state.multiprocess;
> +}
> +
> +uint32_t gdb_get_cpu_pid(CPUState *cpu)
>  {
>  #ifdef CONFIG_USER_ONLY
>      return getpid();
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index d73f424f56..a7c95d215b 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -138,6 +138,21 @@ GArray *gdb_get_register_list(CPUState *cpu);
>=20=20
>  void gdb_set_stop_cpu(CPUState *cpu);
>=20=20
> +/**
> + * gdb_get_cpu_pid() - Get the PID assigned to a CPU
> + * @cpu - the CPU to query
> + *
> + * Return: The PID associated with the cpu
> + */
> +uint32_t gdb_get_cpu_pid(CPUState *cpu);
> +
> +/**
> + * gdb_is_multiprocess() - Tells if the gdb server supports multiple pro=
cesses
> + *
> + * Return: True if supported
> + */
> +bool gdb_is_multiprocess(void);
> +
>  /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>  extern const GDBFeature gdb_static_features[];

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

