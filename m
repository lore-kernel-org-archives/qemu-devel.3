Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628B5CEE347
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQLz-0004Hi-5b; Tue, 18 Nov 2025 13:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLQLx-0004HJ-De
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:22:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLQLu-0008Qi-Rg
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763490172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLnkG5MRloHG7ylbN4bt2Y6vGHyYYdnKu8P2xogaNNA=;
 b=VKdjiSGx7lmkjWZgLxn3AxsY6l3vISmS/Eqx8AvKvObSWE1vC4wVaIxcQt4wsg7yOmEFBb
 R+KevcLUo7eGfjd9Nkxeb3XhrtOlMlXSg1r1By00TAaQI/tysi++9oqw1HEyPyZkNtGxwO
 vdIHano65lsKmDkXgf8EIYtfeEUPtUE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-bPJOoiPGOIq_Lx4bctBmdA-1; Tue, 18 Nov 2025 13:22:50 -0500
X-MC-Unique: bPJOoiPGOIq_Lx4bctBmdA-1
X-Mimecast-MFC-AGG-ID: bPJOoiPGOIq_Lx4bctBmdA_1763490170
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-786a0fe77d9so98363687b3.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763490170; x=1764094970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mLnkG5MRloHG7ylbN4bt2Y6vGHyYYdnKu8P2xogaNNA=;
 b=o0vErbCzC6TCxJOtfY9jrJypqAE0+z0wZstmx1g137nx3Vk8z/XJLaxhwWLyJVvuCF
 dBVYNu7vXlvM00w7l24ukscVodTFgMGITjISCffudo/f5jR1sfiY9OZkoZFb33ZCb5m9
 VqRq/JXzd21lJSw5OYtAPLwwXFR3mbq50X4CH60SH0TAEE6mbAQTewfV4U6g69MyduZO
 SPcyYnZu3HyQnpW0UiVHaS30uNpCGutgIQtrCEHdIcsKEozel/9nDEJWvxXmBr9C3TNa
 rvy8IBJlavKz7aprt/qraY46S/pjCHJ4Y69ckJlykX7mGkuYRpMn3gwRF9I4b05bnBxs
 arRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763490170; x=1764094970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLnkG5MRloHG7ylbN4bt2Y6vGHyYYdnKu8P2xogaNNA=;
 b=sQzuYH0tXnS7tidcHuO7ejc6ij4wer9tDXJx3qTVsNbJwmZ+d0ii7A9TLdsToT33Vq
 jx/zNPXoMUadCeATJpXMZfascDY7S2X32wCGQP+6Fcr3Q+A83x5DV6pLo8tGaFBoFEIK
 zxECIa2aOdwqUvoOATl7JpMdnoEDcuu8pBLNBhQLbfzxlRseQLQXQliovtHv5Qj1Ksam
 blSPJzMDona1m/2IpaZlsbZL7hlPpGoXaHHMMjU2XYotBRDEqmSzKq+Hu/xc6V6oHmY0
 /hd4Ik4k47UCOVUQ8ZM20W5Dta7hc1PaRNsE05SCsvoP/ZsZLk2AjlLwQzLMbE6vOZE2
 2mnA==
X-Gm-Message-State: AOJu0Yy5pG+700BAq57IP0RvfVRrwx/aV8Ep65ITM2ZfSAFgXM+WKfoc
 iHCmp40tj+ji2kNlWSCDqE2F7isUklUFFRmxxDCajplKERul19vfY80N4yveRIN/fVXsqExczbO
 WiNeOwNqPXBA2NnjSa4PS/U5DUbrfv0Fd4IUXAYirBZ7Lqci1whjCg9DIxv+TXv2Wjxot90v8BJ
 nEuxmu4DdO9Bogu7azbjw7iMwbRhwiM4k=
X-Gm-Gg: ASbGncu5OCA1nN0AGYGcOVv8Jw8/9G1+ZB+4WwXkIdujgoGKusG50GqGFX3FQ51lwgr
 uFFItUyqbljw0a52cnb8SYlo/R/3ffa1qMhNC3tLbWKSk1yHGWZOg9SLqJWUCi60SqG0Az7zFeZ
 dwN/LuyRmG9T0QkNUn5UWPeRGU2sbyicL9RjMMYl/XAvkNUQ+gHhd3IeCqo4XWE+KGiBwkUwDUw
 1MrHM6pF72G9W/Bv+2AnLx3Rw==
X-Received: by 2002:a05:690e:1596:20b0:63f:c6b3:ccd0 with SMTP id
 956f58d0204a3-641e757adacmr12057996d50.29.1763490169931; 
 Tue, 18 Nov 2025 10:22:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkTCnkkGzLEcHfEkNm8JwJUQ5rfc9cl6+xbxFwqrJ6V4sf2tGLT5Y+Zatu7uosARvg38u0co43ix9zd8GveNM=
X-Received: by 2002:a05:690e:1596:20b0:63f:c6b3:ccd0 with SMTP id
 956f58d0204a3-641e757adacmr12057979d50.29.1763490169629; Tue, 18 Nov 2025
 10:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-7-jsnow@redhat.com>
 <e0da46f7-7fc9-4487-b6ec-3f6fc460559d@redhat.com>
