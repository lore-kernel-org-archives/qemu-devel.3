Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292BEC48260
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 00:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra3SZ-0007zy-Ii; Tue, 13 Feb 2024 19:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1ra3SY-0007zo-91
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 19:49:10 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1ra3ST-0001zs-M3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 19:49:10 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so3127387f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 16:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1707871742; x=1708476542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QR2rufZiyka4TIWIzW+P0yRZlowOdvJCY0TqeLfEhAs=;
 b=DSX0kwuEo2KvPbr8GABmnuDWE1MwMy4y3HCwi4nKqljriBZlw7ZiThpHOnEc3mWIQa
 9Ov/Ywu+Gh2wbPhJ7U2xJkyC/C6SmXCLCYdIKGc94V+/vnvCQMEY3ZbNo3bRQ+hsbK5S
 5+q/h47Q079S11zZCTJlt0hCDDKkCLbQ9bPcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707871742; x=1708476542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QR2rufZiyka4TIWIzW+P0yRZlowOdvJCY0TqeLfEhAs=;
 b=tNBwUD8MW1d0ouX3u4DDFPToFuxCagcOXsFdeg3uzX8Hzk2mXINZtNWAuD/w4rT2eU
 kKVRiI71KLcU6Ev1o6G8fNhiHH7uETXFclrY2t3ClQRXlJSfZYxJqA9epxs3T5Ku2k74
 OerNf9VccmW26H0hsjLzwjU6ghjYdM61PfsVTAZ6rBYIHPe8bKWvsZBFlugTYvNeeb8K
 q2NwZK6sUBs2u7i8+YV3WTEY8cx89C7XRVkVAsZwQtn+cAS76GmCsbFCbLJeAUvVJLrD
 XMKIQoX8FDK/OR/YA3o57kd/q7CPENgbL2LaS/ygHE3b6uDurlCuyr+zGG2qbYLklJB3
 mTQA==
X-Gm-Message-State: AOJu0YwaeMerMQbVbFPPtEzT94pM+lEWXAVHZ5qhn0YFhAiTk6qahl5P
 5UQfzy4AtWs8z5cjOQ+0NafREjvoCAyz/EHcq+bJQgs6y3ixE1df9v7p06vLzRFzGfPkA5z+as2
 LnQ==
X-Google-Smtp-Source: AGHT+IFivVeCTMVPeSha123SwK5kLhSNl4/5yYTNP6FMRShOMAMtrFqdt4hhqLNZw9sr7grDiKqmyg==
X-Received: by 2002:a5d:51c7:0:b0:33b:7d9b:4592 with SMTP id
 n7-20020a5d51c7000000b0033b7d9b4592mr632660wrv.5.1707871742486; 
 Tue, 13 Feb 2024 16:49:02 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 k23-20020a05640212d700b005612987a525sm4114942edx.89.2024.02.13.16.49.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 16:49:01 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-560530f4e21so18574a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 16:49:01 -0800 (PST)
X-Received: by 2002:aa7:c997:0:b0:563:1103:a75f with SMTP id
 c23-20020aa7c997000000b005631103a75fmr14782edt.0.1707871741333; Tue, 13 Feb
 2024 16:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
 <87cytwnqoj.fsf@alyssa.is>
 <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
 <87msssmax4.fsf@alyssa.is>
 <CAAfnVBm--wu3=ES0tY2JPXwm+Ga-tRLq=EpkZdzdVoHGUfb2KQ@mail.gmail.com>
In-Reply-To: <CAAfnVBm--wu3=ES0tY2JPXwm+Ga-tRLq=EpkZdzdVoHGUfb2KQ@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 13 Feb 2024 16:48:48 -0800
X-Gmail-Original-Message-ID: <CAAfnVBkk1QTAo4dT372QNFmWqFFG4TxM0OTv9XHQQf6fm11fag@mail.gmail.com>
Message-ID: <CAAfnVBkk1QTAo4dT372QNFmWqFFG4TxM0OTv9XHQQf6fm11fag@mail.gmail.com>
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Content-Type: multipart/alternative; boundary="00000000000077348506114ce0b4"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

--00000000000077348506114ce0b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:10=E2=80=AFPM Gurchetan Singh <gurchetansingh@chr=
omium.org>
wrote:

