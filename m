Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7988EC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaEr-0000yU-QO; Thu, 01 Feb 2024 11:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVaEl-0000gm-Ly
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:48:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVaEg-0003g2-TX
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:48:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40fc22e53f1so4719795e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706806101; x=1707410901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=af1ngahCdsTagYqFBoSKMTBXtOpsxoFzjPhN1zlaao4=;
 b=VT2m1A7tO9AgnV1xMKJpvzRdpptL0RXLMXxZKK+aphjO/ln6z2i/BZB7xl1Ps1SYOe
 2mSZji29uYTSOZbUrS13ha1kt4KZ7nwRNXaCtLNyZtPiIEW0IoatwzfPs/UAyYbNfF20
 DFdQvT/dKZ1wdoR+Xz7w9GdCYRlgaPTNoAbVmm0jiqzAxK2Zr0M1VdSk7koE79y4kB6v
 SCTko0TK/CTGHcGZ9M5GEyJYq7J8++3WAgpun++Hr1VSiHo4erIKXZkjoesxpmhWjxzS
 rpvMtcX2nioNUCHSkmBg5PLWjX75cvfutuIbwtCyaOyBObCHsJWrfsnvB9yEIQG2lV1M
 sCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706806101; x=1707410901;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=af1ngahCdsTagYqFBoSKMTBXtOpsxoFzjPhN1zlaao4=;
 b=kMCPaIoLwkb4bWOVFppfYU+3k86x+9WiyTUm3WUtX8KmCpn3ZMFw4tKVNtOTmo5Cnk
 Ezx3wJ2yZl662V/3ewCTSTxbtniWnquvF+Jo3/5nFZvMHAgcDPJA1dsfsvdbej8b+IDr
 5oFIDp9m0QAC1WM+pa0bQM3BZYn/+vHWOR6CI4wD0z6gdX/iF6xRaBSnjjB/qiwS7d4a
 ab4piTLgP1FvrJY08E46pwDmJWoQzvyaf7ipwX4+kttOQlYzL8vL0uv+mnQV8tXUCcc6
 wz3v0pCt6wOjNaHZNx9sA5Q5f15ZiRy2YcOtbv6U8OWRz6WdD7T1Qx5MxoMhQOd0gkH/
 mkVQ==
X-Gm-Message-State: AOJu0Yx7cu6TTJscGc7ikcIeInKnlVJLf8k8q8fiZIvCFIthSO4X0DMM
 ohgwWv4AdQQ4tqguefKs2XTM9OhyPeCuZ0ATZn5ozCg/nGpD5ibJJJ4p0HHdVI8=
X-Google-Smtp-Source: AGHT+IHc1DClqv+f5EsuSI+LBG5BpjaOm/u/v8rB009TqV6aeMEOYrzh1QAYk5MFfVlXFgB6AfY0+w==
X-Received: by 2002:a05:6000:a07:b0:33b:fed:656f with SMTP id
 co7-20020a0560000a0700b0033b0fed656fmr3891555wrb.53.1706806101299; 
 Thu, 01 Feb 2024 08:48:21 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX7zyQmLlaqPtnvz7FtRM/sPg7HvauBdzIDIcbgQ5YSrreEgqE/ARNr8jVLZccckfDjJBlRWeE69M2VVGXfc2aXGq+Ty31w3otl2dBCm5qwAKgFL0z5VLMhNoDcMsXVhykNbWWHWecaHxhhhhHgyrEzPegxAkzo
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t18-20020adfe112000000b0033ade19da41sm15868401wrz.76.2024.02.01.08.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 08:48:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0F9A5F7AF;
 Thu,  1 Feb 2024 16:48:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] gdbstub: Implement follow-fork-mode child
