Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E32CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRcub-000252-3h; Mon, 25 May 2026 17:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRcuY-00024s-VM
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:32:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRcuV-0007SR-R8
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:32:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-83d31ac4017so4895479b3a.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779744750; cv=none;
 d=google.com; s=arc-20240605;
 b=G16gJvoYHh9b4U/xZIQajsjusg697BXgdrQ9jVt6C1AvLhwo/x6I/Vt0beAjpGQHhT
 yMKsl6z9q1N0InJfFWKdCAWAnM8wlVVJlqzmBVUx1B+s/fol9vk3gEJPFJSgNY/vH/0R
 qU2qxOdZ/WTB0/kiQB4tE3ITueBsPFs1d6LXHgL1TVx3a+yXkNDNaTM79Jd6yoVcjQnv
 3iWlyTJrfGwGLb9yNN5g4bvUMpwuNy9rqBbc1nKTL85UG3xLleu4VYtTJljoRuTnR9er
 0IFC1Pdb7dUDkxZswc38ic8R1xe+NQPon2/Zo2+h9jIX8KKkhkmf7MJZESVRvijFfI7x
 8RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YobKbDJOmy/Mv3H2VI4v0nQvqVfcdWdYnoFxRMoTGF4=;
 fh=oc95sRJdo3Mjfjp/egrNKP3OkecHKuGbWqKLHs0va7U=;
 b=etspUt4ntOue1TBYDmduVF8VG49qeW57xtdbRObMl/URFnnSdsvF9XZwi5M18teEHK
 PRKzPvD57TrbqOV7Zj3zzNd6wr8qLSHoOVyrEPnMtoJZKEpxvxh/OXg3oqhxbLFunm6y
 EgQtLrkH0PzXBhryUYC+hDYQWvUq8tzFWbV696Vqq0hDyzmf4mHPNl3LpEyfCfQqTkfL
 OlpGLwFGpnzxt6eJoGW2dbESK99JFRVTo3wddsc3RnL5LVKSngbdvAWpORzpHg+SDYSS
 w1rlByzLysU8XFJjTq6S73TYUaZDdZAXOd5dgL7xGSBqPDU9lcGNg05Dx2xDYjDUd4mt
 e4LQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779744750; x=1780349550;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YobKbDJOmy/Mv3H2VI4v0nQvqVfcdWdYnoFxRMoTGF4=;
 b=Af0MHng8rfRxC2R0icznSFNGDwajJvuVHFGvnNzKBvEcT8TrQD9pSBVu5x5Bn1owf8
 KlTroU6WsOrjUMe+Vp2WI5ASTePu/mfCk/IMzKRIAg+4xIU07ZSS2V33dAFwbMRoGYFV
 ZIYm6MAawcM6Lg+32rIghRYhWc4SZ9T2Dwebd6XxFC+1c/AGtYgpMfXG18pBGaJCYCZ7
 jWSro1Uck0gH73DOFPBTcYKwO4kLwOEVx4n4gycaepnrFKVbpHjVNoT/6vE0sd6ylwbC
 Sm0XSktLiYVPIKuNwNIY/sQtChNEjEwQeYDfwvU3VH0yrmqdkHAjbdsYy5hAkAgelaoF
 7Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779744750; x=1780349550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YobKbDJOmy/Mv3H2VI4v0nQvqVfcdWdYnoFxRMoTGF4=;
 b=FWh4dMqp6AYCX1n7Opq/bOq9odCX97EpXRe6ek7grmsyUCdJlV+CMBO3qJH+s5LfJE
 wDJcruYC0XeFiah8LXmh28ypISfxEvcnmEUXgUhlmXk8epiDsPNpY1Vtm7lrleWFTZym
 3rn+Mdf3wNwG7+dwe9gfHdv/dhmnljpCQsLXY/o1C4P0TgYwGowrsd8AYadWpKRsOHvb
 7g5+5TkcELf+rVvoaQq9mktMFW9WbJ66o2shgc8OSp/ZaswWs4OBfKxe7lKA9OodTQ6O
 iJ71IqaXb8HM40zZwZpMmjrb4QcxLiiOK5b5tjTyPqXojW/Airm8dKkUVBr0rEjxCqk1
 rxrA==
