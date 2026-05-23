Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0BDCD5BBF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 00:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQaRd-0000jv-9H; Fri, 22 May 2026 20:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wQaR9-0000dK-KE
 for qemu-devel@nongnu.org; Fri, 22 May 2026 20:41:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wQaQS-00038c-Uc
 for qemu-devel@nongnu.org; Fri, 22 May 2026 20:41:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-83945063f70so4257464b3a.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779496815; cv=none;
 d=google.com; s=arc-20240605;
 b=V3wYAho5KlFNtdiIfov+UaZizlR0VbrnDgLdQf4++3K7KfskMkG0899b9Zsdm5Pr9s
 Z3SxbD/kPyiGpUTVLcbtIMpPgR02kYpuMs9j9J/0Xwt0cuwpjvmO2QYE7ris+FSuiE/9
 pC5Hn7kTTRHbFExUlMhybeZKHGXrm0VjxulJMwmSuJKkkm4ZVsVqC7FG5qyzj1FWuJvL
 EuDKrdlmA9914oJSg1h5/KEyZBhQTN/ozX0tRCBagzGudUDATlA65QN0TzvKcsLKBaVe
 nsNClhT9MJoqBQRe/kHHfGQVbHIcE7U2VS+ikoQ9lQ7isdV94Kr0L2UW/OvawCbrl4Hm
 VCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yl38I9vsqlPNHlJ2yxtEfilaSxfztpN8XKzEIZ6GGI8=;
 fh=WVFoUxpitbfPE6edZqBEwYrbPPmwXPHB2+UNH3xZyKY=;
 b=YQBp3LZ+au3O71b6DzyhS1srJcZin1y1GMK2TZePrS0Z9FM2VDlq7LxuNrzEK0htf4
 tg2982JJfWgX9ESu+MN41q0dZtAUY7mi0NSulQO5O3AopjmrMQWb1jiPTggEZKtTmDO/
 3C4xeTikpPaWPlXWy/U64YEhPJ/7T5dpZfZSF+D2GOYAbUr03wt6M5IFXjjFS5kZfqI0
 ujypcvC++LLfN7b/84hpBHWY8oJeI6X+ELDVv0skc0FVnLOJ00xh1B3qdoz2i25IS47F
 OpfA1di3va3+hbyBw4Xs2F3UTLVgYL/Q8ZvKCj39Bkfl7Dc9jaHD9vAQczXmKTXkZOE9
 O/4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779496815; x=1780101615;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yl38I9vsqlPNHlJ2yxtEfilaSxfztpN8XKzEIZ6GGI8=;
 b=G8p+521Jx/sZ5PQ8W5JR2jIQeGd5bg43lxY0W9Dzyzpe7H3p8zf6Vzet5Xsh/Y1PvR
 qMSOkrbRfyJ4pEhFQp9nErqHaEt+dzLCsVHYR4g48weOEW8zJIl5nmRAc7kiFhBQkylN
 2yXHtl0qFzhTTtkay2pvLYxPJoxYQuFsnlr1gphTu3awV53WzrE6c2mb0JnpL5qZyrXU
 FQn/O7bnQggROJSaCWJAg/HqyP9t23Aq9Rt+Xd3ngjVkG/F6mu3dBHgwFG1qYHtklwuD
 4wmNf6pa1QRwuFdWVVHTdGtk0E0KZxcqSEmFHXfoqblsKDmvAE7daVmLfk4wFm8Dk9Gz
 DsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779496815; x=1780101615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yl38I9vsqlPNHlJ2yxtEfilaSxfztpN8XKzEIZ6GGI8=;
 b=BznJ5ucIHkXE14a1Bkj6Qe/HFyFATUY7b+dOcqAxoQxXex1y4dAFFmluSefZmB5qbz
 wsnuJqet4+Ofs63civRTrmfmPRj1zlZ+kdhBxMegxNhbs0VioSJLsDUwbkwwKZJfrbRb
 svJMBBXQqu+W7zD52351rlAqAZ4PH99ic7M79ltfRBwNcsVQgeHIAQxFP3Tkig7eW9Wl
 rkwB9as8BvyH4KWzoWePQHE6/tSLFIpD4xLaxAYyraWLaHCcpWUNiiR6VOUJjjEr+xGg
 jlAui5Wg+ywDe7i1pFAVqqLcb07xAI4H54uf7j/jrf+OJEqhyUvfTHXbXvU2P3ELEjXl
 +QLQ==
