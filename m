Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D34CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 20:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL68N-0004Cu-VO; Mon, 17 Nov 2025 15:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL68H-00047p-3f
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL68B-00023s-2C
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763412436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvFxaV11kHBIYs3UNxSNrxJL7zT+7WtM5n+clDkHZZo=;
 b=Zui9pZA8COxSA5yqF3HrwP4k0NXMfMZKvKvOyVnN3NEId9PSIrTngaODTCLmBvdYqktnrC
 3z+QUNLPO2p/EV9ikuIw7nobF2ttI0WTuYjIUtVGjO9K9O60aeY3uxf/3JEcav5yX2uqKk
 OJ0BxlWFdTJrnT158OmYGHcptYw9V78=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Xs0oUf7GPhqyjs8PL0sPDQ-1; Mon, 17 Nov 2025 15:47:14 -0500
X-MC-Unique: Xs0oUf7GPhqyjs8PL0sPDQ-1
X-Mimecast-MFC-AGG-ID: Xs0oUf7GPhqyjs8PL0sPDQ_1763412433
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c76c8a1bso2860182f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763412433; x=1764017233; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EvFxaV11kHBIYs3UNxSNrxJL7zT+7WtM5n+clDkHZZo=;
 b=TDZLxScTkK9HsVpxU+6J8qJxRXXRzCrtTsc7cqWQJ2jYkEISqZ4IKIDxN43Mgr+6io
 BQzpOKtdFy42E7Q6DGhFTorbY9nccIHyXG371QbFCUi6t8b2+rNrsJV2beEJdkC/Icei
 PTV1rtsfEQnXAOMU9i115Jv2avhpgaIcW1k14G84Afp5jqynzhJrpQI64wEyi1NergUU
 tqCkB0iOk2XR/Lvf6JJQBR8TSe7IZvmuxA80KE5HAnJeXYgWMylkXcJPBAibOJqBOTND
 WGH5n3m5hPsnRPcbjII9fLej3KA3hClq2wt3KQQioeuXJvX9yz5EUYyOGmE/4E+2DFpB
 ORXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763412433; x=1764017233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvFxaV11kHBIYs3UNxSNrxJL7zT+7WtM5n+clDkHZZo=;
 b=QcZQClMPwcVjNZQN0C+LlLw5ci35sMJpri5Ox0xjTy7myMMarroXFmcWm01foGE0c+
 ylJmz4Ym6St74Iudq/ya4BpC7UlsH5bagBb9Ao2lSkkONhgZ8jV4Uq6Ip4703MgmGZBC
 F57+VZGsNcaKN43a/3LOAGGf9hX8/l5JXvtpCPetK0zsegmvzzqepiiigoFj5Dy3iJ/H
 XHwKvi64uLQp99qMhomSaKNIIZAhv2b5pjTtBf7+hxqGJtnYmQ1L3hGztOKvYXP3Chew
 fw5uY++ZCQiAQPIUBAuQ7cvNcwmt18mPX+Vf6cOkN28vyDIOaGINlpoxOEALjF6t1JwG
 R7ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnM6yYzYadcI7yqn0Mn1b1UQUXRsE+qialKn83HIAZq7tHWlBMGXt9R+1zlmdrEJrYC/7KpxOXTVUZ@nongnu.org
X-Gm-Message-State: AOJu0YzvJOHqLhZ+tVjCphtONZT+36rrPhxYkIVCkw7rDjHkIgybqAqo
 n68fYaIKewydYs3hBjyzfNPzNU+pQXtIB7m82vHOVVqaCzeX/eIRCW9Bfd1kVmh/sxzw21xT9iY
 oiQFOFXv9hHx5J9OhT52bLl3H9hlgxb9A9KlCjEQM3dg8S7lhMZGIurLyZkjchqmCzOhkxrk5PY
 WyY6f5Hi9uSrIwSfjKxi/cEvGDGmc7bJg=
X-Gm-Gg: ASbGncuchmv3j0vBrplSua2nN1aNh9uFAL9JRStOLOjt+o/z+UGp5IflnFoOfew5Xdy
 Q9bBu4m6gMI2cfQFRh31ZofpwzPZbSjaRGJ+o+houSy1u4dwAwVWrTjK5QgFtqD+iqHXZkI3MZ3
 IvCsTfYNngyIul3GoGzvAzn8bXKwobHS+SRxthsEj/I1edgPIF24vuc0P5GHBhaVYsbXq5uKV/F
 BngZr0Qj08SgFjzCCEunquJzz/Fvt6gkxIXhAXpaDAp14vepERJ2zm3rvt/e8MfeOA8mVI=
X-Received: by 2002:a05:6000:2509:b0:42b:3e0a:649e with SMTP id
 ffacd0b85a97d-42b59328f9fmr14455497f8f.13.1763412433417; 
 Mon, 17 Nov 2025 12:47:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjqahpMfO9p3xKJrwdXbEdKEfZS6+SthyuP5EQmBffBp6yf7SQ9Pp9RDKUeXc7BQmZOMW47joT3osZ4RhRmhc=
X-Received: by 2002:a05:6000:2509:b0:42b:3e0a:649e with SMTP id
 ffacd0b85a97d-42b59328f9fmr14455477f8f.13.1763412432870; Mon, 17 Nov 2025
 12:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-18-jsnow@redhat.com>
 <aRtyTkIcuoNazF7L@redhat.com>
In-Reply-To: <aRtyTkIcuoNazF7L@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Nov 2025 21:47:00 +0100
X-Gm-Features: AWmQ_blhtbgZcRGtwmMgNWZ6XK_4gYmHqfdFrWdBp6ApHbBKVqD7jQFEqdwNWms
Message-ID: <CABgObfZW5i4nYchoCTKeh7b3cxYSctpxFp=UV2a2V5t=zmDgNw@mail.gmail.com>
Subject: Re: [PATCH 17/22] tests: forcibly run 'make check-venv' for crash
 tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a772d60643d0735d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--000000000000a772d60643d0735d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 17 nov 2025, 20:07 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:
> > In order to convert the existing Makefile target from a manual
> > invocation of mkvenv to one that uses the meson dependency system, we
> > need to not suppress ninja here.
> >
> > I'm not sure if this creates problems I am not aware of; but invoking
> > ninja here is no longer spurious but will become necessary.
>
> Yes, this will likely create problems. From the commit message that
> introduced NINJA=3D":"...
>
>  Avoid it with the same
>     trick that we are using in buildtest-template.yml already by disablin=
g
>     the up-to-date check via NINJA=3D":".
>

Move the check-venv call to buildtest-template.yml, right after configure?
It's cheap enough.

Paolo


>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  .gitlab-ci.d/buildtest.yml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index 18d72d3058b..2cb2cf25b4a 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -101,7 +101,7 @@ crash-test-debian:
> >      IMAGE: debian
> >    script:
> >      - cd build
> > -    - make NINJA=3D":" check-venv
> > +    - make check-venv
> >      - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only
> ./qemu-system-i386
> >
> >  build-system-fedora:
> > @@ -158,7 +158,7 @@ crash-test-fedora:
> >      IMAGE: fedora
> >    script:
> >      - cd build
> > -    - make NINJA=3D":" check-venv
> > +    - make check-venv
> >      - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-pp=
c
> >      - pyvenv/bin/python3 scripts/device-crash-test -q
> ./qemu-system-riscv32
> >
> > --
> > 2.51.1
> >
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

--000000000000a772d60643d0735d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 17 nov 2025, 20:07 Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:<br>
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
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
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

--000000000000a772d60643d0735d--


