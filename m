Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C66CC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2rG-0007aO-Ug; Tue, 12 Mar 2024 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rk2rD-0007ZK-Eq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:11:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rk2rB-0001pH-MN
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:11:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e66da40b18so2717577b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710252711; x=1710857511; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yepmIJf0nsr6jfPNbcBLC44iu33e8PrZi3myA8uQ8a8=;
 b=czSsAs4USJJeLO92uu5v26KVazWNMpbaX8txuXeXSNi3JGr2/MddNHJw7NhKaTDGRZ
 29j8JHV2m64IuyeNdbfkkNBqSN6XSBDvzE1rMPR4a/mlR42zlTDJIo3Il4YV5dKk2OH2
 zeIAFh1VXyRwVfknO5FHYsX80ef206MUUjQInuCzrZNBWQOVaLRYzF1THkJ+aOwG3PDw
 JjU1ppzOSe/cxAGuXsGRu3G/d6nXCGh541A/pgT/q4WZVvAsbHkq6fSXcrU6CSQnWD6I
 hBHFdsrNRhnw8wuNmt4tDeVHRSZxugiz4busZbmj9r2RFb/gETVGC0T4qusoq7gqhISa
 GtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252711; x=1710857511;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yepmIJf0nsr6jfPNbcBLC44iu33e8PrZi3myA8uQ8a8=;
 b=r4doysSrclVo5KMwx/0G1gVL9jdiF8hAkFBz9ArX1Wt7SzymBP+IRr1yr3HvyX+XkX
 KiS9rAl56yk6+VvBe5AQ3LkpPmxAOWZUrEL7DarZcWiiDoYdriYaz2SfH67YtbvXDU3u
 7pgivBApTO+eCqBeoeDJUOuC91RymD6hbhHqFB/p9D9eRPP0wTV79+di3PzblnJ4Wb73
 t/Oc3Yqea+6WlmS7pgsFPQeW4VvMwwB9ewXlbxdz2fIa6njuI26cJEn3qP2JHO8Phj5K
 XhMPeq4b7LUQe3e6RJYbWBwfd+q0pxDkwyYHFUE2kI6Bb0gEC0E64PZQ1HJ9WB5KNmsL
 bzfA==
X-Gm-Message-State: AOJu0YzCJYXuJXHZ5XE566wmK4f3jxNn53Eeksk7KgkAZW5xpYIwFDx1
 QGvb3ivmakTwlbbPbfE4RJGfR3Vhtq+IJ+fuzuJKYdBJ6J6RwDr2
X-Google-Smtp-Source: AGHT+IHP8FlbeOXdd72goiRGfIZ+1u4tdBku7kz/bPtsWU6KR72ixJIL3OQ3n+IzAbaRiCAvEpNC3Q==
X-Received: by 2002:a05:6a00:2347:b0:6e6:89a4:60ff with SMTP id
 j7-20020a056a00234700b006e689a460ffmr2140857pfj.29.1710252711501; 
 Tue, 12 Mar 2024 07:11:51 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 n4-20020a056a000d4400b006e50e79f155sm6131118pfv.60.2024.03.12.07.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 07:11:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 00:11:44 +1000
Message-Id: <CZRTZI069362.3IKMWWPX4ZO4P@wheely>
Subject: Re: [PATCH v4 06/24] chardev: set record/replay on the base device
 of a muxed device
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "John
 Snow" <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-7-npiggin@gmail.com>
 <CAJ+F1CKmgTCZfvWAfHOOAx7ne=5NFQC-pmdyvmECX3syXf9-=g@mail.gmail.com>
In-Reply-To: <CAJ+F1CKmgTCZfvWAfHOOAx7ne=5NFQC-pmdyvmECX3syXf9-=g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Mar 12, 2024 at 10:39 PM AEST, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Mon, Mar 11, 2024 at 9:44=E2=80=AFPM Nicholas Piggin <npiggin@gmail.co=
m> wrote:
> >
> > chardev events to a muxed device don't get recorded because e.g.,
> > qemu_chr_be_write() checks whether the base device has the record flag
> > set.
> >
> > This can be seen when replaying a trace that has characters typed into
> > the console, an examination of the log shows they are not recorded.
> >
> > Setting QEMU_CHAR_FEATURE_REPLAY on the base chardev fixes the problem.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  chardev/char.c | 71 +++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 50 insertions(+), 21 deletions(-)
> >
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 3c43fb1278..ba847b6e9e 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -615,11 +615,24 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opt=
s, Error **errp)
> >      return backend;
> >  }
> >
> > -Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
> > -                                Error **errp)
> > +static void qemu_chardev_set_replay(Chardev *chr, Error **errp)
> > +{
> > +    if (replay_mode !=3D REPLAY_MODE_NONE) {
> > +        if (CHARDEV_GET_CLASS(chr)->chr_ioctl) {
> > +            error_setg(errp, "Replay: ioctl is not supported "
> > +                             "for serial devices yet");
> > +            return;
>
> You are changing the behaviour, the previous code was just printing an
> error, but let it go. I think you should make this a separate change.

Ah yes true, I will change.

>
> > +        }
> > +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> > +        replay_register_char_driver(chr);
> > +    }
> > +}
> > +
> > +static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext =
*context,
> > +                                         bool replay, Error **errp)
>
> Having so many chr_new functions is starting to really damage
> readability. Also don't use '__' prefix for global symbols, they are
> reserved.

