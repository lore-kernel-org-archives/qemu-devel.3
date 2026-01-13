Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAA8D30CC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 20:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vflEf-0004sM-PB; Tue, 13 Jan 2026 15:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vflEd-0004r7-Hx
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vflEb-0007ud-JQ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768337003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMFMpg+cMrU5QhLipgvgbTFWoHJD5FMwfaYAnXW8Gnk=;
 b=Iy0jdOGy/9FM9E+vPbcFAZJ+6RDzjA/qcfuyJXyAzoJpMteyRSgEeE2IgE6ZDie1RW6C8k
 1hGAa0YtVWyLlB6EYePhV8TFC1IoCNrbm+/vi4csbmrin10NNz7xlwfhPGH5xoZ6nyiFET
 ZOfh0CVAVVi1javWG9oAWuPVTaye2lE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-4pgr1aE_OuK_5AEgY7-S_w-1; Tue, 13 Jan 2026 15:43:22 -0500
X-MC-Unique: 4pgr1aE_OuK_5AEgY7-S_w-1
X-Mimecast-MFC-AGG-ID: 4pgr1aE_OuK_5AEgY7-S_w_1768337001
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-645535ac027so11908957d50.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768337001; x=1768941801; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMFMpg+cMrU5QhLipgvgbTFWoHJD5FMwfaYAnXW8Gnk=;
 b=mkyg/Kpi6lvstAt4uxqzR9ZIJUQYpVGpbzLoZVVgfQoOMA9UAlhQ4799GVPiSjG3YK
 ADdqOXw9GlsEttvj+twARfLjwVoDV0ak6nKN15islsX4DLfPqNp9PkKTFx82hxh7IzvK
 7tn0wcaatTI57RP1mZIBBaXx8QgT+DGfQ4mRtcd5aMGrpjWlpiEB646jAV+WDSUPuRav
 8YXmsPJSXeUUqz2XcNSVrMC7xqtrQeM0X0PPpvCqCarh8njU4xe4GSa37tDjPUV7dZco
 01gVp0KOnDHB8k+4fZTIh9Lmjr3AjZAaYW2CqFXWhhDUA42wiPHzORRuoV7MaxJBsRDI
 6gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768337001; x=1768941801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SMFMpg+cMrU5QhLipgvgbTFWoHJD5FMwfaYAnXW8Gnk=;
 b=ayM0CFkgAiVjG8rv5zRp2HMUQ8W1bxE4Zl5WfHM5AYbctN0ohCU5JXNq87eM+68e7n
 /SEyhYWRsEco6of48prQ0VRN+/yQFK3lk5W2sLK32qsMSgMHfnNEWwphb8U07LnDmaKW
 V/2FYMyhxSB/8AY/nHy0lTTtVuvKKcapQQoJtLkVkoFhRqRxP3cS3AgDhHmuSGJAUR7X
 qXTh+YfNbzcM/a7Mm2W+NSJtR6MslUCnDuCzuSbSL9nbUSFFuknRXzaewjA53/EqLjFN
 0Se19biiBuVseHNgW01V32s6Zbv7Uqika7E7r5VUHfAodYNWOyEY8ekZb51CdwM/b3uk
 jF4w==
X-Gm-Message-State: AOJu0Yw7UdnAHPg+HjYcv9WmDgQU0PWU/7s+PoJN/KcOoT/ZJZX8qTZM
 Y50h3qn5LdbxfQQyF8zKE6p66VZiwqcRuLnv+3jLoJxI1YxM2fqVSJScLbEa2VrQshRC7ipUyiN
 IEEAEPbP23cM3jNc7sVcwKjLOli04mzbDirSuShY9aY80nzQ2Afy7AeduAb+Jhs42PFYbsNXvWN
 NpakbX4dJPXo3X23t4eNHi3vJWW7aOvaQ=
X-Gm-Gg: AY/fxX4zum3Y5EpAC1VMxeCY1l6NNsjPIkdXSs4mqYcqtSyOQVwjOHukW/KmbjKwPMk
 DetK8ZEWV3R3HjVvZJunOUuVOV6zreTjQv++Y5hOUEsZ/1lPopC3ZEkm6nBR6ntQ4TQHBuH3xKH
 L2WkcYidEg0MUJHmV8riIfTksJneLdFJchsqGnqHiHtkrWXhxsON2bvZlJ9hL7EUbtiBrX67330
 P4mqABj/L6pR/hPIkopAb1WBw==
X-Received: by 2002:a05:690e:1883:b0:644:7a72:a506 with SMTP id
 956f58d0204a3-64901b3aaf1mr389309d50.94.1768337001496; 
 Tue, 13 Jan 2026 12:43:21 -0800 (PST)
X-Received: by 2002:a05:690e:1883:b0:644:7a72:a506 with SMTP id
 956f58d0204a3-64901b3aaf1mr389289d50.94.1768337001012; Tue, 13 Jan 2026
 12:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <20251205060058.1503170-4-jsnow@redhat.com>
 <aVz792X-D_14Ka4f@redhat.com>
