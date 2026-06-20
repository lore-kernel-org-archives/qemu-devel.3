Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34DCDB46B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 03:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wamgY-0007jS-1f; Fri, 19 Jun 2026 23:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wamgS-0007j4-OA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 23:47:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wamgO-00058L-Jm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 23:47:52 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so1657676a91.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 20:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781927267; cv=none;
 d=google.com; s=arc-20240605;
 b=jfMImVqKcDJgbrTaDE0WOx9kbPu6oiNSZalGeIfQmH9ZVCKbKjOmxEaxzO7FY/uGWK
 L6v2JapOVatl3ZbhsBa/5r6QFoG3p5BXVDTCSD6n5Tnn2R0PkuBxMejM/K3R2UrGcExW
 0JqrbieFMx+cBOhtpejEOHL5TfRdPF0LvNKqV1ZIEfq6r8zVJjaZk4LaxIrOrsdP9aW2
 TsR6X+j/S/NwZ9nvh4zmxKt1XMntj6tCpBZFnAoYt6Q0OHcsBiYL8mMVoOSLI9yFceTC
 ppS3+K/jhP5O6VHWQjkGyazt6tVJIGOnKpvLP+7nv1SmWmhzLM5DLVo8prkkchq75+AJ
 9rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OSqSpS9REYaS3P+xfs3ijgJxweYk/MK84xv+vx5S5Ew=;
 fh=tChWmEYzjNiE2nQuOWKQCmsYiesBT8hJmZNJMxAXoz0=;
 b=JRwjY46KD1RPZM8+hx0K/5hzd2hbIbFgzFzbRVVK5C1k6ngbdci9YNZQXya4EFXnna
 jW+6MOWEyEvda1tJOzyZGwo3gQd1y9P+0UOyJIwLq9hOAN7iI/sUBRQxfGv6KXBJsK8N
 8M1JYTcNQ0E7EuGWjG/7fozruRTisRbMmyDRIQ9FHW9uMoLXYcqvqvFVB389+GThBexy
 6YjmIQnzeG46qzd9U1Ff1/fMORKd+PBqCwATaGH0ZcPDW5R+2lMlHo+bNNcUiqMfJdNn
 O5U/5TekLhroJJIF0O0pyZzzzcnf6P5hij3yLUhi9hcUW0IHzwRV72rH/UTcAzqokJYZ
 IEUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781927267; x=1782532067;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OSqSpS9REYaS3P+xfs3ijgJxweYk/MK84xv+vx5S5Ew=;
 b=GFxEentX/SRaVawuhLIfJkAPyO7v9NlmSu26sp7lZs6JJOOKNo/L084O0U2CTb0ml2
 ICLoUtJIxZyo9SMFCpMbNDKUr0giV6Iuwx9BRwLkAX7S8vDFz0HoAAZWWPAFE+8XaxFP
 s4CaYhE0ZD+4XbGBmxtCpmxhjF2P3+sPwLwN6eaHw0LgmuC0wH13413/Icf4dEzPALvc
 CsPg5Fb77jI8YJXuJkTCtkflb1wSA+0gV5eHZeacfpomJQVG49BrSSX5+bYK75ItaNoM
 OpAnKx84cNwYu1uAAYuIqa1GCR/oy+GrrVetbw6AMUFmOS4fVtKAYBRByP+F6xEmzNC8
 XA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781927267; x=1782532067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSqSpS9REYaS3P+xfs3ijgJxweYk/MK84xv+vx5S5Ew=;
 b=jQ6vYJ7XPP1XT7n3/5qk2UQu8e07UznaI4vZQ9HdrxgRZnaoT/cfzxeJDV7wKCJYwO
 x3OIvfxA93Tdg+JdyqNiHMzcz0XG5VMYvxaOLhJhUmHdvwfn0fB752WxkKh+7szC54PD
 Vzqfr0N/a875uCySXMoAt5SLIQfR1qshdbEM3YL/dxedBInSB3pcWVJReQV5J22qI3qG
 hOGm/hj7sq16XutWPIHkU+5GPkDDb697cYtrQumcINddC43kOMnjQK/vhHKIjdmQFbbV
 RHb1xCqdAHCfnGbyYA45sngluB/OfNswcov1HOdhjfL/5oDKYihprYnNGZ+e0cT/jzE+
 DGtw==
X-Gm-Message-State: AOJu0YwHjIwGJlny/ZiOR2s97oqxj84Ayl9RoxJCibkuMhenTyX5E9az
 k300+E6DR6WXsaIXwDeAgATJJVWv6jC33HE25sZF5cJ1UVizrY23xtEL6t7DRsM/EgoNQBpCiGB
 yCG+jJtRmEoOsKwpMHdtqwxa7+h5BvMz8KDysWAMLQg==
