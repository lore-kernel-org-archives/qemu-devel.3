Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2071C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcN6k-0001sc-8j; Tue, 20 Feb 2024 05:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcN6e-0001sL-Fs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:12:08 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcN6a-0004pF-KU
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:12:08 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so4707405b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708423800; x=1709028600;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S+IkuOX6QscYoZTac05+HhAUXBQvWtkgrzozGDmzg/E=;
 b=wJ6BZ12T5CG8F5UZFNf25YngrO+YdBVHf0nqQ9g4omigE4DlFBeOhWBVNRliI1pqEW
 3CTGBzk6g4pbg2vx2YiP7ZWxxQUQOjos4TyeIAEELr0c3kPlEMiknITwoorfM2+2Qj0U
 XIqcddFT3f2uZA3ufqipPtxQPRXcPxxDlOuY7yJ2TyM++ZNYNxv/Sv8D4sqIjxOXEg3W
 TxXmTwnntDTvmND5aMph68dYigzUbsl7BWv0C/3afXtBKItgIsuunUr1wd6jAj6D4IUu
 FI8CZILgjY/Pod1tG8FNmRSZzK87JH6Hf2RtmzEd9kfFyXzk85kZfpWa29iXgV/DdxRZ
 Oxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708423800; x=1709028600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+IkuOX6QscYoZTac05+HhAUXBQvWtkgrzozGDmzg/E=;
 b=ARg5uA/ZJyznFN0Ho4DEn4fA78CrlTnpmQOjFEIZqEXscYJZbMco7Uanms0ji3615u
 WfEAmon1YsbLkd0LIUvdgUOBOjdGPobNXk96OkjR2jJAeoNM6DFEfcJV3r4hHBpuTgF0
 oQRb9hzottmGbrQ9Kc8FLEkIUFXwh4P+uM+DC5dgCe3tist+jwP1OBbAXuP8k9U19cWb
 qWZo3VfpYam8pgyhjBnnqgJFlakBF+0M6t4gZ5QbrwcdSl644HSaXJn1FFeJgatAy7NW
 6CkcKtRLMB/0elTybfrq12ypxrXowatbDZN6+4sqYFR7c+hB0eyRhlhNu3/m5PXdZQXY
 MldA==
X-Gm-Message-State: AOJu0YzlopLHi4DtpHh2z36eGG9GH+myr+M7bCHOAHEysufmGD9QAiTQ
 Em8oBE5E1Z16QNpQ6hE3bar34GysGNes3ZO1ukS5e4VZeII5vtmu9QLCfe3NfoVJR87t7kfTfXC
 HrUODRaZAh+NDJjNvNZMvCKtoasK4C8SGaH60yw==
X-Google-Smtp-Source: AGHT+IF6xaLaoQsoCNiL18FU8agybkXqZ4LPizLthQ89lbr6Ie3xGcQrEGzl/3peuy5IErvOq2+DMnXiLwUhB9M3i5I=
X-Received: by 2002:a05:6a21:3409:b0:19e:4ed7:127a with SMTP id
 yn9-20020a056a21340900b0019e4ed7127amr18394169pzb.46.1708423798447; Tue, 20
 Feb 2024 02:09:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706586786.git.yong.huang@smartx.com>
 <af7253711254128efbc37b25fb5c47b851367ce7.1706586786.git.yong.huang@smartx.com>
 <87zfvwjzzd.fsf@pond.sub.org>
 <CAK9dgmY0rExYg+hfTY_okNvTTArZdn60jsWjCABgbbAG6XZiDw@mail.gmail.com>
 <87wmqzcy5h.fsf@pond.sub.org>
 <CAK9dgmaD_3vbOvv9cFzPq-BzQ7xejB-McaD8C9v4Wt_0xnF9kw@mail.gmail.com>
 <87edd7cw1w.fsf@pond.sub.org>
