Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6F8CF2560
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 21:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLTb3-0002qu-BW; Tue, 18 Nov 2025 16:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLTat-0002qD-EB
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 16:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLTaq-0006U6-Cc
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 16:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763502630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWNtzkx5ggGMqwUAhzqioZhECu1Q4Vx7mDfchhXJfog=;
 b=KmgbtmDwihcu3ap5lzKrKDhQO2H5tyKQtJ89LCgitbYD2OjRoF0KqKcbHlAZQvallnG/Wj
 jds7vG3Ymg+VxPJpt5IsHmhx5D6+U+aGZxuTykcX2MiXgwaZLEBkjqXctUCdb0WBtOIr1m
 mT3BGzeVIpJFoHlYPTKMrNYfdeWQbz0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-v-7FcUw-NXCOWnZUCKbu6A-1; Tue, 18 Nov 2025 16:50:26 -0500
X-MC-Unique: v-7FcUw-NXCOWnZUCKbu6A-1
X-Mimecast-MFC-AGG-ID: v-7FcUw-NXCOWnZUCKbu6A_1763502626
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7865de53d43so80461537b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763502626; x=1764107426; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VWNtzkx5ggGMqwUAhzqioZhECu1Q4Vx7mDfchhXJfog=;
 b=tfoX9EUaxQ6M5Ljyh0RrziXHl/NIMR4o5+bUQSY90+EJA0PwjvcrvQP3+f+G+hGLW/
 RL2WxccK3PENNitT8atWlH7h7gn6ogbI7Mql597bEmI7GSFsZc5byPI3XJ0U6cAZ3oSu
 xsXK+/dkJSTHNkJF40r7oDwTSaavbw4SW+K6qrrH2v3BMM52uk2/wJweWSfbZy4OMf+9
 QcsiswY1Y04P7TaWjj+crnD+uUX3qKvAqriJzp3D7Yv6xFXAiSxhbZJkb2Tlh1N+RmeE
 8okrGFyFSXgHH4VqKULV8QxvMdZ91pksC4xVqLkM3OacZEQypBobpn+PoV1kD818hMIK
 Wx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763502626; x=1764107426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWNtzkx5ggGMqwUAhzqioZhECu1Q4Vx7mDfchhXJfog=;
 b=FxgE7jiad+1zby6UoeNzmRPhrgGOHKP7ibotaADX6kFZ3rpqIMyR3niT9UwTAeqDoE
 4JFTYlTpLt9Ff48nJZAG1VX+psInc4t/R6mIvPA3AwZLia5uXqri4605rc6A12RS2stx
 QCqEuhRH4QH9fzZftMWi8Zw0gLVT5Bg29llDS5BXVarFwFVyFRDoASWPAFSvHdB/e7EQ
 Bw6yDfsuDiHS8n7uXz1Tlx4vVTXqBusjwx8c4YFcbqTAkcZ/PVD6A5XgXRnIioUY0Itl
 YrBXwXWoyd/YMlJSnf6sbo9lha6sdPNkoAyr0p4dwkB0fSYTKBCY57MiM0LAAAGAjz33
 sHSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCDCpG528wz5s8viackP9xW9ygxRL5vjPGQVvjri73TvSJtjwgCnOwOwl2OFbp3r+q4Eeh0+48gH+h@nongnu.org
X-Gm-Message-State: AOJu0Yw3H17/rHfv01eHWkbOPKm6N90tQhDoKkU5iRo7eao854E94G8I
 wrt4aJ0EvDnAE3GJbXRMDtSOnAURG9tV+lM+Ug2Eeqa1klxhQAPtNwRVjhPcIdvMGF4h5AL4+qJ
 hfzf04YCFMHxWgIwOp50bvbu/SHKKUPXDRMG1tcB3fYbCkFpX3gdY9Ee9pJAZvKCBv8xZH+9T+F
 pKHONKwAWBPDoTCLOOdSiCPOOxhPTxvZI=
X-Gm-Gg: ASbGncv98vkDZWBMLxT+ZbSfyeERcUxw/SYM37UZ0fe8lEPdudhRNNf9QvPdTppDTID
 ssO1m/vLvKOvVU3cbgB1DspwA8lk3mGsKDtW6c+p6BVyMDNpcnMSho3LOIg0pE66Hoin5FgBDb0
 82kThfBMizPj1B+ieSoWpshER96X02W1UhG91+hvxAYz3KFto2PyrQ+FsVH1/r6scNab1zvXaxB
 TIhuB6n9OAKKg1NWwkbUNRRUA==
