Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45568E95392
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbz2-0005Yf-0l; Wed, 04 Feb 2026 07:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vnbyz-0005YH-Nf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:27:45 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vnbyx-0002sn-NT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:27:45 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-501469b598fso49757461cf.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 04:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770208062; cv=none;
 d=google.com; s=arc-20240605;
 b=KWLq83hOG1bSwc68cQb+kCSkDbsvw/EqhrGLu3BYLJ26SPx1rMv4EI2FouKvkQ5nUq
 egBSb2r9PA785IJnp9XcTG65aus2GGcWg26vHRex5xZ3s7wFOyPFhv32s3auPP/LT4kZ
 yOTppv1JWfVPomUasEehUj+d5l1J1pY0QymyFT6xsQ5+16UhOn69bUvGs4i8XodgTHDf
 +QW1nC0QbrjAXe+/EueY7C2+bKesgpdTpE4Ms9jXcuQpPKZtH1QhTNNHyKtSwY3mmC8y
 lAcu3NrSwyGGB5V4hNC4yVuZoR5rqFkA0RYkp5J8hQTdUo/0yFywZNCE0esTJKlgI+ys
 AC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EGH1UWAtzLtI3MU7H7I/5fB/5T65yquJgaZ8EgaTaVo=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=bgmyHYOtZLUQf0ItzBaVifFpqV8nguzhEniPGz01Ipx9d9RgKJ3xomWL5aE6STXDhB
 duIwtXXcLeiNQo7H6aQmirecAwK4aFe3FXD8Hfrc7orF31+CVG8hzUxkLenHZsveJBpt
 t27BYtMw6Jh3KfmHidgvDjojM066gKAxHx7qYb7K292bxfz1wET5IOd6DW8aWmCm8iQC
 AHep8hEAo0h8tRn6M/mbXC08MXJXjFiLvHW2ATltqYdx6fPPt/XpcUQdbg4f8ar5X3Pn
 goGKYSslJABE8hC7u5Xig5se9sA/A8Nn71DhR4Libumtj40MLIR7KuvxMlVwDNWdJdCE
 aMoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770208062; x=1770812862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGH1UWAtzLtI3MU7H7I/5fB/5T65yquJgaZ8EgaTaVo=;
 b=ImDhwfKqwBMm0+iN9VrDsCqgcDzrEtnQlsZx85gPmyvffLcE2vyVcn5MEWZoKOr6fk
 cOsixymrCNiniZHMxr52lpXPfvrR35LWwGFnefdbO0s5vyzyvwlODtxyea1Ef9Bxohb2
 WmOUu5JNy2SMAaVq1a5TCa7qau8A2oitDdx4l2Y7GD+AzpvuwB7VVhdbw623rzXtSss2
 whYoDiPIxsofugJpf3hjgDGbztOiH7p9k2ZEMyd2eX3VFXM1b+ezeBS/Q9JNecE2VDkc
 ufGOWznUA76WLA2i2jNGPOfD2tDPHURdYIvGH2OaF3uaoCWptr2o1rp5fblR6m0nTKmO
 IksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770208062; x=1770812862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EGH1UWAtzLtI3MU7H7I/5fB/5T65yquJgaZ8EgaTaVo=;
 b=ni5QTdvD5GuVexybKTkrfOYx146S5NSZY5yiVFOvPV3eusxXzy7aa7ggW+oqC/fUT1
 d/BMp5yyR4NMEk6Sjn3oWfGT9dW7NU5aZ0JPtBLJFlwbCym0GDarMc6oyoLMc1d0If6N
 RK+E7GbigVWOSiwddA7xF4gRhcXCdVOCsjm20MZgxDUKmXVPIAMNlcdLUlxc3LxjfQRe
 oXd5sqCRIh+CGwNlOh68lvSR1L1nHUYxgxcL3yMxcq5bW0/AZc980BzvD4e76LB46Cn6
 lLlWpQKO28eMUy+ibDwEI6XvfhXjy8p64KsRVkCEFMQcCUtSLYNaQ8GIFM8OPsguyJ5S
 RSOQ==
X-Gm-Message-State: AOJu0Yy+pjRkTAEaC4cy9Yc/x23kmTYiI+WRimioSeDg7QPYPD+c/14R
 8wrUd7xBPo8cxBaIgZqVOIIiJCMz3DISjF7fZTK33Wjg9aZP55Tw/E3WW8GGoeORLe4akJ9/iKU
 GD7KuV+baYcx+kFzIddHRJ3Nn4DB4MlU=