X-Gm-Message-State: AOJu0YzjvmcB+aaHkubjsOQwKf20pp3oeWukt2RT6NizYJdg6nGLZ/Xx
 mhPO7VGgrBjWZF8JNiUSKJkt2B1VdMJ7lQ134ZbSe7SusNK4jwYIvdGegGZmsKPAo+FneN8hPa8
 t9y4FkUK5XI3FwvKN70QqZojCNsbLtaeVo1le2uG5Rg==
X-Gm-Gg: Acq92OG0EC1cmMxbwBGxcdzzY0fVLuwlVFnchboT1sJG7V3nZ5IcJ4/IxqIa5rbUtkW
 aC++e7qu2+5iBzAPL7J+eFxn7+CN26w+JdVEjUM+L3sNCNjqScQXgTw3zWXbKl9a3jkqTF8BT53
 /orajiaGqlSKRto/LBGLTfnq/+mHe8FDXPHohnSPvDPPCSIXA9Lb0V6qGlYzL6+Ki/ekpCjmVgb
 PO1KnJTwMRQVCrmff3llMTFRGKxrGXFc/KZytiLqIsEBcflU6EChqInKQYzhEGxV1Gbcxj1IIAE
 QA+/QRqKwKxfzitKA5EoIpiDPu6zf2H76qGaTg==
X-Received: by 2002:a05:6a20:43a9:b0:3b3:1cab:33cf with SMTP id
 adf61e73a8af0-3b328c99142mr17242607637.16.1779744749793; Mon, 25 May 2026
 14:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-7-6c16fe448301@bsdimp.com>
 <8de010be-b2be-4e05-a748-2f9336eacade@oss.qualcomm.com>
In-Reply-To: <8de010be-b2be-4e05-a748-2f9336eacade@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 May 2026 15:32:18 -0600
X-Gm-Features: AVHnY4JdUag660373i1h85Rqt9dJFH4uRrYhixsXVn3M6B2wUcU-2jDHyqrqJYQ
Message-ID: <CANCZdfoBmQQ7H41njVYc76XtHM2h+nwXcuF1=KGuT4Acp5P1JA@mail.gmail.com>
Subject: Re: [PATCH v2 07/37] bsd-user: Add os-file.h with pipe2, chflagsat,
 close_range, and more
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000009a421d0652ab1de4"
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42d.google.com
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

