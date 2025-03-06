Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B63FC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 03:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq1gw-0004aP-Lb; Wed, 05 Mar 2025 22:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tq1gn-0004Zz-G0
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 22:14:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tq1gl-0000b5-9L
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 22:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741230860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ud+Yls8jr3a5df6/+OI5c9NMsJ25duooX1HidscoT5c=;
 b=TWRAI09wM5d96ow3691B+L6PspdsGvP247OfNAmQliIxeV+vTDOykkCWFTLg4owWDKRToC
 Dz6FdTgLtAvYbqbEtynNDFUl7G2OBOeMnM3EsvGg3vByhWeAy7xxKwuPxAbLmU3lVIuO9g
 8Ol+KdqXvga9JkiXgmmu3CMMsA5kysQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-CSGlJNy-MsuMMq1H3G7zrQ-1; Wed, 05 Mar 2025 22:14:07 -0500
X-MC-Unique: CSGlJNy-MsuMMq1H3G7zrQ-1
X-Mimecast-MFC-AGG-ID: CSGlJNy-MsuMMq1H3G7zrQ_1741230847
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fe870bc003so476954a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 19:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230846; x=1741835646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ud+Yls8jr3a5df6/+OI5c9NMsJ25duooX1HidscoT5c=;
 b=LY6lA83/MQfPj7q7DkLUK35Gmm/sHKDz/DPlwbfiVSIIt9/qk5OfMwiKru3S7lrGUd
 /BRRAildjRSTOW7F2fISWVThcxl3h8O518/bZwqAPJ36W/QjHqj9yi0+/KTta8tt3T1e
 uWgaiPCgZ3mbFqR1nL/HwAMf5DrY9sEP9LjFTKtQ11a7y95/Il9U0IZbi6kE/9wP6gVA
 1r2AuubGzUkmEjxH+TjkN3TX+TVtdY7jOr8DEnkILxjMGQ2tvPFhwuOECv8EB3ToCsp9
 1VuvJptxJDW9BKkYWbSzFNlmm6AnoYFQ7MdhvzPmKqy3UeR3p5CE/Hg2XbIWlgueLxpa
 aChw==
X-Gm-Message-State: AOJu0YwTDdr86xjnii8YLexikYe0Wuv4/8Xo5WkyEmvDi5zod/svFv/+
 VWF1Nkn31OXo9nCB9DruzI8DowR/wqgFCbk3qepwMubDpbteFs8Mil9Xm/Iq7GcXdcQuwWDPR1n
 GipBWW4h6TxOhK82upFJyBhEcyDGM0LRYjrt0ppX6Cc/T3dSM/9Krb2zyOu3qCsxhtKHp19p/YS
 utKx9ybrWLkABWFClJReDDMhOo4nA=
X-Gm-Gg: ASbGnctkSlzmEdBBqm9HBbLZ2h3gNiIu/8KXapiEQ9I6+oer5aV4pga2siGz7ytp9rs
 4yt3riMLxnU8ODq8B42QhmdMfRuSMDYVxrJy+ru182jiOHcvZJG59V0Af5/BtJVdzZefg34gsPm
 NxePjcjfIWgedsuYGcXXHZ2YBAi+u3
X-Received: by 2002:a17:90b:3142:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-2ff617d8269mr2809865a91.11.1741230846617; 
 Wed, 05 Mar 2025 19:14:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrFcKPKROqrhP1e9nQNAu3U1dH8LhjWocXlRLW6RSLDnjBmOdScuXMpufMBhGijBSP0qCmwUwfcLlP2LMTU4c=
X-Received: by 2002:a17:90b:3142:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-2ff617d8269mr2809842a91.11.1741230846345; Wed, 05 Mar 2025
 19:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-40-jsnow@redhat.com>
 <871pvbojdc.fsf@pond.sub.org>