X-Gm-Message-State: AOJu0YxX52AB7XJpiM7TAFT4GrHc3s21qtvbF17JqUnH28a+gVroUeLx
 /F5/ktOrsvpq/+BCmQfgadRPytuN+hnJEAJGhGQEzFVkH99KxWitJLDgb7KATkYNBZmpHcvBh4a
 CMGKTarFRwQ/U4w0flqYV9CR+rkMoK4jkG8HBTLFPrw==
X-Gm-Gg: Acq92OF+uIjGtE03x37H/ggarvhcS4jliGWJzvf01kC5SypvmpydscNK7ta+0T8lkb5
 bWGNZX1takkrpRu7QBZ7MFTkFFVhzq9xgEHxhyQBmmg2l6wa2Kikw2UH+IloM6dbHlPq4PRBYkb
 KvX3bSLTju8PhGAmv+nX+c/PPO2t5c0Ftz5PsxZNUyoZUojUm1nc4Jhow47Pp6ba6Hrp1XpivJt
 COzaG8bHx9A/aEJoe3nKRMSsN738FAYoH+HTa2t9ba/HJmwtR19004FWZkBTSunm7eYxb34cAE+
 kP/3U0w=
X-Received: by 2002:a05:6a20:5493:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3b307fa1205mr9236946637.35.1779496814606; Fri, 22 May 2026
 17:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <d840bb59-b30d-4955-b570-32f8d2ffc60a@oss.qualcomm.com>
In-Reply-To: <d840bb59-b30d-4955-b570-32f8d2ffc60a@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 22 May 2026 18:40:03 -0600
X-Gm-Features: AVHnY4JRo4fvTH8G5HuGw5sIimEDf9YXhNj3tMI0lQK1g47B3nWEC8VqyDKKZ4A
Message-ID: <CANCZdfqoPUt1Dd55FAZOnxoe1wUSxQGzP1Rp=zRZkY6vC6iOfg@mail.gmail.com>
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000008387a106527163f7"
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42b.google.com
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

