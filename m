Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57584C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMEb-0000hB-Ru; Tue, 20 Feb 2024 04:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcMEY-0000fI-QM
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 04:16:14 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcMEU-0003du-05
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 04:16:14 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso3965021a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708420443; x=1709025243;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bjwfcsE00fv8NpyhUcrh+xGHdUPF1g4TJGDtcgo7k1s=;
 b=r9bit79M76FJkkga3+OI5wEiGwU2XqK6vbrnS/m4pEz99dJriDFspHLYeHpO2PmKyL
 Kj5gC1H67qPUsI6/L4cpFXXtY7A3N75Evpvkx5JKOdvl9hGH1aMfq19ZFO1sfryip/Bs
 xrYghDsK75VtsR5tTyn5WXwCfI4ElVoJ+xLHdP9OQsekPe1yGpd5Cc4p3d6ip7xA7gdW
 jlX1y0riH+vIKzkzWxhB10C1c4LNMh47vEN0l/y/6EOU5ZLlu+o9GiQp0C2OsT1BYc8S
 Hr7hTYasCCqbMH+1B+Ir+11jmjF2HnGpeLX7jLkJ2GRu9CApOXlL9C35lpe0+Xgj+Rde
 lhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708420443; x=1709025243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjwfcsE00fv8NpyhUcrh+xGHdUPF1g4TJGDtcgo7k1s=;
 b=Om46BIzv3iGNTvYCNPof5lCzMmvVz8YdQAAoY24Vr1+7RRm+Ae/riyFXmaYk3YpZ5n
 ryUunJzHFoYgy4sQCBaDq+QRkleCX7pnzrfs1s/7gsVNv0XNhZGA40DrypUKWTD/qhXc
 /EwLCyMteBM/sbE613iHlTZgj2mUz9jwxY3C25/rMx/sLSZqlDzRxCJ0D5QmULANA28g
 2jQ4I+7xLsdxNm16e3ghIG+E+CLYDN2lkI4Sl96E3ftrvpA7hb2iIHfHSHg/LjwYkR0M
 9S4Dr7bvLTyYto2vPUp5kXIfVSS8yN9IYe6ITBUo+oBdju+mn265Bw0jNiaRzfpxc+Q3
 3oHA==
X-Gm-Message-State: AOJu0YxHLXEtxreT3J1uO2UmJOWy87Ye8tvgehp3rRu2VObOQ2toNyE7
 +ns2xkSax5t0m/v7/oJrnp3cis24M7vcCAedK7jlvHhgU3QjCV40R2wTkhCTCFxF7f9pTa+hYws
 65zyseUwKXf171vk+SbRpYhrSBbcNteYl1pUKFQ==
X-Google-Smtp-Source: AGHT+IGDSuinUwiNKKwSWeA3P2is/Bo3C4N/qRfk5KKOiVnozMJxQbuMRPuOlRR6i3RCsTQ0bre8/kYSW6qMG3BipKU=
X-Received: by 2002:a05:6a20:a814:b0:19e:39d4:284c with SMTP id
 cb20-20020a056a20a81400b0019e39d4284cmr13494470pzb.29.1708420442300; Tue, 20
 Feb 2024 01:14:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706586786.git.yong.huang@smartx.com>
 <af7253711254128efbc37b25fb5c47b851367ce7.1706586786.git.yong.huang@smartx.com>
 <87zfvwjzzd.fsf@pond.sub.org>
 <CAK9dgmY0rExYg+hfTY_okNvTTArZdn60jsWjCABgbbAG6XZiDw@mail.gmail.com>
 <87wmqzcy5h.fsf@pond.sub.org>
In-Reply-To: <87wmqzcy5h.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 20 Feb 2024 17:13:46 +0800
Message-ID: <CAK9dgmaD_3vbOvv9cFzPq-BzQ7xejB-McaD8C9v4Wt_0xnF9kw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009737ee0611cca1c0"
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x535.google.com
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

