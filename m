Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F36C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV10I-00020N-SL; Tue, 30 Jan 2024 22:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rV10G-0001z5-QJ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:11:08 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rV10C-0006vB-1E
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:11:08 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a315f43ecc3so483309466b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 19:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1706670662; x=1707275462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=seTow07xii/tgNaQcZGxCbxNrNPVx8O+lxkDBB+n+/E=;
 b=JFAU+hGhkoPydnrmklbWRpInQHEvhqA2VEjJoLyfGbBBhEG1YcV/t4udr/wrMsc/CK
 TW4Ske/gmvHzThq0BmyE1vge8DZRbLNCSr4Py1/MYxDZ4FQz8Oy4aw+xrHmxxXC9D9zf
 So5VIag+rWurokpoC+a2dhU1UEWXqN6nYjxcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706670662; x=1707275462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=seTow07xii/tgNaQcZGxCbxNrNPVx8O+lxkDBB+n+/E=;
 b=SjectEUPfMSl1ar4d6KbQHW59FF0dkz8q/sKcPdOl4tXFwBXNjDZ0Ury6uRHmHyDwT
 Qdt6qr3jiiXsAsV0qDUxLm47eneyeHbTjblcy6QP+5ouQ6CB2Qt8Jfh/SLRDDR/Kwe/p
 fVdO4SaXG/xGwAi494oG2goVs8cHfPn8si/qTda/i7Mb7yoGsamdFXNBrnC1CD4300WM
 K+j6WkNSPWRkyUtc3C+snIdeJ+/JolsVzvQt2ROlhyECr6KYPoJzOk3OL6CF5B9QIkiu
 zrnD86wF+25qre49NWqBuzURgiRiFnsJHOQEnKYSvFfjMlc/46rBVBmfDwk52/T06qTC
 fbBg==
X-Gm-Message-State: AOJu0YxnnPLWHBtux42w/n9sjsno39wVZ34qeZrnAAbP5RUegcubDQ9r
 n44Spex0asFyL3X13IjqOIcJBkifrjGQsYy4ooT93bIG+4ClU3NyftU73rewtIT3vwEuX36iPn1
 VvQ==
X-Google-Smtp-Source: AGHT+IHTFC+rPS8yqVGizs3nZRqgL9QLFF2AADK4OyPIE+nHvOfEkNeIUqz8IuD9Hp6SdH4lZPP3uQ==
X-Received: by 2002:a17:906:fa92:b0:a36:7291:888f with SMTP id
 lt18-20020a170906fa9200b00a367291888fmr182498ejb.65.1706670662113; 
 Tue, 30 Jan 2024 19:11:02 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 f19-20020a17090624d300b00a2f15b8cb76sm5681253ejb.184.2024.01.30.19.11.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 19:11:01 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-55f85a2a43fso2189a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 19:11:01 -0800 (PST)
X-Received: by 2002:a05:6402:312f:b0:55d:2163:7ed1 with SMTP id
 dd15-20020a056402312f00b0055d21637ed1mr308542edb.1.1706670661546; Tue, 30 Jan
 2024 19:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
 <87cytwnqoj.fsf@alyssa.is>
 <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
 <87msssmax4.fsf@alyssa.is>
In-Reply-To: <87msssmax4.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 30 Jan 2024 19:10:49 -0800
X-Gmail-Original-Message-ID: <CAAfnVBm--wu3=ES0tY2JPXwm+Ga-tRLq=EpkZdzdVoHGUfb2KQ@mail.gmail.com>
Message-ID: <CAAfnVBm--wu3=ES0tY2JPXwm+Ga-tRLq=EpkZdzdVoHGUfb2KQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Content-Type: multipart/alternative; boundary="0000000000008853ba0610353ada"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008853ba0610353ada
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:23=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:

> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > On Sat, Jan 20, 2024 at 4:19=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrot=
e:
> >
> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
> >>
> >> > On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross <hi@alyssa.is> w=
rote:
> >> >>
> >> >> Hi Gurchetan,
> >> >>
> >> >> > Thanks for the reminder.  I did make a request to create the
> release
> >> >> > tags, but changes were requested by Fedora packaging effort:
> >> >> >
> >> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2242058
> >> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2241701
> >> >> >
> >> >> > So the request was canceled, but never re-requested.  I'll fire o=
ff
> >> >> > another request, with:
> >> >> >
> >> >> > gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
> >> >> > manually add debug logic")
> >> >> > AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve
> >> licensing")
> >> >> >
> >> >> > as the commits.  These match the Fedora requests, and the AEMU on=
e
> has
> >> >> > been merged into Fedora already it seems.
> >> >>
> >> >> These revisions have the problem I mentioned in my previous message=
:
> >> >>
> >> >> >> The gfxstream ref mentioned here isn't compatible with
> >> >> >> v0.1.2-rutabaga-release, because it no longer provides
> >> logging_base.pc,
> >> >>
> >> >> rutabaga was not fixed to use the new AEMU package names until afte=
r
> the
> >> >> v0.1.2-rutabaga-release tag, in commit 5dfd74a06.  So will there be=
 a