--0000000000008387a106527163f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 6:04=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Upstream the file, thread, socket and remaining signal system calls (to=
o
> > numerous to list here).
> >
> > This series is an ambitous use of claude to help me upstream all the
> > remaining system calls. I've batched them together in what I think are
> > reasonable chunks, and had claude do the grunt work of copying the code
> > over and attributing the commits from our complex branching history. Th=
e
> > chopping up was a bit arbitrary, but I think it's good. The commit
> > messages may be a little weak, but may also be OK. I've also double
> > checked the style and made fixes upstream for them as well. Claude also
> > reviewed all these changes and found a few bugs that I've fixed. I've
> > personally read through them all and haven't found anything glaring. I
> > fixed all the bugs that were found, in most cases differently than
> > claude's suggestions.
> >
> > I've added 'Assisted-by: Claude...' to all these commits to reflect my
> > leaning on Claude so hard. This use falls within the 'non-creative' use
> > that the Qemu project has said is OK. If that's not the right thing to
> > do, I can remove them.
> >
> > This leaves sysctl translation, the powerpc architecture support,
> > coredumps and a transition to 'truss' based system call tracing. With
> > these changes applied we'er down from a high of about 30k lines of diff=
s
> > to only 5k (not counting genereted, but checked in files in blitz). The
> > changes are 8k, so maybe a bit ambitious from that perspective as well.
> >
> > There's a few lines over 80 that I've not cleaned up. Let me know if
> > that's a problem. The other warnings are about adding files, and there'=
s
> > no new MAINTAINERS entry needed. And the 'arch dependent defines should
> > be avoided' are needed to cope with different FreeBSD build systems
> > having different system calls.
> >
> > Note, this is called out below too, but in v2 I've folded back all the
> > fixes based on some out-of-band feedback I recieved to do this the
> > normal way and the qemu project isn't interested in the fixes to fixes.
> >
> > This is a big experiment, in many ways, for me, so I'm interested in
> > whatever feedback you may have to make things better in the future.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> > Changes in v2:
> > - don't write offsets on errors for copy_file_range
> > - pipe2: Check the raw system call value directly
> > - setsockopt: Check target_to_host_ip_mreq return value
> > - <several places>: Check return value of host_to_target_sockaddr
> > - do_bsd_setsockopt: Read in the socket option
> > - ntp_gettime: write back time on non-errors, not just 0
> > - do_freebsd_sigtimedwait check t2h_freebsd_timespec return
> > - do_freebsd_swapcontext writing incorrectly, readonly data (0 to
> user_unlock)
> > - do_thr_set_name needs get_errno()
> > - Have ntp_adjtime write back the structure
> > - kevent_freebsd11 no need to explicitly mask, datatypes do this for us
> > - do_freebsd_setcontext just reads the mcontext, 0 in unlock_user
> > - target_to_host_sigevent is read-only, so pass 0 in unlock_user
> > - target_to_host_ip_mreq needs tswap32 for int32_t
> > - use get_errno on kenv return values to report errors better
> > - kevent: only copy the number of events returns, not whole buffer
> > - Copy tolerance field of timex
> > - freebsd_umtx_sem_wake use VERIFY_READ instead of write to read struct
> > - Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
> > - Fixed additional missing unlock in freebsd_rw_rdlock and
> freebsd_rw_wrlock in !_UMTX_OPTIMIZED
> > - Squashed all the bug commit back to the appropriate earleir patch
> > - Link to v1:
> https://lore.kernel.org/qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a=
@bsdimp.com
> >
> > ---
> > Warner Losh (37):
> >       bsd-user: catchup to locking / mapping routines in bsd-misc.
> >       bsd-user: Rename cpu_env to env throughout bsd-user
> >       bsd-user: Add bsd-signal.h with sigaction through sigreturn
> >       bsd-user: Add signal shims sigwait through kill and os-signal.h
> >       bsd-user: Add signal system call dispatch
> >       bsd-user: Add poll, lseek, pipe, and swap system call shims
> >       bsd-user: Add os-file.h with pipe2, chflagsat, close_range, and
> more
> >       bsd-user: Add file operation system call dispatch
> >       bsd-user: Add bsd-socket.h with bind through getsockname
> >       bsd-user: Add socket shims socketpair through shutdown
> >       bsd-user: Add os-socket.h with sendrecvmsg and message structures
> >       bsd-user: Add do_bsd_setsockopt and socket option definitions
> >       bsd-user: Add do_bsd_getsockopt
> >       bsd-user: Add FreeBSD socket helpers and sockaddr conversion
> >       bsd-user: Add os-socket.c with cmsg conversion functions
> >       bsd-user: Add socket system call dispatch
> >       bsd-user: Add os-time.h with clock and time-of-day functions
> >       bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
> >       bsd-user: Add select, pselect, and ppoll to os-time.h
> >       bsd-user: Add kqueue and kevent functions to os-time.h
> >       bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
> >       bsd-user: Add os-time.c and time-related type definitions
> >       bsd-user: Add time system call dispatch
> >       bsd-user: Add thread, umtx, and ACL type definitions
> >       bsd-user: Add cpu_copy and make init_task_state non-static
> >       bsd-user: Add os-thread.h with thr and context functions
> >       bsd-user: Add do_freebsd__umtx_op to os-thread.h
> >       bsd-user: Add os-thread.c with umtx, mutex, and thread creation
> >       bsd-user: Add thread system call dispatch
> >       bsd-user: Add os-extattr.h with file and fd extattr functions
> >       bsd-user: Add link and list extattr functions to os-extattr.h
> >       bsd-user: Add ACL system call shims to os-extattr.h
> >       bsd-user: Add os-extattr.c with ACL conversion functions
> >       bsd-user: Add extended attribute and ACL system call dispatch
> >       bsd-user: Add scheduler and cpuset functions to os-misc.h
> >       bsd-user: Add kmod, posix, and misc functions to os-misc.h
> >       bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
> >
> >  bsd-user/aarch64/target.h     |    2 +-
> >  bsd-user/arm/target.h         |    2 +-
> >  bsd-user/bsd-file.h           |  164 +++-
> >  bsd-user/bsd-mem.h            |    4 +-
> >  bsd-user/bsd-proc.h           |   24 +-
> >  bsd-user/bsd-signal.h         |  231 ++++++
> >  bsd-user/bsd-socket.c         |   98 +++
> >  bsd-user/bsd-socket.h         |  283 +++++++
> >  bsd-user/freebsd/meson.build  |    8 +-
> >  bsd-user/freebsd/os-extattr.c |  116 +++
> >  bsd-user/freebsd/os-extattr.h |  662 ++++++++++++++++
> >  bsd-user/freebsd/os-file.h    |  129 ++++
> >  bsd-user/freebsd/os-misc.h    |  470 +++++++++++-
> >  bsd-user/freebsd/os-proc.c    |    4 +-
> >  bsd-user/freebsd/os-proc.h    |   26 +-
> >  bsd-user/freebsd/os-signal.h  |   20 +
> >  bsd-user/freebsd/os-socket.c  |  234 ++++++
> >  bsd-user/freebsd/os-socket.h  |  770 +++++++++++++++++++
> >  bsd-user/freebsd/os-stat.h    |    8 +-
> >  bsd-user/freebsd/os-sys.c     |    4 +-
> >  bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
> >  bsd-user/freebsd/os-thread.c  | 1682
> +++++++++++++++++++++++++++++++++++++++++
> >  bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
> >  bsd-user/freebsd/os-time.c    |  346 +++++++++
> >  bsd-user/freebsd/os-time.h    |  983 ++++++++++++++++++++++++
> >  bsd-user/freebsd/qemu-os.h    |   48 ++
> >  bsd-user/i386/target.h        |    2 +-
> >  bsd-user/main.c               |   32 +-
> >  bsd-user/meson.build          |    1 +
> >  bsd-user/qemu-bsd.h           |   26 +
> >  bsd-user/qemu.h               |   48 +-
> >  bsd-user/riscv/target.h       |    2 +-
> >  bsd-user/signal-common.h      |    4 +
> >  bsd-user/signal.c             |   67 ++
> >  bsd-user/syscall_defs.h       |  458 +++++++++--
> >  bsd-user/x86_64/target.h      |    2 +-
> >  36 files changed, 8150 insertions(+), 196 deletions(-)
> > ---
> > base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
> > change-id: 20260504-misc-2026q2-a5af31ac032a
> >
> > Best regards,
>
> After reviewing (what I can) two thirds of the series, I don't feel very
> at ease with validating the rest. Not that there is problem in itself,
> but it's a massive add, and I'm not sure how we can ensure it's
> implemented correctly without any test exercising it.
> It's not particular to bsd-user, linux-user does not have test for all
> syscalls implemented neither.
>