In-Reply-To: <e0da46f7-7fc9-4487-b6ec-3f6fc460559d@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Nov 2025 13:22:38 -0500
X-Gm-Features: AWmQ_bkXnJfMiE7HJW5bw658Y4RH3WcQh3P-pA1tji2PcwU25zgktdIKj1Kw6Qo
Message-ID: <CAFn=p-ZhFu9mvhreh=J1baNOaEjz6sFD1Ro7XTeuPcmpaGm2jg@mail.gmail.com>
Subject: Re: [PATCH 06/22] python/mkvenv: rename 'testdeps' to 'functests'
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000207dab0643e28d6f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000207dab0643e28d6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025, 5:01=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 17/11/2025 19.51, John Snow wrote:
> > pygdbmi is only needed for functional tests and not tests in general; t=
o
> > prepare for more universally required test dependencies, rename this
> > dependency group "functests" instead.
> >
> > In other words: we promise that "make check" will run offline in an
> > isolated environment, but we do not make the same promises for
> > functional tests, which require an internet connection.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   pythondeps.toml        | 2 +-
> >   tests/Makefile.include | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 1657953ff65..d814bb54d08 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -31,6 +31,6 @@ meson =3D { accepted =3D ">=3D1.9.0", installed =3D "=
1.9.0",
> canary =3D "meson" }
> >   sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "6.2.1", canary =
=3D
> "sphinx-build" }
> >   sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.2.2" =
}
> >
> > -[testdeps]
> > +[functests]
> >   "qemu.qmp" =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> >   pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0" }
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index d4dfbf3716d..6f86eb283d3 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -98,7 +98,7 @@ quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run=
, \
> >
> >   $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> >       $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> > -     $(MKVENV_ENSUREGROUP) $< testdeps
> > +     $(MKVENV_ENSUREGROUP) $< functests
> >       $(call quiet-command, touch $@)
> >
> >   check-venv: $(TESTS_VENV_TOKEN)
>
> I'd maybe merge this with the next patch. Anyway:
>

Easy enough, sure!


> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

Thanks!

--000000000000207dab0643e28d6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 18, 2025, 5:01=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 17/11/2025 19.51,=
 John Snow wrote:<br>
&gt; pygdbmi is only needed for functional tests and not tests in general; =
to<br>
&gt; prepare for more universally required test dependencies, rename this<b=
r>
&gt; dependency group &quot;functests&quot; instead.<br>
&gt; <br>
&gt; In other words: we promise that &quot;make check&quot; will run offlin=
e in an<br>
&gt; isolated environment, but we do not make the same promises for<br>
&gt; functional tests, which require an internet connection.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 =C2=A0tests/Makefile.include | 2 +-<br>
&gt;=C2=A0 =C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/pythondeps.toml b/pythondeps.toml<br>
&gt; index 1657953ff65..d814bb54d08 100644<br>
&gt; --- a/pythondeps.toml<br>
&gt; +++ b/pythondeps.toml<br>
&gt; @@ -31,6 +31,6 @@ meson =3D { accepted =3D &quot;&gt;=3D1.9.0&quot;, i=
nstalled =3D &quot;1.9.0&quot;, canary =3D &quot;meson&quot; }<br>
&gt;=C2=A0 =C2=A0sphinx =3D { accepted =3D &quot;&gt;=3D3.4.3&quot;, instal=
led =3D &quot;6.2.1&quot;, canary =3D &quot;sphinx-build&quot; }<br>
&gt;=C2=A0 =C2=A0sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D0.5&quot;=
, installed =3D &quot;1.2.2&quot; }<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -[testdeps]<br>
&gt; +[functests]<br>
&gt;=C2=A0 =C2=A0&quot;qemu.qmp&quot; =3D { accepted =3D &quot;&gt;=3D0.0.5=
&quot;, installed =3D &quot;0.0.5&quot; }<br>
&gt;=C2=A0 =C2=A0pygdbmi =3D { accepted =3D &quot;&gt;=3D0.11.0.0&quot;, in=
stalled =3D &quot;0.11.0.0&quot; }<br>
&gt; diff --git a/tests/Makefile.include b/tests/Makefile.include<br>
&gt; index d4dfbf3716d..6f86eb283d3 100644<br>
&gt; --- a/tests/Makefile.include<br>
&gt; +++ b/tests/Makefile.include<br>
&gt; @@ -98,7 +98,7 @@ quiet-venv-pip =3D $(quiet-@)$(call quiet-command-ru=
n, \<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call quiet-venv-pip,install -e &quot;$(SRC=
_PATH)/python/&quot;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(MKVENV_ENSUREGROUP) $&lt; testdeps<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(MKVENV_ENSUREGROUP) $&lt; functests<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call quiet-command, touch $@)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0check-venv: $(TESTS_VENV_TOKEN)<br>
<br>
I&#39;d maybe merge this with the next patch. Anyway:<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Easy enough, sure!</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks!=C2=A0</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_qu=
ote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div></di=
v>

--000000000000207dab0643e28d6f--


