Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A31C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMlsC-0003tP-Lt; Wed, 04 Jun 2025 07:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMls9-0003ny-Eo
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:01:29 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMls5-0001Se-6v
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:01:27 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-606fdbd20afso863903a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749034883; x=1749639683; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SrIpjSl5Cj3QPaupEzeELtj763bW3lGRtpO6G8BFT9c=;
 b=Imfs1UrkZIcI/H0ai89UJ7uAK0AOzmVlgyHAeYGOqxab/IIUTH9mgk8MCPcZC/SVmk
 C+8BL6EQ0GYr8uDOLsd+x9IvBi4/yTFgN6QlEbsMNABYNVpdxVgz01kZYwKz/y7Re2Dz
 UAIfhbLMeFpT0hd63hogEQizNSC1VIoPZ0oW5PN/SExLXqFKdFqWd/uUDmj7zlgBTarO
 dMaun0xOgj9HLnLUw8US1rvsOlXdun8NKE6hoxtcMa+NMvY4Dcr2r9s7zNkRjrz7sOtS
 YEB2q7to6h3z6r06mCIgxy2Jz+tbBhhHDUOW55Q/UPpEVc/QUZA306EGttq/i7Afva+r
 2O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749034883; x=1749639683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SrIpjSl5Cj3QPaupEzeELtj763bW3lGRtpO6G8BFT9c=;
 b=i776rkI2ciZ4nDB6f+UD1I8UQdZOPkAqSSqQAUe+LkIlOiW98fy9ReQBfjS+iCC4lk
 H5+OI7NrYbg1JYNAimG6bFhwBMArJQzY+fgqoDhDi5tnu9KyipxCfPccZbtQXvPo6rog
 QP94EmxAh2+vJPcTq75acR9a/dMgh85r6ad273GlAt2fTlgcUM1eRzYIabbCn9n+4rlC
 Ef0hB3ACAHPZ5Lv6qrA9j0B4lF6TroBRrBJODCLMW66Kz/zdoNZ6yZqWw7V/doiks/sK
 qvGX2k6iJbJYD9s/koi2p8HUWFjIH9yL9A54UWK1CFgJ5rWUwOibLYV5bOznipSTWZoV
 WHkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX9g1H9MdsS5Nmv69hwPCn4+HMlxnsdbC5AAL5sJRUVWht/iDgmZ+EhowsZeFdGk/7pJgex9MAngZL@nongnu.org
X-Gm-Message-State: AOJu0YzarNPis0E4gRo23RE/KywN260G5CW6n1RICmXxWLZVVWFrN69R
 5patuK/ry23i48N5lC5eQNU6AfxXWiNMVffVUq+qOwIIvRy4IE7u1JfRB0Hrjm4xoX0ezq8J1gH
 PxXHBEVPKn4OosJE5zzwnXxUPon4B01s=
X-Gm-Gg: ASbGncvjmnP1SpRvbc7+MhMFsHMmSYzOf8SQt/7zcQbGU8CehPA77MlfbxGvPCkUjJR
 a7opkeoeOxH99hgesmtKQJPjjh/OqXmHc9H1DJIX4ic/kqWoKA4/mcnTI32qUFbfWLI28rFZr9/
 InTiJA1ztEo3I2DwKsHUZChittL0wgA0g=
X-Google-Smtp-Source: AGHT+IEbx45EgD0p9Qw8EeD94dW5uHbyzFO1hijPG8WNuNIYa3MW8fK/8/XZr3F+kEkU5wfnKLNBlvM1U6a++b3rVgs=
X-Received: by 2002:a17:906:c142:b0:ad2:40a1:7894 with SMTP id
 a640c23a62f3a-addf8f99753mr220692366b.41.1749034882094; Wed, 04 Jun 2025
 04:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 <aEANf4HkZTXn9KXN@redhat.com>
In-Reply-To: <aEANf4HkZTXn9KXN@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Jun 2025 07:01:09 -0400
X-Gm-Features: AX0GCFu1mqMY8sbaa2oxS5roEKGN4giRmlZesNGr-nooYiuud17HkSsoQd1jr6g
Message-ID: <CAJSP0QUGY-t=UcFYKFtkU19s6sKcA8ktvWyJDz_CBL8hxjBd5g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d8dd360636bcea74"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d8dd360636bcea74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025, 05:10 Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:

> On Tue, Jun 03, 2025 at 02:25:42PM -0400, Stefan Hajnoczi wrote:
> > On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> > >
> > > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >
> > > There has been an explosion of interest in so called AI code
> > > generators. Thus far though, this is has not been matched by a broadl=
y
> > > accepted legal interpretation of the licensing implications for code
> > > generator outputs. While the vendors may claim there is no problem an=
d
> > > a free choice of license is possible, they have an inherent conflict
> > > of interest in promoting this interpretation. More broadly there is,
> > > as yet, no broad consensus on the licensing implications of code
> > > generators trained on inputs under a wide variety of licenses
> > >
> > > The DCO requires contributors to assert they have the right to
> > > contribute under the designated project license. Given the lack of
> > > consensus on the licensing of AI code generator output, it is not
> > > considered credible to assert compliance with the DCO clause (b) or (=
c)
> > > where a patch includes such generated code.
> > >
> > > This patch thus defines a policy that the QEMU project will currently
> > > not accept contributions where use of AI code generators is either
> > > known, or suspected.
> > >
> > > These are early days of AI-assisted software development. The legal
> > > questions will be resolved eventually. The tools will mature, and we
> > > can expect some to become safely usable in free software projects.
> > > The policy we set now must be for today, and be open to revision. It'=
s
> > > best to start strict and safe, then relax.
> > >
> > > Meanwhile requests for exceptions can also be considered on a case by
> > > case basis.
> > >
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Acked-by: Stefan Hajnoczi <stefanha@gmail.com>
> > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > > ---
> > >  docs/devel/code-provenance.rst | 50 ++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 49 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/docs/devel/code-provenance.rst
> b/docs/devel/code-provenance.rst
> > > index c27d8fe649..261263cfba 100644
> > > --- a/docs/devel/code-provenance.rst
> > > +++ b/docs/devel/code-provenance.rst
> > > @@ -270,4 +270,52 @@ boilerplate code template which is then filled i=
n
> to produce the final patch.
> > >  The output of such a tool would still be considered the "preferred
> format",
> > >  since it is intended to be a foundation for further human authored
> changes.
> > >  Such tools are acceptable to use, provided they follow a
> deterministic process
> > > -and there is clearly defined copyright and licensing for their outpu=
t.
> > > +and there is clearly defined copyright and licensing for their
> output. Note
> > > +in particular the caveats applying to AI code generators below.
> > > +
> > > +Use of AI code generators
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +TL;DR:
> > > +
> > > +  **Current QEMU project policy is to DECLINE any contributions whic=
h
> are
> > > +  believed to include or derive from AI generated code. This include=
s
> ChatGPT,
> > > +  CoPilot, Llama and similar tools**
> >
> > GitHub spells it "Copilot".
> >
> > Claude is very popular for coding at the moment and probably worth
> mentioning.
> >
> > > +
> > > +The increasing prevalence of AI code generators, most notably but no=
t
> limited
> >
> > More detail is needed on what an "AI code generator" is. Coding
> > assistant tools range from autocompletion to linters to automatic code
> > generators. In addition there are other AI-related tools like ChatGPT
> > or Gemini as a chatbot that can people use like Stackoverflow or an
> > API documentation summarizer.
> >
> > I think the intent is to say: do not put code that comes from _any_ AI
> > tool into QEMU.
>
> Right, the intent is that any copyrightable portion of a commit must
> not have come directly from an AI/LLM tool, or from an agent which
> indirectly/internally uses an AI/LLM tool.
>
> "code generator" is possibly a little overly specific, as this is really
> about any type of tool which emits content that will make its way into
> qemu.git, whether code or non-code content (docs, images, etc).
>

Okay. The use case where AI is used to formulate code comments is common
enough that is with pointing it out explicitly in the policy. Many people
wouldn't consider that an "AI code generator" use case.

Stefan


> > It would be okay to use AI to research APIs, algorithms, brainstorm
> > ideas, debug the code, analyze the code, etc but the actual code
> > changes must not be generated by AI.
>
> Mostly yes - there's a fuzzy boundary in the debug/analyze use cases,
> if the tool is also suggesting code changes to fix issues.
>
> If the scope of the suggested changes meets the threshold for being
> (likely) copyrightable code, that would fall under the policy.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000d8dd360636bcea74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 4, 2025, 05:10 Danie=
l P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Tue, Jun 03, 2025 at 02:25:42PM -0400, Stefan Hajnoczi wrote:<br>
&gt; On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; From: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br=
>
&gt; &gt;<br>
&gt; &gt; There has been an explosion of interest in so called AI code<br>
&gt; &gt; generators. Thus far though, this is has not been matched by a br=
oadly<br>
&gt; &gt; accepted legal interpretation of the licensing implications for c=
ode<br>
&gt; &gt; generator outputs. While the vendors may claim there is no proble=
m and<br>
&gt; &gt; a free choice of license is possible, they have an inherent confl=
ict<br>
&gt; &gt; of interest in promoting this interpretation. More broadly there =
is,<br>
&gt; &gt; as yet, no broad consensus on the licensing implications of code<=
br>
&gt; &gt; generators trained on inputs under a wide variety of licenses<br>
&gt; &gt;<br>
&gt; &gt; The DCO requires contributors to assert they have the right to<br=
>
&gt; &gt; contribute under the designated project license. Given the lack o=
f<br>
&gt; &gt; consensus on the licensing of AI code generator output, it is not=
<br>
&gt; &gt; considered credible to assert compliance with the DCO clause (b) =
or (c)<br>
&gt; &gt; where a patch includes such generated code.<br>
&gt; &gt;<br>
&gt; &gt; This patch thus defines a policy that the QEMU project will curre=
ntly<br>
&gt; &gt; not accept contributions where use of AI code generators is eithe=
r<br>
&gt; &gt; known, or suspected.<br>
&gt; &gt;<br>
&gt; &gt; These are early days of AI-assisted software development. The leg=
al<br>
&gt; &gt; questions will be resolved eventually. The tools will mature, and=
 we<br>