> >> >> new Rutabaga release that's compatible with these release versions =
of
> >> >> gfxstream and AEMU?
> >> >
> >> > Good catch.
> >> >
> >> > One possible workaround is to build gfxstream as a shared library.  =
I
> >> > think that would avoid rutabaga looking for AEMU package config file=
s.
> >> >
> >> > But if another rutabaga release is desired with support for a static
> >> > library, then we can make that happen too.
> >>
> >> We're exclusively building gfxstream as a shared library.
> >>
> >> Looking at rutabaga's build.rs, it appears to me like pkg-config is
> >> always used for gfxstream unless overridden by GFXSTREAM_PATH.
> >>
> >
> > Hmm, it seems we should be checking pkg-config --static before looking
> for
> > AEMU in build.rs -- oh well.
> >
> > Would this be a suitable commit for the 0.1.3 release of rutabaga?
> >
> >
> https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf441=
38def886f47cb1c7c
> >
> > The gfxstream/AEMU commits would remain unchanged.
>
> That combination works for me.
>

Just FYI, still working on it.  Could take 1-2 more weeks.

--0000000000008853ba0610353ada
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 26, 2024 at 6:23=E2=80=AF=
AM Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Gurchetan Si=
ngh &lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gu=
rchetansingh@chromium.org</a>&gt; writes:<br>
<br>
&gt; On Sat, Jan 20, 2024 at 4:19=E2=80=AFAM Alyssa Ross &lt;<a href=3D"mai=
lto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org"=
 target=3D"_blank">gurchetansingh@chromium.org</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross &lt;<a hr=
ef=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br=
>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Hi Gurchetan,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; Thanks for the reminder.=C2=A0 I did make a request =
to create the release<br>
&gt;&gt; &gt;&gt; &gt; tags, but changes were requested by Fedora packaging=
 effort:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?=
id=3D2242058" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.=
com/show_bug.cgi?id=3D2242058</a><br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?=
id=3D2241701" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.=
com/show_bug.cgi?id=3D2241701</a><br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; So the request was canceled, but never re-requested.=
=C2=A0 I&#39;ll fire off<br>
&gt;&gt; &gt;&gt; &gt; another request, with:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c =
(&quot;gfxstream:<br>
&gt;&gt; &gt;&gt; &gt; manually add debug logic&quot;)<br>
&gt;&gt; &gt;&gt; &gt; AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 (&quo=
t;aemu: improve<br>
&gt;&gt; licensing&quot;)<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; as the commits.=C2=A0 These match the Fedora request=
s, and the AEMU one has<br>
&gt;&gt; &gt;&gt; &gt; been merged into Fedora already it seems.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; These revisions have the problem I mentioned in my previo=
us message:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; The gfxstream ref mentioned here isn&#39;t compa=
tible with<br>
&gt;&gt; &gt;&gt; &gt;&gt; v0.1.2-rutabaga-release, because it no longer pr=
ovides<br>
&gt;&gt; logging_base.pc,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; rutabaga was not fixed to use the new AEMU package names =
until after the<br>
&gt;&gt; &gt;&gt; v0.1.2-rutabaga-release tag, in commit 5dfd74a06.=C2=A0 S=
o will there be a<br>
&gt;&gt; &gt;&gt; new Rutabaga release that&#39;s compatible with these rel=
ease versions of<br>
&gt;&gt; &gt;&gt; gfxstream and AEMU?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Good catch.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; One possible workaround is to build gfxstream as a shared lib=
rary.=C2=A0 I<br>
&gt;&gt; &gt; think that would avoid rutabaga looking for AEMU package conf=
ig files.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; But if another rutabaga release is desired with support for a=
 static<br>
&gt;&gt; &gt; library, then we can make that happen too.<br>
&gt;&gt;<br>
&gt;&gt; We&#39;re exclusively building gfxstream as a shared library.<br>
&gt;&gt;<br>
&gt;&gt; Looking at rutabaga&#39;s <a href=3D"http://build.rs" rel=3D"noref=
errer" target=3D"_blank">build.rs</a>, it appears to me like pkg-config is<=
br>
&gt;&gt; always used for gfxstream unless overridden by GFXSTREAM_PATH.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Hmm, it seems we should be checking pkg-config --static before looking=
 for<br>
&gt; AEMU in <a href=3D"http://build.rs" rel=3D"noreferrer" target=3D"_blan=
k">build.rs</a> -- oh well.<br>
&gt;<br>
&gt; Would this be a suitable commit for the 0.1.3 release of rutabaga?<br>
&gt;<br>
&gt; <a href=3D"https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a06=
80d317c6edf44138def886f47cb1c7c" rel=3D"noreferrer" target=3D"_blank">https=
://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf44138def88=
6f47cb1c7c</a><br>
&gt;<br>
&gt; The gfxstream/AEMU commits would remain unchanged.<br>
<br>
That combination works for me.<br></blockquote><div><br></div><div>Just FYI=
, still working on it.=C2=A0 Could take 1-2 more weeks.</div><div><br></div=
><div>=C2=A0</div></div></div>

--0000000000008853ba0610353ada--