In-Reply-To: <871pvbojdc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 5 Mar 2025 22:13:53 -0500
X-Gm-Features: AQ5f1JovAyvQFZkKcxpsYhS3WET5Mel6BHtGY85WSq3GkVIUr4CtOgP_nFFGu0E
Message-ID: <CAFn=p-ZngFzWDyKgkKzxs1Uv_rnn2RVtVeFMJUb_BkFCDCe1Rw@mail.gmail.com>
Subject: Re: [PATCH 39/57] qapi/source: allow multi-line QAPISourceInfo
 advancing
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000119cef062fa3e643"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000119cef062fa3e643
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:35=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This is for the sake of the new rST generator (the "transmogrifier") so
> > we can advance multiple lines on occasion while keeping the
> > generated<-->source mappings accurate.
> >
> > next_line now simply takes an optional n parameter which chooses the
> > number of lines to advance.
> >
> > RFC: Here's the exorbitant detail on why I want this:
> >
> > This is used mainly when converting section syntax in free-form
> > documentation to more traditional rST section header syntax, which
> > does not always line up 1:1 for line counts.
>
> Obvious way to resolve the RFC:
>
>   The next patch will use this when converting ...
>
> >
> > For example:
> >
> > ```
> >  ##
> >  # =3D Section     <-- Info is pointing here, "L1"
> >  #
> >  # Lorem Ipsum
> >  ##
> > ```
> >
> > would be transformed to rST as:
> >
> > ```
> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
> > Section        <-- L1
> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
> >                <-- L2
> > Lorem Ipsum    <-- L3
> > ```
>
> Not a demand, just wondering: could we drop our headings syntax and just
> use rST?
>

Yes, once we drop the old qapidoc fully, which I am not sure I can do
before freeze ... So we have some goofy stuff in the meantime.
You suggested before I can rewrite the freeform generator to avoid needing
this; I wrote the freeform generator to be as close to the old one as I
could, but we could kerjiggle it if needed.

... On the other hand, this is a patch for a +=3D n, so... eh.

--js

--000000000000119cef062fa3e643
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, =
2025 at 5:35=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This is for the sake of the new rST generator (the &quot;transmogrifie=
r&quot;) so<br>
&gt; we can advance multiple lines on occasion while keeping the<br>
&gt; generated&lt;--&gt;source mappings accurate.<br>
&gt;<br>
&gt; next_line now simply takes an optional n parameter which chooses the<b=
r>
&gt; number of lines to advance.<br>
&gt;<br>
&gt; RFC: Here&#39;s the exorbitant detail on why I want this:<br>
&gt;<br>
&gt; This is used mainly when converting section syntax in free-form<br>
&gt; documentation to more traditional rST section header syntax, which<br>
&gt; does not always line up 1:1 for line counts.<br>
<br>
Obvious way to resolve the RFC:<br>
<br>
=C2=A0 The next patch will use this when converting ...<br>
<br>
&gt;<br>
&gt; For example:<br>
&gt;<br>
&gt; ```<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # =3D Section=C2=A0 =C2=A0 =C2=A0&lt;-- Info is pointing here, &=
quot;L1&quot;<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Lorem Ipsum<br>
&gt;=C2=A0 ##<br>
&gt; ```<br>
&gt;<br>
&gt; would be transformed to rST as:<br>
&gt;<br>
&gt; ```<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br>
&gt; Section=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L2<br>
&gt; Lorem Ipsum=C2=A0 =C2=A0 &lt;-- L3<br>
&gt; ```<br>
<br>
Not a demand, just wondering: could we drop our headings syntax and just<br=
>
use rST?<br></blockquote><div><br></div><div>Yes, once we drop the old qapi=
doc fully, which I am not sure I can do before freeze ... So we have some g=
oofy stuff in the meantime.</div><div>You suggested before I can rewrite th=
e freeform generator to avoid needing this; I wrote the freeform generator =
to be as close to the old one as I could, but we could kerjiggle it if need=
ed.</div><div><br></div><div>... On the other hand, this is a patch for a +=
=3D n, so... eh.</div><div><br></div><div>--js</div></div></div>

--000000000000119cef062fa3e643--


