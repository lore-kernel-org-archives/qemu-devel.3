Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7663CD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 17:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slXNu-0000Xn-JQ; Tue, 03 Sep 2024 13:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1slXNn-0000Od-8z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1slXNk-00050U-7S
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725384713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f+w4MnDoVYjlG8+9zQeQW+vsMUe+1cKhV31JE9HHyX8=;
 b=EnS5eWvBkzX5AP63WitEYQO0P4DZPBvgWX9iSIfUpuab4vCTNzPPZTQFCZDkTbhDHPp+hO
 6U5mDgBuT4lG+4760vcF7fdnE6zyk3voiIncTeFdEBLlFg7IvYxMT+O6Kbbl/O5YeikWqE
 9wUYRIYB6r6Rw7qU00y35qGt5i5hwxo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-LZ8maU-JPcyRyQkkpmwWAQ-1; Tue, 03 Sep 2024 13:31:51 -0400
X-MC-Unique: LZ8maU-JPcyRyQkkpmwWAQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so4932364a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 10:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725384711; x=1725989511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+w4MnDoVYjlG8+9zQeQW+vsMUe+1cKhV31JE9HHyX8=;
 b=ZP4voXbXN926aSsjls1wGS2dKO4MYTSYyDYNdcSQGJnG3CnFtXWPR2QZglxlQs8pyA
 a4ZfXR5Ij29v7PuuaTDYEmXulo+ps1Q5BmBbYdmtnDNagz+Fuik2ijoDHKZpgImyQAih
 WC9Kuyky+iqEbQIG4xHFlApeiAElQ749krXOdZt/6YCq7xm2p4/l9ha4hBb3qPycl6LD
 K4awgQ6gYRRWjQJM7Obwq6rexBbbAk5Ii9N+BQdNec1kZDahrjRUNzg0Sd8xQay2Gb9L
 ujzQ0fIQFk5ja2RBokq171//VyYlZeTfFNTTLGCj6eyu4ao/eNCRkKPI2dRVz6A8yZEX
 Q4cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNU5HUxXb6A8FQePDccNuro0aWQpBI1VKQJNpB0Vh/3GiXGrGFiV9GE8GkorqSaOnBJVtey2mbqGQ2@nongnu.org
X-Gm-Message-State: AOJu0YwTxzro/SQdYUmP7PeLl91vjMvB5W+1padkwXrri1TOkDRQmBPp
 4hRFMAfXEOc4erCWwS4f1XopqB/atGVM2I3mhamsf5oesJmXsjonvkrfmvqoDFSnGSD552OldKm
 WCDHLHmEfy+W+8mNpqjhAiJnGoP3p6coioVQDwN6t0IUqWcnguyhFLL7rt5Won5ssXJC6FwCpAd
 UC9B8pc/Q8NKNeEq7uE6D4ZmmpqNc=
X-Received: by 2002:a17:902:f686:b0:205:7574:3b87 with SMTP id
 d9443c01a7336-20575743c5fmr68800555ad.15.1725384710691; 
 Tue, 03 Sep 2024 10:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8QRXNw/SqwZoSwo9v76FC2B2J5lClA2zvh41/seuKewQcqvzNZwmAOJFfL1Cb6nB+4v1HpSGTSmlTFndu2nQ=
X-Received: by 2002:a17:902:f686:b0:205:7574:3b87 with SMTP id
 d9443c01a7336-20575743c5fmr68800225ad.15.1725384710290; Tue, 03 Sep 2024
 10:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-8-jsnow@redhat.com>
 <87bk1acl4s.fsf@pond.sub.org>
 <CAFn=p-a=ob68-_8fkfFMj2AkVtOgL081j4d385n1qXMsN+ehFQ@mail.gmail.com>
 <ZtV8eQfPyuuwHHkq@redhat.com>
In-Reply-To: <ZtV8eQfPyuuwHHkq@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 3 Sep 2024 13:31:37 -0400
Message-ID: <CAFn=p-a9B6ax1LzV0-d6zGCgc9S9Ka0htw+op_gvE-Jx38L6mg@mail.gmail.com>
Subject: Re: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c2177f06213a6e99"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c2177f06213a6e99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024, 4:51=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:

> On Fri, Aug 30, 2024 at 02:22:50PM -0400, John Snow wrote:
> > Gave Dan a related answer. For you, my explanation is:
> >
> > - It's nice to have just one configuration for static analysis in just
> one
> > place
> > - It's nice to have that configuration follow python ecosystem norms
> > - It's nice to use standard python management tools to configure and te=
st
> > the supported versions of static analysis tools, again kept in one plac=
e.
> > - Just moving the folder costs virtually nothing.
> > - Moving it here makes it easier for me to test the eventual integratio=
n
> > with make check in one place.
> > - I like being able to say that anything under `python/` is fiercely
> > guarded by high standards (and the gitlab pipelines) and everything els=
e
> is
> > not. I consider this to be organizationally simple and easy to
> communicate.
> > i.e., I find it attractive to say that "python is maintained, scripts a=
re
> > YMMV." I am *not* willing to maintain everything under `scripts/` with
> the
> > same level of effort I apply to `python/`. I think it's important to
> allow
> > people to commit low-development-cost scripts ("contrib quality") that
> they
> > can run from time to time and not everything needs to be held to a
> > crystalline perfect standard, but some stuff does.
>
> FYI, I was NOT suggesting that you maintain anything under scripts/.
>
> Rather I'm saying that if we want to apply python code standards, we
> should (ultimately) apply them to all python code in the tree, and
> that *ALL* maintainers and contributors should comply.
>

Right, it's just that the level of care to bring everything up to that
standard is currently more effort than I'd like to spend.

Ideally everything WOULD be on the same standard, but...


> Consider our C standards - we don't apply them selectively to a subset
> of the tree - we expect all maintainers to comply. I'd like us to have
> the same be true of Python.
>
> The only real issue we have with python standards is bringing existing
> code upto par, before we can enable the checks.
>

Yeah, exactly. It took me long enough to do this with qmp, machine, qom and
qapi. It'll take aeons for iotests.

It's just not on my radar right now as a priority.

More tractable: protect everything used for the build to that high
standard, worry about the rest later.


> Currently we have no easy way for other maintainers to enable their
> python code be checked, without moving their code under python/ which
> is undesirable IMHO.
>

It's possible I can extend a "lower standard" to everything outside of
python/ to help enforce the basics, without mandatory typing.

(I did add an iotest checker to python/ tests that enforces a lower
standard to those tests. I intend to remove iotests 297 once I get a
top-level "make check-python" instituted.)

I don't think one unified standard is something we can do in the near term.
Mechanically I think it's easy, but in practice pushing all the linting
patches through has been like pulling teeth and I've lost appetite for
pursuing it beyond whatever is *super duper important*.

In retrospect, 3.6 was too early to try adding static typing. I think I
won't bother for anything else until we have 3.9 as a minimum. After the
pushback last time, I doubt I'll make the push any time soon unless
something really urgent comes up.


> If we move the python coding standards to meson.build, such that apply
> to all of the source tree, and then exclude everything except python/,
> we make it easier for other maintainers to bring stuff upto par. All
> need do at that point is remove the exclusion rule for files incrementall=
y
> as they fix them.
>

Not against this in the future, I just think there are some higher priority
items to take care of first:

* Begin protecting qapi with the existing python static analysis regime
* Add a "make check-python" target to the top level makefile that can set
up the environment it needs on-demand and handles what python/'s "make
check-minreqs" currently does (incl iotest 297)
* Drop python/qemu/qmp from the tree in favor of the standalone package.
There are mkvenv changes I'm currently developing here to make this happen.
It's a little involved due to the wide spread of setuptools versions on
platforms we support.

Once I drill through these, I'm more than happy to try to support/maintain
everything else to a lower baseline of care. Maybe this winter, if you'd be
willing to volunteer some review time for the push.


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