Yes. I'd like a low-level test like that. The upstream bsd-user has been to=
o
incomplete to run real programs prior to this series. And there's still som=
e
issues that remain after these system calls (which is next up on my list: I
think elfload needs some patches for PIE).


> However, because we are adding most of it at once, it's a bit different.
> Dropping 8150 new lines at once without any test looks a bit complicated
> to me.
>
> A few questions about the series in itself:
> - Where does most of the implementation comes from? Was it downstream on
> FreeBSD side, or written from scratch for this series?
>

We've had almost all of this code, modulo some big fixes I've added,  in
blitz branch
for years. Stacey Son implemented most of this a decade ago now and had som=
e
issue upstream at the time, IIRC, but I have only sketchy details of the
project then.

We use it inside our poudriere jails to build thousands of ports to test
it. Though there
are issues with many ports, enough work to keep going.

I also run a number of random commands in the jail that's nothing but
cross-arch binaries
as well.

Sometimes I run the Kyua tests, but it's a bit hard to read the output
because many are broken,
many can't work in qemu or in a jail, and there's some that are broken for
a given arch. We don't
have good baselines to compare against and I've not spent the time to get
this into good shape.

Not the most formal set of things we do, but it works.


> - How did you validate it works, beyond it compiles?
>

Generally on the blitz side, all of the above. On the qemu-project side, I
usually just do the bit
about messing around in the jail to test the basics.

