Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C937C5B559
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnL7-00060B-Py; Wed, 04 Jun 2025 08:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uMnL3-0005yp-JI
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uMnKx-0006LS-QZ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749040517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EIg8Pz7rdWM3rNSbN8iBKIwMHd60MI0qvxP3zttrtZw=;
 b=Z2EcQNJhR5wkYOEPh87lNswS7y7JOLc+29ZW5/hCZnaUfX3weQge8KKIqVL42r7t5xJ02E
 WNpXRrA7yTaMjJ4MYNtiqlZB9LF78sWjEppOhqsFd3LY2BCHQ6tzOnGnxt4hXZic8pV3i9
 pyZ2Vg1uYXTf6bOqItX4q1MyEaSXKvI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-KwSCvM0PORGECLRqrfoHOw-1; Wed, 04 Jun 2025 08:35:15 -0400
X-MC-Unique: KwSCvM0PORGECLRqrfoHOw-1
X-Mimecast-MFC-AGG-ID: KwSCvM0PORGECLRqrfoHOw_1749040515
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-70e3acd6353so102343177b3.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 05:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749040515; x=1749645315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EIg8Pz7rdWM3rNSbN8iBKIwMHd60MI0qvxP3zttrtZw=;
 b=ADiwLNmAKx9bRcnYRRnjvv8eI7LyRGkIeJoEP9ELywGz7vYiAbWCu65uCNVkUnrjA0
 wTFQiu8WkBEO59CeAf+ZQLkRffegVz48trBiuqexUmPEvaChghA4RJN3WG1WFbnTwUrp
 r6eD8YiLkQBBBxobg2zaoPM8jG3cI/hZ6cP+cWwG1GlRlUhk06YAK+mrj2EOyZqd3qHX
 XMCczC3xuJ+Eo5RiFi1fKLdfsA1OyxpdsX6BRHy4GNiWfcRk232mbkrq6AERFhTXP1au
 usxVyj/ZPswLEVddm4qA+3sbKPSp+2gp6w2Rt+2KAdISEZB8fxTEdTJNsGdIt7pEJ3ij
 CqBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWILxuJ/kRYVjN4fkrl0Fo/H2CJu/2ZhEC+iUvndiwpGVcMuBqzqCQqcB8AD9TrkGznmpcSPvi+KBTl@nongnu.org
X-Gm-Message-State: AOJu0YxyhcNUyvriUFidIVSdvzXvkejiE9GKt6Pnp6P+f/9t2r3aRU1t
 vJrYuGiBF9J6Ox8bnLrtcOb+4cyJxAh0v+s1EOxCaQPctg6E7NVhXXbnWGLPx4xmt1b7jXByEhe
 vJlJxfMde9F+51NCnSABv9x/GT9jr/p7+Dj0G85T3gWmmX6DTZ0+oHnBtbRny4kCWcnunrc6IVo
 WIn4nZi79B6d8d80EvKjn6K2s/i7F7d/8=
X-Gm-Gg: ASbGnct/jTNPLSydPQKYbX12DngjLUuPHRJGqLBDGsd+3gQFO240FzlpuREe2PU/1ru
 KcH0J/+cCh9pLurG5TI3nBlxU2LdIo1nC9S3CwQLq1ldhuPoVIAyy+TwWa7UBDDSNukrjHg==
X-Received: by 2002:a05:690c:6405:b0:709:ad9e:e651 with SMTP id
 00721157ae682-710d9d76209mr35522677b3.27.1749040515080; 
 Wed, 04 Jun 2025 05:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEOaTvgpWpu4LGdkgrwwfFHWBpDFIAZJD35kZZaaI9jBjnX8agNe1C0SgkCoGpEl+wG2EMZylAj0vUipsAcHo=
