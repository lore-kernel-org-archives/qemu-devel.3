Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29249CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6YB5-0000gm-Eg; Wed, 08 Oct 2025 13:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6YB2-0000gA-9j
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6YAw-0004nt-Dy
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759945320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MpoBmcvdxana/ADI1ZJG5jXl0VsMFcRwbiPxIMI2jDI=;
 b=CfMAc9yey/+BJz8PuH1IGHj5Osm1rnpjsJbPF2ng/qxwE3QS9GtRfr811SaT+81Vx7W+rP
 cusPtAsl1HyguNkhn8aX1qBihVFhZajhoGAzj09cd+rgRvHCtckJ8+P/HJqX90h5HH20oZ
 HYn4B7VvAk7wzWv95xZOSjRI7SZ+4tc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-MAawfersM8Wf-fiIUlqSfA-1; Wed, 08 Oct 2025 13:41:58 -0400
X-MC-Unique: MAawfersM8Wf-fiIUlqSfA-1
X-Mimecast-MFC-AGG-ID: MAawfersM8Wf-fiIUlqSfA_1759945318
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f7b5c27d41so129591f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759945317; x=1760550117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MpoBmcvdxana/ADI1ZJG5jXl0VsMFcRwbiPxIMI2jDI=;
 b=Q/ksVxaLPCrNlRCM1SMyaJrcbfMzjb+qHFo2TU5U3J6fO2sNKx515a8EAAZWB5/orX
 wX2Pcs23fJtdRRU3dGxjZ9/oG49ebK+3VByUrfOvG0jOPl9vFSzuOeWMTNaqEkWdxzDs
 2Xh3qwff/nMj4BRGT3Y+z2ji+MpOXfNw10D8FRJxaKnfoe/5Dib3LBShiiiUQnPV7AMg
 XEzGRlAtIQbb+McpUeHZ4GdYN5T54rYI8iakiiSjxD40h/MmxR5P8uhs3xl8N3XRbYtd
 fOPU2/idZTOfngeEbN2e/FvBUkmgN/baSnq7SMpoJK1rtv+/N5xydhrYfqg0Plx2Y5up
 076w==
X-Gm-Message-State: AOJu0Yx9d4KgwshAJu3nGu2Kh9mk+ZJYgsRZxvWcnH971wtddOUUch+R
 1zBfQfw0k+Q4c/QJwu8DEZjU8D+HviCZa2i8tNy4kdKvh3u9F9/Dft6LDW28mlGRS4eohbijv4F
 B9GkaSjxdcX4h5LD3tuGHtdWDXZFdJEIw8hfgFHp66o0tmh2RaUfRMRqKN95lZXXCCm553Um7XR
 IG9wDrVx8plAYNphPLp2dAiLdZyMZITIo=
X-Gm-Gg: ASbGncs6Tcmx4UZ/e38Mfi6xHkPGdasW1sDgrkBIcjQ/st/rfDECL4pLPqTPnYyuVj5
 r9h/7+G7ydlodJ/WcoZl05N9e2maVosqhJit7fVBAMs59TnW/Q5RimhHsU2eZV5fNMOianFvMyM
 Adjz0Mzq5bTHrdTjXe1m/cKguhAyscXK1ZEThqPgLPyJ3D/+BI6Wlc1FLYxp6717gXTd2EuT8XK
 BqcZO8aYl2CqGdzjlwuhCLhpHbytQ==
X-Received: by 2002:a05:6000:1f09:b0:425:86b1:113a with SMTP id
 ffacd0b85a97d-42586c057f2mr4382751f8f.16.1759945317646; 
 Wed, 08 Oct 2025 10:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEInz+ylA600u0wxZhIhZohiCQkNJjGFzER2akOJS/Q84swVCtQyiOLnUyH56KNxlbNWfJ2Zkt6PpsDubA5UZc=
X-Received: by 2002:a05:6000:1f09:b0:425:86b1:113a with SMTP id
 ffacd0b85a97d-42586c057f2mr4382731f8f.16.1759945317157; Wed, 08 Oct 2025
 10:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008172325.GA181748@fedora>
In-Reply-To: <20251008172325.GA181748@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Oct 2025 19:41:45 +0200
X-Gm-Features: AS18NWBEg3GgHod77kNqBYKjvUK8zmb-BHda9k-XNPoUkVOunaVeM_9P4c2U1QY
Message-ID: <CABgObfYaoJ4-tmdLdbPDiUpheXHigc9pmUAdK1Y6mFhsXo2npg@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracetool: add mypy --strict checking [AI discussion
 ahead!]
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="000000000000741bf20640a933a9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000741bf20640a933a9
Content-Type: text/plain; charset="UTF-8"

