Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601CECF2599
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdCw-0004we-TU; Wed, 19 Nov 2025 03:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLdCe-0004iN-OY
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLdCb-0005rm-2H
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763539568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qlczw5xkOpEPltSGddWKoXQ/HojOsbrvI5BFqdJ87Ak=;
 b=cScL09gYCyYFHAEdMF+o9s42WQdh75K7mjRx6iBLmioYzQ3cRh7xEp6hVky0P+yqytRpCj
 i3eCMeo7ueB7TEaVWfRsypX1J2HZyyHITkWbT4bBCChRvbpGaW7KMHZfncDJCb3CSWOp0z
 OipR25qIgmvF9oZU8sCJ4srJ/j6eLDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-kIhjOj7cMeqCoc5DCMvcrQ-1; Wed, 19 Nov 2025 03:06:05 -0500
X-MC-Unique: kIhjOj7cMeqCoc5DCMvcrQ-1
X-Mimecast-MFC-AGG-ID: kIhjOj7cMeqCoc5DCMvcrQ_1763539565
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429cbd8299cso2963468f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763539565; x=1764144365; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qlczw5xkOpEPltSGddWKoXQ/HojOsbrvI5BFqdJ87Ak=;
 b=GDnXIPVCfyU/kf+RhlFVQ4A82LqvpyVI0PesDgm7HBe2t2tU19W+ddcfhK51akcRpE
 KFVRpmVLltR41t3ZJ6NL19QsylrOMItihffPy/QNVL9KogPQcrLk3JJ/+U6fvdN2ssKF
 yz6ZTA2/QZkAzo1BVDxT3otJodN9R4/Ujy0FbdR17m1+yLZ1WSlgV4M9AaqvVdXCDApt
 MRe7nQ4aXgtaVcbSu0OCf6OPHhQ0KNi3mUBH7WbI8xPdYYagL/G+QMb2LVb4kx4DvHdf
 lMdizjhspPpVqujSALJ6L9smBVIoCHVgNllag65/skkDJGpoOgNYNXDqgqGc/yU3pPpy
 Y95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763539565; x=1764144365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qlczw5xkOpEPltSGddWKoXQ/HojOsbrvI5BFqdJ87Ak=;
 b=wBjSaXoMBLhGq0aSO1YEEAS5iQkKfgWpagsTuuid9/51iMRyD/P+z7m6gk5xvUGxtB
 N0RG0fkaqJEpx33WK/sx+NF6KX2Jf2XOQ3nxrrcYBrcQT+euHX8YEa9WscO6oKynGj8L
 YnIDG5+IGF96+DScnE4HqX0hEEKaAL5RwgtkL4jHGpUwjqKAHab2UBSxN80Cf+0eE2m5
 NYgzOtogI0IjNW5V9Nd9pKWrdEBrur8PO70ZlAoyEj8nWJE65a6YBsjIlOcn9bQKMzVx
 dueAG+HQNbp7BCIvKhuokHkiUchJCvYAzUM87hZ8ztk5zp2NqG1nNSZFY0Lg85cAXiQ8
 KH2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuAEFuA1gKaJD/90EEMykUo5yjDZsEhDXVnarJ3FxHy6yM1v3DJF8KtQoG4YXimnFPmt49ZMbOC9gw@nongnu.org
X-Gm-Message-State: AOJu0YxAEYsbneso33N+kx3/PCitdMptvMmQTFx4FVv5Vc6vPUQuPCug
 gyVbzgVOIWURNW+ovoV+c68A/6aFQ1pl+HM5SlU9ZwN36rxgzEhY4DUhiUonhIob/oVxw+HUmQx
 vL16Il+3pkSDKWfj0ik8DbPw9AIsrnH0Xv++auQtIk7xtRQxMUpJir4ZY0CLay/gCHcDXU0Jm9d
 Qwm4XKQkJ3B1vaFScelB7euIlMu/t8EzU=
X-Gm-Gg: ASbGnctvbp3PcChmeZ/5uVJcKMg6S6t5+tUNs2WTtmNsaqk/cVKf8vW4j5wkngn6u/I
 IXcFfS6vK7qOoO65bK2izeYYyLZvvoQQgsyc787Sq1tCMJXoIihT+ZJDPQAa5/XjXrvCrOsMSZG
 B8aswTP+8KIukuGHcIzTWnyihWcczmxo/itG2ocxJmlWM0WSs0wjcGQpnGHkU7Q8qpml1ub7Cqf
 T5cIgQU+fMuKGdEZ0NZpYIvSDvEUKru29/x193CSALrwHAVULECg8uKGblHQvt5id70Umc=
