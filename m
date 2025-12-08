Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8FBD3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVF0-0001qa-8z; Mon, 08 Dec 2025 02:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vSVEv-0001pT-T9
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 02:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vSVEr-0000c5-CH
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 02:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765177250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrSseIg2PUVp2z3SIzNtnYubbzb5a41taM+n0lwURsk=;
 b=S1dfO7km0kvfdko267wR6Ger8Hgldw8+wjdKEQ6evyzPG1qUhMzXODFVdyc7Ue5EhZQM2s
 183W//ZdY2DK/73PWRMM9pXU48SY11aoV9Cn5rXZkgDb7a0HTC+NhswCwTFybGJi2P1UiP
 Hi2ZHmFgSwhMZ7JS5vFtsFNKKDNEuk0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-nCt93sHRNCePhNuPerthJg-1; Mon, 08 Dec 2025 02:00:48 -0500
X-MC-Unique: nCt93sHRNCePhNuPerthJg-1
X-Mimecast-MFC-AGG-ID: nCt93sHRNCePhNuPerthJg_1765177247
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42e2e2ee360so2615175f8f.0
 for <qemu-devel@nongnu.org>; Sun, 07 Dec 2025 23:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765177247; x=1765782047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xrSseIg2PUVp2z3SIzNtnYubbzb5a41taM+n0lwURsk=;
 b=mOuwmVQmrDSLg98B08c+e823qLRxWnsg2Qyr2KaFWzXQ2Cc5aGWdP7DlVw3dVMIfnp
 jdf6MlufWvtEsoNhwIOANPhhihVOjv47ufMMpfocLUrV7dLC/1mTyzo3zLyC9uiWzokD
 cXB3gFeD4WW1mYvu/e0RolaEsA8zwarqBFgNDZdti6YoLkHw9U1ytjJy7vP8xSl08ncH
 bgp/q6ll1KM1peua2u/yNo6Sm7rQypAMWYQsCphX7bgs3H40uDztHZdVYtlbI0TUtlGa
 NH1aW3KeyL70uq/rE/VpQPRFG34a/vxGRnWbYbJvNKqvaQ3Db9ZOG+hiXqElbOGFMNU6
 zE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765177247; x=1765782047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrSseIg2PUVp2z3SIzNtnYubbzb5a41taM+n0lwURsk=;
 b=cX32XJAGs97zojOQ33jfXl7VsyiTGkeo0W9ws4zXRlm+SWCkUTbFFHMtNuSKm90USK
 eOVqnM0L+MK/SvS9kSdkpLmwEeLYlQu5AAwmBAC74w8o+757Ywv3co1yULk3H4xrpXFT
 fn2BHPuKEX1fuAUQItp4XR8BV0JtMxFByYweUGL3DjFQu9yerEJI+TP9FVgoMGt4P7zf
 8758lwvphWZ808BWFtKNB1dbxBiv7OyMcNEShtFDPNHosXP9H/x0jNE5EQ/bnwDokvRL
 caCd/zzsxpMinxsZVnHOeFvzuJLIYCTDWblGzwHohXsmow59MglvZLba8wWj7lJYGz+g
 LMVQ==
X-Gm-Message-State: AOJu0YzwSDEAnXqMfVTP+5UK9G3m69ENPCihrvssObgguCCGyv8JRC1I
 ZEsJMxld4TX0xVpf9pNBXkhkoc13YBYyAvsocVzN933HgjGR57qSahzxl/GNss6kIx1sR+WaRI3
 KoO9T2w5QTXktbtKhRzAlsB0qXkHSZNCQFDw57IFZZ0KtO3lfC5qs475xw45rMfNTTOwMcMqnYf
 tj+xFTMtVNUM1uy5RxkDu4pgzprPXehkg/9ZfqY4c=
X-Gm-Gg: ASbGncuhG7Eln3ra1DMU4n5jZ/stpZXx8xJj5dHpZX2HGYlZNmPREOhyRiixhzScpaO
 OdEIK9JCJrnqaCwocPYlEfeeMA8menzPwfhEt3mO95Tmiox/SUI4r4JknwcdjHXDNmeNaAgKOKs
 wt7OCAfbfTyzDAHimjTsD7lMjiX6PRRCJFQZ8AVMRb5rC2gFhmfMm6yPqf2eXzsmwIO2/3Gmvav
 0tFef/UI8+joY/Vr9poJzDBAHWRosBOXovXiFtV5N1+jJR//4REDd74sE4NbtrjDI/g
X-Received: by 2002:a05:6000:40dc:b0:42b:3131:5436 with SMTP id
 ffacd0b85a97d-42f89f286e6mr6096960f8f.16.1765177246748; 
 Sun, 07 Dec 2025 23:00:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw2/O3pvmKs/0J13yxjzd86YmN7D8XEmQtpx8Yxe0vecrcMHMUoHEGrkMDfHdIQf2iXYv+87jnLZlWqNnh6iY=
