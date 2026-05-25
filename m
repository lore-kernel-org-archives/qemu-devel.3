Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF13CD5BAB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 02:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRKt3-00005T-LO; Sun, 24 May 2026 22:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRKsw-000057-CI
 for qemu-devel@nongnu.org; Sun, 24 May 2026 22:17:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRKsr-0005jD-B8
 for qemu-devel@nongnu.org; Sun, 24 May 2026 22:17:41 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2bcd3ac3307so53601935ad.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 19:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779675455; cv=none;
 d=google.com; s=arc-20240605;
 b=Qe7Hc+3l3nm/PtyP5w/odEK8kSC3c/bfPdXBpO5xfIsm/YeIGRz8LUGTA1PrBThj6M
 kNAGZrO2ZdQSxtNL5fVDP9fsIsj9To62AgxT6Ej1equddlUgkieSF/8fTD6eMGjz6ecy
 nZIvAlf0vJqQ209h+8OhG1RVxRXJrzFrwPzcyXe05DrBLWnr8BA0iX/PRQS5micR4LZ2
 KjZO2PegASjbuKq1e5701of6gELYGu+aba0lqAxR5gBkA6JaENodPkDRF4P+mJhPPxbp
 1ET7xP30cigHKMfBMOZ06nRlRbXeeyXWHag9f9QJVV5xFv0fOI+zLsSeSR8xaQXxAaSq
 kSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A7zQRpYtGFS2ytRC1SjvFJOnLajnz1Na+5+eGmYevpA=;
 fh=Hc/XkILqIVS4XdlWNU2RWzilslKz2UV+wYnWy0nOT3I=;
 b=VxAdJu2A5V+6q7059q1d9tvUoq4CN/5bxoK6bjMbEp/N98+M3KvQxER/R1SCvlQ2hM
 VprlIoL3hlBWhsNyyZEr1OzImUnkCcJMEmi4c0NDa0R5LFMdDKVxEKTwpXSf35Q6ZDU2
 s9eh32iAiT01c3V8yQGT/1FNtemfus/8zFDdFOKraPkjOacnYXgHxWTeuxcrboCmG/kA
 TBPvhN/CYYI9vJx5wP7H3AWkYNcv6oIMxvuxOK5nrjGlGJ6u82a+oHjLPX6CPbFqjR5y
 ombodIXzume/yISk9rJnb2cQzzYCsH9jM5gVjW+RLpwDMiERUAI0yamWRA1n1k9aDhUK
 iN7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779675455; x=1780280255;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A7zQRpYtGFS2ytRC1SjvFJOnLajnz1Na+5+eGmYevpA=;
 b=L04hdKzfLuQ0EPku4zQy9zSiK46TaXh3HA9POulWv63sUriFmW4T0AHnIabVLt4Ie0
 S0Rn7ixcI7oL4dVeIwHxiRa/svp6mdJzrL5U20sV8VERNKQM8aF4XjbxgubkdrCAHxio
 am01z9PSeyQqHytduafqWpPgNj4ksDQ8HvGmRIpIZF9fS1GsK83wSFjHUqBvrWXVeFTE
 KAdMSlNwu71HAnYUodSFq09JwbvqQizreAWB/HXXVHrjNxaVKGnS6zabReUzJesePV+V
 dUBLA1aaMkpWkQwHxdzdFTmJ9q/1fBJcpBWhY/YpnOnjBR/HZXQZ544zawu2ayd4LJe9
 cGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779675455; x=1780280255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7zQRpYtGFS2ytRC1SjvFJOnLajnz1Na+5+eGmYevpA=;
 b=LrVyBORX4qPGWVH97Yo+0BvhxXcyeGEjrNcWEzj/hcE0qYSBpGIlZKsyl6tT6SHfPC
 o7+0KthoJcyyRnM1lCuo++20CsixMq2unCm0aimBU0QoXDu6ZMmN81qWlMDgdY1a75mH
 ibzmJHiCl7vpCAzUV0YkAc+QN5PuCLrvBeYOHNF//Zdd7UEn7zqwNnFKCMmoVXTY3J4O
 F7DZ6h1kIFXmMuFbTRVVbND1b7PdpIZnbaOKGhT1/qbR3L2Ex23IC7oSyZyLcpAhtYLN
 8k0qECUpykGg8ef99Tbq5AXK137zVTil2BVzxDqNj7lSv/hkHyBH3fGvkMiCqXMMxzYk
 /ObQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9d3SeiLkLMc47zGjiL3tFDn2Wc/0JkepE+oVYLv88+hepMjbajBz5Goeujp78sXGo1SH/sdToT9Tza@nongnu.org
X-Gm-Message-State: AOJu0Yw2tDqMC5f6AZyhKOekeHSvNQOP7AfVRJDZpukG4F9tt3viI91+
 XASUsdpvZ6lMKmSCLYb7AzNtC5EYz9yHYkDEIEPCxEyIvmQMfEtkShdDA0k8dNZXa1eFTW1cVq0
 CFw48a5n6mbtDUN49jkLGNrDdDaUXlyDXJ4HwkxaRUw==