Yeah I agree they're not good, I tried to think of a better name.

>
> >  {>      const ChardevClass *cc;
> > -    Chardev *chr =3D NULL;
> > +    Chardev *base =3D NULL, *chr =3D NULL;
> >      ChardevBackend *backend =3D NULL;
> >      const char *name =3D qemu_opt_get(opts, "backend");
> >      const char *id =3D qemu_opts_id(opts);
> > @@ -657,11 +670,11 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, G=
MainContext *context,
> >      chr =3D qemu_chardev_new(bid ? bid : id,
> >                             object_class_get_name(OBJECT_CLASS(cc)),
> >                             backend, context, errp);
> > -
> >      if (chr =3D=3D NULL) {
> >          goto out;
> >      }
> >
> > +    base =3D chr;
> >      if (bid) {
> >          Chardev *mux;
> >          qapi_free_ChardevBackend(backend);
> > @@ -681,11 +694,25 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, G=
MainContext *context,
> >  out:
> >      qapi_free_ChardevBackend(backend);
> >      g_free(bid);
> > +
> > +    if (replay && base) {
> > +        /* RR should be set on the base device, not the mux */
> > +        qemu_chardev_set_replay(base, errp);
> > +    }
> > +
> >      return chr;
> >  }
> >
> > -Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
,
> > -                               bool permit_mux_mon, GMainContext *cont=
ext)
> > +Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
> > +                                Error **errp)
> > +{
> > +    /* XXX: should this really not record/replay? */
>
> I don't understand the context here, make it a different commit to explai=
n?

Good point. I was wondering whether devices created by this
call should have record/replay enabled.

>
> > +    return __qemu_chr_new_from_opts(opts, context, false, errp);
> > +}
> > +
> > +static Chardev *__qemu_chr_new(const char *label, const char *filename=
,
> > +                               bool permit_mux_mon, GMainContext *cont=
ext,
> > +                               bool replay)
> >  {
> >      const char *p;
> >      Chardev *chr;
> > @@ -693,14 +720,22 @@ Chardev *qemu_chr_new_noreplay(const char *label,=
 const char *filename,
> >      Error *err =3D NULL;
> >
> >      if (strstart(filename, "chardev:", &p)) {
> > -        return qemu_chr_find(p);
> > +        chr =3D qemu_chr_find(p);
> > +        if (replay) {
> > +            qemu_chardev_set_replay(chr, &err);
> > +            if (err) {
> > +                error_report_err(err);
> > +                return NULL;
> > +            }
> > +        }
> > +        return chr;
> >      }
> >
> >      opts =3D qemu_chr_parse_compat(label, filename, permit_mux_mon);
> >      if (!opts)
> >          return NULL;
> >
> > -    chr =3D qemu_chr_new_from_opts(opts, context, &err);
> > +    chr =3D __qemu_chr_new_from_opts(opts, context, replay, &err);
> >      if (!chr) {
> >          error_report_err(err);
> >          goto out;
> > @@ -722,24 +757,18 @@ out:
> >      return chr;
> >  }
> >
> > +Chardev *qemu_chr_new_noreplay(const char *label, const char *filename=
,
> > +                               bool permit_mux_mon, GMainContext *cont=
ext)
> > +{
> > +    return __qemu_chr_new(label, filename, permit_mux_mon, context, fa=
lse);
> > +}
> > +
> >  static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
> >                                            const char *filename,
> >                                            bool permit_mux_mon,
> >                                            GMainContext *context)
> >  {
> > -    Chardev *chr;
> > -    chr =3D qemu_chr_new_noreplay(label, filename, permit_mux_mon, con=
text);
> > -    if (chr) {
> > -        if (replay_mode !=3D REPLAY_MODE_NONE) {
> > -            qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> > -        }
> > -        if (qemu_chr_replay(chr) && CHARDEV_GET_CLASS(chr)->chr_ioctl)=
 {
> > -            error_report("Replay: ioctl is not supported "
> > -                         "for serial devices yet");
> > -        }
> > -        replay_register_char_driver(chr);
> > -    }
> > -    return chr;
> > +    return __qemu_chr_new(label, filename, permit_mux_mon, context, tr=
ue);
> >  }
> >
> >  Chardev *qemu_chr_new(const char *label, const char *filename,
> > --
> > 2.42.0
> >
> >
>
> It's probably too late for 9.0, splitting the patch and preliminary
> cleanup should really help reviewing the change and pointing out the
> behaviour differences.

Agree. Fixing the rr flag setting could be considered a bug fix.
So a minimal patch that does not change other behaviour might be
suitable for 9.0. But that could be decided at the time, no need
to rush this in before the soft freeze.

Thanks,
Nick