X-Received: by 2002:a05:6000:1ace:b0:42b:55a1:2174 with SMTP id
 ffacd0b85a97d-42b595bb801mr17865291f8f.59.1763539564606; 
 Wed, 19 Nov 2025 00:06:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVORAPhmsqHxbzeJbgB2JTzqH1e5etiWMgadjwCaTN1OlsGqodpL90g2MWdePsyDpVqnI6fI0OP2YK4E53L3U=
X-Received: by 2002:a05:6000:1ace:b0:42b:55a1:2174 with SMTP id
 ffacd0b85a97d-42b595bb801mr17865255f8f.59.1763539564139; Wed, 19 Nov 2025
 00:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-18-jsnow@redhat.com>
 <aRtyTkIcuoNazF7L@redhat.com>
 <CABgObfZW5i4nYchoCTKeh7b3cxYSctpxFp=UV2a2V5t=zmDgNw@mail.gmail.com>
 <CAFn=p-a4_EX7FvobF2f8fH2=ZKemcZvobi0EKV4MpCiQM+TQ+g@mail.gmail.com>
In-Reply-To: <CAFn=p-a4_EX7FvobF2f8fH2=ZKemcZvobi0EKV4MpCiQM+TQ+g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 09:05:53 +0100
X-Gm-Features: AWmQ_bn8wEBwDyzdnNcPNQllnuPNLI9bistTLm7pAZYV5Ol3jJuWhJrRHEUjt6A
Message-ID: <CABgObfY6QPzH0xM+VOeP16Lsi+y9DEeim0tsx+yKXEW2skVPHQ@mail.gmail.com>
Subject: Re: [PATCH 17/22] tests: forcibly run 'make check-venv' for crash
 tests
To: John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000044aab00643ee0dce"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000044aab00643ee0dce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 18 nov 2025, 22:50 John Snow <jsnow@redhat.com> ha scritto:

>
>
> On Mon, Nov 17, 2025, 3:47=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>>
>>
>> Il lun 17 nov 2025, 20:07 Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
ha
>> scritto:
>>
>>> On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:
>>> > In order to convert the existing Makefile target from a manual
>>> > invocation of mkvenv to one that uses the meson dependency system, we
>>> > need to not suppress ninja here.
>>> >
>>> > I'm not sure if this creates problems I am not aware of; but invoking
>>> > ninja here is no longer spurious but will become necessary.
>>>
>>> Yes, this will likely create problems. From the commit message that
>>> introduced NINJA=3D":"...
>>>
>>>  Avoid it with the same
>>>     trick that we are using in buildtest-template.yml already by
>>> disabling
>>>     the up-to-date check via NINJA=3D":".
>>>
>>
>> Move the check-venv call to buildtest-template.yml, right after
>> configure? It's cheap enough.
>>
>> Paolo
>>
>
> What's the root issue here? That there's enough of a time delay between
> the actual configure and the test running that it re-runs configure?
>

That the git repo is cloned again and is therefore newer than the
artifacts. That triggers a full rebuild.


> (And presumably this is bad mostly for wasted CI time...?)
>
>
>
>>
>>>
>>> >
>>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>> > ---
>>> >  .gitlab-ci.d/buildtest.yml | 4 ++--
>>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>>> >
>>> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>> > index 18d72d3058b..2cb2cf25b4a 100644
>>> > --- a/.gitlab-ci.d/buildtest.yml
>>> > +++ b/.gitlab-ci.d/buildtest.yml
>>> > @@ -101,7 +101,7 @@ crash-test-debian:
>>> >      IMAGE: debian
>>> >    script:
>>> >      - cd build
>>> > -    - make NINJA=3D":" check-venv
>>> > +    - make check-venv
>>> >      - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only
>>> ./qemu-system-i386
>>> >
>>> >  build-system-fedora:
>>> > @@ -158,7 +158,7 @@ crash-test-fedora:
>>> >      IMAGE: fedora
>>> >    script:
>>> >      - cd build
>>> > -    - make NINJA=3D":" check-venv
>>> > +    - make check-venv
>>> >      - pyvenv/bin/python3 scripts/device-crash-test -q
>>> ./qemu-system-ppc
>>> >      - pyvenv/bin/python3 scripts/device-crash-test -q
>>> ./qemu-system-riscv32
>>> >
>>> > --
>>> > 2.51.1
>>> >
>>>
>>> With regards,
>>> Daniel
>>> --
>>> |: https://berrange.com      -o-
>>> https://www.flickr.com/photos/dberrange :|
>>> |: https://libvirt.org         -o-
>>> https://fstop138.berrange.com :|
>>> |: https://entangle-photo.org    -o-
>>> https://www.instagram.com/dberrange :|
>>>
>>>

