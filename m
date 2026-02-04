Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2295E9D41B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngLQ-0006dd-BL; Wed, 04 Feb 2026 12:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vngLO-0006ct-LR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:07:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vngLM-0008EX-6M
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770224827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E/A04IYSvP31+S2A1IXi9kwdKvSilkRo04QAM8/Aceg=;
 b=fJsKxbODWU2xgCYym0AtDWlMI8u4jgh2snaPt3AaBG5npBo9+u8nkLkNd/V+LeqajNwVmq
 mSXUfeaYZnP9WWkrheib6vWkxfP8THjG35wJEeEiZtp8H7CM60lGmhjN7/a2x/1/fBUn1f
 9aWayA4b1hWcjB2sN/M25fpn77lCRtw=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-AEuHcDBSNamNHksh-CTN0A-1; Wed, 04 Feb 2026 12:07:05 -0500
X-MC-Unique: AEuHcDBSNamNHksh-CTN0A-1
X-Mimecast-MFC-AGG-ID: AEuHcDBSNamNHksh-CTN0A_1770224825
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-649deeeb00fso138646d50.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 09:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770224824; cv=none;
 d=google.com; s=arc-20240605;
 b=E3PMNzdnWTDJDqheXABFE99XhmGT/p6Bkzb2xXF9l6aGfgMwjezloQtRSkESSGmEJ1
 k/YfBlc+HA7i7gIfEbYPJ6Dqc3oUB4446YW9AurCie8h+ZIJVVjR8NiFgphM5YXmw7Qq
 L/NVosO1uMQbffB0BQGRZp5wxdGzBE8A0xJMeo0un5LUyrAwz2sb5cTbqntvTSoJLVBY
 tq/SE+7xgFP07nj9Bm0onf7UnOa1r+sQaNjqfeGxb9OOkc9ziRyepKT/sy+NPwQjK7/g
 YXEULH7yZOPeWaIolVPJJtOGmDzhqr5dPgMjKlFD9zBUBQTEHLPM7uO/orSO38FVZGfU
 RMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E/A04IYSvP31+S2A1IXi9kwdKvSilkRo04QAM8/Aceg=;
 fh=z94pb0SCObMgEmHwqnERWGzVkOT7uV+NemWsUoTaNUY=;
 b=Tspm6QCkEJ498+Q7YY+A+2txYT1eGJxld5ND1j7A67aw1DTlEAAMZ79DfNt3PrTIld
 6rXo1jX2+4AOkstJ1fOfnRFuNibBaEnC0PjsbUAP0bDC5GqmttniVLyo2oZKmv+1dQsD
 Dqzasd7yLRSAUxqGp/4wfakWVQ8e6T8GfLjrj/FXKTD0L0bsmHOjPIeZw0dKoymYCcHK
 bbgu+h3jkgH2kA/M/zmV2U39UFthuq3MAUg3OD+ctyXxKAaDQE7RMqwjNOFvKdcg7jNi
 HfQnUHocEh/Q+PRwDh8PadKMx1FtI/ttmWXYaEsGsRcwiHNKZaOBkUqNSyiHrNN2PZvE
 NGFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770224824; x=1770829624; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E/A04IYSvP31+S2A1IXi9kwdKvSilkRo04QAM8/Aceg=;
 b=bfN+7Z19/JVfmiIOPdfJJZTx14vQTS/99VBU9No+w1CnPENSwNdDP8a3DEWvMO/0CB
 ++SkmOKlvS+e0pPSXU0+le7nU+D5hq6F6yGOKyYy5oL0V9d3yzsdX5FBRXy4wXch2hat
 j2DGDuAfVELZBYNfAYQskSsIiR18HnWQq9JF0buRk30mme3wXAte6zjAT8kbaIzsnvIP
 2iETlKNUrs0dP3nnchyRD72IRhR7lT+eB8eodDaDDK87lyEZvL8MTh8o57jTqIj6hknb
 Xt8KBcgXRyYdVWlfhm4o6lcYqvcjPZiEcgm2xL+qqlEua6SHEybFjF+krofBNtGdjsGu
 ITNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770224824; x=1770829624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/A04IYSvP31+S2A1IXi9kwdKvSilkRo04QAM8/Aceg=;
 b=nq2g8YT0yBF/U07UjvncfuZCP1lb5VpdeEeQisKnBOJIic7YrNnv9ER8moQUGrK+n8
 UefTEMTQoCiQESNTBynua1odFnSN3JWcEQuSsA1PZ92sk9m9PBqVceD340NBP8p8yWo7
 Ts230lWA9T0MFjWcA7E61YNKmnopCls6oT9z55Z4peE+RAeRrCGNOxEiqQTXzk9modP+
 VVnNxbNIeO7dai+YZ8oFUwGTKInryKA7ZFrumpNjeuo4Qw7BFqtM4hPKTg867P6nA9Kr
 U2q0ZbwKbFSuJP6oY/Yc0rsJAHgVe7TOHy8uGcZDlRb0glh6xdUqnXuhqpYA6lKZ+qsa
 Brcw==