--000000000000c2177f06213a6e99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Mon, Sep 2, 2024, 4:51=E2=80=AFAM Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"nor=
eferrer">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On Fri, Aug 30, 2024 at 02:22:50PM -0400, John Snow wrote:<br>
&gt; Gave Dan a related answer. For you, my explanation is:<br>
&gt; <br>
&gt; - It&#39;s nice to have just one configuration for static analysis in =
just one<br>
&gt; place<br>
&gt; - It&#39;s nice to have that configuration follow python ecosystem nor=
ms<br>
&gt; - It&#39;s nice to use standard python management tools to configure a=
nd test<br>
&gt; the supported versions of static analysis tools, again kept in one pla=
ce.<br>
&gt; - Just moving the folder costs virtually nothing.<br>
&gt; - Moving it here makes it easier for me to test the eventual integrati=
on<br>
&gt; with make check in one place.<br>
&gt; - I like being able to say that anything under `python/` is fiercely<b=
r>
&gt; guarded by high standards (and the gitlab pipelines) and everything el=
se is<br>
&gt; not. I consider this to be organizationally simple and easy to communi=
cate.<br>
&gt; i.e., I find it attractive to say that &quot;python is maintained, scr=
ipts are<br>
&gt; YMMV.&quot; I am *not* willing to maintain everything under `scripts/`=
 with the<br>
&gt; same level of effort I apply to `python/`. I think it&#39;s important =
to allow<br>
&gt; people to commit low-development-cost scripts (&quot;contrib quality&q=
uot;) that they<br>
&gt; can run from time to time and not everything needs to be held to a<br>
&gt; crystalline perfect standard, but some stuff does.<br>
<br>
FYI, I was NOT suggesting that you maintain anything under scripts/.<br>
<br>
Rather I&#39;m saying that if we want to apply python code standards, we<br=
>
should (ultimately) apply them to all python code in the tree, and<br>
that *ALL* maintainers and contributors should comply.<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">Right, it&#39;s just =
that the level of care to bring everything up to that standard is currently=
 more effort than I&#39;d like to spend.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Ideally everything WOULD be on the same standard, but...=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
Consider our C standards - we don&#39;t apply them selectively to a subset<=
br>
of the tree - we expect all maintainers to comply. I&#39;d like us to have<=
br>
the same be true of Python.<br>
<br>
The only real issue we have with python standards is bringing existing<br>
code upto par, before we can enable the checks.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, exactly. It took me lo=
ng enough to do this with qmp, machine, qom and qapi. It&#39;ll take aeons =
for iotests.</div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s ju=
st not on my radar right now as a priority.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">More tractable: protect everything used for the build t=
o that high standard, worry about the rest later.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
Currently we have no easy way for other maintainers to enable their<br>
python code be checked, without moving their code under python/ which<br>
is undesirable IMHO.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">It&#39;s possible I can extend a &quot;lower standard&q=
uot; to everything outside of python/ to help enforce the basics, without m=
andatory typing.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(I did =
add an iotest checker to python/ tests that enforces a lower standard to th=
ose tests. I intend to remove iotests 297 once I get a top-level &quot;make=
 check-python&quot; instituted.)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I don&#39;t think one unified standard is something we can do in =
the near term. Mechanically I think it&#39;s easy, but in practice pushing =
all the linting patches through has been like pulling teeth and I&#39;ve lo=
st appetite for pursuing it beyond whatever is *super duper important*.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">In retrospect, 3.6 was too =
early to try adding static typing. I think I won&#39;t bother for anything =
else until we have 3.9 as a minimum. After the pushback last time, I doubt =
I&#39;ll make the push any time soon unless something really urgent comes u=
p.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
If we move the python coding standards to meson.build, such that apply<br>
to all of the source tree, and then exclude everything except python/,<br>
we make it easier for other maintainers to bring stuff upto par. All<br>
need do at that point is remove the exclusion rule for files incrementally<=
br>
as they fix them.<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Not against this in the future, I just think there are som=
e higher priority items to take care of first:</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">* Begin protecting qapi with the existing python sta=
tic analysis regime</div><div dir=3D"auto">* Add a &quot;make check-python&=
quot; target to the top level makefile that can set up the environment it n=
eeds on-demand and handles what python/&#39;s &quot;make check-minreqs&quot=
; currently does (incl iotest 297)</div><div dir=3D"auto">* Drop python/qem=
u/qmp from the tree in favor of the standalone package. There are mkvenv ch=
anges I&#39;m currently developing here to make this happen. It&#39;s a lit=
tle involved due to the wide spread of setuptools versions on platforms we =
support.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Once I drill th=
rough these, I&#39;m more than happy to try to support/maintain everything =
else to a lower baseline of care. Maybe this winter, if you&#39;d be willin=
g to volunteer some review time for the push.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
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

--000000000000c2177f06213a6e99--