X-Received: by 2002:a05:6000:40dc:b0:42b:3131:5436 with SMTP id
 ffacd0b85a97d-42f89f286e6mr6096930f8f.16.1765177246339; Sun, 07 Dec 2025
 23:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-12-pbonzini@redhat.com>
 <875xal5jnv.fsf@pond.sub.org>
 <21a2d5fb-0181-4ce8-8bea-a214c8eac2d7@redhat.com>
 <87cy4t3yzc.fsf@pond.sub.org>
In-Reply-To: <87cy4t3yzc.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Dec 2025 08:00:00 +0100
X-Gm-Features: AQt7F2pC_gg5WUJDdanL6NnpwahLwLLkbGhshqKuKGFfhVe0607VDMGYgBEpTvw
Message-ID: <CABgObfYJiBZC6jx9wQGCubC8J6Gu0Hn9q+Zo_Dm1J8PcRJDNNw@mail.gmail.com>
Subject: Re: [PATCH 11/19] rust/qobject: add from/to JSON bindings for QObject
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000bbea3006456b5a40"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000bbea3006456b5a40
Content-Type: text/plain; charset="UTF-8"

Il ven 5 dic 2025, 13:16 Markus Armbruster <armbru@redhat.com> ha scritto:

> > Note however that there is no support for push parsing, therefore this
> > would not replace the balanced-parentheses machinery in
> > qobject/json-streamer.c, and therefore QMP would still need a minimal
> lexer.
>
> That push parser...  I never liked it.  First, it's half-assed: it's a
> push lexer wed to a pull parser with parenthesis counting.  Second, why
> complicated & half-assed when you can do simple & quarter-assed instead?
> We could've required "exactly one complete JSON value per line", or some
> expression separator such as an empty line.
>

Hmm not sure I agree, actually I think I disagree. It seems simpler but it
is also different.

Push parsing is not rocket science. It would be easy to write a proper one,
it's just that there is no real reason other than cleanliness.

> Grr... I just remembered about interpolation :/ so no, we still need a
> > parser for libqmp.c.
>
> Right.
>
> Interpolation lets us build QObjects from literal templates with
> variable scalars or QObjects interpolated.  More concise and much easier
> to read than the equivalend nest of constructor calls.  Drawback: chains
> us to our own, bespoke JSON parser.
>

And also, for similar reasons of practicality, single quotes (which IIRC
also became valid QMP, and that's less excusable).

But while it's a pity, we still get a lot from serde, namely making the
automatic generation of visitor code for structs someone else's problem.

Out of curiosity: how would we do better than "nest of constructor
> calls" in Rust?
>

You'd do that with a quoting macro, i.e.

qobject!({"command": cmd})

where the macro compiles to the nest of constructor calls, like
QObject::from_iter([(c"command", to_qobject(cmd))]).

Paolo

>

--000000000000bbea3006456b5a40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 5 dic 2025, 13:16 Markus =
Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&=
gt; Note however that there is no support for push parsing, therefore this =
<br>
&gt; would not replace the balanced-parentheses machinery in <br>
&gt; qobject/json-streamer.c, and therefore QMP would still need a minimal =
lexer.<br>
<br>
That push parser...=C2=A0 I never liked it.=C2=A0 First, it&#39;s half-asse=
d: it&#39;s a<br>
push lexer wed to a pull parser with parenthesis counting.=C2=A0 Second, wh=
y<br>
complicated &amp; half-assed when you can do simple &amp; quarter-assed ins=
tead?<br>
We could&#39;ve required &quot;exactly one complete JSON value per line&quo=
t;, or some<br>
expression separator such as an empty line.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Hmm not sure I agree, actually I=
 think I disagree. It seems simpler but it is also different.=C2=A0</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Push parsing is not rocket scie=
nce. It would be easy to write a proper one, it&#39;s just that there is no=
 real reason other than cleanliness.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">&gt; Grr... I just remembered about in=
terpolation :/ so no, we still need a <br>
&gt; parser for libqmp.c.<br>
<br>
Right.<br>
<br>
Interpolation lets us build QObjects from literal templates with<br>
variable scalars or QObjects interpolated.=C2=A0 More concise and much easi=
er<br>
to read than the equivalend nest of constructor calls.=C2=A0 Drawback: chai=
ns<br>
us to our own, bespoke JSON parser.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">And also, for similar reasons of practic=
ality, single quotes (which IIRC also became valid QMP, and that&#39;s less=
 excusable).</div><div dir=3D"auto"><br></div><div dir=3D"auto">But while i=
t&#39;s a pity, we still get a lot from serde, namely making the automatic =
generation of visitor code for structs someone else&#39;s problem.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Out of curiosity: how would we do better than &quot;nest of constructor<br>
calls&quot; in Rust?<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">You&#39;d do that with a quoting macro, i.e.=C2=A0</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">qobject!({&quot;command&quot=
;: cmd})</div><div dir=3D"auto"><br></div><div dir=3D"auto">where the macro=
 compiles to the nest of constructor calls, like QObject::from_iter([(c&quo=
t;command&quot;, to_qobject(cmd))]).</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Paolo</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--000000000000bbea3006456b5a40--


