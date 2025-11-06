Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D45DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH25r-0002Q5-64; Thu, 06 Nov 2025 10:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balint@balintreczey.hu>)
 id 1vH25p-0002Pu-Gn
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:40:09 -0500
Received: from h13.levelcenter.hu ([92.43.200.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balint@balintreczey.hu>)
 id 1vH25l-0005LM-Cx
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:40:08 -0500
Received: from ujproxy07.mediacenter.hu ([92.43.200.137]
 helo=mail-ed1-f41.google.com)
 by h13.levelcenter.hu with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <balint@balintreczey.hu>)
 id 1vH25g-000Hwt-EM
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 16:40:00 +0100
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso1679200a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:40:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUqKiGdRoMisCiSoe1ThGQSLfq3h0yR4Hbit3uD/mGjp5Cke5dEQpX/Tf3EfHTECz9ozxX+GZtyDusC@nongnu.org
X-Gm-Message-State: AOJu0YzLu3lrzdyxoYmYOGg1FIIIkFIP9JecYIIXN7YQVSXMDUkVMutU
 vlhAIblp3niXEZDfEyxiczgu8TLomWc5NjBui7YpgD4+DN/sGtgknG/JXw5s8fkRe4jeRRxKQjm
 G71bEgp1ANWXXmMN7ump/k3qp1qeKTmg=
X-Google-Smtp-Source: AGHT+IEehvRbghXk1xo43PlGhEtaUjk3rfJICNtLDjXp2Nis7SHCMX6jLRUNsX/JoKkHqYwFXP6m5+BsF53NoPLA4dQ=
X-Received: by 2002:a05:6402:42c7:b0:641:1cd6:fecd with SMTP id
 4fb4d7f45d1cf-6411cd708c2mr3693219a12.8.1762443600036; Thu, 06 Nov 2025
 07:40:00 -0800 (PST)
MIME-Version: 1.0
References: <bae8d02e3d6c909c07a14b5a2ca0a816.rbalint@gmail.com>
 <CAFEAcA9jzkZ_PSXvjDEXyGB1=NAKuMEphhKeMeahXcfXXDmWUg@mail.gmail.com>
In-Reply-To: <CAFEAcA9jzkZ_PSXvjDEXyGB1=NAKuMEphhKeMeahXcfXXDmWUg@mail.gmail.com>
Date: Thu, 6 Nov 2025 16:39:47 +0100
X-Gmail-Original-Message-ID: <CAK0OdpzG9UVktcHtSqmyw2P4OAQaKVsqG5skgxxxAJj3dt4i4g@mail.gmail.com>
X-Gm-Features: AWmQ_blRDimfRoc07JlME_igIWWehXunxieWTUlxz1h9aSHRRqo8a1wpIgDO5x8
Message-ID: <CAK0OdpzG9UVktcHtSqmyw2P4OAQaKVsqG5skgxxxAJj3dt4i4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] user: add runtime switch to call safe_syscall via libc
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=92.43.200.153;
 envelope-from=balint@balintreczey.hu; helo=h13.levelcenter.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  balint@balintreczey.hu
X-ACL-Warn: ,  =?UTF-8?B?QsOhbGludCBSw6ljemV5?= <balint@balintreczey.hu>
From:  =?UTF-8?B?QsOhbGludCBSw6ljemV5?= via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

Thank you for the review!

Peter Maydell <peter.maydell@linaro.org> ezt =C3=ADrta (id=C5=91pont: 2025.=
 nov.
5., Sze, 14:53):
>
> On Tue, 4 Nov 2025 at 22:08, Balint Reczey via <qemu-devel@nongnu.org> wr=
ote:
> >
> > Add a libc-backed path for safe_syscall() that make syscalls via
> > libc's syscall(). This enables interposing syscalls via LD_PRELOAD when
> > running static guest binaries under a dynamically linked qemu-user.
> >
> > The assembly implementation (safe_syscall_base()) remains the default.
> > A runtime switch or a set environment variable changes the behavior:
> >
> > Command line: -libc-syscall
> > Environment: QEMU_LIBC_SYSCALL
>
> > +/*
> > + * libc-backed implementation: Make a system call via libc's syscall()
> > + * if no guest signal is pending.
> > + */
> > +long safe_syscall_libc(int *pending, long number, ...)
> > +{
> > +    va_list ap;
> > +    long arg1, arg2, arg3, arg4, arg5, arg6;
> > +    long ret;
> > +
> > +    /* Check if a guest signal is pending */
> > +    if (qatomic_read(pending)) {
> > +        errno =3D QEMU_ERESTARTSYS;
> > +        return -1;
> > +    }
>
> We check for a pending signal here...
>
> > +
> > +    va_start(ap, number);
> > +    /* Extract up to 6 syscall arguments */
> > +    arg1 =3D va_arg(ap, long);
> > +    arg2 =3D va_arg(ap, long);
> > +    arg3 =3D va_arg(ap, long);
> > +    arg4 =3D va_arg(ap, long);
> > +    arg5 =3D va_arg(ap, long);
> > +    arg6 =3D va_arg(ap, long);
> > +    va_end(ap);
>
> ...but if a signal arrives after we checked but somewhere in here
> before we actually make the host syscall, then we may incorrectly
> block in the syscall.
>
> > +
> > +    /* Make the actual system call using libc's syscall() */
> > +    ret =3D syscall(number, arg1, arg2, arg3, arg4, arg5, arg6);
>
> This is the race condition which is the reason why safe_syscall
> is implemented in assembly: we need to be able to control exactly
> which code we're in so that the signal handler can adjust the PC
> if it sees that we were attempting to do a syscall when the
> signal arrived. (There's a longer explanation of this in a comment
> in include/user/safe-syscall.h.)

Yes, indeed. I moved the pending check right before the syscall()
call, but there is still a race and I think it can't be resolved as
well as it is done in the assembly implementation.

> Not getting this right results in various hangs and
> other misbehaviour when a signal arrives to the guest
> program at the wrong moment. We don't want to regress
> that behaviour. Any proposal for having QEMU call syscall()
> needs to avoid reintroducing the races.

Yes, this is why there is a run-time switch to choose the less
safe behavior, but I understand that this still may not be acceptable
for the project.
It works beautifully though for wrapping statically linked tools in builds,
thus for anyone interested the patch will be maintained at:
https://github.com/firebuild/qemu/tree/safe-syscalls-via-libc

Cheers,
Balint

> thanks
> -- PMM