In-Reply-To: <bd14786900838155c9f1d2e82adc5e4d68207ee9.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Thu, 01 Feb 2024 17:22:07 +0100")
References: <20240131205031.144607-1-iii@linux.ibm.com>
 <20240131205031.144607-3-iii@linux.ibm.com>
 <877cjomlk9.fsf@draig.linaro.org>
 <bd14786900838155c9f1d2e82adc5e4d68207ee9.camel@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 16:48:20 +0000
Message-ID: <87bk90ku5n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Thu, 2024-02-01 at 12:11 +0000, Alex Benn=C3=A9e wrote:
>> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>>=20
>> > Currently it's not possible to use gdbstub for debugging linux-user
>> > code that runs in a forked child, which is normally done using the
>> > `set
>> > follow-fork-mode child` GDB command. Purely on the protocol level,
>> > the
>> > missing piece is the fork-events feature.
>> >=20
>> > However, a deeper problem is supporting $Hg switching between
>> > different
>> > processes - right now it can do only threads. Implementing this for
>> > the
>> > general case would be quite complicated, but, fortunately, for the
>> > follow-fork-mode case there are a few factors that greatly simplify
>> > things: fork() happens in the exclusive section, there are only two
>> > processes involved, and before one of them is resumed, the second
>> > one
>> > is detached.
>> >=20
>> > This makes it possible to implement a simplified scheme: the parent
>> > and
>> > the child share the gdbserver socket, it's used only by one of them
>> > at
>> > any given time, which is coordinated through a separate socketpair.
>> > The
>> > processes can read from the gdbserver socket only one byte at a
>> > time,
>> > which is not great for performance, but, fortunately, the
>> > follow-fork-mode involves only a few messages.
>> >=20
>> > Add the hooks for the user-specific handling of $qSupported, $Hg,
>> > and
>> > $D. Advertise the fork-events support, and remember whether GDB has
>> > it
>> > as well. Implement the state machine that is initialized on fork(),
>> > decides the current owner of the gdbserver socket, and is
>> > terminated
>> > when one of the two processes is detached. The logic for the parent
>> > and
>> > the child is the same, only the initial state is different.
>> >=20
>> > Handle the `stepi` of a syscall corner case by disabling the
>> > single-stepping in detached processes.
>> >=20
>> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > ---
>> > =C2=A0gdbstub/gdbstub.c=C2=A0=C2=A0 |=C2=A0 29 ++++--
>> > =C2=A0gdbstub/internals.h |=C2=A0=C2=A0 3 +
>> > =C2=A0gdbstub/user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 210
>> > +++++++++++++++++++++++++++++++++++++++++++-
>> > =C2=A03 files changed, 234 insertions(+), 8 deletions(-)
>
> [...]
> =C2=A0
>> > diff --git a/gdbstub/user.c b/gdbstub/user.c
>> > index 120eb7fc117..962f4cb74e7 100644
>> > --- a/gdbstub/user.c
>> > +++ b/gdbstub/user.c
>> > @@ -10,6 +10,7 @@
>> > =C2=A0 */
>> > =C2=A0
>> > =C2=A0#include "qemu/osdep.h"
>> > +#include <sys/syscall.h>
>> > =C2=A0#include "qemu/bitops.h"
>> > =C2=A0#include "qemu/cutils.h"
>> > =C2=A0#include "qemu/sockets.h"
>> > @@ -25,6 +26,41 @@
>> > =C2=A0#define GDB_NR_SYSCALLS 1024
>> > =C2=A0typedef unsigned long
>> > GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
>> > =C2=A0
>> > +/*
>> > + * Forked child talks to its parent in order to let GDB enforce
>> > the
>> > + * follow-fork-mode. This happens inside a start_exclusive()
>> > section, so that
>> > + * the other threads, which may be forking too, do not interfere.
>> > The
>> > + * implementation relies on GDB not sending $vCont until it has
>> > detached
>> > + * either from the parent (follow-fork-mode child) or from the
>> > child
>> > + * (follow-fork-mode parent).
>> > + *
>> > + * The parent and the child share the GDB socket; at any given
>> > time only one
>> > + * of them is allowed to use it, as is reflected in the respective
>> > fork_state.
>> > + * This is negotiated via the fork_sockets pair as a reaction to
>> > $Hg.
>> > + */
>> > +enum GDBForkState {
>> > +=C2=A0=C2=A0=C2=A0 /* Fully owning the GDB socket. */
>> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_ENABLED,
>> > +=C2=A0=C2=A0=C2=A0 /* Working with the GDB socket; the peer is inacti=
ve. */
>> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_ACTIVE,
>> > +=C2=A0=C2=A0=C2=A0 /* Handing off the GDB socket to the peer. */
>> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_DEACTIVATING,
>> > +=C2=A0=C2=A0=C2=A0 /* The peer is working with the GDB socket. */
>> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_INACTIVE,
>> > +=C2=A0=C2=A0=C2=A0 /* Asking the peer to close its GDB socket fd. */
>> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_ENABLING,
>> > +=C2=A0=C2=A0=C2=A0 /* Asking the peer to take over, closing our GDB s=
ocket fd. */
>> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_DISABLING,
>> > +=C2=A0=C2=A0=C2=A0 /* The peer has taken over, our GDB socket fd is c=
losed. */
>> > +=C2=A0=C2=A0=C2=A0 GDB_FORK_DISABLED,
>> > +};
>>=20
>> gulp - thats a potentially fairly complex state diagram. Do we just
>> work
>> through the states sequentially?
>
> Unfortunately no. I had less states at some point, but then realized
> it was better to have these things laid out explicitly. Let me try to
> summarize the possible transitions:
>
> GDB_FORK_ENABLED: Terminal state; GDB follows the current process.
> GDB_FORK_DISABLED: Terminal state; GDB follows the other process.
> GDB_FORK_ACTIVE -> GDB_FORK_DEACTIVATING: On $Hg.
> GDB_FORK_ACTIVE -> GDB_FORK_ENABLING: On $D.
> GDB_FORK_ACTIVE -> GDB_FORK_DISABLING: On $D.
> GDB_FORK_ACTIVE -> GDB_FORK_DISABLED: On communication error.
> GDB_FORK_DEACTIVATING -> GDB_FORK_INACTIVE: On gdb_read_byte() return.
> GDB_FORK_DEACTIVATING -> GDB_FORK_DISABLED: On communication error.
> GDB_FORK_INACTIVE -> GDB_FORK_ACTIVE: On $Hg in peer.
> GDB_FORK_INACTIVE -> GDB_FORK_ENABLE: On $D in peer.
> GDB_FORK_INACTIVE -> GDB_FORK_DISABLE: On $D in peer.
> GDB_FORK_INACTIVE -> GDB_FORK_DISABLED: On communication error.
> GDB_FORK_ENABLING -> GDB_FORK_ENABLED: On gdb_read_byte() return.
> GDB_FORK_ENABLING -> GDB_FORK_DISABLED: On communication error.
> GDB_FORK_DISABLING -> GDB_FORK_DISABLED: On gdb_read_byte() return.
>
> Some states have only one meaningful transition:
>
> GDB_FORK_DEACTIVATING -> GDB_FORK_INACTIVE
> GDB_FORK_ENABLING -> GDB_FORK_ENABLED
>
> and can in theory be squashed, but then the socketpair communication
> would have to be moved to the respective user-hook, which would
> complicate the error handling.
>
> [...]
>
>> > @@ -369,16 +421,168 @@ static void disable_gdbstub(void)
>> > =C2=A0=C2=A0=C2=A0=C2=A0 CPU_FOREACH(cpu) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_breakpoint_remove=
_all(cpu, BP_GDB);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no cpu_watchpoint_=
remove_all for user-mode */
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_single_step(cpu, 0);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tb_flush(cpu);
>> > =C2=A0=C2=A0=C2=A0=C2=A0 }
>> > =C2=A0}
>> > =C2=A0
>> > -/* Disable gdb stub for child processes.=C2=A0 */
>> > =C2=A0void gdbserver_fork_end(pid_t pid)
>> > =C2=A0{
>> > -=C2=A0=C2=A0=C2=A0 if (pid !=3D 0 || !gdbserver_state.init ||
>> > gdbserver_user_state.fd < 0) {
>> > +=C2=A0=C2=A0=C2=A0 char b;
>> > +=C2=A0=C2=A0=C2=A0 int fd;
>> > +
>> > +=C2=A0=C2=A0=C2=A0 if (!gdbserver_state.init || gdbserver_user_state.=
fd < 0) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> > +=C2=A0=C2=A0=C2=A0 }
>> > +
>> > +=C2=A0=C2=A0=C2=A0 if (pid =3D=3D -1) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gdbserver_user_state.f=
ork_state !=3D GDB_FORK_DISABLED)
>> > {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
assert(gdbserver_user_state.fork_state =3D=3D
>> > GDB_FORK_INACTIVE);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=
ose(gdbserver_user_state.fork_sockets[0]);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=
ose(gdbserver_user_state.fork_sockets[1]);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> > =C2=A0=C2=A0=C2=A0=C2=A0 }
>> > -=C2=A0=C2=A0=C2=A0 disable_gdbstub();
>> > +
>> > +=C2=A0=C2=A0=C2=A0 if (gdbserver_user_state.fork_state =3D=3D GDB_FOR=
K_DISABLED) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pid =3D=3D 0) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 di=
sable_gdbstub();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> > +=C2=A0=C2=A0=C2=A0 }
>> > +
>> > +=C2=A0=C2=A0=C2=A0 if (pid =3D=3D 0) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(gdbserver_user_state=
.fork_sockets[0]);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D gdbserver_user_stat=
e.fork_sockets[1];
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(gdbserver_state.p=
rocess_num =3D=3D 1);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(gdbserver_state.p=
rocesses[0].pid =3D=3D
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fo=
rk_peer_pid);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(gdbserver_state.p=
rocesses[0].attached);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_state.processes[=
0].pid =3D getpid();
>> > +=C2=A0=C2=A0=C2=A0 } else {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(gdbserver_user_state=
.fork_sockets[1]);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D gdbserver_user_stat=
e.fork_sockets[0];
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fork_=
state =3D GDB_FORK_ACTIVE;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fork_=
peer_pid =3D pid;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.fork_=
peer_tid =3D pid;
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!gdbserver_state.allow=
_stop_reply) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to fail;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_string_printf(gdbserver_=
state.str_buf,
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "T%02=
xfork:p%02x.%02x;thread:p%02x.%02x;",
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> > gdb_target_signal_to_gdb(gdb_target_sigtrap()),
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid, =
pid, (int)getpid(),
>> > qemu_get_thread_id());
>>=20
>> I don't think I messed up the merge but:
>>=20
>> ../../gdbstub/user.c: In function =E2=80=98gdbserver_fork_end=E2=80=99:
>> ../../gdbstub/user.c:461:50: error: implicit declaration of function
>> =E2=80=98gdb_target_sigtrap=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
>> =C2=A0 461 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
>> gdb_target_signal_to_gdb(gdb_target_sigtrap()),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> ^~~~~~~~~~~~~~~~~~
>> ../../gdbstub/user.c:461:50: error: nested extern declaration of
>> =E2=80=98gdb_target_sigtrap=E2=80=99 [-Werror=3Dnested-externs]
>> cc1: all warnings being treated as errors
>>=20
>> I cant see where gdb_target_sigtrap is from?
>
> This is from [1], which this series is Based-on. I can make one series
> with both features if it's more convenient to review.
>
> [1]
> https://patchew.org/QEMU/20240116094411.216665-1-iii@linux.ibm.com/

Oops missed that one, looking at it now.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

