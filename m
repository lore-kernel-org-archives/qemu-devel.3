Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1FEC5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 23:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvNca-00049T-Sr; Sat, 15 Aug 2026 19:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wvNcY-00048u-Ez
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 19:16:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wvNcV-0007nk-PF
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 19:16:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so37271785ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 16:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786835811; cv=none;
 d=google.com; s=arc-20260327;
 b=tC56vhKbYfgQP6zyic4/+gDCMD8XA+mssUavJZ4nzTXxfTuHXMsg/Pt3uLbKsplzFM
 hGc6uDbY418sAJZKiz4N206gKiiLRHFFRlYU7BSNA1otWUxu6vE+L7uSeekkTQCSkGy2
 1GoNqqUWnbxz2Q5iCpidEUqdh7mjNLVW/TnQeB6WUKF+fifCebotzo9jR9zMSOvg67i7
 eucwURQHC1o944e6Q5qpeaNT9l+TDguElw/Ke1K2YNRsUQqj/ifLJHK4zAkBAe3fcVBG
 cFY8O/Gd2pkV6/wQcPgIVAAJlMx5G8OAfWcKEwWo1ir5YJxyhMo27Rkl6OGMebRoq/hL
 pTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cnrNWTHTxgcUKJHU1uTwHWYRPxL6RxH9z2vKglZDzNg=;
 fh=tChWmEYzjNiE2nQuOWKQCmsYiesBT8hJmZNJMxAXoz0=;
 b=qtHEjcPn7WKHQvW3qvy7tr4XfzydlmzNuixMtMK2/B4iwyyz5SoiA0qnxLuwezXwV3
 EF1hdtol3Kdpj+zVwZ1cg5FYcT5ZSHyZVj3YPiJH/W+oaeMvDg9QI3UvZPWQKkMeRaV3
 24iMDVabmoWJw7lzjp4XFBg8UcAYDnEmQ24Uo9uNnKbaYHvpeS2dFrlnNDmB8iWLSbU1
 clyYBdUx3mPzKSoiYbrUGusqbUqsmIpTGFK4vGVmKp9Oj99dmcyLpjQfx5SHe4f5re6L
 sACbQYxQsJ/7Jogjdy52YK8nfDI+Ayj2dptewRlJAgc+PaGXwQvxeJp6tK4Gv1e2MHfv
 OPoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1786835811; x=1787440611;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cnrNWTHTxgcUKJHU1uTwHWYRPxL6RxH9z2vKglZDzNg=;
 b=LNPdjrMgxJ8vZ1PaeD9YbCh60ANDn7mYR+tUprzTzDr4bXDSK6/ktVlD26DIjsgqKo
 oKZwIZ4KE6jivRx3Pb71O4NFdCPgEruMoq/80Euk81LLHLvwSs/mfGwnJ7tE7ckrOzPh
 VysxkTS4G8yU2rq5UqZQuKGRWF56RcTAgG8OGEXMbWevWkFR6uQlD/fhOYl73LXvHxmX
 XPtMGna4AVxhmyyek+LkDZWFeMYEb0FL1yeOBA9pKHh75+6SfKWUJOxa8/ppSFQEVRGk
 2TUHKM1bUVldJkpTX2pcBD37Oe2C+WDU3hHJwgkrbaunxKSJFbLsTovYMDFZARFWLUvE
 1BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786835811; x=1787440611;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cnrNWTHTxgcUKJHU1uTwHWYRPxL6RxH9z2vKglZDzNg=;
 b=gq+4T1stO5OqTOp1BZ+fLTWx/otrYA0eGb1ZKTXJOXxQS5FIgUol8oB73yplhTCbwF
 W7LhCMqqZKLv2hq5jLY0f5Cxa1PP8xBLu0sh0FksobkiiBZ2gnpMd3yV+JiIqUEnImuy
 Ah3b07xbZ6mESMTkU54Q3SgJUTau+ut5AzwETMUF6iaI6A4wg9ymGH3IgR5UoZBLO9nz
 8v0ZZjc83B4oiO7mz3/qqQuRwWLZSLrX9EmIMWltnAnIJ0XZaz2BAjWwHavj0Y2HvCeB
 +uEv0flt1Wdip/Q0ZWgWS1W0CSdKJt+hWWbQ2BtJw5X0yjeUKEJ9bwf0IZDj4CXG2IoB
 K6UQ==