I'm happy cleaving this massive set into some smaller sets if that would
help, but that still wouldn't
answer the 'how the heck do we test it'.

I've also had claude do code reviews of this branch. It's found maybe 100
bugs that I've fixed
(maybe 25 more between v2 and v3). The vast majority of the bugs are
lock/unlock issues. Either
leaks on error paths, failure to check for TARGET_EFAULT in places or
passing args that don't
matter unless you compile CONFIG_DEBUG_REMAP to indicate copying, etc. Some
real bugs
have been found, including one that might lead to a multi-threaded hang.

I have been putting off dealing with the PIE issue which blocks building
most ports at the moment,
but there's two pull requests to address it in blitz. When I tried them I
hit some problems, but
maybe I've fixed those in other ways. If I fixed that, I'd know that the
base code works, but
maybe all the pieces aren't in qemu-project yet.

Based on all that, what's your advice?

Warner



> Regards,
> Pierrick
>

--0000000000008387a106527163f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 6:04=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Upstream the file, thread, socket and remaining signal system calls (t=
oo<br>
&gt; numerous to list here).<br>
&gt; <br>
&gt; This series is an ambitous use of claude to help me upstream all the<b=
r>
&gt; remaining system calls. I&#39;ve batched them together in what I think=
 are<br>
&gt; reasonable chunks, and had claude do the grunt work of copying the cod=
e<br>
&gt; over and attributing the commits from our complex branching history. T=
he<br>
&gt; chopping up was a bit arbitrary, but I think it&#39;s good. The commit=
<br>
&gt; messages may be a little weak, but may also be OK. I&#39;ve also doubl=
e<br>
&gt; checked the style and made fixes upstream for them as well. Claude als=
o<br>
&gt; reviewed all these changes and found a few bugs that I&#39;ve fixed. I=
&#39;ve<br>
&gt; personally read through them all and haven&#39;t found anything glarin=
g. I<br>
&gt; fixed all the bugs that were found, in most cases differently than<br>
&gt; claude&#39;s suggestions.<br>
&gt; <br>
&gt; I&#39;ve added &#39;Assisted-by: Claude...&#39; to all these commits t=
o reflect my<br>
&gt; leaning on Claude so hard. This use falls within the &#39;non-creative=
&#39; use<br>
&gt; that the Qemu project has said is OK. If that&#39;s not the right thin=
g to<br>
&gt; do, I can remove them.<br>
&gt; <br>
&gt; This leaves sysctl translation, the powerpc architecture support,<br>
&gt; coredumps and a transition to &#39;truss&#39; based system call tracin=
g. With<br>
&gt; these changes applied we&#39;er down from a high of about 30k lines of=
 diffs<br>
&gt; to only 5k (not counting genereted, but checked in files in blitz). Th=
e<br>
&gt; changes are 8k, so maybe a bit ambitious from that perspective as well=
.<br>
&gt; <br>
&gt; There&#39;s a few lines over 80 that I&#39;ve not cleaned up. Let me k=
now if<br>
&gt; that&#39;s a problem. The other warnings are about adding files, and t=
here&#39;s<br>
&gt; no new MAINTAINERS entry needed. And the &#39;arch dependent defines s=
hould<br>
&gt; be avoided&#39; are needed to cope with different FreeBSD build system=
s<br>
&gt; having different system calls.<br>
&gt; <br>
&gt; Note, this is called out below too, but in v2 I&#39;ve folded back all=
 the<br>
