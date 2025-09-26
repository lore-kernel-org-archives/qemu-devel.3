Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CDDCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 19:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2E6J-0006gH-Um; Fri, 26 Sep 2025 15:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v2E6H-0006eb-Ly
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 15:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v2E65-0005cJ-Qt
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 15:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758914825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMWQz4ONWoJUcBgefp/qHyt71eDdSre4DeSV1Lx0ZF8=;
 b=jVXmGcoB/QhUlAHmzZMMQkICccE674UKUZWnpy7k5OCw4oBHlnMI/5ZU7E5YOdMbZ+7XNS
 BqLpq/qr1B9S13nia+vNuW6/apUsKMbLCIs7ZuU/H2QOmx9N+TPqL/8uhoFBv/RFcFHPj/
 d/qUWkjxk5Y3qQaEF5xpWwIc52bOxKo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-vBM_1j4RP-i8c3Gl-Cre8g-1; Fri, 26 Sep 2025 15:27:01 -0400
X-MC-Unique: vBM_1j4RP-i8c3Gl-Cre8g-1
X-Mimecast-MFC-AGG-ID: vBM_1j4RP-i8c3Gl-Cre8g_1758914820
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ece0cb7c9cso1930673f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 12:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758914820; x=1759519620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMWQz4ONWoJUcBgefp/qHyt71eDdSre4DeSV1Lx0ZF8=;
 b=u3rDnDbP1qy/M0qJH3FnigP0YHSHqCkcZb6zIJCzNzAAoUBuQ7AHZLphBKt2wKpR59
 2Tz197QVFdOwfezHt1Q6DFMbzFE4p3HFsOX86XfolswcAl464tlNO0NyuF6SgFLGrSqy
 O4Ojgs22MLKdwj4WeOZcTyOk3v6g9Wnj0fRBFDrUr1mj+cLqGt8ZB+jr+WOjhvekZp8r
 uImP56Z0gfwkG46yA9Ip1/e6nHXFl+86aBItMBP0CsVt5BigLuWaQYC38p0LvJlNWgsp
 fSF9MFWluIsGsJBvvb8ykRtsVU94HpGYZDtkWOZW0FqSoSo4Vit1AyKeIaAaziGvu0Ht
 ORyw==
X-Gm-Message-State: AOJu0YwrrDTDbV97A1EufJnwRZcDeapN42I3ChFzm94mnRlzTuo8m4yN
 etR8SQr00DXNafLjb/AE6ZoD4iSKL9zweLjwB/LiNjzoyT1F+IzwT/nDtOMY+glqOv3BI5M0y/V
 JJWkqE6f21T6mg47kNPzztOkuUMtUU27pMj7O/7YVgK9TGq3qzVZowNh6/70MDX6XLuWKvbe6Sj
 UtYOcoGfpj46nPvpN26ekKZGphN6+5tX8=
X-Gm-Gg: ASbGncsFhkL8epJ4vKo/EISPCUnPsaHwNRf6UVEWdGYLmf3qRmSnED9j7BKlHZte1lA
 Ze6pqrZAjno1+eY4gH1ynfxirKgzvsjkeIat3vB6zETNSl6dp61BI+0n9c4yiyZXMrU4LV8tFmL
 3FrgOva4bElNPKS9dmNSEV37D4JVtYA4gYj1PokbAA1dMohSJsLTgO9c0rkF2wYTONHyOmO0Cu8
 GWYqZa60uJLZeN+yoOkbNNHZAE=
X-Received: by 2002:a05:6000:2507:b0:407:7a7:1ca0 with SMTP id
 ffacd0b85a97d-40e4773cb94mr8181317f8f.14.1758914820362; 
 Fri, 26 Sep 2025 12:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/0vy8EhVkAmQT1YcfGJImsQifRGjSXR9Q/qbHCzkwSjUCfti47PzAlb5Jc/i9eDFHyaGD+O6Accj3g9VFU/o=
X-Received: by 2002:a05:6000:2507:b0:407:7a7:1ca0 with SMTP id
 ffacd0b85a97d-40e4773cb94mr8181306f8f.14.1758914819980; Fri, 26 Sep 2025
 12:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250925075630.352720-1-pbonzini@redhat.com>
 <CAFEAcA_6nf6zAK9=VZE9kCXUvYcZhxAgPUN=0gxtun7ip6b7ig@mail.gmail.com>
