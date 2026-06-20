Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FE3CD98F6
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 02:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1walfu-0001Zz-Bi; Fri, 19 Jun 2026 22:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1walfn-0001Zr-VL
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 22:43:09 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1walfi-00031O-El
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 22:43:06 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5bbca605be3so2277634e0c.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 19:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781923381; cv=none;
 d=google.com; s=arc-20240605;
 b=YkPDAdBFgv3J7Z/LV7alyyi6WO+2aJbrL29eXHfm7OxPxn7mZ1O0pV7XROUGveRsFr
 JA4l9SC+n9Mtb203NQJS8xsooTjM2uDrj1YIFHt9SPphiI0jtJEtNh0imV8ha5KkGHzb
 aRQ3cA2Evrlbv+fkysCIpQOuF1B9ahUSW92NGIE4QiIp1vLhBCjiHbBgrk1wUdjo7xKq
 wuctql6l4gnej1GgRBj6drDInKBsWx7xr8Q0t6I1mIuXRNdcxMaMEBBXZjG42y50eQfT
 qqWx59Ms2jmMPm7pjbOXXMeZlf4VRdLsJenwLzuey/C+Gtr8R6OnF0ouPr+DXWuUtLyV
 wVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T0T4cW5HbLqks1Yf/xiBXd+TUze4MwImbwmEB80NSEk=;
 fh=Dr8Vecsy77sRT7MZw4BAX84bgC3kPDutw0JQ5v0KlWM=;
 b=cvxVGtQ9FCXUQHo807G602awvrdKf1d6IO+HCdwk9RxM085LiiZcDmJGWF/e/STw9a
 ACpaM94hI3y2w71AThjFTDY96YZB/qygtYldrwzorAeYAPgK5aHpgZgB07vMcjnAmFYf
 P2V8BydeY47ZqkdNelSZujSaFmHZdJXtwfploW8cxNRLOWbe2Qxsj0Kh6is6FAVlwNPo
 f7E9bSidZKBM0JGdRPiPiS6k5TpxBOVqHPslCFYbj6mvm0Uu1FEjg1FmOzYkwASyAgjQ
 LdqhwwAL2zRYsruPSszM/VJXjKMriGj+y0T09nhUT7A503YDMA0rMpu8ke+A6ZAiuGFD
 uFzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1781923381; x=1782528181;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T0T4cW5HbLqks1Yf/xiBXd+TUze4MwImbwmEB80NSEk=;
 b=yu6nd6ZUYNP+6Ob5klGkUV6JXOWwHOosXQN/EV6xHoI0juZlDCIkhu2XkXlmQg7Y0T
 EcdHCRekN3PrrFst+B51NiyOutolkndMWXxHDNX/t4WzptnzzYFhmA3osGRwExwwNe/a
 loOkZUnJZvb2L3C3LhorA5sM/+nqI5pe3jn+KFjff/pGrfMUqbCyudGOr5ZwkS65J2DC
 +BN6w/ggYzSANeAesCTrK2BHScsFPsfGS8nPvt7FPcdeeMRRUwLcG4iKuuuWmKXshhW6
 +1LTXcr+aAGvu4abGKYWQA3q6lBreSmG5pHE6s8v3PMSZZmyC3gA368F4vaV7Cf/idH7
 +/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781923381; x=1782528181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0T4cW5HbLqks1Yf/xiBXd+TUze4MwImbwmEB80NSEk=;
 b=Ev632A0/Ma/sI4aVdZW3cc247ezmzDHJAufEoAe+eLSYTGY48fogX5GFd4UOS77Fte
 OaLf14Feh3aHG+5sfLToyAfaVhhb8TlxkkoC6o5G23d14yvIn7hZrBRj1vcjvwlOddr/
 oH2goHz7fnkzkkXGCHlnh6OwGKu7BWgOQrdRSY6Eb5n88cmy4vjbZDDNKpSGOjQENTyv
 0Dwlg9kdmbRVtWzKe1EDu4ZEk57e0nGiweBdIZnjTtM9bkNOYTYBW3/ShhLtZSlRHfQR
 T6fa++2p87Edu9FGJS5lMj+oHq4ff9IKAwwQ355FAklXQQRvfsTuq83zosDyhHiIkAIC
 Q43Q==