--0000000000009a421d0652ab1de4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:54=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Add FreeBSD-specific file operation shims: pipe2, chflagsat,
> > close_range, copy_file_range, and __specialfd. Also add the
> > safe_copy_file_range and safe_ppoll syscall wrappers and the
> > target_specialfd_eventfd type definitions.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/freebsd/os-file.h    | 129
> ++++++++++++++++++++++++++++++++++++++++++
> >  bsd-user/freebsd/os-syscall.c |   7 +++
> >  2 files changed, 136 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
> > new file mode 100644
> > index 0000000000..c1da52789a
> > --- /dev/null
> > +++ b/bsd-user/freebsd/os-file.h
> > @@ -0,0 +1,129 @@
> > +/*
> > + * FreeBSD file related system call shims and definitions
> > + *
> > + * Copyright (c) 2014 Stacey D. Son
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#ifndef FREEBSD_OS_FILE_H
> > +#define FREEBSD_OS_FILE_H
> > +
> > +#include <sys/specialfd.h>
> > +
> > +/*
> > + * Asynchronous I/O.
> > + */
> > +
> > +/* pipe2(2) */
> > +static abi_long do_bsd_pipe2(CPUArchState *env, abi_ulong pipedes, int
> flags)
> > +{
> > +    int host_pipe[2];
> > +    int host_ret =3D pipe2(host_pipe, flags);
> > +    /* XXXss - flags should be translated from target to host. */
> > +
> > +    if (host_ret =3D=3D -1) {
> > +        return get_errno(host_ret);
> > +    }
> > +
> > +    /*
> > +     * pipe2() returns it's second FD by copying it back to userspace
> and not in
> > +     * a second register like pipe(2): set_second_rval(env,
> host_pipe[1]);
> > +     *
> > +     * Copy the FD's back to userspace:
> > +     */
> > +    if (put_user_s32(host_pipe[0], pipedes) ||
> > +        put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0]))) {
> > +        close(host_pipe[0]);
> > +        close(host_pipe[1]);
> > +        return -TARGET_EFAULT;
> > +    }
> > +    return 0;
> > +}
> > +
> > +/* chflagsat(2) */
> > +static inline abi_long do_bsd_chflagsat(int fd, abi_ulong path,
> > +        abi_ulong flags, int atflags)
> > +{
> > +    abi_long ret;
> > +    void *p;
> > +
> > +    LOCK_PATH(p, path);
> > +    ret =3D get_errno(chflagsat(fd, p, flags, atflags)); /* XXX path(p=
)?
> */
> > +    UNLOCK_PATH(p, path);
> > +
> > +    return ret;
> > +}
> > +
> > +/* close_range(2) */
> > +static inline abi_long do_freebsd_close_range(unsigned int lowfd,
> > +    unsigned int highfd, int flags)
> > +{
> > +
> > +    return get_errno(close_range(lowfd, highfd, flags));
> > +}
> > +
> > +ssize_t safe_copy_file_range(int, off_t *, int, off_t *, size_t,
> unsigned int);
> > +
> > +/* copy_file_range(2) */
> > +static inline abi_long do_freebsd_copy_file_range(int infd,
> > +    abi_ulong inofftp, int outfd, abi_ulong outofftp, size_t len,
> > +    unsigned int flags)
> > +{
> > +    off_t inoff, outoff, *inp, *outp;
> > +    abi_long ret;
> > +
> > +    inp =3D outp =3D NULL;
> > +    if (inofftp !=3D 0 && !access_ok(VERIFY_WRITE, inofftp,
> sizeof(off_t))) {
> > +        return -TARGET_EFAULT;
> > +    } else if (inofftp !=3D 0) {
> > +        inoff =3D tswap64(*(off_t *)g2h_untagged(inofftp));
> > +        inp =3D &inoff;
> > +    }
> > +    if (outofftp !=3D 0 && !access_ok(VERIFY_WRITE, outofftp,
> sizeof(off_t))) {
> > +        return -TARGET_EFAULT;
> > +    } else if (outofftp !=3D 0) {
> > +        outoff =3D tswap64(*(off_t *)g2h_untagged(outofftp));
> > +        outp =3D &outoff;
> > +    }
> > +
>
> Very small nit, but this pattern is a bit weird to read:
>
> Would be better with:
>
> if (inofftp !=3D 0) {
>   if (!access_ok(VERIFY_WRITE, inofftp, sizeof(off_t))) {
>     return -TARGET_EFAULT;
>   }
>   inoff =3D tswap64(*(off_t *)g2h_untagged(inofftp));
>   inp =3D &inoff;
> }
>

Yes. That's a better pattern. I've redone this and outoffp and had claude
double check.
You can check in the next rev :)


