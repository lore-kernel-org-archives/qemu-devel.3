Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6628BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 17:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLnHj-0007vd-1d; Mon, 24 Jun 2024 13:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLnHh-0007vC-5T
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 13:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLnHZ-0004G2-4h
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 13:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719249307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8y6yIquyQ9xFIBHw9avM/SsIFOc52VWpb0J9P/SZ4J4=;
 b=NS9gTP1UroUMkk2W5TC3e8aZR0CC2MiA2u/NCth8/aNW+my5ap1GGECMrPaamLTWxTB3yG
 d7GnOXK8oNMx5bVt7Q2u8KJVgAfFZwO6fq9ysTzPolEf0AyJsLFhWq2iNNcMeYzXG6swIa
 XdWiLRA3zeF6fuSRIkLIUZ5wo1jlVww=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-QvSk-c2cN3-HQBywwG8W2Q-1; Mon, 24 Jun 2024 13:15:05 -0400
X-MC-Unique: QvSk-c2cN3-HQBywwG8W2Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3634a634f8aso2194765f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 10:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719249304; x=1719854104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8y6yIquyQ9xFIBHw9avM/SsIFOc52VWpb0J9P/SZ4J4=;
 b=bVr6GTxOr7XpDvk8Ilpu1YfYvlrj56lumwiBjhTuhJvtbfrrMZ+03KM1OMCev3z5xq
 I0ssLHnLMeGIjl2uCkpDubo2XinQdsItSycDN2FBWUvYp+Due7DgdVrlGuAGqMvX05gw
 NT1vLdRuxQQet2bBIQUgK0X1VtiXW4hqEANbQ3wx8+2CqHmdK/pHrvTXumGHO1TqG46B
 K+DQA1CEDW7yto5CjimikLLD69fQUByYEATLLjeiURqzm+n4AdEUa/7nxkMhMfl93KGM
 8wPfVu4QmSBtAdAkxXFAGsrjNlVeJtTuCWzqVUD36hiDotR2QJr8W+AbFdgBJKFIW4lI
 NJvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvRU+wj2hJ1Ewq41yINVSTdZaISWw30B/R6KJPEWfupfvq2RL/sMZN7KCTsvNrMe6AroA9mXycEEOnR68gwVyggunIo6U=
X-Gm-Message-State: AOJu0YyiJIjVkgzHfuP3FOVOjtooIuyBmxkLyKq+LiPUbK1FHQHgx4/h
 eUyQ+bmTY14CT3HLbpe2QXhuM6wO4uvK2FKMsBP82wY1Fim8VTZjGHLjrhZCEGRbGoLG3X9wBbr
 TdjYv41QFsZuQ9MbJP8wdFI33YHpFSZznfBIYjFYuelD5jAIMC8IJrtAG9ET1IZmeAMAZDe7QUF
 5QnUqbWTU5xIkS8Xr09jqHG/6Ss5w=
X-Received: by 2002:a05:6000:1fa7:b0:365:32e0:f757 with SMTP id
 ffacd0b85a97d-366e96b22acmr4507249f8f.50.1719249304128; 
 Mon, 24 Jun 2024 10:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErRD2itdA0VK1u9quntlNef5jmZQ4YeFqzvrugj/V9YATo44KCu4NUHB3eGohE2pzti2A3KELXZs0MKcgaLBg=
X-Received: by 2002:a05:6000:1fa7:b0:365:32e0:f757 with SMTP id
 ffacd0b85a97d-366e96b22acmr4507221f8f.50.1719249303684; Mon, 24 Jun 2024
 10:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnmkN2PL3r-2sxqe@redhat.com>
In-Reply-To: <ZnmkN2PL3r-2sxqe@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Jun 2024 19:14:53 +0200
Message-ID: <CABgObfbH4KpFv+eKr3BLpk0S9TOkQNiyQN5q6JAFGsMrWmSGnA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000006ddae061ba5ec59"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--00000000000006ddae061ba5ec59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 24 giu 2024, 18:52 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> On Wed, Jun 19, 2024 at 11:13:58PM +0300, Manos Pitsidianakis wrote:
> > Add options for Rust in meson_options.txt, meson.build, configure to
> > prepare for adding Rust code in the followup commits.
> >
> > `rust` is a reserved meson name, so we have to use an alternative.
> > `with_rust` was chosen.
> >
> > A cargo_wrapper.py script is added that is heavily based on the work of
> > Marc-Andr=C3=A9 Lureau from 2021.
> >
> >
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat=
.com/
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  MAINTAINERS                   |   5 +
> >  configure                     |  11 ++
> >  meson.build                   |  11 ++
> >  meson_options.txt             |   4 +
> >  scripts/cargo_wrapper.py      | 279 ++++++++++++++++++++++++++++++++++
> >  scripts/meson-buildoptions.sh |   6 +
> >  6 files changed, 316 insertions(+)
> >  create mode 100644 scripts/cargo_wrapper.py
>
> > diff --git a/configure b/configure
> > index 38ee257701..6894d7c2d1 100755
> > --- a/configure
> > +++ b/configure
> > @@ -302,6 +302,9 @@ else
> >    objcc=3D"${objcc-${cross_prefix}clang}"
> >  fi
> >
> > +with_rust=3D"auto"
>
> On last week's call one of the things we discussed is the expectations
> for consumers of QEMU around the usage of Rust & its optionality (or
> not) long term.
>
> I'm of the view that to be valuable for QEMU, we need to consider
> Rust to become a mandatory feature. There's a question of how quickly
> we move, however, before declaring it mandatory. The longer we take
> to declare it mandatory, the longer we are limiting the value we
> can take from Rust.
>