X-Gm-Message-State: AOJu0YxtxtAnYfdrqtazmFot6jTiEb1hexP03gPgJzwBThjXUSFWvgma
 ipGgpT46OeeDBwkxts6vAMKL1vjOQErdDzBFSlhRc6/fF31KbrHoOgbVVKUYhhfdfCRtov/S/nL
 VizqQvP2klI+emsml8FInKGyqqkFxXtMR7/6uCmOZuw==
X-Gm-Gg: AR+sD11C9EQhDMWWdL4jLJcOvQ7TJ4uovc4jrAdKn6kigknTzNPNddS89ivqmOvRYHt
 2q10OGOkmWezVbOoPwjEA7IW2c5XpQB2PZF0Nd7pFxkK0wb7KzKGxI/PDXjJdx7eecyKhtH0c0e
 hKHbBCYR7wxIBvIoaIwBtc+hHOeq5VxgqtuikhKXrK140UNr0gkG44Jd5XFeJbR62WCgifNerI3
 6YgJz2f6tohezU7F9JtOV/+vlA59EK0D/5n3xJxX5j2ZRfpmAMFnFJNwYPqB+1dzLwsHC5o7KD5
 iQpaAj+bLN+/2rurk1eQ/NeUFhYW0ywW04SoxjXtqiJ2
X-Received: by 2002:a17:903:1a08:b0:2d3:7887:7e7f with SMTP id
 d9443c01a7336-2d3b0c5de30mr187111545ad.11.1786835811257; Sat, 15 Aug 2026
 16:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-19-6c16fe448301@bsdimp.com>
 <c75ecfed-2dbf-4517-b240-7ca8a623e4a6@oss.qualcomm.com>
In-Reply-To: <c75ecfed-2dbf-4517-b240-7ca8a623e4a6@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 15 Aug 2026 17:16:38 -0600
X-Gm-Features: AUfX_mwnOk2obQNZU0yR6V_nwvB8Ge332TunLMtIF22pBGYYWyl7287bbahjfvc
Message-ID: <CANCZdfooM-hzozBKdFPaudPMCkJYBA7rvkaOEigyvskAQjeXkg@mail.gmail.com>
Subject: Re: [PATCH v2 19/37] bsd-user: Add select, pselect,
 and ppoll to os-time.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cd5f0e06591e2117"
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62f.google.com
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