&gt; &gt; can expect some to become safely usable in free software projects=
.<br>
&gt; &gt; The policy we set now must be for today, and be open to revision.=
 It&#39;s<br>
&gt; &gt; best to start strict and safe, then relax.<br>
&gt; &gt;<br>
&gt; &gt; Meanwhile requests for exceptions can also be considered on a cas=
e by<br>
&gt; &gt; case basis.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</=
a>&gt;<br>
&gt; &gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">kwolf@redhat.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 docs/devel/code-provenance.rst | 50 +++++++++++++++++++++++=
++++++++++-<br>
&gt; &gt;=C2=A0 1 file changed, 49 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-pro=
venance.rst<br>
&gt; &gt; index c27d8fe649..261263cfba 100644<br>
&gt; &gt; --- a/docs/devel/code-provenance.rst<br>
&gt; &gt; +++ b/docs/devel/code-provenance.rst<br>
&gt; &gt; @@ -270,4 +270,52 @@ boilerplate code template which is then fill=
ed in to produce the final patch.<br>
&gt; &gt;=C2=A0 The output of such a tool would still be considered the &qu=
ot;preferred format&quot;,<br>
&gt; &gt;=C2=A0 since it is intended to be a foundation for further human a=
uthored changes.<br>
&gt; &gt;=C2=A0 Such tools are acceptable to use, provided they follow a de=
terministic process<br>
&gt; &gt; -and there is clearly defined copyright and licensing for their o=
utput.<br>
&gt; &gt; +and there is clearly defined copyright and licensing for their o=
utput. Note<br>
&gt; &gt; +in particular the caveats applying to AI code generators below.<=
br>
&gt; &gt; +<br>
&gt; &gt; +Use of AI code generators<br>
&gt; &gt; +~~~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt; &gt; +<br>
&gt; &gt; +TL;DR:<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 **Current QEMU project policy is to DECLINE any contribut=
ions which are<br>
&gt; &gt; +=C2=A0 believed to include or derive from AI generated code. Thi=
s includes ChatGPT,<br>
&gt; &gt; +=C2=A0 CoPilot, Llama and similar tools**<br>
&gt; <br>
&gt; GitHub spells it &quot;Copilot&quot;.<br>
&gt; <br>
&gt; Claude is very popular for coding at the moment and probably worth men=
tioning.<br>
&gt; <br>
&gt; &gt; +<br>
&gt; &gt; +The increasing prevalence of AI code generators, most notably bu=
t not limited<br>
&gt; <br>
&gt; More detail is needed on what an &quot;AI code generator&quot; is. Cod=
ing<br>
&gt; assistant tools range from autocompletion to linters to automatic code=
<br>
&gt; generators. In addition there are other AI-related tools like ChatGPT<=
br>
&gt; or Gemini as a chatbot that can people use like Stackoverflow or an<br=
>
&gt; API documentation summarizer.<br>
&gt; <br>
&gt; I think the intent is to say: do not put code that comes from _any_ AI=
<br>
&gt; tool into QEMU.<br>
<br>
Right, the intent is that any copyrightable portion of a commit must<br>
not have come directly from an AI/LLM tool, or from an agent which<br>
indirectly/internally uses an AI/LLM tool.<br>
<br>
&quot;code generator&quot; is possibly a little overly specific, as this is=
 really<br>
about any type of tool which emits content that will make its way into<br>
qemu.git, whether code or non-code content (docs, images, etc).<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Okay. The us=
e case where AI is used to formulate code comments is common enough that is=
 with pointing it out explicitly in the policy. Many people wouldn&#39;t co=
nsider that an &quot;AI code generator&quot; use case.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Stefan</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; It would be okay to use AI to research APIs, algorithms, brainstorm<br=
>
&gt; ideas, debug the code, analyze the code, etc but the actual code<br>
&gt; changes must not be generated by AI.<br>
<br>
Mostly yes - there&#39;s a fuzzy boundary in the debug/analyze use cases,<b=
r>
if the tool is also suggesting code changes to fix issues.<br>
<br>
If the scope of the suggested changes meets the threshold for being<br>
(likely) copyrightable code, that would fall under the policy.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000d8dd360636bcea74--

