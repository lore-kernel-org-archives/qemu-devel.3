Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D110CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 16:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSzu9-0001eE-Pa; Fri, 29 May 2026 12:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSzu7-0001cv-Nw
 for qemu-devel@nongnu.org; Fri, 29 May 2026 12:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSzu5-0008JS-14
 for qemu-devel@nongnu.org; Fri, 29 May 2026 12:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780071463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AtTya1rtencXgcZMDkxsNU0BT1XFHxESs9SeX7qdZdE=;
 b=gIMW4CZ4g4bR3QPN+LAvZiYs0TTc1KMZG+w6ujgxzNDK5//Gb7ryGPReWSwsNaQsQyleqY
 rhzrX2lv528bnmrUPix4ki4BC+uZY1gNI+k8GhJLu5hVWnVD3EFJAMcJ74uU3DUkQu5IGs
 Gwg6bjXhP0WoIXw8/8a1KDugm52LmUM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-eieQ8OQ6PcCmUito4vuimw-1; Fri, 29 May 2026 12:17:42 -0400
X-MC-Unique: eieQ8OQ6PcCmUito4vuimw-1
X-Mimecast-MFC-AGG-ID: eieQ8OQ6PcCmUito4vuimw_1780071461
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so3927535e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 09:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780071461; cv=none;
 d=google.com; s=arc-20240605;
 b=N0eE7PLxr2GAIQKglDOcegsDt+c82Pd5JrzOaC0oM2PNOY1Vcgea4Nu8npvSBztKP7
 aA3TSpFjLxn+fQZkxgJw7svfmA+um7Oa3tFIEnutx8c1l0nlK/bCONfjyMugQ8bglS8e
 +YuWainB2ZYBt+3UL6nJ3F4HGWGYz3HVxCqONgTBm4KJf13/Dltna4t4mpKOyPjN06FL
 Rqok7376ZWDJ4X9apU4XwJDQ+o1cwgtRAG7r5guIq3o42gyiDZdH1PScZ9JBz84InElg
 +g5jI/EqX+jWMUqDZcDe3IOt8HQNZAkYqkauAdNa6ycyMgJ9WNuDkRSp4zrmHPdIalhn
 Odhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AtTya1rtencXgcZMDkxsNU0BT1XFHxESs9SeX7qdZdE=;
 fh=qwalCgWlNXaEvc+uKjixd/1b39FgYTY9/ymfsd6WScc=;
 b=jKywEBOV3MZttEjCxznox2pjsEEu+B3YVAqM7Bv1F51j81S11l3c2LfaaNcAgXJXUj
 ffZxIwGYumP/N1yx9SLM/h0JxVa9ECxIBYPUf8gKswTGg5pd2m9jlAqa/NyMFL1cgdpY
 0OzN479WdIPUQ2gDyYpdmJwgs+8AxopP1KZcLwMs9RaZ3/wq+/uiA7+1LVyx5OGdpqUy
 BjZKjc9dEFya+0TusYiAOG/O4NqnSied/TU5l6j84O3GMBfGlO8CVT4oZuXrNgOrRQPg
 Rb+uCQBsfOviChEwEaZ7HG/+syT7A2y6rdbKqTo1NAoGGIIjyZ8vGOBdrkG30G9dGU2+
 1SOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780071461; x=1780676261; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AtTya1rtencXgcZMDkxsNU0BT1XFHxESs9SeX7qdZdE=;
 b=TRYYnE9/mF1HbVrFE0yDC1wIXLOn3n69U5XsX2t0GE2O4bg5xin286wD2xMRqbNSE/
 7lN/pAA7Qorer9/nKAa3rN7o7BvY6BfZLv0hGZMGgWnV97xB5n7GpTPxY7BZ8KIv3fJ3
 fwWX/wtkX8QuYxrUOyC/i/Bx/JZuMvO2fWadUCUBC+Nqg6b0Ivgt5s9kQmm6N+nVNQVR
 sXoVOalTZ13knqcNJyODYtxLgUReFaVuZbBjyYVFfZTCA30N0AEN4oGO5mt2K8PPNoHH
 vnqq446sR+fmYECaGfhabIw3oEADczjLIaE+70iiGmZEj9GUpJEDfyPY7vVtfdQ4879R
 WfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780071461; x=1780676261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtTya1rtencXgcZMDkxsNU0BT1XFHxESs9SeX7qdZdE=;
 b=r8LvLpp8ZgZmOkNH2/NErywBA+QOoqIW9P4AgMDeILETdRWoNkUq2V8aHDGxD2kgOz
 ejya9t+vP4IcjfuCeSbAC/SRpuxu0v7BzS87ehHxkfBWrEVUAaZxdEYJAir0cab7kvUb
 NAfxCz1i98b1Ajrgl7OcwBFBjpG5k+7Os3EPQNIhwBOOFmkW4E2XtIagGISN50K0yzxg
 LigIEaxI941t03XYmB3f/Otj+43LGOeWQ5UYCoiLtEilQwCO+fsBLUp3XQVpsDm0WhTY
 PRGsImBlEskaBtfIs+Qd3THd2pA2v+cNeDITa41pwOnURa/lNRt7K6WUQ06PiFdEQLvs
 8D0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ849IDW7fSSzwTvYbjEKEVC1P0A0qZn94DWn1pAymBEs+BsT5WxpQYj+aOj29RscGtKmnNbf4UcTucW@nongnu.org