--000000000000cd5f0e06591e2117
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 5:46=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Add I/O multiplexing system call shims: select, pselect, and ppoll
> > with proper fd_set, timespec/timeval, and signal mask conversion.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/freebsd/os-time.h | 202
> +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 202 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> > index 05fa043442..12c5ba02e8 100644
> > --- a/bsd-user/freebsd/os-time.h
> > +++ b/bsd-user/freebsd/os-time.h
> > @@ -427,5 +427,207 @@ static inline abi_long
> do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
> >      return ret;
> >  }
> >
> > +/* select(2) */
> > +static inline abi_long do_freebsd_select(CPUArchState *env, int n,
> > +        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
> > +        abi_ulong target_tv_addr)
> > +{
> > +    fd_set rfds, wfds, efds;
> > +    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
> > +    struct timeval tv, *tvp;
> > +    abi_long ret, error;
> > +
> > +    ret =3D copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +    ret =3D copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +    ret =3D copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
>
> We can factor this with a macro
>
> > +    if (target_tv_addr !=3D 0) {
> > +        if (t2h_freebsd_timeval(&tv, target_tv_addr)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        tvp =3D &tv;
> > +    } else {
> > +        tvp =3D NULL;
> > +    }
> > +
> > +    ret =3D get_errno(safe_select(n, rfds_ptr, wfds_ptr, efds_ptr, tvp=
));
> > +
> > +    if (!is_error(ret)) {
>
> We can simplify depth here by using an early return.
> if (is_error(ret)) {
>   return ret;
> }
>
> > +        if (rfd_addr !=3D 0) {
> > +            error =3D copy_to_user_fdset(rfd_addr, &rfds, n);
> > +            if (error !=3D 0) {
> > +                return error;
> > +            }
> > +        }
> > +        if (wfd_addr !=3D 0) {
> > +            error =3D copy_to_user_fdset(wfd_addr, &wfds, n);
> > +            if (error !=3D 0) {
> > +                return error;
> > +            }
> > +        }
> > +        if (efd_addr !=3D 0) {
> > +            error =3D copy_to_user_fdset(efd_addr, &efds, n);
> > +            if (error !=3D 0) {
> > +                return error;
> > +            }
> > +        }
>
> Same, reuse the macro defined above.
>
> > +        if (target_tv_addr !=3D 0) {
> > +            error =3D h2t_freebsd_timeval(&tv, target_tv_addr);
> > +            if (is_error(error)) {
> > +                return error;
> > +            }
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +/* pselect(2) */
> > +static inline abi_long do_freebsd_pselect(CPUArchState *env, int n,
> > +        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
> > +        abi_ulong ts_addr, abi_ulong set_addr)
> > +{
> > +    CPUState *cpu =3D env_cpu(env);
> > +    TaskState *tstate =3D cpu->opaque;
> > +    fd_set rfds, wfds, efds;
> > +    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
> > +    sigset_t *set_ptr;
> > +    struct timespec ts, *ts_ptr;
> > +    void *p;
> > +    abi_long ret, error;
> > +
> > +    ret =3D copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
> > +    if (is_error(ret)) {
> > +        return ret;
> > +    }
> > +    ret =3D copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
> > +    if (is_error(ret)) {
> > +        return ret;
> > +    }
> > +    ret =3D copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
> > +    if (is_error(ret)) {
> > +        return ret;
> > +    }
> > +
>
> Same than above.
>

I like these suggestions, but due to lack of good regression tests, I'm
going to defer them
since I know the code that's there works.
https://github.com/qemu-bsd-user/qemu-bsd-user/issues/66
memorializes the issue.

Warner


> > +    /* Unlike select(), pselect() uses struct timespec instead of
> timeval */
> > +    if (ts_addr) {
> > +        if (t2h_freebsd_timespec(&ts, ts_addr)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        ts_ptr =3D &ts;
> > +    } else {
> > +        ts_ptr =3D NULL;
> > +    }
> > +
> > +    if (set_addr !=3D 0) {
> > +        p =3D lock_user(VERIFY_READ, set_addr, sizeof(target_sigset_t)=
,
> 1);
> > +        if (p =3D=3D NULL) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        target_to_host_sigset(&tstate->sigsuspend_mask, p);
> > +        unlock_user(p, set_addr, 0);
> > +        set_ptr =3D &tstate->sigsuspend_mask;
> > +    } else {
> > +        set_ptr =3D NULL;
> > +    }
> > +
> > +    ret =3D get_errno(safe_pselect(n, rfds_ptr, wfds_ptr, efds_ptr,
> ts_ptr,
> > +        set_ptr));
> > +    if (ret !=3D -TARGET_ERESTART)  {
> > +        tstate->in_sigsuspend =3D true;
> > +    }
> > +    if (!is_error(ret)) {
> > +        if (rfd_addr !=3D 0) {
> > +            error =3D copy_to_user_fdset(rfd_addr, &rfds, n);
> > +            if (is_error(error)) {
> > +                return error;
> > +            }
> > +        }
> > +        if (wfd_addr !=3D 0) {
> > +            error =3D copy_to_user_fdset(wfd_addr, &wfds, n);
> > +            if (is_error(error)) {
> > +                return error;
> > +            }
> > +        }
> > +        if (efd_addr !=3D 0) {
> > +            error =3D copy_to_user_fdset(efd_addr, &efds, n);
> > +            if (is_error(error)) {
> > +                return error;
> > +            }
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +/* ppoll(2) */
> > +static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long
> arg1,
> > +        abi_long arg2, abi_ulong arg3, abi_ulong arg4)
> > +{
> > +    CPUState *cpu =3D env_cpu(env);
> > +    TaskState *tstate =3D cpu->opaque;
> > +    abi_long ret;
> > +    nfds_t i, nfds =3D arg2;
> > +    struct pollfd *pfd;
> > +    struct target_pollfd *target_pfd;
> > +    struct timespec ts, *ts_ptr;
> > +    sigset_t *set_ptr;
> > +    void *p;
> > +
> > +    target_pfd =3D lock_user(VERIFY_WRITE, arg1,
> > +                           sizeof(struct target_pollfd) * nfds, 1);
> > +    if (!target_pfd) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    pfd =3D alloca(sizeof(struct pollfd) * nfds);
> > +    for (i =3D 0; i < nfds; i++) {
> > +        pfd[i].fd =3D tswap32(target_pfd[i].fd);
> > +        pfd[i].events =3D tswap16(target_pfd[i].events);
> > +    }
> > +
> > +    /* Unlike poll(), ppoll() uses struct timespec. */
> > +    if (arg3) {
> > +        if (t2h_freebsd_timespec(&ts, arg3)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        ts_ptr =3D &ts;
> > +    } else {
> > +        ts_ptr =3D NULL;
> > +    }
> > +
> > +    if (arg4 !=3D 0) {
> > +        p =3D lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1)=
;
> > +        if (p =3D=3D NULL) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        target_to_host_sigset(&tstate->sigsuspend_mask, p);
> > +        unlock_user(p, arg4, 0);
> > +        set_ptr =3D &tstate->sigsuspend_mask;
> > +    } else {
> > +        set_ptr =3D NULL;
> > +    }
> > +
> > +    ret =3D get_errno(ppoll(pfd, nfds, ts_ptr, set_ptr));
> > +    if (ret !=3D -TARGET_ERESTART) {
> > +        tstate->in_sigsuspend =3D true;
> > +    }
> > +    if (!is_error(ret)) {
> > +        for (i =3D 0; i < nfds; i++) {
> > +            target_pfd[i].revents =3D tswap16(pfd[i].revents);
> > +        }
> > +    }
> > +    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds)=
;
> > +
> > +    return ret;
> > +}
> > +
> > +/* kqueue(2) */
> >
> >  #endif /* FREEBSD_OS_TIME_H */
> >
>
>

--000000000000cd5f0e06591e2117
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 5:46=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Add I/O multiplexing system call shims: select, pselect, and ppoll<br>
&gt; with proper fd_set, timespec/timeval, and signal mask conversion.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.uranka=
r@gmail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/os-time.h | 202 +++++++++++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 1 file changed, 202 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h<b=
r>
&gt; index 05fa043442..12c5ba02e8 100644<br>
&gt; --- a/bsd-user/freebsd/os-time.h<br>
&gt; +++ b/bsd-user/freebsd/os-time.h<br>
&gt; @@ -427,5 +427,207 @@ static inline abi_long do_freebsd_ktimer_gettime=
(abi_long arg1, abi_long arg2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/* select(2) */<br>
&gt; +static inline abi_long do_freebsd_select(CPUArchState *env, int n,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong rfd_addr, abi_ulong wfd_addr, a=
bi_ulong efd_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong target_tv_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 fd_set rfds, wfds, efds;<br>
&gt; +=C2=A0 =C2=A0 fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;<br>
&gt; +=C2=A0 =C2=A0 struct timeval tv, *tvp;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret, error;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D copy_from_user_fdset_ptr(&amp;rfds, &amp;rfds_p=
tr, rfd_addr, n);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D copy_from_user_fdset_ptr(&amp;wfds, &amp;wfds_p=
tr, wfd_addr, n);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D copy_from_user_fdset_ptr(&amp;efds, &amp;efds_p=
tr, efd_addr, n);<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
We can factor this with a macro<br>
<br>
&gt; +=C2=A0 =C2=A0 if (target_tv_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timeval(&amp;tv, target_t=
v_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D &amp;tv;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tvp =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(safe_select(n, rfds_ptr, wfds_ptr, ef=
ds_ptr, tvp));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
<br>
We can simplify depth here by using an early return.<br>
if (is_error(ret)) {<br>
=C2=A0 return ret;<br>
}<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rfd_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D copy_to_user_fdse=
t(rfd_addr, &amp;rfds, n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wfd_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D copy_to_user_fdse=
t(wfd_addr, &amp;wfds, n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (efd_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D copy_to_user_fdse=
t(efd_addr, &amp;efds, n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Same, reuse the macro defined above.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_tv_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D h2t_freebsd_timev=
al(&amp;tv, target_tv_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(error)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* pselect(2) */<br>
&gt; +static inline abi_long do_freebsd_pselect(CPUArchState *env, int n,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong rfd_addr, abi_ulong wfd_addr, a=
bi_ulong efd_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong ts_addr, abi_ulong set_addr)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cpu =3D env_cpu(env);<br>
&gt; +=C2=A0 =C2=A0 TaskState *tstate =3D cpu-&gt;opaque;<br>
&gt; +=C2=A0 =C2=A0 fd_set rfds, wfds, efds;<br>
&gt; +=C2=A0 =C2=A0 fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;<br>
&gt; +=C2=A0 =C2=A0 sigset_t *set_ptr;<br>
&gt; +=C2=A0 =C2=A0 struct timespec ts, *ts_ptr;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret, error;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D copy_from_user_fdset_ptr(&amp;rfds, &amp;rfds_p=
tr, rfd_addr, n);<br>
&gt; +=C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D copy_from_user_fdset_ptr(&amp;wfds, &amp;wfds_p=
tr, wfd_addr, n);<br>
&gt; +=C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D copy_from_user_fdset_ptr(&amp;efds, &amp;efds_p=
tr, efd_addr, n);<br>
&gt; +=C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
Same than above.<br></blockquote><div><br></div><div>I like these suggestio=
ns, but due to lack of good regression tests, I&#39;m going to defer them</=
div><div>since I know the code that&#39;s there works.</div><div><a href=3D=
"https://github.com/qemu-bsd-user/qemu-bsd-user/issues/66">https://github.c=
om/qemu-bsd-user/qemu-bsd-user/issues/66</a></div><div>memorializes the iss=
ue.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 /* Unlike select(), pselect() uses struct timespec inst=
ead of timeval */<br>
&gt; +=C2=A0 =C2=A0 if (ts_addr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timespec(&amp;ts, ts_addr=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ts_ptr =3D &amp;ts;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ts_ptr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (set_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D lock_user(VERIFY_READ, set_addr, si=
zeof(target_sigset_t), 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_to_host_sigset(&amp;tstate-&gt;sig=
suspend_mask, p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(p, set_addr, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_ptr =3D &amp;tstate-&gt;sigsuspend_ma=
sk;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_ptr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(safe_pselect(n, rfds_ptr, wfds_ptr, e=
fds_ptr, ts_ptr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_ptr));<br>
&gt; +=C2=A0 =C2=A0 if (ret !=3D -TARGET_ERESTART)=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tstate-&gt;in_sigsuspend =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rfd_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D copy_to_user_fdse=
t(rfd_addr, &amp;rfds, n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(error)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wfd_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D copy_to_user_fdse=
t(wfd_addr, &amp;wfds, n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(error)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (efd_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D copy_to_user_fdse=
t(efd_addr, &amp;efds, n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(error)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* ppoll(2) */<br>
&gt; +static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long a=
rg1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg2, abi_ulong arg3, abi_ulong =
arg4)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cpu =3D env_cpu(env);<br>
&gt; +=C2=A0 =C2=A0 TaskState *tstate =3D cpu-&gt;opaque;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 nfds_t i, nfds =3D arg2;<br>
&gt; +=C2=A0 =C2=A0 struct pollfd *pfd;<br>
&gt; +=C2=A0 =C2=A0 struct target_pollfd *target_pfd;<br>
&gt; +=C2=A0 =C2=A0 struct timespec ts, *ts_ptr;<br>
&gt; +=C2=A0 =C2=A0 sigset_t *set_ptr;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 target_pfd =3D lock_user(VERIFY_WRITE, arg1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct target_pollfd) * nfds, 1);<br>
&gt; +=C2=A0 =C2=A0 if (!target_pfd) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 pfd =3D alloca(sizeof(struct pollfd) * nfds);<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nfds; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pfd[i].fd =3D tswap32(target_pfd[i].fd);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pfd[i].events =3D tswap16(target_pfd[i].e=
vents);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Unlike poll(), ppoll() uses struct timespec. */<br>
&gt; +=C2=A0 =C2=A0 if (arg3) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timespec(&amp;ts, arg3)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ts_ptr =3D &amp;ts;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ts_ptr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg4 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D lock_user(VERIFY_READ, arg4, sizeof=
(target_sigset_t), 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_to_host_sigset(&amp;tstate-&gt;sig=
suspend_mask, p);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(p, arg4, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_ptr =3D &amp;tstate-&gt;sigsuspend_ma=
sk;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_ptr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(ppoll(pfd, nfds, ts_ptr, set_ptr));<b=
r>
&gt; +=C2=A0 =C2=A0 if (ret !=3D -TARGET_ERESTART) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tstate-&gt;in_sigsuspend =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; nfds; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_pfd[i].revents =3D t=
swap16(pfd[i].revents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 unlock_user(target_pfd, arg1, sizeof(struct target_poll=
fd) * nfds);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* kqueue(2) */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif /* FREEBSD_OS_TIME_H */<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000cd5f0e06591e2117--

