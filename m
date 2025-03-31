Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BD1C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzK3U-0000aI-NL; Mon, 31 Mar 2025 14:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tzK3T-0000ZG-4X
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tzK3R-0000sn-BS
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743446411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOzQ+dug8cwogjx8AM1rEA89s3R5k3XSOXWZVZxBoow=;
 b=XI4bnYXegsIYBUadMt/G3JdWqlAIJHiGsD5uihlkp2s6aDuUoo4SE7V82fMcL3zw0mb9Ni
 sjP+zhMyU77YYG9gwrtJcWUMr/NguX/YEclIylvOao3qryGaWtl4ZK93y+ma/VbrnVPgJR
 G4kLFYeMQQkGPWnCLSefINIvRBO4Sss=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-lpf-LjmqMzK00kzxwnNAZA-1; Mon, 31 Mar 2025 14:40:07 -0400
X-MC-Unique: lpf-LjmqMzK00kzxwnNAZA-1
X-Mimecast-MFC-AGG-ID: lpf-LjmqMzK00kzxwnNAZA_1743446407
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3011bee1751so7878471a91.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743446407; x=1744051207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOzQ+dug8cwogjx8AM1rEA89s3R5k3XSOXWZVZxBoow=;
 b=Pp7kychSvzM2u1R/5GEJ0Vk4Ykqt15iIlNhrUYIHOiezd0qbFTD5pkS95faRUI3ReW
 HEFnmdGG1HmnCgHlCZanOR2l2gTUOajVuIgrDyOSq56b/xD1+VAdKwnNwB7Vh3gvEu3e
 VXaCPsHzBmZpfd1AnwDRhKEjLtpGRLAFMBPgLKbNTlS2ezo3S+BbNFSHJEO+p/dW5/zW
 fzseX98iv7vlzml9OsQD8psbaTrhQrT1kVvzlvodOq9VoYYbpYPCTn4rCsVSG79f43tk
 DWn96YAYa/bPlBUO5OuEKn9Q9PfVnDOrsZSEaqdHfchWyu4ggcWTnX3At7KLo2YACnCA
 EIdg==
X-Gm-Message-State: AOJu0YziXe5HfqL73tyR1RjCnQlToleZBSJ/faEaIpw1L69+g6VG4rC1
 c2XKik4n3xQPP7PxmvLuU+EDewXjFG2F7lwA1yg0+tXD8PQ5XlIewP1Z31XHqEeqG+LSoUSkVEn
 MqiK1eHJZmPfG2Y8242lEkcx36N+pqQrB3UukK+ufq9mtGmAmUjop4h/nPEpT0ckM54ryBFY4YG
 PFM72F26dpzFVBvmSissO2hjJEiBc=
X-Gm-Gg: ASbGncuxAiPK4xOfuFW+uf9pYE+MXhqDTLWh/9sSHvi06MslvCJQLYdfr9gx0jEM2VO
 tgqwS5UaYljvnqUFUiakmjJgkpLwLPD+HXwWqmHCQqo/FL6wLl/g8f8jxGWd6d4aCHjQcB/17je
 l/ooZG/ZGEAYrH/9ZGynRfPltv5r9Z
X-Received: by 2002:a17:90a:e185:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-305320b180bmr14286412a91.20.1743446406796; 
 Mon, 31 Mar 2025 11:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUuf/8aqy0CXm+l691ZtlehGvpsnyKTkenRk98pAMQObtzkm5wS01t6eiWQYto1gGv2Mitq72gCp9mD9A6BxU=
X-Received: by 2002:a17:90a:e185:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-305320b180bmr14286386a91.20.1743446406430; Mon, 31 Mar 2025
 11:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-4-jsnow@redhat.com>
 <87a598fhnp.fsf@pond.sub.org>
 <CAFn=p-aixsXRdE86tDS9kBd4azBQ7KU-h-utNkCndykbORAZ8w@mail.gmail.com>
 <87wmcb2fxq.fsf@pond.sub.org>