X-Gm-Gg: Acq92OFNWqL2NNFxvNZajLn7C8A4P9hQgY+IOY3V+PQVAxgzxYWYVNmcdI4JwPMB2k6
 XEjIbZNkBShvRhQwICZAiJ6xktTdsW3D8ASqGbzWpoXztI0HRMZo7MyChq6vMuP0fA/LtHgxuDt
 tpA80FyOSxKnEExzWPQXsIB67YavhsGDq3ku+7nQ9bO9fY6oHo0hLkKSAosDVX1POyVtZkUe5J2
 qHKq6WDu/YmlJRLZCTKcTX7mo9ld83pL8h2iPzzo/vJdT1gOJM/QRquyibmRh5tXP8FI+n65CAD
 IOrE59MMNlhQ6cOsactvrEFeiC5N13+rXjQ=
X-Received: by 2002:a17:903:2bce:b0:2b2:4260:109 with SMTP id
 d9443c01a7336-2beb074f776mr131066635ad.23.1779675455176; Sun, 24 May 2026
 19:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <d840bb59-b30d-4955-b570-32f8d2ffc60a@oss.qualcomm.com>
 <CANCZdfqoPUt1Dd55FAZOnxoe1wUSxQGzP1Rp=zRZkY6vC6iOfg@mail.gmail.com>
 <586de8e4-428c-4e05-99d1-574f09b89f15@oss.qualcomm.com>
 <730049c6-7de2-403d-a327-491d1cfc52fd@gmx.de>
In-Reply-To: <730049c6-7de2-403d-a327-491d1cfc52fd@gmx.de>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 24 May 2026 20:17:24 -0600
X-Gm-Features: AVHnY4IvQfcrhJ63qQ1kGKDRwthMjT-D__oGhqILWpcGekoxU-kAPQdXwnjDBok
Message-ID: <CANCZdfoj1hB0kc29bDdRAH2wtFrOu0hGcjjsF9THN-KpfsGFLw@mail.gmail.com>
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
To: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@freebsd.org>, 
 Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000524f8706529afb05"
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000524f8706529afb05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 12:57=E2=80=AFPM Helge Deller <deller@gmx.de> wrote=
:

