Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AB9E6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlogH-0004Up-B2; Fri, 30 Jan 2026 08:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vlogF-0004UV-JH
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 08:36:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vlogD-0004Z0-PV
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 08:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769780215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1lqTgr1PmbOYfdThAq60Vdm4gMn9+jjWVTcFGFxogAA=;
 b=IONs0GdUCyuJHi3Zf/7inQKXfpRGkmTJDk+8wUR64Qfr+s/uw+lbQeJr7NYgNtv7GO+Wuz
 bQLycu8/qigwvtgfmmbQxb9eYanibM4tK23GkyxEF90hlO2u/tc5ToTvTRB1eEnsmPMmf8
 xPzvlu9tORRj0J5cvfuRLwGVP7pObv4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-EfV53w3JPOGS_RLUf8xEXQ-1; Fri, 30 Jan 2026 08:36:53 -0500
X-MC-Unique: EfV53w3JPOGS_RLUf8xEXQ-1
X-Mimecast-MFC-AGG-ID: EfV53w3JPOGS_RLUf8xEXQ_1769780212
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso19135555e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 05:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769780212; cv=none;
 d=google.com; s=arc-20240605;
 b=Z1j7MxxcPu42NhvRoUOm6sBHihmj2gtFsk/qfz1z/VxdbFkzd295yaFUVmd9DGsd9F
 hSHDQg4CPtLL4AYaKiMAGl8XHmOQMEf3bg2jDO71YXAz1vH+rL7eKygFTcyB2lYyJ4yf
 msfoh/ZaTHw1bVmcC/yf17P1p3/MT84vOaQ8UPGxrq70bn4PVtBXKZFD6mgXWGqowqO5
 PanaE/oAJDGE35/aSQKfj9Lpl9SXrKF1gHFwPWo3LEVlFVZgC1OJipTUtiPKk02ifYUL
 +dhart5//Vn2IxgkOSrXDXjld/nAdPWix+CXczwl64bjso5y25qjBIyLApTtDZ8KzLge
 C8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1lqTgr1PmbOYfdThAq60Vdm4gMn9+jjWVTcFGFxogAA=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=ENX0bLk354ReRE4wY/EmL0TH6mQ5hSruRZr75SFca22dgX8rONWq2BthQMPGin4+ay
 AuEG3MyErSNsMUubIueIgjRQ9Z8kZWM4gsMc8ObQ3T+gLOTfxK5PfR6zqGZkE7IgL1CO
 HeTOYqRZ0ODA5gNLzmCGdeJPHvEy8oWPSuZtesCjdPhshDAPwxO9F41d5e+GGDpZcICm
 olcVzEj3YANZ5ctqhtcRmWmY8rblWyDPU8lyWpbK0B1eyVHUiuIkYd9GtGVLA21sVp1e
 r57kg2MgePlwmlR2QSpddQ5LhQO2kxBQE7LTU93G2I//I3J+7WbRIdbI4nMOg5Dcaw65
 h2Ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769780212; x=1770385012; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1lqTgr1PmbOYfdThAq60Vdm4gMn9+jjWVTcFGFxogAA=;
 b=nFm4K0GPzMNGkdvaFYN7UI/59sPKS6FmDsW55FhQYOnWJopst1cIK8xA/P27W8josK
 nkV56mVMjn1nSSkJ2GgM1weuKrET3NFyBqguhyYTyQ8kyURa32dTBBNskAsgcqi0wS0M
 finAeTwgmz+sFO9we34tJ6XKO6Z11yMTRzheTmsRZ5YSKz/l37hdXj89y4rHlcZYLXba
 TLvqJTUltDrB5+Gqwc1vJRSpaDXHpqDmDPpVbsY1Tl1/3n2XVFgDFRozyVacXgkhk4jl
 Zci+laLAAtZ17YU6WGiwCYg0Jhq1+kfDXkjQ5I7BFrepMp8t8rrh7YWGSfmlNrh+0pmC
 s14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769780212; x=1770385012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lqTgr1PmbOYfdThAq60Vdm4gMn9+jjWVTcFGFxogAA=;
 b=I3YpWpDe7t8Zdvz4iHYbben0cv7O9hX0leYLvDFSTlbHL1dbS7f/tZVDu5j5Rgom//
 v+5m4EgzQYkyy78q8ogzXbQFpGB4C7RKdokqLHLT7UeLe2zodUlZGs0a8pmHpvJbShTc
 vxnsk/NXIpl/JUkjGBi+1944Rb/s/cQTF3pNqxsszQK/MsWzmz5d/6XTTT4GLMvq45ej
 B6ZC4aSyBe3cmfO9R/oJZmrPFrHPDCIRn+CAu/qF5/Rc652+I22G+PNt05ytEeZHdNIv
 vtf4NVru4SiqwuJKdyjPTHLzfTwPsBjcbHw5R5xtfy+/WAycq19B9r6yCSrIhdqse0Tw
 iiCg==