X-Gm-Message-State: AOJu0YwrMBey7ibJjxuOpjNbOh8/HfAi/VLGqAEVlx51fglVvC0UgCji
 Z99jNTXDn0A0tORXC0b6mAmtFV5pyvm3/wSqHvcd0Yn+srWrzQ7toVqKXhG7YXbY4PXoh/NDWPN
 YgAOw5XQxEHkKWmIk3J7a3UJ1x4FX+cYYfba50akXLSyGPoFKGHagWJ5VFPozjfyD2AmVSHxlvM
 5adyR9uuh/p6CvPOTggPlUohbxWblcZ1k=
X-Gm-Gg: Acq92OECS2Oo1OnWPTv78POqTrABobWJHTGeL7D2NkNxw+jf5d9oSyQLzxNci8dstRZ
 qKk8Z5X7Vd95GNXjHRLkWl7zBptAGhZGoUHMCwDe9Wiw6TEIkMXc3T+l554tH7BQh7zaWDygHMu
 TOLf2/2H+hoI7JsDPn5s+boByFGOiO+i96qYtQ3jDU17aI529XR+Ekugc9Jk4EkgsdO0kN/zmlp
 5nBfQDTol4N83EGjwMyrGJ5UgMZ62rcFirz5qJlgYDpVoQa5D5cIyNNeAyaQyNH10dBDLQUX/PV
 gnUaoQH0NxEYSwtRoQ==
X-Received: by 2002:a05:600c:1382:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490a29e4449mr2722785e9.11.1780071460695; 
 Fri, 29 May 2026 09:17:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1382:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490a29e4449mr2721875e9.11.1780071460026; Fri, 29 May 2026
 09:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <CAFEAcA_EWR_MjH1arCdi2y0saZ-Hc7zRAK97YTeEcesVRb9Rtg@mail.gmail.com>
 <20260529114114-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260529114114-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 May 2026 18:17:29 +0200
X-Gm-Features: AVHnY4Iaek9irYXJi94-Op8cQQ1t2pcbaaropyCroXyvPwZA7Sl_5lalGLReYYw
Message-ID: <CABgObfZ5OUOih=pSrmpCKaAWqWnKgNZ2yZvRUoctYr=tEunoXA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: multipart/alternative; boundary="0000000000000d06a50652f72f5f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000d06a50652f72f5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 29 mag 2026, 17:46 Michael S. Tsirkin <mst@redhat.com> ha scritto:

> > If as a project we want to limit the
> > blast-radius if we find we have to rip out a hypothetical tainted
> > contribution, shouldn't that mean that we hold that as a project-wide
> > line, rather than leaving it up to the opinion of the individual
> > maintainer ?
>
> I guess, the maintainer can judge that the code is unique and qemu
> specific enough, and follows from what it is doing automatically enough,
> that the chances it is accidentally copying something are nil?
>

One thing that I had in mind was using AI to adjust QEMU code as the kernel
side goes through review and APIs change. The changes at that point may be
not entirely mechanical and, more importantly for traceability, it probably
will not make sense to separate them from the original code; but the code
still has fundamentally a shape and design that was provided by the human.

Another, which is Rust-specific, is procedural macro code, which is often
boring, or very much tied to the shape of the generated code and
human-written traits, or both. See
https://github.com/qemu/qemu/blob/master/rust/qemu-macros/src/migration_sta=
te.rs
for an example, contrasting the block starting with "self.conversion =3D
match" with the rest.

I don't think it makes sense to have a wholesale permission for procedural
macros because that is not *always* true, or true for a whole file. But say
a contributor wrote the overall specification/documentation first, and
mostly one-shotted a skeleton with a prompt like "based on the
documentation, generate basic attribute parsing code for the MigrationState
derive macro, together with a code generator that provides empty methods
for an implementation of the trait ::migration::MigrationState from
rust/hw/migration/". Then I would absolutely not reject it. This is also
the intention of the suggestion around prompts=E2=80=94to favor quick gener=
ation of
boilerplate code over full "agentic" (blargh) implementation.

> > +**Documentation and code comments**
> > > +  While AI can help draft text, it still requires significant human
> > > +  oversight.  Pay attention to the organization and flow of the
> generated
> > > +  text, and strictly fact-check all technical details as LLMs are
> prone
> > > +  to being confidently wrong.
> >
> > I think the application to documentation and comments is the part
> > I'm least enthusiastic about here.
>
> But I am very enthusiastic about less agrammatical english in both.
> AI is super helpful for non native speakers.
>