X-Gm-Gg: AZuq6aKCAnyc/da3BhNn7SJV8Erj5Pn37i2U2rfh324sSRpU7EW6XawXKtBDnqU6IaP
 v5RL9A96tJR1/9fSfY36K0OQyHQ8f34c73vgGD0zzGQ1yaHEvUddcrCd8+KMzUM4r81FfzKxVKo
 0zuZBuXtZYU+cC3cn+91leu0OqsVjo93Me2VhKddUocnTVmjy9O5tWUQ5/0xaRqk9Paa/7FB1Nf
 32kampE5rW3Su1k0i0isLHUimzkO+XbOEb8dFsOhog9RLZ309tf1jvMc/DNo6jEPlQFXE5mxVYP
 2WAsa9zLxAenYXc6G9xR6d0wuo4=
X-Received: by 2002:ac8:5a42:0:b0:4f1:83e4:6f55 with SMTP id
 d75a77b69052e-5061c0c58a3mr31095001cf.16.1770208062063; Wed, 04 Feb 2026
 04:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-6-marcandre.lureau@redhat.com>
 <b28fd63e-063c-41d3-a9dc-54929e7adfaa@nutanix.com>
In-Reply-To: <b28fd63e-063c-41d3-a9dc-54929e7adfaa@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Feb 2026 16:27:30 +0400
X-Gm-Features: AZwV_Qg1f8xp6jZaaN3SJLnkmas6CcIdE2eMh9kIcMmpAY0yqMsbvh49-0CRLLI
Message-ID: <CAJ+F1CKauYDpB0+_ggGP9mMkvYTDTbcsp2LX+twm8dvMggpSuQ@mail.gmail.com>
Subject: Re: [PATCH 05/37] qemu-options.hx: clarify default audio backend
 selection
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Mark

On Tue, Feb 3, 2026 at 7:49=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   qemu-options.hx | 22 +++++++++++++++-------
> >   1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 455b8be8903..732934a6fa8 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -896,11 +896,16 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
> >       QEMU_ARCH_ALL)
> >   SRST
> >   ``-audiodev [driver=3D]driver,id=3Did[,prop[=3Dvalue][,...]]``
> > -    Adds a new audio backend driver identified by id. There are global
> > -    and driver specific properties. Some values can be set differently
> > -    for input and output, they're marked with ``in|out.``. You can set
> > -    the input's property with ``in.prop`` and the output's property wi=
th
> > -    ``out.prop``. For example:
> > +    Adds a new audio backend driver identified by id.
> > +
> > +    If no audio backend is specified, QEMU will attempt to select a
> > +    default one. The ``-display`` option may influence which backend i=
s
> > +    selected.
> > +
> > +    There are global and driver specific properties. Some values can b=
e
> > +    set differently for input and output, they're marked with ``in|out=
.``.
> > +    You can set the input's property with ``in.prop`` and the output's
> > +    property with ``out.prop``. For example:
> >
> >       ::
> >
> > @@ -2172,8 +2177,11 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
> >       , QEMU_ARCH_ALL)
> >   SRST
> >   ``-display type``
> > -    Select type of display to use. Use ``-display help`` to list the a=
vailable
> > -    display types. Valid values for type are
> > +    Select type of display to use. This may also influence the default
> > +    audio backend selection.
> > +
> > +    Use ``-display help`` to list the available display types. Valid v=
alues
> > +    for type are
> >
> >       ``spice-app[,gl=3Don|off]``
> >           Start QEMU as a Spice server and launch the default Spice cli=
ent
>
> The documentation changes look fine in terms of describing how one
> option may influence the other, however there is no explicit mention in
> the documentation that selecting a dbus display with no audio backend
> will also use dbus for audio.
>
> Is it possible to mention this somewhere? Otherwise someone would have
> to go digging through the code to figure this out.

would something like that help?

@@ -2191,6 +2192,9 @@ SRST
     ``dbus``
         Export the display over D-Bus interfaces. (Since 7.0)

+        When no audio backend is specified, the dbus audio backend is used
+        by default.
+


--=20
Marc-Andr=C3=A9 Lureau

