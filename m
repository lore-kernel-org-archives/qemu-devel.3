Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504CEEE209D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLVq-0004mQ-11; Fri, 06 Feb 2026 08:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1voLVo-0004m5-I1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:04:40 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1voLVm-0002qx-Pu
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:04:40 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-502a26e8711so12373251cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:04:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770383076; cv=none;
 d=google.com; s=arc-20240605;
 b=L1gsx4PwnATUI392FhoiIbNAb4N8B36Sp6Q4UD6Winlm5DBQK00HbqDIjRE5sI1ZSf
 dNH50q8/cy01Z05+HhAWdrKZRQCpOunbtVhk115TIwKk9CQgoJEVRVNwyf4LGXfObIxi
 3bJs4CX6b+uN6DjUG7R1yY9Hn6Xa04lQxSQ36EQPw2iqa6pHh1eWwIv1BI1aJsckQimS
 HogLH0mkOvSj+6aUJ+1n+6ZHX8VGwUNSOKJlfxm7KmrjmdiYk7o/4A8ptO5KKaBa3xwt
 uCohZVoHRLuCPkAiPnfgmMY9xbIAaJppm/CmkUZT/vJ5IcFp2n4LXp3rm5gh9QlHr91b
 ab0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uN5a1DrDWXGRz+zFu33pBYxU2DW9vVuEnFvgK3//06g=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=XugZH6ZD5sdKecUoKNW9ryigGH+2czfPSQ6RKllXfp6dPn+Exjo1oKmxp+pzVf+fj6
 bHFYhT395wQHL+YycKubddUmWFn908K0FLFmx0GqgpjWu0mdsXT/tXDpq1Xy7/OzqPs3
 K5q7ylTxVQDC30J1t3+SN2n4DbLlhRPNvkHIoWnw0PnOX1wB9JNSg8+h6cTgLXAYQ8g/
 hzgKlMirGAsXajPYv5vjQ9ampRCnDPViTPAK+5ygqE88cwlY3sWBdGVve4thvifC+lNf
 lcfEd8wHge0yOdjH8lFTQCY3VwqpymRIyk+Nm8WQnmzNcXG/IXM79/oks+SSDwpFRyUQ
 JCEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770383076; x=1770987876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN5a1DrDWXGRz+zFu33pBYxU2DW9vVuEnFvgK3//06g=;
 b=AMPBJqQrPm4NQ3jjoEVGqgzXB3tgjBQkK/nQcpRUWlNMw0L1mqW6SakcBz2J3OLs75
 hNWCmk5ji0BKui0S4WT0Ct2l22zIutzBEoT5IBy89GlEM+dUJVXDnKjSmfeH61xkldTP
 bd8ZUz7FAB4x3wcKYwoasKJvPG3ERn7awKd+qEm5TA1YrrzO1n3JBTpfjeTnl4vA/1dv
 FFxSOYTz1X+Nii82VR7kJDsYw5dX119Y/rfI4rL06pQJEgtCMMsz57y1suzgW77NKMpn
 jRVwzS+pMn2hmNZd+4eAPOZYlJFe7CzV3vrAp5Mv7zS4APkEFiNhdAvh+HZISKaBenwB
 GJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770383076; x=1770987876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uN5a1DrDWXGRz+zFu33pBYxU2DW9vVuEnFvgK3//06g=;
 b=tMHL6Wp0NJDGUEPnOWVMQtC71weKZKxi37gzsjNcx+TpG85LrdyhtA8nucj4pDpSuH
 CZTtOeWu2nhn+2QCORM62ZgiUR0Zemm5LrKgmFJc5/72cdnXSkReA/7rVGOL8bSo+WGk
 z7AMI4MKG+MZAN+/FsW4YSaLnU7sJK+cbbgeuOVdIl8sYuvpwJkGxpL0IcaYM0uynxkZ
 0dApac4qaOK0sxe3LC/30C9ngYjTxnli59c6hqro0Hs9VMDoln7lPq8OFtUb8OuIbhyg
 fkFA/lEmtbgk4mopRAmJ1ALeHgzPCBWSXJ/nkk/RLcENkIYwda3TvXeJYK9UgpOKChqj
 Kdkg==
X-Gm-Message-State: AOJu0YwaXU2CQNa/1fYywY+Umbjy1O/krnzfIdOAdlxLtesDMpp61r6I
 TwryxU7a8danb8bFYwdu6LLhn0Vwi22VsgU3rfDYagqGquI63GjyRluCkgryHLVuZowN0GoHNN+
 R86atvqgMrcnJexmJWPp+VTOXKiG37Pk=
X-Gm-Gg: AZuq6aIZaLRZ9KEatqbmQ+KMthiKuTZAs3bwfisoDbBu4UGOhefhQxSwHG7UQyz9grd
 ahffzHzksF9uSvKUzp9s0jL4dOjOM9vk7RR7FqhmsrM3Wvxz7ylTMBEGzyv/Uxsoznr3PuVCwLF
 z4I2BdjACWf2YBu8OIhPY5LQfQbuTKhOuwmVYVQrCcUOzNBV/k/izHom5rDzvoeOXIUKqKF8YoK
 h3Z0jmJIghxcyk2BWdqLAhkZqi9TozGJ1GCgc+G/mGMtSu0AoKc7QV6Zh79jb20yCDfsVJbC1t1
 g3WUGt6qsilkFsB7WQF/0WplAFI=