&gt; fixes based on some out-of-band feedback I recieved to do this the<br>
&gt; normal way and the qemu project isn&#39;t interested in the fixes to f=
ixes.<br>
&gt; <br>
&gt; This is a big experiment, in many ways, for me, so I&#39;m interested =
in<br>
&gt; whatever feedback you may have to make things better in the future.<br=
>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - don&#39;t write offsets on errors for copy_file_range<br>
&gt; - pipe2: Check the raw system call value directly<br>
&gt; - setsockopt: Check target_to_host_ip_mreq return value<br>
&gt; - &lt;several places&gt;: Check return value of host_to_target_sockadd=
r<br>
&gt; - do_bsd_setsockopt: Read in the socket option<br>
&gt; - ntp_gettime: write back time on non-errors, not just 0<br>
&gt; - do_freebsd_sigtimedwait check t2h_freebsd_timespec return<br>
&gt; - do_freebsd_swapcontext writing incorrectly, readonly data (0 to user=
_unlock)<br>
&gt; - do_thr_set_name needs get_errno()<br>
&gt; - Have ntp_adjtime write back the structure<br>
&gt; - kevent_freebsd11 no need to explicitly mask, datatypes do this for u=
s<br>
&gt; - do_freebsd_setcontext just reads the mcontext, 0 in unlock_user<br>
&gt; - target_to_host_sigevent is read-only, so pass 0 in unlock_user<br>
&gt; - target_to_host_ip_mreq needs tswap32 for int32_t<br>
&gt; - use get_errno on kenv return values to report errors better<br>
&gt; - kevent: only copy the number of events returns, not whole buffer<br>
&gt; - Copy tolerance field of timex<br>
&gt; - freebsd_umtx_sem_wake use VERIFY_READ instead of write to read struc=
t<br>
&gt; - Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED<br>
&gt; - Fixed additional missing unlock in freebsd_rw_rdlock and freebsd_rw_=
wrlock in !_UMTX_OPTIMIZED<br>
&gt; - Squashed all the bug commit back to the appropriate earleir patch<br=
>
&gt; - Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260515-m=
isc-2026q2-v1-0-5438ca41b27a@bsdimp.com" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27=
a@bsdimp.com</a><br>
&gt; <br>
&gt; ---<br>
&gt; Warner Losh (37):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: catchup to locking / mapping routi=
nes in bsd-misc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Rename cpu_env to env throughout b=
sd-user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add bsd-signal.h with sigaction th=
rough sigreturn<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add signal shims sigwait through k=
ill and os-signal.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add signal system call dispatch<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add poll, lseek, pipe, and swap sy=
stem call shims<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-file.h with pipe2, chflagsa=
t, close_range, and more<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add file operation system call dis=
patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add bsd-socket.h with bind through=
 getsockname<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add socket shims socketpair throug=
h shutdown<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-socket.h with sendrecvmsg a=
nd message structures<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_bsd_setsockopt and socket o=
ption definitions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_bsd_getsockopt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add FreeBSD socket helpers and soc=
kaddr conversion<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-socket.c with cmsg conversi=
on functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add socket system call dispatch<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-time.h with clock and time-=
of-day functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add utimes, futimes, and ktimer fu=
nctions to os-time.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add select, pselect, and ppoll to =
os-time.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add kqueue and kevent functions to=
 os-time.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add sigtimedwait, itimer, and futi=
mens to os-time.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-time.c and time-related typ=
e definitions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add time system call dispatch<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add thread, umtx, and ACL type def=
initions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add cpu_copy and make init_task_st=
ate non-static<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-thread.h with thr and conte=
xt functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add do_freebsd__umtx_op to os-thre=
ad.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-thread.c with umtx, mutex, =
and thread creation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add thread system call dispatch<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-extattr.h with file and fd =
extattr functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add link and list extattr function=
s to os-extattr.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add ACL system call shims to os-ex=
tattr.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add os-extattr.c with ACL conversi=
on functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add extended attribute and ACL sys=
tem call dispatch<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add scheduler and cpuset functions=
 to os-misc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add kmod, posix, and misc function=
