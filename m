Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7162DC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKdy-0000bk-DE; Tue, 20 Feb 2024 02:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcKdv-0000bY-FN
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:34:19 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcKds-000314-AD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:34:19 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dbb47852cdso23733275ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708414332; x=1709019132;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDtx/n0c32kuN75bD+iP3DnUNXkzVFNWvXcPFS44MXM=;
 b=BHJ4lnux+MIA5cKXV2nPna/1QBsDOHQ1TgLajTUU13MvU4k14MTejAlO3CaQPqyW2Z
 +k9UaZ3uKn9ejdYlxB3HKjL51rCFBBMiOvorROS85bAfBJRe8Z4NTGudKyr0J7edkYE1
 qNPOXJBnJu7U1Q4/AbEIIBLYQbqJeZ8thMvwqNAyru+oZFx2UZ/joXS6QPgxfjOBbqmK
 Qj39H3/6F+ZUGnWaIQ4yziXekEK3tVEeCyy/VGHdrxEklhYQV4prpg5VnQfhUsbOR2fS
 hE9Xo8/CwnLSM8bXWMpKjyW/d5/71SDblw1S7VkutK+ii4GnujhWVZGvYcS4YU8bqk3E
 u+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708414332; x=1709019132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDtx/n0c32kuN75bD+iP3DnUNXkzVFNWvXcPFS44MXM=;
 b=XU3rDqB0bDugkokI7JZ65xxogDm95HbWMUUNnPRVlSmq0fX3Yd4B1IqhAr0larx8Rt
 u5w5ukqfL8wdgekYWy+sG+MUOxbAAGNOsNED9eQzUdY6lBnc0NAbK5hgZTcZyZF1ULpn
 lvD0arhjZnsUmwMuF9doVLpFH5OwhpfKmaYWmUwaSbrYki6cJUpdyANrZZDBlOnueH6g
 zGqVkK3bfU55oNu7F0N92DQqKUJIgLXVyMMhdQxzOFsaDpBUdX539fFo4aw8+sl4mOPz
 GzpwdTR2o6KyBc0AzOgonquAtOiRXT0bGSdPhugZ7BKHligFg3gN+MEjbwM7+QOoykDK
 2rEg==
X-Gm-Message-State: AOJu0Yx8k2fwNCjQ19m/eHC+dUdjPEVA08tAIDRvNZ1TUjWcf7JkMFX8
 /Tb3EgdGg8/zPfH21PHyrPJ2iJyXBq+7NpYdnjq3jfd+rqxmF+U5Qd/tX2HJ94IY/H9pFe2deVK
 PVIpGRqJfTKOUR9/3V+znxtsrMQwGq+8YONkx7g==
X-Google-Smtp-Source: AGHT+IEBBFa/O7aej8OyEuFvMFtmFx2lHB2H8Cr6XK7ngttO9asgctyVvxndM2I96M14EItP4B2j3tCJNA10OXMgkjk=
X-Received: by 2002:a17:90a:bb0f:b0:298:d21a:976c with SMTP id
 u15-20020a17090abb0f00b00298d21a976cmr11038634pjr.17.1708414331022; Mon, 19
 Feb 2024 23:32:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706586786.git.yong.huang@smartx.com>
 <af7253711254128efbc37b25fb5c47b851367ce7.1706586786.git.yong.huang@smartx.com>
 <87zfvwjzzd.fsf@pond.sub.org>
In-Reply-To: <87zfvwjzzd.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 20 Feb 2024 15:31:54 +0800
Message-ID: <CAK9dgmY0rExYg+hfTY_okNvTTArZdn60jsWjCABgbbAG6XZiDw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005481a10611cb35a7"
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
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

--0000000000005481a10611cb35a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> yong.huang@smartx.com writes:
>
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > To support detached LUKS header creation, make the existing 'file'
> > field in BlockdevCreateOptionsLUKS optional.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> [...]
>
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index ae604c6019..69a88d613d 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4957,7 +4957,8 @@
> >  #
> >  # Driver specific image creation options for LUKS.
> >  #
> > -# @file: Node to create the image format on
> > +# @file: Node to create the image format on, mandatory except when
> > +#        'preallocation' is not requested
>
> You mean when @preallocation is "off"?
>
> Cases:
>
> 1. @file is mandatory
>

When @preallocation is specified to PREALLOC_MODE_ON, file
is mandatory because preallocation aims to act on payload data that
@file holds.


> 2. @file is optional and present
>