X-Gm-Gg: AfdE7ckQYFSBafWLnShJnpIV47bryRS89NDhW+9H5SNL8Io742nBotAT6B0+M2WVNKf
 /LXJ/ArmHEpVvSNBwlaWPLs6vubv5YZJDOW21GyVyZm35ZA9cXGcXvEfBOfxO9XB08iZrdUpX/4
 4id9l05O+GeqwD5voB2vEMQ05HEGzOxttcQqYIxu+KOiNd3vLCiGNTop6yk3cBofDS3JEcVcD34
 do1HjGzYUBCkh4fVMX0oJxu3jtJ9tM80gfe99tkdzmUv/49wwXOX1M2V5D7+vy3gFpkK4Ke+w==
X-Received: by 2002:a17:90b:33c8:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-37d15fb0ae4mr6377942a91.0.1781927266687; Fri, 19 Jun 2026
 20:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-22-6c16fe448301@bsdimp.com>
 <177adfe7-714f-4570-982f-85e70a28a5be@oss.qualcomm.com>
In-Reply-To: <177adfe7-714f-4570-982f-85e70a28a5be@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 19 Jun 2026 23:47:35 -0400
X-Gm-Features: AVVi8Cf9prmJOsoEdRpg0qM8tlO3S8TflBREQn2r91vQ_o8l3j1rJy9NTIPwQsM
Message-ID: <CANCZdfoNTpkApxRRU3EYNmjxBEpQCdnwy9ra_2OwE=CKUyPL9A@mail.gmail.com>
Subject: Re: [PATCH v2 22/37] bsd-user: Add os-time.c and time-related type
 definitions
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bf2ff90654a74520"
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1036.google.com
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

