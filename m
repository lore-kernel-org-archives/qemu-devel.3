Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D342C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTnxH-00039O-VY; Tue, 16 Jul 2024 15:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTnx3-00032x-Fn
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 15:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTnwz-00023u-7j
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 15:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721158498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUKYpplj8fsi0g48Qd80OCh/wygTPEV+d4BMmhELcqQ=;
 b=UMpeLjrD6jQu3RcsZuzzkiuUDqXmWprOIUQy4KNcz9T7TAAs5Wcp1H4vWRpp4+H2/4JRnG
 TjkxaFH3nAUYfnFvsghPLyZbppxxS3txX6SA4BDcTQc1hexXESXBm7Nzl5CWTU+tId7q5y
 rdkwPtBJ18UKDQE2ZLUcnuG8eB3snnI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-0QWRXu4dNmW8aro7QNmNIQ-1; Tue, 16 Jul 2024 15:34:56 -0400
X-MC-Unique: 0QWRXu4dNmW8aro7QNmNIQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367963c4f52so4140293f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 12:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721158495; x=1721763295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lUKYpplj8fsi0g48Qd80OCh/wygTPEV+d4BMmhELcqQ=;
 b=VTVe6Lf7N8t5fgWlzLRUWpJ82/aMOwjEBUrsT91UAAqR17xPw7qKAgzgcwgqKOyeSi
 TZuRO8DSjntZQ+fIdHUvWBOsJtBBvoLCpARiiot745y1oSFZs06V1CEmyj+6OhZGxRbH
 FlQ4uDfeq66Rw7qZLG9EXyMKkQqfCvlFRg6ZVbNNKipmJXoplRiEejJeRbrAxsRQCrYB
 O3ipjLrDOmD47tVrSsN/F3/WpqdOd8MG5bjGjKkXfFKZFf7hjYNjLKeR8D6hfujSEzVi
 ee+WqBgYXk79e6e7cyCedvewkwSAWSvgUezLt6cSFympnnEk0X1yvHHGEqNVNi1JKXRr
 mnsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvTIRYjd7N6J+1rileviRDdbA5FTQwVNR1VtczHV/bvca0i9hjD6HRu1NOJKY3dYE75H3kN8bqhTAmggp7HWnewSklt10=
X-Gm-Message-State: AOJu0Yw1mPZZheffmQfB1gw1KOlr28FE8LeOGKUB0RdYUHb/p2DVeDQr
 /vEgK+bGDuzVpnDod2UtWGTlSpVGvWI4SaxVLwGUtHmZb0Fat5ttK8/bu17ylVkrFQJi6iQapRg
 TBrUvjEpljLU2oXi7unD0hf2g6x/6Ri0ek5LxraEHRP67qQfwvKo3LNqXGTKLmJBhValHjgyKSy
 I8BiAGi8cygaG6quIjp85iurH80VY=
X-Received: by 2002:adf:fe46:0:b0:361:bcc5:2e26 with SMTP id
 ffacd0b85a97d-368260d4ceemr2173351f8f.19.1721158495254; 
 Tue, 16 Jul 2024 12:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFawOBMTQOUbW1wYsXXy+vNIbZzyJExmpwgE3H6liirBxmPhNDUfHGb7Qb/CTlDfypFCr+GLAX+UwHCUtzHV2Q=
X-Received: by 2002:adf:fe46:0:b0:361:bcc5:2e26 with SMTP id
 ffacd0b85a97d-368260d4ceemr2173336f8f.19.1721158494734; Tue, 16 Jul 2024
 12:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240711115546.40859-1-thuth@redhat.com>
 <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
 <CABgObfbVdSDiJxNzv5TdUfOLLB=dLCkB0KgFQOxAcnG02gpDLA@mail.gmail.com>
 <Zpa3kFjfNMf-ZDi1@redhat.com>
In-Reply-To: <Zpa3kFjfNMf-ZDi1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jul 2024 21:34:41 +0200
Message-ID: <CABgObfYgWnG5WidzY1dhMzwqijTXM6dyQBW_WMVGiHE5W8+bDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ae6450061d6270ee"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000ae6450061d6270ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 16 lug 2024, 20:10 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> On Tue, Jul 16, 2024 at 08:03:54PM +0200, Paolo Bonzini wrote:
> > Il mar 16 lug 2024, 18:45 John Snow <jsnow@redhat.com> ha scritto:
> >
> > > My only ask is that we keep the tests running in the custom venv
> > > environment we set up at build time
> > >
> >
> > Yes, they do, however pytest should also be added to pythondeps.toml if
> we
> > go this way.
>
> Done in this patch:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg03596.html


That adds pycotap, not pytest.

> Yep, that's the part that I am a bit more doubtful about.
>
> Pulling & caching VM images isn't much more than a URL download to
> a local file, not very complex in python. Assuming that's what you
> are refering to, then it is already done in this patch:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg03598.html


I think there are also compressed assets that have to be passed through
gzip/xzip/zstd. I am worried that Thomas's patches do 90% of the job but
that is not a good estimation of what's left.

Paolo


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

--000000000000ae6450061d6270ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 16 lug 2024, 20:10 Daniel P. Berrang=C3=A9 &lt;=
<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Jul =
16, 2024 at 08:03:54PM +0200, Paolo Bonzini wrote:<br>
&gt; Il mar 16 lug 2024, 18:45 John Snow &lt;<a href=3D"mailto:jsnow@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; ha scri=
tto:<br>
&gt; <br>
&gt; &gt; My only ask is that we keep the tests running in the custom venv<=
br>
&gt; &gt; environment we set up at build time<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes, they do, however pytest should also be added to pythondeps.toml i=
f we<br>
&gt; go this way.<br>
<br>
Done in this patch:<br>
<br>
=C2=A0 <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2024-07/=
msg03596.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://list=
s.nongnu.org/archive/html/qemu-devel/2024-07/msg03596.html</a></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That adds pycotap=
, not pytest.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Yep, that&#39;s the part that I am a bit more doubtful about.<br>
<br>
Pulling &amp; caching VM images isn&#39;t much more than a URL download to =
<br>
a local file, not very complex in python. Assuming that&#39;s what you<br>
are refering to, then it is already done in this patch:<br>
<br>
=C2=A0 <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2024-07/=
msg03598.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://list=
s.nongnu.org/archive/html/qemu-devel/2024-07/msg03598.html</a></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I think there are=
 also compressed assets that have to be passed through gzip/xzip/zstd. I am=
 worried that Thomas&#39;s patches do 90% of the job but that is not a good=
 estimation of what&#39;s left.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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

--000000000000ae6450061d6270ee--