X-Received: by 2002:a05:690c:6405:b0:709:ad9e:e651 with SMTP id
 00721157ae682-710d9d76209mr35522147b3.27.1749040514562; Wed, 04 Jun 2025
 05:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 <87a56o1154.fsf@pond.sub.org> <aD_yhelX-w4Vdm8Z@redhat.com>
 <87frgfyjb5.fsf@pond.sub.org> <aEAQZLOrJvF5rdz4@redhat.com>
In-Reply-To: <aEAQZLOrJvF5rdz4@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Wed, 4 Jun 2025 15:35:02 +0300
X-Gm-Features: AX0GCFuvosUu30gIhc8vZIAv4EZzADBq5__uQ2nzBQm4bLWC8PMP7rq_RL530dA
Message-ID: <CAGoVJZy3bi6Cjn4riFN4qCb7fM9yBRmy4so8xDhsZOJiQgySOQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009196f50636be3ad5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009196f50636be3ad5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Jun 04, 2025 at 10:58:38AM +0200, Markus Armbruster wrote:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> > > On Wed, Jun 04, 2025 at 08:17:27AM +0200, Markus Armbruster wrote:
> > >> Stefan Hajnoczi <stefanha@gmail.com> writes:
> > >>
> > >> > On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruster <
> armbru@redhat.com> wrote:
> > >> >>
> > >> >> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >  >> +
> > >> >> +The increasing prevalence of AI code generators, most notably bu=
t
> not limited
> > >> >
> > >> > More detail is needed on what an "AI code generator" is. Coding
> > >> > assistant tools range from autocompletion to linters to automatic
> code
> > >> > generators. In addition there are other AI-related tools like
> ChatGPT
> > >> > or Gemini as a chatbot that can people use like Stackoverflow or a=
n
> > >> > API documentation summarizer.
> > >> >
> > >> > I think the intent is to say: do not put code that comes from _any=
_
> AI
> > >> > tool into QEMU.
> > >> >
> > >> > It would be okay to use AI to research APIs, algorithms, brainstor=
m
> > >> > ideas, debug the code, analyze the code, etc but the actual code
> > >> > changes must not be generated by AI.
> > >
> > > The scope of the policy is around contributions we receive as
> > > patches with SoB. Researching / brainstorming / analysis etc
> > > are not contribution activities, so not covered by the policy
> > > IMHO.
> >
> > Yes.  More below.
> >
> > >> The existing text is about "AI code generators".  However, the "most
> > >> notably LLMs" that follows it could lead readers to believe it's abo=
ut
> > >> more than just code generation, because LLMs are in fact used for
> more.
> > >> I figure this is your concern.
> > >>
> > >> We could instead start wide, then narrow the focus to code generatio=
n.
> > >> Here's my try:
> > >>
> > >>   The increasing prevalence of AI-assisted software development
> results
> > >>   in a number of difficult legal questions and risks for software
> > >>   projects, including QEMU.  Of particular concern is code generated
> by
> > >>   `Large Language Models
> > >>   <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> > >
> > > Documentation we maintain has the same concerns as code.
> > > So I'd suggest to substitute 'code' with 'code / content'.
> >
> > Makes sense, thanks!
> >
> > >> If we want to mention uses of AI we consider okay, I'd do so further
> > >> down, to not distract from the main point here.  Perhaps:
> > >>
> > >>   The QEMU project thus requires that contributors refrain from usin=
g
> AI code
> > >>   generators on patches intended to be submitted to the project, and
> will
> > >>   decline any contribution if use of AI is either known or suspected=
.
> > >>
> > >>   This policy does not apply to other uses of AI, such as researchin=
g
> APIs or
> > >>   algorithms, static analysis, or debugging.
> > >>
> > >>   Examples of tools impacted by this policy includes both GitHub's
> CoPilot,
> > >>   OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which
> are less
> > >>   well known.
> > >>
> > >> The paragraph in the middle is new, the other two are unchanged.
> > >>
> > >> Thoughts?
> > >
> > > IMHO its redundant, as the policy is expressly around contribution of
> > > code/content, and those activities as not contribution related, so
> > > outside the scope already.
> >
> > The very first paragraph in this file already set the scope: "provenanc=
e
> > of patch submissions [...] to the project", so you have a point here.
> > But does repeating the scope here hurt or help?
>
> I guess it probably doesn't hurt to have it. Perhaps tweak to
>
>  This policy does not apply to other uses of AI, such as researching APIs
> or
>  algorithms, static analysis, or debugging, provided their output is not
>  to be included in contributions.
>
> and for the last paragraph remove 'both' and add a tailer
>
>    Examples of tools impacted by this policy include GitHub's CoPilot,
>    OpenAI's ChatGPT, and Meta's Code Llama (amongst many others which are
> less
>    well known), and code/content generation agents which are built on top
> of
>    such tools.
>

I suggest emphasizing AI code completion as well (for example Copilot
integrated with Visual Studio Code does it). As such code is not generated
as a result of the prompt but by the "usual" code completion operation, the
developer might not be aware that this is actually AI generated code.

Best regards,
Yan.


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
>

--0000000000009196f50636be3ad5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 4, =
2025 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1e=
x">On Wed, Jun 04, 2025 at 10:58:38AM +0200, Markus Armbruster wrote:<br>
&gt; Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" tar=
get=3D"_blank">berrange@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; On Wed, Jun 04, 2025 at 08:17:27AM +0200, Markus Armbruster wrote=
:<br>
&gt; &gt;&gt; Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" tar=
get=3D"_blank">stefanha@gmail.com</a>&gt; writes:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; &gt; On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.=
com</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; From: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:=
berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; &gt;=C2=A0 &gt;&gt; +<br>
&gt; &gt;&gt; &gt;&gt; +The increasing prevalence of AI code generators, mo=
st notably but not limited<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; More detail is needed on what an &quot;AI code generator=
&quot; is. Coding<br>
&gt; &gt;&gt; &gt; assistant tools range from autocompletion to linters to =
automatic code<br>
&gt; &gt;&gt; &gt; generators. In addition there are other AI-related tools=
 like ChatGPT<br>
&gt; &gt;&gt; &gt; or Gemini as a chatbot that can people use like Stackove=
rflow or an<br>
&gt; &gt;&gt; &gt; API documentation summarizer.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; I think the intent is to say: do not put code that comes=
 from _any_ AI<br>
&gt; &gt;&gt; &gt; tool into QEMU.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; It would be okay to use AI to research APIs, algorithms,=
 brainstorm<br>
&gt; &gt;&gt; &gt; ideas, debug the code, analyze the code, etc but the act=
ual code<br>
&gt; &gt;&gt; &gt; changes must not be generated by AI.<br>
&gt; &gt;<br>
&gt; &gt; The scope of the policy is around contributions we receive as<br>
&gt; &gt; patches with SoB. Researching / brainstorming / analysis etc<br>
&gt; &gt; are not contribution activities, so not covered by the policy<br>
&gt; &gt; IMHO.<br>
&gt; <br>
&gt; Yes.=C2=A0 More below.<br>
&gt; <br>
&gt; &gt;&gt; The existing text is about &quot;AI code generators&quot;.=C2=
=A0 However, the &quot;most<br>
&gt; &gt;&gt; notably LLMs&quot; that follows it could lead readers to beli=
eve it&#39;s about<br>
&gt; &gt;&gt; more than just code generation, because LLMs are in fact used=
 for more.<br>
&gt; &gt;&gt; I figure this is your concern.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; We could instead start wide, then narrow the focus to code ge=
neration.<br>
&gt; &gt;&gt; Here&#39;s my try:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt;=C2=A0 =C2=A0The increasing prevalence of AI-assisted software=
 development results<br>
&gt; &gt;&gt;=C2=A0 =C2=A0in a number of difficult legal questions and risk=
s for software<br>
&gt; &gt;&gt;=C2=A0 =C2=A0projects, including QEMU.=C2=A0 Of particular con=
cern is code generated by<br>
&gt; &gt;&gt;=C2=A0 =C2=A0`Large Language Models<br>
&gt; &gt;&gt;=C2=A0 =C2=A0&lt;<a href=3D"https://en.wikipedia.org/wiki/Larg=
e_language_model" rel=3D"noreferrer" target=3D"_blank">https://en.wikipedia=
.org/wiki/Large_language_model</a>&gt;`__ (LLMs).<br>
&gt; &gt;<br>
&gt; &gt; Documentation we maintain has the same concerns as code.<br>
&gt; &gt; So I&#39;d suggest to substitute &#39;code&#39; with &#39;code / =
content&#39;.<br>
&gt; <br>
&gt; Makes sense, thanks!<br>
&gt; <br>
&gt; &gt;&gt; If we want to mention uses of AI we consider okay, I&#39;d do=
 so further<br>
&gt; &gt;&gt; down, to not distract from the main point here.=C2=A0 Perhaps=
:<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt;=C2=A0 =C2=A0The QEMU project thus requires that contributors =
refrain from using AI code<br>
&gt; &gt;&gt;=C2=A0 =C2=A0generators on patches intended to be submitted to=
 the project, and will<br>
&gt; &gt;&gt;=C2=A0 =C2=A0decline any contribution if use of AI is either k=
nown or suspected.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt;=C2=A0 =C2=A0This policy does not apply to other uses of AI, s=
uch as researching APIs or<br>
&gt; &gt;&gt;=C2=A0 =C2=A0algorithms, static analysis, or debugging.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt;=C2=A0 =C2=A0Examples of tools impacted by this policy include=
s both GitHub&#39;s CoPilot,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0OpenAI&#39;s ChatGPT, and Meta&#39;s Code Llama, =
amongst many others which are less<br>
&gt; &gt;&gt;=C2=A0 =C2=A0well known.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; The paragraph in the middle is new, the other two are unchang=
ed.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; Thoughts?<br>
&gt; &gt;<br>
&gt; &gt; IMHO its redundant, as the policy is expressly around contributio=
n of<br>
&gt; &gt; code/content, and those activities as not contribution related, s=
o<br>
&gt; &gt; outside the scope already.<br>
&gt; <br>
&gt; The very first paragraph in this file already set the scope: &quot;pro=
venance<br>
&gt; of patch submissions [...] to the project&quot;, so you have a point h=
ere.<br>
&gt; But does repeating the scope here hurt or help?<br>
<br>
I guess it probably doesn&#39;t hurt to have it. Perhaps tweak to<br>
<br>
=C2=A0This policy does not apply to other uses of AI, such as researching A=
PIs or<br>
=C2=A0algorithms, static analysis, or debugging, provided their output is n=
ot<br>
=C2=A0to be included in contributions.<br>
<br>
and for the last paragraph remove &#39;both&#39; and add a tailer<br>
<br>
=C2=A0 =C2=A0Examples of tools impacted by this policy include GitHub&#39;s=
 CoPilot,<br>
=C2=A0 =C2=A0OpenAI&#39;s ChatGPT, and Meta&#39;s Code Llama (amongst many =
others which are less<br>
=C2=A0 =C2=A0well known), and code/content generation agents which are buil=
t on top of<br>
=C2=A0 =C2=A0such tools.<br></blockquote><div><br></div><div>I suggest emph=
asizing=C2=A0AI code completion as well (for example Copilot integrated wit=
h Visual Studio Code does it). As such code is not generated as a result of=
 the prompt but by the &quot;usual&quot; code completion operation, the dev=
eloper might not be aware that this is actually AI generated code.</div><di=
v><br></div><div>Best regards,</div><div>Yan.</div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-le=
ft:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div></div>

--0000000000009196f50636be3ad5--