--00000000000044aab00643ee0dce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 18 nov 2025, 22:50 John S=
now &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Nov 17, 2025, 3:47=E2=80=AFPM Paolo Bonzini &lt;<a hre=
f=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonz=
ini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">Il lun 17 nov 2025, 20:07 Daniel P. Berr=
ang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">berrange@redhat.com</a>&gt; ha scritto:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Nov 17, 2025 at 0=
1:51:25PM -0500, John Snow wrote:<br>
&gt; In order to convert the existing Makefile target from a manual<br>
&gt; invocation of mkvenv to one that uses the meson dependency system, we<=
br>
&gt; need to not suppress ninja here.<br>
&gt; <br>
&gt; I&#39;m not sure if this creates problems I am not aware of; but invok=
ing<br>
&gt; ninja here is no longer spurious but will become necessary.<br>
<br>
Yes, this will likely create problems. From the commit message that<br>
introduced NINJA=3D&quot;:&quot;...<br>
<br>=C2=A0Avoid it with the same<br>
=C2=A0 =C2=A0 trick that we are using in buildtest-template.yml already by =
disabling<br>
=C2=A0 =C2=A0 the up-to-date check via NINJA=3D&quot;:&quot;.<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Move the check=
-venv call to buildtest-template.yml, right after configure? It&#39;s cheap=
 enough.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</di=
v></div></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">What&#39;s the root issue here? That there&#39;s enough of a time delay=
 between the actual configure and the test running that it re-runs configur=
e?</div></div></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">That the git repo is cloned again and is therefore newer than the=
 artifacts. That triggers a full rebuild.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D"aut=
o"><br></div><div dir=3D"auto">(And presumably this is bad mostly for waste=
d CI time...?)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a=
>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .gitlab-ci.d/buildtest.yml | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml<b=
r>
&gt; index 18d72d3058b..2cb2cf25b4a 100644<br>
&gt; --- a/.gitlab-ci.d/buildtest.yml<br>
&gt; +++ b/.gitlab-ci.d/buildtest.yml<br>
&gt; @@ -101,7 +101,7 @@ crash-test-debian:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 IMAGE: debian<br>
&gt;=C2=A0 =C2=A0 script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - cd build<br>
&gt; -=C2=A0 =C2=A0 - make NINJA=3D&quot;:&quot; check-venv<br>
&gt; +=C2=A0 =C2=A0 - make check-venv<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - pyvenv/bin/python3 scripts/device-crash-test -q =
--tcg-only ./qemu-system-i386<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 build-system-fedora:<br>
&gt; @@ -158,7 +158,7 @@ crash-test-fedora:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 IMAGE: fedora<br>
&gt;=C2=A0 =C2=A0 script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - cd build<br>
&gt; -=C2=A0 =C2=A0 - make NINJA=3D&quot;:&quot; check-venv<br>
&gt; +=C2=A0 =C2=A0 - make check-venv<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - pyvenv/bin/python3 scripts/device-crash-test -q =
./qemu-system-ppc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - pyvenv/bin/python3 scripts/device-crash-test -q =
./qemu-system-riscv32<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.51.1<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer noreferrer=
 noreferrer" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0=
 -o-=C2=A0 =C2=A0 <a href=3D"https://www.flickr.com/photos/dberrange" rel=
=3D"noreferrer noreferrer noreferrer noreferrer" target=3D"_blank">https://=
www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer =
noreferrer" target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https:=
//fstop138.berrange.com" rel=3D"noreferrer noreferrer noreferrer noreferrer=
" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer nore=
ferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a>=C2=A0 =
=C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"https://www.instagram.com/dberrange" rel=
=3D"noreferrer noreferrer noreferrer noreferrer" target=3D"_blank">https://=
www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>
</blockquote></div></div></div>
</blockquote></div></div></div>

--00000000000044aab00643ee0dce--


