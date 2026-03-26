Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B191010A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5oFI-0007l9-FD; Thu, 26 Mar 2026 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5oFF-0007kB-DI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5oFD-00007l-Tu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774545103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g9zSMpp1TxPFsniTk/jIjdbcgZgtOEbBNexJCPpqW7Y=;
 b=QpNXn1c/CmWWYyDKl1WHppothQosC0XHHj5OJx5A3c1qt2pFZ5lkw8SUO7yw7vRcPFOVWD
 sa79QSialPrs0Pf/bzJ2g6ubR14Jp9xnh3VdRDq/+r8Q8pgSqefS4n7DfaSnfFPUdxTmMd
 6DlUWL3F5QujKi9gvCAdHNHozAoQBT0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-RXWVYxrVP8y72-BDL9ceHg-1; Thu, 26 Mar 2026 13:11:41 -0400
X-MC-Unique: RXWVYxrVP8y72-BDL9ceHg-1
X-Mimecast-MFC-AGG-ID: RXWVYxrVP8y72-BDL9ceHg_1774545101
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-899f671ceb2so33520916d6.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 10:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774545101; cv=none;
 d=google.com; s=arc-20240605;
 b=Yg/bF695563QK1Q8ZeOjQAUR1B8+xVNUzjDL4Cfz4eXX45+r5gCho0Ld5RXw0do9sK
 TSm02DuGWyORDfcwelgPREEskRXllneRWGKZwk1oZgwPgCmQE3xS5NOMz/Q6BmGuCZDi
 6m+8rQ+J0xkAU2brrnnEGiy9ubB0KDyK4X0/amwfBuvao6j7u7+4Kxb38nAlWDslCRa0
 HLmBriTIpeZ6xrAlSMR3Defe7kEKDsizr6aIVELGWvT4C/p0TlbmcS4ArLxZg1CWYhE/
 4xXvoPyr5KacYNg0lU4PH3/JRon60gQGTKp4HqRkqdUb+JmqdfaPAYdXRJsZUBnFuuzw
 27HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g9zSMpp1TxPFsniTk/jIjdbcgZgtOEbBNexJCPpqW7Y=;
 fh=MzL6WcXKpEpqLDgwHTYAdozkNrS3UwPO0t8Yo7HIV70=;
 b=LdEyz4rrAav2AHx5VTrReLpHFYVezD4PUwk/5M1ql6SbEenlvyjzTMN9M5tHCvmR++
 2qseWCWsrSge1QwoI/A00M07B1b6PaNaVrGk7x/ayvgUfrDtkChzxiWAoSymnum5rew2
 OpBhB5ot9q0MaU8rq3pCl9ig1p8OzOvc3LPx6nFAwxmABRVDWo8F2X6nCt2l8EQ/lAeF
 yn/X7aWlT2Rim7AHcf45pGMa61TXcCDtUmZnwLnKiFFATnSJmA8UN0aH7vmDTI3ahMCg
 TQO5OZNgcPd0OISnALxctrE+k6mec1hH+57f/uJLGgL+OWYC+a96ozZ3k7WmCiesCogx
 bBlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774545101; x=1775149901; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g9zSMpp1TxPFsniTk/jIjdbcgZgtOEbBNexJCPpqW7Y=;
 b=S1k8xn11mGahkIhxV9gYZagzRNB/HhKG3Df+nQNfkRijIMWkjlInTlqZrh3wqhcxTi
 qdjyFwA85Ade2KuQdHUf5nKP65UV5CPlFauKVDvKljGOweROEiaZXfRkaNOTzE94GlN4
 GKduX2q3l82nz6tLwV8Shco3IXY2/A5NOGbnqYrzdzwLKC7tyggn+cymQU6V05K0iE7t
 y7XUgiIEfwgwFMN871khUOb87RthWnjpsqwUGL8AdEkegiiotnftedXZOBvuaNUQH6YM
 YMVLPpL8fn/0kqK879TJeIOmQWNXDjAeuAKXLDBHbIGNx76aBLYpBAMddUEi9YOJVJeX
 6Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774545101; x=1775149901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9zSMpp1TxPFsniTk/jIjdbcgZgtOEbBNexJCPpqW7Y=;
 b=o7jUFRW0KfqYWHxzQxWpexeSQh8wAp7WZOGfaOH8FvtFxzg33/0AJxgeglNErRo10z
 sOvk+G6LjsdgKDaGdhUrxoRr7w2M46g7zt9BSH9vCJSJ4tosAuHQB/Irkj8PNLazqU2Y
 m8gxdukEX4sShMWWbUcZtPFSf290b2UnWV2PaLkInzP7QDygaeZIH30L7w/StDBdkduW
 pdxO5ooPydfnu87vX14QUJcJ9hpz8NrAVH+vv22Ngs/Whd69OFHyZ/cmk1x0FGai7xHX
 ol/yRoYZAb0GRCesJ4Oe8Dzb93sh1y6kUl9q3dRChhNN9T4pwGYejXlFlmNy7/zoy+yX
 YJlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB4GxuH9pN2QsupdqQTOx+IdHdk3YnZt54xx1EsYx3lcE8r6fzLsuaqXfGmfl51XoLXWSNGT+UhLN6@nongnu.org
X-Gm-Message-State: AOJu0Ywh9ifo06Za458KCYg3QsAVi8Yi7wKLc61z8GqeQiPypUcmTuzp
 XaAtpHyuotyiKghDj0IVpk6fQ4vJsXOPOPLWsZWn0ecJAUjykzbySHPP7hf03gbKKz7FQ3Hd9Rt
 5oxS+biDLXg11CqV0WHEKrJg5id1oL0NUBzStvzd5qgcPVHc3rdelisJdCgJSXg2sJqsjCWpI6n
 n24WquLqvovoTAYR14Jimb6qf/dXMpGCA=