X-Gm-Message-State: AOJu0Yw3W1UvQrEjLDem6TiJBbSPLI9nsFvX0KXDF6M8l2cwOfeqA474
 vjfzNNB+PCIB6dsiMky2iMDneXMI633fqi8qKAVd74DcgoF92fiJYiKqoL0+6QsZ4w1DJH+KXzh
 QBlsLX1hNgX+xjKFFbOhkdbqzLqC0l14T3YcPeSLyJBuAe3a3AMKuXIwmyA==
X-Gm-Gg: AfdE7cm59VqiWdTs6Glzcr19O/j4Sc7KONXxEzio9erUMzUN8mXLFtk639KGjcM3Rnz
 Rh+btyTjpUsO8wqVvYU5+8TXRbRs+3lS4ig9V8CNAZ6JJrZO4RiEKEkAoPMD5eoN5KfwWcGLrJN
 0GlR3eE2UaODenIJ++HAfe8Ig1TDj7RKjbWKJ6F9dET2oQMRHP33OcD9NbPBcAKoroCsnRBzXk7
 q+Mu0ICVmL8vevaDuUmUMDXdjwdfFnyYVnQ6CG0dvTLwHwzzcUI59Bo/YZkxUUcJmUeIfv5lE9H
 DCcxUjl6
X-Received: by 2002:a17:90a:dfc8:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-37d199a59c0mr4512671a91.4.1781922662746; Fri, 19 Jun 2026
 19:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-20-6c16fe448301@bsdimp.com>
 <422b450f-2a19-4bd6-b4b5-25e554b75e8b@oss.qualcomm.com>
In-Reply-To: <422b450f-2a19-4bd6-b4b5-25e554b75e8b@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 19 Jun 2026 22:30:51 -0400
X-Gm-Features: AVVi8CcNI0FcYG_YyXHI9R6fHvN955le4lfghq1AEUW33DR0XyV7ZIPD3s8ZObw
Message-ID: <CANCZdfqUQ2U6CuKFph3+LT=TFXS6_xPcTidEtPEbr9Wgkv0yHQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] bsd-user: Add kqueue and kevent functions to
 os-time.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000549dd50654a63337"
Received-SPF: none client-ip=2607:f8b0:4864:20::a35;
 envelope-from=wlosh@bsdimp.com; helo=mail-vk1-xa35.google.com
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