Il mer 8 ott 2025, 19:23 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> On Wed, Oct 08, 2025 at 08:35:39AM +0200, Paolo Bonzini wrote:
> > In this version, the types were added mostly with the RightTyper tool
> > (https://github.com/RightTyper/RightTyper), which uses profiling to
> detect
> > the types of arguments and return types at run time.  However, because
> > adding type annotations is such a narrow and verifiable task, I also
> developed
> > a parallel version using an LLM, to provide some data on topics such as:
> >
> > - how much choice/creativity is there in writing type annotations?
> >   Is it closer to writing functional code or to refactoring?
> >
> > - how does AI output for such mechanical transformations compare to other
> >   automated tools, whose output is known not to be copyrightable?
> >
> > - what is the kind of time saving that the tool can provide?
> >
> > - how effective is an LLM for this task?  Is the required human help a
> >   pain to provide, or can the human keep the fun part for itself?
>
> Here are my thoughts:
>
> - Type annotations are probably not copyrightable. Although I think AI
>   output contributions should be allowed for non-copyrightable work, I
>   understand the slippery slope argument. Also, at QEMU Summit the
>   consensus was to give it some time and then revisit the AI policy next
>   year. I think we should stick to that so that the QEMU community has
>   time to consider other scenarios involving AI.


I agree. At the same time, rushing a policy change is bad but making an
uninformed one is too. Submitting the non-AI change, recounting the
experience with the AI tool, and explaining how they differed for me,
hopefully helps informing decisions. In fact this is probably at the upper
end of the complexity, for what can still be described as mechanical
transformation.

In other words, I want to be clear that, even though I did rush a bit the
discussion on the policy, I don't want to rush the changes but rather be
prepared for them.

- Markus pointed out why generating them automatically may not result in
>   the same quality as manually-written annotations because the AI
>   doesn't have the context that is missing from the code itself. [...] The
> difference between
>   manually-written type hints and AI-generated ones is probably less
>   significant than with API documentation though, so I think they are
>   sufficiently valuable and high quality enough to merge.
>

Indeed. And also, the nuances are more important for something where type
hints describe an API than if you're doing it only for some extra static
checking.

You can always start with a tool and refine, too. In fact I expect that
*if* an exception is granted for mechanical changes, submissions would
almost never consist of AI-generated changes only. Full isolation may not
always be practical, but separating AI- or tool-generated commits from
human refinements is something we'd ask for anyway, for the sake of
reviewability.

Paolo

>

--000000000000741bf20640a933a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 8 ott 2025, 19:23 Stefan =
Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Wed, Oct 08, 2025 at 08:35:39AM +0200, Paolo Bonzini wrote:<br>
&gt; In this version, the types were added mostly with the RightTyper tool<=
br>
&gt; (<a href=3D"https://github.com/RightTyper/RightTyper" rel=3D"noreferre=
r noreferrer" target=3D"_blank">https://github.com/RightTyper/RightTyper</a=
>), which uses profiling to detect<br>
&gt; the types of arguments and return types at run time.=C2=A0 However, be=
cause<br>
&gt; adding type annotations is such a narrow and verifiable task, I also d=
eveloped<br>
&gt; a parallel version using an LLM, to provide some data on topics such a=
s:<br>
&gt; <br>
&gt; - how much choice/creativity is there in writing type annotations?<br>
&gt;=C2=A0 =C2=A0Is it closer to writing functional code or to refactoring?=
<br>
&gt; <br>
&gt; - how does AI output for such mechanical transformations compare to ot=
her<br>
&gt;=C2=A0 =C2=A0automated tools, whose output is known not to be copyright=
able? <br>
&gt; <br>
&gt; - what is the kind of time saving that the tool can provide?<br>
&gt; <br>
&gt; - how effective is an LLM for this task?=C2=A0 Is the required human h=
elp a<br>
&gt;=C2=A0 =C2=A0pain to provide, or can the human keep the fun part for it=
self?<br>
<br>
Here are my thoughts:<br>
<br>
- Type annotations are probably not copyrightable. Although I think AI<br>
=C2=A0 output contributions should be allowed for non-copyrightable work, I=
<br>
=C2=A0 understand the slippery slope argument. Also, at QEMU Summit the<br>
=C2=A0 consensus was to give it some time and then revisit the AI policy ne=
xt<br>
=C2=A0 year. I think we should stick to that so that the QEMU community has=
<br>
=C2=A0 time to consider other scenarios involving AI.</blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">I agree. At the same time,=
 rushing a policy change is bad but making an uninformed one is too. Submit=
ting the non-AI change, recounting the experience with the AI tool, and exp=
laining how they differed for me, hopefully helps informing decisions. In f=
act this is probably at the upper end of the complexity, for what can still=
 be described as mechanical transformation.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">In other words, I want to be clear that, even though I =
did rush a bit the discussion on the policy, I don&#39;t want to rush the c=
hanges but rather be prepared for them.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">- Markus pointed out why generating=
 them automatically may not result in<br>
=C2=A0 the same quality as manually-written annotations because the AI<br>
=C2=A0 doesn&#39;t have the context that is missing from the code itself. [=
...] The difference between<br>
=C2=A0 manually-written type hints and AI-generated ones is probably less<b=
r>
=C2=A0 significant than with API documentation though, so I think they are<=
br>
=C2=A0 sufficiently valuable and high quality enough to merge.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Indeed. And a=
lso, the nuances are more important for something where type hints describe=
 an API than if you&#39;re doing it only for some extra static checking.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">You can always start with =
a tool and refine, too. In fact I expect that *if* an exception is granted =
for mechanical changes, submissions would almost never consist of AI-genera=
ted changes only. Full isolation may not always be practical, but separatin=
g AI- or tool-generated commits from human refinements is something we&#39;=
d ask for anyway, for the sake of reviewability.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div class=3D"gmail_q=
uote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
</blockquote></div></div></div>

--000000000000741bf20640a933a9--