In-Reply-To: <CAFEAcA_6nf6zAK9=VZE9kCXUvYcZhxAgPUN=0gxtun7ip6b7ig@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Sep 2025 21:26:47 +0200
X-Gm-Features: AS18NWBpZZrxxBJ83-QZLJZAD67f2Vhu28W8FnEj4MqKdagOCPrEjs6t_o_-XJc
Message-ID: <CABgObfYauCBr7YVUvGURRy0qGS8NaeLn=r23WFuq2hhzgWmJng@mail.gmail.com>
Subject: Re: [PATCH] docs/code-provenance: add an exception for non-creative
 AI changes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi,
 Stefan" <stefanha@redhat.com>, 
 "P. Berrange, Daniel" <berrange@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000917a9063fb9450b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000000917a9063fb9450b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025, 16:39 Peter Maydell <peter.maydell@linaro.org> wrote:

> I figure I'll state my personal opinion on this one. This isn't
> intended to be any kind of 'veto' on the question: I don't
> feel that strongly about it (and I don't think I ought to
> have a personal veto in any case).
>
> I'm not enthusiastic. The current policy is essentially
> "the legal risks are unclear and the project isn't willing
> to accept them". That's a straightforward rule to follow
> that doesn't require either the contributor or the reviewer
> or the project to make a possibly difficult judgement call on
> what counts as not in fact risky. As soon as we start adding
> exceptions then either we the project are making those
> judgement calls, or else we're pushing them on contributors
> or reviewers. I prefer the simple "'no' until the legal
> picture becomes less murky" rule we have currently.
>

In principle I agree. I am not enthusiastic either. There are however two
problems in the current policy.

First, the policy is based on a honor code; in some cases the use of AI can
be easily spotted, but in general it's anything but trivial especially in
capable hands where, for example, code is generated by AI but commit
messages are not. As such, the policy cannot prevent inclusion of AI
generated code, it only tells you who is to blame.

Second, for this specific kind of change it is, pretty much, impossible to
tell whether it's generated with AI or by a specialized tool or by hand. If
you provide a way for people to be honest about their tool usage, and allow
it at least in some cases, there's a nonzero chance they will be; if you
just tell them a hard no, and lying by omission has more than plausible
deniability, there's a relatively high chance that they will just stay
silent on the matter while still using the tool.

In other words, as much as I would also like a simple policy, I expect
fewer undiscovered violations with the exception in place=E2=80=94even beyo=
nd what
the exception allows. And given the stated goal of using proposals and
actual usage to inform future policy, this approach could serve that goal
better than plain prohibition.

That said, I am okay with having no exception if that's the consensus.

Thanks,

Paolo


> -- PMM
>
>

--0000000000000917a9063fb9450b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 26, 2025, 16:39 Pete=
r Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lin=
aro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">I figure I&#39;ll state my personal opinion on this one. This isn&#3=
9;t<br>
intended to be any kind of &#39;veto&#39; on the question: I don&#39;t<br>
feel that strongly about it (and I don&#39;t think I ought to<br>
have a personal veto in any case).<br>
<br>
I&#39;m not enthusiastic. The current policy is essentially<br>
&quot;the legal risks are unclear and the project isn&#39;t willing<br>
to accept them&quot;. That&#39;s a straightforward rule to follow<br>
that doesn&#39;t require either the contributor or the reviewer<br>
or the project to make a possibly difficult judgement call on<br>
what counts as not in fact risky. As soon as we start adding<br>
exceptions then either we the project are making those<br>
judgement calls, or else we&#39;re pushing them on contributors<br>
or reviewers. I prefer the simple &quot;&#39;no&#39; until the legal<br>
picture becomes less murky&quot; rule we have currently.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">In principle I agre=
e. I am not enthusiastic either. There are however two problems in the curr=
ent policy.</div><div dir=3D"auto"><br></div><div dir=3D"auto">First, the p=
olicy is based on a honor code; in some cases the use of AI can be easily s=
potted, but in general it&#39;s anything but trivial especially in capable =
hands where, for example, code is generated by AI but commit messages are n=
ot. As such, the policy cannot prevent inclusion of AI generated code, it o=
nly tells you who is to blame.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Second, for this specific kind of change it is, pretty much, impossi=
ble to tell whether it&#39;s generated with AI or by a specialized tool or =
by hand. If you provide a way for people to be honest about their tool usag=
e, and allow it at least in some cases, there&#39;s a nonzero chance they w=
ill be; if you just tell them a hard no, and lying by omission has more tha=
n plausible deniability, there&#39;s a relatively high chance that they wil=
l just stay silent on the matter while still using the tool.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">In other words, as much as I would al=
so like a simple policy, I expect fewer undiscovered violations with the ex=
ception in place=E2=80=94even beyond what the exception allows. And given t=
he stated goal of using proposals and actual usage to inform future policy,=
 this approach could serve that goal better than plain prohibition.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">That said, I am okay with havin=
g no exception if that&#39;s the consensus.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000000917a9063fb9450b--


