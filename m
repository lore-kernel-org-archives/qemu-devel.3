Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tub48-0007Ex-NQ; Tue, 18 Mar 2025 13:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tub3o-00076t-T0
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:49:18 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tub3m-0001gY-8L
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:49:04 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso4712696276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742320107; x=1742924907; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEl+rBbulfCvdsYq0HFcMiL7cJUjiyQsWfYOMDRHzFE=;
 b=Tmdq5a/PAfKwYCXZTP6ui8e27kQDkyHAOcHs7U4f4a6iA5w+KLsio86M97c6md/Zmf
 JsPj9INqF0ugu/rH1NIp6n2v+wlbtF/9JHvbUvTLLbxjTBGUVJgCjCVRHn7W4KkH1mH4
 o0+k01mYnuuJPhZQavrqOD0kcCloSDocLo6is850/u5caf6LqlB0PFToWqowtkt1oEAr
 dh3fQLI/FF50ldUFn5nFQoM7e1sDRHHQY433JFpNQwSqSbl9wVTYacus2wQOnB1ElidF
 6jwaYrgPaeVOW085Lvy0VR0ZrjIG7wW04Rmve2Wm8MJILKVtQkvSwKX8U9+G4PJIO6Wk
 vmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742320107; x=1742924907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEl+rBbulfCvdsYq0HFcMiL7cJUjiyQsWfYOMDRHzFE=;
 b=gD+T0l0mcOSPCOMju8Otd4m1U0XeBrq2JzFwx7bTVUg+6x7uEgMRRk1C7U8wrSqR6G
 O2gDqFizsLa9+CEU7x6qm4NsJ728o39l2Yl4ZMqylKI8Soy0syenCgYqTYj8TTzMjGLy
 ZuW9Kc2WwsVOd0dF2oFCoD5/Mo6boY9e1mRXRCLZ/xxAl0omzorY5ySmwGBkW3kN8IjB
 D2G7HFofvydZ2t3gUNDdIBQPRTpDOnMIbf1TWs/DEt4MytxJ7ic7gLAxQPGwBAxsKzHT
 iBGaPvtQs0KoJP84e7njXXMF8H4p6Qr2QC+vR9FRLXct9h/Wew9bihDMF+ubROad0RNH
 t8Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuNpXETM+Hhn5vaG51Glm97HECrZ0ERb4PFE4DtNF8mfFLqC7CGv+uIJfM5O6P2qb4UwIerrScxtYA@nongnu.org
X-Gm-Message-State: AOJu0Yz+mhTqsl7rttFOJE3Sx198WkrdnztlzltUcl403peCthBwbBaI
 nbVTkTnuTkJy2uZ8MeOaVO4eE3n9+EVMUIlzFYuqn5Txe6W8z7pBZ2IoZhEyO8J+oFiuM2HFdMd
 hfXfylKDDblGQb9BE4GnYE5ybjXTuTrK4Gm1meQ==
X-Gm-Gg: ASbGnct5sw2R1tBbWdXbPl4TEPKt91XZrZFGXS9n3YZ2EowDcOC+nrGB1x31rZIFO4O
 ROd0ivKxqNvZHZCPzR9jYpZGK3zwiO2291ak/20W7lGRBW/K/i6Lbg/cpX6j/hqGeEiwdM+eyho
 Kb2tq6q49pNcS/o+z/wCSrwK9kQSA=
X-Google-Smtp-Source: AGHT+IFNQ7+zX9lCeGAbyD0+/uukSBmf3ZQqQ4nTELErgpVG5xbjxtprlqALWNuWBtsNuZS4/50OQfrD4PeUiLRKN1A=
X-Received: by 2002:a05:6902:2502:b0:e5d:c6e8:2e32 with SMTP id
 3f1490d57ef6-e6679026961mr293254276.24.1742320107372; Tue, 18 Mar 2025
 10:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
 <Z9l7J0oZ8GAEqaMP@redhat.com>
 <CAFEAcA_ZBz3yvUYo5WhqmKRqCm+Jy1R01pshtU0NPRzzbP4hYQ@mail.gmail.com>
 <CAFEAcA-=FaNSQOSG3iFua30baATRvjBQPd5TfG6fBqJrFBFuYA@mail.gmail.com>
 <Z9mq6BtHD4YMGlE3@redhat.com>
In-Reply-To: <Z9mq6BtHD4YMGlE3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 17:48:14 +0000
X-Gm-Features: AQ5f1JohsrGYwOaxHvKrloFzKwZz3bGITzRwk0DT85VBweeaWfF_7zaFN1t-zO0
Message-ID: <CAFEAcA9gRT1z2yokut9hLAQjF4cuG4Woy7D2f=ZF=-3HoW6p=A@mail.gmail.com>
Subject: Re: Generic way to detect qemu linux-user emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Tue, 18 Mar 2025 at 17:18, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Mar 18, 2025 at 05:08:52PM +0000, Peter Maydell wrote:
> > On Tue, 18 Mar 2025 at 15:04, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > > More generally, AIUI glibc expects that it has control over what's
> > > happening with threads, so it can set up its own data structures
> > > for the new thread (e.g. for TLS variables). This email from the
> > > glibc mailing list is admittedly now two decades old
> > > https://public-inbox.org/libc-alpha/200408042007.i74K7ZOr025380@magil=
la.sf.frob.com/
> > > but it says:
> > >
> > > # Basically, if you want to call libc functions you should do it from=
 a
> > > # thread that was set up by libc or libpthread.  i.e., if you make yo=
ur own
> > > # threads with clone, only call libc functions from the initial threa=
d.
> >
> > I spoke to some glibc devs on IRC and they confirmed that this
> > remains true for modern glibc: because glibc needs to set up
> > things like TLS on new threads, you can't mix your own direct
> > calls to clone() with calls to glibc functions.
>
> Using clone() directly is done by a number of projects (systemd, libvirt,
> podman/docker/runc, etc) that want to create containers, while freely usi=
ng
> arbitrary glibc calls in the program. You do need to be careful what glib=
c
> functions you run in the child after clone, but before execve though.

Yes, if you don't call glibc functions in the child that's fine.
If those other projects are calling some glibc functions post
clone() in the child then I think they're relying on undocumented
behaviour that might break on them in future...

> For the projects I mention, avoiding the danger areas is probably easier
> than for QEMU, since QEMU has to theoretically cope with whatever madness
> the guest program chooses to do, while those programs know exactly what
> they will run between clone & execve.

QEMU's structure also is that we assume we can freely call
glibc functions as a result of TCG operations. So even if the
child in the guest is very carefully doing absolutely no
other library calls between clone and execve, QEMU itself
will be doing them.

> Wonder if its worth enquiring if glibc would be interested
> in following musl's approach to make it more emulation friendly for
> QEMU ?

That would essentially be asking "please can you revert glibc
commit 4b4d4056bb154603f36 ?", so probably not:

https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D4b4d4056bb154603f3=
6

-- PMM