In-Reply-To: <aVz792X-D_14Ka4f@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Jan 2026 15:43:09 -0500
X-Gm-Features: AZwV_QgCSorYShD9lsa_RPYrLZsIpHR1fVQyctT_J5yqUj5NW7q61s4nM0geRK4
Message-ID: <CAFn=p-aQz91eXhb370L2UkL4nQNEGYxqdamHpvBb8nEWsRMtVA@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] python/mkvenv: add 'checktests' and 'functests'
 dependency groups
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Jan 6, 2026 at 7:11=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Fri, Dec 05, 2025 at 01:00:45AM -0500, John Snow wrote:
> > 'checktests' contains depedencies *required* to run "make check", and a=
s
> > such, we promise that these dependencies can be sourced from the user's
> > distribution repository or from vendored packages so that "make check"
> > can be executed offline in an isolated build environment.
> >
> > In contrast, pygdbmi is only needed for functional tests and not tests
> > in general; we do not make the same offline/isolated guarantees for
> > functional tests, and this dependency group is allowed to fetch
> > dependencies from PyPI at runtime.
> >
> > For the time being, Amend the "check-venv" target to install both
> > dependency groups, to avoid a duplicate dependency between them.
>
> We now have the 'run' script concept merged, so we can do
> "./run ..." and it'll "do the right thing" executing with
> the python venv in $PYTHONPATH, and locally built binaries
> in $PATH, etc.
>
> What I think is missing is to ensure that qemu.qmp is *always*
> available in the venv.

Always-always, or should the run script do a just-in-time install when
invoked? (Reading ahead: You mean always-always.) I recall we had
competing ideas for the runscript, you didn't see mine, and yours got
merged. Fine by me, but I forget the details. Where is your script...?

(I forget where the hell I was with all of this, my best recollection
is that there is some fine-tuning to do with what dependencies get
installed with which targets and when. I suppose I'll try to hammer
out this specific issue as it's the most recent one in my inbox, then
I will refresh and resend my series and see where we land.)

>
> The split of python deps between vendored and non-vendored
> pieces makes sense, but the association of 'qemu.qmp' with
> tests is overlooking that qemu.qmp is used for more than
> just the tests - it is also a dep of qmp-shell which is a
> developer tool. Given this I think tieing install of qemu.qmp
> to 'make check' (via 'make check-venv') is a mistake. Instead
> we should unconditionally install it when configure is run.

Ah, okay. I think my only concern about doing this was that it was
potentially slow and I was trying to be very aggressive about not
installing anything that was not strictly necessary for the build. I
do agree it's for more than 'tests', though - as you point out, it's
for developer tooling too.

I'm not against always installing it, I think, but I have some
lingering half-remembered reasons that made me think we didn't want
that. I don't remember why. If there's no opposition to it, I guess I
can just do that and see what happens...

>
> We have precedent for that in --enable-rust unconditionally
> installing all vendored Rust crates.  Since we vendor qemu.qmp
> there's no download penalty, and timing the venv creation
> shows it takes about 1 second which is insignificant in the
> context of everything else configure does.
>
> Anyway, if we move the 'checktests' group install to configure,
> then combined with the new 'run' script we would eliminate the
> main behaviour regression from removing qemu.qmp from git.

Alright.

>
>
> Leaving the 'functests' group to be lazy installed is OK, since
> as a developer if you're running a functional test directly,
> that is pretty likely to be after you already had run the
> 'make check-functional' command and saw a failure. IOW the
> venv will be populated with the needed deps.

mmmmm, OK. Let me catch up on some of my other emails and see what the
other lingering complaints I can find are, and I will make a pass at a
version that just installs qemu.qmp unconditionally. Feel free to yell
at me on IRC with any lingering concerns you can think of to help me
get back up to speed after my marathon break...

--js

>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  pythondeps.toml        | 10 +++++++++-
> >  tests/Makefile.include |  2 +-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 1657953ff65..14ceb4e7787 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -31,6 +31,14 @@ meson =3D { accepted =3D ">=3D1.9.0", installed =3D =
"1.9.0", canary =3D "meson" }
> >  sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "6.2.1", canary =
=3D "sphinx-build" }
> >  sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.2.2" }
> >
> > -[testdeps]
> > +# This test group is for dependencies required to run "make check"
> > +# successfully, and should only include depedencies that can be
> > +# guaranteed via configure from system packages, or python packages we
> > +# vendor.
> > +[checktests]
> >  "qemu.qmp" =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> > +
> > +# This test group is for functional tests, and can include dependencie=
s
> > +# fetched from PyPI.
> > +[functests]
> >  pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0" }
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index d4dfbf3716d..40b114bd158 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -98,7 +98,7 @@ quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run=
, \
> >
> >  $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> >       $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> > -     $(MKVENV_ENSUREGROUP) $< testdeps
> > +     $(MKVENV_ENSUREGROUP) $< checktests functests
> >       $(call quiet-command, touch $@)
> >
> >  check-venv: $(TESTS_VENV_TOKEN)
> > --
> > 2.51.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