In-Reply-To: <87wmcb2fxq.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 31 Mar 2025 14:39:54 -0400
X-Gm-Features: AQ5f1JrB_NlkfbXpkjGzOL7Cf9vO_MaQ-_wbKdgQzT9ve7S0K8j0pZd9sS3sZnU
Message-ID: <CAFn=p-aVnA9G2WH=nEXy3qp5nrDotfw2r18NNPapM74fCY-GDQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] python: update missing dependencies from minreqs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bdae160631a7bf08"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000bdae160631a7bf08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 1:36=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, Mar 26, 2025 at 2:08=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > A few transitive dependencies were left floating; as a result, pip's
> >> > dependency solver can pull in newer dependencies, which we don't
> >> > want. Pin them down.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >>
> >> What problem exactly does this fix?  Make target check-minreqs?
> >>
> >
> > I'm not sure it's a "problem" as such, but an inconsistency. Yes, it's
> with
> > check-minreqs -- without this patch, pip is free to choose newer versio=
ns
> > of these dependencies as appropriate. Though unlikely at this point, in
> > theory, new dependency updates could be selected by pip and invalidate
> the
> > concept of an entirely fixed/pinned virtual environment.
> >
> > That these transitive dependencies were not frozen initially was an
> > oversight.
> >
> > check-minreqs is supposed to build the exact same venv every time witho=
ut
> > fail. Without this change, it's *possible* that it might do something
> > different on release day if someone releases a new package. No good,
> > probably.
>
> I see.
>
> You've been spoiling me with really nice commit messages...  If you'd
> like to push this one to that level, I'd suggest to start with a short
> paragraph explaining why we pin versions for check-minreq, then state
> the issue being fixed: we missed some pins.
>

"If you give a mouse a cookie, ..."

Already typed it all out to you, might as well update the commit message at
this point.

--js

--000000000000bdae160631a7bf08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 27,=
 2025 at 1:36=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Mar 26, 2025 at 2:08=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; A few transitive dependencies were left floating; as a result=
, pip&#39;s<br>
&gt;&gt; &gt; dependency solver can pull in newer dependencies, which we do=
n&#39;t<br>
&gt;&gt; &gt; want. Pin them down.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; What problem exactly does this fix?=C2=A0 Make target check-minreq=
s?<br>
&gt;&gt;<br>
&gt;<br>
&gt; I&#39;m not sure it&#39;s a &quot;problem&quot; as such, but an incons=
istency. Yes, it&#39;s with<br>
&gt; check-minreqs -- without this patch, pip is free to choose newer versi=
ons<br>
&gt; of these dependencies as appropriate. Though unlikely at this point, i=
n<br>
&gt; theory, new dependency updates could be selected by pip and invalidate=
 the<br>
&gt; concept of an entirely fixed/pinned virtual environment.<br>
&gt;<br>
&gt; That these transitive dependencies were not frozen initially was an<br=
>
&gt; oversight.<br>
&gt;<br>
&gt; check-minreqs is supposed to build the exact same venv every time with=
out<br>
&gt; fail. Without this change, it&#39;s *possible* that it might do someth=
ing<br>
&gt; different on release day if someone releases a new package. No good,<b=
r>
&gt; probably.<br>
<br>
I see.<br>
<br>
You&#39;ve been spoiling me with really nice commit messages...=C2=A0 If yo=
u&#39;d<br>
like to push this one to that level, I&#39;d suggest to start with a short<=
br>
paragraph explaining why we pin versions for check-minreq, then state<br>
the issue being fixed: we missed some pins.<br></blockquote><div><br></div>=
<div>&quot;If you give a mouse a cookie, ...&quot;</div><div><br></div><div=
>Already typed it all out to you, might as well update the commit message a=
t this point.</div><div><br></div><div>--js</div></div></div>

--000000000000bdae160631a7bf08--