s to os-misc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bsd-user: Add scheduler, cpuset, kmod, and m=
isc syscall dispatch<br>
&gt; <br>
&gt;=C2=A0 bsd-user/aarch64/target.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-=
<br>
&gt;=C2=A0 bsd-user/arm/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 2 +-<br>
&gt;=C2=A0 bsd-user/bsd-file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 164 +++-<br>
&gt;=C2=A0 bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 4 +-<br>
&gt;=C2=A0 bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A024 +-<br>
&gt;=C2=A0 bsd-user/bsd-signal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
31 ++++++<br>
&gt;=C2=A0 bsd-user/bsd-socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A098 +++<br>
&gt;=C2=A0 bsd-user/bsd-socket.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
83 +++++++<br>
&gt;=C2=A0 bsd-user/freebsd/meson.build=C2=A0 |=C2=A0 =C2=A0 8 +-<br>
&gt;=C2=A0 bsd-user/freebsd/os-extattr.c |=C2=A0 116 +++<br>
&gt;=C2=A0 bsd-user/freebsd/os-extattr.h |=C2=A0 662 ++++++++++++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-file.h=C2=A0 =C2=A0 |=C2=A0 129 ++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 |=C2=A0 470 +++++++++++-=
<br>
&gt;=C2=A0 bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +-<br>
&gt;=C2=A0 bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 |=C2=A0 =C2=A026 +-<br>
&gt;=C2=A0 bsd-user/freebsd/os-signal.h=C2=A0 |=C2=A0 =C2=A020 +<br>
&gt;=C2=A0 bsd-user/freebsd/os-socket.c=C2=A0 |=C2=A0 234 ++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-socket.h=C2=A0 |=C2=A0 770 +++++++++++++++++=
++<br>
&gt;=C2=A0 bsd-user/freebsd/os-stat.h=C2=A0 =C2=A0 |=C2=A0 =C2=A0 8 +-<br>
&gt;=C2=A0 bsd-user/freebsd/os-sys.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +-=
<br>
&gt;=C2=A0 bsd-user/freebsd/os-syscall.c |=C2=A0 790 +++++++++++++++++--<br=
>
&gt;=C2=A0 bsd-user/freebsd/os-thread.c=C2=A0 | 1682 ++++++++++++++++++++++=
+++++++++++++++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-thread.h=C2=A0 |=C2=A0 596 +++++++++++++++<b=
r>
&gt;=C2=A0 bsd-user/freebsd/os-time.c=C2=A0 =C2=A0 |=C2=A0 346 +++++++++<br=
>
&gt;=C2=A0 bsd-user/freebsd/os-time.h=C2=A0 =C2=A0 |=C2=A0 983 ++++++++++++=
++++++++++++<br>
&gt;=C2=A0 bsd-user/freebsd/qemu-os.h=C2=A0 =C2=A0 |=C2=A0 =C2=A048 ++<br>
&gt;=C2=A0 bsd-user/i386/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
 2 +-<br>
&gt;=C2=A0 bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A032 +-<br>
&gt;=C2=A0 bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 1 +<br>
&gt;=C2=A0 bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A026 +<br>
&gt;=C2=A0 bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A048 +-<br>
&gt;=C2=A0 bsd-user/riscv/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
 2 +-<br>