> On 5/23/26 03:19, Pierrick Bouvier wrote:
> > On 5/22/2026 5:40 PM, Warner Losh wrote:
> >>
> >>
> >> On Fri, May 22, 2026 at 6:04=E2=80=AFPM Pierrick Bouvier
> >> <pierrick.bouvier@oss.qualcomm.com
> >> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> >>
> >>      On 5/18/2026 2:27 PM, Warner Losh wrote:
> >>      > Upstream the file, thread, socket and remaining signal system
> >>      calls (too
> >>      > numerous to list here).
> >>      >
> >>      > This series is an ambitous use of claude to help me upstream al=
l
> the
> >>      > remaining system calls. I've batched them together in what I
> think are
> >>      > reasonable chunks, and had claude do the grunt work of copying
> the
> >>      code
> >>      > over and attributing the commits from our complex branching
> >>      history. The
> >>      > chopping up was a bit arbitrary, but I think it's good. The
> commit
> >>      > messages may be a little weak, but may also be OK. I've also
> double
> >>      > checked the style and made fixes upstream for them as well.
> Claude
> >>      also
> >>      > reviewed all these changes and found a few bugs that I've fixed=
.
> I've
> >>      > personally read through them all and haven't found anything
> glaring. I
> >>      > fixed all the bugs that were found, in most cases differently
> than
> >>      > claude's suggestions.
> >>      >
> >>      > I've added 'Assisted-by: Claude...' to all these commits to
> reflect my
> >>      > leaning on Claude so hard. This use falls within the 'non-
> >>      creative' use
> >>      > that the Qemu project has said is OK. If that's not the right
> thing to
> >>      > do, I can remove them.
> >>      >
> >>      > This leaves sysctl translation, the powerpc architecture suppor=
t,
> >>      > coredumps and a transition to 'truss' based system call tracing=
.
> With
> >>      > these changes applied we'er down from a high of about 30k lines
> of
> >>      diffs
> >>      > to only 5k (not counting genereted, but checked in files in
> >>      blitz). The
> >>      > changes are 8k, so maybe a bit ambitious from that perspective =
as
> >>      well.
> >>      >
> >>      > There's a few lines over 80 that I've not cleaned up. Let me
> know if
> >>      > that's a problem. The other warnings are about adding files, an=
d
> >>      there's
> >>      > no new MAINTAINERS entry needed. And the 'arch dependent define=
s
> >>      should
> >>      > be avoided' are needed to cope with different FreeBSD build
> systems
> >>      > having different system calls.
> >>      >
> >>      > Note, this is called out below too, but in v2 I've folded back
> all the
> >>      > fixes based on some out-of-band feedback I recieved to do this
> the
> >>      > normal way and the qemu project isn't interested in the fixes t=
o
> >>      fixes.
> >>      >
> >>      > This is a big experiment, in many ways, for me, so I'm
> interested in
> >>      > whatever feedback you may have to make things better in the
> future.
> >>      >
> >>      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:
> imp@bsdimp.com>>
> >>      > ---
> >>      > Changes in v2:
> >>      > - don't write offsets on errors for copy_file_range
> >>      > - pipe2: Check the raw system call value directly
> >>      > - setsockopt: Check target_to_host_ip_mreq return value
> >>      > - <several places>: Check return value of host_to_target_sockad=
dr
> >>      > - do_bsd_setsockopt: Read in the socket option
> >>      > - ntp_gettime: write back time on non-errors, not just 0
> >>      > - do_freebsd_sigtimedwait check t2h_freebsd_timespec return
> >>      > - do_freebsd_swapcontext writing incorrectly, readonly data (0 =
to
> >>      user_unlock)
> >>      > - do_thr_set_name needs get_errno()
> >>      > - Have ntp_adjtime write back the structure
> >>      > - kevent_freebsd11 no need to explicitly mask, datatypes do thi=
s
> >>      for us
> >>      > - do_freebsd_setcontext just reads the mcontext, 0 in unlock_us=
er
> >>      > - target_to_host_sigevent is read-only, so pass 0 in unlock_use=
r
> >>      > - target_to_host_ip_mreq needs tswap32 for int32_t
> >>      > - use get_errno on kenv return values to report errors better
> >>      > - kevent: only copy the number of events returns, not whole
> buffer
> >>      > - Copy tolerance field of timex
> >>      > - freebsd_umtx_sem_wake use VERIFY_READ instead of write to rea=
d
> >>      struct
> >>      > - Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
> >>      > - Fixed additional missing unlock in freebsd_rw_rdlock and
> >>      freebsd_rw_wrlock in !_UMTX_OPTIMIZED
> >>      > - Squashed all the bug commit back to the appropriate earleir
> patch
> >>      > - Link to v1: https://lore.kernel.org/qemu-devel/20260515-
> >>      misc-2026q2-v1-0-5438ca41b27a@bsdimp.com <https://lore.kernel.org=
/
> >>      qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
> >>      >
> >>      > ---
> >>      > Warner Losh (37):
> >>      >       bsd-user: catchup to locking / mapping routines in
> bsd-misc.
> >>      >       bsd-user: Rename cpu_env to env throughout bsd-user
> >>      >       bsd-user: Add bsd-signal.h with sigaction through sigretu=
rn
> >>      >       bsd-user: Add signal shims sigwait through kill and
> os-signal.h
> >>      >       bsd-user: Add signal system call dispatch
> >>      >       bsd-user: Add poll, lseek, pipe, and swap system call shi=
ms
> >>      >       bsd-user: Add os-file.h with pipe2, chflagsat, close_rang=
e,
> >>      and more
> >>      >       bsd-user: Add file operation system call dispatch
> >>      >       bsd-user: Add bsd-socket.h with bind through getsockname
> >>      >       bsd-user: Add socket shims socketpair through shutdown
> >>      >       bsd-user: Add os-socket.h with sendrecvmsg and message
> >>      structures
> >>      >       bsd-user: Add do_bsd_setsockopt and socket option
> definitions
> >>      >       bsd-user: Add do_bsd_getsockopt
> >>      >       bsd-user: Add FreeBSD socket helpers and sockaddr
> conversion
> >>      >       bsd-user: Add os-socket.c with cmsg conversion functions
> >>      >       bsd-user: Add socket system call dispatch
> >>      >       bsd-user: Add os-time.h with clock and time-of-day
> functions
> >>      >       bsd-user: Add utimes, futimes, and ktimer functions to
> os-time.h
> >>      >       bsd-user: Add select, pselect, and ppoll to os-time.h
> >>      >       bsd-user: Add kqueue and kevent functions to os-time.h
> >>      >       bsd-user: Add sigtimedwait, itimer, and futimens to
> os-time.h
> >>      >       bsd-user: Add os-time.c and time-related type definitions
> >>      >       bsd-user: Add time system call dispatch
> >>      >       bsd-user: Add thread, umtx, and ACL type definitions
> >>      >       bsd-user: Add cpu_copy and make init_task_state non-stati=
c
> >>      >       bsd-user: Add os-thread.h with thr and context functions
> >>      >       bsd-user: Add do_freebsd__umtx_op to os-thread.h
> >>      >       bsd-user: Add os-thread.c with umtx, mutex, and thread
> creation
> >>      >       bsd-user: Add thread system call dispatch
> >>      >       bsd-user: Add os-extattr.h with file and fd extattr
> functions
> >>      >       bsd-user: Add link and list extattr functions to
> os-extattr.h
> >>      >       bsd-user: Add ACL system call shims to os-extattr.h
> >>      >       bsd-user: Add os-extattr.c with ACL conversion functions
> >>      >       bsd-user: Add extended attribute and ACL system call
> dispatch
> >>      >       bsd-user: Add scheduler and cpuset functions to os-misc.h
> >>      >       bsd-user: Add kmod, posix, and misc functions to os-misc.=
h
> >>      >       bsd-user: Add scheduler, cpuset, kmod, and misc syscall
> dispatch
> >>      >
> >>      >  bsd-user/aarch64/target.h     |    2 +-
> >>      >  bsd-user/arm/target.h         |    2 +-
> >>      >  bsd-user/bsd-file.h           |  164 +++-
> >>      >  bsd-user/bsd-mem.h            |    4 +-
> >>      >  bsd-user/bsd-proc.h           |   24 +-
> >>      >  bsd-user/bsd-signal.h         |  231 ++++++
> >>      >  bsd-user/bsd-socket.c         |   98 +++
> >>      >  bsd-user/bsd-socket.h         |  283 +++++++
> >>      >  bsd-user/freebsd/meson.build  |    8 +-
> >>      >  bsd-user/freebsd/os-extattr.c |  116 +++
> >>      >  bsd-user/freebsd/os-extattr.h |  662 ++++++++++++++++
> >>      >  bsd-user/freebsd/os-file.h    |  129 ++++
> >>      >  bsd-user/freebsd/os-misc.h    |  470 +++++++++++-
> >>      >  bsd-user/freebsd/os-proc.c    |    4 +-
> >>      >  bsd-user/freebsd/os-proc.h    |   26 +-
> >>      >  bsd-user/freebsd/os-signal.h  |   20 +
> >>      >  bsd-user/freebsd/os-socket.c  |  234 ++++++
> >>      >  bsd-user/freebsd/os-socket.h  |  770 +++++++++++++++++++
> >>      >  bsd-user/freebsd/os-stat.h    |    8 +-
> >>      >  bsd-user/freebsd/os-sys.c     |    4 +-
> >>      >  bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
> >>      >  bsd-user/freebsd/os-thread.c  | 1682
> ++++++++++++++++++++++++++++
> >>      +++++++++++++
> >>      >  bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
> >>      >  bsd-user/freebsd/os-time.c    |  346 +++++++++
> >>      >  bsd-user/freebsd/os-time.h    |  983 ++++++++++++++++++++++++
> >>      >  bsd-user/freebsd/qemu-os.h    |   48 ++
> >>      >  bsd-user/i386/target.h        |    2 +-
> >>      >  bsd-user/main.c               |   32 +-
> >>      >  bsd-user/meson.build          |    1 +
> >>      >  bsd-user/qemu-bsd.h           |   26 +
> >>      >  bsd-user/qemu.h               |   48 +-
> >>      >  bsd-user/riscv/target.h       |    2 +-
> >>      >  bsd-user/signal-common.h      |    4 +
> >>      >  bsd-user/signal.c             |   67 ++
> >>      >  bsd-user/syscall_defs.h       |  458 +++++++++--
> >>      >  bsd-user/x86_64/target.h      |    2 +-
> >>      >  36 files changed, 8150 insertions(+), 196 deletions(-)
> >>      > ---
> >>      > base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
> >>      > change-id: 20260504-misc-2026q2-a5af31ac032a
> >>      >
> >>      > Best regards,
> >>
> >>      After reviewing (what I can) two thirds of the series, I don't
> feel very
> >>      at ease with validating the rest. Not that there is problem in
> itself,
> >>      but it's a massive add, and I'm not sure how we can ensure it's
> >>      implemented correctly without any test exercising it.
> >>      It's not particular to bsd-user, linux-user does not have test fo=
r
> all
> >>      syscalls implemented neither.
> >>
> >>
> >> Yes. I'd like a low-level test like that. The upstream bsd-user has
> been too
> >> incomplete to run real programs prior to this series. And there's stil=
l
> some
> >> issues that remain after these system calls (which is next up on my
> list: I
> >> think elfload needs some patches for PIE).
> >>
> >>
> >>      However, because we are adding most of it at once, it's a bit
> different.
> >>      Dropping 8150 new lines at once without any test looks a bit
> complicated
> >>      to me.
> >>
> >>      A few questions about the series in itself:
> >>      - Where does most of the implementation comes from? Was it
> downstream on
> >>      FreeBSD side, or written from scratch for this series?
> >>
> >>
> >> We've had almost all of this code, modulo some big fixes I've added,  =
in
> >> blitz branch
> >> for years. Stacey Son implemented most of this a decade ago now and ha=
d
> some
> >> issue upstream at the time, IIRC, but I have only sketchy details of t=
he
> >> project then.
> >>
> >> We use it inside our poudriere jails to build thousands of ports to te=
st
> >> it. Though there are issues with many ports, enough work to keep going=
.
>
> So, this seems to be similar to what I do, and it's actually a good test
> case for linux-user.
> I'm running some debian buildd servers which use qemu-hppa to build debia=
n
> packages
> for the hppa architecture. With that setup I found quite some bugs in
> qemu-user
> and now it's pretty stable.
>
> >> I also run a number of random commands in the jail that's nothing but
> >> cross-arch binaries
> >> as well.
> >>
> >
> > That's good to hear this has been used downstream for a long time. That
> > was my feeling after our conversation, but just wanted to double check
> this.
> >
> >> Sometimes I run the Kyua tests, but it's a bit hard to read the output
> >> because many are broken,
> >> many can't work in qemu or in a jail, and there's some that are broken
> >> for a given arch. We don't
> >> have good baselines to compare against and I've not spent the time to
> >> get this into good shape.
> >>
> >> Not the most formal set of things we do, but it works.
> >>
> >>
> >>      - How did you validate it works, beyond it compiles?
> >>
> >>
> >> Generally on the blitz side, all of the above. On the qemu-project sid=
e,
> >> I usually just do the bit
> >> about messing around in the jail to test the basics.
> >>
> >> I'm happy cleaving this massive set into some smaller sets if that wou=
ld
> >> help, but that still wouldn't
> >> answer the 'how the heck do we test it'.
> >>
> >
> > It would require a massive effort for no benefit, since it doesn't
> > increase testability of the whole.
> >
> >> I've also had claude do code reviews of this branch. It's found maybe
> >> 100 bugs that I've fixed
> >> (maybe 25 more between v2 and v3). The vast majority of the bugs are
> >> lock/unlock issues. Either
> >> leaks on error paths, failure to check for TARGET_EFAULT in places or
> >> passing args that don't
> >> matter unless you compile CONFIG_DEBUG_REMAP to indicate copying, etc.
> >> Some real bugs
> >> have been found, including one that might lead to a multi-threaded han=
g.
> >>
> >
> > This is better than nothing, and it's a common usage I have with Claude
> > too. I just hope the industry does not settle on "let the AI review"
> > instead of test/cover approach.
> >
> >> I have been putting off dealing with the PIE issue which blocks buildi=
ng
> >> most ports at the moment,
> >> but there's two pull requests to address it in blitz. When I tried the=
m
> >> I hit some problems, but
> >> maybe I've fixed those in other ways. If I fixed that, I'd know that t=
he
> >> base code works, but
> >> maybe all the pieces aren't in qemu-project yet.
> >>
> >> Based on all that, what's your advice?
> >>
> >
> > In an ideal world, I would advise to upstream the minimum to be able to
> > run hello-world. Once done, add tests for all existing syscalls.
> > Then add new syscalls with their tests. I tend to think that good code
> > is not the one being the most elegant/performant, but the one that you
> > can modify with trust in what you did, which means covered by a test.
>