I am also not enthusiastic for documentation; the review I gave for
Philippe's unedited experiment was rather scathing. The main challenge for
documentation is the structure of the work, which is really complicated to
establish because the LLM doesn't have a clue about the underlying design.

But there can be interesting uses nevertheless, such as integrating
knowledge from functional tests into documentation, that are worth
exploring. Also for Rust I am really trying to have *all* functions
commented (and tested through so tests) and AI can produce good results
more often than not, especially when the model has access to a
human-written file-level blurb.

> For changes to code, we have at
> > least some guardrails on the AI output, in the fact that it has to
> > compile and to pass tests. For changes to documentation, the
> > only guardrails are human eyeballs.
> >
> > Also both comments and documentation ideally are a record of
> > what we intended the behaviour to be. If an LLM is effectively
> > autogenerating something documentation-shaped from the code we
> > lose that.
>

I agree with both of these observations, for what it's worth.

Paolo

>
> > -- PMM
>
>

--0000000000000d06a50652f72f5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 29 mag 2026, 17:46 Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; =
If as a project we want to limit the<br>
&gt; blast-radius if we find we have to rip out a hypothetical tainted<br>
&gt; contribution, shouldn&#39;t that mean that we hold that as a project-w=
ide<br>
&gt; line, rather than leaving it up to the opinion of the individual<br>
&gt; maintainer ?<br>
<br>
I guess, the maintainer can judge that the code is unique and qemu<br>
specific enough, and follows from what it is doing automatically enough,<br=
>
that the chances it is accidentally copying something are nil?<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">One thing tha=
t I had in mind was using AI to adjust QEMU code as the kernel side goes th=
rough review and APIs change. The changes at that point may be not entirely=
 mechanical and, more importantly for traceability, it probably will not ma=
ke sense to separate them from the original code; but the code still has fu=
ndamentally a shape and design that was provided by the human.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Another, which is Rust-specific, is =
procedural macro code, which is often boring, or very much tied to the shap=
e of the generated code and human-written traits, or both. See <a href=3D"h=
ttps://github.com/qemu/qemu/blob/master/rust/qemu-macros/src/migration_stat=
e.rs">https://github.com/qemu/qemu/blob/master/rust/qemu-macros/src/migrati=
on_state.rs</a> for an example, contrasting the block starting with &quot;s=
elf.conversion =3D match&quot; with the rest.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">I don&#39;t think it makes sense to have a wholesale =
permission for procedural macros because that is not *always* true, or true=
 for a whole file. But say a contributor wrote the overall specification/do=
cumentation first, and mostly one-shotted a skeleton with a prompt like &qu=
ot;based on the documentation, generate basic attribute parsing code for th=
e MigrationState derive macro, together with a code generator that provides=
 empty methods for an implementation of the trait ::migration::MigrationSta=
te from rust/hw/migration/&quot;. Then I would absolutely not reject it. Th=
is is also the intention of the suggestion around prompts=E2=80=94to favor =
quick generation of boilerplate code over full &quot;agentic&quot; (blargh)=
 implementation.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">&gt; &gt; +**Documentation and code comments**<br>
&gt; &gt; +=C2=A0 While AI can help draft text, it still requires significa=
nt human<br>
&gt; &gt; +=C2=A0 oversight.=C2=A0 Pay attention to the organization and fl=
ow of the generated<br>
&gt; &gt; +=C2=A0 text, and strictly fact-check all technical details as LL=
Ms are prone<br>
&gt; &gt; +=C2=A0 to being confidently wrong.<br>
&gt; <br>
&gt; I think the application to documentation and comments is the part<br>
&gt; I&#39;m least enthusiastic about here.<br>
<br>
But I am very enthusiastic about less agrammatical english in both.<br>
AI is super helpful for non native speakers.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">I am also not enthusiastic for =
documentation; the review I gave for Philippe&#39;s unedited experiment was=
 rather scathing. The main challenge for documentation is the structure of =
the work, which is really complicated to establish because the LLM doesn&#3=
9;t have a clue about the underlying design.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">But there can be interesting uses nevertheless, such a=
s integrating knowledge from functional tests into documentation, that are =
worth exploring. Also for Rust I am really trying to have *all* functions c=
ommented (and tested through so tests) and AI can produce good results more=
 often than not, especially when the model has access to a human-written fi=
le-level blurb.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">&gt; For changes to code, we have at<br>
&gt; least some guardrails on the AI output, in the fact that it has to<br>
&gt; compile and to pass tests. For changes to documentation, the<br>
&gt; only guardrails are human eyeballs.<br>
&gt; <br>
&gt; Also both comments and documentation ideally are a record of<br>
&gt; what we intended the behaviour to be. If an LLM is effectively<br>
&gt; autogenerating something documentation-shaped from the code we<br>
&gt; lose that.<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I agree with both of these observations, for what it&#39;s w=
orth.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; -- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000000d06a50652f72f5f--