--000000000000bf2ff90654a74520
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 7:52=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Add os-time.c with time conversion helpers (t2h/h2t functions for
> > timespec, timeval, timex, ntptimeval, itimerspec) and POSIX timer
> > helper functions. Also add target_freebsd_timex,
> target_freebsd_ntptimeval,
> > target_freebsd_itimerspec, kevent structures, and timer definitions
> > to syscall_defs.h.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/freebsd/os-syscall.c |   2 +
> >  bsd-user/freebsd/os-time.c    | 346
> ++++++++++++++++++++++++++++++++++++++++++
> >  bsd-user/freebsd/os-time.h    |   3 +
> >  3 files changed, 351 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-syscall.c
> b/bsd-user/freebsd/os-syscall.c
> > index 6fbd2da261..020d16fda3 100644
> > --- a/bsd-user/freebsd/os-syscall.c
> > +++ b/bsd-user/freebsd/os-syscall.c
> > @@ -98,6 +98,8 @@ safe_syscall6(int, kevent, int, kq, const struct
> kevent *, changelist,
> >      int, nchanges, struct kevent *, eventlist, int, nevents,
> >      const struct timespec *, timeout);
> >
> > +int g_posix_timers[32] =3D { 0, } ;
> > +
> >  /* used in os-proc */
> >  safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
> >      struct rusage *, rusage);
> > diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c
> > new file mode 100644
> > index 0000000000..f1c1cc2c1a
> > --- /dev/null
> > +++ b/bsd-user/freebsd/os-time.c
> > @@ -0,0 +1,346 @@
> > +/*
> > + * FreeBSD time related system call helpers
> > + *
> > + * Copyright (c) 2013-2015 Stacey D. Son
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#include "qemu/osdep.h"
> > +
> > +#include <errno.h>
> > +#include <time.h>
> > +#include <sys/timex.h>
> > +#include <sys/types.h>
> > +#include <sys/select.h>
> > +#include <sys/umtx.h>
> > +
> > +#include "qemu.h"
> > +#include "qemu-os.h"
> > +
> > +/*
> > + * FreeBSD time conversion functions
> > + */
> > +abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong
> target_tv_addr)
> > +{
> > +    struct target_freebsd_timeval *target_tv;
> > +
> > +    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) =
{
> > +        return -TARGET_EFAULT;
> > +    }
> > +    __get_user(tv->tv_sec, &target_tv->tv_sec);
> > +    __get_user(tv->tv_usec, &target_tv->tv_usec);
> > +    unlock_user_struct(target_tv, target_tv_addr, 0);
> > +
> > +    return 0;
> > +}
> > +
> > +abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong
> target_tv_addr)
> > +{
> > +    struct target_freebsd_timeval *target_tv;
> > +
> > +    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0))=
 {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    __put_user(tv->tv_sec, &target_tv->tv_sec);
> > +    __put_user(tv->tv_usec, &target_tv->tv_usec);
> > +    unlock_user_struct(target_tv, target_tv_addr, 1);
> > +
> > +    return 0;
> > +}
> > +
> > +abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong
> target_ts_addr)
> > +{
> > +    struct target_freebsd_timespec *target_ts;
> > +
> > +    if (!lock_user_struct(VERIFY_READ, target_ts, target_ts_addr, 1)) =
{
> > +        return -TARGET_EFAULT;
> > +    }
> > +    __get_user(ts->tv_sec, &target_ts->tv_sec);
> > +    __get_user(ts->tv_nsec, &target_ts->tv_nsec);
> > +    unlock_user_struct(target_ts, target_ts_addr, 0);
> > +
> > +    return 0;
> > +}
> > +
> > +abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timespe=
c
> *ts)
> > +{
> > +    struct target_freebsd_timespec *target_ts;
> > +
> > +    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_ts_addr, 0))=
 {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    __put_user(ts->tv_sec, &target_ts->tv_sec);
> > +    __put_user(ts->tv_nsec, &target_ts->tv_nsec);
> > +    unlock_user_struct(target_ts, target_ts_addr, 1);
> > +
> > +    return 0;
> > +}
> > +
> > +abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
> > +        abi_ulong target_ut_size, void *host_t, size_t *host_tsz)
> > +{
> > +    abi_long ret;
> > +
> > +    if (target_ut_size <=3D sizeof(struct target_freebsd_timespec)) {
> > +        ret =3D t2h_freebsd_timespec((struct timespec *)host_t,
> target_ut_addr);
> > +        if (ret =3D=3D 0) {
> > +            *host_tsz =3D sizeof(struct timespec);
> > +        }
> > +        return ret;
> > +    } else {
> > +        struct target_freebsd__umtx_time *target_ut;
> > +        struct _umtx_time *ut =3D (struct _umtx_time *)host_t;
> > +
> > +        if (!lock_user_struct(VERIFY_READ, target_ut, target_ut_addr,
> 1)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        if (t2h_freebsd_timespec(&ut->_timeout,
> h2g(&target_ut->_timeout))) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        __get_user(ut->_flags, &target_ut->_flags);
> > +        __get_user(ut->_clockid, &target_ut->_clockid);
> > +        unlock_user_struct(target_ut, target_ut_addr, 0);
> > +
> > +        if (target_ut_size > sizeof(struct target_freebsd__umtx_time))=
 {
> > +            *host_tsz =3D sizeof(struct _umtx_time) + sizeof(struct
> timespec);
> > +        } else {
> > +            *host_tsz =3D sizeof(struct _umtx_time);
> > +        }
> > +
> > +        return 0;
> > +    }
> > +}
> > +
> > +abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong
> target_tx_addr)
> > +{
> > +    struct target_freebsd_timex *target_tx;
> > +
> > +    if (!lock_user_struct(VERIFY_READ, target_tx, target_tx_addr, 1)) =
{
> > +        return -TARGET_EFAULT;
> > +    }
> > +    __get_user(host_tx->modes, &target_tx->modes);
> > +    __get_user(host_tx->offset, &target_tx->offset);
> > +    __get_user(host_tx->freq, &target_tx->freq);
> > +    __get_user(host_tx->maxerror, &target_tx->maxerror);
> > +    __get_user(host_tx->esterror, &target_tx->esterror);
> > +    __get_user(host_tx->status, &target_tx->status);
> > +    __get_user(host_tx->constant, &target_tx->constant);
> > +    __get_user(host_tx->precision, &target_tx->precision);
> > +    __get_user(host_tx->tolerance, &target_tx->tolerance);
> > +    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
> > +    __get_user(host_tx->jitter, &target_tx->jitter);
> > +    __get_user(host_tx->shift, &target_tx->shift);
> > +    __get_user(host_tx->stabil, &target_tx->stabil);
> > +    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
> > +    __get_user(host_tx->calcnt, &target_tx->calcnt);
> > +    __get_user(host_tx->errcnt, &target_tx->errcnt);
> > +    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
> > +    unlock_user_struct(target_tx, target_tx_addr, 0);
> > +
> > +    return 0;
> > +}
> > +
> > +abi_long h2t_freebsd_timex(abi_ulong target_tx_addr, struct timex
> *host_tx)
> > +{
> > +    struct target_freebsd_timex *target_tx;
> > +
> > +    if (!lock_user_struct(VERIFY_WRITE, target_tx, target_tx_addr, 0))=
 {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    __put_user(host_tx->modes, &target_tx->modes);
> > +    __put_user(host_tx->offset, &target_tx->offset);
> > +    __put_user(host_tx->freq, &target_tx->freq);
> > +    __put_user(host_tx->maxerror, &target_tx->maxerror);
> > +    __put_user(host_tx->esterror, &target_tx->esterror);
> > +    __put_user(host_tx->status, &target_tx->status);
> > +    __put_user(host_tx->constant, &target_tx->constant);
> > +    __put_user(host_tx->precision, &target_tx->precision);
> > +    __put_user(host_tx->tolerance, &target_tx->tolerance);
> > +    __put_user(host_tx->ppsfreq, &target_tx->ppsfreq);
> > +    __put_user(host_tx->jitter, &target_tx->jitter);
> > +    __put_user(host_tx->shift, &target_tx->shift);
> > +    __put_user(host_tx->stabil, &target_tx->stabil);
> > +    __put_user(host_tx->jitcnt, &target_tx->jitcnt);
> > +    __put_user(host_tx->calcnt, &target_tx->calcnt);
> > +    __put_user(host_tx->errcnt, &target_tx->errcnt);
> > +    __put_user(host_tx->stbcnt, &target_tx->stbcnt);
> > +    unlock_user_struct(target_tx, target_tx_addr, 1);
> > +
> > +    return 0;
> > +}
> > +
> > +abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
> > +        struct ntptimeval *ntv)
> > +{
> > +    struct target_freebsd_ntptimeval *target_ntv;
> > +
> > +    if (!lock_user_struct(VERIFY_WRITE, target_ntv, target_ntv_addr,
> 0)) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    __put_user(ntv->time.tv_sec, &target_ntv->time.tv_sec);
> > +    __put_user(ntv->time.tv_nsec, &target_ntv->time.tv_nsec);
> > +    __put_user(ntv->maxerror, &target_ntv->maxerror);
> > +    __put_user(ntv->esterror, &target_ntv->esterror);
> > +    __put_user(ntv->tai, &target_ntv->tai);
> > +    __put_user(ntv->time_state, &target_ntv->time_state);
> > +    unlock_user_struct(target_ntv, target_ntv_addr, 1);
> > +
> > +    return 0;
> > +}
> > +
> > +/*
> > + * select(2) fdset copy functions
> > + */
> > +abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr,
> int n)
> > +{
> > +    int i, nw, j, k;
> > +    abi_ulong b, *target_fds;
> > +
> > +    nw =3D (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
> > +    target_fds =3D lock_user(VERIFY_READ, target_fds_addr,
> > +            sizeof(abi_ulong) * nw, 1);
> > +    if (target_fds =3D=3D NULL) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    FD_ZERO(fds);
> > +    k =3D 0;
> > +    for (i =3D 0; i < nw; i++) {
> > +        /* grab the abi_ulong */
> > +        __get_user(b, &target_fds[i]);
> > +        for (j =3D 0; j < TARGET_ABI_BITS; j++) {
> > +            /* check the bit inside the abi_ulong */
> > +            if ((b >> j) & 1) {
> > +                FD_SET(k, fds);
> > +            }
> > +            k++;
> > +        }
> > +    }
> > +    unlock_user(target_fds, target_fds_addr, 0);
> > +
> > +    return 0;
> > +}
> > +
> > +abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,
> > +        abi_ulong target_fds_addr, int n)
> > +{
> > +
> > +    if (target_fds_addr) {
> > +        if (copy_from_user_fdset(fds, target_fds_addr, n)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        *fds_ptr =3D fds;
> > +    } else {
> > +        *fds_ptr =3D NULL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set
> *fds, int n)
> > +{
> > +    int i, nw, j, k;
> > +    abi_long v;
> > +    abi_ulong *target_fds;
> > +
> > +    nw =3D (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
> > +    target_fds =3D lock_user(VERIFY_WRITE, target_fds_addr,
> > +            sizeof(abi_ulong) * nw, 0);
> > +    if (target_fds =3D=3D NULL) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    k =3D 0;
> > +    for (i =3D 0; i < nw; i++) {
> > +        v =3D 0;
> > +        for (j =3D 0; j < TARGET_ABI_BITS; j++) {
> > +            v |=3D ((FD_ISSET(k, fds) !=3D 0) << j);
> > +            k++;
> > +        }
> > +        __put_user(v, &target_fds[i]);
> > +    }
> > +    unlock_user(target_fds, target_fds_addr, sizeof(abi_ulong) * nw);
> > +
> > +    return 0;
> > +}
>
> It seems the two functions above do not belong to current patch, but
> should be present in N-2 patch at least (ideally, in a third one, before
> os-time part of the series)
>

But these are inside os-time.c, which is created in this patch.  And I
think you
may mean the last 3. So moving it backwards is a bit of a pain to get the
depends
right, since I'd have to create os-time.c

Can we relax the grouping a bit? I'll leave it alone for v3, so can you
check
what you mean here agianst that and tag the functions that you intended.

Warner


> > +
> > +abi_int next_free_host_timer(void)
> > +{
> > +    int k ;
> > +    /* FIXME: Does finding the next free slot require a lock? */
> > +    for (k =3D 0; k < ARRAY_SIZE(g_posix_timers); k++) {
> > +        if (g_posix_timers[k] =3D=3D 0) {
> > +            g_posix_timers[k] =3D 1;
> > +            return k;
> > +        }
> > +    }
> > +    return -1;
> > +}
> > +
> > +int host_to_target_timerid(int timerid)
> > +{
> > +    int k;
> > +
> > +    for (k =3D 0; k < ARRAY_SIZE(g_posix_timers); k++) {
> > +        if (g_posix_timers[k] =3D=3D timerid) {
> > +            return TIMER_MAGIC | k;
> > +        }
> > +    }
> > +
> > +    return -1;
> > +}
> > +
> > +abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
> > +                                                 abi_ulong target_addr=
)
> > +{
> > +    struct target_freebsd_itimerspec *target_itspec;
> > +
> > +    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1))=
 {
> > +        return -TARGET_EFAULT;
> > +    }
> > +
> > +    host_itspec->it_interval.tv_sec =3D
> > +                            tswapal(target_itspec->it_interval.tv_sec)=
;
> > +    host_itspec->it_interval.tv_nsec =3D
> > +                            tswapal(target_itspec->it_interval.tv_nsec=
);
> > +    host_itspec->it_value.tv_sec =3D
> tswapal(target_itspec->it_value.tv_sec);
> > +    host_itspec->it_value.tv_nsec =3D
> tswapal(target_itspec->it_value.tv_nsec);
> > +
> > +    unlock_user_struct(target_itspec, target_addr, 0);
> > +    return 0;
> > +}
> > +
> > +abi_long host_to_target_itimerspec(abi_ulong target_addr,
> > +                                               struct itimerspec
> *host_its)
> > +{
> > +    struct target_freebsd_itimerspec *target_itspec;
> > +
> > +    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)=
)
> {
> > +        return -TARGET_EFAULT;
> > +    }
> > +
> > +    target_itspec->it_interval.tv_sec =3D
> tswapal(host_its->it_interval.tv_sec);
> > +    target_itspec->it_interval.tv_nsec =3D
> tswapal(host_its->it_interval.tv_nsec);
> > +
> > +    target_itspec->it_value.tv_sec =3D tswapal(host_its->it_value.tv_s=
ec);
> > +    target_itspec->it_value.tv_nsec =3D
> tswapal(host_its->it_value.tv_nsec);
> > +
> > +    unlock_user_struct(target_itspec, target_addr, 1);
> > +    return 0;
> > +}
> > +
> > +/* Convert QEMU provided timer ID back to internal 16bit index format =
*/
> > +int get_timer_id(abi_long arg)
> > +{
> > +    int timerid =3D arg;
> > +
> > +    if ((timerid & TIMER_MAGIC_MASK) !=3D TIMER_MAGIC) {
> > +        return -TARGET_EINVAL;
> > +    }
> > +
> > +    timerid &=3D 0xffff;
> > +
> > +    if (timerid >=3D ARRAY_SIZE(g_posix_timers)) {
> > +        return -TARGET_EINVAL;
> > +    }
> > +
> > +    return timerid;
> > +}
> > diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> > index f24b6f35db..e91a3f9bcf 100644
> > --- a/bsd-user/freebsd/os-time.h
> > +++ b/bsd-user/freebsd/os-time.h
> > @@ -198,6 +198,9 @@ static inline abi_long
> do_freebsd_ntp_adjtime(abi_ulong target_tx_addr)
> >      if (ret =3D=3D 0) {
> >          ret =3D get_errno(ntp_adjtime(&host_tx));
> >      }
> > +    if (!is_error(ret)) {
> > +        h2t_freebsd_timex(target_tx_addr, &host_tx);
> > +    }
> >
> >      return ret;
> >  }
> >
>
>