--0000000000009737ee0611cca1c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:56=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> yong.huang@smartx.com writes:
> >>
> >> > From: Hyman Huang <yong.huang@smartx.com>
> >> >
> >> > To support detached LUKS header creation, make the existing 'file'
> >> > field in BlockdevCreateOptionsLUKS optional.
> >> >
> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>
> >> [...]
> >>
> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> > index ae604c6019..69a88d613d 100644
> >> > --- a/qapi/block-core.json
> >> > +++ b/qapi/block-core.json
> >> > @@ -4957,7 +4957,8 @@
> >> >  #
> >> >  # Driver specific image creation options for LUKS.
> >> >  #
> >> > -# @file: Node to create the image format on
> >> > +# @file: Node to create the image format on, mandatory except when
> >> > +#        'preallocation' is not requested
> >>
> >> You mean when @preallocation is "off"?
> >>
> >> Cases:
> >>
> >> 1. @file is mandatory
> >>
> >
> > When @preallocation is specified to PREALLOC_MODE_ON, file
> > is mandatory because preallocation aims to act on payload data that
> > @file holds.
> >
> >
> >> 2. @file is optional and present
> >>
> >
> > When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
> > @file if optional.
> > If @file present=EF=BC=8Cthere are two cases:
> > 1. @header is absent,  the creation process degenerate to the origin
> action.
> > 2. @header is present,  the creation process would trunk the payload da=
ta
> > image that @file holds and do the LUKS formatting on the image that
> > @header refers;
> >
> >
> >>
> >> 3. @file is optional and absent
> >>
> >
> > When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
> > @file if optional.
> > If @file is absent, do the LUKS formatting only.
> > Note that Either the parameter 'header' or 'file' must be specified.
> >
> > Here's my interpretation; do let me know if any of the points are off o=
r
> > need to be refactored.
> >
> >
> >>
> >> Ignorant question: behavior in each case?
>
> Thanks!  Would it make sense to work the above into the documentation?
>

You mean adding the above interpretation to the following patch?

https://patchew.org/QEMU/c2049499aa05758b4cf18dcec942694ed454a980.170835831=
0.git.yong.huang@smartx.com/


> [...]
>
>
Yong

--=20
Best regards

--0000000000009737ee0611cca1c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 20=
24 at 4:56=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huang=
 &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; <a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.hu=
ang@smartx.com</a> writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; To support detached LUKS header creation, make the existing &=
#39;file&#39;<br>
&gt;&gt; &gt; field in BlockdevCreateOptionsLUKS optional.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@s=
martx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:be=
rrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt; &gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt;&gt; &gt; index ae604c6019..69a88d613d 100644<br>
&gt;&gt; &gt; --- a/qapi/block-core.json<br>
&gt;&gt; &gt; +++ b/qapi/block-core.json<br>
&gt;&gt; &gt; @@ -4957,7 +4957,8 @@<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;=C2=A0 # Driver specific image creation options for LUKS.<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# @file: Node to create the image format on<br>
&gt;&gt; &gt; +# @file: Node to create the image format on, mandatory excep=
t when<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;preallocation&#39; is not =
requested<br>
&gt;&gt;<br>
&gt;&gt; You mean when @preallocation is &quot;off&quot;?<br>
&gt;&gt;<br>
&gt;&gt; Cases:<br>
&gt;&gt;<br>
&gt;&gt; 1. @file is mandatory<br>
&gt;&gt;<br>
&gt;<br>
&gt; When @preallocation is specified to PREALLOC_MODE_ON, file<br>
&gt; is mandatory because preallocation aims to act on payload data that<br=
>
&gt; @file holds.<br>
&gt;<br>
&gt;<br>
&gt;&gt; 2. @file is optional and present<br>
&gt;&gt;<br>
&gt;<br>
&gt; When @preallocation is not specified or equals to PREALLOC_MODE_OFF,<b=
r>
&gt; @file if optional.<br>
&gt; If @file present=EF=BC=8Cthere are two cases:<br>
&gt; 1. @header is absent,=C2=A0 the creation process degenerate to the ori=
gin action.<br>
&gt; 2. @header is present,=C2=A0 the creation process would trunk the payl=
oad data<br>
&gt; image that @file holds and do the LUKS formatting on the image that<br=
>
&gt; @header refers;<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; 3. @file is optional and absent<br>
&gt;&gt;<br>
&gt;<br>
&gt; When @preallocation is not specified or equals to PREALLOC_MODE_OFF,<b=
r>
&gt; @file if optional.<br>
&gt; If @file is absent, do the LUKS formatting only.<br>
&gt; Note that Either the parameter &#39;header&#39; or &#39;file&#39; must=
 be specified.<br>
&gt;<br>
&gt; Here&#39;s my interpretation; do let me know if any of the points are =
off or<br>
&gt; need to be refactored.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Ignorant question: behavior in each case?<br>
<br>
Thanks!=C2=A0 Would it make sense to work the above into the documentation?=
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif"> You mean adding the above int=
erpretation=C2=A0to the following patch?</div><div class=3D"gmail_default" =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif"><a href=3D"https://patchew.org/QEMU/c2049499aa05758b4cf18dcec942694e=
d454a980.1708358310.git.yong.huang@smartx.com/">https://patchew.org/QEMU/c2=
049499aa05758b4cf18dcec942694ed454a980.1708358310.git.yong.huang@smartx.com=
/</a><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;comi=
c sans ms&quot;,sans-serif"><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Yong</div><div><br></div><sp=
an class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D=
"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif"=
>Best regards</font></div></div></div>

--0000000000009737ee0611cca1c0--