X-Received: by 2002:a05:622a:34a:b0:503:29df:3919 with SMTP id
 d75a77b69052e-50639a1e3a4mr33522851cf.81.1770383075643; Fri, 06 Feb 2026
 05:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-6-marcandre.lureau@redhat.com>
 <b28fd63e-063c-41d3-a9dc-54929e7adfaa@nutanix.com>
 <CAJ+F1CKauYDpB0+_ggGP9mMkvYTDTbcsp2LX+twm8dvMggpSuQ@mail.gmail.com>
 <1f9dfd2f-9586-4f08-afc9-113b7ecab135@nutanix.com>
In-Reply-To: <1f9dfd2f-9586-4f08-afc9-113b7ecab135@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 6 Feb 2026 17:04:24 +0400
X-Gm-Features: AZwV_Qg--nij5t8Zl0ukBtx7VP9696oY7FPKE4s8byTnO5BZ3uGtAh55Ij4uYd8
Message-ID: <CAJ+F1CKsXKU9J-cqKT=L8MJP_Xsztoy_Z9TNGOpDUJVxH9xCEw@mail.gmail.com>
Subject: Re: [PATCH 05/37] qemu-options.hx: clarify default audio backend
 selection
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Feb 5, 2026 at 8:19=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 04/02/2026 12:27, Marc-Andr=C3=A9 Lureau wrote:
>
> > Hi Mark
> >
> > On Tue, Feb 3, 2026 at 7:49=E2=80=AFPM Mark Cave-Ayland
> > <mark.caveayland@nutanix.com> wrote:
> >>
> >> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
> >>
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>    qemu-options.hx | 22 +++++++++++++++-------
> >>>    1 file changed, 15 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/qemu-options.hx b/qemu-options.hx
> >>> index 455b8be8903..732934a6fa8 100644
> >>> --- a/qemu-options.hx
> >>> +++ b/qemu-options.hx
> >>> @@ -896,11 +896,16 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
> >>>        QEMU_ARCH_ALL)
> >>>    SRST
> >>>    ``-audiodev [driver=3D]driver,id=3Did[,prop[=3Dvalue][,...]]``
> >>> -    Adds a new audio backend driver identified by id. There are glob=
al
> >>> -    and driver specific properties. Some values can be set different=
ly
> >>> -    for input and output, they're marked with ``in|out.``. You can s=
et
> >>> -    the input's property with ``in.prop`` and the output's property =
with
> >>> -    ``out.prop``. For example:
> >>> +    Adds a new audio backend driver identified by id.
> >>> +
> >>> +    If no audio backend is specified, QEMU will attempt to select a
> >>> +    default one. The ``-display`` option may influence which backend=
 is
> >>> +    selected.
> >>> +
> >>> +    There are global and driver specific properties. Some values can=
 be
> >>> +    set differently for input and output, they're marked with ``in|o=
ut.``.
> >>> +    You can set the input's property with ``in.prop`` and the output=
's
> >>> +    property with ``out.prop``. For example:
> >>>
> >>>        ::
> >>>
> >>> @@ -2172,8 +2177,11 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
> >>>        , QEMU_ARCH_ALL)
> >>>    SRST
> >>>    ``-display type``
> >>> -    Select type of display to use. Use ``-display help`` to list the=
 available
> >>> -    display types. Valid values for type are
> >>> +    Select type of display to use. This may also influence the defau=
lt
> >>> +    audio backend selection.
> >>> +
> >>> +    Use ``-display help`` to list the available display types. Valid=
 values
> >>> +    for type are
> >>>
> >>>        ``spice-app[,gl=3Don|off]``
> >>>            Start QEMU as a Spice server and launch the default Spice =
client
> >>
> >> The documentation changes look fine in terms of describing how one
> >> option may influence the other, however there is no explicit mention i=
n
> >> the documentation that selecting a dbus display with no audio backend
> >> will also use dbus for audio.
> >>
> >> Is it possible to mention this somewhere? Otherwise someone would have
> >> to go digging through the code to figure this out.
> >
> > would something like that help?
> >
> > @@ -2191,6 +2192,9 @@ SRST
> >       ``dbus``
> >           Export the display over D-Bus interfaces. (Since 7.0)
> >
> > +        When no audio backend is specified, the dbus audio backend is =
used
> > +        by default.
> > +
>
> That definitely helps. Is it possible to tweak the wording to something
> along the lines of:
>
> If no audio backend is specified and the dbus display backend is
> specified, the dbus audio backend is used by default.
>

ok

> Another question: is there any documentation for -audiodev dbus and its
> properties anywhere at all? I had a look at
> https://qemu.readthedocs.io/en/master/system/invocation.html but I can't
> see an entry for it in the audiodev section anywhere?

Good catch, what about?:

+``-audiodev dbus,id=3Did[,prop[=3Dvalue][,...]]``
+    Creates a D-Bus backend. It must be associated with the display
+    (as ``-display dbus,audiodev=3Did``). (Since 7.0)
+
+    D-Bus specific options are:
+
+    ``nsamples``
+        Number of samples per read/write (default to 480, 10ms at 48kHz)
+        (Since 10.0)

thanks

--=20
Marc-Andr=C3=A9 Lureau