X-Gm-Message-State: AOJu0Yxw1kapp1mUcHRy7LQADTuijG1bt0RhezRd49Zae2f8sXjNwGhf
 hTkTdwHCivKVlyjTHQgkHpQb8R1aKHJZgwE1dBd3tVC1xJBil6lfDKp3DqoPYyqK0fWVsabs/Nl
 T9GLa5uE2NMMUg6yRQ64y9a0BQto0UHWNW1OkEL2+NXE7qFh1oveZ49ak7gHSzco+aEGMPFCz6j
 8Dqm8ErPtVhd9F1L29Jn4qxsI36JEDyOA=
X-Gm-Gg: AZuq6aJEPrDeYVw4vJlvQ+DAclhGsk1DuIthP6Ky+5qnDuH3lsCYXQ/gONzuzYZHoNJ
 xQf+rKrdV9MkzBHsLasIBReCpMqC1tcRFY9ygGtoLuA4T91bGQTxr1rpEQ3PNLG7ZIhj3UIxIne
 7FEl4jLiL5ZDb3/94uhd1m2XSUuEAjmGEc5mRGBanI0/4uPLl7oWV4L1/gJHngtm3ATx26ldYsA
 a3aC4fB24XeVGlkT8ogHcAgfoKNRTS1oIslaptxW9nNWY0XW/empeEinXKmaz1AWSJlYg==
X-Received: by 2002:a05:600c:a00e:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-482db481bffmr40330105e9.17.1769780212360; 
 Fri, 30 Jan 2026 05:36:52 -0800 (PST)
X-Received: by 2002:a05:600c:a00e:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-482db481bffmr40329595e9.17.1769780211817; Fri, 30 Jan 2026
 05:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <87ldhffe79.fsf@pond.sub.org>
In-Reply-To: <87ldhffe79.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 30 Jan 2026 14:36:40 +0100
X-Gm-Features: AZwV_QidetO5Y1VVXd7dCw5cO-QL6J3w1vjMSA2LvqTTC-wAdUnr3iG59keAPuk
Message-ID: <CABgObfYD6cLmN_qgmro-O2wUPqnqTn3ZUYntbPrFQkX0xE=8AQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] qobject: switch JSON parser to push
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000db349706499b10d4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000db349706499b10d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 30 gen 2026, 14:00 Markus Armbruster <armbru@redhat.com> ha scritto:

> > Another benefit is that QEMU can report the first parsing error
> > immediately, without waiting for delimiters to be balanced.
>
> Sounds promising!  Let's see...
>
> Before the series:
>
>      $ socat "READLINE,prompt=3DQMP> "
> UNIX-CONNECT:$HOME/work/images/test-qmp
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10},
> "package": "v10.2.0-567-gfb6b66de43-dirty"}, "capabilities": ["oob"]}}
>     QMP> [{"a"]
>
> Parse error not diagnosed right away, but ...
>
>     QMP> }
>     {"error": {"class": "GenericError", "desc": "JSON parse error, missin=
g
> : in object pair"}}
>
> .... only when the streamer decides the expression is complete.
>
> After the series:
>
>     QMP> [{"a"]
>     {"error": {"class": "GenericError", "desc": "JSON parse error at line
> 1, column 6, expecting ':'"}}
>
> Cool!  However, if I do it again, things fall apart:
>
>     QMP> [{"a"
>     QMP> }
>     QMP> }
>     QMP> }
>     QMP> ]
>     QMP> ]
>     {"error": {"class": "GenericError", "desc": "JSON parse error at line
> 7, column 1, expecting value"}}
>
> Parse error recovery not quite right?
>

Well, if you read the above very carefully :) the error is *reported*
immediately, but recovery still waits for delimiters to be balanced.

In testing, when I got an error I just typed a long enough variant on
"]}]}]}" and that is enough to recover=E2=80=94just like in the old parser.=
 Still
the difference in error reporting matters, because it gives feedback that
is immediately useful, rather than possibly delayed forever.

The policy is easy to change, either in v2 or in subsequent work, because
recovery is layered on top of json-parser and its code is nothing more than
"if you believe it's a good time to recover, reset the parser".

Paolo

> On top of the benefits intrinsic in the push architecture, it so happens
> > that it's really easy to add a location to JSON parsing errors now, so
> > do that as well.
> >
> > Paolo
>
>

--000000000000db349706499b10d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 30 gen 2026, 14:00 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
&gt; Another benefit is that QEMU can report the first parsing error<br>
&gt; immediately, without waiting for delimiters to be balanced.<br>
<br>
Sounds promising!=C2=A0 Let&#39;s see...<br>
<br>
Before the series:<br>
<br>
=C2=A0 =C2=A0 =C2=A0$ socat &quot;READLINE,prompt=3DQMP&gt; &quot; UNIX-CON=
NECT:$HOME/work/images/test-qmp <br>
=C2=A0 =C2=A0 {&quot;QMP&quot;: {&quot;version&quot;: {&quot;qemu&quot;: {&=
quot;micro&quot;: 50, &quot;minor&quot;: 2, &quot;major&quot;: 10}, &quot;p=
ackage&quot;: &quot;v10.2.0-567-gfb6b66de43-dirty&quot;}, &quot;capabilitie=
s&quot;: [&quot;oob&quot;]}}<br>
=C2=A0 =C2=A0 QMP&gt; [{&quot;a&quot;]<br>
<br>
Parse error not diagnosed right away, but ...<br>
<br>
=C2=A0 =C2=A0 QMP&gt; }<br>
=C2=A0 =C2=A0 {&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&qu=
ot;, &quot;desc&quot;: &quot;JSON parse error, missing : in object pair&quo=
t;}}<br>
<br>
.... only when the streamer decides the expression is complete.<br>
<br>
After the series:<br>
<br>
=C2=A0 =C2=A0 QMP&gt; [{&quot;a&quot;]<br>
=C2=A0 =C2=A0 {&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&qu=
ot;, &quot;desc&quot;: &quot;JSON parse error at line 1, column 6, expectin=
g &#39;:&#39;&quot;}}<br>
<br>
Cool!=C2=A0 However, if I do it again, things fall apart:<br>
<br>
=C2=A0 =C2=A0 QMP&gt; [{&quot;a&quot;<br>
=C2=A0 =C2=A0 QMP&gt; }<br>
=C2=A0 =C2=A0 QMP&gt; }<br>
=C2=A0 =C2=A0 QMP&gt; }<br>
=C2=A0 =C2=A0 QMP&gt; ]<br>
=C2=A0 =C2=A0 QMP&gt; ]<br>
=C2=A0 =C2=A0 {&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&qu=
ot;, &quot;desc&quot;: &quot;JSON parse error at line 7, column 1, expectin=
g value&quot;}}<br>
<br>
Parse error recovery not quite right?<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Well, if you read the above very care=
fully :) the error is *reported* immediately, but recovery still waits for =
delimiters to be balanced.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">In testing, when I got an error I just typed a long enough variant on &q=
uot;]}]}]}&quot; and that is enough to recover=E2=80=94just like in the old=
 parser. Still the difference in error reporting matters, because it gives =
feedback that is immediately useful, rather than possibly delayed forever.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div dir=3D"auto">The po=
licy is easy to change, either in v2 or in subsequent work, because recover=
y is layered on top of json-parser and its code is nothing more than &quot;=
if you believe it&#39;s a good time to recover, reset the parser&quot;.</di=
v><div dir=3D"auto"><br></div></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; On top of the benefits intrinsic in the push architecture, it so happe=
ns<br>
&gt; that it&#39;s really easy to add a location to JSON parsing errors now=
, so<br>
&gt; do that as well.<br>
&gt;<br>
&gt; Paolo<br>
<br>
</blockquote></div></div></div>

--000000000000db349706499b10d4--