X-Gm-Message-State: AOJu0YxwVsN718TkDwjS91Eguu7wX2ZwRpti2a8lrq0s0S37dsgpVGmZ
 YcBwx/3vxzTrQHASaqXG/uTRZl3FbWaRzrkCNsabsQysiWL0CAeDZTvGIYoYCThqdSy8pALEhLq
 jBB58HokP7jNJL87bQal0CQnG2xXujfoQvfrjuwH3Ndc+exZ6hKF6leR468Lx9Ch0Qgm8si6ORH
 G6h+F7wAAeu5bR3f0TwAlu88t+OYPyf58=
X-Gm-Gg: AZuq6aJ/BRtQw5x03Iy0GkZ152E3DRUou+SQVs+9Ve5fyQPI5aGSRDb1dEULRRBhxOE
 Puu0jUts1yGg5yy/xU3TdbgSkAgJq7aoebr/pPZf43gCk/Mm9LLo15Rlkb6S9/IZU87kNTAXZCw
 BwgUG0J92os4KD/aZ29W/U1S70udA1c2gH8MFf6FaMVb74zNoL9kn/T4MNALyKzXq/XkgHA9gVB
 vLS5fkTh/ah+zyFp+wqkH2RXw==
X-Received: by 2002:a53:b604:0:b0:649:d9df:904f with SMTP id
 956f58d0204a3-649db48fa6amr2085305d50.57.1770224824523; 
 Wed, 04 Feb 2026 09:07:04 -0800 (PST)
X-Received: by 2002:a53:b604:0:b0:649:d9df:904f with SMTP id
 956f58d0204a3-649db48fa6amr2085279d50.57.1770224824123; Wed, 04 Feb 2026
 09:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-14-jsnow@redhat.com>
 <aYMPjHydSnITR25D@redhat.com>
In-Reply-To: <aYMPjHydSnITR25D@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 4 Feb 2026 12:06:52 -0500
X-Gm-Features: AZwV_Qii14bpa-vDc4tueZ6lz67rhOxIiL2R6bfkKF4IeyBVRwOclPlYTBWvhS4
Message-ID: <CAFn=p-b6MLvCvvxZVDCLrxaxQuetsGF3d2hmKx61isDZEfwzyw@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] tests: remove "make check-venv" target
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, 
 Thomas Huth <thuth@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>, 
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000d0a623064a0295e0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000d0a623064a0295e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026, 4:21=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:

> On Tue, Feb 03, 2026 at 03:35:08PM -0500, John Snow wrote:
> > With the qemu.qmp and qemu.machine dependencies now installed by defaul=
t
> > at configure time and additional dependencies required by functional
> > testing installed on demand, there is no longer any reason to have an
> > explicit target.
> >
> > FIXME: This forces image regeneration for vm tests whenever Make
> > determines that the image needs to be rebuilt; which is a regression
> > over the previous behavior.
>
> IIUC because you always pass the '--force' flag now. If the deps show it
> is dirty though, this seems right ? Is it a regression or was previous
> code incorrectly NOT forcing rebuild in all needed cases ? It is pretty
> confusing logic there.
>

Yeah, admittedly I don't understand what the old conditional was even
doing... I forgot I still had this fixme in here, mea culpa.

I suppose I kind of figured that if someone complained, I'd fix it then...?
because I'm not sure exactly what regressed or in what cases, or how to
even roll back and test the behavior pre-fix.

*loud shrugging*


> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/Makefile.include    | 22 ++--------------------
> >  tests/vm/Makefile.include | 24 +++++++-----------------
> >  2 files changed, 9 insertions(+), 37 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000d0a623064a0295e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 4, 2026, 4:21=E2=80=
=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Tue, Feb 03, 2026 at 03:35:08PM -0500, John Snow wrote:<br>
&gt; With the qemu.qmp and qemu.machine dependencies now installed by defau=
lt<br>
&gt; at configure time and additional dependencies required by functional<b=
r>
&gt; testing installed on demand, there is no longer any reason to have an<=
br>
&gt; explicit target.<br>
&gt; <br>
&gt; FIXME: This forces image regeneration for vm tests whenever Make<br>
&gt; determines that the image needs to be rebuilt; which is a regression<b=
r>
&gt; over the previous behavior.<br>
<br>
IIUC because you always pass the &#39;--force&#39; flag now. If the deps sh=
ow it<br>
is dirty though, this seems right ? Is it a regression or was previous<br>
code incorrectly NOT forcing rebuild in all needed cases ? It is pretty<br>
confusing logic there.<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Yeah, admittedly I don&#39;t understand what the old =
conditional was even doing... I forgot I still had this fixme in here, mea =
culpa.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I suppose I kind =
of figured that if someone complained, I&#39;d fix it then...? because I&#3=
9;m not sure exactly what regressed or in what cases, or how to even roll b=
ack and test the behavior pre-fix.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">*loud shrugging*</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/Makefile.include=C2=A0 =C2=A0 | 22 ++--------------------<=
br>
&gt;=C2=A0 tests/vm/Makefile.include | 24 +++++++-----------------<br>
&gt;=C2=A0 2 files changed, 9 insertions(+), 37 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000d0a623064a0295e0--