--000000000000bf2ff90654a74520
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 7:52=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Add os-time.c with time conversion helpers (t2h/h2t functions for<br>
&gt; timespec, timeval, timex, ntptimeval, itimerspec) and POSIX timer<br>
&gt; helper functions. Also add target_freebsd_timex, target_freebsd_ntptim=
eval,<br>
&gt; target_freebsd_itimerspec, kevent structures, and timer definitions<br=
>
&gt; to syscall_defs.h.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.uranka=
r@gmail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/os-syscall.c |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 bsd-user/freebsd/os-time.c=C2=A0 =C2=A0 | 346 ++++++++++++++++++=
++++++++++++++++++++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-time.h=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 3 files changed, 351 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-sysca=
ll.c<br>
&gt; index 6fbd2da261..020d16fda3 100644<br>
&gt; --- a/bsd-user/freebsd/os-syscall.c<br>
&gt; +++ b/bsd-user/freebsd/os-syscall.c<br>
&gt; @@ -98,6 +98,8 @@ safe_syscall6(int, kevent, int, kq, const struct kev=
ent *, changelist,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int, nchanges, struct kevent *, eventlist, int, ne=
vents,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const struct timespec *, timeout);<br>
&gt;=C2=A0 <br>
&gt; +int g_posix_timers[32] =3D { 0, } ;<br>
&gt; +<br>
&gt;=C2=A0 /* used in os-proc */<br>
&gt;=C2=A0 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, opt=
ions,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct rusage *, rusage);<br>
&gt; diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..f1c1cc2c1a<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/freebsd/os-time.c<br>
&gt; @@ -0,0 +1,346 @@<br>
&gt; +/*<br>
&gt; + * FreeBSD time related system call helpers<br>
&gt; + *<br>
&gt; + * Copyright (c) 2013-2015 Stacey D. Son<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &lt;errno.h&gt;<br>
&gt; +#include &lt;time.h&gt;<br>
&gt; +#include &lt;sys/timex.h&gt;<br>
&gt; +#include &lt;sys/types.h&gt;<br>
&gt; +#include &lt;sys/select.h&gt;<br>
&gt; +#include &lt;sys/umtx.h&gt;<br>
&gt; +<br>
&gt; +#include &quot;qemu.h&quot;<br>
&gt; +#include &quot;qemu-os.h&quot;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * FreeBSD time conversion functions<br>
&gt; + */<br>
&gt; +abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_=
addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_timeval *target_tv;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_tv, target_tv=
_addr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __get_user(tv-&gt;tv_sec, &amp;target_tv-&gt;tv_sec);<b=
r>
&gt; +=C2=A0 =C2=A0 __get_user(tv-&gt;tv_usec, &amp;target_tv-&gt;tv_usec);=
<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_tv, target_tv_addr, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_=
addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_timeval *target_tv;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_tv, target_t=
v_addr, 0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __put_user(tv-&gt;tv_sec, &amp;target_tv-&gt;tv_sec);<b=
r>
&gt; +=C2=A0 =C2=A0 __put_user(tv-&gt;tv_usec, &amp;target_tv-&gt;tv_usec);=
<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_tv, target_tv_addr, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_t=
s_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_timespec *target_ts;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_ts, target_ts=
_addr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __get_user(ts-&gt;tv_sec, &amp;target_ts-&gt;tv_sec);<b=
r>
&gt; +=C2=A0 =C2=A0 __get_user(ts-&gt;tv_nsec, &amp;target_ts-&gt;tv_nsec);=
<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_ts, target_ts_addr, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timesp=
ec *ts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_timespec *target_ts;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_ts, target_t=
s_addr, 0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __put_user(ts-&gt;tv_sec, &amp;target_ts-&gt;tv_sec);<b=
r>
&gt; +=C2=A0 =C2=A0 __put_user(ts-&gt;tv_nsec, &amp;target_ts-&gt;tv_nsec);=
<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_ts, target_ts_addr, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_ut_size, void *host_t, s=
ize_t *host_tsz)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (target_ut_size &lt;=3D sizeof(struct target_freebsd=
_timespec)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D t2h_freebsd_timespec((struct time=
spec *)host_t, target_ut_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_tsz =3D sizeof(struct=
 timespec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct target_freebsd__umtx_time *target_=
ut;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct _umtx_time *ut =3D (struct _umtx_t=
ime *)host_t;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target=
_ut, target_ut_addr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timespec(&amp;ut-&gt;_tim=
eout, h2g(&amp;target_ut-&gt;_timeout))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(ut-&gt;_flags, &amp;target_ut-=
&gt;_flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(ut-&gt;_clockid, &amp;target_u=
t-&gt;_clockid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user_struct(target_ut, target_ut_a=
ddr, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_ut_size &gt; sizeof(struct tar=
get_freebsd__umtx_time)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_tsz =3D sizeof(struct=
 _umtx_time) + sizeof(struct timespec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *host_tsz =3D sizeof(struct=
 _umtx_time);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx=
_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_timex *target_tx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_tx, target_tx=
_addr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;modes, &amp;target_tx-&gt;modes)=
;<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;offset, &amp;target_tx-&gt;offse=
t);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;freq, &amp;target_tx-&gt;freq);<=
br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;maxerror, &amp;target_tx-&gt;max=
error);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;esterror, &amp;target_tx-&gt;est=
error);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;status, &amp;target_tx-&gt;statu=
s);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;constant, &amp;target_tx-&gt;con=
stant);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;precision, &amp;target_tx-&gt;pr=
ecision);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;tolerance, &amp;target_tx-&gt;to=
lerance);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;ppsfreq, &amp;target_tx-&gt;ppsf=
req);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;jitter, &amp;target_tx-&gt;jitte=
r);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;shift, &amp;target_tx-&gt;shift)=
;<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;stabil, &amp;target_tx-&gt;stabi=
l);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;jitcnt, &amp;target_tx-&gt;jitcn=
t);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;calcnt, &amp;target_tx-&gt;calcn=
t);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;errcnt, &amp;target_tx-&gt;errcn=
t);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_tx-&gt;stbcnt, &amp;target_tx-&gt;stbcn=
t);<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_tx, target_tx_addr, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long h2t_freebsd_timex(abi_ulong target_tx_addr, struct timex *ho=
st_tx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_timex *target_tx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_tx, target_t=
x_addr, 0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;modes, &amp;target_tx-&gt;modes)=
;<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;offset, &amp;target_tx-&gt;offse=
t);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;freq, &amp;target_tx-&gt;freq);<=
br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;maxerror, &amp;target_tx-&gt;max=
error);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;esterror, &amp;target_tx-&gt;est=
error);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;status, &amp;target_tx-&gt;statu=
s);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;constant, &amp;target_tx-&gt;con=
stant);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;precision, &amp;target_tx-&gt;pr=
ecision);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;tolerance, &amp;target_tx-&gt;to=
lerance);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;ppsfreq, &amp;target_tx-&gt;ppsf=
req);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;jitter, &amp;target_tx-&gt;jitte=
r);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;shift, &amp;target_tx-&gt;shift)=
;<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;stabil, &amp;target_tx-&gt;stabi=
l);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;jitcnt, &amp;target_tx-&gt;jitcn=
t);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;calcnt, &amp;target_tx-&gt;calcn=
t);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;errcnt, &amp;target_tx-&gt;errcn=
t);<br>
&gt; +=C2=A0 =C2=A0 __put_user(host_tx-&gt;stbcnt, &amp;target_tx-&gt;stbcn=
t);<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_tx, target_tx_addr, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ntptimeval *ntv)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_ntptimeval *target_ntv;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_ntv, target_=
ntv_addr, 0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __put_user(ntv-&gt;time.tv_sec, &amp;target_ntv-&gt;tim=
e.tv_sec);<br>
&gt; +=C2=A0 =C2=A0 __put_user(ntv-&gt;time.tv_nsec, &amp;target_ntv-&gt;ti=
me.tv_nsec);<br>
&gt; +=C2=A0 =C2=A0 __put_user(ntv-&gt;maxerror, &amp;target_ntv-&gt;maxerr=
or);<br>
&gt; +=C2=A0 =C2=A0 __put_user(ntv-&gt;esterror, &amp;target_ntv-&gt;esterr=
or);<br>
&gt; +=C2=A0 =C2=A0 __put_user(ntv-&gt;tai, &amp;target_ntv-&gt;tai);<br>
&gt; +=C2=A0 =C2=A0 __put_user(ntv-&gt;time_state, &amp;target_ntv-&gt;time=
_state);<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_ntv, target_ntv_addr, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * select(2) fdset copy functions<br>
&gt; + */<br>
&gt; +abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr=
, int n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i, nw, j, k;<br>
&gt; +=C2=A0 =C2=A0 abi_ulong b, *target_fds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nw =3D (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;<br>
&gt; +=C2=A0 =C2=A0 target_fds =3D lock_user(VERIFY_READ, target_fds_addr,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(abi_ulong) * nw, 1);=
<br>
&gt; +=C2=A0 =C2=A0 if (target_fds =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 FD_ZERO(fds);<br>
&gt; +=C2=A0 =C2=A0 k =3D 0;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nw; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* grab the abi_ulong */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(b, &amp;target_fds[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; TARGET_ABI_BITS; j++=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* check the bit inside the=
 abi_ulong */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((b &gt;&gt; j) &amp; 1)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FD_SET(k, fds=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 unlock_user(target_fds, target_fds_addr, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_fds_addr, int n)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (target_fds_addr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copy_from_user_fdset(fds, target_fds_=
addr, n)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fds_ptr =3D fds;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fds_ptr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set *=
fds, int n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i, nw, j, k;<br>
&gt; +=C2=A0 =C2=A0 abi_long v;<br>
&gt; +=C2=A0 =C2=A0 abi_ulong *target_fds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nw =3D (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;<br>
&gt; +=C2=A0 =C2=A0 target_fds =3D lock_user(VERIFY_WRITE, target_fds_addr,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(abi_ulong) * nw, 0);=
<br>
&gt; +=C2=A0 =C2=A0 if (target_fds =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 k =3D 0;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nw; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; TARGET_ABI_BITS; j++=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v |=3D ((FD_ISSET(k, fds) !=
=3D 0) &lt;&lt; j);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(v, &amp;target_fds[i]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 unlock_user(target_fds, target_fds_addr, sizeof(abi_ulo=
ng) * nw);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
<br>
It seems the two functions above do not belong to current patch, but<br>
should be present in N-2 patch at least (ideally, in a third one, before<br=
>
os-time part of the series)<br></blockquote><div><br></div><div>But these a=
re inside os-time.c, which is created in this patch.=C2=A0 And I think you<=
/div><div>may mean the last 3. So moving it backwards is a bit of a pain to=
 get the depends</div><div>right, since I&#39;d have to create os-time.c</d=
iv><div><br></div><div>Can we relax the grouping a bit? I&#39;ll leave it a=
lone for v3, so can you check</div><div>what you mean here agianst that and=
 tag the functions that you intended.</div><div><br></div><div>Warner</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +abi_int next_free_host_timer(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int k ;<br>
&gt; +=C2=A0 =C2=A0 /* FIXME: Does finding the next free slot require a loc=
k? */<br>
&gt; +=C2=A0 =C2=A0 for (k =3D 0; k &lt; ARRAY_SIZE(g_posix_timers); k++) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_posix_timers[k] =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_posix_timers[k] =3D 1;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return k;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int host_to_target_timerid(int timerid)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int k;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (k =3D 0; k &lt; ARRAY_SIZE(g_posix_timers); k++) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_posix_timers[k] =3D=3D timerid) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TIMER_MAGIC | k;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong target_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_itimerspec *target_itspec;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_itspec, targe=
t_addr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 host_itspec-&gt;it_interval.tv_sec =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswapal(target_itspec-&gt;it_interval.tv_sec);=
<br>
&gt; +=C2=A0 =C2=A0 host_itspec-&gt;it_interval.tv_nsec =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswapal(target_itspec-&gt;it_interval.tv_nsec)=
;<br>
&gt; +=C2=A0 =C2=A0 host_itspec-&gt;it_value.tv_sec =3D tswapal(target_itsp=
ec-&gt;it_value.tv_sec);<br>
&gt; +=C2=A0 =C2=A0 host_itspec-&gt;it_value.tv_nsec =3D tswapal(target_its=
pec-&gt;it_value.tv_nsec);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_itspec, target_addr, 0);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long host_to_target_itimerspec(abi_ulong target_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct itimerspec *host_its)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_itimerspec *target_itspec;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_WRITE, target_itspec, targ=
et_addr, 0)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 target_itspec-&gt;it_interval.tv_sec =3D tswapal(host_i=
ts-&gt;it_interval.tv_sec);<br>
&gt; +=C2=A0 =C2=A0 target_itspec-&gt;it_interval.tv_nsec =3D tswapal(host_=
its-&gt;it_interval.tv_nsec);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 target_itspec-&gt;it_value.tv_sec =3D tswapal(host_its-=
&gt;it_value.tv_sec);<br>
&gt; +=C2=A0 =C2=A0 target_itspec-&gt;it_value.tv_nsec =3D tswapal(host_its=
-&gt;it_value.tv_nsec);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_itspec, target_addr, 1);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Convert QEMU provided timer ID back to internal 16bit index format=
 */<br>
&gt; +int get_timer_id(abi_long arg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int timerid =3D arg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((timerid &amp; TIMER_MAGIC_MASK) !=3D TIMER_MAGIC) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 timerid &amp;=3D 0xffff;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (timerid &gt;=3D ARRAY_SIZE(g_posix_timers)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return timerid;<br>
&gt; +}<br>
&gt; diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h<b=
r>
&gt; index f24b6f35db..e91a3f9bcf 100644<br>
&gt; --- a/bsd-user/freebsd/os-time.h<br>
&gt; +++ b/bsd-user/freebsd/os-time.h<br>
&gt; @@ -198,6 +198,9 @@ static inline abi_long do_freebsd_ntp_adjtime(abi_=
ulong target_tx_addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(ntp_adjtime(&amp;h=
ost_tx));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 h2t_freebsd_timex(target_tx_addr, &amp;ho=
st_tx);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000bf2ff90654a74520--