> > +    ret =3D get_errno(safe_copy_file_range(infd, inp, outfd, outp, len=
,
> > +        flags));
> > +
> > +    if (!is_error(ret)) {
> > +        if (inofftp !=3D 0) {
> > +            *(off_t *)g2h_untagged(inofftp) =3D tswap64(inoff);
> > +        }
> > +        if (outofftp !=3D 0) {
> > +            *(off_t *)g2h_untagged(outofftp) =3D tswap64(outoff);
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +static inline abi_long do_freebsd___specialfd(int type, abi_ulong req,
> > +    size_t len)
> > +{
> > +    abi_long ret;
> > +
> > +    ret =3D -TARGET_EINVAL;
> > +    switch (type) {
> > +    case TARGET_SPECIALFD_EVENT: {
> > +        struct specialfd_eventfd evfd;
> > +        struct target_specialfd_eventfd *target_eventfd;
> > +
> > +        if (!lock_user_struct(VERIFY_READ, target_eventfd, req, 1)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +
> > +        evfd.initval =3D tswap32(target_eventfd->initval);
> > +        evfd.flags =3D tswap32(target_eventfd->flags);
> > +        ret =3D get_errno(syscall(SYS___specialfd, type, &evfd,
> sizeof(evfd)));
> > +        unlock_user_struct(target_eventfd, req, 0);
> > +        break;
> > +    }
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +#endif /* FREEBSD_OS_FILE_H */
> > diff --git a/bsd-user/freebsd/os-syscall.c
> b/bsd-user/freebsd/os-syscall.c
> > index fc6273a780..8a25be4ac7 100644
> > --- a/bsd-user/freebsd/os-syscall.c
> > +++ b/bsd-user/freebsd/os-syscall.c
> > @@ -45,6 +45,7 @@
> >  #include "os-stat.h"
> >  #include "os-proc.h"
> >  #include "os-signal.h"
> > +#include "os-file.h"
> >  #include "os-misc.h"
> >
> >  /* I/O */
> > @@ -66,6 +67,12 @@ safe_syscall3(ssize_t, writev, int, fd, const struct
> iovec *, iov, int, iovcnt);
> >  safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov,
> int, iovcnt,
> >      off_t, offset);
> >
> > +safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
> > +    const struct timespec *, restrict_timeout, const sigset_t *,
> > +    restrict_newsigmask);
> > +safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp,
> int, outfd,
> > +    off_t *, outoffp, size_t, len, unsigned int, flags);
> > +
> >  /* used in os-proc */
> >  safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
> >      struct rusage *, rusage);
> >
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>

Thanks!

Warner

--0000000000009a421d0652ab1de4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 4:54=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Add FreeBSD-specific file operation shims: pipe2, chflagsat,<br>
&gt; close_range, copy_file_range, and __specialfd. Also add the<br>
&gt; safe_copy_file_range and safe_ppoll syscall wrappers and the<br>
&gt; target_specialfd_eventfd type definitions.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/os-file.h=C2=A0 =C2=A0 | 129 ++++++++++++++++++=
++++++++++++++++++++++++<br>
&gt;=C2=A0 bsd-user/freebsd/os-syscall.c |=C2=A0 =C2=A07 +++<br>
&gt;=C2=A0 2 files changed, 136 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..c1da52789a<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/freebsd/os-file.h<br>
&gt; @@ -0,0 +1,129 @@<br>
&gt; +/*<br>
&gt; + * FreeBSD file related system call shims and definitions<br>
&gt; + *<br>
&gt; + * Copyright (c) 2014 Stacey D. Son<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +#ifndef FREEBSD_OS_FILE_H<br>
&gt; +#define FREEBSD_OS_FILE_H<br>
&gt; +<br>
&gt; +#include &lt;sys/specialfd.h&gt;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Asynchronous I/O.<br>
&gt; + */<br>
&gt; +<br>
&gt; +/* pipe2(2) */<br>
&gt; +static abi_long do_bsd_pipe2(CPUArchState *env, abi_ulong pipedes, in=
t flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int host_pipe[2];<br>
&gt; +=C2=A0 =C2=A0 int host_ret =3D pipe2(host_pipe, flags);<br>
&gt; +=C2=A0 =C2=A0 /* XXXss - flags should be translated from target to ho=
st. */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (host_ret =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_errno(host_ret);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* pipe2() returns it&#39;s second FD by copying i=
t back to userspace and not in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* a second register like pipe(2): set_second_rval=
(env, host_pipe[1]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Copy the FD&#39;s back to userspace:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (put_user_s32(host_pipe[0], pipedes) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_user_s32(host_pipe[1], pipedes + size=
of(host_pipe[0]))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(host_pipe[0]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(host_pipe[1]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* chflagsat(2) */<br>
&gt; +static inline abi_long do_bsd_chflagsat(int fd, abi_ulong path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong flags, int atflags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 void *p;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 LOCK_PATH(p, path);<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(chflagsat(fd, p, flags, atflags)); /*=
 XXX path(p)? */<br>
&gt; +=C2=A0 =C2=A0 UNLOCK_PATH(p, path);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* close_range(2) */<br>
&gt; +static inline abi_long do_freebsd_close_range(unsigned int lowfd,<br>
&gt; +=C2=A0 =C2=A0 unsigned int highfd, int flags)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return get_errno(close_range(lowfd, highfd, flags));<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +ssize_t safe_copy_file_range(int, off_t *, int, off_t *, size_t, unsi=
gned int);<br>
&gt; +<br>
&gt; +/* copy_file_range(2) */<br>
&gt; +static inline abi_long do_freebsd_copy_file_range(int infd,<br>
&gt; +=C2=A0 =C2=A0 abi_ulong inofftp, int outfd, abi_ulong outofftp, size_=
t len,<br>
&gt; +=C2=A0 =C2=A0 unsigned int flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 off_t inoff, outoff, *inp, *outp;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 inp =3D outp =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 if (inofftp !=3D 0 &amp;&amp; !access_ok(VERIFY_WRITE, =
inofftp, sizeof(off_t))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 } else if (inofftp !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 inoff =3D tswap64(*(off_t *)g2h_untagged(=
inofftp));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 inp =3D &amp;inoff;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (outofftp !=3D 0 &amp;&amp; !access_ok(VERIFY_WRITE,=
 outofftp, sizeof(off_t))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 } else if (outofftp !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 outoff =3D tswap64(*(off_t *)g2h_untagged=
(outofftp));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 outp =3D &amp;outoff;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
Very small nit, but this pattern is a bit weird to read:<br>
<br>
Would be better with:<br>
<br>
if (inofftp !=3D 0) {<br>
=C2=A0 if (!access_ok(VERIFY_WRITE, inofftp, sizeof(off_t))) {<br>
=C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
=C2=A0 }<br>
=C2=A0 inoff =3D tswap64(*(off_t *)g2h_untagged(inofftp));<br>
=C2=A0 inp =3D &amp;inoff;<br>
}<br></blockquote><div><br></div><div>Yes. That&#39;s a better pattern. I&#=
39;ve redone this and outoffp and had claude double check.</div><div>You ca=
n check in the next rev :)</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(safe_copy_file_range(infd, inp, outfd=
, outp, len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (inofftp !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(off_t *)g2h_untagged(inof=
ftp) =3D tswap64(inoff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (outofftp !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(off_t *)g2h_untagged(outo=
fftp) =3D tswap64(outoff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline abi_long do_freebsd___specialfd(int type, abi_ulong req=
,<br>
&gt; +=C2=A0 =C2=A0 size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 switch (type) {<br>
&gt; +=C2=A0 =C2=A0 case TARGET_SPECIALFD_EVENT: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct specialfd_eventfd evfd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct target_specialfd_eventfd *target_e=
ventfd;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target=
_eventfd, req, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 evfd.initval =3D tswap32(target_eventfd-&=
gt;initval);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 evfd.flags =3D tswap32(target_eventfd-&gt=
;flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(syscall(SYS___specialfd=
, type, &amp;evfd, sizeof(evfd)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user_struct(target_eventfd, req, 0=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +#endif /* FREEBSD_OS_FILE_H */<br>
&gt; diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-sysca=
ll.c<br>
&gt; index fc6273a780..8a25be4ac7 100644<br>
&gt; --- a/bsd-user/freebsd/os-syscall.c<br>
&gt; +++ b/bsd-user/freebsd/os-syscall.c<br>
&gt; @@ -45,6 +45,7 @@<br>
&gt;=C2=A0 #include &quot;os-stat.h&quot;<br>
&gt;=C2=A0 #include &quot;os-proc.h&quot;<br>
&gt;=C2=A0 #include &quot;os-signal.h&quot;<br>
&gt; +#include &quot;os-file.h&quot;<br>
&gt;=C2=A0 #include &quot;os-misc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* I/O */<br>
&gt; @@ -66,6 +67,12 @@ safe_syscall3(ssize_t, writev, int, fd, const struc=
t iovec *, iov, int, iovcnt);<br>
&gt;=C2=A0 safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, i=
ov, int, iovcnt,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 off_t, offset);<br>
&gt;=C2=A0 <br>
&gt; +safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,<br>
&gt; +=C2=A0 =C2=A0 const struct timespec *, restrict_timeout, const sigset=
_t *,<br>
&gt; +=C2=A0 =C2=A0 restrict_newsigmask);<br>
&gt; +safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, i=
nt, outfd,<br>
&gt; +=C2=A0 =C2=A0 off_t *, outoffp, size_t, len, unsigned int, flags);<br=
>
&gt; +<br>
&gt;=C2=A0 /* used in os-proc */<br>
&gt;=C2=A0 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, opt=
ions,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct rusage *, rusage);<br>
&gt; <br>
<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qu=
alcomm.com" target=3D"_blank">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>=
</blockquote><div><br></div><div>Thanks!</div><div><br></div><div>Warner=C2=
=A0</div></div></div>

--0000000000009a421d0652ab1de4--