Hello World was upstreamed about 3 years ago now. The rest has been insanel=
y
slow to get going...


> > In the real world, seems like we don't really have another option than
> > taking it, except if you're ready to spend 6 months to add tests for
> > this series. I'll let other reviewers finish the work for this series.
> >
> > I'm not against the pragmatic approach of taking it, and let it be
> > tested on the field.
>
> +1 from me.
>

Yea, I'm trying to see how close to being able to build something with
Poudriere
(the FreeBSD building tool that has this tightly integrated) was can get.
Right
now I'm running into umtx hangs, which are a joy to debug.


> > It would be unfair considering how the rest of QEMU is not always teste=
d.
>
> True.
>

Yea... I have unfair feelings from time to time, but I've just decided to
push back
on the suggestions that feel that way that don't really help.

I'm working towards having blitz being able to run poudriere again...
Somewhere
between 9.2 and now something broke things, but I think I got those things
fixed,
and then again around 10.1 or 10.2 there was another.  It's one reason I
want it
in upstream: we can then have some minimal acceptance test (that's less
than a
full poudriere bulk build, since that's hours of CPU time) that will
hopefully keep
things from breaking...  Even just 'install freebsd/$ARCH into a jail and
build hello
world' would catch a huge class of bugs. Some basic locking tests would
catch
the rest of the big-ticket items.

Warner


> Helge
>

--000000000000524f8706529afb05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 23,=
 2026 at 12:57=E2=80=AFPM Helge Deller &lt;<a href=3D"mailto:deller@gmx.de"=
>deller@gmx.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 5/23/26 03:19, Pierrick Bouvier wrote:<br>
&gt; On 5/22/2026 5:40 PM, Warner Losh wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Fri, May 22, 2026 at 6:04=E2=80=AFPM Pierrick Bouvier<br>
&gt;&gt; &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com" target=3D=
"_blank">pierrick.bouvier@oss.qualcomm.com</a><br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com" ta=
rget=3D"_blank">pierrick.bouvier@oss.qualcomm.com</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 On 5/18/2026 2:27 PM, Warner Losh wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Upstream the file, thread, socket and rem=
aining signal system<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 calls (too<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; numerous to list here).<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This series is an ambitous use of claude =
to help me upstream all the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; remaining system calls. I&#39;ve batched =
them together in what I think are<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; reasonable chunks, and had claude do the =
grunt work of copying the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 code<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; over and attributing the commits from our=
 complex branching<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 history. The<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; chopping up was a bit arbitrary, but I th=
ink it&#39;s good. The commit<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; messages may be a little weak, but may al=
so be OK. I&#39;ve also double<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; checked the style and made fixes upstream=
 for them as well. Claude<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 also<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; reviewed all these changes and found a fe=
w bugs that I&#39;ve fixed. I&#39;ve<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; personally read through them all and have=
n&#39;t found anything glaring. I<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; fixed all the bugs that were found, in mo=
st cases differently than<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; claude&#39;s suggestions.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ve added &#39;Assisted-by: Claude..=
.&#39; to all these commits to reflect my<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; leaning on Claude so hard. This use falls=
 within the &#39;non-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 creative&#39; use<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; that the Qemu project has said is OK. If =
that&#39;s not the right thing to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; do, I can remove them.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This leaves sysctl translation, the power=
pc architecture support,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; coredumps and a transition to &#39;truss&=
#39; based system call tracing. With<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; these changes applied we&#39;er down from=
 a high of about 30k lines of<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 diffs<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to only 5k (not counting genereted, but c=
hecked in files in<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 blitz). The<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; changes are 8k, so maybe a bit ambitious =
from that perspective as<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 well.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; There&#39;s a few lines over 80 that I&#3=
9;ve not cleaned up. Let me know if<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; that&#39;s a problem. The other warnings =
are about adding files, and<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 there&#39;s<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; no new MAINTAINERS entry needed. And the =
&#39;arch dependent defines<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 should<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; be avoided&#39; are needed to cope with d=
ifferent FreeBSD build systems<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; having different system calls.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Note, this is called out below too, but i=
n v2 I&#39;ve folded back all the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; fixes based on some out-of-band feedback =
I recieved to do this the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; normal way and the qemu project isn&#39;t=
 interested in the fixes to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fixes.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This is a big experiment, in many ways, f=
or me, so I&#39;m interested in<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; whatever feedback you may have to make th=
ings better in the future.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Warner Losh &lt;<a href=3D=
"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a> &lt;mailto:<a =
href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt;&gt;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Changes in v2:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - don&#39;t write offsets on errors for c=
opy_file_range<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - pipe2: Check the raw system call value =
directly<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - setsockopt: Check target_to_host_ip_mre=
q return value<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - &lt;several places&gt;: Check return va=
lue of host_to_target_sockaddr<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - do_bsd_setsockopt: Read in the socket o=
ption<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - ntp_gettime: write back time on non-err=
ors, not just 0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - do_freebsd_sigtimedwait check t2h_freeb=
sd_timespec return<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - do_freebsd_swapcontext writing incorrec=
tly, readonly data (0 to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 user_unlock)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - do_thr_set_name needs get_errno()<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Have ntp_adjtime write back the structu=
re<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - kevent_freebsd11 no need to explicitly =
mask, datatypes do this<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 for us<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - do_freebsd_setcontext just reads the mc=
ontext, 0 in unlock_user<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - target_to_host_sigevent is read-only, s=
o pass 0 in unlock_user<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - target_to_host_ip_mreq needs tswap32 fo=
r int32_t<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - use get_errno on kenv return values to =
report errors better<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - kevent: only copy the number of events =
returns, not whole buffer<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Copy tolerance field of timex<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - freebsd_umtx_sem_wake use VERIFY_READ i=
nstead of write to read<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Avoid double g2h_untagged mistakes in !=
_UMTX_OPTIMIZED<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Fixed additional missing unlock in free=
bsd_rw_rdlock and<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 freebsd_rw_wrlock in !_UMTX_OPTIMIZED<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Squashed all the bug commit back to the=
 appropriate earleir patch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Link to v1: <a href=3D"https://lore.ker=
nel.org/qemu-devel/20260515-" rel=3D"noreferrer" target=3D"_blank">https://=
lore.kernel.org/qemu-devel/20260515-</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:misc-2026q2-v1-0-5438ca41b27=
a@bsdimp.com" target=3D"_blank">misc-2026q2-v1-0-5438ca41b27a@bsdimp.com</a=
> &lt;<a href=3D"https://lore.kernel.org/" rel=3D"noreferrer" target=3D"_bl=
ank">https://lore.kernel.org/</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qemu-devel/<a href=3D"mailto:20260515-misc-202=
6q2-v1-0-5438ca41b27a@bsdimp.com" target=3D"_blank">20260515-misc-2026q2-v1=
-0-5438ca41b27a@bsdimp.com</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Warner Losh (37):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: catch=
up to locking / mapping routines in bsd-misc.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Renam=
e cpu_env to env throughout bsd-user<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add b=
sd-signal.h with sigaction through sigreturn<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
ignal shims sigwait through kill and os-signal.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
ignal system call dispatch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add p=
oll, lseek, pipe, and swap system call shims<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-file.h with pipe2, chflagsat, close_range,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 and more<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add f=
ile operation system call dispatch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add b=
sd-socket.h with bind through getsockname<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
ocket shims socketpair through shutdown<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-socket.h with sendrecvmsg and message<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 structures<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add d=
o_bsd_setsockopt and socket option definitions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add d=
o_bsd_getsockopt<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add F=
reeBSD socket helpers and sockaddr conversion<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-socket.c with cmsg conversion functions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
ocket system call dispatch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-time.h with clock and time-of-day functions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add u=
times, futimes, and ktimer functions to os-time.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
elect, pselect, and ppoll to os-time.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add k=
queue and kevent functions to os-time.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
igtimedwait, itimer, and futimens to os-time.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-time.c and time-related type definitions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add t=
ime system call dispatch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add t=
hread, umtx, and ACL type definitions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add c=
pu_copy and make init_task_state non-static<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-thread.h with thr and context functions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add d=
o_freebsd__umtx_op to os-thread.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-thread.c with umtx, mutex, and thread creation<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add t=
hread system call dispatch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-extattr.h with file and fd extattr functions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add l=
ink and list extattr functions to os-extattr.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add A=
CL system call shims to os-extattr.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add o=
s-extattr.c with ACL conversion functions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add e=
xtended attribute and ACL system call dispatch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
cheduler and cpuset functions to os-misc.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add k=
mod, posix, and misc functions to os-misc.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add s=
cheduler, cpuset, kmod, and misc syscall dispatch<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/aarch64/target.h=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 2 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/arm/target.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/bsd-file.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 164 +++-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/bsd-proc.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A024 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/bsd-signal.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 231 ++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/bsd-socket.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A098 +++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/bsd-socket.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 283 +++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/meson.build=C2=A0 =
|=C2=A0 =C2=A0 8 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-extattr.c |=C2=
=A0 116 +++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-extattr.h |=C2=
=A0 662 ++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-file.h=C2=A0 =
=C2=A0 |=C2=A0 129 ++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-misc.h=C2=A0 =
=C2=A0 |=C2=A0 470 +++++++++++-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-proc.c=C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 4 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-proc.h=C2=A0 =
=C2=A0 |=C2=A0 =C2=A026 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-signal.h=C2=A0 =
|=C2=A0 =C2=A020 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-socket.c=C2=A0 =
|=C2=A0 234 ++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-socket.h=C2=A0 =
|=C2=A0 770 +++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-stat.h=C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 8 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-sys.c=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 4 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-syscall.c |=C2=
=A0 790 +++++++++++++++++--<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-thread.c=C2=A0 =
| 1682 ++++++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 +++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-thread.h=C2=A0 =
|=C2=A0 596 +++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-time.c=C2=A0 =
=C2=A0 |=C2=A0 346 +++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/os-time.h=C2=A0 =
=C2=A0 |=C2=A0 983 ++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/freebsd/qemu-os.h=C2=A0 =
=C2=A0 |=C2=A0 =C2=A048 ++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/i386/target.h=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/main.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A032 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/meson.build=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A026 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A048 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/riscv/target.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/signal-common.h=C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 4 +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/signal.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A067 ++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/syscall_defs.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 458 +++++++++--<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 bsd-user/x86_64/target.h=C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 36 files changed, 8150 insertions(+=
), 196 deletions(-)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; base-commit: edcc429e9e41a8e0e415dcdab6aa=
52ad17ef8889<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; change-id: 20260504-misc-2026q2-a5af31ac0=
32a<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Best regards,<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 After reviewing (what I can) two thirds of the=
 series, I don&#39;t feel very<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 at ease with validating the rest. Not that the=
re is problem in itself,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 but it&#39;s a massive add, and I&#39;m not su=
re how we can ensure it&#39;s<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 implemented correctly without any test exercis=
ing it.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 It&#39;s not particular to bsd-user, linux-use=
r does not have test for all<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 syscalls implemented neither.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Yes. I&#39;d like a low-level test like that. The upstream bsd-use=
r has been too<br>
&gt;&gt; incomplete to run real programs prior to this series. And there&#3=
9;s still some<br>
&gt;&gt; issues that remain after these system calls (which is next up on m=
y list: I<br>
&gt;&gt; think elfload needs some patches for PIE).<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 However, because we are adding most of it at o=
nce, it&#39;s a bit different.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Dropping 8150 new lines at once without any te=
st looks a bit complicated<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 to me.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 A few questions about the series in itself:<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 - Where does most of the implementation comes =
from? Was it downstream on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 FreeBSD side, or written from scratch for this=
 series?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; We&#39;ve had almost all of this code, modulo some big fixes I&#39=
;ve added,=C2=A0 in<br>
&gt;&gt; blitz branch<br>
&gt;&gt; for years. Stacey Son implemented most of this a decade ago now an=
d had some<br>
&gt;&gt; issue upstream at the time, IIRC, but I have only sketchy details =
of the<br>
&gt;&gt; project then.<br>
&gt;&gt;<br>
&gt;&gt; We use it inside our poudriere jails to build thousands of ports t=
o test<br>
&gt;&gt; it. Though there are issues with many ports, enough work to keep g=
oing.<br>
<br>
So, this seems to be similar to what I do, and it&#39;s actually a good tes=
t case for linux-user.<br>
I&#39;m running some debian buildd servers which use qemu-hppa to build deb=
ian packages<br>
for the hppa architecture. With that setup I found quite some bugs in qemu-=
user<br>
and now it&#39;s pretty stable.<br>
<br>
&gt;&gt; I also run a number of random commands in the jail that&#39;s noth=
ing but<br>
&gt;&gt; cross-arch binaries<br>
&gt;&gt; as well.<br>
&gt;&gt;<br>
&gt; <br>
&gt; That&#39;s good to hear this has been used downstream for a long time.=
 That<br>
&gt; was my feeling after our conversation, but just wanted to double check=
 this.<br>
&gt; <br>
&gt;&gt; Sometimes I run the Kyua tests, but it&#39;s a bit hard to read th=
e output<br>
&gt;&gt; because many are broken,<br>
&gt;&gt; many can&#39;t work in qemu or in a jail, and there&#39;s some tha=
t are broken<br>
&gt;&gt; for a given arch. We don&#39;t<br>
&gt;&gt; have good baselines to compare against and I&#39;ve not spent the =
time to<br>
&gt;&gt; get this into good shape.<br>
&gt;&gt;<br>
&gt;&gt; Not the most formal set of things we do, but it works.<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 - How did you validate it works, beyond it com=
piles?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Generally on the blitz side, all of the above. On the qemu-project=
 side,<br>
&gt;&gt; I usually just do the bit<br>
&gt;&gt; about messing around in the jail to test the basics.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m happy cleaving this massive set into some smaller sets if =
that would<br>
&gt;&gt; help, but that still wouldn&#39;t<br>
&gt;&gt; answer the &#39;how the heck do we test it&#39;.<br>
&gt;&gt;<br>
&gt; <br>
&gt; It would require a massive effort for no benefit, since it doesn&#39;t=
<br>
&gt; increase testability of the whole.<br>
&gt; <br>
&gt;&gt; I&#39;ve also had claude do code reviews of this branch. It&#39;s =
found maybe<br>
&gt;&gt; 100 bugs that I&#39;ve fixed<br>
&gt;&gt; (maybe 25 more between v2 and v3). The vast majority of the bugs a=
re<br>
&gt;&gt; lock/unlock issues. Either<br>
&gt;&gt; leaks on error paths, failure to check for TARGET_EFAULT in places=
 or<br>
&gt;&gt; passing args that don&#39;t<br>
&gt;&gt; matter unless you compile CONFIG_DEBUG_REMAP to indicate copying, =
etc.<br>
&gt;&gt; Some real bugs<br>
&gt;&gt; have been found, including one that might lead to a multi-threaded=
 hang.<br>
&gt;&gt;<br>
&gt; <br>
&gt; This is better than nothing, and it&#39;s a common usage I have with C=
laude<br>
&gt; too. I just hope the industry does not settle on &quot;let the AI revi=
ew&quot;<br>
&gt; instead of test/cover approach.<br>
&gt; <br>
&gt;&gt; I have been putting off dealing with the PIE issue which blocks bu=
ilding<br>
&gt;&gt; most ports at the moment,<br>
&gt;&gt; but there&#39;s two pull requests to address it in blitz. When I t=
ried them<br>
&gt;&gt; I hit some problems, but<br>
&gt;&gt; maybe I&#39;ve fixed those in other ways. If I fixed that, I&#39;d=
 know that the<br>
&gt;&gt; base code works, but<br>
&gt;&gt; maybe all the pieces aren&#39;t in qemu-project yet.<br>
&gt;&gt;<br>
&gt;&gt; Based on all that, what&#39;s your advice?<br>
&gt;&gt;<br>
&gt; <br>
&gt; In an ideal world, I would advise to upstream the minimum to be able t=
o<br>
&gt; run hello-world. Once done, add tests for all existing syscalls.<br>
&gt; Then add new syscalls with their tests. I tend to think that good code=
<br>
&gt; is not the one being the most elegant/performant, but the one that you=
<br>
&gt; can modify with trust in what you did, which means covered by a test.<=
br></blockquote><div><br></div><div>Hello World was upstreamed about 3 year=
s ago now. The rest has been insanely</div><div>slow to get going...</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; In the real world, seems like we don&#39;t really have another option =
than<br>
&gt; taking it, except if you&#39;re ready to spend 6 months to add tests f=
or<br>
&gt; this series. I&#39;ll let other reviewers finish the work for this ser=
ies.<br>
&gt; <br>
&gt; I&#39;m not against the pragmatic approach of taking it, and let it be=
<br>
&gt; tested on the field. <br>
<br>
+1 from me.<br></blockquote><div><br></div><div>Yea, I&#39;m trying to see =
how close to being able to build something with Poudriere</div><div>(the Fr=
eeBSD building tool that has this tightly integrated) was can get. Right</d=
iv><div>now I&#39;m running into umtx hangs, which are a joy to debug.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; It would be unfair considering how the rest of QEMU is not always test=
ed.<br>
<br>
True.<br></blockquote><div><br></div><div>Yea... I have unfair feelings fro=
m time to time, but I&#39;ve just decided to push back</div><div>on the sug=
gestions that feel that way that don&#39;t really help.</div><div><br></div=
><div>I&#39;m working towards having blitz being able to run poudriere agai=
n... Somewhere</div><div>between 9.2 and now something broke things, but I =
think I got those things fixed,</div><div>and then again around 10.1 or 10.=
2 there was another.=C2=A0 It&#39;s one reason I want it</div><div>in upstr=
eam: we can then have some minimal acceptance test (that&#39;s less than a<=
/div><div>full poudriere bulk build, since that&#39;s hours of CPU time) th=
at will hopefully keep</div><div>things from breaking...=C2=A0 Even just &#=
39;install freebsd/$ARCH into a jail and build hello</div><div>world&#39; w=
ould catch a huge class of bugs. Some basic locking tests would catch</div>=
<div>the rest of the big-ticket items.</div><div><br></div><div>Warner</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Helge<br>
</blockquote></div></div>

--000000000000524f8706529afb05--

