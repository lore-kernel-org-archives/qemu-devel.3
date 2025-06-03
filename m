Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4991C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 20:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMYXb-0002Qh-A7; Tue, 03 Jun 2025 16:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uMYXS-0002QH-8k
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 16:47:14 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uMYXQ-0006hM-Dc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 16:47:14 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-32a81344ae9so65661441fa.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748983630; x=1749588430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbVQm+RS+l5xAfH1eyujrmawSB8p5rdyV8kFkBYVH8U=;
 b=fTZyu+Czk3sTDARdUjGiFpulQjCOnisyFbqMS62b5nczY0mBOscvDWwrg3S+0P9m6q
 JpahPkF7lBoksBpmS/HHgTfkpz6ZBsWV6kOJfk/xDJFEVqIGmvg1IVvw/GXLygFnoJIv
 tKXR+jlG1+47DdROpUVasj3OSOTnImI2QcUpCqhPtuCCLGChvwPm/XnBkJ0Eti5sclrX
 zJ6sHFG0PwOuI3ZW2FHvw+SmliAM/uF47Z9JZFpud9qWR1+T4qtmB+p+LJVSqJGg5Ozh
 R/xfFfCJuEuITY1ePHhoHv2ymPCdUkmRpyeekZPzyh0oVThW6uNX50wezIolLY90uTIz
 iVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748983630; x=1749588430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbVQm+RS+l5xAfH1eyujrmawSB8p5rdyV8kFkBYVH8U=;
 b=mMhFnOqH7Ps0vF/Dc3H73JbuWdDa8s58i6wRz+uR02yKZMyE0yuL9eLbV7jRUp7yuw
 4fApu6vM663blFGhKX7YueSFezMPgNx6eZCKYiaem2XKjkQdUJq9Vi4WenEazBq9NJd3
 5+egJpwKEaCehrMxUkuYGs+mBwgGHCz+w6oMo5h8mb55sEwBc04Z7xrP/eQlfSG24ww3
 zK7cBfbG0yPEIFYPBmWBHPf3f7PDzOq9gJtUe79N3yjfUhP2fAqWgiptOUk9lKsdy7Qo
 cX4wFuZLI9Y+lSwUYptRjw2XYn81wENXV/wMfvnBwGXrmh3BGFdXF5HLFwaE/rzzBwRf
 FDPA==
X-Gm-Message-State: AOJu0YzqJXBfPOsXQhcPjQs+aQNflLvsKeO3XyYgzUf+IYOhzPzXIDyh
 boVZlx5q197KdWfaDzt/XyFlMXUtAPq9wttrsfFa7VP+F8FhXvg4vT1Xm6K7jyGqHiMPMdw+PwV
 a1pzSNCwvrW4sa2CZbv2bqfcTEWfmno4=
X-Gm-Gg: ASbGncsJ56CMv8BPtGp/brOjCNmiPm66c8BgIKxctnHRYcECIkIV4PwWYLuewMibY56
 c/h9AG3ICKUHH9K4OtEP7jib2Kx1N88unmU63dT00mRkG1w8RsCTvfpdej49iPZ0uxMRLp/m/9K
 wyazyV0sd6e8E+0gSBsJm862o4eQNro2xJcllgrsUqUs7iq7MwlFgat8wv7F6HuRU=
X-Google-Smtp-Source: AGHT+IFESP6WDiVb/48cIkItjx7o3iQMcJ1AOaR7kb2z/S9hJAi1INWqvhpwqKbuV3gZJnFxj8b2s8Kmh1CuJNSdY+A=
X-Received: by 2002:a2e:be1a:0:b0:30b:cd68:b69c with SMTP id
 38308e7fff4ca-32ac78fd9acmr260101fa.3.1748983630204; Tue, 03 Jun 2025
 13:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
 <CAJSP0QVT56Sx8-T2+qF2LnFksL=feGL+v0CJPnX+ZuQ6iMMMRg@mail.gmail.com>
 <CACcXsZgbzf+Rp8AujP_cGgh8J9xk=uadLM5Bem_6PCV=EzP2kg@mail.gmail.com>
 <CAJSP0QWC1JmgGQ5RoDG=kJfabOpsazXNMf1DFQQ=iTUY6zdAww@mail.gmail.com>
In-Reply-To: <CAJSP0QWC1JmgGQ5RoDG=kJfabOpsazXNMf1DFQQ=iTUY6zdAww@mail.gmail.com>
From: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Date: Tue, 3 Jun 2025 22:46:59 +0200
X-Gm-Features: AX0GCFv1eiNFwd5cOpATLgqbP60kSObIF53Ap7EE6ZXFAXyweey69jgHGEU-Ygk
Message-ID: <CACcXsZjJyVvh+Yq2JiSMwdUeGe4uDQHm2pDgkBfmWEcwAT3M_Q@mail.gmail.com>
Subject: Re: [PATCH v2] meson: fix Windows build
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-lj1-x236.google.com
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

Am Di., 3. Juni 2025 um 19:56 Uhr schrieb Stefan Hajnoczi <stefanha@gmail.c=
om>:
>
> On Tue, Jun 3, 2025 at 1:00=E2=80=AFPM Oleg Tolmatcev <oleg.tolmatcev@gma=
il.com> wrote:
> >
> > Am Mo., 2. Juni 2025 um 20:45 Uhr schrieb Stefan Hajnoczi <stefanha@gma=
il.com>:
> > >
> > > > +    try:
> > > > +        event_filename =3D os.path.relpath(event.filename)
> > > > +    except ValueError:
> > > > +        event_filename =3D event.filename
> > > > +    event_filename =3D PurePath(event_filename).as_posix()
> > >
> > > Please do this in one place to avoid code duplication in the backends=
.
> > > Perhaps event.filename or a new field can hold the properly formatted
> > > value so backends don't need to call relpath() themselves.
> >
> > I'll move the code to "tracetool/__init__.py".
> >
> > > I noticed that out_filename is also emitted with #line but, unlike
> > > event.filename, no special processing (relpath() or as_posix()) is
> > > used there. Is it possible to drop relpath() and avoid the whole
> > > issue?
> >
> > "out_filename" is not a problem because it is a relative path in POSIX
> > format. "relpath" was introduced in this commit
> > 9d672e290475001fcecdcc9dc79ad088ff89d17f. I can not decide whether it
> > should be dropped or not.
>
> out_filename is the last argument in sys.argv[] and Event.filename
> comes from the previous arguments in sys.argv[].
>
> Tracetool's sys.argv[] comes from trace/meson.build where the
> trace-events filenames are built like this:
>   trace_events_file =3D meson.project_source_root() / item / 'trace-event=
s'
>
> The output filename (sys.argv[-1]) happens to be built as a relative path=
:
>   fmt =3D '@0@-' + group_name + '.@1@'
>   ...
>   output: fmt.format('trace', 'h')
>
> It's inconsistent that out_filename is assumed to be a relative POSIX
> filename whereas the trace-events filenames are made relative by the
> code.
>
> I think it's more robust for tracetool to make filenames relative than
> to assume whoever is invoking tracetool.py has already done that. It's
> also easier for meson.build to be able to pass an absolute path if it
> wants.
>
> That line of thinking results in the following:
> 1. Add a posix_relpath() helper function to tracetool/__init__.py.
> 2. Use posix_relpath() whenever a #line filename is required.
> 3. Also use posix_relpath() on #line out_filename for consistency.
>
> How does that sound?

Sounds good.
Oleg