When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
@file if optional.
If @file present=EF=BC=8Cthere are two cases:
1. @header is absent,  the creation process degenerate to the origin action=
.
2. @header is present,  the creation process would trunk the payload data
image that @file holds and do the LUKS formatting on the image that
@header refers;


>
> 3. @file is optional and absent
>

When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
@file if optional.
If @file is absent, do the LUKS formatting only.
Note that Either the parameter 'header' or 'file' must be specified.

Here's my interpretation; do let me know if any of the points are off or
need to be refactored.


>
> Ignorant question: behavior in each case?
>
> >  #
> >  # @size: Size of the virtual disk in bytes
> >  #
> > @@ -4968,7 +4969,7 @@
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsLUKS',
> >    'base': 'QCryptoBlockCreateOptionsLUKS',
> > -  'data': { 'file':             'BlockdevRef',
> > +  'data': { '*file':            'BlockdevRef',
> >              'size':             'size',
> >              '*preallocation':   'PreallocMode' } }
>
>
Thanks,

Yong

--=20
Best regards

--0000000000005481a10611cb35a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 20=
24 at 2:31=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><a href=3D=
"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> =
writes:<br>
<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; To support detached LUKS header creation, make the existing &#39;file&=
#39;<br>
&gt; field in BlockdevCreateOptionsLUKS optional.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@re=
dhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index ae604c6019..69a88d613d 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -4957,7 +4957,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Driver specific image creation options for LUKS.<br>
&gt;=C2=A0 #<br>
&gt; -# @file: Node to create the image format on<br>
&gt; +# @file: Node to create the image format on, mandatory except when<br=
>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;preallocation&#39; is not requested=
<br>
<br>
You mean when @preallocation is &quot;off&quot;?<br>
<br>
Cases:<br>
<br>
1. @file is mandatory<br></blockquote><div><br></div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">When=C2=
=A0@preallocation is specified to=C2=A0PREALLOC_MODE_ON, file</div><div cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif">is mandatory because preallocation aims to act on payload data that</d=
iv><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&qu=
ot;,sans-serif">@file holds.=C2=A0</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left=
:1ex">
<br>
2. @file is optional and present<br></blockquote><div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif">When @preallocation<span class=3D"gmail-Apple-converted-space">=C2=
=A0is not specified or equals to=C2=A0</span>PREALLOC_MODE_OFF,</div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif">@file if optional.=C2=A0</div><div class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">If <a class=3D"gmail_plus=
reply" id=3D"plusReplyChip-4">@file</a>=C2=A0present=EF=BC=8Cthere are two =
cases:</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">1. @header is absent, =C2=A0the creation process d=
egenerate to the origin action.</div><div class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">2. @header is present, =
=C2=A0the creation process would trunk the payload data</div><div class=3D"=
gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">i=
mage that=C2=A0@file holds and do the LUKS formatting on the image that</di=
v><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quo=
t;,sans-serif">@header refers;=C2=A0</div></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-lef=
t:1ex">
<br>
3. @file is optional and absent<br></blockquote><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">When @preallocation<span class=3D"gmail-Apple-converted-space">=C2=A0=
is not specified or equals to=C2=A0</span>PREALLOC_MODE_OFF,</div><div clas=
s=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">@file if optional.=C2=A0</div></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">If=C2=A0<a class=3D"g=
mail_plusreply" id=3D"gmail-plusReplyChip-4">@file is=C2=A0</a>absent, do t=
he LUKS formatting only.</div><div class=3D"gmail_default" style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif">Note that=C2=A0Either the parame=
ter &#39;header&#39; or &#39;file&#39; must=C2=A0be specified.</div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif">Here&#39;s my interpretation; do let me know i=
f any of the points are off or</div><div class=3D"gmail_default" style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif">need to be refactored.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">
<br>
Ignorant question: behavior in each case?<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @size: Size of the virtual disk in bytes<br>
&gt;=C2=A0 #<br>
&gt; @@ -4968,7 +4969,7 @@<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevCreateOptionsLUKS&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;base&#39;: &#39;QCryptoBlockCreateOptionsLUKS&#39;,<=
br>
&gt; -=C2=A0 &#39;data&#39;: { &#39;file&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&#39;BlockdevRef&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;*file&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;size&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*preallocation&#3=
9;:=C2=A0 =C2=A0&#39;PreallocMode&#39; } }<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div class=3D"g=
mail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><b=
r></div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif">Yong</div><div><br></div><span class=3D"gmail_signatur=
e_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font></div>=
</div></div>

--0000000000005481a10611cb35a7--

