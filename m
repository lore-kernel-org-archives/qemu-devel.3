Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FCDC021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkUEf-0004Z2-B9; Tue, 18 Feb 2025 15:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkUEb-0004YV-6Z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkUEX-0004tc-Mk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739910619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjcaFs3P9y2rTI+as9MOd9bu+8o5FaW2DnorXb4G4CY=;
 b=IR2azarYLj1An1mYnfn9/CEnwG5AQUftInScYhArJQAq9Khi2m4UhWwPET1g6G8ttrTJ2u
 VU2LHuCAWKfFCQgeoXdB6OP5js4d4DG4e6ZEw9XYBQaPNzk5WdDl/ptbAts3KNy3F8JgSP
 d9sRYwS0l0v1LAqh/YkBGIHDHoakNDQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-Z4yvZwV7O1GxiChCCByM_g-1; Tue, 18 Feb 2025 15:30:18 -0500
X-MC-Unique: Z4yvZwV7O1GxiChCCByM_g-1
X-Mimecast-MFC-AGG-ID: Z4yvZwV7O1GxiChCCByM_g_1739910617
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22126a488d7so59336955ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 12:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739910617; x=1740515417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qjcaFs3P9y2rTI+as9MOd9bu+8o5FaW2DnorXb4G4CY=;
 b=pGrEzGg/x3CwlqffK6pBicxjoT3g0E1gWB2W4lNoTKtrCJtoUMdRhfnZ5EA3F7lon4
 9c4cgvTLu2bthzQs41xl2njWzCzlhOEwak1rq5ddlZgBe1/a58kghGQFDNTiPTRlhh+f
 6htcmONMeSK9DP6aNfHVyg89wdqG9NnSAv1g0f+JCqAgjhZ5uWDvQ1GfpL8A4CgtgTq4
 9KZk2cbd1Nd5daI8FkRHYwxSJL3h0IR0AwYog/hWM688T9V25BBGMgVtLv4LaLM0i2oo
 08NAqItE5PJk7AxrYicTdkzi1QKSFeZDbGGe9pwRSSnstoglOzYKuBrYzVcqz17VdilX
 yKUg==
X-Gm-Message-State: AOJu0YyoH+2aFIqrSzCTPz+OwqURbbvYOrg/6QlW65aeiGQW1adpjYQH
 470OnsgqZtyeEfFcN0kRXn7+RbDB6HznsCE1Zd68dpfPX92Bt/t0aO2ofyH71WddJpIa6+Xn3lm
 mnqfOHBCi6XCkYyPEHOf8TZy7Mgrp9RHrOJV4ugCollbEtx8dHn2WTv4Q/XbSEF0SSWobD1MJ48
 F3KLoTf+Ae66navgvdG1dYeg96z5Y=
X-Gm-Gg: ASbGncsEuauZmi0yGk9cI2JajKT9an+W5JGtZKJEur7AgsX9h7OXjDwE0dy0A5Rark9
 meeaiIiD1EoYRqTjRHMsjk2nvoRcTIiRhkPqrIk28Wg+rBwTiC3U+DHBFwpvSW321PLm60AnJOI
 IuL30ESUXVV3tA+Q1nRw==
X-Received: by 2002:a17:902:e850:b0:21f:90ae:bf83 with SMTP id
 d9443c01a7336-221040d75d2mr232506265ad.44.1739910616868; 
 Tue, 18 Feb 2025 12:30:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeny3QiJXWLSLHq0TbsWXJ6KIdFfZtYN+UlgeRjTE7hbquYOnRGOnvhlgkBS+m0xNS398LHHCGfH6DRCubn3w=
X-Received: by 2002:a17:902:e850:b0:21f:90ae:bf83 with SMTP id
 d9443c01a7336-221040d75d2mr232505555ad.44.1739910616425; Tue, 18 Feb 2025
 12:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-28-jsnow@redhat.com>
 <87frkkttl2.fsf@pond.sub.org>
In-Reply-To: <87frkkttl2.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Feb 2025 15:30:04 -0500
X-Gm-Features: AWEUYZkPpqrKZUC4y0Wq252TueZGPiuzZS0IohimNw85C9lM0Nkbqp04TloawbI
Message-ID: <CAFn=p-YTNKHC6Y1O0Q7s+VZPpE0WDTeyzL8tF8JRd3Acz7Z5ug@mail.gmail.com>
Subject: Re: [PATCH 27/42] qapi: differentiate "intro" and "detail" sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003bcf7c062e708244"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

--0000000000003bcf7c062e708244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:00=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch begins distinguishing "Plain" sections as being either
> > "Intro" or "Details" sections for the purpose of knowing when and where
> > to inline those sections.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index a8b30ae1a4b..b2f77ffdd7a 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
>
> [...]
>
> > @@ -584,14 +584,20 @@ def get_doc(self) -> 'QAPIDoc':
> >                      if text:
> >                          doc.append_line(text)
> >                      line =3D self.get_doc_indented(doc)
> > -                    no_more_args =3D True
> > +                    have_tagged =3D True
> >                  elif line.startswith('=3D'):
> >                      raise QAPIParseError(
> >                          self,
> >                          "unexpected '=3D' markup in definition
> documentation")
> >                  else:
> >                      # plain paragraph(s)
> > -                    doc.ensure_untagged_section(self.info)
> > +                    if have_tagged:
> > +                        no_more_tags =3D True
>
> @no_more_tags is not used in this patch.  Does the conditional
> assignment belong to the next patch?
>

Yep, oopsie. Refactor blunder.

--js

--0000000000003bcf7c062e708244
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 11,=
 2025 at 10:00=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@re=
dhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com=
" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch begins distinguishing &quot;Plain&quot; sections as being e=
ither<br>
&gt; &quot;Intro&quot; or &quot;Details&quot; sections for the purpose of k=
nowing when and where<br>
&gt; to inline those sections.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index a8b30ae1a4b..b2f77ffdd7a 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
<br>
[...]<br>
<br>
&gt; @@ -584,14 +584,20 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if text:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 doc.append_line(text)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 line =3D self.get_doc_indented(doc)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 no_more_args =3D True<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 have_tagged =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif lin=
e.startswith(&#39;=3D&#39;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 raise QAPIParseError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;unexpected &#39;=3D&#39; markup in definition do=
cumentation&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # plain paragraph(s)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 doc.ensure_untagged_section(<a href=3D"http://self.info" rel=3D"noreferrer=
" target=3D"_blank">self.info</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if have_tagged:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 no_more_tags =3D True<br>
<br>
@no_more_tags is not used in this patch.=C2=A0 Does the conditional<br>
assignment belong to the next patch?<br></blockquote><div><br></div><div>Ye=
p, oopsie. Refactor blunder.</div><div><br></div><div>--js</div></div></div=
>

--0000000000003bcf7c062e708244--