X-Gm-Gg: ATEYQzz+TCX0c2/4QqSywTxrczPdzGGejxKv2mQ73/G8fC8EnMQVlB5r/DUB4reU/1s
 70ZGuf6BDPAlXTVbCZRxJ3mylrbaB7NgEndn6hbGhLEmVsG/8KzgrWzTH+hjiAULuCxEIMklFgq
 S2vvfvE5RqUq7APcT572WKIVcx6c3VXkwegIg+YXovSXMRJy/A4KDXqdhQYKhdBUII//YBSyuep
 A/+z3y6
X-Received: by 2002:a05:6214:1311:b0:899:ed40:464d with SMTP id
 6a1803df08f44-89cc4a8ec76mr137167626d6.29.1774545100592; 
 Thu, 26 Mar 2026 10:11:40 -0700 (PDT)
X-Received: by 2002:a05:6214:1311:b0:899:ed40:464d with SMTP id
 6a1803df08f44-89cc4a8ec76mr137167146d6.29.1774545100127; Thu, 26 Mar 2026
 10:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
 <CAPMcbCoPfE+c1851esnnWRgxFcgm1CRr9CGtOmBNWphX5kt1tA@mail.gmail.com>
 <09297e78-b1bd-4281-919d-99de0a5a33ab@linaro.org>
In-Reply-To: <09297e78-b1bd-4281-919d-99de0a5a33ab@linaro.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Mar 2026 19:11:28 +0200
X-Gm-Features: AQROBzDd_lKxziKJ3sgChSs5jfOR_lVVLr8yaTcmM53IFaIoVr7tjlZ-A_-W8vE
Message-ID: <CAPMcbCrwv-Q=iP04iYHi5QTfE9RjWjJwEnLmH-9W2vghfOHEpw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000054d406064df07a6d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000054d406064df07a6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 6:48=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 3/26/26 9:43 AM, Kostiantyn Kostiuk wrote:
> >
> >
> >
> > On Thu, Mar 26, 2026 at 6:35=E2=80=AFPM Mohamed Mediouni
> > <mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>> wrote:
> >
> >
> >      > On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk
> >     <kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>> wrote:
> >      >
> >      > This is the first set of changes to allow building qemu-ga with
> >     Microsoft Windows Clang.
> >      > It includes some cleanups and fixes that also make the code more
> >     portable.
> >      > The main goal is to be able to build qemu-ga with the MSVC
> toolchain
> >      > because MinGW-w64 is not available for ARM64 Windows.
> >      >
> >     Hello,
> >
> >     MinGW-w64 is available for arm64 Windows, although it=E2=80=99s mor=
e
> >
> >     mature with Clang as a compiler instead of of MSVC.
> >
> >
> > I expect to use clang from the MSVC environment, not the MSVC compiler
> >
>
> Is the difference that this clang does not come with mingw preinstalled,
> and thus require using msvc headers/libraries instead?
>

Yes, the difference is that MSVC Clang comes with MSVC headers/libraries,
not a Linux/MinGW one


>
> In all cases, it's just better to use msys2 environment. What is your
> limitation with it?
>

This requires additional maintenance of the MSYS2 environment.
Also, MSYS2 is a rolling release distribution, while we definitely
need to know the version of dependencies and control them.


>
> >
> >     Is it more of a packaging issue with distributions?
> >
> >     Thank you,
> >     -Mohamed
> >
> >
>
>

--00000000000054d406064df07a6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 26, 2026=
 at 6:48=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier=
@linaro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 3/26/26 9:43 A=
M, Kostiantyn Kostiuk wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Thu, Mar 26, 2026 at 6:35=E2=80=AFPM Mohamed Mediouni <br>
&gt; &lt;<a href=3D"mailto:mohamed@unpredictable.fr" target=3D"_blank">moha=
med@unpredictable.fr</a> &lt;mailto:<a href=3D"mailto:mohamed@unpredictable=
.fr" target=3D"_blank">mohamed@unpredictable.fr</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:kkostiuk@redhat.com" target=
=3D"_blank">kkostiuk@redhat.com</a> &lt;mailto:<a href=3D"mailto:kkostiuk@r=
edhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This is the first set of changes to allow bui=
lding qemu-ga with<br>
&gt;=C2=A0 =C2=A0 =C2=A0Microsoft Windows Clang.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; It includes some cleanups and fixes that also=
 make the code more<br>
&gt;=C2=A0 =C2=A0 =C2=A0portable.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The main goal is to be able to build qemu-ga =
with the MSVC toolchain<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; because MinGW-w64 is not available for ARM64 =
Windows.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hello,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0MinGW-w64 is available for arm64 Windows, although =
it=E2=80=99s more <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0mature with Clang as a compiler instead of of MSVC.=
<br>
&gt; <br>
&gt; <br>
&gt; I expect to use clang from the MSVC environment, not the MSVC compiler=
<br>
&gt;<br>
<br>
Is the difference that this clang does not come with mingw preinstalled, <b=
r>
and thus require using msvc headers/libraries instead?<br></blockquote><div=
><br></div><div>Yes, the difference is that MSVC Clang comes with MSVC head=
ers/libraries, not a Linux/MinGW one</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
In all cases, it&#39;s just better to use msys2 environment. What is your <=
br>
limitation with it?<br></blockquote><div><br></div><div>This requires addit=
ional maintenance of the MSYS2 environment.</div>Also, MSYS2 is a rolling r=
elease distribution, while we definitely</div><div class=3D"gmail_quote">ne=
ed to know the version of dependencies and control them.<div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Is it more of a packaging issue with distributions?=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thank you,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-Mohamed<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>
</div>

--00000000000054d406064df07a6d--


