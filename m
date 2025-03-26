Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AB9C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 20:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txX70-0003WY-8Z; Wed, 26 Mar 2025 16:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txX6v-0003W6-1B
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 16:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txX6s-0001wB-Ui
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 16:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743019941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7ggLutzIxFrsNcyu+MhNLd8yVQvqhnKVLpfhrmbTjE=;
 b=ZP2n1H2+zNJmjlOt82WsHnoqhE0Uc3KlX6YxsZRVRC3fvhTmInF470i+LyNRvT1lmpAgqH
 BLhaF+JnjuhFgVe5UY441mycwpxM06kP9nxdgn0IFEbckbZF6pl17t/oI0u3v+MeVgEfnb
 0wX0p3ChL6m4aVhKaWGmUwh8dF7qwvg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-taOkONiWMLKJ5P7a3y6TAw-1; Wed, 26 Mar 2025 16:12:18 -0400
X-MC-Unique: taOkONiWMLKJ5P7a3y6TAw-1
X-Mimecast-MFC-AGG-ID: taOkONiWMLKJ5P7a3y6TAw_1743019938
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff8340d547so291348a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 13:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743019937; x=1743624737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7ggLutzIxFrsNcyu+MhNLd8yVQvqhnKVLpfhrmbTjE=;
 b=XyJF7Od2hM9iAVdTnHXVwjVtTAMkMi1deaavu0sjKrxXe6dnJoF9OcSMFpLRB6j8Lm
 EKZszZBrfPVG/zvteAif4aCUPljC9g036dD7/tbT9lIWTj/Bj9KY767JQXQPnd4Xabhj
 q8/7CA8ErEGdiPp30IG5m2pQqUT6NqiE3uP8CBleUijcPCoc+SaHdirrac78NCsIQ2dV
 atGS7j6eC7mGDWKDwJssbWc0pS4HNLQ4QI37OlFcDlPSNiyEjENacbjrN+otWedC19Ca
 wfWgSb/1mp9rAj7nLTk+YYYDc/tBx8sOgdQao1ywy94mYBC9Iylz8F9TBu26X7BfoXQs
 eGgg==
X-Gm-Message-State: AOJu0Yw2uFKK1ksOWbXKOF6AfIeV8YQJxIj9wQJCfy2SozoDkY0oonAn
 ZxX0RCQoGIcvZz2vWHBmV//7nXNbG2bIAe51Mbs+Oqbt2gXv3ZPjShJ7Ok8Tn/mqw+BM8taQboM
 ie7+4JaXFjdeLrj1267TGaXq6POMWHPVh4Q7Tl1RuRaHLm0yIBGx8t2k2vhL/f8sn/S+KLndscQ
 RCaqXgH1yHpQuN0+YCvYW6q5RGVpc=
X-Gm-Gg: ASbGncuEE7eiqK/R0Tv4Ao7fghYSgpoq/CrRQkWHaqxuSaVBROqiyU71rn+fQRMQdQo
 dkQkb9pkD7TFvAmVz8m31QdzxJoVqGXp/ytWQw5WWeaIyl31AXj1Kt8ABoC53NZs2WtE0z8UGaA
 9R2U1Qho38jvaZcSBJbhhwp0E6HRBu
X-Received: by 2002:a17:90b:2645:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-303a815d2ccmr1826475a91.16.1743019937686; 
 Wed, 26 Mar 2025 13:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz7zBUDlE8ZdK7/k77bzZGouDqMuxZYGa7wshUI1Qa6WV1Rm4DuhDGHPt9x2pAutHWYfAdFg3kgeieS7S/rgs=
X-Received: by 2002:a17:90b:2645:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-303a815d2ccmr1826427a91.16.1743019937271; Wed, 26 Mar 2025
 13:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-4-jsnow@redhat.com>
 <87a598fhnp.fsf@pond.sub.org>