Yes, I agree. However, considering we haven't even checked the situation
with what language features are required by any idiomatic bindings vs the
1.63 version that we need to support for Debian, I think it's a bit
premature to make it mandatory.

As soon as the PL011 device is a reasonable example of how to write good
Rust device models, however, we should switch to making it default-on, and
--without-rust can go away within one or two releases.

> +  --with-rust-target-triple=3D*) with_rust_target_triple=3D"$optarg"
>
As with previous posting, IMHO, this should ideally not exist. We should
> honour the --cross-prefix=3D values, re-mapping to to Rust targets for al=
l
> the combos we know about


More precisely it should be based not on the cross prefix, but on the same
OS and CPU values that are detected from cpp symbols and used for the meson
cross file. I have already made a rough list of differences between these
and the Rust target triples, but I haven't yet turned them to code.

It would however be the first patch I send after these are in a good shape
for inclusion.

The priority right now should be to investigate the build tree workspace
design that I sketched last week in my reply to Richard. Once that can be
considered a stable build system integration, further improvements can be
done in tree.

--with-rust-target-triple should only be needed
> as a workaround for where we might have missed a mapping.
>

Agreed.

Paolo

--00000000000006ddae061ba5ec59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 24 giu 2024, 18:52 Daniel P. Berrang=C3=A9 &lt;=
<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer"=
>berrange@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Wed, Jun 19, 2024 at 11:13:58PM +0300, Manos Pi=
tsidianakis wrote:<br>
&gt; Add options for Rust in meson_options.txt, meson.build, configure to<b=
r>
&gt; prepare for adding Rust code in the followup commits.<br>
&gt; <br>
&gt; `rust` is a reserved meson name, so we have to use an alternative.<br>
&gt; `with_rust` was chosen.<br>
&gt; <br>
&gt; A cargo_wrapper.py script is added that is heavily based on the work o=
f<br>
&gt; Marc-Andr=C3=A9 Lureau from 2021.<br>
&gt; <br>
&gt; <a href=3D"https://patchew.org/QEMU/20210907121943.3498701-1-marcandre=
.lureau@redhat.com/" rel=3D"noreferrer noreferrer noreferrer" target=3D"_bl=
ank">https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@red=
hat.com/</a><br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">marcandr=
e.lureau@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidi=
anakis@linaro.org" rel=3D"noreferrer noreferrer" target=3D"_blank">manos.pi=
tsidianakis@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 ++<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 11 ++<br>
&gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 scripts/cargo_wrapper.py=C2=A0 =C2=A0 =C2=A0 | 279 +++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 scripts/meson-buildoptions.sh |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 6 files changed, 316 insertions(+)<br>
&gt;=C2=A0 create mode 100644 scripts/cargo_wrapper.py<br>
<br>
&gt; diff --git a/configure b/configure<br>
&gt; index 38ee257701..6894d7c2d1 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -302,6 +302,9 @@ else<br>
&gt;=C2=A0 =C2=A0 objcc=3D&quot;${objcc-${cross_prefix}clang}&quot;<br>
&gt;=C2=A0 fi<br>
&gt;=C2=A0 <br>
&gt; +with_rust=3D&quot;auto&quot;<br>
<br>
On last week&#39;s call one of the things we discussed is the expectations<=
br>
for consumers of QEMU around the usage of Rust &amp; its optionality (or<br=
>
not) long term.<br>
<br>I&#39;m of the view that to be valuable for QEMU, we need to consider<b=
r>
Rust to become a mandatory feature. There&#39;s a question of how quickly<b=
r>
we move, however, before declaring it mandatory. The longer we take<br>
to declare it mandatory, the longer we are limiting the value we<br>
can take from Rust.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Yes, I agree. However, considering we haven&#39;t even c=
hecked the situation with what language features are required by any idioma=
tic bindings vs the 1.63 version that we need to support for Debian, I thin=
k it&#39;s a bit premature to make it mandatory.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">As soon as the PL011 device is a reasonable exampl=
e of how to write good Rust device models, however, we should switch to mak=
ing it default-on, and --without-rust can go away within one or two release=
s.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +=C2=A0 --with=
-rust-target-triple=3D*) with_rust_target_triple=3D&quot;$optarg&quot;<br><=
/blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">As with previous posting, IMHO,=
 this should ideally not exist. We should<br>
honour the --cross-prefix=3D values, re-mapping to to Rust targets for all<=
br>
the combos we know about</blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">More precisely it should be based not on the cross pref=
ix, but on the same OS and CPU values that are detected from cpp symbols an=
d used for the meson cross file. I have already made a rough list of differ=
ences between these and the Rust target triples, but I haven&#39;t yet turn=
ed them to code.</div><div dir=3D"auto"><br></div><div dir=3D"auto">It woul=
d however be the first patch I send after these are in a good shape for inc=
lusion.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The priority rig=
ht now should be to investigate the build tree workspace design that I sket=
ched last week in my reply to Richard. Once that can be considered a stable=
 build system integration, further improvements can be done in tree.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">--with-rust-target-triple sh=
ould only be needed<br>
as a workaround for where we might have missed a mapping.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Agreed.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--00000000000006ddae061ba5ec59--