>
>
> On Fri, Jan 26, 2024 at 6:23=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>
>> > On Sat, Jan 20, 2024 at 4:19=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wro=
te:
>> >
>> >> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>> >>
>> >> > On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross <hi@alyssa.is> =
wrote:
>> >> >>
>> >> >> Hi Gurchetan,
>> >> >>
>> >> >> > Thanks for the reminder.  I did make a request to create the
>> release
>> >> >> > tags, but changes were requested by Fedora packaging effort:
>> >> >> >
>> >> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2242058
>> >> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2241701
>> >> >> >
>> >> >> > So the request was canceled, but never re-requested.  I'll fire
>> off
>> >> >> > another request, with:
>> >> >> >
>> >> >> > gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
>> >> >> > manually add debug logic")
>> >> >> > AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve
>> >> licensing")
>> >> >> >
>> >> >> > as the commits.  These match the Fedora requests, and the AEMU
>> one has
>> >> >> > been merged into Fedora already it seems.
>> >> >>
>> >> >> These revisions have the problem I mentioned in my previous messag=
e:
>> >> >>
>> >> >> >> The gfxstream ref mentioned here isn't compatible with
>> >> >> >> v0.1.2-rutabaga-release, because it no longer provides
>> >> logging_base.pc,
>> >> >>
>> >> >> rutabaga was not fixed to use the new AEMU package names until
>> after the
>> >> >> v0.1.2-rutabaga-release tag, in commit 5dfd74a06.  So will there b=
e
>> a
>> >> >> new Rutabaga release that's compatible with these release versions
>> of
>> >> >> gfxstream and AEMU?
>> >> >
>> >> > Good catch.
>> >> >
>> >> > One possible workaround is to build gfxstream as a shared library. =
 I
>> >> > think that would avoid rutabaga looking for AEMU package config
>> files.
>> >> >
>> >> > But if another rutabaga release is desired with support for a stati=
c
>> >> > library, then we can make that happen too.
>> >>
>> >> We're exclusively building gfxstream as a shared library.
>> >>
>> >> Looking at rutabaga's build.rs, it appears to me like pkg-config is
>> >> always used for gfxstream unless overridden by GFXSTREAM_PATH.
>> >>
>> >
>> > Hmm, it seems we should be checking pkg-config --static before looking
>> for
>> > AEMU in build.rs -- oh well.
>> >
>> > Would this be a suitable commit for the 0.1.3 release of rutabaga?
>> >
>> >
>> https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf44=
138def886f47cb1c7c
>> >
>> > The gfxstream/AEMU commits would remain unchanged.
>>
>> That combination works for me.
>>
>
> Just FYI, still working on it.  Could take 1-2 more weeks.
>

FYI:

https://android.googlesource.com/platform/hardware/google/gfxstream/+/refs/=
tags/v0.1.2-gfxstream-release

https://android.googlesource.com/platform/hardware/google/aemu/+/refs/tags/=
v0.1.2-aemu-release

https://chromium.googlesource.com/crosvm/crosvm/+/refs/tags/v0.1.3-rutabaga=
-release


>
>
>

--00000000000077348506114ce0b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 30, 2024 at 7:10=E2=80=AF=
PM Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org">gurch=
etansingh@chromium.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 26,=
 2024 at 6:23=E2=80=AFAM Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is" ta=
rget=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Gurchetan Singh &lt;<a href=3D"mailto:gurchetan=
singh@chromium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt; w=
rites:<br>
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
, still working on it.=C2=A0 Could take 1-2 more weeks.</div></div></div></=
blockquote><div><br></div><div>FYI:</div><div><br></div><div><a href=3D"htt=
ps://android.googlesource.com/platform/hardware/google/gfxstream/+/refs/tag=
s/v0.1.2-gfxstream-release">https://android.googlesource.com/platform/hardw=
are/google/gfxstream/+/refs/tags/v0.1.2-gfxstream-release</a><br><div><br><=
/div><div><a href=3D"https://android.googlesource.com/platform/hardware/goo=
gle/aemu/+/refs/tags/v0.1.2-aemu-release">https://android.googlesource.com/=
platform/hardware/google/aemu/+/refs/tags/v0.1.2-aemu-release</a><br></div>=
<div><br></div><div><a href=3D"https://chromium.googlesource.com/crosvm/cro=
svm/+/refs/tags/v0.1.3-rutabaga-release">https://chromium.googlesource.com/=
crosvm/crosvm/+/refs/tags/v0.1.3-rutabaga-release</a></div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div><br></div><div>=C2=A0</div></div></div>
</blockquote></div></div>

--00000000000077348506114ce0b4--