In-Reply-To: <87a598fhnp.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Mar 2025 16:12:04 -0400
X-Gm-Features: AQ5f1JrH3HB9jm21Bnt4gplYii6SK5JSSGTj6qvnEY6wznDtQF42_zHkoF4PrCk
Message-ID: <CAFn=p-aixsXRdE86tDS9kBd4azBQ7KU-h-utNkCndykbORAZ8w@mail.gmail.com>
Subject: Re: [PATCH 3/5] python: update missing dependencies from minreqs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000032ac070631447413"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000032ac070631447413
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 2:08=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > A few transitive dependencies were left floating; as a result, pip's
> > dependency solver can pull in newer dependencies, which we don't
> > want. Pin them down.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> What problem exactly does this fix?  Make target check-minreqs?
>

I'm not sure it's a "problem" as such, but an inconsistency. Yes, it's with
check-minreqs -- without this patch, pip is free to choose newer versions
of these dependencies as appropriate. Though unlikely at this point, in
theory, new dependency updates could be selected by pip and invalidate the
concept of an entirely fixed/pinned virtual environment.

That these transitive dependencies were not frozen initially was an
oversight.

check-minreqs is supposed to build the exact same venv every time without
fail. Without this change, it's *possible* that it might do something
different on release day if someone releases a new package. No good,
probably.


>
> > ---
> >  python/tests/minreqs.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> > index a3f423efd84..19c0f5e4c50 100644
> > --- a/python/tests/minreqs.txt
> > +++ b/python/tests/minreqs.txt
> > @@ -38,10 +38,14 @@ pyflakes=3D=3D2.5.0
> >
> >  # Transitive mypy dependencies
> >  mypy-extensions=3D=3D1.0.0
> > +tomli=3D=3D1.1.0
> >  typing-extensions=3D=3D4.7.1
> >
> >  # Transitive pylint dependencies
> >  astroid=3D=3D2.15.4
> > +dill=3D=3D0.2
> >  lazy-object-proxy=3D=3D1.4.0
> > +platformdirs=3D=3D2.2.0
> >  toml=3D=3D0.10.0
> > +tomlkit=3D=3D0.10.1
> >  wrapt=3D=3D1.14.0
>
>

--00000000000032ac070631447413
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 26,=
 2025 at 2:08=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; A few transitive dependencies were left floating; as a result, pip&#39=
;s<br>
&gt; dependency solver can pull in newer dependencies, which we don&#39;t<b=
r>
&gt; want. Pin them down.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
What problem exactly does this fix?=C2=A0 Make target check-minreqs?<br></b=
lockquote><div><br></div><div>I&#39;m not sure it&#39;s a &quot;problem&quo=
t; as such, but an inconsistency. Yes, it&#39;s with check-minreqs -- witho=
ut this patch, pip is free to choose newer versions of these dependencies a=
s appropriate. Though unlikely at this point, in theory, new dependency upd=
ates could be selected by pip and invalidate the concept of an entirely fix=
ed/pinned virtual environment.</div><div><br></div><div>That these transiti=
ve dependencies were not frozen initially was an oversight.</div><div><br><=
/div><div>check-minreqs is supposed to build the exact same venv every time=
 without fail. Without this change, it&#39;s *possible* that it might do so=
mething different on release day if someone releases a new package. No good=
, probably.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 python/tests/minreqs.txt | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt<br>
&gt; index a3f423efd84..19c0f5e4c50 100644<br>
&gt; --- a/python/tests/minreqs.txt<br>
&gt; +++ b/python/tests/minreqs.txt<br>
&gt; @@ -38,10 +38,14 @@ pyflakes=3D=3D2.5.0<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Transitive mypy dependencies<br>
&gt;=C2=A0 mypy-extensions=3D=3D1.0.0<br>
&gt; +tomli=3D=3D1.1.0<br>
&gt;=C2=A0 typing-extensions=3D=3D4.7.1<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Transitive pylint dependencies<br>
&gt;=C2=A0 astroid=3D=3D2.15.4<br>
&gt; +dill=3D=3D0.2<br>
&gt;=C2=A0 lazy-object-proxy=3D=3D1.4.0<br>
&gt; +platformdirs=3D=3D2.2.0<br>
&gt;=C2=A0 toml=3D=3D0.10.0<br>
&gt; +tomlkit=3D=3D0.10.1<br>
&gt;=C2=A0 wrapt=3D=3D1.14.0<br>
<br>
</blockquote></div></div>

--00000000000032ac070631447413--