--000000000000549dd50654a63337
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 7:49=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Add event notification system call shims: kqueue, freebsd11_kevent
> > (legacy 32-bit data field), and kevent (with 64-bit ext fields).
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/freebsd/os-time.h | 173
> +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 173 insertions(+)
> >
> > diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
> > index 12c5ba02e8..078355392d 100644
> > --- a/bsd-user/freebsd/os-time.h
> > +++ b/bsd-user/freebsd/os-time.h
> > @@ -629,5 +629,178 @@ static inline abi_long
> do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
> >  }
> >
> >  /* kqueue(2) */
> > +static inline abi_long do_freebsd_kqueue(void)
> > +{
> > +
> > +    return get_errno(kqueue());
> > +}
> > +
> > +/* kevent(2) */
> > +/* XXX Maybe some day, consolidate these two... */
> > +static inline abi_long do_freebsd_freebsd11_kevent(abi_long arg1,
> > +    abi_ulong arg2, abi_long arg3, abi_ulong arg4, abi_long arg5,
> abi_long arg6)
> > +{
> > +    abi_long ret;
> > +    struct kevent *changelist =3D NULL, *eventlist =3D NULL;
> > +    struct target_freebsd11_kevent *target_changelist,
> *target_eventlist;
> > +    struct timespec ts;
> > +    int i;
> > +
> > +    if (arg3 !=3D 0) {
> > +        target_changelist =3D lock_user(VERIFY_READ, arg2,
> > +                                      sizeof(*target_changelist) *
> arg3, 1);
> > +        if (target_changelist =3D=3D NULL) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +
> > +        changelist =3D alloca(sizeof(struct kevent) * arg3);
> > +        memset(changelist, '\0', sizeof(struct kevent) * arg3);
> > +        for (i =3D 0; i < arg3; i++) {
> > +            __get_user(changelist[i].ident,
> &target_changelist[i].ident);
> > +            __get_user(changelist[i].filter,
> &target_changelist[i].filter);
> > +            __get_user(changelist[i].flags,
> &target_changelist[i].flags);
> > +            __get_user(changelist[i].fflags,
> &target_changelist[i].fflags);
> > +            __get_user(changelist[i].data, &target_changelist[i].data)=
;
> > +            /* __get_user(changelist[i].udata,
> &target_changelist[i].udata); */
> > +#if TARGET_ABI_BITS =3D=3D 32
> > +            changelist[i].udata =3D (void
> *)(uintptr_t)target_changelist[i].udata;
> > +            tswap32s((uint32_t *)&changelist[i].udata);
> > +#else
> > +            changelist[i].udata =3D (void
> *)(uintptr_t)target_changelist[i].udata;
> > +            tswap64s((uint64_t *)&changelist[i].udata);
> > +#endif
> > +        }
> > +        unlock_user(target_changelist, arg2, sizeof(*target_changelist=
)
> * arg3);
> > +    }
> > +
> > +    if (arg5 !=3D 0) {
> > +        eventlist =3D alloca(sizeof(struct kevent) * arg5);
> > +    }
> > +    if (arg6 !=3D 0) {
> > +        if (t2h_freebsd_timespec(&ts, arg6)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +    }
> > +    ret =3D get_errno(safe_kevent(arg1, changelist, arg3, eventlist, a=
rg5,
> > +                                arg6 !=3D 0 ? &ts : NULL));
> > +
> > +    if (arg5 =3D=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (!is_error(ret)) {
> > +        target_eventlist =3D lock_user(VERIFY_WRITE, arg4,
> > +                                     sizeof(*target_eventlist) * arg5,
> 0);
> > +        if (target_eventlist =3D=3D NULL) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        for (i =3D 0; i < ret; i++) {
> > +            __put_user(eventlist[i].ident, &target_eventlist[i].ident)=
;
> > +            __put_user(eventlist[i].filter,
> &target_eventlist[i].filter);
> > +            __put_user(eventlist[i].flags, &target_eventlist[i].flags)=
;
> > +            __put_user(eventlist[i].fflags,
> &target_eventlist[i].fflags);
> > +            __put_user(eventlist[i].data, &target_eventlist[i].data);
> > +            /* __put_user(eventlist[i].udata,
> &target_eventlist[i].udata);*/
> > +#if TARGET_ABI_BITS =3D=3D 32
> > +            tswap32s((uint32_t *)&eventlist[i].udata);
> > +            target_eventlist[i].udata =3D (uintptr_t)eventlist[i].udat=
a;
> > +#else
> > +            tswap64s((uint64_t *)&eventlist[i].udata);
> > +            target_eventlist[i].udata =3D (uintptr_t)eventlist[i].udat=
a;
> > +#endif
> > +        }
> > +        unlock_user(target_eventlist, arg4,
> > +                    sizeof(*target_eventlist) * ret);
> > +    }
> > +    return ret;
> > +}
> > +
> > +/* kevent(2) */
> > +static inline abi_long do_freebsd_kevent(abi_long arg1, abi_ulong arg2=
,
> > +        abi_long arg3, abi_ulong arg4, abi_long arg5, abi_long arg6)
> > +{
> > +    abi_long ret;
> > +    struct kevent *changelist =3D NULL, *eventlist =3D NULL;
> > +    struct target_freebsd_kevent *target_changelist, *target_eventlist=
;
> > +    struct timespec ts;
> > +    int i;
> > +
> > +    if (arg3 !=3D 0) {
> > +        target_changelist =3D lock_user(VERIFY_READ, arg2,
> > +                sizeof(struct target_freebsd_kevent) * arg3, 1);
> > +        if (target_changelist =3D=3D NULL) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +
> > +        changelist =3D alloca(sizeof(struct kevent) * arg3);
> > +        for (i =3D 0; i < arg3; i++) {
> > +            __get_user(changelist[i].ident,
> &target_changelist[i].ident);
> > +            __get_user(changelist[i].filter,
> &target_changelist[i].filter);
> > +            __get_user(changelist[i].flags,
> &target_changelist[i].flags);
> > +            __get_user(changelist[i].fflags,
> &target_changelist[i].fflags);
> > +            __get_user(changelist[i].data, &target_changelist[i].data)=
;
> > +            /* __get_user(changelist[i].udata,
> &target_changelist[i].udata); */
> > +#if TARGET_ABI_BITS =3D=3D 32
> > +            changelist[i].udata =3D (void
> *)(uintptr_t)target_changelist[i].udata;
> > +            tswap32s((uint32_t *)&changelist[i].udata);
> > +#else
> > +            changelist[i].udata =3D (void
> *)(uintptr_t)target_changelist[i].udata;
> > +            tswap64s((uint64_t *)&changelist[i].udata);
> > +#endif
> > +            __get_user(changelist[i].ext[0],
> &target_changelist[i].ext[0]);
> > +            __get_user(changelist[i].ext[1],
> &target_changelist[i].ext[1]);
> > +            __get_user(changelist[i].ext[2],
> &target_changelist[i].ext[2]);
> > +            __get_user(changelist[i].ext[3],
> &target_changelist[i].ext[3]);
> > +        }
> > +        unlock_user(target_changelist, arg2, 0);
> > +    }
> > +
> > +    if (arg5 !=3D 0) {
> > +        eventlist =3D alloca(sizeof(struct kevent) * arg5);
> > +    }
> > +    if (arg6 !=3D 0) {
> > +        if (t2h_freebsd_timespec(&ts, arg6)) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +    }
> > +    ret =3D get_errno(safe_kevent(arg1, changelist, arg3, eventlist, a=
rg5,
> > +                                arg6 !=3D 0 ? &ts : NULL));
> > +
> > +    if (arg5 =3D=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (!is_error(ret)) {
> > +        target_eventlist =3D lock_user(VERIFY_WRITE, arg4,
> > +            sizeof(struct target_freebsd_kevent) * arg5, 0);
> > +        if (target_eventlist =3D=3D NULL) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        for (i =3D 0; i < ret; i++) {
> > +            __put_user(eventlist[i].ident, &target_eventlist[i].ident)=
;
> > +            __put_user(eventlist[i].filter,
> &target_eventlist[i].filter);
> > +            __put_user(eventlist[i].flags, &target_eventlist[i].flags)=
;
> > +            __put_user(eventlist[i].fflags,
> &target_eventlist[i].fflags);
> > +            __put_user(eventlist[i].data, &target_eventlist[i].data);
> > +            /* __put_user(eventlist[i].udata,
> &target_eventlist[i].udata);*/
> > +#if TARGET_ABI_BITS =3D=3D 32
> > +            tswap32s((uint32_t *)&eventlist[i].udata);
> > +            target_eventlist[i].udata =3D (uintptr_t)eventlist[i].udat=
a;
> > +#else
> > +            tswap64s((uint64_t *)&eventlist[i].udata);
> > +            target_eventlist[i].udata =3D (uintptr_t)eventlist[i].udat=
a;
> > +#endif
> > +            __put_user(eventlist[i].ext[0],
> &target_eventlist[i].ext[0]);
> > +            __put_user(eventlist[i].ext[1],
> &target_eventlist[i].ext[1]);
> > +            __put_user(eventlist[i].ext[2],
> &target_eventlist[i].ext[2]);
> > +            __put_user(eventlist[i].ext[3],
> &target_eventlist[i].ext[3]);
> > +        }
> > +        unlock_user(target_eventlist, arg4,
> > +                sizeof(struct target_freebsd_kevent) * ret);
> > +    }
> > +    return ret;
> > +}
> > +
> > +/* sigtimedwait(2) */
> >
> >  #endif /* FREEBSD_OS_TIME_H */
> >
>
> If I understand correctly, the difference between the two is only in
> get/put user for eventlist[i].ext[*].
> It seems worth to factorize the two and add a parameter to switch
> between the two.
>

It's close, but the structures have slightly different layouts, so it's har=
d
to refactor. I know there's an XXX comment suggesting that we should
combine these, but I'd kinda like to postpone that. It may be that we'll
just delete the kevent11 which may happen soon (we kept it long past
the end of FreeBSD 11 support because it was one of the system calls
that rust used, and that may finally be deployed widely enough to retire
it).

Warner

--000000000000549dd50654a63337
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 7:49=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Add event notification system call shims: kqueue, freebsd11_kevent<br>
&gt; (legacy 32-bit data field), and kevent (with 64-bit ext fields).<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.uranka=
r@gmail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Sean Bruno &lt;sbruno@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/os-time.h | 173 +++++++++++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 1 file changed, 173 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h<b=
r>
&gt; index 12c5ba02e8..078355392d 100644<br>
&gt; --- a/bsd-user/freebsd/os-time.h<br>
&gt; +++ b/bsd-user/freebsd/os-time.h<br>
&gt; @@ -629,5 +629,178 @@ static inline abi_long do_freebsd_ppoll(CPUArchS=
tate *env, abi_long arg1,<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* kqueue(2) */<br>
&gt; +static inline abi_long do_freebsd_kqueue(void)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return get_errno(kqueue());<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* kevent(2) */<br>
&gt; +/* XXX Maybe some day, consolidate these two... */<br>
&gt; +static inline abi_long do_freebsd_freebsd11_kevent(abi_long arg1,<br>
&gt; +=C2=A0 =C2=A0 abi_ulong arg2, abi_long arg3, abi_ulong arg4, abi_long=
 arg5, abi_long arg6)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 struct kevent *changelist =3D NULL, *eventlist =3D NULL=
;<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd11_kevent *target_changelist, *tar=
get_eventlist;<br>
&gt; +=C2=A0 =C2=A0 struct timespec ts;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg3 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_changelist =3D lock_user(VERIFY_RE=
AD, arg2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(*tar=
get_changelist) * arg3, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_changelist =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 changelist =3D alloca(sizeof(struct keven=
t) * arg3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(changelist, &#39;\0&#39;, sizeof(s=
truct kevent) * arg3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; arg3; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].id=
ent, &amp;target_changelist[i].ident);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].fi=
lter, &amp;target_changelist[i].filter);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].fl=
ags, &amp;target_changelist[i].flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].ff=
lags, &amp;target_changelist[i].fflags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].da=
ta, &amp;target_changelist[i].data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* __get_user(changelist[i]=
.udata, &amp;target_changelist[i].udata); */<br>
&gt; +#if TARGET_ABI_BITS =3D=3D 32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changelist[i].udata =3D (vo=
id *)(uintptr_t)target_changelist[i].udata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap32s((uint32_t *)&amp;c=
hangelist[i].udata);<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changelist[i].udata =3D (vo=
id *)(uintptr_t)target_changelist[i].udata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap64s((uint64_t *)&amp;c=
hangelist[i].udata);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(target_changelist, arg2, size=
of(*target_changelist) * arg3);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg5 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 eventlist =3D alloca(sizeof(struct kevent=
) * arg5);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (arg6 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timespec(&amp;ts, arg6)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(safe_kevent(arg1, changelist, arg3, e=
ventlist, arg5,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg6 !=3D 0 ? &amp;ts : NULL));<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg5 =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_eventlist =3D lock_user(VERIFY_WRI=
TE, arg4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(*targ=
et_eventlist) * arg5, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_eventlist =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ret; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ide=
nt, &amp;target_eventlist[i].ident);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].fil=
ter, &amp;target_eventlist[i].filter);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].fla=
gs, &amp;target_eventlist[i].flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ffl=
ags, &amp;target_eventlist[i].fflags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].dat=
a, &amp;target_eventlist[i].data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* __put_user(eventlist[i].=
udata, &amp;target_eventlist[i].udata);*/<br>
&gt; +#if TARGET_ABI_BITS =3D=3D 32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap32s((uint32_t *)&amp;e=
ventlist[i].udata);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_eventlist[i].udata =
=3D (uintptr_t)eventlist[i].udata;<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap64s((uint64_t *)&amp;e=
ventlist[i].udata);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_eventlist[i].udata =
=3D (uintptr_t)eventlist[i].udata;<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(target_eventlist, arg4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 sizeof(*target_eventlist) * ret);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* kevent(2) */<br>
&gt; +static inline abi_long do_freebsd_kevent(abi_long arg1, abi_ulong arg=
2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg3, abi_ulong arg4, abi_long a=
rg5, abi_long arg6)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 struct kevent *changelist =3D NULL, *eventlist =3D NULL=
;<br>
&gt; +=C2=A0 =C2=A0 struct target_freebsd_kevent *target_changelist, *targe=
t_eventlist;<br>
&gt; +=C2=A0 =C2=A0 struct timespec ts;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg3 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_changelist =3D lock_user(VERIFY_RE=
AD, arg2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct=
 target_freebsd_kevent) * arg3, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_changelist =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 changelist =3D alloca(sizeof(struct keven=
t) * arg3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; arg3; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].id=
ent, &amp;target_changelist[i].ident);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].fi=
lter, &amp;target_changelist[i].filter);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].fl=
ags, &amp;target_changelist[i].flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].ff=
lags, &amp;target_changelist[i].fflags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].da=
ta, &amp;target_changelist[i].data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* __get_user(changelist[i]=
.udata, &amp;target_changelist[i].udata); */<br>
&gt; +#if TARGET_ABI_BITS =3D=3D 32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changelist[i].udata =3D (vo=
id *)(uintptr_t)target_changelist[i].udata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap32s((uint32_t *)&amp;c=
hangelist[i].udata);<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changelist[i].udata =3D (vo=
id *)(uintptr_t)target_changelist[i].udata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap64s((uint64_t *)&amp;c=
hangelist[i].udata);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].ex=
t[0], &amp;target_changelist[i].ext[0]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].ex=
t[1], &amp;target_changelist[i].ext[1]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].ex=
t[2], &amp;target_changelist[i].ext[2]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(changelist[i].ex=
t[3], &amp;target_changelist[i].ext[3]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(target_changelist, arg2, 0);<=
br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg5 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 eventlist =3D alloca(sizeof(struct kevent=
) * arg5);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (arg6 !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (t2h_freebsd_timespec(&amp;ts, arg6)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(safe_kevent(arg1, changelist, arg3, e=
ventlist, arg5,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg6 !=3D 0 ? &amp;ts : NULL));<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (arg5 =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_eventlist =3D lock_user(VERIFY_WRI=
TE, arg4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct target_freebs=
d_kevent) * arg5, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_eventlist =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ret; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ide=
nt, &amp;target_eventlist[i].ident);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].fil=
ter, &amp;target_eventlist[i].filter);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].fla=
gs, &amp;target_eventlist[i].flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ffl=
ags, &amp;target_eventlist[i].fflags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].dat=
a, &amp;target_eventlist[i].data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* __put_user(eventlist[i].=
udata, &amp;target_eventlist[i].udata);*/<br>
&gt; +#if TARGET_ABI_BITS =3D=3D 32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap32s((uint32_t *)&amp;e=
ventlist[i].udata);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_eventlist[i].udata =
=3D (uintptr_t)eventlist[i].udata;<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap64s((uint64_t *)&amp;e=
ventlist[i].udata);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_eventlist[i].udata =
=3D (uintptr_t)eventlist[i].udata;<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ext=
[0], &amp;target_eventlist[i].ext[0]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ext=
[1], &amp;target_eventlist[i].ext[1]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ext=
[2], &amp;target_eventlist[i].ext[2]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(eventlist[i].ext=
[3], &amp;target_eventlist[i].ext[3]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(target_eventlist, arg4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct=
 target_freebsd_kevent) * ret);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* sigtimedwait(2) */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif /* FREEBSD_OS_TIME_H */<br>
&gt; <br>
<br>
If I understand correctly, the difference between the two is only in<br>
get/put user for eventlist[i].ext[*].<br>
It seems worth to factorize the two and add a parameter to switch<br>
between the two.<br></blockquote><div><br></div><div>It&#39;s close, but th=
e structures have slightly different layouts, so it&#39;s hard</div><div>to=
 refactor. I know there&#39;s an XXX comment suggesting that we should</div=
><div>combine these, but I&#39;d kinda like to postpone that. It may be tha=
t we&#39;ll</div><div>just delete the kevent11 which may happen soon (we ke=
pt it long past</div><div>the end of FreeBSD 11 support because it was one =
of the system calls</div><div>that rust used, and that may finally be deplo=
yed widely enough to retire</div><div>it).</div><div><br></div><div>Warner=
=C2=A0</div></div></div>

--000000000000549dd50654a63337--