X-Received: by 2002:a05:690c:a08d:10b0:781:32c:b359 with SMTP id
 00721157ae682-78929ed2d9bmr265840747b3.36.1763502625959; 
 Tue, 18 Nov 2025 13:50:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSkNx9/ld8DrGiMIGbB0UAcJWfrX2VWTAmLGVekdft7leZIiYXplHDVNtWuR6ieRp2sef+kotngnHLsBLURm8=
X-Received: by 2002:a05:690c:a08d:10b0:781:32c:b359 with SMTP id
 00721157ae682-78929ed2d9bmr265840387b3.36.1763502625598; Tue, 18 Nov 2025
 13:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-18-jsnow@redhat.com>
 <aRtyTkIcuoNazF7L@redhat.com>
 <CABgObfZW5i4nYchoCTKeh7b3cxYSctpxFp=UV2a2V5t=zmDgNw@mail.gmail.com>
In-Reply-To: <CABgObfZW5i4nYchoCTKeh7b3cxYSctpxFp=UV2a2V5t=zmDgNw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Nov 2025 16:50:14 -0500
X-Gm-Features: AWmQ_bkcbyiXSr5kv_l9p6FwBPB7dwgZgmSj7qBF97NklwOJpQ6ip34Q7CilcY4
Message-ID: <CAFn=p-a4_EX7FvobF2f8fH2=ZKemcZvobi0EKV4MpCiQM+TQ+g@mail.gmail.com>
Subject: Re: [PATCH 17/22] tests: forcibly run 'make check-venv' for crash
 tests
To: Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/alternative; boundary="0000000000008fb9e60643e573b6"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

--0000000000008fb9e60643e573b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025, 3:47=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> w=
rote:

>
>
> Il lun 17 nov 2025, 20:07 Daniel P. Berrang=C3=A9 <berrange@redhat.com> h=
a
> scritto:
>
>> On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:
>> > In order to convert the existing Makefile target from a manual
>> > invocation of mkvenv to one that uses the meson dependency system, we
>> > need to not suppress ninja here.
>> >
>> > I'm not sure if this creates problems I am not aware of; but invoking
>> > ninja here is no longer spurious but will become necessary.
>>
>> Yes, this will likely create problems. From the commit message that
>> introduced NINJA=3D":"...
>>
>>  Avoid it with the same
>>     trick that we are using in buildtest-template.yml already by disabli=
ng
>>     the up-to-date check via NINJA=3D":".
>>
>
> Move the check-venv call to buildtest-template.yml, right after configure=
?
> It's cheap enough.
>
> Paolo
>

What's the root issue here? That there's enough of a time delay between the
actual configure and the test running that it re-runs configure?

(And presumably this is bad mostly for wasted CI time...?)



>
>>
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  .gitlab-ci.d/buildtest.yml | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> > index 18d72d3058b..2cb2cf25b4a 100644
>> > --- a/.gitlab-ci.d/buildtest.yml
>> > +++ b/.gitlab-ci.d/buildtest.yml
>> > @@ -101,7 +101,7 @@ crash-test-debian:
>> >      IMAGE: debian
>> >    script:
>> >      - cd build
>> > -    - make NINJA=3D":" check-venv
>> > +    - make check-venv
>> >      - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only
>> ./qemu-system-i386
>> >
>> >  build-system-fedora:
>> > @@ -158,7 +158,7 @@ crash-test-fedora:
>> >      IMAGE: fedora
>> >    script:
>> >      - cd build
>> > -    - make NINJA=3D":" check-venv
>> > +    - make check-venv
>> >      - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-p=
pc
>> >      - pyvenv/bin/python3 scripts/device-crash-test -q
>> ./qemu-system-riscv32
>> >
>> > --
>> > 2.51.1
>> >
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-
>> https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-
>> https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-
>> https://www.instagram.com/dberrange :|
>>
>>

--0000000000008fb9e60643e573b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 17, 2025, 3:47=E2=80=
=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">Il lun 17 nov 2025, 20:07 Daniel P. Berrang=C3=A9 &lt;<a href=3D"m=
ailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@re=
dhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:<br>
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
e?</div><div dir=3D"auto"><br></div><div dir=3D"auto">(And presumably this =
is bad mostly for wasted CI time...?)</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
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
" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =
=C2=A0 <a href=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferre=
r noreferrer noreferrer" target=3D"_blank">https://www.flickr.com/photos/db=
errange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-o-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138=
.berrange.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">h=
ttps://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer nore=
ferrer" target=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=
=C2=A0 =C2=A0 <a href=3D"https://www.instagram.com/dberrange" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://www.instagram.com/dbe=
rrange</a> :|<br>
<br>
</blockquote></div></div></div>
</blockquote></div></div></div>

--0000000000008fb9e60643e573b6--