In-Reply-To: <87edd7cw1w.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 20 Feb 2024 18:09:42 +0800
Message-ID: <CAK9dgmaAgaU=BcPuF48R+vPeBjLxGixDVdytVE=eJqHY_z3Q-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a1f4970611cd699c"
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000a1f4970611cd699c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:47=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Tue, Feb 20, 2024 at 4:56=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> Yong Huang <yong.huang@smartx.com> writes:
> >>
> >> > On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com>
> >> wrote:
> >> >
> >> >> yong.huang@smartx.com writes:
> >> >>
> >> >> > From: Hyman Huang <yong.huang@smartx.com>
> >> >> >
> >> >> > To support detached LUKS header creation, make the existing 'file=
'
> >> >> > field in BlockdevCreateOptionsLUKS optional.
> >> >> >
> >> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >> >> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> >>
> >> >> [...]
> >> >>
> >> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> > index ae604c6019..69a88d613d 100644
> >> >> > --- a/qapi/block-core.json
> >> >> > +++ b/qapi/block-core.json
> >> >> > @@ -4957,7 +4957,8 @@
> >> >> >  #
> >> >> >  # Driver specific image creation options for LUKS.
> >> >> >  #
> >> >> > -# @file: Node to create the image format on
> >> >> > +# @file: Node to create the image format on, mandatory except wh=
en
> >> >> > +#        'preallocation' is not requested
> >> >>
> >> >> You mean when @preallocation is "off"?
> >> >>
> >> >> Cases:
> >> >>
> >> >> 1. @file is mandatory
> >> >>
> >> >
> >> > When @preallocation is specified to PREALLOC_MODE_ON, file
> >> > is mandatory because preallocation aims to act on payload data that
> >> > @file holds.
> >> >
> >> >
> >> >> 2. @file is optional and present
> >> >>
> >> >
> >> > When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
> >> > @file if optional.
> >> > If @file present=EF=BC=8Cthere are two cases:
> >> > 1. @header is absent,  the creation process degenerate to the origin
> action.
> >> > 2. @header is present,  the creation process would trunk the payload
> data
> >> > image that @file holds and do the LUKS formatting on the image that
> >> > @header refers;
> >> >
> >> >
> >> >>
> >> >> 3. @file is optional and absent
> >> >>
> >> >
> >> > When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
> >> > @file if optional.
> >> > If @file is absent, do the LUKS formatting only.
> >> > Note that Either the parameter 'header' or 'file' must be specified.
> >> >
> >> > Here's my interpretation; do let me know if any of the points are of=
f
> or
> >> > need to be refactored.
> >> >
> >> >
> >> >>
> >> >> Ignorant question: behavior in each case?
> >>
> >> Thanks!  Would it make sense to work the above into the documentation?
> >>
> >
> > You mean adding the above interpretation to the following patch?
> >
> >
> https://patchew.org/QEMU/c2049499aa05758b4cf18dcec942694ed454a980.1708358=
310.git.yong.huang@smartx.com/
>
> To the doc comments.
>
> The doc comments are the source code for the "QEMU QMP Reference
> Manual".  That manual should fully explain what the QMP commands do.


> Information on how to best use the commands, or an introduction to
> concepts behind the commands can also be useful, but is often a bad fit
> for a *reference* manual.  We can put it elsewhere then.
>
> Makes sense?
>
>
Of course yes, it can be somewhat complex to use the LUKS volume with
a detachable header, but users may find some relief from the
interpretation.

I'll try it.

--=20
Best regards

--000000000000a1f4970611cd699c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 20=
24 at 5:47=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huang=
 &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Feb 20, 2024 at 4:56=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"=