&gt;=C2=A0 bsd-user/signal-common.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +<=
br>
&gt;=C2=A0 bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A067 ++<br>
&gt;=C2=A0 bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 458 ++=
+++++++--<br>
&gt;=C2=A0 bsd-user/x86_64/target.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-=
<br>
&gt;=C2=A0 36 files changed, 8150 insertions(+), 196 deletions(-)<br>
&gt; ---<br>
&gt; base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889<br>
&gt; change-id: 20260504-misc-2026q2-a5af31ac032a<br>
&gt; <br>
&gt; Best regards,<br>
<br>
After reviewing (what I can) two thirds of the series, I don&#39;t feel ver=
y<br>
at ease with validating the rest. Not that there is problem in itself,<br>
but it&#39;s a massive add, and I&#39;m not sure how we can ensure it&#39;s=
<br>
implemented correctly without any test exercising it.<br>
It&#39;s not particular to bsd-user, linux-user does not have test for all<=
br>
syscalls implemented neither.<br></blockquote><div><br></div><div>Yes. I&#3=
9;d like a low-level test like that. The upstream bsd-user has been too</di=
v><div>incomplete to run real programs prior to this series. And there&#39;=
s still some</div><div>issues that remain after these system calls (which i=
s next up on my list: I</div><div>think elfload needs some patches for PIE)=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
However, because we are adding most of it at once, it&#39;s a bit different=
.<br>
Dropping 8150 new lines at once without any test looks a bit complicated<br=
>
to me.<br>
<br>
A few questions about the series in itself:<br>
- Where does most of the implementation comes from? Was it downstream on<br=
>
FreeBSD side, or written from scratch for this series?<br></blockquote><div=
><br></div><div>We&#39;ve had almost all of this code, modulo some big fixe=
s I&#39;ve added,=C2=A0 in blitz branch</div><div>for years. Stacey Son imp=
lemented most of this a decade ago now and had some</div><div>issue upstrea=
m at the time, IIRC, but I have only sketchy details of the project then.</=
div><div><br></div><div>We use it inside our poudriere jails to build thous=
ands of ports to test it. Though there</div><div>are issues with many ports=
, enough work to keep going.</div><div><br></div><div>I also run a number o=
f random commands in the jail that&#39;s nothing but cross-arch binaries</d=
iv><div>as well.</div><div><br></div><div>Sometimes I run the Kyua tests, b=
ut it&#39;s a bit hard to read the output because many are broken,</div><di=
v>many can&#39;t work in qemu or in a jail, and there&#39;s some that are b=
roken for a given arch. We don&#39;t</div><div>have good baselines to compa=
re against and I&#39;ve not spent the time to get this into good shape.</di=
v><div><br></div><div>Not the most formal set of things we do, but it works=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
- How did you validate it works, beyond it compiles?<br></blockquote><div><=
br></div><div>Generally on the blitz side, all of the above. On the qemu-pr=
oject side, I usually just do the bit</div><div>about messing around in the=
 jail to test the basics.</div><div><br></div><div>I&#39;m happy cleaving t=
his massive set into some smaller sets if that would help, but that still w=
ouldn&#39;t</div><div>answer the &#39;how the heck do we test it&#39;.</div=
><div><br></div><div><span style=3D"background-color:rgb(231,242,255)">I&#3=
9;ve also had claude do code reviews of this branch. It&#39;s found maybe 1=
00 bugs that I&#39;ve fixed</span></div><div><span style=3D"background-colo=
r:rgb(231,242,255)">(maybe 25 more between v2 and v3). The vast majority of=
 the bugs are lock/unlock issues. Either</span></div><div><span style=3D"ba=
ckground-color:rgb(231,242,255)">leaks on error paths, failure to check for=
 TARGET_EFAULT in places or passing args that don&#39;t</span></div><div><s=
pan style=3D"background-color:rgb(231,242,255)">matter unless you compile C=
ONFIG_DEBUG_REMAP to indicate copying, etc. Some real bugs</span></div><div=
><span style=3D"background-color:rgb(231,242,255)">have been found, includi=
ng one that might lead to a multi-threaded hang.</span></div><div><span sty=
le=3D"background-color:rgb(231,242,255)"><br></span></div><div><span style=
=3D"background-color:rgb(231,242,255)">I have been putting off dealing with=
 the PIE issue which blocks building most ports at the moment,</span></div>=
<div><span style=3D"background-color:rgb(231,242,255)">but there&#39;s two =
pull requests to address it in blitz. When I tried them I hit some problems=
, but</span></div><div><span style=3D"background-color:rgb(231,242,255)">ma=
ybe I&#39;ve fixed those in other ways. If I fixed that, I&#39;d know that =
the base code works, but</span></div><div><span style=3D"background-color:r=
gb(231,242,255)">maybe all the pieces aren&#39;t in qemu-project yet.</span=
></div><div><span style=3D"background-color:rgb(231,242,255)"><br></span></=
div><div><span style=3D"background-color:rgb(231,242,255)">Based on all tha=
t, what&#39;s your advice?</span></div><div><span style=3D"background-color=
:rgb(231,242,255)"><br></span></div><div><span style=3D"background-color:rg=
b(231,242,255)">Warner</span></div><div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
Regards,<br>
Pierrick<br>
</blockquote></div></div>

--0000000000008387a106527163f7--