_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Markus Armbruster &lt=
;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</=
a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; <a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank=
">yong.huang@smartx.com</a> writes:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@s=
martx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; To support detached LUKS header creation, make the e=
xisting &#39;file&#39;<br>
&gt;&gt; &gt;&gt; &gt; field in BlockdevCreateOptionsLUKS optional.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yon=
g.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"=
mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<b=
r>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [...]<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; diff --git a/qapi/block-core.json b/qapi/block-core.=
json<br>
&gt;&gt; &gt;&gt; &gt; index ae604c6019..69a88d613d 100644<br>
&gt;&gt; &gt;&gt; &gt; --- a/qapi/block-core.json<br>
&gt;&gt; &gt;&gt; &gt; +++ b/qapi/block-core.json<br>
&gt;&gt; &gt;&gt; &gt; @@ -4957,7 +4957,8 @@<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 # Driver specific image creation options for L=
UKS.<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;&gt; &gt; -# @file: Node to create the image format on<br>
&gt;&gt; &gt;&gt; &gt; +# @file: Node to create the image format on, mandat=
ory except when<br>
&gt;&gt; &gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;preallocation&#39=
; is not requested<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; You mean when @preallocation is &quot;off&quot;?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Cases:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; 1. @file is mandatory<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; When @preallocation is specified to PREALLOC_MODE_ON, file<br=
>
&gt;&gt; &gt; is mandatory because preallocation aims to act on payload dat=
a that<br>
&gt;&gt; &gt; @file holds.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; 2. @file is optional and present<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; When @preallocation is not specified or equals to PREALLOC_MO=
DE_OFF,<br>
&gt;&gt; &gt; @file if optional.<br>
&gt;&gt; &gt; If @file present=EF=BC=8Cthere are two cases:<br>
&gt;&gt; &gt; 1. @header is absent,=C2=A0 the creation process degenerate t=
o the origin action.<br>
&gt;&gt; &gt; 2. @header is present,=C2=A0 the creation process would trunk=
 the payload data<br>
&gt;&gt; &gt; image that @file holds and do the LUKS formatting on the imag=
e that<br>
&gt;&gt; &gt; @header refers;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; 3. @file is optional and absent<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; When @preallocation is not specified or equals to PREALLOC_MO=
DE_OFF,<br>
&gt;&gt; &gt; @file if optional.<br>
&gt;&gt; &gt; If @file is absent, do the LUKS formatting only.<br>
&gt;&gt; &gt; Note that Either the parameter &#39;header&#39; or &#39;file&=
#39; must be specified.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Here&#39;s my interpretation; do let me know if any of the po=
ints are off or<br>
&gt;&gt; &gt; need to be refactored.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Ignorant question: behavior in each case?<br>
&gt;&gt;<br>
&gt;&gt; Thanks!=C2=A0 Would it make sense to work the above into the docum=
entation?<br>
&gt;&gt;<br>
&gt;<br>
&gt; You mean adding the above interpretation to the following patch?<br>
&gt;<br>
&gt; <a href=3D"https://patchew.org/QEMU/c2049499aa05758b4cf18dcec942694ed4=
54a980.1708358310.git.yong.huang@smartx.com/" rel=3D"noreferrer" target=3D"=
_blank">https://patchew.org/QEMU/c2049499aa05758b4cf18dcec942694ed454a980.1=
708358310.git.yong.huang@smartx.com/</a><br>
<br>
To the doc comments.<br>
<br>
The doc comments are the source code for the &quot;QEMU QMP Reference<br>
Manual&quot;.=C2=A0 That manual should fully explain what the QMP commands =
do.=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-co=
lor:rgb(204,204,204);padding-left:1ex">
<br>
Information on how to best use the commands, or an introduction to<br>
concepts behind the commands can also be useful, but is often a bad fit<br>
for a *reference* manual.=C2=A0 We can put it elsewhere then.<br>
<br>
Makes sense?<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Of course yes, it can be som=
ewhat complex to use the LUKS volume with</div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">a detachable he=
ader, but users may find some relief from the interpretation.=C2=A0</div><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:&quo=
t;comic sans ms&quot;,sans-serif">I&#39;ll try it.</div><div><br></div><spa=
n class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">=
Best regards</font></div></div></div>

--000000000000a1f4970611cd699c--

